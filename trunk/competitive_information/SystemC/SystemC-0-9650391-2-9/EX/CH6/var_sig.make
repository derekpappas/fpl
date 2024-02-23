# Copyright 2003 Star Galaxy Publishing
# File: var_sig.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall
CFLAGS = $(OPT) $(OTHER)
# CFLAGS = $(DEBUG) $(OTHER)

MODULE = systemc.run
SRCS = var_sig.cpp
#SRCS = main.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
