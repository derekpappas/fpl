// Verilated -*- SystemC -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _Va2r_tap_H_
#define _Va2r_tap_H_

#include "systemc.h"
#include "verilated_sc.h"
#include "verilated.h"
class Va2r_tap__Syms;

//----------

SC_MODULE(Va2r_tap) {
  public:
    // CELLS
    // Public to allow access to /*verilator_public*/ items;
    // otherwise the application code can consider these internals.
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    sc_in<bool>	clock;
    sc_in<bool>	reset;
    sc_in<bool>	a2r_pipe_en;
    sc_in<bool>	a2r_grant_in;
    sc_in<bool>	a2r_request_in;
    sc_out<bool>	a2r_request_out;
    sc_out<bool>	a2r_grant_out;
    sc_in<bool>	a2r_aphi_in;
    sc_in<bool>	a2r_write_in;
    sc_in<bool>	a2r_read_in;
    sc_in<bool>	a2r_ready_in;
    sc_in<bool>	a2r_error_in;
    sc_out<bool>	a2r_aphi_out;
    sc_out<bool>	a2r_write_out;
    sc_out<bool>	a2r_read_out;
    sc_out<bool>	a2r_ready_out;
    sc_out<bool>	a2r_error_out;
    sc_in<bool>	a2r_retry_in;
    sc_out<bool>	a2r_retry_out;
    sc_in<bool>	slave_retry;
    sc_in<bool>	master_read;
    sc_in<bool>	master_write;
    sc_out<bool>	master_ready;
    sc_out<bool>	master_error;
    sc_in<bool>	slave_ready;
    sc_in<bool>	slave_error;
    sc_out<bool>	slave_read;
    sc_out<bool>	slave_write;
    sc_out<bool>	slave_reset;
    sc_in<uint32_t>	a2r_in;
    sc_out<uint32_t>	a2r_out;
    sc_in<uint32_t>	master_address;
    sc_in<uint32_t>	master_write_data;
    sc_out<uint32_t>	master_read_data;
    sc_in<uint32_t>	slave_read_data;
    sc_out<uint32_t>	slave_write_data;
    sc_out<uint32_t>	slave_address;
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    VL_SIG8(v__DOT__master_state,2,0);
    VL_SIG8(v__DOT__init_n,0,0);
    VL_SIG8(v__DOT__a2r_enable_out,0,0);
    VL_SIG8(v__DOT__a2r_mtr_en_out,0,0);
    VL_SIG8(v__DOT__a2r_slv_en_out,0,0);
    VL_SIG8(v__DOT__tap_aphi_in,0,0);
    VL_SIG8(v__DOT__tap_write_in,0,0);
    VL_SIG8(v__DOT__tap_read_in,0,0);
    VL_SIG8(v__DOT__tap_ready_in,0,0);
    VL_SIG8(v__DOT__tap_error_in,0,0);
    VL_SIG8(v__DOT__tap_grant_in,0,0);
    VL_SIG8(v__DOT__tap_request,0,0);
    VL_SIG8(v__DOT__tap_grant,0,0);
    VL_SIG8(v__DOT__tap_aphi_out,0,0);
    VL_SIG8(v__DOT__tap_aphi_out_d,0,0);
    VL_SIG8(v__DOT__tap_read_out,0,0);
    VL_SIG8(v__DOT__tap_write_out,0,0);
    VL_SIG8(v__DOT__tap_ready,0,0);
    VL_SIG8(v__DOT__tap_error,0,0);
    VL_SIG8(v__DOT__grant_start,3,0);
    VL_SIG8(v__DOT__tap_retry_in,0,0);
    VL_SIG8(v__DOT__tap_retry_master,0,0);
    VL_SIG8(v__DOT__tap_retry_slave,0,0);
    VL_SIG8(v__DOT__next_state,2,0);
    VL_SIG8(v__DOT__detect,0,0);
    VL_SIG8(v__DOT__slave_done,0,0);
    VL_SIG8(v__DOT__address_phase,0,0);
    VL_SIG8(v__DOT__valid_request,0,0);
    VL_SIG8(v__DOT__grant,0,0);
    VL_SIG8(v__DOT__win,0,0);
    VL_SIG8(v__DOT__genblk18__DOT__pipeline_en,0,0);
    //char	__VpadToAlign183[1];
    VL_SIG(v__DOT__tap_in,31,0);
    VL_SIG(v__DOT__tap,31,0);
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    VL_SIG8(__Vcellinp__v__clock,0,0);
    VL_SIG8(__Vcellinp__v__reset,0,0);
    VL_SIG8(__Vcellinp__v__a2r_pipe_en,0,0);
    VL_SIG8(__Vcellinp__v__a2r_grant_in,0,0);
    VL_SIG8(__Vcellinp__v__a2r_aphi_in,0,0);
    VL_SIG8(__Vcellinp__v__a2r_write_in,0,0);
    VL_SIG8(__Vcellinp__v__a2r_read_in,0,0);
    VL_SIG8(__Vcellinp__v__a2r_ready_in,0,0);
    VL_SIG8(__Vcellinp__v__a2r_error_in,0,0);
    VL_SIG8(__Vcellinp__v__a2r_retry_in,0,0);
    VL_SIG8(__Vcellinp__v__slave_retry,0,0);
    VL_SIG8(__Vcellinp__v__master_read,0,0);
    VL_SIG8(__Vcellinp__v__master_write,0,0);
    VL_SIG8(__Vcellinp__v__slave_ready,0,0);
    VL_SIG8(__Vcellinp__v__slave_error,0,0);
    VL_SIG8(__Vcellinp__v__slave_read,0,0);
    VL_SIG8(__Vcellinp__v__slave_write,0,0);
    VL_SIG8(__Vcellinp__v__slave_reset,0,0);
    VL_SIG8(__VinpClk__TOP____Vcellinp__v__reset,0,0);
    VL_SIG8(__Vclklast__TOP____Vcellinp__v__clock,0,0);
    VL_SIG8(__Vclklast__TOP____VinpClk__TOP____Vcellinp__v__reset,0,0);
    VL_SIG8(__Vchglast__TOP____Vcellinp__v__reset,0,0);
    //char	__VpadToAlign218[2];
    VL_SIG(__Vcellinp__v__a2r_in,31,0);
    VL_SIG(__Vcellinp__v__master_address,31,0);
    VL_SIG(__Vcellinp__v__master_write_data,31,0);
    VL_SIG(__Vcellinp__v__slave_read_data,31,0);
    VL_SIG(__Vcellinp__v__slave_address,31,0);
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    //char	__VpadToAlign244[4];
    Va2r_tap__Syms*	__VlSymsp;		// Symbol table
    
    // PARAMETERS
    // Parameters marked /*verilator public*/ for use by application code
    
    // CONSTRUCTORS
  private:
    Va2r_tap& operator= (const Va2r_tap&);	///< Copying not allowed
    Va2r_tap(const Va2r_tap&);	///< Copying not allowed
  public:
    SC_CTOR(Va2r_tap);
    virtual ~Va2r_tap();
    
    // USER METHODS
    
    // API METHODS
  private:
    void eval();
  public:
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(Va2r_tap__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(Va2r_tap__Syms* symsp, bool first);
  private:
    static IData	_change_request(Va2r_tap__Syms* __restrict vlSymsp);
  public:
    static void	_combo__TOP__11(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_combo__TOP__2(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_combo__TOP__6(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_combo__TOP__9(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_eval(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_eval_initial(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_eval_settle(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_initial__TOP(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__5(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__8(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_settle__TOP__1(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_settle__TOP__10(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_settle__TOP__3(Va2r_tap__Syms* __restrict vlSymsp);
    static void	_settle__TOP__7(Va2r_tap__Syms* __restrict vlSymsp);
} VL_ATTR_ALIGNED(64);

#endif  /*guard*/
