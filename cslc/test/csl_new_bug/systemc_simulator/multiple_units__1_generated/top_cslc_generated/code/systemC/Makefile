ifeq ($(TARGET_ARCH), linux64)
#SYSTEMC_INCLUDE_DIR=$(SYSTEMC_INCLUDE)/include
SYSTEMC_INCLUDE_DIR=$(SYSTEMC)/include
BOOST_INCLUDE_DIR=$(BOOST_HOME)
SYSTEMC_LIB_DIR=$(SYSTEMC)/lib-linux64
else ifeq ($(TARGET_ARCH), x86_64)
#SYSTEMC_INCLUDE_DIR=$(SYSTEMC_INCLUDE)/include
SYSTEMC_INCLUDE_DIR=$(SYSTEMC)/include
BOOST_INCLUDE_DIR=$(BOOST_HOME)
SYSTEMC_LIB_DIR=$(SYSTEMC)/lib-linux64
else
#SYSTEMC_INCLUDE_DIR=$(SYSTEMC_INCLUDE)/include
SYSTEMC_INCLUDE_DIR=$(SYSTEMC)/include
BOOST_INCLUDE_DIR=$(BOOST_HOME)
SYSTEMC_LIB_DIR=$(SYSTEMC)
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

# the names of the libs passed to -l
#A2R_NAME     = a2r
#SSM_NAME     = ssm
#ME_NAME      = me
#SYSTEM_NAME  = system
#SUPPORT_NAME = support
###a_name = a
###b_name = b
###c_name = c
###top_name = top

# the names of the libs dependencies
#A2R_LIB     = $(A2R_DIR)/lib$(A2R_NAME).a
#SSM_LIB     = $(SSM_DIR)/lib$(SSM_NAME).a
#ME_LIB      = $(ME_DIR)/lib$(ME_NAME).a
#SYSTEM_LIB  = $(SYSTEM_DIR)/lib$(SYSTEM_NAME).a
#SUPPORT_LIB = $(SUPPORT_DIR)/lib$(SUPPORT_NAME).a
#SSM_LIBRARIES = $(A2R_LIB) $(SSM_LIB) $(ME_LIB) $(SYSTEM_LIB) $(SUPPORT_LIB)
###a_lib = $(CURDIR)/lib$(a_name).a
###b_lib = $(CURDIR)/lib$(b_name).a
###c_lib = $(CURDIR)/lib$(c_name).a
###top_lib = $(CURDIR)/lib$(top_name).a

# the directories containing libs
#A2R_DIR     = ../../$(A2R_NAME)/systemc
#SSM_DIR     = ../../$(SSM_NAME)/systemc
#ME_DIR      = ../../$(ME_NAME)/systemc
#SYSTEM_DIR  = ../../$(SYSTEM_NAME)/systemc
#SUPPORT_DIR = ../../$(SUPPORT_NAME)

# the paths to the include directories
#A2R_INC     = -I$(A2R_DIR)
#SSM_INC     = -I$(SSM_DIR)
#ME_INC      = -I$(ME_DIR)
#SYSTEM_INC  = -I$(SYSTEM_DIR)
#SUPPORT_INC = -I$(SUPPORT_DIR)
#SSM_INCLUDE_PATHS = $(A2R_INC) $(SSM_INC) $(ME_INC) $(SYSTEM_INC) $(SUPPORT_INC)
INC_PATHS= -I. -I.. -I$(SYSTEMC_INCLUDE_DIR) -I$(WORK)/trunk/src/cdom/ \
         -I$(BOOST_INCLUDE_DIR)
#$(SSM_INCLUDE_PATHS)

# the paths to the library directories
###A2R_LIB_PATH     = -L$(A2R_DIR)
###SSM_LIB_PATH     = -L$(SSM_DIR)
###ME_LIB_PATH      = -L$(ME_DIR)
###SYSTEM_LIB_PATH  = -L$(SYSTEM_DIR)
###SUPPORT_LIB_PATH = -L$(SUPPORT_DIR)
###SSM_LIB_PATHS = $(A2R_LIB_PATH) $(SSM_LIB_PATH) $(ME_LIB_PATH) $(SYSTEM_LIB_PATH) $(SUPPORT_LIB_PATH)
LIB_PATHS =  -L$(SYSTEMC_LIB_DIR) -L$(CURDIR) -L.
#$(SSM_LIB_PATHS)

# the -l args
#SSM_LIBS = -l$(A2R_NAME) -l$(SSM_NAME) -l$(ME_NAME) -l$(SYSTEM_NAME) -l$(SUPPORT_NAME)
#CURRENT_LIBS = -l$(a_name) -l$(b_name) -l$(c_name) -l$(top_name)
LIBS     =  -lsystemc 
#$(CURRENT_LIBS)
# -lm $(SSM_LIBS) 

#SHORT_ARCHIVE_NAME = me
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
#	 $(CC) $(CFLAGS) $(INC_PATHS) $(LIB_PATHS) $(MAINCPP) $(LIBS) -l$(SHORT_ARCHIVE_NAME) -o main 2>&1 | c++filt
	 $(CC) $(CFLAGS) $(INC_PATHS) -L$(SYSTEMC_LIB_DIR) -L. $(MAINCPP)  -l$(SHORT_ARCHIVE_NAME) $(LIBS) -o main 2>&1  | c++filt

clean:
	rm -f $(OBJS) *.a main 
#
#ultraclean: clean 
#	rm -f Makefile.deps 

