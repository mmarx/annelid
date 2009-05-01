/* annelid - fortran shared object loading
 * “The Many sings to us.”
 *
 * Copyright (c) 2009, Maximilian Marx <mmarx@wh2.tu-dresden.de>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.

 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

/**
 *\file
 * \brief C implementation
 * \details This contains the implementation of annelid's C part.
 * \author Maximilian Marx
 */

#include <dlfcn.h>
#include <stdio.h>

#include "annelid.h"

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
