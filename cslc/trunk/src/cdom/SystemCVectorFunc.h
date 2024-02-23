// Turn on/off generation of vector files for unit instances
// Implemented by Oana Botez
//------------------------------------------

#ifndef VEC_CTRL_H
#define VEC_CTRL_H

#include <cstdio>
#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <string>
#include <algorithm>
#include "boost/shared_ptr.hpp"
#include "boost/weak_ptr.hpp"
#include "../support/TypeDefs.h"


typedef std::map<std::string,TBool> TMap_RefString_TBool;
typedef boost::shared_ptr<TMap_RefString_TBool> Ref_TMap_RefString_TBool;

extern Ref_TMap_RefString_TBool unit_inst;
extern Ref_TMap_RefString_TBool unit_inst_vcd;

namespace vec_func {

  typedef std::map<std::string,TBool> TMap_RefString_TBool;
  typedef boost::shared_ptr<TMap_RefString_TBool> Ref_TMap_RefString_TBool;
  typedef std::map<std::string,TBool>::iterator iter_TMap_RefString_TBool;
  typedef std::pair<RefString,TBool> TPair_RefString_TBool; 
  typedef std::vector<RefString> TVec_RefString;
  typedef TVec_RefString::const_iterator refString_iter;
  typedef std::vector<std::string> TVecString;
  typedef TVecString::const_iterator string_iter;
  typedef boost::shared_ptr<TVec_RefString> Ref_TVec_RefString;
  typedef std::map<std::string,Ref_TVec_RefString> TMap_RefStr_TVec;
  typedef std::pair<std::string,Ref_TVec_RefString> TPair_RefString_TVec;
  typedef std::map<std::string,Ref_TVec_RefString>::iterator iter_TMap_RefString_TVec;
  typedef boost::shared_ptr<TMap_RefStr_TVec> RefMap_RefStr_TVec;

 
    void registerUnit(RefString u);
  //void registerInst();
    void turnOn(RefString u);
    void parseArgs(char* args[], int argc);
    void setVecArgs(char* args);
    void setVcdArgs(char* args);
    void turnOnVecAllUnits();
    void turnOnVcdAllUnits();
    void printMap();

}

#endif
