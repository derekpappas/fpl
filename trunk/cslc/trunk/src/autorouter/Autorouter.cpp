//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007, 2008 FastPath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of FastPath Logic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of FastPath Logic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

/**
 * Author: Bogdan Zamfir <bogdanz@fplsrl.com>
 */

// The args vector is used by the the error messaging system to print out an error message
// using the current context
// args is declared in 
// trunk/src/support/ErrorAPI.cpp:std::vector<std::string> args;

/**
The call stack for the functions in this module is as follows:

startAutoRouter()
  process()
    getNCA(RefCInstTreeNode node1, RefCInstTreeNode node2)
      getNumHid(RefCInstTreeNode node)    
    getARPath(NSCInstTree::RefCInstTreeNode node1 , NSCInstTree::RefCInstTreeNode node2)
  traverseSegments(RefConnection connection)
    routeSegments(RefConnection conn, TLong id1, TLong id2, EInstanceRel relation) 
      createConnection(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation)
        createSibSibConnection(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2) 
          getRelName(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation) 
          existsPort(RefCInstTreeNode inst, const RefString& portName, RefCInstTreeNode NCA, RefTVec_RefString interfaceNames, TLineNumberType lineNumber, RefString fileName, TBool skipPrefix)
          buildExprLink(RefCSLOmConnectable point, RefTVec_RefString interfaceNames, RefString alternateName, RefCInstTreeNode node1, TBool skipPrefix)
        createCPConnection(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2)
          getRelName(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation) 
          existsPort(RefCInstTreeNode inst, const RefString& portName, RefCInstTreeNode NCA, RefTVec_RefString interfaceNames, TLineNumberType lineNumber, RefString fileName, TBool skipPrefix)
          buildExprLink(RefCSLOmConnectable point, RefTVec_RefString interfaceNames, RefString alternateName, RefCInstTreeNode node1, TBool skipPrefix)
        createPCConnection(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2)
          getRelName(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation) 
          existsPort(RefCInstTreeNode inst, const RefString& portName, RefCInstTreeNode NCA, RefTVec_RefString interfaceNames, TLineNumberType lineNumber, RefString fileName, TBool skipPrefix)
          buildExprLink(RefCSLOmConnectable point, RefTVec_RefString interfaceNames, RefString alternateName, RefCInstTreeNode node1, TBool skipPrefix)
        check(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation) 
          getRelName(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation) 
          existsPort(RefCInstTreeNode inst, const RefString& portName, RefCInstTreeNode NCA, RefTVec_RefString interfaceNames, TLineNumberType lineNumber, RefString fileName, TBool skipPrefix)
          checkRelationshipSignalSignal(TInt dt) 
          checkBitRangeSignalSignal(TLineNumberType lineNumber, RefString fileName, RefCSLOmConnectable p1, RefCSLOmConnectable p2, NSCInstTree::RefCInstTreeNode inst1, NSCInstTree::RefCInstTreeNode inst2, RefCSLOmExprLink link1, RefCSLOmExprLink link2)
    genPort(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection dir)
      buildInterfaces(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl unit, RefTVec_RefString names, RefCInstTreeNode inst)
      create(RefCInstTreeNode inst, RefCSLOmPortDecl port, EInstanceRel rel,  RefString backupName, RefTVec_RefString ifcNames)
        buildSignalGroups(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl unit, RefTVec_RefString names, RefCInstTreeNode inst)
        getBadObj(RefCSLOmUnitDecl unit, RefTVec_RefString names, TBool testIfc) 
 */


#include "Autorouter.h"
#include "../support/CommonSupport.h"
#include "../cslom/CSLOM.h"
#include <string>
#include <vector>

TBool m_arHasErrors = FALSE;

using namespace NSCInstTree;
using namespace NSCSLOm;
using namespace std;

namespace NSAutorouter {

//**************************************************
// const ints                                      
//**************************************************

const int UNIT_NAME = 0;


RefCSLOmExprLink getConnectedFromUnit(RefCSLOmUnitDecl unit, RefCSLOmConnectable obj, RefTVec_TLong path) {
  if (obj->getParentUnit().get() == unit.get()) {
    return obj->getF2ALink();
  }
  else {
    RefTVec_RefCInstTreeNode nodeMap = CInstTreeNode::getNodeMap();
    RefCSLOmUnitInstance inst;
    TVec_TLong::reverse_iterator it = path->rbegin();
    TVec_TLong::reverse_iterator it1;

    for (; it < path->rend(); ++it) {
      it1 = it+1;
      if (nodeMap->at(*it1)->getUnitDecl().get() == unit.get()) {
        inst = nodeMap->at(*it)->getUnitInst();
        break;
      }
    }

    ASSERT(CSLOmUnitDecl::cast(inst->getParent()->getParent())->isSetGenerateUniqueRTL() || inst->getParent()->getParent().get() == unit.get(),"found it");
    RefCSLOmExprLink expr = getConnectedFromUnit((inst)->getUnitDecl(), obj, path);
    if (expr.get()) {
      RefTMap_RefCSLOmExprLink_RefCSLOmExpr connMap = (inst)->getConnectionMap();
      TMap_RefCSLOmExprLink_RefCSLOmExpr::iterator itMap = connMap->find(expr);
      if (itMap != connMap->end()) {
        if (itMap->second->isExprLink()) {
          return CSLOmExprLink::cast(itMap->second);
        }
        else {
          return RefCSLOmExprLink(); // not needed-just return at the end of the function
        }
      }
      else {
        return RefCSLOmExprLink(); // not needed-just return at the end of the function
      }
    }
    else {
      return RefCSLOmExprLink(); // not needed-just return at the end of the function
    }
  }
  return RefCSLOmExprLink();
}

RefCSLOmBase getBadObj(RefCSLOmUnitDecl unit, RefTVec_RefString names, TBool testIfc) {
  RefCSLOmScope scope = unit->getAttachedScope();
  TVec_RefString::iterator it = names->begin();
  RefCSLOmInterface ifc = unit->getDefaultInterface();
  for (; it < names->end(); ++it) {
    RefCSLOmIdentifier id = scope->lookupLocal(*it);
    if (id.get()) {
      if (testIfc && !id->getParent()->isInterface()) {
        return id->getParent();
      }
      else if (!testIfc && !id->getParent()->isSignalGroup()) {
        return id->getParent();
      }
      else {
        scope = CSLOmInterface::cast(id->getParent())->getAttachedScope();
        ifc = CSLOmInterface::cast(id->getParent());
      }
    }
  }
  return RefCSLOmBase();
}

// TBool exprLinkEqual(RefCSLOmExprLink el1, RefCSLOmExprLink el2) {
//   if (el1.get() == el2.get()) {
//     return TRUE;
//   }
//   else {
//     RefTVec_RefString hid1 = el1->getHidNames();
//     RefTVec_RefString hid2 = el2->getHidNames();
//     if (hid1->size() != hid2->size()) {
//       return FALSE;
//     }
//     else {
//       TVec_RefString::iterator it1;
//       TVec_RefString::iterator it2;
//       for (it1 = hid1->begin(),
//            it2 = hid2->begin(); 
//            it1 < hid1->end(),
//            it2 < hid2->end(); 
//            ++it1,
//            ++it2) {
//         if ((*it1)->compare(*(*it2)) != 0) {
//           return FALSE;
//         }
//         else {
//           //do nothing
//         }
//       }
//     }
//   }
//   return TRUE;
// }


TBool less_RefCSLOmExprLink::operator() (const NSCSLOm::RefCSLOmExprLink& s1, const NSCSLOm::RefCSLOmExprLink& s2) const {
  ASSERT(s1.get(), "null string 1");
  ASSERT(s2.get(), "null string 2");

  RefTVec_RefString vec1 = s1->getHidNames();
  RefTVec_RefString vec2 = s2->getHidNames();

  if (vec1->size() < vec2->size()) {
    return TRUE;
  }
  else if (vec1->size() == vec2->size()) {
    for (TUInt i = 0; i < vec2->size(); i++ ) {
      if (vec1->at(i)->compare( *( vec2->at(i) ) ) < ZERO) {
        return TRUE;
      }
    }
  }
 
  return FALSE;
}

// ********************************************************************************
// CAutorouterScope class
// ********************************************************************************

// ********************************************************************************
// ConnectionEndPoint class
// ********************************************************************************
ConnectionEndPoint::ConnectionEndPoint(TLineNumberType lineNumber, RefString fileName) :
  m_lineNumber(lineNumber),
  m_fileName(fileName),
  m_endPointLink(),
  m_endPointExpr(),
  m_postProcessNode(),
  m_endPoint(),
  m_interfaceNames(),
  m_endPointIfcNames(),
  m_wasSignal(FALSE),
  m_prefix(),
  m_ifcName(),
  m_lvl(-1) {}

RefConnectionEndPoint ConnectionEndPoint::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink linkToEndPoint, RefString prefix, TUInt level) {
  ASSERT(linkToEndPoint.get(), "null link received");

  ConnectionEndPoint* endPoint;
  try {
    endPoint = new ConnectionEndPoint(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefConnectionEndPoint refEndPoint = RefConnectionEndPoint(endPoint);

  endPoint->m_endPointLink = linkToEndPoint;
  endPoint->m_endPoint = CSLOmConnectable::cast(linkToEndPoint->doEval());
  if (level == -1 && prefix.get()) {
    endPoint->m_prefix = prefix;
  }
  else if (prefix.get()){
    endPoint->m_ifcName = prefix;
    endPoint->m_lvl = level;
  }
  ASSERT(endPoint->m_endPoint.get(),"this should not be null, cannot connect an object that doesn't exist");

  return refEndPoint;
}

RefConnectionEndPoint ConnectionEndPoint::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmExpr linkToEndPoint, RefString prefix, TUInt level) {
  ASSERT(linkToEndPoint.get(), "null link received");

  ConnectionEndPoint* endPoint;
  try {
    endPoint = new ConnectionEndPoint(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefConnectionEndPoint refEndPoint = RefConnectionEndPoint(endPoint);

  endPoint->m_endPointExpr = linkToEndPoint;
  endPoint->m_endPoint = CSLOmConnectable::cast(linkToEndPoint->doEval());
  if (level == -1 && prefix.get()) {
    endPoint->m_prefix = prefix;
  }
  else if (prefix.get()){
    endPoint->m_ifcName = prefix;
    endPoint->m_lvl = level;
  }
  //  ASSERT(endPoint->m_endPoint.get(),"this should not be null, cannot connect an object that doesn't exist");
  
  return refEndPoint;
}


TBool ConnectionEndPoint::genPort(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection dir) {
  if (m_endPoint->isSignal()) {
    m_wasSignal = TRUE;
    RefCSLOmSignal sig = CSLOmSignal::cast(m_endPoint);

    TLineNumberType ln = sig->getLineNumber();
    ECSLOmSignalType type = sig->getSignalType();
    RefString name = RefString(new std::string("ars_"));
    name->append(*sig->getName());
    RefCSLOmBaseRange br = sig->getBitRange();
    if(type == SIGNAL_REG) {
      args.push_back(*convertLink(m_endPointLink));
      addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_REG, args, lineNumber, fileName);
      m_arHasErrors = TRUE;
      return FALSE;
    }
    else {

      ASSERT(sig->getParent()->isUnitDecl() || sig->getParent()->isSignalGroup(),"only unit decl parent is supported for now..");

      if (sig->getParent()->isUnitDecl()) {
        RefCSLOmUnitDecl unit = CSLOmUnitDecl::cast(sig->getParent());
        RefCSLOmIdentifier id = unit->getAttachedScope()->lookupLocal(name);
        if (!id.get()) {
          if (m_endPointLink->hasBitRange()) {
            name->append("_ps");
          }
          m_endPoint = unit->addPort(lineNumber, fileName, dir != DIR_UNDEFINED ? dir:INOUT, type, name, RefCSLOmExprLink() );
          CSLOmPortDecl::cast(m_endPoint)->setBitRange(m_endPointLink->hasBitRange() ? CSLOmBaseRange::cast(m_endPointLink->getBitRange()) : br);

          m_endPoint->enableArGenerated();
          if(m_postProcessNode->getUnitInst().get()) {
            m_endPoint->setArInstance(CSLOmIdentifier::cast(m_postProcessNode->getUnitInst()->getChild(ID))->getName());
          }
          else {
            m_endPoint->setArInstance(RefString(new std::string("no instance(top unit)")));
          }
          RefCSLOmExprLink newPort = CSLOmExprLink::build(lineNumber, fileName, name);
          newPort->setValue(m_endPoint);
          newPort->addID(CSLOmIdentifier::cast(m_endPoint->getChild(ID)));
          CSLOmStmtAssign::build(lineNumber, fileName, unit, newPort, m_endPointLink);
        }
        else if (id->getParent()->isPort() && CSLOmConnectable::cast(id->getParent())->isArGenerated() && CSLOmPortDecl::cast(id->getParent())->getPortDirection()==dir) {
          m_endPoint = CSLOmConnectable::cast(id->getParent());
        }
        else if (!id->getParent()->isPort()) {
          args.push_back(intToString(id->getParent()->getLineNumber()));
          args.push_back(*CSLOmIdentifier::cast(m_postProcessNode->getUnitDecl()->getChild(ID))->getName());
          args.push_back(*CSLOmConnectable::cast(id->getParent())->getArInstance());
          args.push_back(*id->getName());
          args.push_back("type");
          args.push_back(*CSLOmIdentifier::cast(m_postProcessNode->getUnitInst()->getChild(ID))->getName());
          addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, lineNumber, fileName);
          m_arHasErrors = TRUE;
          return FALSE;
        }
        else {
          args.push_back(intToString(id->getParent()->getLineNumber()));
          args.push_back(*CSLOmIdentifier::cast(m_postProcessNode->getUnitDecl()->getChild(ID))->getName());
          args.push_back(*CSLOmConnectable::cast(id->getParent())->getArInstance());
          args.push_back(*id->getName());
          args.push_back("direction");
          args.push_back(*CSLOmIdentifier::cast(m_postProcessNode->getUnitInst()->getChild(ID))->getName());
          addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, lineNumber, fileName);
          m_arHasErrors = TRUE;
          return FALSE;
        }
      }
      else {
        RefString portName = name;
        RefCSLOmExprLink signal = CSLOmExprLink::build(lineNumber, fileName, sig->getName());

        RefString errorName(new std::string);
        RefTVec_RefString temp = RefTVec_RefString(new TVec_RefString);
        RefCSLOmBase parent = sig->getParent();
        while (parent->isSignalGroup()) {
          RefString name = RefString(new std::string("arifc_"));
          name->append(*CSLOmIdentifier::cast(parent->getChild(ID))->getName());
          temp->push_back(name);
          signal->addScopeItem(CSLOmIdentifier::cast(parent->getChild(ID))->getName());
          parent = parent->getParent();        
        }
        errorName->append(*(signal->getHidNames()->at(0)));

        RefCSLOmExprLink newSigExpr = signal;//CSLOmExprLink::build(lineNumber, fileName, newSignal);
        newSigExpr->setValue(sig);
        newSigExpr->addID(CSLOmIdentifier::cast(sig->getChild(ID)));
        if (m_endPointLink->hasBitRange()) {
          newSigExpr->setBitRange(m_endPointLink->getBitRange());
        }

        m_endPointIfcNames = temp;
        m_interfaceNames = RefTVec_RefString(new TVec_RefString);
        for (TVec_RefString::iterator it = temp->begin(); it < temp->end(); it++) {
          m_interfaceNames->push_back(*it);
        }
        if(!parent->isUnitDecl()) {
          args.push_back(*errorName);
          addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_GLOBAL_OBJ, args, lineNumber, fileName);
          m_arHasErrors = TRUE;
          return FALSE;
        }

        ASSERT(parent->isUnitDecl(), "ERROR: the sg should be in a unit");
        
        RefCSLOmInterface ifc = CAutorouter::buildInterfaces(lineNumber, fileName, CSLOmUnitDecl::cast(parent),temp, m_postProcessNode);
        RefCSLOmIdentifier id = ifc->getAttachedScope()->lookupLocal(name);
        if (!id.get() || !CSLOmConnectable::cast(id->getParent())->isArGenerated()) {
          RefCSLOmIdentifier id1 = ifc->getAttachedScope()->lookupLocal(portName);
          if (!id1.get()) {
            m_endPoint = ifc->addPort(lineNumber, fileName, portName, dir != DIR_UNDEFINED ? dir:INOUT, type);
            RefCSLOmExprLink newPort = CSLOmExprLink::build(lineNumber, fileName, portName);
            for (TVec_RefString::reverse_iterator it = temp->rbegin(); it < temp->rend(); it++) {
              newPort->addScopeItem(*it);
            }
            RefCSLOmExpr widthExpr = m_endPointLink->hasBitRange() ? m_endPointLink->getBitRange()->getWidth() : sig->getWidth();
            RefTMap_RefCSLOmUnitInstance_RefCSLOmBase eval = widthExpr->doParamEval(sig);
            TInt widthVal = CSLOmExpr::getValueForInstance(m_postProcessNode->getUnitInst(), eval)->getValue();
            
            CSLOmPortDecl::cast(m_endPoint)->setWidth(CSLOmNum32::build(m_lineNumber, m_fileName, widthVal));
            m_endPoint->enableArGenerated();
            if(m_postProcessNode->getUnitInst().get()) {
              m_endPoint->setArInstance(CSLOmIdentifier::cast(m_postProcessNode->getUnitInst()->getChild(ID))->getName());
            }
            else {
              m_endPoint->setArInstance(RefString(new std::string("no instance(top unit)")));
            }
            newPort->setValue(m_endPoint);
            newPort->addID(CSLOmIdentifier::cast(m_endPoint->getChild(ID)));
            signal->setValue(sig);
            signal->addID(CSLOmIdentifier::cast(sig->getChild(ID)));
            CSLOmStmtAssign::build(lineNumber, fileName, parent, newPort, newSigExpr);
          }
          else if (id1->getParent()->isPort() && CSLOmConnectable::cast(id1->getParent())->isArGenerated() && CSLOmPortDecl::cast(id1->getParent())->getPortDirection()==dir) {
            m_endPoint = CSLOmConnectable::cast(id1->getParent());
          }
          else if (!id1->getParent()->isPort()){
            args.push_back(intToString(id1->getParent()->getLineNumber()));
            args.push_back(*CSLOmIdentifier::cast(m_postProcessNode->getUnitDecl()->getChild(ID))->getName());
            args.push_back(*CSLOmConnectable::cast(id1->getParent())->getArInstance());
            args.push_back(*id1->getName());
            args.push_back("type");
            args.push_back(*CSLOmIdentifier::cast(m_postProcessNode->getUnitInst()->getChild(ID))->getName());
            addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, lineNumber, fileName);
            m_arHasErrors = TRUE;
            return FALSE;
          }
          else {
            args.push_back(intToString(id1->getParent()->getLineNumber()));
            args.push_back(*CSLOmIdentifier::cast(m_postProcessNode->getUnitDecl()->getChild(ID))->getName());
            args.push_back(*CSLOmConnectable::cast(id1->getParent())->getArInstance());
            args.push_back(*id1->getName());
            args.push_back("direction");
            args.push_back(*CSLOmIdentifier::cast(m_postProcessNode->getUnitInst()->getChild(ID))->getName());
            addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, lineNumber, fileName);
            m_arHasErrors = TRUE;
            return FALSE;
          }
        }
        else if (id.get()) {
          m_endPoint = CSLOmConnectable::cast(id->getParent());
        }
      }
    }
  }
  else if (m_endPointLink->hasBitRange()){
    RefCSLOmBase parent = m_endPoint->getParent();
    RefCSLOmExprLink oldPort = CAutorouter::buildExprLink(m_endPoint, m_endPointIfcNames, RefString(), m_postProcessNode, FALSE);
    oldPort->setBitRange(m_endPointLink->getBitRange());
    oldPort->setValue(m_endPoint);
    RefString name = RefString(new std::string("ar_ps_"));
    name->append(*CSLOmIdentifier::cast(m_endPoint->getChild(ID))->getName());
    if (parent->isInterface() && CSLOmInterface::cast(parent)->isDefaultIfc()) {
      RefCSLOmUnitDecl unit = CSLOmUnitDecl::cast(parent->getParent());
      m_endPoint = unit->addPort(lineNumber, fileName, CSLOmPortDecl::cast(m_endPoint)->getPortDirection(), CSLOmPortDecl::cast(m_endPoint)->getPortType(), name, RefCSLOmExprLink());
      m_endPoint->enableArGenerated();
      CSLOmPortDecl::cast(m_endPoint)->setBitRange(CSLOmBaseRange::cast(m_endPointLink->getBitRange()));
    }
    else {
      RefCSLOmInterface ifc = CSLOmInterface::cast(parent);
      m_endPoint = ifc->addPort(lineNumber, fileName, name, CSLOmPortDecl::cast(m_endPoint)->getPortDirection(), CSLOmPortDecl::cast(m_endPoint)->getPortType());
      m_endPoint->enableArGenerated();
      CSLOmPortDecl::cast(m_endPoint)->setBitRange(CSLOmBaseRange::cast(m_endPointLink->getBitRange()));
    }
    RefCSLOmExprLink newPort = CAutorouter::buildExprLink(m_endPoint, m_endPointIfcNames, RefString(), m_postProcessNode, FALSE);
    newPort->setValue(m_endPoint);
    newPort->addID(CSLOmIdentifier::cast(m_endPoint->getChild(ID)));
    CSLOmStmtAssign::build(lineNumber, fileName, (parent->isInterface() && CSLOmInterface::cast(parent)->isDefaultIfc()) ? parent->getParent(): parent, newPort, oldPort);
  }

  return TRUE;
}

