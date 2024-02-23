#ifndef INC_GUARD_eu_h
#define INC_GUARD_eu_h

#include "me_config.h"

SC_MODULE(eu) {
	sc_in<bool> clk;
	sc_in<bool> reset_;
	sc_in<bool> enable;
	sc_in<bool> rf_eu_v;

	T_IR_sc_in        rf_eu_ir      ;
	T_DATA_sc_in      src_a         ;
	T_DATA_sc_in      src_b         ;
	T_DATA_sc_out     eu_rf_wr_data;
	T_RF_ADDR_sc_out  eu_rf_wr_addr;
	sc_out<bool>      eu_rf_wren   ; 
	sc_out<bool>      eu_branch    ;

	sc_signal<bool> valid;
	TUInt eu_rf_wr_data_las; // las op instruction result
	TUInt eu_rf_wr_data_bit; // bit op  instruction result

	NSOpcode::MeInstructionDecoder *instructionDecoder;

	void inputs() {
		valid.write(enable.read() && rf_eu_v.read());
	}

 
    void executionUnit() {

		instructionDecoder->setInstructionReg(rf_eu_ir.read());

		if (enable.read()) {
			if (rf_eu_v.read()) {
				if (instructionDecoder->isInstFormatOpLas()) {
					switch (instructionDecoder->getLasOp()) {
					case NSOpcode::ELasAdd : eu_rf_wr_data_las =   src_a.read() + src_b.read() ;  ; break;
					case NSOpcode::ELasSub : eu_rf_wr_data_las =   src_a.read() - src_b.read() ;  ; break;	
					case NSOpcode::ELasAnd : eu_rf_wr_data_las =   src_a.read() & src_b.read() ;  ; break;	
					case NSOpcode::ELasOr  : eu_rf_wr_data_las =   src_a.read() | src_b.read() ;  ; break;
					case NSOpcode::ELasXor : eu_rf_wr_data_las =   src_a.read() ^ src_b.read() ;  ; break;	
					case NSOpcode::ELasXnor: eu_rf_wr_data_las = ~(src_a.read() ^ src_b.read());  ; break;
					default: cerr << "ERROR: eu bad las opcode val = " << instructionDecoder->getLasOp() << endl;
					}
				}
				else if (instructionDecoder->isInstFormatOpBit()) {
				}
				else if (instructionDecoder->isInstFormatOpLdIm()) {
				}
				else if (instructionDecoder->isInstFormatOpBr()) {
					switch (instructionDecoder->getLasOp()) {
					case NSOpcode::ECondLtZero    :  eu_branch.write(src_a.read() <  0); break;
					case NSOpcode::ECondGtEqZero  :  eu_branch.write(src_a.read() >= 0); break;
					case NSOpcode::ECondEqZero    :  eu_branch.write(src_a.read() == 0); break;
					case NSOpcode::ECondGtZero    :  eu_branch.write(src_a.read() >  0); break;
					case NSOpcode::ECondLtEqZero  :  eu_branch.write(src_a.read() <= 0); break;
					case NSOpcode::ECondNotEqZero :  eu_branch.write(src_a.read() != 0); break;
					case NSOpcode::ECondAlways    :  eu_branch.write(true) ; break;
					default: cerr << "ERROR: eu bad br cond opcode val = " << instructionDecoder->getBrOp() << endl;
					}
				}
				else {
					std::cout << "executionUnit:: NOP"  << std::endl;
				}
			}
		}

	}


	void outputs() {
		// select the eu result to write to the rf
		if (instructionDecoder->isInstFormatOpLas()) {
			switch (instructionDecoder->getInstFormat()) {
			case NSOpcode::EInstFormatLas : 
				eu_rf_wr_data.write(eu_rf_wr_data_las ); 
				eu_rf_wren.write(valid); 
				eu_rf_wr_addr.write(instructionDecoder->getDestination()); // the rf addr to write the result to
				break;
			case NSOpcode::EInstFormatBit : 
				eu_rf_wr_data.write(eu_rf_wr_data_bit ); 
				eu_rf_wren.write(valid); 
				eu_rf_wr_addr.write(instructionDecoder->getDestination()); // the rf addr to write the result to
				break;
			default: 
				eu_rf_wr_data.write( 0xDEADBEEF ); 
				eu_rf_wren.write(false); 
				eu_rf_wr_addr.write( 0xDEADBEEF ); // r0 is a constant register
				break;
			}
		}

		std::cout << "executionUnit::****************************************" << std::endl;
		std::cout << "executionUnit:: rf_eu_v=" << rf_eu_v.read() << endl; 
		std::cout << "executionUnit::enable =" << enable.read() << endl; 

		std::cout << "executionUnit:: instReg=" << instructionDecoder->getInstructionReg() 
				  << " isInstFmtLas=" << instructionDecoder->isInstFormatOpLas() 
				  << " instFmt=" << instructionDecoder->getInstFormat() << std::endl;

		std::cout << "executionUnit:: rf_eu_ir = " << rf_eu_ir.read() << std::endl;	

		std::cout << "executionUnit:: las op = " << instructionDecoder->printLasOp() << " las op = " << instructionDecoder->getLasOp() << std::endl;	
		std::cout << "executionUnit:: src_a = " << src_a.read() << std::endl;
		std::cout << "executionUnit:: src_b = " << src_b.read() << std::endl;

		std::cout << "executionUnit:: eu_rf_wr_data_las = " << eu_rf_wr_data_las << std::endl;
		std::cout << "executionUnit:: eu_rf_wr_data_bit = " << eu_rf_wr_data_bit << std::endl;
		std::cout << "executionUnit:: eu_rf_wr_data = " << eu_rf_wr_data.read() << std::endl;
		std::cout << "executionUnit:: eu_rf_wr_addr = " << eu_rf_wr_addr.read() << std::endl;
		std::cout << "executionUnit:: eu_rf_wren             = " << eu_rf_wren.read() << std::endl;


	}
 
    SC_CTOR(eu) {
		std::cout << "unit me instance name = " << name() << std::endl;

		SC_METHOD(inputs);
		sensitive << rf_eu_v << enable << enable;

		SC_METHOD(executionUnit);
		sensitive << rf_eu_ir << src_a << src_b << enable << rf_eu_v ;

		SC_METHOD(outputs);
		sensitive << rf_eu_ir;
		//		sensitive << clk.pos();

		instructionDecoder = new NSOpcode::MeInstructionDecoder();


		dont_initialize();
  }
};

#endif
