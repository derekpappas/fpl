# Copyright 2003 Star Galaxy Publishing
# File: full_adder_main.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall
#CFLAGS = $(OPT) $(OTHER)
CFLAGS = $(DEBUG) $(OTHER)

MODULE = full_adder.run
SRCS = half_adder.cpp full_adder.cpp full_adder_driver.cpp full_adder_monitor.cpp full_adder_main.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
