#include "../html_template.h"
#include <fstream>
#include <iostream>

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------
int main(int argc, char* argv[]) 
{
 // create a template object
  // html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/templates/verilog_tb_templates/testbench.tmpl");
string path = getenv("WORK");
html_template templ(path + "/trunk/templates/verilog_tb_templates/testbench.tmpl");

 string tb_module_name = "TB";

 //---------------create the tb.v file------------------
 char file_name[20] = "TB.v";
 ofstream testbench;
 testbench.open(file_name, ios::out | ios::app);
 //-------------------------------------------------------
 templ("tb_module_name") = tb_module_name;

 //add to TB.v file
 testbench << templ;
 
 //---------------run all templates----------
 system("g++ -Wall -ansi -pedantic param.o ../html_template.o -o param");
 system("./param");
 system("g++ -Wall -ansi -pedantic signal.o ../html_template.o -o signal");
 system("./signal");
 system("g++ -Wall -ansi -pedantic dut_inst.o ../html_template.o -o dut_inst");
 system("./dut_inst");
 system("g++ -Wall -ansi -pedantic stim_exp_memory.o ../html_template.o -o stim_exp_memory");
 system("./stim_exp_memory");
 system("g++ -Wall -ansi -pedantic initial_block.o ../html_template.o -o initial_block");
 system("./initial_block");
 system("g++ -Wall -ansi -pedantic match.o ../html_template.o -o match");
 system("./match");

 cout << ".........Created testbench file: " << file_name << "\n";
 testbench.close();
 return 0;
}
