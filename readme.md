# A C++ 17 project template for macosx

## Includes

- Boost
- CCache
- Clang-tidy
- As many compiler warnings as possible
- Protocol buffers (must be installed as library)
- SFML (must be installed as library, can use homebrew)
- SPDLOG (must be installed as library)
- GTest (must be installed as library)
- Rapidcheck
- include-what-you-use (must be installed, can use homebrew)
- Doxygen (must be installed, can use homebrew) #Untested, TODO: test
- A coverage module (uses xcode)

## To enable protocol buffers:

Edit src/module/CMakeLists.txt


## TODO:
There is an issue with vscode c++ TestMate extension not detecting rapidcheck tests