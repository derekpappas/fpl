#include "../html_template.h"
//#include "../tmpl_interface/interface.cpp"

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------
int main(int argc, char* argv[]) 
{
 // create a template object
  // html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/temp//lates/verilog_tb_templates/clk_gen.tmpl");
string path = getenv("WORK");
html_template templ(path + "/trunk/templates/verilog_tb_templates/clk_gen.tmpl");

 int clk_per = 10;
 string clk = "clk";

 char file_name[20] = "TB.v";
 templ("clk") = clk;          //from interface
 templ("clk_per")= clk_per;   //from interface

 //cout << templ;
//-------------add to tb file-------------
  ofstream testbench(file_name, ios::app);
  testbench << templ;

  
 return 0;
}
