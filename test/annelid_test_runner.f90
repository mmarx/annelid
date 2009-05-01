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
!> \brief Test case
!> \details This test checks the Fortran part of annelid.

!>
!> \brief Test case
!> \details This tries to load two shared objects, “libannelid_test_a.so”
!> and “libannelid_test_b.so”, looks up the symbol “annelid_test” in each of
!> them and calls the return value as a function of no arguments returning int.
!> Expected output:
!> \verbatim
!> got: 23
!> got: 42
!>\endverbatim
!>

program annelid_test_runner
  use annelid
  implicit none

  !> \brief Function signatures
  !> \details This interface contains the signatures for functions pointers.

  interface
     
     !> \brief Function signature for test fixtures.
     !> \details This specifies the type of function pointers.
     
     integer function signature ()
     end function signature
     
  end interface

  type (c_ptr) :: handle_a !< handle to the first shared object
  type (c_ptr) :: handle_b !< handle to the second shared object
  type (c_funptr) :: symbol_a !< function pointer to the first symbol
  type (c_funptr) :: symbol_b !< function pointer to the second symbol

  procedure (signature), pointer :: test_a => null () !< procedure pointer to the first fixture
  procedure (signature), pointer :: test_b => null () !< procedure pointer to the second fixture
  
  ! load the shared objects
  handle_a = load_shared_object ("./libannelid_test_a.so")
  handle_b = load_shared_object ("./libannelid_test_b.so")

  ! lookup the symbols
  symbol_a = resolve_symbol (handle_a, "annelid_test")
  symbol_b = resolve_symbol (handle_b, "annelid_test")

  ! convert C function pointers to Fortran procedure pointers
  call c_f_procpointer (symbol_a, test_a)
  call c_f_procpointer (symbol_b, test_b)

  ! call functions
  if (c_associated (symbol_a)) then
     write (*, *) 'got: ', test_a ()
  end if
  
  if (c_associated (symbol_b)) then
     write (*, *) 'got: ', test_b ()
  end if

  ! disassociate procedure pointers
  nullify (test_a)
  nullify (test_b)

  ! unload shared objects
  call unload_shared_object (handle_a)
  call unload_shared_object (handle_b)

end program annelid_test_runner
