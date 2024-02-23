# Copyright 2003 Star Galaxy Publishing
# File: sync_mux41_main.make

TARGET_ARCH = gccsparcOS5

CC     = g++
OPT    = -O3
DEBUG  = -g
OTHER  = -Wall
CFLAGS = $(OPT) $(OTHER)
# CFLAGS = $(DEBUG) $(OTHER)

MODULE = sync_mux41.run
SRCS = sync_mux41.cpp sync_mux41_driver.cpp sync_mux41_monitor.cpp sync_mux41_main.cpp
OBJS = $(SRCS:.cpp=.o)

include ../Makefile.defs
