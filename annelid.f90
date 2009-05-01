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

!> \file
!> \brief Fortran interface and implementation
!> \details This contains the fortran part of annelid.
!> \author Maximilian Marx

!> \brief annelid - fortran shared object loading
!> \details This contains both annelid's internals and it's public interface.

module annelid

  use, intrinsic :: iso_c_binding
  implicit none 

  private
  public :: load_shared_object, unload_shared_object, resolve_symbol, &
       & c_char, c_ptr, c_funptr, c_f_procpointer, c_null_ptr, c_null_funptr, &
       & c_null_char, c_associated


  !> \brief Interface definition for external C functions.
  !> \details This interface defines the C functions called to wrap libdl.

  interface
     
     !> \brief Wraps \ref load_shared_object.
     !> \details Interface for \ref load_shared_object.
     !>
     !> \param name null-terminated character array of c_char kind
     !> \return c_ptr handle

     function do_load_shared_object (name) bind (c, name = "load_shared_object")
       use, intrinsic :: iso_c_binding
       
       character (kind = c_char), dimension (*) :: name
       type (c_ptr) :: do_load_shared_object
     end function do_load_shared_object

     !> \brief Wraps \ref unload_shared_object.
     !> \details Interface for \ref unload_shared_object.
     !>
     !> \param handle c_ptr handle from \ref do_load_shared_object

     subroutine do_unload_shared_object (handle) bind (c, name = "unload_shared_object")
       use, intrinsic :: iso_c_binding
       
       type (c_ptr), value :: handle
     end subroutine do_unload_shared_object

     !> \brief Wraps \ref resolve_symbol.
     !> \details Interface for \ref resolve_symbol.
     !>
     !> \param handle c_ptr handle from \ref do_load_shared_object
     !> \param name null-terminated character array of c_char kind
     !> \return c_funptr function pointer

     function do_resolve_symbol (handle, name) bind (c, name = "resolve_symbol")
       use, intrinsic :: iso_c_binding

       type (c_ptr), value :: handle
       character (kind = c_char), dimension (*) :: name
       type (c_funptr) :: do_resolve_symbol       
     end function do_resolve_symbol

  end interface

contains

  !> \brief Loads a shared object.
  !> \details Loads the given shared object and returns a handle to it.
  !>
  !> \param name the shared object file to load.
  !> \return handle to the shared object.

  function load_shared_object (name)
    character (kind = c_char, len = *), intent(in) :: name
    type (c_ptr) :: load_shared_object

    load_shared_object = do_load_shared_object (name // c_null_char)
  end function load_shared_object

  !> \brief Unloads a shared object.
  !> \details Unloads the given shared object.
  !>
  !> \param handle the shared object to unload.

  subroutine unload_shared_object (handle)
    type (c_ptr), intent(in) :: handle

    call do_unload_shared_object (handle)
  end subroutine unload_shared_object
  
  !> \brief Finds a symbol in a shared object.
  !> \details Looks up a symbol with the given name in a given shared
  !> object and returns it's address.
  !>
  !> \param handle the shared object to search in.
  !> \param name the symbol name to look up.
  !>
  !> \return address of the symbol, or C_NULL_PTR if no such symbol was found.

  function resolve_symbol (handle, name)
    type (c_ptr) :: handle
    character (kind = c_char, len = *) :: name
    type (c_funptr) :: resolve_symbol
    intent(in) :: handle, name

    resolve_symbol = do_resolve_symbol (handle, name // c_null_char)
  end function resolve_symbol

end module annelid
