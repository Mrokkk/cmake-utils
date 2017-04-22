function(add_sanitizers_flags)
    set(SANITIZERS_FLAGS "-fsanitize=address,undefined")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${SANITIZERS_FLAGS}" PARENT_SCOPE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SANITIZERS_FLAGS}")
endfunction(add_sanitizers_flags)

