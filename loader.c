#include <stdio.h>

#include "annelid.h"

int
main (int argc, char** argv)
{
  typedef int (*signature) ();

  void* so_a = NULL;
  void* so_b = NULL;
  void* fct_a = NULL;
  void* fct_b = NULL;

  int retval = 0;

  so_a = load_shared_object ("./libannelid_test_a.so");
  so_b = load_shared_object ("./libannelid_test_b.so");
  fct_a = resolve_symbol (so_a, "annelid_test");
  fct_b = resolve_symbol (so_b, "annelid_test");

  if (NULL != fct_a)
    {
      retval = ((signature) fct_a) ();
      printf ("got: %d\n", retval);
    }

  if (NULL != fct_b)
    {
      retval = ((signature) fct_b) ();
      printf ("got: %d\n", retval);
    }

  unload_shared_object (so_a);
  unload_shared_object (so_b);

  return 0;
}
