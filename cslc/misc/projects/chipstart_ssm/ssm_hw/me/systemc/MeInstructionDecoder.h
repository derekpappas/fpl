#ifndef INC_GUARD_MEINSTRUCTIONDECODER_h
#define INC_GUARD_MEINSTRUCTIONDECODER_h

#include <iostream>
#include <string>
#include "TypeDefs.h"
#include <iostream>
#include <fstream>
#include <cstdlib>

using namespace std;

namespace NSOpcode {

	enum e_shift {
		EShiftInstFormat       = 30,
		EShiftSrcASrcImmField  = 29,
		EShiftSrcBSrcImmField  = 28,
		EShiftInstruction      = 24, // byte[3]
		EShiftCondSrc          = 16, // byte[2]
		EShiftDestination      = 16, // byte[2]
		EShiftOperandA         =  8, // byte[1]
		EShiftOperandB         =  0, // byte[0]
		EShiftOperandImm16     = 0, // byte[1:0]
		EShiftLasOperation     = 24, // byte[3]
		EshiftBrAddress        =  0
	} ;

	enum e_masks {
		EMaskSrcImmField     =    1,
		EMaskInstFormat      =  0x3, // Instruction format
		EMaskLasOpcodeField  =  0xF, // LAS opcode field
		EMaskBitOpcodeField  =  0xF, // swap/bit opcode field
		EMaskLdImmOpcodeField= 0x3F, // load immediate opcode
		EMaskCondOpcodeField = 0x3F, // Br cond opcode
		EMaskSrcABSrcImmField=  0x1, // source A type - register or immediate
		EMaskBrCondSrc       =  0xF, // logical or arithmetic operation
		EMaskBrAddress       =  0xFF, // logical or arithmetic operation
		EMaskLasOperation    =  0xF, // logical or arithmetic operation
		EMaskInstruction     = 0xFF, // 
		EMaskOperandAB       = 0xFF, // 
		EMaskDestination     = 0xFF,  // 
		EMaskOperandImm8     = 0xFF,   // byte[0:0]
		EMaskOperandImm16    = 0xFFFF // byte[1:0]
	} ;

	enum e_instructionFormats {
		EInstFormatLas  = 0, // 0 
		EInstFormatBit  = 1, // 1
		EInstFormatLdIm = 2, // 2
		EInstFormatBr   = 3  // 3 
	} ;

	// the las and bit instruction formats use bit 29:28 to specify the type of operand
	// 
	// bit 29:28 select reg or immediate
	// reg = 0
	// imm = 1

	enum e_operandSource {
		EOperandReg = 0, // register 
		EOperandImm = 1, // immediate value in the lower two bytes
	} ;

	// L = logical
	// A = arithmetic
	// S = swap

	enum  e_lasOps {
		ELasAdd	 =  0,
		ELasSub	 =  1,
		ELasAnd	 =  4,
		ELasOr	 =  5,
		ELasXor	 =  6,
		ELasXnor =  7
	};

	enum  e_bitOps {
		ESetBit  = 0,
		ETestBit = 1,
		ESwapBit = 2,
		ESwap    = 3
	} ;

	enum  e_ldImmOps {
		ELoadLow  = 0,
		ELoadHigh = 1,
		EMsg      = 0x3F
	} ;

	enum  e_condOps {
		ECondLtZero    =  0, // < 0
		ECondGtEqZero  =  1, // >= 0
		ECondEqZero    =  2, // == 0
		ECondGtZero    =  3, // > 0
		ECondLtEqZero  =  4, // <= 0
		ECondNotEqZero =  5, // != 0
		ECondAlways    = 32  // ALWAYS
	};


	class MeInstructionDecoder {
	private:
		TUInt instructionReg;

	public:

		MeInstructionDecoder ();
		~MeInstructionDecoder ();

		TUInt getInstructionReg();
		void  setInstructionReg(TUInt instructionReg);

		void instructionDecoder();

		// get the 4 bytes in an instruction
		TUInt getInstruction();
		TUInt getOperandA();
		TUInt getOperandB();
		TUInt getCondSrcField();
		TUInt getBrAddress();
		TUInt getOperandDest();
		TUInt getDestination();
//		TUInt getLdImmOpcodeField();
//		TUInt getCondOpcodeField();

		TUInt getOperandASrcImmField();
		TUInt getOperandBSrcImmField();

//		TUInt getOperandASrcImmType();
//		TUInt getOperandBSrcImmType();

		TUInt getInstFormat();

		TUInt getLasOp ();
		TUInt getBitOp ();
		TUInt getLdImOp();
		TUInt getBrOp  ();

//		TUInt getSrcASrcImmField();
//		TUInt getSrcBSrcImmField();

		TUInt getRfRdAddrSrcA();
		TUInt getRfRdAddrSrcB();

		TUInt getRfRdEnSrcA();
		TUInt getRfRdEnSrcB();

		TUInt getOperandAImm8Field ();
		TUInt getOperandBImm8Field ();
		TUInt getLdImmOperand16Field ();

		bool isOperandASrc();
		bool isOperandAImm();

		bool isOperandBSrc();
		bool isOperandBImm();

		bool isInstFormatOpLas  ();
		bool isInstFormatOpBit  ();
		bool isInstFormatOpLdIm ();
		bool isInstFormatOpBr   ();

		bool isLasInstLasAdd  ();
		bool isLasInstLasSub  ();
		bool isLasInstLasAnd  ();
		bool isLasInstLasOr   ();
		bool isLasInstLasXor  ();
		bool isLasInstLasXnor ();
		bool isLasInstLasSwap ();

		bool isBitInstSetBit   ();
		bool isBitInstClrBit   ();
		bool isBitInstTestBit  ();
		bool isBitInstSwapBit  ();

		bool isLdImmInstLoadLow   ();
		bool isLdImmInstLoadHigh  ();
		bool isLdImmInstMsg   ();

		bool isOperandSrc ();
		bool isOperandImm ();

		bool isBrInstCondLtZero     ();
		bool isBrInstCondGtEqZero   ();
		bool isBrInstCondEqZero     ();
		bool isBrInstCondGtZero     ();
		bool isBrInstCondLtEqZero   ();
		bool isBrInstCondNotEqZero  ();
		bool isBrInstCondAlways     ();

		void loadInstructionMemory  (string binaryFileName);

		void buildTest  (string binaryFileName);

		TUInt makeOperand (TUInt x, TUInt shiftAmount);

		TUInt makeOperandA (TUInt x);
		TUInt makeOperandB (TUInt x);
		TUInt makeDestination (TUInt x);
		string printLasOp();		
		string printInstFormat();

	};
}

#endif
