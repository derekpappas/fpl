//---------------------------------------------------------------------
// Copyright (c) 2005, 2006 Fastpathlogic
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

#include "Adapter.h"
#include <cmath>
TBool adapterHasErrors = FALSE;

// clock name to pass to cdom
  RefString cslomClockName;

using namespace NSCdom;
using namespace NSCSLOm;
using namespace std;

namespace NSAdapter {

// ********************************************
// CAdapterToCDOM class
// ********************************************

ECDOmNetType CAdapterToCDOM::getCDOmNetType(ECSLOmSignalType type) {
  ECDOmNetType netType = NET_UNDEFINED;
  switch(type) {
    case ( SIGNAL_UNDEFINED):      netType = NET_WIRE   ; break;
    case ( SIGNAL_SUPPLY_0) :      netType = NET_SUPPLY0; break;
    case ( SIGNAL_SUPPLY_1) :      netType = NET_SUPPLY1; break;
    case ( SIGNAL_TRI)      :      netType = NET_TRI    ; break;
    case ( SIGNAL_TRI0)     :      netType = NET_TRI0   ; break;
    case ( SIGNAL_TRI1)     :      netType = NET_TRI1   ; break;
    case ( SIGNAL_TRIAND)   :      netType = NET_TRIAND ; break;
    case ( SIGNAL_TRIOR)    :      netType = NET_TRIOR  ; break;
    case ( SIGNAL_WIRE)     :      netType = NET_WIRE   ; break;
    case ( SIGNAL_WAND)     :      netType = NET_WAND   ; break;
    case ( SIGNAL_WOR)      :      netType = NET_WOR    ; break;
    case ( SIGNAL_TRIREG)   :      netType = NET_TRIREG ; break;
  }
  return netType;
}

ECDOmVarType CAdapterToCDOM::getCDOmVarType(ECSLOmSignalType type) {
  ECDOmVarType varType = VAR_UNDEFINED;
  switch(type) {
    case ( SIGNAL_REG)         :      varType = VAR_REG     ; break;
    case ( SIGNAL_VAR_INTEGER) :      varType = VAR_INTEGER ; break;
    case ( SIGNAL_VAR_REAL)    :      varType = VAR_REAL    ; break;
    case ( SIGNAL_VAR_REALTIME):      varType = VAR_REALTIME; break;
    case ( SIGNAL_VAR_TIME)    :      varType = VAR_TIME    ; break;
  }
  return varType;
}

void CAdapterToCDOM::adaptIfcOrSgAssign(RefCSLOmConnectable lhs,
                                        RefCSLOmConnectable rhs,
                                        RefCDOmContAssn contAssn
                                        ) {

  RefTVec_RefCDOmExpr lhsExprs = RefTVec_RefCDOmExpr(new TVec_RefCDOmExpr());
  RefTVec_RefCDOmExpr rhsExprs = RefTVec_RefCDOmExpr(new TVec_RefCDOmExpr());
  if(lhs->isInterface()) {
    RefCSLOmInterface ifc = CSLOmInterface::cast(lhs);
    RefTVec_RefCSLOmPortDecl ports = ifc->getAllPorts();
    TVec_RefCSLOmPortDecl_const_iter it = ports->begin();
    for(; it != ports->end(); ++it) {
      RefString portName = RefString(new string(""));
      RefCSLOmPortDecl port = CSLOmPortDecl::cast(*it);
      map<RefCSLOmConnectable, RefString>::const_iterator it2 = m_allPortsSignalsNames.find(*it);
      if(it2 != m_allPortsSignalsNames.end()) {
        portName = RefString(it2->second);
      } 
      else {
        map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator portIt = m_allCslPorts.find(port);
        if(portIt != m_allCslPorts.end()) {
          RefTVec_RefString prefixes = portIt->second;
          for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
            if((*prefixIt).get()) {
              portName->append(**prefixIt);
              portName->append("_");
            }
          }
        }
        portIt = m_cslPortsSuffixes.find(port);
        if(portIt != m_cslPortsSuffixes.end()) {
          RefTVec_RefString suffixes = portIt->second;
          for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
            if((*suffixIt).get()) {
              portName->append(**suffixIt);
              portName->append("_");
            }
          }
        }
        portName->append(*(port->getName()));
      }
      lhsExprs->push_back(buildCDOmExprLink(lhs->getLineNumber(), portName));
    }
  }
  else if(lhs->isSignalGroup()){
    RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(lhs);
    RefTVec_RefCSLOmSignal signals = sg->getAllSignals();
    TVec_RefCSLOmSignal_const_iter it = signals->begin();
    for(; it != signals->end(); ++it) {
      RefString signalName = RefString(new string(""));
      RefCSLOmSignal signal = CSLOmSignal::cast(*it);
      map<RefCSLOmConnectable, RefString>::const_iterator it2 = m_allPortsSignalsNames.find(*it);
      if(it2 != m_allPortsSignalsNames.end()) {
        signalName = RefString(it2->second);
      } 
      else {
        map<RefCSLOmSignal, RefTVec_RefString>::const_iterator signalIt = m_allCslSignals.find(signal);
        if(signalIt != m_allCslSignals.end()) {
          RefTVec_RefString prefixes = signalIt->second;
          for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
            if((*prefixIt).get()) {
              signalName->append(**prefixIt);
              signalName->append("_");
            }
          }
        }
        signalIt = m_cslSignalsSuffixes.find(signal);
        if(signalIt != m_cslSignalsSuffixes.end()) {
          RefTVec_RefString suffixes = signalIt->second;
          for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
            signalName->append(**suffixIt);
            signalName->append("_");
          }
        }
        signalName->append(*(signal->getName()));
      }
      lhsExprs->push_back(buildCDOmExprLink(lhs->getLineNumber(), signalName));
    }
  }
  else {
    ASSERT(FAIL, "Only interface and signal group are supported!");
  }


  if(rhs->isInterface()) {
    RefCSLOmInterface ifc = CSLOmInterface::cast(rhs);
    RefTVec_RefCSLOmPortDecl ports = ifc->getAllPorts();
    TVec_RefCSLOmPortDecl_const_iter it = ports->begin();
    for(; it != ports->end(); ++it) {
      RefString portName = RefString(new string(""));
      RefCSLOmPortDecl port = CSLOmPortDecl::cast(*it);
      map<RefCSLOmConnectable, RefString>::const_iterator it2 = m_allPortsSignalsNames.find(*it);
      if(it2 != m_allPortsSignalsNames.end()) {
        portName = RefString(it2->second);
      } 
      else {
        map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator portIt = m_allCslPorts.find(port);
        if(portIt != m_allCslPorts.end()) {
          RefTVec_RefString prefixes = portIt->second;
          for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
            if((*prefixIt).get()) {
              portName->append(**prefixIt);
              portName->append("_");
            }
          }
        }
        portIt = m_cslPortsSuffixes.find(port);
        if(portIt != m_cslPortsSuffixes.end()) {
          RefTVec_RefString suffixes = portIt->second;
          for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
            if((*suffixIt).get()) {
              portName->append(**suffixIt);
              portName->append("_");
            }
          }
        }
        portName->append(*(port->getName()));
      }
      rhsExprs->push_back(buildCDOmExprLink(lhs->getLineNumber(), portName));
    }
  }
  else if(rhs->isSignalGroup()){
    RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(rhs);
    RefTVec_RefCSLOmSignal signals = sg->getAllSignals();
    TVec_RefCSLOmSignal_const_iter it = signals->begin();
    for(; it != signals->end(); ++it) {
      RefString signalName = RefString(new string(""));
      RefCSLOmSignal signal = CSLOmSignal::cast(*it);
      map<RefCSLOmConnectable, RefString>::const_iterator it2 = m_allPortsSignalsNames.find(*it);
      if(it2 != m_allPortsSignalsNames.end()) {
        signalName = RefString(it2->second);
      } 
      else {
        map<RefCSLOmSignal, RefTVec_RefString>::const_iterator signalIt = m_allCslSignals.find(signal);
        if(signalIt != m_allCslSignals.end()) {
          RefTVec_RefString prefixes = signalIt->second;
          for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
            if((*prefixIt).get()) {
              signalName->append(**prefixIt);
              signalName->append("_");
            }
          }
        }
        signalIt = m_cslSignalsSuffixes.find(signal);
        if(signalIt != m_cslSignalsSuffixes.end()) {
          RefTVec_RefString suffixes = signalIt->second;
          for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
            signalName->append(**suffixIt);
            signalName->append("_");
          }
        }
        signalName->append(*(signal->getName()));
      }
      rhsExprs->push_back(buildCDOmExprLink(lhs->getLineNumber(), signalName));
    }
  }
  else {
    ASSERT(FAIL, "Only interface and signal group are supported!");
  }

  RefCDOmAssn assn;
  for(int i = 0; i < lhsExprs->size(); ++i) {
    assn = buildCDOmAssn(lhs->getLineNumber(), lhsExprs->at(i), rhsExprs->at(i));
    contAssn->addNetAssn(assn);
  }

}

void CAdapterToCDOM::adaptPortOrSignalConnection( RefCSLOmExprLink actualExpr, 
                                                  RefCSLOmExprLink formalExpr, 
                                                  RefCDOmModuleOrUdpInstance cdomModuleInst 
                                                ) { 

  RefCSLOmBase x = actualExpr->doEval();
  RefCSLOmConnectable cslActual = CSLOmConnectable::cast(actualExpr->doEval());
  RefCSLOmConnectable cslFormal = CSLOmConnectable::cast(formalExpr->doEval());

  ASSERT(cslActual.get(), "adaptPortOrSignalConnection(): actual is null");
  ASSERT(cslFormal.get(), "adaptPortOrSignalConnection(): formal is null");
  
  //prefixes
  RefString actualName = RefString(new string(""));
  RefString formalName = RefString(new string(""));
  
  if(cslActual->isPort()) {
    RefCSLOmPortDecl actualPort = CSLOmPortDecl::cast(cslActual);
    map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator actualIt = m_allCslPorts.find(actualPort);
    if(actualIt != m_allCslPorts.end()) {
      RefTVec_RefString prefixes = actualIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        if((*prefixIt).get()) {
          actualName->append(**prefixIt);
          actualName->append("_");
        }
      }
    }
    actualIt = m_cslPortsSuffixes.find(actualPort);
    if(actualIt != m_cslPortsSuffixes.end()) {
      RefTVec_RefString suffixes = actualIt->second;
      for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
        if((*suffixIt).get()) {
          actualName->append(**suffixIt);
          actualName->append("_");
        }
      }
    }
    actualName->append(*(actualPort->getName()));
  }
  else if (cslActual->isSignal()) {
    RefCSLOmSignal actualSignal = CSLOmSignal::cast(cslActual);
    map<RefCSLOmSignal, RefTVec_RefString>::const_iterator actualIt = m_allCslSignals.find(actualSignal);
    if(actualIt != m_allCslSignals.end()) {
      RefTVec_RefString prefixes = actualIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        if((*prefixIt).get()) {
          actualName->append(**prefixIt);
          actualName->append("_");
        }
      }
    }
    actualIt = m_cslSignalsSuffixes.find(actualSignal);
    if(actualIt != m_cslSignalsSuffixes.end()) {
      RefTVec_RefString suffixes = actualIt->second;
      for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
        actualName->append(**suffixIt);
        actualName->append("_");
      }
    }
    actualName->append(*(actualSignal->getName()));
  }

  if(cslFormal->isPort()) {
    RefCSLOmPortDecl formalPort = CSLOmPortDecl::cast(cslFormal);
    map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator formalIt = m_allCslPorts.find(formalPort);
    if(formalIt != m_allCslPorts.end()) {
      RefTVec_RefString prefixes = formalIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        if((*prefixIt).get()) {
          formalName->append(**prefixIt);
          formalName->append("_");
        }
      }
    }
    else {
      //in case there was a predeclaration and the prefixes were not yet added
      //this is necessary only for the formal parameter as the actual one is always within the current scope
      RefCSLOmPortDecl formalPort = CSLOmPortDecl::cast(cslFormal);
      RefTVec_RefString prefixes = RefTVec_RefString(new TVec_RefString());
      RefCSLOmBase parent = formalPort->getParent();
      ASSERT(parent->isInterface(), "parent should be interface");
      RefCSLOmInterface parentIfc = CSLOmInterface::cast(parent);
      while(!parentIfc->isDefaultIfc()) {
        if(!parentIfc->getNoPrefixBit()) {
          RefString prefix = RefString(parentIfc->getPrefix());
          if(prefix.get()) {
            prefixes->push_back(prefix);
            formalName->append(*prefix);
            formalName->append("_");
          }
          else {
            prefix = RefString(parentIfc->getName());
            prefixes->push_back(prefix);
            formalName->append(*prefix);
            formalName->append("_");
          }
        }
        parent = parentIfc->getParent();
        ASSERT(parent->isInterface(), "parent should be interface");
        parentIfc = CSLOmInterface::cast(parent);
      }
      if(prefixes.get()) {
        m_allCslPorts.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(formalPort, prefixes));
      }
    }
    formalIt = m_cslPortsSuffixes.find(formalPort);
    if(formalIt != m_cslPortsSuffixes.end()) {
      RefTVec_RefString suffixes = formalIt->second;
      for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
        formalName->append(**suffixIt);
        formalName->append("_");
      }
    }
    else {
      //in case there was a predeclaration and the suffixes were not yet added
      RefCSLOmPortDecl formalPort = CSLOmPortDecl::cast(cslFormal);
      RefTVec_RefString suffixes = RefTVec_RefString(new TVec_RefString());
      RefCSLOmBase parent = formalPort->getParent();
      ASSERT(parent->isInterface(), "parent should be interface");
      RefCSLOmInterface parentIfc = CSLOmInterface::cast(parent);
      while(!parentIfc->isDefaultIfc()) {
        RefString suffix = RefString(parentIfc->getSuffix());
        if(suffix.get()) {
          suffixes->push_back(suffix);
          formalName->append(*suffix);
          formalName->append("_");
        }
        parent = parentIfc->getParent();
        ASSERT(parent->isInterface(), "parent should be interface");
        parentIfc = CSLOmInterface::cast(parent);
      }
      if(suffixes.get()) {
        m_cslPortsSuffixes.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(formalPort, suffixes));
      }
    }
    formalName->append(*(formalPort->getName()));
  }
  else if (cslFormal->isSignal()) {
    RefCSLOmSignal formalSignal = CSLOmSignal::cast(cslFormal);
    map<RefCSLOmSignal, RefTVec_RefString>::const_iterator formalIt = m_allCslSignals.find(formalSignal);
    if(formalIt != m_allCslSignals.end()) {
      RefTVec_RefString prefixes = formalIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        formalName->append(**prefixIt);
        formalName->append("_");
      }
    }
    formalName->append(*(formalSignal->getName()));
  }

  //connections
  RefCDOmExprLink cdomActual = buildCDOmExprLink(cslActual->getLineNumber(), actualName);
  if (actualExpr->hasBitRange()) {
    RefCSLOmExpr expr = actualExpr->getBitRange()->getUpper();
    RefCDOmExpr up;
    if(expr->isNumber()) {
      up = buildCDOmNum32WithValue(expr->getLineNumber(),CSLOmNumber::cast(expr->doEval())->getValue());
    }
    else if(expr->isOp()) {
      expr->acceptVisitor(*this);
      up = CDOmExprOp::cast(m_cdomReturnedValue);
    }
    else if(expr->isExprLink()){
      RefCSLOmBase cslCurrParent = m_cslCurrParent;
      RefCDOmBase cdomReturnedValue = m_cdomReturnedValue;
      expr->acceptVisitor(*this);
      up = CDOmExpr::cast(m_cdomReturnedValue);//buildCDOmExprLink(expr->getLineNumber(), CSLOmExprLink::cast(expr)->getName());
      m_cslCurrParent = cslCurrParent;
      m_cdomReturnedValue = cdomReturnedValue;
    }
    expr = actualExpr->getBitRange()->getLower();
    //RefCSLOmNumber low = CSLOmNumber::cast(expr->doEval());
    RefCDOmExpr low;
    if(expr->isNumber()) {
      low = buildCDOmNum32WithValue(expr->getLineNumber(),CSLOmNumber::cast(expr->doEval())->getValue());
    }
    else if(expr->isOp()) {
      expr->acceptVisitor(*this);
      low = CDOmExprOp::cast(m_cdomReturnedValue);
    }
    else if(expr->isExprLink()){
      RefCSLOmBase cslCurrParent = m_cslCurrParent;
      RefCDOmBase cdomReturnedValue = m_cdomReturnedValue;
      expr->acceptVisitor(*this);
      low = CDOmExpr::cast(m_cdomReturnedValue);//buildCDOmExprLink(expr->getLineNumber(), CSLOmExprLink::cast(expr)->getName());
      m_cslCurrParent = cslCurrParent;
      m_cdomReturnedValue = cdomReturnedValue;
      //low = buildCDOmExprLink(expr->getLineNumber(), CSLOmExprLink::cast(expr)->getName());
    }
    NSCdom::RefCDOmRangeExpr rangeExpr;
    /* if (up->getValue() == low->getValue()) {
      NSCdom::RefCDOmNum32 upper = buildCDOmNum32WithValue(up->getLineNumber(), up->getValue());
      rangeExpr = buildCDOmRangeExprSimple(up->getLineNumber(), upper);
    }
    else {
      NSCdom::RefCDOmNum32 upper = buildCDOmNum32WithValue(up->getLineNumber(), up->getValue());
      NSCdom::RefCDOmNum32 lower = buildCDOmNum32WithValue(low->getLineNumber(), low->getValue());*/
      rangeExpr = buildCDOmRangeExprDouble(up->getLineNumber(), up, low);
      //}
    cdomActual->setRangeExpr(rangeExpr);
  }
  RefString cdomFormal = RefString(new string(*formalName));
  
  cdomModuleInst->addPortConnection(RefCDOmAttrListCollection(), cdomActual, cdomFormal);

}

void CAdapterToCDOM::adaptPortOrSignalConnection( RefCSLOmConnectable cslActual, 
                                                  RefCSLOmConnectable cslFormal, 
                                                  RefCDOmModuleOrUdpInstance cdomModuleInst 
                                                ) { 

  ASSERT(cslActual.get(), "adaptPortOrSignalConnection(): actual is null");
  ASSERT(cslFormal.get(), "adaptPortOrSignalConnection(): formal is null");
  
  //prefixes
  RefString actualName = RefString(new string(""));
  RefString formalName = RefString(new string(""));
  
  if(cslActual->isPort()) {
    RefCSLOmPortDecl actualPort = CSLOmPortDecl::cast(cslActual);
    map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator actualIt = m_allCslPorts.find(actualPort);
    if(actualIt != m_allCslPorts.end()) {
      RefTVec_RefString prefixes = actualIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        if((*prefixIt).get()) {
          actualName->append(**prefixIt);
          actualName->append("_");
        }
      }
    }
    actualIt = m_cslPortsSuffixes.find(actualPort);
    if(actualIt != m_cslPortsSuffixes.end()) {
      RefTVec_RefString suffixes = actualIt->second;
      for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
        actualName->append(**suffixIt);
        actualName->append("_");
      }
    }
    actualName->append(*(actualPort->getName()));
  }
  else if (cslActual->isSignal()) {
    RefCSLOmSignal actualSignal = CSLOmSignal::cast(cslActual);
    map<RefCSLOmSignal, RefTVec_RefString>::const_iterator actualIt = m_allCslSignals.find(actualSignal);
    if(actualIt != m_allCslSignals.end()) {
      RefTVec_RefString prefixes = actualIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        actualName->append(**prefixIt);
        actualName->append("_");
      }
    }
    actualIt = m_cslSignalsSuffixes.find(actualSignal);
    if(actualIt != m_cslSignalsSuffixes.end()) {
      RefTVec_RefString suffixes = actualIt->second;
      for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
        actualName->append(**suffixIt);
        actualName->append("_");
      }
    }
    actualName->append(*(actualSignal->getName()));
  }

  if(cslFormal->isPort()) {
    RefCSLOmPortDecl formalPort = CSLOmPortDecl::cast(cslFormal);
    map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator formalIt = m_allCslPorts.find(formalPort);
    if(formalIt != m_allCslPorts.end()) {
      RefTVec_RefString prefixes = formalIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        if((*prefixIt).get()) {
          formalName->append(**prefixIt);
          formalName->append("_");
        }
      }
    }
    else {
      //in case there was a predeclaration and the prefixes were not yet added
      RefCSLOmPortDecl formalPort = CSLOmPortDecl::cast(cslFormal);
      RefTVec_RefString prefixes = RefTVec_RefString(new TVec_RefString());
      RefCSLOmBase parent = formalPort->getParent();
      ASSERT(parent->isInterface(), "parent should be interface");
      RefCSLOmInterface parentIfc = CSLOmInterface::cast(parent);
      while(!parentIfc->isDefaultIfc()) {
        if(!parentIfc->getNoPrefixBit()) {
          RefString prefix = RefString(parentIfc->getPrefix());
          if(prefix.get()) {
            prefixes->push_back(prefix);
            formalName->append(*prefix);
            formalName->append("_");
          }
          else {
            prefix = RefString(parentIfc->getName());
            prefixes->push_back(prefix);
            formalName->append(*prefix);
            formalName->append("_");
          }
        }
        parent = parentIfc->getParent();
        ASSERT(parent->isInterface(), "parent should be interface");
        parentIfc = CSLOmInterface::cast(parent);
      }
      if(prefixes.get()) {
        m_allCslPorts.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(formalPort, prefixes));
      }
    }
    //adding the suffixes
    formalIt = m_cslPortsSuffixes.find(formalPort);
    if(formalIt != m_cslPortsSuffixes.end()) {
      RefTVec_RefString suffixes = formalIt->second;
      for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
        if((*suffixIt).get()) {
          formalName->append(**suffixIt);
          formalName->append("_");
        }
      }
    }
    else {
      //in case there was a predeclaration and the suffixes were not yet added
      RefCSLOmPortDecl formalPort = CSLOmPortDecl::cast(cslFormal);
      RefTVec_RefString suffixes = RefTVec_RefString(new TVec_RefString());
      RefCSLOmBase parent = formalPort->getParent();
      ASSERT(parent->isInterface(), "parent should be interface");
      RefCSLOmInterface parentIfc = CSLOmInterface::cast(parent);
      while(!parentIfc->isDefaultIfc()) {
        RefString suffix = RefString(parentIfc->getSuffix());
        if(suffix.get()) {
          suffixes->push_back(suffix);
          formalName->append(*suffix);
          formalName->append("_");
        }
        parent = parentIfc->getParent();
        ASSERT(parent->isInterface(), "parent should be interface");
        parentIfc = CSLOmInterface::cast(parent);
      }
      if(suffixes.get()) {
        m_cslPortsSuffixes.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(formalPort, suffixes));
      }
    }
    formalName->append(*(formalPort->getName()));
  }
  else if (cslFormal->isSignal()) {
    RefCSLOmSignal formalSignal = CSLOmSignal::cast(cslFormal);
    map<RefCSLOmSignal, RefTVec_RefString>::const_iterator formalIt = m_allCslSignals.find(formalSignal);
    if(formalIt != m_allCslSignals.end()) {
      RefTVec_RefString prefixes = formalIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        formalName->append(**prefixIt);
        formalName->append("_");
      }
    }
    else {
      RefCSLOmSignal signal = CSLOmSignal::cast(cslFormal);
      RefTVec_RefString prefixes = RefTVec_RefString(new TVec_RefString());
      RefCSLOmBase parent = signal->getParent();
      RefCSLOmGroupSignal parentSg;
      //ASSERT(parent->isSignalGroup(), "parent should be signal group");
      while(parent->isSignalGroup()) {
        parentSg = CSLOmGroupSignal::cast(parent);
        if(!parentSg->getNoPrefixBit()) {
          RefString prefix = RefString(parentSg->getPrefix());
          if(prefix.get()) {
            prefixes->push_back(prefix);
            formalName->append(*prefix);
            formalName->append("_");
          }
          else {
            prefix = RefString(parentSg->getName());
            prefixes->push_back(prefix);
            formalName->append(*prefix);
            formalName->append("_");
          }
        }
        parent = parentSg->getParent();
      }
      if(prefixes.get()) {
        m_allCslSignals.insert(pair<RefCSLOmSignal, RefTVec_RefString>(signal, prefixes));
      }
    }
    //adding the suffixes
    formalIt = m_cslSignalsSuffixes.find(formalSignal);
    if(formalIt != m_cslSignalsSuffixes.end()) {
      RefTVec_RefString suffixes = formalIt->second;
      for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
        formalName->append(**suffixIt);
        formalName->append("_");
      }
    }
    else {
      RefCSLOmSignal signal = CSLOmSignal::cast(cslFormal);
      RefTVec_RefString suffixes = RefTVec_RefString(new TVec_RefString());
      RefCSLOmBase parent = signal->getParent();
      RefCSLOmGroupSignal parentSg;
      //ASSERT(parent->isSignalGroup(), "parent should be signal group");
      while(parent->isSignalGroup()) {
        parentSg = CSLOmGroupSignal::cast(parent);
        RefString suffix = RefString(parentSg->getSuffix());
        if(suffix.get()) {
          suffixes->push_back(suffix);
          formalName->append(*suffix);
          formalName->append("_");
        }
        parent = parentSg->getParent();
      }
      if(suffixes.get()) {
        m_cslSignalsSuffixes.insert(pair<RefCSLOmSignal, RefTVec_RefString>(signal, suffixes));
      }
    }
    formalName->append(*(formalSignal->getName()));
  }

  //connections
  RefCDOmExprLink cdomActual = buildCDOmExprLink(cslActual->getLineNumber(), actualName);
  RefString cdomFormal = RefString(new string(*formalName));
  
  cdomModuleInst->addPortConnection(RefCDOmAttrListCollection(), cdomActual, cdomFormal);
}


void CAdapterToCDOM::adaptExprConnection( RefCSLOmExpr cslActual, 
                                          RefCSLOmConnectable cslFormal, 
                                          RefCDOmModuleOrUdpInstance cdomModuleInst 
                                          ) { 

  ASSERT(cslActual.get(), "adaptExprConnection(): actual is null");
  ASSERT(cslFormal.get(), "adaptExprConnection(): formal is null");
  
  //prefixes
  RefString formalName = RefString(new string(""));

  if(cslFormal->isPort()) {
    RefCSLOmPortDecl formalPort = CSLOmPortDecl::cast(cslFormal);
    map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator formalIt = m_allCslPorts.find(formalPort);
    if(formalIt != m_allCslPorts.end()) {
      RefTVec_RefString prefixes = formalIt->second;
      for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
        if((*prefixIt).get()) {
          formalName->append(**prefixIt);
          formalName->append("_");
        }
      }
    }
    else {
      RefCSLOmBase parent = formalPort->getParent();
      RefTVec_RefString prefixes = RefTVec_RefString(new TVec_RefString());
      ASSERT(parent->isInterface(), "parent should be an interface");
      RefCSLOmInterface parentIfc = CSLOmInterface::cast(parent);
      while(!parentIfc->isDefaultIfc()) {
        if(!parentIfc->getNoPrefixBit()) {
          RefString prefix = RefString(parentIfc->getPrefix());
          if(prefix.get()) {
            prefixes->push_back(prefix);
            formalName->append(*prefix);
            formalName->append("_");
          }
          else {
            prefix = RefString(parentIfc->getName());
            prefixes->push_back(prefix);
            formalName->append(*prefix);
            formalName->append("_");
          }
        }
        parent = parentIfc->getParent();
        ASSERT(parent->isInterface(), "parent should be an interface");
        parentIfc = CSLOmInterface::cast(parent);
      }
      if(prefixes.get()) {
        m_allCslPorts.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(formalPort, prefixes));
      }
    }
    //adding the suffixes
    formalIt = m_cslPortsSuffixes.find(formalPort);
    if(formalIt != m_cslPortsSuffixes.end()) {
      RefTVec_RefString suffixes = formalIt->second;
      for(TVec_RefString::const_iterator suffixIt = suffixes->begin(); suffixIt < suffixes->end(); ++suffixIt) {
        if((*suffixIt).get()) {
          formalName->append(**suffixIt);
          formalName->append("_");
        }
      }
    }
    else {
      RefCSLOmBase parent = formalPort->getParent();
      RefTVec_RefString suffixes = RefTVec_RefString(new TVec_RefString());
      ASSERT(parent->isInterface(), "parent should be an interface");
      RefCSLOmInterface parentIfc = CSLOmInterface::cast(parent);
      while(!parentIfc->isDefaultIfc()) {
        RefString suffix = RefString(parentIfc->getSuffix());
        if(suffix.get()) {
          suffixes->push_back(suffix);
          formalName->append(*suffix);
          formalName->append("_");
        }
        parent = parentIfc->getParent();
        ASSERT(parent->isInterface(), "parent should be an interface");
        parentIfc = CSLOmInterface::cast(parent);
      }
      if(suffixes.get()) {
        m_cslPortsSuffixes.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(formalPort, suffixes));
      }
    }
    formalName->append(*(formalPort->getName()));
  }
  else if(cslFormal->isInterface()) {
    //to be completed
  }

  //connections
  RefCDOmExpr cdomActual;
  //Alina's code
  if(cslActual->isOp()) {
    cslActual->acceptVisitor(*this);
    cdomActual = CDOmExprOp::cast(m_cdomReturnedValue);
  }
  //end Alina's code
  else if(cslActual->isConcat()) {
    RefCSLOmExprConcat cslConcat = CSLOmExprConcat::cast(cslActual);
    RefTVec_RefCSLOmBase concatExprs =cslConcat->getExprsAsBase();
    if(concatExprs.get()) {
      cdomActual = buildCDOmConcat(cslActual->getLineNumber(), concatExprs);
    }
  }
  else if(cslActual->isMultiConcat()) {
    cdomActual = buildCDOmMultiConcat(cslActual->getLineNumber(), cslActual);
  }
  else if(cslActual->isNumber()) {
    RefCDOmNum32 actual = CDOmNum32::build(cslActual->getLineNumber(), CSLOmNum32::cast(cslActual)->getValue());
    cdomActual = CDOmExpr::cast(actual);
  }
  RefString cdomFormal = RefString(new string(*formalName));
  
  cdomModuleInst->addPortConnection(RefCDOmAttrListCollection(), cdomActual, cdomFormal);
  
}

void CAdapterToCDOM::adaptInterfaceOrSignalGroupConnection( RefCSLOmConnectable cslActual, 
                                                            RefCSLOmConnectable cslFormal, 
                                                            RefCDOmModuleOrUdpInstance cdomModuleInst
                                                          ) {
  
  ASSERT(cslActual.get(), "adaptInterfaceOrSignalGroupConnection(): null actual parameter received");
  ASSERT(cslFormal.get(), "adaptInterfaceOrSignalGroupConnection(): null formal parameter received");

  //connect actual interface to formal interface
  if(cslActual->isInterface() && cslFormal->isInterface()) {
    RefCSLOmInterface cslActualInterface = CSLOmInterface::cast(cslActual);
    RefCSLOmInterface cslFormalInterface = CSLOmInterface::cast(cslFormal);
    RefTVec_RefCSLOmBase actualChildren = cslActualInterface->getChildrenAsBase();
    ASSERT(actualChildren.get(), "adaptInterfaceOrSignalGroupConnection():actual interface has no children");
    
    for(TVec_RefCSLOmBase_const_iter it1 = actualChildren->begin(); it1 < actualChildren->end(); ++it1) {
      if((*it1)->isPort()) {
        RefCSLOmPortDecl actualPort = CSLOmPortDecl::cast(*it1);
        RefTVec_RefCSLOmPortDecl formalPorts = cslFormalInterface->getPorts();
        
        //ASSERT(formalPorts.get(), "adaptInterfaceOrSignalGroupConnection():formal interface has no ports on current level");
        if(formalPorts.get()) {
        for(TVec_RefCSLOmPortDecl_const_iter it2 = formalPorts->begin(); it2 < formalPorts->end(); ++it2) {
          RefCSLOmExpr width = CSLOmSimpleBitRange::cast((*it2)->getBitRange())->getWidth();
          RefCSLOmExpr actualWidth = CSLOmSimpleBitRange::cast(actualPort->getBitRange())->getWidth();
          if(   *((*it2)->getName()) == *(actualPort->getName()) 
           && (*it2)->getPortDirection() == actualPort->getPortDirection()
           && CSLOmNumber::cast(width->doEval())->getValue() == CSLOmNumber::cast(actualWidth->doEval())->getValue()) {   
            adaptPortOrSignalConnection(CSLOmConnectable::cast(actualPort), CSLOmConnectable::cast(*it2),cdomModuleInst);
            break;
          }
        }
        } 
      }
      else if((*it1)->isInterface()) {
        RefCSLOmInterface actualInterface = CSLOmInterface::cast(*it1);
        RefTVec_RefCSLOmInterface formalInterfaces = cslFormalInterface->getInterfaces();
        //ASSERT(formalInterfaces.get(), "adaptInterfaceOrSignalGroupConnection():formal interface instance has no interfaces on current level");

        if(formalInterfaces.get()) {
        for(TVec_RefCSLOmInterface_iter it2 = formalInterfaces->begin(); it2 < formalInterfaces->end(); ++it2) {
          if(*((*it2)->getName()) == *(actualInterface->getName())) {
            adaptInterfaceOrSignalGroupConnection(actualInterface, *it2, cdomModuleInst);
          }
        }
        }
      }
      else if((*it1)->isID()) {
        continue;
      }
    }
  }

  //connect actual interface to formal signal group
  else if(cslActual->isInterface() && cslFormal->isSignalGroup()) {
    RefCSLOmInterface cslActualInterface = CSLOmInterface::cast(cslActual);
    RefCSLOmGroupSignal cslFormalSigGroup = CSLOmGroupSignal::cast(cslFormal);

    RefTVec_RefCSLOmBase actualChildren = cslActualInterface->getChildrenAsBase();
    ASSERT(actualChildren.get(), "adaptInterfaceOrSignalGroupConnection(): actual  interface has no children");

    for(TVec_RefCSLOmBase_const_iter it1 = actualChildren->begin(); it1 < actualChildren->end(); ++it1) {
      if((*it1)->isPort()) {
        RefCSLOmPortDecl actualPort = CSLOmPortDecl::cast(*it1);
        RefTVec_RefCSLOmSignal formalSignals = cslFormalSigGroup->getSignals();
        //ASSERT(formalSignals.get(), "adaptInterfaceOrSignalGroupConnection(): formal signal group has no signals on current level");
        if(formalSignals.get()) {
        for(TVec_RefCSLOmSignal_const_iter it2 = formalSignals->begin(); it2 < formalSignals->end(); ++it2) {
          RefCSLOmExpr width = CSLOmSimpleBitRange::cast((*it2)->getBitRange())->getWidth();
          RefCSLOmExpr actualWidth = CSLOmSimpleBitRange::cast(actualPort->getBitRange())->getWidth();
          if(*((*it2)->getName()) == *(actualPort->getName())
           && CSLOmNumber::cast(width->doEval())->getValue() == CSLOmNumber::cast(actualWidth->doEval())->getValue()) {
            adaptPortOrSignalConnection(CSLOmConnectable::cast(actualPort), CSLOmConnectable::cast(*it2), cdomModuleInst);
            break;
          }       
        }
        }
      }
      else if ((*it1)->isInterface()) {
        RefCSLOmInterface actualInterface = CSLOmInterface::cast(*it1);
        RefTVec_RefCSLOmGroupSignal formalSigGroups = cslFormalSigGroup->getGroupSignals();
        ASSERT(formalSigGroups.get(), "adaptInterfaceOrSignalGroupConnection(): formal signal group has no signal group on current level");

        if(formalSigGroups.get()) {
        for(TVec_RefCSLOmGroupSignal_const_iter it2 = formalSigGroups->begin(); it2 < formalSigGroups->end(); ++it2) {
          if(*((*it2)->getName()) == *(actualInterface->getName())) {
            adaptInterfaceOrSignalGroupConnection(actualInterface, *it2, cdomModuleInst);
            break;
          }
        }
        }
      }
      else if ((*it1)->isID()) {
        continue;
      }
    }
  }

  //connect actual signal group to formal interface
  else if(cslActual->isSignalGroup() && cslFormal->isInterface()) {
    RefCSLOmGroupSignal cslActualSigGroup = CSLOmGroupSignal::cast(cslActual);
    RefCSLOmInterface cslFormalInterface = CSLOmInterface::cast(cslFormal);

    RefTVec_RefCSLOmBase actualChidren = cslActualSigGroup->getChildrenAsBase();
    ASSERT(actualChidren.get(), "adaptInterfaceOrSignalGroupConnection(): actual Parameter has no children");
    
    for(TVec_RefCSLOmBase_const_iter it1 = actualChidren->begin(); it1 < actualChidren->end(); ++it1) {
      if((*it1)->isSignal()) {
        RefCSLOmSignal actualSignal = CSLOmSignal::cast(*it1);
        RefTVec_RefCSLOmPortDecl formalPorts = cslFormalInterface->getPorts();
        //ASSERT(formalPorts.get(), "adaptInterfaceOrSignalGroupConnection(): formal interface has no ports on current level");---see bug 2341

        if(formalPorts.get()) {
        for(TVec_RefCSLOmPortDecl_const_iter it2 = formalPorts->begin(); it2 < formalPorts->end(); ++it2) {
          RefCSLOmExpr width = CSLOmSimpleBitRange::cast((*it2)->getBitRange())->getWidth();
          RefCSLOmExpr actualWidth = CSLOmSimpleBitRange::cast(actualSignal->getBitRange())->getWidth();
          if(*((*it2)->getName()) == *(actualSignal->getName())
             &&CSLOmNumber::cast(width->doEval())->getValue() == CSLOmNumber::cast(actualWidth->doEval())->getValue()) {
            
            adaptPortOrSignalConnection(CSLOmConnectable::cast(actualSignal), CSLOmConnectable::cast(*it2),cdomModuleInst );
            break;
          }
        }
        }
      }
      else if((*it1)->isSignalGroup()) {
        RefCSLOmGroupSignal actualSigGroup = CSLOmGroupSignal::cast(*it1);
        RefTVec_RefCSLOmInterface formalInterfaces = cslFormalInterface->getInterfaces();
        //ASSERT(formalInterfaces.get(), "adaptInterfaceOrSignalGroupConnection(): formal interface has no interface children on current level");---see bug 2341

        if(formalInterfaces.get()) {
        for(TVec_RefCSLOmInterface_iter it2 = formalInterfaces->begin(); it2 < formalInterfaces->end(); ++it2) {
          if(*(*it2)->getName() == *(actualSigGroup->getName())) {
            adaptInterfaceOrSignalGroupConnection(actualSigGroup, *it2, cdomModuleInst);
            break;
          }
        }
        }
      }
      else if((*it1)->isID()) {
        continue;
      }
    }
  }

  //connect actual signal group to formal signal group
  else if(cslActual->isSignalGroup() && cslFormal->isSignalGroup()) {
    RefCSLOmGroupSignal cslActualSigGroup = CSLOmGroupSignal::cast(cslActual);
    RefCSLOmGroupSignal cslFormalSigGroup = CSLOmGroupSignal::cast(cslFormal);
    RefTVec_RefCSLOmBase actualChildren = cslActualSigGroup->getChildrenAsBase();
    ASSERT(actualChildren.get(), "adaptInterfaceOrSignalGroupConnection(): actual signal group has no children");

    for(TVec_RefCSLOmBase_const_iter it1 = actualChildren->begin(); it1 < actualChildren->end(); ++it1) {
      if((*it1)->isSignal()) {
        RefCSLOmSignal actualSignal = CSLOmSignal::cast(*it1);
        RefTVec_RefCSLOmSignal formalSignals = cslFormalSigGroup->getSignals();
        //ASSERT(formalSignals.get(), "adaptInterfaceOrSignalGroupConnection(): formal signal group has no signals on current level"); ---see bug 2341

        if(formalSignals.get()) {
        for(TVec_RefCSLOmSignal_const_iter it2 = formalSignals->begin(); it2 < formalSignals->end(); ++it2) {
          RefCSLOmExpr width = CSLOmSimpleBitRange::cast((*it2)->getBitRange())->getWidth();
          RefCSLOmExpr actualWidth = CSLOmSimpleBitRange::cast(actualSignal->getBitRange())->getWidth();
          if(*((*it2)->getName()) == *(actualSignal->getName())
             &&CSLOmNumber::cast(width->doEval())->getValue() == CSLOmNumber::cast(actualWidth->doEval())->getValue()) {
            adaptPortOrSignalConnection(CSLOmConnectable::cast(actualSignal), CSLOmConnectable::cast(*it2), cdomModuleInst);
            break;
          }
        }
        }
      }
      else if((*it1)->isSignalGroup()) {
        RefCSLOmGroupSignal actualSigGroup = CSLOmGroupSignal::cast(*it1);
        RefTVec_RefCSLOmGroupSignal formalSigGroups = cslFormalSigGroup->getGroupSignals();
        //ASSERT(formalSigGroups.get(), "adaptInterfaceOrSignalGroupConnection(): formal has no signal groups on current level");

        if(formalSigGroups.get()) {
        for(TVec_RefCSLOmGroupSignal_const_iter it2 = formalSigGroups->begin(); it2 < formalSigGroups->end(); ++it2) {
          if(*((*it2)->getName()) == *(actualSigGroup->getName())) {
            adaptInterfaceOrSignalGroupConnection(actualSigGroup, *it2, cdomModuleInst);
            break;
          }
        }
        }
      }
      else if((*it1)->isID()) {
        continue;
      }
    }
  }
}


NSCdom::CDOmNumber::ENumBaseType CAdapterToCDOM::getCDOmNumType(NSCSLOm::CSLOmNumber::ENumBaseType type) {
  switch(type) {
    case CSLOmNumber::NUM_BASE_BIN:
      return CDOmNumber::NUM_BASE_BIN;
    case CSLOmNumber::NUM_BASE_OCT:
      return CDOmNumber::NUM_BASE_OCT;
    case CSLOmNumber::NUM_BASE_DEC:
      return CDOmNumber::NUM_BASE_DEC;
    case CSLOmNumber::NUM_BASE_HEX:
      return CDOmNumber::NUM_BASE_HEX;
    default:
      ASSERT(FAIL, "The cslom input base type is invalid");
  }
}
    //NOT CALLED EVER AND BREAK BUILD ON WINDOWS
// RefString CAdapterToCDOM::getNumberString(const RefString& numStr, NSCSLOm::CSLOmNumber::ENumBaseType baseType) { 
//   ASSERT(numStr.get(), "The input number string is null");
//   if(    hashBin.size() != 256
//       || hashOct.size() != 256
//       || hashDec.size() != 256
//       || hashHex.size() != 256
//       )
//      initHashes();
//   switch(baseType) {
//     case NSCSLOm::CSLOmNumber::NUM_BASE_BIN:
//       return stripBin(numStr);
//     case NSCSLOm::CSLOmNumber::NUM_BASE_OCT:
//       return stripOct(numStr);
//     case NSCSLOm::CSLOmNumber::NUM_BASE_DEC:
//       return stripDec(numStr);
//     case NSCSLOm::CSLOmNumber::NUM_BASE_HEX:
//       return stripHex(numStr);
//     default:
//       ASSERT(FAIL, "The cslom input base type is invalid");
//   }
// }

std::vector<int> CAdapterToCDOM::hashBin = vector<int>();
std::vector<int> CAdapterToCDOM::hashOct = vector<int>();
std::vector<int> CAdapterToCDOM::hashDec = vector<int>();
std::vector<int> CAdapterToCDOM::hashHex = vector<int>();

void CAdapterToCDOM::initHashes() {
  hashBin.assign(265,0);
  hashOct.assign(265,0);
  hashDec.assign(265,0);
  hashHex.assign(265,0);
  for( char c = '0'; c<='1'; c++ ) {
    hashBin [c] = 1;
    hashOct [c] = 1;   
    hashDec [c] = 1;   
    hashHex [c] = 1;   
    //hashReal[c] = 1;
  }

  for( char c = '2'; c<='7'; c++ ) {
    hashOct [c] = 1;   
    hashDec [c] = 1;   
    hashHex [c] = 1;   
    //hashReal[c] = 1;
  }

  for( char c = '8'; c<='9'; c++ ) {
    hashDec [c] = 1;   
    hashHex [c] = 1;   
    //hashReal[c] = 1;
  }
//01000001 //A
//01100001 //a
//0010 0000 //mask 0x20

  for( char c = 'A'; c<='F'; c++ ) {
    hashHex [c] = 1;   
    hashHex [c|0x20] = 1;   
  }
  
  hashBin  ['X'] = 1;
  hashOct  ['X'] = 1;   
  hashDec  ['X'] = 1;   
  hashHex  ['X'] = 1;   
  
  hashBin  ['x'] = 1;
  hashOct  ['x'] = 1;   
  hashDec  ['x'] = 1;   
  hashHex  ['x'] = 1;   
  
  hashBin  ['z'] = 1;
  hashOct  ['z'] = 1;   
  hashDec  ['z'] = 1;   
  hashHex  ['z'] = 1;   
  
  hashBin  ['Z'] = 1;
  hashOct  ['Z'] = 1;   
  hashDec  ['Z'] = 1;   
  hashHex  ['Z'] = 1;   
  
  hashBin  ['?'] = 1;
  hashOct  ['?'] = 1;   
  hashDec  ['?'] = 1;   
  hashHex  ['?'] = 1;   

  //hashReal ['e'] = 1;
  //hashReal ['E'] = 1;
  //hashReal ['+'] = 1;
  //hashReal ['-'] = 1;
  //hashReal ['.'] = 1;
}

RefCDOmDesign CAdapterToCDOM::            buildCDOmDesign                     () {
 
  return CDOmDesign::build();
}

RefCDOmComment CAdapterToCDOM::           buildCDOmComment                    ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                CDOmComment::ECommentType commentType,
                                                                                RefString commentLine
                                                                              ) {
  return CDOmComment::build(lineNumber, parent, commentType, commentLine);
}

RefCDOmInclude CAdapterToCDOM::           buildCDOmInclude                    ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                NSCdom::EIncludeFileType type,
                                                                                RefString fileName
                                                                              ) {
 return CDOmInclude ::build(lineNumber, parent, type, fileName);
}

RefCDOmExprLink CAdapterToCDOM::          buildCDOmExprLink                   ( TInt lineNumber, 
                                                                                const RefString& name, 
                                                                                RefCDOmExpr expr 
                                                                              ) {
  return CDOmExprLink::build(lineNumber, name, expr);
}

RefCDOmExprConcat CAdapterToCDOM::          buildCDOmConcat               ( TInt lineNumber, 
                                                                             RefTVec_RefCSLOmBase exprs 
                                                                           ) {
  RefCDOmExprConcat exprConcat = RefCDOmExprConcat();
  for(TVec_RefCSLOmBase_const_iter it = exprs->begin(); it < exprs->end(); ++it) {
    if((*it)->isNumber()) {
      RefCDOmNum32  nr = CDOmNum32::build(lineNumber, CSLOmNum32::cast(*it)->getValue(), getCDOmNumType(CSLOmNum32::cast(*it)->getNumBaseType()));
      if(exprConcat.get()) {
        exprConcat->addExpr(nr);
      }
      else {
        exprConcat = buildCDOmExprConcat(lineNumber, nr);
      }
    }
    else if((*it)->isExprLink()) {
      RefCDOmExprLink cdomExprLink = RefCDOmExprLink();
      if(CSLOmExprLink::cast(*it)->isHID()) {
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(*it);
        RefCSLOmBase expr = exprLink->doEval();
        if (expr->isPort() || expr->isSignal()) {
          NSCSLOm::RefCSLOmConnectable obj = CSLOmConnectable::cast(expr);
          NSCSLOm::RefCSLOmExprLink expr = obj->getF2ALink();
          RefTVec_RefString temp = expr->getHidNames();
          RefString name = RefString(new std::string(""));
          RefCSLOmBase vecCurParent=RefCSLOmBase();
          TVec_RefString::iterator iter = temp->end()-1;
      
          vecCurParent=obj->getParent();
          iter--;
          for (; iter >= temp->begin(); iter--) {
            if(vecCurParent->isInterface() && !CSLOmInterface::cast(vecCurParent)->isDefaultIfc()){
              RefCSLOmInterface ifc=CSLOmInterface::cast(vecCurParent);
              if(!ifc->getNoPrefixBit()){
                if(!(ifc->getPrefix()).get()){
                  name->insert(0,"_");
                  name->insert(0,*(*iter));
                }
                else{
                  name->insert(0,"_");
                  name->insert(0,*ifc->getPrefix());
                }
              }
              if(ifc->getSuffix().get()) {
                name->append(*ifc->getSuffix());
                name->append("_");
              }
            }
            else if(vecCurParent->isSignalGroup()){
              RefCSLOmGroupSignal sg=CSLOmGroupSignal::cast(vecCurParent);
              if(!sg->getNoPrefixBit()){
                if(!(sg->getPrefix()).get()){
                  name->insert(0,"_");
                  name->insert(0,*(*iter));
                }
                else{
                  name->insert(0,"_");
                  name->insert(0,*sg->getPrefix());
                }
              }
              if(sg->getSuffix().get()) {
                name->append(*sg->getSuffix());
                name->append("_");
              }
            }
            else{
              name->insert(0,"_");
              name->insert(0,*(*iter));
            }
        
            vecCurParent=vecCurParent->getParent();
          }
          name->append(*exprLink->getName());

          cdomExprLink = buildCDOmExprLink(exprLink->getLineNumber(), name);  
        }
        else {
          const RefTVec_RefString names = exprLink->getHidNames();
          for(TVec_RefString_const_iter it = names->begin(); it < names->end(); ++it) {
            if(!cdomExprLink.get()) {
              cdomExprLink = buildCDOmExprLink(exprLink->getLineNumber(), *it);
            }
            else {
              CDOmExprLink::cast(cdomExprLink)->addHidItem(*it);
            }
          }
        }
      }
      else {
        cdomExprLink = buildCDOmExprLink(lineNumber, CSLOmExprLink::cast(*it)->getName());
      }
      
      if(exprConcat.get()) {
        exprConcat->addExpr(cdomExprLink);
      }
      else {
        exprConcat = buildCDOmExprConcat(lineNumber, cdomExprLink);
      }
    }
    else if((*it)->isExpr()) {
      RefCSLOmExpr expr = CSLOmExpr::cast(*it);
      if((expr)->isOp()) {
        RefCSLOmExprOp exprOp = CSLOmExprOp::cast(expr);
        exprOp->acceptVisitor(*this);
        //        RefCDOmExpr exprChild = CDOmExpr::cast(m_cdomReturnedValue);
        if(exprConcat.get()) {
          exprConcat->addExpr(CDOmExpr::cast(m_cdomReturnedValue));
        }
        else {
          exprConcat = buildCDOmExprConcat(lineNumber, CDOmExpr::cast(m_cdomReturnedValue));
        }
      }
      else if(expr->isConcat()) {
        RefTVec_RefCSLOmBase concatExprs = CSLOmExprConcat::cast(*it)->getExprsAsBase();
        if(concatExprs.get()) {
          RefCDOmExpr exprChild = buildCDOmConcat(lineNumber, concatExprs);
          if(exprConcat.get()) {
            exprConcat->addExpr(exprChild);
          }
          else {
            exprConcat = buildCDOmExprConcat(lineNumber, exprChild);
          }
        }   
      }
      else if(expr->isMultiConcat()) {
        RefTVec_RefCSLOmBase concatExprs = CSLOmExprMultiConcat::cast(*it)->getExprsAsBase();
        if(concatExprs.get()) {
          RefCDOmExpr exprChild = buildCDOmConcat(lineNumber, concatExprs);
          if(exprConcat.get()) {
            exprConcat->addExpr(exprChild);
          }
          else {
            exprConcat = buildCDOmExprConcat(lineNumber, exprChild);
          }
        }
      }
    }
    else {
      ASSERT(FAIL, "Adapter only supports number, expr link, expr op, concat and multiconcat as children");
    }
  }

  return exprConcat;
}

RefCDOmExprMultiConcat CAdapterToCDOM::buildCDOmMultiConcat               ( TInt lineNumber, 
                                                                             RefCSLOmExpr expr 
                                                                           ) {
  RefCSLOmExprMultiConcat exprMultiConcat = CSLOmExprMultiConcat::cast(expr);

  RefCDOmExprConcat exprConcat = RefCDOmExprConcat();;
  RefCSLOmExprConcat concatExpr = exprMultiConcat->getExprConcat();
  RefTVec_RefCSLOmBase concatChildren = concatExpr->getExprsAsBase();
  exprConcat = buildCDOmConcat(lineNumber, concatChildren);
   
  RefCSLOmNum32 no = CSLOmNum32::cast(exprMultiConcat->getExpr());
  RefCDOmNum32 expr2 = CDOmNum32::build(lineNumber, no->getValue(), getCDOmNumType(no->getNumBaseType()));

  return CDOmExprMultiConcat::build(lineNumber, expr2, exprConcat);
}



RefCDOmString CAdapterToCDOM::          buildCDOmString                     ( TInt lineNumber, 
                                                                                const RefString& name, 
                                                                                RefCDOmExpr expr 
                                                                              ) {
  return CDOmString::build(lineNumber, name);
}

RefCDOmExprOp CAdapterToCDOM::            buildCDOmExprOp                     ( TInt lineNumber, 
                                                                                CDOmExprOp::EOpType opType, 
                                                                                RefCDOmExpr expr1, 
                                                                                RefCDOmExpr expr2, 
                                                                                RefCDOmExpr expr3 
                                                                              ) {
  return CDOmExprOp::build(lineNumber, opType, expr1, expr2, expr3);
}

RefCDOmStmt CAdapterToCDOM::              buildCDOmStmtNull                   ( TInt lineNumber) {
  return CDOmStmt::buildNullStmt(lineNumber);
}

RefCDOmStmtAssn CAdapterToCDOM::          buildCDOmStmtAssnSimple             ( TInt lineNumber, 
                                                                                CDOmStmtAssn::EAssnType assnType, 
                                                                                RefCDOmExpr lvalue,
                                                                                RefCDOmExpr expr
                                                                              ) {
  return CDOmStmtAssn::buildSimple(lineNumber, assnType, lvalue, expr);
}

RefCDOmStmtAssn CAdapterToCDOM::          buildCDOmStmtAssnWithDelayControl   ( TInt lineNumber, 
                                                                                CDOmStmtAssn::EAssnType assnType, 
                                                                                RefCDOmExpr lvalue,
                                                                                RefCDOmExpr expr,
                                                                                RefCDOmDelayControl delayControl
                                                                              ) {
  return CDOmStmtAssn::buildWithDelayControl(lineNumber, assnType, lvalue, expr, delayControl);
}

RefCDOmStmtAssn CAdapterToCDOM::          buildCDOmStmtAssnWithEventControl   ( TInt lineNumber, 
                                                                                CDOmStmtAssn::EAssnType assnType, 
                                                                                RefCDOmExpr lvalue,
                                                                                RefCDOmExpr expr,
                                                                                RefCDOmEventControl evntControl,
                                                                                RefCDOmExpr repeatExpr
                                                                              ) {
  return CDOmStmtAssn::buildWithEventControl(lineNumber, assnType, lvalue, expr, evntControl, repeatExpr);
}

RefCDOmDelayControl CAdapterToCDOM::      buildCDOmDelayControl               ( TInt lineNumber, 
                                                                                RefCDOmNumber num 
                                                                              ) {
  return CDOmDelayControl::build(lineNumber, num);
}

RefCDOmEventControl CAdapterToCDOM::      buildCDOmEventControlWithHid        ( TInt lineNumber, 
                                                                                RefCDOmExprLink hid 
                                                                              ) {
  return CDOmEventControl::build(lineNumber, hid);
}

RefCDOmEventControl CAdapterToCDOM::      buildCDOmEventControlWithEvExpr     ( TInt lineNumber, 
                                                                                RefCDOmEventExpr evExpr 
                                                                              ) {
  return CDOmEventControl::build(lineNumber, evExpr);
}

RefCDOmEventControl CAdapterToCDOM::      buildCDOmEventControlWithBool       ( TInt lineNumber, 
                                                                                TBool starWithParenthesis 
                                                                              ) {
  return CDOmEventControl::build(lineNumber, starWithParenthesis);
}

RefCDOmEventExpr CAdapterToCDOM::         buildCDOmEventExprSimple            ( TInt lineNumber, 
                                                                                CDOmEventExpr::EEventExprType type, 
                                                                                RefCDOmExpr expr
                                                                              ) {
  return CDOmEventExpr::build(lineNumber, type, expr);
}

RefCDOmEventExpr CAdapterToCDOM::         buildCDOmEventExprDouble            ( TInt lineNumber, 
                                                                                CDOmEventExpr::EEventExprType type, 
                                                                                RefCDOmEventExpr expr1,
                                                                                RefCDOmEventExpr expr2
                                                                              ) {
  return CDOmEventExpr::build(lineNumber, type, expr1, expr2);
}

RefCDOmStmtIf CAdapterToCDOM::            buildCDOmStmtIf                     ( TInt lineNumber, 
                                                                                RefCDOmExpr ifCondExpr, 
                                                                                RefCDOmStmt ifStmt, 
                                                                                RefCDOmStmt elseStmt
                                                                              ) {
  return CDOmStmtIf::build(lineNumber, ifCondExpr , ifStmt, elseStmt);
}

RefCDOmStmtCase CAdapterToCDOM::          buildCDOmStmtCase                   ( TInt lineNumber, 
                                                                                CDOmStmtCase::ECaseType type, 
                                                                                RefCDOmExpr expr,
                                                                                RefCDOmListExpr listExpr, 
                                                                                RefCDOmStmt stmt
                                                                              ) {
  return CDOmStmtCase::build(lineNumber, type, expr, listExpr, stmt);
}

RefCDOmStmtDisable CAdapterToCDOM::       buildCDOmStmtDisable                ( TInt lineNumber, 
                                                                                RefCDOmExprLink hid 
                                                                              ) {
  return CDOmStmtDisable::build(lineNumber, hid);
}

RefCDOmStmtLoop CAdapterToCDOM::          buildCDOmStmtLoopForever            ( TInt lineNumber, 
                                                                                RefCDOmStmt stmt
                                                                              ) {
  return CDOmStmtLoop::buildForeverStmt(lineNumber, stmt);
}

RefCDOmStmtLoop CAdapterToCDOM::          buildCDOmStmtLoopRepeat             ( TInt lineNumber, 
                                                                                RefCDOmExpr expr, 
                                                                                RefCDOmStmt stmt
                                                                              ) {
  return CDOmStmtLoop::buildRepeatStmt(lineNumber, expr, stmt);
}

RefCDOmStmtLoop CAdapterToCDOM::          buildCDOmStmtLoopWhile              ( TInt lineNumber,
                                                                                RefCDOmExpr expr,
                                                                                RefCDOmStmt stmt
                                                                                ) {
  return CDOmStmtLoop::buildWhileStmt(lineNumber, expr, stmt);
}

RefCDOmStmtLoop CAdapterToCDOM::        buildCDOmStmtLoopFor                  ( TInt lineNumber,
                                                                                RefCDOmAssn initAssn,
                                                                                RefCDOmExpr condExpr,
                                                                                RefCDOmAssn incAssn,
                                                                                RefCDOmStmt stmt
                                                                                ) {
  return CDOmStmtLoop::buildForStmt(lineNumber, initAssn, condExpr, incAssn, stmt);
}

RefCDOmStmtEventTrigger CAdapterToCDOM::  buildCDOmStmtEventTrigger           ( TInt lineNumber, 
                                                                                RefCDOmExprLink hid, 
                                                                                RefCDOmListExpr listExpr
                                                                              ) {
  return CDOmStmtEventTrigger::build(lineNumber, hid, listExpr);
}

RefCDOmStmtBlock CAdapterToCDOM::         buildCDOmStmtBlock                  ( TInt lineNumber, 
                                                                                CDOmStmtBlock::EBlockType blockType, 
                                                                                const RefString& name
                                                                              ) {
  return CDOmStmtBlock::build(lineNumber, blockType, name);
}

RefCDOmAssn CAdapterToCDOM::              buildCDOmAssn                       ( TInt lineNumber, 
                                                                                RefCDOmExpr lvalue, 
                                                                                RefCDOmExpr expr
                                                                              ) {
  return CDOmAssn::build(lineNumber, lvalue, expr);
}

RefCDOmContAssn CAdapterToCDOM::          buildCDOmContAssn                   ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                ECDOmDriveStrength first, 
                                                                                ECDOmDriveStrength second
                                                                              ) {
  return CDOmContAssn::build(lineNumber, parent, first, second);
}

RefCDOmStmtProcContAssn CAdapterToCDOM::  buildCDOmStmtProcContAssnWithAssn   ( TInt lineNumber,
                                                                                CDOmStmtProcContAssn::EProcContAssnType procContAssnType,
                                                                                RefCDOmAssn assn
                                                                              ) {
  return CDOmStmtProcContAssn::build(lineNumber, procContAssnType, assn);
}

RefCDOmStmtProcContAssn CAdapterToCDOM::  buildCDOmStmtProcContAssnWithLvalue ( TInt lineNumber,
                                                                                CDOmStmtProcContAssn::EProcContAssnType procContAssnType,
                                                                                RefCDOmExpr lvalue
                                                                              ) {
  return CDOmStmtProcContAssn::build(lineNumber, procContAssnType, lvalue);
}

RefCDOmStmtProcTimingControl CAdapterToCDOM:: buildCDOmStmtProcTimingControlWithEventControl ( TInt lineNumber,
                                                                                               RefCDOmEventControl eventControl,
                                                                                               RefCDOmStmt stmt
                                                                                             ) {
  return CDOmStmtProcTimingControl::buildWithEventControl(lineNumber, eventControl, stmt);
}

RefCDOmStmtProcTimingControl CAdapterToCDOM:: buildCDOmStmtProcTimingControlWithDelayControl  ( TInt lineNumber,
                                                                                                RefCDOmDelayControl delayControl,
                                                                                                RefCDOmStmt stmt
                                                                                              ) {
  return CDOmStmtProcTimingControl::buildWithDelayControl(lineNumber, delayControl, stmt);
}

RefCDOmStmtTaskEnable CAdapterToCDOM::    buildCDOmStmtTaskEnable             ( TInt lineNumber,
                                                                                CDOmStmtTaskEnable::ETaskEnableType taskEnableType,
                                                                                RefCDOmExprLink hid
                                                                              ) {
  return CDOmStmtTaskEnable::build(lineNumber, taskEnableType, hid);
}

RefCDOmStmtWait CAdapterToCDOM::          buildCDOmStmtWait                   ( TInt lineNumber,
                                                                                RefCDOmExpr expr,
                                                                                RefCDOmStmt stmt
                                                                              ) {
  return CDOmStmtWait::build(lineNumber, expr, stmt);
}

RefCDOmRange CAdapterToCDOM::             buildCDOmRange                      ( TInt lineNumber,
                                                                                RefCDOmExpr firstExpr,
                                                                                RefCDOmExpr secondExpr
                                                                              ) {
  return CDOmRange::build(lineNumber, firstExpr, secondExpr);
}

RefCDOmRangeList CAdapterToCDOM::         buildCDOmRangeList                  ( TInt lineNumber,
                                                                                RefCDOmRange rangeItem
                                                                              ) {
  return CDOmRangeList::build(lineNumber, rangeItem);
}

RefCDOmRangeExpr CAdapterToCDOM::         buildCDOmRangeExprSimple            ( TInt lineNumber,
                                                                                RefCDOmExpr firstExpr
                                                                              ) {
  return CDOmRangeExpr::buildSingleRangeExpr(lineNumber, firstExpr);
}

RefCDOmRangeExpr CAdapterToCDOM::         buildCDOmRangeExprDouble            ( TInt lineNumber,
                                                                                RefCDOmExpr firstExpr,
                                                                                RefCDOmExpr secondExpr,
                                                                                CDOmRangeExpr::ERangeExprType rangeExprType
                                                                              ) {
  return CDOmRangeExpr::buildDoubleRangeExpr(lineNumber, firstExpr, secondExpr, rangeExprType);
} 

RefCDOmParamDecl CAdapterToCDOM::         buildCDOmParamDecl                  ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                CDOmParamDecl::EParamDeclType paramDeclType
                                                                              ) {
  return CDOmParamDecl::build(lineNumber, parent, paramDeclType);
}

RefCDOmParamDecl CAdapterToCDOM::         buildCDOmParamDeclWithParamType     ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                CDOmParamDecl::EParamDeclType paramDeclType,
                                                                                CDOmParamDecl::EParamType     paramType
                                                                              ) {
  return CDOmParamDecl::build(lineNumber, parent, paramDeclType, paramType);
}

RefCDOmPortDecl CAdapterToCDOM::          buildCDOmPortDeclNet                ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                ECDOmPortType portType,
                                                                                ECDOmNetType netType,
                                                                                RefCDOmRange range,
                                                                                const RefString& name,
                                                                                RefCDOmExpr expr 
                                                                              ) {
  if(expr.get()) {
    ASSERT(name.get(), "Adding a net with no name to a portDecl is illegal");
  }
  RefCDOmPortDecl net = CDOmPortDecl::buildNetPortDecl(lineNumber, parent, portType, netType);
  if(range.get()) {
    net->setRange(range);
  }
  if(name.get()) {
    net->addPort(lineNumber, name, expr);
  }
  return net;
}

RefCDOmPortDecl CAdapterToCDOM::          buildCDOmPortDeclVar                ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                ECDOmVarType varType,
                                                                                RefCDOmRange range,
                                                                                const RefString& name,
                                                                                RefCDOmExpr expr 
                                                                              ) {
  if(expr.get()) {
    ASSERT(name.get(), "Adding a var with no name to a portDecl is illegal");
  }
  RefCDOmPortDecl var = CDOmPortDecl::buildVarPortDecl(lineNumber, parent, varType);
  if(range.get()) {
    var->setRange(range);
  }
  if(name.get()) {
    var->addPort(lineNumber, name, expr);
  }
  return var;
}

RefCDOmUdpPortDeclOutput CAdapterToCDOM:: buildCDOmUdpPortDeclOutput          ( TInt lineNumber,
                                                                                RefCDOmUdpDecl parent,
                                                                                CDOmUdpPortDeclOutput::EUdpPortDeclOutputType type,
                                                                                const RefString portName,
                                                                                RefCDOmExpr expr
                                                                              ) {
  return CDOmUdpPortDeclOutput::build(lineNumber, parent, type, portName, expr);
}

RefCDOmUdpPortDeclInput CAdapterToCDOM::  buildCDOmUdpPortDeclInput           ( TInt lineNumber,
                                                                                RefCDOmUdpDecl parent,
                                                                                const RefString portName
                                                                              ) {
  return CDOmUdpPortDeclInput::build(lineNumber, parent, portName);
}

RefCDOmTaskDecl CAdapterToCDOM::          buildCDOmTaskDecl                   ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                CDOmTaskDecl::ETaskDeclType taskDeclType,
                                                                                const RefString& name,
                                                                                TBool isAutomatic
                                                                              ) {
  return CDOmTaskDecl::build(lineNumber, parent, taskDeclType, name, isAutomatic);
}

RefCDOmFuncDecl CAdapterToCDOM::          buildCDOmFuncDecl                   ( TInt lineNumber,
                                                                                RefCDOmBase parent, 
                                                                                CDOmFuncDecl::EFuncDeclType funcDeclType,
                                                                                const RefString& name,
                                                                                TBool isAutomatic,
                                                                                TBool isSigned
                                                                              ) {
  return CDOmFuncDecl::build(lineNumber, parent, funcDeclType, name, isAutomatic, isSigned);
}

RefCDOmFunctionCall CAdapterToCDOM::      buildCDOmFunctionCall               ( TInt lineNumber,
                                                                                RefCDOmExprLink exprLink,
                                                                                RefCDOmListExpr exprList,
                                                                                RefCDOmAttrListCollection attrListCollection
                                                                                ) {
  return CDOmFunctionCall::build(lineNumber, exprLink, exprList, attrListCollection);
}

RefCDOmVarDecl CAdapterToCDOM::           buildCDOmVarDecl                    ( TInt lineNumber,
                                                                                RefCDOmBase parent,
                                                                                ECDOmVarType varType,
                                                                                RefCDOmRange range,
                                                                                RefString name,
                                                                                RefCDOmRangeList rangeList,
                                                                                RefCDOmExpr expr 
                                                                              ) {
  RefCDOmVarDecl varDecl = CDOmVarDecl::build(lineNumber, parent, varType);
  if(range.get()) {
    varDecl->setRange(range);
  }
  if(name.get()) {
    if(!expr.get()) {
      varDecl->addVar(lineNumber, name, rangeList);
    }
    else {
      ASSERT(!rangeList.get(), "CDOmVarDec;::addVar(): both rangeList and expr exist");
      varDecl->addVar(lineNumber, name, expr);
    }
  }
  return varDecl;
}

RefCDOmNetDecl CAdapterToCDOM::           buildCDOmNetDecl                     ( TInt lineNumber,
                                                                                 RefCDOmBase parent,
                                                                                 ECDOmNetType netType,
                                                                                 RefCDOmRange range,
                                                                                 CDOmNetDecl::EVectorAccessType vat,
                                                                                 RefString name,
                                                                                 RefCDOmRangeList rangeList,
                                                                                 RefCDOmExpr expr 
                                                                               ) {
  RefCDOmNetDecl netDecl = CDOmNetDecl::build(lineNumber, parent, netType);
  if(range.get()) {
    netDecl->setRange(range, vat);
  }
  if(name.get()) {
    if(!expr.get()) {
      netDecl->addNet(lineNumber, name, rangeList);
    }
    else {
      ASSERT(!rangeList.get(), "CDOmNetDecl::addNet(): both rangeList and expr exist");
      netDecl->addNet(lineNumber, name, expr);
    }
  }
  return netDecl;
}

RefCDOmMinTypMax CAdapterToCDOM::         buildCDOmMinTypMax                   ( TInt lineNumber,
                                                                                 RefCDOmExpr expr1,
                                                                                 RefCDOmExpr expr2, 
                                                                                 RefCDOmExpr expr3 
                                                                               ) {
  if(!expr2.get() && !expr3.get()) {
    return CDOmMinTypMax::build(lineNumber, expr1);
  }
  else if (expr2.get() && expr3.get()) {
    return CDOmMinTypMax::build(lineNumber, expr1, expr2, expr3);
  }
  else {
    ASSERT(FAIL, "A mintypmax cannot take 2 expressions(1 or 3)");
  }
}

RefCDOmEventDecl CAdapterToCDOM::         buildCDOmEventDecl                   ( TInt lineNumber,
                                                                                 RefCDOmBase parent,
                                                                                 const RefString& name,
                                                                                 RefCDOmRangeList rangeList 
                                                                                ) {
  return CDOmEventDecl::build(lineNumber, parent, name, rangeList);
}

RefCDOmModuleOrUdpInstantiation CAdapterToCDOM::  buildCDOmModuleOrUdpInstantiation    ( TInt lineNumber,
                                                                                         RefCDOmBase parent,
                                                                                         RefCDOmExprLink moduleExprLink
                                                                                       ) {
  return CDOmModuleOrUdpInstantiation::build(lineNumber, parent, moduleExprLink);
}

RefCDOmInitOrAlways CAdapterToCDOM::      buildCDOmInitOrAlways                ( TInt lineNumber,
                                                                                 RefCDOmBase parent,
                                                                                 CDOmInitOrAlways::EInitOrAlwaysType initOrAlwaysType,
                                                                                 RefCDOmStmt stmt
                                                                                ) {
  return CDOmInitOrAlways::build(lineNumber, parent, initOrAlwaysType, stmt);
}

RefCDOmSpecifyBlock CAdapterToCDOM::      buildCDOmSpecifyBlock                ( TInt lineNumber,
                                                                                 RefCDOmModuleDecl parent
                                                                               ) {
  return CDOmSpecifyBlock::build(lineNumber, parent);
}

RefCDOmNum32 CAdapterToCDOM::             buildCDOmNum32WithValue              ( TInt lineNumber,
                                                                                 TInt value
                                                                               ) {
  return CDOmNum32::build(lineNumber, value);
}

RefCDOmNum32 CAdapterToCDOM::             buildCDOmNum32WithString             ( TInt lineNumber,
                                                                                 CDOmNumber::ENumBaseType base,
                                                                                 RefString num,
                                                                                 TInt width
                                                                               ) {
  return CDOmNum32::build(lineNumber, base, num, width);
}

RefCDOmListExpr CAdapterToCDOM::          buildCDOmListExpr                    ( TInt lineNumber, 
                                                                                 RefCDOmExpr item
                                                                               ) {
  return CDOmListExpr::build(lineNumber, item);
}
    
RefCDOmParamOverride CAdapterToCDOM::     buildCDOmParamOverride               ( TInt lineNumber,
                                                                                 RefCDOmBase parent,
                                                                                 RefCDOmExprLink hid,
                                                                                 RefCDOmMinTypMax minTypMax
                                                                               ) {
  return CDOmParamOverride::build(lineNumber, parent, hid, minTypMax);
}

RefCDOmExprConcat CAdapterToCDOM::        buildCDOmExprConcat                  ( TInt lineNumber,
                                                                                 RefCDOmExpr expr
                                                                               ) {
  return CDOmExprConcat::build(lineNumber, expr);
}

RefCDOmExprMultiConcat CAdapterToCDOM::   buildCDOmExprMultiConcat             ( TInt lineNumber,
                                                                                 RefCDOmExpr expr,
                                                                                 RefCDOmExprConcat exprConcat
                                                                               ) {
  return CDOmExprMultiConcat::build(lineNumber, expr, exprConcat);
}

RefCDOmDefine CAdapterToCDOM::            buildCDOmDefine                      (  TInt lineNumber, 
                                                                                  RefCDOmBase parent,
                                                                                  CDOmDefine::EDefineType defineType,
                                                                                  RefString macroName,
                                                                                  RefCDOmExpr macroText
                                                                                ) {
  return CDOmDefine::build(lineNumber, parent, defineType, macroName, macroText);
}




void  CAdapterToCDOM::adaptFlipFlop                                             ( TLineNumberType lineNumber,
                                                                                  TInt flipFlopWidth,
                                                                                  RefString inputName,
                                                                                  RefString outputName,
                                                                                  RefString clockName,
                                                                                  RefString resetName
                                                                                ) {
  ASSERT(inputName.get(), "adaptFlipFlop:: null input port name received");
  ASSERT(outputName.get(), "adaptFlipFlop:: null output port name received");
  ASSERT(clockName.get(), "adaptFlipFlop:: null clock port name received");
  ASSERT(resetName.get(), "adaptFlipFlop: null reset port name received");

  ASSERT(m_cdomCurrParent.get(), "adaptFlipFlop: cdom current parent is null");
  ASSERT(m_cdomCurrParent->getType() == TYPE_DECL_MODULE, "adaptFlipFlop: cdom current parent is not a module");

  //build flip-flop ports - at this point they should already be built (or not see which you should decomment)
  //RefCDOmPortDecl clockPort = buildCDOmPortDeclNet( lineNumber,
  //                                                  m_cdomCurrParent, 
  //                                                  PORT_INPUT,  
  //                                                  NET_WIRE, 
  //                                                  buildCDOmRange( lineNumber, 
  //                                                                  buildCDOmNum32WithValue(lineNumber, 0),
  //                                                                  buildCDOmNum32WithValue(lineNumber, 0)
  //                                                                ),
  //                                                  clockName
  //                                                );
  //RefCDOmPortItem  clockPortItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, clockName);
 
  //RefCDOmPortDecl resetPort = buildCDOmPortDeclNet( lineNumber,
  //                                                  m_cdomCurrParent, 
  //                                                  PORT_INPUT,  
  //                                                  NET_WIRE, 
  //                                                  buildCDOmRange( lineNumber, 
  //                                                                  buildCDOmNum32WithValue(lineNumber, 0),
  //                                                                  buildCDOmNum32WithValue(lineNumber, 0)
  //                                                                ),
  //                                                  resetName
  //                                                ); 
  //RefCDOmPortItem  resetPortItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, resetName);

  //RefCDOmPortDecl inputPort = buildCDOmPortDeclNet( lineNumber,
  //                                                  m_cdomCurrParent, 
  //                                                  PORT_INPUT,  
  //                                                  NET_WIRE, 
  //                                                  buildCDOmRange( lineNumber, 
  //                                                                  buildCDOmNum32WithValue(lineNumber, flipFlopWidth-1),
  //                                                                  buildCDOmNum32WithValue(lineNumber, 0)
  //                                                                ),
  //                                                  inputName
  //                                                );
  //RefCDOmPortItem  inputPortItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, inputName);

  //RefCDOmPortDecl outputPort = buildCDOmPortDeclNet( lineNumber,
  //                                                   m_cdomCurrParent, 
  //                                                   PORT_OUTPUT,  
  //                                                   NET_WIRE, 
  //                                                   buildCDOmRange( lineNumber, 
  //                                                                   buildCDOmNum32WithValue(lineNumber, flipFlopWidth-1),
  //                                                                   buildCDOmNum32WithValue(lineNumber, 0)
  //                                                                 ),
  //                                                   outputName
  //                                                 );
  //RefCDOmPortItem  outputPortItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, outputName);

  //build always block
  RefCDOmStmtBlock ifStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  ifStmtBlock->addStmt(buildCDOmStmtAssnSimple( lineNumber, 
                                                CDOmStmtAssn::ASSN_BLOCKING,
                                                buildCDOmExprLink(lineNumber, outputName),
                                                buildCDOmNum32WithValue(lineNumber, flipFlopWidth)
                                              )
                      );
  RefCDOmStmtBlock elseStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  elseStmtBlock->addStmt( buildCDOmStmtAssnSimple( lineNumber,
                                                   CDOmStmtAssn::ASSN_BLOCKING,
                                                   buildCDOmExprLink(lineNumber, outputName),
                                                   buildCDOmExprLink(lineNumber, inputName)
                                                 )
                        );
  RefCDOmStmtIf ifStatement = buildCDOmStmtIf( lineNumber, 
                                               buildCDOmExprOp( lineNumber, 
                                                                CDOmExprOp::OP_UNARY_BITWISE_NOT,
                                                                buildCDOmExprLink(lineNumber, resetName)
                                                              ),
                                               ifStmtBlock,
                                               elseStmtBlock
                                             );
  
  RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  stmtBlock->addStmt(ifStatement);
  
  RefCDOmEventExpr evExpr = buildCDOmEventExprDouble( lineNumber, 
                                                      CDOmEventExpr::EVENT_EXPR_OR, 
                                                      buildCDOmEventExprSimple( lineNumber, 
                                                                                CDOmEventExpr::EVENT_EXPR_POSEDGE, 
                                                                                buildCDOmExprLink(lineNumber, clockName)
                                                                              ),
                                                      buildCDOmEventExprSimple( lineNumber,
                                                                                CDOmEventExpr::EVENT_EXPR_NEGEDGE,
                                                                                buildCDOmExprLink(lineNumber, resetName)
                                                                              )
                                                    );
  RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);
  RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock);
  RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc );
}

//void CAdapterToCDOM::adaptMultiplexor ( TLineNumberType lineNumber, 
//                                        TInt outputWidth,
//                                        RefTVec_RefString inputNames, 
//                                        RefString selectName, 
//                                        RefString outputName
//                                      ) {
//  ASSERT(inputNames.get(), "adaptMultiplexor: null input name vector received");
//  ASSERT(selectName.get(), "adaptMultiplexor: null select signal name received");
//  ASSERT(outputName.get(), "adaptMultiplexor: null output signal name received");
//  ASSERT(m_cdomCurrParent.get(), "adaptMultiplexor: cdom current parent is null");
//  ASSERT(m_cdomCurrParent->getType() == TYPE_DECL_MODULE, "adaptMultiplexor: cdom current parent is not a module");
//
//  //build outputput port
//
//  RefCDOmPortDecl outputPort = buildCDOmPortDeclVar(lineNumber, 
//                                                    m_cdomCurrParent, 
//                                                    VAR_REG,  
//                                                    buildCDOmRange( lineNumber,
//                                                                    buildCDOmNum32WithValue(lineNumber, outputWidth-1),
//                                                                    buildCDOmNum32WithValue(lineNumber, 0)
//                                                                  ),
//                                                    outputName
//                                                   );
//  RefCDOmPortItem outputPortItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, outputName);
//
//  //build always block with case
//  TInt i = 0;
//  RefCDOmStmtCase stmtCase;
//  for(TVec_RefString_const_iter it = inputNames->begin(); it < inputNames->end(); ++it) {
//    if(!stmtCase.get()) {
//      RefCDOmListExpr list = buildCDOmListExpr(lineNumber, buildCDOmNum32WithValue(lineNumber, i++));
//      RefCDOmStmtAssn stmt = buildCDOmStmtAssnSimple( lineNumber, 
//                                                      CDOmStmtAssn::ASSN_BLOCKING,  
//                                                      buildCDOmExprLink(lineNumber, outputName),
//                                                      buildCDOmExprLink(lineNumber, *it)
//                                                    );
//      stmtCase = buildCDOmStmtCase( lineNumber, 
//                                    CDOmStmtCase::CASE_CASE, 
//                                    buildCDOmExprLink(lineNumber, selectName),
//                                    list,
//                                    stmt
//                                  );
//    }
//    else {
//      stmtCase->addCaseItem( buildCDOmListExpr(lineNumber, buildCDOmNum32WithValue(lineNumber, i++)),
//                             buildCDOmStmtAssnSimple( lineNumber, 
//                                                      CDOmStmtAssn::ASSN_BLOCKING,
//                                                      buildCDOmExprLink(lineNumber, outputName),
//                                                      buildCDOmExprLink(lineNumber, *it)
//                                                    )
//                           );
//    }
//  }
//  
//  RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
//  stmtBlock->addStmt(stmtCase);
//  
//  RefCDOmEventControl evCtrl = buildCDOmEventControlWithHid(lineNumber, buildCDOmExprLink(lineNumber, selectName));
//  RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock );
//  RefCDOmInitOrAlways always = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc);
//    
//  
//}

void CAdapterToCDOM::adaptMultiplexor(TInt lineNumber, TInt nrOfSelectBits, RefString outputName, RefTVec_RefCDOmExpr inputs, RefTVec_RefCDOmExpr selects) {
  ASSERT(nrOfSelectBits, "adaptMultiplexor:number of mux select bits cannot be nul");
  if(nrOfSelectBits == 1) {
    ASSERT(selects.get() && selects->size() == 1, "adaptMultiplexor: input parametrs are not consistent");
    ASSERT(inputs.get() && inputs->size() == 2, "adaptMultiplexor: input parameters are not consistent");
    //assign statement
    RefCDOmAssn assn = buildCDOmAssn(lineNumber, 
                                     buildCDOmExprLink(lineNumber, outputName),
                                     buildCDOmExprOp(lineNumber,
                                                     CDOmExprOp::OP_TERNARY_COND,
                                                     selects->at(0),
                                                     inputs->at(0),
                                                     inputs->at(1)
                                                     )
                                     );
    RefCDOmContAssn contAssn = buildCDOmContAssn(lineNumber, m_cdomCurrParent);
    contAssn->addNetAssn(assn);

  }
  else {
    ASSERT(selects.get() && selects->size() == nrOfSelectBits, "adaptMultiplexor: input parameters are not consistent");
    ASSERT(inputs.get() && inputs->size() == static_cast<int>(pow(2,static_cast<double>(nrOfSelectBits))), "adaptMultiplexor: input parameters are not consistent");
    //case statement
    //TInt i = 0;
    //RefCDOmStmtCase stmtCase;
    //for(NSCSLOm::TVec_RefCDOmExpr_const_iter it = inputs->begin(); it < inputs->end(); ++it) {
    //  if(!stmtCase.get()) {
    //    RefCDOmListExpr list = buildCDOmListExpr(lineNumber, buildCDOmNum32WithValue(lineNumber, i++));
    //    RefCDOmStmtAssn stmt = buildCDOmStmtAssnSimple( lineNumber, 
    //                                                    CDOmStmtAssn::ASSN_BLOCKING,  
    //                                                    buildCDOmExprLink(lineNumber, outputName),
    //                                                    *it
    //                                                    );
    //    stmtCase = buildCDOmStmtCase( lineNumber, 
    //                                  CDOmStmtCase::CASE_CASE, 
    //                                  buildCDOmExprLink(lineNumber, selectName),
    //                                  list,
    //                                  stmt
    //                                  );
    //  }
    //  else {
    //    stmtCase->addCaseItem( buildCDOmListExpr(lineNumber, buildCDOmNum32WithValue(lineNumber, i++)),
    //                           buildCDOmStmtAssnSimple( lineNumber, 
    //                                                    CDOmStmtAssn::ASSN_BLOCKING,
    //                                                    buildCDOmExprLink(lineNumber, outputName),
    //                                                    *it
    //                                                    )
    //                           );
    //  }
    //}
    //    
    //RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    //stmtBlock->addStmt(stmtCase);
    //    
    //RefCDOmEventControl evCtrl = buildCDOmEventControlWithHid(lineNumber, buildCDOmExprLink(lineNumber, selectName));
    //RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock );
    //RefCDOmInitOrAlways always = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc);
  }
}

void CAdapterToCDOM::adaptAssign(TInt lineNumber, RefCDOmExpr left, RefCDOmExpr right) {
  RefCDOmAssn assn = buildCDOmAssn(lineNumber, left, right);
  RefCDOmContAssn contAssn = buildCDOmContAssn(lineNumber, m_cdomCurrParent);
  contAssn->addNetAssn(assn);
}

void CAdapterToCDOM::adaptMemoryMapForUnitRegisters(const NSCSLOm::RefCSLOmUnitDecl unitDecl, RefString memMapModuleName) {
  ASSERT(m_cdomCurrParent.get(), "adaptUnitRegistersEnableLogicModule(): the cdom current parent is null");
  ASSERT(m_cdomCurrParent->getType() == TYPE_DECL_MODULE, "adaptUnitRegistersEnableLogicModule(): the cdom current parent is not a module");
  
  //port names
  RefString busEnName = RefString(new string("bus_en"));
  RefString busAddrName = RefString(new string("bus_addr"));
  RefString unitAddrName = RefString(new string("unit_addr"));
  RefString resetName = RefString(new string("internal_reg_access_reset"));
  RefString clockName = RefString(new string("internal_reg_access_clock"));

  //internal signal names
  RefString unitEnName = RefString(new string("unit_en"));
  RefString decEnName = RefString(new string("dec_en"));
  RefString decOutputName = RefString(new string("reg_select"));

  //ports
  RefCDOmPortItem busEnPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, busEnName);
  RefCDOmPortDecl busEn = buildCDOmPortDeclNet( unitDecl->getLineNumber(), 
                                                m_cdomCurrParent,
                                                PORT_INPUT,
                                                NET_WIRE,
                                                buildCDOmRange( unitDecl->getLineNumber(),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                              ),                                              
                                                busEnName
                                              );
  
  RefCDOmPortItem busAddrPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, busAddrName);
  RefCDOmPortDecl busAddr = buildCDOmPortDeclNet( unitDecl->getLineNumber(), 
                                                  m_cdomCurrParent,
                                                  PORT_INPUT,
                                                  NET_WIRE,
                                                  buildCDOmRange( unitDecl->getLineNumber(),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                              ),                                              
                                                  busAddrName
                                                );
  RefCDOmPortItem unitAddrPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, unitAddrName);
  RefCDOmPortDecl unitAddr = buildCDOmPortDeclNet( unitDecl->getLineNumber(), 
                                                   m_cdomCurrParent,
                                                   PORT_INPUT,
                                                   NET_WIRE,
                                                   buildCDOmRange( unitDecl->getLineNumber(),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                 ),                                              
                                                   unitAddrName
                                                );
  RefCDOmPortItem clockPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, clockName);
  RefCDOmPortDecl clock = buildCDOmPortDeclNet( unitDecl->getLineNumber(), 
                                                   m_cdomCurrParent,
                                                   PORT_INPUT,
                                                   NET_WIRE,
                                                   buildCDOmRange( unitDecl->getLineNumber(),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                 ),                                              
                                                   clockName
                                                );
  RefCDOmPortItem resetPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, resetName);
  RefCDOmPortDecl reset = buildCDOmPortDeclNet( unitDecl->getLineNumber(), 
                                                   m_cdomCurrParent,
                                                   PORT_INPUT,
                                                   NET_WIRE,
                                                   buildCDOmRange( unitDecl->getLineNumber(),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                 ),                                              
                                                   resetName
                                                );

  //internal signals
  RefCDOmNetDecl unitEn = buildCDOmNetDecl( unitDecl->getLineNumber(),
                                            m_cdomCurrParent,
                                            NET_WIRE,
                                            buildCDOmRange( unitDecl->getLineNumber(),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                          )
                                          );
  unitEn->addNet(unitDecl->getLineNumber(), unitEnName);
  
  RefCDOmNetDecl decEn = buildCDOmNetDecl(  unitDecl->getLineNumber(),
                                            m_cdomCurrParent,
                                            NET_WIRE,
                                            buildCDOmRange( unitDecl->getLineNumber(),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                          )
                                          );
  decEn->addNet(unitDecl->getLineNumber(), decEnName);

  RefCDOmNetDecl decOutput = buildCDOmNetDecl(  unitDecl->getLineNumber(),
                                                m_cdomCurrParent,
                                                NET_WIRE,
                                                buildCDOmRange( unitDecl->getLineNumber(),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                              )
                                            );
  decOutput->addNet(unitDecl->getLineNumber(), decOutputName);

  //memory map module instance
  RefCDOmExprLink memExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), memMapModuleName);
  RefCDOmModuleOrUdpInstantiation memInstantiation = buildCDOmModuleOrUdpInstantiation(unitDecl->getLineNumber(), m_cdomCurrParent, memExprLink) ;
  RefString memMapInstanceName = RefString(new string(*memMapModuleName));
  memMapInstanceName->append("_instance");
  RefCDOmModuleOrUdpInstance memInstance = memInstantiation->buildModuleInstance(unitDecl->getLineNumber(), memMapInstanceName);

  //connect instance to unit ports
  RefCDOmExprLink clockExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), clockName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), clockExprLink, clockName);

  RefCDOmExprLink resetExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), resetName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), resetExprLink, resetName);

  RefCDOmExprLink busEnExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), busEnName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), busEnExprLink, busEnName);
  
  RefCDOmExprLink busAddrExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), busAddrName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), busAddrExprLink, busAddrName);
  
  RefCDOmExprLink unitAddrExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), unitAddrName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), unitAddrExprLink, unitAddrName);

  //connect instance to unit signals
  RefCDOmExprLink unitEnExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), unitEnName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), unitEnExprLink, unitEnName);

  RefCDOmExprLink decEnExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), decEnName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), decEnExprLink, decEnName);

  RefCDOmExprLink decOutputExprLink = buildCDOmExprLink(unitDecl->getLineNumber(), decOutputName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), decOutputExprLink, decOutputName);


}

void CAdapterToCDOM::adaptUnitRegistersEnableLogicModule (const NSCSLOm::RefCSLOmUnitDecl unitDecl, RefString memMapModuleName) {
  //DCERR ("inside adaptUnitRegistersEnableLogicModule" << endl);
  ASSERT(m_cdomCurrParent.get(), "adaptUnitRegistersEnableLogicModule(): the cdom current parent is null");
  ASSERT(m_cdomCurrParent->getType() == TYPE_DECL_MODULE, "adaptUnitRegistersEnableLogicModule(): the cdom current parent is not a module");

  //port names
  RefString busEnName = RefString(new string("bus_en"));
  RefString busAddrName = RefString(new string("bus_addr"));
  RefString unitAddrName = RefString(new string("unit_addr"));
  RefString resetName = RefString(new string("internal_reg_access_reset"));
  RefString clockName = RefString(new string("internal_reg_access_clock"));
  RefString unitEnName = RefString(new string("unit_en"));
  RefString decEnName = RefString(new string("dec_en"));
  RefString decOutputName = RefString(new string("reg_select"));
 
  //ports
  RefCDOmPortItem busEnPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, busEnName);
  RefCDOmPortDecl busEn = buildCDOmPortDeclNet( unitDecl->getLineNumber(), 
                                                m_cdomCurrParent,
                                                PORT_INPUT,
                                                NET_WIRE,
                                                buildCDOmRange( unitDecl->getLineNumber(),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                              ),                                              
                                                busEnName
                                              );
  
  RefCDOmPortItem busAddrPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, busAddrName);
  RefCDOmPortDecl busAddr = buildCDOmPortDeclNet( unitDecl->getLineNumber(), 
                                                  m_cdomCurrParent,
                                                  PORT_INPUT,
                                                  NET_WIRE,
                                                  buildCDOmRange( unitDecl->getLineNumber(),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                              ),                                              
                                                  busAddrName
                                                );
  RefCDOmPortItem unitAddrPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, unitAddrName);
  RefCDOmPortDecl unitAddr = buildCDOmPortDeclNet( unitDecl->getLineNumber(), 
                                                   m_cdomCurrParent,
                                                   PORT_INPUT,
                                                   NET_WIRE,
                                                   buildCDOmRange( unitDecl->getLineNumber(),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                 ),                                              
                                                   unitAddrName
                                                );

  RefCDOmPortItem unitEnPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, unitEnName);
  RefCDOmPortDecl unitEn = buildCDOmPortDeclNet( unitDecl->getLineNumber(),
                                                 m_cdomCurrParent,
                                                 PORT_INPUT,
                                                 NET_WIRE,
                                                 buildCDOmRange( unitDecl->getLineNumber(),
                                                                 buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                 buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                               ),
                                                 unitEnName
                                          );
  
  RefCDOmPortItem decEnPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, decEnName);
  RefCDOmPortDecl decEn = buildCDOmPortDeclNet(  unitDecl->getLineNumber(),
                                            m_cdomCurrParent,
                                            PORT_INPUT,
                                            NET_WIRE,
                                            buildCDOmRange( unitDecl->getLineNumber(),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                          ),
                                            decEnName
                                          );

  RefCDOmPortItem decOutputPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, decOutputName);
  RefCDOmPortDecl decOutput = buildCDOmPortDeclNet(  unitDecl->getLineNumber(),
                                                m_cdomCurrParent,
                                                PORT_OUTPUT,
                                                NET_WIRE,
                                                buildCDOmRange( unitDecl->getLineNumber(),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                              ),
                                                decOutputName
                                            );

  RefCDOmPortItem clockPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, clockName);
  RefCDOmPortDecl clock = buildCDOmPortDeclNet( unitDecl->getLineNumber(),
                                            m_cdomCurrParent,
                                            PORT_INPUT,
                                            NET_WIRE,
                                            buildCDOmRange( unitDecl->getLineNumber(),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                          ),
                                            clockName
                                          );
  
  RefCDOmPortItem resetPortItem = 
    (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(unitDecl->getLineNumber(), CDOmPortItem::PORT_ITEM_SIMPLE, resetName);
  RefCDOmPortDecl reset = buildCDOmPortDeclNet( unitDecl->getLineNumber(),
                                            m_cdomCurrParent,
                                            PORT_INPUT,
                                            NET_WIRE,
                                            buildCDOmRange( unitDecl->getLineNumber(),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                          ),
                                            resetName
                                          );
  
  adaptCompare(unitDecl->getLineNumber(), busAddrName, unitAddrName, unitEnName, clockName, resetName );
  adaptAndGate(unitDecl->getLineNumber(), busEnName, unitEnName, decEnName, clockName, resetName);
  generateDecoderFromVerilogSignal(unitDecl->getLineNumber(), busAddrName, decOutputName, clockName, resetName, decEnName);
}

void CAdapterToCDOM::generateDecoderFromVerilogSignal( TLineNumberType lineNumber,
                                                       RefString decInputName, 
                                                       RefString decOutputName, 
                                                       RefString clockName,
                                                       RefString resetName,
                                                       RefString decEnName
                                                     ) {
  RefCDOmStmtAssn ifAssnStmt = buildCDOmStmtAssnSimple( lineNumber,
                                                        CDOmStmtAssn::ASSN_BLOCKING,
                                                        buildCDOmExprLink(lineNumber, decOutputName),
                                                        buildCDOmExprOp ( lineNumber,
                                                                          CDOmExprOp::OP_BINARY_SHIFT_LEFT,
                                                                          buildCDOmNum32WithValue(lineNumber, 1),
                                                                          buildCDOmExprLink(lineNumber, decInputName)
                                                                        )
                                                      );
  RefCDOmStmtAssn elseAssnStmt = buildCDOmStmtAssnSimple( lineNumber,
                                                          CDOmStmtAssn::ASSN_BLOCKING,
                                                          buildCDOmExprLink(lineNumber, decOutputName),
                                                          buildCDOmNum32WithValue(lineNumber, 0)
                                                        );
  
  RefCDOmStmtBlock ifBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  ifBlock->addStmt(ifAssnStmt);
  
  RefCDOmStmtBlock elseBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  elseBlock->addStmt(elseAssnStmt);
  
  RefCDOmStmtIf ifStmt = buildCDOmStmtIf( lineNumber, 
                                          buildCDOmExprLink(lineNumber, decEnName),
                                          ifBlock,
                                          elseBlock
                                        );
  
  RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  stmtBlock->addStmt(ifStmt);

  RefCDOmEventExpr evExpr = buildCDOmEventExprDouble( lineNumber, 
                                                      CDOmEventExpr::EVENT_EXPR_OR, 
                                                      buildCDOmEventExprSimple( lineNumber, 
                                                                                CDOmEventExpr::EVENT_EXPR_POSEDGE, 
                                                                                buildCDOmExprLink(lineNumber, clockName)
                                                                              ),
                                                      buildCDOmEventExprSimple( lineNumber,
                                                                                CDOmEventExpr::EVENT_EXPR_NEGEDGE,
                                                                                buildCDOmExprLink(lineNumber, resetName)
                                                                              )
                                                    ); 
  RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);
  RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock);
  RefCDOmInitOrAlways always = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc);

}

void CAdapterToCDOM::adaptVectorModule (RefCSLOmUnitDecl unitDecl) {
  
  //section 1 : get general vector info for later use

  
    TInt lineNumber = unitDecl->getLineNumber();

  //get the dut the vector is connected to
  RefCSLOmVectorInfo vInfo = CSLOmVectorInfo::cast(unitDecl->getUnitInfo());
  RefCSLOmExprLink vectLink = vInfo->getModuleName();
  ASSERT(vectLink.get(), "adaptVectorModule: vector has no dut associated");
  RefCSLOmUnitDecl dut = CSLOmUnitDecl::cast(vectLink->getLocalNameID()->getParent());

  //insert the dut and its associated stim and expect vectors in two maps
  map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator it;
  if(vInfo->getDirection() == INPUT) {
    if(!m_tbDutNamesStimVects.empty() && (it = m_tbDutNamesStimVects.find(dut->getName())) != m_tbDutNamesStimVects.end()) {//the unit already has stim vectors
      RefTVec_RefCSLOmUnitDecl stimVectors = it->second;
      stimVectors->push_back(unitDecl);
      //DCERR("I shouldn't be here!" << endl);
    }
    else {
      RefTVec_RefCSLOmUnitDecl stimVectors = RefTVec_RefCSLOmUnitDecl(new TVec_RefCSLOmUnitDecl());
      stimVectors->push_back(unitDecl);
      //DCERR("Added vector " << *(unitDecl->getName()) << "to dut " << *(dut->getName()) << endl);
      m_tbDutNamesStimVects.insert(pair<RefString, RefTVec_RefCSLOmUnitDecl>(dut->getName(),stimVectors));
    }
    //m_tbDutNamesStimVects.insert(pair<RefString, RefCSLOmUnitDecl>(dut->getName(), unitDecl));
  }
  else {
    if(!m_tbDutNamesExpectVects.empty() && (it = m_tbDutNamesExpectVects.find(dut->getName())) != m_tbDutNamesExpectVects.end()) {//the unit already has stim vectors
      RefTVec_RefCSLOmUnitDecl expectVectors = it->second;
      expectVectors->push_back(unitDecl);
      //DCERR("I shouldn't be here!" << endl);
    }
    else {
      RefTVec_RefCSLOmUnitDecl expectVectors = RefTVec_RefCSLOmUnitDecl(new TVec_RefCSLOmUnitDecl());
      expectVectors->push_back(unitDecl);
      //DCERR("Added vector " << *(unitDecl->getName()) << "to dut " << *(dut->getName()) << endl);
      m_tbDutNamesExpectVects.insert(pair<RefString, RefTVec_RefCSLOmUnitDecl>(dut->getName(),expectVectors));
    }
    //m_tbDutNamesExpectVects.insert(pair<RefString, RefCSLOmUnitDecl>(dut->getName(), unitDecl));
  }
 
  //section 2 : build stim/expect mem module ports
 
    if(!m_tbVectorDone) {

    m_tbVectClockName = RefString(new string("clock"));
    RefCDOmPortItem clockItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, m_tbVectClockName);
    RefCDOmPortDecl clock = buildCDOmPortDeclNet(lineNumber, 
                                                 m_cdomCurrParent, 
                                                 PORT_INPUT, 
                                                 NET_WIRE, 
                                                 buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0)),
                                                 m_tbVectClockName
                                                 );
    
    m_tbVectResetName = RefString(new string("reset_"));
    RefCDOmPortItem resetItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, m_tbVectResetName);
    RefCDOmPortDecl reset = buildCDOmPortDeclNet(lineNumber, 
                                                 m_cdomCurrParent, 
                                                 PORT_INPUT, 
                                                 NET_WIRE, 
                                                 buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0)),
                                                 m_tbVectResetName
                                                 );
    
    m_tbVectRdEnName = RefString(new string("rd_en"));
    RefCDOmPortItem rdEnItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, m_tbVectRdEnName);
    RefCDOmPortDecl rdEn = buildCDOmPortDeclNet(lineNumber, 
                                                m_cdomCurrParent, 
                                                PORT_INPUT, 
                                                NET_WIRE, 
                                                buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0)),
                                                m_tbVectRdEnName
                                                );
    
    m_tbVectOutputName = RefString(new string("vector_out"));
    RefCDOmPortItem dataOutItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, m_tbVectOutputName);
    RefCDOmPortDecl dataOut = buildCDOmPortDeclNet(lineNumber, 
                                                   m_cdomCurrParent, 
                                                   PORT_OUTPUT,
                                                   NET_WIRE,
                                                   //VAR_REG, 
                                                   buildCDOmRange(lineNumber, 
                                                                  buildCDOmExprOp(lineNumber,
                                                                                  CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                                  buildCDOmExprLink(lineNumber, RefString(new string("MEM_WIDTH"))), 
                                                                                  buildCDOmNum32WithValue(lineNumber, 1)
                                                                                  ),
                                                                  buildCDOmNum32WithValue(lineNumber, 0)
                                                                  ),
                                                   m_tbVectOutputName
                                                 );

    m_tbVectValidName = RefString(new string("valid"));
    RefCDOmPortItem validItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, m_tbVectValidName);
    RefCDOmPortDecl valid = buildCDOmPortDeclNet(lineNumber, 
                                                 m_cdomCurrParent, 
                                                 PORT_OUTPUT, 
                                                 NET_WIRE, 
                                                 buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0)),
                                                 m_tbVectValidName
                                                 );

    m_tbVectVerErrName = RefString(new string("version_err"));
    RefCDOmPortItem versionErrItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, m_tbVectVerErrName);
    RefCDOmPortDecl versionError = buildCDOmPortDeclNet(lineNumber,
                                                        m_cdomCurrParent,
                                                        PORT_OUTPUT,
                                                        NET_WIRE,
                                                        buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0)),
                                                        m_tbVectVerErrName
                                                        );

    m_tbVectIdErrName = RefString(new string("id_err"));
    RefCDOmPortItem idErrItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, m_tbVectIdErrName);
    RefCDOmPortDecl idError = buildCDOmPortDeclNet(lineNumber,
                                                   m_cdomCurrParent,
                                                   PORT_OUTPUT,
                                                   NET_WIRE,
                                                   buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0)),
                                                   m_tbVectIdErrName
                                                   );


    //section 3 : build stim/expect mem module internal signals

    RefString memOutName = RefString(new string("memory_out"));
    RefCDOmVarDecl memOut = buildCDOmVarDecl(lineNumber,
                                             m_cdomCurrParent,
                                             VAR_REG,
                                             buildCDOmRange(lineNumber,
                                                            buildCDOmExprOp(lineNumber,
                                                                            CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                            buildCDOmExprLink(lineNumber, RefString(new string("MEM_WIDTH"))),
                                                                            buildCDOmNum32WithValue(lineNumber, 1)
                                                                            ),
                                                            buildCDOmNum32WithValue(lineNumber, 0)
                                                            ),
                                             memOutName
                                             );

    RefString memName = RefString(new string("stim_expect_memory"));
    RefCDOmVarDecl mem = buildCDOmVarDecl(lineNumber, 
                                          m_cdomCurrParent,
                                          VAR_REG,
                                          buildCDOmRange(lineNumber, 
                                                         buildCDOmExprOp(lineNumber, 
                                                                         CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                         buildCDOmExprLink(lineNumber, RefString(new string("MEM_WIDTH"))),
                                                                         buildCDOmNum32WithValue(lineNumber, 1)
                                                                         ),
                                                         buildCDOmNum32WithValue(lineNumber, 0)
                                                         ),
                                          memName,
                                          buildCDOmRangeList(lineNumber,
                                                             buildCDOmRange(lineNumber,
                                                                            buildCDOmNum32WithValue(lineNumber, 0),
//                                                                             buildCDOmExprOp(lineNumber,
//                                                                                             CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                            buildCDOmExprLink(lineNumber, RefString(new string("MEM_DEPTH")))                
//                                                                                             buildCDOmNum32WithValue(lineNumber, 1)
//                                                                                             )
                                                                            )
                                                             )
                                          );

    RefString rdAddrName = RefString(new string("rd_addr"));
    RefCDOmVarDecl rdAddr = buildCDOmVarDecl(lineNumber, 
                                             m_cdomCurrParent,  
                                             VAR_REG, 
                                             buildCDOmRange(lineNumber, 
                                                            buildCDOmExprOp(unitDecl->getLineNumber(),
                                                                            CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                            buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("ADDR_WIDTH"))),
                                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
                                                                            ),
                                                            buildCDOmNum32WithValue(lineNumber, 0)
                                                            ),
                                             rdAddrName
                                             );

    RefString memOutIsIdName = RefString(new string("mem_out_is_id"));
    RefCDOmVarDecl memOutIsId = buildCDOmVarDecl(lineNumber, 
                                                 m_cdomCurrParent,
                                                 VAR_REG,
                                                 buildCDOmRange(lineNumber,
                                                                buildCDOmNum32WithValue(lineNumber, 0),
                                                                buildCDOmNum32WithValue(lineNumber, 0)
                                                                ),
                                                 memOutIsIdName
                                                 );
    //memOutIsId->addNet(lineNumber, memOutIsIdName);

    RefString memOutIsVersionName = RefString(new string("mem_out_is_version"));
    RefCDOmVarDecl memOutIsVersion = buildCDOmVarDecl(lineNumber,
                                                      m_cdomCurrParent,
                                                      VAR_REG,
                                                      buildCDOmRange(lineNumber,
                                                                     buildCDOmNum32WithValue(lineNumber, 0),
                                                                     buildCDOmNum32WithValue(lineNumber, 0)
                                                                     ),
                                                      memOutIsVersionName
                                                      );
    //memOutIsVersion->addNet(lineNumber, memOutIsVersionName);

    RefString memOutIsIdOrVersionName = RefString(new string("mem_out_is_id_or_version"));
    RefCDOmNetDecl memOutIsIdOrVersion = buildCDOmNetDecl(lineNumber,
                                                          m_cdomCurrParent,
                                                          NET_WIRE,
                                                          buildCDOmRange(lineNumber,
                                                                         buildCDOmNum32WithValue(lineNumber, 0),
                                                                         buildCDOmNum32WithValue(lineNumber, 0)
                                                                         )
                                                          );
    memOutIsIdOrVersion->addNet(lineNumber, memOutIsIdOrVersionName);
    
    RefString muxSelectName = RefString(new string("mux_select"));
    RefCDOmNetDecl muxSelect = buildCDOmNetDecl(lineNumber,
                                                m_cdomCurrParent,
                                                NET_WIRE,
                                                buildCDOmRange(lineNumber,
                                                               buildCDOmNum32WithValue(lineNumber, 0),
                                                               buildCDOmNum32WithValue(lineNumber, 0)
                                                               )
                                                );
    muxSelect->addNet(lineNumber, muxSelectName);

    RefString vectorIdMatchName = RefString(new string("vector_id_match"));
    RefCDOmNetDecl vectorIdMatch = buildCDOmNetDecl(lineNumber,
                                                    m_cdomCurrParent,
                                                    NET_WIRE,
                                                    buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0))
                                                    );
    vectorIdMatch->addNet(lineNumber, vectorIdMatchName);

    RefString vectorVersionMatchName = RefString(new string("vector_version_match"));
    RefCDOmNetDecl vectorVersionMatch = buildCDOmNetDecl(lineNumber,
                                                         m_cdomCurrParent,
                                                         NET_WIRE,
                                                         buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0))
                                                         );
    vectorVersionMatch->addNet(lineNumber, vectorVersionMatchName);

//     RefString zeroName = RefString(new string("zero"));
//     RefCDOmNetDecl zero = buildCDOmNetDecl(lineNumber,
//                                            m_cdomCurrParent,
//                                            NET_WIRE,
//                                            buildCDOmRange(lineNumber,
//                                                           buildCDOmExprOp(lineNumber, 
//                                                                           CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
//                                                                           buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
//                                                                           buildCDOmNum32WithValue(lineNumber, 2)
//                                                                           ),
//                                                           buildCDOmNum32WithValue(lineNumber, 0)
//                                                           )
//                                            );
//     zero->addNet(lineNumber, zeroName);

    //section 4 : build stim/expect mem module parameters

    //parameter MEM_WIDTH = number
    RefCDOmParamDecl memWidthParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    memWidthParam->addParam(lineNumber, RefString(new string("MEM_WIDTH")), buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, 0)));

    //parameter ADDR_WIDTH = number
    RefCDOmParamDecl addrWidthParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    addrWidthParam->addParam(lineNumber, RefString(new string("ADDR_WIDTH")), buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, 0)));

    //parameter VECTOR_ID
    RefCDOmParamDecl vectId = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    vectId->addParam(lineNumber, RefString(new string("VECTOR_ID")), buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, 0)));

    //parameter VECTOR_VERSION
    RefCDOmParamDecl vectVer = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    vectVer->addParam(lineNumber, RefString(new string("VECTOR_VERSION")), buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, 0)));

    //parameter VECTOR_NAME
    RefCDOmParamDecl vectName = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    vectName->addParam(lineNumber, RefString(new string("VECTOR_NAME")), buildCDOmMinTypMax(lineNumber, buildCDOmString(lineNumber, RefString(new string("")))));

    //parameter VECTOR_FILE
    RefCDOmParamDecl vectFile = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    vectFile->addParam(lineNumber, RefString(new string("VECTOR_FILE")), buildCDOmMinTypMax(lineNumber, buildCDOmString(lineNumber, RefString(new string("")))));

    //parameter VECTOR_RADIX = number
    RefCDOmParamDecl radixParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    radixParam->addParam(lineNumber, RefString(new string("VECTOR_RADIX")), buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, 0)));

    //parameter MEM_DEPTH = 1 << ADDR_WIDTH
    RefCDOmParamDecl memDepthParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);

    RefCDOmNum32 num0 = buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")));
    num0->setIsVeriNumFlag(FALSE);
    RefCDOmNum32 num = buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")));
    num->setIsVeriNumFlag(TRUE);
    memDepthParam->addParam(lineNumber, 
                            RefString(new string("MEM_DEPTH")), 
                            buildCDOmMinTypMax(lineNumber, 
                                               buildCDOmExprOp(lineNumber,
                                                               CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                               buildCDOmMinTypMax(lineNumber, 
                                                                                  buildCDOmExprOp(lineNumber, 
                                                                                                  CDOmExprOp::OP_BINARY_SHIFT_LEFT, 
                                                                                                  num0,
                                                                                                  buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH")))  
                                                                                                  )
                                                                                  ),
                                                               num
                                                              )
                                               )
                            );

    //section 5 : increment stim/expect mem rdAddr 
    RefTVec_RefCDOmStmtAssn idOrVerAssns = RefTVec_RefCDOmStmtAssn(new TVec_RefCDOmStmtAssn());

    RefCDOmStmtAssn isIdAssn = buildCDOmStmtAssnSimple(lineNumber, 
                                                       CDOmStmtAssn::ASSN_NON_BLOCKING, 
                                                       buildCDOmExprLink(lineNumber, memOutIsIdName),
                                                       buildCDOmExprOp(lineNumber, 
                                                                       CDOmExprOp::OP_BINARY_EQUALITY_EQ,
                                                                       buildCDOmExprLink(lineNumber, rdAddrName),
                                                                       buildCDOmNum32WithValue(lineNumber, 0)
                                                                       )
                                                       );
    idOrVerAssns->push_back(isIdAssn);

    RefCDOmStmtAssn isVerAssn = buildCDOmStmtAssnSimple(lineNumber, 
                                                        CDOmStmtAssn::ASSN_NON_BLOCKING, 
                                                        buildCDOmExprLink(lineNumber, memOutIsVersionName),
                                                        buildCDOmExprOp(lineNumber, 
                                                                        CDOmExprOp::OP_BINARY_EQUALITY_EQ,
                                                                        buildCDOmExprLink(lineNumber, rdAddrName),
                                                                        buildCDOmNum32WithValue(lineNumber, 1)
                                                                        )
                                                        );
    idOrVerAssns->push_back(isVerAssn);

    adaptCounter(lineNumber, m_tbVectClockName, m_tbVectResetName, rdAddrName, m_tbVectRdEnName, RefString(), idOrVerAssns);

    //section 6 : stim/expect mem read logic

    adaptMemory(lineNumber, m_tbVectClockName, m_tbVectResetName, rdAddrName, m_tbVectRdEnName, memOutName, memName);
    
    //section 7 : init the flag used to exclude the vector id and version from the output-expect comparison

    //adaptAssign(lineNumber,
    //            buildCDOmExprLink(lineNumber, memOutIsIdName),
    //            buildCDOmExprOp(lineNumber,
    //                            CDOmExprOp::OP_BINARY_EQUALITY_EQ,
    //                            buildCDOmExprLink(lineNumber, rdAddrName),
    //                            buildCDOmNum32WithValue(lineNumber, 0)
    //                            )
    //            );
    //adaptAssign(lineNumber,
    //            buildCDOmExprLink(lineNumber, memOutIsVersionName),
    //            buildCDOmExprOp(lineNumber,
    //                            CDOmExprOp::OP_BINARY_EQUALITY_EQ,
    //                            buildCDOmExprLink(lineNumber, rdAddrName),
    //                            buildCDOmNum32WithValue(lineNumber, 1)
    //                            )
    //            );
    adaptAssign(lineNumber,
                buildCDOmExprLink(lineNumber, memOutIsIdOrVersionName),
                buildCDOmExprOp(lineNumber,
                                CDOmExprOp::OP_BINARY_LOGIC_OR,
                                buildCDOmExprLink(lineNumber, memOutIsIdName),
                                buildCDOmExprLink(lineNumber, memOutIsVersionName)
                                )
                );

    //section 8 : mux logic - ignore the vector id and version in the output-expect comparison

    //mux select
    adaptAssign(lineNumber,
                buildCDOmExprLink(lineNumber, muxSelectName),
		/* buildCDOmExprOp(lineNumber,
                                CDOmExprOp::OP_BINARY_LOGIC_OR,
				 buildCDOmExprOp(lineNumber,
                                                CDOmExprOp::OP_UNARY_BITWISE_NOT,
                                                buildCDOmExprLink(lineNumber, m_tbVectRdEnName)
                                                ),
                                buildCDOmExprLink(lineNumber,CDOmExprOp::OP_UNARY_BITWISE_NOT, memOutIsIdOrVersionName)
                                )*/

  

   buildCDOmExprOp(lineNumber,
                                CDOmExprOp::OP_BINARY_LOGIC_OR,
				 buildCDOmExprOp(lineNumber,
                                                CDOmExprOp::OP_UNARY_BITWISE_NOT,
                                                buildCDOmExprLink(lineNumber, memOutIsIdOrVersionName)
                                                ),
                                buildCDOmExprLink(lineNumber, m_tbVectRdEnName)
                                )

                );
    //mux logic
    RefTVec_RefCDOmExpr muxInputs = RefTVec_RefCDOmExpr(new TVec_RefCDOmExpr());
    RefCDOmNum32 memWidthAsNumber = buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0")));
    memWidthAsNumber->setIsVeriNumFlag(TRUE);
    RefCDOmExprMultiConcat input1 = buildCDOmExprMultiConcat(lineNumber,
                                                             buildCDOmExprLink(lineNumber, RefString(new string("MEM_WIDTH"))),
                                                             buildCDOmExprConcat(lineNumber, 
                                                                                 //buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0")))
                                                                                 memWidthAsNumber
                                                                                 )
                                                             );
    RefCDOmExprLink input2 = buildCDOmExprLink(lineNumber, memOutName);
    muxInputs->push_back(input2);
    muxInputs->push_back(input1);

    RefTVec_RefCDOmExpr muxSelects = RefTVec_RefCDOmExpr(new TVec_RefCDOmExpr());
    RefCDOmExprLink select = buildCDOmExprLink(lineNumber, muxSelectName);
    muxSelects->push_back(select);

    adaptMultiplexor(lineNumber, 1, m_tbVectOutputName, muxInputs, muxSelects );

    //section 9 : check vector id and version consistancy(the id and ver read from the stim/expect memory(file) should coincide with the id and ver in the user code)

    adaptAssign(lineNumber,
                buildCDOmExprLink(lineNumber, vectorIdMatchName),
                buildCDOmExprOp(lineNumber,
                                CDOmExprOp::OP_BINARY_BITWISE_AND,
                                buildCDOmMinTypMax(lineNumber,
                                                   buildCDOmExprOp(lineNumber,
                                                                   CDOmExprOp::OP_BINARY_EQUALITY_EQ,
                                                                   buildCDOmExprLink(lineNumber, memOutName),
                                                                   buildCDOmExprLink(lineNumber, RefString(new string("VECTOR_ID")))
                                                                   )
                                                   ),
                                buildCDOmExprLink(lineNumber, memOutIsIdName)
                                )
                );

    adaptAssign(lineNumber,
                buildCDOmExprLink(lineNumber, vectorVersionMatchName),
                buildCDOmExprOp(lineNumber,
                                CDOmExprOp::OP_BINARY_BITWISE_AND,
                                buildCDOmMinTypMax(lineNumber,
                                                   buildCDOmExprOp(lineNumber,
                                                                   CDOmExprOp::OP_BINARY_EQUALITY_EQ,
                                                                   buildCDOmExprLink(lineNumber, memOutName),
                                                                   buildCDOmExprLink(lineNumber, RefString(new string("VECTOR_VERSION")))
                                                                   )
                                                   ),
                                buildCDOmExprLink(lineNumber, memOutIsVersionName)
                                )
                );

    adaptAssign(lineNumber,
                buildCDOmExprLink(lineNumber, m_tbVectVerErrName),
                buildCDOmExprOp(lineNumber,
                                CDOmExprOp::OP_BINARY_BITWISE_AND,
                                buildCDOmExprLink(lineNumber, memOutIsVersionName),
                                buildCDOmExprOp(lineNumber,
                                                CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ,
                                                buildCDOmExprLink(lineNumber, memOutName),
                                                buildCDOmExprLink(lineNumber, RefString(new string("VECTOR_VERSION")))
                                                )
                                )
                );

    adaptAssign(lineNumber,
                buildCDOmExprLink(lineNumber, m_tbVectIdErrName),
                buildCDOmExprOp(lineNumber,
                                CDOmExprOp::OP_BINARY_BITWISE_AND,
                                buildCDOmExprLink(lineNumber, memOutIsIdName),
                                buildCDOmExprOp(lineNumber,
                                                CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ,
                                                buildCDOmExprLink(lineNumber, memOutName),
                                                buildCDOmExprLink(lineNumber, RefString(new string("VECTOR_ID")))
                                                )
                                )
                );

    //section 10 : valid = rd_en && ~mem_out_is_id_or_version

    adaptAssign(lineNumber,
                buildCDOmExprLink(lineNumber, m_tbVectValidName),
                buildCDOmExprOp(lineNumber,
                                CDOmExprOp::OP_BINARY_LOGIC_AND,
                                buildCDOmExprLink(lineNumber, m_tbVectRdEnName),
                                buildCDOmExprOp(lineNumber,
                                                CDOmExprOp::OP_UNARY_BITWISE_NOT,
                                                buildCDOmExprLink(lineNumber, memOutIsIdOrVersionName)
                                                )
                                )
                );

    //section 11 : display initial contents of memory
    RefString memAddrIterName = RefString(new string("mem_addr"));
    RefCDOmVarDecl memAddrIter = buildCDOmVarDecl(unitDecl->getLineNumber(),
                                                  m_cdomCurrParent,
                                                  VAR_INTEGER,
                                                  RefCDOmRange(),
                                                  memAddrIterName);
     
    RefString fileParamName = RefString(new string("VECTOR_FILE"));
    RefString memDepthName = RefString(new string("MEM_DEPTH"));

    RefString memLoadedName = RefString(new string("stim_expect_memory_loaded"));
    RefCDOmVarDecl memLoaded = buildCDOmVarDecl(unitDecl->getLineNumber(),
                                                m_cdomCurrParent,
                                                VAR_REG,
                                                buildCDOmRange(unitDecl->getLineNumber(),
                                                               buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                               buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                               ),
                                                memLoadedName
                                                );
       
    generateInitialVectorMemDisplay(unitDecl->getLineNumber(), memLoadedName, memName, fileParamName, memDepthName, memAddrIterName);   
} 
}

void CAdapterToCDOM::adaptTestbenchModule (RefCSLOmUnitDecl unitDecl) {
 
  //section 1 : extract testbench info for later use
  RefCSLOmTBInfo tbInfo = CSLOmTBInfo::cast(unitDecl->getUnitInfo());
  RefCSLOmSignal clockSignal = tbInfo->getClockSignal();
  //ASSERT(clockSignal.get(), "adaptTestbenchModule::testbench does not have a clock port");
  if(!clockSignal.get()) {
    args.push_back(*(unitDecl->getName()));
    addErr(NSWarningErr::DEE_CCT_MOD_NO_TB_CLOCK, args, unitDecl->getLineNumber());
    adapterHasErrors = TRUE;
    return;
  }
  RefString clockName = clockSignal->getName();
  RefCSLOmNum32 clockPeriod = CSLOmNum32::cast(tbInfo->getClockPeriod());
  //CSLOmTBInfo::ETBTimeBase clockTimeBase = tbInfo->getClockTimeBase();
  RefString outputFileName = tbInfo->getWaveFilename();
  CSLOmTBInfo::ETBWaveType waveType = tbInfo->getWaveType();        

  //section 2 : build tb internal signals 

  //build testbench reset signal(temporary default, should be added to the tb in the csl code, just like the clock signal)
  RefString resetName = RefString(new string("testbench_reset"));
  RefCDOmVarDecl reset = buildCDOmVarDecl(unitDecl->getLineNumber(), 
                                          m_cdomCurrParent, 
                                          VAR_REG,
                                          buildCDOmRange(unitDecl->getLineNumber(), 
                                                         buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                         buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                         ),
                                          resetName
                                          ); 

  RefString randValidName = RefString(new string("rand_valid"));
  RefCDOmVarDecl randValid = buildCDOmVarDecl(unitDecl->getLineNumber(), 
                                              m_cdomCurrParent, 
                                              VAR_REG,
                                              buildCDOmRange(unitDecl->getLineNumber(), 
                                                             buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                             buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                             ),
                                              randValidName
                                              ); 

  //build valid port to connect to expect vector
  RefString validName = RefString(new string("expect_out_valid"));
  RefCDOmNetDecl valid = buildCDOmNetDecl(unitDecl->getLineNumber(),
                                          m_cdomCurrParent,
                                          NET_WIRE,
                                          buildCDOmRange(unitDecl->getLineNumber(), 
                                                         buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                         buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                         )
                                          );
  valid->addNet(unitDecl->getLineNumber(), validName);

  //build rdEn port to connect to vectors
  RefString rdEnName = RefString(new string("rd_en"));
  RefCDOmNetDecl rdEn = buildCDOmNetDecl(unitDecl->getLineNumber(),
                                         m_cdomCurrParent,
                                         NET_WIRE,
                                         buildCDOmRange(unitDecl->getLineNumber(), 
                                                        buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                        buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                        )
                                         );
  rdEn->addNet(unitDecl->getLineNumber(), rdEnName);

  //build verErr port to connect to vectors
  RefString verErrName = RefString(new string("version_err"));
  RefCDOmNetDecl verErr = buildCDOmNetDecl(unitDecl->getLineNumber(),
                                           m_cdomCurrParent,
                                           NET_WIRE,
                                           buildCDOmRange(unitDecl->getLineNumber(), 
                                                          buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                          buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                          )
                                           );
  verErr->addNet(unitDecl->getLineNumber(), verErrName);

  //build idErr port to connect to vectors
  RefString idErrName = RefString(new string("id_err"));
  RefCDOmNetDecl idErr = buildCDOmNetDecl(unitDecl->getLineNumber(),
                                          m_cdomCurrParent,
                                          NET_WIRE,
                                          buildCDOmRange(unitDecl->getLineNumber(), 
                                                         buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
                                                         buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                         )
                                          );
  idErr->addNet(unitDecl->getLineNumber(), idErrName);

  adaptAssign(unitDecl->getLineNumber(),
              buildCDOmExprLink(unitDecl->getLineNumber(), rdEnName),
              buildCDOmExprLink(unitDecl->getLineNumber(), randValidName)
              );

  //build fileMcd port
  RefString fileMcdName = RefString(new string("file_mcd"));
  RefCDOmVarDecl fileMcd = buildCDOmVarDecl(unitDecl->getLineNumber(),
                                            m_cdomCurrParent,
                                            VAR_INTEGER,
                                            RefCDOmRange(),
                                            fileMcdName
                                            );

  //build reportFileMcd port
  RefString reportFileMcdName = RefString(new string("report_file_mcd"));
  RefCDOmVarDecl reportFileMcd = buildCDOmVarDecl(unitDecl->getLineNumber(), 
                                                  m_cdomCurrParent,
                                                  VAR_INTEGER,
                                                  RefCDOmRange(),
                                                  reportFileMcdName
                                                  );

  RefString cycleCntName = RefString(new string("cycle_cnt"));
  RefCDOmVarDecl cycleCnt = buildCDOmVarDecl(unitDecl->getLineNumber(),
                                             m_cdomCurrParent,
                                             VAR_INTEGER,
                                             RefCDOmRange(),
                                             cycleCntName
                                             );

  RefString simTimeoutName = RefString(new string("SIM_TIMEOUT_CNT"));
  RefString simStopName = RefString(new string("stop_sim"));
  RefCDOmNetDecl simStop = buildCDOmNetDecl(unitDecl->getLineNumber(),
                                            m_cdomCurrParent,
                                            NET_WIRE,
                                            RefCDOmRange()
                                            );
  RefCDOmExpr simStopExpr = buildCDOmExprOp(unitDecl->getLineNumber(),
                                            CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL,
                                            buildCDOmExprLink(unitDecl->getLineNumber(), cycleCntName),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), simTimeoutName)
                                            );
  simStop->addNet(unitDecl->getLineNumber(), 
                  simStopName,
                  simStopExpr
                  );

  //section 2bis: always block to increment  cycle_count
  RefCDOmStmtBlock ccStmtBlk = buildCDOmStmtBlock(unitDecl->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);

  RefCDOmStmtBlock ccIfStmtBlk = buildCDOmStmtBlock(unitDecl->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);
  RefCDOmStmtAssn ccInit = buildCDOmStmtAssnSimple(unitDecl->getLineNumber(), 
                                                   CDOmStmtAssn::ASSN_NON_BLOCKING, 
                                                   buildCDOmExprLink(unitDecl->getLineNumber(), cycleCntName),
                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                   );
  ccIfStmtBlk->addStmt(ccInit);

  RefCDOmStmtBlock ccElseStmtBlk = buildCDOmStmtBlock(unitDecl->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);
  RefCDOmStmtAssn ccIncr = buildCDOmStmtAssnSimple(unitDecl->getLineNumber(),
                                                   CDOmStmtAssn::ASSN_NON_BLOCKING,
                                                   buildCDOmExprLink(unitDecl->getLineNumber(), cycleCntName),
                                                   buildCDOmExprOp(unitDecl->getLineNumber(), 
                                                                   CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
                                                                   buildCDOmExprLink(unitDecl->getLineNumber(), cycleCntName),
                                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
                                                                   )
                                                   );
  ccElseStmtBlk->addStmt(ccIncr);

  RefCDOmStmtIf ccIf = buildCDOmStmtIf(unitDecl->getLineNumber(),
                                       buildCDOmExprOp(unitDecl->getLineNumber(), 
                                                       CDOmExprOp::OP_UNARY_BITWISE_NOT,
                                                       buildCDOmExprLink(unitDecl->getLineNumber(), resetName)
                                                       ),
                                       ccIfStmtBlk,
                                       ccElseStmtBlk
                                       );
  ccStmtBlk->addStmt(ccIf);

  RefCDOmStmtProcTimingControl ccptc = 
    buildCDOmStmtProcTimingControlWithEventControl(unitDecl->getLineNumber(),
                                                   buildCDOmEventControlWithEvExpr(unitDecl->getLineNumber(),
                                                                                   buildCDOmEventExprDouble(unitDecl->getLineNumber(),
                                                                                                            CDOmEventExpr::EVENT_EXPR_OR,
                                                                                                            buildCDOmEventExprSimple( unitDecl->getLineNumber(),
                                                                                                                                      CDOmEventExpr::EVENT_EXPR_POSEDGE,
                                                                                                                                      buildCDOmExprLink
                                                                                                                                      (unitDecl->getLineNumber(),
                                                                                                                                       clockName
                                                                                                                                      )
                                                                                                                                    ),
                                                                                                            buildCDOmEventExprSimple( unitDecl->getLineNumber(),
                                                                                                                                      CDOmEventExpr::EVENT_EXPR_NEGEDGE,
                                                                                                                                      buildCDOmExprLink
                                                                                                                                      (unitDecl->getLineNumber(),
                                                                                                                                       resetName
                                                                                                                                       )
                                                                                                                                    )
                                                                                                            )
                                                                                   ),
                                                   ccStmtBlk
                                                   );
  RefCDOmInitOrAlways ccAlwaysBlk = buildCDOmInitOrAlways(unitDecl->getLineNumber(), m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ccptc);

  //section 3 : include date and time in tb module init block

  RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(unitDecl->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);

  RefCDOmStmtTaskEnable dateAndTime = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
                                                              CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                              buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$system")))
                                                              );
  dateAndTime->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("time stamp: +20%y %m %d"))));

  stmtBlock->addStmt(dateAndTime);

  //section 4 : generate piece wise linear waveforms inside tb module init block

  map<TInt, TInt> wavesForTbClock;
  RefTVec_RefCDOmStmt stmtVectForTbClock = generatePieceWiseLinearWaveForms(unitDecl->getLineNumber(), clockName, 0, wavesForTbClock);
  for(TVec_RefCDOmStmt::const_iterator it = stmtVectForTbClock->begin(); it < stmtVectForTbClock->end(); ++it) {
    stmtBlock->addStmt(*it);
  }


  map<TInt, TInt> wavesForTbValid;
  RefTVec_RefCDOmStmt stmtVectForTbValid = generatePieceWiseLinearWaveForms(unitDecl->getLineNumber(), randValidName, 1, wavesForTbValid);
  for(TVec_RefCDOmStmt::const_iterator it = stmtVectForTbValid->begin(); it < stmtVectForTbValid->end(); ++it) {
    stmtBlock->addStmt(*it);
  }

  map<TInt, TInt> wavesForReset;
  wavesForReset.insert(pair<TInt, TInt>(10, 0));
  wavesForReset.insert(pair<TInt, TInt>(20, 1));
  RefTVec_RefCDOmStmt stmtVectForReset = generatePieceWiseLinearWaveForms(unitDecl->getLineNumber(), resetName, 1, wavesForReset);
  for(TVec_RefCDOmStmt::const_iterator it = stmtVectForReset->begin(); it < stmtVectForReset->end(); ++it) {
    stmtBlock->addStmt(*it);
  }

  //section 4bis : open file to write dut output values and expect values into 
  RefString outExpFileName = RefString(new string("vectors.txt"));//read this from somewhere

  RefCDOmFunctionCall openFile = buildCDOmFunctionCall(unitDecl->getLineNumber(), 
                                                       buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$fopen"))),
                                                       buildCDOmListExpr(unitDecl->getLineNumber(), buildCDOmString(unitDecl->getLineNumber(), outExpFileName))
                                                       );
  RefCDOmStmtAssn openFileStmt = buildCDOmStmtAssnSimple(unitDecl->getLineNumber(),
                                                         CDOmStmtAssn::ASSN_BLOCKING,
                                                         buildCDOmExprLink(unitDecl->getLineNumber(), fileMcdName),
                                                         openFile
                                                         );
  stmtBlock->addStmt(openFileStmt);

  RefCDOmStmtBlock fileCheckStmtBlock = buildCDOmStmtBlock(unitDecl->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);

  RefCDOmStmtTaskEnable display = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
                                                          CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                          buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$display")))
                                                          );
  display->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("Error opening vectors.txt file"))));

  fileCheckStmtBlock->addStmt(display);

  RefCDOmStmtTaskEnable finish = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
                                                         CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                         buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$finish")))
                                                         );

  fileCheckStmtBlock->addStmt(finish);

  RefCDOmStmtIf fileCheck = buildCDOmStmtIf(unitDecl->getLineNumber(),
                                            buildCDOmExprOp(unitDecl->getLineNumber(),
                                                            CDOmExprOp::OP_BINARY_EQUALITY_EQ,
                                                            buildCDOmExprLink(unitDecl->getLineNumber(), fileMcdName),
                                                            buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                            ),
                                            fileCheckStmtBlock,
                                            RefCDOmStmt()
                                            );
  stmtBlock->addStmt(fileCheck);

  RefCDOmStmtTaskEnable fdisplay = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(),
                                                           CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                           buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$display")))
                                                           );
  fdisplay->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), fileMcdName));
  fdisplay->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("Dut outputs vs expected vectors:\\n"))));
  stmtBlock->addStmt(fdisplay);

  //section 4bisbis: open report file
  if(tbInfo->getReportType() > CSLOmTBInfo::TB_REPORT_UNDEF && tbInfo->getReportType() < CSLOmTBInfo::TB_REPORT_MAX) {
    RefString reportFileName = RefString(new string("report.txt"));//read this from somewhere

    RefCDOmFunctionCall openReportFile = buildCDOmFunctionCall(unitDecl->getLineNumber(), 
                                                             buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$fopen"))),
                                                             buildCDOmListExpr(unitDecl->getLineNumber(), buildCDOmString(unitDecl->getLineNumber(), reportFileName))
                                                             );
    RefCDOmStmtAssn openReportFileStmt = buildCDOmStmtAssnSimple(unitDecl->getLineNumber(),
                                                         CDOmStmtAssn::ASSN_BLOCKING,
                                                         buildCDOmExprLink(unitDecl->getLineNumber(), reportFileMcdName),
                                                         openReportFile
                                                         );
    stmtBlock->addStmt(openReportFileStmt);
  }

  //section 5 : build testbench parameters(one set for each vector unit in the csl file) for vector module instantiation
  
  TInt simTimeoutVal = 100; //get this from somewhere
  RefCDOmParamDecl simTimeout = buildCDOmParamDecl(unitDecl->getLineNumber(), m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  simTimeout->addParam(unitDecl->getLineNumber(), 
                     simTimeoutName, 
                     buildCDOmMinTypMax(unitDecl->getLineNumber(), buildCDOmNum32WithValue(unitDecl->getLineNumber(), simTimeoutVal))
                     );

  //ASSERT(!m_tbDutNamesStimVects.empty(), "There are no stim vectors in the csl design");
  if(!m_tbDutNamesStimVects.empty()) {
    for(map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator mainIt = m_tbDutNamesStimVects.begin(); mainIt != m_tbDutNamesStimVects.end(); ++mainIt) {
      RefTVec_RefCSLOmUnitDecl cslVectors = mainIt->second;
      for(TVec_RefCSLOmUnitDecl::const_iterator it = cslVectors->begin(); it != cslVectors->end(); ++it) {
        adaptTestbenchParameters(unitDecl->getLineNumber(), *it);
      }
    }
  }

  ASSERT(!m_tbDutNamesExpectVects.empty(), "There are no expect vectors in the csl design");
  for(map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator mainIt = m_tbDutNamesExpectVects.begin(); mainIt != m_tbDutNamesExpectVects.end(); ++mainIt) {
    RefTVec_RefCSLOmUnitDecl cslVectors = mainIt->second;
    for(TVec_RefCSLOmUnitDecl::const_iterator it = cslVectors->begin(); it < cslVectors->end(); ++it) {
      adaptTestbenchParameters(unitDecl->getLineNumber(), *it);
    }
  }

  //section 6 : build vector instances(x stims and y expects for each dut instance in the tb)
  //            and assign testbench params to vector instances params

  for(TVec_RefCDOmModuleOrUdpInstance::const_iterator it = m_cdomDutInstances->begin(); it < m_cdomDutInstances->end(); ++it) {

    //retrieve the instance type
    RefCDOmModuleDecl dut = retrieveModuleFromInstance(*it);
    RefString dutName = (CDOmIdentifier::cast(dut->getChild(0)))->getName();

    //retrieve the unit's vector of stim vectors
    map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator stimIter = m_tbDutNamesStimVects.find(dutName);
    RefTVec_RefCSLOmUnitDecl stimVects;
    if(stimIter != m_tbDutNamesStimVects.end()) {
      stimVects = stimIter->second;
    }

    //retrieve the unit's vector of expect vectors
    map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator expectIter = m_tbDutNamesExpectVects.find(dutName);
    //ASSERT(expectIter != m_tbDutNamesExpectVects.end(), "There is at least one dut in the csl design with no expect vector associated ");
    if(expectIter == m_tbDutNamesExpectVects.end()) {
      args.push_back(*(unitDecl->getName()));
      addErr(NSWarningErr::DEE_CCT_MOD_NO_EXPECT_VECT, args, unitDecl->getLineNumber());
      adapterHasErrors = TRUE;
      return;
    }
    RefTVec_RefCSLOmUnitDecl expectVects = expectIter->second;

    RefTVec_RefCDOmModuleOrUdpInstance associatedStimVectors = RefTVec_RefCDOmModuleOrUdpInstance(new TVec_RefCDOmModuleOrUdpInstance());
    for(TVec_RefCSLOmUnitDecl::const_iterator innerStimIt = stimVects->begin(); innerStimIt < stimVects->end(); ++innerStimIt) {
      RefCDOmModuleOrUdpInstance stimVectInstance = adaptTestbenchParameterConnections(unitDecl->getLineNumber(), *it, *innerStimIt);
      associatedStimVectors->push_back(stimVectInstance);
    }
    m_cdomDutsStimVects.insert(pair<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>(*it, associatedStimVectors));

    RefTVec_RefCDOmModuleOrUdpInstance associatedExpectVectors = RefTVec_RefCDOmModuleOrUdpInstance(new TVec_RefCDOmModuleOrUdpInstance());
    for(TVec_RefCSLOmUnitDecl::const_iterator innerExpectIt = expectVects->begin(); innerExpectIt < expectVects->end(); ++innerExpectIt) {
      RefCDOmModuleOrUdpInstance expectVectInstance = adaptTestbenchParameterConnections(unitDecl->getLineNumber(), *it, *innerExpectIt);
      associatedExpectVectors->push_back(expectVectInstance);
    }
    m_cdomDutsExpectVects.insert(pair<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>(*it, associatedExpectVectors));
  }

  //section 7 : read the files associated with the vector instances into memories and include the logic in the tb module init block
        
  ASSERT(/*!m_cdomDutsStimVects.empty() && */!m_cdomDutsExpectVects.empty(), "Testbench has no vector instances");

  //files associated with stim vector instances
  if(!m_cdomDutsStimVects.empty()) {
    for(map<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>::const_iterator mIt = m_cdomDutsStimVects.begin(); mIt != m_cdomDutsStimVects.end(); ++mIt) {
      
      RefCDOmModuleDecl dut = retrieveModuleFromInstance(mIt->first);

      //retrieve the verilog stim vector instances vector      
      RefTVec_RefCDOmModuleOrUdpInstance assocCdomStims = mIt->second;
      
      //retrieve the csl stim vectors vector
      map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator vIt = m_tbDutNamesStimVects.find((CDOmIdentifier::cast(dut->getChild(0)))->getName());
      ASSERT(vIt != m_tbDutNamesStimVects.end(), "Adapter internal bug: verilog dut instance has stim vectors associated while the original csl instance has none");
      RefTVec_RefCSLOmUnitDecl assocCslStims = vIt->second;

//       //read the files into memories
//       TVec_RefCSLOmUnitDecl::const_iterator vIt1;
//       TVec_RefCDOmModuleOrUdpInstance::const_iterator vIt2;
//       for(vIt1 = assocCslStims->begin(), vIt2 = assocCdomStims->begin();
//           vIt1 < assocCslStims->end() && vIt2 < assocCdomStims->end()  ;
//           ++vIt1                       , ++vIt2                        ) {
     
//         RefCSLOmVectorInfo stimInfo = CSLOmVectorInfo::cast((*vIt1)->getUnitInfo());
    
// //         RefCDOmStmtTaskEnable readMemFromFile;
// //         switch (stimInfo->getRadix()) {        
// //           case CSLOmVerifCompInfo::VC_RADIX_HEX :
// //             readMemFromFile = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
// //                                                       CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
// //                                                       buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$readmemh")))
// //                                                       );
// //             break;
// //           default: 
// //             readMemFromFile = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
// //                                                       CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
// //                                                       buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$readmemb")))
// //                                                       );
// //         }
    
// //         RefString tbVectFileName = RefString(new string("\""));
// //         tbVectFileName->append(*(stimInfo->getOutputFilename()));
// //         tbVectFileName->append("\"");
// //         readMemFromFile->addExpr(buildCDOmString(unitDecl->getLineNumber(), tbVectFileName));
      
// //         RefString vectInstanceName = (CDOmIdentifier::cast((*vIt2)->getChild(0)))->getName();
// //         RefCDOmExprLink memHid = buildCDOmExprLink(unitDecl->getLineNumber(), vectInstanceName);
// //         RefString vName = RefString(new string("stim_expect_memory"));
// //         memHid->addHidItem(vName);
// //         readMemFromFile->addExpr(memHid); 

// //         stmtBlock->addStmt(readMemFromFile);
//       }
    }
  }

  //files associated with expect vector instances
  for(map<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>::const_iterator mIt = m_cdomDutsExpectVects.begin(); mIt != m_cdomDutsExpectVects.end(); ++mIt) {
    //retrieve the dut type
    RefCDOmModuleOrUdpInstance cdomDut = mIt->first;
    RefCDOmModuleOrUdpInstantiation instantiation = CDOmModuleOrUdpInstantiation::cast(cdomDut->getParent());
    RefCDOmExprLink linkToDutModule = instantiation->getModuleExprLink();
    RefCDOmScope currentScope = m_product->getAttachedScope();
    RefCDOmIdentifier typeId = currentScope->lookupLocal(linkToDutModule->getName());
    RefCDOmModuleDecl dut = CDOmModuleDecl::cast(typeId->getParent());
    
    //retrieve the verilog expect vector instances vector      
    RefTVec_RefCDOmModuleOrUdpInstance assocCdomExpects = mIt->second;

    //retrieve the csl expect vectors vector
    map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator vIt = m_tbDutNamesExpectVects.find((CDOmIdentifier::cast(dut->getChild(0)))->getName());
    ASSERT(vIt != m_tbDutNamesExpectVects.end(), "Adapter internal bug: verilog dut instance has expect vectors associated while the original csl instance has none");
    RefTVec_RefCSLOmUnitDecl assocCslExpects = vIt->second;

//     //read the files into memories
//     TVec_RefCSLOmUnitDecl::const_iterator vIt1;
//     TVec_RefCDOmModuleOrUdpInstance::const_iterator vIt2;
//     for(vIt1 = assocCslExpects->begin(),  vIt2 = assocCdomExpects->begin();
//         vIt1 < assocCslExpects->end()  && vIt2 < assocCdomExpects->end()  ;
//         ++vIt1                         ,  ++vIt2                          ) {

//       RefCSLOmVectorInfo expectInfo = CSLOmVectorInfo::cast((*vIt1)->getUnitInfo());
    
//       RefCDOmStmtTaskEnable readMemFromFile;
//       switch (expectInfo->getRadix()) {        
//         case CSLOmVerifCompInfo::VC_RADIX_HEX :
//           readMemFromFile = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
//                                                     CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
//                                                     buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$readmemh")))
//                                                     );
//           break;
//         default: 
//           readMemFromFile = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
//                                                     CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
//                                                     buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$readmemb")))
//                                                     );
//       }

//       RefString tbVectFileName = RefString(new string("\""));
//       tbVectFileName->append(*(expectInfo->getOutputFilename()));
//       tbVectFileName->append("\"");
//       readMemFromFile->addExpr(buildCDOmString(unitDecl->getLineNumber(), tbVectFileName));
      
//       RefString vectInstanceName = (CDOmIdentifier::cast((*vIt2)->getChild(0)))->getName();
//       RefCDOmExprLink memHid = buildCDOmExprLink(unitDecl->getLineNumber(), vectInstanceName);
//       RefString vName = RefString(new string("stim_expect_memory"));
//       memHid->addHidItem(vName);
//       readMemFromFile->addExpr(memHid); 

//       stmtBlock->addStmt(readMemFromFile);
//     }
  }
  

  //section 8 : fsdb/vsd waves generation(included in tb module init block)
  
  if(!outputFileName.get()) {
    outputFileName = RefString(new string("wavesDefaultOutputFile"));
  }
  if(waveType == CSLOmTBInfo::TB_WAVE_UNDEF) {
    waveType = CSLOmTBInfo::TB_WAVE_VSD;
  }
  //RefCDOmExprLink scope;?
  RefTVec_RefCDOmStmt stmtVecForWaveGen = generateFsdbOrVsd(unitDecl->getLineNumber(), unitDecl->getName(), outputFileName, waveType);
  if(stmtVecForWaveGen.get() && stmtVecForWaveGen->size()) {
    for(TVec_RefCDOmStmt::const_iterator it = stmtVecForWaveGen->begin(); it < stmtVecForWaveGen->end(); ++it) {
      stmtBlock->addStmt(*it);
    }
  }

  RefCDOmInitOrAlways initBlock = buildCDOmInitOrAlways(unitDecl->getLineNumber(), m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_INIT, stmtBlock );         

  //section 9 : build tb auxiliary signals, one(or two) for each port of each dut instance, connect the dut instances and the vector instances
  RefTVec_RefString dutOutputCopies = RefTVec_RefString(new TVec_RefString());
  RefTVec_RefString dutOutputCopiesExpect = RefTVec_RefString(new TVec_RefString());
  map<RefString, RefTVec_RefString> expInstancesOutputCopies;
  map<RefString, RefTVec_RefString> expInstancesOutputCopiesExpect;

  ASSERT(!m_cdomDutInstances->empty(), "Testbench has no dut instances");
  for(TVec_RefCDOmModuleOrUdpInstance::const_iterator it = m_cdomDutInstances->begin(); it < m_cdomDutInstances->end(); ++it) {
    //connect clock port to dut instance
    (*it)->addPortConnection(RefCDOmAttrListCollection(), 
                             buildCDOmExprLink(unitDecl->getLineNumber(), clockName),
                             clockName
                             );

    //retrieve the instance type
    RefCDOmModuleOrUdpInstantiation instantiation = CDOmModuleOrUdpInstantiation::cast((*it)->getParent());
    RefCDOmExprLink linkToDutModule = instantiation->getModuleExprLink();
    RefCDOmScope currentScope = m_product->getAttachedScope();
    RefCDOmIdentifier typeId = currentScope->lookupLocal(linkToDutModule->getName());
    RefCDOmModuleDecl dut = CDOmModuleDecl::cast(typeId->getParent());

    RefCDOmExpr stimActual;
    RefCDOmExpr expectActual;
    
    //get input ports after include/exclude
    map<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>::const_iterator mapIt = m_cdomDutsStimVects.find(*it);
    //ASSERT(mapIt != m_cdomDutsStimVects.end(), "Internal bug: Missing stim vect instance for a dut instance");
    RefTVec_RefCDOmModuleOrUdpInstance assocStimInstances = RefTVec_RefCDOmModuleOrUdpInstance(new TVec_RefCDOmModuleOrUdpInstance());
    if(mapIt != m_cdomDutsStimVects.end()) {
      assocStimInstances = mapIt->second;
    }

    map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator it0 = m_tbDutNamesStimVects.find((CDOmIdentifier::cast(dut->getChild(0)))->getName());
    if(it0 != m_tbDutNamesStimVects.end()) {
      RefTVec_RefCSLOmUnitDecl assocStims = it0->second;
      
      TVec_RefCSLOmUnitDecl::const_iterator stimIt;
      TVec_RefCDOmModuleOrUdpInstance::const_iterator stimInstIt;
      for(stimIt = assocStims->begin(), stimInstIt = assocStimInstances->begin(); 
          stimIt < assocStims->end() && stimInstIt < assocStimInstances->end(); 
          ++stimIt, ++stimInstIt) {
        
        DCERR("stim vector name = " << *((*stimIt)->getName()) << " stim vector instance name = " << *(CDOmIdentifier::cast((*stimInstIt)->getChild(0))->getName()) << endl);
        RefCSLOmVectorInfo assocStimInfo = CSLOmVectorInfo::cast((*stimIt)->getUnitInfo());
        RefTVec_RefCSLOmExprLink assocInPorts = assocStimInfo->getAssociatedPorts();

        //build 1 aux tb sig for each dut input
        if(assocInPorts.get()) {
          for(TVec_RefCSLOmExprLink::const_iterator iter = assocInPorts->begin(); iter < assocInPorts->end(); ++iter) {
            DCERR("stim vector port = " << (*(*iter)->getLocalNameID()->getName()));

            RefCSLOmPortDecl port = CSLOmPortDecl::cast((*iter)->getLocalNameID()->getParent());

            //look for all the interface-type parents of the port, if any for corret port name generation
            RefString portName = RefString(new string(""));
            map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator nameIt = m_allCslPorts.find(port);
            if(nameIt != m_allCslPorts.end()) {
              ASSERT((nameIt->second).get(), "Internal bug: no ifc prefixes for a port inside allCslPorts map"); 
              RefTVec_RefString ifcNames = nameIt->second;
              if(ifcNames.get() && ifcNames->size()) {
                for(TVec_RefString::const_iterator ifcIt = ifcNames->begin(); ifcIt < ifcNames->end(); ++ifcIt) {
                  if((*ifcIt).get()) {
                    portName->append(**ifcIt);
                    portName->append("_");
                  }
                }
              }
            }
            portName->append(*(port->getName()));
            
            RefCSLOmExpr width = port->getWidth();
            RefCSLOmNumber noWidth = CSLOmNumber::cast(width->doEval());
            RefCDOmNetDecl tbAuxSig = buildCDOmNetDecl(unitDecl->getLineNumber(), 
                                                       m_cdomCurrParent,
                                                       NET_WIRE,
                                                       buildCDOmRange(unitDecl->getLineNumber(),    
                                                                      buildCDOmNum32WithValue(unitDecl->getLineNumber(), 
                                                                                              (noWidth->getValue() - 1)),
                                                                      buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                      )
                                                       );
                
            RefString tbAuxSigName = RefString(new string(*((CDOmIdentifier::cast((*it)->getChild(0)))->getName())));//dut instance name
            tbAuxSigName->append("_in_");//port direction
            tbAuxSigName->append(*portName);//port name
            tbAuxSig->addNet(unitDecl->getLineNumber(), tbAuxSigName);

            //connect to dut instance
            RefString formal = portName;
            RefCDOmExprLink actual = buildCDOmExprLink(unitDecl->getLineNumber(), tbAuxSigName);
            (*it)->addPortConnection(RefCDOmAttrListCollection(), actual, formal);


            //build actual for connection to stim vector instance
            if(assocInPorts->size() == 1) { // no need for concat
              stimActual = buildCDOmExprLink(unitDecl->getLineNumber(), tbAuxSigName);
            }
            else {
              if(!stimActual.get()) {
                stimActual = buildCDOmExprConcat(unitDecl->getLineNumber(), buildCDOmExprLink(unitDecl->getLineNumber(), tbAuxSigName));
              }
              else {
                CDOmExprConcat::cast(stimActual)->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), tbAuxSigName));
              }
            }
          }
          
          //connections to stim vector instance
          if(stimActual.get()) {
            //connect vector output
            (*stimInstIt)->addPortConnection(RefCDOmAttrListCollection(), stimActual, m_tbVectOutputName);
            //connect vector clock
            (*stimInstIt)->addPortConnection(RefCDOmAttrListCollection(), 
                                            buildCDOmExprLink(unitDecl->getLineNumber(), clockName),
                                            m_tbVectClockName
                                            );
            //connect vector reset
            (*stimInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), resetName),
                                            m_tbVectResetName
                                            );
            //connect vector valid
            (*stimInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), validName),
                                            m_tbVectValidName
                                            );
            //connect vector rdEn
            (*stimInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), rdEnName),
                                            m_tbVectRdEnName
                                            );
            //connect vector verErr
            (*stimInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), verErrName),
                                            m_tbVectVerErrName
                                            );
            //connect vector idErr
            (*stimInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), idErrName),
                                            m_tbVectIdErrName
                                            );
        
          }
          else {
            (*stimInstIt)->addPortConnection();
          }
        }
      }
    }
   
    //get output ports after include/exclude
    map<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>::const_iterator mapIt1 = m_cdomDutsExpectVects.find(*it);
    ASSERT(mapIt1 != m_cdomDutsExpectVects.end(), "internal bug: dut instance has no associated expect vector instances");
    RefTVec_RefCDOmModuleOrUdpInstance assocExpectInsts = mapIt1->second;

    map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator it1 = m_tbDutNamesExpectVects.find((CDOmIdentifier::cast(dut->getChild(0)))->getName());
    ASSERT(it1 != m_tbDutNamesExpectVects.end(), "internal bug: no expect vector associated to dut instance");
    RefTVec_RefCSLOmUnitDecl assocExpects = it1->second;

    TVec_RefCSLOmUnitDecl::const_iterator expectIt;
    TVec_RefCDOmModuleOrUdpInstance::const_iterator expectInstIt;
    for(expectIt = assocExpects->begin(),  expectInstIt = assocExpectInsts->begin(); 
        expectIt < assocExpects->end() && expectInstIt < assocExpectInsts->end()  ; 
        ++expectIt                     ,  ++expectInstIt                          ) {

      DCERR("expect vector name = " << *((*expectIt)->getName()) << " expect vect inst name = " << *(CDOmIdentifier::cast((*expectInstIt)->getChild(0))->getName()) << endl);

      RefCSLOmVectorInfo assocExpectInfo = CSLOmVectorInfo::cast((*expectIt)->getUnitInfo());
      RefTVec_RefCSLOmExprLink assocOutPorts = assocExpectInfo->getAssociatedPorts();

      //build aux tb sigs for all dut outputs(2 tb aux sigs for each dut output: 1 connects to the comparator and the other to the expect vector)
      dutOutputCopies = RefTVec_RefString(new TVec_RefString());
      dutOutputCopiesExpect = RefTVec_RefString(new TVec_RefString());

      if(assocOutPorts.get()) {
        //DCERR("Number of associated output ports for vector " << *((*expectIt)->getName()) << " : " << assocOutPorts->size() << endl);
        for(TVec_RefCSLOmExprLink::const_iterator iter = assocOutPorts->begin(); iter < assocOutPorts->end(); ++iter) {
          DCERR("expect vector port = " << (*(*iter)->getLocalNameID()->getName()));
          RefCSLOmPortDecl port = CSLOmPortDecl::cast((*iter)->getLocalNameID()->getParent());

          //look for all the interface-type parents of the port, if any for corret port name generation
          RefString portName = RefString(new string(""));
          map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator nameIt = m_allCslPorts.find(port);
          if(nameIt != m_allCslPorts.end()) {
            ASSERT((nameIt->second).get(), "Internal bug: no ifc prefixes for a port inside allCslPorts map"); 
            RefTVec_RefString ifcNames = nameIt->second;
            if(ifcNames.get() && ifcNames->size()) {
              for(TVec_RefString::const_iterator ifcIt = ifcNames->begin(); ifcIt < ifcNames->end(); ++ifcIt) {
                if((*ifcIt).get()) {
                  portName->append(**ifcIt);
                  portName->append("_");
                }
              }
            }
          }
          portName->append(*(port->getName()));

          for(TInt i = 0; i <= 1; ++i) {
            RefCSLOmExpr width = port->getWidth();
            RefCSLOmNumber noWidth = CSLOmNumber::cast(width->doEval());
            RefCDOmNetDecl tbAuxSig = buildCDOmNetDecl(unitDecl->getLineNumber(), 
                                                       m_cdomCurrParent,
                                                       NET_WIRE,
                                                       buildCDOmRange(unitDecl->getLineNumber(),    
                                                                      buildCDOmNum32WithValue(unitDecl->getLineNumber(), 
                                                                                              noWidth->getValue() - 1),
                                                                      buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                      )
                                                       );
            RefString tbAuxSigName = RefString(new string(*((CDOmIdentifier::cast((*it)->getChild(0))))->getName()));//dut instance name
            tbAuxSigName->append("_out_");//port direction
            tbAuxSigName->append(*portName);//port name
            if(i) {
              tbAuxSigName->append("_expect");
            }
            tbAuxSig->addNet(unitDecl->getLineNumber(), tbAuxSigName);
          
            if(!i) {
              dutOutputCopies->push_back(tbAuxSigName);
            
              //connections to dut instance
              RefString formal = portName;
              RefCDOmExprLink actual = buildCDOmExprLink(unitDecl->getLineNumber(), tbAuxSigName);
              (*it)->addPortConnection(RefCDOmAttrListCollection(), actual, formal);
            }
            if(i) {
              dutOutputCopiesExpect->push_back(tbAuxSigName);

              //build actual for expect vect connection
              if(assocOutPorts->size() == 1) {
                expectActual = buildCDOmExprLink(unitDecl->getLineNumber(), tbAuxSigName);
              }
              else {
                if(!expectActual.get()) {
                  expectActual = buildCDOmExprConcat(unitDecl->getLineNumber(), buildCDOmExprLink(unitDecl->getLineNumber(), tbAuxSigName));
                }
                else {
                  CDOmExprConcat::cast(expectActual)->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), tbAuxSigName));
                }
              }
            }
          }
        }
        //connect to expect vector
        if(expectActual.get()) {
          //connect vector output
          (*expectInstIt)->addPortConnection(RefCDOmAttrListCollection(), expectActual, m_tbVectOutputName);
          //connect vector clock
          (*expectInstIt)->addPortConnection(RefCDOmAttrListCollection(), 
                                            buildCDOmExprLink(unitDecl->getLineNumber(), clockName),
                                            m_tbVectClockName
                                            );
          //connect vector reset
          (*expectInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), resetName),
                                            m_tbVectResetName
                                            );
          //connect vector valid
          (*expectInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), validName),
                                            m_tbVectValidName
                                            );
          //connect vector rdEn
          (*expectInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), rdEnName),
                                            m_tbVectRdEnName
                                            );
          //connect vector verErr
          (*expectInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), verErrName),
                                            m_tbVectVerErrName
                                            );
          //connect vector idErr
          (*expectInstIt)->addPortConnection(RefCDOmAttrListCollection(),
                                            buildCDOmExprLink(unitDecl->getLineNumber(), idErrName),
                                            m_tbVectIdErrName
                                            );
        }
        else {
          (*expectInstIt)->addPortConnection();
        }
      }

      expInstancesOutputCopies.insert(pair<RefString, RefTVec_RefString>(CDOmIdentifier::cast((*expectInstIt)->getChild(0))->getName(), dutOutputCopies));
      expInstancesOutputCopiesExpect.insert(pair<RefString, RefTVec_RefString>(CDOmIdentifier::cast((*expectInstIt)->getChild(0))->getName(), dutOutputCopiesExpect));
    }

    //if the dut has no ports, initialize an emty f2a connection map
    if(!(*it)->getExplicitPortMap().get()) {
      (*it)->addPortConnection();
    }                             
  }  
  
  //section 9bis : write dut output values vs expected values in output file

  RefCDOmStmtBlock stmtBlk = buildCDOmStmtBlock(unitDecl->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);

  for(map<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>::const_iterator it = m_cdomDutsExpectVects.begin(); it != m_cdomDutsExpectVects.end(); ++it ) {

    RefTVec_RefCDOmModuleOrUdpInstance expInstances = it->second;
    for(TVec_RefCDOmModuleOrUdpInstance::const_iterator itt = expInstances->begin(); itt < expInstances->end(); ++itt ) {
    
      RefCDOmStmtTaskEnable taskEn = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
                                                             CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                             buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$fdisplay")))
                                                             );
      taskEn->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), fileMcdName));
      taskEn->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("dut name: %s"))));
      taskEn->addExpr(buildCDOmString(unitDecl->getLineNumber(), CDOmIdentifier::cast((it->first)->getChild(0))->getName()));
      taskEn->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string(" expect vector name: %s"))));
      taskEn->addExpr(buildCDOmString(unitDecl->getLineNumber(), CDOmIdentifier::cast((*itt)->getChild(0))->getName()));  
      taskEn->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("\\n"))));
      stmtBlk->addStmt(taskEn);

      map<RefString, RefTVec_RefString>::const_iterator copyIt = expInstancesOutputCopies.find(CDOmIdentifier::cast((*itt)->getChild(0))->getName());
      map<RefString, RefTVec_RefString>::const_iterator copyExpIt = expInstancesOutputCopiesExpect.find(CDOmIdentifier::cast((*itt)->getChild(0))->getName());
      //ASSERT
      RefTVec_RefString outCopies = copyIt->second;
      RefTVec_RefString outCopiesExpect = copyExpIt->second;
      TVec_RefString::const_iterator it1;
      TVec_RefString::const_iterator it2;
      for(it1= outCopies->begin(),  it2 = outCopiesExpect->begin();
          it1 < outCopies->end() && it2 < outCopiesExpect->end();
          ++it1, ++it2) {

        RefCDOmStmtTaskEnable taskEn1 = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
                                                             CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                             buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$fdisplay")))
                                                             );
        taskEn1->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), fileMcdName));
        taskEn1->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("dut output: %b"))));
        taskEn1->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), *it1));
        taskEn1->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("expected output: %b"))));
        taskEn1->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), *it2));
        stmtBlk->addStmt(taskEn1);
      }
    }
  }
 
  RefCDOmStmtProcTimingControl ptc = 
    buildCDOmStmtProcTimingControlWithEventControl(unitDecl->getLineNumber(),
                                                   buildCDOmEventControlWithEvExpr(unitDecl->getLineNumber(),
                                                                                   buildCDOmEventExprSimple(unitDecl->getLineNumber(),
                                                                                                            CDOmEventExpr::EVENT_EXPR_POSEDGE,
                                                                                                            buildCDOmExprLink(unitDecl->getLineNumber(),
                                                                                                                              clockName
                                                                                                                              )
                                                                                                            )
                                                                                   ),
                                                   stmtBlk
                                                   );

  if(tbInfo->getReportType() > CSLOmTBInfo::TB_REPORT_UNDEF && tbInfo->getReportType() < CSLOmTBInfo::TB_REPORT_MAX) {
    RefCDOmInitOrAlways alwaysBlk = buildCDOmInitOrAlways(unitDecl->getLineNumber(), m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc);

    //section 9bisbis: write the report file

    RefCDOmStmtBlock reportStmtBlk = buildCDOmStmtBlock(unitDecl->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);

    for(map<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>::const_iterator it = m_cdomDutsExpectVects.begin(); it != m_cdomDutsExpectVects.end(); ++it) {

      //retrieve dut
      //RefCDOmModuleDecl dut = retrieveModuleFromInstance(it->first);
      //RefString dutName = CDOmIdentifier::cast(dut->getChild(0))->getName();
    
      //retrieve csl expects
      //map<RefString,RefTVec_RefCSLOmUnitDecl>::const_iterator cslIt = m_tbDutNamesExpectVects.find(dutName);
      //ASSERT(cslIt != m_tbDutNamesExpectVects.end(), "Write report problem");
      //RefTVec_RefCSLOmUnitDecl cslExpectVectors = cslIt->second; 

      //retrieve cdom expects
      RefTVec_RefCDOmModuleOrUdpInstance cdomExpectVectors = it->second;
      TVec_RefCDOmModuleOrUdpInstance::const_iterator itt;
      for(itt = cdomExpectVectors->begin(); itt < cdomExpectVectors->end(); ++itt) {
        RefCDOmStmtTaskEnable dis = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
                                                            CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                            buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$fdisplay")))
                                                            );
        dis->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), reportFileMcdName));
        dis->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("Status for expect vector %s"))));
        dis->addExpr(buildCDOmString(unitDecl->getLineNumber(),CDOmIdentifier::cast((*itt)->getChild(0))->getName() ));
        dis->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("associated to dut %s"))));
        dis->addExpr(buildCDOmString(unitDecl->getLineNumber(), CDOmIdentifier::cast(it->first->getChild(0))->getName()));
        dis->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string(":\\n"))));
        reportStmtBlk->addStmt(dis);

        RefCDOmStmtTaskEnable dis1 = buildCDOmStmtTaskEnable(unitDecl->getLineNumber(), 
                                                             CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                             buildCDOmExprLink(unitDecl->getLineNumber(), RefString(new string("$fdisplay")))
                                                             );
        dis1->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), reportFileMcdName));
        dis1->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("Total number of comparisons: %b"))));

        RefString expTransactionName = RefString(new string(*(CDOmIdentifier::cast((*itt)->getChild(0))->getName())));
        expTransactionName->append("_transaction_count");
        dis1->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), expTransactionName));
        dis1->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string(" out of which, passed: %b"))));

        RefString expMatchName = RefString(new string(*(CDOmIdentifier::cast((*itt)->getChild(0))->getName())));
        expMatchName->append("_match_count");
        dis1->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(), expMatchName));
        dis1->addExpr(buildCDOmString(unitDecl->getLineNumber(), RefString(new string("\\nOverall: %s"))));

        RefString final = RefString(new string(*(CDOmIdentifier::cast((*itt)->getChild(0))->getName())));
        final->append("_mismatch_count?\"failed\":\"passed\"");
        dis1->addExpr(buildCDOmExprLink(unitDecl->getLineNumber(),final ));
        reportStmtBlk->addStmt(dis1);
      
      }
    }

    RefCDOmStmtBlock mainReportStmtBlk = buildCDOmStmtBlock(unitDecl->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);
    RefCDOmStmtIf reportIf = buildCDOmStmtIf(unitDecl->getLineNumber(),
                                             buildCDOmExprLink(unitDecl->getLineNumber(), simStopName),
                                             reportStmtBlk,
                                             RefCDOmStmt()
                                             );
    mainReportStmtBlk->addStmt(reportIf);
  

    RefCDOmStmtProcTimingControl reportPtc = 
      buildCDOmStmtProcTimingControlWithEventControl(unitDecl->getLineNumber(),
                                                     buildCDOmEventControlWithEvExpr(unitDecl->getLineNumber(),
                                                                                     buildCDOmEventExprSimple(unitDecl->getLineNumber(),
                                                                                                              CDOmEventExpr::EVENT_EXPR_POSEDGE,
                                                                                                              buildCDOmExprLink(unitDecl->getLineNumber(),
                                                                                                                                clockName
                                                                                                                                )
                                                                                                              )
                                                                                     ),
                                                     mainReportStmtBlk
                                                     );
  
    RefCDOmInitOrAlways alwaysBlkReport = buildCDOmInitOrAlways(unitDecl->getLineNumber(), m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, reportPtc);
  }

  //section 10 : always block to generate clock waves

  RefCDOmStmtProcTimingControl 
    clockWaves = buildCDOmStmtProcTimingControlWithDelayControl ( unitDecl->getLineNumber(),
                                                                  buildCDOmDelayControl(unitDecl->getLineNumber(), 
                                                                                        buildCDOmNum32WithValue(unitDecl->getLineNumber(), clockPeriod->getValue())
                                                                                        ),
                                                                  buildCDOmStmtAssnSimple(unitDecl->getLineNumber(),
                                                                                          CDOmStmtAssn::ASSN_BLOCKING,
                                                                                          buildCDOmExprLink(unitDecl->getLineNumber(), clockName),
                                                                                          buildCDOmExprOp(unitDecl->getLineNumber(),
                                                                                                          CDOmExprOp::OP_UNARY_BITWISE_NOT, 
                                                                                                          buildCDOmExprLink(unitDecl->getLineNumber(), clockName)
                                                                                                          )
                                                                                          )
                                                                                             
                                                                  );
  RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(unitDecl->getLineNumber(), m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, clockWaves);

  //section 11 : initial display of stimvect memory contents

  //build testbench integer for mem iterator 
  //RefString memAddrIterName = RefString(new string("mem_addr"));
  //RefCDOmVarDecl memAddrIter = buildCDOmVarDecl(unitDecl->getLineNumber(),
  //                                              m_cdomCurrParent,
  //                                              VAR_INTEGER,
  //                                              RefCDOmRange(),
  //                                              memAddrIterName
  //                                              );
  //  
  //for(map<RefString, RefCSLOmUnitDecl>::const_iterator it = m_tbDutNamesStimVects.begin(); it != m_tbDutNamesStimVects.end(); ++it) {
  //
  //  RefString paramName;    
  //  paramName = refStrToUpper(it->second->getName());
  //  paramName->append("_VECTOR_FILE");
  //
  //  RefString memWidthName;
  //  memWidthName = refStrToUpper(it->second->getName());
  //  memWidthName->append("_MEM_WIDTH");
  //
  //  RefString memDepthName;
  //  memDepthName = refStrToUpper(it->second->getName());
  //  memDepthName->append("_MEM_DEPTH");
  //
  //  RefString memLoadedName;
  //  memLoadedName = RefString(new string(*(it->second->getName())));
  //  memLoadedName->append("_mem_loaded");
  //  RefCDOmVarDecl memLoaded = buildCDOmVarDecl(unitDecl->getLineNumber(),
  //                                              m_cdomCurrParent,
  //                                              VAR_REG,
  //                                              buildCDOmRange(unitDecl->getLineNumber(),
  //                                                             buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                             buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                             ),
  //                                              memLoadedName
  //                                              );
  //  
  //  RefString memName;
  //  memName = RefString(new string(*(it->second->getName())));
  //  memName->append("_mem");
  //  RefCDOmVarDecl initMem = buildCDOmVarDecl(unitDecl->getLineNumber(),
  //                                            m_cdomCurrParent,
  //                                            VAR_REG,
  //                                            buildCDOmRange(unitDecl->getLineNumber(),
  //                                                           buildCDOmExprOp(unitDecl->getLineNumber(),
  //                                                                           CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
  //                                                                           buildCDOmExprLink(unitDecl->getLineNumber(), memWidthName),
  //                                                                           buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
  //                                                                           ),
  //                                                           buildCDOmNum32WithValue(unitDecl->getLineNumber(),0)
  //                                                           ),
  //                                            memName,
  //                                            buildCDOmRangeList(unitDecl->getLineNumber(),
  //                                                               buildCDOmRange(unitDecl->getLineNumber(),
  //                                                                              buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                                              buildCDOmExprOp(unitDecl->getLineNumber(), 
  //                                                                                              CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
  //                                                                                              buildCDOmExprLink(unitDecl->getLineNumber(), 
  //                                                                                                                memDepthName
  //                                                                                                                ),
  //                                                                                              buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
  //                                                                                              )
  //                                                                              )
  //                                                               )
  //                                            );
  //  
  //  generateInitialVectorMemDisplay(unitDecl->getLineNumber(), memLoadedName, memName, paramName, memDepthName, 0, memAddrIterName);
  //}
  //
  //for(map<RefString, RefCSLOmUnitDecl>::const_iterator it = m_tbDutNamesExpectVects.begin(); it != m_tbDutNamesExpectVects.end(); ++it) {
  //
  //  RefString paramName;    
  //  paramName = refStrToUpper(it->second->getName());
  //  paramName->append("_VECTOR_FILE");
  //
  //  RefString memWidthName;
  //  memWidthName = refStrToUpper(it->second->getName());
  //  memWidthName->append("_MEM_WIDTH");
  //
  //  RefString memDepthName;
  //  memDepthName = refStrToUpper(it->second->getName());
  //  memDepthName->append("_MEM_DEPTH");
  //
  //  RefString memLoadedName;
  //  memLoadedName = RefString(new string(*(it->second->getName())));
  //  memLoadedName->append("_mem_loaded");
  //  RefCDOmVarDecl memLoaded = buildCDOmVarDecl(unitDecl->getLineNumber(),
  //                                              m_cdomCurrParent,
  //                                              VAR_REG,
  //                                              buildCDOmRange(unitDecl->getLineNumber(),
  //                                                             buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                             buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                             ),
  //                                              memLoadedName
  //                                              );
  //  
  //  RefString memName;
  //  memName = RefString(new string(*(it->second->getName())));
  //  memName->append("_mem");
  //  RefCDOmVarDecl initMem = buildCDOmVarDecl(unitDecl->getLineNumber(),
  //                                            m_cdomCurrParent,
  //                                            VAR_REG,
  //                                            buildCDOmRange(unitDecl->getLineNumber(),
  //                                                           buildCDOmExprOp(unitDecl->getLineNumber(),
  //                                                                           CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
  //                                                                           buildCDOmExprLink(unitDecl->getLineNumber(), memWidthName),
  //                                                                           buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
  //                                                                           ),
  //                                                           buildCDOmNum32WithValue(unitDecl->getLineNumber(),0)
  //                                                           ),
  //                                            memName,
  //                                            buildCDOmRangeList(unitDecl->getLineNumber(),
  //                                                               buildCDOmRange(unitDecl->getLineNumber(),
  //                                                                              buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                                              buildCDOmExprOp(unitDecl->getLineNumber(), 
  //                                                                                              CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
  //                                                                                              buildCDOmExprLink(unitDecl->getLineNumber(), 
  //                                                                                                                memDepthName
  //                                                                                                                ),
  //                                                                                              buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
  //                                                                                              )
  //                                                                              )
  //                                                               )
  //                                            );
  //  
  //  generateInitialVectorMemDisplay(unitDecl->getLineNumber(), memLoadedName, memName, paramName, memDepthName, 1, memAddrIterName);
  //}

  //section 12 : dut ouputs - expect outputs compare logic    
  for(map<RefCDOmModuleOrUdpInstance, RefTVec_RefCDOmModuleOrUdpInstance>::const_iterator it = m_cdomDutsExpectVects.begin(); it != m_cdomDutsExpectVects.end(); ++it) {
    //retrieve the instance type

    RefCDOmModuleDecl dut = retrieveModuleFromInstance(it->first);
    RefString dutName = (CDOmIdentifier::cast(dut->getChild(0)))->getName();

    RefString dutInstanceName = CDOmIdentifier::cast(it->first->getChild(0))->getName();

    map<RefString, RefTVec_RefCSLOmUnitDecl>::const_iterator vectIt = m_tbDutNamesExpectVects.find(dutName);
    ASSERT(vectIt != m_tbDutNamesExpectVects.end(), "Internal bug: dut instance with no associated expect vector");
    RefTVec_RefCSLOmUnitDecl expVector = vectIt->second;

    RefTVec_RefCDOmModuleOrUdpInstance expInstVector = it->second;

    TVec_RefCSLOmUnitDecl::const_iterator expIt;
    TVec_RefCDOmModuleOrUdpInstance::const_iterator expInstIt;
    for(expIt = expVector->begin(),   expInstIt = expInstVector->begin();
        expIt < expVector->end()   && expInstIt < expInstVector->end()  ;
        ++expIt                    ,  ++expInstIt                       ) {

      RefString matchCountName = RefString(new string(*(CDOmIdentifier::cast((*expInstIt)->getChild(0))->getName())));
      matchCountName->append("_match_count");
      //add to init block
      stmtBlock->addStmt(buildCDOmStmtAssnSimple(unitDecl->getLineNumber(), 
                                                 CDOmStmtAssn::ASSN_BLOCKING, 
                                                 buildCDOmExprLink(unitDecl->getLineNumber(), matchCountName),
                                                 buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                 )
                         );

      RefString mismatchCountName = RefString(new string(*(CDOmIdentifier::cast((*expInstIt)->getChild(0))->getName())));
      mismatchCountName->append("_mismatch_count");
      //add to init block
      stmtBlock->addStmt(buildCDOmStmtAssnSimple(unitDecl->getLineNumber(), 
                                                 CDOmStmtAssn::ASSN_BLOCKING, 
                                                 buildCDOmExprLink(unitDecl->getLineNumber(), mismatchCountName),
                                                 buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                 )
                         );

      RefString transactionCountName = RefString(new string(*(CDOmIdentifier::cast((*expInstIt)->getChild(0))->getName())));
      transactionCountName->append("_transaction_count");
      //add to init block
      stmtBlock->addStmt(buildCDOmStmtAssnSimple(unitDecl->getLineNumber(), 
                                                 CDOmStmtAssn::ASSN_BLOCKING, 
                                                 buildCDOmExprLink(unitDecl->getLineNumber(), transactionCountName),
                                                 buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                 )
                         );

      RefString mismatchName = RefString(new string(*(CDOmIdentifier::cast((*expInstIt)->getChild(0))->getName())));
      mismatchName->append("_mismatch");

      RefString widthName = refStrToUpper((*expIt)->getName());
      widthName->append("_ADDR_WIDTH");

      RefCDOmVarDecl matchCount = buildCDOmVarDecl(unitDecl->getLineNumber(),
                                                   m_cdomCurrParent,
                                                   VAR_REG,
                                                   buildCDOmRange(unitDecl->getLineNumber(),
                                                                  buildCDOmExprOp(unitDecl->getLineNumber(), 
                                                                                  CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                                  buildCDOmExprLink(unitDecl->getLineNumber(), widthName),
                                                                                  buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
                                                                                  ),
                                                                  buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                  ),
                                                   matchCountName
                                                   );
    
    
      RefCDOmVarDecl mismatchCount = buildCDOmVarDecl(unitDecl->getLineNumber(),
                                                      m_cdomCurrParent,
                                                      VAR_REG,
                                                      buildCDOmRange(unitDecl->getLineNumber(),
                                                                     buildCDOmExprOp(unitDecl->getLineNumber(), 
                                                                                     CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                                     buildCDOmExprLink(unitDecl->getLineNumber(), widthName),
                                                                                     buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
                                                                                     ),
                                                                     buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                     ),
                                                      mismatchCountName
                                                      );
    

      RefCDOmVarDecl transactionCount = buildCDOmVarDecl(unitDecl->getLineNumber(),
                                                         m_cdomCurrParent,
                                                         VAR_REG,
                                                         buildCDOmRange(unitDecl->getLineNumber(),
                                                                        buildCDOmExprOp(unitDecl->getLineNumber(), 
                                                                                        CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                                        buildCDOmExprLink(unitDecl->getLineNumber(), widthName),
                                                                                        buildCDOmNum32WithValue(unitDecl->getLineNumber(), 1)
                                                                                        ),
                                                                        buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                        ),
                                                         transactionCountName
                                                         );
    

      RefCDOmVarDecl mismatch = buildCDOmVarDecl(unitDecl->getLineNumber(),
                                                 m_cdomCurrParent,
                                                 VAR_REG,
                                                 buildCDOmRange(unitDecl->getLineNumber(), 
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0), 
                                                                buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
                                                                ),
                                                 mismatchName
                                                 );


      RefString maxErrParamName = refStrToUpper((*expIt)->getName());
      maxErrParamName->append("_VECTOR_MAX_ERR");

      RefString addrWidthParamName = refStrToUpper((*expIt)->getName());
      addrWidthParamName->append("_ADDR_WIDTH");

      RefString expectVectInstanceName = CDOmIdentifier::cast((*expInstIt)->getChild(0))->getName();

      RefTVec_RefString dutOutputs = RefTVec_RefString(new TVec_RefString());
      RefTVec_RefString expectOutputs = RefTVec_RefString(new TVec_RefString());

      map<RefString, RefTVec_RefString>::const_iterator itr1 = expInstancesOutputCopies.find(expectVectInstanceName);
      ASSERT(itr1 != expInstancesOutputCopies.end(), "Internal bug: no copies created inside the tb for at least one of the instantiated duts");
      dutOutputs = itr1->second;

      map<RefString, RefTVec_RefString>::const_iterator itr2 = expInstancesOutputCopiesExpect.find(expectVectInstanceName);
      ASSERT(itr2 != expInstancesOutputCopiesExpect.end(), "Internal bug: no copies created inside the tb for at least one of the instantiated duts");
      expectOutputs = itr2->second;

      adaptDutOutputsExpectOutputsCompare(unitDecl->getLineNumber(), 
                                          clockName, 
                                          resetName,
                                          validName ,
                                          dutInstanceName,
                                          expectVectInstanceName,
                                          dutOutputs,
                                          expectOutputs,
                                          
                                           
                                          mismatchCountName,
                                          FALSE,
                                          transactionCountName,
                                          addrWidthParamName,
                                          maxErrParamName
                                          );

      adaptDutOutputsExpectOutputsCompare(unitDecl->getLineNumber(), 
                                          clockName, 
                                          resetName,
                                          validName ,
                                          dutInstanceName,
                                          expectVectInstanceName,
                                          dutOutputs,
                                          expectOutputs,
                                          
                                          matchCountName, 
                                          TRUE,
                                          transactionCountName,
                                          addrWidthParamName
                                          
                                          );
    }
  }
}

void CAdapterToCDOM:: adaptTestbenchParameters(TLineNumberType lineNumber, RefCSLOmUnitDecl cslVector) {
  RefCSLOmVectorInfo cslVectorInfo = CSLOmVectorInfo::cast(cslVector->getUnitInfo());

  //parameter MEM_WIDTH     
  RefString memWidthParamName = refStrToUpper(cslVector->getName());
  memWidthParamName->append("_MEM_WIDTH");

  TInt memWidthParamValue = 3;
  RefTVec_RefCSLOmExprLink linksToAssocPorts = cslVectorInfo->getAssociatedPorts();
  for(TVec_RefCSLOmExprLink_const_iter iter = linksToAssocPorts->begin(); iter < linksToAssocPorts->end(); ++iter) {
    RefCSLOmPortDecl port = CSLOmPortDecl::cast((*iter)->getLocalNameID()->getParent());
    RefCSLOmExpr width = port->getWidth();
    if(width->getExprType() == CSLOmExpr::EXPR_NUMBER) {
      memWidthParamValue += (CSLOmNum32::cast(width))->getValue();
    }
    else {
      RefCSLOmExpr upper = CSLOmSimpleBitRange::cast(port->getBitRange())->getUpper();
      //to be implemented pending eval support in cslom
    }
  }

  RefCDOmParamDecl memWidth = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  memWidth->addParam(lineNumber, 
                     memWidthParamName, 
                     buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, memWidthParamValue))
                     );

  //parameter ADDR_WIDTH
  RefString addrWidthParamName = refStrToUpper(cslVector->getName());
  addrWidthParamName->append("_ADDR_WIDTH");

  TInt addrWidthParamValue = 16;//log(memDepth)/log(2);memDepth = ?

  RefCDOmParamDecl addrWidth = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  addrWidth->addParam(lineNumber, 
                      addrWidthParamName, 
                      buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, addrWidthParamValue))
                      );

  //parameter VECTOR_ID
  RefString vectorIdParamName = refStrToUpper(cslVector->getName());
  vectorIdParamName->append("_VECTOR_ID");

  TInt vectorIdParamValue = CSLOmNum32::cast(cslVectorInfo->getNumericID())->getValue();

  RefCDOmParamDecl vectorId = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  vectorId->addParam(lineNumber, 
                     vectorIdParamName, 
                     buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, vectorIdParamValue))
                     );

  //parameter VECTOR_VERSION
  RefString vectorVerParamName = refStrToUpper(cslVector->getName());
  vectorVerParamName->append("_VECTOR_VERSION");

  TInt vectorVerParamValue = CSLOmNum32::cast(cslVectorInfo->getVersion())->getValue();

  RefCDOmParamDecl vectorVer = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  vectorVer->addParam(lineNumber, 
                      vectorVerParamName, 
                      buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, vectorVerParamValue))
                      );

  //parameter VECTOR_NAME
  RefString vectorNameParamName = refStrToUpper(cslVector->getName());
  vectorNameParamName->append("_VECTOR_NAME");
  
  RefString vectorNameParamValue = RefString(new string(*(cslVectorInfo->getName())));
  //vectorNameParamValue->append(*(cslVectorInfo->getName()));
  //vectorNameParamValue->append("\"");
  
  RefCDOmParamDecl vectorName = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  vectorName->addParam(lineNumber, 
                       vectorNameParamName, 
                       buildCDOmMinTypMax(lineNumber, buildCDOmString(lineNumber,vectorNameParamValue))
                       );

  //parameter VECTOR_FILE
  RefString vectorFileParamName = refStrToUpper(cslVector->getName());
  vectorFileParamName->append("_VECTOR_FILE");


  RefString vectorFileParamValue = RefString(new string(*(cslVectorInfo->getOutputFilename())));
  RefCDOmParamDecl vectorFile = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  vectorFile->addParam(lineNumber, 
                       vectorFileParamName, 
                       buildCDOmMinTypMax(lineNumber, buildCDOmString(lineNumber,vectorFileParamValue))
                       );
        
  //parameter VECTOR_RADIX
  RefString vectorRadixParamName = refStrToUpper(cslVector->getName());
  vectorRadixParamName->append("_VECTOR_RADIX");

  TInt vectorRadixParamValue = 0;
  CSLOmVerifCompInfo::ECSLOmVCRadix rad = cslVectorInfo->getRadix();
  if(rad == CSLOmVerifCompInfo::VC_RADIX_HEX) {
    vectorRadixParamValue = 1;
  }
  //switch(rad) {
  //  case CSLOmVerifCompInfo::VC_RADIX_BIN:
  //    vectorRadixParamValue = 0;
  //    break;
  //  case CSLOmVerifCompInfo::VC_RADIX_HEX:
  //    vectorRadixParamValue = 1;
  //    break;
  //  default:
  //    ASSERT(false, "AdaptTestbenchModule():Invalid vactor radix");
  //}
        
  RefCDOmParamDecl vectorRadix = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  vectorRadix->addParam(lineNumber, 
                        vectorRadixParamName, 
                        buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, vectorRadixParamValue))
                        );

  //parameter VECTOR_MAX_ERR
  RefString vectorMaxErrParamName = refStrToUpper(cslVector->getName());
  vectorMaxErrParamName->append("_VECTOR_MAX_ERR");

  TInt vectorMaxErrParamValue = CSLOmNum32::cast(cslVectorInfo->getMaxMismatchesCount())->getValue();

  RefCDOmParamDecl vectorMaxErr = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  vectorMaxErr->addParam(lineNumber, 
                         vectorMaxErrParamName, 
                         buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, vectorMaxErrParamValue))
                         );

}

 RefCDOmModuleOrUdpInstance CAdapterToCDOM::adaptTestbenchParameterConnections(TLineNumberType lineNumber, 
                                                                               RefCDOmModuleOrUdpInstance dutInstance, 
                                                                               RefCSLOmUnitDecl vector
                                                                               ) {

  //instance name
  RefString stimVectInstanceName = RefString(new string(*(vector->getName())));//vector name
  stimVectInstanceName->append("_");
  stimVectInstanceName->append(*((CDOmIdentifier::cast(dutInstance->getChild(0)))->getName()));//instance name

  //buid the moduleInstantiation node
  RefCDOmModuleOrUdpInstantiation vectInstantiation = buildCDOmModuleOrUdpInstantiation(lineNumber,
                                                                                        m_cdomCurrParent,
                                                                                        buildCDOmExprLink(lineNumber,
                                                                                                          m_vectorModuleName
                                                                                                          )
                                                                                        );

  //module parameters assignments
  RefString stimMemWidthName = refStrToUpper(vector->getName());
  stimMemWidthName->append("_MEM_WIDTH");
  vectInstantiation->addNamedParamAssn(RefString(new string("MEM_WIDTH")),
                                       buildCDOmMinTypMax(lineNumber, 
                                                          buildCDOmExprLink(lineNumber, stimMemWidthName)
                                                          )
                                       );

  RefString stimAddrWidthName = refStrToUpper(vector->getName());
  stimAddrWidthName->append("_ADDR_WIDTH");
  vectInstantiation->addNamedParamAssn(RefString(new string("ADDR_WIDTH")),
                                       buildCDOmMinTypMax(lineNumber, 
                                                          buildCDOmExprLink(lineNumber, stimAddrWidthName)
                                                          )
                                       );

  RefString stimVectIdName = refStrToUpper(vector->getName());
  stimVectIdName->append("_VECTOR_ID");
  vectInstantiation->addNamedParamAssn(RefString(new string("VECTOR_ID")),
                                       buildCDOmMinTypMax(lineNumber, 
                                                          buildCDOmExprLink(lineNumber, stimVectIdName)
                                                          )
                                       );

  RefString stimVectVerName = refStrToUpper(vector->getName());
  stimVectVerName->append("_VECTOR_VERSION");
  vectInstantiation->addNamedParamAssn(RefString(new string("VECTOR_VERSION")),
                                       buildCDOmMinTypMax(lineNumber, 
                                                          buildCDOmExprLink(lineNumber, stimVectVerName)
                                                          )
                                       );

  RefString stimVectNameName = refStrToUpper(vector->getName());
  stimVectNameName->append("_VECTOR_NAME");
  vectInstantiation->addNamedParamAssn(RefString(new string("VECTOR_NAME")),
                                       buildCDOmMinTypMax(lineNumber, 
                                                          buildCDOmExprLink(lineNumber, stimVectNameName)
                                                          )
                                       );

  RefString stimVectFileName = refStrToUpper(vector->getName());
  stimVectFileName->append("_VECTOR_FILE");
  vectInstantiation->addNamedParamAssn(RefString(new string("VECTOR_FILE")),
                                       buildCDOmMinTypMax(lineNumber, 
                                                          buildCDOmExprLink(lineNumber, stimVectFileName)
                                                          )
                                       );

  RefString stimVectRadixName = refStrToUpper(vector->getName());
  stimVectRadixName->append("_VECTOR_RADIX");
  vectInstantiation->addNamedParamAssn(RefString(new string("VECTOR_RADIX")),
                                       buildCDOmMinTypMax(lineNumber, 
                                                          buildCDOmExprLink(lineNumber, stimVectRadixName)
                                                          )
                                       );

  RefCDOmModuleOrUdpInstance stimVectInstance = vectInstantiation->buildModuleInstance(lineNumber, stimVectInstanceName);
  return stimVectInstance;
}

RefCDOmModuleDecl     CAdapterToCDOM::                     retrieveModuleFromInstance(RefCDOmModuleOrUdpInstance instance) {
  RefCDOmModuleOrUdpInstantiation instantiation = CDOmModuleOrUdpInstantiation::cast(instance->getParent());
  RefCDOmExprLink linkToDutModule = instantiation->getModuleExprLink();
  RefCDOmScope currentScope = m_product->getAttachedScope();
  RefCDOmIdentifier typeId = currentScope->lookupLocal(linkToDutModule->getName());
  RefCDOmModuleDecl module = CDOmModuleDecl::cast(typeId->getParent());
  return module;
}

void     CAdapterToCDOM::                     adaptDutOutputsExpectOutputsCompare  ( TInt lineNumber,
                                                                                     RefString clockName,
                                                                                     RefString resetName,
                                                                                     RefString validName,
                                                                                     RefString dutName,
                                                                                     RefString expectName,
                                                                                     RefTVec_RefString dutOuts,
                                                                                     RefTVec_RefString expectOuts,
                                                                                     
                                                                                     
                                                                                     RefString countName,
                                                                                     TBool matchOrMismatch,
                                                                                     RefString transactionCountName,
                                                                                     RefString addrWidthParamName,
                                                                                     RefString maxErrParamName
                                                                                     ) {

  RefCDOmStmtBlock resetElseStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

  TVec_RefString::const_iterator dutOutsIt;
  TVec_RefString::const_iterator expectOutsIt;
  for(dutOutsIt = dutOuts->begin(), expectOutsIt = expectOuts->begin();
      dutOutsIt < dutOuts->end() && expectOutsIt < expectOuts->end();
      ++dutOutsIt, ++expectOutsIt) {

    RefString enWireName = RefString(new string(**dutOutsIt));
    if(!matchOrMismatch) {
      enWireName->append("_mismatch_en");
    }
    else {
      enWireName->append("_match_en");
    }

    RefCDOmNetDecl enWire = buildCDOmNetDecl(lineNumber,
                                             m_cdomCurrParent,
                                             NET_WIRE,
                                             RefCDOmRange()
                                             );

    RefCDOmExpr enWireExpr; 
    if(!matchOrMismatch) {
      enWireExpr = buildCDOmExprOp(lineNumber, 
                                   CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ,
                                   buildCDOmExprLink(lineNumber, *dutOutsIt),
                                   buildCDOmExprLink(lineNumber, *expectOutsIt)
                                   );
    }
    else {
      enWireExpr = buildCDOmExprOp(lineNumber, 
                                   CDOmExprOp::OP_BINARY_EQUALITY_EQ,
                                   buildCDOmExprLink(lineNumber, *dutOutsIt),
                                   buildCDOmExprLink(lineNumber, *expectOutsIt)
                                   );
    }

    enWire->addNet(lineNumber, enWireName, enWireExpr);

    RefCDOmStmtBlock displayStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    
    RefCDOmNum32 transCountOne = buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")));
    transCountOne->setIsVeriNumFlag(TRUE);
    RefCDOmStmtAssn transCountIncr = buildCDOmStmtAssnSimple(lineNumber, 
                                                             CDOmStmtAssn::ASSN_BLOCKING,
                                                             buildCDOmExprLink(lineNumber, transactionCountName),
                                                             buildCDOmExprOp(lineNumber,
                                                                             CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
                                                                             buildCDOmExprLink(lineNumber, transactionCountName),
                                                                             transCountOne
                                                                             )
                                                             );
    displayStmtBlock->addStmt(transCountIncr);

    RefCDOmNum32 mismatchCountOne = buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")));
    mismatchCountOne->setIsVeriNumFlag(TRUE);
    RefCDOmStmtAssn mismatchCountIncr = buildCDOmStmtAssnSimple(lineNumber, 
                                                             CDOmStmtAssn::ASSN_BLOCKING,
                                                             buildCDOmExprLink(lineNumber, countName),
                                                             buildCDOmExprOp(lineNumber,
                                                                             CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
                                                                             buildCDOmExprLink(lineNumber, countName),
                                                                             mismatchCountOne
                                                                             )
                                                             );
    displayStmtBlock->addStmt(mismatchCountIncr);

    RefCDOmStmtTaskEnable displayStmt = buildCDOmStmtTaskEnable(lineNumber, 
                                                                CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                                buildCDOmExprLink(lineNumber, RefString(new string("$display")))
                                                                );
    RefString matchOrMismatchString;
    if(!matchOrMismatch) {
      matchOrMismatchString = RefString(new string("mismatch"));
    }
    else {
      matchOrMismatchString = RefString(new string("match"));
    }
    matchOrMismatchString->append(" detected: dut %s shows value %b; evepect vector %s shows value %b\\n ");

    displayStmt->addExpr(buildCDOmString(lineNumber, matchOrMismatchString));
    displayStmt->addExpr(buildCDOmString(lineNumber, dutName));
    displayStmt->addExpr(buildCDOmExprLink(lineNumber, *dutOutsIt));
    displayStmt->addExpr(buildCDOmString(lineNumber, expectName));
    displayStmt->addExpr(buildCDOmExprLink(lineNumber, *expectOutsIt));
    displayStmtBlock->addStmt(displayStmt);

    RefCDOmStmtIf displayIf = buildCDOmStmtIf(lineNumber,
                                              buildCDOmExprLink(lineNumber, enWireName),
                                              displayStmtBlock,
                                              RefCDOmStmt());
    resetElseStmtBlock->addStmt(displayIf);

    
  }

  RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

  RefCDOmStmtBlock initMismatchCountStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //RefCDOmExprConcat mismatchCountConcat = buildCDOmExprConcat(lineNumber, 
  //                                                            buildCDOmExprLink(lineNumber, addrWidthParamName)
  //
  //                                                            );

  RefCDOmNum32 mismatchCountNumber = buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0")));
  mismatchCountNumber->setIsVeriNumFlag(TRUE);

  RefCDOmExprConcat mismatchCountNumberConcat = buildCDOmExprConcat(lineNumber, mismatchCountNumber);                                                                    
  //mismatchCountConcat->addExpr(mismatchCountNumberConcat);
  RefCDOmExprMultiConcat mismatchCountConcat = buildCDOmExprMultiConcat(lineNumber, buildCDOmExprLink(lineNumber, addrWidthParamName), mismatchCountNumberConcat);
  RefCDOmStmtAssn mismatchCountInit = buildCDOmStmtAssnSimple(lineNumber, 
                                                              CDOmStmtAssn::ASSN_BLOCKING, 
                                                              buildCDOmExprLink(lineNumber, countName),
                                                              mismatchCountConcat);
  initMismatchCountStmtBlock->addStmt(mismatchCountInit);

  if(maxErrParamName.get()) {
    RefCDOmStmtBlock transCountCheckDisplayBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    RefCDOmStmtTaskEnable disStmt = buildCDOmStmtTaskEnable(lineNumber, 
                                                            CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                            buildCDOmExprLink(lineNumber, RefString(new string("$display")))
                                                            );
    disStmt->addExpr(buildCDOmString(lineNumber, RefString(new string("Maximum number or errors allowed for vector %s has been reached"))));
    disStmt->addExpr(buildCDOmString(lineNumber, expectName));
    transCountCheckDisplayBlock->addStmt(disStmt);
    RefCDOmStmtIf transCountCheckStmt = buildCDOmStmtIf(lineNumber, 
                                                        buildCDOmExprOp(lineNumber,
                                                                        CDOmExprOp::OP_BINARY_RELATIONAL_GREATER,
                                                                        buildCDOmExprLink(lineNumber, countName),
                                                                        buildCDOmExprLink(lineNumber, maxErrParamName)
                                                                        ),
                                                        transCountCheckDisplayBlock,
                                                        RefCDOmStmt()
                                                        );
    resetElseStmtBlock->addStmt(transCountCheckStmt);
  }
  
  RefCDOmStmtIf resetIf = buildCDOmStmtIf(lineNumber, 
                                          buildCDOmExprOp(lineNumber,
                                                          CDOmExprOp::OP_UNARY_BITWISE_NOT,
                                                          buildCDOmExprLink(lineNumber, resetName)
                                                          ),
                                          initMismatchCountStmtBlock,
                                          resetElseStmtBlock
                                          );
  stmtBlock->addStmt(resetIf);

  RefCDOmEventExpr evExpr = buildCDOmEventExprDouble(lineNumber, 
                                                     CDOmEventExpr::EVENT_EXPR_OR,
                                                     buildCDOmEventExprSimple(lineNumber, CDOmEventExpr::EVENT_EXPR_POSEDGE, buildCDOmExprLink(lineNumber, clockName)),
                                                     buildCDOmEventExprSimple(lineNumber, CDOmEventExpr::EVENT_EXPR_NEGEDGE, buildCDOmExprLink(lineNumber, resetName))
                                                     );
  RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);
  RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock);
  RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc );

  //RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //
  //RefCDOmStmtAssn mismatchAssn = buildCDOmStmtAssnSimple(lineNumber, 
  //                                                       CDOmStmtAssn::ASSN_NON_BLOCKING, 
  //                                                       buildCDOmExprLink(lineNumber, mismatchName),
  //                                                       buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0")))
  //                                                       );
  //stmtBlock->addStmt(mismatchAssn);
  //
  //RefCDOmStmtBlock mainIfStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //
  //RefCDOmStmtAssn transCntAssn = buildCDOmStmtAssnSimple(lineNumber, 
  //                                                       CDOmStmtAssn::ASSN_BLOCKING, 
  //                                                       buildCDOmExprLink(lineNumber, transactionCountName),
  //                                                       buildCDOmExprOp(lineNumber,
  //                                                                       CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
  //                                                                       buildCDOmExprLink(lineNumber, transactionCountName),
  //                                                                       buildCDOmNum32WithString(lineNumber,
  //                                                                                                CDOmNum32::NUM_BASE_BIN,
  //                                                                                                RefString(new string("1"))
  //                                                                                                )
  //                                                                       )
  //                                                       );
  //mainIfStmtBlock->addStmt(transCntAssn);
  //
  //TVec_RefString_const_iter it1;
  //TVec_RefString_const_iter it2;
  //for( it1 = dutOuts->begin(), it2 = expectOuts->begin(); 
  //     it1 < dutOuts->end() && it2 < expectOuts->end(); 
  //     ++it1, ++it2) {
  //  
  //  RefCDOmStmtBlock innerIfStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //  RefCDOmStmtAssn innerAssn = buildCDOmStmtAssnSimple(lineNumber, 
  //                                                      CDOmStmtAssn::ASSN_BLOCKING, 
  //                                                      buildCDOmExprLink(lineNumber, mismatchName),
  //                                                      buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")))
  //                                                      );
  //  innerIfStmtBlock->addStmt(innerAssn);
  //
  //  RefCDOmStmtTaskEnable innerDisplay = buildCDOmStmtTaskEnable(lineNumber, 
  //                                                               CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
  //                                                               buildCDOmExprLink(lineNumber, RefString(new string("$display")))
  //                                                               );
  //  innerDisplay->addExpr(buildCDOmString(lineNumber, 
  //                                          RefString(new string("Mismatch detected: expect vector %s shows value %b, design under test %s output vector shows value %b"))
  //                                          )
  //                        );
  //  innerDisplay->addExpr(buildCDOmString(lineNumber, expectName));
  //
  //  innerDisplay->addExpr(buildCDOmExprLink(lineNumber, *it2));
  //
  //  innerDisplay->addExpr(buildCDOmString(lineNumber, dutName));
  //
  //  innerDisplay->addExpr(buildCDOmExprLink(lineNumber, *it1));
  //
  //  innerIfStmtBlock->addStmt(innerDisplay);
  //
  //  RefCDOmStmtIf innerIf = buildCDOmStmtIf(lineNumber,
  //                                          buildCDOmExprOp(lineNumber,
  //                                                          CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ,
  //                                                          buildCDOmExprLink(lineNumber, *it1),
  //                                                          buildCDOmExprLink(lineNumber, *it2)
  //                                                          ),
  //                                          innerIfStmtBlock,
  //                                          RefCDOmStmt()
  //                                          );
  //  mainIfStmtBlock->addStmt(innerIf);
  //  
  //}
  //
  //RefCDOmStmtIf mainIf = buildCDOmStmtIf(lineNumber, 
  //                                       buildCDOmExprLink(lineNumber, validName),
  //                                       mainIfStmtBlock,
  //                                       RefCDOmStmt()
  //                                       );
  //stmtBlock->addStmt(mainIf);
  //
  //RefCDOmStmtBlock secondaryIfStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //RefCDOmStmtAssn secondaryIfAssn = buildCDOmStmtAssnSimple(lineNumber,
  //                                                          CDOmStmtAssn::ASSN_NON_BLOCKING,
  //                                                          buildCDOmExprLink(lineNumber, mismatchCountName),
  //                                                          buildCDOmExprOp(lineNumber,
  //                                                                          CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
  //                                                                          buildCDOmExprLink(lineNumber, mismatchCountName),
  //                                                                          buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")))
  //                                                                          )
  //                                                          );
  //secondaryIfStmtBlock->addStmt(secondaryIfAssn);
  //
  //RefCDOmStmtBlock secondaryElseStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //RefCDOmStmtAssn secondaryElseAssn = buildCDOmStmtAssnSimple(lineNumber,
  //                                                            CDOmStmtAssn::ASSN_NON_BLOCKING,
  //                                                            buildCDOmExprLink(lineNumber, matchCountName),
  //                                                            buildCDOmExprOp(lineNumber,
  //                                                                            CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
  //                                                                            buildCDOmExprLink(lineNumber, matchCountName),
  //                                                                            buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")))
  //                                                                            )
  //                                                            );
  //
  //secondaryElseStmtBlock->addStmt(secondaryElseAssn);
  //
  //RefCDOmStmtIf secondaryIf = buildCDOmStmtIf(lineNumber,
  //                                            buildCDOmExprLink(lineNumber, mismatchName),
  //                                            secondaryIfStmtBlock,
  //                                            secondaryElseStmtBlock
  //                                            );
  //stmtBlock->addStmt(secondaryIf);
  //
  //RefCDOmStmtBlock ternaryStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //RefCDOmStmtTaskEnable ternaryDisplay = buildCDOmStmtTaskEnable(lineNumber, 
  //                                                               CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
  //                                                               buildCDOmExprLink(lineNumber, RefString(new string("$display")))
  //                                                               );
  //ternaryDisplay->addExpr(buildCDOmString(lineNumber, 
  //                                          RefString(new string("current transaction index = %d, mismatches so far = %d, current test status = %s"))
  //                                          )
  //                        );
  //ternaryDisplay->addExpr(buildCDOmExprLink(lineNumber, transactionCountName));
  //ternaryDisplay->addExpr(buildCDOmExprLink(lineNumber, mismatchCountName));
  //RefString ternary = RefString(new string(""));
  //ternary->append(*mismatchName);
  //ternary->append("?\"failed\":\"passed\"");
  //ternaryDisplay->addExpr(buildCDOmExprLink(lineNumber,ternary));
  //ternaryStmtBlock->addStmt(ternaryDisplay);
  //
  //RefCDOmStmtTaskEnable ternaryFinish = buildCDOmStmtTaskEnable(lineNumber, 
  //                                                              CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
  //                                                              buildCDOmExprLink(lineNumber, RefString(new string("$finish")))
  //                                                              );
  //ternaryStmtBlock->addStmt(ternaryFinish);
  //
  //RefCDOmStmtIf ternaryIf = buildCDOmStmtIf(lineNumber, 
  //                                          buildCDOmExprOp(lineNumber,
  //                                                          CDOmExprOp::OP_BINARY_RELATIONAL_GREATER,
  //                                                          buildCDOmExprLink(lineNumber, mismatchCountName),
  //                                                          buildCDOmExprLink(lineNumber, maxErrParamName)
  //                                                          ),
  //                                          ternaryStmtBlock,
  //                                          RefCDOmStmt()
  //                                          );
  //stmtBlock->addStmt(ternaryIf);
  //
  //RefCDOmEventExpr evExpr = buildCDOmEventExprSimple(lineNumber, CDOmEventExpr::EVENT_EXPR_POSEDGE, buildCDOmExprLink(lineNumber, clockName));
  //RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);
  //RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock);
  //RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc );
  
}

RefTVec_RefCDOmStmt CAdapterToCDOM::generatePieceWiseLinearWaveForms(TInt lineNumber, RefString signalName, TInt initValue, map<TInt,TInt> waves) {
  
  //ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DECL_MODULE, "Cdom curren parent for PWLWF init block is of illegal type");

  RefTVec_RefCDOmStmt stmtVect = RefTVec_RefCDOmStmt(new TVec_RefCDOmStmt());

  stringstream ss;
  ss << initValue;
  RefCDOmStmtAssn initAssn = buildCDOmStmtAssnSimple(lineNumber, 
                                                     CDOmStmtAssn::ASSN_BLOCKING, 
                                                     buildCDOmExprLink(lineNumber, signalName),
                                                     buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string(ss.str())))
                                                     );
  stmtVect->push_back(initAssn);

  if(!waves.empty()) {
    for(map<TInt, TInt>::const_iterator it = waves.begin(); it != waves.end(); ++it) {
      ss.str("");
      ss << (*it).second;
      RefCDOmStmtProcTimingControl ptc = 
        buildCDOmStmtProcTimingControlWithDelayControl (lineNumber, 
                                                        buildCDOmDelayControl (lineNumber, buildCDOmNum32WithValue(lineNumber, (*it).first)),
                                                        buildCDOmStmtAssnSimple(lineNumber, 
                                                                                CDOmStmtAssn::ASSN_BLOCKING,
                                                                                buildCDOmExprLink(lineNumber, signalName), 
                                                                                buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string(ss.str())))
                                                                                )
                                                        );
      stmtVect->push_back(ptc);
    }
  }
  return stmtVect;
  //RefCDOmInitOrAlways initBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_INIT, stmtBlock);
}

RefTVec_RefCDOmStmt CAdapterToCDOM::generateFsdbOrVsd(TLineNumberType lineNumber, 
                                                      RefString tbName, 
                                                      RefString outputFileName, 
                                                      CSLOmTBInfo::ETBWaveType waveType, 
                                                      RefCDOmExprLink scope) {

  RefTVec_RefCDOmStmt stmtVec = RefTVec_RefCDOmStmt(new TVec_RefCDOmStmt());

  RefString taskName = RefString(new string("$"));
  //switch(waveType) {
  //  case CSLOmTBInfo::TB_WAVE_FSDB : 
  //    taskName->append("fsdb");
  //  case CSLOmTBInfo::TB_WAVE_VSD:
  //    taskName->append("vsd");
  //}
  taskName->append("dump");

  RefString taskFile = RefString(new string(*taskName));
  taskFile->append("file");
  RefCDOmStmtTaskEnable stmt1 = buildCDOmStmtTaskEnable(lineNumber, 
                                                        CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                        buildCDOmExprLink(lineNumber, taskFile)
                                                        );
  RefString fileNameWithExtension = RefString(new string(""));
  fileNameWithExtension->append(*outputFileName);
  fileNameWithExtension->append("_dump");
  stmt1->addExpr(buildCDOmString(lineNumber, fileNameWithExtension));
  stmtVec->push_back(stmt1);

  RefString taskVars = RefString(new string(*taskName));
  taskVars->append("vars");
  RefCDOmStmtTaskEnable stmt2 = buildCDOmStmtTaskEnable(lineNumber, 
                                                        CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                        buildCDOmExprLink(lineNumber, taskVars)
                                                        );
  stmt2->addExpr(buildCDOmNum32WithValue(lineNumber, 0));
  stmt2->addExpr(buildCDOmExprLink(lineNumber, tbName));
  stmtVec->push_back(stmt2);

  RefString taskOn = RefString(new string(*taskName));
  taskOn->append("on");
  RefCDOmStmtTaskEnable stmt3 = buildCDOmStmtTaskEnable(lineNumber, 
                                                        CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                        buildCDOmExprLink(lineNumber, taskOn)
                                                        );
  stmtVec->push_back(stmt3);

  
  return stmtVec;
}

void CAdapterToCDOM::generateInitialVectorMemDisplay(TLineNumberType lineNumber,
                                                     RefString memLoadedName, 
                                                     RefString memName, 
                                                     RefString vectorParamName,
                                                     RefString memDepthName,
                                                     RefString memAddrIterName) {

  RefCDOmStmtBlock firstStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

  RefCDOmStmtAssn assn1 = buildCDOmStmtAssnSimple(lineNumber, 
                                                  CDOmStmtAssn::ASSN_NON_BLOCKING, 
                                                  buildCDOmExprLink(lineNumber, memLoadedName),
                                                  buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0")))
                                                  );
  firstStmtBlock->addStmt(assn1);

  RefCDOmStmtTaskEnable stmt2 = buildCDOmStmtTaskEnable(lineNumber, 
                                                        CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                        buildCDOmExprLink(lineNumber, RefString(new string("$display")))
                                                        );
  RefString message = RefString(new string(""));
  message->append(*vectorParamName);
  message->append("= %s");
  stmt2->addExpr(buildCDOmString(lineNumber, message));
  stmt2->addExpr(buildCDOmExprLink(lineNumber, vectorParamName));
  firstStmtBlock->addStmt(stmt2);

  RefCDOmStmtBlock ifBranchStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  RefCDOmStmtTaskEnable stmt3 = buildCDOmStmtTaskEnable(lineNumber, 
                                                        CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                        buildCDOmExprLink(lineNumber, RefString(new string("$readmemb")))
                                                        );
  stmt3->addExpr(buildCDOmExprLink(lineNumber, vectorParamName));
  stmt3->addExpr(buildCDOmExprLink(lineNumber, memName));
  ifBranchStmtBlock->addStmt(stmt3);

  RefCDOmStmtBlock elseBranchStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  RefCDOmStmtTaskEnable stmtReadB = buildCDOmStmtTaskEnable(lineNumber, 
                                                            CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                            buildCDOmExprLink(lineNumber, RefString(new string("$readmemh")))
                                                            );
  stmtReadB->addExpr(buildCDOmExprLink(lineNumber, vectorParamName));
  stmtReadB->addExpr(buildCDOmExprLink(lineNumber, memName));
  elseBranchStmtBlock->addStmt(stmtReadB);

  RefCDOmExprLink radixExpr = buildCDOmExprLink(lineNumber, RefString(new std::string("VECTOR_RADIX")));
  RefCDOmNum32 num32 = buildCDOmNum32WithValue(lineNumber, 0);
  
  RefCDOmExprOp ifExpr = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_EQUALITY_EQ, radixExpr, num32);
  
  RefCDOmStmtIf readIf = buildCDOmStmtIf(lineNumber, 
                                         ifExpr,
                                         ifBranchStmtBlock,
                                         elseBranchStmtBlock
                                         );
  firstStmtBlock->addStmt(readIf);

  RefCDOmStmtAssn assn4 = buildCDOmStmtAssnSimple(lineNumber, 
                                                  CDOmStmtAssn::ASSN_NON_BLOCKING, 
                                                  buildCDOmExprLink(lineNumber, memLoadedName),
                                                  buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")))
                                                  );
  firstStmtBlock->addStmt(assn4);

  RefCDOmInitOrAlways firstInit = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_INIT, firstStmtBlock);

  RefCDOmStmtBlock secondStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

  RefCDOmEventControl evCtrl = buildCDOmEventControlWithHid(lineNumber, buildCDOmExprLink(lineNumber, memLoadedName));
  RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, buildCDOmStmtNull(lineNumber));
  secondStmtBlock->addStmt(ptc);

  //RefCDOmStmtTaskEnable ifTaskEn = buildCDOmStmtTaskEnable(lineNumber,
  //                                                         CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
  //                                                         buildCDOmExprLink(lineNumber, RefString(new string("$test$plusargs")))      
  //                                                         );
  //if(!cmdLineArg) {
  //  ifTaskEn->addExpr(buildCDOmString(lineNumber, RefString(new string("\"show_stim_mem_init_state\""))));
  //}
  //else {
  //  ifTaskEn->addExpr(buildCDOmExprLink(lineNumber, RefString(new string("\"show_expect_mem_init_state\""))));
  //}
  RefCDOmExprLink ifTaskEn;
  //if(!cmdLineArg) {
  //  ifTaskEn = buildCDOmExprLink(lineNumber, RefString(new string("$test$plusargs(\"show_stim_mem_init_state\")")));
  //}
  //else {
  //  ifTaskEn = buildCDOmExprLink(lineNumber, RefString(new string("$test$plusargs(\"show_expect_mem_init_state\")")));
  //}

  ifTaskEn = buildCDOmExprLink(lineNumber, RefString(new string("$test$plusargs(\"show_stim_expect_memory_init_state\")")));

  RefCDOmStmtBlock mainIfStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

  RefCDOmStmtTaskEnable display = buildCDOmStmtTaskEnable(lineNumber, 
                                                          CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, 
                                                          buildCDOmExprLink(lineNumber, RefString(new string("$display")))
                                                          );

  display->addExpr(buildCDOmString(lineNumber, RefString(new string("Initial state of vector file %s "))));
  display->addExpr(buildCDOmExprLink(lineNumber, vectorParamName));
  mainIfStmtBlock->addStmt(display);

  RefCDOmStmtBlock forStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

  RefCDOmStmtTaskEnable forDisplay = buildCDOmStmtTaskEnable(lineNumber, 
                                                             CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM,
                                                             buildCDOmExprLink(lineNumber, RefString(new string("$display")))
                                                             );
  forDisplay->addExpr(buildCDOmString(lineNumber, RefString(new string("mem[%d] = %x"))));
  forDisplay->addExpr(buildCDOmExprLink(lineNumber, memAddrIterName));
  RefCDOmExprLink eLink = buildCDOmExprLink(lineNumber, memName );
  eLink->setArrayIndexes(buildCDOmListExpr(lineNumber, buildCDOmExprLink(lineNumber, memAddrIterName)));
  forDisplay->addExpr(eLink);
  forStmtBlock->addStmt(forDisplay);

  RefCDOmStmtLoop  forStmt = buildCDOmStmtLoopFor(lineNumber, 
                                                  buildCDOmAssn(lineNumber, buildCDOmExprLink(lineNumber, memAddrIterName), buildCDOmNum32WithValue(lineNumber, 0)),
                                                  buildCDOmExprOp(lineNumber,
                                                                  CDOmExprOp::OP_BINARY_RELATIONAL_LESS,
                                                                  buildCDOmExprLink(lineNumber, memAddrIterName),
                                                                  buildCDOmExprLink(lineNumber, memDepthName)
                                                                  ),
                                                  buildCDOmAssn(lineNumber, 
                                                                buildCDOmExprLink(lineNumber, memAddrIterName),
                                                                buildCDOmExprOp(lineNumber,
                                                                                CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
                                                                                buildCDOmExprLink(lineNumber, memAddrIterName),
                                                                                buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")))
                                                                                )
                                                                ),
                                                  forStmtBlock
                                                  );
  mainIfStmtBlock->addStmt(forStmt);

  RefCDOmStmtIf mainIf = buildCDOmStmtIf(lineNumber, 
                                         ifTaskEn,
                                         mainIfStmtBlock,
                                         RefCDOmStmt()
                                         );
  secondStmtBlock->addStmt(mainIf);

  RefCDOmInitOrAlways secondInit = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_INIT, secondStmtBlock);  
}

void CAdapterToCDOM::adaptDecoder(const NSCSLOm::RefCSLOmSignal &signal) {
  
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DECL_MODULE, "Cannot generate a decoder from a signal whose parent is not a module");

  double outputWidth;
  double val;
    
  RefCSLOmBaseRange br = signal->getBitRange();
  ASSERT(br->isField(), "Cannot generate a decoder for a signal with no field");
  RefCSLOmField field = CSLOmField::cast(br);
  
  if((field->getWidth()).get()) { 
    RefCSLOmExpr width = field->getWidth();
    val = static_cast<double>(CSLOmNumber::cast(width->doEval())->getValue());
    outputWidth = pow(2, val);
  }
  else {
    outputWidth = 2; //pow(2,1)
  }
  
  if(field->getFieldType() == CSLOmField::FIELD_ENUM) {
    RefCSLOmEnum fieldEnum = CSLOmEnum::cast(field->getEnum());
    RefTVec_RefCSLOmBase fieldEnumChildren = fieldEnum->getChildrenAsBase();
    RefCSLOmIdentifier lastEnumIt = CSLOmIdentifier::cast(fieldEnumChildren->back());
    ASSERT(outputWidth >= CSLOmNum32::cast(lastEnumIt->getPayload())->getValue(), "adaptDecoder: Field's width is insufficient");

    //Check if enum is sequential
    TInt currPayload, prevPayload = -1;
    TBool isSequentialEnum = TRUE;
    for(TVec_RefCSLOmBase_const_iter iter = fieldEnumChildren->begin(); iter < fieldEnumChildren->end(); ++iter) {
      if(iter == fieldEnumChildren->begin()) {
        continue;
      }
      currPayload = CSLOmNum32::cast((CSLOmIdentifier::cast(*iter))->getPayload())->getValue();
      if(currPayload == prevPayload + 1) {
       prevPayload = currPayload;
      }
      else {
        isSequentialEnum = FALSE;
        break;
      }
    }
    
    if(!isSequentialEnum) {
      adaptDecoderForRandomEnum(signal);
    }
    else {//isSequentialEnum = true
      adaptDecoderForSeqEnum(signal, outputWidth);
    }
    

  }
  else { //no enum set
    adaptDecoderForNoEnum(signal, outputWidth);
  }
 //else if(field->getType() == CSLOmField::FIELD_ENUM_ITEM) 
}

void CAdapterToCDOM::adaptDecoderForRandomEnum(const NSCSLOm::RefCSLOmSignal &signal) {

  RefCSLOmField field = CSLOmField::cast(signal->getBitRange());
  RefCSLOmEnum fieldEnum = CSLOmEnum::cast(field->getEnum());
  
  RefCDOmStmtCase stmtCase;
  RefCDOmExprLink sameExprLink = buildCDOmExprLink(signal->getLineNumber(), signal->getName());
  
  RefTVec_RefCSLOmBase fieldEnumChildren = fieldEnum->getChildrenAsBase();
  for(TVec_RefCSLOmBase_const_iter iter = fieldEnumChildren->begin(); iter < fieldEnumChildren->end(); ++iter) {
    if(iter == fieldEnumChildren->begin()) {
      continue;
    }
    TInt payload = CSLOmNum32::cast((CSLOmIdentifier::cast(*iter))->getPayload())->getValue();
    RefString name = (CSLOmIdentifier::cast(*iter))->getLowerName();
    RefString nameUpper = RefString(new string("E_"));
    nameUpper->append(*((CSLOmIdentifier::cast(*iter))->getUpperName()));
    
    RefCDOmExprLink caseItem = buildCDOmExprLink(signal->getLineNumber(), nameUpper);
    RefCDOmListExpr caseExprList = buildCDOmListExpr(signal->getLineNumber(), caseItem);
    RefString outputBit = RefString(new std::string("dec_"));
    outputBit->append(std::string(*(signal->getName())));
    outputBit->append(std::string("_"));

    //const char* upperString = (*name).c_str();
    //char* lowerString = new char(strlen(upperString));
    //for(TInt i = 0; i < strlen(upperString); ++i) {
    //  lowerString[i] = tolower(upperString[i]);
    //}
    //outputBit->append(lowerString);
    //delete upperString;
    //delete lowerString;
    //outputBit->append(*(refStrToLower(name)));
    outputBit->append(*name);

    RefCDOmExpr left = buildCDOmExprLink(signal->getLineNumber(), outputBit); 
    RefCDOmExpr right = buildCDOmNum32WithString(signal->getLineNumber(), CDOmNumber::NUM_BASE_BIN, RefString(new string("1")));
    RefCDOmStmtAssn assn = buildCDOmStmtAssnSimple(signal->getLineNumber(), CDOmStmtAssn::ASSN_BLOCKING, left, right);
    if(!stmtCase.get()) {
      stmtCase = buildCDOmStmtCase(signal->getLineNumber(), CDOmStmtCase::CASE_CASE, sameExprLink, caseExprList, assn);
    }
    else {
      stmtCase->addCaseItem(caseExprList, assn);
    }

    //adding decoder output signals to the parent cdom module
    RefCDOmVarDecl decOut = buildCDOmVarDecl( signal->getLineNumber(), 
                                              m_cdomCurrParent, 
                                              VAR_REG, 
                                              buildCDOmRange( signal->getLineNumber(), 
                                                              buildCDOmNum32WithValue(signal->getLineNumber(), 0),
                                                              buildCDOmNum32WithValue(signal->getLineNumber(), 0)
                                                            ),
                                              outputBit
                                            );

    DCERR("Added dec output to module" << endl);
  }
  //default stmt
  RefCDOmExprLink taskExprLink = buildCDOmExprLink(signal->getLineNumber(), RefString(new string("$display")));
  RefCDOmStmtTaskEnable defaultStmt = buildCDOmStmtTaskEnable(signal->getLineNumber(), CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, taskExprLink);
  defaultStmt->addExpr(buildCDOmString(signal->getLineNumber(), RefString(new string("Illegal value"))));
  //RefCDOmStmtAssn defaultAssn = buildCDOmStmtAssnSimple(signal->getLineNumber(), 
  //                                                      CDOmStmtAssn::ASSN_NON_BLOCKING, 
  //                                                      buildCDOmExprLink(signal->getLineNumber(), RefString(new string("Illegal value"))),
  //                                                      buildCDOmExprLink(signal->getLineNumber(), RefString(new string("true")))
  //                                                     );
  stmtCase->addCaseItem(RefCDOmListExpr(), defaultStmt);
  RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(signal->getLineNumber(), CDOmStmtBlock::BLOCK_SEQUENTIAL);
  stmtBlock->addStmt(stmtCase);

  RefCDOmExprLink exprLink = buildCDOmExprLink(signal->getLineNumber(), signal->getName());
  RefCDOmEventControl evCtrl = buildCDOmEventControlWithHid(signal->getLineNumber(), exprLink);

  RefCDOmStmt stmt = buildCDOmStmtProcTimingControlWithEventControl(signal->getLineNumber(), evCtrl, stmtBlock);
  RefCDOmInitOrAlways alwaysBlock = 
    buildCDOmInitOrAlways(signal->getLineNumber(), m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, stmt);

}

void CAdapterToCDOM::adaptDecoderForSeqEnum(const NSCSLOm::RefCSLOmSignal &signal ,double outputWidth) {

  RefCSLOmField field = CSLOmField::cast(signal->getBitRange());
  RefCSLOmEnum fieldEnum = CSLOmEnum::cast(field->getEnum());
  
  RefCDOmExprConcat enumConcat;

  RefTVec_RefCSLOmBase fieldEnumChildren = fieldEnum->getChildrenAsBase();
  for(TVec_RefCSLOmBase_const_iter iter = fieldEnumChildren->begin(); iter < fieldEnumChildren->end(); ++iter) {
    if(iter == fieldEnumChildren->begin()) {
      continue;
    }
    RefString name = (CSLOmIdentifier::cast(*iter))->getLowerName();
    RefString outputBit = RefString(new string("dec_"));
    outputBit->append(*(signal->getName()));
    outputBit->append("_");
    outputBit->append(*name);
    
    RefCDOmVarDecl decOut = buildCDOmVarDecl( signal->getLineNumber(), 
        m_cdomCurrParent, 
        VAR_REG, 
        buildCDOmRange( signal->getLineNumber(), 
          buildCDOmNum32WithValue(signal->getLineNumber(), 0),
          buildCDOmNum32WithValue(signal->getLineNumber(), 0)
          ),
        outputBit
        );
    RefCDOmExprLink enItem = buildCDOmExprLink(signal->getLineNumber(), outputBit);
    if (!enumConcat.get()) {
      enumConcat = buildCDOmExprConcat(signal->getLineNumber(), enItem);
    }
    else {
      enumConcat->addExpr(enItem);
    }
  }
  RefCDOmExpr leftOfShift = buildCDOmNum32WithValue(signal->getLineNumber(), 1);
  RefCDOmExpr rightOfShift = buildCDOmExprLink(signal->getLineNumber(), signal->getName());
  RefCDOmExpr shiftExpr = buildCDOmExprOp(signal->getLineNumber(), CDOmExprOp::OP_BINARY_SHIFT_LEFT, leftOfShift, rightOfShift);

  RefString outputName = RefString(new std::string("dec_"));
  outputName->append(std::string(*signal->getName()));

  RefCDOmExpr fe = buildCDOmNum32WithValue(signal->getLineNumber(), static_cast<TInt>(outputWidth-1));
  RefCDOmExpr se = buildCDOmNum32WithValue(signal->getLineNumber(), 0);
  RefCDOmRange outputRange = buildCDOmRange(signal->getLineNumber(), fe,se);
  RefCDOmVarDecl outputVar = buildCDOmVarDecl( signal->getLineNumber(), m_cdomCurrParent, VAR_REG, 
      outputRange, outputName, RefCDOmRangeList(), shiftExpr);



  RefCDOmAssn enAssn = buildCDOmAssn( signal->getLineNumber(),
      enumConcat,
      buildCDOmExprLink(signal->getLineNumber(), outputName)
      );
  RefCDOmContAssn enContAssn = buildCDOmContAssn( signal->getLineNumber(), 
      m_cdomCurrParent
      ); 
  enContAssn->addNetAssn(enAssn);

}

void CAdapterToCDOM::adaptDecoderForNoEnum(const NSCSLOm::RefCSLOmSignal &signal, double outputWidth) {
  RefCDOmExpr leftOfShift = buildCDOmNum32WithValue(signal->getLineNumber(), 1);
  RefCDOmExpr rightOfShift = buildCDOmExprLink(signal->getLineNumber(), signal->getName());
  RefCDOmExpr shiftExpr = buildCDOmExprOp(signal->getLineNumber(), CDOmExprOp::OP_BINARY_SHIFT_LEFT, leftOfShift, rightOfShift);

  RefString outputName = RefString(new std::string("dec_"));
  outputName->append(std::string(*signal->getName()));

  //outputWidth = pow(2, static_cast<double>(31));
  TUInt outputWidthAsUnsigned = static_cast<TUInt>(outputWidth-1);
  DCERR("outputWidth = " << outputWidth << " and outputWidthAsUnsigned = " << outputWidthAsUnsigned << endl);
  RefCDOmExpr se = buildCDOmNum32WithValue(signal->getLineNumber(), outputWidthAsUnsigned);
  RefCDOmExpr fe = buildCDOmNum32WithValue(signal->getLineNumber(), 0);
  RefCDOmRange outputRange = buildCDOmRange(signal->getLineNumber(), fe,se);
  RefCDOmVarDecl outputVar = buildCDOmVarDecl( signal->getLineNumber(), m_cdomCurrParent, VAR_REG, 
      outputRange, outputName, RefCDOmRangeList(), shiftExpr);

}




void CAdapterToCDOM::adaptCompare ( TInt lineNumber, 
                                    RefString inputName1, 
                                    RefString inputName2,
                                    RefString outputName, 
                                    RefString clockName, 
                                    RefString resetName
                                  ) {
  RefCDOmExpr expr, right0, left;
  
  RefCDOmExpr lvalue = buildCDOmExprLink(lineNumber, outputName);
  RefCDOmExpr right = buildCDOmExprLink(lineNumber, inputName2);
  RefCDOmExpr left0 = buildCDOmExprLink(lineNumber, inputName1);
  TBool isFull = (*outputName).compare("full");
  DCERR("isFull = " << isFull << "outputName = " << *outputName << endl);
  if(!isFull) {
    right0 = buildCDOmNum32WithValue(lineNumber, 1);
    left = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS, left0, right0);
    expr = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_EQUALITY_EQ, left, right);
  }
  else {
    expr = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_EQUALITY_EQ, left0, right);
  }
  RefCDOmAssn assn = buildCDOmAssn(lineNumber, lvalue, expr);
  
  RefCDOmContAssn contAssn = buildCDOmContAssn(lineNumber, m_cdomCurrParent);
  contAssn->addNetAssn(assn);
  
  
  //RefCDOmExpr expr1 = buildCDOmExprLink(lineNumber, clockName);  
  //RefCDOmEventExpr evExpr1 = buildCDOmEventExprSimple(lineNumber, CDOmEventExpr::EVENT_EXPR_POSEDGE, expr1);
  //RefCDOmExpr expr2 = buildCDOmExprLink(lineNumber, resetName);
  //RefCDOmEventExpr evExpr2 = buildCDOmEventExprSimple(lineNumber, CDOmEventExpr::EVENT_EXPR_NEGEDGE, expr2);
  //RefCDOmEventExpr evExpr = buildCDOmEventExprDouble(lineNumber, CDOmEventExpr::EVENT_EXPR_OR, evExpr1, evExpr2);
  //RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);  

  //RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //stmtBlock->addStmt(assnFull);
  //stmtBlock->addStmt(assnEmpty);
  //
  //RefCDOmStmtProcTimingControl ptc = CDOmStmtProcTimingControl::buildWithEventControl(lineNumber, evCtrl, stmtBlock);
  //RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc);

}

void CAdapterToCDOM::adaptAndGate ( TInt lineNumber, 
                                    RefString input1Name, 
                                    RefString input2Name, 
                                    RefString resultName,
                                    RefString clockName,
                                    RefString resetName,
                                    TInt negate
                                  ) {
  
  RefCDOmExpr rightOfAnd, leftOfAnd;
  switch(negate) {
    case 0: rightOfAnd = buildCDOmExprLink(lineNumber, input1Name);
            leftOfAnd = buildCDOmExprLink(lineNumber, input2Name);
            break;
    case 1: rightOfAnd = buildCDOmExprLink(lineNumber, input1Name);
            leftOfAnd = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_UNARY_LOGIC_NOT, buildCDOmExprLink(lineNumber, input2Name));
            break;
    case 2: rightOfAnd = buildCDOmExprOp(lineNumber,CDOmExprOp::OP_UNARY_LOGIC_NOT, buildCDOmExprLink(lineNumber, input1Name));
            leftOfAnd = buildCDOmExprLink(lineNumber, input2Name);
            break;
    case 3: rightOfAnd = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_UNARY_LOGIC_NOT, buildCDOmExprLink(lineNumber, input1Name));
            leftOfAnd = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_UNARY_LOGIC_NOT, buildCDOmExprLink(lineNumber, input2Name));
            break;
  }
  RefCDOmExpr right = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_LOGIC_AND, leftOfAnd, rightOfAnd);
  RefCDOmExpr left = buildCDOmExprLink(lineNumber, resultName);
  RefCDOmAssn assn = buildCDOmAssn(lineNumber, left, right);

  RefCDOmContAssn contAssn = buildCDOmContAssn(lineNumber, m_cdomCurrParent);
  contAssn->addNetAssn(assn);
  //RefCDOmExpr expr1 = buildCDOmExprLink(lineNumber, clockName);  
  //RefCDOmEventExpr evExpr1 = buildCDOmEventExprSimple(lineNumber, CDOmEventExpr::EVENT_EXPR_POSEDGE, expr1);
  //RefCDOmExpr expr2 = buildCDOmExprLink(lineNumber, resetName);
  //RefCDOmEventExpr evExpr2 = buildCDOmEventExprSimple(lineNumber, CDOmEventExpr::EVENT_EXPR_NEGEDGE, expr2);
  //RefCDOmEventExpr evExpr = buildCDOmEventExprDouble(lineNumber, CDOmEventExpr::EVENT_EXPR_OR, evExpr1, evExpr2);
  //RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);  

  //RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  //stmtBlock->addStmt(assn);
  //
  //RefCDOmStmtProcTimingControl ptc = CDOmStmtProcTimingControl::buildWithEventControl(lineNumber, evCtrl, stmtBlock);
  //RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc);
}



//void CAdapterToCDOM::adaptValid( RefCDOmPortDecl clock, RefCDOmPortDecl reset, RefCDOmPortDecl rdEnable) {}


void CAdapterToCDOM::adaptCounter( TInt unitLineNumber,
                                   RefString clockName, 
                                   RefString resetName, 
                                   RefString countValName,
                                   RefString countEnName,
                                   RefString zeroName,
                                   RefTVec_RefCDOmStmtAssn supplementaryStmts,
                                   RefCDOmPortDecl countInitVal) {

   
//    always @(pe clk or n reset_) begin
  RefCDOmExpr expr1 = buildCDOmExprLink(unitLineNumber, clockName);  
  RefCDOmEventExpr evExpr1 = buildCDOmEventExprSimple(unitLineNumber, CDOmEventExpr::EVENT_EXPR_POSEDGE, expr1);
  RefCDOmExpr expr2 = buildCDOmExprLink(unitLineNumber, resetName);
  RefCDOmEventExpr evExpr2 = buildCDOmEventExprSimple(unitLineNumber, CDOmEventExpr::EVENT_EXPR_NEGEDGE, expr2);
  RefCDOmEventExpr evExpr = buildCDOmEventExprDouble(unitLineNumber, CDOmEventExpr::EVENT_EXPR_OR, evExpr1, evExpr2);
  RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(unitLineNumber, evExpr);  
  
//      if (~reset_) begin
//        cnt_val <= {1'b0{`ADDR_WIDTH}};
//      end
//      else if (cnt_clr) begin
//        cnt_val <= {1'b0{`ADDR_WIDTH}};
//      end
//      else if (cnt_en) begin
//        cnt_val <= cnt_val +{zero,1'b1};  //wire[ADDR_WIDTH-2 : 0] zero = {ADDR_WIDTH-1{1'b0}}
//     end
//   end
  
  RefCDOmStmtIf stmtIf1;
  RefCDOmExpr ifCondExpr1 = buildCDOmExprLink(unitLineNumber, countEnName);
  RefCDOmExpr leftOfPlus = buildCDOmExprLink(unitLineNumber, countValName);
//   RefCDOmExprConcat rightOfPlus = buildCDOmExprConcat(unitLineNumber, buildCDOmExprLink(unitLineNumber, zeroName));
//   rightOfPlus->addExpr(buildCDOmNum32WithString(unitLineNumber, CDOmNumber::NUM_BASE_BIN, RefString(new string("1"))));
  RefCDOmExpr right1 = buildCDOmExprOp(unitLineNumber, 
                                       CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS, 
                                       leftOfPlus, 
                                       buildCDOmNum32WithString(unitLineNumber, CDOmNumber::NUM_BASE_BIN, RefString(new string("1")))
                                       );
  RefCDOmExpr left1 = buildCDOmExprLink(unitLineNumber, countValName);
  RefCDOmStmt ifStmt1 = buildCDOmStmtAssnSimple(unitLineNumber, CDOmStmtAssn::ASSN_NON_BLOCKING, left1, right1);
  RefCDOmStmtBlock block1 = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  block1->addStmt(ifStmt1);

  if(supplementaryStmts.get() && supplementaryStmts->size()) {
    for(TVec_RefCDOmStmtAssn::const_iterator it = supplementaryStmts->begin(); it < supplementaryStmts->end(); ++it) {
      block1->addStmt(*it);
    }
  }

  stmtIf1 = buildCDOmStmtIf(unitLineNumber, ifCondExpr1, block1, RefCDOmStmt());
    
  RefCDOmNum32 zero = buildCDOmNum32WithString(unitLineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0")));
  zero->setIsVeriNumFlag(TRUE);
  RefCDOmExpr right3 = buildCDOmExprMultiConcat(unitLineNumber, 
                                                buildCDOmExprLink(unitLineNumber, RefString(new string("ADDR_WIDTH"))),
                                                buildCDOmExprConcat(unitLineNumber,
                                                                    zero
                                                                    //buildCDOmNum32WithString(unitLineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0"))) 
                                                                    )
                                                );
  RefCDOmExpr left3 = buildCDOmExprLink(unitLineNumber, countValName);
  RefCDOmStmt ifStmt3 = buildCDOmStmtAssnSimple(unitLineNumber, CDOmStmtAssn::ASSN_NON_BLOCKING, left3, right3);
  RefCDOmStmtBlock block3 = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  block3->addStmt(ifStmt3);
  RefCDOmExpr ifCondExpr3 = buildCDOmExprOp(unitLineNumber, 
                                            CDOmExprOp::OP_UNARY_BITWISE_NOT,
                                            buildCDOmExprLink(unitLineNumber, resetName)
                                           );
  RefCDOmStmtIf stmtIf3 = buildCDOmStmtIf(unitLineNumber, ifCondExpr3, block3, stmtIf1);
  
  RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  stmtBlock->addStmt(stmtIf3);

 
   
  RefCDOmStmtProcTimingControl ptc = CDOmStmtProcTimingControl::buildWithEventControl(unitLineNumber, evCtrl, stmtBlock);
  RefCDOmInitOrAlways always = buildCDOmInitOrAlways(unitLineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc);

}

  


void CAdapterToCDOM::adaptMemory( TInt unitLineNumber,
                                  RefString  clockName,
                                  RefString  resetName,
                                  RefString  rdAddrName,
                                  RefString  rdEnableName,
                                  RefString  rdDataName,
                                  RefString  memName,
                                  RefString  wrAddrName,
                                  RefString  wrEnableName,
                                  RefString  wrDataName,
                                  RefString  validName,
                                  RefString  rdEnableSName,
                                  RefString  rdDataSName,
                                  RefString  rdAddrSName

                                 ) {
 
// always @(posedge clk or negedge reset_) begin
//  if (~reset_) begin
//    valid <= 1'b0;
//  end
//  else begin
//    valid <= rd_en;
//    rd_data <= mem[rd_addr];
//    if (wr_en) begin
//      mem[wr_addr] = wr_addr;
//    end
//  end
// end
// 
// endmodule
  RefCDOmStmtBlock block1 = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  RefCDOmStmt stmtIf1;
  if(wrAddrName.get() && wrEnableName.get()) {
    RefCDOmListExpr list1 = CDOmListExpr::build(unitLineNumber, buildCDOmExprLink(unitLineNumber, wrAddrName));
    RefCDOmExprLink leftOfAssn3 = buildCDOmExprLink(unitLineNumber, memName);
    leftOfAssn3->setArrayIndexes(list1);
    RefCDOmExpr rightOfAssn3 = buildCDOmExprLink(unitLineNumber, wrDataName);
    RefCDOmStmt ifStmt1= buildCDOmStmtAssnSimple(unitLineNumber, CDOmStmtAssn::ASSN_NON_BLOCKING, leftOfAssn3, rightOfAssn3);
    block1->addStmt(ifStmt1);

    RefCDOmExpr ifCondExpr1 = buildCDOmExprLink(unitLineNumber, wrEnableName);
    stmtIf1 = buildCDOmStmtIf(unitLineNumber, ifCondExpr1, block1, RefCDOmStmt());
  }
  
  RefCDOmExpr leftOfAssn2 = buildCDOmExprLink(unitLineNumber, rdDataName);
  RefCDOmExprLink rightOfAssn2 = buildCDOmExprLink(unitLineNumber, memName);
  RefCDOmListExpr list = CDOmListExpr::build(unitLineNumber, buildCDOmExprLink(unitLineNumber, rdAddrName));
  rightOfAssn2->setArrayIndexes(list);
  RefCDOmStmt assn2 = buildCDOmStmtAssnSimple(unitLineNumber, CDOmStmtAssn::ASSN_NON_BLOCKING, leftOfAssn2, rightOfAssn2);
  
  RefCDOmStmtBlock blockForRd = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  blockForRd->addStmt(assn2);

  RefCDOmExprLink condForRd = buildCDOmExprLink(unitLineNumber, rdEnableName);
  RefCDOmStmt ifStmtForRd = buildCDOmStmtIf(unitLineNumber, condForRd, blockForRd, RefCDOmStmt());

  RefCDOmStmt ifStmtForRd2 = RefCDOmStmt();
  if(rdEnableSName.get()) {
    RefCDOmExpr leftOfAssn2 = buildCDOmExprLink(unitLineNumber, rdDataSName);
    RefCDOmExprLink rightOfAssn2 = buildCDOmExprLink(unitLineNumber, memName);
    RefCDOmListExpr list = CDOmListExpr::build(unitLineNumber, buildCDOmExprLink(unitLineNumber, rdAddrSName));
    rightOfAssn2->setArrayIndexes(list);
    RefCDOmStmt assn2 = buildCDOmStmtAssnSimple(unitLineNumber, CDOmStmtAssn::ASSN_NON_BLOCKING, leftOfAssn2, rightOfAssn2);
    RefCDOmStmtBlock blockForRd = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    blockForRd->addStmt(assn2);

    RefCDOmExprLink condForRd = buildCDOmExprLink(unitLineNumber, rdEnableSName);
    ifStmtForRd2 = buildCDOmStmtIf(unitLineNumber, condForRd, blockForRd, RefCDOmStmt());
  }


  RefCDOmStmt assn1;
  if(validName.get()) {
    RefCDOmExpr leftOfAssn1 = buildCDOmExprLink(unitLineNumber, validName);
    if(rdEnableSName.get()) {
      RefCDOmExpr rightOfAssn1 = buildCDOmExprLink(unitLineNumber, rdEnableName);
      RefCDOmExpr rightOfAssn2 = buildCDOmExprLink(unitLineNumber, rdEnableSName);
      RefCDOmExprOp rightOfAssn = buildCDOmExprOp(unitLineNumber, CDOmExprOp::OP_BINARY_BITWISE_OR, rightOfAssn1,rightOfAssn2);
      assn1 = buildCDOmStmtAssnSimple(unitLineNumber, CDOmStmtAssn::ASSN_NON_BLOCKING, leftOfAssn1, rightOfAssn);
    }
    else {
      RefCDOmExpr rightOfAssn1 = buildCDOmExprLink(unitLineNumber, rdEnableName);
      assn1 = buildCDOmStmtAssnSimple(unitLineNumber, CDOmStmtAssn::ASSN_NON_BLOCKING, leftOfAssn1, rightOfAssn1);
    }
  }
  RefCDOmStmtBlock stmtBlock1 = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
  if(assn1.get()) {
    stmtBlock1->addStmt(assn1);
  }
  stmtBlock1->addStmt(ifStmtForRd);
  if(ifStmtForRd2.get()) {
    stmtBlock1->addStmt(ifStmtForRd2);
  }
  if(stmtIf1.get()) {
    stmtBlock1->addStmt(stmtIf1);
  }
  
  RefCDOmStmt stmtIf;
  if(validName.get()) {
    RefCDOmExpr rightOfAssn = buildCDOmNum32WithValue(unitLineNumber, 1);
    RefCDOmExpr leftOfAssn = buildCDOmExprLink(unitLineNumber, validName);
    RefCDOmStmt ifStmt = buildCDOmStmtAssnSimple(unitLineNumber, CDOmStmtAssn::ASSN_NON_BLOCKING, leftOfAssn, rightOfAssn);
    RefCDOmStmtBlock block = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    block->addStmt(ifStmt);
    RefCDOmExpr ifCondExpr = buildCDOmExprOp( unitLineNumber, 
                                              CDOmExprOp::OP_UNARY_BITWISE_NOT,
                                              buildCDOmExprLink(unitLineNumber, resetName)
                                              );
    stmtIf = buildCDOmStmtIf(unitLineNumber, ifCondExpr, block, stmtBlock1);
  }
  
  RefCDOmExpr clkExpr = buildCDOmExprLink(unitLineNumber, clockName);
  RefCDOmEventExpr e1 = buildCDOmEventExprSimple(unitLineNumber, CDOmEventExpr::EVENT_EXPR_POSEDGE, clkExpr);
  RefCDOmExpr resetExpr = buildCDOmExprLink(unitLineNumber, resetName);
  RefCDOmEventExpr e2 = buildCDOmEventExprSimple(unitLineNumber, CDOmEventExpr::EVENT_EXPR_NEGEDGE, resetExpr);
  RefCDOmEventExpr evExpr = buildCDOmEventExprDouble(unitLineNumber, CDOmEventExpr::EVENT_EXPR_OR, e1, e2);
  RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(unitLineNumber, evExpr);

  RefCDOmStmtProcTimingControl ptc;
  if(stmtIf.get()) {
    RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(unitLineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    stmtBlock->addStmt(stmtIf);
    ptc = buildCDOmStmtProcTimingControlWithEventControl(unitLineNumber, evCtrl, stmtBlock);
  }
  else {
    ptc = buildCDOmStmtProcTimingControlWithEventControl(unitLineNumber, evCtrl, stmtBlock1);
  }
  
  RefCDOmInitOrAlways always = buildCDOmInitOrAlways(unitLineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc);

}


CAdapterToCDOM::CAdapterToCDOM(RefCDOmDesign product) : m_product(product), 
                                                        m_cdomTraversedChildren(RefTVec_RefCDOmBase(new TVec_RefCDOmBase())),
                                                        m_cslTraversedChildren(RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase())),
                                                        m_ifcPrefixes(RefTVec_RefString(new TVec_RefString())),
                                                        m_sigGroupPrefixes(RefTVec_RefString(new TVec_RefString())),
                                                        m_ifcSuffixes(RefTVec_RefString(new TVec_RefString())),
                                                        m_sigGroupSuffixes(RefTVec_RefString(new TVec_RefString())),
                                                        m_actualPrefix(RefTVec_RefString(new TVec_RefString())),
                                                        m_formalPrefix(RefTVec_RefString(new TVec_RefString())),
                                                        m_reversedActualPrefixes(RefTVec_RefString(new TVec_RefString())),
                                                        m_reversedFormalPrefixes(RefTVec_RefString(new TVec_RefString())),
                                                        
                                                        //testbench
                                                        m_cdomDutInstances(RefTVec_RefCDOmModuleOrUdpInstance(new TVec_RefCDOmModuleOrUdpInstance())),
                                                        m_tbVectClockName(RefString()),
                                                        m_tbVectResetName(RefString()),
                                                        m_tbVectOutputName(RefString()),
                                                        m_tbVectValidName(RefString()),
                                                        m_tbVectorDone(FALSE),

                                                        m_tbVectorInstances(RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase())), 
                                                        m_vectorModuleName(RefString()),
                                                        m_unitPrefix(),
                                                        m_simpleBitRangeIT(TRUE),
                                                        m_isOrdinarySimpleBrOrDimZero(FALSE),
                                                        m_insideAssign(FALSE),
                                                        m_generateIndividualSignals(TRUE),
                                                        m_firstCallOfNum32BT(TRUE), 
                                                        m_secondCallOfNum32BT(FALSE), 
                                                        m_thirdCallOfNum32BT(FALSE),
                                                        m_firstCallOfBitRangeIT(1),
                                                        m_firstCallOfEnumIT(0),
                                                        m_enumName(RefString()),
                                                        m_enumItemVal(-1),
                                                        m_num32Offset(RefCDOmNum32()), 
                                                        m_num32FirstExpr(RefCDOmNum32()), 
                                                        m_num32SecondExpr(RefCDOmNum32()),
                                                        m_beforeTraversalForNum32(0),
                                                        m_unitType(UNIT_TYPE_UNIT_DECL),
                                                        m_unitInfo(RefCSLOmUnitInfo()),
                                                        m_memMapLocations(RefTVec_RefCSLOmMemoryMapLocation(new TVec_RefCSLOmMemoryMapLocation())),
                                                        m_nrOfAlienChildren(0)

{
  TRACE_ME(0,"CAdapterToCDOM::CAdapterToCDOM(RefCDOmDesign product)")
#ifdef _ADAPTER_COMPILED_TIME
  DCERR( "Using adapter compiled at : " << __DATE__ << " " << __TIME__ << endl);
#endif
}

RefCDOmDesign CAdapterToCDOM::getProduct() { 
  TRACE_ME(0,"CAdapterToCDOM::getProduct()");
  return m_product; 
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      )");
  NSCdom::EIncludeFileType fileType;
  if (fileInclude->getFileType() == NSCSLOm::FILE_VERILOG) {
    fileType = NSCdom::FILE_VERILOG;
  }
  else {
    fileType = NSCdom::FILE_CPLUSPLUS;
  }

  //  buildCDOmInclude(fileInclude->getLineNumber(),m_cdomCurrParent, fileType, fileInclude->getFileName()); //----commented by OB
  
  // CDOMInclude should be built using the included file, not the name of the cpp file, like in the previuos line
  buildCDOmInclude(fileInclude->getLineNumber(),m_cdomCurrParent, fileType, fileInclude->getIncFileName()); //----OB added
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmDesign      & design      ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmDesign      & design      )");
  ASSERT(design.get(), "The design is null");
  if(!m_product.get())
    m_product = buildCDOmDesign();
  RefTVec_RefCSLOmBase children = design->getChildrenAsBase();
  if( !children.get() ) {
    DCERR( "Warning, the design has no children" << endl);
    return;
  }
  
  m_cdomCurrParent = m_product;
  m_cslCurrParent = design;
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier  & id          ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier  & id          )");
  ASSERT(id.get(), "The input id is invalid");

  m_cslReturnedValue = id;
   
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprLink    & exprLink    ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprLink    & exprLink    )");
  m_cslCurrParent = exprLink;
  
//     //Checking that the expresion link is not pointing towards a signal from a signal group or a port from an interface.
//     //If it is, the expresion link must point only to a signal or port.
//     NSCSLOm::RefTVec_RefCSLOmIdentifier ids = exprLink->getIDs();
//     RefString name = RefString(new string(""));
//     TBool isIfcOrSigGroup = FALSE;
//     TInt size = ids->size();
//     RefCSLOmIdentifier id1 = ids->back();

//     RefCSLOmIdentifier id2 = ids->at(size-2);
//     CSLOmIdentifier::EIdType type = (id1)->getIdType();
//     if(type == CSLOmIdentifier::ID_CSL_SIGNAL) {
//       if((id2)->getIdType() == CSLOmIdentifier::ID_CSL_GROUP) {
//         isIfcOrSigGroup = TRUE;
//         RefCSLOmSignal signal = CSLOmSignal::cast(CSLOmConnectable::cast(exprLink->doEval()));
//         map<RefCSLOmSignal, RefTVec_RefString>::const_iterator it = m_allCslSignals.find(signal);
//         if(it != m_allCslSignals.end()) {
//           RefTVec_RefString prefixes = it->second;
//           for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
//             name->append(**prefixIt);
//             name->append("_");
//           }
//         }
//         else {
//           RefCSLOmSignal signal = CSLOmSignal::cast(exprLink->doEval());
//           RefTVec_RefString prefixes = RefTVec_RefString(new TVec_RefString());
//           RefCSLOmBase parent = signal->getParent();
//           RefCSLOmGroupSignal parentSg;
//           ASSERT(parent->isSignalGroup(), "parent should be signal group");
//           while(parent->isSignalGroup()) {
//             parentSg = CSLOmGroupSignal::cast(parent);
//             RefString prefix = RefString(parentSg->getPrefix());
//             prefixes->push_back(prefix);
//             name->append(*prefix);
//             name->append("_");
//             parent = parentSg->getParent();
//           }
//           if(prefixes.get()) {
//             m_allCslSignals.insert(pair<RefCSLOmSignal, RefTVec_RefString>(signal, prefixes));
//           }
//         }
//         name->append(*(signal->getName()));
//       }
//     }
//     else if(type == CSLOmIdentifier::ID_CSL_PORT) {
//       if((id2)->getIdType() == CSLOmIdentifier::ID_CSL_INTERFACE) {
//         isIfcOrSigGroup = TRUE;
//         RefCSLOmPortDecl port = CSLOmPortDecl::cast(exprLink->doEval());
//         map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator it = m_allCslPorts.find(port);
//         if(it != m_allCslPorts.end()) {
//           RefTVec_RefString prefixes = it->second;
//           for(TVec_RefString::const_iterator prefixIt = prefixes->begin(); prefixIt < prefixes->end(); ++prefixIt) {
//             name->append(**prefixIt);
//             name->append("_");
//           }
//         } 
//         //in case of predeclarations
//         else {
//           RefCSLOmPortDecl port = CSLOmPortDecl::cast(exprLink->doEval());
//           RefTVec_RefString prefixes = RefTVec_RefString(new TVec_RefString());
//           RefCSLOmBase parent = port->getParent();
//           ASSERT(parent->isInterface(), "parent should be interface");
//           RefCSLOmInterface parentIfc = CSLOmInterface::cast(parent);
//           while(!parentIfc->isDefaultIfc()) {
//             RefString prefix = RefString(parentIfc->getPrefix());
//             prefixes->push_back(prefix);
//             name->append(*prefix);
//             name->append("_");
//             parent = parentIfc->getParent();
//             ASSERT(parent->isInterface(), "parent should be interface");
//             parentIfc = CSLOmInterface::cast(parent);
//           }
//           if(prefixes.get()) {
//             m_allCslPorts.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(port, prefixes));
//           }
//         }
//         name->append(*(port->getName()));
//       }
//     }
//     else if(type == CSLOmIdentifier::ID_CSL_INTERFACE) {
//       //to be completed
//     }
//     else if(type == CSLOmIdentifier::ID_CSL_GROUP) {      
//       //to be completed
//     }
//     const RefTVec_RefString names = exprLink->getHidNames();
//     for(TVec_RefString_const_iter it = names->begin(); it < names->end(); ++it) {
//       if(!cdomExprLink.get()) {
//         if(isIfcOrSigGroup) {
//           cdomExprLink = buildCDOmExprLink(exprLink->getLineNumber(), name);
//         }
//         else {
//           cdomExprLink = buildCDOmExprLink(exprLink->getLineNumber(), *it);
//         }
//       }
//       else {
//         if(!isIfcOrSigGroup) {
//           cdomExprLink->addHidItem(*it);
//         }
//       }
//     }

}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl    & unitDecl    ) {
 
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl    & unitDecl    )");
  ASSERT(unitDecl.get(), "The input unit declaration is NULL");
  RefTVec_RefCSLOmBase children=unitDecl->getChildrenAsBase();
  ASSERT(children.get(), "The unit declaration m_children is a null vector");
  ASSERT(children->size(), "The unit declaration m_children size is 0");
  ASSERT(children->at(0).get(), "The first child is a null wrapped pointer");
  ASSERT(m_cdomCurrParent.get(), "The current cdom parent isn't set"); 
  ASSERT(m_cslCurrParent.get(), "The current cslom parent isn't set");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DESIGN, "The current cdom parent isn't CDOmDesign");
  ASSERT(m_cslCurrParent->getType() == NSCSLOm::TYPE_DESIGN, "The current cslom parent isn't CSLOmDesign");
    
 
  if (!unitDecl->isSetDoNotGenerateRTL()) {
    //for mem map
    RefCDOmModuleDecl internalRegsEnModule;
    RefCDOmBase aux;
    
    RefCDOmModuleDecl moduleDecl;
    if(unitDecl->getUnitType() != CSLOmUnitDecl::CSL_VECTOR) {
      moduleDecl = CDOmDesign::cast(m_cdomCurrParent)->buildModuleDecl( unitDecl->getLineNumber(), unitDecl->getName());
      
    }
    else if (unitDecl->getUnitType() == CSLOmUnitDecl::CSL_VECTOR && !m_tbVectorDone) {
      //cout << "here" << endl;
      m_vectorModuleName = RefString(new string("stim_expect_mem_template"));
      moduleDecl = CDOmDesign::cast(m_cdomCurrParent)->buildModuleDecl(unitDecl->getLineNumber(), m_vectorModuleName);
    }
    
    if(moduleDecl.get()) {
      //generate comment stating the csl unit source of the generated verilog module
      RefString commentLine = RefString(new string("Location of source csl unit: file name = "));
      commentLine->append(*(unitDecl->getFileName()));
      commentLine->append(" line number = ");
      stringstream line;
      line << unitDecl->getLineNumber();
      commentLine->append(line.str());
      RefCDOmComment comment = buildCDOmComment(unitDecl->getLineNumber(), 
                                                moduleDecl, 
                                                CDOmComment::TYPE_SLASH_SLASH, 
                                                commentLine
                                                );
    }
    
    m_unitPrefix = unitDecl->getUnitPrefix();
    
    if(moduleDecl.get()) {
      m_cdomCurrParent = moduleDecl;
    }
    m_cslCurrParent = unitDecl;
    
    m_unitInfo = unitDecl->getUnitInfo(); 
    
    RefString unitName = unitDecl->getName();
    switch (unitDecl->getUnitType()) {
      case CSLOmUnitDecl::CSL_FIFO_DECL :           m_unitType = UNIT_TYPE_FIFO_DECL; 
        m_cslFifoPorts = (CSLOmFifoInfo::cast(m_unitInfo))->getPortMap();
        moduleDecl->setCslSourceUnitType(CDOmModuleDecl::GEN_FROM_FIFO);
        break;
      case CSLOmUnitDecl::CSL_REGISTER_FILE_DECL :  m_unitType = UNIT_TYPE_REGISTER_FILE_DECL;
        m_cslRegisterFilePorts = (CSLOmRegisterFileInfo::cast(m_unitInfo))->getPortMap();
        moduleDecl->setCslSourceUnitType(CDOmModuleDecl::GEN_FROM_REG_FILE);
        break;
      case CSLOmUnitDecl::CSL_TESTBENCH_DECL:       m_unitType = UNIT_TYPE_TESTBENCH_DECL;
        moduleDecl->setCslSourceUnitType(CDOmModuleDecl::GEN_FROM_TB);
        break;
      case CSLOmUnitDecl::CSL_VECTOR:               m_unitType = UNIT_TYPE_VECTOR_DECL;
        if(!m_tbVectorDone) {
          moduleDecl->setCslSourceUnitType(CDOmModuleDecl::GEN_FROM_VECTOR);
        }
        break;
      case CSLOmUnitDecl::CSL_MEMORY_DECL:          m_unitType = UNIT_TYPE_MEM_DECL;
        moduleDecl->setCslSourceUnitType(CDOmModuleDecl::GEN_FROM_MEM);
        //m_cslMemoryPorts = (CSLOmMemoryInfo::cast(unitDecl->getUnitInfo()))->getPortMap();
        break;
      case CSLOmUnitDecl::CSL_REGISTER_DECL:        m_unitType = UNIT_TYPE_REGISTER_DECL;
        m_cslRegisterPorts = (CSLOmRegDeclInfo::cast(m_unitInfo))->getPortMap();
        moduleDecl->setCslSourceUnitType(CDOmModuleDecl::GEN_FROM_REG);
        break;
      default://CSL_UNIT_DECL
        moduleDecl->setCslSourceUnitType(CDOmModuleDecl::GEN_FROM_UNIT);
        //memory map query
        //int ok = false;
        //if(m_memMapLocations.get()) {
        //  for(TVec_RefCSLOmMemoryMapLocation_const_iter it = m_memMapLocations->begin(); 
        //      it < m_memMapLocations->end(); 
        //      ++it) {
        //DCERR("loc name " << *((*it)->getSymbol()->getName()) << endl);
        //DCERR("loc addr " << ((*it)->getAddressableObject()).get() << endl);
        //DCERR("unit addr " << unitDecl.get());
        //    if(unitDecl == (*it)->getAddressableObject()) {
        //      ok = true;
        //      break;
        //    }
        //  }
        //  if(ok) {
        if(m_memMapLocations.get() && m_memMapLocations->size()) {//replace this
          RefString memMapModuleName = RefString(new string(""));
          memMapModuleName->append(*(unitDecl->getName()));
          memMapModuleName->append("_internal_registers_enable_logic");
          adaptMemoryMapForUnitRegisters(unitDecl, memMapModuleName);
          internalRegsEnModule = 
            CDOmDesign::cast(m_cdomCurrParent->getParent())->buildModuleDecl(unitDecl->getLineNumber(),
                                                                             memMapModuleName
                                                                             );
          aux = m_cdomCurrParent;
          m_cdomCurrParent = internalRegsEnModule;
          adaptUnitRegistersEnableLogicModule(unitDecl, 
                                              memMapModuleName
                                              );
          m_cdomCurrParent = aux;
        }
        //  }
        //}
    }
  }
  else {
    DCERR("Not generating Verilog for \'" << *(unitDecl->getID()->getName()) << "\'");
    
    disableChildrenTraversal();
  }
}


void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmSignal      & signal      ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmSignal      & signal      )");
  ASSERT(signal.get(), "The input signal is null");
  ASSERT(m_cslCurrParent.get(), "The csl current parent is null");
  ASSERT(m_cdomCurrParent.get(), "The cdom current parent is null");
  ASSERT(m_cslCurrParent->isUnitDecl() || m_cslCurrParent->isSignalGroup(),"The csl current parent is not a unit nor a group of signals");
  ASSERT(m_cdomCurrParent->getType() == TYPE_DECL_MODULE, "The cdom current parent is not a module");
  
  m_cslCurrParent = signal; 

}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance    & unitInst    ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance    & unitInst    )");
  ASSERT(unitInst.get(), "The input unit instantiation is a null pointer");
  ASSERT(m_cslCurrParent.get(), "The current csl parent is null");
  ASSERT(m_cdomCurrParent.get(), "The current cdom parent is null");
  ASSERT(m_cslCurrParent->getType() == NSCSLOm::TYPE_UNIT_INSTANTIATION, "The current csl parent isn't of type CSLOmUnitInstantiation");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_MODULE_INSTANTIATION, "The current cdom parent isn't of type CDOmModuleOrUdpInstantiation");
  
  //RefTVec_RefCSLOmBase children = unitInst->getChildrenAsBase();
  //DCERR("Unit instance has " <<children->size() << " children: " << endl);
  //for(TVec_RefCSLOmBase::const_iterator it = children->begin(); it < children->end(); ++it) {
  //  DCERR("type: " << (*it)->getType() << endl);
  //}

  
  m_cslCurrParent = unitInst;
}



void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange    & simpleBitRange    ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange    & simpleBitRange    )");
  ASSERT(simpleBitRange.get(), "Input simple bitrange is null");
  ASSERT(m_cslCurrParent.get(), "Csl current parent is null");
  ASSERT(   m_cslCurrParent->isBitRange() 
         || m_cslCurrParent->isSignal()
         || m_cslCurrParent->isPort()
         || m_cslCurrParent->isDesign() 
         || m_cslCurrParent->isExpr(), "Csl current parent is of illegal type");
  ASSERT(m_cdomCurrParent.get(), "Cdom current parent is null");  

  if(   (!simpleBitRange->getParent()->isBitRange()) 
        || ((simpleBitRange->getParent()->isBitRange() && (CSLOmMultiDimBitRange::cast(simpleBitRange->getParent()))->getDimZero() == simpleBitRange))) {
    m_isOrdinarySimpleBrOrDimZero = TRUE;
    m_cslCurrParent = simpleBitRange;
  }
  else {
    disableChildrenTraversal();
  }
  //ASSERT(   m_cdomCurrParent->getType() == NSCdom::TYPE_NET_DECL 
  //       || m_cdomCurrParent->getType() == NSCdom::TYPE_VAR_DECL 
  //       || m_cdomCurrParent->getType() == NSCdom::TYPE_PORT_DECL,
  //       "Cdom current parent is of illegal type");
  //As the cdom parent(signal or port) is beeing built in the afterTraversal method, this assert should not be here.
  m_nrOfAlienChildren = m_cdomTraversedChildren->size();
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange  & multiDimBitRange  ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange    & multiDimBitRange    )");
  ASSERT(multiDimBitRange.get(), "Input multidim bitrange is null");
  ASSERT(m_cslCurrParent.get(), "Current csl parent is null");
  ASSERT(   m_cslCurrParent->isDesign() 
         || m_cslCurrParent->isSignal()
         || m_cslCurrParent->isPort(), "Csl current parent is of illegal type");
  ASSERT(m_cdomCurrParent.get(), "Current cdom parent is null");
  //Can't check the cdom parent type here as the cdom parent hasn't been built yet.
  //the m_cdomCurrParent is still of type moduleDecl.
  //ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_NET_DECL 
  //       || m_cdomCurrParent->getType() == NSCdom::TYPE_VAR_DECL 
  //       || m_cdomCurrParent->getType() == NSCdom::TYPE_PORT_DECL,
  //       "CDOM current parent is of illegal type");

  m_cslCurrParent = multiDimBitRange;
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmGroup       & group       ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmGroup       & group       )");
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal & groupSignal ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal & groupSignal )");
  ASSERT(groupSignal.get(), "Input groupSignal is null");
  ASSERT(m_cslCurrParent.get(), "The csl current parent is not set");
  ASSERT(m_cslCurrParent->getType() == TYPE_CONNECTABLE || m_cslCurrParent->getType() == TYPE_DECL_UNIT, "The csl current parent is not valid");
  if(!groupSignal->getGenerateIndividualRtlSignals()) {
    m_generateIndividualSignals = FALSE;
  }
  
  if(!groupSignal->getNoPrefixBit()) {
    if(!groupSignal->getPrefix().get()) {
      m_sigGroupPrefixes->push_back(groupSignal->getName());
    }
    else {
      m_sigGroupPrefixes->push_back(groupSignal->getPrefix());
    }
  }
  if(groupSignal->getSuffix().get()) {
    m_sigGroupSuffixes->push_back(groupSignal->getSuffix());
  }
  
  m_cslCurrParent = groupSignal;
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmNum32      & number      ) {
  if(!number->getParent()->isBitRange() 
     || number->getParent()->isBitRange() && m_isOrdinarySimpleBrOrDimZero) {
    TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmNumber      & number      )");
    ASSERT(number.get(), "The input CSLOmNumber is null");
    if(m_cslCurrParent->getType() == NSCSLOm::TYPE_BIT_RANGE && !m_generateIndividualSignals) {
      if(!m_beforeTraversalForNum32) {
        m_num32Offset = buildCDOmNum32WithValue(number->getLineNumber(), 0);
        m_num32FirstExpr = buildCDOmNum32WithValue(number->getLineNumber(), 0);
        m_num32SecondExpr = buildCDOmNum32WithValue(number->getLineNumber(), 0);
        ++m_beforeTraversalForNum32;
      }
      RefCDOmNumber num = buildCDOmNum32WithString(
                                                   number->getLineNumber(), 
                                                   getCDOmNumType(number->getNumBaseType()),
                                                   number->getTokenString()
                                                   );
    
      RefCDOmNumber one = buildCDOmNum32WithValue( number->getLineNumber(), 1 );
      if(m_firstCallOfNum32BT) {
        m_firstCallOfNum32BT = FALSE;
        m_secondCallOfNum32BT = TRUE;
        m_num32Offset = m_num32Offset->add(num);
      }
      else if(m_secondCallOfNum32BT) {
        m_secondCallOfNum32BT = FALSE;
        m_thirdCallOfNum32BT = TRUE;
        m_num32FirstExpr = m_num32FirstExpr->add(num);
        m_num32FirstExpr = m_num32FirstExpr->add(one);
      }
      else if(m_thirdCallOfNum32BT) {
        m_thirdCallOfNum32BT = FALSE;
        m_firstCallOfNum32BT = TRUE;
        m_num32SecondExpr = m_num32SecondExpr->add(num);
      }
    }
    else {
      /*      RefCDOmNum32 cdomNum32 = buildCDOmNum32WithString(
                                                        number->getLineNumber(),
                                                        getCDOmNumType(number->getNumBaseType()),
                                                        number->getTokenString()
                                                        );*/
      RefCDOmNum32 cdomNum32 = CDOmNum32::build(number->getLineNumber(),
                                                number->getValue(),
                                                getCDOmNumType(number->getNumBaseType()),
                                                number->getWidth()
                                                );
      m_cdomReturnedValue = cdomNum32;
    }
  }
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmVeriNum     & veriNum      ) {
  if(!veriNum->getParent()->isBitRange() 
     || veriNum->getParent()->isBitRange() && m_isOrdinarySimpleBrOrDimZero) {
    TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmNumber      & number      )");
    ASSERT(veriNum.get(), "The input CSLOmNumber is null");
    RefCDOmVeriNum cdomVeriNum = CDOmVeriNum::build(veriNum->getLineNumber(),
                                                    getCDOmNumType(veriNum->getNumBaseType()),
                                                    veriNum->getTokenString(),
                                                    RefString(new string("")),
                                                    veriNum->isSigned()
                                                    );
    m_cdomReturnedValue = cdomVeriNum;
  }
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmInterface   & interface   ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmInterface   & interface   )");
  ASSERT(interface.get(), "NULL input interface");
  
  if(!interface->isDefaultIfc() && !interface->getNoPrefixBit()) {
    RefString prefix = interface->getPrefix();
    RefString name = interface->getName();
    if(!prefix.get()) {//set_prefix(""); no_prefix(); set_prefix("smth") were NOT called
      m_ifcPrefixes->push_back(name);
      // m_ifc = name;
      //cout << "IFC name =" << *name << endl;
    }
    else {
      m_ifcPrefixes->push_back(prefix);
    }
    if(interface->getSuffix().get()) {
      m_ifcSuffixes->push_back(interface->getSuffix());
    }
  }
  m_cslCurrParent = interface;
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation & unitInstantiation) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation & unitInstantiation)");
  ASSERT(unitInstantiation.get(), "The input unit instantiation is a null pointer");
  ASSERT(m_cslCurrParent.get(), "The current csl parent isn't set");
  ASSERT(m_cdomCurrParent.get(), "The current cdom parent isn't set");
  ASSERT(m_cslCurrParent->getType() == NSCSLOm::TYPE_DECL_UNIT || m_cslCurrParent->isInterface(), 
      "The current csl parent is not a csl unit or a csl interface");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DECL_MODULE, "The current cdom parent is not a CDOmModuleDecl");

  m_inTraversalForUnitInstantiation = 0;
  m_cslCurrParent = unitInstantiation;
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                    & portDecl          ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl   & portDecl          )");
  ASSERT(portDecl.get(), "The input port declaration is a null pointer");
  ASSERT(m_cslCurrParent.get(), "The current cslom parent wasn't set");
  ASSERT(m_cslCurrParent->isInterface(), "The current cslom parent isn't of type CSLOmInterface");
  ASSERT(m_cdomCurrParent.get(), "The current cdom parent wasn't set");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DECL_MODULE, "The current cdom parent isn't of type CDOmModuleDecl");

  //  if(m_cslCurrParent->isInterface())
  //   cout <<"INTERFACE!!! " << endl;

  m_cslCurrParent = portDecl;


  // string port_name = *portDecl->getName();
  // if(m_ifc){
  //   string port_ifc_name = *m_ifc + "_" + port_name;
    // cout << "port NAME = " << port_ifc_name<< endl;
  //  }
    
  // set the clock name to pass it to cdom
  if(portDecl->getAttr() == ATTR_CLK) {
    cslomClockName = portDecl->getName();
    //std::cout << "\n------set clock name\n\n";
  }


}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprOp                      & exprOp            ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprOp     & exprOp            )");
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                  & exprConcat        ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprConcat & exprConcat        )");
  ASSERT(exprConcat.get(), "The input expression concat is null");
  NSCdom::RefCDOmExprConcat cdomExpConcat = RefCDOmExprConcat();
  NSCSLOm::RefTVec_RefCSLOmBase children = exprConcat->getChildrenAsBase();
  ASSERT(children.get(), "The concatenated expression m_children vector is null");
  ASSERT(children->size(), "The concatenated expression m_children vector size is 0");
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat          & exprMultiConcat          ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat          & exprMultiConcat          )");
  ASSERT(exprMultiConcat.get(), "Null input exprMultiConcat");

  //RefCSLOmExpr cslomExpr = exprMultiConcat->getExpr();
  //ASSERT(cslomExpr.get(), "null expression");
  //RefCSLOmExprConcat cslomExprConcat = exprMultiConcat->getExprConcat();
  //ASSERT(cslomExprConcat.get(), "Null exprConcat");

  //cslomExpr->acceptVisitor(*this);
  //ASSERT(m_cdomReturnedValue.get(), "null returned cdom value");
  //ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "The returned type is not expression");
  //RefCDOmExpr cdomExpr = boost::static_pointer_cast<CDOmExpr>(m_cdomReturnedValue);
  //m_cdomReturnedValue = RefCDOmBase();

  //cslomExprConcat->acceptVisitor(*this);
  //ASSERT(m_cdomReturnedValue.get(), "null retured cdom value");
  //ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "The returned cdom type is not expression");
  //ASSERT(boost::static_pointer_cast<CDOmExpr>(m_cdomReturnedValue)->getExprType() == CDOmExpr::EXPR_CONCAT, "The reurned cdom expression is not a concat");
  //RefCDOmExprConcat cdomExprConcat = boost::static_pointer_cast<CDOmExprConcat>(m_cdomReturnedValue);
  ////m_cdomReturnedValue = RefCDOmBase();

  //RefCDOmExprMultiConcat cdomExprMultiConcat = buildCDOmExprMultiConcat(exprMultiConcat->getLineNumber(), cdomExpr, cdomExprConcat);
  //m_cdomReturnedValue = cdomExprMultiConcat;
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmList                     & list                     ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmList                     & list                     )");
  //ignore this node
}

//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmSetCommand               & setCommand               ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmSetCommand               & setCommand               )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetWidth              & cmdSetWidth              ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetWidth              & cmdSetWidth              )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetBitRange           & cmdSetBitRange           ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetBitRange           & cmdSetBitRange           )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetOffset             & cmdSetOffset             ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetOffset             & cmdSetOffset             )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetLowerIndex         & cmdSetLowerIndex         ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetLowerIndex         & cmdSetLowerIndex         )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetUpperIndex         & cmdSetUpperIndex         ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetUpperIndex         & cmdSetUpperIndex         )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetRange              & cmdSetRange              ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetRange              & cmdSetRange              )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetNumberOfDimensions & cmdSetNumberOfDimensions ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetNumberOfDimensions & cmdSetNumberOfDimensions )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimWidth           & cmdSetDimWidth           ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimWidth           & cmdSetDimWidth           )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimBitRange        & cmdSetDimBitRange        ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimBitRange        & cmdSetDimBitRange        )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimOffset          & cmdSetDimOffset          ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimOffset          & cmdSetDimOffset          )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimLowerIndex      & cmdSetDimLowerIndex      ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimLowerIndex      & cmdSetDimLowerIndex      )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimUpperIndex      & cmdSetDimUpperIndex      ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimUpperIndex      & cmdSetDimUpperIndex      )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimRange           & cmdSetDimRange           ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimRange           & cmdSetDimRange           )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetUnitPrefix         & cmdSetUnitPrefix         ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetUnitPrefix         & cmdSetUnitPrefix         )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefix       & cmdSetSignalPrefix       ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefix       & cmdSetSignalPrefix       )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefixLocal  & cmdSetSignalPrefixLocal  ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefixLocal  & cmdSetSignalPrefixLocal  )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetType               & cmdSetType               ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetType               & cmdSetType               )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetAttr               & cmdSetAttr               ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetAttr               & cmdSetAttr               )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInstance           & cmdAddInstance           ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInstance           & cmdAddInstance           )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInstanceList       & cmdAddInstanceList       ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInstanceList       & cmdAddInstanceList       )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignal             & cmdAddSignal             ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignal             & cmdAddSignal             )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignalList         & cmdAddSignalList         ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignalList         & cmdAddSignalList         )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignalGroup& cmdAddSignalGroup) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignalGroup& cmdAddSignalGroup )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddPort               & cmdAddPort               ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddPort               & cmdAddPort               )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddPortList           & cmdAddPortList           ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddPortList           & cmdAddPortList           )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignal          & cmdRemoveSignal          ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignal          & cmdRemoveSignal          )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignalList      & cmdRemoveSignalList      ) {
//  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignalList      & cmdRemoveSignalList      )");
//  //ignore this node
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdRemovePort& cmdRemovePort) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdRemovePort& cmdRemovePort)");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdRemovePortList& cmdRemovePortList) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdRemovePortList& cmdRemovePortList)");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetInstanceAlterationBit & cmdSetInstanceAlterationBit ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdSetInstanceAlterationBit & cmdSetInstanceAlterationBit )");
//  //ignore this node
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdGenerateIndividualRTLSignals & cmdGenerateIndividualRTLSignals ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdGenerateIndividualRTLSignals & cmdGenerateIndividualRTLSignals )");
//  //ignore this node
//}
//
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInterface             & cmdAddInterface             ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInterface             & cmdAddInterface             )");
//  //ignore this node
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddUnitParameter         & cmdAddUnitParameter         ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdAddUnitParameter         & cmdAddUnitParameter         )");
//  //ignore this node
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdOverrideUnitParameter    & cmdOverrideUnitParameter    ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdOverrideUnitParameter    & cmdOverrideUnitParameter    )");
//  //ignore this node
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdInputVerilogType         & cmdInputVerilogType         ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdInputVerilogType         & cmdInputVerilogType         )");
//  //TODO
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdOutputVerilogType        & cmdOutputVerilogType        ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdOutputVerilogType        & cmdOutputVerilogType        )");
//  //TODO
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdReverse                  & cmdReverse                  ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdReverse                  & cmdReverse                  )");
//  //ignore this node
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdConnect                  & cmdConnect                  ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdConnect                  & cmdConnect                  )");
//  //ignore this node
//}
// 
//void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdConnectSplit             & cmdConnectSplit             ) {
//  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmCmdConnectSplit             & cmdConnectSplit             )");
//  //ignore this node
//}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmParameter                   & parameter                   ) {
  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmParameter                   & parameter                   )");
  ASSERT(parameter.get(), "CSLOmParameterBT: Parameter is null.");
  ASSERT(m_cslCurrParent.get(), "CSLOmParameterBT: Null csl parent.");
  ASSERT(m_cslCurrParent->isUnitDecl() || m_cslCurrParent->getType() == TYPE_INST_UNIT || m_cslCurrParent->isInterface() || m_cslCurrParent->isSignalGroup(), 
         "CSLOmParameterBT: The type of the current parent must be CSLOmUnitDecl or CSLOmUnitInstance or CSLOmInterface or CSLOmSignalGroup.");
  ASSERT(m_cdomCurrParent.get(), "CSLOmParameterBT: Null CDOM parent");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DECL_MODULE || m_cdomCurrParent->getType() == NSCdom::TYPE_MODULE_INSTANTIATION, 
         "CSLOmParameterBT: The type of the current parent must be CDOmModuleDecl or CDOmModuleOrUdpInstantiation");

  //RefTVec_RefCSLOmBase paramChildren = parameter->getChildrenAsBase();
  //DCERR("Param has " << paramChildren->size() << " children." << endl);
  //DCERR("Child types:" << endl);
  //for(TVec_RefCSLOmBase::const_iterator it = paramChildren->begin(); it < paramChildren->end(); ++it) {
  //  DCERR((*it)->getType() << endl);
  //  
  //}


  //const RefString paramName = parameter->getParamName();
  //RefCSLOmExpr defaultValue = parameter->getDefaultValue();
  //RefCDOmMinTypMax cdomMinTypMax(0);
  //if(defaultValue.get()) {
  //  defaultValue->acceptVisitor(*this);
  //  ASSERT(m_cdomReturnedValue.get(), "Null cdom returned value");
  //  ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "The type of the returned value is not expr");
  //  cdomMinTypMax = buildCDOmMinTypMax(m_cdomReturnedValue->getLineNumber(), boost::static_pointer_cast<CDOmExpr>(m_cdomReturnedValue));
  //}
  //RefCDOmParamDecl paramDecl = buildCDOmParamDecl(paramDecl->getLineNumber(), m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  //paramDecl->addParam(paramDecl->getLineNumber(), paramName, cdomMinTypMax);
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmListExpr &listExpr) {
  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmListExpr &listExpr)");
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall &exprHybridOrFuncCall) {
  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall &exprHybridOrFuncCall)");
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature &exprFuncSignature) {
  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature &exprFuncSignature)");
}

// void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmTestbenchDecl &testbenchDecl) {
//   TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmTestbenchDecl &testbenchDecl)");
//   ASSERT(testbenchDecl.get(), "Testbench declaration is null");
//   ASSERT(m_cslCurrParent.get(), "The csl current parent is null");
//   ASSERT(m_cdomCurrParent.get(), "The cdom current parent is null");
//   ASSERT(m_cslCurrParent->isDesign(), "The csl current parent is not the design");
//   ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DESIGN, "The cdom current parent is not the design");

//   RefCDOmModuleDecl moduleDecl = CDOmDesign::cast(m_cdomCurrParent)->buildModuleDecl( testbenchDecl->getLineNumber(), testbenchDecl->getName());
//   m_cslCurrParent = testbenchDecl;
//   m_cdomCurrParent = moduleDecl;
// }

// void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmTestbenchVector &testbenchVector) {
//   TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmTestbenchVector &testbenchVector)");
//   ASSERT(testbenchVector.get(), "Testbench vector is null");
//   ASSERT(m_cslCurrParent.get(), "The csl current parent is null");
//   ASSERT(m_cdomCurrParent.get(), "The cdom current parent is null");
//   ASSERT(m_cslCurrParent->isTestbenchDecl(), "The csl current parent is not a testbench declaration");
//   ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DECL_MODULE, "The cdom current parent is not a module declaration");

//   m_cslCurrParent = testbenchVector;
//}

/*
void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride &parameterOverride) {
  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride &parameterOverride)");
  ASSERT(parameterOverride.get(), "Null parameterOverride");

  //RefCSLOmExpr value = parameterOverride->getValue();
  //ASSERT(value.get(), "NULL value in parameterOverride");
  //value->acceptVisitor(*this);
  //ASSERT(m_cdomReturnedValue.get(), "null returned value");
  //ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "The returned type is not an expression");
  //RefCDOmMinTypMax cdomMinTypMax = buildCDOmMinTypMax(m_cdomReturnedValue->getLineNumber(), boost::static_pointer_cast<CDOmExpr>(m_cdomReturnedValue));
  //m_cdomReturnedValue = RefCDOmBase();

  //const RefString name = parameterOverride->getParamName();
  //ASSERT(name.get(), "NULL name in parameterOverride");
  //RefCDOmExprLink cdomLink = buildCDOmExprLink(parameterOverride->getLineNumber(), name);
  //
  //ASSERT(m_cdomCurrParent.get(), "Null cdom parent")
  //RefCDOmParamOverride paramOverride = buildCDOmParamOverride(paramOverride->getLineNumber(), m_cdomCurrParent, cdomLink, cdomMinTypMax);

  //m_cdomReturnedValue = paramOverride;
}
*/

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmEnum                    &enumeration) {
  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmEnum &enumeration)");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DESIGN, "Enum must be a child of the design");
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmField                   &field) {
  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmField &field)");
  ASSERT(m_cslCurrParent.get(), "Parent of csl field is null");
  //ASSERT(m_cslCurrParent->isSignal() || m_cslCurrParent->isField(), "Parent of csl field is not a signal nor another field");  
  m_cslCurrParent = field;

}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {}
void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmAddressRange      & addressRange      )");
  DCERR(m_cdomCurrParent->getType() << endl);
  //ASSERT(m_cslCurrParent->getType() == TYPE_CONTAINER, "Parent of addressRange is not a container");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DESIGN, "Cdom current parent is not of type design");

}
void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation      & memoryMapLocation      )");
  ASSERT(m_cslCurrParent->getType() == TYPE_MEMORY_MAP_PAGE, "Parent of memmapLocation is not a memmapPage");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DESIGN, "Parent of define directive is not of type design");

  m_cslCurrParent = memoryMapLocation;

  m_memMapLocations->push_back(memoryMapLocation);
  
  //RefString objectName;
  //RefCSLOmIdentifier id = memoryMapLocation->getSymbol(); 
  //RefCSLOmBase object = memoryMapLocation->getAddressableObject();
  //if(object->isSignal()) {
  //  RefCSLOmSignal sig = CSLOmSignal::cast(object);
  //  objectName = sig->getID()->getName();
  //}
  
  //RefCSLOmAddressRange addr = memoryMapLocation->getLocalAddress();
  //RefCSLOmNum32 addrLower = CSLOmNum32::cast(addr->getLower());
  //
  //RefCDOmDefine define = buildCDOmDefine(memoryMapLocation->getLineNumber(), 
  //                                    m_cdomCurrParent, 
  //                                    CDOmDefine::DEFINE_TYPE_DEFINE,
  //                                    id->getName(),
  //                                    buildCDOmExprLink(memoryMapLocation->getLineNumber(), 
  //                                                      RefString(new string(*ltos(addrLower->getValue())))
  //                                                     )
  //                                   );
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage      & memoryMapPage      )");
  m_cslCurrParent = memoryMapPage;
  DCERR("In memmap page" << endl);
}
void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
}

void CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {
  m_cslCurrParent = stmtAssign;
  m_insideAssign = TRUE;
  //RefTVec_RefCSLOmBase children = stmtAssign->getChildrenAsBase();
  //for(TVec_RefCSLOmBase::const_iterator it = children->begin(); it < children->end(); ++it) {
  //  DCERR("cslom stmt assign child " << CSLOmExpr::cast(*it)->getExprType() << endl);
  //  }
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ) {
  TRACE_ME(0,"CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      )");
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
  if(m_unitType == UNIT_TYPE_TESTBENCH_DECL 
     && m_cslReturnedValue.get() 
     && m_cslReturnedValue->getType() == NSCSLOm::TYPE_INST_UNIT
     && m_cdomReturnedValue.get()) {
    RefCSLOmUnitInstance unitInstance = CSLOmUnitInstance::cast(m_cslReturnedValue);
    if(unitInstance->getUnitDecl()->getUnitType() == CSLOmUnitDecl::CSL_VECTOR) {
      m_tbVectorInstances->push_back(m_cslReturnedValue);
    }
  }
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {
  ASSERT(m_cslCurrParent.get(), "CSLOmInstanceIT: CSL parent is null");
  ASSERT(m_cslCurrParent->getType() == TYPE_INST_UNIT, "CSLOmInstanceIT: CSL parent is not of type unit instance");
  ASSERT(m_cdomCurrParent.get(), "CSLOmInstanceIT: CDOM parent is null");
  ASSERT(m_cdomCurrParent->getType() == TYPE_MODULE_INSTANTIATION, "CSLOmInstanceIT: CDOM parent is not of type module instantiation");
  if(m_cslReturnedValue->getType() == TYPE_PARAMETER) {
    ASSERT(m_cslReturnedValue.get(), "CSLOmInstanceIT: CSL returned value is null");
    ASSERT(m_cslReturnedValue->getType() == TYPE_PARAMETER, "CSLOmInstanceIT: CSL returned value is not of type parameter") ;
    ASSERT(m_cdomReturnedValue.get(), "CSLOmInstanceIT: CDOM returned value is null");
    ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "CSLOmInstanceIT: CDOM returned value is not of type expr");

    RefCDOmModuleOrUdpInstantiation cdomInstantiation = CDOmModuleOrUdpInstantiation::cast(m_cdomCurrParent);
    RefCSLOmParameter param = CSLOmParameter::cast(m_cslReturnedValue);
    ASSERT(param->isOvr(), "CSLOmUnitInstanceIT: Only params of type override can be children for unit instance nodes.");
    RefCSLOmExprLink paramDeclLink = CSLOmExprLink::cast(param->getChild(ID));//first child of instance ovr param is link to the param decl in the original unit decl

    RefCSLOmUnitDecl unit = CSLOmUnitInstantiation::cast(m_cslCurrParent->getParent())->getUnitDecl();
    RefCSLOmScope unitScope = unit->getAttachedScope();
    CSLOmScopeBlock::enterScope(unitScope);
    paramDeclLink->doEval();
    CSLOmScopeBlock::exitScope();

    ASSERT(paramDeclLink->getValue().get() && paramDeclLink->getValue()->isParameter(), "CSLOmUnitInstanceIT: ovr param points to a param decl that evaluates to null or an illegal type.");
    RefCSLOmParameter paramDecl = CSLOmParameter::cast(paramDeclLink->getValue());


    //mihaelaP
    if(param->isOveriden()) { 
      DCERR("unitInstIT: paramDecl name: " << *(paramDecl->getName()) << endl);
      cdomInstantiation->addNamedParamAssn(paramDecl->getName(),
                                           buildCDOmMinTypMax(unitInst->getLineNumber(), CDOmExpr::cast(m_cdomReturnedValue)));
    }
  }
}


void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  if(m_isOrdinarySimpleBrOrDimZero) {
    if(!m_simpleBitRangeIT) {
      ASSERT(m_cdomReturnedValue.get(), "Cdom returned value is null");
      ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "Cdom returned value is of illegal type");

      m_cdomTraversedChildren->push_back(m_cdomReturnedValue);  
    }
    else {
      m_simpleBitRangeIT = FALSE;
    }
  }
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation & unitInstantiation)");
  if(m_inTraversalForUnitInstantiation)
    return;
  else {  //inTraversal should be executed only after the first child has been visited
    RefCDOmModuleOrUdpInstantiation moduleOrUdpInstantiation;
    RefCDOmExprLink exprLink;

    if((CSLOmUnitDecl::cast(unitInstantiation->getUnitDeclExprLink()->getLocalNameID()->getParent()))->getUnitType() != CSLOmUnitDecl::CSL_VECTOR) {
      exprLink = boost::static_pointer_cast<CDOmExprLink>(m_cdomReturnedValue);
      ASSERT(exprLink.get(), "exprLink is null");    
      moduleOrUdpInstantiation= buildCDOmModuleOrUdpInstantiation(unitInstantiation->getLineNumber(), m_cdomCurrParent, exprLink);
    }
    else {
      exprLink = buildCDOmExprLink(unitInstantiation->getLineNumber(), m_vectorModuleName);
      moduleOrUdpInstantiation = buildCDOmModuleOrUdpInstantiation(unitInstantiation->getLineNumber(), m_cdomCurrParent,exprLink);
    }
    m_cdomCurrParent = moduleOrUdpInstantiation;
    ++m_inTraversalForUnitInstantiation; 
  }
}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {

  TRACE_ME(0,"CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmExprOp     & exprOp            )");
  ASSERT(exprOp.get(), "The input expression is null");
  ASSERT(m_cdomReturnedValue.get(), "The cdom returned value wasn't set");
  ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "Cdom returned value is not an expression");

  m_cdomTraversedChildren->push_back(m_cdomReturnedValue); 
  m_cdomReturnedValue = RefCDOmBase(); 
  
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {
  ASSERT(m_cdomReturnedValue.get(), "Cdom returned value is null") ;
  ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR 
         /*|| m_cdomReturnedValue->getType() == NSCdom::TYPE_RANGE_EXPR*/, "The cdom returned value isn't of type CDOmExpr or CDOmRangeExpr");

  m_cdomTraversedChildren->push_back(m_cdomReturnedValue);

}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
  ASSERT(m_cdomReturnedValue.get(), "Cdom returned value is null");
  ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "Cdom returned value is not an expression");

  m_cdomTraversedChildren->push_back(m_cdomReturnedValue);
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {}  
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmSetCommand                      & setCommand                      ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetWidth                     & cmdSetWidth                     ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetBitRange                  & cmdSetBitRange                  ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetOffset                    & cmdSetOffset                    ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetLowerIndex                & cmdSetLowerIndex                ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetUpperIndex                & cmdSetUpperIndex                ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetRange                     & cmdSetRange                     ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetNumberOfDimensions        & cmdSetNumberOfDimensions        ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetDimWidth                  & cmdSetDimWidth                  ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetDimBitRange               & cmdSetDimBitRange               ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetDimOffset                 & cmdSetDimOffset                 ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetDimLowerIndex             & cmdSetDimLowerIndex             ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetDimUpperIndex             & cmdSetDimUpperIndex             ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetDimRange                  & cmdSetDimRange                  ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetUnitPrefix                & cmdSetUnitPrefix                ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefix              & cmdSetSignalPrefix              ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefixLocal         & cmdSetSignalPrefixLocal         ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetType                      & cmdSetType                      ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetAttr                      & cmdSetAttr                      ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddInstance                  & cmdAddInstance                  ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddInstanceList              & cmdAddInstanceList              ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddSignal                    & cmdAddSignal                    ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddSignalList                & cmdAddSignalList                ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddSignalGroup               & cmdAddSignalGroup               ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddPort                      & cmdAddPort                      ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddPortList                  & cmdAddPortList                  ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignal                 & cmdRemoveSignal                 ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignalList             & cmdRemoveSignalList             ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdRemovePort                   & cmdRemovePort                   ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdRemovePortList               & cmdRemovePortList               ) {} 
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdSetInstanceAlterationBit     & cmdSetInstanceAlterationBit     ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdGenerateIndividualRTLSignals & cmdGenerateIndividualRTLSignals ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddInterface                 & cmdAddInterface                 ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdAddUnitParameter             & cmdAddUnitParameter             ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdOverrideUnitParameter        & cmdOverrideUnitParameter        ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdInputVerilogType             & cmdInputVerilogType             ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdOutputVerilogType            & cmdOutputVerilogType            ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdReverse                      & cmdReverse                      ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdConnect                      & cmdConnect                      ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmCmdConnectSplit                 & cmdConnectSplit                 ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {}
// void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmTestbenchDecl                   & testbenchDecl                   ) {}
//void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmTestbenchVector                 & testbenchVector                 ) {}

/*
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) {
  ASSERT(m_cdomReturnedValue.get(), "The cdom returned value is null");
  ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "The cdom returnd value isn't an expression");

  RefCDOmExpr cdomExpr = CDOmExpr::cast(m_cdomReturnedValue);
  RefCDOmMinTypMax cdomMinTypMax = buildCDOmMinTypMax(m_cdomReturnedValue->getLineNumber(), cdomExpr);

  RefString name = parameterOverride->getParamName();
  RefCDOmExprLink cdomExprLink = buildCDOmExprLink(parameterOverride->getLineNumber(), name);

  RefCDOmParamOverride cdomParamOverride = 
    buildCDOmParamOverride(parameterOverride->getLineNumber(), m_cdomCurrParent, cdomExprLink, cdomMinTypMax);
}
*/

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {

  //RefCSLOmAddressRange global = memoryMapLocation->getGlobalAddress();
  //RefCSLOmAddressRange local = memoryMapLocation->getLocalAddress();
  //
  //RefCSLOmNum32 globalLow = CSLOmNum32::cast(global->getLower());
  //RefCSLOmNum32 globalUp = CSLOmNum32::cast(global->getUpper());
  //RefCSLOmNum32 localLow = CSLOmNum32::cast(local->getLower());
  //RefCSLOmNum32 localUp = CSLOmNum32::cast(local->getUpper());
  //
  //RefCSLOmIdentifier id = memoryMapLocation->getSymbol(); 
  //RefString globalLowName = id->getName();
  //globalLowName->append("GLOBAL_LOWER");
  //RefString globalUpName = id->getName();
  //globalUpName->append("GLOBAL_UPPER");
  //RefString localLowName = id->getName();
  //localLowName->append("LOCAL_LOWER");
  //RefString localUpName = id->getName();
  //localUpName->append("LOCAL_UPPER");
  //
  //RefCDOmDefine defineGlobalLower = buildCDOmDefine(memoryMapLocation->getLineNumber(), 
  //                                    m_cdomCurrParent, 
  //                                    CDOmDefine::DEFINE_TYPE_DEFINE,
  //                                    globalLowName,
  //                                    buildCDOmExprLink(memoryMapLocation->getLineNumber(), 
  //                                                      RefString(new string(*ltos(globalLow->getValue())))
  //                                                     )
  //                                   );
  //RefCDOmDefine defineGlobalUpper = buildCDOmDefine(memoryMapLocation->getLineNumber(), 
  //                                    m_cdomCurrParent, 
  //                                    CDOmDefine::DEFINE_TYPE_DEFINE,
  //                                    globalUpName,
  //                                    buildCDOmExprLink(memoryMapLocation->getLineNumber(), 
  //                                                      RefString(new string(*ltos(globalUp->getValue())))
  //                                                     )
  //                                   );
  //RefCDOmDefine defineLocalLower = buildCDOmDefine(memoryMapLocation->getLineNumber(), 
  //                                    m_cdomCurrParent, 
  //                                    CDOmDefine::DEFINE_TYPE_DEFINE,
  //                                    localLowName,
  //                                    buildCDOmExprLink(memoryMapLocation->getLineNumber(), 
  //                                                      RefString(new string(*ltos(localLow->getValue())))
  //                                                     )
  //                                   );
  //RefCDOmDefine defineLocalUpper = buildCDOmDefine(memoryMapLocation->getLineNumber(), 
  //                                    m_cdomCurrParent, 
  //                                    CDOmDefine::DEFINE_TYPE_DEFINE,
  //                                    localUpName,
  //                                    buildCDOmExprLink(memoryMapLocation->getLineNumber(), 
  //                                                      RefString(new string(*ltos(localUp->getValue())))
  //                                                     )
  //                                   );


}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {}
void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {

  ASSERT(m_cdomReturnedValue.get(), "stmtAssn has a null child");
  ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR , "stmtAssn has a child of illegal type");
  m_cdomTraversedChildren->push_back(m_cdomReturnedValue);
  m_insideAssign = FALSE;
  
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ) {
  TRACE_ME(0,"CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      )");
}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmEnum                & enumeration               ) {
  ASSERT(m_cslReturnedValue.get(), "Enum:IT cslReturnedValue is null");
  ASSERT(m_cslReturnedValue->getType() == NSCSLOm::TYPE_ID_SIMPLE, "Enum's name should be an ID");
  if(!m_firstCallOfEnumIT) { //first child is the enum name
    ASSERT(CSLOmIdentifier::cast(m_cslReturnedValue)->getIdType() == CSLOmIdentifier::ID_ENUM, "Enums name should be an id of type ID_ENUM");
    ++m_firstCallOfEnumIT;
    RefCSLOmIdentifier enumItem = CSLOmIdentifier::cast(m_cslReturnedValue);
    //m_enumName = enumItem->getUpperName();
    m_enumName = enumItem->getName();
  }
  else {
    ASSERT(CSLOmIdentifier::cast(m_cslReturnedValue)->getIdType() == CSLOmIdentifier::ID_ENUM_ITEM, 
        "Enum's children should be ids of type ID_ENUM_ITEM");
    ASSERT(m_enumName.get(), "Enum has no name");
    
    RefCSLOmIdentifier enumItem = CSLOmIdentifier::cast(m_cslReturnedValue);
    RefString enumItemName = RefString(new string(""));
    enumItemName->append(*m_enumName);
    enumItemName->append("_");
    enumItemName->append(*(enumItem->getName()));
    
    if((enumItem->getPayload()).get()) {
      ASSERT((enumItem->getPayload())->getType() ==NSCSLOm:: TYPE_EXPR, "Enum item's payload is not an expr");
      ASSERT(CSLOmExpr::cast(enumItem->getPayload())->getExprType() == CSLOmExpr::EXPR_NUMBER, "Enum item's payload is not a number");
      m_enumItemVal = CSLOmNum32::cast(enumItem->getPayload())->getValue();
      RefCDOmNum32 enumItemValue = buildCDOmNum32WithValue(enumeration->getLineNumber(), m_enumItemVal);
      //RefCDOmNum32 enumItemValue = buildCDOmNum32WithString(enumeration->getLineNumber(), CDOmNumber::NUM_BASE_BIN, RefString(new string("5")));
      
      //RefCDOmDefine def = buildCDOmDefine  (enumeration->getLineNumber(), 
      //                                      m_cdomCurrParent, 
      //                                      CDOmDefine::DEFINE_TYPE_DEFINE, 
      //                                      enumItemName,
      //                                      enumItemValue
      //                                     );
    }
    else {
      RefCDOmNum32 enumItemValue = buildCDOmNum32WithValue(enumeration->getLineNumber(), m_enumItemVal+1);
      //RefCDOmDefine def = buildCDOmDefine(enumeration->getLineNumber(), 
      //                                      m_cdomCurrParent, 
      //                                      CDOmDefine::DEFINE_TYPE_DEFINE, 
      //                                      enumItemName,
      //                                      enumItemValue
      //                                     );
      ++m_enumItemVal;
    }
  }

}

void CAdapterToCDOM::inTraversal(const NSCSLOm::RefCSLOmField                & field               ) {
}



void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
    m_memMapLocations->clear();
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {
  m_cslCurrParent = m_cslCurrParent->getParent();  
  ASSERT(exprLink.get(), "The input expression link is null.");
  ASSERT(m_cslCurrParent.get(), "Null m_cslCurrParent received.");

  NSCdom::RefCDOmBase cdomExprLink = NSCdom::RefCDOmBase();
  RefString exprLinkName = exprLink->getName();
  RefCSLOmBase expr = exprLink->doEval();
  if(exprLink->isHID())  {
    if (expr->isPort() || expr->isSignal()) {
      NSCSLOm::RefCSLOmConnectable obj = CSLOmConnectable::cast(expr);
      RefString name = RefString(new std::string(""));
      map<RefCSLOmConnectable, RefString>::const_iterator it = m_allPortsSignalsNames.find(obj);
      if(it != m_allPortsSignalsNames.end()) {
        name = RefString(it->second);
      } 
      else {
      NSCSLOm::RefCSLOmExprLink expr = obj->getF2ALink();
      RefTVec_RefString temp = expr->getHidNames();
      RefCSLOmBase vecCurParent=RefCSLOmBase();
      TVec_RefString::iterator iter = temp->end()-1;
      
      vecCurParent=obj->getParent();
      //name->append(*(*iter));
      iter--;
      for (; iter >= temp->begin(); iter--) {
        if(vecCurParent->isInterface() && !CSLOmInterface::cast(vecCurParent)->isDefaultIfc()){
          RefCSLOmInterface ifc=CSLOmInterface::cast(vecCurParent);
          if(!ifc->getNoPrefixBit()){
            if(!(ifc->getPrefix()).get()){
              name->insert(0,"_");
              name->insert(0,*(*iter));
            }
            else{
              name->insert(0,"_");
              name->insert(0,*ifc->getPrefix());
            }
          }
          if(ifc->getSuffix().get()) {
            name->append(*ifc->getSuffix());
            name->append("_");
          }
        }
        else if(vecCurParent->isSignalGroup()){
          RefCSLOmGroupSignal sg=CSLOmGroupSignal::cast(vecCurParent);
          if(!sg->getNoPrefixBit()){
            if(!(sg->getPrefix()).get()){
              name->insert(0,"_");
              name->insert(0,*(*iter));
            }
            else{
              name->insert(0,"_");
              name->insert(0,*sg->getPrefix());
            }
          }
          if(sg->getSuffix().get()) {
            name->append(*sg->getSuffix());
            name->append("_");
          }
        }
        else{
          name->insert(0,"_");
          name->insert(0,*(*iter));
        }
        
        vecCurParent=vecCurParent->getParent();
      }
      name->append(*exprLinkName);
      }
      cdomExprLink = buildCDOmExprLink(exprLink->getLineNumber(), name);  
    }
    else {
      const RefTVec_RefString names = exprLink->getHidNames();
      for(TVec_RefString_const_iter it = names->begin(); it < names->end(); ++it) {
        if(!cdomExprLink.get()) {
          cdomExprLink = buildCDOmExprLink(exprLink->getLineNumber(), *it);
        }
        else {
          CDOmExprLink::cast(cdomExprLink)->addHidItem(*it);
        }
      }
      if(expr.get() && expr->isInterface()) {
        RefCSLOmInterface ifc = CSLOmInterface::cast(expr);
        m_assignIfcOrSg.push_back(ifc);
      }
      else if(expr.get() && expr->isSignalGroup()) {
        RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(expr);
        m_assignIfcOrSg.push_back(sg);
      }
    }
  }
  else {
    //added by MP for parameters in interfaces and signal groups
    //If the expr link is a reference towards a overriden parameter from an interface or signal group,
    //the returned value will be the value of the parameter and not an expr link.
    if(expr.get() && expr->isInterface()) {
      RefCSLOmInterface ifc = CSLOmInterface::cast(expr);
      m_assignIfcOrSg.push_back(ifc);
    }
    else if(expr.get() && expr->isSignalGroup()) {
      RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(expr);
      m_assignIfcOrSg.push_back(sg);
    }
    cdomExprLink = buildCDOmExprLink(exprLink->getLineNumber(), exprLinkName); 
    RefCSLOmBase parent = m_cslCurrParent;
    while (parent.get() && !parent->isDesign()) {
      if(parent->isInterface()) {
        RefCSLOmInterface ifc = CSLOmInterface::cast(parent);
      //      if(parent->isPort()) {
        /*    if(parent->getParent()->isInterface()) {
              RefCSLOmInterface ifc = CSLOmInterface::cast(parent->getParent());*/
          if(!ifc->isDefaultIfc()) {
            RefCSLOmScope ifcScope = ifc->getAttachedScope();
            CSLOmScopeBlock::enterScope(ifcScope);
            RefCSLOmBase param = exprLink->doEval();
            CSLOmScopeBlock::exitScope();
            if(param->isParameter() && CSLOmParameter::cast(param)->isOvr()) {
              RefCSLOmExpr value = CSLOmParameter::cast(param)->getValue();
              cdomExprLink = buildCDOmNum32WithValue(exprLink->getLineNumber(), CSLOmNum32::cast(value)->getValue());
            }
          }
          //}
        break;
      }
      else if(parent->isSignalGroup()) {
        RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(parent);
        /*if(parent->isSignal()) {
        if(parent->getParent()->isSignalGroup()) {
        RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(parent->getParent());*/
          RefCSLOmScope sgScope = sg->getAttachedScope();
          CSLOmScopeBlock::enterScope(sgScope);
          RefCSLOmBase param = exprLink->doEval();
          CSLOmScopeBlock::exitScope();
          if(param->isParameter() && CSLOmParameter::cast(param)->isOvr()) {
            RefCSLOmExpr value = CSLOmParameter::cast(param)->getValue();
            cdomExprLink = buildCDOmNum32WithValue(exprLink->getLineNumber(), CSLOmNum32::cast(value)->getValue());
          }
          //}
        break;
      }
      else if(parent->isExprLink()) {
        RefCSLOmBase parentExpr = CSLOmExprLink::cast(parent)->doEval();
        if(parentExpr.get()) {
          parent = parentExpr;
        }
      }
      else {
        parent = parent->getParent();
      }
    }
    //end added by MP
  }
  if(m_cdomReturnedValue.get() && (m_cdomReturnedValue->getType() == TYPE_RANGE_EXPR)) {
    CDOmExprLink::cast(cdomExprLink)->setRangeExpr(CDOmRangeExpr::cast(m_cdomReturnedValue));
  }
  m_cdomReturnedValue = cdomExprLink;
  ASSERT(m_cdomReturnedValue.get(), "exprLink is null");
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
  if (!unitDecl->isSetDoNotGenerateRTL()) {
    RefCSLOmUnitInfo info = unitDecl->getUnitInfo();
    RefCDOmModuleDecl memModuleDecl;
    RefCDOmBase auxParent;
    RefString memName = RefString(new string(*(unitDecl->getName())));
    switch(m_unitType) {
      case UNIT_TYPE_FIFO_DECL:  
        memName ->append("_fifo_memory");
        adaptFifoModule(unitDecl, memName);                   
        memModuleDecl = CDOmDesign::cast(m_cdomCurrParent->getParent())->buildModuleDecl( unitDecl->getLineNumber(), memName );
        auxParent = m_cdomCurrParent;
        m_cdomCurrParent = memModuleDecl;
        adaptMemoryModule(unitDecl);
        m_cdomCurrParent = auxParent;
        m_cdomFifoPorts.clear();
        break;
      case UNIT_TYPE_REGISTER_FILE_DECL:  
        memName->append("_register_file_memory");
        adaptRegisterFileModule(unitDecl, memName);   
        memModuleDecl = CDOmDesign::cast(m_cdomCurrParent->getParent())->buildModuleDecl( unitDecl->getLineNumber(), memName );
        auxParent = m_cdomCurrParent;
        m_cdomCurrParent = memModuleDecl;
        adaptMemoryModule(unitDecl);
        m_cdomCurrParent = auxParent;
        m_cdomRegisterFilePorts.clear();
        break;
      case UNIT_TYPE_TESTBENCH_DECL:
        adaptTestbenchModule(unitDecl);
        break;
      case UNIT_TYPE_VECTOR_DECL:
        adaptVectorModule(unitDecl);
        break;
      case UNIT_TYPE_MEM_DECL:
        adaptMemoryModule(unitDecl);
        break;
      case UNIT_TYPE_REGISTER_DECL:
        adaptRegisterModule(unitDecl);
        //DCERR("Under Construction" << endl);
        //default:
        //adaptUnitRegistersEnableLogicModule(unitDecl, RefString(new string("bus_addr")), RefString(new string("bus_en")));
        
    }
    
    m_unitType = UNIT_TYPE_UNIT_DECL;
    m_cslCurrParent = unitDecl->getParent();
    if(unitDecl->getUnitType() != CSLOmUnitDecl::CSL_VECTOR || unitDecl->getUnitType() == CSLOmUnitDecl::CSL_VECTOR && !m_tbVectorDone) {
      m_cdomCurrParent = m_cdomCurrParent->getParent();
      if(unitDecl->getUnitType() == CSLOmUnitDecl::CSL_VECTOR && !m_tbVectorDone) {
        m_tbVectorDone = TRUE;
      }
    }
    m_unitPrefix = RefString();
    if(m_tbVectorInstances.get() && m_tbVectorInstances->size()) {
      m_tbVectorInstances->clear();
    }
  }
  else {
    enableChildrenTraversal();
  }
}


void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
  m_cslCurrParent = m_cslCurrParent->getParent();
  
  if(m_generateIndividualSignals) { 

    //section 1: compute the number of verilog signals to generate

    TInt nrOfSigs = 1;

    if(signal->getBitRange()->isMultiDimBitRange()) {//m_cdomReturnedValue stores dimension zero, if not null
      RefCSLOmSimpleBitRange dimZero = (CSLOmMultiDimBitRange::cast(signal->getBitRange()))->getDimZero();
      RefTVec_RefCSLOmSimpleBitRange dimensions = signal->getBitRange()->getChildren<CSLOmSimpleBitRange>(TYPE_ALL_SIMPLE_BR);
      for(TVec_RefCSLOmSimpleBitRange::const_iterator it = dimensions->begin(); it < dimensions->end(); ++it) {
        RefCSLOmExpr width = RefCSLOmExpr();
        if(dimZero.get() && dimZero != *it || !dimZero.get()) {
          width = (*it)->getWidth();
          nrOfSigs *= CSLOmNumber::cast(width->doEval())->getValue();
        }
      }
    }

    //section 2: build the cdom range from the csl bitrange stored in m_cdomReturnedValue if not null

    
    RefCDOmRange range;
    if(m_cdomReturnedValue.get()) {
      range = CDOmRange::cast(m_cdomReturnedValue);
      m_cdomReturnedValue = RefCDOmBase();
    }
    else { //no dim 0 set
      range = buildCDOmRange(signal->getLineNumber(), buildCDOmNum32WithValue(signal->getLineNumber(), 0), buildCDOmNum32WithValue(signal->getLineNumber(), 0));
    }

    //section 3: build the net/var and set the cdom current parent

    ECDOmNetType netType = getCDOmNetType(signal->getSignalType());
    ECDOmVarType varType = getCDOmVarType(signal->getSignalType());
    RefCDOmNetDecl netDecl;
    RefCDOmVarDecl varDecl;
    if(netType != NET_UNDEFINED) {  
      netDecl = buildCDOmNetDecl(signal->getLineNumber(), m_cdomCurrParent, netType, range );
    }
    else if(varType != VAR_UNDEFINED && varType != VAR_TIME && varType != VAR_INTEGER && varType != VAR_REAL) {
      varDecl = buildCDOmVarDecl(signal->getLineNumber(), m_cdomCurrParent, varType, range );
    }
    else {//var time, integer and real have implicit ranges
      varDecl = buildCDOmVarDecl(signal->getLineNumber(), m_cdomCurrParent, varType);
    }

    //section 4: name the nets/vars
    
    for(TInt i = 0; i<nrOfSigs; ++i) {  
      RefString fullName = RefString(new string());
      if(m_unitPrefix.get()) {
        fullName->append(*m_unitPrefix);
      }
      if(m_sigGroupPrefixes.get() && m_sigGroupPrefixes->size()>=1) {
        for(TVec_RefString_const_iter it = m_sigGroupPrefixes->begin(); it<m_sigGroupPrefixes->end(); ++it) {
          if((*it).get()) {
            fullName->append(*(*it));
            fullName->append("_");
          }
        }
      }
      if(m_sigGroupSuffixes.get() && m_sigGroupSuffixes->size()>=1) {
        for(TVec_RefString_const_iter it = m_sigGroupSuffixes->begin(); it<m_sigGroupSuffixes->end(); ++it) {
          fullName->append(*(*it));
          fullName->append("_");
        }
      }
      fullName->append(std::string(*(signal->getName())));
      if (nrOfSigs > 1) {
        fullName->append(std::string("_"));
        fullName->append(*ltos(i));
      }
    
      //avoid name collisions
      TInt idx = 0;
      TBool isAppended = TRUE;
      RefString baseSignalName = RefString(new string(*fullName));
      if(!m_allCdomSignals.empty()) {
        while(isAppended) {
          for(map<RefString, RefString>::const_iterator it = m_allCdomSignals.begin(); it != m_allCdomSignals.end(); ++it) {
            //DCERR("type of port's first child: " << it->first->getChild(0)->getType() << endl);
            RefString idName = it->first;
            RefString moduleName = CDOmIdentifier::cast(CDOmModuleDecl::cast(m_cdomCurrParent)->getChild(0))->getName();
            if((*idName == *fullName) && (*(it->second) == *moduleName)) {
              fullName = RefString(new string(*baseSignalName));
              fullName->append("_");
              fullName->append(*ltos(idx++));
              isAppended = TRUE;
              break;
            }
            else {
              isAppended = FALSE;
            }
          }
        }
      }
      baseSignalName = RefString(new string(*fullName));
      isAppended = TRUE;
      if(!m_allCdomPorts.empty()) {
        while(isAppended) {
          for(map<RefCDOmPortDecl, RefString>::const_iterator it = m_allCdomPorts.begin(); it != m_allCdomPorts.end(); ++it) {
            //DCERR("type of port's first child: " << it->first->getChild(0)->getType() << endl);
            RefString idName = it->first->getIDs()->at(0)->getName();
            RefString moduleName = CDOmIdentifier::cast(CDOmModuleDecl::cast(m_cdomCurrParent)->getChild(0))->getName();
            if((*idName == *fullName) && (*(it->second) == *moduleName)) {
              fullName = RefString(new string(*baseSignalName));
              fullName->append("_");
              fullName->append(*ltos(idx++));
              isAppended = TRUE;
              break;
            }
            else {
              isAppended = FALSE;
            }
          }
        }
      }

      //section 13: include the cdom port and the parent cdom module in the m_allCdomPorts map for later port name generation(name collisions)
      m_allPortsSignalsNames.insert(pair<RefCSLOmConnectable, RefString>(CSLOmConnectable::cast(signal), fullName));
      RefString moduleName = CDOmIdentifier::cast(CDOmModuleDecl::cast(m_cdomCurrParent)->getChild(0))->getName();
      m_allCdomSignals.insert(pair<RefString, RefString>(fullName, moduleName));

      if(netDecl.get()) {
        netDecl->addNet(signal->getLineNumber(), fullName);
      }
      else if(varDecl.get()) {
        varDecl->addVar(signal->getLineNumber(), fullName);
      }
    }
    
    //section 5: insert current signal and the vector of signal group-type parent names, if any, in a map for later use(f2a)

    if(m_sigGroupPrefixes.get()) {
      RefTVec_RefString sigGroupPrefixesCopy = RefTVec_RefString(new TVec_RefString());
      for(TVec_RefString::const_iterator it = m_sigGroupPrefixes->begin(); it < m_sigGroupPrefixes->end(); ++it) {
        sigGroupPrefixesCopy->push_back(*it);
      }
      m_allCslSignals.insert(pair<RefCSLOmSignal, RefTVec_RefString>(signal, sigGroupPrefixesCopy));
    }

    if(m_sigGroupSuffixes.get()) {
      RefTVec_RefString sigGroupSuffixesCopy = RefTVec_RefString(new TVec_RefString());
      for(TVec_RefString::const_iterator it = m_sigGroupSuffixes->begin(); it < m_sigGroupSuffixes->end(); ++it) {
        sigGroupSuffixesCopy->push_back(*it);
      }
      m_cslSignalsSuffixes.insert(pair<RefCSLOmSignal, RefTVec_RefString>(signal, sigGroupSuffixesCopy));
    }

    //section 6: decoders

    if(signal->isDecoder()) {
      ASSERT(signal->getBitRange()->isField(), "Cannot generate a decoder from a signal with no field");
      adaptDecoder(signal);
    }
  }
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {

  m_cslCurrParent = m_cslCurrParent->getParent();
  ASSERT(unitInst.get(), "The input unit instantiation is a null pointer");
  ASSERT(m_cslCurrParent.get(), "The current csl parent is null");
  ASSERT(m_cdomCurrParent.get(), "The current cdom parent is null");
  ASSERT(m_cslCurrParent->getType() == NSCSLOm::TYPE_UNIT_INSTANTIATION, "The current csl parent isn't of type CSLOmUnitInstantiation");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_MODULE_INSTANTIATION, "The current cdom parent isn't of type CDOmModuleOrUdpInstantiation");

  /*RefTMap_RefString_RefCDOmMinTypMax paramMap = CDOmModuleOrUdpInstantiation::cast(m_cdomCurrParent)->getExplicitParamNameMap();
    for(TMap_RefString_RefCDOmMinTypMax::const_iterator it = paramMap->begin(); it != paramMap->end(); ++it) {
    DCERR("adapter unitInstanceAT: param name: " << *(it->first) << " param value: " << CDOmNum32::cast(it->second->getChild(0))->getValue() << endl);
    }*/

  //build the verilog module instance

  RefCDOmModuleOrUdpInstantiation cdomModuleInstantiation = CDOmModuleOrUdpInstantiation::cast(m_cdomCurrParent);
  RefCDOmModuleOrUdpInstance cdomModuleInst = cdomModuleInstantiation->buildModuleInstance(unitInst->getLineNumber(), unitInst->getName());
 
  //testbench dut instances
  
  if((CSLOmUnitDecl::cast(unitInst->getParent()->getParent()))->getUnitType() == CSLOmUnitDecl::CSL_TESTBENCH_DECL) {
    m_cdomDutInstances->push_back(cdomModuleInst);
     }
  else {
  //formal to actual mapping

    RefCSLOmExprLink cslFormal;
    RefCSLOmExpr cslActual;  
    RefTMap_RefCSLOmExprLink_RefCSLOmExpr connectionMap = unitInst->getConnectionMap();
    if(connectionMap->empty()) {
      cdomModuleInst->addPortConnection();
    }
    else {
      RefCSLOmUnitDecl unit=CSLOmUnitInstantiation::cast(m_cslCurrParent)->getUnitDecl();
      for(TMap_RefCSLOmExprLink_RefCSLOmExpr_const_iter it = connectionMap->begin(); it != connectionMap->end(); ++it) {
        cslFormal= it->first;
        cslActual = it->second;
        ASSERT(cslFormal.get(), "f2a mapping: Formal parameter cannot be null");
      
        if(cslActual.get()) {
          
          RefString formalName = cslFormal->getHidName(0);          
          
          //build API
          RefCSLOmScope formalScope = unit->getAttachedScope();
          CSLOmScopeBlock::enterScope(formalScope);
          cslFormal->doEval();
          CSLOmScopeBlock::exitScope();
          ASSERT(cslFormal->getValue().get(), "f2a mapping: formal parameter evaluates to null.");
          //with the code above
       
          ASSERT(cslFormal->getValue()->isPort() || cslFormal->getValue()->isInterface(), "f2a mapping: formal parameter can only be a port or interface.");
          if(cslActual->isExprLink()) {
            RefCSLOmExprLink cslActualLink = CSLOmExprLink::cast(cslActual);
            if(cslActualLink->getValue().get()) {
              //DCERR(cslActualLink->getValue()->isInterface() << " " << cslFormal->getValue()->isInterface() << " look here" << endl);
              if(cslActualLink->getValue()->isInterface() || cslActualLink->getValue()->isSignalGroup()) {
                adaptInterfaceOrSignalGroupConnection(CSLOmConnectable::cast(cslActualLink->getValue()), 
                                                      CSLOmConnectable::cast(cslFormal->getValue()), 
                                                      cdomModuleInst
                                                      );
              }
              else if(cslActualLink->getValue()->isPort() || cslActualLink->getValue()->isSignal()) {
                adaptPortOrSignalConnection(cslActualLink, 
                                            cslFormal, 
                                            cdomModuleInst
                                            );
              }
              else {
                ASSERT(FAIL, "f2a mapping: Connection map contains expr links to nonconnectable objects ");
              }
            }
            else {
              ASSERT(FAIL, "f2a mapping: cslActual exprLink points to null");
            }
          }
          else {
            //the actual parameter is not an expresion link to a connectable object, but a number, concat, or multiconcat 
            RefCSLOmBase oldCslParent = RefCSLOmBase(m_cslCurrParent);
            if(cslActual->isNumber() || cslActual->isConcat() || cslActual->isMultiConcat() || cslActual->isOp()) {
              adaptExprConnection(cslActual, 
                                  CSLOmConnectable::cast(cslFormal->getValue()), 
                                  cdomModuleInst);
              m_cslCurrParent = RefCSLOmBase(oldCslParent);
            }
            else {
              ASSERT(FAIL, "f2a mapping: cslActual is not of appropiate type");
            }
         }
        }
      }

      RefTMap_RefString_RefCDOmExpr portMap = cdomModuleInst->getExplicitPortMap();
      if(!portMap.get() || portMap->empty()) {
        cdomModuleInst->addPortConnection();
      }
    }
  
  }
  m_cslReturnedValue = unitInst;
}



void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  TBool brHasOneChild = FALSE;

  //m_cslCurrParent = m_cslCurrParent->getParent();//BUG 1925
  if(m_isOrdinarySimpleBrOrDimZero) {
    ASSERT( m_cdomTraversedChildren.get() && 
            (m_cdomTraversedChildren->size() == m_nrOfAlienChildren + 1 || 
             m_cdomTraversedChildren->size() == m_nrOfAlienChildren + 3), 
            "Illegal number of children for bitrange");
    if(m_cdomTraversedChildren->size() == m_nrOfAlienChildren + 1) {
      brHasOneChild = TRUE;
    }
    m_cslCurrParent = simpleBitRange->getParent(); //added by MP, BUG 1925
    RefCDOmExpr firstExpr, secondExpr;
    RefCDOmExpr offset;
    if(brHasOneChild) {
      offset = CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 1));
    }
    else {
      offset = CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 3));
    }
    RefCDOmExprOp offsetAsOp;
    RefCDOmNum32 offsetAsNumber;
    RefCDOmExprLink offsetAsHid;
    RefCDOmExpr offsetCopy;
    TBool offsetIsNullNum = FALSE;

    switch(offset->getExprType()) {
      case CDOmExpr::EXPR_NUMBER:
        offsetAsNumber = CDOmNum32::cast(offset);
        if(offsetAsNumber->getValue() == 0) {
          offsetIsNullNum = TRUE;
        }
        else {
          offsetCopy = buildCDOmNum32WithValue(simpleBitRange->getLineNumber(), offsetAsNumber->getValue());
        }
        break;
      case CDOmExpr::EXPR_HID:
        offsetAsHid = CDOmExprLink::cast(offset);
        offsetCopy = buildCDOmExprLink(simpleBitRange->getLineNumber(), offsetAsHid->getName());
        break;
      case CDOmExpr::EXPR_OP:
        offsetAsOp = CDOmExprOp::cast(offset);
        offsetCopy = buildCDOmExprOp(simpleBitRange->getLineNumber(), offsetAsOp->getOpType(), offsetAsOp->getExpr1(), offsetAsOp->getExpr2(), offsetAsOp->getExpr3());
        break;
      default:
        ASSERT(FALSE, "CSLOmSimpleBitRangeAT(): Offset expr type not supported");
    }

    if(m_cdomTraversedChildren->size() == m_nrOfAlienChildren + 1) {
      firstExpr = CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 1)); //firstExpr = offset
      secondExpr = buildCDOmNum32WithValue(simpleBitRange->getLineNumber(), 0);
    }
    else if(m_cdomTraversedChildren->size() == m_nrOfAlienChildren + 3) {
      if(offsetIsNullNum) {
        firstExpr = CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 2));
        secondExpr = CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 1));
      }
      else {
        RefCDOmExpr fe = CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 2));
        RefCDOmExpr se = CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 1));

        firstExpr = buildCDOmExprOp(simpleBitRange->getLineNumber(), CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS, fe, offset);
        secondExpr = buildCDOmExprOp(simpleBitRange->getLineNumber(), CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS, se, offsetCopy);
      }
    }
    if(m_cslCurrParent->isExpr()) {         
      RefCDOmRangeExpr rangeExpr = buildCDOmRangeExprDouble(simpleBitRange->getLineNumber(),firstExpr, secondExpr );
      m_cdomReturnedValue = rangeExpr;
    }
    else {
      RefCDOmRange range = buildCDOmRange(simpleBitRange->getLineNumber(), firstExpr, secondExpr);
      m_cdomReturnedValue = range; 
    }
    for(TInt i = 0; i < 3; ++i) {
      m_cdomTraversedChildren->pop_back();
    }
    m_simpleBitRangeIT = TRUE;
    //m_cslCurrParent = simpleBitRange->getParent();//BUG 1925
  }
  else {
    enableChildrenTraversal();
  }
  m_isOrdinarySimpleBrOrDimZero = FALSE;
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
  m_cslCurrParent = multiDimBitRange->getParent();
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           ) {}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
  if(!m_generateIndividualSignals) {
    ASSERT(groupSignal->getChildrenSize() >= 1, "This signal group has no signals");
    RefCSLOmSignal sig = CSLOmSignal::cast(groupSignal->getChild(1));
    ECSLOmSignalType signalType = sig->getSignalType();
    RefTVec_RefCSLOmSignal sigVec = groupSignal->getChildren<CSLOmSignal>(TYPE_ALL_SIGNALS);
    for(TVec_RefCSLOmSignal_const_iter it = sigVec->begin(); it!=sigVec->end(); ++it)
      ASSERT((*it)->getSignalType() == signalType, 
          "When generateIndividulaRTLSignals option is not active, all signals inside the group should be of the same type");
    ASSERT(m_num32Offset.get() && m_num32FirstExpr.get() && m_num32SecondExpr.get(), 
        "Offset, firstExpr and secondExpr for unique bitrange should not be null");
    
    //computing the unique bitrange for the cumulative signal
    RefCDOmRange uniqueRange = RefCDOmRange();
    RefCDOmNum32 firstExpr = CDOmNum32::cast(m_num32FirstExpr);
    RefCDOmNum32 secondExpr = CDOmNum32::cast(m_num32SecondExpr);
    RefCDOmNum32 diff = CDOmNum32::cast(firstExpr->substract(secondExpr));
    RefCDOmNum32 zero = buildCDOmNum32WithValue(groupSignal->getLineNumber(), 0);
    //if group only has one signal (meaning 2 children id and that only signal)
    if(groupSignal->getChildrenSize() == 2 ) {
      RefCSLOmSignal s = CSLOmSignal::cast(groupSignal->getChild(1));
      RefCSLOmSimpleBitRange br = CSLOmSimpleBitRange::cast(s->getBitRange());
      RefCSLOmExpr upper = br->getUpper();
      RefCSLOmExpr lower = br->getLower();
      if(!CSLOmNumber::cast(upper->doEval()) && !CSLOmNumber::cast(lower->doEval()))//default bitrange [0:0]
        uniqueRange = buildCDOmRange(groupSignal->getLineNumber(), diff, zero);
      else {
        RefCSLOmNum32 ui = CSLOmNum32::cast(upper->doEval());
        RefCSLOmNum32 li = CSLOmNum32::cast(lower->doEval());
        if(ui->getValue() == li->getValue()) {
          uniqueRange = buildCDOmRange(groupSignal->getLineNumber(), diff, zero);
        }
        else {
          RefCDOmNum32 one = buildCDOmNum32WithValue(groupSignal->getLineNumber(), 1);
          RefCDOmNum32 diffMinusOne = CDOmNum32::cast(diff->substract(one));
          uniqueRange = buildCDOmRange(groupSignal->getLineNumber(), diffMinusOne, zero);
        }
      }
    }
    else {
      RefCDOmNum32 one = buildCDOmNum32WithValue(groupSignal->getLineNumber(), 1);
      RefCDOmNum32 diffMinusOne = CDOmNum32::cast(diff->substract(one));
      uniqueRange = buildCDOmRange(groupSignal->getLineNumber(), diffMinusOne, zero);
    }
    
    //building and naming the cumulative signal
    ECDOmNetType netType = getCDOmNetType(signalType);
    ECDOmVarType varType = getCDOmVarType(signalType);
    RefString name;
    if(m_unitPrefix.get()) {
      name = RefString(new std::string(*m_unitPrefix));
      name->append(std::string("_"));
      name->append(std::string(*(groupSignal->getName())));
    }
    else {
      name = groupSignal->getName();
    }
    if(netType!=NSCdom::NET_UNDEFINED) {
      RefCDOmNetDecl uniqueNetDecl = buildCDOmNetDecl(groupSignal->getLineNumber(), m_cdomCurrParent, netType);
      uniqueNetDecl->setRange(uniqueRange);
      uniqueNetDecl->addNet(groupSignal->getLineNumber(), name);
    }
    else if(varType!=VAR_UNDEFINED) {
      RefCDOmVarDecl uniqueVarDecl = buildCDOmVarDecl(groupSignal->getLineNumber(), m_cdomCurrParent, varType);
      uniqueVarDecl->setRange(uniqueRange);
      uniqueVarDecl->addVar(groupSignal->getLineNumber(), name);
    }
    else ASSERT(FAIL, "CDOm equivalent of CSLOM signal must be VAR or NET");
  }

  if(m_sigGroupPrefixes.get() && m_sigGroupPrefixes->size()>=1) {
    m_sigGroupPrefixes->pop_back();
  }
  if(m_sigGroupSuffixes.get() && m_sigGroupSuffixes->size()>=1 && groupSignal->getSuffix().get()) {
    m_sigGroupSuffixes->pop_back();
  }
  m_beforeTraversalForNum32 = 0;
  m_generateIndividualSignals = TRUE; 
  m_cslCurrParent = m_cslCurrParent->getParent();
}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) {}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {
  if(m_ifcPrefixes.get() && m_ifcPrefixes->size() >= 1) {
    m_ifcPrefixes->pop_back();
  }
  if(m_ifcSuffixes.get() && m_ifcSuffixes->size() >= 1 && interface->getSuffix().get()) {
    m_ifcSuffixes->pop_back();
  }
  m_cslCurrParent = interface->getParent();
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {
  m_cslCurrParent = unitInstantiation->getParent();
  m_cdomCurrParent = m_cdomCurrParent->getParent();
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {

  //section 1:restore the current parent
  m_cslCurrParent = m_cslCurrParent->getParent();

  //section 2:check that the returned value is the port's bitrange
  ASSERT(m_cdomReturnedValue->getType() == TYPE_RANGE, "The cdom returned value is of illegal type");
  
  //section 3:a port of type reg can only be an output
  if(portDecl->getPortType() == SIGNAL_REG && portDecl->getPortDirection() == INPUT)
    ASSERT(FAIL,"An input port cannot be a reg");

  //section 4: determine the port type: net/var
  NSCdom::ECDOmNetType netType = NSCdom::NET_UNDEFINED;
  NSCdom::ECDOmVarType varType = NSCdom::VAR_UNDEFINED;
  NSCSLOm::ECSLOmSignalType sigType = portDecl->getPortType();
  netType = getCDOmNetType(sigType);
  varType = getCDOmVarType(sigType);
  
  //section 5: determine the port direction
  NSCdom::ECDOmPortType portType;
  switch(portDecl->getPortDirection()) {
    case (INOUT) :   portType = PORT_INOUT;      break;
    case (INPUT) :   portType = PORT_INPUT;      break;
    case (OUTPUT):   portType = PORT_OUTPUT;     break;
    default      :   portType = PORT_INOUT;
  }

  //section 6: compute the number of ports to generate
  TInt nrOfPorts = 1;
  if(portDecl->getBitRange()->isMultiDimBitRange()) {
    RefCSLOmMultiDimBitRange portBr = CSLOmMultiDimBitRange::cast(portDecl->getBitRange());
    RefCSLOmSimpleBitRange dimZero = portBr->getDimZero();
    RefTVec_RefCSLOmSimpleBitRange dims = portBr->getChildren<CSLOmSimpleBitRange>(TYPE_ALL_SIMPLE_BR);
    for(TVec_RefCSLOmSimpleBitRange::const_iterator it = dims->begin(); it < dims->end(); ++it) {
      if(dimZero.get() && (*it) != dimZero || !dimZero.get()) {
        RefCSLOmExpr width = (*it)->getWidth();
        nrOfPorts *= CSLOmNumber::cast(width->doEval())->getValue();
      }
    }
  }


  RefTVec_RefString portNames = RefTVec_RefString(new TVec_RefString());
  for(int i = 0; i < nrOfPorts; ++i) {

    //section 7: prefix the port's name with the unit prefix(if any) and with the parent iterface's prefixes and suffixes(if any) 
    RefString portName = RefString(new std::string(""));
    if(m_unitPrefix.get()) {
      portName->append(*m_unitPrefix);
      portName->append(std::string("_"));
    }
    if(   m_cslCurrParent->isInterface() 
          && !(CSLOmInterface::cast(m_cslCurrParent))->isDefaultIfc() 
          && m_ifcPrefixes.get() 
          && m_ifcPrefixes->size() >= 1) {
      for(TVec_RefString_const_iter it = m_ifcPrefixes->begin(); it < m_ifcPrefixes->end(); ++it) {
        if((*it).get()) {
          portName->append(*(*it));
          portName->append("_");
        }
      }
     
    }
    if(   m_cslCurrParent->isInterface() 
          && !(CSLOmInterface::cast(m_cslCurrParent))->isDefaultIfc() 
          && m_ifcSuffixes.get() 
          && m_ifcSuffixes->size() >= 1) {
      for(TVec_RefString_const_iter it = m_ifcSuffixes->begin(); it < m_ifcSuffixes->end(); ++it) {
        portName->append(*(*it));
        portName->append("_");
      }
    }
    portName->append(*(portDecl->getName()));
  
   
    //section 8: if multiple ports are being generated, then append their names with the current index
    if(nrOfPorts > 1) {
      portName->append("_");
      portName->append(*ltos(i));
    }

    //section 9: avoid name collisions
    TInt idx = 0;
    TBool isAppended = TRUE;
    RefString basePortName = RefString(new string(*portName));
    if(!m_allCdomPorts.empty()) {
      while(isAppended) {
        for(map<RefCDOmPortDecl, RefString>::const_iterator it = m_allCdomPorts.begin(); it != m_allCdomPorts.end(); ++it) {
          //DCERR("type of port's first child: " << it->first->getChild(0)->getType() << endl);
          RefString idName = it->first->getIDs()->at(0)->getName();
          RefString moduleName = CDOmIdentifier::cast(CDOmModuleDecl::cast(m_cdomCurrParent)->getChild(0))->getName();
          if((*idName == *portName) && (*(it->second) == *moduleName)) {
            portName = RefString(new string(*basePortName));
            portName->append("_");
            portName->append(*ltos(idx++));
            isAppended = TRUE;
            break;
          }
          else {
            isAppended = FALSE;
          }
        }
      }
    }
    basePortName = RefString(new string(*portName));
    isAppended = TRUE;
    if(!m_allCdomSignals.empty()) {
      while(isAppended) {
        for(map<RefString, RefString>::const_iterator it = m_allCdomSignals.begin(); it != m_allCdomSignals.end(); ++it) {
          //DCERR("type of port's first child: " << it->first->getChild(0)->getType() << endl);
          RefString idName = it->first;
          RefString moduleName = CDOmIdentifier::cast(CDOmModuleDecl::cast(m_cdomCurrParent)->getChild(0))->getName();
          if((*idName == *portName) && (*(it->second) == *moduleName)) {
            portName = RefString(new string(*basePortName));
            portName->append("_");
            portName->append(*ltos(idx++));
            isAppended = TRUE;
            break;
          }
          else {
            isAppended = FALSE;
          }
        }
      }
    }
    portNames->push_back(portName);
    // cout << "PORT NAME =" << *portName << endl;
    m_allPortsSignalsNames.insert(pair<RefCSLOmConnectable, RefString>(CSLOmConnectable::cast(portDecl), portName));

    //section 10: build the port item(port predeclaration)
    CDOmPortItem::EPortItemType portItemType = CDOmPortItem::PORT_ITEM_SIMPLE; 
    RefCDOmPortItem portItem = (CDOmModuleDecl::cast(m_cdomCurrParent))->buildPortItem(portDecl->getLineNumber(), portItemType, portName);  
  }

  //section 11: build the port declaration
  RefCDOmPortDecl cdomPortDecl = RefCDOmPortDecl();    
  if(netType!=NSCdom::NET_UNDEFINED) {
    cdomPortDecl = buildCDOmPortDeclNet( portDecl->getLineNumber(), 
                                         m_cdomCurrParent, 
                                         portType, 
                                         netType, 
                                         CDOmRange::cast(m_cdomReturnedValue)
                                         );
  }
  else if(varType!=NSCdom::VAR_UNDEFINED) {
    cdomPortDecl = buildCDOmPortDeclVar( portDecl->getLineNumber(),
                                         m_cdomCurrParent,
                                         varType,
                                         CDOmRange::cast(m_cdomReturnedValue)
                                         );
  }
  for(TVec_RefString::const_iterator it = portNames->begin(); it < portNames->end(); ++it) {
    cdomPortDecl->addPort(portDecl->getLineNumber(), (*it));
  }

  //section 12: insert the converted cdom ports into the cdomUnitPorts map 
  pair<EFifoPortNames, RefCDOmPortDecl> cdomFifoMapItem;
  pair<ERFPortNames, RefCDOmPortDecl> cdomRegisterFileMapItem;
  pair<ERegPortNames, RefCDOmPortDecl> cdomRegisterMapItem;
  switch (m_unitType) {
    case UNIT_TYPE_UNIT_DECL :
      break;
    case UNIT_TYPE_MEM_DECL :
      DCERR("This will need implementation!(added by bz so it won't fail anymore)");
      break;
    case UNIT_TYPE_FIFO_DECL :
      if(m_cslFifoPorts.get() && !m_cslFifoPorts->empty()) {
        //ASSERT(m_cslFifoPorts->find(FIFO_PN_PUSH) != m_cslFifoPorts->end()
        //       && m_cslFifoPorts->find(FIFO_PN_POP) != m_cslFifoPorts->end()
        //       && m_cslFifoPorts->find(FIFO_PN_FULL) != m_cslFifoPorts->end()
        //       && m_cslFifoPorts->find(FIFO_PN_EMPTY) != m_cslFifoPorts->end()
        //       && m_cslFifoPorts->find(FIFO_PN_DATA_IN) != m_cslFifoPorts->end()
        //       && m_cslFifoPorts->find(FIFO_PN_DATA_OUT) != m_cslFifoPorts->end()
        //       && m_cslFifoPorts->find(FIFO_PN_VALID) != m_cslFifoPorts->end(),
        //       "Fifo map does not contain all mandatory ports");
        for(TMap_EFifoPortNames_RefCSLOmPortDecl::const_iterator it = m_cslFifoPorts->begin(); it != m_cslFifoPorts->end(); ++it) {
          if(it->second == portDecl) {
            cdomFifoMapItem = make_pair(it->first, cdomPortDecl);
            break;
          }
        }
        m_cdomFifoPorts.insert(cdomFifoMapItem);
      }
      break;
    case UNIT_TYPE_REGISTER_FILE_DECL :
      if(m_cslRegisterFilePorts.get() && !m_cslRegisterFilePorts->empty()) {
        // ASSERT(m_cslRegisterFilePorts->find(RF_PN_CLOCK) != m_cslRegisterFilePorts->end()
        //       && m_cslRegisterFilePorts->find(RF_PN_RESET) != m_cslRegisterFilePorts->end()
        //       && m_cslregisterfileports->find(RF_PN_WR_ADDR) != m_cslRegisterFilePorts->end()
        //       && m_cslRegisterFilePorts->find(RF_PN_RESET) != m_cslRegisterFilePorts->end()
        //       && m_cslregisterfileports->find(RF_PN_WR_ADDR) != m_cslRegisterFilePorts->end()
        //       && m_cslRegisterFilePorts->find(RF_PN_RD_ADDR) != m_cslRegisterFilePorts->end()
        //       && m_cslregisterfileports->find(RF_PN_DATA_IN) != m_cslRegisterFilePorts->end()
        //       && m_cslRegisterFilePorts->find(RF_PN_DATA_OUT) != m_cslRegisterFilePorts->end()
        //       && m_cslRegisterFilePorts->find(RF_PN_WR_EN) != m_cslRegisterFilePorts->end()
        //       && m_cslRegisterFilePorts->find(RF_PN_RD_EN) != m_cslRegisterFilePorts->end()
        //       && m_cslRegisterFilePorts->find(RF_PN_VALID) != m_cslRegisterFilePorts->end(),
        //       "Regfile map does not contain all mandatory ports");
        for(TMap_ERFPortNames_RefCSLOmPortDecl::const_iterator it = m_cslRegisterFilePorts->begin(); it != m_cslRegisterFilePorts->end(); ++it) {
          if(it->second == portDecl) {
            cdomRegisterFileMapItem = make_pair(it->first, cdomPortDecl);
            break;
          }
        }
        m_cdomRegisterFilePorts.insert(cdomRegisterFileMapItem);
      }
      break;     
    case UNIT_TYPE_TESTBENCH_DECL:
      break;
    case UNIT_TYPE_REGISTER_DECL:
      if(m_cslRegisterPorts.get() && !m_cslRegisterPorts->empty()) {
        for(TMap_ERegPortNames_RefCSLOmPortDecl::const_iterator it = m_cslRegisterPorts->begin(); it != m_cslRegisterPorts->end(); ++it) {
          if(it->second == portDecl) {
            cdomRegisterMapItem = make_pair(it->first, cdomPortDecl);
            break;
          }
        }
        m_cdomRegisterPorts.insert(cdomRegisterMapItem);
      }
      break;
    default:
      ASSERT(FAIL, "RefCSLOmPortDecl AT: Illegal unit type");
  }

  //section 13: include the cdom port and the parent cdom module in the m_allCdomPorts map for later port name generation(name collisions)
  RefString moduleName = CDOmIdentifier::cast(CDOmModuleDecl::cast(m_cdomCurrParent)->getChild(0))->getName();
  m_allCdomPorts.insert(pair<RefCDOmPortDecl, RefString>(cdomPortDecl, moduleName));

  //section 14: include the csl port and the interface prefixes in the m_allCslPorts map for later port name generation(f2a and testbench)
  DCERR("port to be included in allCslPorts map " << *(portDecl->getName()) << endl);
  if(m_ifcPrefixes.get()) {
    map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator portIt = m_allCslPorts.find(portDecl);
    if(portIt == m_allCslPorts.end()) {
      RefTVec_RefString ifcPrefixesCopy = RefTVec_RefString(new TVec_RefString());
      for(TVec_RefString::const_iterator it = m_ifcPrefixes->begin(); it < m_ifcPrefixes->end(); ++it ) {
        ifcPrefixesCopy->push_back(*it);
      }
      m_allCslPorts.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(portDecl, ifcPrefixesCopy));
    }
  }
  if(m_ifcSuffixes.get()) {
    map<RefCSLOmPortDecl, RefTVec_RefString>::const_iterator portIt = m_cslPortsSuffixes.find(portDecl);
    if(portIt == m_cslPortsSuffixes.end()) {
      RefTVec_RefString ifcSuffixesCopy = RefTVec_RefString(new TVec_RefString());
      for(TVec_RefString::const_iterator it = m_ifcSuffixes->begin(); it < m_ifcSuffixes->end(); ++it ) {
        ifcSuffixesCopy->push_back(*it);
      }
      m_cslPortsSuffixes.insert(pair<RefCSLOmPortDecl, RefTVec_RefString>(portDecl, ifcSuffixesCopy));
    }
  }
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {
  NSCSLOm::CSLOmExprOp::EOpType opType = exprOp->getOpType();
  NSCdom::CDOmExprOp::EOpType cdomOpType;
  switch(opType) {
    case NSCSLOm::CSLOmExprOp::OP_UNARY_ARITHMETIC_PLUS:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_ARITHMETIC_PLUS;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_ARITHMETIC_MINUS:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_ARITHMETIC_MINUS;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_LOGIC_NOT:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_LOGIC_NOT;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_BITWISE_NOT:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_BITWISE_NOT;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_REDUCTION_AND:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_REDUCTION_AND;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_REDUCTION_NAND:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_REDUCTION_NAND;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_REDUCTION_OR:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_REDUCTION_OR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_REDUCTION_NOR:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_REDUCTION_NOR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_REDUCTION_XOR:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_REDUCTION_XOR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_REDUCTION_XNOR:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_REDUCTION_XNOR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_UNARY_LOG_2:
      cdomOpType = NSCdom::CDOmExprOp::OP_UNARY_LOG_2;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_ARITHMETIC_DIV:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_ARITHMETIC_DIV;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_ARITHMETIC_MOD:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_ARITHMETIC_MOD;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_ARITHMETIC_POW:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_ARITHMETIC_POW;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_EQUALITY_EQ:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_EQUALITY_EQ;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_EQUALITY_NOT_EQ:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_IDENTITY_EQ_CASE:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_LOGIC_AND:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_LOGIC_AND;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_LOGIC_OR:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_LOGIC_OR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_RELATIONAL_LESS:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_RELATIONAL_LESS;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_RELATIONAL_GREATER;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_BITWISE_AND:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_BITWISE_AND;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_BITWISE_NAND:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_BITWISE_NAND;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_BITWISE_OR:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_BITWISE_OR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_BITWISE_NOR:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_BITWISE_NOR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_BITWISE_XOR:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_BITWISE_XOR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_BITWISE_XNOR:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_BITWISE_XNOR;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_SHIFT_LEFT:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_SHIFT_LEFT;
      break;
    case NSCSLOm::CSLOmExprOp::OP_BINARY_SHIFT_RIGHT:
      cdomOpType = NSCdom::CDOmExprOp::OP_BINARY_SHIFT_RIGHT;
      break;
    case NSCSLOm::CSLOmExprOp::OP_TERNARY_COND:
      cdomOpType = NSCdom::CDOmExprOp::OP_TERNARY_COND;
      break;
    default:
        ASSERT(FAIL, "Invalid expression operator");
  }
  RefCDOmExprOp cdomExprOp;
  if(exprOp->isUnary()) {
    ASSERT(m_cdomTraversedChildren->size() >= 1, "Unary exprOp has illegal number of children");
    cdomExprOp = buildCDOmExprOp( exprOp->getLineNumber(), cdomOpType, CDOmExpr::cast(m_cdomTraversedChildren->back()));
    m_cdomTraversedChildren->pop_back();
  }
  else if(exprOp->isBinary()) {
    ASSERT(m_cdomTraversedChildren->size() >= 2, "Binary exprOp has illegal number of children");
    cdomExprOp = buildCDOmExprOp( exprOp->getLineNumber(), cdomOpType, 
                                  CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 2)), 
                                  CDOmExpr::cast(m_cdomTraversedChildren->back())
                                 );
    for(int i = 0; i<=1; ++i) {
      m_cdomTraversedChildren->pop_back();
    }
  }
  else if(exprOp->isTernary()) {
    ASSERT(m_cdomTraversedChildren->size() >= 3, "Ternary exprOp has illegal number of children");
    cdomExprOp = buildCDOmExprOp( exprOp->getLineNumber(), cdomOpType, 
                                  CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 3)), 
                                  CDOmExpr::cast(m_cdomTraversedChildren->at(m_cdomTraversedChildren->size() - 2)), 
                                  CDOmExpr::cast(m_cdomTraversedChildren->back())
                                  );
    for(int i = 0; i<=2; ++i) {
      m_cdomTraversedChildren->pop_back();
    }
  }
  else
    ASSERT(FAIL, "cdomExprOp should be unary, binary or ternary");
  m_cdomReturnedValue = cdomExprOp;

}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {
  ASSERT(m_cdomTraversedChildren.get(), "Children vector for exprConcat is null");
  ASSERT(m_cdomTraversedChildren->size(), "exprConcat has no children");
  
  RefCDOmExprConcat cdomExprConcat = RefCDOmExprConcat();
  // + 1 because we have to keep the first element
  for(TVec_RefCDOmBase_const_iter it = m_cdomTraversedChildren->end() - exprConcat->getChildrenSize() ; it < m_cdomTraversedChildren->end(); ++it) {
    if(!cdomExprConcat.get())
      cdomExprConcat = buildCDOmExprConcat(exprConcat->getLineNumber(), CDOmExpr::cast(*it));
    else
      cdomExprConcat->addExpr(CDOmExpr::cast(*it));
  }
  m_cdomReturnedValue = cdomExprConcat;
  //m_cdomTraversedChildren->clear();
  TInt vecSize = exprConcat->getChildrenSize();
  for(int i = 0; i < vecSize; ++i) {
      m_cdomTraversedChildren->pop_back();
    }

}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
  ASSERT(m_cdomTraversedChildren.get(), "Children vector for exprMultiConcat is null");
  //  ASSERT(m_cdomTraversedChildren->size() == 2, "exprMultiConcat should have two children");

  RefCDOmExprConcat exprConcat = CDOmExprConcat::cast(m_cdomTraversedChildren->back());
  m_cdomTraversedChildren->pop_back();
  
  RefCDOmExpr expr = CDOmExpr::cast(m_cdomTraversedChildren->back());
  m_cdomTraversedChildren->pop_back();

  RefCDOmExprMultiConcat cdomExprMultiConcat = buildCDOmExprMultiConcat( exprMultiConcat->getLineNumber(), expr, exprConcat);
  m_cdomReturnedValue = cdomExprMultiConcat;
  //m_cdomTraversedChildren->clear();
//   TInt vecSize = m_cdomTraversedChildren->size() - 1;
//   for(int i = 0; i < vecSize; ++i) {
//       m_cdomTraversedChildren->pop_back();
//     }

}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {}  
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmSetCommand                      & setCommand                      ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetWidth                     & cmdSetWidth                     ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetBitRange                  & cmdSetBitRange                  ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetOffset                    & cmdSetOffset                    ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetLowerIndex                & cmdSetLowerIndex                ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetUpperIndex                & cmdSetUpperIndex                ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetRange                     & cmdSetRange                     ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetNumberOfDimensions        & cmdSetNumberOfDimensions        ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimWidth                  & cmdSetDimWidth                  ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimBitRange               & cmdSetDimBitRange               ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimOffset                 & cmdSetDimOffset                 ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimLowerIndex             & cmdSetDimLowerIndex             ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimUpperIndex             & cmdSetDimUpperIndex             ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimRange                  & cmdSetDimRange                  ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetUnitPrefix                & cmdSetUnitPrefix                ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefix              & cmdSetSignalPrefix              ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefixLocal         & cmdSetSignalPrefixLocal         ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetType                      & cmdSetType                      ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetAttr                      & cmdSetAttr                      ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddInstance                  & cmdAddInstance                  ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddInstanceList              & cmdAddInstanceList              ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddSignal                    & cmdAddSignal                    ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddSignalList                & cmdAddSignalList                ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddSignalGroup               & cmdAddSignalGroup               ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddPort                      & cmdAddPort                      ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddPortList                  & cmdAddPortList                  ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignal                 & cmdRemoveSignal                 ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignalList             & cmdRemoveSignalList             ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdRemovePort                   & cmdRemovePort                   ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdRemovePortList               & cmdRemovePortList               ) {} 
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdSetInstanceAlterationBit     & cmdSetInstanceAlterationBit     ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdGenerateIndividualRTLSignals & cmdGenerateIndividualRTLSignals ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddInterface                 & cmdAddInterface                 ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdAddUnitParameter             & cmdAddUnitParameter             ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdOverrideUnitParameter        & cmdOverrideUnitParameter        ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdInputVerilogType             & cmdInputVerilogType             ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdOutputVerilogType            & cmdOutputVerilogType            ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdReverse                      & cmdReverse                      ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdConnect                      & cmdConnect                      ) {}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmCmdConnectSplit                 & cmdConnectSplit                 ) {}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {
  //in case there was an expr link as child
  m_cslCurrParent = parameter->getParent();
  TRACE_ME(0, "CAdapterToCDOM::beforeTraversal(const NSCSLOm::RefCSLOmParameter                   & parameter                   )");
  ASSERT(parameter.get(), "CSLOmParameterAT: Parameter is null.");
  ASSERT(m_cslCurrParent.get(), "CSLOmParameterAT: Cslom parent is null");
  ASSERT(m_cslCurrParent->isUnitDecl() || m_cslCurrParent->getType() == TYPE_INST_UNIT || m_cslCurrParent->isInterface() || m_cslCurrParent->isSignalGroup(), 
         "CSLOmParameterAT: The type of the current parent must be CSLOmUnitDecl or CSLOmUnitInstance or CSLOmInterface or CSLOmSignalGroup");
  ASSERT(m_cdomCurrParent.get(), "CSLOmParameterAT: Cdom parent is null.");
  ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DECL_MODULE || m_cdomCurrParent->getType() == NSCdom::TYPE_MODULE_INSTANTIATION,
         "CSLOmParameterAT: The type of the current parent must be CDOmModuleDecl or CDOmModuleOrUdpInstantiation");
  ASSERT(m_cdomReturnedValue->getType() == NSCdom::TYPE_EXPR, "The type of the cdom returnd value is not of type expr");
  
  //RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(m_cslCurrParent);
  //RefString parentUnitName = parentUnit->getName();

  if(parameter->isDecl()) {
    RefCDOmParamDecl paramDecl = buildCDOmParamDecl(parameter->getLineNumber(), m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  
    RefString paramName = parameter->getName();
    //RefCDOmExpr paramValue = CDOmExpr::cast(m_cdomReturnedValue);
    //if(paramValue->getExprType() == CDOmExpr::EXPR_NUMBER) {
    //  TInt val = (CDOmNum32::cast(paramValue))->getValue();
    //  DCERR("param value: " << val << endl);
    //}
    RefCDOmMinTypMax cdomMinTypMax = buildCDOmMinTypMax(m_cdomReturnedValue->getLineNumber(),
                                                        CDOmExpr::cast(m_cdomReturnedValue)
                                                        );
    paramDecl->addParam(paramDecl->getLineNumber(), paramName, cdomMinTypMax);
  }


  //at this point if parameter is of type override, unitInstanceIT gets m_cslReturnedValue which is the csl parameter(stores the name)
  //and m_cdomReturnedValue which is the parameter value already converted to cdom
  m_cslReturnedValue = parameter;
}


void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {}
// void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmTestbenchDecl                   & testbenchDecl                   ) {
//   m_cslCurrParent = m_cslCurrParent->getParent();
//   m_cdomCurrParent = m_cdomCurrParent->getParent();
// }

// void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmTestbenchVector                 & testbenchVector                 ) {
//   m_cslCurrParent = m_cslCurrParent->getParent();
  
//   ASSERT(testbenchVector.get(), "Testbench vector is null");
//   ASSERT(m_cslCurrParent.get(), "The csl current parent is null");
//   ASSERT(m_cdomCurrParent.get(), "The cdom current parent is null");
//   ASSERT(m_cslCurrParent->isTestbenchDecl(), "The csl current parent is not a testbench declaration");
//   ASSERT(m_cdomCurrParent->getType() == NSCdom::TYPE_DECL_MODULE, "The cdom current parent is not a module declaration");
 
//   //reg vector_name[vector_dim:0];
//   //  RefCDOmVarDecl vector = buildCDOmVarDecl(testbenchVector->getLineNumber(), m_cdomCurrParent, NSCdom::VAR_REG);

//   //  TInt dim = CSLOmNum32::cast(testbenchVector->getWidth())->getValue();
//   //RefCDOmNum32 firstExpr = buildCDOmNum32WithValue(testbenchVector->getLineNumber(), dim-1);
//   //RefCDOmNum32 secondExpr = buildCDOmNum32WithValue(testbenchVector->getLineNumber(), 0);
//   //RefCDOmRange vectRange = buildCDOmRange(testbenchVector->getLineNumber(), firstExpr, secondExpr);
//   //vector->setRange(vectRange);
  
//   RefString vectName = testbenchVector->getID()->getName();
//   vector->addVar(testbenchVector->getLineNumber(), vectName);
  

//}
//void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) {}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumearation                    ) {
  m_firstCallOfEnumIT = 0;
  m_enumItemVal = -1;
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {
  m_cslCurrParent = m_cslCurrParent->getParent();
  if(m_cslCurrParent->isSignal()) {
    RefCDOmExpr firstExpr = buildCDOmNum32WithValue(field->getLineNumber(), 0);
    RefCSLOmExpr width = field->getWidth();
    RefCDOmExpr secondExpr = buildCDOmNum32WithValue(field->getLineNumber(), (CSLOmNumber::cast(width->doEval())->getValue())-1 );
    RefCDOmRange range = buildCDOmRange(field->getLineNumber(), firstExpr, secondExpr);
    m_cdomReturnedValue = range;
  }

}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {
}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {
  m_cslCurrParent = memoryMapLocation->getParent();
}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {
  m_cslCurrParent = memoryMapPage->getParent();
}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {}
void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
}

void CAdapterToCDOM::afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {
  ASSERT(m_cdomCurrParent->getType() == TYPE_DECL_MODULE, "stmtAssn has parent of illegal type");
  //ASSERT(m_cdomTraversedChildren.get() && m_cdomTraversedChildren->size() >= 2, "stmtAssn has illegal number of children");
  ASSERT(m_cdomTraversedChildren.get(), "stmtAssn has no children");

  m_cslCurrParent = stmtAssign->getParent();

  //DCERR("||| name at 0 is " << *(CDOmExprLink::cast(m_cdomTraversedChildren->at(0))->getName()));  
  //DCERR("||| type at 1 is " << *(CDOmExprLink::cast(m_cdomTraversedChildren->at(1))->getName()));  
  //DCERR("||| type at 1 is " << (CDOmExpr::cast(m_cdomTraversedChildren->at(1))->getExprType()));
  //DCERR("size is " << m_cdomTraversedChildren->size());

  RefCDOmContAssn contAssn = buildCDOmContAssn(stmtAssign->getLineNumber(), m_cdomCurrParent);

  if(!m_assignIfcOrSg.empty()) {
    ASSERT(m_assignIfcOrSg.size() == 2, "Assign should have two children!");
    adaptIfcOrSgAssign(m_assignIfcOrSg[0], m_assignIfcOrSg[1], contAssn);
    m_assignIfcOrSg.clear();
  }
  else {
    RefCDOmExpr rhs = CDOmExpr::cast(m_cdomTraversedChildren->back());
    m_cdomTraversedChildren->pop_back();
  
    RefCDOmExpr lhs = CDOmExpr::cast(m_cdomTraversedChildren->back());
    m_cdomTraversedChildren->pop_back();

    //if(m_cdomTraversedChildren->size() <= 2) {
    //RefCDOmBase temp = (m_cdomTraversedChildren->at(0))->getParent();
    //DCERR("parent type is " << (CDOmExpr::cast(temp))->getExprType());
    RefCDOmAssn assn = buildCDOmAssn(stmtAssign->getLineNumber(), 
                                     lhs,
                                     rhs
                                     );
    //}
    //else{
    //  RefCDOmExprConcat exprConcat = build
    //}
  
    contAssn->addNetAssn(assn);
  }
}

}//end of namespace

