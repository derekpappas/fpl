# Copyright 2003 Star Galaxy Publishing
# File: driver_bank.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall
CFLAGS = $(OPT) $(OTHER)
# CFLAGS = $(DEBUG) $(OTHER)

MODULE = systemc.run
SRCS = driver_bank.cpp
#SRCS = main.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
