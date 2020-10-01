cmake_minimum_required(VERSION 3.18)


project(cpp-template-macosx)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -stdlib=libc++ -lc++abi -L/usr/local/lib -lprotobuf")
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS_DEBUG "-g -fsanitize=address")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")
set(CMAKE_LINK_DEPENDS_NO_SHARED ON)


include(cmake/clang-tidy.cmake)
include(cmake/tests.cmake)

include(cmake/rapidcheck.cmake)
include(cmake/compiler-warnings.cmake)
include(cmake/ccache.cmake)
include(cmake/boost.cmake)
include(cmake/spdlog.cmake)
include(cmake/protobuf.cmake)
include(cmake/sfml.cmake)
include(cmake/includewhatyouuse.cmake)

add_subdirectory(src)
