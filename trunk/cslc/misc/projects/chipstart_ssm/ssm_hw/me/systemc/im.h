#ifndef IMT_H
#define IMT_H
#include "systemc.h"
#include "me_config.h"
#include "TypeDefs.h"
#include "MeInstructionDecoder.h"
#include <iomanip>

using namespace std;

//template <class T, int num_words = 256, int addr_width = 16>
template <class T, int num_words = 256> SC_MODULE(im) {

	sc_in<bool> clk;
	sc_in<bool> reset_;
	sc_in<bool> enable;
	sc_in<bool> eu_branch;
	sc_in<bool> RnW;   // ReadNotWrite
	sc_in<bool> pc_im_v;
	sc_in<bool> rf_stall;
	sc_in<TUInt > pc_im_address;
	sc_out<bool> im_rf_v;
	sc_out<T> data;

	void pipelineValid();
	void im_proc();
	TUInt makeOperand (TUInt x, TUInt shiftAmount);
	TUInt makeOperand (TUInt x, TUInt shiftAmount);
	TUInt makeOperandA (TUInt x);
	TUInt makeOperandB (TUInt x);
	TUInt makeDestination (TUInt x);

	void buildTest  (string binaryFileName);
	void loadInstructionMemory  (string binaryFileName, bool ldTest = false);
    SC_CTOR(im);

 private:
    T * buffer;
};


#endif
