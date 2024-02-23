#ifndef TESTTABLESH

#define TESTTABLESH

#include "ObjectModel.h"
using namespace NSChipDesignOm;

// ---------------------------------------------
// |               NSTables                    |
// ---------------------------------------------

namespace NSTables{
	EOmBase ltabBase[] = { \
			BASE_UNDEF, \
			BASE_BASE, \
			BASE_IOLIST, \
			BASE_MODULE, \
			BASE_MODULE_INST, \
			BASE_UDP, \
			BASE_UDPINST, \
			BASE_ELEMENT, \
			BASE_GATE, \
			BASE_PARAM, \
			BASE_CONTASSN, \
			BASE_PROCESS, \
			BASE_SPECBLK, \
			BASE_FUNCTION, \
			BASE_FUNCTION_INST, \
			BASE_TASK, \
			BASE_EXPR, \
			BASE_EXPR_SIGNAL, \
			BASE_EXPR_EVENT, \
			BASE_EXPR_OP, \
			BASE_REAL, \
			BASE_EVENT, \
			BASE_PORT, \
			BASE_DIRECTIVE, \
			BASE_MODEL, \
			BASE_STMT_ASSN, \
			BASE_STMT_CASE, \
			BASE_STMT_LOOP, \
			BASE_STMT_IFELSE, \
			BASE_EXPR_VAL, \
			BASE_EXPR_VAL_INT, \
			BASE_EXPR_VAL_REAL, \
			BASE_CASE_ITEM, \
			BASE_BITRANGE, \
			BASE_EXPR_SIGNALREF \
		}; //35 elements
	int baseSize = 35;

	EOmScope ltabScope[] = { \
			SCOPE_UNDEF, \
			SCOPE_MODULE, \
			SCOPE_UDP, \
			SCOPE_PROCESS, \
			SCOPE_COMPONENT, \
			SCOPE_BLOCK, \
			SCOPE_ELEMENT \
		}; //7 elements
	int scopeSize = 7;

	EOmTraverse ltabTraverse[] = { \
			TRAVERSE_UNDEF, \
			TRAVERSE_OUT_TO_IN, \
			TRAVERSE_IN_TO_OUT \
		}; //3 elements
	int traverseSize = 3;

	EOmNumberBase ltabNumberBase[] = { \
			NUMBER_BASE_UNDEF, \
			NUMBER_BASE_BIN, \
			NUMBER_BASE_OCT, \
			NUMBER_BASE_DEC, \
			NUMBER_BASE_HEX \
		}; //5 elements
	int numberBaseSize = 5;

	EOmProcAssign ltabProcAssign[] = { \
			PROC_ASSIGN_UNDEF, \
			PROC_ASSIGN_BLOCKING, \
			PROC_ASSIGN_NON_BLOCKING, \
			PROC_ASSIGN_CONT_ASSIGN, \
			PROC_ASSIGN_FORCE \
		}; // 5 elements
	int procAssignSize = 5;

	EOmProcess ltabProcess[] = { \
			PROCESS_UNDEF, \
			PROCESS_INIT, \
			PROCESS_ALWAYS \
		}; // 3 elements
	int processSize = 3;

	EOmEvent ltabEvent[] = { \
			EVENT_UNDEF, \
			EVENT_POSEDGE, \
			EVENT_NEGEDGE \
		}; // 3 elements
	int eventSize = 3;

	EOmCase ltabCase[] = { \
			CASE_UNDEF, \
			CASE_CASE, \
			CASE_CASEZ, \
			CASE_CASEX \
		}; // 4 elements
	int caseSize = 4;

	EOmCaseItem ltabCaseItem[] = { \
			CASE_ITEM_UNDEF, \
			CASE_ITEM_CASE, \
			CASE_ITEM_DEFAULT \
		}; // 3 elements
	int caseItemSize = 3;

	EOmAssn ltabAssn[] = { \
			ASSN_BLOCKING, \
			ASSN_NON_BLOCKING \
		}; // 2 elements
	int assnSize = 2;

	EOmEqual ltabEqual[] = { \
			EQUAL_EQUAL, \
			EQUAL_CASE_EQUAL, \
			EQUAL_NOT_EQUAL, \
			EQUAL_NOT_CASE_EQUAL \
		}; // 4 elements
	int equalSize = 4;

	EOmSignal ltabSignal[] = { \
			SIGNAL_UNDEF, \
			SIGNAL_WIRE, \
			SIGNAL_TRI, \
			SIGNAL_WOR, \
			SIGNAL_TRIOR, \
			SIGNAL_WAND, \
			SIGNAL_TRIAND, \
			SIGNAL_TRI0, \
			SIGNAL_TRI1, \
			SIGNAL_SUPPLY0, \
			SIGNAL_SUPPLY1, \
			SIGNAL_TRIREG, \
			SIGNAL_REG, \
			SIGNAL_INT, \
			SIGNAL_TIME, \
			SIGNAL_REAL, \
			SIGNAL_REAL_TIME \
		}; // 17 elements
	int signalSize = 17;	