void ConnectionEndPoint::processExpr(ECSLOmPortDirection dir) {
  ASSERT(hasExpr(), "has to have expr");
  ASSERT(!m_endPointExpr->isExprLink(), "expr cannot be HID");

  TInt width = m_endPointExpr->getWidth();
  ECSLOmPortDirection exprDir = DIR_UNDEFINED;
  RefString name = RefString(new std::string("ar_expr"));
  
  RefTVec_RefCSLOmExpr exprs = m_endPointExpr->getExprs();
  RefCInstTreeNode inst = RefCInstTreeNode();
  for (TVec_RefCSLOmExpr::iterator it = exprs->begin(); it < exprs->end(); it++) {
    if ((*it)->isExprLink()) {
      m_endPointLink = CSLOmExprLink::cast(*it);
      m_endPointLink->addScopeItem(CSLOmIdentifier::cast(CSLOmConnectable::cast(m_endPointLink->getValue())->getParentUnit()->getChild(ID))->getName());
      name->append("_");
      name->append(*m_endPointLink->getName());
      processLink(FALSE);
      if (!inst.get()) {
        inst = m_postProcessNode;
      }
      else if (inst.get() != m_postProcessNode.get()) {
        //to do throw error
        return;
      }

      RefCSLOmExprLink link = CSLOmExprLink::build(m_lineNumber, m_fileName, m_endPointLink->getName());
      if (m_endPointIfcNames.get()) {
        for (TVec_RefString::reverse_iterator iter = m_endPointIfcNames->rbegin(); iter < m_endPointIfcNames->rend(); iter++) {
          link->addScopeItem(*iter);
        }
      }

      CSLOmScopeBlock::enterScope(CSLOmBase::getAttachedScope(m_postProcessNode->getUnitDecl().get()));
      link->doEval();
      CSLOmScopeBlock::exitScope();

      if (!link->doEval().get()) {
        //to do throw error
      }
      else if (link->doEval()->isPort() && exprDir == DIR_UNDEFINED) {
        exprDir = CSLOmPortDecl::cast(link->doEval())->getPortDirection();
      }
      else if (link->doEval()->isPort() && (CSLOmPortDecl::cast(link->doEval())->getPortDirection() != exprDir)) {
        // to do throw error
        return;
      }
    }
  }

  RefCSLOmUnitDecl parent = m_postProcessNode->getUnitDecl();
  RefCSLOmPortDecl port = CSLOmPortDecl::build(m_lineNumber, m_fileName, parent->getDefaultInterface(), name, exprDir == DIR_UNDEFINED ? dir : exprDir, CSLOmNum32::build(m_lineNumber, m_fileName, width));
  RefCSLOmExprLink lhs = CSLOmExprLink::build(m_lineNumber, m_fileName, name);
  lhs->setValue(port);
  lhs->addID(CSLOmIdentifier::cast(port->getChild(ID)));
  CSLOmStmtAssign::build(m_lineNumber, m_fileName, parent, lhs, m_endPointExpr);
  m_endPoint = port;
  m_endPointIfcNames = RefTVec_RefString();
  m_interfaceNames = RefTVec_RefString();
  m_endPointLink = lhs;
}

// ********************************************************************************
// CONCAT
// create the ports in each child and the formal in the instantiation
// create the signal for the concat
// create the concat using the formals in the parent
// assign the concat to the signal
// change the end point name to the LHS concat
// generate connections 
// ********************************************************************************

