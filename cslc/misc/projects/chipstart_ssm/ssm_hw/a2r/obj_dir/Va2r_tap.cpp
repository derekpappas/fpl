// Verilated -*- SystemC -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Va2r_tap.h for the primary calling header

#include "Va2r_tap.h"          // For This
#include "Va2r_tap__Syms.h"

//--------------------
// STATIC VARIABLES


//--------------------

VL_SC_CTOR_IMP(Va2r_tap)
#if (SYSTEMC_VERSION>20011000)
    : clock("clock"), reset("reset"), a2r_pipe_en("a2r_pipe_en"), 
      a2r_grant_in("a2r_grant_in"), a2r_request_in("a2r_request_in"), 
      a2r_request_out("a2r_request_out"), a2r_grant_out("a2r_grant_out"), 
      a2r_aphi_in("a2r_aphi_in"), a2r_write_in("a2r_write_in"), 
      a2r_read_in("a2r_read_in"), a2r_ready_in("a2r_ready_in"), 
      a2r_error_in("a2r_error_in"), a2r_aphi_out("a2r_aphi_out"), 
      a2r_write_out("a2r_write_out"), a2r_read_out("a2r_read_out"), 
      a2r_ready_out("a2r_ready_out"), a2r_error_out("a2r_error_out"), 
      a2r_retry_in("a2r_retry_in"), a2r_retry_out("a2r_retry_out"), 
      slave_retry("slave_retry"), master_read("master_read"), 
      master_write("master_write"), master_ready("master_ready"), 
      master_error("master_error"), slave_ready("slave_ready"), 
      slave_error("slave_error"), slave_read("slave_read"), 
      slave_write("slave_write"), slave_reset("slave_reset"), 
      a2r_in("a2r_in"), a2r_out("a2r_out"), master_address("master_address"), 
      master_write_data("master_write_data"), master_read_data("master_read_data"), 
      slave_read_data("slave_read_data"), slave_write_data("slave_write_data"), 
      slave_address("slave_address")
#endif
 {
    Va2r_tap__Syms* __restrict vlSymsp = __VlSymsp = new Va2r_tap__Syms(this, name());
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Sensitivities on all clocks and combo inputs
    SC_METHOD(eval);
    sensitive << clock;
    sensitive << reset;
    sensitive << a2r_pipe_en;
    sensitive << a2r_grant_in;
    sensitive << a2r_in;
    sensitive << a2r_aphi_in;
    sensitive << a2r_write_in;
    sensitive << a2r_read_in;
    sensitive << a2r_ready_in;
    sensitive << a2r_error_in;
    sensitive << a2r_retry_in;
    sensitive << slave_retry;
    sensitive << master_address;
    sensitive << master_write_data;
    sensitive << master_read;
    sensitive << master_write;
    sensitive << slave_read_data;
    sensitive << slave_ready;
    sensitive << slave_error;
    
    // Reset internal values
    
    // Reset structure values
    __Vcellinp__v__clock = VL_RAND_RESET_I(1);
    __Vcellinp__v__reset = VL_RAND_RESET_I(1);
    __Vcellinp__v__a2r_pipe_en = VL_RAND_RESET_I(1);
    __Vcellinp__v__a2r_grant_in = VL_RAND_RESET_I(1);
    __Vcellinp__v__a2r_in = VL_RAND_RESET_I(32);
    __Vcellinp__v__a2r_aphi_in = VL_RAND_RESET_I(1);
    __Vcellinp__v__a2r_write_in = VL_RAND_RESET_I(1);
    __Vcellinp__v__a2r_read_in = VL_RAND_RESET_I(1);
    __Vcellinp__v__a2r_ready_in = VL_RAND_RESET_I(1);
    __Vcellinp__v__a2r_error_in = VL_RAND_RESET_I(1);
    __Vcellinp__v__a2r_retry_in = VL_RAND_RESET_I(1);
    __Vcellinp__v__slave_retry = VL_RAND_RESET_I(1);
    __Vcellinp__v__master_address = VL_RAND_RESET_I(32);
    __Vcellinp__v__master_write_data = VL_RAND_RESET_I(32);
    __Vcellinp__v__master_read = VL_RAND_RESET_I(1);
    __Vcellinp__v__master_write = VL_RAND_RESET_I(1);
    __Vcellinp__v__slave_read_data = VL_RAND_RESET_I(32);
    __Vcellinp__v__slave_ready = VL_RAND_RESET_I(1);
    __Vcellinp__v__slave_error = VL_RAND_RESET_I(1);
    __Vcellinp__v__slave_address = VL_RAND_RESET_I(32);
    __Vcellinp__v__slave_read = VL_RAND_RESET_I(1);
    __Vcellinp__v__slave_write = VL_RAND_RESET_I(1);
    __Vcellinp__v__slave_reset = VL_RAND_RESET_I(1);
    v__DOT__master_state = VL_RAND_RESET_I(3);
    v__DOT__init_n = VL_RAND_RESET_I(1);
    v__DOT__a2r_enable_out = VL_RAND_RESET_I(1);
    v__DOT__a2r_mtr_en_out = VL_RAND_RESET_I(1);
    v__DOT__a2r_slv_en_out = VL_RAND_RESET_I(1);
    v__DOT__tap_in = VL_RAND_RESET_I(32);
    v__DOT__tap_aphi_in = VL_RAND_RESET_I(1);
    v__DOT__tap_write_in = VL_RAND_RESET_I(1);
    v__DOT__tap_read_in = VL_RAND_RESET_I(1);
    v__DOT__tap_ready_in = VL_RAND_RESET_I(1);
    v__DOT__tap_error_in = VL_RAND_RESET_I(1);
    v__DOT__tap_grant_in = VL_RAND_RESET_I(1);
    v__DOT__tap = VL_RAND_RESET_I(32);
    v__DOT__tap_request = VL_RAND_RESET_I(1);
    v__DOT__tap_grant = VL_RAND_RESET_I(1);
    v__DOT__tap_aphi_out = VL_RAND_RESET_I(1);
    v__DOT__tap_aphi_out_d = VL_RAND_RESET_I(1);
    v__DOT__tap_read_out = VL_RAND_RESET_I(1);
    v__DOT__tap_write_out = VL_RAND_RESET_I(1);
    v__DOT__tap_ready = VL_RAND_RESET_I(1);
    v__DOT__tap_error = VL_RAND_RESET_I(1);
    v__DOT__grant_start = VL_RAND_RESET_I(4);
    v__DOT__tap_retry_in = VL_RAND_RESET_I(1);
    v__DOT__tap_retry_master = VL_RAND_RESET_I(1);
    v__DOT__tap_retry_slave = VL_RAND_RESET_I(1);
    v__DOT__next_state = VL_RAND_RESET_I(3);
    v__DOT__detect = VL_RAND_RESET_I(1);
    v__DOT__slave_done = VL_RAND_RESET_I(1);
    v__DOT__address_phase = VL_RAND_RESET_I(1);
    v__DOT__valid_request = VL_RAND_RESET_I(1);
    v__DOT__grant = VL_RAND_RESET_I(1);
    v__DOT__win = VL_RAND_RESET_I(1);
    v__DOT__genblk18__DOT__pipeline_en = VL_RAND_RESET_I(1);
    __VinpClk__TOP____Vcellinp__v__reset = VL_RAND_RESET_I(1);
    __Vclklast__TOP____Vcellinp__v__clock = VL_RAND_RESET_I(1);
    __Vclklast__TOP____VinpClk__TOP____Vcellinp__v__reset = VL_RAND_RESET_I(1);
    __Vchglast__TOP____Vcellinp__v__reset = VL_RAND_RESET_I(1);
}

