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
