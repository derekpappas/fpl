// Copyright (c) 2005, 2006, 2007, 2008 Fastpathlogic
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
 *   CSLOM CSIM CPP Code Generator
 *   Authors: AndreiB 
 *   2007-2008
 */

#include "CSIM_CPP_Generator.h"


using namespace NSCSLOm;
using namespace NSCSLOmVisitor;
using namespace std;
using namespace boost;

namespace NSCsimCppGenerator {

/**********************************
 * class CsimCppGenerator
 **********************************/
CsimCppGenerator::CsimCppGenerator(const string& path): m_stringStreamHdr(RefStringstream(new stringstream())),
                                                        m_stringStreamCpp(RefStringstream(new stringstream())),
                                                        m_outputFileStreamHdr(RefOfstream(new ofstream())),
                                                        m_outputFileStreamCpp(RefOfstream(new ofstream())),
                                                        //m_outputMakefile(RefOfstream(new ofstream())),
                                                        m_path(RefString(new string(path))),
                                                        m_includePath(RefString(new string(""))),
                                                        m_compileScriptSrc(RefString(new string(""))),
                                                        m_compileScriptDest(RefString(new string(""))),
                                                        m_depth(ZERO),
                                                        m_sourceNames(new TVec_RefString()),
                                                        m_instExprLinks(NSCSLOm::RefTVec_RefCSLOmExprLink(new NSCSLOm::TVec_RefCSLOmExprLink())),
                                                        m_idParentType(NSCSLOm::TYPE_ALL_TYPES),
                                                        m_ifcPrefixes(RefTVec_RefString(new TVec_RefString())),
                                                        m_sigPrefixes(RefTVec_RefString(new TVec_RefString())),
                                                        m_unitVerifCompNames(RefTVec_RefString(new TVec_RefString())),
                                                        m_unitIsTop(FALSE)
                                                   
{
  enableNoTestBench();
  //for internal use
  //NOTE: need a way to specify the include path for csim headers
#ifndef __RELEASE_VERSION
  char* envName = getenv("WORK");
  if(envName != NULL){
    //(*m_includePath).append(envName);
    //(*m_includePath).append("/trunk/src/csim/");

    (*m_compileScriptSrc).append(envName);
    (*m_compileScriptSrc).append("/trunk/build_utils/compile.pl");

  }
#endif

}

void CsimCppGenerator::setGeneratePath(RefString path){
  m_generatePath = path;
}

//helper functions

std::string CsimCppGenerator::signalType(int width, ECPPGenExpandType expandType, ECPPGenConnectableType type) {
  //sizes in bits
  TInt sizeTBool     = sizeof(TBool    );
  TInt sizeTChar     = sizeof(TChar    ) * 8;
  TInt sizeTShort    = sizeof(TShort   ) * 8;
  TInt sizeTInt      = sizeof(TInt     ) * 8;
  TInt sizeTLongLong = sizeof(TLongLong) * 8;
  
  //temp string
  std::string tempStr = "", retStr = "";

  //less than or eq to 1 bit
  if (width <= sizeTBool){ 
    //TBool - in h file
    tempStr = "TBool";
  }
  else if (width <= sizeTChar){
    //TChar
    tempStr = "TChar";
  }
  else if (width <= sizeTShort){
    //TShort
    tempStr = "TShort";
  }
  else if (width <= sizeTInt){
    //TInt
    tempStr = "TInt";
  }
  else if (width <= sizeTLongLong){
    //TLongLong
    tempStr = "TLongLong";
  }
  else {
    //ASSERT here
    //ASSERT(FAIL,"Illegal range received");
    DCERR("WARNING: The range exceeds the maximum supported - will use Long Long");
    tempStr = "TLongLong";
  }
  //usually thisn is the return: in context is "RefCsimPortTBool " (full case)
  if(expandType == CPP_GEN_EXPAND_FULL){
    switch(type){
      case CPP_GEN_CONNECTABLE_PORT   : retStr = "RefCsimPort" + tempStr + " "  ; break;
      case CPP_GEN_CONNECTABLE_SIGNAL : retStr = "RefCsimSignal" + tempStr + " "; break;
      default                         : ASSERT(FALSE,"Wrong parameter in function"); break;
    }
    return retStr;
  }
  //sometimes this is required: "TBool" (lite case)
  //see port allocation
  else if(expandType == CPP_GEN_EXPAND_LITE){
    return tempStr;
  }
  
}

//csim generator

void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
   (*m_compileScriptDest).append(*m_path);
   //START OF TO BE REMOVED - MAIN
   //RefString dirGen = RefString(new std::string(*m_path));
   //(*dirGen).append("/generated");
   //fs::create_directory(*dirGen);
   //END OF TO BE REMOVED - MAIN 
}