void Va2r_tap::__Vconfigure(Va2r_tap__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Va2r_tap::~Va2r_tap() {
    delete __VlSymsp; __VlSymsp=NULL;
}

//--------------------


void Va2r_tap::eval() {
    Va2r_tap__Syms* __restrict vlSymsp = this->__VlSymsp; // Setup global symbol table
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    VL_DEBUG_IF(VL_PRINTF("\n----TOP Evaluate Va2r_tap::eval\n"); );
    int __VclockLoop = 0;
    IData __Vchange=1;
    while (VL_LIKELY(__Vchange)) {
	VL_DEBUG_IF(VL_PRINTF(" Clock loop\n"););
	vlSymsp->__Vm_activity = true;
	_eval(vlSymsp);
	__Vchange = _change_request(vlSymsp);
	if (++__VclockLoop > 100) vl_fatal(__FILE__,__LINE__,__FILE__,"Verilated model didn't converge");
    }
}

void Va2r_tap::_eval_initial_loop(Va2r_tap__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    int __VclockLoop = 0;
    IData __Vchange=1;
    while (VL_LIKELY(__Vchange)) {
	_eval_settle(vlSymsp);
	_eval(vlSymsp);
	__Vchange = _change_request(vlSymsp);
	if (++__VclockLoop > 100) vl_fatal(__FILE__,__LINE__,__FILE__,"Verilated model didn't DC converge");
    }
}

//--------------------
// Internal Methods

void Va2r_tap::_initial__TOP(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_initial__TOP\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // INITIAL at a2r_tap.v:210
    VL_WRITEF(" A2R TAP setup: Master ID =  0, Target ID =  0, Pipeline Settings = 11111:\n");
}

void Va2r_tap::_settle__TOP__1(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_settle__TOP__1\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    VL_ASSIGN_SII(1,vlTOPp->slave_reset, vlTOPp->__Vcellinp__v__slave_reset);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_pipe_en, vlTOPp->a2r_pipe_en);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__clock, vlTOPp->clock);
}

void Va2r_tap::_combo__TOP__2(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_combo__TOP__2\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_pipe_en, vlTOPp->a2r_pipe_en);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__clock, vlTOPp->clock);
    vlTOPp->v__DOT__genblk18__DOT__pipeline_en = ((IData)(vlTOPp->__Vcellinp__v__a2r_pipe_en) 
						  | (IData)(vlTOPp->__Vcellinp__v__reset));
}

void Va2r_tap::_settle__TOP__3(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_settle__TOP__3\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__genblk18__DOT__pipeline_en = ((IData)(vlTOPp->__Vcellinp__v__a2r_pipe_en) 
						  | (IData)(vlTOPp->__Vcellinp__v__reset));
}

