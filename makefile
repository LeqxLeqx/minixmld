

SRC_FILES=$(wildcard src/minixmld/*.d) \
          $(wildcard src/minixmld/c/*.d) \
          $(wildcard src/minixmld/c/baselib/*.d)
INTER_FILES=$(SRC_FILES:.d=.o)
OBJ_FILES=$(addprefix bin/, $(INTER_FILES:src/%=%))
CC=gdc
LIBCC=gcc
CFLAGS=-g -Wall -fPIC -lbaselib -lpthread -lminixml -Isrc
LIB_NAME=bin/libminixmld.so

.PHONY : all
all : bin $(OBJ_FILES)
	$(LIBCC) $(CFLAGS) $(OBJ_FILES) -shared -o $(LIB_NAME)

bin/%.o : src/%.d bin
	$(CC) $(CFLAGS) -c $< -o $@


bin :
	mkdir bin
	mkdir bin/minixmld
	mkdir bin/minixmld/c
	mkdir bin/minixmld/c/baselib

.PHONY : clean
clean :
	rm -fr bin


