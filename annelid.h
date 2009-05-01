#ifndef ANNELID_ANNELID_H
#define ANNELID_ANNELID_H

void
print_error (char* description, char* error);

void*
load_shared_object (char* name);

void
unload_shared_object (void* handle);

void*
resolve_symbol (void* handle, char* name);

#endif
