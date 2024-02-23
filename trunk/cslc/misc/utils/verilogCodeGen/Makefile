gcc    = g++
target = verilogCodeGen.bin


CDOM_DIR=../../cdom/src
#TOOLS_OBJ=$(OM_DIR)/Tools.o
#VISITOR_OBJ=$(OM_DIR)/Visitor.o
CDOM_OBJS = $(CDOM_DIR)/CDOM.o $(CDOM_DIR)/VeriNum.o $(CDOM_DIR)/CDOM_Visitor.o
#CDOM_OBJS = $(CDOM_DIR)/VeriNum.o
CODEGEN_OBJS=verilogCodeGen.o
MAIN_OBJ=main.o
OBJS = $(CDOM_OBJS) $(CODEGEN_OBJS) $(MAIN_OBJ)

CXXFLAGS=-I$(CDOM_DIR) 

build : $(target)

CODEGEN_OBJS: verilogCodeGen.cpp verilogCodeGen.h

$(target) : $(OBJS)
	$(gcc) -o $(target) $(OBJS)


regress:
	echo "Add commands to run regresss"

clean:
	rm -f $(CODEGEN_OBJS) $(MAIN_OBJ)
