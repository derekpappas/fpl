# Copyright 2003 Star Galaxy Publishing
# File: test.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall
CFLAGS = $(OPT) $(OTHER)
# CFLAGS = $(DEBUG) $(OTHER)

MODULE = systemc.run
SRCS = test.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
