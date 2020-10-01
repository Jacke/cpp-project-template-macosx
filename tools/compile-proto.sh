#!/bin/bash
echo "Compiling .proto files"
CPP_DST_DIR=src/module/proto;
CPP_SRC_DIR=src/module/proto;
protoc -I=$CPP_SRC_DIR --cpp_out=$CPP_DST_DIR $CPP_SRC_DIR/protobuffs.proto


# Note: proto install configured with './configure CC=clang CXX="clang++ -std=c++11 -stdlib=libc++" CXXFLAGS="-O3" --disable-shared'