# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.24.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.24.2/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/liushijia/Desktop/Games202/homework4/lut-gen

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/liushijia/Desktop/Games202/homework4/lut-gen/build

# Include any dependencies generated for this target.
include CMakeFiles/lut-Eavg-IS.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/lut-Eavg-IS.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/lut-Eavg-IS.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/lut-Eavg-IS.dir/flags.make

CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o: CMakeFiles/lut-Eavg-IS.dir/flags.make
CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o: /Users/liushijia/Desktop/Games202/homework4/lut-gen/Eavg_IS.cpp
CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o: CMakeFiles/lut-Eavg-IS.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/liushijia/Desktop/Games202/homework4/lut-gen/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o"
	/usr/local/opt/llvm/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o -MF CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o.d -o CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o -c /Users/liushijia/Desktop/Games202/homework4/lut-gen/Eavg_IS.cpp

CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.i"
	/usr/local/opt/llvm/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/liushijia/Desktop/Games202/homework4/lut-gen/Eavg_IS.cpp > CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.i

CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.s"
	/usr/local/opt/llvm/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/liushijia/Desktop/Games202/homework4/lut-gen/Eavg_IS.cpp -o CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.s

# Object files for target lut-Eavg-IS
lut__Eavg__IS_OBJECTS = \
"CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o"

# External object files for target lut-Eavg-IS
lut__Eavg__IS_EXTERNAL_OBJECTS =

lut-Eavg-IS: CMakeFiles/lut-Eavg-IS.dir/Eavg_IS.cpp.o
lut-Eavg-IS: CMakeFiles/lut-Eavg-IS.dir/build.make
lut-Eavg-IS: CMakeFiles/lut-Eavg-IS.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/liushijia/Desktop/Games202/homework4/lut-gen/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable lut-Eavg-IS"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lut-Eavg-IS.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/lut-Eavg-IS.dir/build: lut-Eavg-IS
.PHONY : CMakeFiles/lut-Eavg-IS.dir/build

CMakeFiles/lut-Eavg-IS.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/lut-Eavg-IS.dir/cmake_clean.cmake
.PHONY : CMakeFiles/lut-Eavg-IS.dir/clean

CMakeFiles/lut-Eavg-IS.dir/depend:
	cd /Users/liushijia/Desktop/Games202/homework4/lut-gen/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/liushijia/Desktop/Games202/homework4/lut-gen /Users/liushijia/Desktop/Games202/homework4/lut-gen /Users/liushijia/Desktop/Games202/homework4/lut-gen/build /Users/liushijia/Desktop/Games202/homework4/lut-gen/build /Users/liushijia/Desktop/Games202/homework4/lut-gen/build/CMakeFiles/lut-Eavg-IS.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/lut-Eavg-IS.dir/depend