void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {
  RefCSLOmBase parent = id->getParent();

  RefString idName = id->getName();

  //Checking if we are identifying a Unit Decl 
  //in this special case, the output streams have to be properly initialized  
  if(parent.get()){
    if(parent->isUnitDecl()){
      //to be used later
      m_unitName = idName;
    }
    else if(parent->isPort()){
      RefString portName = RefString(new std::string(""));
      if( m_ifcPrefixes.get() && m_ifcPrefixes->size() >= 1) {
        for(TVec_RefString_const_iter it = m_ifcPrefixes->begin(); it < m_ifcPrefixes->end(); ++it) {
          portName->append(*(*it));
          portName->append("_");
        }
      }
      portName->append(*idName);
      *(m_outputFileStreamHdr) << *(portName);
      m_portName = portName;
    }
    else if(parent->isSignal()){
      RefString sigName = RefString(new std::string(""));
      if( m_sigPrefixes.get() && m_sigPrefixes->size() >= 1) {
        for(TVec_RefString_const_iter it = m_sigPrefixes->begin(); it < m_sigPrefixes->end(); ++it) {
          sigName->append(*(*it));
          sigName->append("_");
        }
      }
      sigName->append(*idName);
      *(m_outputFileStreamHdr) << *(sigName);
      m_sigName = sigName;
    }
  }
}

void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {
  RefCSLOmBase parent = exprLink->getParent();
  if(parent.get() && parent->getType() == TYPE_UNIT_INSTANTIATION) {
    indt <RefOfstream> (1, m_outputFileStreamHdr);
    //*(m_outputFileStreamHdr) << *(exprLink->getLocalNameID()->getName());
    *(m_outputFileStreamHdr) << "RefCsimUnit";
    *(m_outputFileStreamHdr) << " ";
  }
}

void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
  //retrieve unit type
  m_unitType = unitDecl->getUnitType();
  //check to see if it's top
  m_unitIsTop = unitDecl->isTopUnit();

  //disable testbench output
  //TBool unitDeclFlag = isUnitDeclInTraversalEnabled();
  //TBool unitInfoFlag = isUnitInfoInTraversalEnabled();

  m_unitCnt  = 0;
  m_unitHasVerifComp = FALSE;
  //inc indent size
  m_depth++;
  m_unitConnections    = RefStringstream(new std::stringstream());
  m_portAllocations    = RefStringstream(new std::stringstream());
  m_signalAllocations  = RefStringstream(new std::stringstream());
  m_instanceReg        = RefStringstream(new std::stringstream());
  m_clkConnect         = RefStringstream(new std::stringstream());
  m_defaultInits       = RefStringstream(new std::stringstream());
  m_addPortConnectable = RefStringstream(new std::stringstream());
  m_addSigConnectable  = RefStringstream(new std::stringstream());
  m_vwBuildCall        = RefStringstream(new std::stringstream());

  //TEST
  RefTVec_WeakCSLOmVerifCompInfo verifComp = unitDecl->getVerifComps();
  if(verifComp.get()){
    m_unitHasVerifComp = TRUE;
    for(TVec_WeakCSLOmVerifCompInfo_const_iter iter = verifComp->begin(); iter < verifComp->end(); ++iter){
      m_unitVerifCompNames->push_back(RefString(new std::string(*((iter->lock())->getName()))));
    }
  }

  //TEMPORARY "HACK"
  RefTVec_RefCSLOmUnitInstantiation unitInstantiations = unitDecl->getInstantiations();
  if(unitInstantiations.get()){
    for(TVec_RefCSLOmUnitInstantiation_const_iter iter = unitInstantiations->begin(); iter < unitInstantiations->end(); ++iter){
      m_instExprLinks->push_back((*iter)->getUnitDeclExprLink());
    }
  }
}

