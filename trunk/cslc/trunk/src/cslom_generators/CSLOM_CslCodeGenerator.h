//---------------------------------------------------------------------
// Copyright (c) 2010 Fastpathlogic
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

//Author: MonicaS
//Data: October,2010

#include "html_template.h"
#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "../support/CommonSupport.h"
#include "../support/cli/cslcCLI_Support.h"
#include <sstream>


#ifndef _CSLOM_CSL_GENERATOR

#define _CSLOM_CSL_GENERATOR

#ifndef __RELEASE_VERSION

//#define _DEBUG_CSLOM_CSL_GENERATOR

#endif

namespace NSCSLOmCslCodeGenerator {

class CSLOmIsaPrefixTree;
 typedef boost::shared_ptr<CSLOmIsaPrefixTree>         RefCSLOmIsaPrefixTree;
 typedef std::vector<RefCSLOmIsaPrefixTree>      TVec_RefCSLOmIsaPrefixTree;   // vector of RefCSLOmIsaPrefixTree
 typedef boost::shared_ptr<TVec_RefCSLOmIsaPrefixTree>      RefTVec_RefCSLOmIsaPrefixTree;
 typedef std::vector<RefString> TVec_RefString;
 typedef boost::shared_ptr<TVec_RefString> RefTVec_RefString;
 typedef map<RefString,RefTVec_RefString> TMap_RefString_RefTVec;
 typedef boost::shared_ptr<TMap_RefString_RefTVec> RefTMap_RefString_RefTVec;
 typedef map<RefString, RefTMap_RefString_RefTVec> TMap_RefString_RefTMap;
 typedef boost::shared_ptr<TMap_RefString_RefTMap> RefTMap_RefString_RefTMap;

 typedef map<RefString,RefString> TMap_RefString;
 typedef boost::shared_ptr<TMap_RefString> RefTMap_RefString;
 typedef map<RefString, RefTMap_RefString> TMap_RefString_RefTMap_RefString;
 typedef boost::shared_ptr<TMap_RefString_RefTMap_RefString> RefTMap_RefString_RefTMap_RefString;
 typedef map<RefString,RefTMap_RefString_RefTMap_RefString> TMap_RefTMap;
 typedef boost::shared_ptr<TMap_RefTMap> RefTMap_RefTMap;
 typedef map<RefString,RefTMap_RefTMap> TMap_RefTMap_RefTMap;
 typedef boost::shared_ptr<TMap_RefTMap_RefTMap> RefTMap_RefTMap_RefTMap;

 typedef vector<RefTMap_RefString_RefTVec> TVec_RefMap;
 typedef boost::shared_ptr<TVec_RefMap> RefTVec_RefMap;
 typedef vector<TInt> TVec_TInt;
 typedef boost::shared_ptr<TVec_TInt> RefTVec_TInt;
 typedef map<RefString,RefTVec_TInt> RefString_TInt_Map;
 typedef boost::shared_ptr<RefString_TInt_Map> RefString_TInt_RefMap;

class CSLOmCslCodeGenerator;
typedef boost::shared_ptr<CSLOmCslCodeGenerator>   RefCSLOmCslCodeGenerator;


/**
 * Prefix Tree or Trie
 * This class is to be used only within CSLOmVerilogTbGenerator class
 * for building isa instructions and checking for duplicates 
 */
class CSLOmIsaPrefixTree {
  private:  
  


    RefCSLOmIsaPrefixTree getThis() const {return m_weakRef.lock();}
    boost::weak_ptr<CSLOmIsaPrefixTree> m_weakRef;
    boost::weak_ptr<CSLOmIsaPrefixTree> m_parent;
    RefCSLOmIsaPrefixTree m_leftChild;
    RefCSLOmIsaPrefixTree m_rightChild;
    RefString m_instrName;
  
    CSLOmIsaPrefixTree();
    static RefCSLOmIsaPrefixTree build();
    void addChild(TBool dir, RefString name);
    TBool isLeaf();
    friend class CSLOmCslCodeGenerator;
};

/**
 * This component is supposed to do checks and throw errors on the CSLOM
 * so that it provides the Adapter and all the other code generators a 
 * "pure" and correct CSLOM tree. In theory, the Checker isn't supposed to
 * modify the CSLOM in any way, just to check for design errors that cannot
 * be caught until CSLOM is fully built, or, in other words, seeing
 * "the full picture".
 */
class CSLOmCslCodeGenerator : public NSCSLOmVisitor::CVisitorTraversal {
  public:


