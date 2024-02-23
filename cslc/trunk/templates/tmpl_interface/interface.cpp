#include "../html_template.h"
//#include "../../src/cslom/CSLOM_Units.cpp"
#include "interface.h"
#include "../../src/cslom_generators/CSLOM_VerilogTbCodeGenerator.cpp"
//#include "../verilog_tmpl_drivers/testbench.cpp"

/*#include <signal.h>
#include "../../src/cslc/cslc_Platform.h"
#include "../../src/cslc/new_cslc.h"
#include "../../src/support/cli/cslcCLI_Typedef.h"
#include "../../src/support/cli/cslcCLI_Support.h"

#ifndef __RLM_OFF
#include "../../src/cslc/license.h"
#endif*/

using namespace std;
using namespace tmpl;
using namespace NSCSLOm;
using namespace NSCSLOmVerilogTbGenerator; 

//----------------------------------------------------------------------------

/*void signal_handler(int signal) {
  throw NSCslc::CSLcSignal();
}


void killSingletons() {
  //  NSCLi::CLiTool::Instance()->PrepareToDie();
  NSCLi::CLiTool::DestroyInstance();
  NSCLi::CLiCommon::DestroyInstance();
  NSCslc::CslcTool::DestroyInstance();
  }*/


//int main(int argc, char* argv[]) 
void CTmplInterface( RefCSLOmVerilogTbCodeGenerator &tbGen)
{

 //---------------cslc flow-----------------------
  // Kill the singletons on exit
  /*  std::atexit(&killSingletons);

  //TODO: get 'component to run' status
  TInt cslcComponent = NSCslc::CslcTool::COMP_ALL;

  DCERR("You are running CSLC without RLM; you'd better be offline...");

  ::signal(SIGINT, signal_handler);

  NSCslc::RefCSLcMain compiler = NSCslc::CSLcMain::getCompilerInstance(&std::cout);

   int retVal = compiler->runCompiler(argc, argv, cslcComponent);

   compiler->cleanUp();*/
  // return retVal;
  //-----------------------------------------------------------------------------------

 // create a template object
  html_template templ("/home/Monica/work/svn_repo/repos/trunk/cslc/trunk/templates/verilog_tb_templates/interface.tmpl");
 

  //----------------parameters---------------------
  //------------------names------------------------
 string SIM_TIMEOUT_CNT ;
 string STIM_MEM_WIDTH ;
 string STIM_ADDR_WIDTH ;
 string STIM_VECTOR_ID ;
 string STIM_VECTOR_VERSION ;
 string STIM_VECTOR_NAME ;
 string STIM_VECTOR_FILE ;
 string STIM_VECTOR_RADIX ;
 string STIM_VECTOR_MAX_ERR ;

 string EXP_MEM_WIDTH ;
 string EXP_ADDR_WIDTH ;
 string EXP_VECTOR_ID ;
 string EXP_VECTOR_VERSION ;
 string EXP_VECTOR_NAME ;
 string EXP_VECTOR_FILE ;
 string EXP_VECTOR_RADIX ;
 string EXP_VECTOR_MAX_ERR ;

 //---------------------values---------------------
 string STIM_VECTOR_NAME_val ;
 string STIM_VECTOR_FILE_val ;
 string EXP_VECTOR_NAME_val ;
 string EXP_VECTOR_FILE_val ;
 int SIM_TIMEOUT_CNT_val ;
 int STIM_MEM_WIDTH_val ;
 int STIM_ADDR_WIDTH_val ;
 int STIM_VECTOR_ID_val ;
 int STIM_VECTOR_VERSION_val;
 int STIM_VECTOR_RADIX_val ;
 int STIM_VECTOR_MAX_ERR_val ;
 int EXP_MEM_WIDTH_val ;
 int EXP_ADDR_WIDTH_val ;
 int EXP_VECTOR_ID_val ;
 int EXP_VECTOR_VERSION_val ;
 int EXP_VECTOR_RADIX_val ;
 int EXP_VECTOR_MAX_ERR_val ;


 //-------------- TB signals name---------------
 string clk;
 string testbench_reset_ ;
 string rand_valid ;
 string expect_out_valid ;
 string rd_en ; 
 string stim_mem_version_err ;
 string exp_mem_version_err ;
 string stim_mem_id_err ;
 string exp_mem_id_err ;
 //--------------------------------------------
 string report_file_mcd ;
 string file_mcd ; 
 string cycle_cnt ;
 string stop_sim ;
 
 //---------TB signls type----------------------
 string clk_type;
 string tb_reset_type ;
 string rand_valid_type ;
 string expect_out_valid_type ;
 string rd_en_type ; 
 string stim_mem_version_err_type ;
 string exp_mem_version_err_type ;
 string stim_mem_id_err_type ;
 string exp_mem_id_err_type ;
 //--------------------------------------------
 string report_file_mcd_type ;
 string file_mcd_type ; 
 string cycle_cnt_type ;
 string stop_sim_type ;
//---------------------------------------------
 string tb_name;
 int clk_per;
 string clkTimeBase;
 string dutOutFileName;
 string tbWaveFile;
 string tbWaveType;
//---------------------------------------------

	
 SIM_TIMEOUT_CNT     = *simTimeoutName;  
 SIM_TIMEOUT_CNT_val =  simTimeoutVal ; 
 // cout << "param = " << SIM_TIMEOUT_CNT <<endl;
 
 STIM_MEM_WIDTH       = *stimMemWidthParamName;  
 STIM_MEM_WIDTH_val   =  stimAddrWidthParamVal;

 STIM_ADDR_WIDTH      = *stimAddrWidthParamName;
 STIM_ADDR_WIDTH_val  =  stimAddrWidthParamVal; 

 STIM_VECTOR_ID       = *stimVecIdParamName; 
 STIM_VECTOR_ID_val   =  stimVecIdParamVal; 
 
 STIM_VECTOR_VERSION     = *stimVecVerParamName; 
 STIM_VECTOR_VERSION_val =  stimVecVerParamVal; 
 
 STIM_VECTOR_NAME     = *stimVecNameParamName;  
 STIM_VECTOR_NAME_val = *stimVecNameParamVal; 
 
 STIM_VECTOR_FILE     = *stimVecFileParamName;  
 STIM_VECTOR_FILE_val = *stimVecFileParamVal; 
 
 STIM_VECTOR_RADIX    = *stimVecRadParamName;  
 STIM_VECTOR_RADIX_val=  stimVecRadParamVal;
 
 STIM_VECTOR_MAX_ERR    = *stimVecMaxErrParamName;   
 STIM_VECTOR_MAX_ERR_val=  stimVecMaxErrParamVal;
 
 EXP_MEM_WIDTH        = *expMemWidthParamName; 
 EXP_MEM_WIDTH_val    =  expMemWidthParamVal; 
 
 EXP_ADDR_WIDTH       = *expAddrWidthParamName;   
 EXP_ADDR_WIDTH_val   =  expAddrWidthParamVal; 
 
 EXP_VECTOR_ID        = *expVecIdParamName;   
 EXP_VECTOR_ID_val    =  expVecIdParamVal; 
 
 EXP_VECTOR_VERSION     = *expVecVerParamName; 
 EXP_VECTOR_VERSION_val =  expVecVerParamVal; 
 
 EXP_VECTOR_NAME      = *expVecNameParamName;   
 EXP_VECTOR_NAME_val  = *expVecNameParamVal; 
 
 EXP_VECTOR_FILE      = *expVecFileParamName; 
 EXP_VECTOR_FILE_val  = *expVecFileParamVal; 
 
 EXP_VECTOR_RADIX     = *expVecRadParamName; 
 EXP_VECTOR_RADIX_val=   expVecRadParamVal;

 EXP_VECTOR_MAX_ERR    = *expVecMaxErrParamName;   
 EXP_VECTOR_MAX_ERR_val=  expVecMaxErrParamVal;
 
 //------------------------------------------------
 
 clk                  = *clockName; 
 clk_type             = *clockType; 
 //cout << "clk = " << clk <<endl;

 testbench_reset_     = *resetName; 
 tb_reset_type        = *resetType; 
 
 rand_valid           = *randValidName;   
 rand_valid_type      = *randValidType; 
 
 expect_out_valid     = *validName; 
 expect_out_valid_type= *validType; 
 
 rd_en                = *rdEnName; 
 rd_en_type           = *rdEnType; 
 
 stim_mem_version_err = *stimVerErrName; 
 stim_mem_version_err_type = *stimVerErrType; 
 
 exp_mem_version_err  = *expVerErrName; 
 exp_mem_version_err_type  = *expVerErrType; 
 
 stim_mem_id_err      = *stimIdErrName; 
 stim_mem_id_err_type = *stimIdErrType;
 
 exp_mem_id_err       = *expIdErrName;  
 exp_mem_id_err_type  = *expIdErrType;
 
 report_file_mcd      = *reportFileMcdName;
 report_file_mcd_type = *reportFileMcdType; 
 
 file_mcd             = *fileMcdName;
 file_mcd_type        = *fileMcdType; 
 
 cycle_cnt            = *cycleCntName;
 cycle_cnt_type       = *cycleCntType;
 
 stop_sim             = *simStopName;
 stop_sim_type        = *simStopType;  
 

 //-----------------------------------------------
  //-------------DUT name------------------------
 string dut_name;
 string dut_inst;

 dut_name = *dutName;
 dut_inst = *dutInst;
 
 //------------DUT signals--------------------
 vector<string> wire_name_vec;
 vector<string> wire_type_vec;
 vector<int> wire_upper_idx_vec;
 
 string wire_name;
 string wire_type;
 int wire_upper_idx;
 

 
 for(iterIn = inPorts->begin(); iterIn != inPorts->end();iterIn++){
   
   if((*iterIn)->getName()){
     wire_name = *((*iterIn)->getName());
     wire_name_vec.push_back(wire_name);
   }
   if((*iterIn)->getWidth()){
     wire_upper_idx = ((*iterIn)->getWidth())-1 ;
     wire_upper_idx_vec.push_back(wire_upper_idx);
   }
 }
 //------------DUT ports----------------------
  vector<string> in_port_name_vec;
  vector<string> in_port_type_vec;
  vector<int> in_port_width_vec;

  vector<string> out_port_name_vec;
  vector<string> out_port_type_vec;
  vector<int> out_port_width_vec;

  string port_name;
  string port_type;
  int port_width;

 TVec_RefCSLOmExprLink::const_iterator iterIn;
 TVec_RefCSLOmExprLink::const_iterator iterOut;
 
 for(iterIn = inPorts->begin(); iterIn != inPorts->end();iterIn++){
     if((*iterIn)->getName()){
       port_name = *((*iterIn)->getName());
       in_port_name_vec.push_back(port_name);
     }
     if((*iterIn)->getType()){
       port_type = *((*iterIn)->getType());
       in_port_type_vec.push_back(port_type);
     }
     else { 
       port_type = " ";
       in_port_type_vec.push_back(port_type);
     }
     if((*iterIn)->getWidth()){
       port_width = ((*iterIn)->getWidth());
       in_port_width_vec.push_back(port_width);
     }
   }

for(iterOut = outPorts->begin(); iterOut != outPorts->end();iterOut++){
     if((*iterOut)->getName()){
       port_name = *((*iterOut)->getName());
       out_port_name_vec.push_back(port_name);
     }
     if((*iterIn)->getType()){
       port_type = *((*iterIn)->getType());
       out_port_type_vec.push_back(port_type);
     }
     else { 
       port_type = " ";
       out_port_type_vec.push_back(port_type);
     }
     if((*iterIn)->getWidth()){
       port_width = ((*iterIn)->getWidth());
       out_port_width_vec.push_back(port_width);
     }
   }
 

 //-----------TB name-------------------------
 
   tb_name = *verilogFilename;
   //cout << "TB NAME = " << tb_name << endl;

 //----------------CLK period------------------
   clk_per = per;
   //cout << "clk_per= " << clk_per <<endl;
 
 //----------------CLK timebase------------------
   clkTimeBase = *timeBase;
   //cout << "clk time base= " << clkTimeBase <<endl;
 
 //--------------DUTOutFileName---------------
 
 if(tbContainer->getDutOutFileName()){
   dutOutFileName = *tbContainer->getDutOutFileName();
 }
 //--------------TbWaveFile-------------------

   tbWaveFile = *outputFileName;
 
 //---------------TbWaveType------------------
 
   tbWaveType = *waveType;
 }
 //-------------------------------------------

 cout << templ;
 }
 else
   cout << "NO INFO!!!!" << endl;

  //system("../verilog_tmpl_drivers/make");
  //system("../verilog_tmpl_drivers/./testbench");
  //system("pwd");
 
 return 0;
}