void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
  //signal attribute:
  m_signalAttr = signal->getSignalAttr();

  if(NSCSLOm::CSLOmSimpleBitRange::BR_SIMPLE == signal->getBitRange()->getBrType()){
    m_sigWidth = CSLOmNumber::cast(CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(),signal->getWidth()->doParamEval(signal)))->getValue();
  }
  else{
    DCERR("WARNING: Csim gen does not yet support multidim bitranges - setting width to 1");
    m_sigWidth = 1;
  }
  m_sigCnt = 0;

  indt <RefOfstream> (1, m_outputFileStreamHdr);
  *(m_outputFileStreamHdr) << signalType(m_sigWidth, CPP_GEN_EXPAND_FULL, CPP_GEN_CONNECTABLE_SIGNAL);

}    
void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {
  *(m_outputFileStreamHdr) << *(unitInst->getName());
  *(m_outputFileStreamHdr) << ";" << endl;
  //instance registration is written in the stringstream
  indt <RefStringstream> (m_depth, m_instanceReg);
  *(m_instanceReg) << *(unitInst->getName()) << "->setParent(getThis());" << std::endl;
  indt <RefStringstream> (m_depth, m_instanceReg);
  *(m_instanceReg) << *(unitInst->getName()) << "->setInstanceName(RefString(new std::string(\"" << *(unitInst->getName()) << "\")));" << std::endl;
  indt <RefStringstream> (m_depth, m_defaultInits);
  *(m_defaultInits) << *(unitInst->getName()) << "->defaultInitialize();" << std::endl;

  RefTMap_RefCSLOmExprLink_RefCSLOmExpr connectionsMap = unitInst->getConnectionMap();
  if(connectionsMap.get()){
    for(TMap_RefCSLOmExprLink_RefCSLOmExpr_const_iter iter = connectionsMap->begin(); iter != connectionsMap->end(); ++iter){
      //WARNING: temporary fix
      if (iter->second->isExprLink()) {
        indt <RefStringstream> (m_depth + 1, m_unitConnections); //FIX!!!
        indt <RefStringstream> (m_depth + 1, m_clkConnect); //FIX!!!


        RefCSLOmBase tempValue = (iter->first)->getValue();
        RefCSLOmBase actual = CSLOmExprLink::cast(iter->second)->getValue();
        RefCSLOmPortDecl actualPort;
        if(actual->isPort()){
          actualPort = CSLOmPortDecl::cast(actual);
        }
        if(tempValue.get() && tempValue->isPort()){
          if(actualPort.get() && NSCSLOm::ATTR_CLK == actualPort->getAttr()){
            (*m_clkConnect) << *(CSLOmExprLink::cast(iter->second)->getName()) << "->connectToClock(" << *(unitInst->getName()) << ", " << "(boost::static_pointer_cast<" << *(unitInst->getUnitDecl()->getName()) << ">(" << *(unitInst->getName()) << "))->" << *((iter->first)->getName()) << ", RefString(new std::string(\"" << *((iter->first)->getName()) << "\")));" << std::endl;
          }
          else{
            (*m_unitConnections) << *(CSLOmExprLink::cast(iter->second)->getName()) << "->connect(" << "boost::static_pointer_cast<CsimPort" << signalType(CSLOmNumber::cast(CSLOmExpr::getValueForInstance(unitInst,CSLOmPortDecl::cast(tempValue)->getWidth()->doParamEval(tempValue)))->getValue(), CPP_GEN_EXPAND_LITE, CPP_GEN_CONNECTABLE_PORT) << ">(" << *(unitInst->getName()) << "->getSignalByName(RefString(new std::string(\"" << *((iter->first)->getName()) << "\")))));" << std::endl;
          }
        }
        else{
          DCERR("WARNING: Formal to actual member is not port: Output is corrupted! - This will be fixed later");
        }
      }
    }
  }
}
    
void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
}

void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
  //loading the prefix vector with the current signal name
  //to be used as prefixes for signals
  m_sigPrefixes->push_back(groupSignal->getName());
}
    
