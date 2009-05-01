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
