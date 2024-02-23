#-----------------------------------------------------------------------
# config
#-----------------------------------------------------------------------

# name of the target executable
EXE := testbench
# list of files tp delete when cleaning
TO_CLEAN := *.o $(EXE)
# override compiler flags to give us no break
#CFLAGS := -Wall -ansi -pedantic $(DEBUG)
#CFLAGS := -Wall -ansi -pedantic  testbench.o ../html_template.o -o testbench
CFLAGS := -Wall
# compiler
CC := g++

#-----------------------------------------------------------------------
# main
#-----------------------------------------------------------------------


#-----------------------------------------------------------------------
 # create the list of *.o files based on auto dependencies 
#OBJECTS := $(shell $(CC) -MM $(INCLUDE) *.cpp ../*.cpp | awk -F": " '{ if(NF<2){next;} ;ORS=" "; print $$1}')
OBJECTS := $(shell $(CC) -MM $(INCLUDE) testbench.cpp ../*.cpp | awk -F": " '{ if(NF<2){next;} ;ORS=" "; print $$1}')
#
all: $(EXE) 

# rule to create an object file
#%.o: %.cpp %.h
#	$(CC) $(CFLAGS) $(INCLUDE) $(LIB) -c $<
#%.o: %.cpp ../html_template.cpp

testbench.o: testbench.cpp ../html_template.cpp
	$(CC) $(CFLAGS) -I../ -I. -c $<

# create the executable
$(EXE): $(OBJECTS) 
#$(EXE): testbench.o
	$(CC) $(CFLAGS) $^ -o $@ 

#-----------------------------------------------------------------------

clean:
	-rm -f $(TO_CLEAN)

#-----------------------------------------------------------------------

.PHONY: debug
debug:
	$(MAKE) clean
	$(MAKE) DEBUG="-g -DDEBUG -DDEBUG2 -DDEBUG3"

