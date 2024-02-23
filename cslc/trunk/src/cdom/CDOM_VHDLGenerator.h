//----------------------------------------------------------------------
// Copyright (c) 2005-2008 Fastpathlogic
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
/*
 *   CDOM VHDL Code generator
 *   Authors: Monica 
 *   2009
 */

//#ifndef 
//#define 

#include <iostream>
#include <fstream>
#include <string>
//#define __TRACE
#include "CDOM.h"
#include "CDOM_Type_Map.h"
#include "CDOM_Visitor.h"
#include "../support/cli/cslcCLI_Support.h"

#define __TRACE
#include "../support/CommonSupport.h"
//defines used by indent function <- these are only temporary (need to be integrated)
//Not needed anymore - code needs to be updated and the 3 defines removed
#define IND1 1
#define IND2 2
#define IND3 3

/* This is sent by CDOM and represents the concatenation of top units names
 * the design (or NULL if the design has no top unit)
 */
extern RefString cslTopUnitName;

extern TBool cslomHasEnum;

 using namespace NSCdom;

namespace NSCdomVHDLGenerator {

  class CVHDLArchData;
  class CVHDLSignalData;
  class CVHDLPortData;
  class CVHDLModuleInstance;
  class CVHDLConstrF2A;
  class CVHDLRangeData;
  class CVHDLModuleData;
  class CVHDLDesignData;
  class CVHDLParamData;
  class CVHDLVarData;

//*****************************************************************************
//    MS added
//*****************************************************************************
 typedef enum _ESCPortWidthType {
    TYPE_SC_VECTORED,
    TYPE_SC_SIMPLE
  } ESCPortWidthType;

  typedef boost::shared_ptr<std::ofstream> RefOfstream;
  typedef boost::shared_ptr<std::ifstream> RefIfstream;
  typedef std::map<RefString, ESCPortWidthType, NSCdom::less_RefString> TMap_RefString_ESCPortWidthType;
  typedef TMap_RefString_ESCPortWidthType::const_iterator TMap_RefString_ESCPortWidthType_const_iter;
  typedef std::pair<RefString, ESCPortWidthType> TPair_RefString_ESCPortWidthType;
  typedef boost::shared_ptr<TMap_RefString_ESCPortWidthType> RefTMap_RefString_ESCPortWidthType;

  typedef std::map<RefString,TInt> TMap_RefString_TInt;
  typedef std::map<RefString,TInt>::iterator iter_TMap_RefString_TInt;
  typedef std::map<RefString,RefCDOmMinTypMax>::iterator iter_TMap_RefString_RefCDOmMinTypMax;
 
  typedef std::pair<RefString,TInt> TPair_RefString_TInt; 
  typedef boost::shared_ptr<TMap_RefString_TInt> Ref_TMap_RefString_TInt;
  typedef std::list<RefString> TList_RefString;
  typedef TList_RefString::const_iterator TList_RefString_const_iter;
  typedef boost::shared_ptr<TList_RefString> RefTList_RefString;
  typedef std::map<RefString,RefString> TMap_RefString_RefString;
  typedef boost::shared_ptr<TMap_RefString_RefString> Ref_TMap_RefString_RefString;
  typedef std::map<RefString,RefString>::iterator iter_TMap_RefString_RefString;

  typedef boost::shared_ptr<CVHDLArchData> Ref_CVHDLArchData; //MS added
  typedef std::vector<Ref_CVHDLArchData> TVec_CVHDLArchData;  //MS added
  typedef boost::shared_ptr<TVec_CVHDLArchData> Ref_TVec_CVHDLArchData; //MS added
  typedef TVec_CVHDLArchData::const_iterator TVec_CVHDLArchData_const_iter; //MS added

  typedef boost::shared_ptr<CVHDLModuleData> Ref_CVHDLModuleData; //MS added
  typedef std::vector<Ref_CVHDLModuleData> TVec_CVHDLModuleData;  //MS added
  typedef boost::shared_ptr<TVec_CVHDLModuleData> Ref_TVec_CVHDLModuleData; //MS added
  typedef TVec_CVHDLModuleData::const_iterator TVec_CVHDLModuleData_const_iter; //MS added

  typedef boost::shared_ptr<CVHDLDesignData> Ref_CVHDLDesignData; //MS added
  typedef std::vector<Ref_CVHDLDesignData> TVec_CVHDLDesignData;  //MS added
  typedef boost::shared_ptr<TVec_CVHDLDesignData> Ref_TVec_CVHDLDesignData; //MS added
  typedef TVec_CVHDLDesignData::const_iterator TVec_CVHDLDesignData_const_iter; //MS added

  typedef boost::shared_ptr<CVHDLSignalData> Ref_CVHDLSignalData; //MS added
  typedef std::vector<Ref_CVHDLSignalData> TVec_CVHDLSignalData;  //MS added
  typedef boost::shared_ptr<TVec_CVHDLSignalData> Ref_TVec_CVHDLSignalData; //MS added
  typedef TVec_CVHDLSignalData::const_iterator TVec_CVHDLSignalData_const_iter; //MS added

