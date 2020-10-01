add_library(App SHARED app.cpp)
target_link_libraries(App Module)

add_executable(app main.cpp)
target_link_libraries(app App)

add_subdirectory(tests)

add_includewhatyouuse(App)
