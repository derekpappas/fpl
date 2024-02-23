// Copyright 2003 Star Galaxy Publishing
// File: micro_bus.h

#include "systemc.h"

const int ADDR_WIDTH = 16;
const int DATA_WIDTH = 8;

struct micro_bus {
  sc_uint<ADDR_WIDTH> address;
  sc_uint<DATA_WIDTH> data;

  bool read, write;

  inline micro_bus& operator= (const micro_bus&);

  bool operator== (const micro_bus&) const;
};

inline micro_bus& micro_bus::operator= (const micro_bus& arg) {
  address = arg.address;
  data = arg.data;
  read = arg.read;
  write = arg.write;
 
  return (*this);
}

inline bool micro_bus::operator== (const micro_bus& arg) const {
  return (
    (address == arg.address) && 
    (data == arg.data) && 
    (read == arg.read) && 
    (write == arg.write));
}

inline ostream& operator<< (ostream& os, const micro_bus& arg) {
  os << "address=" << arg.address <<
        " data=" << arg.data << " read=" << arg.read << 
        " write=" << arg.write << endl;

  return os;
}

inline void sc_trace (sc_trace_file *tf, const micro_bus& arg, const sc_string& name) {
  sc_trace (tf, arg.address, name+".address");
  sc_trace (tf, arg.data, name+".data");
  sc_trace (tf, arg.read, name+".read");
  sc_trace (tf, arg.write, name+".write");
}