  typedef boost::shared_ptr<CVHDLVarData> Ref_CVHDLVarData; //MS added
  typedef std::vector<Ref_CVHDLVarData> TVec_CVHDLVarData;  //MS added
  typedef boost::shared_ptr<TVec_CVHDLVarData> Ref_TVec_CVHDLVarData; //MS added
  typedef TVec_CVHDLVarData::const_iterator TVec_CVHDLVarData_const_iter; //MS added

  typedef boost::shared_ptr<CVHDLPortData> Ref_CVHDLPortData; //MS added
  typedef std::vector<Ref_CVHDLPortData> TVec_CVHDLPortData;  //MS added
  typedef boost::shared_ptr<TVec_CVHDLPortData> Ref_TVec_CVHDLPortData; //MS added
  typedef TVec_CVHDLPortData::const_iterator TVec_CVHDLPortData_const_iter; //MS added

  typedef boost::shared_ptr<CVHDLParamData> Ref_CVHDLParamData; //MS added
  typedef std::vector<Ref_CVHDLParamData> TVec_CVHDLParamData;  //MS added
  typedef boost::shared_ptr<TVec_CVHDLParamData> Ref_TVec_CVHDLParamData; //MS added
  typedef TVec_CVHDLParamData::const_iterator TVec_CVHDLParamData_const_iter; //MS added
 
  typedef boost::shared_ptr<CVHDLModuleInstance> Ref_CVHDLModuleInstance;
  typedef boost::shared_ptr<CVHDLConstrF2A> Ref_CVHDLConstrF2A;
  typedef std::vector<Ref_CVHDLModuleInstance> TVec_CVHDLModuleInstance;

  typedef boost::shared_ptr<CVHDLRangeData> Ref_CVHDLRangeData; //Ms added
  typedef std::vector<Ref_CVHDLRangeData> TVec_CVHDLRangeData;  //MS added
  typedef boost::shared_ptr<TVec_CVHDLRangeData> Ref_TVec_CVHDLRangeData; //MS added
  typedef TVec_CVHDLRangeData::const_iterator TVec_CVHDLRangeData_const_iter; //MS added

  typedef TVec_CVHDLModuleInstance::const_iterator modInst_iter;
  typedef boost::shared_ptr<TVec_CVHDLModuleInstance> Ref_TVec_CVHDLModuleInstance;
  typedef std::vector<Ref_CVHDLConstrF2A> TVec_CVHDLConstrF2A;
  typedef TVec_CVHDLConstrF2A::const_iterator constrF2A_iter;
  typedef boost::shared_ptr<TVec_CVHDLConstrF2A> Ref_TVec_CVHDLConstrF2A;
  typedef std::vector<RefString> TVec_RefString;
  typedef TVec_RefString::const_iterator refString_iter;
  typedef boost::shared_ptr<TVec_RefString> Ref_TVec_RefString;
  typedef std::vector<Ref_TVec_RefString> TVec_Ref_TVec_RefString;
  typedef TVec_Ref_TVec_RefString::const_iterator refVec_iter;

  typedef boost::shared_ptr<TVec_Ref_TVec_RefString> Ref_TVec_Ref_TVec_RefString;
  typedef std::map<RefString,Ref_TVec_RefString> mapRefString_Ref_TVec_RefString; //FormalExprActual;
  typedef std::map<RefString,Ref_TVec_RefString>::iterator iter_mapRefString_Ref_TVec_RefString; //mapFormalExprActual;
  typedef boost::shared_ptr<mapRefString_Ref_TVec_RefString> Ref_mapRefString_Ref_TVec_RefString;
  typedef std::pair<RefString,Ref_TVec_RefString> pairRefString_Ref_TVec_RefString;
  typedef boost::shared_ptr<pairRefString_Ref_TVec_RefString> Ref_pairRefString_Ref_TVec_RefString;

  typedef boost::shared_ptr<TInt> Ref_TInt;
  typedef std::vector<TInt> TVec_TInt;     //MS added
  typedef std::vector<RefString> TVec_RefString;     //MS added
  typedef std::vector<std::string> TVec_String; //MS added
  typedef TVec_TInt::const_iterator TVec_TInt_const_iter; //MS added
  
  typedef TVec_String::const_iterator TVec_String_const_iter; //MS added
  typedef std::vector<char> TVec_char;
  typedef boost ::shared_ptr<TVec_char> RefTVec_char;
  // typedef RefTVec_char::const_iterator RefTVec_char_iter; //
  typedef TVec_char::const_iterator TVec_char_iter; //
  typedef boost::shared_ptr<char> RefChar;
  typedef std::vector<RefChar> TVec_RefChar;
  typedef boost::shared_ptr<RefChar> RefTVec_RefChar;

  typedef std::vector<TVec_char> TVec_TVec_char;
  typedef boost::shared_ptr<TVec_TVec_char> RefTVec_TVec_char;
  typedef TVec_TVec_char::const_iterator TVec_TVec_char_iter;

