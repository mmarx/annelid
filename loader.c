#include <dlfcn.h>
#include <stdio.h>

void
print_error (char* description, char* error)
{
  fprintf (stderr, "[annelid]: %s failed: %s.\n", description, error);
}

void*
load_shared_object (char* name)
{
  void* handle = NULL;

  handle = dlopen (name, (RTLD_LAZY | RTLD_LOCAL));

  if (NULL == handle)
    {
      print_error ("dlopen", dlerror ());
    }

  return handle;
}

void
unload_shared_object (void* handle)
{
  if (NULL != handle)
    {
      if (dlclose (handle))
	{
	  print_error ("dlclose", dlerror ());
	}
    }
}

void*
resolve_symbol (void* handle, char* name)
{
  char* error = NULL;
  void* symbol = NULL;

  if (NULL != handle)
    {
      dlerror ();
      symbol = dlsym (handle, name);
      error = dlerror ();

      if (NULL != error)
	{
	  print_error ("dlsym", error);
	}
    }

  return symbol;
}

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