void Va2r_tap::_sequent__TOP__5(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_sequent__TOP__5\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    VL_SIG8(__Vdly__v__DOT__grant_start,3,0);
    VL_SIG8(__Vdly__v__DOT__tap_grant,0,0);
    VL_SIG8(__Vdly__v__DOT__tap_retry_master,0,0);
    VL_SIG8(__Vdly__v__DOT__a2r_slv_en_out,0,0);
    VL_SIG8(__Vdly____Vcellinp__v__slave_write,0,0);
    VL_SIG8(__Vdly____Vcellinp__v__slave_read,0,0);
    //char	__VpadToAlign90[2];
    VL_SIG(__Vdly____Vcellinp__v__slave_address,31,0);
    // Body
    __Vdly__v__DOT__grant_start = vlTOPp->v__DOT__grant_start;
    __Vdly____Vcellinp__v__slave_address = vlTOPp->__Vcellinp__v__slave_address;
    __Vdly____Vcellinp__v__slave_write = vlTOPp->__Vcellinp__v__slave_write;
    __Vdly____Vcellinp__v__slave_read = vlTOPp->__Vcellinp__v__slave_read;
    __Vdly__v__DOT__a2r_slv_en_out = vlTOPp->v__DOT__a2r_slv_en_out;
    __Vdly__v__DOT__tap_retry_master = vlTOPp->v__DOT__tap_retry_master;
    __Vdly__v__DOT__tap_grant = vlTOPp->v__DOT__tap_grant;
    // ALWAYS at a2r_tap.v:309
    __Vdly__v__DOT__grant_start = (0xf & (VL_UNARYMIN_I((IData)((IData)(vlTOPp->v__DOT__init_n))) 
					  & ((0xf == (IData)(vlTOPp->v__DOT__grant_start))
					      ? 0xf
					      : ((IData)(1) 
						 + (IData)(vlTOPp->v__DOT__grant_start)))));
    // ALWAYS at a2r_tap.v:355
    vlTOPp->v__DOT__tap_retry_slave = ((IData)(vlTOPp->v__DOT__init_n) 
				       & (IData)(vlTOPp->__Vcellinp__v__slave_retry));
    // ALWAYS at a2r_tap.v:335
    vlTOPp->v__DOT__tap_error = ((IData)(vlTOPp->v__DOT__init_n) 
				 & (IData)(vlTOPp->__Vcellinp__v__slave_error));
    // ALWAYS at a2r_tap.v:334
    vlTOPp->v__DOT__tap_ready = ((IData)(vlTOPp->v__DOT__init_n) 
				 & (IData)(vlTOPp->__Vcellinp__v__slave_ready));
    // ALWAYS at a2r_tap.v:438
    vlTOPp->v__DOT__tap_retry_in = ((IData)(vlTOPp->v__DOT__init_n) 
				    & (IData)(vlTOPp->__Vcellinp__v__a2r_retry_in));
    // ALWAYS at a2r_tap.v:433
    vlTOPp->v__DOT__tap_error_in = ((IData)(vlTOPp->v__DOT__init_n) 
				    & (IData)(vlTOPp->__Vcellinp__v__a2r_error_in));
    // ALWAYS at a2r_tap.v:451
    __Vdly____Vcellinp__v__slave_address = ((IData)(vlTOPp->v__DOT__detect)
					     ? vlTOPp->v__DOT__tap_in
					     : vlTOPp->__Vcellinp__v__slave_address);
    // ALWAYS at a2r_tap.v:429
    vlTOPp->v__DOT__tap_aphi_in = ((IData)(vlTOPp->v__DOT__init_n) 
				   & (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in));
    // ALWAYS at a2r_tap.v:453
    __Vdly____Vcellinp__v__slave_write = ((((IData)(vlTOPp->v__DOT__init_n) 
					    & (IData)(vlTOPp->v__DOT__detect)) 
					   & (IData)(vlTOPp->v__DOT__tap_write_in)) 
					  | (((IData)(vlTOPp->v__DOT__init_n) 
					      & (IData)(vlTOPp->__Vcellinp__v__slave_write)) 
					     & (~ (IData)(vlTOPp->v__DOT__slave_done))));
    // ALWAYS at a2r_tap.v:456
    __Vdly____Vcellinp__v__slave_read = ((((IData)(vlTOPp->v__DOT__init_n) 
					   & (IData)(vlTOPp->v__DOT__detect)) 
					  & (IData)(vlTOPp->v__DOT__tap_read_in)) 
					 | (((IData)(vlTOPp->v__DOT__init_n) 
					     & (IData)(vlTOPp->__Vcellinp__v__slave_read)) 
					    & (~ (IData)(vlTOPp->v__DOT__slave_done))));
    // ALWAYS at a2r_tap.v:332
    vlTOPp->v__DOT__tap_read_out = (((IData)(vlTOPp->v__DOT__init_n) 
				     & (IData)(vlTOPp->v__DOT__address_phase)) 
				    & (IData)(vlTOPp->__Vcellinp__v__master_read));
    // ALWAYS at a2r_tap.v:333
    vlTOPp->v__DOT__tap_write_out = (((IData)(vlTOPp->v__DOT__init_n) 
				      & (IData)(vlTOPp->v__DOT__address_phase)) 
				     & (IData)(vlTOPp->__Vcellinp__v__master_write));
    // ALWAYS at a2r_tap.v:400
    __Vdly__v__DOT__a2r_slv_en_out = (((IData)(vlTOPp->v__DOT__init_n) 
				       & ((IData)(vlTOPp->__Vcellinp__v__slave_read) 
					  | (IData)(vlTOPp->__Vcellinp__v__slave_write))) 
				      | ((((IData)(vlTOPp->v__DOT__init_n) 
					   & (IData)(vlTOPp->v__DOT__a2r_slv_en_out)) 
					  & (~ (IData)(vlTOPp->v__DOT__tap_ready_in))) 
					 & (~ (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in))));
    // ALWAYS at a2r_tap.v:397
    vlTOPp->v__DOT__a2r_mtr_en_out = ((((IData)(vlTOPp->v__DOT__init_n) 
					& (5 == (IData)(vlTOPp->v__DOT__master_state))) 
				       & (~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in))) 
				      | ((IData)(vlTOPp->v__DOT__init_n) 
					 & (IData)(vlTOPp->v__DOT__address_phase)));
    // ALWAYS at a2r_tap.v:352
    __Vdly__v__DOT__tap_retry_master = (((((IData)(vlTOPp->v__DOT__init_n) 
					   & (5 == (IData)(vlTOPp->v__DOT__master_state))) 
					  & (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
					 & (IData)(vlTOPp->__Vcellinp__v__a2r_retry_in)) 
					| (((IData)(vlTOPp->v__DOT__init_n) 
					    & (4 == (IData)(vlTOPp->v__DOT__master_state))) 
					   & (IData)(vlTOPp->v__DOT__tap_retry_master)));
    // ALWAYS at a2r_tap.v:392
    vlTOPp->v__DOT__a2r_enable_out = ((((IData)(vlTOPp->v__DOT__init_n) 
					& (IData)(vlTOPp->__Vcellinp__v__slave_read)) 
				       | (((IData)(vlTOPp->v__DOT__init_n) 
					   & (5 == (IData)(vlTOPp->v__DOT__master_state))) 
					  & (~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)))) 
				      | ((IData)(vlTOPp->v__DOT__init_n) 
					 & (IData)(vlTOPp->v__DOT__address_phase)));
    // ALWAYS at a2r_tap.v:318
    vlTOPp->v__DOT__tap = ((IData)(vlTOPp->v__DOT__address_phase)
			    ? vlTOPp->__Vcellinp__v__master_address
			    : (((IData)(vlTOPp->__Vcellinp__v__master_write) 
				& (5 == (IData)(vlTOPp->v__DOT__master_state)))
			        ? vlTOPp->__Vcellinp__v__master_write_data
			        : ((IData)(vlTOPp->__Vcellinp__v__slave_read)
				    ? vlTOPp->__Vcellinp__v__slave_read_data
				    : 0)));
    // ALWAYS at a2r_tap.v:434
    vlTOPp->v__DOT__tap_grant_in = ((IData)(vlTOPp->v__DOT__init_n) 
				    & (IData)(vlTOPp->__Vcellinp__v__a2r_grant_in));
    // ALWAYS at a2r_tap.v:327
    __Vdly__v__DOT__tap_grant = (((IData)(vlTOPp->v__DOT__init_n) 
				  & (((0xe == (IData)(vlTOPp->v__DOT__grant_start)) 
				      | (((((IData)(vlTOPp->v__DOT__win) 
					    & (~ (IData)(vlTOPp->v__DOT__valid_request))) 
					   & (~ (IData)(vlTOPp->v__DOT__master_state))) 
					  & ((IData)(vlTOPp->v__DOT__master_state) 
					     >> 1)) 
					 | ((((IData)(vlTOPp->v__DOT__win) 
					      & (~ (IData)(vlTOPp->v__DOT__valid_request))) 
					     & (IData)(vlTOPp->v__DOT__master_state)) 
					    & (~ ((IData)(vlTOPp->v__DOT__master_state) 
						  >> 2))))) 
				     | (IData)(vlTOPp->v__DOT__tap_aphi_out_d))) 
				 | (((IData)(vlTOPp->v__DOT__init_n) 
				     & (IData)(vlTOPp->v__DOT__tap_grant)) 
				    & ((~ (IData)(vlTOPp->v__DOT__tap_request)) 
				       & (IData)(vlTOPp->v__DOT__grant))));
    vlTOPp->__Vcellinp__v__slave_address = __Vdly____Vcellinp__v__slave_address;
    vlTOPp->__Vcellinp__v__slave_write = __Vdly____Vcellinp__v__slave_write;
    vlTOPp->v__DOT__a2r_slv_en_out = __Vdly__v__DOT__a2r_slv_en_out;
    vlTOPp->v__DOT__tap_retry_master = __Vdly__v__DOT__tap_retry_master;
    vlTOPp->__Vcellinp__v__slave_read = __Vdly____Vcellinp__v__slave_read;
    vlTOPp->v__DOT__grant_start = __Vdly__v__DOT__grant_start;
    vlTOPp->v__DOT__tap_grant = __Vdly__v__DOT__tap_grant;
    VL_ASSIGN_SII(32,vlTOPp->slave_address, vlTOPp->__Vcellinp__v__slave_address);
    // ALWAYS at a2r_tap.v:428
    vlTOPp->v__DOT__tap_in = vlTOPp->__Vcellinp__v__a2r_in;
    // ALWAYS at a2r_tap.v:431
    vlTOPp->v__DOT__tap_write_in = ((IData)(vlTOPp->v__DOT__init_n) 
				    & (IData)(vlTOPp->__Vcellinp__v__a2r_write_in));
    // ALWAYS at a2r_tap.v:430
    vlTOPp->v__DOT__tap_read_in = ((IData)(vlTOPp->v__DOT__init_n) 
				   & (IData)(vlTOPp->__Vcellinp__v__a2r_read_in));
    VL_ASSIGN_SII(1,vlTOPp->slave_write, vlTOPp->__Vcellinp__v__slave_write);
    // ALWAYS at a2r_tap.v:432
    vlTOPp->v__DOT__tap_ready_in = ((IData)(vlTOPp->v__DOT__init_n) 
				    & (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in));
    VL_ASSIGN_SII(1,vlTOPp->slave_read, vlTOPp->__Vcellinp__v__slave_read);
    // ALWAYS at a2r_tap.v:325
    vlTOPp->v__DOT__tap_aphi_out_d = ((IData)(vlTOPp->v__DOT__init_n) 
				      & (IData)(vlTOPp->v__DOT__tap_aphi_out));
    // ALWAYS at a2r_tap.v:323
    vlTOPp->v__DOT__tap_request = (((IData)(vlTOPp->v__DOT__init_n) 
				    & (IData)(vlTOPp->v__DOT__valid_request)) 
				   & (~ ((IData)(vlTOPp->v__DOT__master_state) 
					 >> 2)));
    VL_ASSIGN_SII(32,vlTOPp->slave_write_data, vlTOPp->v__DOT__tap_in);
    // ALWAYS at a2r_tap.v:447
    vlTOPp->v__DOT__detect = ((IData)(vlTOPp->v__DOT__tap_aphi_in) 
			      & (~ (IData)(vlTOPp->v__DOT__tap_ready_in)));
    // ALWAYS at a2r_tap.v:324
    vlTOPp->v__DOT__tap_aphi_out = ((IData)(vlTOPp->v__DOT__init_n) 
				    & (IData)(vlTOPp->v__DOT__address_phase));
    VL_ASSIGN_SII(1,vlTOPp->a2r_request_out, vlTOPp->v__DOT__tap_request);
    // ALWAYS at a2r_tap.v:281
    vlTOPp->v__DOT__master_state = (VL_UNARYMIN_I((IData)((IData)(vlTOPp->v__DOT__init_n))) 
				    & (IData)(vlTOPp->v__DOT__next_state));
    vlTOPp->v__DOT__address_phase = (1 & (((IData)(vlTOPp->v__DOT__master_state) 
					   & ((IData)(vlTOPp->v__DOT__master_state) 
					      >> 1)) 
					  & ((IData)(vlTOPp->v__DOT__master_state) 
					     >> 2)));
    VL_ASSIGN_SII(32,vlTOPp->master_read_data, (VL_UNARYMIN_I((IData)(
								      (4 
								       == (IData)(vlTOPp->v__DOT__master_state)))) 
						& vlTOPp->v__DOT__tap_in));
    VL_ASSIGN_SII(1,vlTOPp->master_ready, ((4 == (IData)(vlTOPp->v__DOT__master_state)) 
					   & (~ (IData)(vlTOPp->v__DOT__tap_retry_master))));
    VL_ASSIGN_SII(1,vlTOPp->master_error, ((5 == (IData)(vlTOPp->v__DOT__master_state)) 
					   & (IData)(vlTOPp->v__DOT__tap_error_in)));
}