void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {
  //loading the prefix vector with the current interface name
  //to be used as prefixes for ports
  if(!interface->isDefaultIfc()) {
    m_ifcPrefixes->push_back(interface->getInterfaceName());
  }
}    
void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
  //checking the attribute
  //eg. - check if it's of type clock - so we can generate a csimclock
  //Note: using the same member as for signal
  m_signalAttr = portDecl->getAttr();
  
  //bitrange check
  if(NSCSLOm::CSLOmSimpleBitRange::BR_SIMPLE == portDecl->getBitRange()->getBrType()){
    m_portWidth = CSLOmNumber::cast(CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(),portDecl->getWidth()->doParamEval(portDecl)))->getValue();
  }
  else{
    DCERR("WARNING: Csim gen does not yet support multidim bitranges - setting width to 1");
    m_portWidth = 1;
  }
  //m_portDir = PORT_DIR_UNDEFINED;
  m_portDeclCnt = 0;
  ECSLOmPortDirection tempPortDir = portDecl->getPortDirection();
  switch(tempPortDir){
    case NSCSLOm::INPUT  : m_portDirName = RefString(new std::string("PORT_DIR_INPUT")) ; break;
    case NSCSLOm::OUTPUT : m_portDirName = RefString(new std::string("PORT_DIR_OUTPUT")); break;
    case NSCSLOm::INOUT  : m_portDirName = RefString(new std::string("PORT_DIR_INOUT")) ; break;
    default : ASSERT(FAIL,"Invalid port direction received");
  }

  indt <RefOfstream> (1, m_outputFileStreamHdr);
  switch (m_signalAttr){
    case NSCSLOm::ATTR_UNDEFINED : *(m_outputFileStreamHdr) << signalType(m_portWidth, CPP_GEN_EXPAND_FULL, CPP_GEN_CONNECTABLE_PORT);  break;
    case NSCSLOm::ATTR_EN        : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_STALL     : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_PE        : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_PS        : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_MS        : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_DEC       : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_CLK       : *(m_outputFileStreamHdr) << "RefCsimClock " ;                                                        break; 
    case NSCSLOm::ATTR_RST       : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_WR_EN     : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    default                      : ASSERT(FALSE, "[CSIM] : Wrong attribute for signal");                                                break;
  }

  //*(m_outputFileStreamHdr) << signalType(m_portWidth, CPP_GEN_EXPAND_FULL, CPP_GEN_CONNECTABLE_PORT);

  //*(m_outputFileStreamHdr) << *(portDecl->getName());
  
  //*(m_outputFileStreamHdr) << m_stringStreamHdr->str();
}    
void CsimCppGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {
  m_vectorName = vectorInfo->getName();
  m_vectorUnitName = vectorInfo->getModuleName()->getName();
  m_stimulusElseExpected = TRUE;//defaults to stimulus
  m_vectorEdgeType = NSCSLOm::CSLOmVectorInfo::VC_EDGE_UNDEFINED;
  //Initialising flags
  m_stimulusElseExpected = vectorInfo->getStimulusElseExpected();

  m_vectorEdgeType = vectorInfo->getCaptureEdgeType();

  NSCSLOm::CSLOmVerifCompInfo::ECSLOmVCRadix vectorRadix = vectorInfo->getRadix();
  if(NSCSLOm::CSLOmVerifCompInfo::VC_RADIX_BIN == vectorRadix){
    m_vectorRadixName = RefString(new std::string("NSCsimLib::T_BIN"));
  }
  else if(NSCSLOm::CSLOmVerifCompInfo::VC_RADIX_HEX == vectorRadix){
    m_vectorRadixName = RefString(new std::string("NSCsimLib::T_HEX"));
  }
  //WARNING: this last case has to be removed after cslom fix
  else{
    m_vectorRadixName = RefString(new std::string("NSCsimLib::T_BIN"));
  }

  if(m_stimulusElseExpected){
    m_portsVec = vectorInfo->getDUTInputPorts();
    //initializing vector type name
    m_vectorTypeName = RefString(new std::string("NSCsimLib::VECTOR_TYPE_STIM"));
  }
  else{
    m_portsVec = vectorInfo->getDUTOutputPorts();
    //initializing vector type name
    m_vectorTypeName = RefString(new std::string("NSCsimLib::VECTOR_TYPE_EXPECT"));
  }
  
  RefCSLOmNumber vecID = vectorInfo->getNumericID();
  if(vecID.get()){
    m_vecID = vecID->getValue();
  }
  else{
    m_vecID = 0; //temporary for now
  }

  RefCSLOmNumber vecVer = vectorInfo->getVersion();
  if(vecVer.get()){
    m_vecVer = vecVer->getValue();
  }
  else{
    m_vecVer = 0; //temporary for now
  }

  RefCSLOmNumber vecMaxEvents = vectorInfo->getMaxEventsCount();
  if(vecMaxEvents.get()){
    m_vecMaxEvents = vecMaxEvents->getValue();
  }
  else{
    m_vecMaxEvents = 1; //temporary for now
  }
  
  //Init streams - these will write to the same file 
  //in different locations in a for loop so will be used as buffers
  m_vectorWriteFuncStream = RefStringstream(new std::stringstream());
  m_vectorConnectFuncStream = RefStringstream(new std::stringstream());
  m_vectorDefaultInitFuncStream = RefStringstream(new std::stringstream());
}



void CsimCppGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitDecl                            & unitDecl                        ) {
  //here the inherited type is written to the output stream
  m_unitCnt++;
  if(m_unitCnt == 1){
    //if(CSLOmUnitDecl::CSL_UNIT_DECL == m_unitType || CSLOmUnitDecl::CSL_VECTOR == m_unitType){
    //creating output streams
      //section 1 : initialize header file output stream
      RefString completePathHdr = RefString(new string(*m_generatePath));
      //completePathHdr->append(*parentName);
      //appending 
      completePathHdr->append(*m_unitName);
      completePathHdr->append(".h");
      m_outputFileStreamHdr = RefOfstream(new ofstream((*completePathHdr).c_str()));

      //section 2 : initialize cpp file output stream
      RefString completePathCpp = RefString(new string(*m_generatePath));
      //completePathCpp->append(*parentName);
      completePathCpp->append(*m_unitName);
      completePathCpp->append(".cpp");
      m_outputFileStreamCpp = RefOfstream(new ofstream((*completePathCpp).c_str()));

      //begining to write in stream
      //incguards
      RefString guardName = RefString(new std::string(*(refStrToUpper(m_unitName))));
      (*(guardName)).append("_H");
      
      *(m_outputFileStreamHdr) << "#ifndef " << *(guardName) << std::endl;
      *(m_outputFileStreamHdr) << "#define " << *(guardName) << std::endl << std::endl;

      *(m_outputFileStreamHdr) << "#include \"" << *(m_includePath) << "CsimSignal.h\"" << std::endl;
      *(m_outputFileStreamHdr) << "#include \"" << *(m_includePath) << "CsimPort.h\"" << std::endl;
      if(CSLOmUnitDecl::CSL_VECTOR == m_unitType){
        *(m_outputFileStreamHdr) << "#include \"" << *(m_includePath) << "CsimVectorWriter.h\"" << std::endl;
      }
      //performing unit decl type specific tasks
      if(CSLOmUnitDecl::CSL_UNIT_DECL == m_unitType){
        //printing unit instance includes 
        //If the unit instantiates other units the header from those files is needed to find the types
        if( m_instExprLinks.get()){
          for(NSCSLOm::TVec_RefCSLOmExprLink_const_iter iter = m_instExprLinks->begin(); iter < m_instExprLinks->end(); ++iter){
            *(m_outputFileStreamHdr) << "#include \"" << *((*iter)->getName()) << ".h\"" <<std::endl;
          }
        }
        //printing unit instance includes
        //If the unit has any vector associated to it
        if(m_unitHasVerifComp && m_unitVerifCompNames.get()){
          for(TVec_RefString_const_iter iter = m_unitVerifCompNames->begin(); iter < m_unitVerifCompNames->end(); ++iter){
            *(m_outputFileStreamHdr) << "#include \"" << *(*iter) << ".h\"" <<std::endl;
          }
        }
      }
      *(m_outputFileStreamHdr) << std::endl;
      *(m_outputFileStreamHdr) << "using namespace NSCsimLib;" << std::endl << std::endl;
      //adding csim gen specific namespace
      *(m_outputFileStreamHdr) << "namespace NSCsimGen {" << std::endl << std::endl;
      //*(m_outputFileStreamHdr) << "#include \"CsimUnit.h\"" << std::endl << std::endl;
      *(m_outputFileStreamHdr) << "class " << *(m_unitName) << " : public ";
      //including h file in cpp
      *(m_outputFileStreamCpp) << "#include \"" << *(m_unitName) << ".h" << "\"" << std::endl << std::endl;
      *(m_outputFileStreamCpp) << "namespace NSCsimGen {" << std::endl << std::endl;

      //creating the vector of unit names
      //WARNING not used anywhere: REMOVE?
      //m_sourceNames->push_back(idName);

      switch(m_unitType){
        case CSLOmUnitDecl::CSL_UNIT_DECL : 
          *(m_outputFileStreamHdr) << "CsimUnit {" << std::endl;
          *(m_outputFileStreamHdr) << "public:" << std::endl;
          break;
        case CSLOmUnitDecl::CSL_VECTOR    : 
          *(m_outputFileStreamHdr) << "CsimVectorWriter {" << std::endl; 
          //call indent with appropriate size and output stream
          indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
          *(m_outputFileStreamHdr) << "public:" << std::endl;
          break;     
      }
    }
}

