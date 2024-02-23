#include "csl_gen.h"
#include "cGenIsa_ao.h"

using namespace NSCSLinterconnect;


ostream* CSLbase::m_out = &cout;

string intToStr (const int& no){
  stringstream ss;
  ss << no;
  return ss.str();
}

CSLbase::CSLbase(ECSLtype type, CSLbasePoint parent, string name) :
  m_type(type),
  m_name(name),
  m_parent(parent)
  //  m_out(OUTPUT)
{}

CSLbase::~CSLbase() {
  CSLbaseVec ch = getChildren();
  for (CSLbaseVec_cIter itb = ch.begin(); itb != ch.end(); itb++) {
    delete (*itb);
  }       
}

CSLbasePoint CSLbase::getParent() const {
  return m_parent;
}

const string CSLbase::getName() const {
  return m_name;
}

const CSLbaseVec CSLbase::getChildren() const {
  return m_children;
}

const int CSLbase::getChildrenCount() const {
  return m_children.size();
}

CSLbasePoint CSLbase::getChildAt(int index) const {
  if ((index >= 0) && (index < getChildrenCount())) {
    return m_children.at(index);
  }
  else {
    return NULL;
  }
}

const ECSLtype CSLbase::getType() const {
  return m_type;
}

//***random select function***
// CSLscopedBasePoint CSLbase::randSelObj(ECSLtype type) {
//   string scope = "";
//   bool canAdd = true;
//   CSLbasePoint parent = this;
//   CSLbasePoint randObj = NULL;

//   while (parent != NULL) {
//     if ((parent->getType() == CSL_UNIT_INST) && (type != CSL_UNIT)) {
//       scope = addToScope(scope, parent->getName());
//       parent = (static_cast<CSLunitInstPoint>(parent))->getUnit();
//       canAdd = false;
//     }
//     else if (parent->getChildrenCount() > 0) {
//       if ((parent->getType() != CSL_DESIGN) && canAdd) {
//         scope = addToScope(scope, parent->getName());
//       }
//       else {
//         canAdd = true;
//       }

//       int maxPos = rand() % parent->getChildrenCount();
//       CSLbaseVec ch = parent->getChildren();
//       CSLbaseVec_cIter itb = ch.begin();

//       while ((maxPos > 0) && (itb != ch.end())) {
//         if ((*itb)->getType() == type) {
//           randObj = (*itb);
//         }
//         maxPos--;
//         itb++;
//       }

//       if ((randObj != NULL) && (rand() % 2)) {
//         return CSLscopedBasePoint(scope, randObj);
//       }
//       else if (rand() % 2) {
//         parent = parent->getChildAt(rand() % parent->getChildrenCount());
//       }
//       else {
//         scope = removeFromScope(scope);
//         parent = parent->getParent();
//       }
//     }
//     else {
//       scope = removeFromScope(scope);
//       parent = parent->getParent();
//     }
//   }
//   return CSLscopedBasePoint(scope, randObj);
// }

//scope functions
string CSLbase::addToScope(string scope, string toAdd) {
  return (scope + toAdd + ".");
}

string CSLbase::removeFromScope(string scope) {
  if (!scope.empty()) {
    int pos = scope.find_last_of(".") - 1;
    while ((pos > 0) && (scope.at(pos) != '.')) {
      pos--;
    }
    if (pos > 0) {
      return scope.substr(0, pos + 1);
    }
    else {
      return "";
    }
  }
  else return "";
}

bool CSLbase::newNameIsValid(string name) {
  for(int i=0; i<m_names.size();++i){
    if(m_names[i] == name){
      return false;
    }
  }
  return true;
}

//***add functions***
void CSLbase::addChild(CSLbasePoint child) {
  if (child != NULL) {
    m_children.push_back(child);
  }
  else {
    cerr << "no child\n";
  }
}

CSLdesign::CSLdesign(string name) :
  CSLbase(CSL_DESIGN, NULL, name) {}

CSLdesign::~CSLdesign() {}


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

/*
void CSLdesign::addIsaInstrFormat() {
  string name;
  name = randString();
    if (newNameIsValid(name) == true ) {
      m_names.push_back(name);
      CSLisaInstrFormat* isaInstrFormat = new CSLisaInstrFormat(name);
      isaInstrFormat.buildDecl(this);
    }
    addChild(isaInstrFormat);
}
*/

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
// TODO: FIXME DEP - 2010-01-15  addIsaInstrFormat();
}

