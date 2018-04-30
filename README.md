# minixmld
a D wrapper for the minixml library


# to compile and install the library
call `make` to compile the library and call `install.sh` to install the
neccessary include files and shared object file. The include files are placed
into `/usr/include` and the shared object file is placed into `/usr/lib`.
Successfuly compilation of the library will require that linkages to `baselib`,
`minixml` and `pthread` be available on the compiling machine.

# to compile against the library
add linkages as follows `-lminixmld -lminixml -lbaselib -lpthread` when
compiling against the library.


