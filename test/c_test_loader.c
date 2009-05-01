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
 * \brief C test program
 * \details This test checks the C part of annelid.
 * \author Maximilian Marx
 */

#include <stdio.h>

#include "annelid.h"

/**
 * \brief Test case
 * \details This tries to load two shared objects, “libannelid_test_a.so”
 * and “libannelid_test_b.so”, looks up the symbol “annelid_test” in each of
 * them and calls the return value as a function of no arguments returning int.
 * Expected output:
 * \verbatim
got: 23
got: 42
\endverbatim
 *
 * \param argc Number of command line arguments specified.
 * \param argv Array of command line arguments.
 * \return 0 if nothing went wrong.
 */

int
main (int argc, char** argv)
{
  typedef int (*signature) (); /**< Function pointer signature */

  void* so_a = NULL; /**< handle for the first shared object */
  void* so_b = NULL; /**< handle for the second shared object */
  void* fct_a = NULL; /**< pointer to the first symbol */
  void* fct_b = NULL; /**< pointer to the second symbol */

  int retval = 0; /**< return value */

  /* load the shared objects */
  so_a = load_shared_object ("./libannelid_test_a.so");
  so_b = load_shared_object ("./libannelid_test_b.so");

  /* look up the symbols */
  fct_a = resolve_symbol (so_a, "annelid_test");
  fct_b = resolve_symbol (so_b, "annelid_test");

  /* call functions */
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

  /* unload the shared objects */
  unload_shared_object (so_a);
  unload_shared_object (so_b);

  return 0;
}
