# Copyright 2003 Star Galaxy Publishing
# File: specific_alu_main.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall
CFLAGS = $(OPT) $(OTHER)
# CFLAGS = $(DEBUG) $(OTHER)

MODULE = systemc.run
SRCS = generic_alu.cpp specific_alu_main.cpp
#SRCS = main.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
