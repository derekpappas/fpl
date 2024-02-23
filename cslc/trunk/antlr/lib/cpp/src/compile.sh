#!/bin/bash
cd "$1"
if [ -f libantlr.a ];
then
	echo ANTLR library up2date.
else
	echo ANTLR library NOT up2date. Building...
	rm -rf *.o *.a
	gcc -c -I.. *.cpp
	ar q libantlr.a *.o
	echo ANTLR built. Going on...
fi
