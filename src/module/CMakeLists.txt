add_library(Module SHARED feature.cpp)

target_include_directories(Module PUBLIC ..)

add_subdirectory(mocks)
add_subdirectory(tests)
add_subdirectory(libs)



add_project_warnings(Module)
add_rapidcheck(Module)
add_includewhatyouuse(Module)
