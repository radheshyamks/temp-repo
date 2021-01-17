cmake_minimum_required(VERSION 3.12)
project(class VERSION 1.1 LANGUAGES CXX)

configure_file(class.hh.in class.hh)

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_BINARY_DIR})

add_executable(${PROJECT_NAME} class01.cpp)
#project(<PROJECT-NAME> [<language-name>...])
##project(<PROJECT-NAME>
##        [VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]
##        [DESCRIPTION <project-description-string>]
##        [HOMEPAGE_URL <url-string>]
##        [LANGUAGES <language-name>...])
#set(CMAKE_CXX_COMPILER g++)
## specify the C++ standard
#set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_STANDARD_REQUIRED True)
#project(class VERSION 1.1 DESCRIPTION "this project is only for simple class" LANGUAGES CXX )
#configure_file(class.hh.in class.hh)
#set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)
#set(CMAKE_CXX_FLAGS_INIT "-fexceptions")
##add_subdirectory()
##enable_testing()
#add_executable(${PROJECT_NAME} class01.cpp)

#cmake_minimum_required( VERSION 2.6 )
#
#project( Application On )
#
#find_package( Boost COMPONENTS system REQUIRED )
#
#link_directories( ${Boost_LIBRARY_DIRS} )
#
#if(Boost_FOUND)
#    include_directories( ${Boost_INCLUDE_DIRS} )
#
#    add_library( object class01.cpp)   
#    target_link_libraries( object ${Boost_SYSTEM_LIBRARY} )
#
#endif()
#

#foreach()
#endforeach()
#if()
#endif()
#function(function_name arg1 arg2 ...){}
#include(CheckSymbolExists)
#check_symbol_exists(log "math.h" HAVE_LOG)
#check_symbol_exists(exp "math.h" HAVE_EXP)
#if(NOT (HAVE_LOG AND HAVE_EXP))
#  unset(HAVE_LOG CACHE)
#  unset(HAVE_EXP CACHE)
#  set(CMAKE_REQUIRED_LIBRARIES "m")
#  check_symbol_exists(log "math.h" HAVE_LOG)
#  check_symbol_exists(exp "math.h" HAVE_EXP)
#  if(HAVE_LOG AND HAVE_EXP)
#    target_link_libraries(MathFunctions PRIVATE m)
#  endif()
#endif()
#
## add compile definitions
#if(HAVE_LOG AND HAVE_EXP)
#  target_compile_definitions(MathFunctions
#                             PRIVATE "HAVE_LOG" "HAVE_EXP")
#endif()
# enable testing
#enable_testing()
#
#With:
#
## enable dashboard scripting
#include(CTest)
#
#The CTest module will automatically call enable_testing(), so we can remove it from our CMake files.
#
#We will also need to create a CTestConfig.cmake file in the top-level directory where we can specify the name of the project and where to submit the dashboard.
#
#set(CTEST_PROJECT_NAME "CMakeTutorial")
#set(CTEST_NIGHTLY_START_TIME "00:00:00 EST")
#
#set(CTEST_DROP_METHOD "http")
#set(CTEST_DROP_SITE "my.cdash.org")
#set(CTEST_DROP_LOCATION "/submit.php?project=CMakeTutorial")
#set(CTEST_DROP_SITE_CDASH TRUE)

