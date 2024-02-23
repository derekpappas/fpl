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

EXECUTABLE = ssm 

CPPS =
INCS = $(wildcard *.h)
MAINCPP = main.cpp 

OBJS = $(CPPS:.cpp=.o) 
OBJS += $(INCS:.h=.o) 

# the names of the libs passed to -l
A2R_NAME     = a2r
SSM_NAME     = ssm
ME_NAME      = me
SYSTEM_NAME  = system
SUPPORT_NAME = support

# the names of the libs dependencies
A2R_LIB     = $(A2R_DIR)/lib$(A2R_NAME).a
SSM_LIB     = $(SSM_DIR)/lib$(SSM_NAME).a
ME_LIB      = $(ME_DIR)/lib$(ME_NAME).a
SYSTEM_LIB  = $(SYSTEM_DIR)/lib$(SYSTEM_NAME).a
SUPPORT_LIB = $(SUPPORT_DIR)/lib$(SUPPORT_NAME).a
SSM_LIBRARIES = $(A2R_LIB) $(SSM_LIB) $(ME_LIB) $(SYSTEM_LIB) $(SUPPORT_LIB)

# the directories containing libs
A2R_DIR     = ../../$(A2R_NAME)/systemc
SSM_DIR     = ../../$(SSM_NAME)/systemc
ME_DIR      = ../../$(ME_NAME)/systemc
SYSTEM_DIR  = ../../$(SYSTEM_NAME)/systemc
SUPPORT_DIR = ../../$(SUPPORT_NAME)

# the paths to the include directories
A2R_INC     = -I$(A2R_DIR)
SSM_INC     = -I$(SSM_DIR)
ME_INC      = -I$(ME_DIR)
SYSTEM_INC  = -I$(SYSTEM_DIR)
SUPPORT_INC = -I$(SUPPORT_DIR)
SSM_INCLUDE_PATHS = $(A2R_INC) $(SSM_INC) $(ME_INC) $(SYSTEM_INC) $(SUPPORT_INC)
INC_PATHS += -I. -I.. -I$(SYSTEMC_INCLUDE_DIR) -I$(WORK)/trunk/src/cdom/ \
         -I$(BOOST_INCLUDE_DIR) -I$(SUPPORT_DIRECTORY) $(SSM_INCLUDE_PATHS)

# the paths to the library directories
SUPPORT_LIB_PATH = -L$(SUPPORT_DIR)
A2R_LIB_PATH     = -L$(A2R_DIR)
ME_LIB_PATH      = -L$(ME_DIR)
SSM_LIB_PATH     = -L$(SSM_DIR)
SYSTEM_LIB_PATH  = -L$(SYSTEM_DIR)
SSM_LIB_PATHS = $(SUPPORT_LIB_PATH) $(A2R_LIB_PATH) $(ME_LIB_PATH) $(SSM_LIB_PATH) $(SYSTEM_LIB_PATH) 
LIB_PATH =  -L$(SYSTEMC_LIB_DIR) $(SSM_LIB_PATHS)

# the -l args
SSM_LIBS = -l$(A2R_NAME) -l$(SSM_NAME) -l$(ME_NAME) -l$(SYSTEM_NAME) -l$(SUPPORT_NAME)
LIBS     =  -lsystemc -lm $(SSM_LIBS) 

SHORT_ARCHIVE_NAME = ssm
ARCHIVE            = lib$(SHORT_ARCHIVE_NAME).a

all: $(ARCHIVE) $(EXECUTABLE)

print:
	echo SYSTEMC_LIB_DIR = ${SYSTEMC_LIB_DIR}
	echo BOOST_INCLUDE_DIR = ${BOOST_INCLUDE_DIR}
	echo SYSTEMC_INCLUDE_DIR = ${SYSTEMC_INCLUDE_DIR}
	echo TARGET_ARCH = $(TARGET_ARCH)
	echo BOOST_INCLUDE_DIR = $(BOOST_INCLUDE_DIR)
	echo INCS = $(INCS)
	echo srcs = $(SRCS)
	echo objs = $(OBJS)
	echo SHORT_ARCHIVE_NAME = $(SHORT_ARCHIVE_NAME)
	echo ARCHIVE = $(ARCHIVE)

$(ARCHIVE): $(OBJS) 
	$(AR) $(ARFLAGS) $@ $^

%.o:%.cpp
	$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@

%.o:%.h
	$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@

$(EXECUTABLE): $(ARCHIVE)  $(MAINCPP) 
	 $(CC) $(CFLAGS) $(INC_PATHS) $(LIB_PATH) $(MAINCPP) -l$(SHORT_ARCHIVE_NAME) $(LIBS)  -o $(EXECUTABLE) 2>&1 | c++filt

#clean:
#	rm -f $(OBJS) main core 
#
#ultraclean: clean 
#	rm -f Makefile.deps 

