add_library(Module SHARED feature.cpp)

target_include_directories(Module PUBLIC ..)

add_subdirectory(mocks)
add_subdirectory(tests)
# Enable for protocol buffers
# add_subdirectory(proto)

add_project_warnings(Module)
