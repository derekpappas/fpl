# Copyright 2003 Star Galaxy Publishing
# File: simple_alu.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall
CFLAGS = $(OPT) $(OTHER)
# CFLAGS = $(DEBUG) $(OTHER)

MODULE = systemc.run
SRCS = simple_alu.cpp
#SRCS = main.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
