#ifdef GL_ES
precision mediump float;
#endif

varying highp vec3 vColor;

const float PI = 3.14159265359;

void main(){
    gl_FragColor = vec4( 1.0 / PI * vColor, 1.0);
}