void ConnectionEndPoint::processLink(TBool isEndPointParam) {
  RefCInstTreeNode temp;

  RefTVec_RefString names = m_endPointLink->getHidNames();
  TVec_RefString::iterator strIter = names->begin();
  RefString unitName = names->at(0);
  strIter++;
  RefString errorStr(new std::string(*m_endPointLink->getName()));
  RefTVec_RefCInstTreeNode nodes = CInstTreeNode::getNodeMap();

  for (TVec_RefCInstTreeNode::iterator it = nodes->begin(); it < nodes->end(); ++it) {
    if (CSLOmIdentifier::cast((*it)->getUnitDecl()->getChild(ID))->getName()->compare(*unitName) == 0) {
      temp = *it;
      break;
    }
    if ((*it)->getUnitDecl()->isReplica()) {
      RefCSLOmUnitDecl decl = CSLOmUnitReplica::cast((*it)->getUnitDecl())->getUnitDecl();
      if( CSLOmIdentifier::cast(decl->getChild(ID))->getName()->compare(*unitName) == 0) {
        temp = *it;
        break;
      }
    }
  }

  while( strIter < names->end() - 1 && (temp->getChildren().get() && temp->getChildren()->find(*strIter) != temp->getChildren()->end())) {
    ASSERT(temp->getChildren()->find(*strIter) != temp->getChildren()->end(), "this should not happen");

    temp = temp->getChildren()->find(*strIter)->second;
    ++strIter;
  }
  if(!m_endPointIfcNames.get()) {
    if (strIter < names->end() - 1) {
      m_endPointIfcNames = RefTVec_RefString(new TVec_RefString);
      for (; strIter < names->end() - 1; ++strIter) {
        m_endPointIfcNames->push_back(*strIter);
      }
    }
  }
  if(!m_interfaceNames.get()) {
    if (m_endPointIfcNames.get()) {
      m_interfaceNames = RefTVec_RefString(new TVec_RefString);
      if (m_prefix.get()) {
        m_interfaceNames->push_back(m_prefix);
      }
      for (TVec_RefString::iterator it = m_endPointIfcNames->begin(); it < m_endPointIfcNames->end() ; ++it) {
        m_interfaceNames->push_back(*it);
      }
    }
  }
  if (!isEndPointParam) {
    if (m_interfaceNames.get()) {
      errorStr->clear();
      errorStr->append(*m_interfaceNames->back());
      //----------------
      if (m_ifcName.get() && m_lvl != -1) {
        (*m_interfaceNames)[m_lvl] = m_ifcName;    
      }
    }
  }
  if (!temp.get()) {
    args.push_back(*errorStr);
    addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_GLOBAL_OBJ, args, m_lineNumber, m_fileName);
    m_arHasErrors = TRUE;
  }
  m_postProcessNode = temp;
}

// ********************************************************************************
// CSLOmConnection class
// ********************************************************************************
RefTVec_RefConnection Connection::m_connectionMap = RefTVec_RefConnection(new TVec_RefConnection);
Connection::Connection(TLineNumberType lineNumber, RefString fileName) :
  m_lineNumber(lineNumber),
  m_fileName(fileName),
  m_endPoint1(),
  m_endPoint2(),
  m_interName() {}

RefConnection Connection::build(TLineNumberType lineNumber, RefString fileName, RefConnectionEndPoint endPoint1, RefConnectionEndPoint endPoint2, RefString interName) {
  ASSERT(endPoint1.get(), "null link received");
  ASSERT(endPoint2.get(), "null link received");
  
  Connection* connection;
  try {
    connection = new Connection(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefConnection refConnection = RefConnection(connection);

  connection->m_endPoint1 = endPoint1;
  connection->m_endPoint2 = endPoint2;
  connection->m_interName = interName;//new std::string("t"));

  return refConnection;
}

TBool Connection::lookup(NSCSLOm::RefCSLOmExprLink scope, NSCSLOm::RefCSLOmExprLink link, NSCSLOm::RefCSLOmUnitDecl unit, RefString name, RefTVec_RefString path) {
  TBool found = FALSE;
  RefTVec_RefCSLOmExprLink temp = CSLOmExprLink::isPatternIn(link, unit->getAttachedScope());
  if (temp.get()) {
    for (TVec_RefCSLOmExprLink::iterator it = temp->begin(); it < temp->end(); it++) {
      TVec_RefString::reverse_iterator it1 = path->rbegin();
      for (; it1 < path->rend(); ++it1) {
        (*it)->addScopeItem(*it1);
      }
      addConnection(CSLOmExprLink::cast(scope->dupp()), *it, name, FALSE);
      found = TRUE;
    }
  }

  RefTVec_RefCSLOmUnitInstance instances = unit->getUnitInstances();
  TVec_RefCSLOmUnitInstance::iterator iter = instances->begin();
  for (; iter < instances->end(); ++iter) {
    RefString instName = (*iter)->getName();
    path->push_back(instName);
    TBool res = lookup(scope, link, (*iter)->getUnitDecl(), name, path);
    if (res && !found) {
      found = TRUE;
    }
    path->pop_back();
  }
  return found;
}

  /** add a connect_by_name to the connection list
      haveToLookup - look up the objects
   */
void Connection::addConnection(RefCSLOmExpr object1, RefCSLOmExpr object2, RefString name, TBool haveToLookup) {
  ASSERT(object1.get(),"object to be connected should not be NULL");
  ASSERT(object2.get(),"object to be connected should not be NULL");
  if(object1->isExprLink() && object2->isExprLink()) {
    if (haveToLookup) {
      TBool found = FALSE;
      //     if (object2->doEval().get()) {
      //       addConnection(CSLOmExprLink::cast(object1->dupp()), CSLOmExprLink::cast(object2->dupp()), name, FALSE);
      //       found = TRUE;
      //     }
      //     else {
      found = lookup(CSLOmExprLink::cast(object1), 
                     CSLOmExprLink::cast(object2), 
                     CSLOmUnitDecl::cast(NSCSLOm::CSLOmScopeBlock::getCurrentScope()->getHolderObject()), 
                     name, 
                     RefTVec_RefString(new TVec_RefString));
      //    }
      if (!found) {
        args.push_back(*convertLink(CSLOmExprLink::cast(object2)));
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_PARAM_NOT_FOUND, args, object1->getLineNumber(), object1->getFileName());
        m_arHasErrors = TRUE;
      }
    }
    else {
      RefCSLOmBase obj1 = object1->doEval();
      RefCSLOmBase obj2 = object2->doEval();
  
      if (!obj1.get() || !obj2.get()) {
        args.push_back(*convertLink(obj1.get()? CSLOmExprLink::cast(object2): CSLOmExprLink::cast(object1)));
        args.push_back(*CSLOmIdentifier::cast(CSLOmScopeBlock::getCurrentScope()->getID())->getName());
        addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, object1->getLineNumber(),object1->getFileName());
        m_arHasErrors=TRUE;
        return;
      }

      if ((obj1->isPort()   && obj2->isPort()  ) ||
          (obj1->isSignal() && obj2->isPort()  ) ||
          (obj1->isPort()   && obj2->isSignal())) {
        addConnectionPort(object1, object2, name);
      }
      else if (obj1->isInterface() && obj2->isInterface()) { // FIX - create error function
        if (!addConnectionInterface(CSLOmExprLink::cast(object1), CSLOmExprLink::cast(object2), name, FALSE, TRUE, -1)) {
          args.push_back(*convertLink(CSLOmExprLink::cast(object1)));
          args.push_back(*convertLink(CSLOmExprLink::cast(object2)));
          addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_NO_MATCH_CONNECT_BY_NAME, args, object1->getLineNumber(), object1->getFileName());
        }
      }
      else if (obj1->isInstance() && obj2->isInstance()) { // FIX - create error function
        CSLOmExprLink::cast(object1)->setValue(CSLOmUnitInstance::cast(obj1)->getUnitDecl()->getDefaultInterface());
        CSLOmExprLink::cast(object2)->setValue(CSLOmUnitInstance::cast(obj2)->getUnitDecl()->getDefaultInterface());
        if (!addConnectionInterface(CSLOmExprLink::cast(object1), CSLOmExprLink::cast(object2), name, TRUE, FALSE, -1)) {
          args.push_back(*convertLink(CSLOmExprLink::cast(object1)));
          args.push_back(*convertLink(CSLOmExprLink::cast(object2)));
          addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_NO_MATCH_CONNECT_BY_NAME, args, object1->getLineNumber(), object1->getFileName());
        }
      }
      else if ((obj1->isSignalGroup() && obj2->isInterface()) ||
               (obj2->isSignalGroup() && obj1->isInterface())){
        if (!addConnectionSignalGroup(CSLOmExprLink::cast(object1), CSLOmExprLink::cast(object2), name)) { // FIX - create error function
          args.push_back(*convertLink(CSLOmExprLink::cast(object1)));
          args.push_back(*convertLink(CSLOmExprLink::cast(object2)));
          addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_NO_MATCH_CONNECT_BY_NAME, args, object1->getLineNumber(), object1->getFileName());
        }
      }
      else { // FIX - create error function
        args.push_back(*convertLink(CSLOmExprLink::cast(object1)));
        args.push_back(*convertLink(CSLOmExprLink::cast(object2)));
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_INVALID_TYPES, args, object1->getLineNumber(), object1->getFileName());
        m_arHasErrors = TRUE;
      }
    }
  }
  else {
    if(object1->isExprLink() && (object1->doEval()->isSignalGroup() || object1->doEval()->isInterface())) { // FIX - create error function
      args.push_back(*convertLink(CSLOmExprLink::cast(object1)));
      args.push_back("expression");
      addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_INVALID_TYPES, args, object1->getLineNumber(), object1->getFileName());
      m_arHasErrors = TRUE;
      return;
    }

    if(object1->isExprLink() && object1->doEval()->isInstance()) { // FIX - create error function
      args.push_back(*convertLink(CSLOmExprLink::cast(object1)));
      args.push_back("expression");
      addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_INVALID_TYPES, args, object1->getLineNumber(), object1->getFileName());
      m_arHasErrors = TRUE;
      return;
    }

    if(object2->isExprLink() && (object2->doEval()->isSignalGroup() || object2->doEval()->isInterface())) { // FIX - create error function
      args.push_back("expression");
      args.push_back(*convertLink(CSLOmExprLink::cast(object2)));
      addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_INVALID_TYPES, args, object1->getLineNumber(), object1->getFileName());
      m_arHasErrors = TRUE;
      return;
    }
    addConnectionPort(object1, object2, name);
  }
}

void Connection::addConnectionPort(RefCSLOmExpr object1, RefCSLOmExpr object2, RefString name, TBool isPrefix, TBool isIfcConn, TInt level) {
  ASSERT(object1.get(),"object to be connected should not be NULL");
  ASSERT(object2.get(),"object to be connected should not be NULL");

  RefCSLOmExprLink fullPath1; 
  if (object1->isExprLink()) {
    fullPath1 = CSLOmExprLink::cast(object1)->getFullPathLink();
  }
  RefCSLOmExprLink fullPath2; 
  if (object2->isExprLink()) {
    fullPath2 = CSLOmExprLink::cast(object2)->getFullPathLink();
  }

  RefConnectionEndPoint endPoint1; 
  if (fullPath1.get()) { // FIX - FACTOR fullPath1 or object1
    endPoint1 = ConnectionEndPoint::build(fullPath1->getLineNumber(),fullPath1->getFileName(), fullPath1, !(isPrefix || isIfcConn) ? RefString() : name, level);
  }
  else {
    endPoint1 = ConnectionEndPoint::build(object1->getLineNumber(),object1->getFileName(), object1, !(isPrefix || isIfcConn) ? RefString() : name, level);
  }

  RefConnectionEndPoint endPoint2;
  if(fullPath2.get()) {  // FIX - FACTOR fullPath2 or object2
    endPoint2 = ConnectionEndPoint::build(fullPath2->getLineNumber(),fullPath2->getFileName(), fullPath2, !(isPrefix || isIfcConn) ? RefString() : name, level);
  }
  else {
    endPoint2 = ConnectionEndPoint::build(object2->getLineNumber(),object2->getFileName(), object2, !(isPrefix || isIfcConn) ? RefString() : name, level);
  }

  if (endPoint1.get() && endPoint2.get()) {
    RefConnection connection = Connection::build(fullPath1->getLineNumber(), fullPath1->getFileName() ,endPoint1, endPoint2, isPrefix || isIfcConn ? RefString() : name );

    if (connection.get()) {
      m_connectionMap->push_back(connection);
    }
  }
}

