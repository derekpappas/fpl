#include "im.h"

	template < class T, int N> 
	void im < T, N>::pipelineValid() {
		if (! rf_stall.read()) {
			im_rf_v.write(pc_im_v.read() && !eu_branch);
		}
	}

	template < class T, int N> 
	void im < T, N>::im_proc() {
		if (! rf_stall.read()) {

			if (RnW) {
				data = buffer[pc_im_address.read()];
				std::cout << "   read op  buffer[" << pc_im_address << "] = " <<  buffer[pc_im_address] << " im read operation  = " << pc_im_address.read() << " data = " << data.read()  <<  std::endl;
			}
			else {
				data = 0;
				std::cout << "NO read op  buffer[" << pc_im_address << "] = " <<  buffer[pc_im_address] << " im read operation  = " << pc_im_address.read() << " data = " << data.read()  <<  std::endl;
			
			}
		}
	}

	template < class T, int N> 
	im < T, N>::im(sc_core::sc_module_name name)  :
		sc_module( name ) {
		cout << "unit me instance name = " << name() << endl;

		SC_METHOD(im_proc);
		sensitive << clk.pos();

		SC_METHOD(pipelineValid);
		sensitive << clk.pos();

		buffer = new T[N];
	}


	// create a test and put it into a file

	TUInt makeOperand (TUInt x, TUInt shiftAmount) { 
		if (x >= 16 and x < 0 ) { // check that x is a valid reg value
			cerr << "ERROR: makeOperand out of bounds : " <<  x << endl;
		}

		return x << shiftAmount;
	}

	template < class T, int N> 
	TUInt im < T, N>::makeOperandA (TUInt x) { return makeOperand (x, NSOpcode::EShiftOperandA);}

	template < class T, int N> 
	TUInt im < T, N>::makeOperandB (TUInt x) { return makeOperand (x, NSOpcode::EShiftOperandB);}

	template < class T, int N> 
	TUInt im < T, N>::makeDestination (TUInt x) { return makeOperand (x, NSOpcode::EShiftDestination);}

	template < class T, int N> 
	void im < T, N>::buildTest  (string binaryFileName) {
		TUInt instFormatLas  = NSOpcode::EInstFormatLas  << NSOpcode::EShiftInstFormat; 
		TUInt instFormatBit  = NSOpcode::EInstFormatBit  << NSOpcode::EShiftInstFormat; 
		TUInt instFormatLdIm = NSOpcode::EInstFormatLdIm << NSOpcode::EShiftInstFormat; 
		TUInt instFormatBr   = NSOpcode::EInstFormatBr   << NSOpcode::EShiftInstFormat; 

		TUInt operandSrcImmA= NSOpcode::EOperandReg << NSOpcode::EShiftSrcASrcImmField; 
		TUInt operandSrcImmB= NSOpcode::EOperandReg << NSOpcode::EShiftSrcBSrcImmField; 
			   
		TUInt lasOpAdd	 = NSOpcode::ELasAdd  << NSOpcode::EShiftInstruction;
		TUInt lasOpSub	 = NSOpcode::ELasSub  << NSOpcode::EShiftInstruction;
		TUInt lasOpAnd	 = NSOpcode::ELasAnd  << NSOpcode::EShiftInstruction;
		TUInt lasOpOr	     = NSOpcode::ELasOr   << NSOpcode::EShiftInstruction;
		TUInt lasOpXor	 = NSOpcode::ELasXor  << NSOpcode::EShiftInstruction;
		TUInt lasOpXnor    = NSOpcode::ELasXnor << NSOpcode::EShiftInstruction;

		TUInt ldLow        = NSOpcode::ELoadLow << NSOpcode::EShiftInstruction;
		TUInt ldHigh       = NSOpcode::ELoadHigh << NSOpcode::EShiftInstruction;

		buffer[0] = instFormatLdIm | ldLow  |  makeDestination(3) | 4 ;
		buffer[1] = instFormatLdIm | ldHigh |  makeDestination(3) | 4 ;
		buffer[2] = instFormatLdIm | ldLow  |  makeDestination(3) | 0xFF ;
		buffer[3] = instFormatLdIm | ldHigh |  makeDestination(3) | 0xFF ;
		buffer[4] = instFormatLas | operandSrcImmA | operandSrcImmB | lasOpAdd | makeDestination(5) | makeOperandB(4) | makeOperandA(3) ;

		TUInt tmp = instFormatLas | instFormatLdIm |  makeDestination(3) | 4 ;

		std::cout << hex << "instFormatLas = " << instFormatLas << std::endl;
		std::cout << hex << "instFormatLdIm = " << instFormatLdIm << std::endl;
		std::cout << hex << "makeDestination(3) = " << makeDestination(3) << std::endl;

		std::cout << hex << "instruction = " << tmp << std::endl;

		for(int i = 0; i < N; i++) {
			std::cout << hex << "write buffer[" << i << "] = " << buffer[i] << std::endl;
		}

		std::fstream out(binaryFileName.c_str(), std::ios_base::out);
		if (out.is_open()) {			
			out.setf(std::ios_base::hex | std::ios_base::basefield);
			out.write((char *) &buffer, sizeof(buffer));
			out.close();
			cout << "buildTest::opened file for writing" << binaryFileName << endl;
		}
		else {
			cerr << "buildTest::Unable to open file for writing" << binaryFileName << endl;
		}
	}

	template < class T, int N> 
	void im < T, N>::loadInstructionMemory  (string binaryFileName, bool ldTest) {

		string loadBinaryFileName;

		if (ldTest) { //create a test program and run it
			loadBinaryFileName = "test.bin";
			buildTest(loadBinaryFileName);
		}
		else { // load the regular file passed in
			loadBinaryFileName = binaryFileName;
		}

		cout << "loadInstructionMemory::loadBinaryFileName = " << loadBinaryFileName << endl;

		std::fstream in(loadBinaryFileName.c_str(), std::ios_base::in);
		if (in.is_open()) {			
			//		  in.setf(std::ios_base::hex | std::ios_base::basefield);
			//		  in.read((char *) &buffer, sizeof(buffer));
			//		  in.close();	

			in >> std::hex;  // #include <iomanip>
			TUInt a;
			TUInt index = 0;
			while (in >> a) {
				std::cout << std::hex  << "0x" << a << "\n";
				buffer[index++] = a;
			}

			cout << "loadInstructionMemory::opened file for reading" << loadBinaryFileName << endl;
			
			for(int i = 0; i < N; i++) {
				std::cout << hex << "IM[" << i << "] = " << buffer[i] << std::endl;
			}
		}
		else {
			cerr << "loadInstructionMemory::Unable to open file" << loadBinaryFileName << endl;
		}
	}