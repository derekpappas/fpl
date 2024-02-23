#include "../html_template.h"

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------
int main(int argc, char* argv[]) 
{
 // create a template object
  // html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/temp//lates/verilog_tb_templates/clk_gen.tmpl");
string path = getenv("WORK");
html_template templ(path + "/trunk/templates/verilog_tb_templates/clk_gen.tmpl");

 int time = 10;
 char file_name[20] = "TB.v";
 templ("clk") = "clk";
 templ("time")= time;

 // cout << templ;
//-------------add to tb file-------------
  ofstream testbench(file_name, ios::app);
  testbench << templ;

 return 0;
}
