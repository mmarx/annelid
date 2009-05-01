program annelid_tester
  use, intrinsic :: iso_c_binding

  type (c_ptr) :: handle_a
  type (c_ptr) :: handle_b
  type (c_funptr) :: symbol_a
  type (c_funptr) :: symbol_b

  interface
     integer function signature ()
     end function signature
  end interface

  interface
     function load_shared_object (name) bind (c)
       use, intrinsic :: iso_c_binding
       
       character (kind = c_char, len = *) :: name
       type (c_ptr) :: load_shared_object
     end function load_shared_object

     subroutine unload_shared_object (handle) bind (c)
       use, intrinsic :: iso_c_binding
       
       type (c_ptr), value :: handle
     end subroutine unload_shared_object

     function resolve_symbol (handle, name) bind (c)
       use, intrinsic :: iso_c_binding

       type (c_ptr), value :: handle
       character (kind = c_char, len = *) :: name
       type (c_funptr) :: resolve_symbol       
     end function resolve_symbol
  end interface

  procedure (signature), pointer :: test_a => null ()
  procedure (signature), pointer :: test_b => null ()
  
  write(*, *) 'hello, world!'

  handle_a = load_shared_object ("./libannelid_test_a.so" // char (0))
  handle_b = load_shared_object ("./libannelid_test_b.so" // char (0))

  symbol_a = resolve_symbol (handle_a, "annelid_test" // char (0))
  symbol_b = resolve_symbol (handle_b, "annelid_test" // char (0))

  call c_f_procpointer (symbol_a, test_a)
  call c_f_procpointer (symbol_b, test_b)

  write(*, *) 'got: ', test_a ()
  write(*, *) 'got: ', test_b ()

  nullify (test_a)
  nullify (test_b)

  call unload_shared_object (handle_a)
  call unload_shared_object (handle_b)
end program annelid_tester
