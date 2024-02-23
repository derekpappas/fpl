#-----------------------------------------------------------------------
# config
#-----------------------------------------------------------------------

ARCH := $(shell arch)
ARCH := $(subst i3,x,$(ARCH))
ARCH := $(subst i6,x,$(ARCH))
# name of the target executable
EXE := interface
# list of files tp delete when cleaning
TO_CLEAN := *.o $(EXE)
# override compiler flags to give us no break
#CFLAGS := -Wall -ansi -pedantic $(DEBUG)
#CFLAGS := -Wall -ansi -pedantic  interface.o ../html_template.o -o interface
CFLAGS := -Wall
# compiler
CC := g++

#-----------------------------------------------------------------------
# main
#-----------------------------------------------------------------------


#-----------------------------------------------------------------------
 # create the list of *.o files based on auto dependencies 
#OBJECTS := $(shell $(CC) -MM $(INCLUDE) *.cpp interface.cpp | awk -F": " '{ if(NF<2){next;} ;ORS=" "; print $$1}')
#
all: $(EXE) 

INCPATH = -I../cslom -I../cslc -I${WORK}/trunk/antlr/lib/cpp -I/usr/local/include/boost-1_38 -I. -I..

LIBS = ../html_template.o\
       ${WORK}/trunk/build/linux/$(ARCH)/cslc/debug/cslc_Typedef.o\
       ${WORK}/trunk/build/linux/$(ARCH)/cslc/debug/new_cslc.o\
       -L${WORK}/trunk/build/linux/$(ARCH)/csl_xml_warn_error -Wl,-Bdynamic -lWE -lCSLC_Errors\
       -L${WORK}/trunk/build/linux/$(ARCH)/preproc -lPreproc\
       -L${WORK}/trunk/build/linux/$(ARCH)/parser/verilog -lVerilogParser\
       -L${WORK}/trunk/build/linux/$(ARCH)/cdom -lCdom\
       -L${WORK}/trunk/build/linux/$(ARCH)/parser/csl -lCslParser\
       -L${WORK}/trunk/build/linux/$(ARCH)/cslom -lCslom\
       -L${WORK}/trunk/build/linux/$(ARCH)/cslom2cdom_adapter -lAdapter\
       -L${WORK}/trunk/build/linux/$(ARCH)/cslom_design_checker -lCslomChecker\
       -L${WORK}/trunk/build/linux/$(ARCH)/cslom_generators -lCslomGen\
       -L${WORK}/trunk/build/linux/$(ARCH)/autorouter -lAR\
       -L${WORK}/trunk/build/linux/$(ARCH)/support -lSupport\
       -L${WORK}/trunk/antlr/lib/cpp/src -lantlr\
       -L/usr/lib64 -lxerces-c\
       -L/usr/local/lib -lboost_filesystem

# rule to create an object file
#%.o: %.cpp %.h
#	$(CC) $(CFLAGS) $(INCLUDE) $(LIB) -c $<
interface.o: interface.cpp ../html_template.cpp
	$(CC) $(CFLAGS) $(INCPATH) -c $<

# create the executable
#$(EXE): $(OBJECTS)
$(EXE): interface.o
	$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

#-----------------------------------------------------------------------

clean:
	rm -f $(TO_CLEAN)

#-----------------------------------------------------------------------

.PHONY: debug
debug:
	$(MAKE) clean
	$(MAKE) DEBUG="-g -DDEBUG -DDEBUG2 -DDEBUG3"

