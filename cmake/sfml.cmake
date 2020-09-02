set(SFML_DIR "/usr/lib/cmake/SFML")

find_package(SFML 2.5 COMPONENTS graphics audio system window REQUIRED)

message("-- SFML version ${SFML_VERSION}")

function(add_sfml EXE_OR_LIB)
  target_link_libraries(${EXE_OR_LIB} sfml-graphics sfml-audio sfml-system sfml-window)
endfunction()
