ifeq ($(TARGET_ARCH), linux64) 
SYSTEMC_INCLUDE_DIR = $(SYSTEMC)/include 
BOOST_INCLUDE_DIR = $(BOOST_HOME) 
SYSTEMC_LIB_DIR = $(SYSTEMC)/lib-linux64
else ifeq ($(TARGET_ARCH), x86_64) 
SYSTEMC_INCLUDE_DIR=$(SYSTEMC)/include 
BOOST_INCLUDE_DIR=$(BOOST_HOME) 
SYSTEMC_LIB_DIR=$(SYSTEMC)/lib-linux64
else 
SYSTEMC_INCLUDE_DIR = $(SYSTEMC)/include
BOOST_INCLUDE_DIR = $(BOOST_HOME) 
SYSTEMC_LIB_DIR = $(SYSTEMC)
endif 

CC = g++ 
OPT    = -O3 
DEBUG  = 

MODULE = main 

INCS = $(wildcard *.h) 
CPPS = $(INCS:.h=.o) 
MAINCPP = main.cpp 
MAIN = main 

OBJS = $(CPPS:.cpp=.o) SystemCVectorWriterTrace.o 

INC_PATHS= -I. -I.. -I$(SYSTEMC_INCLUDE_DIR) -I$(WORK)/trunk/src/cdom/ -I$(BOOST_INCLUDE_DIR)
LIB_PATHS =  -L$(SYSTEMC_LIB_DIR) -L$(CURDIR) -L.
LIBS     =  -lsystemc
SHORT_ARCHIVE_NAME = units
ARCHIVE            = lib$(SHORT_ARCHIVE_NAME).a

all: $(ARCHIVE) main

print:
	echo SYSTEMC_LIB_DIR = ${SYSTEMC_LIB_DIR}
	echo BOOST_INCLUDE_DIR = ${BOOST_INCLUDE_DIR}
	echo SYSTEMC_INCLUDE_DIR = ${SYSTEMC_INCLUDE_DIR}
	echo TARGET_ARCH = $(TARGET_ARCH)
	echo BOOST_INCLUDE_DIR = $(BOOST_INCLUDE_DIR)
	echo incs = $(INCS)
	echo srcs = $(SRCS)
	echo objs = $(OBJS)
	echo SHORT_ARCHIVE_NAME = $(SHORT_ARCHIVE_NAME)
	echo ARCHIVE = $(ARCHIVE)

$(ARCHIVE): $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

SystemCVectorWriterTrace.o: $(WORK)/trunk/src/cdom/SystemCVectorWriterTrace.cpp
	$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@

%.o:%.cpp SystemCVectorWriterTrace.o
	$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@

%.o:%.h
	$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@

$(MAIN): $(ARCHIVE)  $(MAINCPP) 
	$(CC) $(CFLAGS) $(INC_PATHS) -L$(SYSTEMC_LIB_DIR) -L. $(MAINCPP)  -l$(SHORT_ARCHIVE_NAME) $(LIBS) -o main 2>&1  | c++filt

clean:
	rm -f $(OBJS) *.a main 
