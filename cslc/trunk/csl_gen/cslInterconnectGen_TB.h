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


////////////////////////////////////////////////////////////////////
//TODO: -replace all pointers with RefCount objects               //
////////////////////////////////////////////////////////////////////

#ifndef _CSL_INTERCONNECT_GEN_H_
#define _CSL_INTERCONNECT_GEN_H_


#include <map>
#include <stack>
#include <fstream>
#include <algorithm>

#include <vector>
#include <iostream>
#include "../support/CommonSupport.h"
#include <sstream>
#include "support.h"
using namespace std;

namespace NSCSLinterconnect {

//--------------------CONSTS--------------------//
const short TYPE_VEC_SIZE        = 16;
const short DIR_VEC_SIZE         = 3;
const short NAMES_SIZE           = 5;
const short MAX_WIDTH            = 16;
const short MAX_OFFSET           = 16;
const short MAX_FIELD_WIDTH      = 100;
//const short FIELD_INSTANCE_NO    = 20;  

const string sig_portTypes[TYPE_VEC_SIZE] = {"trireg",
                                             "tri",
                                             "wire",
                                             "wor",
                                             "wand",
                                             "trior",
                                             "tri0",
                                             "tri1",
                                             "triand",
                                             "supply0",
                                             "supply1",
                                             "reg",
                                             "integer",
                                             "time",
                                             "real",
                                             "realtime"};

const string portDirections[DIR_VEC_SIZE] = {"input",
                                             "output",
                                             "inout"};

//--------------------CONSTS--------------------//

//--------------------CLASSES--------------------//
class CSLbase;
class CSLdesign;
class CSLifc;
class CSLunit;
class CSLunitInst;
class CSLifcInst;
class CSLport;
class CSLsignal;
class CSLbitrange;
class CSLenum;
class CSLenumItem;
class CSLfield;
class CSLfieldInst;
class CSLfifo;
class CSLisa;
class CSLisaInstr;
class CSLisaInstrFormat;
class CSLregister;
class CSLregisterFile;
//--------------------CLASSES--------------------//

//--------------------TYPEDEFS--------------------//
typedef enum _ECSLtype {
  CSL_DESIGN,
  CSL_IFC,
  CSL_UNIT,
  CSL_UNIT_INST,
  CSL_IFC_INST,
  CSL_INSTANCE,
  CSL_PORT,
  CSL_SIGNAL,
  CSL_BITRANGE,
  CSL_ISA_FIELD,
  CSL_ISA_ELEMENT,
  CSL_FIFO,
  CSL_MEM_MAP_PAGE,
  CSL_MEM_MAP,
  CSL_ENUM,
  CSL_ENUM_ITEM,
  CSL_FIELD,
  CSL_FIELD_INST,
  CSL_REG,
  CSL_REG_FILE,
  CSL_MEMORY
} ECSLtype;

// typedef enum _ECSLfieldDecl {
//   CSL_FIELD_EMPTY,
//   CSL_FIELD_WIDTH,
//   CSL_FIELD_WIDTH_E,
//   CSL_FIELD_WIDTH_EI,
//   CSL_FIELD_LOWER_UPPER,
//   CSL_FIELD_LOWER_UPPER_E,
//   CSL_FIELD_LOWER_UPPER_EI,
//   CSL_FIELD_BITR_ENUM,
//   CSL_FIELD_BITR_ENUM_IT,
//   CSL_FIELD_COPY,
//   CSL_FIELD_OBJECT,
//   CSL_FIELD_MAX
// } ECSLfieldDecl;

// typedef enum _ECSLfieldFunct {
//   CSL_SET_ENUM,
//   CSL_SET_ENUM_ITEM,
//   CSL_SET_WIDTH,
//   CSL_SET_RANGE,
//   CSL_SET_VALUE,
//   CSL_SET_BITRANGE,
//   CSL_SET_LOWER_INDEX,
//   CSL_SET_UPPER_INDEX,
//   CSL_SET_FIELD_POSITION,
//   CSL_SET_NEXT,
//   CSL_SET_PREVIOUS,
//   CSL_FIELD_FUNCTION_MAX
// } ECSLfieldFunct;

typedef CSLbase*                                CSLbasePoint;
typedef CSLdesign*                              CSLdesignPoint;
typedef CSLifc*                                 CSLifcPoint;
typedef CSLunit*                                CSLunitPoint;
typedef CSLunitInst*                            CSLunitInstPoint;
typedef CSLifcInst*                             CSLifcInstPoint;
typedef CSLport*                                CSLportPoint;
typedef CSLsignal*                              CSLsignalPoint;
typedef CSLbitrange*                            CSLbitrangePoint;
typedef CSLenum*                                CSLenumPoint;
typedef CSLenumItem*                            CSLenumItemPoint;
typedef CSLfield*                               CSLfieldPoint;
typedef CSLfieldInst*                           CSLfieldInstPoint;


typedef pair<string, CSLbasePoint>              CSLscopedBasePoint;
typedef pair<string, CSLdesignPoint>            CSLscopedDesignPoint;
typedef pair<string, CSLifcPoint>               CSLscopedIfcPoint;
typedef pair<string, CSLunitPoint>              CSLscopedUnitPoint;
typedef pair<string, CSLunitInstPoint>          CSLscopedUnitInstPoint;
typedef pair<string, CSLifcInstPoint>           CSLscopedIfcInstPoint;
typedef pair<string, CSLportPoint>              CSLscopedPortPoint;
typedef pair<string, CSLsignalPoint>            CSLscopedSignalPoint;
typedef pair<string, CSLbitrangePoint>          CSLscopedBitrangePoint;
typedef pair<string, CSLenumPoint>              CSLscopedEnumPoint;
typedef pair<string, CSLenumItemPoint>          CSLscopedEnumItemPoint;
typedef pair<string, CSLfieldPoint>             CSLscopedFieldPoint;
typedef pair<string, CSLfieldInstPoint>         CSLscopedFieldInstPoint; 

typedef vector<CSLbasePoint>                    CSLbaseVec;

typedef CSLbaseVec::const_iterator              CSLbaseVec_cIter;

//--------------------TYPEDEFS--------------------//

///////////////////
// class CSLbase //==============================================
///////////////////
class CSLbase {
    // protected:
  public:

