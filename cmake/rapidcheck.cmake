set(RC_ENABLE_GTEST TRUE)
add_subdirectory("src/module/libs/rapidcheck")
function(add_rapidcheck EXE_OR_LIB)
    target_link_libraries(${EXE_OR_LIB} rapidcheck)
    target_link_libraries(${EXE_OR_LIB} rapidcheck_gtest)
endfunction()
