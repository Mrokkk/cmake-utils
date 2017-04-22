function(add_coverage_flags)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        set(COVERAGE_FLAGS "-O0 -fprofile-instr-generate -fcoverage-mapping -fno-inline")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lgcov" PARENT_SCOPE)
    else()
        set(COVERAGE_FLAGS "-O0 -fprofile-arcs -ftest-coverage -fno-inline -fno-inline-small-functions -fno-default-inline")
    endif()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COVERAGE_FLAGS}" PARENT_SCOPE)
endfunction(add_coverage_flags)

function(add_coverage_targets executable run-target prefix source-dir)
    add_custom_target(clean-coverage
        COMMAND find ${CMAKE_BINARY_DIR} -name '*.gcda' -exec rm {} "\;"
        DEPENDS ${executable}
        COMMENT "Cleaning coverage data"
        PARENT_SCOPE)
    add_dependencies(${prefix}-run clean-coverage)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        add_custom_target(tests-cov
            DEPENDS ${executable}
            COMMAND LLVM_PROFILE_FILE=tests.profdata ./${executable}
            COMMAND llvm-profdata merge -instr tests.profdata -o merged.profdata
            COMMAND llvm-cov report ./${executable} -instr-profile=merged.profdata
            COMMENT "Running LLVM coverage generating" PARENT_SCOPE)
    else()
        add_custom_target(${prefix}-cov
            COMMAND gcovr -r ${source-dir} ${CMAKE_BINARY_DIR}
            DEPENDS ${run-target}
            COMMENT "Running GCOVR coverage generating" PARENT_SCOPE)
        add_custom_target(${prefix}-cov-html
            COMMAND gcovr --html --html-details -o ${prefix}-cov.html -r ${source-dir} ${CMAKE_BINARY_DIR}
            DEPENDS ${run-target}
            COMMENT "Running GCOVR coverage generating (HTML)" PARENT_SCOPE)
    endif()
endfunction(add_coverage_targets)

