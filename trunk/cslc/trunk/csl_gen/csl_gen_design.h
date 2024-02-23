#ifndef _CSL_GEN_DESIGN_H_
#define _CSL_GEN_DESIGN_H_

#include "csl_gen_base.h"

using namespace std;

namespace NSCSLinterconnect {


class CSLdesign : public CSLbase {
  public:
    CSLdesign(string name = "Default_design");
    ~CSLdesign();

    //build functions
    bool buildDecl();
    void print(){}

    //  private:
    //add functions
//     void addBitrange();
//     void addSignal();
//     void addIfc();
//     void addUnit();
//       void addField();
//       void addEnum();
    void addIsaInstrFormat();
};
} //NSCSLinterconnect

#endif //_CSL_INTERCONNECT_GEN_H_
