# Copyright 2003 Star Galaxy Publishing
# File: usr_main2.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall -I ../CH7
CFLAGS = $(OPT) $(OTHER)
# CFLAGS = $(DEBUG) $(OTHER)

MODULE = usr.run
SRCS = ../CH7/usr.cpp read_vectors2.cpp check_results.cpp usr_main2.cpp
#SRCS = main.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
