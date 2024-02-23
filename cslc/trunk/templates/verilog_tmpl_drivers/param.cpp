#include "../html_template.h"

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------
int main(int argc, char* argv[]) 
{
 // create a template object
 //html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/templates/verilog_tb_templates/param.tmpl");
  string path = getenv("WORK");
  html_template templ(path + "/trunk/templates/verilog_tb_templates/param.tmpl");

char file_name[20] = "TB.v";
 //---------inputs from vectors module-------
 //------names--------------------
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

 //----values---------------------
 string STIM_VECTOR_NAME_val = "\"stim\"";
 string STIM_VECTOR_FILE_val = "\"stim\"";
 string EXP_VECTOR_NAME_val = "\"exp\"";
 string EXP_VECTOR_FILE_val = "\"exp\"";
 int STIM_TIMEOUT_CNT_val = 100;
 int STIM_MEM_WIDTH_val = 3;
 int STIM_ADDR_WIDTH_val =16;
 int STIM_VECTOR_ID_val = 4;
 int STIM_VECTOR_VERSION_val =5;
 int STIM_VECTOR_RADIX_val = 1;
 int STIM_VECTOR_MAX_ERR_val = 0;
 int EXP_MEM_WIDTH_val = 3;
 int EXP_ADDR_WIDTH_val =16;
 int EXP_VECTOR_ID_val = 6;
 int EXP_VECTOR_VERSION_val =7;
 int EXP_VECTOR_RADIX_val = 1;
 int EXP_VECTOR_MAX_ERR_val = 10;

 //------------Parameter names-------------
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

 //------------parameters values----------------
 templ("STIM_TIMEOUT_CNT_val")= STIM_TIMEOUT_CNT_val;
 templ("STIM_MEM_WIDTH_val")= STIM_MEM_WIDTH_val;
 templ("STIM_ADDR_WIDTH_val")= STIM_ADDR_WIDTH_val;
 templ("STIM_VECTOR_ID_val")= STIM_VECTOR_ID_val;
 templ("STIM_VECTOR_VERSION_val")= STIM_VECTOR_VERSION_val;
 templ("STIM_VECTOR_NAME_val")= STIM_VECTOR_NAME_val;
 templ("STIM_VECTOR_FILE_val")= STIM_VECTOR_FILE_val;
 templ("STIM_VECTOR_RADIX_val")= STIM_VECTOR_RADIX_val;
 templ("STIM_VECTOR_MAX_ERR_val")= STIM_VECTOR_MAX_ERR_val;

 templ("EXP_MEM_WIDTH_val")= EXP_MEM_WIDTH_val;
 templ("EXP_ADDR_WIDTH_val")= EXP_ADDR_WIDTH_val;
 templ("EXP_VECTOR_ID_val")= EXP_VECTOR_ID_val;
 templ("EXP_VECTOR_VERSION_val")= EXP_VECTOR_VERSION_val;
 templ("EXP_VECTOR_NAME_val")= EXP_VECTOR_NAME_val;
 templ("EXP_VECTOR_FILE_val")= EXP_VECTOR_FILE_val;
 templ("EXP_VECTOR_RADIX_val")= EXP_VECTOR_RADIX_val;
 templ("EXP_VECTOR_MAX_ERR_val")= EXP_VECTOR_MAX_ERR_val;

// cout << templ;
// add to TB.v  file
 ofstream testbench(file_name, ios::app);
 testbench << templ ;

 return 0;
}
