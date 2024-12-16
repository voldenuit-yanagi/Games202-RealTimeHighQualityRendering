#include "denoiser.h"

Denoiser::Denoiser() : m_useTemportal(false) {}

void Denoiser::Reprojection(const FrameInfo &frameInfo) {
    int height = m_accColor.m_height;
    int width = m_accColor.m_width;
    Matrix4x4 preWorldToScreen =
        m_preFrameInfo.m_matrix[m_preFrameInfo.m_matrix.size() - 1];
    Matrix4x4 preWorldToCamera =
        m_preFrameInfo.m_matrix[m_preFrameInfo.m_matrix.size() - 2];
#pragma omp parallel for
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // TODO: Reproject
            m_valid(x, y) = false;
            m_misc(x, y) = Float3(0.f);
            int id = frameInfo.m_id(x,y);
            if (id == -1) {
                continue;
            }
            
            Float3 worldPositionInCurrentFrame = frameInfo.m_position(x, y);
            Matrix4x4 currentWorldToLocal = Inverse(frameInfo.m_matrix[id]);
            Matrix4x4 preLocalToWorld = m_preFrameInfo.m_matrix[id];
            auto screenPositionInPreFrame = preWorldToScreen(
                preLocalToWorld(currentWorldToLocal(worldPositionInCurrentFrame, Float3::EType::Point),
                                Float3::EType::Point),
                Float3::EType::Point);
            int pre_x = screenPositionInPreFrame.x;
            int pre_y = screenPositionInPreFrame.y;
            if (pre_x >= 0 && pre_x < width && pre_y >= 0 && pre_y < height) {
                if (m_preFrameInfo.m_id(pre_x, pre_y) == id) {
                    m_valid(x, y) = true;
                    m_misc(x, y) = m_accColor(pre_x, pre_y);
                }
            }
        }
    }
    std::swap(m_misc, m_accColor);
}

void Denoiser::TemporalAccumulation(const Buffer2D<Float3> &curFilteredColor) {
    int height = m_accColor.m_height;
    int width = m_accColor.m_width;
    int kernelRadius = 3;
#pragma omp parallel for
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // TODO: Temporal clamp
            Float3 sum(0.0f);
            for (int i=std::max(0, x-3); i<=std::min(x+3, width-1); i++) {
                for (int j=std::max(0, y-3); j<=std::min(y+3, height-1); j++) {
                    sum += curFilteredColor(i, j);
                }
            }
            Float3 mu = sum / 49.0f;
            Float3 sigma2(0.0f);
            for (int i=std::max(0, x-kernelRadius); i<=std::min(x+kernelRadius, width-1); i++) {
                for (int j=std::max(0, y-kernelRadius); j<=std::min(y+kernelRadius, height-1); j++) {
                    Float3 diff = curFilteredColor(i, j) - mu;
                    sigma2 += Float3(diff.x*diff.x, diff.y*diff.y, diff.z*diff.z);
                }
            }
            sigma2 /= 49.0f;
            Float3 sigma(Sqr(sigma2.x), Sqr(sigma2.y), Sqr(sigma2.z));
            Float3 color = m_accColor(x, y);
            Clamp(color, mu-sigma*m_colorBoxK, mu+sigma*m_colorBoxK);
            // TODO: Exponential moving average
            float alpha = m_alpha;
            if (m_valid(x, y) == false) {
                alpha = 1.0f;
            }
            m_misc(x, y) = Lerp(color, curFilteredColor(x, y), alpha);
        }
    }
    std::swap(m_misc, m_accColor);
}

Buffer2D<Float3> Denoiser::Filter(const FrameInfo &frameInfo) {
    int height = frameInfo.m_beauty.m_height;
    int width = frameInfo.m_beauty.m_width;
    Buffer2D<Float3> filteredImage = CreateBuffer2D<Float3>(width, height);
    int kernelRadius = 16;
#pragma omp parallel for
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // TODO: Joint bilateral filter
            Float3 centerPosition = frameInfo.m_position(x, y);
            Float3 centerColor = frameInfo.m_beauty(x, y);
            Float3 centerNormal = frameInfo.m_normal(x, y);
            float centerDepth = frameInfo.m_depth(x, y);
            Float3 sum_of_weighted_values(0);
            float sum_of_weights = 0;
            for (int i=std::max(0, x-kernelRadius); i<std::min(width-1, x-kernelRadius); i++) {
                for (int j=std::max(0, y-kernelRadius); j<std::min(height-1, y-kernelRadius); j++) {
                    if (i==x && j==y) {
                        sum_of_weights += 1;
                        sum_of_weighted_values += centerColor;
                    }
                    else {
                        Float3 samplePosition = frameInfo.m_position(i, j);
                        Float3 sampleColor = frameInfo.m_beauty(i, j);
                        Float3 sampleNormal = frameInfo.m_normal(i, j);
                        float sampleDepth = frameInfo.m_depth(i, j);
                        
                        float position_dis = SqrDistance(centerPosition, samplePosition) / (2.0f * m_sigmaCoord);
                        float color_dis = SqrDistance(centerColor, sampleColor) / (2.0f * m_sigmaColor);
                        float normal_dis = SafeAcos(Dot(centerNormal, sampleNormal)) / (2.0f * m_sigmaNormal);
                        float Dplane = Dot(centerNormal, Normalize(samplePosition-centerPosition));
                        float plane_dis = Dplane * Dplane / (2.0f * m_sigmaPlane);
                        float weight = exp(- position_dis - color_dis - normal_dis - plane_dis);

                        sum_of_weights += weight;
                        sum_of_weighted_values += sampleColor * weight;
                    }
                }
            }
            filteredImage(x, y) = sum_of_weighted_values / sum_of_weights;
        }
    }
    return filteredImage;
}

void Denoiser::Init(const FrameInfo &frameInfo, const Buffer2D<Float3> &filteredColor) {
    m_accColor.Copy(filteredColor);
    int height = m_accColor.m_height;
    int width = m_accColor.m_width;
    m_misc = CreateBuffer2D<Float3>(width, height);
    m_valid = CreateBuffer2D<bool>(width, height);
}

void Denoiser::Maintain(const FrameInfo &frameInfo) { m_preFrameInfo = frameInfo; }

Buffer2D<Float3> Denoiser::ProcessFrame(const FrameInfo &frameInfo) {
    // Filter current frame
    Buffer2D<Float3> filteredColor;
    filteredColor = Filter(frameInfo);

    // Reproject previous frame color to current
    if (m_useTemportal) {
        Reprojection(frameInfo);
        TemporalAccumulation(filteredColor);
    } else {
        Init(frameInfo, filteredColor);
    }

    // Maintain
    Maintain(frameInfo);
    if (!m_useTemportal) {
        m_useTemportal = true;
    }
    return m_accColor;
}