TBool Connection::addConnectionInterface(RefCSLOmExprLink object1, RefCSLOmExprLink object2, RefString name, TBool isPrefix, TBool isIfcConn, TInt level) {
  ASSERT(object1.get(),"object to be connected should not be NULL");
  ASSERT(object2.get(),"object to be connected should not be NULL");

  RefCSLOmInterface ifc1 = CSLOmInterface::cast(object1->doEval());
  RefCSLOmInterface ifc2 = CSLOmInterface::cast(object2->doEval());

  ASSERT(ifc1.get(),"this should not be null");
  ASSERT(ifc2.get(),"this should not be null");


  RefCSLOmBase temp = ifc1->getParent();
  TUInt index = -1;
  if (isIfcConn) {
    while (!temp->isUnitDecl()) {
      temp = temp->getParent();
      index++;
    }
  }
  

  TBool found = FALSE;
  RefCSLOmScope scope = ifc2->getAttachedScope();
  if (ifc2->isDefaultIfc()) {
    scope = CSLOmUnitDecl::cast(ifc2->getParent())->getAttachedScope();
  }
  RefTVec_RefCSLOmPortDecl ports = ifc1->getPorts();
  if (ports.get()) {
    for (TVec_RefCSLOmPortDecl::iterator it = ports->begin(); it < ports->end(); ++it) {
      RefCSLOmIdentifier id = scope->lookupLocal((*it)->getName());
      if (id.get() && id->getParent()->isPort()) { // FIX - create error function
        RefCSLOmExprLink obj1 = CSLOmExprLink::cast(object1->dupp());
        RefCSLOmExprLink obj2 = CSLOmExprLink::cast(object2->dupp());
        obj1->addHidItem((*it)->getName());
        obj2->addHidItem((*it)->getName());
        addConnectionPort(obj1, obj2, name, isPrefix, TRUE, index == -1 ? level : index);
        found = TRUE;
      }
    }
  }

  RefTVec_RefCSLOmInterface ifcs = ifc1->getInterfaces();
  if (ifcs.get()) {
    for (TVec_RefCSLOmInterface::iterator it = ifcs->begin(); it < ifcs->end(); ++it) {
      RefCSLOmIdentifier id = scope->lookupLocal((*it)->getName());
      if (id.get() && id->getParent()->isInterface()) { // FIX - create error function
        RefCSLOmExprLink obj1 = CSLOmExprLink::cast(object1->dupp());
        RefCSLOmExprLink obj2 = CSLOmExprLink::cast(object2->dupp());
        obj1->addHidItem((*it)->getName());
        obj2->addHidItem((*it)->getName());
        found = addConnectionInterface(obj1, obj2, name, isPrefix, FALSE, index == -1 ? level : index) || found;
        
      }
    }
  }
  return found;
}

TBool Connection::addConnectionSignalGroup(RefCSLOmExprLink object1, RefCSLOmExprLink object2, RefString name) {
  ASSERT(object1.get(),"object to be connected should not be NULL");
  ASSERT(object2.get(),"object to be connected should not be NULL");

  RefCSLOmBase eval1 = object1->doEval();
  RefCSLOmBase eval2 = object2->doEval();

  RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(eval1->isInterface() ? eval2 : eval1);
  RefCSLOmInterface  ifc =   CSLOmInterface::cast(eval2->isInterface() ? eval2 : eval1);

  ASSERT(sg.get(),"this should not be null");
  ASSERT(ifc.get(),"this should not be null");
  
  TBool found = FALSE;

  RefCSLOmScope scope = sg->getAttachedScope();
  RefTVec_RefCSLOmPortDecl ports = ifc->getPorts();
  if (ports.get()) {
    for (TVec_RefCSLOmPortDecl::iterator it = ports->begin(); it < ports->end(); ++it) {
      RefCSLOmIdentifier id = scope->lookupLocal((*it)->getName());
      if (id.get() && id->getParent()->isSignal()) { // FIX - create function
        RefCSLOmExprLink obj1 = CSLOmExprLink::cast(object1->dupp());
        RefCSLOmExprLink obj2 = CSLOmExprLink::cast(object2->dupp());
        obj1->addHidItem((*it)->getName());
        obj2->addHidItem((*it)->getName());
        addConnectionPort(obj1, obj2, name, FALSE, TRUE);
        found = TRUE;
      }
    }
  }

  RefTVec_RefCSLOmInterface ifcs = ifc->getInterfaces();
  if (ifcs.get()) {
    for (TVec_RefCSLOmInterface::iterator it = ifcs->begin(); it < ifcs->end(); ++it) {
      RefCSLOmIdentifier id = scope->lookupLocal((*it)->getName());
      if (id.get() && id->getParent()->isInterface()) { // FIX - create function
        RefCSLOmExprLink obj1 = CSLOmExprLink::cast(object1->dupp());
        RefCSLOmExprLink obj2 = CSLOmExprLink::cast(object2->dupp());
        obj1->addHidItem((*it)->getName());
        obj2->addHidItem((*it)->getName());
        found = found || addConnectionSignalGroup(obj1, obj2, RefString());
      }
    }
  }
  return found;
}

RefCSLOmConnectable Connection::create(RefCInstTreeNode inst, RefCSLOmPortDecl port, EInstanceRel rel,  RefString backupName, RefTVec_RefString ifcNames) {
  RefString name = backupName;
  TLineNumberType lineNumber = m_lineNumber;
  RefString fileName = m_fileName;
  RefCInstTreeNode NCA = m_NCA;
  //  if (!existsPort(inst, port->getName(), NCA, ifcNames).get() && !existsPort(inst, name, NCA, ifcNames).get()) {
  ECSLOmPortDirection pd = port->getPortDirection();
  if (rel == REL_SS) {
    if (pd == INPUT) {
      pd = OUTPUT;
    }
    else if (pd == OUTPUT) {
      pd = INPUT;
    }
  }

  RefCSLOmUnitDecl unit;
  if (inst->getUnitInst().get()) {
    unit = inst->getUnitInst()->getUnitDecl();
  }
  else {
    unit = inst->getUnitDecl();
  }

  ASSERT(unit.get(),"error unit does not exist");

  RefCSLOmInterface ifc = RefCSLOmInterface();
  RefCSLOmGroupSignal sg = RefCSLOmGroupSignal();
  if (ifcNames.get()) {
    if(inst == NCA) {
      sg = CAutorouter::buildSignalGroups(lineNumber, fileName, unit, ifcNames, inst);
    }
    else {
      ifc = CAutorouter::buildInterfaces(lineNumber, fileName, unit, ifcNames, inst);
    }
  }
  else {
    ifc = unit->getDefaultInterface();
  }


  // FIX what are first, second, third????

  TBool first  = (rel == REL_CP || rel == REL_PC) && ifc.get();
  TBool second = (rel == REL_SS && inst == NCA) && (sg.get() || !ifcNames.get());
  TBool third  = (rel == REL_SS && inst != NCA) && ifc.get();

  if(!first && !second && !third) {
    if (rel == REL_SS && inst == NCA) { // ifc
      RefCSLOmBase badObj = getBadObj(unit, ifcNames, FALSE);
      if (badObj->isConnectable() && CSLOmConnectable::cast(badObj)->isArGenerated()) { // FIX - create error function
        args.push_back(intToString(badObj->getLineNumber()));
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitDecl()->getChild(ID))->getName());
        args.push_back(*CSLOmConnectable::cast(badObj)->getArInstance());
        args.push_back(*CSLOmIdentifier::cast(badObj->getChild(ID))->getName());
        args.push_back("type");
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, lineNumber, fileName);
        m_arHasErrors = TRUE;
      }
      else {
        RefCSLOmBase temp = badObj;
        while (!temp->getParent()->getParent()->isUnitDecl()) {
          temp = temp->getParent();
        }
        args.push_back(intToString(badObj->getLineNumber()));
        args.push_back(*CSLOmIdentifier::cast(temp->getChild(ID))->getName());
        args.push_back(*CSLOmIdentifier::cast(badObj->getChild(ID))->getName());
        args.push_back("type");
        if (inst->getUnitInst().get()) {
          args.push_back(*CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
        }
        else {
          RefString topName = RefString(new std::string("top unit: "));
          topName->append(*CSLOmIdentifier::cast(inst->getUnitDecl()->getChild(ID))->getName());
          args.push_back(*topName);
        }
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_USER_OBJ_ON_ARPATH, args, lineNumber, fileName);
        m_arHasErrors = TRUE;
      }
    }
    else { //sg
      RefCSLOmBase badObj = getBadObj(unit, ifcNames, TRUE);
      if (badObj->isConnectable() && CSLOmConnectable::cast(badObj)->isArGenerated()) { // FIX - create error function
        args.push_back(intToString(badObj->getLineNumber()));
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitDecl()->getChild(ID))->getName());
        args.push_back(*CSLOmConnectable::cast(badObj)->getArInstance());
        args.push_back(*CSLOmIdentifier::cast(badObj->getChild(ID))->getName());
        args.push_back("type");
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, lineNumber, fileName);
        m_arHasErrors = TRUE;
      }
      else {
        RefCSLOmBase temp = badObj;
        while (!temp->getParent()->getParent()->isUnitDecl()) {
          temp = temp->getParent();
        }
        args.push_back(intToString(badObj->getLineNumber())); // FIX - create error function
        args.push_back(*CSLOmIdentifier::cast(temp->getChild(ID))->getName());
        args.push_back(*CSLOmIdentifier::cast(badObj->getChild(ID))->getName());
        args.push_back("type");
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_USER_OBJ_ON_ARPATH, args, lineNumber, fileName);
        m_arHasErrors = TRUE;
      }
    }
    return RefCSLOmConnectable();
  }

  RefString newName = name;
  RefCSLOmConnectable namedConn = CAutorouter::existsPort(inst, newName, NCA, ifcNames);
  if (namedConn.get()) {
    ECSLOmPortDirection wantedDir = (rel == REL_PC) ? pd : port->getPortDirection();
    if (rel == REL_SS && inst == NCA ) {
      if (namedConn->isSignal()) {
        return namedConn;
      }
    }
    else if (namedConn->isPort()) {
      return namedConn;      
    }
    if (namedConn->isArGenerated()) { // FIX - create error function
      args.push_back(intToString(namedConn->getLineNumber()));
      args.push_back(*CSLOmIdentifier::cast(inst->getUnitDecl()->getChild(ID))->getName());
      args.push_back(*CSLOmConnectable::cast(namedConn)->getArInstance());
      args.push_back(*CSLOmIdentifier::cast(namedConn->getChild(ID))->getName());
      args.push_back("type");
      if (inst->getUnitInst().get()) {
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
      }
      else {
        RefString topName = RefString(new std::string("top unit: "));
        topName->append(*CSLOmIdentifier::cast(inst->getUnitDecl()->getChild(ID))->getName());
        args.push_back(*topName);
      }
      addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, lineNumber, fileName);
      m_arHasErrors = TRUE;
    }
    else {
      RefCSLOmBase temp = namedConn;
      while (!temp->getParent()->getParent()->isUnitDecl()) {
        temp = temp->getParent();
      }
      args.push_back(intToString(namedConn->getLineNumber())); // FIX - create error function
      args.push_back(*CSLOmIdentifier::cast(temp->getParent()->getParent()->getChild(ID))->getName());
      args.push_back(*CSLOmIdentifier::cast(namedConn->getChild(ID))->getName());
      args.push_back("type");
      if (inst->getUnitInst().get()) {
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
      }
      else {
        RefString topName = RefString(new std::string("top unit: "));
        topName->append(*CSLOmIdentifier::cast(inst->getUnitDecl()->getChild(ID))->getName());
        args.push_back(*topName);
      }
      addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_USER_OBJ_ON_ARPATH, args, lineNumber, fileName);
      m_arHasErrors = TRUE;
    }
    return RefCSLOmConnectable();
  }
//   TUInt index = 0;
//   RefString newName = RefString(new string(*name));
//   while (existsPort(inst, newName, NCA, ifcNames).get()) {
//     newName = RefString(new string(*name));
//     newName->append(intToString(index)); 
//     index++;
//  }
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase eval = CSLOmSimpleBitRange::cast(port->getBitRange())->getWidth()->doParamEval(port);
  TInt widthVal = CSLOmExpr::getValueForInstance(m_endPoint1->getPostProcessNode()->getUnitInst(), eval)->getValue();

  RefCSLOmExpr widthExpr = CSLOmNum32::build(port->getLineNumber(), port->getFileName(), widthVal);
  RefCSLOmConnectable obj = RefCSLOmConnectable();
  switch (rel) {
    case REL_CP: 
      obj = ifc->addPort(lineNumber,port->getFileName(), newName, port->getPortDirection(), SIGNAL_WIRE, RefCSLOmExprLink()); 
      CSLOmPortDecl::cast(obj)->setWidth(widthExpr); 
      break;
    case REL_PC: 
      obj = ifc->addPort(lineNumber,port->getFileName(), newName, pd, SIGNAL_WIRE, RefCSLOmExprLink()); 
      CSLOmPortDecl::cast(obj)->setWidth(widthExpr); 
      break;
    case REL_SS: 
      if(inst == NCA) {
        if (sg.get()){
          RefCSLOmSignal sig = sg->addSignal(lineNumber,port->getFileName(), newName, SIGNAL_WIRE, RefCSLOmExprLink());
          sig->setWidth(widthExpr);
          obj = sig;
        }
        else {
          RefCSLOmSignal sig = unit->addSignal(lineNumber,port->getFileName(), newName, SIGNAL_WIRE, RefCSLOmExprLink());
          sig->setWidth(widthExpr);
          obj = sig;
        }
      }
      else  {
        obj = ifc->addPort(lineNumber,port->getFileName(), newName, pd, SIGNAL_WIRE, RefCSLOmExprLink());
        CSLOmPortDecl::cast(obj)->setWidth(widthExpr);
      }
      break;
    default: ASSERT(FAIL, "this should not happen 2"); break;
  }
  obj->enableArGenerated();
  if (inst->getUnitInst().get()) {
    obj->setArInstance(CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
  }
  else {
    obj->setArInstance(RefString(new std::string("no instance(top unit)")));
  }

  return obj;
// }
//  else {
//    if (existsPort(inst, port->getName(), NCA).get()) {
//      return existsPort(inst, port->getName(), NCA, ifcNames);
//    }
//    else {
//      return existsPort(inst, name, NCA, ifcNames);
//    }
//  }
//return RefCSLOmConnectable();
}