  typedef std::vector<RefChar> TVec_RefChar;
  typedef boost::shared_ptr<TVec_RefChar> Ref_TVec_RefChar;
  typedef std::vector<Ref_TVec_RefChar> TVec_Ref_TVec_RefChar;
  typedef boost::shared_ptr<TVec_Ref_TVec_RefChar> Ref_TVec_Ref_TVec_RefChar;

  typedef std::map<RefString,TVec_char> mapRefString_TVec_char; //numbers;
  typedef std::map<RefString,TVec_char>::iterator iter_mapRefString_Ref_TVec_char; 
  typedef boost::shared_ptr<mapRefString_TVec_char> Ref_mapRefString_TVec_char;
  typedef TVec_RefCDOmExpr::const_iterator TVec_RefCDOmExpr_const_iter;

  typedef std::map<RefString,TVec_RefString> mapRefString_TVecRefString; //numbers;
  typedef std::map<RefString,TVec_RefString>::iterator iter_mapRefString_TVecRefString; 
  typedef boost::shared_ptr<mapRefString_TVecRefString> Ref_mapRefString_TVecRefString;
   

//********************************************************************************
// CVHDLArchData class - MS added
//********************************************************************************
  class CVHDLArchData {
  private:
    RefString topModuleName;
    Ref_TVec_CVHDLModuleInstance instanceData;
    //Ref_TVec_RefString genSignals;
    Ref_TVec_CVHDLSignalData signalData;
    Ref_TVec_CVHDLVarData varData;
   
  public:
    CVHDLArchData();

    RefString getTopModuleName();
    void setTopModuleName(const NSCdom::RefCDOmIdentifier &); // const NSCdom::RefCDOmModuleDecl &);
    void addInstanceData(Ref_CVHDLModuleInstance &);
    Ref_TVec_CVHDLModuleInstance getInstanceData();
    //void addGenSignal(RefString &);
    //Ref_TVec_RefString getGenSignals();
    void addSignalData(Ref_CVHDLSignalData &);
    Ref_TVec_CVHDLSignalData getSignalData();
    void addVarData(Ref_CVHDLVarData &);
    Ref_TVec_CVHDLVarData getVarData(); 
   
    
    ~CVHDLArchData();
  };

//********************************************************************************
// CVHDLModuleData class - MS added
//********************************************************************************
  class CVHDLModuleData {
  private:
  
    Ref_TVec_CVHDLPortData portData;
       
  public:
    CVHDLModuleData();

    void addPortData(Ref_CVHDLPortData &);
    Ref_TVec_CVHDLPortData getPortData();
    
    
    ~CVHDLModuleData();
  };
//********************************************************************************
// CVHDLDesignData class - MS added
//********************************************************************************
  class CVHDLDesignData {
  private:
  
    Ref_TVec_CVHDLModuleData moduleData;
    
  public:
    CVHDLDesignData();

    void addModuleData(Ref_CVHDLModuleData &);
    Ref_TVec_CVHDLModuleData getModuleData();
    
    ~CVHDLDesignData();
  };
//********************************************************************************
// CVHDLSignalData class - MS added
//********************************************************************************
  class CVHDLSignalData {
  private:
  
    RefString sigName;
    RefString sigType;
    Ref_CVHDLRangeData signalRange;

  public:
    CVHDLSignalData();
  
    void addSignalName(RefString &);
    RefString getSignalName();
    void addSignalType(RefString );
    RefString getSignalType();
    void addSignalRange(Ref_CVHDLRangeData &);
    Ref_CVHDLRangeData getSignalRange();
    
    ~CVHDLSignalData();
  };
//********************************************************************************
// CVHDLVarData class - MS added
//********************************************************************************
  class CVHDLVarData {
  private:
  
    RefString varName;
    RefString varType;
    Ref_CVHDLRangeData varRange;
    TInt varVal;

  public:
    CVHDLVarData();
  
    void addVarName(RefString &);
    RefString getVarName();
    void addVarType(RefString );
    RefString getVarType();
    void addVarValue(TInt);
    TInt getVarValue();
    void addVarRange(Ref_CVHDLRangeData &);
    Ref_CVHDLRangeData getVarRange();
    
    ~CVHDLVarData();
  };
//********************************************************************************
// CVHDLPortData class - MS added--used for component scope
//********************************************************************************
  class CVHDLPortData {
  private:
  
    RefString pName;
    RefString pType;
    RefString pDir;
    Ref_CVHDLRangeData  portRange;

  public:
    CVHDLPortData();
  
    void addPortName(RefString &);
    RefString getPortName();
    void addPortType(RefString );
    RefString getPortType();
    void addPortDir(RefString );
    RefString getPortDir();
    void addPortRange(Ref_CVHDLRangeData &);
    Ref_CVHDLRangeData  getPortRange();
    
    ~CVHDLPortData();
  };
//********************************************************************************
// CVHDLParamData class - MS added
//********************************************************************************
  class CVHDLParamData {
  private:
  
    RefString parName;
    RefString parType;
    TInt paramValue;
    RefString paramString;

  public:
    CVHDLParamData();
  
