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
 * \brief C interface
 * \details This contains the interface of annelid's C part.
 * \author Maximilian Marx
 */

#ifndef ANNELID_ANNELID_H
#define ANNELID_ANNELID_H

/**
 * \brief Prints an error message.
 * \details Outputs an error message of the format
 * “[annelid] (description) failed: (error)”
 *
 * \param description which action failed
 * \param error error message
 */

void
print_error (char* description, char* error);

/**
 * \brief Loads a shared object.
 * \details Loads the named shared object file
 * and returns a handle to it.
 * The object is loaded with flags RTLD_LAZY
 * and RTLD_LOCAL to prevent name clashes
 * when loading multiple objects containing the
 * same symbols.
 *
 * \param name shared object file name.
 * \return handle to the shared object, or NULL
 * in case of error.
 */

void*
load_shared_object (char* name);

/**
 * \brief Unloads a shared object.
 * \details Unloads the shared object specified
 * by the given handle.
 *
 * \param handle shared object to unload.
 */

void
unload_shared_object (void* handle);

/**
 * \brief Finds a symbol in a shared object.
 * \details Looks up a symbol with the given
 * name in the given shared object and returns
 * it's address.
 *
 * \param handle shared object to search in.
 * \param name symbol name to look for.
 * \return address of the symbol, or NULL if no such symbol was found.
 */

void*
resolve_symbol (void* handle, char* name);

#endif
