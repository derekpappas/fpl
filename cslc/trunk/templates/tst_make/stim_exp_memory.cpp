#include "../html_template.h"

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------
int main(int argc, char* argv[]) 
{
 // create a template object
  // html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/templates/verilog_tb_templates/stim_exp_memory.tmpl");
string path = getenv("WORK");
html_template templ(path + "/trunk/templates/verilog_tb_templates/stim_exp_memory.tmpl");

 char file_name[20] = "TB.v";
 //-------------values received from param.tmpl--------------
 string SIM_TIMEOUT_CNT = "SIM_TIMEOUT_CNT";
 string STIM_MEM_WIDTH = "STIM_MEM_WIDTH";
 string STIM_ADDR_WIDTH = "STIM_ADDR_WIDTH";
 string STIM_VECTOR_ID = "STIM_VECTOR_ID";
 string STIM_VECTOR_VERSION = "STIM_VECTOR_VERSION";
 string STIM_VECTOR_NAME = "STIM_VECTOR_NAME";
 string STIM_VECTOR_FILE = "STIM_VECTOR_FILE";
 string STIM_VECTOR_RADIX = "STIM_VECTOR_RADIX";
 string STIM_VECTOR_MAX_ERR = "STIM_VECTOR_MAX_ERR";

 string EXP_MEM_WIDTH = "EXP_MEM_WIDTH";
 string EXP_ADDR_WIDTH = "EXP_ADDR_WIDTH";
 string EXP_VECTOR_ID = "EXP_VECTOR_ID";
 string EXP_VECTOR_VERSION = "EXP_VECTOR_VERSION";
 string EXP_VECTOR_NAME = "EXP_VECTOR_NAME";
 string EXP_VECTOR_FILE = "EXP_VECTOR_FILE";
 string EXP_VECTOR_RADIX = "EXP_VECTOR_RADIX";
 string EXP_VECTOR_MAX_ERR = "EXP_VECTOR_MAX_ERR";
 //--------------------------------------------------------
 string stim_exp_mem = "stim_exp_mem";  //from vectors
 //----stim parameters name from stim vector module----------------- 
 string S_ADDR_WIDTH = "ADDR_WIDTH";
 string S_MEM_WIDTH = "MEM_WIDTH";
 string S_VECTOR_FILE = "VECTOR_FILE";
 string S_VECTOR_ID = "VECTOR_ID";
 string S_VECTOR_NAME = "VECTOR_NAME";
 string S_VECTOR_RADIX = "VECTOR_RADIX";
 string S_VECTOR_VERSION = "VECTOR_VERSION";

 //------------------------------------------------------------
 //----------------tb signals from signals.tmpl----------------
 string clk = "clk";
 string testbench_reset_ = "testbench_reset_";
 // string rand_valid = "rand_valid";
 string expect_out_valid ="expect_out_valid";
 string rd_en_ = "rd_en";
 string stim_mem_version_err ="stim_mem_version_err";
 string exp_mem_version_err = "exp_mem_version_err";
 string stim_mem_id_err = "stim_mem_id_err";
 string exp_mem_id_err = "exp_mem_id_err";
 //----------------------------------------------------------------
 //-------exp parameters name from exp vector module---------------
 string E_ADDR_WIDTH = "ADDR_WIDTH";
 string E_MEM_WIDTH = "MEM_WIDTH";
 string E_VECTOR_FILE = "VECTOR_FILE";
 string E_VECTOR_ID = "VECTOR_ID";
 string E_VECTOR_NAME = "VECTOR_NAME";
 string E_VECTOR_RADIX = "VECTOR_RADIX";
 string E_VECTOR_VERSION = "VECTOR_VERSION";
 //------------------------------------------------------------
 //------------------stim_exp_memory ports from vectors-----
 string clock = "clock";
 string id_err = "id_err";
 string rd_en ="rd_en";
 string reset_ = "reset_";
 string valid = "valid";
 string version_err = "version_err";
 string vector_out = "vector_out";
 
 //--------------------------memory instances--------------------
 string stim_mem_inst = "stim_mem_inst";
 string exp_mem_inst = "exp_mem_inst";
 //------------------------------------------------------------ 
 //-----------------TB signals for DUT input ports-----------------
 //These are created in signals.cpp

 vector<string> dut_in_wires;
 vector<string> dut_exp_wires;
 vector<string>::const_iterator iter1,iter2;

 dut_in_wires.push_back("a0_in_p_in1");
 dut_in_wires.push_back("a0_in_p_in2");
 dut_exp_wires.push_back("a0_out_p_out1_expected");
 dut_exp_wires.push_back("a0_out_p_out2_expected");

 //---------------------------------------------------------------
 loop_t stimulus;
 loop_t expected;
 row_t row;

for(iter1 = dut_in_wires.begin(); iter1 !=dut_in_wires.end(); iter1++){
    string pi_name = *iter1;
    // row_t row;
    row("in_wire_name")= pi_name;
   
    stimulus += row;
 }
 
 //------------------------------------------------------------
 //----------------TB signals for DUT output ports-------------
 //These are created in signals.cpp

for(iter2 = dut_exp_wires.begin(); iter2 !=dut_exp_wires.end(); iter2++){
    string po_name = *iter2;
    // row_t row;
    row("out_wire_name")= po_name;
    
    expected += row;
 }
 
//------------------TB parameters--------------------------
 templ("STIM_TIMEOUT_CNT") = SIM_TIMEOUT_CNT;
 templ("STIM_MEM_WIDTH") = STIM_MEM_WIDTH;
 templ("STIM_ADDR_WIDTH") = STIM_ADDR_WIDTH;
 templ("STIM_VECTOR_ID") = STIM_VECTOR_ID;
 templ("STIM_VECTOR_VERSION") = STIM_VECTOR_VERSION;
 templ("STIM_VECTOR_NAME") = STIM_VECTOR_NAME;
 templ("STIM_VECTOR_FILE") = STIM_VECTOR_FILE;
 templ("STIM_VECTOR_RADIX") = STIM_VECTOR_RADIX;
 templ("STIM_VECTOR_MAX_ERR") = STIM_VECTOR_MAX_ERR;

 templ("EXP_MEM_WIDTH") = EXP_MEM_WIDTH;
 templ("EXP_ADDR_WIDTH") = EXP_ADDR_WIDTH;
 templ("EXP_VECTOR_ID") = EXP_VECTOR_ID;
 templ("EXP_VECTOR_VERSION") = EXP_VECTOR_VERSION;
 templ("EXP_VECTOR_NAME") = EXP_VECTOR_NAME;
 templ("EXP_VECTOR_FILE") = EXP_VECTOR_FILE;
 templ("EXP_VECTOR_RADIX") = EXP_VECTOR_RADIX;
 templ("EXP_VECTOR_MAX_ERR") = EXP_VECTOR_MAX_ERR;
 //--------------------------------------------------------------
 templ("stimulus") = stimulus; // tb stim wires
 templ("expected") = expected; //tb exp wires
 templ("stim_exp_mem")= stim_exp_mem;
 //----------------------stim_exp_mem parameters------------------
 templ("S_ADDR_WIDTH")= S_ADDR_WIDTH;
 templ("S_MEM_WIDTH")= S_MEM_WIDTH;
 templ("S_VECTOR_FILE")= S_VECTOR_FILE;
 templ("S_VECTOR_ID")= S_VECTOR_ID;
 templ("S_VECTOR_NAME")= S_VECTOR_NAME;
 templ("S_VECTOR_RADIX")= S_VECTOR_RADIX;
 templ("S_VECTOR_VERSION")= S_VECTOR_VERSION;

 templ("E_ADDR_WIDTH")= E_ADDR_WIDTH;
 templ("E_MEM_WIDTH")= E_MEM_WIDTH;
 templ("E_VECTOR_FILE")= E_VECTOR_FILE;
 templ("E_VECTOR_ID")= E_VECTOR_ID;
 templ("E_VECTOR_NAME")= E_VECTOR_NAME;
 templ("E_VECTOR_RADIX")= E_VECTOR_RADIX;
 templ("E_VECTOR_VERSION")= E_VECTOR_VERSION;
 //---------------------------------------------------------------
 //------------------stim_exp_mem formals-------------------------
 templ("clock")= clock;
 templ("id_err")= id_err;
 templ("rd_en")= rd_en;
 templ("reset_")= reset_;
 templ("valid")= valid;
 templ("version_err")= version_err;
 templ("vector_out") = vector_out;

 //----------------------------------------------------------
 //-------------stm_exp mem actuals------------------------
 templ("clk") = clk;
 templ("testbench_reset_") = testbench_reset_;
 templ("expect_out_valid") = expect_out_valid;
 templ("rd_en_") = rd_en_;
 templ("stim_mem_version_err") = stim_mem_version_err;
 templ("exp_mem_version_err") = exp_mem_version_err;
 templ("stim_mem_id_err") = stim_mem_id_err;
 templ("exp_mem_id_err") = exp_mem_id_err;
 templ("expect_out_valid")= expect_out_valid;
 //---------------------------------------------------------
 templ("stim_mem_inst")= stim_mem_inst;
 templ("exp_mem_inst")= exp_mem_inst;
 
 //-----------------------------------------------------------

 //cout << templ;
//-------------add to tb file-------------
  ofstream testbench(file_name, ios::app);
  testbench << templ;

 return 0;
}

 