void Connection::process() {
  ECSLOmPortDirection dir = DIR_UNDEFINED;
  if(!m_endPoint1->hasExpr()) {
    m_endPoint1->processLink();    
    if(m_endPoint1->getEndPoint()->isPort()) {
      dir = CSLOmPortDecl::cast(m_endPoint1->getEndPoint())->getPortDirection();
    }
  }
  else {
    if(!m_endPoint2->hasExpr()) {
      m_endPoint2->processLink(TRUE);
      if(m_endPoint2->getEndPoint()->isPort()) {
        dir = CSLOmPortDecl::cast(m_endPoint2->getEndPoint())->getPortDirection();
      }
    }
    m_endPoint1->processExpr(dir);
  }

  if(!m_endPoint2->hasExpr()) { m_endPoint2->processLink(TRUE); }
  else                        { m_endPoint2->processExpr(dir);  }

  if (m_endPoint1->getEndPoint()->isSignal()) {
    RefConnectionEndPoint aux;
    aux = m_endPoint1;
    m_endPoint1 = m_endPoint2;
    m_endPoint2 = aux;
  }

  if (m_interName.get()) {
    m_endPoint1->removeInterfaceNames();
    m_endPoint2->removeInterfaceNames();
  }

  RefTVec_RefCInstTreeNode nodeMap = CInstTreeNode::getNodeMap();
  TLong nca = CAutorouter::getNCA(m_endPoint1->getPostProcessNode(), m_endPoint2->getPostProcessNode());
  if (nca != -1) {
    m_NCA = nodeMap->at(nca);
    m_routePath = CAutorouter::getARPath(m_endPoint1->getPostProcessNode(), m_endPoint2->getPostProcessNode());
  }
}

// ------------------------------------------------------
// |              CAutorouter class                     |
// ------------------------------------------------------
RefCSLOmExprLink CAutorouter::m_lastName = RefCSLOmExprLink();
RefString CAutorouter::getRelName(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation) {
  RefCSLOmConnectable endP1 = conn->getEndPoint1()->getEndPoint();
  RefCSLOmConnectable endP2 = conn->getEndPoint2()->getEndPoint();

  if (conn->getInterName().get()) {
    return conn->getInterName();
  }

  if (conn->getEndPoint1()->hasPrefix()) {
    return conn->getEndPoint1()->getLink()->getName();
  }

  if (CSLOmIdentifier::cast(endP1->getChild(ID))->getName()->compare(*CSLOmIdentifier::cast(endP2->getChild(ID))->getName()) == 0 ) {
    return CSLOmIdentifier::cast(endP1->getChild(ID))->getName();
  }

  RefString backupName = RefString(new std::string("ar_"));
  backupName->append(*(CSLOmIdentifier::cast(endP1->getChild(ID))->getName()));
  backupName->append("_");
  backupName->append(*(CSLOmIdentifier::cast(endP2->getChild(ID))->getName()));
//   if (relation == REL_SS) {
//     if (CSLOmPortDecl::cast(endP1)->getPortDirection() != INOUT) {
//       if (CSLOmPortDecl::cast(endP1)->getPortDirection() == OUTPUT) {
//         backupName->append("_in");
//       }
//       else if (CSLOmPortDecl::cast(endP1)->getPortDirection() == INPUT){
//         backupName->append("_out");
//       }
//     }
//     else {
//       if (CSLOmPortDecl::cast(endP2)->getPortDirection() == INPUT) {
//         backupName->append("_in");
//       }
//       else if (CSLOmPortDecl::cast(endP2)->getPortDirection() == OUTPUT){
//         backupName->append("_out");
//       }
//     }
//   }
//   else if (relation == REL_PC) {
//     if (endP1->isPort() && CSLOmPortDecl::cast(endP1)->getPortDirection() != INOUT) {
//       if (conn->getNCA() == conn->getEndPoint1()->getPostProcessNode()) {
//         if (CSLOmPortDecl::cast(endP1)->getPortDirection() == INPUT) {
//           backupName->append("_in");
//         }
//         else if (CSLOmPortDecl::cast(endP1)->getPortDirection() == OUTPUT){
//           backupName->append("_out");
//         }
//       }
//       else {
//         if (CSLOmPortDecl::cast(endP1)->getPortDirection() == OUTPUT) {
//           backupName->append("_in");
//         }
//         else if (CSLOmPortDecl::cast(endP1)->getPortDirection() == INPUT){
//           backupName->append("_out");
//         }
//       }
//     }
//     else {
//       if (CSLOmPortDecl::cast(endP2)->getPortDirection() == INPUT) {
//         backupName->append("_in");
//       }
//       else if (CSLOmPortDecl::cast(endP2)->getPortDirection() == OUTPUT){
//         backupName->append("_out");
//       }
//     }
//   }
//   else {
//     if (endP2->isSignal() || CSLOmPortDecl::cast(endP1)->getPortDirection() != INOUT) {
//       if (CSLOmPortDecl::cast(endP1)->getPortDirection() == INPUT) {
//         backupName->append("_in");
//       }
//       else if (CSLOmPortDecl::cast(endP1)->getPortDirection() == OUTPUT){
//         backupName->append("_out");
//       }
//       else {
//         backupName->append("_inout");
//       }
//     }
//     else {
//       if (conn->getNCA() == conn->getEndPoint2()->getPostProcessNode()) {
//         if (CSLOmPortDecl::cast(endP2)->getPortDirection() == INPUT) {
//           backupName->append("_in");
//         }
//         else if (CSLOmPortDecl::cast(endP2)->getPortDirection() == OUTPUT){
//           backupName->append("_out");
//         }
//       }
//       else {
//         if (CSLOmPortDecl::cast(endP2)->getPortDirection() == OUTPUT) {
//           backupName->append("_in");
//         }
//         else if (CSLOmPortDecl::cast(endP2)->getPortDirection() == INPUT){
//           backupName->append("_out");
//         }
//       }
//     }
//   }
  return backupName;
}

TBool CAutorouter::check(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation) {
  RefCSLOmConnectable endP1 = conn->getEndPoint1()->getEndPoint();
  RefCSLOmConnectable endP2 = conn->getEndPoint2()->getEndPoint();

  RefString backupName = getRelName(conn, node1, node2, relation);

  RefCSLOmConnectable p1 = RefCSLOmConnectable();
  RefCSLOmConnectable p2 = RefCSLOmConnectable();

  if (node1.get() != conn->getEndPoint1()->getPostProcessNode().get()) {
    RefTVec_RefString temp = RefTVec_RefString(new TVec_RefString(*(m_lastName->getHidNames())));
    temp->pop_back();
    if (temp->size() == 0) {
      temp = RefTVec_RefString();
    }
    p1 = existsPort(node1, m_lastName->getName(), conn->getNCA(), temp, conn->getLineNumber(), conn->getFileName());
    if (!p1.get()) {
      p1 = existsPort(node1, CSLOmPortDecl::cast(endP1)->getName(), conn->getNCA(), conn->getEndPoint1()->getInterfaceNames(), conn->getLineNumber(), conn->getFileName(), conn->getEndPoint1()->hasPrefix());
    }
  }
  else {
    p1 = existsPort(node1, CSLOmIdentifier::cast(endP1->getChild(ID))->getName(), conn->getNCA(), conn->getEndPoint1()->getEndPointIfcNames(), 0, RefString(), FALSE);
  }

//   if (relation == REL_SS) {
    
//     p2 = existsPort(node2, backupName, conn->getNCA(), conn->getEndPoint1()->getInterfaceNames());
//     if(p2.get()) {
//       args.push_back(intToString(p2->getLineNumber()));
//       args.push_back(*CSLOmIdentifier::cast(p2->getChild(ID))->getName());
//       addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, conn->getLineNumber());
//       m_arHasErrors = TRUE;
//       return FALSE;
//     }
//   }

  if (node2.get() != conn->getEndPoint2()->getPostProcessNode().get()) {
    p2 = existsPort(node2, backupName, conn->getNCA(), conn->getEndPoint1()->getInterfaceNames());
//     if(p2.get()) {
//       args.push_back(intToString(p2->getLineNumber()));
//       args.push_back(*CSLOmIdentifier::cast(p2->getChild(ID))->getName());
//       addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, conn->getLineNumber());
//       m_arHasErrors = TRUE;
//       return FALSE;
//     }
  }
  else {
    p2 = existsPort(node2, CSLOmIdentifier::cast(endP2->getChild(ID))->getName(), conn->getNCA(), conn->getEndPoint2()->getEndPointIfcNames(), 0, RefString(), conn->getEndPoint2()->hasPrefix());
  }
  
  if (p1.get()) {

    ECSLOmPortDirection dir1 = DIR_UNDEFINED;
    ECSLOmPortDirection dir2 = DIR_UNDEFINED;
    if (p1->isSignal()) {
      dir1 = INOUT;
    }
    else if (p1->isPort()) {
      dir1 = CSLOmPortDecl::cast(p1)->getPortDirection();
    }
    else {
      //error
    }

    if (p2.get() && p2->isPort()) {
      dir2 = CSLOmPortDecl::cast(p2)->getPortDirection();
      RefCSLOmExprLink link1 = RefCSLOmExprLink();
      RefCSLOmExprLink link2 = RefCSLOmExprLink();
      if(node1.get() == conn->getEndPoint1()->getPostProcessNode().get()) {
        link1 = conn->getEndPoint1()->getLink();
      }
      if(node2.get() == conn->getEndPoint2()->getPostProcessNode().get()) {
        link2 = conn->getEndPoint2()->getLink();
      }
      TBool brCheck = !checkBitRangeSignalSignal(conn->getLineNumber(), conn->getFileName(), p1, p2, node1, node2, link1, link2);
      if (brCheck && !p2->isArGenerated()) {
        RefCSLOmIdentifier id = CSLOmIdentifier::cast(p2->getChild(ID));
        RefCSLOmBase temp = id->getParent();
        if (!temp->getParent()->isUnitDecl()) {
          while (!temp->getParent()->isUnitDecl()) {
            temp = temp->getParent();
          }
          temp = temp->getParent();
        }
        else {
          temp = temp->getParent();
        }
        args.push_back(intToString(id->getParent()->getLineNumber()));
        args.push_back(*CSLOmIdentifier::cast(temp->getChild(ID))->getName());
        args.push_back(*id->getName());
        args.push_back("bitrange");
        if (node2->getUnitInst().get()) {
          args.push_back(*CSLOmIdentifier::cast(node2->getUnitInst()->getChild(ID))->getName());
        }
        else {
          RefString topName = RefString(new std::string("top unit: "));
          topName->append(*CSLOmIdentifier::cast(node2->getUnitDecl()->getChild(ID))->getName());
          args.push_back(*topName);
        }
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_USER_OBJ_ON_ARPATH, args, conn->getLineNumber(), conn->getFileName());
        m_arHasErrors = TRUE;
        return FALSE;
        // TODO :throw error
      }
      else if (brCheck) {
        args.push_back(intToString(p2->getLineNumber()));
        args.push_back(*CSLOmIdentifier::cast(node2->getUnitDecl()->getChild(ID))->getName());
        args.push_back(*p2->getArInstance());
        args.push_back(*CSLOmIdentifier::cast(p2->getChild(ID))->getName());
        args.push_back("bitrange");
        args.push_back(*CSLOmIdentifier::cast(node2->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, conn->getLineNumber(), conn->getFileName());
        m_arHasErrors = TRUE;
        return FALSE;
      }

    }
    else {
      // DO NOTHING
    }


    TInt dt = ((((relation << REL_SHIFT) | dir1) << SHIFT) | dir2);
    if (!checkRelationshipSignalSignal(dt) && !p2->isArGenerated()) {
      if (p1.get() != conn->getEndPoint1()->getEndPoint().get() || p2.get() != conn->getEndPoint2()->getEndPoint().get()) {
        RefCSLOmBase temp = p1.get() != conn->getEndPoint1()->getEndPoint().get() ? p1 : p2;
        if (!temp->getParent()->isUnitDecl()) {
          while (!temp->getParent()->getParent()->isUnitDecl()) {
            temp = temp->getParent();
          }
        }
        else {
          temp = temp->getParent();
        }
        args.push_back(intToString((p1.get() != conn->getEndPoint1()->getEndPoint().get() ? p1 : p2)->getLineNumber()));
        args.push_back(*CSLOmIdentifier::cast(temp->getChild(ID))->getName());
        args.push_back(*CSLOmIdentifier::cast((p1.get() != conn->getEndPoint1()->getEndPoint().get() ? p1 : p2)->getChild(ID))->getName());
        args.push_back("direction");
        args.push_back(*CSLOmIdentifier::cast(node2->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_USER_OBJ_ON_ARPATH, args, conn->getLineNumber(), conn->getFileName());
        m_arHasErrors = TRUE;
        return FALSE;
      }
      else {
        args.push_back(*convertLink(conn->getEndPoint1()->getLink()));
        args.push_back(*convertLink(conn->getEndPoint2()->getLink()));
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_REL_CHECK, args, conn->getLineNumber(), conn->getFileName());
        m_arHasErrors = TRUE;
        return FALSE;
      }
    }
    else if (!checkRelationshipSignalSignal(dt)) {
      args.push_back(intToString(p2->getLineNumber()));
      args.push_back(*CSLOmIdentifier::cast(node2->getUnitDecl()->getChild(ID))->getName());
      args.push_back(*p2->getArInstance());
      args.push_back(*CSLOmIdentifier::cast(p2->getChild(ID))->getName());
      args.push_back("direction");
      args.push_back(*CSLOmIdentifier::cast(node2->getUnitInst()->getChild(ID))->getName());
      addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, conn->getLineNumber(), conn->getFileName());
      m_arHasErrors = TRUE;
      return FALSE;
    }
  }
  else {
//     ASSERT(FAIL, "this is not good");
    return FALSE;
  }
  return TRUE;
}

