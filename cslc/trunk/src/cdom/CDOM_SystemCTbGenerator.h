//----------------------------------------------------------------------
// Copyright (c) 2005 - 2009 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in par2t, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------
#include <iostream>
#include <fstream>
//#define __TRACE
#include "CDOM.h"
#include "CDOM_Type_Map.h"
#include "CDOM_Visitor.h"
//-------OB added---start
#include "../support/cli/cslcCLI_Support.h"
//-------end

typedef std::map<RefString,int>* mapTb;
//typedef boost::shared_ptr<mapTb> RefMapTb; 
typedef std::map<RefString,int>::iterator iter_mapTb;

#ifndef TB_H
#define TB_H
template <typename Tb>

//********************************************************************************
// CSystemCTbGenerator class
//********************************************************************************

class CSystemCTbGenerator {
 private:
  std::ostream *out; // write to file
  std::ostream *vect_file; // file with vectors
  std::ostream *tb_file; // file with testbench
 public:
  CSystemCTbGenerator();
  void vect_write(RefString s);
  void tb_write(RefString , mapTb);

  };
  
template <typename Tb>
CSystemCTbGenerator<Tb>::CSystemCTbGenerator() {
}


template <typename Tb>
void CSystemCTbGenerator<Tb>::vect_write(RefString s) {
  vect_file = new std::ofstream((*s).c_str());
  out = vect_file;
  *(out) << "template<int MEM_WIDTH = 0, int ADDR_WIDTH = 0, int VECTOR_ID = 0, int VECTOR_VERSION = 0, std::string VECTOR_NAME = "", std::string VECTOR_FILE = "", int VECTOR_RADIX = 0, int MEM_DEPTH = (1 << ADDR_WIDTH) - 1>\n";
  *(out) << "SC_MODULE(stim_expect_mem_template) {\n";
  *(out) << "sc_in_rv<1> clock;\n";
  *(out) << "sc_in_rv<1> reset_;\n";
  *(out) << "sc_in_rv<1> rd_en;\n";
  *(out) << "sc_out_rv<MEM_WIDTH> vector_out;\n";
  *(out) << "sc_out_rv<1> valid;\n";
  *(out) << "sc_out_rv<1> version_err;\n";
  *(out) << "sc_out_rv<1> id_err;\n";
  *(out) << "sc_lv<MEM_WIDTH> memory_out;\n";
  *(out) << "sc_lv<MEM_WIDTH> stim_expect_memory[MEM_DEPTH];\n";
  *(out) << "sc_lv<ADDR_WIDTH> rd_addr;\n";
  *(out) << "sc_lv<1> mem_out_is_id;\n";
  *(out) << "sc_lv<1> mem_out_is_version;\n";
  *(out) << "int mem_addr;\n";
  *(out) << "sc_lv<1> stim_expect_memory_loaded;\n";
  *(out) << "sc_signal_rv<1> mem_out_is_id_or_version;\n";
  *(out) << "sc_signal_rv<1> mux_select;\n";
  *(out) << "sc_signal_rv<1> vector_id_match;\n";
  *(out) << "sc_signal_rv<1> vector_version_match;\n\n";

  *(out) << "void cont_assign_1() {\n";
  *(out) << "mem_out_is_id_or_version = mem_out_is_id.read()mem_out_is_version.read();\n";
  *(out) << "}\n";


  *(out) << "void cont_assign_2() {\n";
  *(out) << " mux_select =  ~ rd_en.read()mem_out_is_id_or_version;\n";
  *(out) << "}\n";


  *(out) << "void cont_assign_3() {\n";
  *(out) << " vector_out = mux_select(MEM_WIDTH ())memory_out.read();\n";
  *(out) << "}\n";


  *(out) << "void cont_assign_4() {\n";
  *(out) << "  vector_id_match = (memory_out.read()VECTOR_ID)mem_out_is_id.read();\n";
  *(out) << "}\n";


  *(out) << "void cont_assign_5() {\n";
  *(out) << "  vector_version_match = (memory_out.read()VECTOR_VERSION)mem_out_is_version.read();\n";
  *(out) << "}\n";


  *(out) << "void cont_assign_6() {\n";
  *(out) << " version_err = mem_out_is_version.read()memory_out.read()VECTOR_VERSION;\n";
  *(out) << "}\n";


  *(out) << "void cont_assign_7() {\n";
  *(out) << "  id_err = mem_out_is_id.read()memory_out.read()VECTOR_ID;\n";
  *(out) << "}\n";


  *(out) << "void cont_assign_8() {\n";
  *(out) << "  valid = rd_en.read() ~ mem_out_is_id_or_version;\n";
  *(out) << "}\n";

  
  *(out) << "void sequential_block_9() {\n";
  *(out) << "   if( ~ reset_.read()) {\n";
  *(out) << "     ( ())      }\n";
  *(out) << "   else         if(rd_en) {\n";
  *(out) << "                              }\n";
  *(out) << "}\n";

  *(out) << "void nonblocking_10() {\n";
  *(out) << "     rd_addr = ;\n";
  *(out) << "    }\n";

  *(out) << "void nonblocking_11() {\n";
  *(out) << "   rd_addr = rd_addr + 1;\n";
  *(out) << " }\n";

  *(out) << "void nonblocking_12() {\n";
  *(out) << "  mem_out_is_id = rd_addr == 0;\n";
  *(out) << "}\b";

  *(out) << "void nonblocking_13() {\n";
  *(out) << "mem_out_is_version = rd_addr == 1;\n";
  *(out) << "}\n";

  *(out) << "void sequential_block_14() {\n";
  *(out) << "if(rd_en) {\n";
  *(out) << "[]}\n";
  *(out) << "}\n";

  *(out) << "void nonblocking_15() {\n";
  *(out) << "memory_out = stim_expect_memory;\n";
  *(out) << "}\n";
  *(out) << "initial \n";

  *(out) << "void sequential_block_16() {\n";
  *(out) << "$display(\"VECTOR_FILE= %s\", VECTOR_FILE);\n";
  *(out) << "if(VECTOR_RADIX) {\n";
  *(out) << "$readmemb(VECTOR_FILE, stim_expect_memory);\n";
  *(out) << "}\n";
  *(out) << "else {\n";
  *(out) << "$readmemh(VECTOR_FILE, stim_expect_memory);\n";
  *(out) << "}\n";
  *(out) << "}\n";

  *(out) << "void nonblocking_17() {\n";
  *(out) << " stim_expect_memory_loaded = 0;\n";
  *(out) << "}\n";

  *(out) << "void nonblocking_18() {\n";
  *(out) << "stim_expect_memory_loaded = 1;\n";
  *(out) << "}\n";
  *(out) << "initial \n";

  *(out) << "void sequential_block_19() {\n";
  *(out) << "stim_expect_memory_loaded;\n";
  *(out) << "if($test$plusargs(\"show_stim_expect_memory_init_state\")) {\n";
  *(out) << "$display(\"Initial state of vector file %s \", VECTOR_FILE);\n";

  *(out) << "for (   mem_addr = ;\n";
  *(out) << "; mem_addrMEM_DEPTH;   mem_addr = mem_addr;\n";
  *(out) << ") {\n";
  *(out) << "$display(\"mem[%d] = %x\", mem_addr, stim_expect_memory[mem_addr]);\n";
  *(out) << "}\n";
  *(out) << "}\n";
  *(out) << "}\n";
  *(out) << "SC_CTOR(stim_expect_mem_template) {\n";
  *(out) << "   SC_METHOD(cont_assign_1);\n";
  *(out) << "   SC_METHOD(cont_assign_2);\n";
  *(out) << "   SC_METHOD(cont_assign_3);\n";
  *(out) << "   SC_METHOD(cont_assign_4);\n";
  *(out) << "   SC_METHOD(cont_assign_5);\n";
  *(out) << "   SC_METHOD(cont_assign_6);\n";
  *(out) << "   SC_METHOD(cont_assign_7);\n";
  *(out) << "   SC_METHOD(cont_assign_8);\n";
  *(out) << "SC_METHOD(sequential_block_9);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(nonblocking_10);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(nonblocking_11);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(nonblocking_12);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(nonblocking_13);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(sequential_block_14);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(nonblocking_15);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(sequential_block_16);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(nonblocking_17);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(nonblocking_18);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "SC_METHOD(sequential_block_19);\n";
  *(out) << "sensitive<<clock<<reset_;\n";
  *(out) << "}\n";
  *(out) << "};\n";

  delete vect_file;

}

