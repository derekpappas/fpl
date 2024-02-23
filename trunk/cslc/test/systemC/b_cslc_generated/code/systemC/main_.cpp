//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "systemc.h"
#include "SystemCVectorWriter.cpp" 
#include "a.h"
#include "b.h"
#include "stim.h"
#include "tb_sysc.h"
int sc_main (int argc , char *argv[]) {

  sc_signal<bool> in, out;
  sc_clock clk("clk", 10, SC_NS,0.5);

  stim *stim0_;
  stim0_ = new stim("stim0_");
  stim0_->A(in);
  stim0_->clk(clk);

  b *b0_;
  b0_ = new b("b0_");
  b0_->in(in);
  b0_->out(out);
  b0_->clk(clk);

  tb_sysc *tb_sysc0_;
  tb_sysc0_ = new tb_sysc("tb_sysc0_");
  tb_sysc0_->in(in);
  tb_sysc0_->out(out);
  tb_sysc0_->clk(clk);
  
  sc_start();  // run forever

 return 0;
}
