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

OPTION(COVERAGE "Enable code coverage" OFF)
OPTION(COVERAGE_TEXT "Show text summary of the coverage" ON)
OPTION(COVERAGE_LCOV "Export coverage data in lcov trace file" OFF)
OPTION(COVERAGE_HTML "Detailed html report of the coverage" OFF)

set(COVERAGE_EXCLUDE_REGEX "([^/]+\.pb\.(cc|h))")
set(COVERAGE_PATH ${PROJECT_BINARY_DIR}/coverage)

if (COVERAGE)
  message(STATUS "Code coverage is enabled. TEXT=${COVERAGE_TEXT}, LCOV=${COVERAGE_LCOV}, HTML=${COVERAGE_HTML}")

  find_program(LLVM_COV_PATH NAMES xcrun REQUIRED)
  find_program(LLVM_PROFDATA_PATH NAMES xcrun REQUIRED)

  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fprofile-instr-generate -fcoverage-mapping")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping")

  set(COVERAGE_TARGETS ${COVERAGE_PATH}/targets.list)
  set(COVERAGE_PROFDATA ${COVERAGE_PATH}/all.profdata)
  mark_as_advanced(COVERAGE_TARGETS COVERAGE_PROFDATA)
endif()

function(add_coverage TARGET)
  if (NOT COVERAGE)
    return()
  endif()

  if (NOT TARGET coverage)
    add_custom_target(coverage-clear
      COMMAND ${CMAKE_COMMAND} -E rm -rf ${COVERAGE_PATH}
      COMMAND ${CMAKE_COMMAND} -E make_directory ${COVERAGE_PATH}
    )

    add_custom_target(coverage-profdata
      COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE="${COVERAGE_PATH}/test_%p.profraw" ${CMAKE_CTEST_COMMAND} ${CMAKE_CTEST_ARGUMENTS}
      COMMAND ${LLVM_PROFDATA_PATH} llvm-profdata merge -sparse ${COVERAGE_PATH}/*.profraw -o ${COVERAGE_PROFDATA}
      WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    )

    add_custom_target(coverage)

    if (COVERAGE_TEXT)
      add_custom_target(coverage-text
        COMMAND ${LLVM_COV_PATH} llvm-cov report `cat ${COVERAGE_TARGETS}` -instr-profile=${COVERAGE_PROFDATA} -ignore-filename-regex="${COVERAGE_EXCLUDE_REGEX}"
        DEPENDS coverage-profdata
      )
      add_dependencies(coverage coverage-text)
    endif()

    if (COVERAGE_HTML)
      add_custom_target(coverage-html
        COMMAND ${LLVM_COV_PATH} llvm-cov show `cat ${COVERAGE_TARGETS}` -instr-profile=${COVERAGE_PROFDATA} -show-line-counts-or-regions -output-dir=${COVERAGE_PATH}/html -format="html" -ignore-filename-regex="${COVERAGE_EXCLUDE_REGEX}"
        DEPENDS coverage-profdata
      )
      add_dependencies(coverage coverage-html)
    endif()

    if (COVERAGE_LCOV)
      add_custom_target(coverage-lcov
        COMMAND ${LLVM_COV_PATH} llvm-cov export `cat ${COVERAGE_TARGETS}` -format="lcov" -instr-profile=${COVERAGE_PROFDATA} -ignore-filename-regex="${COVERAGE_EXCLUDE_REGEX}" > ${COVERAGE_PATH}/lcov.info
        DEPENDS coverage-profdata
      )
      add_dependencies(coverage coverage-lcov)
    endif()
  endif()

  add_custom_target(coverage-${TARGET}
    COMMAND ${CMAKE_COMMAND} -E echo "-object=$<TARGET_FILE:${TARGET}>" >> ${COVERAGE_TARGETS}
    DEPENDS coverage-clear
  )
  add_dependencies(coverage-profdata coverage-${TARGET})

endfunction()
