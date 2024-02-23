#include "MeInstructionDecoder.h"

using namespace std;

namespace NSOpcode {
	MeInstructionDecoder::MeInstructionDecoder() {}
	MeInstructionDecoder::~MeInstructionDecoder() {}

	TUInt MeInstructionDecoder::getInstructionReg() { return instructionReg; }
	void  MeInstructionDecoder::setInstructionReg(TUInt ir) { instructionReg = ir; }

	void MeInstructionDecoder::instructionDecoder() {

	}

	TUInt MeInstructionDecoder::getLasOp () { return (instructionReg >> EShiftLasOperation ) & EMaskLasOpcodeField ; }
	TUInt MeInstructionDecoder::getBitOp () { return (instructionReg >> EShiftLasOperation ) & EMaskBitOpcodeField ; }
	TUInt MeInstructionDecoder::getLdImOp() { return (instructionReg >> EShiftLasOperation ) & EMaskLdImmOpcodeField ; }
	TUInt MeInstructionDecoder::getBrOp  () { return (instructionReg >> EShiftLasOperation ) & EMaskCondOpcodeField ; }

//	// the operand source is either a register or an immediate	
//	TUInt MeInstructionDecoder::getOperandASrcImmType() {
//		if (! isInstFormatOpLas() & !isInstFormatOpBit() ) { 
//			cerr << "Not a LAS/Bit instruction-cannot get the operand SrcImm type" << endl; 
//		}
//
//		return (instructionReg >> EShiftSrcASrcImmField) & EMaskSrcABSrcImmField; 
//	}
//
//	TUInt MeInstructionDecoder::getOperandBSrcImmType() {
//		if (! isInstFormatOpLas() & !isInstFormatOpBit() ) { 
//			cerr << "Not a LAS/Bit instruction-cannot get the operand SrcImm type" << endl; 
//		}
//
//		return (instructionReg >> EShiftSrcBSrcImmField) & EMaskSrcABSrcImmField; 
//	}

//	e_lasOperandType MeInstructionDecoder::getLasImmRegtype() { 
//		TUInt lsaTypeBit = (instructionReg & EMaskLasOpTypeRegImm) >> EShiftLasOpTypeRegImm; 
//
//		switch (lsaTypeBit) {
//		case ELasOpTypeReg: return ELasOpTypeReg; 
//		case ELasOpTypeImm: return ELasOpTypeImm;
//		default : {
//			cerr << "ERROR LSA Type bit is not 0 or 1 val = " << lsaTypeBit << endl;  
//			exit(-1);
//		}
//		}
//
//		// unreachable
//	}

	TUInt MeInstructionDecoder::getInstFormat() { return (instructionReg >> EShiftInstFormat) & EMaskInstFormat; }

	TUInt MeInstructionDecoder::getOperandASrcImmField() { return (instructionReg >> EShiftSrcASrcImmField) & EMaskSrcABSrcImmField; }
	TUInt MeInstructionDecoder::getOperandBSrcImmField() { return (instructionReg >> EShiftSrcBSrcImmField) & EMaskSrcABSrcImmField; }

	TUInt MeInstructionDecoder::getCondSrcField() { return (instructionReg >> EShiftCondSrc) & EMaskBrCondSrc; }
	TUInt MeInstructionDecoder::getBrAddress() { return (instructionReg >> EshiftBrAddress) & EMaskBrAddress; }

	TUInt MeInstructionDecoder::getInstruction() { return (instructionReg >> EShiftInstruction) & EMaskInstruction; }
	TUInt MeInstructionDecoder::getDestination() { return (instructionReg >> EShiftDestination) & EMaskDestination; }
		
	TUInt MeInstructionDecoder::getOperandA() { return (instructionReg >> EShiftOperandA) & EMaskOperandAB;  }
	TUInt MeInstructionDecoder::getOperandB() { return (instructionReg >> EShiftOperandB) & EMaskOperandAB;  }

//	TUInt MeInstructionDecoder::getSrcASrcImmField() { return (instructionReg >> EShiftSrcASrcImmField) & EMaskSrcABSrcImmField;  }
//	TUInt MeInstructionDecoder::getSrcBSrcImmField() { return (instructionReg >> EShiftSrcBSrcImmField) & EMaskSrcABSrcImmField;  }

	TUInt MeInstructionDecoder::getRfRdAddrSrcA() { return getOperandA();  }
	TUInt MeInstructionDecoder::getRfRdAddrSrcB() { return getOperandB(); }

	// get the rf read enable bits for source A and source B
	TUInt MeInstructionDecoder::getRfRdEnSrcA  () { return !(getOperandASrcImmField() & EOperandReg); }
	TUInt MeInstructionDecoder::getRfRdEnSrcB  () { return !(getOperandBSrcImmField() & EOperandReg); }

	//	TUInt MeInstructionDecoder::getLdImmOpcodeField() { return (instructionReg >> EShiftInstruction) & EMaskLdImmOpodeField; } 
	//	TUInt MeInstructionDecoder::getBrOpcodeField () { return (instructionReg >> EShiftInstruction) & EMaskCondOpcodeField; } 