void CsimCppGenerator::inTraversal(const NSCSLOm::RefCSLOmSignal                            & signal                        ) {
  m_sigCnt++;
  if(m_sigCnt == 1){
    //starting signal allocations in cpp
    indt <RefStringstream> (m_depth, m_signalAllocations);
    *(m_signalAllocations) << *(m_sigName) << " = CsimSignal" <<  signalType(m_sigWidth, CPP_GEN_EXPAND_LITE, CPP_GEN_CONNECTABLE_SIGNAL)  << "::build(RefString(new std::string(\"" << *(m_sigName) << "\"))," << m_sigWidth << ", getThis());" << std::endl;
    indt <RefStringstream> (m_depth, m_addSigConnectable);
    *(m_addSigConnectable) << "addConnectable(" << (*m_sigName) << ");" << std::endl;
  }                      
} 


void CsimCppGenerator::inTraversal(const NSCSLOm::RefCSLOmPortDecl                            & portDecl                        ) {
  m_portDeclCnt++;
  if(m_portDeclCnt == 1){
  switch (m_signalAttr){
    case NSCSLOm::ATTR_UNDEFINED : {
      //starting port allocations in cpp
      indt <RefStringstream> (m_depth, m_portAllocations);
      *(m_portAllocations) << *(m_portName) << " = CsimPort" <<  signalType(m_portWidth, CPP_GEN_EXPAND_LITE, CPP_GEN_CONNECTABLE_PORT)  << "::build(RefString(new std::string(\"";
      *(m_portAllocations) << *(m_portName)  << "\"))," << m_portWidth << ", getThis(), " << *(m_portDirName)  << ");" << std::endl;
      indt <RefStringstream> (m_depth, m_addPortConnectable);
      *(m_addPortConnectable) << "addConnectable(" << *(m_portName) << ");" << std::endl;
    }
      break;
    case NSCSLOm::ATTR_EN        : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_STALL     : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_PE        : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_PS        : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_MS        : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_DEC       : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_CLK       : {
      //only do this when we are in top unit - otherwise just leave it as a pointer and connect it to this
      if(m_unitIsTop){
        indt <RefStringstream> (m_depth, m_signalAllocations);
        *(m_signalAllocations) << *(m_portName) << " = CsimClock::build(2, (RefString(new std::string(\"" << *(m_portName) << "\"))), getThis());" << std::endl;
      }
    }
      break; 
    case NSCSLOm::ATTR_RST       : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    case NSCSLOm::ATTR_WR_EN     : DCERR("WARNING [CSIM] : You have selected a signal type not handled by the Csim generator");         break; 
    default                      : ASSERT(FALSE, "[CSIM] : Wrong attribute for signal");                                                break;
  }


  }
}

void CsimCppGenerator::inTraversal(const NSCSLOm::RefCSLOmVectorInfo                          & vectorInfo                      ) {

}