template <typename Tb>
void CSystemCTbGenerator<Tb>::tb_write(RefString s, mapTb map) {
  tb_file = new std::ofstream((*s).c_str());
  out = tb_file;
  RefString s1(new std::string("STIM_MEM_WIDTH"));
  RefString s2(new std::string("EXP_MEM_WIDTH"));
  //STIM_MEM_WIDTH = the width of the first input port
  //EXP_MEM_WIDTH = the sum of the widths for all output ports
  *(out) << "template<int SIM_TIMEOUT_CNT = 100, int STIM_MEM_WIDTH = " << (map->find(s1))->second << ", int STIM_ADDR_WIDTH = 0, int STIM_VECTOR_ID = 0, int STIM_VECTOR_VERSION = 0, std::string STIM_VECTOR_NAME = \"stim\", std::string STIM_VECTOR_FILE = \"stim_output.vec\", int STIM_VECTOR_RADIX = 0, int STIM_VECTOR_MAX_ERR = 0, int EXP_MEM_WIDTH = " << (map->find(s2))->second << ", int EXP_ADDR_WIDTH = 0, int EXP_VECTOR_ID = 0, int EXP_VECTOR_VERSION = 0, std::string EXP_VECTOR_NAME = \"exp\", std::string EXP_VECTOR_FILE = \"exp_output.vec\", int EXP_VECTOR_RADIX = 0, int EXP_VECTOR_MAX_ERR = 0>\n";



  delete tb_file;

}


#endif
