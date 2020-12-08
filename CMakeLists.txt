#this is comment in CMakeLists.txt
#how to compile CMakeLists.txt
#mkdir build
#cd build
#cmake .. or cmake -S ../ -B .
#make
#make install
CMake_minimum_required(VERSION 2.6)
#Specify the version being used as well as the language
cmake_minimum_required(VERSION 2.6)

#Name your project here
project(hello)

#Add “-g -O2” options to the gcc compiler
add_definitions(-g -O2)


# specify executable name and dependencies
add_executable(hello hello.cc)

cmake_minimum_required(VERSION 2.6)
#Name your project here
project(hello)
# custom cmake modules path
SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake)
# Special rules for lib installation
include(SetupInstallLib)
#Add “-g -O2” options to the gcc compiler
add_definitions(-g -O2)
# add library to build (located in "lib01" directory)
add_subdirectory(lib01)
# add lib directory as include search dir
include_directories(lib01/include)
# Find all c++ main exes sources files
FILE(GLOB main_src src/*.cc)
# build cpp executables according to the source
FOREACH(main_exe ${main_src})
  get_filename_component(exe ${main_exe} NAME_WE)  # get full name without directory
  MESSAGE( STATUS "New executable ==> " ${exe})    # print exe name
  add_executable (${exe} ${main_exe})              # specify exe file to cpmpile
  target_link_libraries (${exe}  MYlib )           # specify library dependencies
  INSTALL(TARGETS ${exe} RUNTIME DESTINATION bin)  # binaries install directory
ENDFOREACH()

# Install destinattion directory
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set (CMAKE_INSTALL_PREFIX $ENV{HOME}/local  CACHE PATH "" FORCE)
endif()


cmake_minimum_required(VERSION 2.6)

project(hello)

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake)

include(SetupInstallLib)

add_definitions(-g -O2)

CMAKE_MODULE_PATH : cmake module path = files with “.cmake” extension

${PROJECT_SOURCE_DIR}/lib : top level source directory for the current project.

include(SetupInstallLib) : load cmake module => SetupInstallLib.cmake

add_subdirectory(lib01)

include_directories(lib01/include)  # similar to compilation option -Ilib01/include
add_subdirectory(lib01) : add subdirectory “lib01” to the build and process its CMakeList.txt file
          You must have a lib01/CMakeLists.txt file

include_directories(lib01/include) : add lib01/include path to compilation include search path
Equivalent to :  g++ -Ilib01/include ..

You can have multiple include_directories() command, path wil be appended

FILE(GLOB main_src src/*.cc)

FOREACH(main_exe ${main_src})
  get_filename_component(exe ${main_exe} NAME_WE)
  MESSAGE( STATUS "New executable ==> " ${exe})
  add_executable (${exe} ${main_exe})
  target_link_libraries (${exe}  MYlib )
  INSTALL(TARGETS ${exe} RUNTIME DESTINATION bin)
ENDFOREACH()

FILE(GLOB main_src src/*.cc) : create a variable main_src with all c++ sources files from top level src directory.

FILE(GLOB main_src src/*.cc)

FOREACH(main_exe ${main_src})
  get_filename_component(exe ${main_exe} NAME_WE)
  MESSAGE( STATUS "New executable ==> " ${exe})
  add_executable (${exe} ${main_exe})
  target_link_libraries (${exe}  MYlib )
  INSTALL(TARGETS ${exe} RUNTIME DESTINATION bin)
ENDFOREACH()

FILE(GLOB main_src src/*.cc) : create a variable main_src with all c++ sources files from top level src directory.
FOREACH(main_exe ${main_src}) : loop over main_src variable to fill up main_exe variable


FILE(GLOB main_src src/*.cc)

FOREACH(main_exe ${main_src})
  get_filename_component(exe ${main_exe} NAME_WE) 
  MESSAGE( STATUS "New executable ==> " ${exe})      
  add_executable (${exe} ${main_exe})                             
  target_link_libraries (${exe}  MYlib )          
  INSTALL(TARGETS ${exe} RUNTIME DESTINATION bin) 
ENDFOREACH()


FILE(GLOB main_src src/*.cc) : create a variable main_src with all c++ sources files from top level src directory.
FOREACH(main_exe ${main_src}) : loop over main_src variable to fill up main_exe variable
get_filename_component(exe ${main_exe} NAME_W) : set exe variable from main_exe without diretory name nor extension :  main_exe=src/hello.cc → exe=hello
add_executable (${exe} ${main_exe}) : add new executable exe which depends from main_exe

FILE(GLOB main_src src/*.cc)

FOREACH(main_exe ${main_src})
  get_filename_component(exe ${main_exe} NAME_WE) 
  MESSAGE( STATUS "New executable ==> " ${exe})      
  add_executable (${exe} ${main_exe})                             
  target_link_libraries (${exe}  MYlib )          
  INSTALL(TARGETS ${exe} RUNTIME DESTINATION bin) 
ENDFOREACH()

FILE(GLOB main_src src/*.cc) : create a variable main_src with all c++ sources files from top level src directory.
FOREACH(main_exe ${main_src}) : loop over main_src variable to fill up main_exe variable
get_filename_component(exe ${main_exe} NAME_W) : set exe variable from main_exe without diretory name nor extension :  main_exe=src/hello.cc → exe=hello
add_executable (${exe} ${main_exe}) : add new executable exe which depends from main_exe
target_link_libraries (${exe}  MYlib ) : executable must be linked against MYlib library (libMYlib.so)


# Find all library sources files
FILE(GLOB SRCLIB src/*.cc src/*.c) # src sources files relatives too lib01
# add  current directory as include search dir
include_directories(include)
# create library "MYlib"
add_library (MYlib SHARED ${SRCLIB})
# Destination path for the lib
SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

INSTALL(FILES include/chello.h DESTINATION include)
INSTALL(FILES ${PROJECT_BINARY_DIR}/lib/libMYlib.so DESTINATION lib)

FILE(GLOB SRCLIB src/*.cc src/*.c)

include_directories(include)
FILE(GLOB SRCLIB src/*.cc src/*.c) : create a variable SRC_LIB with all c++/c sources files from src subdirectory, actually lib01/src (recursive search)

include_directories(include) :  add include, actually lib01/include, path to compilation include search path

add_library (MYlib SHARED ${SRCLIB})


SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

add_library (MYlib SHARED ${SRCLIB}) : Add a SHARED lib libMYlib.so  to the project using the specified source files from SRCLIB variable.
           Note: no lib prefix nor .so suffix

STATIC instead of SHARED => static library

SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib) : library directory destination
           PROJECT_BINARY_DIR : directory from where you enter cmake command, here build

lib01/CMakeLists.txt
INSTALL(FILES include/chello.h DESTINATION include)
INSTALL(FILES ${PROJECT_BINARY_DIR}/lib/libMYlib.so DESTINATION lib)

cmake/SetupInstallLib.cmake
# Install destinattion directory
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set (CMAKE_INSTALL_PREFIX $ENV{HOME}/local  CACHE PATH "" FORCE)
endif()
SET(CMAKE_SKIP_BUILD_RPATH  FALSE)
# when building, don't use the install RPATH already
# (but later on when installing)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
# add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
# check RPATH to be used when installing is not a system directory
LIST(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
IF("${isSystemDir}" STREQUAL "-1")
   SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
ENDIF("${isSystemDir}" STREQUAL "-1")

CMakeLists.txt
INSTALL(TARGETS ${exe} RUNTIME DESTINATION bin)

if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set (CMAKE_INSTALL_PREFIX $ENV{HOME}/local  CACHE PATH "" FORCE)
endif()

SET(CMAKE_SKIP_BUILD_RPATH  FALSE)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
LIST(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
IF("${isSystemDir}" STREQUAL "-1")
   SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
ENDIF("${isSystemDir}" STREQUAL "-1")
CMAKE_INSTALL_PREFIX : specify install base directory path

set (CMAKE_INSTALL_PREFIX $ENV{HOME}/local  CACHE PATH "" FORCE) : installation by default in ${HOME}/local directory

To change default install directory path, re-run :
		cmake .. -DCMAKE_INSTALL_PREFIX=/mynewpath/directory
		make install

FOREACH(main_exe ${main_src})
   …. 
   ….
  INSTALL(TARGETS ${exe} RUNTIME DESTINATION bin) 
ENDFOREACH()

INSTALL(TARGETS ${exe} RUNTIME DESTINATION bin) : install every exe binary file to installation_path/bin directory

from lib01/CMakeLists.txt
INSTALL(FILES include/chello.h DESTINATION include) : install chello.h to installation_path/include directory

INSTALL(FILES ${PROJECT_BINARY_DIR}/lib/libMYlib.so DESTINATION lib) : install  library libMYlib.so to installation_path/lib directory

Note : library comes from ${PROJECT_BINARY_DIR}/lib directory

INSTALL(FILES include/chello.h DESTINATION include)

INSTALL(FILES ${PROJECT_BINARY_DIR}/lib/libMYlib.so DESTINATION lib)

INSTALL(FILES include/chello.h DESTINATION include) : install chello.h to installation_path/include directory

INSTALL(FILES ${PROJECT_BINARY_DIR}/lib/libMYlib.so DESTINATION lib) : install  library libMYlib.so to installation_path/lib directory

Note : library comes from ${PROJECT_BINARY_DIR}/lib directory




CMake Tutorial
Contents

CMake Tutorial

Introduction

A Basic Starting Point (Step 1)

Adding a Version Number and Configured Header File

Specify the C++ Standard

Build and Test

Adding a Library (Step 2)

Adding Usage Requirements for Library (Step 3)

Installing and Testing (Step 4)

Install Rules

Testing Support

Adding System Introspection (Step 5)

Specify Compile Definition

Adding a Custom Command and Generated File (Step 6)

Building an Installer (Step 7)

Adding Support for a Dashboard (Step 8)

Mixing Static and Shared (Step 9)

Adding Generator Expressions (Step 10)

Adding Export Configuration (Step 11)

Packaging Debug and Release (Step 12)

Introduction
The CMake tutorial provides a step-by-step guide that covers common build system issues that CMake helps address. Seeing how various topics all work together in an example project can be very helpful. The tutorial documentation and source code for examples can be found in the Help/guide/tutorial directory of the CMake source code tree. Each step has its own subdirectory containing code that may be used as a starting point. The tutorial examples are progressive so that each step provides the complete solution for the previous step.

A Basic Starting Point (Step 1)
The most basic project is an executable built from source code files. For simple projects, a three line CMakeLists.txt file is all that is required. This will be the starting point for our tutorial. Create a CMakeLists.txt file in the Step1 directory that looks like:

cmake_minimum_required(VERSION 3.10)

# set the project name
project(Tutorial)

# add the executable
add_executable(Tutorial tutorial.cxx)
Note that this example uses lower case commands in the CMakeLists.txt file. Upper, lower, and mixed case commands are supported by CMake. The source code for tutorial.cxx is provided in the Step1 directory and can be used to compute the square root of a number.

Adding a Version Number and Configured Header File
The first feature we will add is to provide our executable and project with a version number. While we could do this exclusively in the source code, using CMakeLists.txt provides more flexibility.

First, modify the CMakeLists.txt file to use the project() command to set the project name and version number.

cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)
Then, configure a header file to pass the version number to the source code:

configure_file(TutorialConfig.h.in TutorialConfig.h)
Since the configured file will be written into the binary tree, we must add that directory to the list of paths to search for include files. Add the following lines to the end of the CMakeLists.txt file:

target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )
Using your favorite editor, create TutorialConfig.h.in in the source directory with the following contents:

// the configured options and settings for Tutorial
#define Tutorial_VERSION_MAJOR @Tutorial_VERSION_MAJOR@
#define Tutorial_VERSION_MINOR @Tutorial_VERSION_MINOR@
When CMake configures this header file the values for @Tutorial_VERSION_MAJOR@ and @Tutorial_VERSION_MINOR@ will be replaced.

Next modify tutorial.cxx to include the configured header file, TutorialConfig.h.

Finally, let’s print out the executable name and version number by updating tutorial.cxx as follows:

  if (argc < 2) {
    // report version
    std::cout << argv[0] << " Version " << Tutorial_VERSION_MAJOR << "."
              << Tutorial_VERSION_MINOR << std::endl;
    std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }
Specify the C++ Standard
Next let’s add some C++11 features to our project by replacing atof with std::stod in tutorial.cxx. At the same time, remove #include <cstdlib>.

  const double inputValue = std::stod(argv[1]);
We will need to explicitly state in the CMake code that it should use the correct flags. The easiest way to enable support for a specific C++ standard in CMake is by using the CMAKE_CXX_STANDARD variable. For this tutorial, set the CMAKE_CXX_STANDARD variable in the CMakeLists.txt file to 11 and CMAKE_CXX_STANDARD_REQUIRED to True. Make sure to add the CMAKE_CXX_STANDARD declarations above the call to add_executable.

cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
Build and Test
Run the cmake executable or the cmake-gui to configure the project and then build it with your chosen build tool.

For example, from the command line we could navigate to the Help/guide/tutorial directory of the CMake source code tree and create a build directory:

mkdir Step1_build
Next, navigate to the build directory and run CMake to configure the project and generate a native build system:

cd Step1_build
cmake ../Step1
Then call that build system to actually compile/link the project:

cmake --build .
Finally, try to use the newly built Tutorial with these commands:

Tutorial 4294967296
Tutorial 10
Tutorial
Adding a Library (Step 2)
Now we will add a library to our project. This library will contain our own implementation for computing the square root of a number. The executable can then use this library instead of the standard square root function provided by the compiler.

For this tutorial we will put the library into a subdirectory called MathFunctions. This directory already contains a header file, MathFunctions.h, and a source file mysqrt.cxx. The source file has one function called mysqrt that provides similar functionality to the compiler’s sqrt function.

Add the following one line CMakeLists.txt file to the MathFunctions directory:

add_library(MathFunctions mysqrt.cxx)
To make use of the new library we will add an add_subdirectory() call in the top-level CMakeLists.txt file so that the library will get built. We add the new library to the executable, and add MathFunctions as an include directory so that the mqsqrt.h header file can be found. The last few lines of the top-level CMakeLists.txt file should now look like:

# add the MathFunctions library
add_subdirectory(MathFunctions)

# add the executable
add_executable(Tutorial tutorial.cxx)

target_link_libraries(Tutorial PUBLIC MathFunctions)

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                          "${PROJECT_BINARY_DIR}"
                          "${PROJECT_SOURCE_DIR}/MathFunctions"
                          )
Now let us make the MathFunctions library optional. While for the tutorial there really isn’t any need to do so, for larger projects this is a common occurrence. The first step is to add an option to the top-level CMakeLists.txt file.

option(USE_MYMATH "Use tutorial provided math implementation" ON)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)
This option will be displayed in the cmake-gui and ccmake with a default value of ON that can be changed by the user. This setting will be stored in the cache so that the user does not need to set the value each time they run CMake on a build directory.

The next change is to make building and linking the MathFunctions library conditional. To do this we change the end of the top-level CMakeLists.txt file to look like the following:

if(USE_MYMATH)
  add_subdirectory(MathFunctions)
  list(APPEND EXTRA_LIBS MathFunctions)
  list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunctions")
endif()

# add the executable
add_executable(Tutorial tutorial.cxx)

target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           ${EXTRA_INCLUDES}
                           )
Note the use of the variable EXTRA_LIBS to collect up any optional libraries to later be linked into the executable. The variable EXTRA_INCLUDES is used similarly for optional header files. This is a classic approach when dealing with many optional components, we will cover the modern approach in the next step.

The corresponding changes to the source code are fairly straightforward. First, in tutorial.cxx, include the MathFunctions.h header if we need it:

#ifdef USE_MYMATH
#  include "MathFunctions.h"
#endif
Then, in the same file, make USE_MYMATH control which square root function is used:

#ifdef USE_MYMATH
  const double outputValue = mysqrt(inputValue);
#else
  const double outputValue = sqrt(inputValue);
#endif
Since the source code now requires USE_MYMATH we can add it to TutorialConfig.h.in with the following line:

#cmakedefine USE_MYMATH
Exercise: Why is it important that we configure TutorialConfig.h.in after the option for USE_MYMATH? What would happen if we inverted the two?

Run the cmake executable or the cmake-gui to configure the project and then build it with your chosen build tool. Then run the built Tutorial executable.

Now let’s update the value of USE_MYMATH. The easiest way is to use the cmake-gui or ccmake if you’re in the terminal. Or, alternatively, if you want to change the option from the command-line, try:

cmake ../Step2 -DUSE_MYMATH=OFF
Rebuild and run the tutorial again.

Which function gives better results, sqrt or mysqrt?

Adding Usage Requirements for Library (Step 3)
Usage requirements allow for far better control over a library or executable’s link and include line while also giving more control over the transitive property of targets inside CMake. The primary commands that leverage usage requirements are:

target_compile_definitions()

target_compile_options()

target_include_directories()

target_link_libraries()

Let’s refactor our code from Adding a Library (Step 2) to use the modern CMake approach of usage requirements. We first state that anybody linking to MathFunctions needs to include the current source directory, while MathFunctions itself doesn’t. So this can become an INTERFACE usage requirement.

Remember INTERFACE means things that consumers require but the producer doesn’t. Add the following lines to the end of MathFunctions/CMakeLists.txt:

target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          )
Now that we’ve specified usage requirements for MathFunctions we can safely remove our uses of the EXTRA_INCLUDES variable from the top-level CMakeLists.txt, here:

if(USE_MYMATH)
  add_subdirectory(MathFunctions)
  list(APPEND EXTRA_LIBS MathFunctions)
endif()
And here:

target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )
Once this is done, run the cmake executable or the cmake-gui to configure the project and then build it with your chosen build tool or by using cmake --build . from the build directory.

Installing and Testing (Step 4)
Now we can start adding install rules and testing support to our project.

Install Rules
The install rules are fairly simple: for MathFunctions we want to install the library and header file and for the application we want to install the executable and configured header.

So to the end of MathFunctions/CMakeLists.txt we add:

install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
And to the end of the top-level CMakeLists.txt we add:

install(TARGETS Tutorial DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
  DESTINATION include
  )
That is all that is needed to create a basic local install of the tutorial.

Now run the cmake executable or the cmake-gui to configure the project and then build it with your chosen build tool.

Then run the install step by using the install option of the cmake command (introduced in 3.15, older versions of CMake must use make install) from the command line. For multi-configuration tools, don’t forget to use the --config argument to specify the configuration. If using an IDE, simply build the INSTALL target. This step will install the appropriate header files, libraries, and executables. For example:

cmake --install .
The CMake variable CMAKE_INSTALL_PREFIX is used to determine the root of where the files will be installed. If using the cmake --install command, the installation prefix can be overridden via the --prefix argument. For example:

cmake --install . --prefix "/home/myuser/installdir"
Navigate to the install directory and verify that the installed Tutorial runs.

Testing Support
Next let’s test our application. At the end of the top-level CMakeLists.txt file we can enable testing and then add a number of basic tests to verify that the application is working correctly.

enable_testing()

# does the application run
add_test(NAME Runs COMMAND Tutorial 25)

# does the usage message work?
add_test(NAME Usage COMMAND Tutorial)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
  )

# define a function to simplify adding tests
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction(do_test)

# do a bunch of result based tests
do_test(Tutorial 4 "4 is 2")
do_test(Tutorial 9 "9 is 3")
do_test(Tutorial 5 "5 is 2.236")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is [-nan|nan|0]")
do_test(Tutorial 0.0001 "0.0001 is 0.01")
The first test simply verifies that the application runs, does not segfault or otherwise crash, and has a zero return value. This is the basic form of a CTest test.

The next test makes use of the PASS_REGULAR_EXPRESSION test property to verify that the output of the test contains certain strings. In this case, verifying that the usage message is printed when an incorrect number of arguments are provided.

Lastly, we have a function called do_test that runs the application and verifies that the computed square root is correct for given input. For each invocation of do_test, another test is added to the project with a name, input, and expected results based on the passed arguments.

Rebuild the application and then cd to the binary directory and run the ctest executable: ctest -N and ctest -VV. For multi-config generators (e.g. Visual Studio), the configuration type must be specified. To run tests in Debug mode, for example, use ctest -C Debug -VV from the build directory (not the Debug subdirectory!). Alternatively, build the RUN_TESTS target from the IDE.

Adding System Introspection (Step 5)
Let us consider adding some code to our project that depends on features the target platform may not have. For this example, we will add some code that depends on whether or not the target platform has the log and exp functions. Of course almost every platform has these functions but for this tutorial assume that they are not common.

If the platform has log and exp then we will use them to compute the square root in the mysqrt function. We first test for the availability of these functions using the CheckSymbolExists module in the top-level CMakeLists.txt. On some platforms, we will need to link to the m library. If log and exp are not initially found, require the m library and try again.

We’re going to use the new defines in TutorialConfig.h.in, so be sure to set them before that file is configured.

include(CheckSymbolExists)
check_symbol_exists(log "math.h" HAVE_LOG)
check_symbol_exists(exp "math.h" HAVE_EXP)
if(NOT (HAVE_LOG AND HAVE_EXP))
  unset(HAVE_LOG CACHE)
  unset(HAVE_EXP CACHE)
  set(CMAKE_REQUIRED_LIBRARIES "m")
  check_symbol_exists(log "math.h" HAVE_LOG)
  check_symbol_exists(exp "math.h" HAVE_EXP)
  if(HAVE_LOG AND HAVE_EXP)
    target_link_libraries(MathFunctions PRIVATE m)
  endif()
endif()
Now let’s add these defines to TutorialConfig.h.in so that we can use them from mysqrt.cxx:

// does the platform provide exp and log functions?
#cmakedefine HAVE_LOG
#cmakedefine HAVE_EXP
If log and exp are available on the system, then we will use them to compute the square root in the mysqrt function. Add the following code to the mysqrt function in MathFunctions/mysqrt.cxx (don’t forget the #endif before returning the result!):

#if defined(HAVE_LOG) && defined(HAVE_EXP)
  double result = exp(log(x) * 0.5);
  std::cout << "Computing sqrt of " << x << " to be " << result
            << " using log and exp" << std::endl;
#else
  double result = x;
We will also need to modify mysqrt.cxx to include cmath.

#include <cmath>
Run the cmake executable or the cmake-gui to configure the project and then build it with your chosen build tool and run the Tutorial executable.

You will notice that we’re not using log and exp, even if we think they should be available. We should realize quickly that we have forgotten to include TutorialConfig.h in mysqrt.cxx.

We will also need to update MathFunctions/CMakeLists.txt so mysqrt.cxx knows where this file is located:

target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          PRIVATE ${CMAKE_BINARY_DIR}
          )
After making this update, go ahead and build the project again and run the built Tutorial executable. If log and exp are still not being used, open the generated TutorialConfig.h file from the build directory. Maybe they aren’t available on the current system?

Which function gives better results now, sqrt or mysqrt?

Specify Compile Definition
Is there a better place for us to save the HAVE_LOG and HAVE_EXP values other than in TutorialConfig.h? Let’s try to use target_compile_definitions().

First, remove the defines from TutorialConfig.h.in. We no longer need to include TutorialConfig.h from mysqrt.cxx or the extra include in MathFunctions/CMakeLists.txt.

Next, we can move the check for HAVE_LOG and HAVE_EXP to MathFunctions/CMakeLists.txt and then specify those values as PRIVATE compile definitions.

include(CheckSymbolExists)
check_symbol_exists(log "math.h" HAVE_LOG)
check_symbol_exists(exp "math.h" HAVE_EXP)
if(NOT (HAVE_LOG AND HAVE_EXP))
  unset(HAVE_LOG CACHE)
  unset(HAVE_EXP CACHE)
  set(CMAKE_REQUIRED_LIBRARIES "m")
  check_symbol_exists(log "math.h" HAVE_LOG)
  check_symbol_exists(exp "math.h" HAVE_EXP)
  if(HAVE_LOG AND HAVE_EXP)
    target_link_libraries(MathFunctions PRIVATE m)
  endif()
endif()

# add compile definitions
if(HAVE_LOG AND HAVE_EXP)
  target_compile_definitions(MathFunctions
                             PRIVATE "HAVE_LOG" "HAVE_EXP")
endif()
After making these updates, go ahead and build the project again. Run the built Tutorial executable and verify that the results are same as earlier in this step.

Adding a Custom Command and Generated File (Step 6)
Suppose, for the purpose of this tutorial, we decide that we never want to use the platform log and exp functions and instead would like to generate a table of precomputed values to use in the mysqrt function. In this section, we will create the table as part of the build process, and then compile that table into our application.

First, let’s remove the check for the log and exp functions in MathFunctions/CMakeLists.txt. Then remove the check for HAVE_LOG and HAVE_EXP from mysqrt.cxx. At the same time, we can remove #include <cmath>.

In the MathFunctions subdirectory, a new source file named MakeTable.cxx has been provided to generate the table.

After reviewing the file, we can see that the table is produced as valid C++ code and that the output filename is passed in as an argument.

The next step is to add the appropriate commands to the MathFunctions/CMakeLists.txt file to build the MakeTable executable and then run it as part of the build process. A few commands are needed to accomplish this.

First, at the top of MathFunctions/CMakeLists.txt, the executable for MakeTable is added as any other executable would be added.

add_executable(MakeTable MakeTable.cxx)
Then we add a custom command that specifies how to produce Table.h by running MakeTable.

add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
  COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
  DEPENDS MakeTable
  )
Next we have to let CMake know that mysqrt.cxx depends on the generated file Table.h. This is done by adding the generated Table.h to the list of sources for the library MathFunctions.

add_library(MathFunctions
            mysqrt.cxx
            ${CMAKE_CURRENT_BINARY_DIR}/Table.h
            )
We also have to add the current binary directory to the list of include directories so that Table.h can be found and included by mysqrt.cxx.

target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          PRIVATE ${CMAKE_CURRENT_BINARY_DIR}
          )
Now let’s use the generated table. First, modify mysqrt.cxx to include Table.h. Next, we can rewrite the mysqrt function to use the table:

double mysqrt(double x)
{
  if (x <= 0) {
    return 0;
  }

  // use the table to help find an initial value
  double result = x;
  if (x >= 1 && x < 10) {
    std::cout << "Use the table to help find an initial value " << std::endl;
    result = sqrtTable[static_cast<int>(x)];
  }

  // do ten iterations
  for (int i = 0; i < 10; ++i) {
    if (result <= 0) {
      result = 0.1;
    }
    double delta = x - (result * result);
    result = result + 0.5 * delta / result;
    std::cout << "Computing sqrt of " << x << " to be " << result << std::endl;
  }

  return result;
}
Run the cmake executable or the cmake-gui to configure the project and then build it with your chosen build tool.

When this project is built it will first build the MakeTable executable. It will then run MakeTable to produce Table.h. Finally, it will compile mysqrt.cxx which includes Table.h to produce the MathFunctions library.

Run the Tutorial executable and verify that it is using the table.

Building an Installer (Step 7)
Next suppose that we want to distribute our project to other people so that they can use it. We want to provide both binary and source distributions on a variety of platforms. This is a little different from the install we did previously in Installing and Testing (Step 4) , where we were installing the binaries that we had built from the source code. In this example we will be building installation packages that support binary installations and package management features. To accomplish this we will use CPack to create platform specific installers. Specifically we need to add a few lines to the bottom of our top-level CMakeLists.txt file.

include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
include(CPack)
That is all there is to it. We start by including InstallRequiredSystemLibraries. This module will include any runtime libraries that are needed by the project for the current platform. Next we set some CPack variables to where we have stored the license and version information for this project. The version information was set earlier in this tutorial and the license.txt has been included in the top-level source directory for this step.

Finally we include the CPack module which will use these variables and some other properties of the current system to setup an installer.

The next step is to build the project in the usual manner and then run the cpack executable. To build a binary distribution, from the binary directory run:

cpack
To specify the generator, use the -G option. For multi-config builds, use -C to specify the configuration. For example:

cpack -G ZIP -C Debug
To create a source distribution you would type:

cpack --config CPackSourceConfig.cmake
Alternatively, run make package or right click the Package target and Build Project from an IDE.

Run the installer found in the binary directory. Then run the installed executable and verify that it works.

Adding Support for a Dashboard (Step 8)
Adding support for submitting our test results to a dashboard is simple. We already defined a number of tests for our project in Testing Support. Now we just have to run those tests and submit them to a dashboard. To include support for dashboards we include the CTest module in our top-level CMakeLists.txt.

Replace:

# enable testing
enable_testing()
With:

# enable dashboard scripting
include(CTest)
The CTest module will automatically call enable_testing(), so we can remove it from our CMake files.

We will also need to create a CTestConfig.cmake file in the top-level directory where we can specify the name of the project and where to submit the dashboard.

set(CTEST_PROJECT_NAME "CMakeTutorial")
set(CTEST_NIGHTLY_START_TIME "00:00:00 EST")

set(CTEST_DROP_METHOD "http")
set(CTEST_DROP_SITE "my.cdash.org")
set(CTEST_DROP_LOCATION "/submit.php?project=CMakeTutorial")
set(CTEST_DROP_SITE_CDASH TRUE)
The ctest executable will read in this file when it runs. To create a simple dashboard you can run the cmake executable or the cmake-gui to configure the project, but do not build it yet. Instead, change directory to the binary tree, and then run:

ctest [-VV] -D Experimental

Remember, for multi-config generators (e.g. Visual Studio), the configuration type must be specified:

ctest [-VV] -C Debug -D Experimental
Or, from an IDE, build the Experimental target.

The ctest executable will build and test the project and submit the results to Kitware’s public dashboard: https://my.cdash.org/index.php?project=CMakeTutorial.

Mixing Static and Shared (Step 9)
In this section we will show how the BUILD_SHARED_LIBS variable can be used to control the default behavior of add_library(), and allow control over how libraries without an explicit type (STATIC, SHARED, MODULE or OBJECT) are built.

To accomplish this we need to add BUILD_SHARED_LIBS to the top-level CMakeLists.txt. We use the option() command as it allows users to optionally select if the value should be ON or OFF.

Next we are going to refactor MathFunctions to become a real library that encapsulates using mysqrt or sqrt, instead of requiring the calling code to do this logic. This will also mean that USE_MYMATH will not control building MathFunctions, but instead will control the behavior of this library.

The first step is to update the starting section of the top-level CMakeLists.txt to look like:

cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# control where the static and shared libraries are built so that on windows
# we don't need to tinker with the path to run the executable
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

# configure a header file to pass the version number only
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the MathFunctions library
add_subdirectory(MathFunctions)

# add the executable
add_executable(Tutorial tutorial.cxx)
target_link_libraries(Tutorial PUBLIC MathFunctions)
Now that we have made MathFunctions always be used, we will need to update the logic of that library. So, in MathFunctions/CMakeLists.txt we need to create a SqrtLibrary that will conditionally be built and installed when USE_MYMATH is enabled. Now, since this is a tutorial, we are going to explicitly require that SqrtLibrary is built statically.

The end result is that MathFunctions/CMakeLists.txt should look like:

# add the library that runs
add_library(MathFunctions MathFunctions.cxx)

# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while we don't.
target_include_directories(MathFunctions
                           INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
                           )

# should we use our own math functions
option(USE_MYMATH "Use tutorial provided math implementation" ON)
if(USE_MYMATH)

  target_compile_definitions(MathFunctions PRIVATE "USE_MYMATH")

  # first we add the executable that generates the table
  add_executable(MakeTable MakeTable.cxx)

  # add the command to generate the source code
  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
    COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
    DEPENDS MakeTable
    )

  # library that just does sqrt
  add_library(SqrtLibrary STATIC
              mysqrt.cxx
              ${CMAKE_CURRENT_BINARY_DIR}/Table.h
              )

  # state that we depend on our binary dir to find Table.h
  target_include_directories(SqrtLibrary PRIVATE
                             ${CMAKE_CURRENT_BINARY_DIR}
                             )

  target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
endif()

# define the symbol stating we are using the declspec(dllexport) when
# building on windows
target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")

# install rules
set(installable_libs MathFunctions)
if(TARGET SqrtLibrary)
  list(APPEND installable_libs SqrtLibrary)
endif()
install(TARGETS ${installable_libs} DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
Next, update MathFunctions/mysqrt.cxx to use the mathfunctions and detail namespaces:

#include <iostream>

#include "MathFunctions.h"

// include the generated table
#include "Table.h"

namespace mathfunctions {
namespace detail {
// a hack square root calculation using simple operations
double mysqrt(double x)
{
  if (x <= 0) {
    return 0;
  }

  // use the table to help find an initial value
  double result = x;
  if (x >= 1 && x < 10) {
    std::cout << "Use the table to help find an initial value " << std::endl;
    result = sqrtTable[static_cast<int>(x)];
  }

  // do ten iterations
  for (int i = 0; i < 10; ++i) {
    if (result <= 0) {
      result = 0.1;
    }
    double delta = x - (result * result);
    result = result + 0.5 * delta / result;
    std::cout << "Computing sqrt of " << x << " to be " << result << std::endl;
  }

  return result;
}
}
}
We also need to make some changes in tutorial.cxx, so that it no longer uses USE_MYMATH:

Always include MathFunctions.h

Always use mathfunctions::sqrt

Don’t include cmath

Finally, update MathFunctions/MathFunctions.h to use dll export defines:

#if defined(_WIN32)
#  if defined(EXPORTING_MYMATH)
#    define DECLSPEC __declspec(dllexport)
#  else
#    define DECLSPEC __declspec(dllimport)
#  endif
#else // non windows
#  define DECLSPEC
#endif

namespace mathfunctions {
double DECLSPEC sqrt(double x);
}
At this point, if you build everything, you may notice that linking fails as we are combining a static library without position independent code with a library that has position independent code. The solution to this is to explicitly set the POSITION_INDEPENDENT_CODE target property of SqrtLibrary to be True no matter the build type.

  # state that SqrtLibrary need PIC when the default is shared libraries
  set_target_properties(SqrtLibrary PROPERTIES
                        POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
                        )

  target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
Exercise: We modified MathFunctions.h to use dll export defines. Using CMake documentation can you find a helper module to simplify this?

Adding Generator Expressions (Step 10)
Generator expressions are evaluated during build system generation to produce information specific to each build configuration.

Generator expressions are allowed in the context of many target properties, such as LINK_LIBRARIES, INCLUDE_DIRECTORIES, COMPILE_DEFINITIONS and others. They may also be used when using commands to populate those properties, such as target_link_libraries(), target_include_directories(), target_compile_definitions() and others.

Generator expressions may be used to enable conditional linking, conditional definitions used when compiling, conditional include directories and more. The conditions may be based on the build configuration, target properties, platform information or any other queryable information.

There are different types of generator expressions including Logical, Informational, and Output expressions.

Logical expressions are used to create conditional output. The basic expressions are the 0 and 1 expressions. A $<0:...> results in the empty string, and <1:...> results in the content of “…”. They can also be nested.

A common usage of generator expressions is to conditionally add compiler flags, such as those for language levels or warnings. A nice pattern is to associate this information to an INTERFACE target allowing this information to propagate. Let’s start by constructing an INTERFACE target and specifying the required C++ standard level of 11 instead of using CMAKE_CXX_STANDARD.

So the following code:

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
Would be replaced with:

add_library(tutorial_compiler_flags INTERFACE)
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)
Next we add the desired compiler warning flags that we want for our project. As warning flags vary based on the compiler we use the COMPILE_LANG_AND_ID generator expression to control which flags to apply given a language and a set of compiler ids as seen below:

set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
target_compile_options(tutorial_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)
Looking at this we see that the warning flags are encapsulated inside a BUILD_INTERFACE condition. This is done so that consumers of our installed project will not inherit our warning flags.

Exercise: Modify MathFunctions/CMakeLists.txt so that all targets have a target_link_libraries() call to tutorial_compiler_flags.

Adding Export Configuration (Step 11)
During Installing and Testing (Step 4) of the tutorial we added the ability for CMake to install the library and headers of the project. During Building an Installer (Step 7) we added the ability to package up this information so it could be distributed to other people.

The next step is to add the necessary information so that other CMake projects can use our project, be it from a build directory, a local install or when packaged.

The first step is to update our install(TARGETS) commands to not only specify a DESTINATION but also an EXPORT. The EXPORT keyword generates and installs a CMake file containing code to import all targets listed in the install command from the installation tree. So let’s go ahead and explicitly EXPORT the MathFunctions library by updating the install command in MathFunctions/CMakeLists.txt to look like:

set(installable_libs MathFunctions tutorial_compiler_flags)
if(TARGET SqrtLibrary)
  list(APPEND installable_libs SqrtLibrary)
endif()
install(TARGETS ${installable_libs}
        DESTINATION lib
        EXPORT MathFunctionsTargets)
install(FILES MathFunctions.h DESTINATION include)
Now that we have MathFunctions being exported, we also need to explicitly install the generated MathFunctionsTargets.cmake file. This is done by adding the following to the bottom of the top-level CMakeLists.txt:

install(EXPORT MathFunctionsTargets
  FILE MathFunctionsTargets.cmake
  DESTINATION lib/cmake/MathFunctions
)
At this point you should try and run CMake. If everything is setup properly you will see that CMake will generate an error that looks like:

Target "MathFunctions" INTERFACE_INCLUDE_DIRECTORIES property contains
path:

  "/Users/robert/Documents/CMakeClass/Tutorial/Step11/MathFunctions"

which is prefixed in the source directory.
What CMake is trying to say is that during generating the export information it will export a path that is intrinsically tied to the current machine and will not be valid on other machines. The solution to this is to update the MathFunctions target_include_directories() to understand that it needs different INTERFACE locations when being used from within the build directory and from an install / package. This means converting the target_include_directories() call for MathFunctions to look like:

target_include_directories(MathFunctions
                           INTERFACE
                            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                            $<INSTALL_INTERFACE:include>
                           )
Once this has been updated, we can re-run CMake and verify that it doesn’t warn anymore.

At this point, we have CMake properly packaging the target information that is required but we will still need to generate a MathFunctionsConfig.cmake so that the CMake find_package() command can find our project. So let’s go ahead and add a new file to the top-level of the project called Config.cmake.in with the following contents:


@PACKAGE_INIT@

include ( "${CMAKE_CURRENT_LIST_DIR}/MathFunctionsTargets.cmake" )
Then, to properly configure and install that file, add the following to the bottom of the top-level CMakeLists.txt:

install(EXPORT MathFunctionsTargets
  FILE MathFunctionsTargets.cmake
  DESTINATION lib/cmake/MathFunctions
)

include(CMakePackageConfigHelpers)
# generate the config file that is includes the exports
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
  INSTALL_DESTINATION "lib/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )
# generate the version file for the config file
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)

# install the configuration file
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
  DESTINATION lib/cmake/MathFunctions
  )
At this point, we have generated a relocatable CMake Configuration for our project that can be used after the project has been installed or packaged. If we want our project to also be used from a build directory we only have to add the following to the bottom of the top level CMakeLists.txt:

export(EXPORT MathFunctionsTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
)
With this export call we now generate a Targets.cmake, allowing the configured MathFunctionsConfig.cmake in the build directory to be used by other projects, without needing it to be installed.

Packaging Debug and Release (Step 12)
Note: This example is valid for single-configuration generators and will not work for multi-configuration generators (e.g. Visual Studio).

By default, CMake’s model is that a build directory only contains a single configuration, be it Debug, Release, MinSizeRel, or RelWithDebInfo. It is possible, however, to setup CPack to bundle multiple build directories and construct a package that contains multiple configurations of the same project.

First, we want to ensure that the debug and release builds use different names for the executables and libraries that will be installed. Let’s use d as the postfix for the debug executable and libraries.

Set CMAKE_DEBUG_POSTFIX near the beginning of the top-level CMakeLists.txt file:

set(CMAKE_DEBUG_POSTFIX d)

add_library(tutorial_compiler_flags INTERFACE)
And the DEBUG_POSTFIX property on the tutorial executable:

add_executable(Tutorial tutorial.cxx)
set_target_properties(Tutorial PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})

target_link_libraries(Tutorial PUBLIC MathFunctions)
Let’s also add version numbering to the MathFunctions library. In MathFunctions/CMakeLists.txt, set the VERSION and SOVERSION properties:

set_property(TARGET MathFunctions PROPERTY VERSION "1.0.0")
set_property(TARGET MathFunctions PROPERTY SOVERSION "1")
From the Step12 directory, create debug and release subbdirectories. The layout will look like:

- Step12
   - debug
   - release
Now we need to setup debug and release builds. We can use CMAKE_BUILD_TYPE to set the configuration type:

cd debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build .
cd ../release
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
Now that both the debug and release builds are complete, we can use a custom configuration file to package both builds into a single release. In the Step12 directory, create a file called MultiCPackConfig.cmake. In this file, first include the default configuration file that was created by the cmake executable.

Next, use the CPACK_INSTALL_CMAKE_PROJECTS variable to specify which projects to install. In this case, we want to install both debug and release.

include("release/CPackConfig.cmake")

set(CPACK_INSTALL_CMAKE_PROJECTS
    "debug;Tutorial;ALL;/"
    "release;Tutorial;ALL;/"
    )
From the Step12 directory, run cpack specifying our custom configuration file with the config option:

cpack --config MultiCPackConfig.cmake

cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
set(CMAKE_LEGACY_CYGWIN_WIN32 0)
project("To Do List")
enable_testing()
add_executable(toDo main.cc
                    ToDo.cc)
add_test(toDoTest toDo)

cmake_minimum_required(VERSION version FATAL_ERROR)
This command specifies the minimum version of CMake that can be used with CMakeLists.txt file. The first argument must be VERSION verbatim. The next is the minimum version of CMake that can be used. The last is optional, but should be included, it must be FATAL_ERROR verbatim. It is recommended that this command be used in all top level CMakeLists.txt. If you aren’t sure what version to set use the version of CMake you have installed.
cmake_minimum_required() documentation (2013-03-26)
set(CMAKE_LEGACY_CYGWIN_WIN32 0)
This gets rid of the warning you would have seen earlier if you were using Cygwin. If you aren’t using Cygwin then it has no effect at all.
This tells CMake not to define WIN32 when building with Cygwin. This is the preferred option and for us it doesn’t make a difference either way so we will use the recommended setting.
enable_testing()
Enables testing for this CMake project. This should only be used in top level CMakeLists.txt. The main thing this does is enable the add_test() command.
enable_testing() documentation (2013-03-26)
add_test(testname executable arg1 …)
This command only does something if the enable_testing() has already been run, otherwise it does nothing. This adds a test to the current directory that will be run by CTest. The executable can be anything, so it could be a test program, e.g. a unit test created with something like Google Test, a script, or any other test imaginable. Note: Tests are not run automatically and if your test program is built as part of your project the test target will not ensure it is up to date. It is best to build all other targets before running the test target.
add_test() documentation (2013-03-26)
Perhaps I lied. One can easily argue that introducing the add_test() command is not a simple improvement. And they would probably be right, however, it is an important improvement. Testing will be explored further later in this tutorial.

Naturally we need some more code to go with this, so here goes:

As mentioned earlier building with CMake is the same as it was before.
make test
The enable_testing() function we added to our CMakeLists.txt adds the “test” target to our Makefile. Making the “test” target will run CTest which will, in turn, run all of our tests. In our case just the one.
When CTest runs our tests it prints an abbreviated output that just provides the status of each of our tests. It then finishes up with a summary of all tests.
Testing/Temporary/LastTest.log
This file is created by CTest whenever it is run. It contains much more detail than the terminal output of CTest shows. Most importantly it contains the output of the tests. This is where you will want to look whenever a test fails.
Testing/Temporary/CTestCostData.txt
This file contains the time, in seconds, taken to run each test.
CMake along with CTest makes it easy to run our tests. CTest has many other features which will be presented later in this tutorial. There are, however, a few drawbacks to running our tests this way but we will leave those for later, too


Introduction
Last time we added a nice unit test and then set up CMake to build it, of course, and add it to the list of tests that CTest will run. This is great, now we can run cmake then use make and make test to test our project. Now it’s time to build on our success because we certainly aren’t done yet.

The main problem we need to tackle is that there are currently 3 steps to creating a test program:

add the executable target
link the executable against the “gmock_main” library
add the test to CTest’s list of tests
That’s 3 steps too many. If you are thinking that 3 steps aren’t too many remember that any project of a useful size will have a rather large number of unit tests, each of which will require these same 3 steps – that’s a lot of repetition. As programmers we should not repeat ourselves, and we shouldn’t slack off just because we are merely setting up our build system. What we want is the ability to add a new test in a single step. Writing the test is hard enough, building and running it should be easy.

Lucky for us CMake offers the ability to write functions. So we will start by writing a function that combines these 3 steps so that only one step will be needed. Once we have the function we will improve it further taking advantage of the fact that we will only have to write said improvements once.

A Simple Function
We have 3 simple steps to encapsulate in a function, that should be simple, right?

ToDoCore/unit_test/CMakeLists.txtNew or modified lines in bold.
set(GMOCK_DIR "../../../../../gmock/gmock-1.6.0"
    CACHE PATH "The path to the GoogleMock test framework.")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # force this option to ON so that Google Test will use /MD instead of /MT
    # /MD is now the default for Visual Studio, so it should be our default, too
    option(gtest_force_shared_crt
           "Use shared (DLL) run-time lib even when Google Test is built as static lib."
           ON)
elseif (APPLE)
    add_definitions(-DGTEST_USE_OWN_TR1_TUPLE=1)
endif()
add_subdirectory(${GMOCK_DIR} ${CMAKE_BINARY_DIR}/gmock)
set_property(TARGET gtest APPEND_STRING PROPERTY COMPILE_FLAGS " -w")

include_directories(SYSTEM ${GMOCK_DIR}/gtest/include
                           ${GMOCK_DIR}/include)


#
# add_gmock_test(<target> <sources>...)
#
#  Adds a Google Mock based test executable, <target>, built from <sources> and
#  adds the test so that CTest will run it. Both the executable and the test
#  will be named <target>.
#
function(add_gmock_test target)
    add_executable(${target} ${ARGN})
    target_link_libraries(${target} gmock_main)

    add_test(${target} ${target})
endfunction()


add_gmock_test(ToDoTest ToDoTest.cc)
target_link_libraries(ToDoTest toDoCore)
[zip file] Source
I like to put comments before my functions that show how they should be called and explain what they do.
function(add_gmock_test target)
Start the definition of the function add_gmock_test with one required parameter target.
Inside the function its first argument is available as the variable target and the rest of the arguments are available in a list stored in the variable ARGN. CMake will allow you to pass more arguments to a function than the number of parameters it defined. It is up to the writer of the function to handle all of them, validate them and produce an error if they aren’t correct, or merely ignore them. In this case we are just passing them all on to the command add_executable().
Also available is the variable ARGC which holds the count of all arguments passed to the function, both ones matching parameters and any extras. Additionally each argument can be accessed via the variables ARGV0, ARGV1, … ARGVN. As if that weren’t enough ways to access function arguments all arguments are also available as a list stored in the variable ARGV. This affords a lot of flexibility but can make argument validation and handling difficult.
function() documentation (2013-06-01)
endfunction()
Ends the definition of a function. As I’ve said before CMake’s syntax is a bit strange. You can pass the name of the function as an argument to this command, but it is not required. If you do it should match otherwise CMake will print a warning when configuring. I think it’s easier to read if no arguments are passed to endfunction() and functions shouldn’t be long enough that a reminder of what function is being ended is needed.
endfunction() documentation (2013-06-01)
add_gmock_test(ToDoTest ToDoTest.cc)
Now we use the function we just wrote to add our Google Mock based test. With the function written it is now much simpler as we don’t need to write out the three separate commands every time.
target_link_libraries(ToDoTest toDoCore)
We still have to link our test with the “toDoCore” library. Since this is specific to this test and not all tests it wouldn’t make sense to include this in our function.
Commands and Functions and Macros! Oh my!
So far we have seen several CMake commands and now even written a function! You may wonder what the difference is between a command and a function. Simply put commands are built into CMake and functions are written using CMake’s language. While some commands behave quite similarly to functions, e.g. add_executable, some others behave in ways that cannot be mimicked using functions or macros, e.g. if() and function().

Macros, on the other hand, are similar to functions in that they are written the same and offer all of the same ways for accessing arguments. However, macros don’t have their own scope and rather than dereferencing arguments when run arguments are replaced instead. The first difference is what makes macros both useful and dangerous, the second is more subtle and can make working with lists difficult. (Yes, I know. I haven’t talked about lists yet.)

You can’t add commands, but you can create functions and macros. As a rule of thumb do not use a macro unless absolutely necessary, then you will avoid many problems.

Scope
Scope is interesting in CMake and can occasionally be confusing. There’s local scope, directory scope, global scope, and cache scope. As with most languages things are inherited from enclosing scopes. For example if you were to set someVariable to “some value” and then call someFunction() inside the function dereferencing someVariable would yield “some value”.

Local Scope
This refers to the most narrow scope at a given location. So the current function or directory if not inside a function. Note that conditionals, loops, and macros do not create a new scope, which is important to remember. When you set a variable this is the scope that is affected.

Parent Scope
The scope enclosing the current local scope. For example the scope that called the current function or the directory that executed the most recent add_subdirectory() command. This is important because the set() command can be used to set variables in the parent scope. In fact this is the only way to return values from a function.

set(variable values… PARENT_SCOPE)

set() documentation (2013-06-01)

Directory Scope
This is the scope of the current directory being processed by CMake which is used by directory properties and macros. The confusing thing is that some commands affect directory properties, such as add_definitions() and remove_definitions(). Many of these properties affect the targets created within this directory scope but only take effect when generating. So if you create a target and then use the add_definitions() command those definitions will apply to the target created previously. It is less confusing if things that affect directory scope are done before creating any targets in that directory. Also do not mix setting directory properties and creating targets inside a function, either use separate functions or set the corresponding target property.

Global Scope
As expected anything defined with global scope is accessible from within any local scope. Targets, functions, and global properties all have global scope. For this reason all targets must have unique names. (Strictly speaking this isn’t true, however not all generators can handle multiple targets with the same name. For maximum compatibility it is best to ensure all targets have unique names.) Functions, on the other hand, can be redefined at will, but that is generally not a good idea.

Cache Scope
This is similar to global scope, however only variables can be stored in the cache. In addition the cache persists between CMake configure runs. As we have already seen some cached variables can also be edited using the CMake GUI or the ccmake tool.

Let’s Include Some Organization
There’s two issues with what we have now. First we’ve combined settings and functions for unit testing as well as an actual target. Second burying the inclusion of Google Mock this deep in our project makes it difficult to use a relative path. If you were to set the path to Google Mock on the command line using cmake -DGMOCK_DIR=somePath you would expect the path to be relative to the top project directory rather than two directories deeper. We can fix both of these problems at the same time.

We will refactor the code related to Google Mock into a separate file. Which will resolve problem one. Then we will include our new file from the top CMakeLists.txt file, which will address problem two. The question is where to put this new file and what to call it? In CMake files like these are called modules. Cmake comes with many which are stored in a directory called “Modules”. Many software projects, on the other hand, store CMake related code in a directory called “cmake”, a logical name, sometimes this is done out of necessity (e.g. if using ClearCase). I think we shall put the file in cmake/Modules. As for the name since we consistently used gmock or GMOCK let’s go with gmock.cmake.

cmake/Modules/gmock.cmake
set(GMOCK_DIR "../../../gmock/gmock-1.6.0"
    CACHE PATH "The path to the GoogleMock test framework.")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # force this option to ON so that Google Test will use /MD instead of /MT
    # /MD is now the default for Visual Studio, so it should be our default, too
    option(gtest_force_shared_crt
           "Use shared (DLL) run-time lib even when Google Test is built as static lib."
           ON)
elseif (APPLE)
    add_definitions(-DGTEST_USE_OWN_TR1_TUPLE=1)
endif()
add_subdirectory(${GMOCK_DIR} ${CMAKE_BINARY_DIR}/gmock)
set_property(TARGET gtest APPEND_STRING PROPERTY COMPILE_FLAGS " -w")

include_directories(SYSTEM ${GMOCK_DIR}/gtest/include
                           ${GMOCK_DIR}/include)


#
# add_gmock_test(<target> <sources>...)
#
#  Adds a Google Mock based test executable, <target>, built from <sources> and
#  adds the test so that CTest will run it. Both the executable and the test
#  will be named <target>.
#
function(add_gmock_test target)
    add_executable(${target} ${ARGN})
    target_link_libraries(${target} gmock_main)

    add_test(${target} ${target})

endfunction()
If you look closely the only change to this code you’ll notice is that the default value for GMOCK_DIR has two fewer parent directories in it. It is now relative to the top of our project as one would expect.

CMakeLists.txtNew or modified lines in bold.
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
set(CMAKE_LEGACY_CYGWIN_WIN32 0)

project("To Do List")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

enable_testing()
include(gmock)


if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" OR
    "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(warnings "-Wall -Wextra -Werror")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(warnings "/W4 /WX /EHsc")
endif()
if (NOT CONFIGURED_ONCE)
    set(CMAKE_CXX_FLAGS "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
    set(CMAKE_C_FLAGS   "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
endif()


include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(ToDoCore)

add_executable(toDo main.cc)
target_link_libraries(toDo toDoCore)


set(CONFIGURED_ONCE TRUE CACHE INTERNAL
    "A flag showing that CMake has configured at least once.")
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)
Lists, finally! Okay not quite yet. Here we append the “Modules” directory we created to CMake’s module path. This is the path CMake searches when you include a module.
We set the include path because, in the future, we might want to include modules from other CMakeLists.txt in other directories. This allows us to include them without having to specify the full path every time.
include(gmock)
This includes the new module we created. When used this way CMake searches the module path for the file gmock.cmake and when it finds the file it is included. These includes are much like those done by the C preprocessor. The code in the included file executes in the same scope as the file that included it.
list(APPEND list elements…)
Appends the elements to the list stored in the variable named list. That’s correct, you pass in the name of the list to be updated, you do not dereference it.
list() documentation (2013-06-04)
CMAKE_MODULE_PATH
When including modules CMake searches for the requested module in the paths in this list. If this list is exhausted then CMake will look in the directory containing the default modules that come with CMake. Because these paths need to work anywhere in the build tree they must be absolute paths. Since this is a list the list() command should be used to manipulate it.
CMAKE_MODULE_PATH documentation (2013-06-04)
include(module | file)
Include the module or file in the current file being processed. If a module name is provided CMake will search for the file module.cmake and included it if found. Alternatively if a file name is provided CMake will include that file directly; no module path searching is required. If the file cannot be included either because it doesn’t exist or wasn’t found CMake will issue a warning, but will continue processing.
include() documentation (2013-06-04)
ToDoCore/unit_test/CMakeLists.txt
add_gmock_test(ToDoTest ToDoTest.cc)
target_link_libraries(ToDoTest toDoCore)
This file has gone on a serious diet. After moving all general code for unit testing with Google Mock into gmock.cmake this file became quite simple.

[zip file] Source
Lists!
At long last! You’ve been teased by lists for 2 chapters now, and most of this one too. It is high time we discussed lists.

CMake has two data structures built in: strings and lists. Well, strictly speaking that isn’t completely true; lists are semicolon delimited strings. So an empty string is also an empty list and a regular string is a list with only one item. The simplest way to make a list is set(myList a b c) which is exactly the same as set(myList a;b;c). However set(myList "a;b;c") creates a list with just one item. If a string begins with " it is treated as a string literal and any spaces or quotes remain a part of that string rather than causing it to be split into several list items.

Lists are important to understand not just because they are useful but also because all arguments to commands, functions, and macros are processed as a list. So just as set(myList a b c) is the same as set(myList a;b;c) so too is set(myList;a;b;c). When CMake processes the call to the set() command it collects all of the arguments into a single list. This list (ARGV) is the separated into the first argument, the variable name (myList), and the rest of the items, the values (a;b;c). This can cause trouble if you pass a quoted string containing semicolons to a function that then passes it to another function without quoting it as your string will become a list.

While you can create list with set(myList a b c) I’d strongly recommend using list(APPEND myList a b c). Using the list() command shows that you are using the variable myList as a list. Naturally the list() command allows you to do other things with lists.

list() documentation (2013-06-04)

Auto Play
Well really automatic test running. So far in my experience it takes significantly less time to run unit tests than it does to build them. For this reason I think it is beneficial to run your unit tests every time they are built. This also has the side effect of stopping your build if the unit test fails.

cmake/Modules/gmock.cmakeNew or modified lines in bold.
set(GMOCK_DIR "../../../gmock/gmock-1.6.0"
    CACHE PATH "The path to the GoogleMock test framework.")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # force this option to ON so that Google Test will use /MD instead of /MT
    # /MD is now the default for Visual Studio, so it should be our default, too
    option(gtest_force_shared_crt
           "Use shared (DLL) run-time lib even when Google Test is built as static lib."
           ON)
elseif (APPLE)
    add_definitions(-DGTEST_USE_OWN_TR1_TUPLE=1)
endif()
add_subdirectory(${GMOCK_DIR} ${CMAKE_BINARY_DIR}/gmock)
set_property(TARGET gtest APPEND_STRING PROPERTY COMPILE_FLAGS " -w")

include_directories(SYSTEM ${GMOCK_DIR}/gtest/include
                           ${GMOCK_DIR}/include)


#
# add_gmock_test(<target> <sources>...)
#
#  Adds a Google Mock based test executable, <target>, built from <sources> and
#  adds the test so that CTest will run it. Both the executable and the test
#  will be named <target>.
#
function(add_gmock_test target)
    add_executable(${target} ${ARGN})
    target_link_libraries(${target} gmock_main)

    add_test(${target} ${target})

    add_custom_command(TARGET ${target}
                       POST_BUILD
                       COMMAND ${target}
                       WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                       COMMENT "Running ${target}" VERBATIM)
endfunction()
[zip file] Source
add_custom_command(TARGET ${target}
                   POST_BUILD
                   COMMAND ./${target}
                   WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                   COMMENT "Running ${target}" VERBATIM)
We use the add_custom_command() command to run each test after each time it is built. Here we simply run the test and if it fails the build will stop. However if you were to build again immediately the failed test would not be run again and the build will continue. Fixing that will be left for later.
add_custom_command(TARGET target
                   PRE_BUILD | PRE_LINK | POST_BUILD
                   COMMAND command arguments…
                   COMMAND command2 arguments… …
                   WORKING_DIRECTORY directory
                   COMMENT comment VERBATIM)
target
The name of the target to which we are adding the custom command.
PRE_BUILD | PRE_LINK | POST_BUILD
When to run the custom command. PRE_BUILD will run the command before any of the target’s other dependencies. PRE_LINK runs the command after all other dependencies. Lastly POST_BUILD runs the command after the target has been built.
Note: the PRE_BUILD option only works with Visual Studio 7 or newer. For all other generators it is treated as PRE_LINK instead.
COMMAND command arguments…
The command to run and any arguments to be passed to it. If command specifies an executable target, i.e. one created with the add_executable() command, the location of the actual built executable will replace the name; additionally a target level dependency will be added so that the executable target will be built before this custom command is run.
Note: target level dependencies merely control the order in which targets are build. If a target level dependency is rebuilt this command will not be re-run.
Any number of commands can be listed using this syntax and they will all be run in order each time.
 WORKING_DIRECTORY directory
Specify the working directory from which the listed commands will be run.
 COMMENT comment
Provide a comment that will be displayed before the listed commands are run.
 VERBATIM
This argument tells CMake to ensure that the commands and their arguments are escaped appropriately for whichever build tool is being used. If this argument is omitted the behavior is platform and tool specific. Therefore it is strongly recommended that you always provide the VERBATIM argument.
add_custom_command() documentation (2013-06-15)


Introduction
So far our project is rather simple. A real project would be more complicated than the one we’ve created. Let’s add subdirectories, libraries, and proper unit tests to make our project more realistic.

In this chapter we will split up our project to have a library which we can put in a subdirectory. Then we will use Google Test and Google Mock to add a more realistic unit test.

The Library in a Subdirectory
We will make the ToDo class its own library, and put it in a subdirectory. Even though it is a single source file making it a library actually has one significant advantage. CMake will compile source files once for each target that includes them. So if the ToDo class is used by our command line tool, a unit test, and perhaps a GUI App it would be compiled three times. Imagine if we had a collection of classes instead of just one. This results in a lot of unnecessary compilation.

There were some minor changes to the C++, grab the files here: [zip file] Source
(CMakeLists.txt listed below)

CMakeLists.txtNew or modified lines in bold.
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
set(CMAKE_LEGACY_CYGWIN_WIN32 0)

project("To Do List")

enable_testing()


if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" OR
    "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(warnings "-Wall -Wextra -Werror")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(warnings "/W4 /WX /EHsc")
endif()
if (NOT CONFIGURED_ONCE)
    set(CMAKE_CXX_FLAGS "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
    set(CMAKE_C_FLAGS   "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
endif()


include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(ToDoCore)

add_executable(toDo main.cc)
target_link_libraries(toDo toDoCore)

add_test(toDoTest toDo)


set(CONFIGURED_ONCE TRUE CACHE INTERNAL
    "A flag showing that CMake has configured at least once.")
So now our executable “toDo” only depends on the file “main.cc” and the new library “toDoCore”. Our project also has a new subdirectory “ToDoCore”.

include_directories(directories)
Add directories to the end of this directory’s include paths. We didn’t need this before because all of our files were in the same directory.
include_directories() documentation (2013-04-20)
CMAKE_CURRENT_SOURCE_DIR
The full path to the source directory that CMake is currently processing.
CMAKE_CURRENT_SOURCE_DIR documentation (2013-04-20)
add_subdirectory(source_dir)
Include the directory source_dir in your project. This directory must contain a CMakeLists.txt file.
Note: We’re omitting the optional second parameter. This only works with subdirectories of the current directory. We will see how to add external directories later.
add_subdirectory documentation (2013-04-20)
target_link_libraries(target library…)
Specify that target needs to be linked against one or more libraries. If a library name matches another target dependencies are setup automatically so that the libraries will be built first and target will be updated whenever any of the libraries are.
If the target is an executable then it will be linked against the listed libraries.
If the target is a library then its dependency on these libraries will be recorded. Then when something else links against target it will also link against target‘s dependencies. This makes it much easier to handle a library’s dependencies since you only have to define them once when you define library itself.
For the moment we are using the simplest form of this command. For more information see the documentation (2013-04-20).
When describing add_subdirectory() I stated that the subdirectory must contain a CMakeLists.txt file. So here’s the new file.

ToDoCore/CMakeLists.txt
add_library(toDoCore ToDo.cc)
Conveniently this file is rather simple.

add_library(target STATIC | SHARED | MODULE sources…)
This command creates a new library target built from sources. As you may have noticed this command is very similar to add_executable.
With STATIC, SHARED, and MODULE you can specify what kind of library to build. STATIC libraries are archives of object files that are linked directly into other targets. SHARED libraries are linked dynamically and loaded at runtime. MODULE libraries are plug-ins that aren’t linked against but can be loaded dynamically at runtime.
If the library type is not specified it will be either STATIC or SHARED. The default type is controlled by the BUILD_SHARED_LIBS variable. By default static libraries are created.
add_library() documentation (2013-04-20)
Testing – for Real
We have a rudimentary test but if we were really developing software we’d write a real test using a real testing framework. As mentioned earlier we will use Google Test 1.6.0 and Google Mock 1.6.0. Conveniently they include their own CMakeLists.txt files, which makes them easy for us to use.

First the test:

ToDoCore/unit_test/ToDoTest.cc
#include "ToDoCore/ToDo.h"

#include <string>
  using std::string;

#include <gmock/gmock.h>
  using ::testing::Eq;
#include <gtest/gtest.h>
  using ::testing::Test;


namespace ToDoCore
{
namespace testing
{
    class ToDoTest : public Test
    {
    protected:
        ToDoTest(){}
        ~ToDoTest(){}

        virtual void SetUp(){}
        virtual void TearDown(){}


        ToDo list;

        static const size_t taskCount = 3;
        static const string tasks[taskCount];
    };

    const string ToDoTest::tasks[taskCount] = {"write code",
                                               "compile",
                                               "test"};


    TEST_F(ToDoTest, constructor_createsEmptyList)
    {
        EXPECT_THAT(list.size(), Eq(size_t(0)));
    }

    TEST_F(ToDoTest, addTask_threeTimes_sizeIsThree)
    {
        list.addTask(tasks[0]);
        list.addTask(tasks[1]);
        list.addTask(tasks[2]);

        EXPECT_THAT(list.size(), Eq(taskCount));
    }

    TEST_F(ToDoTest, getTask_withOneTask_returnsCorrectString)
    {
        list.addTask(tasks[0]);

        ASSERT_THAT(list.size(),     Eq(size_t(1)));
        EXPECT_THAT(list.getTask(0), Eq(tasks[0]));
    }

    TEST_F(ToDoTest, getTask_withThreeTasts_returnsCorrectStringForEachIndex)
    {
        list.addTask(tasks[0]);
        list.addTask(tasks[1]);
        list.addTask(tasks[2]);

        ASSERT_THAT(list.size(),     Eq(taskCount));
        EXPECT_THAT(list.getTask(0), Eq(tasks[0]));
        EXPECT_THAT(list.getTask(1), Eq(tasks[1]));
        EXPECT_THAT(list.getTask(2), Eq(tasks[2]));
    }

} // namespace testing
} // namespace ToDoCore
This is a rather simple test, but ToDo is still a rather simple class. It may look strange if you are unfamiliar with Google Test, taking a look at Google Test Primer may be helpful. I also use a little functionality from Google Mock so Google Mock for Dummies may also be useful.

Now we need to build the test:

ToDoCore/CMakeLists.txtNew or modified lines in bold.
add_library(toDoCore ToDo.cc)

add_subdirectory(unit_test)
ToDoCore/unit_test/CMakeLists.txt
set(GMOCK_DIR "../../../../../gmock/gmock-1.6.0"
    CACHE PATH "The path to the GoogleMock test framework.")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # force this option to ON so that Google Test will use /MD instead of /MT
    # /MD is now the default for Visual Studio, so it should be our default, too
    option(gtest_force_shared_crt
           "Use shared (DLL) run-time lib even when Google Test is built as static lib."
           ON)
elseif (APPLE)
    add_definitions(-DGTEST_USE_OWN_TR1_TUPLE=1)
endif()
add_subdirectory(${GMOCK_DIR} ${CMAKE_BINARY_DIR}/gmock)

include_directories(SYSTEM ${GMOCK_DIR}/gtest/include
                           ${GMOCK_DIR}/include)


add_executable(ToDoTest ToDoTest.cc)
target_link_libraries(ToDoTest toDoCore
                               gmock_main)

add_test(ToDoTest ToDoTest)
First we add the Google Mock directory to our project then we add our test. The path to Google Mock is stored in a cached variable so that you can easily set it to the correct value either from the command line or via one of the GUIs. There are several potential problems with that line but we will worry about those later, for now it’s good enough. Okay I oversimplified a little. We don’t just add the Google Mock directory, we also work around some OS-specific problems.

When using Visual Studio to build our test we would run into a problem. Even when building static libraries, CMake’s default, MSVC defaults to linking against the multi-threaded, DLL-specific version of the standard library. By default Google Test overrides this so that the non-DLL version of the multi-threaded standard library is used. Then when our test links against both toDoCore and gmock_main the linker will output a large number of errors since we would be linking against two different copies of the standard library. To avoid this problem we force Google Test to use the DLL-specific version to match Visual Studio’s default by setting the gtest_force_shared_crt option to ON. See Microsoft C/C++ Compiler Run-Time Library.

The second problem occurs on newer version of Mac OS X which default to using a different standard library that fully supports C++11. GTest uses the tuple class from the draft TR1 standard and therefore looks for it in the std::tr1 namespace. The tr1 namespace is not present in the C++11 standard library that Apple uses so GTest cannot find it and won’t compile. We fix this by telling GTest to use its own tuple implementation.

add_subdirectory(source_dir binary_dir)
Add the directory source_dir to the current project with binary_dir as its corresponding binary output directory. When adding a directory that is a subdirectory of the current directory CMake will automatically determine what the binary output directory should be, making the second argument optional. However if you add a directory that isn’t a subdirectory you need to specify the binary output directory.
add_subdirectory documentation (2013-04-20)
CMAKE_BINARY_DIR
This variable holds the path to the top level binary output directory, i.e. the directory in which you ran the cmake command or the path you chose for “Where to build the binaries” in the GUI.
CMAKE_BINARY_DIR documentation (2013-04-27)
include_directories(AFTER|BEFORE SYSTEM directory…)
AFTER|BEFORE
Specify whether or not these include directories should be appended or prepended to the list of include directories. If omitted then the default behavior is used.
By default directories are appended to the list. This behavior can be changed by setting CMAKE_INCLUDE_DIRECTORIES_BEFORE to TRUE.
SYSTEM
Specify that these directories are system include directories. This only has an affect on compilers that support the distinction. This can change the order in which the compiler searches include directories or the handling of warnings from headers found in these directories.
directory…
The directories to be added to the list of include directories.
include_directories() documentation (2013-04-20)
option(name docstring initialValue)
Provide a boolean option to the user. This will be displayed in the GUI as a checkbox. Once created the value of the option can be accessed as the variable name. The docstring will be displayed in the GUI to tell the user what this option does. If no initial value is provided it defaults to OFF.
While this boolean option is stored in the cache and accessible as a variable you cannot override the initialValue by setting a variable of the same name beforehand, not even by passing a -D command line option to CMake. Which is why we have to define the option ourselves before Google Test does.
option() documentation (2013-05-3)
add_definitions(flags…)
Add preprocessor definitions to the compiler command line for targets in the current directory and those below it. While this command is intended for adding definitions you still need to precede them with -D.
Because this command modifies the COMPILE_DEFINITIONS directory property it affects all targets in the directory, even those that were defined before this command was used. If this is not the desired effect then modifying the COMPILE_DEFINITIONS property of particular targets or source files will work better. (Properties are introduced below.)
add_definitions() documentation (2014-09-28)
COMPILE_DEFINITIONS directory property documentation (2014-09-28)
COMPILE_DEFINITIONS target property documentation (2014-09-28)
COMPILE_DEFINITIONS source file property documentation (2014-09-28)
Let’s go ahead and try out our new test!
[zip file] Source

 > mkdir build
 > cd build
 > cmake -G "Unix Makefiles" ..
-- The C compiler identification is Clang 4.2.0
-- The CXX compiler identification is Clang 4.2.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Found PythonInterp: /usr/local/bin/python (found version "2.7.3")
-- Looking for include file pthread.h
-- Looking for include file pthread.h - found
-- Looking for pthread_create
-- Looking for pthread_create - found
-- Found Threads: TRUE
-- Configuring done
-- Generating done
-- Build files have been written to: /Documents/Programming/C++/CMake Tutorial/flavors/part4_step2/build
 > make
Scanning dependencies of target toDoCore
[ 14%] Building CXX object ToDoCore/CMakeFiles/toDoCore.dir/ToDo.cc.o
Linking CXX static library libtoDoCore.a
[ 14%] Built target toDoCore
Scanning dependencies of target toDo
[ 28%] Building CXX object CMakeFiles/toDo.dir/main.cc.o
Linking CXX executable toDo
[ 28%] Built target toDo
Scanning dependencies of target gtest
[ 42%] Building CXX object gmock/gtest/CMakeFiles/gtest.dir/src/gtest-all.cc.o
In file included from /Documents/Programming/C++/gmock/gmock-1.6.0/gtest/src/gtest-all.cc:42:
In file included from /Documents/Programming/C++/gmock/gmock-1.6.0/gtest/src/gtest.cc:132:
/Documents/Programming/C++/gmock/gmock-1.6.0/gtest/src/gtest-internal-inl.h:206:8: error:
      private field 'pretty_' is not used [-Werror,-Wunused-private-field]
  bool pretty_;
       ^
1 error generated.
make[2]: *** [gmock/gtest/CMakeFiles/gtest.dir/src/gtest-all.cc.o] Error 1
make[1]: *** [gmock/gtest/CMakeFiles/gtest.dir/all] Error 2
make: *** [all] Error 2
Oh noes! Newer versions of Clang have some pretty strict warnings and we have just run afoul of one. So we have a problem: we want to use strict compiler settings to ensure we write good code but we also don’t want to go changing Google Test. As it turns out CMake actually provides us the flexibility we need to disable warnings for just the gtest target.

This is a capability that can easily be abused. In the case of Google Test we didn’t write it and we know, or at least assume, that it works fine. Because of that we don’t care about any warnings we might find in Google Test’s code. We need to be careful not to use this feature to allow ourselves to write poor code.

ToDoCore/unit_test/CMakeLists.txtNew or modified lines in bold.
set(GMOCK_DIR "../../../../../gmock/gmock-1.6.0"
    CACHE PATH "The path to the GoogleMock test framework.")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # force this option to ON so that Google Test will use /MD instead of /MT
    # /MD is now the default for Visual Studio, so it should be our default, too
    option(gtest_force_shared_crt
           "Use shared (DLL) run-time lib even when Google Test is built as static lib."
           ON)
elseif (APPLE)
    add_definitions(-DGTEST_USE_OWN_TR1_TUPLE=1)
endif()
add_subdirectory(${GMOCK_DIR} ${CMAKE_BINARY_DIR}/gmock)
set_property(TARGET gtest APPEND_STRING PROPERTY COMPILE_FLAGS " -w")

include_directories(SYSTEM ${GMOCK_DIR}/gtest/include
                           ${GMOCK_DIR}/include)


add_executable(ToDoTest ToDoTest.cc)
target_link_libraries(ToDoTest toDoCore
                               gmock_main)

add_test(ToDoTest ToDoTest)
set_property(TARGET gtest APPEND_STRING PROPERTY COMPILE_FLAGS ” -w”)
There are a variety of things that have properties in CMake, in this case we are interested in a target’s properties. Each target can have it’s own compiler flags in addition the ones set in CMAKE_<LANG>_FLAGS. Here we append “ -w” to gtest‘s COMPILE_FLAGS. The flag “-w” disables all warnings for both GCC and Clang. When compiling with MSVC the “-w” will be automatically converted to “/w” which has the same function. (Although it will warn that “/w” is overriding “/W4“)
COMPILE_FLAGS documentation (2013-04-28)
GCC Warning Options (2013-04-28), currently these work for Clang too.
Microsoft C/C++ Compiler Warning Level (2013-04-28)
set_property(TARGET target_name… APPEND|APPEND_STRING PROPERTY name value…)
TARGET
Specify that we want to set the property of a target. Several other types of things have properties you can set. For the moment we are only going to deal with targets, but the concept is the same for the rest.
target_name…
The name of the target whose property you want to set. You can list multiple targets and all will have the property set the same way for each.
 APPEND | APPEND_STRING
Append to the property’s existing value instead of setting it. APPEND appends to the property as a list. APPEND_STRING appends to the property as a string.
Note: Do not provide a multiple values when using APPEND_STRING as the results will not be what you expect.
Don’t worry about lists we will cover them in the next chapter.
PROPERTY
name
The name of the property you want to set. See Properties on Targets.
value…
The value to set for the property. If multiple values are provided they are treated as a list. Only provide one value if also using APPEND_STRING.
Don’t worry about lists yet.
set_property() documentation (2013-04-28)

Introduction
Now that we have our testing simplified and automated we have a great foundation upon which to build our amazing command line To Do list app. What’s that? You say that an awesome To Do app allows you to add items to your list? Indeed it does, and more! But wait, let’s not get ahead of ourselves. We need to be able to accept and parse command line options if this app is to be of any use at all.

I know what you are thinking now: parsing command line options is a drag and who likes parsing stuff anyway? Well we are in luck as the Boost Program Options library will do all the hard work for us. All we need to do is rewrite our main function to be something useful, let the library do the parsing and our app will be on it’s way to the top 10 list. Okay, I might be exaggerating that last one.

Boosting the Command Line
Okay, that section title may be a little over the top. Our main function has languished while we set up testing and streamlined our CMake. Now it’s time to turn attention back to it and what we find is that it needs to be gutted and re-done, much like an old kitchen. Since we have better tests we don’t need the one in main anymore. We will update main to have two command line options: --add, which will add a new entry to the to do list, and --help, which will do what you’d expect.

main.cc
#include <iostream>
  using std::cerr;
  using std::cout;
  using std::endl;
#include <string>
  using std::string;

#include <boost/program_options.hpp>
  namespace po = boost::program_options;

#include "ToDoCore/ToDo.h"
  using ToDoCore::ToDo;

int main(
    int    argc,
    char** argv
)
{
    po::options_description desc("Options");
    desc.add_options()
        ("help,h", "display this help")
        ("add,a", po::value< string >(), "add a new entry to the To Do list")
        ;

    bool parseError = false;
    po::variables_map vm;
    try
    {
        po::store(po::parse_command_line(argc, argv, desc), vm);
        po::notify(vm);
    }
    catch (po::error& error)
    {
        cerr << "Error: " << error.what() << "\n" << endl;
        parseError = true;
    }

    if (parseError || vm.count("help"))
    {
        cout << "todo:  A simple To Do list program" << "\n";
        cout                                         << "\n";
        cout << "Usage:"                             << "\n";
        cout << "  " << argv[0] << " [options]"      << "\n";
        cout                                         << "\n";
        cout << desc                                 << "\n";

        if (parseError)
        {
            return 64;
        }
        else
        {
            return 0;
        }
    }


    ToDo list;

    list.addTask("write code");
    list.addTask("compile");
    list.addTask("test");

    if (vm.count("add"))
    {
        list.addTask(vm["add"].as< string >());
    }

    for (size_t i = 0; i < list.size(); ++i)
    {
        cout << list.getTask(i) << "\n";
    }
    return 0;
}
Boost Program Options makes it easier to parse command line options than it would be to do it by hand. Now that we have the required --help option and the --add our app is a bit more useful.

There’s a new problem now. How will we link our app against Boost? As it turns out CMake has a command for finding things like Boost: the find_package() command. Let’s see how it works.

CMakeLists.txtNew or modified lines in bold.
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
set(CMAKE_LEGACY_CYGWIN_WIN32 0)

project("To Do List")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

enable_testing()
include(gmock)


if (NOT DEFINED     BOOST_ROOT        AND
    NOT DEFINED ENV{BOOST_ROOT}       AND
    NOT DEFINED     BOOST_INCLUDEDIR  AND
    NOT DEFINED ENV{BOOST_INCLUDEDIR} AND
    NOT DEFINED     BOOST_LIBRARYDIR  AND
    NOT DEFINED ENV{BOOST_LIBRARYDIR})
    if (APPLE)
        set(BOOST_ROOT "../../../boost/boost_1_54_0/mac")
    elseif (WIN32)
        set(BOOST_INCLUDEDIR "C:/local/boost_1_55_0")
        set(BOOST_LIBRARYDIR "C:/local/boost_1_55_0/lib32-msvc-10.0")
    endif()
endif()
if (APPLE OR WIN32)
    set(Boost_USE_STATIC_LIBS TRUE)
endif()
find_package(Boost 1.32 REQUIRED COMPONENTS program_options)
include_directories(SYSTEM ${Boost_INCLUDE_DIRS})

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" OR
    "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(warnings "-Wall -Wextra -Werror")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(warnings "/W4 /wd4512 /WX /EHsc")
        # Disabled Warnings:
        #   4512 "assignment operator could not be generated"
        #        This warning provides no useful information and will occur in
        #        well formed programs.
        #        <http://msdn.microsoft.com/en-us/library/hsyx7kbz.aspx>
endif()
if (NOT CONFIGURED_ONCE)
    set(CMAKE_CXX_FLAGS "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
    set(CMAKE_C_FLAGS   "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
endif()


include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(ToDoCore)

add_executable(toDo main.cc)
target_link_libraries(toDo toDoCore ${Boost_LIBRARIES})


set(CONFIGURED_ONCE TRUE CACHE INTERNAL
    "A flag showing that CMake has configured at least once.")
[zip file] Source
find_package(Boost 1.32 REQUIRED COMPONENTS program_options)
This command searches for Boost, both the headers and the boost_program_options library, and then defines variables that indicate whether or not Boost has been found and if so describe the locations of the libraries and header files.
include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
Add the paths to Boost’s include files to the compiler’s include search paths.
By using the SYSTEM argument CMake will tell the compiler, if possible, that these paths contain system include files. Oftentimes the compiler will ignore warnings from files found in system include paths.
The SYSTEM option does not have an effect with all generators. When using the Visual Studio 10 or the Xcode generators neither Visual Studio nor Xcode appear to treat system include paths any differently than regular include paths. This can make a big difference when compiler flags are set to treat warnings as errors.
target_link_libraries(toDo ${Boost_LIBRARIES} toDoCore)
This links our little app, toDo, with the Boost libraries. In this case just boost_program_options since that’s the only compiled library we requested. It also links toDo with our toDoCore library. Naturally we need this as that library implements all of our to do list functionality.
find_package(package version EXACT REQUIRED COMPONENTS components…)
package
The name of the package to find, e.g. Boost. This name is case sensitive.
version
The desired version of the package.
EXACT
Match the version of the package exactly instead of accepting a newer version.
REQUIRED
Specifying this option causes CMake’s configure step to fail if the package cannot be found.
COMPONENTS components…
Some libraries, like Boost, have optional components. The find_package() command will only search for these components if they have been listed as arguments when the command is called.
find_package() documentation (2014-11-14)
How to Use FindBoost
We glossed over how to use FindBoost before and actually we glossed over how find_package() really works. Naturally CMake can’t know how to find any arbitrary package. So find_package(), as invoked above, actually loads a CMake Module file called FindBoost.cmake which does the actual work of finding Boost. CMake installations come with a good complement of Find Modules. CMake searches for FindBoost.cmake just as it would any module included using the include() command.

The documentation for it can be obtained using the command cmake --help-module FindBoost.

set(BOOST_ROOT “../../../boost/boost_1_54_0/mac”)
FindBoost uses the value of BOOST_ROOT as a hint for where to look. It will search in BOOST_ROOT as well as the standard places to look for libraries. In this example I did not install Boost in a standard location on my Mac so I needed to tell FindBoost where to look.
set(BOOST_INCLUDEDIR “C:/local/boost_1_55_0”)
If your installation of boost is not stored in the “normal” folders, i.e. include and lib, you will need to specify the directory that contains the include files separately. Since libraries don’t seem to have a standard installation location on Windows as they do on Linux we needed to tell FindBoost where Boost’s header files are. Usually when providing BOOST_INCLUDEDIR BOOST_ROOT isn’t needed. If you are using any of Boost’s compiled libraries you will also need BOOST_LIBRARYDIR.
set(BOOST_LIBRARYDIR “C:/local/boost_1_55_0/lib32-msvc-10.0”)
The same as BOOST_INCLUDEDIR, if specifying BOOST_ROOT doesn’t find the libraries then you will have to specify the BOOST_LIBRARYDIR.
set(Boost_USE_STATIC_LIBS TRUE)
By default FindBoost provides the paths to dynamic libraries, however you can set Boost_USE_STATIC_LIBS to true so that FindBoost will provide the paths to the static libraries instead.
We want to use the static libraries on Mac OS X (APPLE) because when Boost is installed on the Mac the dynamic libraries are not configured properly and our app would not run if we were to link against them.
On Windows we are linking with static libraries so Visual Studio will look for the static Boost libraries. Since FindBoost normally provides the paths to Boost’s dynamic libraries linking would fail. By specifying that we want the static libraries linking will succeed and we can use our new command line arguments.
There are several other variables that affect how FindBoost works, but they aren’t needed as often. Consult the documentation for more information.

FindBoost documentation (2015-03-02)

include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
We add the paths to where the Boost header files are. These assume that your include directives are of the canonical form #include <boost/…>. Boost_INCLUDE_DIRS is set for us by FindBoost.
target_link_libraries(toDo ${Boost_LIBRARIES} toDoCore)
The paths to all of the boost libraries we requested, i.e. program_options, are provided by FindBoost in the variable Boost_LIBRARIES. We simply link against the list of libraries provided.
FindBoost defines several other variables, which are listed in its documentation. The most important one, not used here, is Boost_FOUND. If Boost has been found then Boost_FOUND will be true, otherwise it will be false. Since we specified that Boost was REQUIRED we know that Boost_FOUND must be true otherwise CMake’s configuration step would have failed. If Boost were not REQUIRED then Boost_FOUND would be an extremely important variable.

If we had chosen not to require Boost but not changed anything else in our CMakeLists.txt we would run into trouble if Boost had not been found. You would expect that our code wouldn’t compile because an include file could not be found. As it turns out you won’t actually get that far. FindBoost will set Boost_INCLUDE_DIRS to a value indicating that Boost was not found. Because of this the CMake configure step will fail because we use that variable as an include directory. Since CMake checks this for us we need to remember to be careful when using optional packages.

Choosing a Root
Typically BOOST_ROOT should be the directory that contains the include and lib directories in which you will find boost. Remember the boost headers will be inside a boost directory. As you might notice this is the standard layout used on Unix and Linux. When the headers and libraries are not arranged this way, as is likely on Windows, the BOOST_INCLUDEDIR and BOOST_LIBRARYDIR should be used instead.

So right now you are probably wondering what use FindBoost really is if I had to specify the root, or worse the include and library directories. Well there are a few reasons:

Most importantly if Boost has been installed in a standard location it would have been found without any information being provided.
It will check that the Boost it finds is the desired version, 1.32 or greater in this case. Not all finders actually check version, but when available this feature is very useful as incorrect library versions are caught immediately rather than later through potentially confusing compile errors.
In the case of Boost the finder will ensure the desired libraries are found. Since approximately 90% of the Boost libraries are header only some installs only include the headers and none of the compiled libraries.
Lastly even though I specified my non-standard install locations for Boost in the CMakeLists.txt you needn’t install it there. Regardless FindBoost will still find Boost if you have it installed in a standard location. Additionally you can set your own location using by setting the BOOST_ROOT variable using the -D command line option of cmake or by setting it using the GUI or curses interface. Perhaps most conveniently you can set the BOOST_ROOT environment variable and not need to tell CMake separately. This, of course, applies to the BOOST_INCLUDEDIR and BOOST_LIBRARYDIR variables, too.
So this leaves one question: does it make sense to set BOOST_ROOT in the CMakeLists.txt?

If you are the only one working on the project then it will certainly be easier to set it in the CMakeLists.txt, although you will have to do this for every project. Setting the environmental variable might be easier.

If you work on a team whose development machines are all configured similarly, or should be, then setting BOOST_ROOT in the CMakeLists.txt is a good idea because it simplifies things for most developers and therefore provides and incentive for all developers to use the standard configuration.

Now if you work with a disparate group of people, say on an free/open source project, it makes less sense to set BOOST_ROOT in the CMakeLists.txt as there is likely no notion of a standard development environment.

Finding Packages
Since CMake ships with a reasonable number of Find modules there’s a good chance that whatever you want to find can be found by simply using the find_package command. While you should review the documentation for that particular module there are some variables that you can expect to be defined.

Package_FOUND
This variable indicates whether or not the package has been found.
Package_INCLUDE_DIRS
The include directories for that particular package. This variable should be passed to the include_directories() command.
Package_LIBRARIES
The full paths to this package’s libraries. This variable should be passed to the target_link_libraries() command.
Package_DEFINITIONS
Definitions required to compile code that uses this package. This should be passed to the add_definitions() command.
Documentation Found
As mentioned above you can get the documentation for FindBoost by using the cmake command. While this is somewhat convenient the terminal is not always the best tool for reading documentation. There is a slightly more useful variant of the command: cmake --help-module FindBoost file. This allows you to read the documentation however you please.

There’s another convenient command that will list all of the available modules: cmake --help-modules. This will also provide some documentation for each. Again you can easily save this to a file with the command cmake --help-modules file.

# Specify the minimum version for CMake

cmake_minimum_required(VERSION 2.8)

# Project's name

project(hello)
# Set the output folder where your program will be created
set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/bin)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})

There is a list of CMake’s global varibales. You should know them.

CMAKE_BINARY_DIR

if you are building in-source, this is the same as CMAKE_SOURCE_DIR, otherwise this is the top level directory of your build tree

CMAKE_SOURCE_DIR

this is the directory, from which cmake was started, i.e. the top level source directory

EXECUTABLE_OUTPUT_PATH

set this variable to specify a common place where CMake should put all executable files (instead of CMAKE_CURRENT_BINARY_DIR)

SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
LIBRARY_OUTPUT_PATH

set this variable to specify a common place where CMake should put all libraries (instead of CMAKE_CURRENT_BINARY_DIR)

SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
PROJECT_NAME

the name of the project set by PROJECT() command.

PROJECT_SOURCE_DIR

contains the full path to the root of your project source directory, i.e. to the nearest directory where CMakeLists.txt contains the PROJECT() command Now, you have to compile the test.cpp. The way to do this task is too simple. Add the following line into your CMakeLists.txt:

add_executable(hello ${PROJECT_SOURCE_DIR}/test.cpp)


Build logic and definitions with CMake language is written either in CMakeLists.txt or a file ends with <project_name>.cmake. But as a best practice, main script is named as CMakeLists.txt instead of cmake.
CMakeLists.txt file is placed at the source of the project you want to build.
CMakeLists.txt is placed at the root of the source tree of any application, library it will work for.
If there are multiple modules, and each module can be compiled and built separately, CMakeLists.txt can be inserted into the sub folder.
.cmake files can be used as scripts, which runs cmake command to prepare environment pre-processing or split tasks which can be written outside of CMakeLists.txt.
.cmake files can also define modules for projects. These projects can be separated build processes for libraries or extra methods for complex, multi-module projects.
Writing Makefiles might be harder than writing CMake scripts. CMake scripts by syntax and logic have similarity to high level languages so it makes easier for developers to create their cmake scripts with less effort and without getting lost in Makefiles

CMake Commands

message: prints given message
cmake_minimum_required: sets minimum version of cmake to be used
add_executable: adds executable target with given name
add_library: adds a library target to be build from listed source files
add_subdirectory: adds a subdirectory to build
There are also commands to enable developers write out conditional statements, loops, iterate on list, assignments:
if, endif
elif, endif
while, endwhile
foreach, endforeach
list
return
set_property (assign value to variable.)
Indentation is not mandatory but suggested while writing CMake scripts. CMake doesn’t use ‘;’ to understand end of statement.
All conditional statements should be ended with its corresponding end command (endif, endwhile, endforeachetc)
All these properties of CMake help developers to program complex build processes including multiple modules, libraries and platforms.

CMake Environment Variables

Some of the environment variables are overriden by predefined CMake Variables. e.g. CXXFLAGS is overriden when CMAKE_CXX_FLAGS is defined.
Below is an example use case, when you want to enable all warnings during compile process, you may write -Wall to build command. If you are building your code with CMake, you can add -Wall flag with using set command.
set(CMAKE_CXX_FLAGS "-Wall")
# append flag, best practice, suggested, don't lose previously defined flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

CMake Variables
CMake includes predefined variables which are set by default as location of source tree and system components.
Variables are case-sensitive, not like commands. You can only use alpha numeric chars and underscore, dash (_, -) in definition of variable.

Some of the variables can be seen as below, these are predefined according to root folder:
CMAKE_BINARY_DIR: Full path to top level of build tree and binary output folder, by default it is defined as top level of build tree.
CMAKE_HOME_DIRECTORY: Path to top of source tree
CMAKE_SOURCE_DIR: Full path to top level of source tree.
CMAKE_INCLUDE_PATH: Path used to find file, path
Variable values can be accessed with ${<variable_name>}.
message("CXX Standard: ${CMAKE_CXX_STANDARD}")
set(CMAKE_CXX_STANDARD 14)
Just like above variables, you can define your own variables. You can call set command to set a value to a new variable or change value of existing variable like below:
set(TRIAL_VARIABLE "VALUE")
message("${TRIAL_VARIABLE}")

CMake Lists
All values in CMake are stored as string but a string can be treated as list in certain context.
A list of elements represented as a string by concatenating elements separated by semi-column ‘;’.
set(files a.txt b.txt c.txt)
# sets files to "a.txt;b.txt;c.txt"
In order to access the list of values you can use foreach command of CMake as following:
foreach(file ${files})
    message("Filename: ${file}")
endforeach()

CMake Generator Expressions

If you try to build above code with default settings, you could get an error about auto return type because most hosts configured to work C++99 config by default. Therefore you should point your compiler to build with C++14 with setting CMAKE_CXX_STANDARD variable to 14. If you want to add C++14 on command line, you can set -std=c++14.
CMake generates Makefile with defaults settings which is mostly lower than C++14, so you should add 14 flag as seen below.
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
add_executable(cmake_hello main.cpp)
Now, you should be able to build it correctly. (cmake command would work even though you didn’t add 14 standard but make command would return error.)
CMake eases building process for you; especially when you do cross compile to make sure you are working with correct version of compiler with correct configurations, this will enable multiple developers to use same building configurations across all machines including build server and developer PC

MAKE_SYSTEM
the complete system name, e.g. "Linux-2.4.22", "FreeBSD-5.4-RELEASE" or "Windows 5.1"
CMAKE_SYSTEM_NAME
The name of the system targeted by the build. The three common values are Windows, Darwin, and Linux, though several others exist, such as Android, FreeBSD, and CrayLinuxEnvironment. Platforms without an operating system, such as embedded devices, are given Generic as a system name.
CMAKE_SYSTEM_VERSION
Version of the operating system. Generally the kernel version.
CMAKE_SYSTEM_PROCESSOR
the processor name (e.g. "Intel(R) Pentium(R) M processor 2.00GHz")
CMAKE_HOST_SYSTEM_NAME
The name of the system hosting the build. Has the same possible values as CMAKE_SYSTEM_NAME.
Let’s check if build system is Unix or Windows.
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
# UNIX, WIN32, WINRT, CYGWIN, APPLE are environment variables as flags set by default system
if(UNIX)
    message("This is a ${CMAKE_SYSTEM_NAME} system")
elseif(WIN32)
    message("This is a Windows System")
endif()
# or use MATCHES to see if actual system name
# Darwin is Apple's system name
if(${CMAKE_SYSTEM_NAME} MATCHES Darwin)
    message("This is a ${CMAKE_SYSTEM_NAME} system")
elseif(${CMAKE_SYSTEM_NAME} MATCHES Windows)
    message("This is a Windows System")
endif()
add_executable(cmake_hello main.cpp)
System information checks your build system other than building correct binary, like using macros. You can define compiler macros to send to code during build process to change behavior.
Large code bases are implemented to be system agnostic with macros to use certain methods only for the correct system. That also prevents errors, next section shows how to define a macro and use in code.


Defining Macros using CMake

ou can define macros in CMake with add_definitions command, using -D flag before the macro name.
Lets define macro named CMAKEMACROSAMPLE and print it in the code.
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
# or use MATCHES to see if actual system name
# Darwin is Apple's system name
if(${CMAKE_SYSTEM_NAME} MATCHES Darwin)
    add_definitions(-DCMAKEMACROSAMPLE="Apple MacOS")
elseif(${CMAKE_SYSTEM_NAME} MATCHES Windows)
    add_definitions(-DCMAKEMACROSAMPLE="Windows PC")
endif()
add_executable(cmake_hello main.cpp)
Below is the new main.cpp with printing macro.
#include <iostream>
#ifndef CMAKEMACROSAMPLE
    #define CMAKEMACROSAMPLE "NO SYSTEM NAME"
#endif
auto sum(int a, int b){
        return a + b;
}
int main() {
        std::cout<<"Hello CMake!"<<std::endl;
		std::cout<<CMAKEMACROSAMPLE<<std::endl;
        std::cout<<"Sum of 3 + 4 :"<<sum(3, 4)<<std::endl;
        return 0;
}
CMake Folder Organization
While building applications, we try to keep source tree clean and separate auto-generated files and binaries.
For CMake, many developers prefer to create a build folder under root tree and start CMake command inside, as below. Make sure you did cleaned all previously generate files (CMakeCache.txt), otherwise it doesn’t creates files inside build.
$ mkdir build
$ cmake ..
$ ls -all
-rw-r--r--   1 onur  staff  13010 Jan 25 18:40 CMakeCache.txt
drwxr-xr-x  15 onur  staff    480 Jan 25 18:40 CMakeFiles
-rw-r--r--   1 onur  staff   4964 Jan 25 18:40 Makefile
-rw-r--r--   1 onur  staff   1256 Jan 25 18:40 cmake_install.cmake
$ make all
Above commands creates build files inside build directory. It is called out-source build.
You can add build/ folder to your .gitignore to disable tracking.
At this time, you can not force CMake with variables to force creating artefacts into another folder with setting variables so if you don’t want to create a directory and cd into it, you can also use below command to create folder and generate files inside it. -H and -B flags will help it.
-H points the source tree root.
-B points the build directory.
$ cmake -H. -Bbuild
# H indicates source directory
# B indicates build directory
# For CLion, you can navigate to CLion -> Preferences -> Build, Execution and Deployment -> CMake -> Generation Path
However, you can write script in CMake to manipulate where the libraries will be, executables will be.
Let’s edit our CMakeLists.txt to generate binary file inside bin folder with setting CMAKE_RUNTIME_OUTPUT_DIRECTORY or EXECUTABLE_OUTPUT_PATH.
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
add_executable(cmake_hello main.cpp)
After building the project, cmake_hello binary will be generated inside build/bin folder.
Same procedure can be done for library paths as well for shared libraries (.dll or .so) with following variables.
LIBRARY_OUTPUT_PATH
CMAKE_LIBRARY_OUTPUT_DIRECTORY
Or you can use archive output paths for static libraries (.a or .lib)
CMAKE_ARCHIVE_OUTPUT_DIRECTORY
ARCHIVE_OUTPUT_PATH
In some cases, setting single path can be enough, but for larger projects with multiple modules, you may need to write cmake scripts to manage folders to easily organize build structure. This will help you to pack and deploy, install the generated executables, libraries, documents with certain folders.
It is a common practice to disable in-source building. Following script can be used to block in-source building.


# Disable in-source builds to prevent source tree corruption.
if(" ${CMAKE_SOURCE_DIR}" STREQUAL " ${CMAKE_BINARY_DIR}")
  message(FATAL_ERROR "
FATAL: In-source builds are not allowed.
       You should create a separate directory for build files.
")
endif()
Building a Library with CMake
Let’s expand the CMakeHello project with additional sub folder and a class.
To keep things simple, we added a template class which is able to do 4 math operations, sum, subtraction, division, multiplication only on integers.
First, we created lib/math folder inside source tree.
Then, added class files, operations.cpp, operations.hpp as following
#ifndef CMAKEHELLO_OPERATIONS_HPP
#define CMAKEHELLO_OPERATIONS_HPP
namespace math {
    class operations{
    public:
        int sum(const int &a, const int &b);
        int mult(const int &a, const int &b);
        int div(const int &a, const int &b);
        int sub(const int &a, const int &b);
    };
}
#endif //CMAKEHELLO_OPERATIONS_HPP
#include <exception>
#include <stdexcept>
#include <iostream>
#include "operations.hpp"
int math::operations::sum(const int &a, const int &b){
    return a + b;
}
int math::operations::mult(const int &a, const int &b){
    return a * b;
}
int math::operations::div(const int &a, const int &b){
    if(b == 0){
        throw std::overflow_error("Divide by zero exception");
    }
    return a/b;
}
int math::operations::sub(const int &a, const int &b){
    return a - b;
}
Then, we modified main.cpp to include operations.hpp and use its sum method instead of previously written sum.
#include <iostream>
#include "lib/math/operations.hpp"
int main() {
	std::cout<<"Hello CMake!"<<std::endl;
        math::operations op;
        int sum = op.sum(3, 4);
	std::cout<<"Sum of 3 + 4 :"<<sum<<std::endl;
	return 0;
}

Quick Note: Shared vs Static Library
Before going more with library building with C++, lets get a quick brief about shared and static libraries.
Shared Library File Extensions:
Windows: .dll
Mac OS X: .dylib
Linux: .so
Static Library File Extensions:
Linux: .a


Shared libraries are mainly placed in a shared resource of host to make sure multiple applications can access them. Compiler’s build systems with assumption that, shared libraries will be in a shared folder during the execution time so application binary size would reduce, it will handle some of the resources from shared libraries during executions. That requirement also decrease the performance because at each execution it tries to load instructions from shared objects.
Static libraries are used to fetch instructions directly into application binary by compiler, so all the code required from library are already injected into final application binary. That increase the size of object but increase the size of binary but performance get increased. Applications build with static library will also don’t need dependencies on the running platform.
Building Library with Target
If you just want to build these files together with main.cpp, you can just add source files next to add_executable command. This will compile all together and create a single binary file. Leading to 15.076 bytes of exe file.
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
add_executable(cmake_hello main.cpp lib/math/operations.cpp lib/math/operations.hpp)
As an alternate, you can create a variable named ${SOURCES} as a list to include target sources. It can be done in a lot of different ways, depending on your methodology.
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(SOURCES main.cpp
            lib/math/operations.cpp
            lib/math/operations.hpp)
add_executable(cmake_hello ${SOURCES})
Building Library Separate than Target
We can build library separately either as shared or static.
If we do that, we also need to link library to executable in order to enable executable file to make calls from operations library. We also want to generate library binaries inside lib directory of build folder.
set LIBRARY_OUTPUT_PATH
add_library command as SHARED or STATIC
target_link_libraries to target (cmake_hello)
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH  ${CMAKE_BINARY_DIR}/lib)
message(${CMAKE_BINARY_DIR})
add_library(math SHARED lib/math/operations.cpp)
#add_library(math STATIC lib/math/operations.cpp)
add_executable(cmake_hello main.cpp)
target_link_libraries(cmake_hello math)
You will see that, in mac OS, libmath.dylib is generated and binary size decreased to 14.876 bytes. (No significant change because code is already very small).
Build Library as Sub-Module CMake
Another library building process is that, you can write a new CMakeLists.txt file inside lib/operations folder, to build it independently just before building exe file.
This kind of situations are mostly needed when there is an optional build required to generate module. In our case, above solution is better since they all dependend. However, if you want to add a case to only build libraries and skipping executable build process, below example can work as well.
Generate a new CMakeLists.txt inside lib/math folder as shown in below code snippet to build library.
cmake_minimum_required(VERSION 3.9.1)
set(LIBRARY_OUTPUT_PATH  ${CMAKE_BINARY_DIR}/lib)
add_library(math SHARED operations.cpp)
You should delete add_library command and setting LIBRARY_OUTPUT_PATH from main CMakeLists.txt.
Now, you should add new build path with add_subdirectoy. This command makes cmake to go for the folder and build it as well with the CMakeLists.txt inside it.
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
message(${CMAKE_BINARY_DIR})
add_subdirectory(lib/math)
add_executable(cmake_hello main.cpp)
target_link_libraries(cmake_hello math)
Now, you will see the libmath.diylib inside build/lib folder again.
Above, examples shows how to deal with additional sources inside source tree. Either build them all together or separately according to your release plans.
Finding Existing Library with CMake
In most cases, you may require to use installed libraries on your build host. For example, you can install boost library with apt-get or brew package managers to your system.
CMake has conditional statements to allow you to block building process if library is not installed.
If a library installed to system with its .cmake configurations, cmake would be able to look for system default library locations to find that library. like /usr/lib;/usr/local/lib
Boost library can be installed via package managers, brew or apt-get to system. We can use, cmake’s find_package command to check if library exists before building executable.
Let’s change our example little more. I want to use Boost normal distribution library to generate random samples. Therefore, I included boost/random.hpp, and initialized boost::random::normal_distribution to generate numbers with variate_generator.
#include <iostream>
#include "lib/math/operations.hpp"
#include <boost/random.hpp>
int main() {
	std::cout<<"Hello CMake!"<<std::endl;
        math::operations op;
        int sum = op.sum(3, 4);
	std::cout<<"Sum of 3 + 4 :"<<sum<<std::endl;
    //Boost Random Sample
    boost::mt19937 rng;
    double mean = 2.3;
    double std = 0.34;
    auto normal_dist = boost::random::normal_distribution<double>(mean, std);
    boost::variate_generator<boost::mt19937&,
            boost::normal_distribution<> > random_generator(rng, normal_dist);
    for(int i = 0; i < 2; i++){
        auto rand_val = random_generator();
        std::cout<<"Random Val "<<i+1<<" :"<<rand_val<<std::endl;
    }
	return 0;
}
How CMakeLists.txt should be written now? It should check for the Boost library, if it can find includes headers and links libraries.
Note: In most cases, default library and include paths are defined in cmake default configurations, so it may find these libraries without any modification, but it is not suggested to leave CMakeLists.txt with trusting to system.
cmake_minimum_required(VERSION 3.9.1)
project(CMakeHello)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
message(${CMAKE_BINARY_DIR})
add_executable(cmake_hello main.cpp)
add_subdirectory(lib/math)
find_package(Boost 1.66)
# Check for libray, if found print message, include dirs and link libraries.
if(Boost_FOUND)
    message("Boost Found")
    include_directories(${Boost_INCLUDE_DIRS})
    target_link_libraries(cmake_hello ${Boost_LIBRARIES})
elseif(NOT Boost_FOUND)
    error("Boost Not Found")
endif()
target_link_libraries(cmake_hello math)
include_directories will include library headers, target_link_libraries will link boost library. Above code will not continue to build if package not found since we defined error, but you can also add REQUIRED flag after package to raise error.
Note: Boost name already recognized by system because cmake has already defined commands to check for Boost library. If it is not a common library like boost, you should write your own scripts to enable this feature.
When a package found, following variables will be initialized automatically.
<NAME>_FOUND : Flag to show if it is found
<NAME>_INCLUDE_DIRS or <NAME>_INCLUDES : Header directories
<NAME>_LIBRARIES or <NAME>_LIBRARIES or <NAME>_LIBS : library files
<NAME>_DEFINITIONS
So what happens, if a library is in a custom folder and outside of source tree. If there won’t be any CMake, your command line build would look like below.
g++ main.cpp -o cmake_hello -I/home/onur/libraries/boost/include -L/home/onur/libraries/boost -lBoost
With this logic, you should add include and library folder with following commands.
include_directories(/Users/User/Projects/libraries/include)
link_directories(/Users/User/Projects/libraries/libs)
# elseif case can be
elseif(NOT Boost_FOUND)
message("Boost Not Found")
	include_directories(/Users/User/Projects/libraries/include)
	link_directories(/Users/User/Projects/libraries/libs)
	target_link_libraries(cmake_hello Boost)
endif()
Many different methodologies can be followed while including custom libraries for your project. You can also write custom cmake methods to search for given folders to check libraries etc. Most important thing is to understand linkage logic of compiler. You should point the headers and library (.so, .a) folder and link library for compile process.
Above case is not very safe, because you can’t be sure about if it exists in the folders of host. Safest method is to fetch sources of library and build before going forward. In order to provide this property, dependent library should be added with its sources. If library is closed source, you should include binary to your source tree.
However, it is not always easy to distribute sources because of licensing issues, legal problems etc. It is responsibility of build engineer to figure out best practice for this situation.


Target System Configurations
It is highly possible to build your application, library for or on multiple systems. For example, you may want to include Intel related libraries if you want to deploy your binary on a intel system or you may want to cross-compile for an embedded system, like Android. In order to organise build system, you should add all possible checks into your cmake as well as your code as macros.
Change Compiler and Linker for Build
Let’s say you will cross-compile your project for a different target system. In such cases, your host system should include the target system compiler and linker installed. A basic example is shown in official documentation of CMake: https://cmake.org/cmake/help/v3.6/manual/cmake-toolchains.7.html#cross-compiling-for-linux
Official example is enough for this article’s context, in order to cover it basically. It is an example of building for Raspberry Pi with its C/C++ compiler and tools (linker etc.)
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSROOT /home/devel/rasp-pi-rootfs)
set(CMAKE_STAGING_PREFIX /home/devel/stage)
set(tools /home/devel/gcc-4.7-linaro-rpi-gnueabihf)
set(CMAKE_C_COMPILER ${tools}/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/arm-linux-gnueabihf-g++)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
Most important part is to point compiler and tools (linker) paths correctly. Rest is configuration of build process, including optimisations.
It is also important to know your target system’s compiler properties, it would always be different than the host system. For example, intel system has different level of instructions than ARM. Even arm cpu’s would differ for instruction sets so for optimisations. Make sure you had covered those logic to apply for your cross-compile.
In the next section, we tried to cover some of the basic compiler and linker flags for GNU GCC and Clang.
Compiler/Linker Flags with CMake
Compiler and Linker flags enables engineers to customise behavior of compiler during build process for warnings, optimisations of building process. CMake doesn’t give any new feature additional to flags used by Clang or GNU compilers. But, lets have an overview of compiler and linker flags and what they have been used for.


Compiler Flags
Setting Compiler Flags
Compiler flags are crucial when it comes to configure your application’s final properties, optimisation values, behaviour of compiler etc. In Makefile or command line it can be defined in different ways but it is rather easier to define them in CMake. Just like below:
set(CMAKE_CXX_FLAGS "-std=c++0x -Wall")
# suggested way is to keep previous flags in mind and append new ones
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -Wall")
# Alternatively, you can use generator expressions, which are conditional expressions. Below says that, if compiper is c++ then set it to c++11
add_compile_options("$<$<STREQUAL:$<TARGET_PROPERTY:LINKER_LANGUAGE>,CXX>:-std=c++11>")
It is quite important to know, how these flags works and what flags do you want to use than setting flags with CMake.
Optimisation flags set certain compiler flags or disables them. These flags are defined to make easier to switch on/off certain optimisation flags.


-O0, -O1, -O2, -O3, -Os, -Oz, -Ofast
Warning flags set warning properties during build process to see any warning during build to report them. Some may be turned off to fasten compile process because each warning process would require to make analysis. See manual and tree.


Set Source File Properties
This is a complex property of CMake if there are multiple targets, it can be needed to change one target’s certain behavior. In case, you would like to build main.cpp with C++11 and if you building only library, you may want to build it with C++14. In such cases, you may want to configure certain source’s properties with using set_source_files_properties command like below:
set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/*.cpp PROPERTIES COMPILE_FLAGS "-std=c++11")


GCC linker, by default can search the directories defined in environment variables /usr/lib;/usr/local/lib , then links standard libraries by default.
Most common flag is -l to link desired library like, -lzlib, -lboost etc.
Additional flags, help you to change behavior of linking options of executable.
Below are the variables which you can add linker flags.
CMAKE_EXE_LINKER_FLAGS: Flags used to by linker during creation of executable
CMAKE_EXE_LINKER_FLAGS_RELEASE: Flags used to by linker during creation of release executable
CMAKE_EXE_LINKER_FLAGS_DEBUG: Flags used to by linker during creation of debug executable
CMAKE_STATIC_LINKER_FLAGS: Flags used by linker during the creation of static libraries (.a, .lib)
CMAKE_SHARED_LINKER_FLAGS: Flags used by linker during the creation of static libraries (.a, .lib)
CMAKE_MODULE_LINKER_FLAGS: Flags used by linker during the creation of static libraries (.a, .lib)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl")
Debug and Release Configuration
It is highly recommended to create CMakeLists.txt with multiple configurations according to your needs. If you intend to deliver binaries, you should make a Release, which doesn't include debug flags in binary, which would be a way faster and ready to run. However, debug version of executable files include many of other flags which exposes the memory, method names etc for debuggers to help identify the errors. It is not a good practice and not safe to deliver debug version of an application.
CMake helps you to write script to separate final builds of both type of outputs. There are additional build types like Release with Debug Flags (RELWITHDEBINFO) or Minium Release Size (MINSIZEREL). In this example, we will show both.
You have to create Debug and Release folders for both type of builds under your build folder. build/Debug and build/Release. cmake command line will change as below:
$ cmake -H. -Bbuild/Debug
$ cmake -H. -Bbuild/Release
Above configuration is not enough to create different binaries. You should also set build type with CMAKE_BUILD_TYPE variable on the command line. (CLion handles this process by itself.)
$ cmake -DCMAKE_BUILD_TYPE=Debug -H.  -Bbuild/Debug
$ cmake -DCMAKE_BUILD_TYPE=Release -H. -Bbuild/Release
CMAKE_BUILD_TYPE is accessible inside CMakeLists.txt. You can easily check for build type in CMakeLists.txt
if(${CMAKE_BUILD_TYPE} MATCHES Debug)
    message("Debug Build")
elseif(${CMAKE_BUILD_TYPE} MATCHES Release)
    message("Release Build")
endif()
You can also, set compiler and linker flags separately for build types using the config variables shown in the previous section.
CMAKE_EXE_LINKER_FLAGS_RELEASE: Flags used to by linker during creation of release executable
CMAKE_EXE_LINKER_FLAGS_DEBUG: Flags used to by linker during creation of debug executable
CMAKE_CXX_FLAGS_RELEASE
CMAKE_CXX_FLAGS_DEBUG

First, think about destination folder. CMAKE_INSTALL_PREFIX is the variable to define host destination. it is set to /usr/local by default. During the build process, you should point the destination folder in command-line.
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/test/with/cmake -H. -Bbuild/Release
Keeping in mind that, you are getting prefix destination from terminal you should think about library and executable destinations accordingly.
CMake Best Practices
Always remember the previous configurations, make sure you append new flag instead of overwriting it. It is better to implement, add_flag/remove method of yours, to achieve easier implementation.
set(VARIABLE "${VARIABLE} Flag1 Flag2")
Always check system information carefully, raise error if a certain configuration can’t be done to prevent faulty binaries.
Always, check required libraries to continue build process, raise error if not found.
if(Boost_FOUND)
    message("Boost Found")
else()
    error("Boost Not Found")
endif()

# CMakeLists files in this project can
# refer to the root source directory of the project as ${HELLO_SOURCE_DIR} and
# to the root binary directory of the project as ${HELLO_BINARY_DIR}.
cmake_minimum_required (VERSION 2.8.11)
project (HELLO)

# Recurse into the "Hello" and "Demo" subdirectories. This does not actually
# cause another cmake executable to run. The same process will walk through
# the project's entire directory structure.
add_subdirectory (Hello)
add_subdirectory (Demo)

Then for each subdirectory specified, CMakeLists.txt files are created. In the ./Hello directory, the following CMakeLists.txt file is created:

# Create a library called "Hello" which includes the source file "hello.cxx".
# The extension is already found. Any number of sources could be listed here.
add_library (Hello hello.cxx)

# Make sure the compiler can find include files for our Hello library
# when other libraries or executables link to Hello
target_include_directories (Hello PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
Finally, in the ./Demo directory, the third and final CMakeLists.txt file is created:

# Add executable called "helloDemo" that is built from the source files
# "demo.cxx" and "demo_b.cxx". The extensions are automatically found.
add_executable (helloDemo demo.cxx demo_b.cxx)

# Link the executable to the Hello library. Since the Hello library has
# public include directories we will use those link directories when building
# helloDemo
target_link_libraries (helloDemo LINK_PUBLIC Hello)

project(directory_test)

#Bring the headers, such as Student.h into the project
include_directories(include)

#Can manually add the sources using the set command as follows:
#set(SOURCES src/mainapp.cpp src/Student.cpp)

#However, the file(GLOB...) allows for wildcard additions:
file(GLOB SOURCES "src/*.cpp")

add_executable(testStudent ${SOURCES})

molloyd@beaglebone:~/exploringBB/extras/cmake/student$ tree
.
|-- CMakeLists.txt
|-- build
|   |-- CMakeCache.txt
|   |-- CMakeFiles
|   |   |-- CMakeCCompiler.cmake
|   |   |-- CMakeCXXCompiler.cmake
|   |   |-- CMakeDetermineCompilerABI_C.bin
|   |   |-- CMakeDetermineCompilerABI_CXX.bin
|   |   |-- CMakeDirectoryInformation.cmake
|   |   |-- CMakeOutput.log
|   |   |-- CMakeSystem.cmake
|   |   |-- CMakeTmp
|   |   |-- CompilerIdC
|   |   |   |-- CMakeCCompilerId.c
|   |   |   `-- a.out
|   |   |-- CompilerIdCXX
|   |   |   |-- CMakeCXXCompilerId.cpp
|   |   |   `-- a.out
|   |   |-- Makefile.cmake
|   |   |-- Makefile2
|   |   |-- TargetDirectories.txt
|   |   |-- cmake.check_cache
|   |   |-- progress.marks
|   |   `-- testStudent.dir
|   |       |-- CXX.includecache
|   |       |-- DependInfo.cmake
|   |       |-- build.make
|   |       |-- cmake_clean.cmake
|   |       |-- depend.internal
|   |       |-- depend.make
|   |       |-- flags.make
|   |       |-- link.txt
|   |       |-- progress.make
|   |       `-- src
|   |           |-- Student.cpp.o
|   |           `-- mainapp.cpp.o
|   |-- Makefile
|   |-- cmake_install.cmake
|   `-- testStudent
|-- include
|   `-- Student.h
`-- src
    |-- Student.cpp
    `-- mainapp.cpp



16
cmake_minimum_required(VERSION 2.8.9)
project(directory_test)
set(CMAKE_BUILD_TYPE Release)
 
#Bring the headers, such as Student.h into the project
include_directories(include)
 
#However, the file(GLOB...) allows for wildcard additions:
file(GLOB SOURCES "src/*.cpp")
 
#Generate the shared library from the sources
add_library(testStudent SHARED ${SOURCES})
 
#Set the location for library installation -- i.e., /usr/lib in this case
# not really necessary in this example. Use "sudo make install" to apply
install(TARGETS testStudent DESTINATION /usr/lib)



cmake_minimum_required(VERSION 2.8.9)
project(directory_test)
set(CMAKE_BUILD_TYPE Release)

#Bring the headers, such as Student.h into the project
include_directories(include)

#However, the file(GLOB...) allows for wildcard additions:
file(GLOB SOURCES "src/*.cpp")

#Generate the static library from the sources
add_library(testStudent STATIC ${SOURCES})

#Set the location for library installation -- i.e., /usr/lib in this case
# not really necessary in this example. Use "sudo make install" to apply
install(TARGETS testStudent DESTINATION /usr/lib)


cmake_minimum_required(VERSION 2.8.9)
project (TestLibrary)

#For the shared library:
set ( PROJECT_LINK_LIBS libtestStudent.so )
link_directories( ~/exploringBB/extras/cmake/studentlib_shared/build )

#For the static library:
#set ( PROJECT_LINK_LIBS libtestStudent.a )
#link_directories( ~/exploringBB/extras/cmake/studentlib_static/build )

include_directories(~/exploringBB/extras/cmake/studentlib_shared/include)

add_executable(libtest libtest.cpp)
target_link_libraries(libtest ${PROJECT_LINK_LIBS} )


#
#  _______ _    _ _____  _____     _____  _____
# |__   __| |  | |_   _|/ ____|   |_   _|/ ____|       /\
#    | |  | |__| | | | | (___       | | | (___        /  \
#    | |  |  __  | | |  \___ \      | |  \___ \      / /\ \
#    | |  | |  | |_| |_ ____) |    _| |_ ____) |    / ____ \
#    |_|__|_|_ |_|_____|_____/__  |_____|_____/    /_/  _ \_\
#   |__   __| |  | |__   __/ __ \|  __ \|_   _|   /\   | |
#      | |  | |  | |  | | | |  | | |__) | | |    /  \  | |
#      | |  | |  | |  | | | |  | |  _  /  | |   / /\ \ | |
#      | |  | |__| |  | | | |__| | | \ \ _| |_ / ____ \| |____
#      |_|   \____/   |_|  \____/|_|  \_\_____/_/    \_\______|
#
#
#    _____  ______          _____      _______ _    _ ______
#   |  __ \|  ____|   /\   |  __ \    |__   __| |  | |  ____|
#   | |__) | |__     /  \  | |  | |      | |  | |__| | |__
#   |  _  /|  __|   / /\ \ | |  | |      | |  |  __  |  __|
#   | | \ \| |____ / ____ \| |__| |      | |  | |  | | |____
#   |_|__\_\______/_/_ __\_\_____/__ _   |_|__|_|_ |_|______|_ _ _
#  / ____/ __ \|  \/  |  \/  |  ____| \ | |__   __/ ____| | | | | |
# | |   | |  | | \  / | \  / | |__  |  \| |  | | | (___   | | | | |
# | |   | |  | | |\/| | |\/| |  __| | . ` |  | |  \___ \  | | | | |
# | |___| |__| | |  | | |  | | |____| |\  |  | |  ____) | |_|_|_|_|
#  \_____\____/|_|  |_|_|  |_|______|_| \_|  |_| |_____/  (_|_|_|_)
#
#
#
# This is a CMake makefile.  CMake is a tool that helps you build C++ programs.
# You can download CMake from http://www.cmake.org.  This CMakeLists.txt file
# you are reading builds dlib's example programs.
#


cmake_minimum_required(VERSION 2.8.12)
# Every project needs a name.  We call this the "examples" project.
project(examples)


# Tell cmake we will need dlib.  This command will pull in dlib and compile it
# into your project.  Note that you don't need to compile or install dlib.  All
# cmake needs is the dlib source code folder and it will take care of everything.
add_subdirectory(../dlib dlib_build)

# If you have cmake 3.14 or newer you can even use FetchContent instead of
# add_subdirectory() to pull in dlib as a dependency.  So instead of using the
# above add_subdirectory() command, you could use the following three commands
# to make dlib available:
#  include(FetchContent)
#  FetchContent_Declare(dlib
#      GIT_REPOSITORY https://github.com/davisking/dlib.git
#      GIT_TAG        v19.18
#  )
#  FetchContent_MakeAvailable(dlib)


# The next thing we need to do is tell CMake about the code you want to
# compile.  We do this with the add_executable() statement which takes the name
# of the output executable and then a list of .cpp files to compile.  Here we
# are going to compile one of the dlib example programs which has only one .cpp
# file, assignment_learning_ex.cpp.  If your program consisted of multiple .cpp
# files you would simply list them here in the add_executable() statement.
add_executable(assignment_learning_ex assignment_learning_ex.cpp)
# Finally, you need to tell CMake that this program, assignment_learning_ex,
# depends on dlib.  You do that with this statement:
target_link_libraries(assignment_learning_ex dlib::dlib)



# To compile this program all you need to do is ask cmake.  You would type
# these commands from within the directory containing this CMakeLists.txt
# file:
#   mkdir build
#   cd build
#   cmake ..
#   cmake --build . --config Release
#
# The cmake .. command looks in the parent folder for a file named
# CMakeLists.txt, reads it, and sets up everything needed to build program.
# Also, note that CMake can generate Visual Studio or XCode project files.  So
# if instead you had written:
#   cd build
#   cmake .. -G Xcode
#
# You would be able to open the resulting Xcode project and compile and edit
# the example programs within the Xcode IDE.  CMake can generate a lot of
# different types of IDE projects.  Run the cmake -h command to see a list of
# arguments to -G to see what kinds of projects cmake can generate for you.  It
# probably includes your favorite IDE in the list.




#################################################################################
#################################################################################
#  A CMakeLists.txt file can compile more than just one program.  So below we
#  tell it to compile the other dlib example programs using pretty much the
#  same CMake commands we used above.
#################################################################################
#################################################################################


# Since there are a lot of examples I'm going to use a macro to simplify this
# CMakeLists.txt file.  However, usually you will create only one executable in
# your cmake projects and use the syntax shown above.
macro(add_example name)
   add_executable(${name} ${name}.cpp)
   target_link_libraries(${name} dlib::dlib )
endmacro()

# if an example requires GUI, call this macro to check DLIB_NO_GUI_SUPPORT to include or exclude
macro(add_gui_example name)
   if (DLIB_NO_GUI_SUPPORT)
      message("No GUI support, so we won't build the ${name} example.")
   else()
      add_example(${name})
   endif()
endmacro()

# The deep learning toolkit requires a compiler with essentially complete C++11
# support.  However, versions of Visual Studio prior to October 2016 didn't
# provide enough C++11 support to compile the DNN tooling, but were good enough
# to compile the rest of dlib.  So new versions of Visual Studio 2015 will
# work.  However, Visual Studio 2017 had some C++11 support regressions, so it
# wasn't until December 2017 that Visual Studio 2017 had good enough C++11
# support to compile the DNN examples.  So if you are using Visual Studio, make
# sure you have an updated version if you want to compile the DNN code.
#
# Also note that Visual Studio users should give the -T host=x64 option so that
# CMake will instruct Visual Studio to use its 64bit toolchain.  If you don't
# do this then by default Visual Studio uses a 32bit toolchain, WHICH RESTRICTS
# THE COMPILER TO ONLY 2GB OF RAM, causing it to run out of RAM and crash when
# compiling some of the DNN examples.  So generate your project with a statement
# like this:
#   cmake .. -G "Visual Studio 14 2015 Win64" -T host=x64
if (NOT USING_OLD_VISUAL_STUDIO_COMPILER)
   add_example(dnn_metric_learning_ex)
   add_gui_example(dnn_face_recognition_ex)
   add_example(dnn_introduction_ex)
   add_example(dnn_introduction2_ex)
   add_example(dnn_introduction3_ex)
   add_example(dnn_inception_ex)
   add_gui_example(dnn_mmod_ex)
   add_gui_example(dnn_mmod_face_detection_ex)
   add_gui_example(random_cropper_ex)
   add_gui_example(dnn_mmod_dog_hipsterizer)
   add_gui_example(dnn_imagenet_ex)
   add_gui_example(dnn_mmod_find_cars_ex)
   add_gui_example(dnn_mmod_find_cars2_ex)
   add_example(dnn_mmod_train_find_cars_ex)
   add_gui_example(dnn_semantic_segmentation_ex)
   add_gui_example(dnn_instance_segmentation_ex)
   add_example(dnn_imagenet_train_ex)
   add_example(dnn_semantic_segmentation_train_ex)
   add_example(dnn_instance_segmentation_train_ex)
   add_example(dnn_metric_learning_on_images_ex)
   add_gui_example(dnn_dcgan_train_ex)
endif()


if (DLIB_NO_GUI_SUPPORT)
   message("No GUI support, so we won't build the webcam_face_pose_ex example.")
else()
   find_package(OpenCV QUIET)
   if (OpenCV_FOUND)
      include_directories(${OpenCV_INCLUDE_DIRS})

      add_executable(webcam_face_pose_ex webcam_face_pose_ex.cpp)
      target_link_libraries(webcam_face_pose_ex dlib::dlib ${OpenCV_LIBS} )
   else()
      message("OpenCV not found, so we won't build the webcam_face_pose_ex example.")
   endif()
endif()



#here we apply our macros
add_gui_example(3d_point_cloud_ex)
add_example(bayes_net_ex)
add_example(bayes_net_from_disk_ex)
add_gui_example(bayes_net_gui_ex)
add_example(bridge_ex)
add_example(bsp_ex)
add_example(compress_stream_ex)
add_example(config_reader_ex)
add_example(custom_trainer_ex)
add_example(dir_nav_ex)
add_example(empirical_kernel_map_ex)
add_gui_example(face_detection_ex)
add_gui_example(face_landmark_detection_ex)
add_gui_example(fhog_ex)
add_gui_example(fhog_object_detector_ex)
add_example(file_to_code_ex)
add_example(graph_labeling_ex)
add_gui_example(gui_api_ex)
add_gui_example(hough_transform_ex)
add_gui_example(image_ex)
add_example(integrate_function_adapt_simp_ex)
add_example(iosockstream_ex)
add_example(kcentroid_ex)
add_example(kkmeans_ex)
add_example(krls_ex)
add_example(krls_filter_ex)
add_example(krr_classification_ex)
add_example(krr_regression_ex)
add_example(learning_to_track_ex)
add_example(least_squares_ex)
add_example(linear_manifold_regularizer_ex)
add_example(logger_custom_output_ex)
add_example(logger_ex)
add_example(logger_ex_2)
add_example(matrix_ex)
add_example(matrix_expressions_ex)
add_example(max_cost_assignment_ex)
add_example(member_function_pointer_ex)
add_example(mlp_ex)
add_example(model_selection_ex)
add_gui_example(mpc_ex)
add_example(multiclass_classification_ex)
add_example(multithreaded_object_ex)
add_gui_example(object_detector_advanced_ex)
add_gui_example(object_detector_ex)
add_gui_example(one_class_classifiers_ex)
add_example(optimization_ex)
add_example(parallel_for_ex)
add_example(pipe_ex)
add_example(pipe_ex_2)
add_example(quantum_computing_ex)
add_example(queue_ex)
add_example(rank_features_ex)
add_example(running_stats_ex)
add_example(rvm_ex)
add_example(rvm_regression_ex)
add_example(sequence_labeler_ex)
add_example(sequence_segmenter_ex)
add_example(server_http_ex)
add_example(server_iostream_ex)
add_example(sockets_ex)
add_example(sockstreambuf_ex)
add_example(std_allocator_ex)
add_gui_example(surf_ex)
add_example(svm_c_ex)
add_example(svm_ex)
add_example(svm_pegasos_ex)
add_example(svm_rank_ex)
add_example(svm_sparse_ex)
add_example(svm_struct_ex)
add_example(svr_ex)
add_example(thread_function_ex)
add_example(thread_pool_ex)
add_example(threaded_object_ex)
add_example(threads_ex)
add_example(timer_ex)
add_gui_example(train_object_detector)
add_example(train_shape_predictor_ex)
add_example(using_custom_kernels_ex)
add_gui_example(video_tracking_ex)
add_example(xml_parser_ex)


if (DLIB_LINK_WITH_SQLITE3)
   add_example(sqlite_ex)
endif()

