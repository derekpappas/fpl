#include <string>
#include <sstream>

#include "csl_gen_design.h"
//#include "support.h"
//#include "csl_gen_base.h"
#include "cGenIsa_ao.h"

using namespace std;

namespace NSCSLinterconnect{


//ostream* CSLbase::m_out = &cout;

CSLdesign::CSLdesign(string name) : 
  CSLbase(CSL_DESIGN, 0, name) {
  
}



// print function => TO DO (AO)
// void CSLdesign::print_set(string s) {
//        m_out = new ofstream (s.c_str());
// }

// void CSLdesign::close_file() {
//   if (CSLbase::m_out != &cout) {
//     static_cast<ofstream*>(CSLbase::m_out)->close();
//   }
// }

// //***add functions***
// void CSLdesign::addBitrange() {
//   string brName = randString();
//   if (newNameIsValid(brName)) {
//     CSLbasePoint newBr = new CSLbitrange(this, brName);
//     if (newBr->buildDecl()) {
//       addChild(newBr);
//     }
//     else {
//       delete newBr;
//     }
//   }
// }

// void CSLdesign::addSignal() {
//   string sigName = randString();
//   if (newNameIsValid(sigName)) {
//     CSLsignalPoint newSig = new CSLsignal(this, sigName);
//     if (newSig->buildDecl()) {
//       addChild(newSig);
//     }
//     else {
//       delete newSig;
//     }
//   }
// }

// void CSLdesign::addIfc() {
//   string ifcName = randString();
//   if (newNameIsValid(ifcName)) {
//     CSLifcPoint newIfc = new CSLifc(this, ifcName);
//     if (newIfc->buildDecl()) {
//       addChild(newIfc);
//     }
//     else {
//       delete newIfc;
//     }
//   }
// }

// void CSLdesign::addUnit() {
//   string unitName = randString();
//   if (newNameIsValid(unitName)) {
//     CSLunitPoint newUnit = new CSLunit(this, unitName);
//     if (newUnit->buildDecl()) {
//       addChild(newUnit);
//     }
//     else {
//       delete newUnit;
//     }
//   }
// }

// void CSLdesign::addEnum() {
//   string enumName = randString();
//   if(newNameIsValid(enumName)) {
//     CSLenumPoint newEnum = new CSLenum (this, enumName);
//     newEnum->buildDecl();
//       addChild(newEnum);
//   }
// }

// void CSLdesign::addField() {
//   string fieldName = randString();
//   if( newNameIsValid(fieldName) ) {
//     CSLfieldPoint newField = new CSLfield (this, fieldName);
//     newField->buildDecl( (*this) );
//       addChild( newField);
//   }
// }

void CSLdesign::addIsaInstrFormat() {
  string name;
  name = randString();
    if (newNameIsValid(name) == true ) {
      m_names.push_back(name);
      CSLisaInstrFormat* isaInstrFormat = new CSLisaInstrFormat(name);
      isaInstrFormat->buildDecl(this);
      addChild(isaInstrFormat);
    }

}

//***build functions***
bool CSLdesign::buildDecl() {
  // addSignal();
  // addSignal();
  // addSignal();
  // 
  // addBitrange();
  // addBitrange();
  // addBitrange();
  // addBitrange();
  // 
  // addIfc();
  // addIfc();
  // addIfc();
  // addIfc();
  // addIfc();
  // 
  // addUnit();
  // addUnit();
  // addUnit();
  // addUnit();
//    addEnum();
//    addField();
	// TODO: FIXME DEP - 2010-01-15   addIsaInstrFormat();
}
}