TBool CAutorouter::checkRelationshipSignalSignal(TInt dt) {
  switch(dt) {
    case SIBLING_UNDEF_UNDEF : return FALSE;
    case SIBLING_UNDEF_IN    : return FALSE;
    case SIBLING_UNDEF_OUT   : return FALSE;
    case SIBLING_UNDEF_INOUT : return FALSE;
    case SIBLING_IN_UNDEF    : return TRUE ;
    case SIBLING_IN_IN       : return FALSE;
    case SIBLING_IN_OUT      : return TRUE ;
    case SIBLING_IN_INOUT    : return TRUE ;
    case SIBLING_OUT_UNDEF   : return TRUE ;
    case SIBLING_OUT_IN      : return TRUE ;
    case SIBLING_OUT_OUT     : return FALSE;
    case SIBLING_OUT_INOUT   : return TRUE;
    case SIBLING_INOUT_UNDEF : return TRUE ;
    case SIBLING_INOUT_IN    : return TRUE ;
    case SIBLING_INOUT_OUT   : return TRUE ;
    case SIBLING_INOUT_INOUT : return TRUE ;
    case PC_UNDEF_UNDEF      : return FALSE;
    case PC_UNDEF_IN         : return FALSE;
    case PC_UNDEF_OUT        : return FALSE;
    case PC_UNDEF_INOUT      : return FALSE;
    case PC_IN_UNDEF         : return TRUE;
    case PC_IN_IN            : return TRUE ;
    case PC_IN_OUT           : return FALSE;
    case PC_IN_INOUT         : return TRUE ;
    case PC_OUT_UNDEF        : return TRUE ;
    case PC_OUT_IN           : return FALSE;
    case PC_OUT_OUT          : return TRUE ;
    case PC_OUT_INOUT        : return TRUE ;
    case PC_INOUT_UNDEF      : return TRUE ;
    case PC_INOUT_IN         : return TRUE ;
    case PC_INOUT_OUT        : return TRUE ;
    case PC_INOUT_INOUT      : return TRUE ;
    case CP_UNDEF_UNDEF      : return FALSE;
    case CP_UNDEF_IN         : return FALSE;
    case CP_UNDEF_OUT        : return FALSE;
    case CP_UNDEF_INOUT      : return FALSE;
    case CP_IN_UNDEF         : return TRUE ;
    case CP_IN_IN            : return TRUE ;
    case CP_IN_OUT           : return FALSE;
    case CP_IN_INOUT         : return TRUE ;
    case CP_OUT_UNDEF        : return TRUE ;
    case CP_OUT_IN           : return FALSE;
    case CP_OUT_OUT          : return TRUE ;
    case CP_OUT_INOUT        : return TRUE ;
    case CP_INOUT_UNDEF      : return TRUE ;
    case CP_INOUT_IN         : return TRUE ;
    case CP_INOUT_OUT        : return TRUE ;
    case CP_INOUT_INOUT      : return TRUE ;
    default : ASSERT(FAIL, "something is wrong");    
  }
}

TBool CAutorouter::checkBitRangeSignalSignal(TLineNumberType lineNumber, RefString fileName, RefCSLOmConnectable p1, RefCSLOmConnectable p2, NSCInstTree::RefCInstTreeNode inst1, NSCInstTree::RefCInstTreeNode inst2, RefCSLOmExprLink link1, RefCSLOmExprLink link2) {
  RefCSLOmBaseRange b1 = RefCSLOmBaseRange();
  RefCSLOmBaseRange b2 = RefCSLOmBaseRange();
  if (p1->isSignal()) {
    b1 = CSLOmSignal::cast(p1)->getBitRange();
  }
  else if (p1->isPort()) {
    b1 = CSLOmPortDecl::cast(p1)->getBitRange();
  }
  else {
    ASSERT(FAIL, "object does not contain bitrange");
  }

  if (link1.get() && link1->hasBitRange() && !p1->isArGenerated()) {
    b1 = link1->getBitRange();
  }

  if (p2->isSignal()) {
    b2 = CSLOmSignal::cast(p2)->getBitRange();
  }
  else if (p2->isPort()) {
    b2 = CSLOmPortDecl::cast(p2)->getBitRange();
  }
  else {
    ASSERT(FAIL, "object does not contain bitrange");
  }
  if (link2.get() && link2->hasBitRange() && !p2->isArGenerated()) {
    b2 = link2->getBitRange();
  }

  ASSERT(b1.get(), "bitrange null");
  ASSERT(b2.get(), "bitrange null");
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase eval1 = CSLOmSimpleBitRange::cast(b1)->getWidth()->doParamEval(p1);
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase eval2 = CSLOmSimpleBitRange::cast(b2)->getWidth()->doParamEval(p2);
  if (!eval1.get() || !eval2.get()) {
    return FALSE;
  }
  TInt width1 = CSLOmExpr::getValueForInstance(inst1->getUnitInst(), eval1)->getValue();
  TInt width2 = CSLOmExpr::getValueForInstance(inst2->getUnitInst(), eval2)->getValue();

  if (width1 != width2) {
    if(link1.get()) {
      args.push_back(*convertLink(link1));
    }
    else {
      args.push_back(*CSLOmIdentifier::cast(p1->getChild(ID))->getName());
    }
    if(link2.get()) {
      args.push_back(*convertLink(link2));
    }
    else {
      args.push_back(*CSLOmIdentifier::cast(p2->getChild(ID))->getName());
    }
     
    args.push_back(intToString(width1));
    args.push_back(intToString(width2));
//     if (link1.get() && link1->hasBitRange()) {
//       args.push_back(intToString(CSLOmNumber::cast(CSLOmSimpleBitRange::cast(link1->getBitRange())->getWidth()->doEval(TRUE))->getValue()));
//     }
//     else {
//       args.push_back(intToString(CSLOmNumber::cast(CSLOmSimpleBitRange::cast(p1->getChild(PORT_BR))->getWidth()->doEval(TRUE))->getValue()));
//     }
//     if (link2.get() && link2->hasBitRange()) {
//       args.push_back(intToString(CSLOmNumber::cast(CSLOmSimpleBitRange::cast(link2->getBitRange())->getWidth()->doEval(TRUE))->getValue()));
//     }
//     else {
//       args.push_back(intToString(CSLOmNumber::cast(CSLOmSimpleBitRange::cast(p2->getChild(PORT_BR))->getWidth()->doEval(TRUE))->getValue()));
//     }
    addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_BR_CHECK, args, lineNumber, fileName);
    m_arHasErrors = TRUE;
    return FALSE;
  }
  else {
    return TRUE;
  }

}


RefCSLOmConnectable CAutorouter::existsPort(RefCInstTreeNode inst, const RefString& portName, RefCInstTreeNode NCA, RefTVec_RefString interfaceNames, TLineNumberType lineNumber, RefString fileName, TBool skipPrefix) {
  RefCSLOmScope scope;
  if (inst->getUnitInst().get()) {
    scope = CSLOmBase::getAttachedScope(inst->getUnitInst().get());
  }
  else {
    scope = CSLOmBase::getAttachedScope(inst->getUnitDecl().get());
  }
  RefCSLOmIdentifier id = RefCSLOmIdentifier();
  if (interfaceNames.get()) {
    TVec_RefString::iterator it = interfaceNames->begin();
    if (skipPrefix) { it++; }
    for (; it < interfaceNames->end(); it++) {
      id = scope->lookupLocal(*it);
      if (!id.get()) {
        return RefCSLOmConnectable();
      }
      else {
        if (id->getParent()->isInterface() || id->getParent()->isSignalGroup()) {
          scope = id->toScope();
        }
        else {
          return RefCSLOmConnectable();
        }
      }
    }
  }

  id = scope->lookupLocal(portName);
  if (id.get()) {
    if (id->getParent()->isPort()) {
      return CSLOmConnectable::cast(id->getParent());
    }
    else if (inst == NCA && id->getParent()->isSignal()) {
      return CSLOmConnectable::cast(id->getParent());
    }
    else {
      if (id->getParent()->isConnectable() && CSLOmConnectable::cast(id->getParent())->isArGenerated()) {
        args.push_back(intToString(id->getParent()->getLineNumber()));
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitDecl()->getChild(ID))->getName());
        args.push_back(*CSLOmConnectable::cast(id->getParent())->getArInstance());
        args.push_back(*id->getName());
        args.push_back("type");
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_AR_OBJ_ON_ARPATH, args, lineNumber, fileName);
        m_arHasErrors = TRUE;
      }
      else {
        RefCSLOmBase temp = id->getParent();
        if (!temp->getParent()->isUnitDecl()) {
          while (!temp->getParent()->getParent()->isUnitDecl()) {
            temp = temp->getParent();
          }
        }
        else {
          temp = temp->getParent();
        }
        args.push_back(intToString(id->getParent()->getLineNumber()));
        args.push_back(*CSLOmIdentifier::cast(temp->getChild(ID))->getName());
        args.push_back(*id->getName());
        args.push_back("type");
        args.push_back(*CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_USER_OBJ_ON_ARPATH, args, lineNumber, fileName);
        m_arHasErrors = TRUE;
      }
      return RefCSLOmConnectable();
    }
  }
  else {
    return RefCSLOmConnectable();
  }
}

RefCSLOmExprLink CAutorouter::buildExprLink(RefCSLOmConnectable point, RefTVec_RefString interfaceNames, RefString alternateName, RefCInstTreeNode node1, TBool skipPrefix) {
  RefCSLOmExprLink link;
  if (alternateName.get()) {
    link = CSLOmExprLink::build(point->getLineNumber(),point->getFileName(), alternateName);
    if (interfaceNames.get()) {
      TVec_RefString::reverse_iterator it = interfaceNames->rbegin();
      for (; it < (skipPrefix ? interfaceNames->rend()-1 : interfaceNames->rend()); it++) {
        link->addScopeItem(*it);
      }
    }
    CSLOmScopeBlock::enterScope(node1->getUnitDecl()->getAttachedScope());
    link->doEval();
    CSLOmScopeBlock::exitScope();
  }
  else {
    link = CSLOmExprLink::build(point->getLineNumber(),point->getFileName(), CSLOmIdentifier::cast(point->getChild(ID))->getName());
    if (interfaceNames.get()) {
      TVec_RefString::reverse_iterator it = interfaceNames->rbegin();
      for (; it < (skipPrefix ? interfaceNames->rend()-1 : interfaceNames->rend()); it++) {
        link->addScopeItem(*it);
      }
    }
    link->setValue(point);
    link->addID(CSLOmIdentifier::cast(point->getChild(ID)));
  }
  return link;
}

TBool CAutorouter::createConnection(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2, EInstanceRel relation) {
  RefCSLOmConnectable endP1 = conn->getEndPoint1()->getEndPoint();
  RefCSLOmConnectable endP2 = conn->getEndPoint2()->getEndPoint();

  switch(relation) {
    case REL_PC: return createPCConnection(conn, node1, node2);     break;
    case REL_CP: return createCPConnection(conn, node1, node2);     break;
    case REL_SS: return createSibSibConnection(conn, node1, node2); break;
    default:     ASSERT(FAIL, "this should not happen");            break;
  }
  return FALSE;
}

