# Copyright (c) 2009, Maximilian Marx <mmarx@wh2.tu-dresden.de>            
                                                                         
# Permission to use, copy, modify, and/or distribute this software for any 
# purpose with or without fee is hereby granted, provided that the above   
# copyright notice and this permission notice appear in all copies.        
                                                                         
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF         
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR  
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES   
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN    
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF  
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

include(LibFindMacros)

find_path(libDL_INCLUDE_DIR NAMES dlfcn.h PATHS /usr/include /usr/local/include)
find_library(libDL_LIBRARY NAMES dl PATHS /usr/lib /usr/local/lib)

set(libDL_PROCESS_INCLUDES libDL_INCLUDE_DIR)
set(libDL_PROCESS_LIBS libDL_LIBRARY)

libfind_process(libDL)
