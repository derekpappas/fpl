// Copyright (c) 2005, 2006, 2007 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

#include "cslInterconnectGen_TB.h"

using namespace NSCSLinterconnect;

///////////////////
// class CSLbase //==============================================
///////////////////
//***constructor***
CSLbase::CSLbase(ECSLtype type, CSLbasePoint parent, string name, ostream& output) :
  m_type(type),
  m_name(name),
  m_parent(parent),
  m_out(&output) {}

CSLbase::CSLbase(ECSLtype type, CSLbasePoint parent, string name) :
  m_type(type),
  m_name(name),
  m_parent(parent) {
  if (parent) {
    m_out = parent->m_out;
  }
}

//***destructor***
CSLbase::~CSLbase() {
  CSLbaseVec ch = getChildren();
  CSLbaseVec_cIter itb = ch.begin();
  for (; itb < ch.end(); ++itb) {
    delete (*itb);
  }
}

//***get funstions***
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

//***random string generator***
string CSLbase::randString() {
  char *str = new char[NAMES_SIZE+1];
  for (int i = 0; i < NAMES_SIZE-1; i++) {
    str[i] = rand() % ('z' - 'a') + 'a';
  }
  str[NAMES_SIZE-1]= '1';
  str[NAMES_SIZE]='\0';

  string bla = string(str);
  delete []str;
  return bla;
}

//***random select function***
CSLscopedBasePoint CSLbase::randSelObj(ECSLtype type) {
  string scope = "";
  bool canAdd = true;
  CSLbasePoint parent = this;
  CSLbasePoint randObj = NULL;

  while (parent != NULL) {
    if ((parent->getType() == CSL_UNIT_INST) && (type != CSL_UNIT)) {
      scope = addToScope(scope, parent->getName());
      parent = (static_cast<CSLunitInstPoint>(parent))->getUnit();
      canAdd = false;
    }
    else if (parent->getChildrenCount() > 0) {
      if ((parent->getType() != CSL_DESIGN) && canAdd) {
        scope = addToScope(scope, parent->getName());
      }
      else {
        canAdd = true;
      }

      int maxPos = rand() % parent->getChildrenCount();
      CSLbaseVec ch = parent->getChildren();
      CSLbaseVec_cIter itb = ch.begin();

      while ((maxPos > 0) && (itb != ch.end())) {
        if ((*itb)->getType() == type) {
          randObj = (*itb);
        }
        maxPos--;
        itb++;
      }

      if ((randObj != NULL) && (rand() % 2)) {
        if (type != randObj->getType()) {
          cout << "needed " << type << " got " << randObj->getType() << endl;
        }
        if(  randObj != NULL && type != randObj->getType() )
          cerr << "BUBU 1\n";
        return CSLscopedBasePoint(scope, randObj);
      }
      else if (rand() % 2) {
        parent = parent->getChildAt(rand() % parent->getChildrenCount());
      }
      else {
        scope = removeFromScope(scope);
        parent = parent->getParent();
      }
    }
    else {
      scope = removeFromScope(scope);
      parent = parent->getParent();
    }
  }
        if( randObj != NULL && type != randObj->getType() )
          cerr << "BUBU2\n";

  return CSLscopedBasePoint(scope, randObj);
  if (randObj != NULL && type != randObj->getType()) {
    cout << "needed " << type << " got " << randObj->getType() << endl;
  }
        if(  randObj != NULL && type != randObj->getType() )
          cerr << "BUBU3\n";
  return CSLscopedBasePoint(scope, randObj);
}

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

