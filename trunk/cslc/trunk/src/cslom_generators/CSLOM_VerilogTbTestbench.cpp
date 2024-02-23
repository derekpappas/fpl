#include "CSLOM_VerilogTbTestbench.h"
#include <stdlib.h>
#include <fstream>
#include <iostream>
#include <string>

using namespace std;
using namespace tmpl;
using namespace NSCSLOm;
using namespace NSCSLOmVerilogTbGenerator;

//----------------------------------------------------------------------------

void run_tb_param(RefCSLOmVerilogTbGenerator& tbCodeInfo)
{
    #ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
        cout << "CSLOM_VerilogTbTestbench.cpp :: run_tb_param" << endl;
    #endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/param.tmpl");

    string tb_name;
    string dut_inst;
    string dut_name ;
    vector<RefString> dutInstVec;
   
    
    if(tbCodeInfo->tbName){
      tb_name = *tbCodeInfo->tbName;
    }
    if(tbCodeInfo->dutInstName){
      dut_inst = *tbCodeInfo->dutInstName;
    }
    if(tbCodeInfo->dutName){
      dut_name = *tbCodeInfo->dutName;
    }
   
    
    //generated testbench file_name
    // string m_outputPath = path + "/test/tests/" + dut_name + "_cslc_generated/code/verilog/";
    string m_outputPath = tbCodeInfo->m_outputPath;
    string tb_file_name;
    const char* file_name;

    if(!tb_name.empty()){
      tb_file_name = m_outputPath + dut_inst + "_" + tb_name + ".v";
      file_name= tb_file_name.c_str();
    }

    /*  if(!(tbCodeInfo->dutInstNameVec).empty()){
      dutInstVec = tbCodeInfo->dutInstNameVec;
    }

    if(!tb_name.empty()){
      for(dutIter = dutInstVec.begin(); dutIter != dutInstVec.end(); dutIter++){
	dut_inst = **dutIter;
	tb_file_name = m_outputPath + dut_inst + "_" + tb_name + ".v";
	file_name= tb_file_name.c_str();
      }
      }*/

    string stim_expect_mem_file = dut_inst + "_stim_expect_mem_template";
    //-------parameters-------------
    //------names--------------------
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

    //----values---------------------
    string STIM_VECTOR_NAME_val ;
    string STIM_VECTOR_FILE_val ;
    string EXP_VECTOR_NAME_val ;
    string EXP_VECTOR_FILE_val ;

    int SIM_TIMEOUT_CNT_val ;
    int STIM_MEM_WIDTH_val ;
    int STIM_ADDR_WIDTH_val ;
    string STIM_VECTOR_ID_val ;
    string STIM_VECTOR_VERSION_val ;
    int STIM_VECTOR_RADIX_val ;
    int STIM_VECTOR_MAX_ERR_val ;
    int EXP_MEM_WIDTH_val ;
    int EXP_ADDR_WIDTH_val ;
    string EXP_VECTOR_ID_val ;
    string EXP_VECTOR_VERSION_val ;
    int EXP_VECTOR_RADIX_val ;
    int EXP_VECTOR_MAX_ERR_val ; 
    //-----------------------------------------------
    //-----open the stim vector file------------------

    ifstream stim_vec;
    // string stim_file_name = path + "/test/tests/" + dut_name + "_cslc_generated/code/systemC/" + "stim_vec_"+ dut_inst + "_";  //stim vector name
    string stim_file_name = tbCodeInfo->m_systemCPath + "stim_vec_"+ dut_inst + "_";

  
    const char* stim_f = stim_file_name.c_str();
    const char* stim_file = stim_f;

    string buffer_stim;
    string line;
    int iter1,iter2;
    
    string stim_vec_id;
    string stim_vec_ver;
    string mem_width;
  
    stim_vec.open(stim_file);                  //open the stim file

    if(stim_vec.is_open()){
     
      while (!stim_vec.eof()){
	
	getline(stim_vec,line);
	buffer_stim += line;                       //get each vector line
      }
     
      //--------------get the stim_vec_id from stim vector file-------
	
	iter1 = buffer_stim.find("VEC ID:");               
        iter2 = buffer_stim.find_last_of("//");
	int length1 = (iter2-1) -(iter1+7);
	stim_vec_id = buffer_stim.substr(iter1+7,length1);

	//--------get the stim_vec_version from stim vector file------

	iter1 = buffer_stim.find("VEC VERSION:");              
	stim_vec_ver = buffer_stim.substr(iter1+12,length1);

	//-----------------------------------------------------------
	iter1 = buffer_stim.find(stim_vec_ver);
	mem_width = buffer_stim.substr(iter1 +3);
	//STIM_MEM_WIDTH_val = mem_width.size();
	STIM_ADDR_WIDTH_val =1;

	//-----------------------------------------------------------
	stim_vec.close();
  
    }
    else{
      cout << "Unable to open stim vector file!!!" << endl;
    }
  
    //-----open the exp vector file------------------
    ifstream exp_vec;
    // string exp_file_name =  path + "/test/tests/" + dut_name + "_cslc_generated/code/systemC/" + "exp_vec_" + dut_inst + "_";  //exp vector name
   
    string exp_file_name = tbCodeInfo->m_systemCPath + "exp_vec_"+ dut_inst + "_";

    const char* exp_f = exp_file_name.c_str();
    const char* exp_file = exp_f;

    string buffer_exp;
      
    string exp_vec_id;
    string exp_vec_ver;

   
    exp_vec.open(exp_file);                  //open the exp file

    if(exp_vec.is_open()){
      
      while (!exp_vec.eof()){
	
	getline(exp_vec,line);
	buffer_exp += line;                       //get each vector line
      }
     
      //--------------get the exp_vec_id from exp vector file-------
	
	iter1 = buffer_exp.find("VEC ID:");               
        iter2 = buffer_exp.find_last_of("//");
	int length1 = (iter2-1) -(iter1+7);
	exp_vec_id = buffer_exp.substr(iter1+7,length1);

	//--------get the exp_vec_version from exp vector file------

	iter1 = buffer_exp.find("VEC VERSION:");              
	exp_vec_ver = buffer_exp.substr(iter1+12,length1);
	mem_width = buffer_exp.substr(iter1 + 15);
	//EXP_MEM_WIDTH_val = mem_width.size() -1;
	EXP_ADDR_WIDTH_val =1;
	
	
	//-----------------------------------------------------------
	exp_vec.close();
  
    }
    else{
      cout << "Unable to open exp vector file!!!" << endl;
    }

    //-----------------------------------------------

    
    if(tbCodeInfo->simTimeoutName){
      SIM_TIMEOUT_CNT     = *tbCodeInfo->simTimeoutName;  
      SIM_TIMEOUT_CNT_val =  tbCodeInfo->simTimeoutVal ; 
     
    }
    if(tbCodeInfo->stimMemWidthParamName){
       STIM_MEM_WIDTH       = *tbCodeInfo->stimMemWidthParamName;  
      //STIM_MEM_WIDTH_val   =  tbCodeInfo->stimAddrWidthParamVal;
    
    }
    if(tbCodeInfo->stimAddrWidthParamName){
      STIM_ADDR_WIDTH      = *tbCodeInfo->stimAddrWidthParamName;
      STIM_ADDR_WIDTH_val  =  1;  //default value  
    }
    if(tbCodeInfo->stimVecIdParamName){
      STIM_VECTOR_ID       = *tbCodeInfo->stimVecIdParamName; 
    }
    if(stim_vec_id != ""){
      STIM_VECTOR_ID_val   =  stim_vec_id; 
    }
    else{
      STIM_VECTOR_ID_val   = " 0";
    }
    if(tbCodeInfo->stimVecVerParamName){
      STIM_VECTOR_VERSION     = *tbCodeInfo->stimVecVerParamName; 
    }
    if(stim_vec_ver != ""){
      STIM_VECTOR_VERSION_val =  stim_vec_ver; 
    }
    else{
      STIM_VECTOR_VERSION_val = " 0";
    }
    if(tbCodeInfo->stimVecNameParamName){
      STIM_VECTOR_NAME     = *tbCodeInfo->stimVecNameParamName;  
      STIM_VECTOR_NAME_val = *tbCodeInfo->stimVecNameParamVal; 
    }
    if(tbCodeInfo->stimVecFileParamName){
      STIM_VECTOR_FILE     = *tbCodeInfo->stimVecFileParamName; 
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
      // EXP_MEM_WIDTH_val    =  tbCodeInfo->expMemWidthParamVal; 
    }
    if(tbCodeInfo->expAddrWidthParamName){
      EXP_ADDR_WIDTH       = *tbCodeInfo->expAddrWidthParamName;   
      EXP_ADDR_WIDTH_val   =  1;   //default value 
    }
    if(tbCodeInfo->expVecIdParamName){
      EXP_VECTOR_ID        = *tbCodeInfo->expVecIdParamName;  
    }
    if(exp_vec_id != ""){
      EXP_VECTOR_ID_val    = exp_vec_id; 
    }
    else{
      EXP_VECTOR_ID_val    = " 0";
    }
    if(tbCodeInfo->expVecVerParamName){
      EXP_VECTOR_VERSION     = *tbCodeInfo->expVecVerParamName;
    }
    if(exp_vec_ver != ""){
      EXP_VECTOR_VERSION_val =  exp_vec_ver; 
    }
    else{
      EXP_VECTOR_VERSION_val = " 0";
    }
    if(tbCodeInfo->expVecNameParamName){
      EXP_VECTOR_NAME      = *tbCodeInfo->expVecNameParamName;   
    }
    if(tbCodeInfo->expVecNameParamVal){
      EXP_VECTOR_NAME_val  = *tbCodeInfo->expVecNameParamVal; 
    }
    if(tbCodeInfo->expVecFileParamVal){
      EXP_VECTOR_FILE      = *tbCodeInfo->expVecFileParamName; 
    }
    /*if(tbCodeInfo->expVecFileParamVal){
      EXP_VECTOR_FILE_val  = *tbCodeInfo->expVecFileParamVal; 
      }*/
    if(tbCodeInfo->expVecRadParamName){
      EXP_VECTOR_RADIX     = *tbCodeInfo->expVecRadParamName; 
      EXP_VECTOR_RADIX_val=   tbCodeInfo->expVecRadParamVal;
    }
    if(tbCodeInfo->expVecMaxErrParamName){
      EXP_VECTOR_MAX_ERR    = *tbCodeInfo->expVecMaxErrParamName;   
      EXP_VECTOR_MAX_ERR_val=  tbCodeInfo->expVecMaxErrParamVal;
    }
    //------------------------------------------------
    STIM_VECTOR_FILE_val = "../systemC/stim_vec_" + dut_inst + "_";    
    EXP_VECTOR_FILE_val = "../systemC/exp_vec_" + dut_inst + "_";

    //----------------------------------------------------------
    int stim_mem_width =0;
    int exp_mem_width =0;
    int i;
    vector<RefString>::const_iterator unit_iter;
    NSCSLOm::TVec_RefCSLOmExprLink::const_iterator it1;
    NSCSLOm::TVec_RefCSLOmExprLink::const_iterator it2;
    loop_t unit_list;
    row_t row;
       /*for( i=0 ; i< (tbCodeInfo->inPortWidthVec).size();i++){
	  stim_mem_width += (tbCodeInfo->inPortWidthVec).at(i);
	}
	for( i=0 ; i< (tbCodeInfo->outPortWidthVec).size();i++){
	  exp_mem_width += (tbCodeInfo->outPortWidthVec).at(i);
	  }*/

    if(tbCodeInfo->inPorts){
      // int pCnt =0;
      for(it1= (tbCodeInfo->inPorts)->begin(); it1 != (tbCodeInfo->inPorts)->end(); it1++){
	int port_width = (*it1)->getWidth();
	stim_mem_width += port_width;
	//	cout << "mem_with =" << stim_mem_width << endl;
      }
    }
    if(tbCodeInfo->outPorts){
      for(it2= (tbCodeInfo->outPorts)->begin(); it2 != (tbCodeInfo->outPorts)->end(); it2++){
	int port_width = (*it2)->getWidth();
	exp_mem_width += port_width;
      }
    }
    /* if(tbCodeInfo->dutClk){
      STIM_MEM_WIDTH_val = stim_mem_width-1;
      }*/
    // else{
      STIM_MEM_WIDTH_val = stim_mem_width;
      //  }
    
      EXP_MEM_WIDTH_val = exp_mem_width;

	//-------------------------------------------------------
	if(!(tbCodeInfo->unitVec).empty()){
	  // cout << "size=" << (tbCodeInfo->unitVec).size();
	  for(unit_iter = (tbCodeInfo->unitVec).begin(); unit_iter != (tbCodeInfo->unitVec).end(); unit_iter++){
	    row("unit_name") = *(*unit_iter);
	    unit_list +=row;
	  }
	}
	templ("unit_list") = unit_list;
	templ("tb_name") = tb_name;
	// templ("dut_name") = dut_name;
	templ("stim_expect_mem_file") = stim_expect_mem_file;
    //------------Parameter names-------------
    templ("SIM_TIMEOUT_CNT") = SIM_TIMEOUT_CNT;
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
    templ("SIM_TIMEOUT_CNT_val")= SIM_TIMEOUT_CNT_val;
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

    
    // add to tb_name.v  file
    if(file_name){
      ofstream testbench(file_name, ios::app);
      testbench << templ ;
    //  *(out) << "// Testbech code for " << dut_inst << endl;
    // *(out) << templ; 
    }
}

