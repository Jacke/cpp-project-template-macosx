#[[
MIT License

Copyright (c) 2020 Ivan Safonov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#]]

OPTION(TESTS "Enable tests" ON)
set(TESTS_BUNARY_PREFIX "test_")
set(TESTS_RUN_TIMEOUT "10")
set(TESTS_PARALLEL "8")

if(TESTS)
  message(STATUS "Tests are enabled")
  set(CMAKE_CTEST_ARGUMENTS "-j;${TESTS_PARALLEL};--output-on-failure;--timeout;${TESTS_PARALLEL}")
  find_package(GTest REQUIRED CONFIG)
  include(GoogleTest)
  enable_testing()
endif()

function(add_unit_test TEST_NAME)
  if(NOT TESTS)
    return()
  endif()

  set(multiValueArgs LIBS)
  cmake_parse_arguments(TEST "" "" "${multiValueArgs}" ${ARGN})
  set(TEST_NAME "${TESTS_BUNARY_PREFIX}${TEST_NAME}")

  add_executable(${TEST_NAME} ${TEST_UNPARSED_ARGUMENTS})
  target_link_libraries(${TEST_NAME} GTest::gtest_main ${TEST_LIBS})
  gtest_discover_tests(${TEST_NAME})
endfunction()

function(add_mocks TARGET)
  if(NOT TESTS)
    return()
  endif()

  set(multiValueArgs LIBS)
  cmake_parse_arguments(MOCK "" "" "${multiValueArgs}" ${ARGN})

  add_library(${TARGET} SHARED ${MOCK_UNPARSED_ARGUMENTS})
  target_link_libraries(${TARGET} GTest::gmock ${MOCK_LIBS})
endfunction()