TBool CAutorouter::createSibSibConnection(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2) {

  RefCSLOmConnectable endP1 = conn->getEndPoint1()->getEndPoint();
  RefCSLOmConnectable endP2 = conn->getEndPoint2()->getEndPoint();
  RefString backupName = getRelName(conn, node1, node2, REL_SS);
  RefString sigName = RefString(new std::string("ar_"));
  sigName->append(*(CSLOmIdentifier::cast(endP1->getChild(ID))->getName()));
  sigName->append("_");
  sigName->append(*(CSLOmIdentifier::cast(endP2->getChild(ID))->getName()));
  if (CSLOmIdentifier::cast(endP1->getChild(ID))->getName()->compare(*CSLOmIdentifier::cast(endP2->getChild(ID))->getName()) == 0 ) {
    sigName = CSLOmIdentifier::cast(endP1->getChild(ID))->getName();
  }
  if (conn->getInterName().get()) {
    sigName = conn->getInterName();
  }
  if (conn->getEndPoint1()->hasPrefix()) {
    sigName = conn->getEndPoint1()->getLink()->getName();
  }


  RefCSLOmExprLink linkNew = RefCSLOmExprLink();
  RefCSLOmExprLink linkNew2 = RefCSLOmExprLink();
  RefCSLOmConnectable newPort = RefCSLOmConnectable();
  RefCSLOmConnectable newPort2 = RefCSLOmConnectable();

  RefCSLOmPortDecl lastPort;
  if (node1 != conn->getEndPoint1()->getPostProcessNode()) {
    lastPort = CSLOmPortDecl::cast(m_lastName->getValue());
  }
  else {
    lastPort = CSLOmPortDecl::cast(endP1);
  }
  RefCSLOmExprLink linkOld = RefCSLOmExprLink();
  if (node1 != conn->getEndPoint1()->getPostProcessNode()) {
    RefTVec_RefString temp = RefTVec_RefString(new TVec_RefString(*(m_lastName->getHidNames())));
    temp->pop_back();
    linkOld = buildExprLink(CSLOmConnectable::cast(m_lastName->getValue()), temp, m_lastName->getName(), node1);
  }
  else {
    linkOld = buildExprLink(endP1, conn->getEndPoint1()->getEndPointIfcNames(), RefString(), node1, FALSE);
  }

  TBool foundSignal = FALSE;
  RefTMap_RefCSLOmExprLink_RefCSLOmExpr connMap = node1->getUnitInst()->getConnectionMap();
  if (node1 == conn->getEndPoint1()->getPostProcessNode()) {
    m_lastName = buildExprLink(endP1, conn->getEndPoint1()->getEndPointIfcNames(), RefString(), node1, FALSE);
  }
  if (m_lastName.get() && connMap->find(m_lastName) != connMap->end()) {
    m_lastName = CSLOmExprLink::cast(connMap->find(m_lastName)->second->dupp());

    CSLOmScopeBlock::enterScope(conn->getNCA()->getUnitDecl()->getAttachedScope());
    newPort = CSLOmConnectable::cast(m_lastName->doEval());
    CSLOmScopeBlock::exitScope();
    
    RefTMap_RefCSLOmExprLink_RefCSLOmExpr connMap1 = (node2->getUnitInst())->getConnectionMap();
    TMap_RefCSLOmExprLink_RefCSLOmExpr::iterator it = connMap1->begin();
    for (; it != connMap1->end(); it++) {
      if (it->second->doEval().get() == m_lastName->doEval().get()) {
        m_lastName = CSLOmExprLink::cast(it->first->dupp());
        m_lastName->isInUnitScope(node2->getUnitDecl());
        return TRUE;
      }
    }
    foundSignal = TRUE;
    //    ASSERT(m_lastName->isInUnitScope(node2->getUnitDecl()),"still not good");
  }

//  RefCSLOmPortDecl lastPort = CSLOmPortDecl::cast(existsPort(conn->getEndPoint1()->getPostProcessNode(), CSLOmPortDecl::cast(endP1)->getName(), conn->getNCA(), conn->getEndPoint1()->getEndPointIfcNames(), 0, RefString(), conn->getEndPoint1()->hasPrefix()));
  if (!foundSignal) {
    newPort = conn->create(conn->getNCA(), lastPort, REL_SS, sigName, conn->getEndPoint1()->getInterfaceNames());
    if (!newPort.get()) {
      return FALSE;
    }
  }

  RefCSLOmExprLink expr = getConnectedFromUnit(node2->getUnitDecl(), conn->getEndPoint2()->getEndPoint(), conn->getRoutePath());


  if (node2 != conn->getEndPoint2()->getPostProcessNode() && !expr.get()) {
    newPort2 = conn->create(node2, lastPort, REL_SS, backupName, conn->getEndPoint1()->getInterfaceNames());
    if (!newPort2.get()) {
      return FALSE;
    }
  }

  if (newPort->isConnectable()) {
    if (expr.get()) {
      linkNew2 = CSLOmExprLink::cast(expr->dupp());
      ASSERT(linkNew2->isInUnitScope(node2->getUnitDecl()),"still not good");
    }
    else if (node2 != conn->getEndPoint2()->getPostProcessNode()) {
      linkNew2 = buildExprLink(newPort2, conn->getEndPoint1()->getInterfaceNames(), RefString(), node2);
    }
    else {
      linkNew2 = buildExprLink(endP2, conn->getEndPoint2()->getEndPointIfcNames(), RefString(), node2, conn->getEndPoint2()->hasPrefix());
    }
    linkNew = buildExprLink(newPort, conn->getEndPoint1()->getInterfaceNames(), RefString(), conn->getNCA());

    node1->getUnitInst()->addConnectionPair(linkNew,linkOld ); 
    node2->getUnitInst()->addConnectionPair(linkNew,linkNew2);
    m_lastName = linkNew2;
  }
  else {
    DCERR("AR FAILED: cannot create signal"<<endl);
    return FALSE;
  }
  return TRUE;
}

TBool CAutorouter::createCPConnection(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2) {
  RefCSLOmConnectable endP1 = conn->getEndPoint1()->getEndPoint();
  RefCSLOmConnectable endP2 = conn->getEndPoint2()->getEndPoint();
  RefString backupName = getRelName(conn, node1, node2, REL_CP);

  RefCSLOmExprLink linkNew = RefCSLOmExprLink();
  RefCSLOmConnectable newPort = RefCSLOmConnectable();

  RefCSLOmExprLink linkOld = RefCSLOmExprLink();
  if (node1 != conn->getEndPoint1()->getPostProcessNode()/* && !existsPort(node1, CSLOmPortDecl::cast(endP1)->getName(), conn->getNCA(), conn->getEndPoint1()->getInterfaceNames()).get()*/) {
    RefTVec_RefString temp = RefTVec_RefString(new TVec_RefString(*(m_lastName->getHidNames())));
    temp->pop_back();
    linkOld = buildExprLink(CSLOmConnectable::cast(m_lastName->getValue()), temp, m_lastName->getName(), node1);
  }
  else {
    linkOld = buildExprLink(endP1, conn->getEndPoint1()->getEndPointIfcNames(), RefString(), node1, FALSE);
//     if (conn->getEndPoint1()->getLink()->hasBitRange()) {
//       linkOld->setBitRange(conn->getEndPoint1()->getLink()->getBitRange());
//     }
  }

  RefTMap_RefCSLOmExprLink_RefCSLOmExpr connMap = node1->getUnitInst()->getConnectionMap();
  if (connMap->find(linkOld) != connMap->end()) {
    RefCSLOmExpr aux = connMap->find(linkOld)->second;
    CSLOmScopeBlock::enterScope(node2->getUnitDecl()->getAttachedScope());
    RefCSLOmBase eval = aux->doEval();
    CSLOmScopeBlock::exitScope();
    if (!connMap->find(linkOld)->second->isExprLink() || !eval.get()) { // FIX - create error function
      args.push_back(*convertLink(connMap->find(linkOld)->first));
      args.push_back(*CSLOmIdentifier::cast(node1->getUnitInst()->getChild(ID))->getName());
      args.push_back(intToString(node1->getUnitInst()->getLineNumber()));
      addErr(NSWarningErr::CSE_CAR_DSGN_INVALID_ACTUAL_CONNECTED, args, conn->getLineNumber(), conn->getFileName());
      m_arHasErrors = TRUE;
      return FALSE;
    }
    else if (node2.get() == conn->getEndPoint2()->getPostProcessNode().get() && CSLOmPortDecl::cast(linkOld->doEval())->getPortDirection() == INPUT) {
      RefCSLOmExpr aux = connMap->find(linkOld)->second;
      CSLOmScopeBlock::enterScope(node2->getUnitDecl()->getAttachedScope());
      RefCSLOmBase eval = aux->doEval();
      CSLOmScopeBlock::exitScope();
      if (aux->doEval().get() && aux->doEval().get() != conn->getEndPoint2()->getEndPoint().get()) { // FIX - create error function
        args.push_back(*convertLink(connMap->find(linkOld)->first));
        args.push_back(*CSLOmIdentifier::cast(node1->getUnitInst()->getChild(ID))->getName());
        args.push_back(intToString(node1->getUnitInst()->getLineNumber()));
        addErr(NSWarningErr::CSE_CAR_DSGN_CONNECT_INPUT_TWICE, args, conn->getLineNumber(), conn->getFileName());
        m_arHasErrors = TRUE;
        return FALSE;
      }
    }
    m_lastName = CSLOmExprLink::cast(connMap->find(linkOld)->second->dupp());
    ASSERT(m_lastName->isInUnitScope(node2->getUnitDecl()),"still not good");
  }
  else {
//     RefCSLOmPortDecl lastPort;
//     if (node1 != conn->getEndPoint1()->getPostProcessNode()) {
//       lastPort = CSLOmPortDecl::cast(m_lastName->getValue());
//     }
//     else {
//       lastPort = CSLOmPortDecl::cast(endP1);
//     }

    RefCSLOmPortDecl lastPort = CSLOmPortDecl::cast(existsPort(conn->getEndPoint1()->getPostProcessNode(), CSLOmPortDecl::cast(endP1)->getName(), conn->getNCA(), conn->getEndPoint1()->getEndPointIfcNames(), 0, RefString(), node1.get() != conn->getEndPoint1()->getPostProcessNode().get() ? conn->getEndPoint1()->hasPrefix(): FALSE));

    if (node2 != conn->getEndPoint2()->getPostProcessNode()) {
      newPort = conn->create(node2, lastPort, REL_CP, backupName, conn->getEndPoint1()->getInterfaceNames());
      if (!newPort.get()) {
        return FALSE;
      }

      linkNew = buildExprLink(newPort, conn->getEndPoint1()->getInterfaceNames(), RefString(), node2);
    }
    else {
      linkNew = buildExprLink(endP2, conn->getEndPoint2()->getEndPointIfcNames(), RefString(), node2, FALSE);
      if (conn->getEndPoint2()->getLink()->hasBitRange()) {
        linkNew->setBitRange(conn->getEndPoint2()->getLink()->getBitRange());
      }
    }

    node1->getUnitInst()->addConnectionPair(linkNew, linkOld);
    m_lastName = linkNew;
  }
  return TRUE;
}

TBool CAutorouter::createPCConnection(RefConnection conn, RefCInstTreeNode node1, RefCInstTreeNode node2) {
  RefCSLOmConnectable endP1 = conn->getEndPoint1()->getEndPoint();
  RefCSLOmConnectable endP2 = conn->getEndPoint2()->getEndPoint();
  RefString backupName = getRelName(conn, node1, node2, REL_PC);

  RefCSLOmExprLink linkNew = RefCSLOmExprLink();
  RefCSLOmConnectable newPort = RefCSLOmConnectable();

  RefCSLOmExprLink linkOld = RefCSLOmExprLink();
  if (node1 != conn->getEndPoint1()->getPostProcessNode() /*&& !existsPort(node1, CSLOmPortDecl::cast(endP1)->getName(), conn->getNCA(), conn->getEndPoint1()->getInterfaceNames()).get()*/) {
    RefTVec_RefString temp = RefTVec_RefString(new TVec_RefString(*(m_lastName->getHidNames())));
    temp->pop_back();
    linkOld = buildExprLink(CSLOmConnectable::cast(m_lastName->getValue()), temp, m_lastName->getName(), node1);
    RefCSLOmBase eval = linkOld->getValue();
    if(!eval.get()) {
      linkOld = buildExprLink(endP1, conn->getEndPoint1()->getInterfaceNames(), RefString(), node1, conn->getEndPoint1()->hasPrefix());
    }
  }
  else {
    linkOld = buildExprLink(endP1, conn->getEndPoint1()->getEndPointIfcNames(), RefString(), node1, FALSE);    
  }

  RefCSLOmExprLink expr = getConnectedFromUnit(node2->getUnitDecl(), conn->getEndPoint2()->getEndPoint(), conn->getRoutePath());
  if (expr.get()) {
    node2->getUnitInst()->addConnectionPair(linkOld, expr);
    m_lastName = CSLOmExprLink::cast(expr->dupp());
    m_lastName->isInUnitScope(node2->getUnitDecl());
    ASSERT (m_lastName->isInUnitScope(node2->getUnitDecl()), "not good");
    return FALSE;
  }

  RefTMap_RefCSLOmExprLink_RefCSLOmExpr connMap = (node2->getUnitInst())->getConnectionMap();
  TMap_RefCSLOmExprLink_RefCSLOmExpr::iterator it = connMap->begin();
  for (; it != connMap->end(); it++) {
    if (it->second->doEval().get() == linkOld->doEval().get()) {
      m_lastName = CSLOmExprLink::cast(it->first->dupp());
      m_lastName->isInUnitScope(node2->getUnitDecl());
      return TRUE;
    }
  }

  RefCSLOmPortDecl lastPort;
  if (node1 != conn->getEndPoint1()->getPostProcessNode()) {
    lastPort = CSLOmPortDecl::cast(m_lastName->getValue());
  }
  else {
    lastPort = CSLOmPortDecl::cast(endP1);
  }

  if (node2 != conn->getEndPoint2()->getPostProcessNode()) {
    newPort = conn->create(node2, lastPort, REL_PC, backupName, conn->getEndPoint1()->getInterfaceNames());
    if (!newPort.get()) {
      return FALSE;
    }

    linkNew = buildExprLink(newPort, conn->getEndPoint1()->getInterfaceNames(), RefString(), node2);
  }
  else {
    linkNew = buildExprLink(endP2, conn->getEndPoint2()->getEndPointIfcNames(), RefString(), node2, conn->getEndPoint2()->hasPrefix());
    if (conn->getEndPoint2()->getLink()->hasBitRange()) {
      linkNew->setBitRange(conn->getEndPoint2()->getLink()->getBitRange());
    }
  }

  node2->getUnitInst()->addConnectionPair(linkOld, linkNew);
  m_lastName = linkNew;
  return TRUE;
}

