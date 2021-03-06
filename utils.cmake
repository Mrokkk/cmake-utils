function(add_run_target executable target-name)
    add_custom_target(
        ${target-name}
        DEPENDS ${executable}
        COMMAND ./${executable} ${ARGV2}
        COMMENT "Running ${executable}"
    )
endfunction(add_run_target)

function(add_valgrind_target executable target-name)
    add_custom_target(
        ${target-name}
        DEPENDS ${executable}
        COMMAND valgrind --error-exitcode=1 --leak-check=full ./${executable} ${ARGV2}
        COMMENT "Running ${executable} with Valgrind"
    )
endfunction(add_valgrind_target)

