ifeq ($(TARGET_ARCH), linux64)
SYSTEMC_INCLUDE_DIR=$(SYSTEMC_INCLUDE)/include
BOOST_INCLUDE_DIR=$(BOOST_HOME)
SYSTEMC_LIB_DIR=$(SYSTEMC)/lib-linux64
else ifeq ($(TARGET_ARCH), x86_64)
SYSTEMC_INCLUDE_DIR=$(SYSTEMC_INCLUDE)/include
BOOST_INCLUDE_DIR=$(BOOST_HOME)
SYSTEMC_LIB_DIR=$(SYSTEMC)/lib-linux64
else
SYSTEMC_INCLUDE_DIR=$(SYSTEMC_INCLUDE)/include
BOOST_INCLUDE_DIR=$(BOOST_HOME)
SYSTEMC_LIB_DIR=$(SYSTEMC)
endif

CC = g++ 
OPT    = -O3  
DEBUG  =    
CFLAGS = $(DEBUG) $(OPT) -fexceptions 

MODULE = main 

CPPS = MeInstructionDecoder.cpp
INCS = $(wildcard *.h)
MAINCPP = main.cpp 
MAIN = main

OBJS = $(CPPS:.cpp=.o) 
OBJS += $(INCS:.h=.o) 

SUPPORT_DIRECTORY=../../support
INCDIR = -I. -I.. -I$(SYSTEMC_INCLUDE_DIR) -I$(WORK)/trunk/src/cdom/ \
         -I$(BOOST_INCLUDE_DIR) -I$(SUPPORT_DIRECTORY)
LIBDIR = -L$(SYSTEMC_LIB_DIR) 
LIBS   =  -lsystemc -lm $(EXTRA_LIBS) 

all: libme.a $(EXE)

print:
	echo SYSTEMC_LIB_DIR = ${SYSTEMC_LIB_DIR}
	echo BOOST_INCLUDE_DIR = ${BOOST_INCLUDE_DIR}
	echo SYSTEMC_INCLUDE_DIR = ${SYSTEMC_INCLUDE_DIR}
	echo TARGET_ARCH = $(TARGET_ARCH)
	echo BOOST_INCLUDE_DIR = $(BOOST_INCLUDE_DIR)
	echo srcs = $(SRCS)
	echo objs = $(OBJS)

libme.a: $(OBJS) 
	$(AR) $(ARFLAGS) $@ $^

%.o:%.cpp
	$(CC) $(CFLAGS)  $(INCDIR) -c $< -o $@

%.o:%.h
	$(CC) $(CFLAGS)  $(INCDIR) -c $< -o $@

MeInstructionDecoder.o:MeInstructionDecoder.cpp
	$(CC) $(CFLAGS)  $(INCDIR) -c $< -o $@

main: libme.a $(SYSTEMC_LIB_DIR)/libsystemc.a 
	 $(CC) $(CFLAGS) $(INCDIR) $(LIBDIR) -lme $(OBJS) $(LIBS) 2>&1 | c++filt

#clean:
#	rm -f $(OBJS) main core 
#
#ultraclean: clean 
#	rm -f Makefile.deps 

