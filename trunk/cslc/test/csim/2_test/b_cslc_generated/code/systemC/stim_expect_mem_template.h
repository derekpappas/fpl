template<int MEM_WIDTH = 0, int ADDR_WIDTH = 0, int VECTOR_ID = 0, int VECTOR_VERSION = 0, std::string VECTOR_NAME = "", std::string VECTOR_FILE = "", int VECTOR_RADIX = 0, int MEM_DEPTH = >
#include "systemc.h"

SC_MODULE(stim_expect_mem_template) {
  sc_in<sc_int<1> > clock;
  sc_in<sc_int<1> > reset_;
  sc_in<sc_int<1> > rd_en;
  sc_out<sc_int<1> > vector_out;
  sc_out<sc_int<1> > valid;
  sc_out<sc_int<1> > version_err;
  sc_out<sc_int<1> > id_err;
  sc_signal<sc_int<1> > memory_out;
  sc_signal<sc_int<1> > stim_expect_memory[];
  sc_signal<sc_int<1> > rd_addr;
  sc_signal<sc_int<1> > mem_out_is_id;
  sc_signal<sc_int<1> > mem_out_is_version;
  int mem_addr;
  sc_signal<sc_int<1> > stim_expect_memory_loaded;
  sc_signal<sc_int<1> > mem_out_is_id_or_version;
  sc_signal<sc_int<1> > mux_select;
  sc_signal<sc_int<1> > vector_id_match;
  sc_signal<sc_int<1> > vector_version_match;

  void cont_assign_4() {
    mem_out_is_id_or_version = mem_out_is_id.read() || mem_out_is_version.read();
  }


  void cont_assign_5() {
    mux_select =  ~ rd_en.read() || mem_out_is_id_or_version.read();
  }


  void cont_assign_6() {
    vector_out = mux_select.read() ? ( (0)) : memory_out.read();
  }


  void cont_assign_7() {
    vector_id_match = (memory_out.read() == VECTOR_ID.read()) & mem_out_is_id.read();
  }


  void cont_assign_8() {
    vector_version_match = (memory_out.read() == VECTOR_VERSION.read()) & mem_out_is_version.read();
  }


  void cont_assign_9() {
    version_err = mem_out_is_version.read() & memory_out.read() != VECTOR_VERSION.read();
  }


  void cont_assign_10() {
    id_err = mem_out_is_id.read() & memory_out.read() != VECTOR_ID.read();
  }


  void cont_assign_11() {
    valid = rd_en.read() &&  ~ mem_out_is_id_or_version.read();
  }

  
    void sequential_block_12() {
      if( ~ reset_.read()) {
        ( ())      }
      else         if() {
                                      }
    }

  void nonblocking_13() {
         = ;
      }

  void nonblocking_14() {
       = ;
    }

  void nonblocking_15() {
     = ;
  }

  void nonblocking_16() {
   = ;
}

void sequential_block_17() {
if() {
  []}
}

  void nonblocking_18() {
   = ;
}
initial 

void sequential_block_19() {
("VECTOR_FILE= %s", );
if(VECTOR_RADIX.read() == 0) {
  (, );
}
else {
  (, );
}
}

  void nonblocking_20() {
   = ;
}

  void nonblocking_21() {
 = ;
}
initial 

void sequential_block_22() {
;
if() {
("Initial state of vector file %s ", );

for (   mem_addr = 0;
; mem_addr.read() < MEM_DEPTH.read();   mem_addr = mem_addr.read() + 1;
) {
  ("mem[%d] = %x", , []);
}
}
}
                                                SC_METHOD(sequential_block_12);
sensitive<<clock<<reset_;
SC_METHOD(nonblocking_13);
sensitive<<clock<<reset_;
SC_METHOD(nonblocking_14);
sensitive<<clock<<reset_;
SC_METHOD(nonblocking_15);
sensitive<<clock<<reset_;
SC_METHOD(nonblocking_16);
sensitive<<clock<<reset_;
SC_METHOD(sequential_block_17);
sensitive<<clock<<reset_;
SC_METHOD(nonblocking_18);
sensitive<<clock<<reset_;
SC_METHOD(sequential_block_19);
sensitive<<clock<<reset_;
SC_METHOD(nonblocking_20);
sensitive<<clock<<reset_;
SC_METHOD(nonblocking_21);
sensitive<<clock<<reset_;
SC_METHOD(sequential_block_22);
sensitive<<clock<<reset_;
  SC_CTOR(stim_expect_mem_template) {
      SC_METHOD(cont_assign_4);
      SC_METHOD(cont_assign_5);
      SC_METHOD(cont_assign_6);
      SC_METHOD(cont_assign_7);
      SC_METHOD(cont_assign_8);
      SC_METHOD(cont_assign_9);
      SC_METHOD(cont_assign_10);
      SC_METHOD(cont_assign_11);
      SC_METHOD(cont_assign_12);
      SC_METHOD(cont_assign_13);
      SC_METHOD(cont_assign_14);
      SC_METHOD(cont_assign_15);
      SC_METHOD(cont_assign_16);
      SC_METHOD(cont_assign_17);
      SC_METHOD(cont_assign_18);
      SC_METHOD(cont_assign_19);
      SC_METHOD(cont_assign_20);
      SC_METHOD(cont_assign_21);
      SC_METHOD(cont_assign_22);
  }
};

