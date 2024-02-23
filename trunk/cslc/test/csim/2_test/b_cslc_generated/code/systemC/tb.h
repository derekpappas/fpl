template<int SIM_TIMEOUT_CNT = 100, int STIM_MEM_WIDTH = 1, int STIM_ADDR_WIDTH = 16, int STIM_VECTOR_ID = 0, int STIM_VECTOR_VERSION = 0, std::string STIM_VECTOR_NAME = "stim", std::string STIM_VECTOR_FILE = "stim_output.vec", int STIM_VECTOR_RADIX = 0, int STIM_VECTOR_MAX_ERR = 0, int EXP_MEM_WIDTH = 1, int EXP_ADDR_WIDTH = 16, int EXP_VECTOR_ID = 0, int EXP_VECTOR_VERSION = 0, std::string EXP_VECTOR_NAME = "exp", std::string EXP_VECTOR_FILE = "exp_output.vec", int EXP_VECTOR_RADIX = 0, int EXP_VECTOR_MAX_ERR = 0>
#include "systemc.h"

SC_MODULE(tb) {
sc_signal<sc_int<1> > clk;
sc_signal<sc_int<1> > testbench_reset;
sc_signal<sc_int<1> > rand_valid;
int file_mcd;
int report_file_mcd;
int cycle_cnt;
sc_signal<sc_int<1> > exp_b0_match_count;
sc_signal<sc_int<1> > exp_b0_mismatch_count;
sc_signal<sc_int<1> > exp_b0_transaction_count;
sc_signal<sc_int<1> > exp_b0_mismatch;
sc_signal<sc_int<1> > expect_out_valid;
sc_signal<sc_int<1> > rd_en;
sc_signal<sc_int<1> > version_err;
sc_signal<sc_int<1> > id_err;
sc_signal_resolvedstop_sim;
sc_signal<sc_int<1> > b0_in_in_b1;
sc_signal<sc_int<1> > b0_in_in_b2;
sc_signal<sc_int<1> > b0_out_out_b1;
sc_signal<sc_int<1> > b0_out_out_b1_expect;
sc_signal<sc_int<1> > b0_out_out_b2;
sc_signal<sc_int<1> > b0_out_out_b2_expect;
sc_signal_resolvedb0_out_out_b1_mismatch_en;
sc_signal_resolvedb0_out_out_b2_mismatch_en;
sc_signal_resolvedb0_out_out_b1_match_en;
sc_signal_resolvedb0_out_out_b2_match_en;

void cont_assign_23() {
rd_en = rand_valid;
}

<> *(b0_in_in_b1,b0_in_in_b2)<> *(b0_out_out_b1_expect,b0_out_out_b2_expect)
void sequential_block_24() {
if( ~ ) {
  }
else {
  }
}

  void nonblocking_25() {
   = ;
}

  void nonblocking_26() {
 = ;
}
initial 

void sequential_block_27() {
("time stamp: +20%y %m %d");
 = 1;
 = 1;
 = ;
wait();
 = ;
wait();
 = ;
 = ("vectors.txt");
if( == 0) {
("Error opening vectors.txt file");
;
}
(, "Dut outputs vs expected vectors:\n");
("wavesDefaultOutputFile_dump");
(, );
;
 = ;
 = ;
 = ;
}
wait();
 =  ~ ;

void sequential_block_28() {
if( ~ ) {
   = ( ());
}
else {
  if() {
     =  + 1;
     =  + 1;
    ("mismatch detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "b0", , "exp_b0", );
  }
  if() {
     =  + 1;
     =  + 1;
    ("mismatch detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "b0", , "exp_b0", );
  }
  if( > ) {
    ("Maximum number or errors allowed for vector %s has been reached", "exp_b0");
  }
}
}

void sequential_block_29() {
  if( ~ ) {
     = ( (0));
  }
  else {
    if() {
       =  + 1;
       =  + 1;
      ("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "b0", , "exp_b0", );
    }
    if() {
       =  + 1;
       =  + 1;
      ("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "b0", , "exp_b0", );
    }
  }
}
stop_sim =  >= ;
b0_out_out_b1_mismatch_en =  != ;
b0_out_out_b2_mismatch_en =  != ;
b0_out_out_b1_match_en =  == ;
b0_out_out_b2_match_en =  == ;
<><>SC_METHOD(sequential_block_24);
sensitive<<clk<<testbench_reset;
SC_METHOD(nonblocking_25);
sensitive<<clk<<testbench_reset;
SC_METHOD(nonblocking_26);
sensitive<<clk<<testbench_reset;
SC_METHOD(sequential_block_27);
sensitive<<clk<<testbench_reset;
SC_METHOD(sequential_block_28);
sensitive<<clk<<testbench_reset;
SC_METHOD(sequential_block_29);
sensitive<<clk<<testbench_reset;
  b *b0_;
  stim_expect_mem_template *stim_b0_;
  stim_expect_mem_template *exp_b0_;
  SC_CTOR(tb) {
      SC_METHOD(cont_assign_23);
      SC_METHOD(cont_assign_24);
      SC_METHOD(cont_assign_25);
      SC_METHOD(cont_assign_26);
      SC_METHOD(cont_assign_27);
      SC_METHOD(cont_assign_28);
      SC_METHOD(cont_assign_29);
      b0_ = new b("b0_");
      stim_b0_ = new stim_expect_mem_template("stim_b0_");
      exp_b0_ = new stim_expect_mem_template("exp_b0_");
      b0_->clk(clk();
      b0_->in_b1(b0_in_in_b1);
      b0_->in_b2(b0_in_in_b2);
      b0_->out_b1(b0_out_out_b1);
      b0_->out_b2(b0_out_out_b2);
      stim_b0_->clock(clk);
      stim_b0_->id_err(id_err);
      stim_b0_->rd_en(rd_en);
      stim_b0_->reset_(testbench_reset);
      stim_b0_->valid(expect_out_valid);
      stim_b0_->vector_out);
      stim_b0_->version_err(version_err);
      exp_b0_->clock(clk);
      exp_b0_->id_err(id_err);
      exp_b0_->rd_en(rd_en);
      exp_b0_->reset_(testbench_reset);
      exp_b0_->valid(expect_out_valid);
      exp_b0_->vector_out);
      exp_b0_->version_err(version_err);
  }
};

