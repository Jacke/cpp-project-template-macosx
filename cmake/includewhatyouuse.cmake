cmake_minimum_required(VERSION 3.3 FATAL_ERROR)

find_program(iwyu_path NAMES include-what-you-use iwyu)

if(NOT iwyu_path)
  message(FATAL_ERROR "Could not find the program include-what-you-use")
else()
  message("Found include-what-you-use")
endif()

function(add_includewhatyouuse EXE_OR_LIB)
    set_property(TARGET ${EXE_OR_LIB} PROPERTY CXX_INCLUDE_WHAT_YOU_USE ${iwyu_path})
endfunction()