//***check functions***
bool CSLbase::newNameIsValid(string name) {
  CSLbaseVec ch;
  CSLbasePoint parent = this;
  while (parent != NULL) {
    ch = parent->getChildren();
    for (CSLbaseVec_cIter itb = ch.begin(); itb != ch.end(); itb++) {
      if ((*itb)->getName() == name) {
        return false;
      }
      if ((*itb)->getType() == CSL_ENUM) {
        CSLbaseVec en = (*itb)->getChildren();
        for (CSLbaseVec_cIter ite = en.begin(); ite != en.end(); ite++) {
          if ((*ite)->getName() == name) {
            return false;
          }
        }
      }
    }
    parent = parent->getParent();
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
//===============================================================

/////////////////////
// class CSLdesign //============================================
/////////////////////
//***constructor***
CSLdesign::CSLdesign(ostream& output, string name) :
  CSLbase(CSL_DESIGN, NULL, name, output) {}

//***destructor***
CSLdesign::~CSLdesign() {}

//***add functions***


void CSLdesign::addBitrange() {
  string brName = randString();
  if (newNameIsValid(brName)) {
    CSLbasePoint newBr = new CSLbitrange(this, brName);
    if (newBr->buildDecl()) {
      addChild(newBr);
    }
    else {
      delete newBr;
    }
  }
}

void CSLdesign::addSignal() {
  string sigName = randString();
  if (newNameIsValid(sigName)) {
    CSLsignalPoint newSig = new CSLsignal(this, sigName);
    if (newSig->buildDecl()) {
      addChild(newSig);
    }
    else {
      delete newSig;
    }
  }
}

void CSLdesign::addIfc() {
  string ifcName = randString();
  if (newNameIsValid(ifcName)) {
    CSLifcPoint newIfc = new CSLifc(this, ifcName);
    if (newIfc->buildDecl()) {
      addChild(newIfc);
    }
    else {
      delete newIfc;
    }
  }
}

void CSLdesign::addUnit() {
  string unitName = randString();
  if (newNameIsValid(unitName)) {
    CSLunitPoint newUnit = new CSLunit(this, unitName);
    if (newUnit->buildDecl()) {
      addChild(newUnit);
    }
    else {
      delete newUnit;
    }
  }
}

//***build functions***
bool CSLdesign::buildDecl() {

   addSignal();
   addSignal();
   addSignal();

   addBitrange();
   addBitrange();
   addBitrange();
   addBitrange();

   addIfc();
   addIfc();
   addIfc();
   addIfc();
   addIfc();


   addEnum();
   addEnum();
   addEnum();

   addField();
   addField();
   addField();
   addField();
   addField();
   addField();
   addField();

   addRegister();
   addRegister();
   addRegister();
   addRegisterFile();
   addRegisterFile();

   addIsaField();
   addIsaField();
   addIsaField();
   addIsaField();

   addIsaElement();
   addIsaElement();
   addIsaElement();
   addIsaElement();

   addFifo();
   addFifo();
   addFifo();

   addUnit();
   addUnit();
   addUnit();
   addUnit();


   addMemMapPage();
   addMemMapPage();
   addMemMapPage();
   addMemory();
   addMemory();
   addMemory();
   addMemMap();
 
  return true;
}

void CSLdesign::print() {
  (*m_out) << "//Automatically generated by cGen_ao.cpp\n";
  (*m_out) << "//DO NOT MODIFY!\n";
  (*m_out) << "//Legal test case \n";
  CSLbaseVec ch = getChildren();
  for (CSLbaseVec_cIter it = ch.begin(); it != ch.end(); it++) {
    (*it) -> print();
    (*m_out) << endl;
  }
}

//===============================================================

//////////////////
// class CSLifc //===============================================
//////////////////
//***constructor***
CSLifc::CSLifc(CSLbasePoint parent, string name) :
  CSLbase(CSL_IFC, parent, name) {}

//***destructor***
CSLifc::~CSLifc() {}

//***add functions***
void CSLifc::addIfcInst() {
  string ifcInstName = randString();
  if (newNameIsValid(ifcInstName)) {
    CSLifcInstPoint newIfcInst = new CSLifcInst(this, ifcInstName);
    if (newIfcInst->buildDecl()) {
      addChild(newIfcInst);
    }
    else {
      delete newIfcInst;
    }
  }
}

void CSLifc::addPort() {
  string portName = randString();
  if (newNameIsValid(portName)) {
    CSLportPoint newPort = new CSLport(this, portName);
    if (newPort->buildDecl()) {
      addChild(newPort);
    }
    else {
      delete newPort;
    }
  }
}

//***build functions***
bool CSLifc::buildDecl() {
  addIfcInst();
  addIfcInst();
  addIfcInst();
  addIfcInst();

  addPort();
  addPort();
  addPort();
  addPort();

  return true;
}

//***print functions***
void CSLifc::print() {
  declSHbegin(m_out, "csl_interface", getName());

  CSLbaseVec ch = getChildren();
  for (CSLbaseVec_cIter it = ch.begin(); it != ch.end(); it++) {
    (*it)->print();
  }

  declSHend(m_out);
}
//===============================================================

///////////////////
// class CSLunit //==============================================
///////////////////
//***constructor***
CSLunit::CSLunit(CSLbasePoint parent, string name) :
  CSLbase(CSL_UNIT, parent, name) {}

//***destructor***
CSLunit::~CSLunit() {}

//***build functions***
bool CSLunit::buildDecl() {
  addUnitInst();
  addUnitInst();
  addUnitInst();
  addUnitInst();
  addUnitInst();

  addBitrange();
  addBitrange();
  addBitrange();
  addBitrange();
  addBitrange();
  addBitrange();

  addSignal();
  addSignal();
  addSignal();
  addSignal();

  addPort();
  addPort();
  addPort();
  addPort();
  addPort();
  addPort();

  addIfcInst();
  addIfcInst();
  addIfcInst();
  addIfcInst();
  addIfcInst();

  addFifoInst();// instantiate all fifos
  addRegFileInst();// instantiate all register files

  return true;
}

//***random select functions***
CSLscopedPortPoint CSLunit::randSelPort() {
  CSLscopedBasePoint randObj = randSelObj(CSL_PORT);
  CSLscopedPortPoint ret = CSLscopedPortPoint(randObj.first, static_cast<CSLportPoint>(randObj.second));
  return ret;
}

CSLscopedSignalPoint CSLunit::randSelSignal() {
  CSLscopedBasePoint randObj = randSelObj(CSL_SIGNAL);
  CSLscopedSignalPoint ret = CSLscopedSignalPoint(randObj.first, static_cast<CSLsignalPoint>(randObj.second));
  return ret;
}

CSLscopedBitrangePoint CSLunit::randSelBitrange() {
  CSLscopedBasePoint randObj = randSelObj(CSL_BITRANGE);
  CSLscopedBitrangePoint ret = CSLscopedBitrangePoint(randObj.first, static_cast<CSLbitrangePoint>(randObj.second));
  return ret;
}

//***add functions***
void CSLunit::addIfcInst() {
  string ifcInstName = randString();
  if (newNameIsValid(ifcInstName)) {
    CSLifcInstPoint newIfcInst = new CSLifcInst(this, ifcInstName);
    if (newIfcInst->buildDecl()) {
      addChild(newIfcInst);
    }
    else {
      delete newIfcInst;
    }
  }
}

void CSLunit::addUnitInst() {
  string unitInstName = randString();
  if (newNameIsValid(unitInstName)) {
    CSLunitInstPoint newUnitInst = new CSLunitInst(this, unitInstName);
    if (newUnitInst->buildDecl()) {
      addChild(newUnitInst);
    }
    else {
      delete newUnitInst;
    }
  }
}

void CSLunit::addBitrange() {
  string brName = randString();
  if (newNameIsValid(brName)) {
    CSLbitrangePoint newBr = new CSLbitrange(this, brName);
    if (newBr->buildDecl()) {
      addChild(newBr);
    }
    else {
      delete newBr;
    }
  }
}

void CSLunit::addSignal() {
  string sigName = randString();
  if (newNameIsValid(sigName)) {
    CSLsignalPoint newSig = new CSLsignal(this, sigName);
    if (newSig->buildDecl()) {
      addChild(newSig);
    }
    else {
      delete newSig;
    }
  }
}

void CSLunit::addPort() {
  string portName = randString();
  if (newNameIsValid(portName)) {
    CSLportPoint newPort = new CSLport(this, portName);
    if (newPort->buildDecl()) {
      addChild(newPort);
    }
    else {
      delete newPort;
    }
  }
}

//***modif functions***
void CSLunit::modifPort() {
  CSLscopedPortPoint port = randSelPort();
  if (port.second != NULL) {
    port.second->buildSet(port.first);
  }
}

void CSLunit::modifSignal() {
  CSLscopedSignalPoint sig = randSelSignal();
  if (sig.second != NULL) {
    sig.second->buildSet(sig.first);
  }
}

void CSLunit::modifBitrange() {
  CSLscopedBitrangePoint bitr = randSelBitrange();
  if (bitr.second != NULL) {
    bitr.second->buildSet(bitr.first);
  }
}

//***print functions***
void CSLunit::print() {
   declSHbegin(m_out, "csl_unit", getName());

  CSLbaseVec ch = getChildren();
  for (CSLbaseVec_cIter it = ch.begin(); it != ch.end(); it++) {
    (*it)->print();
  }

  constrSHbegin(m_out, getName());
//   modifPort();
//   modifPort();
//   modifPort();
//   modifPort();
//   modifPort();
//   modifPort();

//   modifSignal();
//   modifSignal();
//   modifSignal();
//   modifSignal();
//   modifSignal();
//   modifSignal();

//   modifBitrange();
//   modifBitrange();
//   modifBitrange();
//   modifBitrange();
//   modifBitrange();
//   modifBitrange();
  constrSHend(m_out);

  declSHend(m_out);
}
//===============================================================

///////////////////////
// class CSLunitInst //==========================================
///////////////////////
//***constructor***
CSLunitInst::CSLunitInst(CSLbasePoint parent, string name) :
  CSLbase(CSL_UNIT_INST, parent, name) {}

//***destructor***
CSLunitInst::~CSLunitInst() {}

//***get functions***
const CSLunitPoint CSLunitInst::getUnit() const {
  return m_instUnit;
}

//***random select functions***
CSLscopedUnitPoint CSLunitInst::randSelUnit() {
  CSLscopedBasePoint randObj = randSelObj(CSL_UNIT);
  CSLscopedUnitPoint ret = CSLscopedUnitPoint(randObj.first, static_cast<CSLunitPoint>(randObj.second));
  return ret;
}

//***build functions***
bool CSLunitInst::buildDecl() {
  CSLscopedUnitPoint unit = randSelUnit();
  if ((unit.second != NULL) && (getName() != unit.second->getName())) {
    m_instUnit = unit.second;
    return true;
  }
  else {
    return false;
  }
}

//***print functions***
void CSLunitInst::print() {
  decl0param(m_out, m_instUnit->getName(), getName());
}
//===============================================================

//////////////////////
// class CSLifcInst //===========================================
//////////////////////
//***constructor***
CSLifcInst::CSLifcInst(CSLbasePoint parent, string name) :
  CSLbase(CSL_IFC_INST, parent, name) {}

//***destructor***
CSLifcInst::~CSLifcInst() {}

//***get functions***
const CSLifcPoint CSLifcInst::getIfcType() const {
  return m_instType;
}

//***random select functions***
CSLscopedIfcPoint CSLifcInst::randSelIfc() {
  CSLscopedBasePoint randObj = randSelObj(CSL_IFC);
  CSLscopedIfcPoint ret = CSLscopedIfcPoint(randObj.first, static_cast<CSLifcPoint>(randObj.second));
  return ret;
}

//***build functions***
bool CSLifcInst::buildDecl() {
  CSLscopedIfcPoint ifc = randSelIfc();
  if ((ifc.second != NULL) && (getName() != ifc.second->getName())) {
    m_instType = ifc.second;
    return true;
  }
  else {
    return false;
  }
}

//***print functions***
void CSLifcInst::print() {
  decl0param(m_out, m_instType->getName(), getName());
}
//===============================================================

//////////////////////
//class CSLinstance //===========================================
//////////////////////
//***constructor***
CSLinstance::CSLinstance(CSLbasePoint parent, CSLbasePoint instantiatedObj, string name) :
  CSLbase(CSL_INSTANCE, parent, name),
  m_instObj(instantiatedObj) {}

//***destructor***
CSLinstance::~CSLinstance() {}

//***get functions***
const CSLbasePoint CSLinstance::getInstantiatedObj() const {
  return m_instObj;
}

//***build functions***
bool CSLinstance::buildDecl() {}

//***print functions***
void CSLinstance::print() {
  decl0param(m_out, m_instObj->getName(), getName());
}
//===============================================================

//////////////////
//class CSLport /================================================
//////////////////
//***constructor***
CSLport::CSLport(CSLbasePoint parent, string name) :
  CSLbase(CSL_PORT, parent, name),
  m_prtBitr(new CSLbitrange(this, name + "_defaultBitrange")) {}

//***destructor***
CSLport::~CSLport() {
  delete m_prtBitr;
}

//***get functions***
const string CSLport::getPortType() const {
  return m_prtType;
}

const string CSLport::getDir() const {
  return m_prtDir;
}

const short CSLport::getLower() const {
  return m_prtBitr->getLower();
}

const short CSLport::getUpper() const {
  return m_prtBitr->getUpper();
}

const short CSLport::getWidth() const {
  return m_prtBitr->getWidth();
}

const short CSLport::getOffset() const {
  return m_prtBitr->getOffset();
}

const CSLbitrangePoint CSLport::getBitrange() const {
  return m_prtBitr;
}

//***set functions***
bool CSLport::setPortType(string type) {
  m_prtType = type;
}

bool CSLport::setDir(string dir) {
  m_prtDir = dir;
}

bool CSLport::setWidth(short width) {
  return m_prtBitr->setWidth(width);
}

bool CSLport::setOffset(short offset) {
  return m_prtBitr->setOffset(offset);
}

bool CSLport::setRange(short lower, short upper) {
  return m_prtBitr->setRange(lower, upper);
}

//***copy functions***
void CSLport::copyBitrange(const CSLbitrangePoint br) {
  m_prtBitr->copyBitrange(br);
}

void CSLport::copySignal(const CSLsignalPoint sig) {
  setPortType(sig->getSigType());
  copyBitrange(sig->getBitrange());
}

void CSLport::copyPort(const CSLportPoint prt) {
  setDir(prt->getDir());
  setPortType(prt->getPortType());
  copyBitrange(prt->getBitrange());
}

//***check functions***
bool CSLport::isPortDeclValid() {
  if (((m_prtDir != "output") && (m_prtType == "reg")) ||
      (m_prtType == "integer") ||
      (m_prtType == "real") ||
      (m_prtType == "realtime") ||
      (m_prtType == "time")) {
    return false;
  }
  else {
    return true;
  }
}

//***build functions***
bool CSLport::buildDecl() {
  m_declForm = static_cast<ECSLportDecl>(rand() % CSL_PORT_DECL_MAX);

  if (m_declForm == CSL_PORT_DECL_EMPTY) {//csl_port name(direction);
    setDir(portDirections[rand() % DIR_VEC_SIZE]);
    return true;
  }
  else if (m_declForm == CSL_PORT_DECL_TYPE) {//csl_port name(direction, type);
    setDir(portDirections[rand() % DIR_VEC_SIZE]);
    setPortType(sig_portTypes[rand() % TYPE_VEC_SIZE]);
    if (isPortDeclValid()) {
      return true;
    }
    else {
      return false;
    }
  }
  else if (m_declForm == CSL_PORT_DECL_WIDTH) {//csl_port name(direction, width);
    setWidth(rand() % (MAX_WIDTH - 1) + 1);
    setDir(portDirections[rand() % DIR_VEC_SIZE]);
    return true;
  }
  else if (m_declForm == CSL_PORT_DECL_TYPE_WIDTH) {//csl_port name(direction, type, width);
    setWidth(rand() % (MAX_WIDTH - 1) + 1);
    setDir(portDirections[rand() % DIR_VEC_SIZE]);
    setPortType(sig_portTypes[rand() % TYPE_VEC_SIZE]);
    if (isPortDeclValid()) {
      return true;
    }
    else {
      return false;
    }
  }
  else if (m_declForm == CSL_PORT_DECL_BITRANGE) {//csl_port name(direction, bitrange);
    CSLscopedBitrangePoint br = randSelBitrange();
    if (br.second != NULL) {
      copyBitrange(br.second);
      setDir(portDirections[rand() % DIR_VEC_SIZE]);
      m_bitrCopy = br.first;
      m_bitrCopy.append(br.second->getName());
      return true;
    }
    else {
      return false;
    }
  }
  else if (m_declForm == CSL_PORT_DECL_TYPE_BITRANGE) {//csl_port name(direction, type, bitrange);
    CSLscopedBitrangePoint br = randSelBitrange();
    if (br.second != NULL) {
      copyBitrange(br.second);
      setDir(portDirections[rand() % DIR_VEC_SIZE]);
      setPortType(sig_portTypes[rand() % TYPE_VEC_SIZE]);
      if (isPortDeclValid()) {
        m_bitrCopy = br.first;
        m_bitrCopy.append(br.second->getName());
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }
  else if (m_declForm == CSL_PORT_DECL_COPY) {
    return false;
  }
  else {
    return false;
  }
}

void CSLport::buildSet(string scope) {
  short form = rand() % CSL_PORT_MODIF_MAX;

  if (form == CSL_PORT_MODIF_RANGE) {//name.set_range(lower, upper);
    short low = rand() % (MAX_WIDTH / 2);
    short up = low + rand() % (MAX_WIDTH / 2) + 1;
    if (setRange(low, up)) {
      call2param(m_out, scope, getName(), "set_range", IntToString(getLower()), IntToString(getUpper()));
    }
  }
  else if (form == CSL_PORT_MODIF_WIDTH) {//name.set_width(width);
    short width = rand() % MAX_WIDTH + 1;
    if (setWidth(width)) {
      call1param(m_out, scope, getName(), "set_width", IntToString(getWidth()));
    }
  }
  else if (form == CSL_PORT_MODIF_OFFSET) {//name.set_offset(offset);
    short offset = rand() % MAX_OFFSET;
    if (setOffset(offset)) {
      call1param(m_out, scope, getName(), "set_offset", IntToString(getOffset()));
    }
  }
}

//***random select functions***
CSLscopedBitrangePoint CSLport::randSelBitrange() {
  CSLscopedBasePoint randObj = randSelObj(CSL_BITRANGE);
  CSLscopedBitrangePoint ret = CSLscopedBitrangePoint(randObj.first, static_cast<CSLbitrangePoint>(randObj.second));
  return ret;
}

//***print functions***
void CSLport::print() {
  if (m_declForm == CSL_PORT_DECL_EMPTY) {//csl_port name(direction);
    decl1param(m_out, "csl_port", getName(), getDir());
  }
  else if (m_declForm == CSL_PORT_DECL_TYPE) {//csl_port name(direction, type);
    decl2param(m_out, "csl_port", getName(), getDir(), getPortType());
  }
  else if (m_declForm == CSL_PORT_DECL_WIDTH) {//csl_port name(direction, width);
    decl2param(m_out, "csl_port", getName(), getDir(), IntToString(getWidth()));
  }
  else if (m_declForm == CSL_PORT_DECL_TYPE_WIDTH) {//csl_port name(direction, type, width);
    decl3param(m_out, "csl_port", getName(), getDir(), getPortType(), IntToString(getWidth()));
  }
  else if (m_declForm == CSL_PORT_DECL_BITRANGE) {//csl_port name(direction, bitrange);
    decl2param(m_out, "csl_port", getName(), getDir(), m_bitrCopy);
  }
  else if (m_declForm == CSL_PORT_DECL_TYPE_BITRANGE) {//csl_port name(direction, type, bitrange);
    decl3param(m_out, "csl_port", getName(), getDir(), getPortType(), m_bitrCopy);
  }
  else if (m_declForm == CSL_PORT_DECL_COPY) {
  }
}
//===============================================================

////////////////////
//class CSLsignal //=============================================
////////////////////
//***constructor***
CSLsignal::CSLsignal(CSLbasePoint parent, string name) :
  CSLbase(CSL_SIGNAL, parent, name),
  m_sigBitr(new CSLbitrange(this, name + "_defaultBitrange")) {}

//***destructor***
CSLsignal::~CSLsignal() {
  delete m_sigBitr;
}

//***get functions***
const string CSLsignal::getSigType() const {
  return m_sigType;
}

const short CSLsignal::getLower() const {
  return m_sigBitr->getLower();
}

const short CSLsignal::getUpper() const {
  return m_sigBitr->getUpper();
}

const short CSLsignal::getWidth() const {
  return m_sigBitr->getWidth();
}

const short CSLsignal::getOffset() const {
  return m_sigBitr->getOffset();
}

const CSLbitrangePoint CSLsignal::getBitrange() const {
  return m_sigBitr;
}

//***set functions***
bool CSLsignal::setSigType(string type) {
  m_sigType = type;
}

bool CSLsignal::setWidth(short width) {
  return m_sigBitr->setWidth(width);
}

bool CSLsignal::setOffset(short offset) {
  return m_sigBitr->setOffset(offset);
}

bool CSLsignal::setRange(short lower, short upper) {
  return m_sigBitr->setRange(lower, upper);
}

//***copy functions***
void CSLsignal::copyBitrange(const CSLbitrangePoint br) {
  m_sigBitr->copyBitrange(br);
}

void CSLsignal::copySignal(const CSLsignalPoint sig) {
  setSigType(sig->getSigType());
  copyBitrange(sig->getBitrange());
}

//***build functions***
bool CSLsignal::buildDecl() {
  m_declForm = static_cast<ECSLsigDecl>(rand() % CSL_SIG_DECL_MAX);

  if (m_declForm == CSL_SIG_DECL_EMPTY) {//csl_signal name();
    return true;
  }
  else if (m_declForm == CSL_SIG_DECL_TYPE) {//csl_signal name(type);
    setSigType(sig_portTypes[rand() % TYPE_VEC_SIZE]);
    return true;
  }
  else if (m_declForm == CSL_SIG_DECL_WIDTH) {//csl_signal name(width);
    setWidth(rand() % (MAX_WIDTH - 1) + 1);
    return true;
  }
  else if (m_declForm == CSL_SIG_DECL_TYPE_WIDTH) {//csl_signal name(type, width);
    setWidth(rand() % (MAX_WIDTH - 1) + 1);
    setSigType(sig_portTypes[rand() % TYPE_VEC_SIZE]);
    return true;
  }
  else if (m_declForm == CSL_SIG_DECL_LOWER_UPPER) {//csl_signal name(lower, upper);
    short low = rand() % (MAX_WIDTH / 2);
    short up = low + rand() % (MAX_WIDTH / 2) + 1;
    setRange(low, up);
    return true;
  }
  else if (m_declForm == CSL_SIG_DECL_TYPE_LOWER_UPPER) {//csl_signal name(type, lower, upper);
    short low = rand() % (MAX_WIDTH / 2);
    short up = low + rand() % (MAX_WIDTH / 2) + 1;
    setRange(low, up);
    setSigType(sig_portTypes[rand() % TYPE_VEC_SIZE]);
    return true;
  }
  else if (m_declForm == CSL_SIG_DECL_BITRANGE) {//csl_signal name(bitrange);
    CSLscopedBitrangePoint br = randSelBitrange();
    if (br.second != NULL) {
      copyBitrange(br.second);
      m_bitrCopy = br.first;
      m_bitrCopy.append(br.second->getName());
      return true;
    }
    else {
      return false;
    }
  }
  else if (m_declForm == CSL_SIG_DECL_TYPE_BITRANGE) {//csl_signal name(type, bitrange);
    CSLscopedBitrangePoint br = randSelBitrange();
    if (br.second != NULL) {
      setSigType(sig_portTypes[rand() % TYPE_VEC_SIZE]);
      copyBitrange(br.second);
      m_bitrCopy = br.first;
      m_bitrCopy.append(br.second->getName());
      return true;
    }
    else {
      return false;
    }
  }
  else if (m_declForm == CSL_SIG_DECL_COPY) {//csl_signal name(sig);
    CSLscopedSignalPoint sig = randSelSignal();
    if (sig.second != NULL) {
      copySignal(sig.second);
      m_sigCopy = sig.first;
      m_sigCopy.append(sig.second->getName());
      return true;
    }
    else {
      return false;
    }
  }
  else {
    return false;
  }
}

void CSLsignal::buildSet(string scope) {
  short form = rand() % CSL_SIG_MODIF_MAX;

  if (form == CSL_SIG_MODIF_RANGE) {//name.set_range(lower, upper);
    short low = rand() % (MAX_WIDTH / 2);
    short up = low + rand() % (MAX_WIDTH / 2) + 1;
    if (setRange(low, up)) {
      call2param(m_out, scope, getName(), "set_range", IntToString(getLower()), IntToString(getUpper()));
    }
  }
  else if (form == CSL_SIG_MODIF_WIDTH) {//name.set_width(width);
    short width = rand() % MAX_WIDTH + 1;
    if (setWidth(width)) {
      call1param(m_out, scope, getName(), "set_width", IntToString(getWidth()));
    }
  }
  else if (form == CSL_SIG_MODIF_OFFSET) {//name.set_offset(offset);
    short offset = rand() % MAX_OFFSET;
    if (setOffset(offset)) {
      call1param(m_out, scope, getName(), "set_offset", IntToString(getOffset()));
    }
  }
}

//***random select functions***
CSLscopedBitrangePoint CSLsignal::randSelBitrange() {
  CSLscopedBasePoint randObj = randSelObj(CSL_BITRANGE);
  CSLscopedBitrangePoint ret = CSLscopedBitrangePoint(randObj.first, static_cast<CSLbitrangePoint>(randObj.second));
  return ret;
}

CSLscopedSignalPoint CSLsignal::randSelSignal() {
  CSLscopedBasePoint randObj = randSelObj(CSL_SIGNAL);
  CSLscopedSignalPoint ret = CSLscopedSignalPoint(randObj.first, static_cast<CSLsignalPoint>(randObj.second));
  return ret;
}

//***print functions***
void CSLsignal::print() {
  if (m_declForm == CSL_SIG_DECL_EMPTY) {//csl_signal name();
    decl0param(m_out, "csl_signal", getName());
  }
  else if (m_declForm == CSL_SIG_DECL_TYPE) {//csl_signal name(type);
    decl1param(m_out, "csl_signal", getName(), getSigType());
  }
  else if (m_declForm == CSL_SIG_DECL_WIDTH) {//csl_signal name(width);
    decl1param(m_out, "csl_signal", getName(), IntToString(getWidth()));
  }
  else if (m_declForm == CSL_SIG_DECL_TYPE_WIDTH) {//csl_signal name(type, width);
    decl2param(m_out, "csl_signal", getName(), getSigType(), IntToString(getWidth()));
  }
  else if (m_declForm == CSL_SIG_DECL_LOWER_UPPER) {//csl_signal name(lower, upper);
    decl2param(m_out, "csl_signal", getName(), IntToString(getLower()), IntToString(getUpper()));
  }
  else if (m_declForm == CSL_SIG_DECL_TYPE_LOWER_UPPER) {//csl_signal name(type, lower, upper);
    decl3param(m_out, "csl_signal", getName(), getSigType(), IntToString(getLower()), IntToString(getUpper()));
  }
  else if (m_declForm == CSL_SIG_DECL_BITRANGE) {//csl_signal name(bitrange);
    decl1param(m_out, "csl_signal", getName(), m_bitrCopy);
  }
  else if (m_declForm == CSL_SIG_DECL_TYPE_BITRANGE) {//csl_signal name(type, bitrange);
    decl2param(m_out, "csl_signal", getName(), getSigType(), m_bitrCopy);
  }
  else if (m_declForm == CSL_SIG_DECL_COPY) {//csl_signal name(sig);
    decl1param(m_out, "csl_signal", getName(), m_sigCopy);
  }
}
//===============================================================

///////////////////////
// class CSLbitrange //==========================================
///////////////////////
//***constructor***
CSLbitrange::CSLbitrange(CSLbasePoint parent, string name) :
  CSLbase(CSL_BITRANGE, parent, name),
  m_brLower(0),
  m_brUpper(1),
  m_brOffset(0),
  m_brWidthIsSet(false) {}

//***destructor***
CSLbitrange::~CSLbitrange() {}

//***get functions***
const short CSLbitrange::getLower() const {
  return m_brLower;
}

const short CSLbitrange::getUpper() const {
  return m_brUpper;
}

const short CSLbitrange::getWidth() const {
  return (m_brUpper - m_brLower);
}

const short CSLbitrange::getOffset() const {
  return m_brOffset;
}

const bool CSLbitrange::isWidthSet() const {
  return m_brWidthIsSet;
}

//***set functions***
bool CSLbitrange::setWidth(short width) {
  if ((!isWidthSet()) &&
      (width > 0)) {
    m_brUpper = m_brLower + width;
    m_brWidthIsSet = true;
    return true;
  }
  else {
    return false;
  }
}

bool CSLbitrange::setOffset(short offset) {
  if (offset >= 0) {
    m_brLower += offset;
    m_brUpper += offset;
    m_brOffset = offset;
    return true;
  }
  else {
    return false;
  }
}

bool CSLbitrange::setRange(short lower, short upper) {
  if ((!isWidthSet()) &&
      (lower >= 0)     &&
      (upper > lower)) {
    m_brLower = lower;
    m_brUpper = upper;
    m_brWidthIsSet = true;
    return true;
  }
  else {
    return false;
  }
}

//***copy functions***
void CSLbitrange::copyBitrange(const CSLbitrangePoint br) {
  m_brLower = br->getLower();
  m_brUpper = br->getUpper();
  m_brOffset = br->getOffset();
  m_brWidthIsSet = br->isWidthSet();
}

//***build functions***
bool CSLbitrange::buildDecl() {
  m_declForm = static_cast<ECSLbitrDecl>(rand() % CSL_BITR_DECL_MAX);

  if (m_declForm == CSL_BITR_DECL_WIDTH) {//csl_bitrange name(width);
    setWidth(rand() % (MAX_WIDTH - 1) + 1);
    return true;
  }
  else if (m_declForm == CSL_BITR_DECL_LOWER_UPPER) {//csl_bitrange name(lower, upper);
    short low = rand() % (MAX_WIDTH / 2);
    short up  = low + rand() % (MAX_WIDTH / 2) + 1;
    setRange(low, up);
    return true;
  }
  else {
    return false;
  }
}

void CSLbitrange::buildSet(string scope) {
  short form = rand() % CSL_BITR_MODIF_MAX;

  if (form == CSL_BITR_MODIF_OFFSET) {//name.set_offset(offset);
    short offset = rand() % MAX_OFFSET;
    if (setOffset(offset)) {
      call1param(m_out, scope, getName(), "set_offset", IntToString(getOffset()));
    }
  }
}

//***print functions***
void CSLbitrange::print() {
  if (m_declForm == CSL_BITR_DECL_WIDTH) {//csl_bitrange name(width);
    decl1param(m_out, "csl_bitrange", getName(), IntToString(getWidth()));
  }
  else if (m_declForm == CSL_BITR_DECL_LOWER_UPPER) {//csl_bitrange name(lower, upper);
    decl2param(m_out, "csl_bitrange", getName(), IntToString(getLower()), IntToString(getUpper()));
  }
}
//==============================================================