    CSLOmCslCodeGenerator(string outputPath);
    int c;
    string m_cslPath;
    string m_cslName;
    /* 
     *instance name 
     */
    RefString dutInstName;
    RefString  unitName;
    RefString unit_name;
    RefString m_DutName;
    RefString m_vecDir;
    /* 
     *testbench name 
     */
    RefString tbName;

    RefString cslName;

    //tb clock name
    RefString clockName;

    //tb clock type
    RefString clockType;
    RefString dutClk;
    //tb clk periode
    TInt per;

    //tb clock timebase
    RefString timeBase; 

    //tb wave type
    RefString waveType; 
    
    //verilog filename
    RefString verilogFilename;

    //timeout counter
    NSCSLOm::RefCSLOmExpr timeoutCnt;
    std::vector<TInt> m_exprCnt;
    //wave filename
    RefString outputFileName;
    
    //tb signals
    RefString resetName;
    RefString resetType;

    RefString randValidName;
    RefString randValidType;

    RefString validName;
    RefString validType;

    RefString rdEnName;
    RefString rdEnType;

    RefString stimVerErrName;
    RefString stimVerErrType;

    RefString expVerErrName;
    RefString expVerErrType;

    RefString stimIdErrName;
    RefString stimIdErrType;

    RefString expIdErrName;
    RefString expIdErrType;

    RefString fileMcdName;
    RefString fileMcdType;

    RefString reportFileMcdName;
    RefString reportFileMcdType;

    RefString cycleCntName;
    RefString cycleCntType;

    RefString simStopName;
    RefString simStopType;

   
    RefString m_ifcInst;
    RefString m_ifcName;
    RefString m_ifcName1;
    RefString uName;
    RefString uInst;
    TInt cnt;
    //unit instance without f2a
    RefTMap_RefString unitNameInstMap;
    RefTMap_RefString_RefTMap_RefString unitDeclInstNameMap;
    // RefTVec_RefString ifcInstVec;
    RefTMap_RefString ifcInstMap;
    RefTVec_RefString portDataVec;
    RefTVec_RefString sigDataVec;
    // RefTVec_RefString unitInstVec;
    RefTMap_RefString instF2aVec;
    RefTMap_RefString simpleAssignStmt;
    RefTMap_RefString_RefTVec opExprAssStmtMap;
    RefTMap_RefString_RefTVec concatAssStmtMap;
    RefTMap_RefString_RefTVec replicAssStmtMap;
    
    RefTMap_RefString_RefTVec portDataMap; 
    RefTMap_RefString_RefTMap  unitPortDeclMap; 
    RefTMap_RefString_RefTVec sigDataMap; 
    RefTMap_RefString_RefTMap  unitSigDeclMap; 
    RefString sigName;
    //RefTMap_RefString_RefTMap unitDeclInstMap;
    // RefTMap_RefString_RefTMap ifcDeclInstMap;
    //RefTMap_RefString_RefTVec unitInstDataMap;
    RefTMap_RefString_RefTMap_RefString unitDeclInstF2aMap;
    RefTMap_RefString unitInstF2aMap;
    RefTMap_RefString_RefTMap_RefString unitInstMap;
    RefTMap_RefString_RefTMap_RefString unitDeclAssignStmt;

    RefTMap_RefString_RefTMap_RefString unitIfcInstMap;
    RefTMap_RefString_RefTMap unitDeclOpExpr;
    RefTMap_RefString_RefTMap unitDeclConcat;
    RefTMap_RefString_RefTMap unitDeclReplic;
    //-----vectors-------------//
    RefTVec_RefString vecData;
    RefTMap_RefString_RefTVec vecDeclMap;
    RefTMap_RefString_RefTMap vectorsMap;
    RefTVec_RefMap vecList;

    //----------tb signals----//
    RefTVec_RefString tbSigDataVec;
    RefTMap_RefString_RefTVec tbSigDataMap; 

