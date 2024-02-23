#include "../html_template.h"

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------
int main(int argc, char* argv[]) 
{
 // create a template object
  // html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/templates/verilog_tb_templates/initial_block.tmpl");
string path = getenv("WORK");
html_template templ(path + "/trunk/templates/verilog_tb_templates/initial_block.tmpl");

 char file_name[20] = "TB.v";
 //----------------vars from signal.tmpl------------
 string file_mcd = "file_mcd"; 
 string cycle_cnt = "cycle_cnt";
 string testbench_reset_ = "testbench_reset_";
 string clk = "clk";
 string rand_valid = "rand_valid";
 string exp_match_count = "exp_a0_match_count";
 string exp_mismatch_count = "exp_a0_mismatch_count";
 string exp_transaction_count = "exp_a0_transaction_count";
 string exp_mismatch = "exp_a0_mismatch_count";
 //------------------------------------------------
 //-----------values from vectors------------------
 string clk_init = "1'b0";
 string rand_valid_init = "1'b1";
 string testbench_reset_init = "1'b1";
 //------------------------------------------------
 //---------inputs from vectors-------------------
 string vectors_file = "vectors.txt";
 string wavesDefaultOutputFile_dump ="wavesDefaultOutputFile_dump";
 string tb_module_name = "TB";
 //-------------------------------------------

 templ("clk") = clk;
 templ("testbench_reset_") = testbench_reset_;
 templ("cycle_cnt") = cycle_cnt;
 templ("clk_init") = clk_init;
 templ("rand_valid") = rand_valid;
 templ("rand_valid_init") = rand_valid_init;
 templ("testbench_reset_") = testbench_reset_;
 templ("testbench_reset_init") = testbench_reset_init;
 templ("match_count") = exp_match_count;
 templ("mismatch_count") = exp_mismatch_count;
 templ("transaction_count") = exp_transaction_count;
 templ("file_mcd") = file_mcd;
 templ("vectors_file") = vectors_file;
 templ("wavesDefaultOutputFile_dump") = wavesDefaultOutputFile_dump;
 templ("tb_module_name") = tb_module_name;

 //cout << templ;
//-------------add to tb file-------------
  ofstream testbench(file_name, ios::app);
  testbench << templ;

 return 0;
}
