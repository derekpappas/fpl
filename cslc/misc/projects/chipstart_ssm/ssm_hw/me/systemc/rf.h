#ifndef INC_GUARD_rf_h
#define INC_GUARD_rf_h

#include "systemc.h"
#include <stdio.h>
#include "me_config.h"

using namespace std;

SC_MODULE(rf) {
	sc_in<bool> clk;
	sc_in<bool> reset_;
	sc_in<bool> enable;
	sc_in<bool> eu_branch;
	sc_in<TUInt > im_rf_ir;

	sc_in<bool> eu_rf_wren; 
	T_RF_ADDR_sc_in eu_rf_wr_addr;
	T_DATA_sc_in eu_rf_wr_data;
	T_DATA_sc_in eu_rf_ir;
	T_DATA_sc_out rd_data_a;
	T_DATA_sc_out rd_data_b;
	sc_in<bool> im_rf_v; 
	sc_out<bool> rf_eu_v; 
	sc_out<bool> rf_stall; 

	TUInt rd_data_dest;

	bool rden_a; 
	T_RF_ADDR_WIDTH rd_addr_a;
	bool rden_b; 
	T_RF_ADDR_WIDTH rd_addr_b;

	bool eu_rf_wr_addr_equal_rd_addr_a; // eu write back address equal to rf read address a
	bool eu_rf_wr_addr_equal_rd_addr_b; // eu write back address equal to rf read address b

	NSOpcode::MeInstructionDecoder *im_rf_instructionDecoder;
	NSOpcode::MeInstructionDecoder *eu_rf_instructionDecoder;

	TUInt rd_data_imm_a; // immediate value from operand A
	TUInt rd_data_imm_b; // immediate value from operand B

	TUInt rd_data_rf_a; // rfa[addr] value from operand A
	TUInt rd_data_rf_b; // rfa[addr] value from operand B

	bool cancelValid ; // cancel the valid bit in the rf if all of the following wren's are false

	// write enables for different instruction types
	bool swap_wren; 
	TUInt swap_wr_addr_a;
	TUInt swap_wr_data_a;
	TUInt swap_wr_addr_b;
	TUInt swap_wr_data_b;

	bool swapbit_wren; 
	TUInt swapbit_wr_addr_a;
	TUInt swapbit_wr_data_a;
	TUInt swapbit_wr_addr_b;
	TUInt swapbit_wr_data_b;

	bool testbit_wren; 
	TUInt testbit_wr_addr;
	TUInt testbit_wr_data;

	bool setbit_wren; 
	TUInt setbit_wr_addr;
	TUInt setbit_wr_data;

	bool ldimm_ab_16_wren; 
	TUInt ldimm_ab_16_wr_addr;
	TUInt ldimm_ab_16_wr_data;

	bool rf_mux_in_wren_a; 
	TUInt rf_mux_in_wr_addr_a;
	TUInt rf_mux_in_wr_data_a;

	bool rf_mux_in_wren_b; 
	TUInt rf_mux_in_wr_addr_b;
	TUInt rf_mux_in_wr_data_b;

	bool bypass_a;
	bool bypass_b;

	TUInt rd_data_imm_mux_a;
	TUInt rd_data_bypass_mux_a;
	TUInt rd_data_imm_mux_b;
	TUInt rd_data_bypass_mux_b;

	TUInt rf_dest_data;

	TUInt eu_rf_wren_int;

	TUInt eu_rf_wr_addr_int;

	TUInt eu_rf_wr_addr_equal_rd_addr_b_1;

	// debug wires for the register file
	// used to display in GTKWave
	TUInt rfa_wire_0 ;
	TUInt rfa_wire_1 ;
	TUInt rfa_wire_2 ;
	TUInt rfa_wire_3 ;
	TUInt rfa_wire_4 ;
	TUInt rfa_wire_5 ;
	TUInt rfa_wire_6 ;
	TUInt rfa_wire_7 ;
	TUInt rfa_wire_8 ;
	TUInt rfa_wire_9 ;
	TUInt rfa_wire_10;
	TUInt rfa_wire_11;
	TUInt rfa_wire_12;
	TUInt rfa_wire_13;
	TUInt rfa_wire_14;
	TUInt rfa_wire_15;
	TUInt rfa_wire_16;
	TUInt rfa_wire_17;
	TUInt rfa_wire_18;
	TUInt rfa_wire_19;
	TUInt rfa_wire_20;
	TUInt rfa_wire_21;
	TUInt rfa_wire_22;
	TUInt rfa_wire_23;
	TUInt rfa_wire_24;
	TUInt rfa_wire_25;
	TUInt rfa_wire_26;
	TUInt rfa_wire_27;
	TUInt rfa_wire_28;
	TUInt rfa_wire_29;
	TUInt rfa_wire_30;
	TUInt rfa_wire_31;

	// rf write signals
	TUInt wr_addr_a;
	TUInt wr_data_a;
	bool  wren_a   ;

	TUInt wr_addr_b;
	TUInt wr_data_b;
	bool  wren_b   ;
	TUInt eu_data;

	bool rfRdAddrEqEuRfWrAddr_b;
	bool rfRdAddrEqEuRfWrAddr_a;

	unsigned int rfa[microengine::RF_NUM_WORDS-1]; // rf[0] is a constant 0

	void init() {
		for (int i = 0; i < microengine::RF_NUM_WORDS; i++) {
			unsigned int d = 11110000 | i;
			rfa[i] = d;
			wait(1);
		}
		
		wait(4);
		for (int i = 0; i < microengine::RF_NUM_WORDS; i++) {
			unsigned int d = 11110000 | i;
			rfa[i] = d;
			wait(1);
		}
	}

	// get the bit in the bit position
	// form a one bit mask from the the bit index
	TUInt getBit(TUInt data, TUInt bitIndex) {
		TUInt oneBitMask = 1<< bitIndex;
		return (data & oneBitMask) >> bitIndex;
	}

	// or in the bit in the data[index] position
	TUInt setBit(TUInt destData, TUInt bitData, TUInt bitIndex ) { // fix
		TUInt bit = (bitData >> bitIndex) | 1 ;
		return destData | bit ;
	}

	TUInt testBit(TUInt data, TUInt bitIndex) {
		return getBit(data, bitIndex);
	}

	// swapBit moves a bit from a source reg to bit zero of a dest reg
	// dest[0] = srca[srcb]
	// or
	// dest[0] = srca[immb]
	// Swap bit is assumed to be:
	// dest[imma] = srcb[0]
	// srcb[0]    = dest[imma]

	TUInt swapBit(TUInt srcData, TUInt bitIndex, TUInt destination) {
		TUInt oneBitMask = 1<< bitIndex;

		// get the bit from the source
		TUInt bit = (srcData & oneBitMask) >> bitIndex;

		// zero out the lowest bit-avoid xor
		destination = destination & 0xFFFFFFFE; // last byte 1110

		// or in the etract bit from the source
		destination = destination | bit; 

		return destination;
	}

	// sign extend using bit 8

	TUInt signExtend8(TUInt srcData) {
		// get bit 8

		TUInt bit8 = (srcData >> 7) & 1; 

		// select mask for upper 3 bytes

		TUInt allOnesmask   = 0xFFFFFF00; // negative number
		TUInt allZeroesmask = 0x00000000; // positive number
		TUInt mask = bit8 ? allOnesmask : allZeroesmask;

		TUInt result = srcData | mask;

		return result;
	}

	// sign extend using bit 16

	TUInt signExtend16(TUInt srcData) {
		// get bit 16

		TUInt bit16 = (srcData >> 15) & 1; 

		// select mask for upper 3 bytes

		TUInt allOnesmask   = 0xFFFF0000; // negative number
		TUInt allZeroesmask = 0x00000000; // positive number
		TUInt mask = bit16 ? allOnesmask : allZeroesmask;

		TUInt result = srcData | mask;

		return result;
	}

	void registerfile_read() {

		im_rf_instructionDecoder->setInstructionReg(im_rf_ir.read());

		// equation for stalling the pc and im
		rf_stall.write((im_rf_instructionDecoder->isInstFormatOpBit()  || im_rf_instructionDecoder->isInstFormatOpLdIm())
					   && eu_rf_wren.read());

		rden_a = enable && im_rf_instructionDecoder->getRfRdEnSrcA(); 
		rd_addr_a = im_rf_instructionDecoder->getOperandA(); 
		rden_b = enable && im_rf_instructionDecoder->getRfRdEnSrcB();  
		rd_addr_b = im_rf_instructionDecoder->getOperandB(); 

		cout << "rf::****************************************" << endl;
		cout << "rf::v = " << im_rf_v.read() << endl;
		cout << "rf::instructionReg = " << im_rf_instructionDecoder->getInstructionReg() << endl;
		cout << "rf::reset_ = "    << reset_.read() << endl;
		cout << "rf::rd_addr_a = " << rd_addr_a << endl;
		cout << "rf::rden_a    = " << rden_a    << endl;
		cout << "rf::rd_addr_b = " << rd_addr_b << endl;
		cout << "rf::rden_b    = " << rden_b    << endl;

		if (! rf_stall.read()) {

			if (! reset_.read()) {
				cout << "rf::reset = " << reset_.read() << endl;
			} 
			else {
				if (enable.read() && im_rf_v.read() && rden_a) {
					if (0 == rd_addr_a) { // read the constant zero from rfa[0]
						rd_data_rf_a = 0;
						cout << "rf:0 read operation rd_addr_a = " << rd_addr_a << endl;
					}
					else if (rd_addr_a < microengine::RF_NUM_WORDS) {
						rd_data_rf_a = rfa[rd_addr_a];
						cout << "rf:1 all read operation rd_addr_a = " << rd_addr_a << endl;
					}
					else {
						rd_data_rf_a = 0xDEADBEEF;
						cerr << "ERROR: rf:  read operation rd_addr_a = " << rd_addr_a << endl;
					}
				}

				if (enable.read() && im_rf_v.read() && rden_b) {
					if (0 == rd_addr_b) { // read the constant zero from rfa[0]
						rd_data_rf_b = 0;
						cout << "rf:0 read operation rd_addr_b = " << rd_addr_b << endl;
					}
					else if (rd_addr_b < microengine::RF_NUM_WORDS) {
						rd_data_rf_b = rfa[rd_addr_b];
						cout << "rf:all read operation rd_addr_b = " << rd_addr_b << endl;
					}
					else {
						rd_data_rf_a = 0xDEADBEEF;
						cerr << "ERROR: rf: read operation rd_addr_b = " << rd_addr_b << endl;
					}
				}
				rd_data_imm_a = signExtend8(im_rf_instructionDecoder->getOperandAImm8Field ());
				rd_data_imm_mux_a = im_rf_instructionDecoder->isOperandAImm() ? rd_data_imm_a: rd_data_rf_a;
				rd_data_imm_b = signExtend8(im_rf_instructionDecoder->getOperandBImm8Field ());
				rd_data_imm_mux_b = im_rf_instructionDecoder->isOperandBImm() ? rd_data_imm_b: rd_data_rf_b;
			}

			// multiplex the register and immediate values based on the register/immediate select in the instruction 

			eu_rf_wr_addr_int = eu_rf_wr_addr.read();

			eu_rf_wren_int = eu_rf_wren.read();

			// if the read address is equal to the eu writeback address use the eu data
			eu_rf_wr_addr_equal_rd_addr_a = eu_rf_wr_addr.read() == rd_addr_a;
			rfRdAddrEqEuRfWrAddr_a = eu_rf_wr_addr_equal_rd_addr_a && eu_rf_wren_int;
			bypass_a = im_rf_instructionDecoder->getRfRdEnSrcA() && rfRdAddrEqEuRfWrAddr_a; // the rf read is a reg not an imm and rf address equals the eu_rf_write address

			// if the read address is equal to the eu writeback address use the eu data
			eu_rf_wr_addr_equal_rd_addr_b = eu_rf_wr_addr.read() == rd_addr_b;
			eu_rf_wr_addr_equal_rd_addr_b_1 = eu_rf_wr_addr_int == rd_addr_b;
			rfRdAddrEqEuRfWrAddr_b = eu_rf_wr_addr_equal_rd_addr_b && eu_rf_wren_int;
			bypass_b = im_rf_instructionDecoder->getRfRdEnSrcB() && rfRdAddrEqEuRfWrAddr_b; // the rf read is a reg not an imm and rf address equals the eu_rf_write address

			eu_data = eu_rf_wr_data.read();
			rd_data_bypass_mux_a = bypass_a ? eu_data : rd_data_imm_mux_a;
		
			rd_data_bypass_mux_b = bypass_b ? eu_data : rd_data_imm_mux_b;

			registerfile_write_mux();

			// if none of the write enables are valid then cancel the operation
			cancelValid = swap_wren    
				|| swapbit_wren 
				|| testbit_wren 
				|| setbit_wren  
				|| ldimm_ab_16_wren;

		}
 
		cout << "rf::im_rf_ir.read()  = " << im_rf_ir.read() << endl;
		cout << "rf::im_rf_instructionDecoder->getInstructionReg()  = " << im_rf_instructionDecoder->getInstructionReg() << endl;

		cout << "rf:: isInstFormatOpLas = " << im_rf_instructionDecoder->isInstFormatOpLas()  << endl;
		cout << "rf:: isInstFormatOpBit = " << im_rf_instructionDecoder->isInstFormatOpBit()  << endl;
		cout << "rf:: isInstFormatOpLdIm= " << im_rf_instructionDecoder->isInstFormatOpLdIm() << endl;
		cout << "rf:: isInstFormatOpBr  = " << im_rf_instructionDecoder->isInstFormatOpBr()   << endl;
		cout << "rf:: getLdImmOperand16Field= " <<  im_rf_instructionDecoder->getLdImmOperand16Field () << endl;
		cout << "rf:: signExtend16(im_rf_instructionDecoder->getLdImmOperand16Field ()) = " << signExtend16(im_rf_instructionDecoder->getLdImmOperand16Field ())  << endl;

		cout << "rf:: rf_dest_data  = " << rf_dest_data << endl;

		cout << "rf::im_rf_ir = " << im_rf_ir.read() << endl;
		cout << "rf::eu_rf_ir = " << eu_rf_ir.read() << endl;

		cout << "rf::op_imm_a = " <<  signExtend8(im_rf_instructionDecoder->getOperandAImm8Field ()) << endl;
		cout << "rf::op_imm_b = " <<  signExtend8(im_rf_instructionDecoder->getOperandBImm8Field ()) << endl;

		cout << "rf:: getOperandAImm8Field  = " <<  im_rf_instructionDecoder->getOperandAImm8Field  () << endl;
		cout << "rf:: getOperandBImm8Field  = " <<  im_rf_instructionDecoder->getOperandBImm8Field  () << endl;

		cout << "rf::signExtend8 (op_imm_a) = "  <<  hex << signExtend8 (im_rf_instructionDecoder->getOperandAImm8Field   ()) << endl;
		cout << "rf::signExtend8 (op_imm_b) = "  <<  hex << signExtend8 (im_rf_instructionDecoder->getOperandBImm8Field   ()) << endl;
		cout << "rf::signExtend16(op_imm_b) = "  <<  hex << signExtend16(im_rf_instructionDecoder->getLdImmOperand16Field ()) << endl;

		cout << "rf::rd_data_rf_a = " << rd_data_rf_a << endl;
		cout << "rf::rd_data_rf_b = " << rd_data_rf_b << endl;

		cout << "rf::rd_data_imm_a = " << rd_data_imm_a << endl;
		cout << "rf::rd_data_imm_b = " << rd_data_imm_b << endl;
		
		cout << "rf::rd_data_imm_mux_sel_a = " << im_rf_instructionDecoder->isOperandAImm() << endl;
		cout << "rf::rd_data_imm_mux_sel_b = " << im_rf_instructionDecoder->isOperandBImm() << endl;

		cout << "rf::rd_data_imm_mux_a = " << rd_data_imm_mux_a << endl;
		cout << "rf::rd_data_imm_mux_b = " << rd_data_imm_mux_b << endl;
				
		cout << "rf::rd_data_bypass_mux_a = " << rd_data_bypass_mux_a << endl;
		cout << "rf::rd_data_bypass_mux_b = " << rd_data_bypass_mux_b << endl;

		cout << "rf::rf_eu_wr_addr = " << im_rf_instructionDecoder->getDestination() << endl;

		cout << "rf::enable = " << enable.read() << endl;
		cout << "rf::eu_rf_wr_addr = " << eu_rf_wr_addr.read() << endl;
		cout << "rf::rd_addr_a     = " << rd_addr_a << endl;
		cout << "rf::eu_rf_wr_addr_equal_rd_addr_a = " << eu_rf_wr_addr_equal_rd_addr_a << endl;
		cout << "rf::eu_rf_wren.read() = " << eu_rf_wren.read() << endl;
		cout << "rf::eu_rf_wren_int = " << eu_rf_wren_int << endl;

		cout << "rf::rfRdAddrEqEuRfWrAddr_a = " << rfRdAddrEqEuRfWrAddr_a << endl;
		cout << "rf::bypass_a = " << bypass_a << endl;

		cout << "rf::eu_rf_wr_addr = " << eu_rf_wr_addr.read() << endl;
		cout << "rf::rd_addr_b     = " << rd_addr_b << endl;
		cout << "rf::eu_rf_wr_addr_equal_rd_addr_b = " << eu_rf_wr_addr_equal_rd_addr_b << endl;
		cout << "rf::eu_rf_wren.read() = " << eu_rf_wren.read() << endl;
		cout << "rf::eu_rf_wren_int = " << eu_rf_wren_int << endl;
		cout << "rf::rfRdAddrEqEuRfWrAddr_b = " << rfRdAddrEqEuRfWrAddr_b << endl;
		cout << "rf::bypass_b = " << bypass_b << endl;

		cout << "rf::eu_data_a = " << eu_data << endl;
		cout << "rf::rd_data_a = " << rd_data_a << endl;
		cout << "rf::rd_data_b = " << rd_data_b << endl;
		cout << "rf::rf_eu_v = " << rf_eu_v.read()		 << endl;

		cout << "rf::eu_rf_wr_addr = " << eu_rf_wr_addr.read() << endl;
		cout << "rf::eu_rf_wr_data = " << eu_rf_wr_data.read() << endl;
		cout << "rf::eu_rf_wren    = " << eu_rf_wren.read()    << endl;
		cout << "rf::rf_stall = " << rf_stall.read()		 << endl;
		for (int i = 0; i < microengine::RF_NUM_WORDS; i++) {
			cout << "rf::   rf[" << i << "] = " << rfa[i] << endl;
		}

		writeDebugSignals();
	}

	void writeDebugSignals() {
		// debug wires for the register file
		// used to display in GTKWave
		rfa_wire_0  = rfa[0 ];
		rfa_wire_1  = rfa[1 ];
		rfa_wire_2  = rfa[2 ];
		rfa_wire_3  = rfa[3 ];
		rfa_wire_4  = rfa[4 ];
		rfa_wire_5  = rfa[5 ];
		rfa_wire_6  = rfa[6 ];
		rfa_wire_7  = rfa[7 ];
		rfa_wire_8  = rfa[8 ];
		rfa_wire_9  = rfa[9 ];
		rfa_wire_10 = rfa[10];
		rfa_wire_11 = rfa[11];
		rfa_wire_12 = rfa[12];
		rfa_wire_13 = rfa[13];
		rfa_wire_14 = rfa[14];
		rfa_wire_15 = rfa[15];
		rfa_wire_16 = rfa[16];
		rfa_wire_17 = rfa[17];
		rfa_wire_18 = rfa[18];
		rfa_wire_19 = rfa[19];
		rfa_wire_20 = rfa[20];
		rfa_wire_21 = rfa[21];
		rfa_wire_22 = rfa[22];
		rfa_wire_23 = rfa[23];
		rfa_wire_24 = rfa[24];
		rfa_wire_25 = rfa[25];
		rfa_wire_26 = rfa[26];
		rfa_wire_27 = rfa[27];
		rfa_wire_28 = rfa[28];
		rfa_wire_29 = rfa[29];
		rfa_wire_30 = rfa[30];
		rfa_wire_31 = rfa[31];
	}

	void register_outputs() {
		if (! rf_stall.read()) {

			rf_eu_v.write(im_rf_v.read() 
						  && !eu_branch 
						  && (rden_a || rden_b) 
						  && enable.read() 
						  && !cancelValid);

			rd_data_a.write(rd_data_bypass_mux_a);
			rd_data_b.write(rd_data_bypass_mux_b);
		}
		else {
			rf_eu_v.write(false);
		}
	}

	void registerfile_write_mux() {
		cout << "rf::eu_rf_wr_addr = " << eu_rf_wr_addr.read() << endl;
		cout << "rf::eu_rf_wr_data = " << eu_rf_wr_data.read() << endl;
		cout << "rf::eu_rf_wren    = " << eu_rf_wren.read()    << endl;

		cout << "rf::swapbit_wr_data_a = " <<  swapbit_wr_data_a << endl;
		cout << "rf::swapbit_wr_addr_a = " <<  swapbit_wr_addr_a << endl;
		cout << "rf::swapbit_wr_data_b = " <<  swapbit_wr_data_b << endl;
		cout << "rf::swapbit_wr_addr_b = " <<  swapbit_wr_addr_b << endl;
		cout << "rf::swapbit_wren.writ = " <<       swapbit_wren << endl;

		cout << "rf::eu_rf_wren 	  = " << eu_rf_wren 	   << endl;
		cout << "rf::swap_wren 		  = " << swap_wren 		   << endl;
		cout << "rf::swapbit_wren 	  = " << swapbit_wren 	   << endl;
		cout << "rf::testbit_wren 	  = " << testbit_wren 	   << endl;
		cout << "rf::setbit_wren 	  = " << setbit_wren 	   << endl;
		cout << "rf::ldimm_ab_16_wren = " << ldimm_ab_16_wren  << endl;
		cout << "rf::rf_mux_in_wren_a = " << rf_mux_in_wren_a  << endl;
		cout << "rf::rf_mux_in_wren_b = " << rf_mux_in_wren_b  << endl;

		//		for (int i = 0; i < microengine::RF_NUM_WORDS; i++) {
		//			cout << "rf::   rf[" << i << "] = " << rfa[i] << endl;
		//		}

		cout << "rf::enable = "        << enable << endl;
		cout << "rf::operandA = "        << eu_rf_instructionDecoder->getOperandA() << endl;
		cout << "rf::operandB = "        << eu_rf_instructionDecoder->getOperandB() << endl;

		if (! rf_stall.read()) {

			rd_data_dest = rfa[im_rf_instructionDecoder->getDestination()];

			swap_wren        = false; 
			swapbit_wren     = false; 
			testbit_wren     = false; 
			setbit_wren      = false; 
			ldimm_ab_16_wren = false; 
			rf_mux_in_wren_a = false; 
			rf_mux_in_wren_b = false; 

			if (enable.read() && im_rf_v.read()) {
				if (im_rf_instructionDecoder->isInstFormatOpBit()) {
					switch (im_rf_instructionDecoder->getBitOp()) {
						// Both swap register and swap bit should be atomic.
						// Atomicity is not necessarily a single cycle so long as the "other side" cannot break the sequence.
					case NSOpcode::ESwap : 
						swap_wren = true;

						swap_wr_data_a = rd_data_rf_a; // FIX rd_data_imm_mux_a ??? 
						swap_wr_addr_a = rd_addr_a; // FIX rd_data_imm_mux_b ???  
						wr_rf_a(swap_wr_addr_a, swap_wr_data_a, swap_wren);
						cout << "rf::write operation swap_wr_addr_a = " << swap_wr_addr_a << " swap_wr_data_a = " << swap_wr_data_a << endl;

						swap_wr_data_b = rd_data_rf_b;  // FIX rd_data_imm_mux_a ???  
						swap_wr_addr_b = rd_addr_b;  // FIX rd_data_imm_mux_b ??? 
						wr_rf_b(swap_wr_addr_b, swap_wr_data_b, swap_wren);
						cout << "rf::write operation swap_wr_addr_b = " << swap_wr_addr_b << " swap_wr_data_b = " << swap_wr_data_b << endl;
						break;
					case NSOpcode::ESwapBit : 
						swapbit_wren = true;

						swapbit_wr_data_a = rd_data_rf_a;  // FIX rd_data_imm_mux_a ??? 
						swapbit_wr_addr_a = rd_addr_b;  // FIX rd_data_imm_mux_b ??? 
						wr_rf_a(swapbit_wr_addr_a, swapbit_wr_data_a, swapbit_wren);
						cout << "rf::write operation swapbit_wr_addr_a = " << swapbit_wr_addr_a << " swapbit_wr_data_a = " << swapbit_wr_data_a << endl;

						swapbit_wr_data_b = rd_data_rf_b;  // FIX rd_data_imm_mux_a ??? 
						swapbit_wr_addr_b = rd_addr_a;  // FIX rd_data_imm_mux_b ??? 
						wr_rf_b(swapbit_wr_addr_b, swapbit_wr_data_b, swapbit_wren);
						cout << "rf::write operation swapbit_wr_addr_b = " << swapbit_wr_addr_b << " swapbit_wr_data_b = " << swapbit_wr_data_b << endl;
						break;
					case NSOpcode::ETestBit: 
						testbit_wren = true;

						testbit_wr_data =  swapBit(rd_data_dest, rd_data_rf_a, rd_data_imm_mux_a  ); // fix
						testbit_wr_addr = im_rf_instructionDecoder->getDestination();
						wr_rf_a(testbit_wr_addr, testbit_wr_data, testbit_wren);
						cout << "rf::write operation testbit_wr_addr = " << testbit_wr_addr << " testbit_wr_data = " << testbit_wr_data << endl;
						break;
					case NSOpcode::ESetBit : 
						setbit_wren = true;

						setbit_wr_data =  setBit(rd_data_dest, rd_data_rf_a, rd_data_imm_mux_a ); // fix 
						setbit_wr_addr = im_rf_instructionDecoder->getDestination();
						wr_rf_a(setbit_wr_addr, setbit_wr_data, setbit_wren);
						cout << "rf::write operation setbit_wr_addr = " << setbit_wr_addr << " setbit_wr_data = " << setbit_wr_data << endl;
						break;
		 
					default: cerr << "ERROR: swap or bit instruction format " << im_rf_instructionDecoder->printInstFormat() << " opcode val = " << im_rf_instructionDecoder->getBitOp() << " ir = " <<  hex << im_rf_instructionDecoder->getInstructionReg() << endl;
					}
				}
				else if (im_rf_instructionDecoder->isInstFormatOpLdIm ()) { // create immediates and do sign extension

					TUInt maskLowerTwoBytes = 0x0000FFFF;
					TUInt maskUpperTwoBytes = 0xFFFF0000;
					cout << "rf::Info im_rf_instructionDecoder->isInstFormatOpLdIm ()" << endl;

					switch (im_rf_instructionDecoder->getLdImOp()) {
					case NSOpcode::ELoadLow :
						cout << "rf::Info: ELoadLow before rf_dest_data =  " << rf_dest_data << " ldimm field = " << im_rf_instructionDecoder->getLdImmOperand16Field()  << " ir =" << hex << im_rf_instructionDecoder->getInstructionReg() << endl;
						rf_dest_data = signExtend16(im_rf_instructionDecoder->getLdImmOperand16Field());
						// rf_dest_data = im_rf_instructionDecoder->getLdImmOperand16Field();
						cout << "rf::Info: after rf_dest_data =  " << rf_dest_data << " ldimm field = " << im_rf_instructionDecoder->getLdImmOperand16Field()  << " ir =" << hex << im_rf_instructionDecoder->getInstructionReg() << endl;
	
						ldimm_ab_16_wren = true;
						ldimm_ab_16_wr_data = rf_dest_data;
						ldimm_ab_16_wr_addr = im_rf_instructionDecoder->getDestination();
						wr_rf_a(ldimm_ab_16_wr_addr, ldimm_ab_16_wr_data, ldimm_ab_16_wren);
						cout << "rf::ldimm high write operation ldimm_ab_16_wr_addr = " << ldimm_ab_16_wr_addr << " ldimm_ab_16_wr_data = " << ldimm_ab_16_wr_data << endl;
						break;
					case NSOpcode::ELoadHigh :
						cout << "rf::Info: ELoadHigh before rf_dest_data =  " << rf_dest_data << " ldimm field = " << im_rf_instructionDecoder->getLdImmOperand16Field()  << " ir =" << hex << im_rf_instructionDecoder->getInstructionReg() << endl;
						// get the destination word
						rf_dest_data = rfa[im_rf_instructionDecoder->getDestination()];
						// zero the upper two bytes
						rf_dest_data = rf_dest_data & 0xFFFF0000;
						// get the 16-bit imm word
						// or the 16-bit imm word into the dest data upper two bytes
						rf_dest_data = rf_dest_data | (im_rf_instructionDecoder->getLdImmOperand16Field() << 16);
	
						ldimm_ab_16_wren = true;
						ldimm_ab_16_wr_data = rf_dest_data;
						ldimm_ab_16_wr_addr = im_rf_instructionDecoder->getDestination();
						wr_rf_a(ldimm_ab_16_wr_addr, ldimm_ab_16_wr_data, ldimm_ab_16_wren);
						cout << "rf::ldimm high write operation ldimm_ab_16_wr_addr = " << ldimm_ab_16_wr_addr << " ldimm_ab_16_wr_data = " << ldimm_ab_16_wr_data << endl;
						break;
					case NSOpcode::EMsg :
						cout << "rf::Message: FIX add string table from asm later #  " << im_rf_instructionDecoder->getLdImmOperand16Field() << endl;
						break;
					default: cerr << "ERROR: op ldimm instruction format " << im_rf_instructionDecoder->printInstFormat() << " opcode val = " << im_rf_instructionDecoder->getBitOp() << " ir = " <<  hex << im_rf_instructionDecoder->getInstructionReg() << endl;
					}
				}
			}
		}

	}

	void wr_rf_a(TUInt wr_addr, TUInt wr_data, bool wren) {
		wr_addr_a = wr_addr;
		wr_data_a = wr_data;
		wren_a    = wren   ;
	}

	void wr_rf_b(TUInt wr_addr, TUInt wr_data, bool wren) {
		wr_addr_b = wr_addr;
		wr_data_b = wr_data;
		wren_b    = wren   ;
	}


	void registerfile_write_rf() {

		// write back from the eu
		if (enable.read() && eu_rf_wren) {
			if (0 < eu_rf_wr_addr.read() && eu_rf_wr_addr.read() < microengine::RF_NUM_WORDS) {
				rfa[eu_rf_wr_addr.read()] = eu_rf_wr_data.read();
				cout << "rf::rf_mux_in_write operation eu_rf_wr_addr.read() = " << eu_rf_wr_addr.read() << " eu_rf_wr_data.read() = " << eu_rf_wr_data.read() << endl;
			}
			else {
				if (0 < eu_rf_wr_addr.read()) {
					cerr << "ERROR: rf: rf_mux_in_write operation rf_mux_in_wr_addr = " << eu_rf_wr_addr.read() << " eu_rf_wr_data.read() = " << eu_rf_wr_data.read() << endl;
				}
			}
		}

		else if (enable.read() && wren_a) {
			if (0 < wr_addr_a && wr_addr_a < microengine::RF_NUM_WORDS) {
				rfa[wr_addr_a] = wr_data_a;
				cout << "rf::write operation wr_addr_a = " << wr_addr_a << endl;
			}
			else {
				if (0 < wr_addr_a) {
					cerr << "ERROR: rf: write operation wr_addr_a = " << wr_addr_a << endl;
				}
			}
		}

		if (enable.read() && wren_b) {
			if (0 < wr_addr_b && wr_addr_b < microengine::RF_NUM_WORDS) {
				rfa[wr_addr_b] = wr_data_b;
				cout << "rf::write operation wr_addr_b = " << wr_addr_b << endl;
			}
			else {
				if (0 < wr_addr_b) {
					cerr << "ERROR: rf: write operation wr_addr_b = " << wr_addr_b << endl;
				}
			}
		}

	}

	SC_CTOR(rf) {
		cout << "unit me instance name = " << name() << endl;
    
		SC_METHOD(registerfile_read);
		sensitive 
			<< enable
			<< eu_branch
			<< im_rf_ir
			<< eu_rf_wren 
			<< eu_rf_wr_addr
			<< eu_rf_wr_data
			<< eu_rf_ir
			<< rd_data_a
			<< rd_data_b
			<< im_rf_v 
			<< rf_eu_v 
			;

		SC_METHOD(registerfile_write_rf);
		sensitive << clk.pos();

		SC_METHOD(register_outputs);
		sensitive << clk.pos();

		im_rf_instructionDecoder = new NSOpcode::MeInstructionDecoder();
		eu_rf_instructionDecoder = new NSOpcode::MeInstructionDecoder();

		dont_initialize();
	}
};

#endif