    void addParamName(RefString &);
    RefString getParamName();
    void addParamType(RefString );
    RefString getParamType();
    void addParamValue(TInt);
    TInt getParamValue();
    void addParamString(RefString );
    RefString getParamString();
    
    ~CVHDLParamData();
  };
//********************************************************************************
// CVHDLModuleInstance class - MS added
//********************************************************************************
  class CVHDLModuleInstance {
  private:
    RefString moduleName;
    RefString instanceName;
    Ref_TVec_CVHDLConstrF2A F2AData;
    Ref_TVec_CVHDLParamData paramData;
   
  public:
    CVHDLModuleInstance();

    RefString getModuleName();
    void setModuleName(RefString &);
    RefString getInstanceName();
    void setInstanceName(RefString &);
    void addF2AData(Ref_CVHDLConstrF2A &);
    Ref_TVec_CVHDLConstrF2A getF2AData();
    void addParamData(Ref_CVHDLParamData &);
    Ref_TVec_CVHDLParamData getParamData();
   
    ~CVHDLModuleInstance();
  };

//********************************************************************************
// CVHDLConstrF2A class - MS added
//********************************************************************************
  class CVHDLConstrF2A {
  private:
    RefTMap_RefString_RefCDOmExpr formalActualExpr;
      
  public:
    CVHDLConstrF2A();
    void addFormalActualExpr(RefTMap_RefString_RefCDOmExpr );
    RefTMap_RefString_RefCDOmExpr getFormalActualExpr();
    ~CVHDLConstrF2A();
  };


//********************************************************************************
// CVHDLRangeData class - MS added
//********************************************************************************
  class CVHDLRangeData {
  private:
   TInt  upperLimit;
   TInt  lowerLimit;

  public:
   CVHDLRangeData();
   TInt getUpperLimit();
   TInt getLowerLimit();
   void setUpperLimit(TInt  &);
   void setLowerLimit(TInt  &);
  
   ~CVHDLRangeData();
  };

//********************************************************************************
// CVHDLGenerator class
//********************************************************************************
class CVHDLGenerator : public NSCdomVisitor::CVisitorTraversal {
   private:
    std::ostream *out;
    
    //WARNING: need to add this to members TBool indent; <- check to trigger indent

    //std::ostream *dout; //output stream for units of type design
    //std::ostream *tout; //output stream for units of type testbench
    //std::ostream *vout; //not used yet
    std::fstream vhout;//vh file stream
    std::fstream defout;//defines file stream
    TBool file;

    //output control
    std::string m_outputPath;
  
    //tmp file
    std::string m_archFileName;

    //names used in file output
    RefString m_currentModuleName;
    RefString m_moduleFileName;
   
    //map of names and instantiations (there are actually module decls but
    // are retrived from instantiations: see getInstancesDeclarationsAsBase())
    //this is to make sure no duplicate names are found in vf output file
    RefTMap_RefString_RefCDOmBase m_instantiationsMap;
    Ref_mapRefString_TVecRefString m_numAssMap;           //MS added---numeric assign
    //depth counter -- used for indentation control
    TInt m_depth;
    //experimental counter
    TInt m_addIndent;

    TInt m_modcnt;//module children counter
    TInt m_portItemSize;//used to determine portItemSize
    TInt m_portDeclNo; //use to keep the number of ports declared in a module--MS added
    TInt m_portDeclSize;//not needed ?
    TVec_TInt m_portCnt; //used to hold the number of ports for each module--MS added
    TInt m_cnt;
    TInt modNo;
    TInt m_moduleCnt;
    TBool m_assignHID; // is true if RHS of assign is a signal/port
    TBool m_exprNum;  //is true if RHS of assign is a number
    TBool m_concatExpr; // is true if RHS of assign is a concatenation expr
    TBool m_binaryExpr; // is TRUE if the width is given as a binary expression
    TBool m_width; // used to determine port/signal range
    TInt rangeNo;
    TBool m_Cnt;
    //---OB added---used in vectors' defines
    TBool m_vect;
    TBool m_parOver;
    TBool m_doubleRange;
    //design 
 TBool m_designGenCode;
 RefTMap_RefString_ESCPortWidthType m_portWidthTypeMap;
 RefCDOmDesign m_design;
 TInt m_designFuncIdNo;