	EOmPortDir ltabPortDir[] = { \
			PORT_DIR_UNDEF, \
			PORT_DIR_INPUT, \
			PORT_DIR_OUTPUT, \
			PORT_DIR_INOUT \
		}; // 4 elements
	int portDirSize = 4;

	EOmCslPort ltabCslPort[] = { \
			CSL_PORT_DECLARED, \
			CSL_PORT_INFERRED, \
			CSL_PORT_AUTOROUTE \
		}; // 3 elements
	int cslPortSize = 3;

	EOmConst ltabConst[] = { \
			CONST_INTEGRAL, \
			CONST_REAL \
		}; // 2 elements
	int constSize = 2;

	EOmOp ltabOp[] = { \
			OP_UNARY_ARITHMETIC_PLUS, \
			OP_UNARY_ARITHMETIC_MINUS, \
			OP_UNARY_LOGIC_NOT, \
			OP_UNARY_BITWISE_NOT, \
			OP_UNARY_REDUCTION_AND, \
			OP_UNARY_REDUCTION_NAND, \
			OP_UNARY_REDUCTION_OR, \
			OP_UNARY_REDUCTION_NOR, \
			OP_UNARY_REDUCTION_XOR, \
			OP_UNARY_REDUCTION_XNOR, \
			OP_BINARY_ARITHMETIC_PLUS, \
			OP_BINARY_ARITHMETIC_MINUS, \
			OP_BINARY_ARITHMETIC_MULTIPLY, \
			OP_BINARY_ARITHMETIC_DIV, \
			OP_BINARY_ARITHMETIC_MOD, \
			OP_BINARY_EQUALITY_EQ, \
			OP_BINARY_EQUALITY_NOT_EQ, \
			OP_BINARY_IDENTITY_EQ_CASE, \
			OP_BINARY_IDENTITY_NOT_EQ_CASE, \
			OP_BINARY_LOGIC_AND, \
			OP_BINARY_LOGIC_OR, \
			OP_BINARY_RELATIONAL_LESS, \
			OP_BINARY_RELATIONAL_LESS_EQUAL, \
			OP_BINARY_RELATIONAL_GREATER, \
			OP_BINARY_RELATIONAL_GREATER_EQUAL, \
			OP_BINARY_BITWISE_AND, \
			OP_BINARY_BITWISE_NAND, \
			OP_BINARY_BITWISE_OR, \
			OP_BINARY_BITWISE_NOR, \
			OP_BINARY_BITWISE_XOR, \
			OP_BINARY_BITWISE_XNOR, \
			OP_BINARY_SHIFT_LEFT, \
			OP_BINARY_SHIFT_RIGHT, \
			OP_TERNARY_COND \
		}; // 34 elements
	int opSize = 34;

	EOmGateType ltabGateType[] = { \
			GATE_AND, \
			GATE_OR, \
			GATE_XOR, \
			GATE_NAND, \
			GATE_NOR, \
			GATE_XNOR, \
			GATE_BUF, \
			GATE_NOT, \
			GATE_BUFIF0, \
			GATE_BUFIF1, \
			GATE_NOTIF0, \
			GATE_NOTIF1, \
			GATE_PULLUP, \
			GATE_PULLDOWN \
		}; // 14 elements
	int gateTypeSize = 14;

	EOmOpCnt ltabOpCnt[] = { \
			OP_CNT_ZERO, \
			OP_CNT_ONE, \
			OP_CNT_TWO, \
			OP_CNT_MULTI \
		}; // 4 elements
	int opCntSize = 4;

	EOmSig ltabSig[] = { \
			SIG_UNDEF, \
			SIG_CLK_NET, \
			SIG_ENABLE, \
			SIG_MUX_SEL, \
			SIG_MUX_MUTEX \
		}; // 5 elements
	int sigSize = 5;

	EOmSynopsysAttr ltabSynopsysAttr[] = { \
			SYNOPSYS_FULL_CASE, \
			SYNOPSYS_PARALLEL_CASE \
		}; // 2 elements
	int synopsysAttrSize = 2;

	EOmSynInfer ltabSynInfer[] = {
			SYN_INFER_MUX, \
			SYN_INFER_OH_MUX, \
			SYN_INFER_DECODER, \
			SYN_INFER_FF, \
			SYN_INFER_LATCH \
		}; //5 elements
	int synInferSize = 5;
	
	EOmParamType ltabParamType [] = { \
		PARAM_UNDEF, \
		PARAM_INTEGER\
	}; // 2 elements
	int paramTypeSize = 2;
	
}
//end of namespace	
#endif