    string                              m_name;
    ECSLtype                            m_type;
    //    ECSLfieldDecl                       m_field_type;

    //  private:
    CSLbasePoint                        m_parent;
    CSLbaseVec                          m_children;

  public:
    ostream*                            m_out;
    CSLbase(ECSLtype type, CSLbasePoint parent, string name, ostream& output);
    CSLbase(ECSLtype type, CSLbasePoint parent, string name);
    virtual ~CSLbase();

    //get functions
    CSLbasePoint getParent() const;
    CSLbasePoint getChildAt(int index) const;
    const string getName() const;
    const CSLbaseVec getChildren() const;
    const int getChildrenCount() const;
    const ECSLtype getType() const;

    //build function
    virtual bool buildDecl() = 0;
    
    //print function
    virtual void print() = 0;

    //random select functions
    CSLscopedBasePoint randSelObj(ECSLtype type);

    //check functions
    bool newNameIsValid(string name);

 
  protected:
    string randString();

    //add functions
    void addChild(CSLbasePoint child);

  private:
    //scope functions
    string addToScope(string scope, string toAdd);
    string removeFromScope(string scope);
};

//===============================================================

/////////////////////
// class CSLdesign //============================================
/////////////////////
class CSLdesign : public CSLbase {
  public:
    CSLdesign(ostream& output, string name = "Default_design");
    ~CSLdesign();

    //build functions
    bool buildDecl();
    void print();

  private:
    //add functions
    void addBitrange();
    void addSignal();
    void addIfc();
    void addUnit();
    void addIsaField();
    void addIsaElement();
    void addFifo();
    void addEnum();
    void addField();
    void addMemMapPage();
    void addMemMap();
    void addMemory();
    void addRegister();
    void addRegisterFile();
};
//===============================================================

//////////////////
// class CSLifc //===============================================
//////////////////
class CSLifc : public CSLbase {
  public:
    CSLifc(CSLbasePoint parent, string name);
    ~CSLifc();