RefCSLOmInterface CAutorouter::buildInterfaces(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl unit, RefTVec_RefString names, RefCInstTreeNode inst) {
  RefCSLOmScope scope = unit->getAttachedScope();
  TVec_RefString::iterator it = names->begin();
  RefCSLOmInterface ifc = unit->getDefaultInterface();
  for (; it < names->end(); ++it) {
    RefCSLOmIdentifier id = scope->lookupLocal(*it);
    if (id.get()) {
      if (!id->getParent()->isInterface()) {
        return RefCSLOmInterface();
      }
      else {
        scope = CSLOmInterface::cast(id->getParent())->getAttachedScope();
        ifc = CSLOmInterface::cast(id->getParent());
      }
    }
    else {
      ifc = CSLOmInterface::build(lineNumber, fileName, ifc, *it);
      ifc->enableArGenerated();
      if(inst->getUnitInst().get()) {
        ifc->setArInstance(CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
      }
      else {
        ifc->setArInstance(RefString(new std::string("no instance(top unit)")));
      }
      scope = CSLOmInterface::cast(ifc)->getAttachedScope();
    }
  }
  return ifc;
}

RefCSLOmGroupSignal CAutorouter::buildSignalGroups(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl unit, RefTVec_RefString names, RefCInstTreeNode inst) {
  RefCSLOmScope scope = unit->getAttachedScope();
  TVec_RefString::iterator it = names->begin();
  RefCSLOmGroupSignal ifc;
  for (; it < names->end(); ++it) {
    RefCSLOmIdentifier id = scope->lookupLocal(*it);
    if (id.get()) {
      if (!id->getParent()->isSignalGroup()) {
        return RefCSLOmGroupSignal();
      }
      else {
        scope = CSLOmGroupSignal::cast(id->getParent())->getAttachedScope();
        ifc = CSLOmGroupSignal::cast(id->getParent());
      }
    }
    else {
      if (ifc.get()) {
        ifc = CSLOmGroupSignal::build(lineNumber, fileName, ifc, *it);
        ifc->enableArGenerated();
        if (inst->getUnitInst().get()) {
          ifc->setArInstance(CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
        }
        else {
          ifc->setArInstance(RefString(new std::string("no instance(top unit)")));
        }
      }
      else {
        ifc = CSLOmGroupSignal::build(lineNumber, fileName, unit, *it);
        ifc->enableArGenerated();
        if (inst->getUnitInst().get()) {
          ifc->setArInstance(CSLOmIdentifier::cast(inst->getUnitInst()->getChild(ID))->getName());
        }
        else {
          ifc->setArInstance(RefString(new std::string("no instance(top unit)")));
        }
      }
      scope = CSLOmGroupSignal::cast(ifc)->getAttachedScope();
    }
  }
  return ifc;
}


RefTVec_TLong CAutorouter::getNumHid(RefCInstTreeNode node) {
  TLong level = node->getLevel();
  RefTVec_TLong hid = RefTVec_TLong(new TVec_TLong);
  while (level >= 0) {
    hid->insert(hid->begin(),node->getID());
    node = node->getParent();
    level--;
  }
  return hid;
}

TLong CAutorouter::getNCA(RefCInstTreeNode node1, RefCInstTreeNode node2) {
  if (node1.get() && node2.get()) {
    RefTVec_TLong hid1 = getNumHid(node1);
    RefTVec_TLong hid2 = getNumHid(node2);
    TLong NCA = -1;

    ASSERT (!hid1->empty(), "ERROR: Empty Hid provided");
    ASSERT (!hid2->empty(), "ERROR: Empty Hid provided");

    if (hid1->size() > hid2->size()) {
      swap (hid1, hid2);
    }

    TInt i;
    for (i = 0; i<hid1->size(); ++i) {
      if (hid1->at(i) != hid2->at(i)) {
        NCA = hid1->at(i-1);
        break;
      }
    }
    if (i == hid1->size()) {
      NCA = hid1->at(hid1->size()-1);
    }
    ASSERT (NCA >= 0, "ERROR: NCA doesn't exist. Possible design error");

    return NCA;
  }
  else {
    return -1;
  }
}

RefTVec_TLong CAutorouter::getARPath(NSCInstTree::RefCInstTreeNode node1 , NSCInstTree::RefCInstTreeNode node2) {
  ASSERT(node1.get(), "null node received");
  ASSERT(node2.get(), "null node received");

  RefTVec_TLong list = RefTVec_TLong( new TVec_TLong );
  RefTVec_TLong hid1 = getNumHid(node1);
  RefTVec_TLong hid2 = getNumHid(node2);

  TLong NCA = getNCA(node1, node2);
  TInt i;
  for (i = 0; i < hid1->size() && hid1->at(i) != NCA; i++ );

  ASSERT(i != hid1->size(), "something is wrong");

  TInt NCAPos = i;
  for (i = hid1->size()-1; i >= NCAPos ; --i) {
    list->push_back(hid1->at(i));
  }

  for (i = NCAPos+1; i < hid2->size() ; ++i) {
    list->push_back(hid2->at(i));
  }

  return list;
}

void CAutorouter::traverseSegments(RefConnection connection) {

  RefTVec_TLong list = connection->getRoutePath();
  RefTVec_RefCInstTreeNode nodeMap = CInstTreeNode::getNodeMap();
  RefCInstTreeNode NCA = connection->getNCA();
  RefConnectionEndPoint endPoint1 = connection->getEndPoint1();
  RefConnectionEndPoint endPoint2 = connection->getEndPoint2();

  TBool noSib2Sib = FALSE;
  TBool passedNCA = FALSE;

  if (NCA == endPoint1->getPostProcessNode() || NCA == endPoint2->getPostProcessNode()) {
    noSib2Sib = TRUE;
    if (nodeMap->at(*(list->begin())) == NCA) { passedNCA = TRUE; }
  }

  DCERR("");
  DCERR("AutoRouter: AutoRouting from: "<< *convertLink(endPoint1->getLink()) << " to: "<< *convertLink(endPoint2->getLink()));
  DCERR("---------------------------------------------------------------------------");

  EInstanceRel currentRel = REL_UNDEFINED;
  if (list->size() == 1) {
    args.push_back(*convertLink(connection->getEndPoint1()->getLink()));
    args.push_back(*convertLink(connection->getEndPoint2()->getLink()));
    addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_SAME_UNIT, args, connection->getLineNumber(), connection->getFileName());
  }
  else {
    EInstanceRel relation;
    if (noSib2Sib) {
      if (endPoint1->getPostProcessNode()->getLevel() > endPoint2->getPostProcessNode()->getLevel()) { relation = REL_PC; }
      else { relation = REL_CP; }
    }
    else { relation = REL_SS; }

    if (endPoint1->hasExpr() || endPoint1->getEndPoint()->isSignal() || endPoint1->getLink()->hasBitRange()) {
      ECSLOmPortDirection dir = CSLOmPortDecl::cast(endPoint1->getEndPoint()->isSignal() ? endPoint2->getEndPoint():endPoint1->getEndPoint())->getPortDirection();
      if (relation == REL_SS) {
        if      (dir == OUTPUT) { dir = INPUT;  }
        else if (dir == INPUT) { dir = OUTPUT; }
      }
      if (endPoint1->hasExpr() || !(endPoint1->getEndPoint()->isSignal() && relation == REL_CP)) {
        if (!endPoint1->genPort(endPoint1->getLineNumber(), endPoint1->getFileName(), dir)) { return; }
      }
    }
    if (endPoint2->hasExpr() || endPoint2->getEndPoint()->isSignal() || endPoint2->getLink()->hasBitRange()) {
      ECSLOmPortDirection dir = CSLOmPortDecl::cast(endPoint1->getEndPoint())->getPortDirection();
      if (relation == REL_SS) {
        if      (dir == OUTPUT) { dir = INPUT;  }
        else if (dir == INPUT ) { dir = OUTPUT; }
      }
      if (endPoint2->hasExpr() || (relation != REL_PC && (endPoint2->getEndPoint()->isSignal() || endPoint2->getLink()->hasBitRange()))) {
        if (!endPoint2->genPort(endPoint2->getLineNumber(), endPoint2->getFileName(), dir)) { return; }
      }
    }
//     if (endPoint1->getPostProcessNode() != NCA && endPoint2->getPostProcessNode() != NCA) {
//       if(endPoint1->wasSignal()) {
//         CSLOmPortDecl::cast(endPoint1->getEndPoint())->reverse();
//       }
//       else if(endPoint2->wasSignal()) {
//         CSLOmPortDecl::cast(endPoint2->getEndPoint())->reverse();
//       }
//     }

    TBool brCheck = !checkBitRangeSignalSignal(endPoint1->getLineNumber(), endPoint1->getFileName(), endPoint1->getEndPoint(), endPoint2->getEndPoint(), endPoint1->getPostProcessNode(), endPoint2->getPostProcessNode(), endPoint1->getLink(), endPoint2->getLink());
    if (brCheck) {
      return;
      // TODO :throw error
    }


    if (endPoint1->getEndPoint()->isPort() && endPoint2->getEndPoint()->isPort()) {
      ECSLOmPortDirection dir1 = CSLOmPortDecl::cast(endPoint1->getEndPoint())->getPortDirection();
      ECSLOmPortDirection dir2 = CSLOmPortDecl::cast(endPoint2->getEndPoint())->getPortDirection();
    
      TInt dt = ((((relation << REL_SHIFT) | dir1) << SHIFT) | dir2);
      if (!checkRelationshipSignalSignal(dt)) {
        args.push_back(*convertLink(connection->getEndPoint1()->getLink()));
        args.push_back(*convertLink(connection->getEndPoint2()->getLink()));
        addErr(NSWarningErr::CSE_CAR_STMT_CONNECT_REL_CHECK, args, connection->getLineNumber(), connection->getFileName());
        m_arHasErrors = TRUE;
        return;
      }
    }
    TVec_TLong::iterator it;
    for (it = list->begin(); it < list->end()-1; ++it) {
      // get relationship between it and (it+1)
      if (!passedNCA && NCA == nodeMap->at(*(it+1)) && noSib2Sib == FALSE) {
        passedNCA = TRUE;
        currentRel = REL_SS;
      }
      else if (!passedNCA) { currentRel = REL_CP; }
      else if ( passedNCA) { currentRel = REL_PC; }

      if (routeSegments(connection, *it, *(it + (currentRel == REL_SS?2:1)), currentRel) == FALSE) { break; }

      if (currentRel == REL_SS ) { it++; }

    }
  }
  DCERR("DONE!!!" << endl );
}

TBool CAutorouter::routeSegments(RefConnection conn, TLong id1, TLong id2, EInstanceRel relation) {
  RefTVec_RefCInstTreeNode nodeMap = CInstTreeNode::getNodeMap();
  RefCInstTreeNode node1 = nodeMap->at(id1);
  RefCInstTreeNode node2 = nodeMap->at(id2);

    /**********************************/
    DCERR ( *(node1->getName()) << "<->" << *(node2->getName()) << " <-***-> ");
    DCERR ( node1->getID() << "<->" << node2->getID());
    if      (relation == REL_SS) { DCERR ( "*** SS"); }
    else if (relation == REL_CP) { DCERR ( "*** CP"); }
    else if (relation == REL_PC) { DCERR ( "*** PC"); }

    DCERR ( endl);
    /***********************************/

  // first check to see which component the signal should exist in
  if (check(conn, node1, node2, relation)) {

    return createConnection(conn, node1, node2, relation);
  }
  return FALSE;
}


void CAutorouter::startAutoRouter() {
  RefTVec_RefConnection connections = Connection::getConnectionMap();
  TVec_RefConnection::iterator it;
  
  for (it = connections->begin(); it < connections->end(); it++) {
    m_lastName = RefCSLOmExprLink();
    (*it)->process();
    if ((*it)->getNCA().get()) {
      traverseSegments(*it);
    }
  }
}

} // endof name space NSAutorouter