void Va2r_tap::_combo__TOP__6(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_combo__TOP__6\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__slave_retry, vlTOPp->slave_retry);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__slave_error, vlTOPp->slave_error);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__slave_ready, vlTOPp->slave_ready);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_error_in, vlTOPp->a2r_error_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__master_read, vlTOPp->master_read);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_aphi_in, vlTOPp->a2r_aphi_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_retry_in, vlTOPp->a2r_retry_in);
    VL_ASSIGN_ISI(32,vlTOPp->__Vcellinp__v__master_address, vlTOPp->master_address);
    VL_ASSIGN_ISI(32,vlTOPp->__Vcellinp__v__master_write_data, vlTOPp->master_write_data);
    VL_ASSIGN_ISI(32,vlTOPp->__Vcellinp__v__slave_read_data, vlTOPp->slave_read_data);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__master_write, vlTOPp->master_write);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_grant_in, vlTOPp->a2r_grant_in);
    VL_ASSIGN_ISI(32,vlTOPp->__Vcellinp__v__a2r_in, vlTOPp->a2r_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_write_in, vlTOPp->a2r_write_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_read_in, vlTOPp->a2r_read_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_ready_in, vlTOPp->a2r_ready_in);
}

void Va2r_tap::_settle__TOP__7(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_settle__TOP__7\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__slave_retry, vlTOPp->slave_retry);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__slave_error, vlTOPp->slave_error);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__slave_ready, vlTOPp->slave_ready);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_error_in, vlTOPp->a2r_error_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__master_read, vlTOPp->master_read);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_aphi_in, vlTOPp->a2r_aphi_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_retry_in, vlTOPp->a2r_retry_in);
    VL_ASSIGN_ISI(32,vlTOPp->__Vcellinp__v__master_address, vlTOPp->master_address);
    VL_ASSIGN_ISI(32,vlTOPp->__Vcellinp__v__master_write_data, vlTOPp->master_write_data);
    VL_ASSIGN_ISI(32,vlTOPp->__Vcellinp__v__slave_read_data, vlTOPp->slave_read_data);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__master_write, vlTOPp->master_write);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_grant_in, vlTOPp->a2r_grant_in);
    VL_ASSIGN_SII(32,vlTOPp->slave_address, vlTOPp->__Vcellinp__v__slave_address);
    VL_ASSIGN_SII(1,vlTOPp->slave_write, vlTOPp->__Vcellinp__v__slave_write);
    VL_ASSIGN_SII(1,vlTOPp->slave_read, vlTOPp->__Vcellinp__v__slave_read);
    VL_ASSIGN_ISI(32,vlTOPp->__Vcellinp__v__a2r_in, vlTOPp->a2r_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_write_in, vlTOPp->a2r_write_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_read_in, vlTOPp->a2r_read_in);
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__a2r_ready_in, vlTOPp->a2r_ready_in);
    VL_ASSIGN_SII(32,vlTOPp->slave_write_data, vlTOPp->v__DOT__tap_in);
    // ALWAYS at a2r_tap.v:447
    vlTOPp->v__DOT__detect = ((IData)(vlTOPp->v__DOT__tap_aphi_in) 
			      & (~ (IData)(vlTOPp->v__DOT__tap_ready_in)));
    VL_ASSIGN_SII(1,vlTOPp->a2r_request_out, vlTOPp->v__DOT__tap_request);
    vlTOPp->v__DOT__address_phase = (1 & (((IData)(vlTOPp->v__DOT__master_state) 
					   & ((IData)(vlTOPp->v__DOT__master_state) 
					      >> 1)) 
					  & ((IData)(vlTOPp->v__DOT__master_state) 
					     >> 2)));
    VL_ASSIGN_SII(32,vlTOPp->master_read_data, (VL_UNARYMIN_I((IData)(
								      (4 
								       == (IData)(vlTOPp->v__DOT__master_state)))) 
						& vlTOPp->v__DOT__tap_in));
    VL_ASSIGN_SII(1,vlTOPp->master_ready, ((4 == (IData)(vlTOPp->v__DOT__master_state)) 
					   & (~ (IData)(vlTOPp->v__DOT__tap_retry_master))));
    VL_ASSIGN_SII(1,vlTOPp->master_error, ((5 == (IData)(vlTOPp->v__DOT__master_state)) 
					   & (IData)(vlTOPp->v__DOT__tap_error_in)));
    vlTOPp->v__DOT__slave_done = (((IData)(vlTOPp->__Vcellinp__v__slave_ready) 
				   | (IData)(vlTOPp->__Vcellinp__v__slave_retry)) 
				  | (IData)(vlTOPp->__Vcellinp__v__slave_error));
    VL_ASSIGN_SII(1,vlTOPp->a2r_error_out, ((IData)(vlTOPp->v__DOT__a2r_slv_en_out)
					     ? (IData)(vlTOPp->v__DOT__tap_error)
					     : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
						 ? (IData)(vlTOPp->v__DOT__tap_error_in)
						 : (IData)(vlTOPp->__Vcellinp__v__a2r_error_in))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_aphi_out, ((IData)(vlTOPp->v__DOT__a2r_mtr_en_out)
					    ? (IData)(vlTOPp->v__DOT__tap_aphi_out)
					    : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
					        ? (IData)(vlTOPp->v__DOT__tap_aphi_in)
					        : (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_retry_out, ((IData)(vlTOPp->v__DOT__a2r_slv_en_out)
					     ? (IData)(vlTOPp->v__DOT__tap_retry_slave)
					     : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
						 ? (IData)(vlTOPp->v__DOT__tap_retry_in)
						 : (IData)(vlTOPp->__Vcellinp__v__a2r_retry_in))));
    vlTOPp->v__DOT__valid_request = ((IData)(vlTOPp->__Vcellinp__v__master_read) 
				     | (IData)(vlTOPp->__Vcellinp__v__master_write));
    vlTOPp->v__DOT__grant = ((IData)(vlTOPp->__Vcellinp__v__a2r_pipe_en)
			      ? (IData)(vlTOPp->v__DOT__tap_grant_in)
			      : (IData)(vlTOPp->__Vcellinp__v__a2r_grant_in));
    VL_ASSIGN_SII(32,vlTOPp->a2r_out, ((IData)(vlTOPp->v__DOT__a2r_enable_out)
				        ? vlTOPp->v__DOT__tap
				        : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
					    ? vlTOPp->v__DOT__tap_in
					    : vlTOPp->__Vcellinp__v__a2r_in)));
    VL_ASSIGN_SII(1,vlTOPp->a2r_write_out, ((IData)(vlTOPp->v__DOT__a2r_enable_out)
					     ? (IData)(vlTOPp->v__DOT__tap_write_out)
					     : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
						 ? (IData)(vlTOPp->v__DOT__tap_write_in)
						 : (IData)(vlTOPp->__Vcellinp__v__a2r_write_in))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_read_out, ((IData)(vlTOPp->v__DOT__a2r_enable_out)
					    ? (IData)(vlTOPp->v__DOT__tap_read_out)
					    : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
					        ? (IData)(vlTOPp->v__DOT__tap_read_in)
					        : (IData)(vlTOPp->__Vcellinp__v__a2r_read_in))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_ready_out, ((IData)(vlTOPp->v__DOT__a2r_slv_en_out)
					     ? (IData)(vlTOPp->v__DOT__tap_ready)
					     : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
						 ? (IData)(vlTOPp->v__DOT__tap_ready_in)
						 : (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in))));
}

