gcc    = g++
target = Driver


OM_DIR=../../../om/src
OM_OBJ=$(OM_DIR)/ObjectModel.o
TOOLS_OBJ=$(OM_DIR)/Tools.o
VISITOR_OBJ=$(OM_DIR)/Visitor.o
TEST_OBJS=testTools.o Driver.o
OBJ = $(TEST_OBJS) $(OM_OBJ) $(VISITOR_OBJ) $(TOOLS_OBJ)

CXXFLAGS=-I$(OM_DIR) 

build : $(target)

$(target): $(OBJ)
	$(gcc) -o $(target) $(OBJ)

regress:
	echo "Add commands to run regresss"

clean:
	rm -f $(target) $(OBJ)