    //-----------op expr------------//
    RefTVec_RefString opExprVec;
    TInt c_num;
    RefTVec_RefString concatVec;
    RefTVec_RefString replicVec;
    TBool m_RhsIsOpExpr;
    TBool m_RhsIsConcat;
    TBool m_RhsIsReplic;
    TBool m_isNum;
    //------interfaces-----------//
    vector<RefString> ifcVec;
    RefTMap_RefString_RefTVec ifcPortDataMap; 
    RefTMap_RefString_RefTMap  ifcPortDeclMap; 
    RefTVec_RefString ifcPortDataVec;
    //------------signal group--------------//
    vector<RefString> sgVec;
    RefTMap_RefString_RefTVec sgSigDataMap; 
    RefTMap_RefString_RefTMap  sgSigDeclMap; 
    RefTMap_RefString_RefTMap_RefString unitSgInstMap;
    RefTVec_RefString sgSigDataVec;
    RefTMap_RefString sgInstMap;
    //-----------attributes----------------//
    RefTMap_RefString attributeMap;
    RefTMap_RefString_RefTMap_RefString unitDeclAttrMap;
    //DUT instances
    vector<RefString> dutInstNameVec;
    //Unit  ports
    vector<RefString> unitPorts;
    vector<RefString> portTypeVec;
    vector<RefString> portDirVec;
    vector<TInt> portWidthVec;

    NSCSLOm::RefTVec_RefCSLOmExprLink inPorts;
     vector<string> inIfcPorts;  //ports from interface
    vector<RefString> inPortTypeVec;
    vector<RefString> inIfcPortTypeVec;  //ports from interface
    vector<TInt> inPortWidthVec;
    //Unit output ports
    
    NSCSLOm::RefTVec_RefCSLOmExprLink outPorts;
    vector<string>  outIfcPorts; //ports from interface
    vector<RefString> outPortTypeVec;
    vector<RefString> outIfcPortTypeVec; //ports from interface
    vector<TInt> outPortWidthVec;
    //unit instances vector
    vector<RefString> unitVec;
    vector<std::string> m_vectors;
    std::ostream *out; //MS added

    //TB 
    RefTMap_RefString dutName_dutInst;
    RefTMap_RefString dutName_dutClk;
    //Numbers
    TInt m_num32value;
    TInt m_num32width;
    TInt m_num32baseType;
    TBool m_num32signed;
    TBool m_expandNum32;
    RefString m_num32TempStr;
    TInt m_num32TempWidth;
    std::stringstream m_num32Stream;
    TBool  m_RhsIsNumber;
    RefString m_binNum;
    RefString  m_lhs,m_rhs;

  TBool file;
  TBool isTb;
  NSCSLOm::RefCSLOmBase m_cslCurrParent;
  //output control
  std::string m_outputPath;
  // std::string outPath;
  RefString m_moduleFileName;
  std::string m_systemCPath;
  RefTVec_RefString m_dutNames;
  RefString m_tbClockName;
  //signal group
  RefString m_sgName;
  RefString m_sgInst;
  //bitRange
  RefString m_brName;  
  RefString_TInt_RefMap bitrangeMap;
  //RefTVec_TInt brVec;
  vector<RefString> brNameVec;

  //used for template
  string csl_file_name;
  const char* file_name;
  ofstream cslCode;
  

  private:
    void formal2ActualConcatReplicationCheck(NSCSLOm::RefCSLOmExprLink formal, NSCSLOm::RefCSLOmExpr actual, NSCSLOm::RefCSLOmUnitDecl formalUnit, NSCSLOm::RefCSLOmUnitDecl actualUnit);
    void checkConcatForObjects(NSCSLOm::RefCSLOmExprConcat);
    void checkIfc2IfcOrSgf2a(NSCSLOm::RefCSLOmExprLink, NSCSLOm::RefCSLOmExprLink, NSCSLOm::RefCSLOmUnitDecl, NSCSLOm::RefCSLOmUnitDecl);
    void cslFileName(std::string filename);

    NSCSLOm::RefCSLOmStmtAssign m_lastStmtAssignVisited;

    TBool m_multipleConcatsInStmtAssign;
    /**
     * flag stating that we have only objects inside a lhs concat assign stmt 
     */
    TBool m_lhsConcatAssignAllObjects;
    /**
     * flag stating that we have yet to visit the lhs concat child of an assign
     */
    TBool m_lhsConcatAssignVisited;
    /**
     * flag stating that lhs of assign statement is concat
     */
    TBool m_lhsAssignStmtConcat;
    /**
     * flag stating that we are inside a statement
     */
    TBool m_insideAssignStmt;
    /**
     * flag stating that we are inside a formal to actual
     */
    TBool m_insideFormalToActual;
    /**
     * flag stating that we are inside a testbench scope
     */
    TBool m_insideTestbench;
    /**
     * flag stating that we are inside a testbench scope
     */
    TBool m_insideIfc;
    /**
     * flag stating that a memory map is present in the design
     */
    TBool m_memoryMapPresent;
    /**
     * flag stating that we are inside an isa_element of type instruction
     * and the name of the instruction
     */
    TBool m_insideIsaElemInstr;
    /**
     * name of the last port or signal visited 
     * to be used for parameter error throwing
     */
    RefString m_lastPSvisited;
    RefString m_isaElemInstrName;
    /**
     * flag stating we are inside an isaField scope 
     */
    TBool m_insideIsaField;
    /**
     * flag stating that an isa element is awaiting his children on the 
     * first level to add their widths
     */
    TBool m_isaElemWait;
    /*
     * these are for checking that the clock name in the dut is
     * the same as in testbench.
     * Ofcourse there can be multiple dut's with multiple clocks
     * so it checks that atleast a clock in the dut has the same 
     * name as the one in the testbench.
     */
    int vCnt;
    RefTVec_RefString m_dutClockNames;
   
