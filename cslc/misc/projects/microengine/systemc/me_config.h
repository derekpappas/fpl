#ifndef ME_CONFIG_H
#define ME_CONFIG_H

#include "systemc.h"
#include <stdio.h>
#include "MeInstructionDecoder.h"

namespace microengine {
	const unsigned int IM_WORD_WIDTH = 32;
	const unsigned int IM_ADDR_WIDTH = 8;
	const unsigned int IM_NUM_WORDS = 1 << IM_ADDR_WIDTH;

	const unsigned int RF_DATA_WIDTH = 32;
	const unsigned int RF_ADDR_WIDTH = 5;
	const unsigned int RF_NUM_WORDS = 1 << RF_ADDR_WIDTH;

	const unsigned int PC_WIDTH = 16;
	const unsigned int IR_WIDTH = 32;
}

typedef sc_uint<microengine::RF_DATA_WIDTH> T_DATA_WORD; 
typedef sc_in<T_DATA_WORD> T_DATA_sc_in; 
typedef sc_out<T_DATA_WORD> T_DATA_sc_out; 
typedef sc_signal<T_DATA_WORD> T_DATA_sc_signal; 

typedef sc_uint<microengine::RF_ADDR_WIDTH> T_RF_ADDR_WIDTH; 
typedef sc_in<T_RF_ADDR_WIDTH> T_RF_ADDR_sc_in; 
typedef sc_out<T_RF_ADDR_WIDTH> T_RF_ADDR_sc_out; 
typedef sc_signal<T_RF_ADDR_WIDTH> T_RF_ADDR_sc_signal; 

typedef sc_uint<microengine::IM_WORD_WIDTH> T_IR_WORD; 
typedef sc_in<T_IR_WORD> T_IR_sc_in; 
typedef sc_out<T_IR_WORD> T_IR_sc_out; 
typedef sc_signal<T_IR_WORD> T_IR_sc_signal; 

typedef sc_uint<microengine::PC_WIDTH> T_PC_WORD; 
typedef sc_in<T_PC_WORD> T_PC_sc_in; 
typedef sc_out<T_PC_WORD> T_PC_sc_out; 
typedef sc_signal<T_PC_WORD> T_PC_sc_signal; 

typedef sc_uint<microengine::IR_WIDTH> T_IR_WORD; 
typedef sc_in<T_IR_WORD> T_IR_sc_in; 
typedef sc_out<T_IR_WORD> T_IR_sc_out; 
typedef sc_signal<T_IR_WORD> T_IR_sc_signal; 

#endif