//----------------------------------------------------------------------------

void run_tb_signal(RefCSLOmVerilogTbGenerator& tbCodeInfo)
{
    #ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
        cout << "CSLOM_VerilogTbTestbench.cpp :: run_tb_signal" << endl;
    #endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/signal.tmpl");

    map<string,string> in_ports;   //includes the name and type for input ports
    map<string,string> out_ports;  //includes the name and type for output ports
 
    map<string,string>::const_iterator iter_in,iter_out;

    //------------DUT input ports--------------------
    vector<string> in_port_name_vec;
    vector<string> in_port_type_vec;
    
    string port_name;
    string port_type;
    
    NSCSLOm::TVec_RefCSLOmExprLink::const_iterator iter1;
    
    //------------DUT output ports----------------------
    vector<string> out_port_name_vec;
    vector<string> out_port_type_vec;
    
    NSCSLOm::TVec_RefCSLOmExprLink::const_iterator iter2;

    //---------------Parameters---------------------------
    string SIM_TIMEOUT_CNT ;
    string STIM_MEM_WIDTH ;    
    string EXP_MEM_WIDTH ;
    string EXP_ADDR_WIDTH ;
    //-------------values received from CSLOM--------------
    string dut_name ;
    string dut_inst;

    //-----------signal names------------------
    string clk ;
    string testbench_reset_ ;
    string rand_valid ;
    string expect_out_valid ;
    string rd_en ;
    string stim_mem_version_err ;
    string exp_mem_version_err ;
    string stim_mem_id_err ;
    string exp_mem_id_err ;
    //------------------------------------
    string report_file_mcd ;
    string file_mcd ; 
    string cycle_cnt ;
    string stop_sim ;
    //----------------------------------------------------
    int iter_name1, iter_name2;
    int iter_type1, iter_type2;
    //-----------signal types----------------------------
    string clk_type ;
    string tb_reset_type ;
    string rand_valid_type ;
    string expect_out_valid_type ;
    string rd_en_type ;
    string stim_mem_version_err_type ;
    string exp_mem_version_err_type ;
    string stim_mem_id_err_type ;
    string exp_mem_id_err_type ;
    //------------------------------------
    string report_file_mcd_type ;
    string file_mcd_type ; 
    string cycle_cnt_type ;
    string stop_sim_type ;
    //----------------------------------------------------
    //these signals are used as inputs for match-mismatch.tmpl
    if(tbCodeInfo->dutInstName){
      dut_inst = *tbCodeInfo->dutInstName;
    }
    if(tbCodeInfo->dutName){
      dut_name = *tbCodeInfo->dutName;
    }
    string exp_match_count = "exp_" + dut_inst + "_match_count";
    string exp_mismatch_count = "exp_" + dut_inst + "_mismatch_count";
    string exp_transaction_count = "exp_" + dut_inst + "_transaction_count";
    string exp_mismatch = "exp_" + dut_inst + "_mismatch";

    //---------------------------------------------
    string exp_match_count_type = "reg";
    string exp_mismatch_count_type = "reg";
    string exp_transaction_count_type = "reg";
    string exp_mismatch_type = " reg";
    //--------------------------------------------

    string tb_name;
    if(tbCodeInfo->tbName){
      tb_name = *tbCodeInfo->tbName;
    }
    //generated testbench file_name
    // string m_outputPath = path + "/test/tests/" + dut_name + "_cslc_generated/code/verilog/";
    string m_outputPath = tbCodeInfo->m_outputPath;
    string tb_file_name;
    const char* file_name;

    if(!tb_name.empty()){
      tb_file_name = m_outputPath + dut_inst + "_" + tb_name + ".v";
      file_name= tb_file_name.c_str();
    }

    //---------------------------------------------

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
    //-------------------------------------------------
    if(tbCodeInfo->dutName){
      dut_name = *tbCodeInfo->dutName;
    }
    

    //-----------------DUT inpt ports----------------
    vector<string>::const_iterator iterIfcIn;
    if(!(tbCodeInfo->inIfcPorts).empty()){
      int pCnt =0;
     
      for(iterIfcIn= (tbCodeInfo->inIfcPorts).begin(); iterIfcIn != (tbCodeInfo->inIfcPorts).end(); iterIfcIn++){
	  port_name = *iterIfcIn;
	  in_port_name_vec.push_back(port_name);
	}
	//-------------port_type----------
	if(tbCodeInfo->inIfcPortTypeVec[pCnt]){
	     port_type = *(tbCodeInfo->inIfcPortTypeVec[pCnt]);
	     in_port_type_vec.push_back(port_type);
	   }
	else {
	  port_type = "wire";
	  in_port_type_vec.push_back(port_type);
	}
	pCnt++;
    }


   if(tbCodeInfo->inPorts){
     int pCnt =0;
     
      for(iter1= (tbCodeInfo->inPorts)->begin(); iter1 != (tbCodeInfo->inPorts)->end(); iter1++){

	if((*iter1)->getName()){
	  port_name = *((*iter1)->getName());
	  in_port_name_vec.push_back(port_name);
	}
	//-------------port_type----------
	if(tbCodeInfo->inPortTypeVec[pCnt]){
	     port_type = *(tbCodeInfo->inPortTypeVec[pCnt]);
	     in_port_type_vec.push_back(port_type);
	   }
	else {
	  port_type = "wire";
	  in_port_type_vec.push_back(port_type);
	}
	pCnt++;
      }
      }

  
    //----------DUT output ports------------------

    vector<string>::const_iterator iterIfcOut;
    if(!(tbCodeInfo->outIfcPorts).empty()){
      int pCnt =0;
     
      for(iterIfcOut= (tbCodeInfo->outIfcPorts).begin(); iterIfcOut != (tbCodeInfo->outIfcPorts).end(); iterIfcOut++){
	  port_name = *iterIfcOut;
	  out_port_name_vec.push_back(port_name);
	}
	//-------------port_type----------
	if(tbCodeInfo->outIfcPortTypeVec[pCnt]){
	     port_type = *(tbCodeInfo->outIfcPortTypeVec[pCnt]);
	     out_port_type_vec.push_back(port_type);
	   }
	else {
	  port_type = "wire";
	  out_port_type_vec.push_back(port_type);
	}
	pCnt++;
    }


   if(tbCodeInfo->outPorts){
      int pCnt =0;
      for(iter2= (tbCodeInfo->outPorts)->begin(); iter2 != (tbCodeInfo->outPorts)->end(); iter2++){
	if((*iter2)->getName()){
	  port_name = *((*iter2)->getName());
	  out_port_name_vec.push_back(port_name);
	}
	//-----port type --------------
	if(tbCodeInfo->outPortTypeVec[pCnt]){
	  port_type = *(tbCodeInfo->outPortTypeVec[pCnt]);
	  out_port_type_vec.push_back(port_type);
	}
	else {
	  port_type = "wire";
	  out_port_type_vec.push_back(port_type);
	}
	pCnt++;
      }
    }
    //-------------------------------------------
    //---------make ports maps-------------------
   
    for( iter_name1 = 0; iter_name1< in_port_name_vec.size(); iter_name1++){
      for( iter_type1 = 0; iter_type1< in_port_type_vec.size(); iter_type1++){
	if(iter_name1 == iter_type1){
	  in_ports.insert(make_pair(in_port_name_vec[iter_name1],in_port_type_vec[iter_type1]));
	 
	}
      }
    }
 
    for( iter_name2 = 0; iter_name2< out_port_name_vec.size(); iter_name2++){
      for( iter_type2 = 0; iter_type2< out_port_type_vec.size(); iter_type2++){
	if(iter_name2 == iter_type2){
	  out_ports.insert(make_pair(out_port_name_vec[iter_name2],out_port_type_vec[iter_type2]));
	}
      }
    }  

   //---------------------------------------------

    if(tbCodeInfo->expAddrWidthParamName){
      EXP_ADDR_WIDTH       = *tbCodeInfo->expAddrWidthParamName;  
    }
    if(tbCodeInfo->simTimeoutName){
      SIM_TIMEOUT_CNT     = *tbCodeInfo->simTimeoutName;
    }
    if(tbCodeInfo->stimMemWidthParamName){
      STIM_MEM_WIDTH       = *tbCodeInfo->stimMemWidthParamName;
    }
    if(tbCodeInfo->expMemWidthParamName){
      EXP_MEM_WIDTH        = *tbCodeInfo->expMemWidthParamName; 
    }
 //-----------------------------------------------
    templ("clk") = clk;
    templ("clk_type") = clk_type;
    templ("testbench_reset_") = testbench_reset_;
    templ("tb_reset_type") = tb_reset_type;
    templ("rand_valid") = rand_valid;
    templ("rand_valid_type") = rand_valid_type;
    templ("file_mcd") = file_mcd;
    templ("file_mcd_type") = file_mcd_type;
    templ("report_file_mcd") = report_file_mcd;
    templ("report_file_mcd_type") = report_file_mcd_type;
    templ("cycle_cnt") = cycle_cnt;
    templ("cycle_cnt_type") = cycle_cnt_type;

    templ("exp_match_count") = exp_match_count;
    templ("exp_match_count_type") = exp_match_count_type;
    templ("exp_mismatch_count") = exp_mismatch_count;
    templ("exp_mismatch_count_type") = exp_mismatch_count_type;
    templ("exp_transaction_count") = exp_transaction_count;
    templ("exp_transaction_count_type") = exp_transaction_count_type;
    templ("exp_mismatch") = exp_mismatch;
    templ("exp_mismatch_type") = exp_mismatch_type;

    templ("expect_out_valid") = expect_out_valid;
    templ("expect_out_valid_type") = expect_out_valid_type;
    templ("rd_en") = rd_en;
    templ("rd_en_type") = rd_en_type;
    templ("stim_mem_version_err") = stim_mem_version_err;
    templ("stim_mem_version_err_type") = stim_mem_version_err_type;
    templ("exp_mem_version_err") = exp_mem_version_err;
    templ("exp_mem_version_err_type") = exp_mem_version_err_type;
    templ("stim_mem_id_err") = stim_mem_id_err;
    templ("stim_mem_id_err_type") = stim_mem_id_err_type;
    templ("exp_mem_id_err") = exp_mem_id_err;
    templ("exp_mem_id_err_type") = exp_mem_id_err_type;
    templ("stop_sim") = stop_sim;
    templ("stop_sim_type") = stop_sim_type;

    vector<int> p_width;
   
    loop_t input_signals;
    loop_t output_signals;
    loop_t exp_signals;
    row_t row;
    int cnt=0;
    int i;

    
    /* for(iter_in = in_ports.begin(); iter_in !=in_ports.end(); iter_in++){
     
        string pi_name = iter_in->first;
        string wire_name = dut_inst + "_in_" + pi_name;
	string wire_type = iter_in->second;

        row("in_in")= wire_name;
        row("in_sig_type") = wire_type;
	for( i=0 ; i< (tbCodeInfo->inPortWidthVec).size();i++){
	  if(i == cnt){
	    row("STIM_VEC")= (tbCodeInfo->inPortWidthVec).at(i);
	  }
	}
        input_signals += row;
	cnt++;
	}*/
    map<string,string>::reverse_iterator iter_in1,iter_out1;
    for(iter_in1 = in_ports.rbegin(); iter_in1 !=in_ports.rend(); ++iter_in1){
     
        string pi_name = iter_in1->first;
        string wire_name = dut_inst + "_in_" + pi_name;
	string wire_type = iter_in1->second;

        row("in_in")= wire_name;
        row("in_sig_type") = wire_type;
	for( i=0 ; i< (tbCodeInfo->inPortWidthVec).size();i++){
	  if(i == cnt){
	    row("STIM_VEC")= (tbCodeInfo->inPortWidthVec).at(i);
	  }
	}
        input_signals += row;
	cnt++;
	}

    cnt =0;
    /*   for(iter_out = out_ports.begin(); iter_out != out_ports.end(); iter_out++){
     
        string po_name = iter_out->first;
        string wire_name = dut_inst + "_out_" + po_name;
        string exp_wire = dut_inst + "_out_" + po_name + "_expected";
	//	p_width = tbCodeInfo->outPortWidthVec;
	// dut_out_wires.push_back(wire_name); //output for other tmpl
        row("out_out")= wire_name;
        row("out_sig_type")= iter_out->second;
        row("out_out_expect")= exp_wire;
	
	for(i=0 ; i< (tbCodeInfo->outPortWidthVec).size();i++){
	  if(i == cnt){
	    row("EXP_VEC")= (tbCodeInfo->outPortWidthVec).at(i);
	  }
	}
        output_signals += row;
	cnt++;
	}*/

    for(iter_out1 = out_ports.rbegin(); iter_out1 != out_ports.rend(); ++iter_out1){
     
        string po_name = iter_out1->first;
        string wire_name = dut_inst + "_out_" + po_name;
        string exp_wire = dut_inst + "_out_" + po_name + "_expected";
	//	p_width = tbCodeInfo->outPortWidthVec;
	// dut_out_wires.push_back(wire_name); //output for other tmpl
        row("out_out")= wire_name;
        row("out_sig_type")= iter_out1->second;
        row("out_out_expect")= exp_wire;
	
	for(i=0 ; i< (tbCodeInfo->outPortWidthVec).size();i++){
	  if(i == cnt){
	    row("EXP_VEC")= (tbCodeInfo->outPortWidthVec).at(i);
	  }
	}
        output_signals += row;
	cnt++;
	}

    templ("input_signals")= input_signals;
    templ("output_signals") = output_signals;
 
   

    templ("EXP_ADDR_WIDTH") = EXP_ADDR_WIDTH;
    templ("SIM_TIMEOUT_CNT") = SIM_TIMEOUT_CNT;
    templ("STIM_MEM_WIDTH") = STIM_MEM_WIDTH;
    templ("EXP_MEM_WIDTH") = EXP_MEM_WIDTH;
 
    //cout << templ;
    //-------------add to tb file-------------
    if(file_name){
      ofstream testbench(file_name, ios::app);
      testbench << templ;
      // cout << templ << endl;
    }
}

