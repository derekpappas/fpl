////////////////////////////////////////////////////////////////////
//TODO: -replace all pointers with RefCount objects               //
////////////////////////////////////////////////////////////////////

#ifndef _CSL_BASE_H_
#define _CSL_BASE_H_

#include <vector>
#include <iostream>
#include <sstream>
#include <string>

#include "../support/CommonSupport.h"
#include "support.h"
//#include "csl_enum_field.h"

using namespace std;

namespace NSCSLinterconnect {

//ostream* OUTPUT = &cout;

const short TYPE_VEC_SIZE = 16;
const short DIR_VEC_SIZE  = 3;

const short NAMES_SIZE    = 2;
const short MAX_WIDTH     = 16;
const short MAX_OFFSET    = 16;

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
class CSLfieldInstance;
class CSLisaInstrFormat;

typedef enum _ECSLtype {
  CSL_DESIGN,
  CSL_IFC,
  CSL_UNIT,
  CSL_UNIT_INST,
  CSL_IFC_INST,
  CSL_PORT,
  CSL_SIGNAL,
  CSL_BITRANGE,
  CSL_FIELD,
  CSL_FIELD_INSTANCE,
  CSL_ENUM,
  CSL_ENUM_ITEM,
  CSL_ISA_INSTR_FORMAT,
  CSL_ISA_INSTR,
  CSL_ISA
} ECSLtype;

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

typedef enum _ECSLbitrDecl {
  CSL_BITR_DECL_EMPTY,
  CSL_BITR_DECL_WIDTH,
  CSL_BITR_DECL_LOWER_UPPER,
  CSL_BITR_DECL_MAX
} ECSLbitrDecl;

typedef enum _ECSLbitrSet {
  CSL_BITR_MODIF_RANGE,
  CSL_BITR_MODIF_WIDTH,
  CSL_BITR_MODIF_OFFSET,
  CSL_BITR_MODIF_MAX
} ECSLbitrModif;

typedef enum _ECSLfieldDecl {
  CSL_FIELD_DECL_EMPTY,
  CSL_FIELD_DECL_LOWER_UPPER,
  CSL_FIELD_DECL_WIDTH,
  CSL_FIELD_DECL_COPY,
  CSL_FIELD_DECL_OBJECT,
  CSL_FIELD_DECL_MAX
} ECSLfieldDecl;

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
typedef CSLfieldInstance*                       CSLfieldInstancePoint;


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
typedef pair<string, CSLfieldInstancePoint>     CSLscopedFieldInstancePoint;


typedef vector<CSLbasePoint>                    CSLbaseVec;

typedef CSLbaseVec::const_iterator              CSLbaseVec_cIter;

class CSLbase {
  public:
     string                              m_name;
     CSLbaseVec                          m_children;
     ECSLtype                            m_type;        
     CSLbasePoint                        m_parent;

     vector <string>                     m_names;
    static ostream                       *m_out;

    CSLbase(ECSLtype type, CSLbasePoint parent, string name);
    virtual ~CSLbase();

    CSLbasePoint getParent() const;
    CSLbasePoint getChildAt(int index) const;
    const string getName() const;
    const CSLbaseVec getChildren() const;
    const int getChildrenCount() const;
    const ECSLtype getType() const;

    bool newNameIsValid(string name);

    //    virtual void buildDecl(CSLbase* design) = 0;
    virtual bool buildDecl() = 0;
    CSLscopedBasePoint randSelObj(ECSLtype type);
    void addChild(CSLbasePoint child);
    virtual void print() = 0;

  private:
    //scope functions
    string addToScope(string scope, string toAdd);
    string removeFromScope(string scope);
};

} //NSCSLinterconnect

#endif //_CSL_INTERCONNECT_GEN_H_