    //used in exprLink
    TInt m_exprLinkExprSize;
    TInt m_exprLinkExprCnt;
    TInt m_exprLinkListExprSize;
    int cnt;
    RefTVec_RefCDOmExpr m_exprLinkExprs;
    RefTVec_RefString m_exprLinkHidNames;
    RefTVec_RefString assignVec;  //MS added---used for assign statement
    RefTVec_RefString assVec;
    RefTVec_RefString opExprVec;  //MS added---used for expression operation
    RefTVec_RefString opConcatVec; //MS added---used for concatenation operation
    TVec_char numVec;     //MS added---used for assign with numbers
    TVec_char numParVec; 
    RefTVec_char refNumVec;
    TVec_Ref_TVec_RefString numVec_Vec; //MS added ---use to hold the num vectors 
    RefTVec_RefString actualNameVec;  //MS added---used for assign statement  
    Ref_pairRefString_Ref_TVec_RefString assignPair; //used in assign stmt
    Ref_mapRefString_Ref_TVec_RefString assignMap;
    Ref_mapRefString_TVec_char numMap; //used for assign with numbers
    Ref_mapRefString_TVec_char paramOverMap; //used for param override
    RefString numAssign;
    Ref_TVec_CVHDLParamData pVec;
    // RefTVec_RefString m_dutVec;
    RefString dutName;
    RefString m_LHS;
    RefString m_parName; //used in param override
    TBool m_tb;
    //used in portDecl
    TInt m_pdcnt;
    TInt m_portIdSize;//used to determine the number of IDs in a portDecl
    TInt m_orderedPortNumSize;//used to determine the port number  --MS added
    //used in varDecl
    TInt m_vrcnt;
    TInt m_varIdSize;//used to determine the number of IDs in a varDecl
    
    //used in netDecl
    TInt m_ntcnt;
    TInt m_netIdSize;//used to determine the number of IDs in a netDecl
    TBool m_hasSignal; //MS added
    Ref_TVec_CVHDLSignalData signalDataVec;
   
    //used in range
    TInt m_rangeExprs;//used to position inside the range
    TBool m_showRange;
    TBool m_rangeGenExpr;
    TBool m_rangeAsWidth;
    TInt m_upper;
    TInt m_lower;
    TVec_TInt m_upperVec;
    TVec_TInt m_lowerVec;
    TVec_TInt partSelVec;
    
   
   //TBool m_noRange;

    //used in include (cdomInclude)
    TBool m_includeInUnit;

    //used in moduleDecl
    CDOmModuleDecl::ECslSourceUnitType m_moduleCslType;
   
    //used in moduleInstantiation
    TInt m_intcnt; //counter that increments after each instance
    TInt m_intExprCnt; //counter that increments after each parameter assignment
    TInt m_intExprSize; //determines the number of expressions (TYPE_EXPR) - paramter assignments are also exprs
    TBool m_intHasParams; //flag to check if the instantiation has paramter assignments
    TInt m_instanceNumSize;//used to determine the number of instances in an instantiation
    RefTVec_RefCDOmPortItem m_portItems;
    TUInt m_moduleInstantiationIndt;
    TInt m_moduleInstantiationParamNo;
    RefString m_moduleInstantiationName;
    RefTVec_RefCDOmExpr m_moduleInstantParamExprVec;
    TMap_RefString_RefCDOmMinTypMax::const_iterator m_paramNameMapIt;
    TBool m_isNumActual; // is TRUE if there is a f2a between a port and a number
    TBool m_partSelActual; // is TRUE if the actual in a f2a conn with an input port is a part select
    TBool m_isExprActual; // is TRUE if an expression is used as an actual in a f2a connection
    TBool m_exprSigPortActual; // is TRUE if there is a f2a between a port and an expr with sigs/ports
    TBool m_actualExpr; // is TRUE when printing an expression used as an actual
    RefTMap_RefString_RefCDOmExpr explicitPortNameMap; // formals and actuals map
    Ref_TMap_RefString_TInt inputPortsMap; // map with input ports and their width
    TBool m_inputPorts; // is true when there are input ports declarations (needed to write the width in the map)
    RefTList_RefString m_inputPortCon; // holds the names of input ports
    RefTList_RefString m_outputPortCon; // holds the names of output ports
    RefTList_RefString m_inoutPortCon; // holds the names of output ports
    TBool m_inputExpr; // is TRUE if an expression is used as an actual in a f2a connection where the formal is an input port
    TBool m_assignStmt; // is TRUE if there is an assign statement
    char p; // is o for output ports,i for input ports and b for both (inout ports)
    CDOmModuleOrUdpInstantiation::EModuleInstantiationType m_moduleInstantiationType;
    RefTVec_RefString paramNameVec;
    RefTVec_RefCDOmBase m_moduleInstanceExprVec;
    TBool m_moduleInstanceGenOrderedAsNamed;
    Ref_TVec_CVHDLPortData portVec; //MS added---hold the list of  ports
    RefString formalName; // name of formal connected with an expression
    TBool opExpr; //is TRUE when there is an operation extpression
    TInt s;
    TInt i;
    // TVec_RefString  m_name; //used to keep the LHS item from an assign with numbers
    // TVec_TVec_char m_num;  //used to keep the RHS item from an assign with numbers
    //used in moduleInstance
    TInt m_inscnt;
    TInt m_insctrl;
    TUInt m_moduleInstanceIndt;
    TInt m_moduleInstanceCnt;
    TInt m_moduleInstanceSize;
    TInt m_moduleInstanceExprSize;    
    TInt m_moduleInstanceExprCnt;
    TBool m_moduleInstanceCloseParen;
    //   TInt m_orderedPortNumSize;//used to determine the port number 
    RefTVec_TUInt m_emptyIndexesVec;
    TUInt m_emptyIndex;
    TBool m_assignPartSel; // is TRUE if there is an assign stmt and RHS is part sel
    //used in exprOp
    //TInt m_posCnt;
    std::vector<TInt> m_exprCnt;
    TBool m_hasVar;

