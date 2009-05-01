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
!> \brief Test fixture
!> \details Specifies a shared object that is used as a test fixture.
!> \author Maximilian Marx

!> \brief Test fixture
!> \details This module contains a test fixture that exports annelid_test.

module annelid_test_a

  use, intrinsic :: iso_c_binding
  implicit none
  
  private
  public :: annelid_test

contains

  !> \brief Returns 23
  !> \details Test fixture that returns 23.
  !>
  !> \return always 23.

  pure function annelid_test () bind(c)
    integer (kind = c_int) :: annelid_test

    annelid_test = 23
  end function annelid_test

end module annelid_test_a
