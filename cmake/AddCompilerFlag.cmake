include (CheckCXXCompilerFlag)
macro(AddCompilerFlag _flag)
   string(REGEX REPLACE "[/:= ]" "_" _flag_esc "${_flag}")
   check_cxx_compiler_flag("${_flag}" check_compiler_flag_${_flag_esc})
   if(check_compiler_flag_${_flag_esc})
      set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${_flag}")
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${_flag}")
   endif(check_compiler_flag_${_flag_esc})
   if(${ARGC} EQUAL 2)
      set(${ARGV1} "${check_compiler_flag_${_flag_esc}}")
   endif(${ARGC} EQUAL 2)
endmacro(AddCompilerFlag)
