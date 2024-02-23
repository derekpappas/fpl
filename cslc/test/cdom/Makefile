gcc    = g++
target = Driver

CDOM_DIR=../../../trunk/src/cdom
#OM_OBJ=$(OM_DIR)/ObjectModel.o
#TOOLS_OBJ=$(OM_DIR)/Tools.o
#VISITOR_OBJ=$(OM_DIR)/Visitor.o
CDOM_OBJS = $(CDOM_DIR)/CDOM.o $(CDOM_DIR)/VeriNum.o $(CDOM_DIR)/CDOM_Visitor.o
#CDOM_OBJS = $(CDOM_DIR)/VeriNum.o
TEST_OBJS=testTools.o Driver.o
OBJS = $(CDOM_OBJS) $(TEST_OBJS)

CXXFLAGS=-I$(CDOM_DIR) 

build : $(target)

$(target) : $(OBJS)
	$(gcc) -o $(target) $(OBJS)

regress:
	echo "Add commands to run regresss"

clean:
	rm -f $(target) $(OBJS)