void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmDesign                           & design                          ) {
  //copying compile script in location
  RefString copyCmd = RefString(new std::string("cp "));
  (*copyCmd).append(*m_compileScriptSrc);
  (*copyCmd).append(" ");
  (*copyCmd).append(*m_compileScriptDest);
  
  system(copyCmd->c_str());
  
  //writing in the actual makefile
  //WARNING DISABLED
  //*(m_outputMakefile) << "CC=g++" << std::endl;
  //*(m_outputMakefile) << "CFLAGS=-c -Wall" << std::endl;
  //*(m_outputMakefile) << "LDFLAGS=" << std::endl;
  //*(m_outputMakefile) << "CSIM_LIB_DIR=$(WORK)" << std::endl;
  //*(m_outputMakefile) << "SOURCES=" << std::endl;
  //*(m_outputMakefile) << "OBJECTS=$(SOURCES:.cpp=.o)" << std::endl;
  //*(m_outputMakefile) << "EXECUTABLE=simulator" << std::endl;
  //
  //*(m_outputMakefile) << std::endl << "all $(SOURCES) $(EXECUTABLE)" << std::endl;
  //*(m_outputMakefile) << "\t$(CC) $(LDFLAGS) $(OBJECTS) -o $@" << std::endl;
  //
  //*(m_outputMakefile) << std::endl << ".cpp.o:" << std::endl;
  //*(m_outputMakefile) << "\t$(CC) $(CFLAGS) $< -o $@" << std::endl;
  //
  //*(m_outputMakefile) << std::endl << "clean:" << std::endl;
  //*(m_outputMakefile) << "\trm -rf *o simulator" << std::endl;
}

void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmIdentifier                       & id                              ) {
  //Resetting the m_idParentType
  //m_idParentType = TYPE_ALL_TYPES;
}
    
void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                         & unitDecl                        ) {
  //testing the unit type - the following output should only show up in UNIT_DECLs
  if(m_unitType == NSCSLOm::CSLOmUnitDecl::CSL_UNIT_DECL){
    //Writing pointers to the vector writers
    //Note: Appending 0 to vw instance names because of conflicts that 
    //appear should the instance have the same name as of the type
    if(m_unitHasVerifComp && m_unitVerifCompNames.get()){
      for(TVec_RefString_const_iter iter = m_unitVerifCompNames->begin(); iter < m_unitVerifCompNames->end(); ++iter){
        indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
        *(m_outputFileStreamHdr) << "RefCsimVectorWriter " << *(*iter) << "0;" << std::endl;
      }
    }

    indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
    *(m_outputFileStreamHdr) << "//functions" << std::endl;

    //writing default initialize function declaration in H file + indentation
    indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
    *(m_outputFileStreamHdr) << "void defaultInitialize();" << std::endl;  

    //writing connect connect function declaration in H file + indentation
    indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
    *(m_outputFileStreamHdr) << "void connect();" << std::endl;

    //writing allocate function declaration in H file + indentation
    indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
    *(m_outputFileStreamHdr) << "virtual void allocate() = 0;" << std::endl;

    //writing initialize function declaration in H file + indentation
    indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
    *(m_outputFileStreamHdr) << "virtual void initialize() = 0;" << std::endl;

    //writing execute function declaration in H file + indentation
    indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
    *(m_outputFileStreamHdr) << "virtual void execute() = 0;" << std::endl;

    indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
    *(m_outputFileStreamHdr) << "//constructor" << std::endl;
    indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
    *(m_outputFileStreamHdr) << *(m_unitName) << "() : CsimUnit(RefString(new std::string(\"" << *(m_unitName) << "\"))) {}" << std::endl;

    //defining initialize() function
    *(m_outputFileStreamCpp) << "void " << *(m_unitName) << "::defaultInitialize() {" << std::endl;  
    indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
    
    if(m_unitIsTop){
      *(m_outputFileStreamCpp) << "setInstanceName(RefString(new std::string(\"" << *(m_unitName) << "\")));" << std::endl;
    }

    indt <RefOfstream> (m_depth, m_outputFileStreamCpp);

    if(!m_portAllocations->str().empty()){
      *(m_outputFileStreamCpp) << "//port allocations" << std::endl;
      *(m_outputFileStreamCpp) << (m_portAllocations)->str();
      indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
      *(m_outputFileStreamCpp) << "//port registrations" << std::endl;
      *(m_outputFileStreamCpp) << (m_addPortConnectable)->str();
    }

    if(!m_signalAllocations->str().empty()){
      indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
      *(m_outputFileStreamCpp) << "//signal allocations" << std::endl;
      *(m_outputFileStreamCpp) << (m_signalAllocations)->str();
      indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
      *(m_outputFileStreamCpp) << "//signal registrations" << std::endl;
      *(m_outputFileStreamCpp) << (m_addSigConnectable)->str();
    }

    //build vector writers
    //Note: Appending 0 to vw instance names because of conflicts that 
    //appear should the instance have the same name as of the type
    if(m_unitHasVerifComp && m_unitVerifCompNames.get()){
      indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
      *(m_outputFileStreamCpp) << "//building vector writers" << std::endl;
      for(TVec_RefString_const_iter iter = m_unitVerifCompNames->begin(); iter < m_unitVerifCompNames->end(); ++iter){
        indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
        *(m_outputFileStreamCpp) << *(*iter) << "0 = buildVW(new " << *(*iter) << "(), getThis());" << std::endl;
      }
    }

    //initializers
    indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
    *(m_outputFileStreamCpp) << "//initializers" <<std::endl;
    indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
    *(m_outputFileStreamCpp) << "allocate();" <<std::endl;


    //instance registration
    if(!m_instanceReg->str().empty()){
      indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
      *(m_outputFileStreamCpp) << "//instance registration" << std::endl;
      *(m_outputFileStreamCpp) << (m_instanceReg)->str();
    }

    //clock connection
    if(!m_clkConnect->str().empty()){
      indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
      *(m_outputFileStreamCpp) << "//clock connections" << std::endl;
      *(m_outputFileStreamCpp) << (m_clkConnect)->str();
    }

    //instance registration
    if(!m_instanceReg->str().empty()){
      indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
      *(m_outputFileStreamCpp) << "//default initis" << std::endl;
      *(m_outputFileStreamCpp) << (m_defaultInits)->str();
    }


    indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
    *(m_outputFileStreamCpp) << "connect();" <<std::endl;
    indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
    *(m_outputFileStreamCpp) << "initialize();" <<std::endl;



    *(m_outputFileStreamCpp) << "}\n" << std::endl;
    //m_unitConnections->str("");

    //defining connect function
    *(m_outputFileStreamCpp) << "void " << *(m_unitName) << "::connect() {" << std::endl;
    *(m_outputFileStreamCpp) << (m_unitConnections)->str();
    *(m_outputFileStreamCpp) << "}" << std::endl;

    //ending unit cpp file - closing csim gen namespace
    *(m_outputFileStreamCpp) << "}" << std::endl;

    m_unitConnections->str("");
  }
  m_unitIsTop = FALSE;
  m_depth--;
  *(m_outputFileStreamHdr) << "};" << std::endl;
  //closing csim gen namespace
  *(m_outputFileStreamHdr) << "}" << std::endl << std::endl;
  *(m_outputFileStreamHdr) << "#endif" << std::endl;
  m_stringStreamHdr->str("");
  m_stringStreamCpp->str("");
}    
void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmSignal                           & signal                          ) {
  *(m_outputFileStreamHdr) << ";" << std::endl;
}
    