//----------------------------------------------------------------------------

void run_tb_dut_inst(RefCSLOmVerilogTbGenerator& tbCodeInfo)
{
    #ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
        cout << "CSLOM_VerilogTbTestbench.cpp :: run_tb_inst" << endl;
    #endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/dut_inst.tmpl");

    // char file_name[20] = "TB.v";

    map<string,string> f2a;
    map<string,string>::const_iterator map_iter;

    map<string,string> in_ports;
    map<string,string> out_ports;
    map<string,string>::const_iterator iter_in,iter_out;

    int iter_name1, iter_name2;
    int iter_type1, iter_type2;
 //------------DUT input ports--------------------
    vector<string> in_port_name_vec;
    vector<string> in_port_type_vec;
    
    string port_name;
    string port_type;
    
    NSCSLOm::TVec_RefCSLOmExprLink::const_iterator iter1;
    
    //------------DUT output ports----------------------
    vector<string> out_port_name_vec;
    vector<string> out_port_type_vec;
    
    NSCSLOm::TVec_RefCSLOmExprLink::const_iterator iter2;

    //-------------------------From interface-----------
    string dut_inst;
    string dut_name;
    string clk;
    //-------------DUT name------------------------
    if(tbCodeInfo->dutName){
      dut_name = *tbCodeInfo->dutName;
    }
    if(tbCodeInfo->dutInstName){
      dut_inst = *tbCodeInfo->dutInstName;
    }
   
    //------------------------------------------------
    //---------generated tb_name.v file----------------
    string tb_name;
    if(tbCodeInfo->tbName){
      tb_name = *tbCodeInfo->tbName;
    }
    //generated testbench file_name
    // string m_outputPath = path + "/test/tests/" + dut_name + "_cslc_generated/code/verilog/"; 
    string m_outputPath = tbCodeInfo->m_outputPath;
    string tb_file_name;
    const char* file_name;
    if(!tb_name.empty()){
      tb_file_name = m_outputPath + dut_inst + "_" + tb_name + ".v";
      file_name= tb_file_name.c_str();
    }
    //---------------------------------------------
    //------------------dut clock-------------------
    string dutClk;
    string p_clk;
    if(tbCodeInfo->dutClk){
          dutClk = "clk";
      
    }
    if(tbCodeInfo->clockName){
      clk    = *tbCodeInfo->clockName; 
    }
    //-----------------DUT inpt ports----------------

    vector<string>::const_iterator iterIfcIn;
    if(!(tbCodeInfo->inIfcPorts).empty()){
      int pCnt =0;
      
      for(iterIfcIn= (tbCodeInfo->inIfcPorts).begin(); iterIfcIn != (tbCodeInfo->inIfcPorts).end(); iterIfcIn++){
	  port_name = *iterIfcIn;
	  in_port_name_vec.push_back(port_name);
	}
	//-------------port_type----------
	if(tbCodeInfo->inIfcPortTypeVec[pCnt]){
	     port_type = *(tbCodeInfo->inIfcPortTypeVec[pCnt]);
	     in_port_type_vec.push_back(port_type);
	   }
	else {
	  port_type = " ";
	  in_port_type_vec.push_back(port_type);
	}
	pCnt++;
    }

    else if(tbCodeInfo->inPorts){
     
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

    //----------DUT output ports------------------

    vector<string>::const_iterator iterIfcOut;
    if(!(tbCodeInfo->outIfcPorts).empty()){
      int pCnt =0;
     
      for(iterIfcOut= (tbCodeInfo->outIfcPorts).begin(); iterIfcOut != (tbCodeInfo->outIfcPorts).end(); iterIfcOut++){
	  port_name = *iterIfcOut;
	  out_port_name_vec.push_back(port_name);
	}
	//-------------port_type----------
	if(tbCodeInfo->outIfcPortTypeVec[pCnt]){
	     port_type = *(tbCodeInfo->outIfcPortTypeVec[pCnt]);
	     out_port_type_vec.push_back(port_type);
	   }
	else {
	  port_type = " ";
	  out_port_type_vec.push_back(port_type);
	}
	pCnt++;
    }

    else if(tbCodeInfo->outPorts){
     
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
    //-------------------------------------------
    //---------make ports maps-------------------
    for( iter_name1 = 0; iter_name1< in_port_name_vec.size(); iter_name1++){
      for( iter_type1 = 0; iter_type1< in_port_type_vec.size(); iter_type1++){
	if(iter_name1 == iter_type1){
	  in_ports.insert(make_pair(in_port_name_vec[iter_name1],in_port_type_vec[iter_type1]));
	}
      }
    }
 
    for( iter_name2 = 0; iter_name2< out_port_name_vec.size(); iter_name2++){
      for( iter_type2 = 0; iter_type2< out_port_type_vec.size(); iter_type2++){
	if(iter_name2 == iter_type2){
	  out_ports.insert(make_pair(out_port_name_vec[iter_name2],out_port_type_vec[iter_type2]));
	}
      }
    }  

    //------------dut f2a connections-----------

    for(iter_in = in_ports.begin(); iter_in !=in_ports.end(); iter_in++){
        string pi_name = iter_in->first;
        string wire_name = dut_inst + "_in_" + pi_name;
        f2a.insert(make_pair(pi_name,wire_name));
    }

    for(iter_out = out_ports.begin(); iter_out != out_ports.end(); iter_out++){
        string po_name = iter_out->first;
        string wire_name= dut_inst + "_out_" + po_name;
        f2a.insert(make_pair(po_name,wire_name));
    }

    //-------------------------------------------
    //--------from interface---------------------
    templ("dutClk")= dutClk;
    templ("clk") = clk;
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
    if(file_name){
    ofstream testbench(file_name, ios::app);
    testbench << templ;
    }
}

//----------------------------------------------------------------------------

void run_tb_stim_exp_memory(RefCSLOmVerilogTbGenerator& tbCodeInfo)
{
    #ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
        cout << "CSLOM_VerilogTbTestbench.cpp :: run_tb_inst" << endl;
    #endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/stim_exp_memory.tmpl");

    //char file_name[20] = "TB.v";

    //-------------values received from param.tmpl--------------
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
    string clk ;
    string testbench_reset_ ;
    // string rand_valid = "rand_valid";
    string expect_out_valid ;
    string rd_en_ ;
    string stim_mem_version_err ;
    string exp_mem_version_err ;
    string stim_mem_id_err ;
    string exp_mem_id_err ;

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

    string dut_inst;
    string dut_name;

    //--------------------------------------------------------

    string tb_name;
    if(tbCodeInfo->tbName){
      tb_name = *tbCodeInfo->tbName;
    }
    if(tbCodeInfo->dutInstName){
      dut_inst = *tbCodeInfo->dutInstName;
    }
    if(tbCodeInfo->dutName){
      dut_name = *tbCodeInfo->dutName;
    }

    //--------------------------------------------------------
    string stim_exp_mem = dut_inst + "_stim_expect_mem_template";

    //generated testbench file_name
    //string m_outputPath = path + "/test/tests/" + dut_name + "_cslc_generated/code/verilog/";
    string m_outputPath = tbCodeInfo->m_outputPath;
    string tb_file_name;
    const char* file_name;

    if(!tb_name.empty()){
      tb_file_name = m_outputPath + dut_inst + "_" + tb_name + ".v";
      file_name= tb_file_name.c_str();
    }
    //---------------------------------------------

    //-------------DUT name------------------------
    if(tbCodeInfo->dutName){
      dut_name = *tbCodeInfo->dutName;
    }
      
    //---------------------parameters--------------------------------- 
    if(tbCodeInfo->simTimeoutName){
      SIM_TIMEOUT_CNT     = *tbCodeInfo->simTimeoutName;  
    }

    if(tbCodeInfo->stimMemWidthParamName){
      STIM_MEM_WIDTH       = *tbCodeInfo->stimMemWidthParamName;  
    
    }
    if(tbCodeInfo->stimAddrWidthParamName){
      STIM_ADDR_WIDTH      = *tbCodeInfo->stimAddrWidthParamName;
     
    }
    if(tbCodeInfo->stimVecIdParamName){
      STIM_VECTOR_ID       = *tbCodeInfo->stimVecIdParamName; 
       
    }
    if(tbCodeInfo->stimVecVerParamName){
      STIM_VECTOR_VERSION     = *tbCodeInfo->stimVecVerParamName; 
      
    }
    if(tbCodeInfo->stimVecNameParamName){
      STIM_VECTOR_NAME     = *tbCodeInfo->stimVecNameParamName;  
      
    }
    if(tbCodeInfo->stimVecFileParamName){
      STIM_VECTOR_FILE     = *tbCodeInfo->stimVecFileParamName; 
    }
    if( tbCodeInfo->stimVecFileParamName){
     EXP_VECTOR_FILE      = *tbCodeInfo->expVecFileParamName; 
    }
    if(tbCodeInfo->stimVecRadParamName){
      STIM_VECTOR_RADIX    = *tbCodeInfo->stimVecRadParamName;  
      
    }
    if(tbCodeInfo->stimVecMaxErrParamName){
      STIM_VECTOR_MAX_ERR    = *tbCodeInfo->stimVecMaxErrParamName;   
      
    }
    if(tbCodeInfo->expMemWidthParamName){
      EXP_MEM_WIDTH        = *tbCodeInfo->expMemWidthParamName; 
      
    }
    if(tbCodeInfo->expAddrWidthParamName){
      EXP_ADDR_WIDTH       = *tbCodeInfo->expAddrWidthParamName;   
      
    }
    if(tbCodeInfo->expVecIdParamName){
      EXP_VECTOR_ID        = *tbCodeInfo->expVecIdParamName;   
     
    }
    if(tbCodeInfo->expVecVerParamName){
      EXP_VECTOR_VERSION     = *tbCodeInfo->expVecVerParamName; 
     
    }
    if(tbCodeInfo->expVecNameParamName){
      EXP_VECTOR_NAME      = *tbCodeInfo->expVecNameParamName;   
     
    }
    if(tbCodeInfo->expVecFileParamVal){
      EXP_VECTOR_FILE      = *tbCodeInfo->expVecFileParamName; 
       
    }
    if(tbCodeInfo->expVecRadParamName){
      EXP_VECTOR_RADIX     = *tbCodeInfo->expVecRadParamName; 
      
    }
    if(tbCodeInfo->expVecMaxErrParamName){
      EXP_VECTOR_MAX_ERR    = *tbCodeInfo->expVecMaxErrParamName;   
     
    }
    //-------------------signals------------------------------------

    if(tbCodeInfo->clockName){
      clk                  = *tbCodeInfo->clockName; 
            
    }
    if(tbCodeInfo->resetName){
      testbench_reset_     = *tbCodeInfo->resetName; 
     
    }
    if(tbCodeInfo->validName){
      expect_out_valid     = *tbCodeInfo->validName; 
      
    }
    if(tbCodeInfo->rdEnName){
      rd_en_                = *tbCodeInfo->rdEnName; 
     
    }
    if(tbCodeInfo->stimVerErrName){
      stim_mem_version_err = *tbCodeInfo->stimVerErrName; 
     
    }
    if(tbCodeInfo->expVerErrName){
      exp_mem_version_err  = *tbCodeInfo->expVerErrName; 
      
    }
    if(tbCodeInfo->stimIdErrName){
      stim_mem_id_err      = *tbCodeInfo->stimIdErrName; 
      
    }
    if(tbCodeInfo->expIdErrName){
      exp_mem_id_err       = *tbCodeInfo->expIdErrName;  
      
    }
    //-----------------TB signals for DUT input ports-----------------
    //These are created in signals.cpp

    vector<string> dut_in_wires;
    vector<string> dut_exp_wires;
    vector<string>::const_iterator iter11,iter12;

    //------------DUT  ports--------------------
     
    string port_name;
     
    NSCSLOm::TVec_RefCSLOmExprLink::reverse_iterator iter1;
    
    NSCSLOm::TVec_RefCSLOmExprLink::reverse_iterator iter2;

    //---------------------------------------------------------------
   //-----------------DUT input ports--------------------------------

    vector<string>::reverse_iterator iterIfcIn;
    if(!(tbCodeInfo->inIfcPorts).empty()){
      for(iterIfcIn= (tbCodeInfo->inIfcPorts).rbegin(); iterIfcIn != (tbCodeInfo->inIfcPorts).rend(); ++iterIfcIn){
	port_name = *iterIfcIn;
	string wire_name= dut_inst + "_in_" + port_name;
	dut_in_wires.push_back(wire_name);
	}
    }

   else if(tbCodeInfo->inPorts){
      for(iter1= (tbCodeInfo->inPorts)->rbegin(); iter1 != (tbCodeInfo->inPorts)->rend(); ++iter1){
	if((*iter1)->getName()){
	  port_name = *((*iter1)->getName());
	  // out_port_name_vec.push_back(port_name);
	  string wire_name = dut_inst + "_in_" + port_name;
	  dut_in_wires.push_back(wire_name);
	}
      }
    }

    //----------DUT expected ports------------------
    vector<string>::reverse_iterator iterIfcOut;
    if(!(tbCodeInfo->outIfcPorts).empty()){
      for(iterIfcOut = (tbCodeInfo->outIfcPorts).rbegin(); iterIfcOut != (tbCodeInfo->outIfcPorts).rend(); ++iterIfcOut){
	port_name = *iterIfcOut;
	string wire_name= dut_inst + "_out_" + port_name + "_expected";
	dut_exp_wires.push_back(wire_name);
      }
    }

    else if(tbCodeInfo->outPorts){
      for(iter2= (tbCodeInfo->outPorts)->rbegin(); iter2 != (tbCodeInfo->outPorts)->rend(); ++iter2){
	if((*iter2)->getName()){
	  port_name = *((*iter2)->getName());
	  //out_port_name_vec.push_back(port_name);
	  string wire_name= dut_inst + "_out_" + port_name + "_expected";
	  dut_exp_wires.push_back(wire_name);
	}
      }
    }
   
    //---------------------------------------------------------------
    loop_t stimulus;
    loop_t expected;
    row_t row;

    for(iter11 = dut_in_wires.begin(); iter11 !=dut_in_wires.end(); iter11++){
        string pi_name = *iter11;
        // row_t row;
        row("in_wire_name")= pi_name;
   
        stimulus += row;
    }
 
    //------------------------------------------------------------
    //----------------TB signals for DUT output ports-------------
    //These are created in signals.cpp

    for(iter12 = dut_exp_wires.begin(); iter12 !=dut_exp_wires.end(); iter12++){
        string po_name = *iter12;
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
    if(file_name){
      ofstream testbench(file_name, ios::app);
      testbench << templ;
      //cout << templ << endl;
    }
}

//----------------------------------------------------------------------------

void run_tb_initial_block(RefCSLOmVerilogTbGenerator& tbCodeInfo)
{
    #ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
        cout << "CSLOM_VerilogTbTestbench.cpp :: run_tb_initial_block" << endl;
    #endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/initial_block.tmpl");

    // char file_name[20] = "TB.v";

    //----------------vars from signal.tmpl------------
    string file_mcd; 
    string cycle_cnt ;
    string testbench_reset_ ;
    string clk ;
    string rand_valid ;
    string exp_match_count ;
    string exp_mismatch_count ;
    string exp_transaction_count ;
    string exp_mismatch ;

    //------------------------------------------------
    //-----------values from vectors------------------
    string clk_init = "1'b0";
    string rand_valid_init = "1'b1";
    string testbench_reset_init = "1'b1";

    //------------------------------------------------
    //---------inputs from vectors-------------------
    string vectors_file = "vectors.txt";
    string wavesDefaultOutputFile_dump ="wavesDefaultOutputFile_dump";
    string tb_name ;
    string dut_inst;
    string dut_name;
    //-------------------------------------------

   
    if(tbCodeInfo->tbName){
      tb_name       = *tbCodeInfo->tbName;
     
    }
    if(tbCodeInfo->dutInstName){
      dut_inst       = *tbCodeInfo->dutInstName;
     
    }
    if(tbCodeInfo->dutName){
      dut_name       = *tbCodeInfo->dutName;
     
    }
    //generated testbench file_name
    // string m_outputPath = path + "/test/tests/" + dut_name + "_cslc_generated/code/verilog/";
    string m_outputPath = tbCodeInfo->m_outputPath;

    const char* file_name;
    string tb_file_name;
    if(!tb_name.empty()){
      tb_file_name = m_outputPath + dut_inst + "_" + tb_name + ".v";
      file_name= tb_file_name.c_str();
    }
    //---------------------------------------------

    if(tbCodeInfo->fileMcdName){
      file_mcd             = *tbCodeInfo->fileMcdName;
     
    }
    if(tbCodeInfo->randValidName){
      rand_valid           = *tbCodeInfo->randValidName;
    }
    if(tbCodeInfo->cycleCntName){
      cycle_cnt            = *tbCodeInfo->cycleCntName;
     
    }
    if(tbCodeInfo->clockName){
      clk                  = *tbCodeInfo->clockName; 
            
    }
    if(tbCodeInfo->resetName){
      testbench_reset_     = *tbCodeInfo->resetName; 
     
    }
   
    
    //-------------------------------------------
    if(tbCodeInfo->matchCountName){
      exp_match_count = *tbCodeInfo->matchCountName;
    }
    if(tbCodeInfo->mismatchCountName){
      exp_mismatch_count = *tbCodeInfo->mismatchCountName;
    }
    if(tbCodeInfo->transCountName){
      exp_transaction_count = *tbCodeInfo->transCountName;
    }
    if(tbCodeInfo->mismatchName){
      exp_mismatch = *tbCodeInfo->mismatchName;
    }

    //---------------------------------------
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
    templ("tb_name") = tb_name;

    //cout << templ;
    //-------------add to tb file-------------
    if(file_name){
      ofstream testbench(file_name, ios::app);
      testbench << templ;
      //cout << templ << endl;
    }
}

//----------------------------------------------------------------------------

void run_tb_match(RefCSLOmVerilogTbGenerator& tbCodeInfo)
{
    #ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
        cout << "CSLOM_VerilogTbTestbench.cpp :: run_tb_match" << endl;
    #endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/match.tmpl");

    // char file_name[20] = "TB.v";

    string dut_inst;
    string dut_name;
    string port_name;
    string file_mcd;
    NSCSLOm::TVec_RefCSLOmExprLink::const_iterator iter_out;
    
    NSCSLOm::TVec_RefCSLOmExprLink::const_iterator iter_exp;
    
    string tb_name;
    if(tbCodeInfo->tbName){
      tb_name = *tbCodeInfo->tbName;
    }
    if(tbCodeInfo->dutInstName){
      dut_inst = *tbCodeInfo->dutInstName;
    }
    if(tbCodeInfo->dutName){
      dut_name = *tbCodeInfo->dutName;
    }
     if(tbCodeInfo->fileMcdName){
      file_mcd  = *tbCodeInfo->fileMcdName;
     
    }
    //generated testbench file_name
     // string m_outputPath = path + "/test/tests/" + dut_name + "_cslc_generated/code/verilog/";
     string m_outputPath = tbCodeInfo->m_outputPath;

    string tb_file_name;
    const char* file_name;
    if(!tb_name.empty()){
      tb_file_name = m_outputPath + dut_inst + "_" + tb_name + ".v";
      file_name= tb_file_name.c_str();
    }
    //---------------------------------------------
    //-------------DUT output signals----------------------
 
    vector<string> dut_out_wires;
    vector<string>::const_iterator iter1;
    vector<string>::const_iterator iterIfcOut;
    //----------DUT output wires------------------
    if(!(tbCodeInfo->outIfcPorts).empty()){
      for(iterIfcOut= (tbCodeInfo->outIfcPorts).begin(); iterIfcOut != (tbCodeInfo->outIfcPorts).end(); iterIfcOut++){
	port_name = *iterIfcOut;
	string wire_name= dut_inst + "_out_" + port_name;
	dut_out_wires.push_back(wire_name);
      }
    }
    else  if(tbCodeInfo->outPorts){
      for(iter_out= (tbCodeInfo->outPorts)->begin(); iter_out != (tbCodeInfo->outPorts)->end(); iter_out++){
	if((*iter_out)->getName()){
	  port_name = *((*iter_out)->getName());
	  //out_port_name_vec.push_back(port_name);
	  string wire_name= dut_inst + "_out_" + port_name;
	  dut_out_wires.push_back(wire_name);
	}
      }
    }
    //-------------TB expected signals(generated by vectors)------
    //these signals are inputs from signals.tmpl
    vector<string> dut_exp_wires;
    vector<string>::const_iterator iter2;
     vector<string>::const_iterator iterIfcExp;
    //----------DUT expected wires------------------
     if(!(tbCodeInfo->outIfcPorts).empty()){
       for(iterIfcExp= (tbCodeInfo->outIfcPorts).begin(); iterIfcExp != (tbCodeInfo->outIfcPorts).end(); iterIfcExp++){
	 port_name = *iterIfcExp;
	 string wire_name= dut_inst + "_out_" + port_name + "_expected";
	 dut_exp_wires.push_back(wire_name);
       }
     }
     else if(tbCodeInfo->outPorts){
      for(iter_exp= (tbCodeInfo->outPorts)->begin(); iter_exp != (tbCodeInfo->outPorts)->end(); iter_exp++){
	if((*iter_exp)->getName()){
	  port_name = *((*iter_exp)->getName());
	  //out_port_name_vec.push_back(port_name);
	  string wire_name= dut_inst + "_out_" + port_name + "_expected";
	  dut_exp_wires.push_back(wire_name);
	}
      }
    }

    //----------clk/reset signals----------------------------------
    
    string clk ;
    string testbench_reset_ ;

    //--------------------------------------------------------------
    //----------------------------------------------------
    //these signals are declared in tb and are inputs from signals.tmpl
    string exp_match_count ;
    string exp_mismatch_count ;
    string exp_transaction_count ;
    string exp_mismatch ;

    //---------------------------------------------
    //-----------inputs from param.tmpl------------
    string EXP_ADDR_WIDTH ;
    string EXP_VECTOR_MAX_ERR ;
    //---------------------------------------------
    // -----------clk period----------------------
    //------------from vectors---------------------
    int clk_per ;
    //--------------------------------------------


    if(tbCodeInfo->clockName){
      clk                  = *tbCodeInfo->clockName; 
            
    }
    if(tbCodeInfo->resetName){
      testbench_reset_     = *tbCodeInfo->resetName; 
     
    }
    if(tbCodeInfo->per){
      clk_per = tbCodeInfo->per;
    }
  //-------------------------------------------
    if(tbCodeInfo->matchCountName){
      exp_match_count = *tbCodeInfo->matchCountName;
    }
    if(tbCodeInfo->mismatchCountName){
      exp_mismatch_count = *tbCodeInfo->mismatchCountName;
    }
    if(tbCodeInfo->transCountName){
      exp_transaction_count = *tbCodeInfo->transCountName;
    }
    if(tbCodeInfo->mismatchName){
      exp_mismatch = *tbCodeInfo->mismatchName;
    }

    //---------------------------------------
    if(tbCodeInfo->expAddrWidthParamName){
      EXP_ADDR_WIDTH       = *tbCodeInfo->expAddrWidthParamName;   
    }      

    if(tbCodeInfo->expVecMaxErrParamName){
      EXP_VECTOR_MAX_ERR    = *tbCodeInfo->expVecMaxErrParamName;   
      
    }
    //-------------------------------------------

    int i=0;
    loop_t match_list;
    //loop_t mismatch_list;
    row_t row1;
 
    for(iter1 = dut_out_wires.begin(); iter1 != dut_out_wires.end(); iter1++){
        string match = *iter1 + "_match_en";
        string mismatch = *iter1 + "_mismatch_en";
        row1("match_en") = match;
        row1("mismatch_en") = mismatch;
        row1("out_signal")= *iter1;
        row1("exp_signal")= dut_exp_wires.at(i);
        i++;
        match_list += row1;
    }

    templ("match_list") = match_list;
    //------------------------------------------------------------
    templ("clk") = clk;
    templ("testbench_reset_") = testbench_reset_;
    templ("mismatch_count") = exp_mismatch_count;
    templ("match_count") = exp_match_count;
    templ("EXP_ADDR_WIDTH") = EXP_ADDR_WIDTH; 
    templ("EXP_VECTOR_MAX_ERR") = EXP_VECTOR_MAX_ERR;

    //-----------------------------------------------------
    loop_t mismatches;
    loop_t matches;
    row_t row2;

    for(iter1 = dut_out_wires.begin(); iter1 != dut_out_wires.end(); iter1++){
        string mismatch = *iter1 + "_mismatch_en";
        row2("mismatch_en") = mismatch;
        row2("transaction_count") = exp_transaction_count;
        row2("mismatch_count") = exp_mismatch_count;
	row2("out_wire") = *iter1;
        row2("exp_wire") = *iter1 + "_expected";
	row2("file_mcd") = file_mcd;
        mismatches +=row2;
    }

    for(iter1 = dut_out_wires.begin(); iter1 != dut_out_wires.end(); iter1++){
        string match = *iter1 + "_match_en";
        row2("match_en") = match;
        row2("transaction_count") = exp_transaction_count;
        row2("match_count") = exp_match_count;
	row2("out_wire") = *iter1;
        row2("exp_wire") = *iter1 + "_expected";
	row2("file_mcd") = file_mcd;
        matches +=row2;
    }

    templ("mismatches") = mismatches;
    templ("matches") = matches;
    templ("clk_per")= clk_per;
    //---------------------------------------------------------

    // cout << templ;
    //-------------add to tb file-------------
    if(file_name){
    ofstream testbench(file_name, ios::app);
    testbench << templ;
    //cout << templ << endl;
    }
}

//----------------------------------------------------------------------------

/*void run_tb_clk_gen(RefCSLOmVerilogTbGenerator& tbCodeInfo)
{
    #ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
        cout << "CSLOM_VerilogTbTestbench.cpp :: run_tb_clk_gen" << endl;
    #endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/clk_gen.tmpl");

  
    string clk;
    int clk_per;
    char file_name[20] = "TB.v";

    if(tbCodeInfo->clockName){
      clk                  = *tbCodeInfo->clockName; 
            
    }
    if(tbCodeInfo->per){
      clk_per = tbCodeInfo->per;
    }
   
    templ("clk") = clk;
    templ("clk_per")= clk_per;
    
    //-------------add to tb file-------------
    ofstream testbench(file_name, ios::app);
    testbench << templ;
    cout << templ << endl;
    }*/

//----------------------------------------------------------------------------

void run_tb_testbench(RefCSLOmVerilogTbGenerator& tbCodeInfo)
{
    #ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
        cout << "CSLOM_VerilogTbTestbench.cpp :: run_tb_testbench" << endl;
    #endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/testbench.tmpl");

   
    //---------------create the tb.v file------------------

    string tb_name;
    string dut_inst;
    string dut_name;

    string m_outputPath = tbCodeInfo->m_outputPath;

   
   

    if(tbCodeInfo->tbName){
      tb_name = *tbCodeInfo->tbName;
    }
    if(tbCodeInfo->dutInstName){
      dut_inst = *tbCodeInfo->dutInstName;
    }
    if(tbCodeInfo->dutName){
      dut_name = *tbCodeInfo->dutName;
    }

    vector<RefString>::const_iterator dutNameIter, dutInstIter;
    if(!(tbCodeInfo->m_dutNames)->empty()){
      for (dutNameIter = (tbCodeInfo->m_dutNames)->begin(); dutNameIter != (tbCodeInfo->m_dutNames)->end(); dutNameIter++){
	//	cout << "DUT NAME =" << **dutNameIter << endl;
      }
    }
    //  if(!(tbCodeInfo->dutInstNameVec).empty()){
    //  for (dutInstIter = (tbCodeInfo->dutInstNameVec).begin(); dutInstIter != (tbCodeInfo->dutInstNameVec).end(); dutInstIter++){  
	string tb_file_name;
	const char* file_name;
	ofstream testbench;
	
	//	dut_inst = **dutInstIter;
	//cout << "DUT INST NAME =" << **dutInstIter << endl;
	//  }
	//}

	if((tbCodeInfo->dutInstNameVec).size()<= 1){
	  //generated testbench file_name
	  if(!tb_name.empty()){
	    tb_file_name = m_outputPath + dut_inst + "_" + tb_name + ".v";
	    file_name= tb_file_name.c_str();
	    
	    testbench.open(file_name, ios::trunc);
	    testbench.open(file_name, ios::in);
	    
	    cout << ".........Created testbench file: " << file_name << "\n";
	  }
	  else {
	    cout << "NO testbench is generated!!!" << endl;
	  }
	}
	else { 
	  cout << endl;
	  cout << "ERROR :  Many DUT instances inside the Test Bench. Only one DUT instance is allowed!!!" << endl; 
	  cout << "NOTE : Verilog TB code will be generated only for one DUT instance!!!" << endl << endl;
	}
    //-------------------------------------------------------
 
    //---------------run all templates----------
	if(!tb_name.empty()){
	  run_tb_param(tbCodeInfo);
	  run_tb_signal(tbCodeInfo);
	  run_tb_dut_inst(tbCodeInfo);
	  run_tb_stim_exp_memory(tbCodeInfo);
	  run_tb_initial_block(tbCodeInfo);
	  run_tb_match(tbCodeInfo);
	  //run_tb_clk_gen(tbCodeInfo);
	  
	  testbench << templ;
	}
    
}

