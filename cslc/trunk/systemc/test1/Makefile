#CC=/usr/bin/g++
MAKEPATH=.
CDOMLIBPATH=$$WORK/trunk/build/linux/x86_64/cdom/

GENPATHOBJ=cdom/
GENNAME=gen
USERPATHOBJ=cdom/user/
MAINFILE=main.cpp
EXECUTABLE=vectorWriter

INCLUDES+=-I$$WORK/trunk/src/cdom
INCLUDES+=-I/opt/tools/systemc/systemc-2.2.0/objdir/include
INCLUDES+=-I/opt/tools/systemc/systemc-2.2.0/src/sysc/tracing
CFLAGS=-g -Wall

CC=gcc

ODIR=obj
LDIR =${CDOMLIBPATH}

LIBS=-lm
LIBS+=CDOM_Library

_DEPS = exor2.h	mon.h	nand2.h	stim.h

IDIR=.

DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

OBJ = exor2.o	mon.o	nand2.o	stim.o

all: vectorWriter

print: 
	echo CC = ${CC}
	echo CFLAGS = ${CFLAGS}
	echo deps = ${DEPS}
	echo includes = ${INCLUDES}

mon.o : mon.cpp mon.h
	gcc ${INCLUDES} mon.cpp -o mon.o $(CFLAGS)  



%.o: %.c 
	gcc ${INCLUDES} -c -o $@ $< $(CFLAGS)  

vectorWriter: $(OBJ)
	gcc -o $@ $^ ${INCLUDES} $(CFLAGS) $(LIBS)  

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 