    //identifier
    TBool m_idPrintSemi;

    //used in listExpr
    TUInt m_listExprCnt;
    TUInt m_listExprSize;
    TBool m_listExprHasExprLinkParent;
    TBool m_listExprHasFunctionCallParent;
    RefCDOmBase m_parent;

    //used in minTypMax
    TInt m_minTypMaxCnt;
    TInt m_minTypMaxChildren;

    //used in delay
    TInt m_delayPos;
    TInt m_delaySize;
    TInt m_delayDeclType;
    TBool m_delayHasParanths;

    //used in paramDecl
    TInt m_paramDeclPos;
    TInt m_paramDeclChildren;
    RefTMap_RefString_RefCDOmIdentifier m_nameMap;
    TBool m_param;
    std::vector<RefString> m_namesVec; 
    TInt m_parCnt;
    TInt parNo; //# of parameters

    //used in ParamOverride
    TInt m_paramOverrideCnt;
    TInt m_paramOverrideSize;

    //used in assn
    TInt m_assnPos;

    //used in stmtBlock
    TInt m_stmtBlockCnt;
    TInt m_stmtBlockSize;

    //used in contAssn
    TInt m_contAssnPos;
    TInt m_contAssnSize;

    //used in stmtAssn
    TInt m_stmtAssnPos;

    //used in eventExpr
    TInt m_eventExprType; //WARNING: this is not used in inTraversal anymore -- may prove to be redundant: dig this!
    std::vector<TInt> m_eventExprCnt;

    //used in eventControl
    TInt m_eventCtrlType;

    //used in stmtProcContAssn
    TInt m_stmtPCAssnType;

    //used in stmtProcTimingControl
    TInt m_stmtPTCtrlPos;

    //used in stmtCase
    TInt m_caseType;
    TInt m_stmtCaseCnt;
    TInt m_stmtCaseSize;
    TBool m_stmtCaseDefault;

    //used in stmtIf
    TInt m_stmtIfCnt;
    TInt m_stmtIfSize;
    TBool m_stmtIfHasAttrList;
    //TBool m_stmtIfHasStmtBlockChildren;

    //used in stmtLoop
    TInt m_stmtLoopCnt;
    TInt m_stmtLoopType;

    //used in stmtTaskEnable
    TInt m_stmtTaskEnableCnt;
    TInt m_stmtTaskEnableSize;

    //used in stmtWait
    TInt m_stmtWaitCnt;

    //used in rangeExpr
    TInt m_rangeExprPos;
    TInt m_rangeExprType;

    //used in exprConcat
    RefTStack_TInt m_exprConcatSize;

    //used in exprMultiConcat
    TInt m_exprMultiConcatPos;

    //used in udpDecl
    TInt m_udpcnt;
    TInt m_udpPdInputCnt;
    RefString m_udpOutPortName;

    //used in udpCombEntry
    TInt m_combEntryCnt;
    TInt m_combEntrySize;

    //used in udpSeqEntry
    TInt m_seqEntryCnt;
    TInt m_seqEntrySize;

    //used in taskDecl
    TInt m_taskDeclChildren;
    TInt m_taskDeclPortItemSize;
    TInt m_taskDeclCnt;

    //used in tfPortDecl
    TInt m_tfPortDeclSize;
    TInt m_tfPortDeclCnt;

    //used in funcDecl
    TInt m_funcDeclCnt;
    TInt m_funcDeclType;
    TBool m_hasRange;

    //used in genvarDecl
    TInt m_genvarDeclCnt;
    TInt m_genvarDeclSize;

    //used in genItemIf
    TInt m_genItemIfCnt;
    TInt m_genItemIfSize;

    //used in genItemCase
    TInt m_genItemCaseCnt;
    TInt m_genItemCaseSize;
    TBool m_genItemCaseDefault;

    //used in genItemLoop
    TInt m_genItemLoopCnt;

    //used in genItemBlock
    TInt m_genItemBlockCnt;
    TInt m_genItemBlockSize;

    //used in eventDecl
    TInt m_eventDeclCnt;
    TInt m_eventDeclSize;
    RefTVec_RefCDOmExprLink m_eventExprVec;

    //used in pulseSSCD
    TInt m_pulseSSCdType;

    //used in pathDecl
    TInt m_pathDeclReturn;
    TBool m_pathDeclIsSimple;
    //TBool m_pathDeclIsSimpleAndFull;
    TBool m_pathDeclIsEdge;
    TBool m_pathDeclIsStateSimpleIf;
    TBool m_pathDeclIsStateEdgeIf;
    TBool m_pathDeclIsStateSimpleIfNone;
    TBool m_pathDeclhasPolarityOp;
    TInt m_pathDeclCnt;

    //used in pathDelayValue
    TInt m_pathDelayValCnt;
    TInt m_pathDelayValSize;

    //used in minTypMaxList
    TInt m_minTypMaxListCnt;
    TInt m_minTypMaxListSize;

