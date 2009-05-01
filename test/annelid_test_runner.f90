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

program annelid_test_tester
  use annelid

  interface
     integer function signature ()
     end function signature
  end interface

  type (c_ptr) :: handle_a
  type (c_ptr) :: handle_b
  type (c_funptr) :: symbol_a
  type (c_funptr) :: symbol_b

  procedure (signature), pointer :: test_a => null ()
  procedure (signature), pointer :: test_b => null ()
  
  handle_a = load_shared_object ("./libannelid_test_a.so")
  handle_b = load_shared_object ("./libannelid_test_b.so")

  symbol_a = resolve_symbol (handle_a, "annelid_test")
  symbol_b = resolve_symbol (handle_b, "annelid_test")

  call c_f_procpointer (symbol_a, test_a)
  call c_f_procpointer (symbol_b, test_b)

  write(*, *) 'got: ', test_a ()
  write(*, *) 'got: ', test_b ()

  nullify (test_a)
  nullify (test_b)

  call unload_shared_object (handle_a)
  call unload_shared_object (handle_b)
end program annelid_test_tester
