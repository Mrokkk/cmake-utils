function(add_run_target executable target-name)
    add_custom_target(
        ${target-name}
        DEPENDS ${executable}
        COMMAND ./${executable}
        COMMENT "Running ${executable}"
    )
endfunction(add_run_target)

function(add_valgrind_target executable target-name)
    add_custom_target(
        ${target-name}
        DEPENDS ${executable}
        COMMAND valgrind ./${executable}
        COMMENT "Running ${executable} with Valgrind"
    )
endfunction(add_valgrind_target)