void Va2r_tap::_sequent__TOP__8(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_sequent__TOP__8\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // ALWAYS at a2r_tap.v:199
    vlTOPp->v__DOT__init_n = (1 & (~ (IData)(vlTOPp->__Vcellinp__v__reset)));
}

void Va2r_tap::_combo__TOP__9(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_combo__TOP__9\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__slave_done = (((IData)(vlTOPp->__Vcellinp__v__slave_ready) 
				   | (IData)(vlTOPp->__Vcellinp__v__slave_retry)) 
				  | (IData)(vlTOPp->__Vcellinp__v__slave_error));
    VL_ASSIGN_SII(1,vlTOPp->a2r_error_out, ((IData)(vlTOPp->v__DOT__a2r_slv_en_out)
					     ? (IData)(vlTOPp->v__DOT__tap_error)
					     : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
						 ? (IData)(vlTOPp->v__DOT__tap_error_in)
						 : (IData)(vlTOPp->__Vcellinp__v__a2r_error_in))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_aphi_out, ((IData)(vlTOPp->v__DOT__a2r_mtr_en_out)
					    ? (IData)(vlTOPp->v__DOT__tap_aphi_out)
					    : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
					        ? (IData)(vlTOPp->v__DOT__tap_aphi_in)
					        : (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_retry_out, ((IData)(vlTOPp->v__DOT__a2r_slv_en_out)
					     ? (IData)(vlTOPp->v__DOT__tap_retry_slave)
					     : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
						 ? (IData)(vlTOPp->v__DOT__tap_retry_in)
						 : (IData)(vlTOPp->__Vcellinp__v__a2r_retry_in))));
    vlTOPp->v__DOT__valid_request = ((IData)(vlTOPp->__Vcellinp__v__master_read) 
				     | (IData)(vlTOPp->__Vcellinp__v__master_write));
    vlTOPp->v__DOT__grant = ((IData)(vlTOPp->__Vcellinp__v__a2r_pipe_en)
			      ? (IData)(vlTOPp->v__DOT__tap_grant_in)
			      : (IData)(vlTOPp->__Vcellinp__v__a2r_grant_in));
    VL_ASSIGN_SII(32,vlTOPp->a2r_out, ((IData)(vlTOPp->v__DOT__a2r_enable_out)
				        ? vlTOPp->v__DOT__tap
				        : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
					    ? vlTOPp->v__DOT__tap_in
					    : vlTOPp->__Vcellinp__v__a2r_in)));
    VL_ASSIGN_SII(1,vlTOPp->a2r_write_out, ((IData)(vlTOPp->v__DOT__a2r_enable_out)
					     ? (IData)(vlTOPp->v__DOT__tap_write_out)
					     : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
						 ? (IData)(vlTOPp->v__DOT__tap_write_in)
						 : (IData)(vlTOPp->__Vcellinp__v__a2r_write_in))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_read_out, ((IData)(vlTOPp->v__DOT__a2r_enable_out)
					    ? (IData)(vlTOPp->v__DOT__tap_read_out)
					    : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
					        ? (IData)(vlTOPp->v__DOT__tap_read_in)
					        : (IData)(vlTOPp->__Vcellinp__v__a2r_read_in))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_ready_out, ((IData)(vlTOPp->v__DOT__a2r_slv_en_out)
					     ? (IData)(vlTOPp->v__DOT__tap_ready)
					     : ((IData)(vlTOPp->v__DOT__genblk18__DOT__pipeline_en)
						 ? (IData)(vlTOPp->v__DOT__tap_ready_in)
						 : (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in))));
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__reset, vlTOPp->reset);
    vlTOPp->v__DOT__next_state = ((6 & (IData)(vlTOPp->v__DOT__next_state)) 
				  | (1 & (~ (((((((
						   (((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
						       & (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
						      & (IData)(vlTOPp->v__DOT__valid_request)) 
						     & (~ 
							((IData)(vlTOPp->v__DOT__master_state) 
							 >> 2))) 
						    | (((IData)(vlTOPp->__Vcellinp__v__a2r_ready_in) 
							& (~ (IData)(vlTOPp->v__DOT__valid_request))) 
						       & (~ (IData)(vlTOPp->v__DOT__master_state)))) 
						   | ((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
							& (IData)(vlTOPp->v__DOT__valid_request)) 
						       & (~ (IData)(vlTOPp->v__DOT__master_state))) 
						      & ((IData)(vlTOPp->v__DOT__master_state) 
							 >> 1))) 
						  | ((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
						       & (~ (IData)(vlTOPp->v__DOT__valid_request))) 
						      & (~ (IData)(vlTOPp->v__DOT__master_state))) 
						     & (~ 
							((IData)(vlTOPp->v__DOT__master_state) 
							 >> 1)))) 
						 | (((IData)(vlTOPp->__Vcellinp__v__a2r_ready_in) 
						     & (~ 
							((IData)(vlTOPp->v__DOT__master_state) 
							 >> 1))) 
						    & ((IData)(vlTOPp->v__DOT__master_state) 
						       >> 2))) 
						| ((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
						     & (~ (IData)(vlTOPp->v__DOT__master_state))) 
						    & (~ 
						       ((IData)(vlTOPp->v__DOT__master_state) 
							>> 1))) 
						   & ((IData)(vlTOPp->v__DOT__master_state) 
						      >> 2))) 
					       | (((IData)(vlTOPp->__Vcellinp__v__a2r_ready_in) 
						   & (~ (IData)(vlTOPp->v__DOT__valid_request))) 
						  & (~ 
						     ((IData)(vlTOPp->v__DOT__master_state) 
						      >> 2)))) 
					      | (((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
						    & (~ (IData)(vlTOPp->v__DOT__valid_request))) 
						   & (IData)(vlTOPp->v__DOT__master_state)) 
						  & ((IData)(vlTOPp->v__DOT__master_state) 
						     >> 1)) 
						 & (~ 
						    ((IData)(vlTOPp->v__DOT__master_state) 
						     >> 2)))) 
					     | (((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
						   & (IData)(vlTOPp->v__DOT__valid_request)) 
						  & (IData)(vlTOPp->v__DOT__master_state)) 
						 & (~ 
						    ((IData)(vlTOPp->v__DOT__master_state) 
						     >> 1))) 
						& (~ 
						   ((IData)(vlTOPp->v__DOT__master_state) 
						    >> 2)))))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_grant_out, ((IData)(vlTOPp->v__DOT__tap_grant) 
					    | ((~ (IData)(vlTOPp->v__DOT__tap_request)) 
					       & (IData)(vlTOPp->v__DOT__grant))));
    vlTOPp->v__DOT__win = ((IData)(vlTOPp->v__DOT__tap_request) 
			   & (IData)(vlTOPp->v__DOT__grant));
}

