#!/bin/bash
echo "Compiling .proto files"
CPP_DST_DIR=src/module/libs/proto;
CPP_SRC_DIR=src/module/libs/proto;
protoc -I=$CPP_SRC_DIR --cpp_out=$CPP_DST_DIR $CPP_SRC_DIR/protobuffs.proto