    //used in specifyTerminalList
    TInt m_specifyTListCnt;
    TInt m_specifyTListSize;

    //used in delayedDataOrRef
    TInt m_delayedDataOrRefCnt;
    TInt m_delayedDataOrRefSize;

    //used in timingCkEventCtrl
    TInt m_timingCheckType;
    std::vector<TInt> m_timingCheckEdgeDescriptor;

    //used in timingCkEvent
    TInt m_timingCheckEventType;
    TInt m_timingCheckEventCnt;
    TInt m_timingCheckEventSize;

    //used in timingCk
    TInt m_systemTimingCkType;
    TInt m_systemTimingCkCnt;
    TInt m_systemTimingCkSize;

    //used in gateInstantiation
    TInt m_gateInstanceType;
    TInt m_gateInstanceCnt;
    TInt m_gateInstanceSize;
    TBool m_gateInstanceFlag;
    NSCdom::RefTVec_RefCDOmBase gateVec;
    
    
    //used in pulseControl
    TInt m_pulseControlCnt;
    TInt m_pulseControlSize;
    TBool m_pulseControlLong;
    TBool m_pulseControlSection;

    //used in attrList
    TInt m_attrListCnt;
    TInt m_attrListSize;

    //used in cdomDefine
    TInt m_defineType;
    std::ostream *m_tempStream;

    //used in CDOmNum32
    TBool m_expandNum32; //show base and width or not
    TInt m_num32baseType;
    TBool m_num32signed;
    TInt m_num32value;
    TInt m_num32width;
    TInt m_num32TempWidth;
    //std::string m_num32TempStr;
    RefString m_num32TempStr;
    std::string::iterator m_num32TempIter;
    std::stringstream m_num32Stream;
    TBool m_num32Indent;

    //used in CDOmComment
    TInt  m_commentType;
    TBool m_commentStar;

    //vfInclude
    RefString m_vhIncludeString;

    //NSCdom::RefCDOmDesign m_product;
    //NSCdom::RefCDOmBase m_cdomCurrParent;
    //NSCdom::RefTVec_RefCDOmBase m_traversedChildren;

   public:
    CVHDLGenerator(std::string outputPath);
    ~CVHDLGenerator();

    void indt(TInt size);
    void portListIndt(TInt size);
    //std::string dec2Bin(TInt value, TInt size);
    void copyrightNotice(std::string filename);
    void setVhInclude(RefString plusPath);
    void indtFile(TInt size, std::ostream* file);
    