void Va2r_tap::_settle__TOP__10(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_settle__TOP__10\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    VL_ASSIGN_ISI(1,vlTOPp->__Vcellinp__v__reset, vlTOPp->reset);
    vlTOPp->v__DOT__next_state = ((6 & (IData)(vlTOPp->v__DOT__next_state)) 
				  | (1 & (~ (((((((
						   (((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
						       & (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
						      & (IData)(vlTOPp->v__DOT__valid_request)) 
						     & (~ 
							((IData)(vlTOPp->v__DOT__master_state) 
							 >> 2))) 
						    | (((IData)(vlTOPp->__Vcellinp__v__a2r_ready_in) 
							& (~ (IData)(vlTOPp->v__DOT__valid_request))) 
						       & (~ (IData)(vlTOPp->v__DOT__master_state)))) 
						   | ((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
							& (IData)(vlTOPp->v__DOT__valid_request)) 
						       & (~ (IData)(vlTOPp->v__DOT__master_state))) 
						      & ((IData)(vlTOPp->v__DOT__master_state) 
							 >> 1))) 
						  | ((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
						       & (~ (IData)(vlTOPp->v__DOT__valid_request))) 
						      & (~ (IData)(vlTOPp->v__DOT__master_state))) 
						     & (~ 
							((IData)(vlTOPp->v__DOT__master_state) 
							 >> 1)))) 
						 | (((IData)(vlTOPp->__Vcellinp__v__a2r_ready_in) 
						     & (~ 
							((IData)(vlTOPp->v__DOT__master_state) 
							 >> 1))) 
						    & ((IData)(vlTOPp->v__DOT__master_state) 
						       >> 2))) 
						| ((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
						     & (~ (IData)(vlTOPp->v__DOT__master_state))) 
						    & (~ 
						       ((IData)(vlTOPp->v__DOT__master_state) 
							>> 1))) 
						   & ((IData)(vlTOPp->v__DOT__master_state) 
						      >> 2))) 
					       | (((IData)(vlTOPp->__Vcellinp__v__a2r_ready_in) 
						   & (~ (IData)(vlTOPp->v__DOT__valid_request))) 
						  & (~ 
						     ((IData)(vlTOPp->v__DOT__master_state) 
						      >> 2)))) 
					      | (((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
						    & (~ (IData)(vlTOPp->v__DOT__valid_request))) 
						   & (IData)(vlTOPp->v__DOT__master_state)) 
						  & ((IData)(vlTOPp->v__DOT__master_state) 
						     >> 1)) 
						 & (~ 
						    ((IData)(vlTOPp->v__DOT__master_state) 
						     >> 2)))) 
					     | (((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
						   & (IData)(vlTOPp->v__DOT__valid_request)) 
						  & (IData)(vlTOPp->v__DOT__master_state)) 
						 & (~ 
						    ((IData)(vlTOPp->v__DOT__master_state) 
						     >> 1))) 
						& (~ 
						   ((IData)(vlTOPp->v__DOT__master_state) 
						    >> 2)))))));
    VL_ASSIGN_SII(1,vlTOPp->a2r_grant_out, ((IData)(vlTOPp->v__DOT__tap_grant) 
					    | ((~ (IData)(vlTOPp->v__DOT__tap_request)) 
					       & (IData)(vlTOPp->v__DOT__grant))));
    vlTOPp->v__DOT__win = ((IData)(vlTOPp->v__DOT__tap_request) 
			   & (IData)(vlTOPp->v__DOT__grant));
    vlTOPp->v__DOT__next_state = ((3 & (IData)(vlTOPp->v__DOT__next_state)) 
				  | (4 & ((~ ((((((~ (IData)(vlTOPp->v__DOT__valid_request)) 
						  & (~ (IData)(vlTOPp->v__DOT__master_state))) 
						 | (((~ (IData)(vlTOPp->v__DOT__master_state)) 
						     & (~ 
							((IData)(vlTOPp->v__DOT__master_state) 
							 >> 1))) 
						    & ((IData)(vlTOPp->v__DOT__master_state) 
						       >> 2))) 
						| ((~ (IData)(vlTOPp->v__DOT__win)) 
						   & (~ 
						      ((IData)(vlTOPp->v__DOT__master_state) 
						       >> 2)))) 
					       | ((~ (IData)(vlTOPp->v__DOT__valid_request)) 
						  & (~ 
						     ((IData)(vlTOPp->v__DOT__master_state) 
						      >> 2)))) 
					      | ((~ 
						  ((IData)(vlTOPp->v__DOT__master_state) 
						   >> 1)) 
						 & (~ 
						    ((IData)(vlTOPp->v__DOT__master_state) 
						     >> 2))))) 
					  << 2)));
    vlTOPp->v__DOT__next_state = ((5 & (IData)(vlTOPp->v__DOT__next_state)) 
				  | ((((((0xfffffffe 
					  & ((((IData)(vlTOPp->v__DOT__valid_request) 
					       & (~ (IData)(vlTOPp->v__DOT__master_state))) 
					      << 1) 
					     & (IData)(vlTOPp->v__DOT__master_state))) 
					 | (((IData)(vlTOPp->v__DOT__valid_request) 
					     & (~ ((IData)(vlTOPp->v__DOT__master_state) 
						   >> 2))) 
					    << 1)) 
					| ((((~ (IData)(vlTOPp->v__DOT__win)) 
					     & (IData)(vlTOPp->v__DOT__valid_request)) 
					    & (~ ((IData)(vlTOPp->v__DOT__master_state) 
						  >> 2))) 
					   << 1)) | 
				       (((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
					   & (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
					  & (IData)(vlTOPp->v__DOT__valid_request)) 
					 & (~ ((IData)(vlTOPp->v__DOT__master_state) 
					       >> 2))) 
					<< 1)) | ((
						   ((IData)(vlTOPp->v__DOT__valid_request) 
						    & (~ 
						       ((IData)(vlTOPp->v__DOT__master_state) 
							>> 1))) 
						   & (~ 
						      ((IData)(vlTOPp->v__DOT__master_state) 
						       >> 2))) 
						  << 1)) 
				     | (((((IData)(vlTOPp->v__DOT__valid_request) 
					   & (IData)(vlTOPp->v__DOT__master_state)) 
					  & (~ ((IData)(vlTOPp->v__DOT__master_state) 
						>> 1))) 
					 & (~ ((IData)(vlTOPp->v__DOT__master_state) 
					       >> 2))) 
					<< 1)));
}

