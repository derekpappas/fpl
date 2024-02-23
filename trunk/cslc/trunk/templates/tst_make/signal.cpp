#include "../html_template.h"

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------
int main(int argc, char* argv[]) 
{
 // create a template object
  // html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/templates/verilog_tb_templates/signal.tmpl");
string path = getenv("WORK");
html_template templ(path + "/trunk/templates/verilog_tb_templates/signal.tmpl");

char file_name[20] = "TB.v";

 map<string,string> in_ports;
 map<string,string> out_ports;
 
 map<string,string>::const_iterator iter1,iter2;

 //-------create vectors for signal names------------
 //these will  be used in stim_exp_memory.cpp

 vector<string> dut_in_wires;
 vector<string> dut_out_wires;
 vector<string> exp_wires;
 //-------------values received from CDOM--------------
 string inst_name = "a0";
 in_ports.insert(make_pair("p_in1","wire"));
 in_ports.insert(make_pair("p_in2","wire"));
 out_ports.insert(make_pair("p_out1","reg"));
 out_ports.insert(make_pair("p_out2","wire"));

  //-----------signal names------------------
 //tb signals used as actuals in stim_exp_mem instances
 string clk = "clk";
 string testbench_reset_ = "testbench_reset_";
 string rand_valid = "rand_valid";
 string expect_out_valid ="expect_out_valid";
 string rd_en = "rd_en";
 string stim_mem_version_err ="stim_mem_version_err";
 string exp_mem_version_err = "exp_mem_version_err";
 string stim_mem_id_err = "stim_mem_id_err";
 string exp_mem_id_err = "exp_mem_id_err";
 //------------------------------------
 string report_file_mcd = "report_file_mcd";
 string file_mcd = "file_mcd"; 
 string cycle_cnt = "cycle_cnt";
 string stop_sim = "stop_sim";
 //----------------------------------------------------
 //these signals are used as inputs for match-mismatch.tmpl
 string exp_match_count = "exp_" + inst_name + "_match_count";
 string exp_mismatch_count = "exp_" + inst_name + "_mismatch_count";
 string exp_transaction_count = "exp_" + inst_name + "_transaction_count";
 string exp_mismatch = "exp_" + inst_name + "_mismatch_count";

 //---------------------------------------------
 templ("clk") = clk;
 templ("testbench_reset_") = testbench_reset_;
 templ("rand_valid") = rand_valid;
 templ("file_mcd") = file_mcd;
 templ("report_file_mcd") = report_file_mcd;
 templ("cycle_cnt") = cycle_cnt;

 templ("exp_match_count") = exp_match_count ;
 templ("exp_mismatch_count") = exp_mismatch_count;
 templ("exp_transaction_count") = exp_transaction_count;
 templ("exp_mismatch") = exp_mismatch;

 templ("expect_out_valid") = expect_out_valid;
 templ("rd_en") = rd_en;
 templ("stim_mem_version_err") = stim_mem_version_err;
 templ("exp_mem_version_err") = exp_mem_version_err;
 templ("stim_mem_id_err") = stim_mem_id_err;
 templ("exp_mem_id_err") = exp_mem_id_err;
 templ("stop_sim") = stop_sim;

 loop_t input_signals;
 loop_t output_signals;
 loop_t exp_signals;
  row_t row;

 for(iter1 = in_ports.begin(); iter1 !=in_ports.end(); iter1++){
   string pi_name = iter1->first;
   string wire_name = inst_name + "_in_" + pi_name;

   dut_in_wires.push_back(wire_name); //output for other tmpl
   row("in_in")= wire_name;
   row("in_sig_type")= iter1->second;
   input_signals += row;
 }
 
 for(iter2 = out_ports.begin(); iter2 != out_ports.end(); iter2++){
   string po_name = iter2->first;
   string wire_name = inst_name + "_out_" + po_name;
   string exp_wire = inst_name + "_out_" + po_name + "_expect";

   dut_out_wires.push_back(wire_name); //output for other tmpl
   row("out_out")= wire_name;
   row("out_sig_type")= iter2->second;
   row("out_out_expect")= exp_wire;
   exp_wires.push_back(exp_wire); //output for other tmpl
   output_signals += row;
 }
 templ("input_signals")= input_signals;
 templ("output_signals") = output_signals;
 
 //---------------------------------------------

 templ("EXP_ADDR_WIDTH") = "EXP_ADDR_WIDTH";
 templ("cycle_cnt") = "cycle_cnt";
 templ("SIM_TIMEOUT_CNT") = "SIM_TIMEOUT_CNT";
 templ("STIM_MEM_WIDTH") = "STIM_MEM_WIDTH";
 templ("EXP_MEM_WIDTH") = "EXP_MEM_WIDTH";
 
 //cout << templ;
 //-------------add to tb file-------------
  ofstream testbench(file_name, ios::app);
  testbench << templ;

 return 0;
}