    RefTVec_TUInt m_dutClockCount;
    NSCSLOm::RefTVec_RefCSLOmExprLink m_assPorts;
    NSCSLOm::RefTVec_RefCSLOmBase m_assVectors;
    NSCSLOm::RefTMap_RefCSLOmSignal_ECSLOmPortDirection m_connectedSignals;
    /*
     * 3 ints keeping lowest field position with enum item and
     * highest field position with variable items
     * and the name of the field for error throwing
     */
    TInt m_currentEnumItemFieldPosition;
    TInt m_currentNormalFieldPosition;
    TInt m_currentPosition;
    RefString m_normalFieldName;
    RefString m_enumItemFieldName;
    /*
     * 1 vector that will act as a stack keeping the widths of the
     * hierarchical isaFields.
     * Theese are checked in after traversal of the spec isaField. 
     */
    RefTVec_TInt m_isaFieldHierSizes;
    /**
     * Vector for keeping the current instruction 
     */
    NSCSLOm::RefTVec_RefCSLOmField m_curInstrFields;
    /**
     * Pointer to the isa prefix check 
     */
    RefCSLOmIsaPrefixTree m_isaPrefixTree;
    /**
     * Pointer to the isa prefix check 
     */
    TBool m_prefixTreeHasAtleastOneInstr;
    /**
     * Number of the total instruction being implemented within the prefix check
     */
    TInt m_prefixIsaInstrNo;
    /**
     *  The width of the root format in design
     */
    TInt m_rootFormatWidth;
    /**
     * added widths
     */
    TInt m_isaElemHierAddedWidths;
    /**
     * flag stating that we are inside of an isa element
     */
    TBool m_insideIsaElement;
    /**
     * pointer to the previously visited isa element
     */
    NSCSLOm::RefCSLOmIsaElement m_prevIsaElement;
    /**
     * counter of isa root elements (there shouldn't be more than one)
     */
    TInt m_isaElemRootCount;
    
    /*
     * counter of dut's in design
     */
    TInt m_dutCount;

    /*
     * counter of memory map pages in the design
     */
    TInt m_memMapPagesCount;
    /*
     * counter of vectors in the design
     */
    TInt m_vectorsInWholeDesignCount;
    /*
     * counter of unit instances in the design
     */
    TInt m_unitInstancesCount;
    /*
     * counter of stimulus vectors in the design
     */
    TInt m_stimCount;
    /*
     * counter of expected vectors in the design
     */
    TInt m_expectCount;
    /*
     * counter of testbenches in the design
     */
    TInt m_testbenchesInWholeDesignCount;
    
   

    //visitor functions
  private:    
    void beforeTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     );
    void beforeTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void beforeTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           );
    void beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         );
    void beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    void beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            );  
    void beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    void beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         );
    void beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        );    
    void beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     );
    void beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         );
    void beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          );    
    void beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      );    

    void inTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     );
    void inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    void inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    void inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    void inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void inTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           );
    void inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         );
    void inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    void inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void inTraversal(const NSCSLOm::RefCSLOmList                            & list                            );  
    void inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    void inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void inTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        );
    void inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         );
    void inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        );    
    void inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     );
    void inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         );
    void inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          );    
    void inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      );    

    void afterTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     );
    void afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    void afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    void afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void afterTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           );
    void afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         );
    void afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    void afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            );  
    void afterTraversal(const NSCSLOm::RefCSLOmSetCommand                      & setCommand                      );
    void afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    void afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        );
    void afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         );
    void afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        );    
    void afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     );
    void afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         );
    void afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          );    
    void afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      );    


};

}
#endif