#Mixing Static and Shared (Step 9)
#
#In this section we will show how the BUILD_SHARED_LIBS variable can be used to control the default behavior of add_library(), and allow control over how libraries without an explicit type (STATIC, SHARED, MODULE or OBJECT) are built.
#
#To accomplish this we need to add BUILD_SHARED_LIBS to the top-level CMakeLists.txt. We use the option() command as it allows users to optionally select if the value should be ON or OFF.
#
#Next we are going to refactor MathFunctions to become a real library that encapsulates using mysqrt or sqrt, instead of requiring the calling code to do this logic. This will also mean that USE_MYMATH will not control building MathFunctions, but instead will control the behavior of this library.
#
#The first step is to update the starting section of the top-level CMakeLists.txt to look like:
#
#cmake_minimum_required(VERSION 3.10)
#
## set the project name and version
#project(Tutorial VERSION 1.0)
#
## specify the C++ standard
#set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_STANDARD_REQUIRED True)
#
## control where the static and shared libraries are built so that on windows
## we don't need to tinker with the path to run the executable
#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
#
#option(BUILD_SHARED_LIBS "Build using shared libraries" ON)
#
## configure a header file to pass the version number only
#configure_file(TutorialConfig.h.in TutorialConfig.h)
#
## add the MathFunctions library
#add_subdirectory(MathFunctions)
#
## add the executable
#add_executable(Tutorial tutorial.cxx)
#target_link_libraries(Tutorial PUBLIC MathFunctions)
#
#Now that we have made MathFunctions always be used, we will need to update the logic of that library. So, in MathFunctions/CMakeLists.txt we need to create a SqrtLibrary that will conditionally be built and installed when USE_MYMATH is enabled. Now, since this is a tutorial, we are going to explicitly require that SqrtLibrary is built statically.
#
#The end result is that MathFunctions/CMakeLists.txt should look like:
#
## add the library that runs
#add_library(MathFunctions MathFunctions.cxx)
#
## state that anybody linking to us needs to include the current source dir
## to find MathFunctions.h, while we don't.
#target_include_directories(MathFunctions
#                           INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
#                           )
#
## should we use our own math functions
#option(USE_MYMATH "Use tutorial provided math implementation" ON)
#if(USE_MYMATH)
#
#  target_compile_definitions(MathFunctions PRIVATE "USE_MYMATH")
#
#  # first we add the executable that generates the table
#  add_executable(MakeTable MakeTable.cxx)
#
#  # add the command to generate the source code
#  add_custom_command(
#    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
#    COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
#    DEPENDS MakeTable
#    )
#
#  # library that just does sqrt
#  add_library(SqrtLibrary STATIC
#              mysqrt.cxx
#              ${CMAKE_CURRENT_BINARY_DIR}/Table.h
#              )
#
#  # state that we depend on our binary dir to find Table.h
#  target_include_directories(SqrtLibrary PRIVATE
#                             ${CMAKE_CURRENT_BINARY_DIR}
#                             )
#
#  target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
#endif()
#
## define the symbol stating we are using the declspec(dllexport) when
## building on windows
#target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")
#
## install rules
#set(installable_libs MathFunctions)
#if(TARGET SqrtLibrary)
#  list(APPEND installable_libs SqrtLibrary)
#endif()
#install(TARGETS ${installable_libs} DESTINATION lib)
#install(FILES MathFunctions.h DESTINATION include)
#
#Next, update MathFunctions/mysqrt.cxx to use the mathfunctions and detail namespaces:
#
##include <iostream>
#
##include "MathFunctions.h"
#
#// include the generated table
##include "Table.h"
#
#namespace mathfunctions {
#namespace detail {
#// a hack square root calculation using simple operations
#double mysqrt(double x)
#{
#  if (x <= 0) {
#    return 0;
#  }
#
#  // use the table to help find an initial value
#  double result = x;
#  if (x >= 1 && x < 10) {
#    std::cout << "Use the table to help find an initial value " << std::endl;
#    result = sqrtTable[static_cast<int>(x)];
#  }
#
#  // do ten iterations
#  for (int i = 0; i < 10; ++i) {
#    if (result <= 0) {
#      result = 0.1;
#    }
#    double delta = x - (result * result);
#    result = result + 0.5 * delta / result;
#    std::cout << "Computing sqrt of " << x << " to be " << result << std::endl;
#  }
#
#  return result;
#}
#}
#}
#
#We also need to make some changes in tutorial.cxx, so that it no longer uses USE_MYMATH:
#
#    Always include MathFunctions.h
#
#    Always use mathfunctions::sqrt
#
#    Don’t include cmath
#
#Finally, update MathFunctions/MathFunctions.h to use dll export defines:
#
##if defined(_WIN32)
##  if defined(EXPORTING_MYMATH)
##    define DECLSPEC __declspec(dllexport)
##  else
##    define DECLSPEC __declspec(dllimport)
##  endif
##else // non windows
##  define DECLSPEC
##endif
#
#namespace mathfunctions {
#double DECLSPEC sqrt(double x);
#}
#
#At this point, if you build everything, you may notice that linking fails as we are combining a static library without position independent code with a library that has position independent code. The solution to this is to explicitly set the POSITION_INDEPENDENT_CODE target property of SqrtLibrary to be True no matter the build type.
#
#  # state that SqrtLibrary need PIC when the default is shared libraries
#  set_target_properties(SqrtLibrary PROPERTIES
#                        POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
#                        )
#
#  target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
#
#Exercise: We modified MathFunctions.h to use dll export defines. Using CMake documentation can you find a helper module to simplify this?
#Adding Generator Expressions (Step 10)
#
#Generator expressions are evaluated during build system generation to produce information specific to each build configuration.
#
#Generator expressions are allowed in the context of many target properties, such as LINK_LIBRARIES, INCLUDE_DIRECTORIES, COMPILE_DEFINITIONS and others. They may also be used when using commands to populate those properties, such as target_link_libraries(), target_include_directories(), target_compile_definitions() and others.
#
#Generator expressions may be used to enable conditional linking, conditional definitions used when compiling, conditional include directories and more. The conditions may be based on the build configuration, target properties, platform information or any other queryable information.
#
#There are different types of generator expressions including Logical, Informational, and Output expressions.
#
#Logical expressions are used to create conditional output. The basic expressions are the 0 and 1 expressions. A $<0:...> results in the empty string, and <1:...> results in the content of “…”. They can also be nested.
#
#A common usage of generator expressions is to conditionally add compiler flags, such as those for language levels or warnings. A nice pattern is to associate this information to an INTERFACE target allowing this information to propagate. Let’s start by constructing an INTERFACE target and specifying the required C++ standard level of 11 instead of using CMAKE_CXX_STANDARD.
#
#So the following code:
#
## specify the C++ standard
#set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_STANDARD_REQUIRED True)
#
#Would be replaced with:
#
#add_library(tutorial_compiler_flags INTERFACE)
#target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)
#
#Next we add the desired compiler warning flags that we want for our project. As warning flags vary based on the compiler we use the COMPILE_LANG_AND_ID generator expression to control which flags to apply given a language and a set of compiler ids as seen below:
#
#set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU>")
#set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
#target_compile_options(tutorial_compiler_flags INTERFACE
#  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
#  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
#)
#
#Looking at this we see that the warning flags are encapsulated inside a BUILD_INTERFACE condition. This is done so that consumers of our installed project will not inherit our warning flags.
#
#Exercise: Modify MathFunctions/CMakeLists.txt so that all targets have a target_link_libraries() call to tutorial_compiler_flags.
#Adding Export Configuration (Step 11)
#
#During Installing and Testing (Step 4) of the tutorial we added the ability for CMake to install the library and headers of the project. During Building an Installer (Step 7) we added the ability to package up this information so it could be distributed to other people.
#
#The next step is to add the necessary information so that other CMake projects can use our project, be it from a build directory, a local install or when packaged.
#
#The first step is to update our install(TARGETS) commands to not only specify a DESTINATION but also an EXPORT. The EXPORT keyword generates and installs a CMake file containing code to import all targets listed in the install command from the installation tree. So let’s go ahead and explicitly EXPORT the MathFunctions library by updating the install command in MathFunctions/CMakeLists.txt to look like:
#
#set(installable_libs MathFunctions tutorial_compiler_flags)
#if(TARGET SqrtLibrary)
#  list(APPEND installable_libs SqrtLibrary)
#endif()
#install(TARGETS ${installable_libs}
#        DESTINATION lib
#        EXPORT MathFunctionsTargets)
#install(FILES MathFunctions.h DESTINATION include)
#
#Now that we have MathFunctions being exported, we also need to explicitly install the generated MathFunctionsTargets.cmake file. This is done by adding the following to the bottom of the top-level CMakeLists.txt:
#
#install(EXPORT MathFunctionsTargets
#  FILE MathFunctionsTargets.cmake
#  DESTINATION lib/cmake/MathFunctions
#)
#
#At this point you should try and run CMake. If everything is setup properly you will see that CMake will generate an error that looks like:
#
#Target "MathFunctions" INTERFACE_INCLUDE_DIRECTORIES property contains
#path:
#
#  "/Users/robert/Documents/CMakeClass/Tutorial/Step11/MathFunctions"
#
#which is prefixed in the source directory.
#
#What CMake is trying to say is that during generating the export information it will export a path that is intrinsically tied to the current machine and will not be valid on other machines. The solution to this is to update the MathFunctions target_include_directories() to understand that it needs different INTERFACE locations when being used from within the build directory and from an install / package. This means converting the target_include_directories() call for MathFunctions to look like:
#
#target_include_directories(MathFunctions
#                           INTERFACE
#                            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
#                            $<INSTALL_INTERFACE:include>
#                           )
#
#Once this has been updated, we can re-run CMake and verify that it doesn’t warn anymore.
#
#At this point, we have CMake properly packaging the target information that is required but we will still need to generate a MathFunctionsConfig.cmake so that the CMake find_package() command can find our project. So let’s go ahead and add a new file to the top-level of the project called Config.cmake.in with the following contents:
#
#
#@PACKAGE_INIT@
#
#include ( "${CMAKE_CURRENT_LIST_DIR}/MathFunctionsTargets.cmake" )
#
#Then, to properly configure and install that file, add the following to the bottom of the top-level CMakeLists.txt:
#
#install(EXPORT MathFunctionsTargets
#  FILE MathFunctionsTargets.cmake
#  DESTINATION lib/cmake/MathFunctions
#)
#
#include(CMakePackageConfigHelpers)
## generate the config file that is includes the exports
#configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
#  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
#  INSTALL_DESTINATION "lib/cmake/example"
#  NO_SET_AND_CHECK_MACRO
#  NO_CHECK_REQUIRED_COMPONENTS_MACRO
#  )
## generate the version file for the config file
#write_basic_package_version_file(
#  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
#  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
#  COMPATIBILITY AnyNewerVersion
#)
#
## install the configuration file
#install(FILES
#  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
#  DESTINATION lib/cmake/MathFunctions
#  )
#
#At this point, we have generated a relocatable CMake Configuration for our project that can be used after the project has been installed or packaged. If we want our project to also be used from a build directory we only have to add the following to the bottom of the top level CMakeLists.txt:
#
#export(EXPORT MathFunctionsTargets
#  FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
#)
#
#With this export call we now generate a Targets.cmake, allowing the configured MathFunctionsConfig.cmake in the build directory to be used by other projects, without needing it to be installed.
#Packaging Debug and Release (Step 12)
#
#Note: This example is valid for single-configuration generators and will not work for multi-configuration generators (e.g. Visual Studio).
#
#By default, CMake’s model is that a build directory only contains a single configuration, be it Debug, Release, MinSizeRel, or RelWithDebInfo. It is possible, however, to setup CPack to bundle multiple build directories and construct a package that contains multiple configurations of the same project.
#
#First, we want to ensure that the debug and release builds use different names for the executables and libraries that will be installed. Let’s use d as the postfix for the debug executable and libraries.
#
#Set CMAKE_DEBUG_POSTFIX near the beginning of the top-level CMakeLists.txt file:
#
#set(CMAKE_DEBUG_POSTFIX d)
#
#add_library(tutorial_compiler_flags INTERFACE)
#
#And the DEBUG_POSTFIX property on the tutorial executable:
#
#add_executable(Tutorial tutorial.cxx)
#set_target_properties(Tutorial PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})
#
#target_link_libraries(Tutorial PUBLIC MathFunctions)
#
#Let’s also add version numbering to the MathFunctions library. In MathFunctions/CMakeLists.txt, set the VERSION and SOVERSION properties:
#
#set_property(TARGET MathFunctions PROPERTY VERSION "1.0.0")
#set_property(TARGET MathFunctions PROPERTY SOVERSION "1")
#
#From the Step12 directory, create debug and release subbdirectories. The layout will look like:
#
#- Step12
#   - debug
#   - release
#
#Now we need to setup debug and release builds. We can use CMAKE_BUILD_TYPE to set the configuration type:
#
#cd debug
#cmake -DCMAKE_BUILD_TYPE=Debug ..
#cmake --build .
#cd ../release
#cmake -DCMAKE_BUILD_TYPE=Release ..
#cmake --build .
#
#Now that both the debug and release builds are complete, we can use a custom configuration file to package both builds into a single release. In the Step12 directory, create a file called MultiCPackConfig.cmake. In this file, first include the default configuration file that was created by the cmake executable.
#
#Next, use the CPACK_INSTALL_CMAKE_PROJECTS variable to specify which projects to install. In this case, we want to install both debug and release.
#
#include("release/CPackConfig.cmake")
#
#set(CPACK_INSTALL_CMAKE_PROJECTS
#    "debug;Tutorial;ALL;/"
#    "release;Tutorial;ALL;/"
#    )
#
#From the Step12 directory, run cpack specifying our custom configuration file with the config option:
#
#cpack --config MultiCPackConfig.cmake
