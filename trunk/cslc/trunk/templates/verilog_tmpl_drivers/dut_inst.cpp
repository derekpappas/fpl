#include "../html_template.h"
//#include "../tmpl_interface/interface.cpp"

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------
int main(int argc, char* argv[]) 
{
 // create a template object
  // html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/temp//lates/verilog_tb_templates/dut_inst.tmpl");
string path = getenv("WORK");
html_template templ(path + "/trunk/templates/verilog_tb_templates/dut_inst.tmpl");

 char file_name[20] = "TB.v";

 map<string,string> f2a;
 map<string,string>::const_iterator map_iter;

 map<string,string> in_ports;
 map<string,string> out_ports;
 map<string,string>::const_iterator iter1,iter2;

 //-------------------------From interface-----------
  string dut_inst = "a0";
  string dut_name = "a";
 //--------------------------------------------
 in_ports.insert(make_pair("p_in1","wire"));
 in_ports.insert(make_pair("p_in2","wire"));
 out_ports.insert(make_pair("p_out1","reg"));
 out_ports.insert(make_pair("p_out2","wire"));

  //------------dut f2a connections-----------

for(iter1 = in_ports.begin(); iter1 !=in_ports.end(); iter1++){
 
   string pi_name = iter1->first;
   string wire_name = dut_inst + "_in_" + pi_name;
   f2a.insert(make_pair(pi_name,wire_name));
 }
for(iter2 = out_ports.begin(); iter2 != out_ports.end(); iter2++){

   string po_name = iter2->first;
   string wire_name= dut_inst + "_out_" + po_name;
   f2a.insert(make_pair(po_name,wire_name));
   }
//-------------------------------------------
//--------from interface---------------------


 loop_t port_list;

 for(map_iter = f2a.begin(); map_iter != f2a.end(); map_iter++){
   row_t row;
   row("port_name")= map_iter->first;
   row("wire_name") = map_iter->second;
   port_list += row;
 }

 templ("dut_name") = dut_name;
 templ("dut_inst") = dut_inst;
 templ("port_list") = port_list;

 // cout << templ;
//-------------add to tb file-------------
  ofstream testbench(file_name, ios::app);
  testbench << templ;

 return 0;
}
