module annelid_test_b
  use, intrinsic :: iso_c_binding
contains
  pure function annelid_test () bind(c)
    integer (kind = c_int) :: annelid_test

    annelid_test = 42
  end function annelid_test
end module annelid_test_b