    //build funcions
    bool buildDecl();
    void print();

  private:
    //add functions
    void addIfcInst();
    void addPort();
};
//===============================================================

///////////////////
// class CSLunit //==============================================
///////////////////
class CSLunit : public CSLbase{
  public:
    CSLunit(CSLbasePoint parent, string name);
    ~CSLunit();

    //build functions
    bool buildDecl();
    void print();

  private:
    //random select functions
    CSLscopedPortPoint randSelPort();
    CSLscopedSignalPoint randSelSignal();
    CSLscopedBitrangePoint randSelBitrange();

    //add functions
    void addIfcInst();
    void addUnitInst();
    void addFifoInst();
    void addRegFileInst();
    void addBitrange();
    void addSignal();
    void addPort();

    //modif functions
    void modifPort();
    void modifSignal();
    void modifBitrange();
};
//===============================================================

///////////////////////
// class CSLunitInst //==========================================
///////////////////////
class CSLunitInst : public CSLbase {
  private:
    CSLunitPoint                        m_instUnit;

  public:
    CSLunitInst(CSLbasePoint parent, string name);
    ~CSLunitInst();

    //get functions
    const CSLunitPoint getUnit() const;

    //build functions
    bool buildDecl();
    void print();

  private:
    //random select functions
    CSLscopedUnitPoint randSelUnit();

    //print functions
    void printUnitInstDecl();
};
//===============================================================

//////////////////////
// class CSLifcInst //===========================================
//////////////////////
class CSLifcInst : public CSLbase {
  private:
    CSLifcPoint                         m_instType;

  public:
    CSLifcInst(CSLbasePoint parent, string name);
    ~CSLifcInst();

    //get functions
    const CSLifcPoint getIfcType() const;

    //build functions
    bool buildDecl();
    void print();

  private:
    //random select functions
    CSLscopedIfcPoint randSelIfc();
};
//===============================================================

//////////////////////
//class CSLinstance //===========================================
//////////////////////
class CSLinstance : public CSLbase {
    //  private:
  public:
    CSLbasePoint                        m_instObj;

    CSLinstance(CSLbasePoint parent, CSLbasePoint instantiatedObj, string name);
    ~CSLinstance();

    //get functions
    const CSLbasePoint getInstantiatedObj() const;

    //build functions
    bool buildDecl();

    //print functions
    void print();
};
//===============================================================

//////////////////
//class CSLport //===============================================
//////////////////
/**********************************************************/
/*ports with type 'reg' can be only directioned as output */
/*ports with types 'real' and 'realtime' are not allowed  */
/**********************************************************/
class CSLport : public CSLbase {
  public:
    typedef enum _ECSLportDecl {
      CSL_PORT_DECL_EMPTY,
      CSL_PORT_DECL_TYPE,
      CSL_PORT_DECL_WIDTH,
      CSL_PORT_DECL_TYPE_WIDTH,
      CSL_PORT_DECL_BITRANGE,
      CSL_PORT_DECL_TYPE_BITRANGE,
      CSL_PORT_DECL_COPY,
      CSL_PORT_DECL_MAX
    } ECSLportDecl;

    typedef enum _ECSLportSet {
      CSL_PORT_MODIF_RANGE,
      CSL_PORT_MODIF_WIDTH,
      CSL_PORT_MODIF_OFFSET,
      CSL_PORT_MODIF_MAX
    } ECSLportModif;

  private:
    ECSLportDecl                        m_declForm;
    string                              m_bitrCopy;
    string                              m_sigCopy;
    string                              m_portCopy;
    string                              m_prtType;
    string                              m_prtDir;
    CSLbitrangePoint                    m_prtBitr;

  public:
    CSLport(CSLbasePoint parent, string name);
    ~CSLport();

    //get functions
    const string getPortType() const;
    const string getDir() const;
    const short getLower() const;
    const short getUpper() const;
    const short getWidth() const;
    const short getOffset() const;
    const CSLbitrangePoint getBitrange() const;

