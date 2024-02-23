#include "CSLOM_VerilogTbInterface.h"
#include <stdlib.h>
#include <fstream>
#include <iostream>

using namespace std;
using namespace tmpl;
using namespace NSCSLOm;
using namespace NSCSLOmVerilogTbGenerator; 

//----------------------------------------------------------------------------

void run_tb_interface(RefCSLOmVerilogTbGenerator& tbCodeInfo) 
{

  if(tbCodeInfo.get()){
    // create a template object
    string path = getenv("WORK");
    string testbench_path, interface_path;
    interface_path = path + "/trunk/templates/verilog_tb_templates/interface.tmpl";
    testbench_path = path + "/trunk/templates/verilog_tb_templates/testbench.tmpl"; 

    html_template templ_ifc(interface_path);
    html_template templ_tb(testbench_path);


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
 string dut_name;
 string dut_inst;
 string tb_name;
 int clk_per;
 string clkTimeBase;
 string dutOutFileName;
 string tbWaveFile;
 string tbWaveType;
//---------------------------------------------


 if(tbCodeInfo->simTimeoutName){
   SIM_TIMEOUT_CNT     = *tbCodeInfo->simTimeoutName;  
   SIM_TIMEOUT_CNT_val =  tbCodeInfo->simTimeoutVal ; 
   // cout << "param = " << SIM_TIMEOUT_CNT <<endl;
 }
 if(tbCodeInfo->stimMemWidthParamName){
   STIM_MEM_WIDTH       = *tbCodeInfo->stimMemWidthParamName;  
   STIM_MEM_WIDTH_val   =  tbCodeInfo->stimAddrWidthParamVal;
 }
 if(tbCodeInfo->stimAddrWidthParamName){
   STIM_ADDR_WIDTH      = *tbCodeInfo->stimAddrWidthParamName;
   STIM_ADDR_WIDTH_val  =  tbCodeInfo->stimAddrWidthParamVal; 
 }
 if(tbCodeInfo->stimVecIdParamName){
   STIM_VECTOR_ID       = *tbCodeInfo->stimVecIdParamName; 
   STIM_VECTOR_ID_val   =  tbCodeInfo->stimVecIdParamVal; 
 }
 if(tbCodeInfo->stimVecVerParamName){
   STIM_VECTOR_VERSION     = *tbCodeInfo->stimVecVerParamName; 
   STIM_VECTOR_VERSION_val =  tbCodeInfo->stimVecVerParamVal; 
 }
 if(tbCodeInfo->stimVecNameParamName){
   STIM_VECTOR_NAME     = *tbCodeInfo->stimVecNameParamName;  
   STIM_VECTOR_NAME_val = *tbCodeInfo->stimVecNameParamVal; 
 }
 if(tbCodeInfo->stimVecFileParamName){
   STIM_VECTOR_FILE     = *tbCodeInfo->stimVecFileParamName; 
 }
 if( tbCodeInfo->stimVecFileParamVal){
   STIM_VECTOR_FILE_val = *tbCodeInfo->stimVecFileParamVal; 
 }
 if(tbCodeInfo->stimVecRadParamName){
   STIM_VECTOR_RADIX    = *tbCodeInfo->stimVecRadParamName;  
   STIM_VECTOR_RADIX_val=  tbCodeInfo->stimVecRadParamVal;
 }
 if(tbCodeInfo->stimVecMaxErrParamName){
   STIM_VECTOR_MAX_ERR    = *tbCodeInfo->stimVecMaxErrParamName;   
   STIM_VECTOR_MAX_ERR_val=  tbCodeInfo->stimVecMaxErrParamVal;
 }
 if(tbCodeInfo->expMemWidthParamName){
   EXP_MEM_WIDTH        = *tbCodeInfo->expMemWidthParamName; 
   EXP_MEM_WIDTH_val    =  tbCodeInfo->expMemWidthParamVal; 
 }
 if(tbCodeInfo->expAddrWidthParamName){
   EXP_ADDR_WIDTH       = *tbCodeInfo->expAddrWidthParamName;   
   EXP_ADDR_WIDTH_val   =  tbCodeInfo->expAddrWidthParamVal; 
 }
 if(tbCodeInfo->expVecIdParamName){
   EXP_VECTOR_ID        = *tbCodeInfo->expVecIdParamName;   
   EXP_VECTOR_ID_val    =  tbCodeInfo->expVecIdParamVal; 
 }
 if(tbCodeInfo->expVecVerParamName){
   EXP_VECTOR_VERSION     = *tbCodeInfo->expVecVerParamName; 
   EXP_VECTOR_VERSION_val =  tbCodeInfo->expVecVerParamVal; 
 }
 if(tbCodeInfo->expVecNameParamName){
   EXP_VECTOR_NAME      = *tbCodeInfo->expVecNameParamName;   
   EXP_VECTOR_NAME_val  = *tbCodeInfo->expVecNameParamVal; 
 }
 if(tbCodeInfo->expVecFileParamVal){
   EXP_VECTOR_FILE      = *tbCodeInfo->expVecFileParamName; 
   EXP_VECTOR_FILE_val  = *tbCodeInfo->expVecFileParamVal; 
 }
 if(tbCodeInfo->expVecRadParamName){
   EXP_VECTOR_RADIX     = *tbCodeInfo->expVecRadParamName; 
   EXP_VECTOR_RADIX_val=   tbCodeInfo->expVecRadParamVal;
 }
 if(tbCodeInfo->expVecMaxErrParamName){
   EXP_VECTOR_MAX_ERR    = *tbCodeInfo->expVecMaxErrParamName;   
   EXP_VECTOR_MAX_ERR_val=  tbCodeInfo->expVecMaxErrParamVal;
 }
 //------------------------------------------------
 
 if(tbCodeInfo->clockName){
   clk                  = *tbCodeInfo->clockName; 
   clk_type             = *tbCodeInfo->clockType; 
  
 }
 if(tbCodeInfo->resetName){
   testbench_reset_     = *tbCodeInfo->resetName; 
   tb_reset_type        = *tbCodeInfo->resetType; 
 }
 if(tbCodeInfo->randValidName){
   rand_valid           = *tbCodeInfo->randValidName;   
   rand_valid_type      = *tbCodeInfo->randValidType; 
 }
 if(tbCodeInfo->validName){
   expect_out_valid     = *tbCodeInfo->validName; 
   expect_out_valid_type= *tbCodeInfo->validType; 
 }
 if(tbCodeInfo->rdEnName){
   rd_en                = *tbCodeInfo->rdEnName; 
   rd_en_type           = *tbCodeInfo->rdEnType; 
 }
 if(tbCodeInfo->stimVerErrName){
   stim_mem_version_err = *tbCodeInfo->stimVerErrName; 
   stim_mem_version_err_type = *tbCodeInfo->stimVerErrType; 
 }
 if(tbCodeInfo->expVerErrName){
   exp_mem_version_err  = *tbCodeInfo->expVerErrName; 
   exp_mem_version_err_type  = *tbCodeInfo->expVerErrType; 
 }
 if(tbCodeInfo->stimIdErrName){
   stim_mem_id_err      = *tbCodeInfo->stimIdErrName; 
   stim_mem_id_err_type = *tbCodeInfo->stimIdErrType;
 }
 if(tbCodeInfo->expIdErrName){
   exp_mem_id_err       = *tbCodeInfo->expIdErrName;  
   exp_mem_id_err_type  = *tbCodeInfo->expIdErrType;
 }
 if(tbCodeInfo->reportFileMcdName){
   report_file_mcd      = *tbCodeInfo->reportFileMcdName;
   report_file_mcd_type = *tbCodeInfo->reportFileMcdType; 
 }
 if(tbCodeInfo->fileMcdName){
   file_mcd             = *tbCodeInfo->fileMcdName;
   file_mcd_type        = *tbCodeInfo->fileMcdType; 
 }
 if(tbCodeInfo->cycleCntName){
   cycle_cnt            = *tbCodeInfo->cycleCntName;
   cycle_cnt_type       = *tbCodeInfo->cycleCntType;
 }
 if(tbCodeInfo->simStopName){
 stop_sim             = *tbCodeInfo->simStopName;
 stop_sim_type        = *tbCodeInfo->simStopType;  
 } 

 //-----------------------------------------------
  //-------------DUT name------------------------
 if(tbCodeInfo->dutName){
 dut_name = *tbCodeInfo->dutName;
 dut_inst = *tbCodeInfo->dutInstName;
 }
 
 //------------DUT input ports--------------------
  vector<string> in_port_name_vec;
  vector<string> in_port_type_vec;
 
  string port_name;
  string port_type;

  NSCSLOm::TVec_RefCSLOmExprLink::const_iterator iter1;
 
  if(tbCodeInfo->inPorts){
    for(iter1= (tbCodeInfo->inPorts)->begin(); iter1 != (tbCodeInfo->inPorts)->end(); iter1++){
    if((*iter1)->getName()){
      port_name = *((*iter1)->getName());
      in_port_name_vec.push_back(port_name);
    }
     if((*iter1)->getType()){
       port_type = ((*iter1)->getType());
       in_port_type_vec.push_back(port_type);
     }
     else { 
       port_type = " ";
       in_port_type_vec.push_back(port_type);
     }
  }
 }
 //------------DUT output ports----------------------
  vector<string> out_port_name_vec;
  vector<string> out_port_type_vec;

  NSCSLOm::TVec_RefCSLOmExprLink::const_iterator iter2;
  if(tbCodeInfo->outPorts){
    for(iter2= (tbCodeInfo->outPorts)->begin(); iter2 != (tbCodeInfo->outPorts)->end(); iter2++){
    if((*iter2)->getName()){
      port_name = *((*iter2)->getName());
      out_port_name_vec.push_back(port_name);
    }
     if((*iter2)->getType()){
       port_type = ((*iter2)->getType());
       out_port_type_vec.push_back(port_type);
     }
     else { 
       port_type = " ";
       out_port_type_vec.push_back(port_type);
     }
  }
 }

 //-----------TB name-------------------------
  if(tbCodeInfo->verilogFilename)
   tb_name = *tbCodeInfo->verilogFilename;
   //cout << "TB NAME = " << tb_name << endl;

 //----------------CLK period------------------
  if(tbCodeInfo->per)
   clk_per = tbCodeInfo->per;
   //cout << "clk_per= " << clk_per <<endl;
 
 //----------------CLK timebase------------------
  if(tbCodeInfo->timeBase)
   clkTimeBase = *tbCodeInfo->timeBase;
   //cout << "clk time base= " << clkTimeBase <<endl;
 
 //--------------DUTOutFileName---------------
 
 //if(tbContainer->getDutOutFileName()){
 //  dutOutFileName = *tbContainer->getDutOutFileName();
   // }
 //--------------TbWaveFile-------------------
   if(tbCodeInfo->outputFileName)
   tbWaveFile = *tbCodeInfo->outputFileName;
 
 //---------------TbWaveType------------------
   if(tbCodeInfo->waveType)
   tbWaveType = *tbCodeInfo->waveType;

 //-------------------------------------------

   // cout << templ_ifc;
   //--------------------------------------------
 
   //cout << templ_tb;
  }
 
 

}