	TUInt MeInstructionDecoder::getOperandAImm8Field () { return getOperandA(); } 
	TUInt MeInstructionDecoder::getOperandBImm8Field () { return getOperandB(); } 
	TUInt MeInstructionDecoder::getLdImmOperand16Field () { return (instructionReg >> EShiftOperandImm16) & EMaskOperandImm16; } 

	bool MeInstructionDecoder::isInstFormatOpLas  () { return getInstFormat() ==  EInstFormatLas   ; }
	bool MeInstructionDecoder::isInstFormatOpBit  () { return getInstFormat() ==  EInstFormatBit   ; }
	bool MeInstructionDecoder::isInstFormatOpLdIm () { return getInstFormat() ==  EInstFormatLdIm  ; }
	bool MeInstructionDecoder::isInstFormatOpBr   () { return getInstFormat() ==  EInstFormatBr    ; }

	bool MeInstructionDecoder::isLasInstLasAdd  () { return getLasOp() == ELasAdd	; }
	bool MeInstructionDecoder::isLasInstLasSub  () { return getLasOp() == ELasSub	; }
	bool MeInstructionDecoder::isLasInstLasAnd  () { return getLasOp() == ELasAnd	; }
	bool MeInstructionDecoder::isLasInstLasOr   () { return getLasOp() == ELasOr	; }
	bool MeInstructionDecoder::isLasInstLasXor  () { return getLasOp() == ELasXor	; }
	bool MeInstructionDecoder::isLasInstLasXnor () { return getLasOp() == ELasXnor	; }

	bool MeInstructionDecoder::isBitInstSetBit   () { return getLasOp() == ESetBit  ; }
	bool MeInstructionDecoder::isBitInstTestBit  () { return getLasOp() == ETestBit ; }
	bool MeInstructionDecoder::isLasInstLasSwap  () { return getLasOp() == ESwap    ; }
	bool MeInstructionDecoder::isBitInstSwapBit  () { return getLasOp() == ESwapBit ; }

	bool MeInstructionDecoder::isLdImmInstLoadLow   () { return getLdImOp() == ELoadLow 	    ; }
	bool MeInstructionDecoder::isLdImmInstLoadHigh  () { return getLdImOp() == ELoadHigh	    ; }
	bool MeInstructionDecoder::isLdImmInstMsg       () { return getLdImOp() == EMsg    	    ; }

	bool MeInstructionDecoder::isOperandASrc () { return getOperandASrcImmField() == EOperandReg; }
	bool MeInstructionDecoder::isOperandAImm () { return getOperandASrcImmField() == EOperandImm; }

	bool MeInstructionDecoder::isOperandBSrc () { return getOperandBSrcImmField() == EOperandReg; }
	bool MeInstructionDecoder::isOperandBImm () { return getOperandBSrcImmField() == EOperandImm; }

	bool MeInstructionDecoder::isBrInstCondLtZero     () { return getBrOp() == ECondLtZero   ; }
	bool MeInstructionDecoder::isBrInstCondGtEqZero   () { return getBrOp() == ECondGtEqZero ; }
	bool MeInstructionDecoder::isBrInstCondEqZero     () { return getBrOp() == ECondEqZero   ; }
	bool MeInstructionDecoder::isBrInstCondGtZero     () { return getBrOp() == ECondGtZero   ; }
	bool MeInstructionDecoder::isBrInstCondLtEqZero   () { return getBrOp() == ECondLtEqZero ; }
	bool MeInstructionDecoder::isBrInstCondNotEqZero  () { return getBrOp() == ECondNotEqZero; }
	bool MeInstructionDecoder::isBrInstCondAlways     () { return getBrOp() == ECondAlways   ; }

	string MeInstructionDecoder::printLasOp() {
		TUInt op = getLasOp();

		if (isInstFormatOpLas()) {
			switch (op) {
			case ELasAdd : return "ELasAdd	"; break;
			case ELasSub : return "ELasSub	"; break;
			case ELasAnd : return "ELasAnd	"; break;
			case ELasOr	 : return "ELasOr	"; break;
			case ELasXor : return "ELasXor	"; break;
			case ELasXnor: return "ELasXnor "; break;
			default : {
				cerr << "ERROR printLasOp: invalid lsa op  val = " << op << endl;  
				exit(-1);
			}

			}
		}
		else {
			return "NA";
		}
	}		

	string MeInstructionDecoder::printInstFormat() {
		TUInt format = getInstFormat();

		switch (format) {
		case EInstFormatLas   : return "EInstFormatLas "; break;
		case EInstFormatBit   : return "EInstFormatBit "; break;
		case EInstFormatLdIm  : return "EInstFormatLdIm"; break;
		case EInstFormatBr    : return "EInstFormatBr  "; break;
		default : {
			cerr << "ERROR printLasOp: invalid instruction format  val = " << format << endl;  
			exit(-1);
		}
		}
	}
}		

 
  
  
  
