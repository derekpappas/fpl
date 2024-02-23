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

CPPS = $(wildcard *.cpp)
INCS = 
MAINCPP = main.cpp 
MAIN = main

OBJS = $(CPPS:.cpp=.o) 
OBJS += 

SUPPORT_DIRECTORY=../../support
INCDIR = -I. -I.. -I$(SYSTEMC_INCLUDE_DIR) \
         -I$(BOOST_INCLUDE_DIR) -I$(SUPPORT_DIRECTORY)
LIBDIR = -L. -L$(SYSTEMC_LIB_DIR) -L$(SUPPORT_DIRECTORY)

LIBS   = -l$(SHORT_ARCHIVE_NAME) -lsupport -lsystemc -lm


SHORT_ARCHIVE_NAME=support
ARCHIVE    = lib$(SHORT_ARCHIVE_NAME).a

all: $(OBJS) $(ARCHIVE)

print:
	echo SYSTEMC_LIB_DIR = ${SYSTEMC_LIB_DIR}
	echo BOOST_INCLUDE_DIR = ${BOOST_INCLUDE_DIR}
	echo SYSTEMC_INCLUDE_DIR = ${SYSTEMC_INCLUDE_DIR}
	echo TARGET_ARCH = $(TARGET_ARCH)
	echo BOOST_INCLUDE_DIR = $(BOOST_INCLUDE_DIR)
	echo objs = $(OBJS)
	echo SHORT_ARCHIVE_NAME = $(SHORT_ARCHIVE_NAME)
	echo ARCHIVE = $(ARCHIVE)

$(ARCHIVE): $(OBJS) 
	$(AR) $(ARFLAGS) $@ $^

%.o:%.cpp
	$(CC) $(CFLAGS)  $(INCDIR) -c $< -o $@

%.o:%.h
	$(CC) $(CFLAGS)  $(INCDIR) -c $< -o $@

$(MAIN): $(ARCHIVE) $(MAINCPP)
	 $(CC) $(CFLAGS) $(INCDIR) $(LIBDIR) $(MAINCPP) $(LIBS) 2>&1 | c++filt

#clean:
#	rm -f $(OBJS) main core 
#
#ultraclean: clean 
#	rm -f Makefile.deps 

