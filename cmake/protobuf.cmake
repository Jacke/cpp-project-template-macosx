
include(FindProtobuf)
find_package(Protobuf REQUIRED)
include_directories(${PROTOBUF_INCLUDE_DIR})

message("-- Protobuf version ${Protobuf_VERSION}")

function(add_protobuf EXE_OR_LIB)
    target_link_libraries(${EXE_OR_LIB} ${PROTOBUF_LIBRARY})
endfunction()
