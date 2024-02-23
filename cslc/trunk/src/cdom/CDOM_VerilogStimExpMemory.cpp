#include "CDOM_VerilogStimExpMemory.h"
#include <stdlib.h>
#include <fstream>
#include <iostream>
#include <string>

using namespace std;
using namespace tmpl;
using namespace NSCdom;
using namespace NSCdomStimExpGenerator;

//----------------------------------------------------------------------------
void run_tb_StimExpMemory (RefCStimExpGenerator& tbMemInfo)
{
    cout << "CDOM_VerilogStimExpMemory.cpp :: run_tb_StimExpMemory" << endl;

// create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/verilog_tb_templates/stim_expect_memory_template.tmpl");

    vector<string> dut_inst_vec;
    vector<string> stimExpMemVec;
    string dut_inst;
    string mem_name;
    string m_outputPath = tbMemInfo->m_outputPath;
    string stim_exp_file_name;
    const char* file_name; 
    const char* fname;
    ofstream stimExpMem;

    string moduleName ;
    vector<RefString>::const_iterator nameIter;
    vector<RefString> namesVec;
    string MEM_WIDTH ;
    string ADDR_WIDTH ;
    string VECTOR_ID ;
    string VECTOR_VERSION ;
    string VECTOR_NAME ;
    string VECTOR_FILE ;
    string VECTOR_RADIX ;
    string MEM_DEPTH ;

    string clock;
    string reset_;
    string rd_en;
    string valid;
    string vector_out;
    string version_err;
    string id_err;

    string clock_dir;
    string reset_dir;
    string rd_en_dir;
    string valid_dir;
    string vector_out_dir;
    string version_err_dir;
    string id_err_dir;

    string memory_out_type;
    string memory_out;
    string stim_expect_memory_type;
    string stim_expect_memory;
    string rd_addr_type;
    string rd_addr;
    string mem_out_is_id_type;
    string mem_out_is_id;
    string mem_out_is_version_type;
    string mem_out_is_version;
    string mem_addr_type;
    string mem_addr;
    string stim_expect_memory_loaded_type;
    string stim_expect_memory_loaded;
    string mem_out_is_id_or_version_type;
    string mem_out_is_id_or_version;
    string mux_select_type;
    string mux_select;
    string vector_id_match_type;
    string vector_id_match;
    string vector_version_match_type;
    string vector_version_match;
    
    vector<string>:: const_iterator itFile;
    vector<RefString>:: const_iterator itInst;

    if(!(tbMemInfo->m_dutInstVec).empty()){
      vector<RefString> InstVec = tbMemInfo->m_dutInstVec;

      for(itInst = InstVec.begin(); itInst != InstVec.end(); itInst++){
	dut_inst = **itInst;
	dut_inst_vec.push_back(dut_inst);

	if(tbMemInfo->m_stimExpModule){
	  mem_name = *tbMemInfo->m_stimExpModule;
	  moduleName = dut_inst + "_" + mem_name; 
	}

	//generated stim_exp_mem_template file_name
	if(!mem_name.empty()){
	  stim_exp_file_name = m_outputPath + dut_inst + "_" + mem_name + ".v";
	  file_name= stim_exp_file_name.c_str();

	  stimExpMem.open(file_name, ios::trunc);  //delete everything in the file
	  stimExpMemVec.push_back(file_name);
	  //stimExpMem.open(file_name, ios::in);

	  cout << ".........stim_expect_memory_template  file is created: " << file_name << " !!! \n";
	}
	else {
	  cout << "NO stim_expect_memory is generated!!!" << endl;
	}

      }
    }

   
    if(tbMemInfo->m_MemWidth){
      MEM_WIDTH = *tbMemInfo->m_MemWidth;
    }
    if(tbMemInfo->m_AddrWidth){
      ADDR_WIDTH = *tbMemInfo->m_AddrWidth;
    }
    if(tbMemInfo->m_VectorId){
      VECTOR_ID = *tbMemInfo->m_VectorId;
    }
    if(tbMemInfo->m_VectorVersion){
      VECTOR_VERSION = *tbMemInfo->m_VectorVersion;
    }
    if(tbMemInfo->m_VectorName){
      VECTOR_NAME = *tbMemInfo->m_VectorName;
    }
    if(tbMemInfo->m_VectorFile){
      VECTOR_FILE = *tbMemInfo->m_VectorFile;
    }
    if(tbMemInfo->m_VectorRadix){
      VECTOR_RADIX = *tbMemInfo->m_VectorRadix;
    }
    if(tbMemInfo->m_MemDepth){
      MEM_DEPTH = *tbMemInfo->m_MemDepth;
    }
    if(tbMemInfo->m_clock){
      clock  = *tbMemInfo->m_clock;
    }
    if(tbMemInfo->m_reset){
      reset_ = *tbMemInfo->m_reset;
    }
    if(tbMemInfo->m_rd_en){
      rd_en  = *tbMemInfo->m_rd_en;
    }
    if(tbMemInfo->m_vector_out){
      vector_out = *tbMemInfo->m_vector_out;
    }
    if(tbMemInfo->m_valid){
      valid = *tbMemInfo->m_valid;
    }
    if(tbMemInfo->m_version_err){
      version_err = *tbMemInfo->m_version_err;
    }
    if(tbMemInfo->m_id_err){
      id_err = *tbMemInfo->m_id_err;
    }
    clock_dir = "input";
    reset_dir = "input";
    rd_en_dir = "input";
    vector_out_dir = "output";
    valid_dir = "output";
    version_err_dir = "output";
    id_err_dir = "output";
    
    if(tbMemInfo->m_memory_out){    
      memory_out = *tbMemInfo->m_memory_out;
    }
    if(tbMemInfo->m_stim_expect_memory){
      stim_expect_memory = *tbMemInfo->m_stim_expect_memory;
    }
    if(tbMemInfo->m_rd_addr){
      rd_addr = *tbMemInfo->m_rd_addr;
    }
    if(tbMemInfo->m_mem_out_is_id){
      mem_out_is_id = *tbMemInfo->m_mem_out_is_id;
    }
    if(tbMemInfo->m_mem_out_is_version){
      mem_out_is_version = *tbMemInfo->m_mem_out_is_version;
    }
    if(tbMemInfo->m_mem_addr){
      mem_addr = *tbMemInfo->m_mem_addr;
    }
    if(tbMemInfo->m_stim_expect_memory_loaded){
      stim_expect_memory_loaded = *tbMemInfo->m_stim_expect_memory_loaded;
    }
    if(tbMemInfo->m_mem_out_is_id_or_version){
      mem_out_is_id_or_version = *tbMemInfo->m_mem_out_is_id_or_version;
    }
    if(tbMemInfo->m_mux_select){
      mux_select = *tbMemInfo->m_mux_select;
    }
    if(tbMemInfo->m_vector_id_match){
      vector_id_match = *tbMemInfo->m_vector_id_match;
    }
    if(tbMemInfo->m_vector_version_match){
      vector_version_match = *tbMemInfo->m_vector_version_match;
    }
    memory_out_type = "reg";
    stim_expect_memory_type = "reg";
    rd_addr_type = "reg";
    mem_out_is_id_type = "reg";
    mem_out_is_version_type = "reg";
    mem_addr_type ="integer";
    stim_expect_memory_loaded_type = "reg";
    mem_out_is_id_or_version_type = "wire";
    mux_select_type = "wire";
    vector_id_match_type = "wire";
    vector_version_match_type = "wire";

    templ("module_name")=moduleName;
    templ("MEM_WIDTH")= MEM_WIDTH;
    templ("ADDR_WIDTH")= ADDR_WIDTH;
    templ("VECTOR_ID")= VECTOR_ID;
    templ("VECTOR_VERSION")= VECTOR_VERSION;
    templ("VECTOR_NAME")= VECTOR_NAME;
    templ("VECTOR_FILE")= VECTOR_FILE;
    templ("VECTOR_RADIX")= VECTOR_RADIX;
    templ("MEM_DEPTH")= MEM_DEPTH;

    templ("clock")= clock;
    templ("reset_")=reset_;
    templ("rd_en")=rd_en;
    templ("vector_out")=vector_out;
    templ("valid")=valid;
    templ("version_err")=version_err;
    templ("id_err")=id_err;

    templ("clock_dir")= clock_dir;
    templ("reset_dir")=reset_dir;
    templ("rd_en_dir")=rd_en_dir;
    templ("vector_out_dir")=vector_out_dir;
    templ("valid_dir")=valid_dir;
    templ("version_err_dir")=version_err_dir;
    templ("id_err_dir")=id_err_dir;

    templ("memory_out_type")=memory_out_type;
    templ("memory_out") =memory_out;
    templ("stim_expect_memory_type")=stim_expect_memory_type;
    templ("stim_expect_memory")=stim_expect_memory;
    templ("rd_addr_type")=rd_addr_type;
    templ("rd_addr")=rd_addr;
    templ("mem_out_is_id_type")=mem_out_is_id_type;
    templ("mem_out_is_id")=mem_out_is_id;
    templ("mem_out_is_version_type")=mem_out_is_version_type;
    templ("mem_out_is_version")=mem_out_is_version;
    templ("mem_addr_type")=mem_addr_type;
    templ("mem_addr")=mem_addr;
    templ("stim_expect_memory_loaded_type")=stim_expect_memory_loaded_type;
    templ("stim_expect_memory_loaded")=stim_expect_memory_loaded;
    templ("mem_out_is_id_or_version_type")=mem_out_is_id_or_version_type;
    templ("mem_out_is_id_or_version")=mem_out_is_id_or_version;
    templ("mux_select_type")=mux_select_type;
    templ("mux_select")=mux_select;
    templ("vector_id_match_type")=vector_id_match_type;
    templ("vector_id_match")=vector_id_match;
    templ("vector_version_match_type")=vector_version_match_type;
    templ("vector_version_match")=vector_version_match;

    for(itFile = stimExpMemVec.begin(); itFile != stimExpMemVec.end(); itFile++){
      string var = *itFile;
      fname = var.c_str();
      ofstream stimExpMem(fname, ios::app);
      stimExpMem << templ;
      stimExpMem.close();
    }
      // if(file_name){
      // ofstream stimExpMem(file_name, ios::app);
      // stimExpMem << templ;
  
      //stimExpMem.close();

      //  }
   
}