void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                     & unitInst                        ) {
  
}    

void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                      & groupSignal                     ) {
  if(m_sigPrefixes.get() && m_sigPrefixes->size() >= 1){
    m_sigPrefixes->pop_back();
  }
}

void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmInterface                        & interface                       ) {
  if(m_ifcPrefixes.get() && m_ifcPrefixes->size() >= 1) {
    m_ifcPrefixes->pop_back();
  }
}    
void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation                & unitInstantiation               ) {
}    

void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmPortDecl                         & portDecl                        ) {
  *(m_outputFileStreamHdr) << ";" << std::endl;
}

void CsimCppGenerator::afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                       & vectorInfo                      ) {
  TInt portWidth = 0;
  //buffer string - will be used to write the same thing in 2 streams
  RefString bufferStr = RefString(new std::string());
  //flag to be used in loop to detect last element
  TBool endVec = FALSE;
  //inc indent
  m_depth++;

  if(m_portsVec.get()){
    for(TVec_RefCSLOmExprLink_const_iter iter = m_portsVec->begin(); iter < m_portsVec->end(); ++iter){
      RefCSLOmBase currentPortAsBase = (*iter)->getValue();
      if(*iter == m_portsVec->back()){
        endVec = TRUE;
      }
      if(currentPortAsBase->isPort()){
        //call indent with appropriate size and output stream
        indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
        RefCSLOmPortDecl currentPort = CSLOmPortDecl::cast(currentPortAsBase);
        RefString currentPortName = currentPort->getName();
        portWidth = CSLOmNumber::cast(currentPort->getWidth()->doEval())->getValue();

        ECSLOmPortDirection tempPortDir = currentPort->getPortDirection();
        RefString portDirName = RefString(new std::string());
        switch(tempPortDir){
          case NSCSLOm::INPUT  : portDirName = RefString(new std::string("PORT_DIR_INPUT")) ; break;
          case NSCSLOm::OUTPUT : portDirName = RefString(new std::string("PORT_DIR_OUTPUT")); break;
          case NSCSLOm::INOUT  : portDirName = RefString(new std::string("PORT_DIR_INOUT")) ; break;
          default : ASSERT(FAIL,"Invalid port direction received");
        }

        //declaring the port with the appropriate type according to its width
        *(m_outputFileStreamHdr) << signalType(portWidth, CPP_GEN_EXPAND_FULL, CPP_GEN_CONNECTABLE_PORT) << *(currentPortName) << ";" << std::endl;
        
        //writing the write() function in the string stream
        //when the loop ends this gets dumped in the file stream
        //call indent with appropriate size and output stream
        indt <RefStringstream> (m_depth, m_vectorWriteFuncStream);

        *(m_vectorWriteFuncStream) << "(*outputStream) << *(convertValueTo(" << *(currentPortName) << "->getValue(), " << "dataRadix, " << portWidth << ")) << ";
        if(!endVec){
          *(m_vectorWriteFuncStream) << "\"_\";" << std::endl; 
        }
        else{
          *(m_vectorWriteFuncStream) << " std::endl;" << std::endl;
        }

        //writing the defaultConnect() function in the string stream
        //when the loop ends this gets dumped in the file stream
        //call indent with appropriate size and output stream
        indt <RefStringstream> (m_depth, m_vectorConnectFuncStream);

        *(m_vectorConnectFuncStream) << *(currentPortName) << "->connect(boost::static_pointer_cast<CsimPort" << signalType(portWidth, CPP_GEN_EXPAND_LITE, CPP_GEN_CONNECTABLE_PORT) << ">(associatedUnitInst->getSignalByName(RefString(new std::string(\"" << *(currentPortName) << "\")))));" << std::endl;
        

        //writing the defaultInitialize() function stream
        indt <RefStringstream> (m_depth, m_vectorDefaultInitFuncStream);
        *(m_vectorDefaultInitFuncStream) << *(currentPortName) << " = CsimPort" << signalType(portWidth, CPP_GEN_EXPAND_LITE, CPP_GEN_CONNECTABLE_PORT) << "::build(RefString(new std::string(\"" << *(currentPortName) << "\"))," << portWidth << ", unit, " << *(portDirName) << ");" << std::endl;
      }
    }
  }

  //writing defaultInitialize() function definition in CPP file
  *(m_outputFileStreamCpp) << "void " << *(m_vectorName) << "::defaultInitialize(RefCsimUnit unit) {" << std::endl; 
  //copying stringstream in filestream
  *(m_outputFileStreamCpp) << (m_vectorDefaultInitFuncStream)->str() << std::endl; 
  *(m_outputFileStreamCpp) << "}" << std::endl;

  //writing defaultConnect() function definition in CPP file
  *(m_outputFileStreamCpp) << "void " << *(m_vectorName) << "::defaultConnect(RefCsimUnit associatedUnitInst) {" << std::endl; 
  //copying stringstream in filestream
  *(m_outputFileStreamCpp) << (m_vectorConnectFuncStream)->str() << std::endl; 
  *(m_outputFileStreamCpp) << "}" << std::endl; 

  //writing writeVector() function definition in CPP file
  *(m_outputFileStreamCpp) << "void " << *(m_vectorName) << "::writeVector(){" << std::endl;
  indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
  *(m_outputFileStreamCpp) << "TRadix dataRadix = getRadix();" << std::endl;
  indt <RefOfstream> (m_depth, m_outputFileStreamCpp);
  *(m_outputFileStreamCpp) << "std::ofstream* outputStream = getOutputStream();" << std::endl << std::endl;
  //copying stringstream in filestream
  *(m_outputFileStreamCpp) << (m_vectorWriteFuncStream)->str() << std::endl;
  *(m_outputFileStreamCpp) << "}" << std::endl;

  //closing csim gen namespace
  *(m_outputFileStreamCpp) << "}" << std::endl;

  //Functions section
  *(m_outputFileStreamHdr) << std::endl;
  indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
  *(m_outputFileStreamHdr) << "//functions" << std::endl;

  //writing default initialize function declaration in H file + indentation
  indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
  *(m_outputFileStreamHdr) << "void defaultInitialize(RefCsimUnit unit);" << std::endl;

  //writing default connect function declaration in H file + indentation
  indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
  *(m_outputFileStreamHdr) << "void defaultConnect(RefCsimUnit associatedUnitInst);" << std::endl;

  //writing default write function declaration in H file + indentation
  indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
  *(m_outputFileStreamHdr) << "void writeVector(" << *(bufferStr) << ");" << std::endl;

  //writing constructor for vector writer
  //WARNING: temporary values are used for id, ver, max_transaction
  indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
  *(m_outputFileStreamHdr) << "//constructor" << std::endl;
  indt <RefOfstream> (m_depth, m_outputFileStreamHdr);
  //*(m_outputFileStreamHdr) << *(m_unitName) << "() : CsimVectorWriter(1,1,RefString(new std::string(\"" << *(m_unitName) << "\")), " << m_vectorTypeName << ", " << *(m_vectorRadixName) << ", 1) {}" << std::endl;
  *(m_outputFileStreamHdr) << *(m_unitName) << "() : CsimVectorWriter(" << m_vecID << ", " << m_vecVer << ", " << "RefString(new std::string(\"" << *(m_unitName) << "\")), " << *(m_vectorTypeName) << ", " << *(m_vectorRadixName) << ", " <<  m_vecMaxEvents << ") {}" << std::endl;

}


}//end of namespace NSCsimCppGenerator