void Va2r_tap::_combo__TOP__11(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_combo__TOP__11\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->v__DOT__next_state = ((3 & (IData)(vlTOPp->v__DOT__next_state)) 
				  | (4 & ((~ ((((((~ (IData)(vlTOPp->v__DOT__valid_request)) 
						  & (~ (IData)(vlTOPp->v__DOT__master_state))) 
						 | (((~ (IData)(vlTOPp->v__DOT__master_state)) 
						     & (~ 
							((IData)(vlTOPp->v__DOT__master_state) 
							 >> 1))) 
						    & ((IData)(vlTOPp->v__DOT__master_state) 
						       >> 2))) 
						| ((~ (IData)(vlTOPp->v__DOT__win)) 
						   & (~ 
						      ((IData)(vlTOPp->v__DOT__master_state) 
						       >> 2)))) 
					       | ((~ (IData)(vlTOPp->v__DOT__valid_request)) 
						  & (~ 
						     ((IData)(vlTOPp->v__DOT__master_state) 
						      >> 2)))) 
					      | ((~ 
						  ((IData)(vlTOPp->v__DOT__master_state) 
						   >> 1)) 
						 & (~ 
						    ((IData)(vlTOPp->v__DOT__master_state) 
						     >> 2))))) 
					  << 2)));
    vlTOPp->v__DOT__next_state = ((5 & (IData)(vlTOPp->v__DOT__next_state)) 
				  | ((((((0xfffffffe 
					  & ((((IData)(vlTOPp->v__DOT__valid_request) 
					       & (~ (IData)(vlTOPp->v__DOT__master_state))) 
					      << 1) 
					     & (IData)(vlTOPp->v__DOT__master_state))) 
					 | (((IData)(vlTOPp->v__DOT__valid_request) 
					     & (~ ((IData)(vlTOPp->v__DOT__master_state) 
						   >> 2))) 
					    << 1)) 
					| ((((~ (IData)(vlTOPp->v__DOT__win)) 
					     & (IData)(vlTOPp->v__DOT__valid_request)) 
					    & (~ ((IData)(vlTOPp->v__DOT__master_state) 
						  >> 2))) 
					   << 1)) | 
				       (((((~ (IData)(vlTOPp->__Vcellinp__v__a2r_ready_in)) 
					   & (IData)(vlTOPp->__Vcellinp__v__a2r_aphi_in)) 
					  & (IData)(vlTOPp->v__DOT__valid_request)) 
					 & (~ ((IData)(vlTOPp->v__DOT__master_state) 
					       >> 2))) 
					<< 1)) | ((
						   ((IData)(vlTOPp->v__DOT__valid_request) 
						    & (~ 
						       ((IData)(vlTOPp->v__DOT__master_state) 
							>> 1))) 
						   & (~ 
						      ((IData)(vlTOPp->v__DOT__master_state) 
						       >> 2))) 
						  << 1)) 
				     | (((((IData)(vlTOPp->v__DOT__valid_request) 
					   & (IData)(vlTOPp->v__DOT__master_state)) 
					  & (~ ((IData)(vlTOPp->v__DOT__master_state) 
						>> 1))) 
					 & (~ ((IData)(vlTOPp->v__DOT__master_state) 
					       >> 2))) 
					<< 1)));
}

