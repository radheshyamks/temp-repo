cmake_minimum_required(VERSION 3.12)
project(PROJECTNAME VERSION 1.1)
#configurefile.hh.in is input file we will write it and cmake will generate configurefilename.hh file
configure_file(configurefile.hh.in configurefilename.hh)
#to create your own variable
set(VARIABLE_NAME "VALUE")
set(target "PROJECTNAME")
set(SOURCE_FILE main.cpp
	)
message("write your message to print on console")
#for the angular bracket
include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_BINARY_DIR})
add_library(${LINKABLE_NAME} filename.cpp)
add_executable(${target} ${SOURCE_FILE})
target_link_libraries(${target} ${LINKABLE_NAME})

##################################################################################################
#How to use CMake to configure your projects with deal.II
#
#cmake is controlled by input files that by convention are called CMakeLists.txt, listing both configuration commands as well as dependencies between source files and targets. This page presents some CMakeLists.txt examples for potential use in your projects. (A detailed description of the deal.II project configuration is given in the deal.II CMake ReadMe.)
#
#    Simple CMakeLists.txt
#        Adding multiple executable targets
#        Adding libraries and common source files
#        Switching build types
#        Adding a "run" target
#    Advanced CMakeLists.txt
#        Source directory layout
#        Control statements
#        File globs
#        DEAL_II_SETUP_TARGET revisited
#        DEAL_II_INITIALIZE_CACHED_VARIABLES revisited
#        Customizing include directories and compile definitions
#        External libraries
#        The "run" target revisited
#        Install a project
#    Autopilot style CMakeLists.txt
#    deal.IIConfig.cmake
#
#Simple CMakeLists.txt
#
#In this section, we start out with a minimal CMakeLists.txt based on the DEAL_II_SETUP_TARGET macro. This method gives full control of what's happening and is easily extensible to more complex projects, as exemplified in the subsections here and later in the section on advanced topics. Here is a full example (plain text version):
#
#CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12)
#
#FIND_PACKAGE(deal.II 9.1.0 REQUIRED
#  HINTS ${DEAL_II_DIR} ../ ../../ $ENV{DEAL_II_DIR}
#  )
#DEAL_II_INITIALIZE_CACHED_VARIABLES()
#
#PROJECT(myproject)
#
#ADD_EXECUTABLE(mycode mycode.cc)
#DEAL_II_SETUP_TARGET(mycode)
#
#The first line of this code makes sure that a sufficiently high version of CMake is installed. 2.8.8 is the minimal version required to set up deal.II, therefore it is safe to use this number here.
#
#Next, we find our deal.II installation with the help of the FIND_PACKAGE command. In this case requiring at least version 9.0.0. The HINTS are a list of directories where the install directory of deal.II is likely to be found. First, the location possibly defined in the CMake variable DEAL_II_DIR is considered. After that, we check whether we are in a subdirectory (first and second level) of the deal.II installation and otherwise use the environment variable DEAL_II_DIR. If all of these hints fail the default system locations /usr/ and /usr/local/ are considered. The list after HINTS can be changed according to your preferences.
#
#After finding the deal.II project, we fetch a set of cached variables with the DEAL_II_INITIALIZE_CACHED_VARIABLES macro. You can inspect these for instance with ccmake.
#
#Every CMakeLists.txt must contain a project definition, which we do next.
#
#Finally, the last two lines define the executable that is to be produced and its source code. The DEAL_II_SETUP_TARGET macro will set up necessary include directories, compile flags, compile definitions, link flags and the link interface.
#Adding multiple executable targets
#
#In order to specify multiple executable targets, simply repeat the last two lines of the simple CMakeLists.txt:
#
#ADD_EXECUTABLE(mycode2 mycode2.cc)
#DEAL_II_SETUP_TARGET(mycode2)
#
#ADD_EXECUTABLE(mycode3 mycode3.cc)
#DEAL_II_SETUP_TARGET(mycode3)
#
#If the list gets longer, consider using a loop, possibly with GLOB.
#Adding libraries and common source files
#
#Adding a library is as simple as adding an executable target. We specify the library name and then have to tell cmake that the executables depend on it. The code in the simple file below the project definition accordingly changes for instance to:
#
#ADD_LIBRARY(mylib libsrc1.cc libsrc2.cc libsrc3.cc)
#DEAL_II_SETUP_TARGET(mylib)
#
#ADD_EXECUTABLE(mycode mycode.cc)
#DEAL_II_SETUP_TARGET(mycode)
#TARGET_LINK_LIBRARIES(mycode mylib)
#
#When you have multiple targets, repeat the last line of code for each of them. Accordingly, a loop becomes even more attractive.
#
#If you only have a single file or few files with common source code, an alternative to creating a library might be the option:
#
#ADD_EXECUTABLE(mycode mycode.cc common.cc)
#DEAL_II_SETUP_TARGET(mycode)
#
#ADD_EXECUTABLE(mycode2 mycode2.cc common.cc)
#DEAL_II_SETUP_TARGET(mycode2)
#
#You should be aware though that in this case common.cc will be compiled for each target, not only once. If you want to avoid this and still don't want to use a shared library or static archive, another option is to create an OBJECT "library":
#
#ADD_LIBRARY(common OBJECT common.cc)
#DEAL_II_SETUP_TARGET(common)
#
#ADD_EXECUTABLE(mycode mycode.cc $<TARGET_OBJECTS:common>)
#DEAL_II_SETUP_TARGET(mycode)
#
#ADD_EXECUTABLE(mycode2 mycode2.cc $<TARGET_OBJECTS:common>)
#DEAL_II_SETUP_TARGET(mycode2)
#
#This will compile common.cc once for the object target common and link the resulting object file into the two executables.
#Switching build types
#
#The build type is controlled via the variable CMAKE_BUILD_TYPE. If it is set to Debug executables and libraries specified in your CMakeLists.txt file will be compiled in debug mode and linked against the debug version of the deal.II library. Contrary, Release will build in optimized mode and link against the optimized release version of deal.II. You can set CMAKE_BUILD_TYPE with the help of ccmake or via cmake on the command line:
#
#$ cmake -DCMAKE_BUILD_TYPE="Debug" .
#
#$ cmake -DCMAKE_BUILD_TYPE="Release" .
#
#Alternatively, you can specify custom targets to switch the build type and compile automatically:
#
#ADD_CUSTOM_TARGET(debug
#  COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Debug ${CMAKE_SOURCE_DIR}
#  COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all
#  COMMENT "Switch CMAKE_BUILD_TYPE to Debug"
#  )
#
#ADD_CUSTOM_TARGET(release
#  COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Release ${CMAKE_SOURCE_DIR}
#  COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all
#  COMMENT "Switch CMAKE_BUILD_TYPE to Release"
#  )
#
#With that, switching the build type and compiling the project can be done very conveniently via:
#
#$ make debug
#
#$ make release
#
#Adding a "run" target
#
#If you wish to have a "run" target for make, like in the deal.II tutorial, specify one this way (obviously, a single "run" target can only run a single executable):
#
#ADD_CUSTOM_TARGET(run COMMAND mycode
#  COMMENT "Run with ${CMAKE_BUILD_TYPE} configuration"
#  )
#
#Advanced CMakeLists.txt
#
#This section covers some advanced topics for a user CMakeLists.txt file.
#Source directory layout
#
#For complex projects it is desirable to organize source code and header files in subdirectories. Assume the following project structure with a library "mylib" and an executable "mycode":
#
#mylib/source/*.cc
#mylib/include/*.h
#
#mycode/source/*.cc
#mycode/include/*.h
#
#In this case the top level CMakeLists.txt file may be:
#
## top level CMakeLists.txt
#CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12)
#FIND_PACKAGE(deal.II 9.1.0 REQUIRED)
#
#DEAL_II_INITIALIZE_CACHED_VARIABLES()
#PROJECT(myproject)
#
#ADD_SUBDIRECTORY(mylib)
#ADD_SUBDIRECTORY(mycode)
#
#The ADD_SUBDIRECTORY statement will include the CMakeLists.txt file in the specified subdirectory. In our case:
#
## mylib/CMakeLists.txt
#
#INCLUDE_DIRECTORIES(include)
#
#ADD_LIBRARY(mylib
#  source/mylib1.cc
#  source/mylib2.cc
#  )
#
#DEAL_II_SETUP_TARGET(mylib)
#
#We have to add the directory include for the header files to the current include directories with the INCLUDE_DIRECTORIES statement (see this section for details). The corresponding configuration file for the executable looks like:
#
## mycode/CMakeLists.txt
#
#INCLUDE_DIRECTORIES(
#  include
#  ${CMAKE_SOURCE_DIR}/mylib/include
#  )
#
#ADD_EXECUTABLE(mycode source/mycode.cc)
#DEAL_II_SETUP_TARGET(mycode)
#
#TARGET_LINK_LIBRARIES(mycode mylib)
#
#Please note that CMakeLists.txt files have directory scope. Any manipulation of properties and variables have only effect in the current directory (and subdirectories, included with ADD_SUBDIRECTORY. The level above will not be affected. Therefore, we have to specify the include directories for "mylib" again in the subdirectory mycode - this time with full path ${CMAKE_SOURCE_DIR}/mylib/include.
#
#CMake defines the following variables for access to important directories:
#
#CMAKE_SOURCE_DIR
#  - the source directory (i.e. the directory of the top level
#    CMakeLists.txt file)
#
#CMAKE_BINARY_DIR
#  - the (top level) build directory
#
#CMAKE_CURRENT_SOURCE_DIR
#  - the current source directory, i.e. location of the currently processed
#    CMakeLists.txt file (top level or included via ADD_SUBDIRECTORY)
#
#CMAKE_CURRENT_BINARY_DIR
#  - the build (sub)directory corresponding to CMAKE_CURRENT_SOURCE_DIR
#
#Control statements
#
#Control statements in CMake take the following form:
#
#IF(<expression>)
#  ...
#ENDIF()
#
#or in long form:
#
#IF(<expression1>)
#  ...
#ELSEIF(<expression2>)
#  ...
#ELSE()
#  ...
#ENDIF()
#
#Please note the (somehow uncommon) empty, opening and closing brackets behind ELSE() and ENDIF(). <expression> can take a multitude of different forms, have a look at the CMake documentation for a complete list. Important examples are:
#
#IF(${variable})
#  - the body will be evaluated if the variable "variable" is defined and
#    synonymous to true, e.g. 1, TRUE, ON, YES (modulo case insensitivity)
#
#IF(variable MATCHES <regular expression>)
#  - the body will be evaluated if the variable "variable" is defined and
#    matches the specified regular expression
#
#IF("${variable}" STREQUAL "foobar")
#  - the body will be evaluated if both strings are equal. Note that
#    "${variable}" will be replaced by the content of the (string)
#    variable "variable"
#
#An expression can be negated by prefixing NOT:
#
#IF(NOT <expression>)
#  ...
#ENDIF()
#
#Loops are implemented with the help of WHILE and FOR statements. The former takes the same <expression> as the IF statement:
#
#WHILE(<expression>)
#  ...
#ENDWHILE()
#
#Given a variable list containing a list, the individual elements element can be accessed with a FOREACH statement:
#
#FOREACH(element ${list})
#  ...
#ENDFOREACH()
#
#Note: It is also possible to specify the list directly:
#
#FOREACH(element foo bar baz)
#  # The variable element will iterate through foo, bar and baz.
#ENDFOREACH
#
#File globs
#
#A very common task is to pick up a list of source files from a directory. You can either manage a list of source files in CMakeLists.txt by hand, e.g. by manually updating all source files for a given target, or you can use a glob to automate this process. The following example will pick up every source file under SOURCE_DIR/sources/ and add it to an executable:
#
#FILE(GLOB sources ${CMAKE_SOURCE_DIR}/source/*.cc)
#ADD_EXECUTABLE(mycode ${sources})
#
#Please be aware of one caveat of this approach: Due to the fact that CMake is a build system generator the resulting build configuration (for make) has no way to detect whether a new source file was added (or removed) and that it has to call back to cmake. So, after adding a new source file you have to touch a CMakeLists.txt file or to run cmake . again by hand.
#DEAL_II_SETUP_TARGET revisited
#
#The DEAL_II_SETUP_TARGET macro is responsible for setting up a target to compile and link against deal.II. It will append the INCLUDE_DIRECTORIES property with the location of the deal.II include directories, and append the properties COMPILE_FLAGS, COMPILE_DEFINITIONS and LINK_FLAGS by their respective values from the deal.II configuration (depending on build type and available debug and/or optimized flavor of the library).
#
#Except in the case of an object library, the specified target will also be set up to link against deal.II (and its transitive link interface) as well.
#
#Optionally, the DEAL_II_SETUP_TARGET macro takes an additional argument DEBUG, or RELEASE, after the target name to explicitly state the library flavor the target should be set up for. If the parameter is omitted, the correct choice is deduced from the current build type. (This is supported for the build types Debug, and Release. In case of DebugRelease the additional argument is always required.)
#
#Note: The flags that are added with DEAL_II_SETUP_TARGET to the target come last in the final link compiler invocation, or linker invocation. This means they take precedence over all flags defined via globally via CMAKE_CXX_FLAGS, etc., or as a directory property. If you wish to modify flags or preprocessor definitions set up with DEAL_II_SETUP_TARGET modify on of the following variables (see the section about deal.IIConfig.cmake for details):
#
#DEAL_II_CXX_FLAGS
#DEAL_II_CXX_FLAGS_DEBUG
#DEAL_II_CXX_FLAGS_RELEASE
#DEAL_II_LINKER_FLAGS
#DEAL_II_LINKER_FLAGS_DEBUG
#DEAL_II_LINKER_FLAGS_RELEASE
#DEAL_II_USER_DEFINITIONS
#DEAL_II_USER_DEFINITIONS_DEBUG
#DEAL_II_USER_DEFINITIONS_RELEASE
#
#DEAL_II_INITIALIZE_CACHED_VARIABLES revisited
#
#The DEAL_II_INITIALIZE_CACHED_VARIABLES macro is responsible for setting up cached variables and has to invoked before the PROJECT call:
#
#FIND_PACKAGE(deal.II 9.1.0 REQUIRED)
#
#DEAL_II_INITIALIZE_CACHED_VARIABLES()
#
#PROJECT(myproject)
#
#The macro will set an uninitialized CMAKE_BUILD_TYPE variable to the the build type of deal.II, i.e. DEAL_II_BUILD_TYPE. If CMAKE_BUILD_TYPE is specified it will automatically be reset if the given value is unsupported by the deal.II installation (i.e., if it is not equal to Debug, Release, or DebugRelease).
#
#Furthermore, this macro sets the C++ compiler to the one used for compiling the deal.II library. The variables will CMAKE_CXX_FLAGS, CMAKE_CXX_FLAGS_DEBUG, and CMAKE_CXX_FLAGS_RELEASE will be initialized with the empty string.
#
#Note: If you wish to override the flags and definitions set by the DEAL_II_SETUP_TARGET macro you have to override the corresponding DEAL_II_* variable instead. See the documentation of DEAL_II_SETUP_TARGET for further details.
#Customizing include directories and compile definitions
#
#You can specify custom include directories and compile definitions prior to a target definition on a per directory basis (have a look at the CMake documentation for further details):
#
#INCLUDE_DIRECTORIES(include1 include2)
#
#ADD_DEFINITIONS(-DFOO -DBAR="BAZ")
#
#ADD_EXECUTABLE(...) # or ADD_LIBRARY(...)
#
#External libraries
#
#For external libraries that provide a CMake project configuration or where a CMake find module is available, including this external library in your project is more or less straightforward. E.g. to require an external project "foo" at least of version 8.0 write:
#
#FIND_PACKAGE(foo 8.0 REQUIRED)
#
#Alternatively, the version number and REQUIRED keyword can be omitted. (Depending on the external library) the project configuration or find macro will usually define variables like FOO_INCLUDE_DIRS and FOO_LIBRARIES that can be directly used in your CMakeLists.txt file:
#
#INCLUDE_DIRECTORIES(${FOO_INCLUDE_DIRS})
#
#ADD_EXECUTABLE(mycode mycode.cc)
#DEAL_II_SETUP_TARGET(mycode)
#
#TARGET_LINK_LIBRARIES(mycode ${FOO_LIBRARIES})
#
#The first statement will set up the include directories for the following targets as explained above. The last statement with TARGET_LINK_LIBRARIES will add the libraries in the FOO_LIBRARIES variable to the link interface of the target mycode.
#
#The "run" target revisited
#
#The simple run statement as explained above will run the generated executable in the build directory. Sometimes it is more desirable to run the executable in a dedicated run directory within in the build directory which is a copy of a skeleton run folder from the source directory:
#
## Copy folder run from the source to the build directory:
#FILE(COPY ${CMAKE_SOURCE_DIR}/run DESTINATION ${CMAKE_BINARY_DIR})
#
#ADD_EXECUTABLE(mycode mycode.cc)
#SET_PROPERTY(TARGET mycode
#  PROPERTY RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/run
#  )
#ADD_CUSTOM_TARGET(run
#  COMMAND mycode
#  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/run
#  )
#
#Here, we modify the RUNTIME_OUTPUT_DIRECTORY property of our target so that the executable is linked inside our designated run folder, so that it is conveniently available as an executable inside the run folder. Furthermore, we specify a WORKING_DIRECTORY for the run target, so that make run invokes the executable inside the intended run directory.
#
#Install a project
#
#If you want the make install to install your project to CMAKE_INSTALL_PREFIX (that may be set on command line or in the cache during the configuration stage), add appropriate INSTALL statements. To install e.g. a project consisting of a library and an executable as well as a run folder:
#
## [...] all the target definitions
#
#INSTALL(TARGETS mylib DESTINATION lib)
#INSTALL(TARGETS mycode DESTINATION bin)
#
#INSTALL(DIRECTORY run DESTINATION share/mycode/run)
#
#Autopilot style CMakeLists.txt
#
#If you want a make interface similar to the deal.II library and its tutorial, namely maker targets for debug and release versions, running the code and cleaning, the easiest way to write a CMakeLists.txt file may be to use an "autopilot" style macro. Here is a minimalistic example for the step-1 tutorial program (plain text version) that can be used for simple projects:
#
#FIND_PACKAGE(deal.II 9.1.0 REQUIRED
#  HINTS
#    ${DEAL_II_DIR} ../ ../../ $ENV{DEAL_II_DIR}
#    # You can specify additional hints for search paths here, e.g.
#    # $ENV{HOME}/workspace/deal.II
#)
#
## Set the name of the project and target:
#SET(TARGET "step-1")
#
## Declare all source files the target consists of:
#SET(TARGET_SRC
#  step-1.cc
#  # You can specify additional files here!
#)
#
#CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12)
#DEAL_II_INITIALIZE_CACHED_VARIABLES()
#PROJECT(${TARGET} CXX)
#DEAL_II_INVOKE_AUTOPILOT()
#
#This CMakeLists.txt is intended for use with a small project and in-source build (i.e., one does not create a separate build directory as we recommend for the deal.II build in the readme file). Using this input file, you can run cmake in the source directory as follows:
#
#$ cd step-1
#$ cmake .
#
#[...]
####
##
##  Project  step-1  set up with  deal.II-8.3  found at
##      /usr
##
##  CMAKE_BUILD_TYPE:          Debug
##
##  You can now run
##       $ make                - to compile and link the program
##       $ make run            - to (compile, link and) run the program
##
##       $ make debug          - to switch the build type to 'Debug'
##       $ make release        - to switch the build type to 'Release'
##
##       $ make edit_cache     - to change (cached) configuration variables
##                               and rerun the configure and generate phases of CMake
##
##       $ make strip_comments - to strip the source files in this
##                               directory off the documentation comments
##       $ make clean          - to remove the generated executable as well as
##                               all intermediate compilation files
##       $ make runclean       - to remove all output generated by the program
##       $ make distclean      - to clean the directory from _all_ generated
##                               files (includes clean, runclean and the removal
##                               of the generated build system)
##       $ make info           - to view this message again
##
##  Have a nice day!
##
####
#
#There are two additional configuration options (in addition to TARGET and TARGET_SRC) that can be set via variables before DEAL_II_INVOKE_AUTOPILOT() is called (plain text version):
#
## (Optional)
## Specify a list of files (file globs) that will be removed
## with the "make runclean" and "make distclean" targets.
## (If empty, sensible default values will be used.)
#SET(CLEAN_UP_FILES
#  # a custom list of globs, e.g. *.log *.vtk
#)
#
## (Optional)
## A custom command line that should be invoked by "make run".
## (If empty, ./${TARGET} will be invoked.)
#SET(TARGET_RUN
#  # a custom command line, e.g. mpirun -np 2 ${TARGET}
#)
#
#deal.IIConfig.cmake
#
#Importing the deal.IIConfig.cmake file via FIND_PACKAGE will set the following variables and macros; all of the form DEAL_II_*:
#
##
## General package information:
##
#
#DEAL_II_PACKAGE_NAME
#DEAL_II_PACKAGE_VERSION     - the full package version string, e.g. "8.1.pre"
#DEAL_II_PACKAGE_VENDOR
#DEAL_II_PACKAGE_DESCRIPTION
#
#DEAL_II_VERSION             - numerical version number (with "pre" and "rc?"
#                              replaced by "0"), e.g. "8.2.0"
#DEAL_II_VERSION_MAJOR       - the major number, e.g. "8"
#DEAL_II_VERSION_MINOR       - the minor version number, e.g. "2"
#DEAL_II_VERSION_SUBMINOR    - the minor version number, e.g. "0"
#
#DEAL_II_GIT_BRANCH          - name of the local git branch of the source directory
#DEAL_II_GIT_REVISION        - full sha1 revision of the current git HEAD
#DEAL_II_GIT_SHORTREV        - short sha1 revision of the current git HEAD
#
#DEAL_II_BUILD_TYPE          - the configured build type, e.g. "DebugRelease"
#DEAL_II_BUILD_TYPES         - an all caps list of available configurations,
#                              e.g. "DEBUG;RELEASE"
#
##
## Information about component locations:
##
#
#DEAL_II_PATH
#DEAL_II_SHARE_RELDIR
#DEAL_II_DOCREADME_RELDIR
#DEAL_II_DOCHTML_RELDIR
#DEAL_II_EXAMPLES_RELDIR
#DEAL_II_EXECUTABLE_RELDIR
#DEAL_II_INCLUDE_RELDIR
#DEAL_II_LIBRARY_RELDIR
#DEAL_II_PROJECT_CONFIG_RELDIR
#
#DEAL_II_BUILD_DIR             - true if deal.II was picked up from a build
#                                dir, false if the configuration is from an installation
#
##
## Compiler and linker configuration
##
#
#DEAL_II_CXX_COMPILER             - the compiler used to compile deal.II
#
#DEAL_II_CXX_FLAGS                - compile flags for all configurations
#DEAL_II_CXX_FLAGS_DEBUG          - _additional_ compile flags for the debug configuration
#DEAL_II_CXX_FLAGS_RELEASE        - _additional_ compile flags for the release configuration
#
#DEAL_II_LINKER_FLAGS             - link flags for all configurations
#DEAL_II_LINKER_FLAGS_DEBUG       - _additional_ link flags for debug configuration
#DEAL_II_LINKER_FLAGS_RELEASE     - _additional_ link flags for release configuration
#
#DEAL_II_USER_DEFINITIONS         - compile definitions for all configurations
#DEAL_II_USER_DEFINITIONS_DEBUG   - _additional_ compile definitions for debug configuration
#DEAL_II_USER_DEFINITIONS_RELEASE - _additional_ compile definitions for release configuration
#
##
## Information about MPI runtime for the mpi implementation used in the
## deal.II library
##
#
#DEAL_II_MPIEXEC
#DEAL_II_MPIEXEC_NUMPROC_FLAG
#DEAL_II_MPIEXEC_PREFLAGS
#DEAL_II_MPIEXEC_POSTFLAGS
#
#
#DEAL_II_STATIC_EXECUTABLE        - true if the link interface is set up to
#                                   compile resulting executables statically
#
##
## Information about include directories and libraries
##
#
#DEAL_II_INCLUDE_DIRS
#
#DEAL_II_LIBRARIES_DEBUG   - a list of the full link interface for the debug configuration
#DEAL_II_LIBRARIES_RELEASE - a list of the full link interface for the release configuration
#DEAL_II_LIBRARIES         - full list of libraries with "debug" and "optimized" keywords
#
##
## Information about library targets
##
#
#DEAL_II_TARGET_CONFIG  - the target config file
#
#DEAL_II_TARGET_DEBUG   - the name of the debug target that is available after inclusion
#                         of the target config file
#DEAL_II_TARGET_RELEASE - the name of the release target
#DEAL_II_TARGET         - full list of targets with "debug" and "optimized" keywords
#
##
## Feature configuration: The following booleans are set to "ON" or "OFF" depending
## on the current feature configuration:
##
#
#DEAL_II_WITH_64BIT_INDICES
#DEAL_II_WITH_ADOLC
#DEAL_II_WITH_ARPACK
#DEAL_II_WITH_ASSIMP
#DEAL_II_WITH_BOOST
#DEAL_II_WITH_COMPLEX_VALUES
#DEAL_II_WITH_CUDA
#DEAL_II_WITH_CXX14
#DEAL_II_WITH_CXX17
#DEAL_II_WITH_GINKGO
#DEAL_II_WITH_GMSH
#DEAL_II_WITH_GSL
#DEAL_II_WITH_HDF5
#DEAL_II_WITH_LAPACK
#DEAL_II_WITH_METIS
#DEAL_II_WITH_MPI
#DEAL_II_WITH_MUPARSER
#DEAL_II_WITH_NANOFLANN
#DEAL_II_WITH_NETCDF
#DEAL_II_WITH_OPENCASCADE
#DEAL_II_WITH_P4EST
#DEAL_II_WITH_PETSC
#DEAL_II_WITH_SCALAPACK
#DEAL_II_WITH_SLEPC
#DEAL_II_WITH_SUNDIALS
#DEAL_II_WITH_SYMENGINE
#DEAL_II_WITH_THREADS
#DEAL_II_WITH_TRILINOS
#DEAL_II_WITH_UMFPACK
#DEAL_II_WITH_ZLIB
########################################################################################
