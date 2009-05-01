module annelid_test_a
  use, intrinsic :: iso_c_binding
contains
  pure function annelid_test () bind(c)
    integer (kind = c_int) :: annelid_test

    annelid_test = 23
  end function annelid_test
end module annelid_test_a