void Va2r_tap::_eval(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_eval\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_combo__TOP__2(vlSymsp);
    if (((IData)(vlTOPp->__Vcellinp__v__clock) & (~ (IData)(vlTOPp->__Vclklast__TOP____Vcellinp__v__clock)))) {
	vlTOPp->_sequent__TOP__5(vlSymsp);
    }
    vlTOPp->_combo__TOP__6(vlSymsp);
    if ((((IData)(vlTOPp->__Vcellinp__v__clock) & (~ (IData)(vlTOPp->__Vclklast__TOP____Vcellinp__v__clock))) 
	 | ((IData)(vlTOPp->__VinpClk__TOP____Vcellinp__v__reset) 
	    & (~ (IData)(vlTOPp->__Vclklast__TOP____VinpClk__TOP____Vcellinp__v__reset))))) {
	vlTOPp->_sequent__TOP__8(vlSymsp);
    }
    vlTOPp->_combo__TOP__9(vlSymsp);
    vlTOPp->_combo__TOP__11(vlSymsp);
    // Final
    vlTOPp->__Vclklast__TOP____Vcellinp__v__clock = vlTOPp->__Vcellinp__v__clock;
    vlTOPp->__Vclklast__TOP____VinpClk__TOP____Vcellinp__v__reset 
	= vlTOPp->__VinpClk__TOP____Vcellinp__v__reset;
    vlTOPp->__VinpClk__TOP____Vcellinp__v__reset = vlTOPp->__Vcellinp__v__reset;
}

void Va2r_tap::_eval_initial(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_eval_initial\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_initial__TOP(vlSymsp);
}

void Va2r_tap::final() {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::final\n"); );
    // Variables
    Va2r_tap__Syms* __restrict vlSymsp = this->__VlSymsp;
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Va2r_tap::_eval_settle(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_eval_settle\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__1(vlSymsp);
    vlTOPp->_settle__TOP__3(vlSymsp);
    vlTOPp->_settle__TOP__7(vlSymsp);
    vlTOPp->_settle__TOP__10(vlSymsp);
}

IData Va2r_tap::_change_request(Va2r_tap__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Va2r_tap::_change_request\n"); );
    Va2r_tap* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    IData __req = false;  // Logically a bool
    __req |= ((vlTOPp->__Vcellinp__v__reset ^ vlTOPp->__Vchglast__TOP____Vcellinp__v__reset));
    VL_DEBUG_IF( if(__req && ((vlTOPp->__Vcellinp__v__reset ^ vlTOPp->__Vchglast__TOP____Vcellinp__v__reset))) VL_PRINTF("	CHANGE: a2r_tap.v:69: __Vcellinp__v__reset\n"); );
    // Final
    vlTOPp->__Vchglast__TOP____Vcellinp__v__reset = vlTOPp->__Vcellinp__v__reset;
    return __req;
}