    //set functions
    bool setPortType(string type);
    bool setDir(string dir);
    bool setWidth(short width);
    bool setOffset(short offset);
    bool setRange(short lower, short upper);

    //copy functions
    void copyBitrange(const CSLbitrangePoint br);
    void copySignal(const CSLsignalPoint sig);
    void copyPort(const CSLportPoint prt);

    //build functions
    bool buildDecl();
    void buildSet(string scope);
    void print();

  private:
    //check functions
    bool isPortDeclValid();

    //random select functions
    CSLscopedBitrangePoint randSelBitrange();
};
//===============================================================

////////////////////
//class CSLsignal //=============================================
////////////////////
class CSLsignal : public CSLbase {
  public:
    typedef enum _ECSLsigDecl {
      CSL_SIG_DECL_EMPTY,
      CSL_SIG_DECL_TYPE,
      CSL_SIG_DECL_WIDTH,
      CSL_SIG_DECL_TYPE_WIDTH,
      CSL_SIG_DECL_LOWER_UPPER,
      CSL_SIG_DECL_TYPE_LOWER_UPPER,
      CSL_SIG_DECL_BITRANGE,
      CSL_SIG_DECL_TYPE_BITRANGE,
      CSL_SIG_DECL_COPY,
      CSL_SIG_DECL_MAX
    } ECSLsigDecl;

    typedef enum _ECSLsigSet {
      CSL_SIG_MODIF_RANGE,
      CSL_SIG_MODIF_WIDTH,
      CSL_SIG_MODIF_OFFSET,
      CSL_SIG_MODIF_BITR,
      CSL_SIG_MODIF_MAX
    } ECSLsigModif;

  private:
    ECSLsigDecl                         m_declForm;
    string                              m_bitrCopy;
    string                              m_sigCopy;
    string                              m_sigType;
    CSLbitrangePoint                    m_sigBitr;

  public:
    CSLsignal(CSLbasePoint parent, string name);
    ~CSLsignal();

    //get functions
    const string getSigType() const;
    const short getLower() const;
    const short getUpper() const;
    const short getWidth() const;
    const short getOffset() const;
    const CSLbitrangePoint getBitrange() const;

    //set functions
    bool setSigType(string type);
    bool setWidth(short width);
    bool setOffset(short offset);
    bool setRange(short lower, short upper);

    //copy functions
    void copyBitrange(const CSLbitrangePoint br);
    void copySignal(const CSLsignalPoint sig);

    //build functions
    bool buildDecl();
    void buildSet(string scope);
    void print();

  private:
    //random select functions
    CSLscopedBitrangePoint randSelBitrange();
    CSLscopedSignalPoint randSelSignal();
};
//===============================================================

///////////////////////
// class CSLbitrange //==========================================
///////////////////////
class CSLbitrange : public CSLbase {
  public:
    typedef enum _ECSLbitrDecl {
      CSL_BITR_DECL_WIDTH,
      CSL_BITR_DECL_LOWER_UPPER,
      CSL_BITR_DECL_MAX
    } ECSLbitrDecl;

    typedef enum _ECSLbitrSet {
      CSL_BITR_MODIF_OFFSET,
      CSL_BITR_MODIF_MAX
    } ECSLbitrModif;

  private:
    ECSLbitrDecl                        m_declForm;
    short                               m_brLower;
    short                               m_brUpper;
    short                               m_brOffset;
    bool                                m_brWidthIsSet;

  public:
    CSLbitrange(CSLbasePoint parent, string name);
    ~CSLbitrange();

    //get functions
    const short getLower() const;
    const short getUpper() const;
    const short getWidth() const;
    const short getOffset() const;
    const bool isWidthSet() const;

    //set functions
    bool setWidth(short width);
    bool setOffset(short offset);
    bool setRange(short lower, short upper);

    //copy functions
    void copyBitrange(const CSLbitrangePoint br);

    //build functons
    bool buildDecl();
    void buildSet(string scope);

    void print();
};
//===============================================================


} //NSCSLinterconnect

#endif //_CSL_INTERCONNECT_GEN_H_
