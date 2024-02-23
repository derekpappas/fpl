//---------------------------------------------------------------------
// Copyright (C) 2005 - 2009 Fastpath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//----------------------------------------------------------------------


#ifndef INC_GUARD_xor_h
#define INC_GUARD_xor_h

#include "nand2.h"
//#include "SystemCVectorWriter.h"
#include "SystemCVectorWriterTrace.h"
#include <iostream>

SC_MODULE(exor2)
{
  sc_in<bool> clk;
  sc_in<sc_uint<4> > A;
  sc_in<sc_uint<4> > B;
  sc_out<sc_uint<4> > F;

  nand2 n1, n2, n3, n4;

  sc_signal<sc_uint<4> > S1;
  sc_signal<sc_uint<4> > S2;
  sc_signal<sc_uint<4> > S3;

  std::string instanceName;

  // stimulus vector file 
  sc_trace_file * stimVecFile_exor;  
  // expected vector file 
  sc_trace_file * expVecFile_exor; 

  void setInstanceName(std::string in) { 
    instanceName = in; 

    char st[] = "stim_vec_";
    char exp[] = "exp_vec_";
    const char* nm = instanceName.c_str();
    char* stimInst = strcat(st,nm);
    char* expInst = strcat(exp,nm);

 
      // create the vector files
      stimVecFile_exor = sc_create_vec_file(stimInst,2,4);
      ((vec_file*)stimVecFile_exor)->sc_set_vcd_time_unit(-9);
      expVecFile_exor = sc_create_vec_file(expInst,2,4);
      ((vec_file*)expVecFile_exor)->sc_set_vcd_time_unit(-9);

    std::cout << "instance name exor in function = " << instanceName << " " << nm << std::endl;
  }

  SC_CTOR(exor2) : n1("N1"), n2("N2"), n3("N3"), n4("N4")
  {

    n1.A(A);
    n1.B(B);
    n1.F(S1);

    n2.A(A);
    n2.B(S1);
    n2.F(S2);

    n3.A(S1);
    n3.B(B);
    n3.F(S3);

    n4.A(S2);
    n4.B(S3);
    n4.F(F);

    sc_trace(stimVecFile_exor, A, std::string("A") );
    sc_trace(stimVecFile_exor, B, std::string("B") );
    sc_trace(expVecFile_exor, F, std::string("F") );

/*
    sc_trace_file * stimVecFile_n1;
    sc_trace_file * expVecFile_n1;

 
    stimVecFile_n1 = sc_create_vec_file("stim_vec_n1",2,4);
    ((vec_file*)stimVecFile_n1)->sc_set_vcd_time_unit(-9);

    expVecFile_n1 = sc_create_vec_file("exp_vec_n1",2,4);
    ((vec_file*)expVecFile_n1)->sc_set_vcd_time_unit(-9);

    sc_trace(stimVecFile_n1, n1.A , std::string("A") );
    sc_trace(stimVecFile_n1, n1.B , std::string("B") );
    sc_trace(expVecFile_n1, n1.F , std::string("F") );
*/

    dont_initialize();  // no initial 0 values

    //sensitive << A << B;  // genVec is sensitive to the changes of the input ports

  }
};

#endif