    void beforeTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 );
    void beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      );
    void beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  );
    void beforeTraversal(const NSCdom::RefCDOmIdentifier                      & id                          );
    void beforeTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    );
    void beforeTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    );
    void beforeTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      );
    void beforeTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    );
    void beforeTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    );
    void beforeTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     );
    void beforeTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     );
    void beforeTraversal(const NSCdom::RefCDOmRange                           & range                       );
    void beforeTraversal(const NSCdom::RefCDOmNum32                           & num                         );
    void beforeTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ){}
    void beforeTraversal(const NSCdom::RefCDOmReal                            & realNum                     );
    void beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         );
    void beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              );
    void beforeTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         );   
    void beforeTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   );
    void beforeTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               );
    void beforeTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   );
    void beforeTraversal(const NSCdom::RefCDOmDelay                           & delay                       );
    void beforeTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                );
    void beforeTraversal(const NSCdom::RefCDOmAssn                            & assn                        );
    void beforeTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    );
    void beforeTraversal(const NSCdom::RefCDOmStmt                            & stmt                        );
    void beforeTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   );
    void beforeTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    );
    void beforeTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   );
    void beforeTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   );
    void beforeTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   );
    void beforeTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  );
    void beforeTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  );
    void beforeTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    );
    void beforeTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      );
    void beforeTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    );
    void beforeTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              );
    void beforeTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    );
    void beforeTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 );
    void beforeTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            );
    void beforeTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   );
    void beforeTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   );
    void beforeTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  );
    void beforeTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             );
    void beforeTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     );
    void beforeTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           );
    void beforeTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            );
    void beforeTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                );
    void beforeTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 );
    void beforeTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 );
    void beforeTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    );
    void beforeTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  );
    void beforeTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    );
    void beforeTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                );
    void beforeTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  );
    void beforeTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     );
    void beforeTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 );
    void beforeTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   );
    void beforeTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 );
    void beforeTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 );
    void beforeTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                );
    void beforeTraversal(const NSCdom::RefCDOmString                          & stringObj                   );
    void beforeTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   );
    void beforeTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                );
    void beforeTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   );
    void beforeTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    );
    void beforeTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              );
    void beforeTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               );
    void beforeTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         );
    void beforeTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            );
    void beforeTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           );
    void beforeTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               );
    void beforeTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              );
    void beforeTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           );
    void beforeTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                );
    void beforeTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    );
    void beforeTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ){}
    void beforeTraversal(const NSCdom::RefCDOmDefine                          & define                      );
    void beforeTraversal(const NSCdom::RefCDOmComment                         & comment                     );

    /*
    void beforeTraversal(const NSCdom::RefCDOmExpr                            & expr                        );
    */

    void inTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 );
    void inTraversal(const NSCdom::RefCDOmDesign                          & design                      );
    void inTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  );
    void inTraversal(const NSCdom::RefCDOmIdentifier                      & id                          );
    void inTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    );
    void inTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    );
    void inTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      );
    void inTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    );
    void inTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    );
    void inTraversal(const NSCdom::RefCDOmRange                           & range                       );
    void inTraversal(const NSCdom::RefCDOmNum32                           & num                         );
    void inTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ){}
    void inTraversal(const NSCdom::RefCDOmReal                            & realNum                     );
    void inTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     );
    void inTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     );
    void inTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         );
    void inTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              );
    void inTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         );   
    void inTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   );
    void inTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               );
    void inTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   );
    void inTraversal(const NSCdom::RefCDOmDelay                           & delay                       );
    void inTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                );
    void inTraversal(const NSCdom::RefCDOmAssn                            & assn                        );
    void inTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    );
    void inTraversal(const NSCdom::RefCDOmStmt                            & stmt                        );
    void inTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   );
    void inTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    );
    void inTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   );
    void inTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   );
    void inTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   );
    void inTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  );
    void inTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  );
    void inTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    );
    void inTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      );
    void inTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    );
    void inTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              );
    void inTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    );
    void inTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 );
    void inTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            );
    void inTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   );
    void inTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   );
    void inTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  );
    void inTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             );
    void inTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     );
    void inTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           );
    void inTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            );
    void inTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                );
    void inTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 );
    void inTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 );
    void inTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    );
    void inTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  );
    void inTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    );
    void inTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                );
    void inTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  );
    void inTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     );
    void inTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 );
    void inTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   );
    void inTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 );
    void inTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 );
    void inTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                );
    void inTraversal(const NSCdom::RefCDOmString                          & stringObj                   );
    void inTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   );
    void inTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                );
    void inTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   );
    void inTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    );
    void inTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              );
    void inTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               );
    void inTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         );
    void inTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            );
    void inTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           );
    void inTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               );
    void inTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              );
    void inTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           );
    void inTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                );
    void inTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    );
    void inTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ){}
    void inTraversal(const NSCdom::RefCDOmDefine                          & define                      );
    void inTraversal(const NSCdom::RefCDOmComment                         & comment                     );

    /*
    void inTraversal(const NSCdom::RefCDOmExpr                            & expr                        );

    */

    void afterTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 );
    void afterTraversal(const NSCdom::RefCDOmDesign                          & design                      );
    void afterTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  );
    void afterTraversal(const NSCdom::RefCDOmIdentifier                      & id                          );
    void afterTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    );
    void afterTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    );
    void afterTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      );
    void afterTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    );
    void afterTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    );
    void afterTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     );
    void afterTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     );
    void afterTraversal(const NSCdom::RefCDOmRange                           & range                       );
    void afterTraversal(const NSCdom::RefCDOmNum32                           & num                         );
    void afterTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ){}
    void afterTraversal(const NSCdom::RefCDOmReal                            & realNum                     );
    void afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         );
    void afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              );
    void afterTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         );   
    void afterTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   );
    void afterTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               );
    void afterTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   );
    void afterTraversal(const NSCdom::RefCDOmDelay                           & delay                       );
    void afterTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                );
    void afterTraversal(const NSCdom::RefCDOmAssn                            & assn                        );
    void afterTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    );
    void afterTraversal(const NSCdom::RefCDOmStmt                            & stmt                        );
    void afterTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   );
    void afterTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    );
    void afterTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   );
    void afterTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   );
    void afterTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   );
    void afterTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  );
    void afterTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  );
    void afterTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    );
    void afterTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      );
    void afterTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    );
    void afterTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              );
    void afterTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    );
    void afterTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 );
    void afterTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            );
    void afterTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   );
    void afterTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   );
    void afterTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  );
    void afterTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             );
    void afterTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     );
    void afterTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           );
    void afterTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            );
    void afterTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                );
    void afterTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 );
    void afterTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 );
    void afterTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    );
    void afterTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDec                   );
    void afterTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    );
    void afterTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                );
    void afterTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  );
    void afterTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     );
    void afterTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 );
    void afterTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   );
    void afterTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 );
    void afterTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 );
    void afterTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                );
    void afterTraversal(const NSCdom::RefCDOmString                          & stringObj                   );
    void afterTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   );
    void afterTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                );
    void afterTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   );
    void afterTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    );
    void afterTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              );
    void afterTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               );
    void afterTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         );
    void afterTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            );
    void afterTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           );
    void afterTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               );
    void afterTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              );
    void afterTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           );
    void afterTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                );
    void afterTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    );
    void afterTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ){}
    void afterTraversal(const NSCdom::RefCDOmDefine                          & define                      );
    void afterTraversal(const NSCdom::RefCDOmComment                         & comment                     );


    /*
    void afterTraversal(const NSCdom::RefCDOmExpr                            & expr                        );

    */

};
}
