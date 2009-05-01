! annelid - fortran shared object loading
! “The Many sings to us.”
!
! Copyright (c) 2009, Maximilian Marx <mmarx@wh2.tu-dresden.de>

! Permission to use, copy, modify, and/or distribute this software for any
! purpose with or without fee is hereby granted, provided that the above
! copyright notice and this permission notice appear in all copies.

! THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
! WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
! MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
! ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
! WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
! ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
! OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

module annelid
  use, intrinsic :: iso_c_binding
  private
  public :: load_shared_object, unload_shared_object, resolve_symbol, &
       & c_char, c_ptr, c_funptr, c_f_procpointer, c_null_ptr, c_null_funptr, &
       & c_null_char

  interface
     function do_load_shared_object (name) bind (c, name = "load_shared_object")
       use, intrinsic :: iso_c_binding
       
       character (kind = c_char, len = *) :: name
       type (c_ptr) :: do_load_shared_object
     end function do_load_shared_object

     subroutine unload_shared_object (handle) bind (c)
       use, intrinsic :: iso_c_binding
       
       type (c_ptr), value :: handle
     end subroutine unload_shared_object

     function do_resolve_symbol (handle, name) bind (c, name = "resolve_symbol")
       use, intrinsic :: iso_c_binding

       type (c_ptr), value :: handle
       character (kind = c_char, len = *) :: name
       type (c_funptr) :: do_resolve_symbol       
     end function do_resolve_symbol
  end interface

contains
  function load_shared_object (name)
    character (kind = c_char, len = *) :: name
    type (c_ptr) :: load_shared_object

    load_shared_object = do_load_shared_object (name // c_null_char)
    
  end function load_shared_object

  function resolve_symbol (handle, name)
    type (c_ptr), value :: handle
    character (kind = c_char, len = *) :: name
    type (c_funptr) :: resolve_symbol

    resolve_symbol = do_resolve_symbol (handle, name // c_null_char)
    
  end function resolve_symbol

end module annelid
