# sdl2 cmake project-config input for ./configure scripts

set(prefix "/usr/local") 
set(exec_prefix "${prefix}")
set(libdir "/usr/local/lib/aarch64-linux-gnu")
set(SDL2_PREFIX "/usr/local")
set(SDL2_EXEC_PREFIX "/usr/local")
set(SDL2_LIBDIR "/usr/local/lib/aarch64-linux-gnu")
set(SDL2_INCLUDE_DIRS "${prefix}/include/SDL2")
set(SDL2_LIBRARIES "-L${SDL2_LIBDIR} -Wl,-rpath,${libdir} -Wl,--enable-new-dtags -lSDL2")
string(STRIP "${SDL2_LIBRARIES}" SDL2_LIBRARIES)

if(NOT TARGET SDL2::SDL2)
  # Remove -lSDL2 as that is handled by CMake, note the space at the end so it does not replace e.g. -lSDL2main
  # This may require "libdir" beeing set (from above)
  string(REPLACE "-lSDL2 " "" SDL2_EXTRA_LINK_FLAGS "-Wl,-rpath,${libdir} -Wl,--enable-new-dtags -lSDL2 ")
  string(STRIP "${SDL2_EXTRA_LINK_FLAGS}" SDL2_EXTRA_LINK_FLAGS)
  string(REPLACE "-lSDL2 " "" SDL2_EXTRA_LINK_FLAGS_STATIC " -Wl,--no-undefined -lm -ldl -lrga -ldrm -L/home/ark/Development/mesa/release/lib/aarch64-linux-gnu -lgbm -lpthread -lrt ")
  string(STRIP "${SDL2_EXTRA_LINK_FLAGS_STATIC}" SDL2_EXTRA_LINK_FLAGS_STATIC)

  add_library(SDL2::SDL2 SHARED IMPORTED)
  set_target_properties(SDL2::SDL2 PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${prefix}/include/SDL2"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_LOCATION "/usr/local/lib/aarch64-linux-gnu/${CMAKE_SHARED_LIBRARY_PREFIX}SDL2${CMAKE_SHARED_LIBRARY_SUFFIX}"
    INTERFACE_LINK_LIBRARIES "${SDL2_EXTRA_LINK_FLAGS}")

  add_library(SDL2::SDL2-static STATIC IMPORTED)
  set_target_properties(SDL2::SDL2-static PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${prefix}/include/SDL2"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_LOCATION "/usr/local/lib/aarch64-linux-gnu/${CMAKE_STATIC_LIBRARY_PREFIX}SDL2${CMAKE_STATIC_LIBRARY_SUFFIX}"
    INTERFACE_LINK_LIBRARIES "${SDL2_EXTRA_LINK_FLAGS_STATIC}")

  add_library(SDL2::SDL2main STATIC IMPORTED)
  set_target_properties(SDL2::SDL2main PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_LOCATION "/usr/local/lib/aarch64-linux-gnu/${CMAKE_STATIC_LIBRARY_PREFIX}SDL2main${CMAKE_STATIC_LIBRARY_SUFFIX}")
endif()
