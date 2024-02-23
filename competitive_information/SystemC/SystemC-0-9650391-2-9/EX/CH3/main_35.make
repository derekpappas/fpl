# Copyright 2003 Star Galaxy Publishing
# File: main_35.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall
CFLAGS = $(OPT) $(OTHER)
# CFLAGS = $(DEBUG) $(OTHER)

MODULE = systemc.run
SRCS = main_35.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
