//---------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpath Logic, Inc.
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpath Logic, Inc.;
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

/**
 * Author: AdrianI 
 */

#include "CslomSupport.h"

using namespace NSCSLOm;
using namespace std;


//--------------------------
//PortPath class
//--------------------------
/**
 * Take the port and put all the connected ports to the children queue and to the path_queue.
 * After that, while path_queue is not empty take all the connected ports from the first port in the path
 * and put them to the child queue and path_queue.
 */
PortPath::PortPath(RefCSLOmPortDecl port){
  queue<RefPortPath> path_queue;
  
  m_port = port;

  RefTVec_PairRefScope_RefPort connected_ports = getEndpointsUpperPorts(port);
  
  if(!connected_ports.get()){
    return;
  }

  m_children = RefQueue_RefPortPath(new Queue_RefPortPath());
  for(TVec_PairRefScope_RefPort::iterator it = connected_ports->begin(); it != connected_ports->end(); ++it){
    RefPortPath child = PortPath::build(it->second);
    path_queue.push(child);
    m_children->push(child);
  }

  while(path_queue.size()){
    RefPortPath parent = path_queue.front();
    path_queue.pop();

    connected_ports = getEndpointsUpperPorts(parent->m_port);
    
    if(!connected_ports.get()){
      continue;
    }
    
    for(TVec_PairRefScope_RefPort::iterator it = connected_ports->begin(); it != connected_ports->end(); ++it){
      RefPortPath child = PortPath::build(it->second);
      path_queue.push(child);
      parent->m_children->push(child);
    }
  }//while
}

RefPortPath PortPath::build(NSCSLOm::RefCSLOmPortDecl port){
  return RefPortPath(new PortPath(port));
}

RefCSLOmPortDecl PortPath::getPort(){
  return m_port;
}

RefQueue_RefPortPath PortPath::getUpperPorts(){
  return m_children;
}

RefCSLOmUnitInstance PortPath::getScope(){
  return m_scope;
}
//--------------------------
//PortPath class
//--------------------------



RefTVec_PairRefScope_RefPort getEndpointsUpperPorts(RefCSLOmPortDecl port){
  RefTVec_PairRefScope_RefPort result (new TVec_PairRefScope_RefPort());
  RefTVec_RefCSLOmSignal   signals(new TVec_RefCSLOmSignal());
  
  RefCSLOmBase parent = port->getParent();
  while(!parent->isDesign()){
    parent = parent->getParent();
  }
  
  RefCSLOmDesign cslom_design = CSLOmDesign  ::cast(parent);
  
  RefTVec_RefCSLOmUnitDecl units = cslom_design->getUnitDeclarations();
  if(!units.get()){
    return RefTVec_PairRefScope_RefPort();
  }
  
  for(TVec_RefCSLOmUnitDecl::iterator it = units->begin(); it != units->end(); ++it){
    RefTVec_RefCSLOmUnitInstantiation instantiations = (*it)->getInstantiations();
    if(!instantiations.get()){
      continue;
    }
  
    for(TVec_RefCSLOmUnitInstantiation::iterator inst = instantiations->begin(); inst != instantiations->end(); ++inst){
      RefTVec_RefCSLOmUnitInstance instances = (*inst)->getUnitInstances();
      if(!instances.get()){
        continue;
      }
      
      for(TVec_RefCSLOmUnitInstance::iterator ist = instances->begin(); ist != instances->end(); ++ist){
        RefTMap_RefCSLOmExprLink_RefCSLOmExprLink connections = (*ist)->getConnectionMap();
        if(!connections.get()){
          continue;
        }
        
        for(TMap_RefCSLOmExprLink_RefCSLOmExprLink::iterator itm = connections->begin(); itm != connections->end(); ++itm){
          //cout<<"*"<<*(itm->first->getName())<<" "<<*(itm->second->getName())<<endl;
          RefCSLOmBase temp_a = itm->first->doEval();
          if(!temp_a->isPort()){
            continue;
          }
  
          RefCSLOmBase temp_b = itm->second->doEval();
          if(!temp_b->isPort()){
            if(temp_b->isSignal()){
              
              RefCSLOmPortDecl a = CSLOmPortDecl::cast(temp_a);
              RefCSLOmSignal   b = CSLOmSignal  ::cast(temp_b);
  
              if(a == port){
                bool exists = false;
                for(TVec_RefCSLOmSignal::iterator s = signals->begin(); s!=signals->end(); ++s){
                  if(*s == b){
                    exists = true;
                    break;
                  }
                }
                if(!exists) signals->push_back(b);
              }
            }
            continue;
          }
  
          RefCSLOmPortDecl a = CSLOmPortDecl::cast(temp_a);
          RefCSLOmPortDecl b = CSLOmPortDecl::cast(temp_b);
  
          if(a == port){
            /**existance*/
            bool exists = false;
            for(TVec_PairRefScope_RefPort::iterator e = result->begin(); e != result->end(); ++e){
              if(e->second == b){
                exists = true;
                break;
              }
            }
            if(!exists) result->push_back(pair<RefCSLOmUnitInstance,RefCSLOmPortDecl>(*ist,b));
          }//if
        }//for itm: connections
      }//for ist: instances
    }//for inst: instantiations
  }//for it : unit decl
  
  //signals
  for(TVec_RefCSLOmSignal::iterator it = signals->begin(); it!= signals->end(); ++it){
    RefTVec_PairRefScope_RefPort ports = getEndpoints(*it);
    if(!ports.get()){
      continue;
    }
  
    for(TVec_PairRefScope_RefPort::iterator port = ports->begin(); port != ports->end(); ++port){
      bool exists = false;
      for(TVec_PairRefScope_RefPort::iterator e = result->begin(); e != result->end(); ++e){
        if((e->first == port->first) && (e->second == port->second)){
          exists = true;
          break;
        }
      }
      if(!exists) result->push_back(*port);
    }   
  }
  
  return result;
}



RefTVec_PairRefScope_RefPort getEndpointsLowerPorts(RefCSLOmPortDecl port){
  RefTVec_PairRefScope_RefPort result(new TVec_PairRefScope_RefPort());

  RefCSLOmBase parent = port->getParent();
  while(!parent->isDesign()){
    parent = parent->getParent();
  }

  RefCSLOmDesign cslom_design = CSLOmDesign  ::cast(parent);

  RefTVec_RefCSLOmUnitDecl units = cslom_design->getUnitDeclarations();
  if(!units.get()){
    return RefTVec_PairRefScope_RefPort();
  }

  for(TVec_RefCSLOmUnitDecl::iterator it = units->begin(); it != units->end(); ++it){
    RefTVec_RefCSLOmUnitInstantiation instantiations = (*it)->getInstantiations();
    if(!instantiations.get()){
      continue;
    }

    for(TVec_RefCSLOmUnitInstantiation::iterator inst = instantiations->begin(); inst != instantiations->end(); ++inst){
      RefTVec_RefCSLOmUnitInstance instances = (*inst)->getUnitInstances();
      if(!instances.get()){
        continue;
      }
      
      for(TVec_RefCSLOmUnitInstance::iterator ist = instances->begin(); ist != instances->end(); ++ist){
        RefTMap_RefCSLOmExprLink_RefCSLOmExprLink connections = (*ist)->getConnectionMap();
        if(!connections.get()){
          continue;
        }
        
        for(TMap_RefCSLOmExprLink_RefCSLOmExprLink::iterator itm = connections->begin(); itm != connections->end(); ++itm){
          RefCSLOmBase temp_a = itm->first->doEval();
          if(!temp_a->isPort()){
            continue;
          }

          RefCSLOmBase temp_b = itm->second->doEval();
          if(!temp_b->isPort()){
            continue;
          }

          RefCSLOmPortDecl a = CSLOmPortDecl::cast(temp_a);
          RefCSLOmPortDecl b = CSLOmPortDecl::cast(temp_b);

          if(b == port){
            /**existance*/
            bool exists = false;
            for(TVec_PairRefScope_RefPort::iterator e = result->begin(); e != result->end(); ++e){
              if(e->second == a){
                exists = true;
                break;
              }
            }
            if(!exists) result->push_back(pair<RefCSLOmUnitInstance,RefCSLOmPortDecl>(*ist,a));
          }//if
        }//for itm: connections
      }//for ist: instances
    }//for inst: instantiations
  }//for it : unit decl

  return result;
}


RefTVec_PairRefScope_RefConnectable getEndpointsUpper(RefCSLOmPortDecl port){
  RefTVec_PairRefScope_RefConnectable result(new TVec_PairRefScope_RefConnectable());

  RefCSLOmBase parent = port->getParent();
  while(!parent->isDesign()){
    parent = parent->getParent();
  }

  RefCSLOmDesign cslom_design = CSLOmDesign  ::cast(parent);

  RefTVec_RefCSLOmUnitDecl units = cslom_design->getUnitDeclarations();
  if(!units.get()){
    return RefTVec_PairRefScope_RefConnectable();
  }

  for(TVec_RefCSLOmUnitDecl::iterator it = units->begin(); it != units->end(); ++it){
    RefTVec_RefCSLOmUnitInstantiation instantiations = (*it)->getInstantiations();
    if(!instantiations.get()){
      continue;
    }

    for(TVec_RefCSLOmUnitInstantiation::iterator inst = instantiations->begin(); inst != instantiations->end(); ++inst){
      RefTVec_RefCSLOmUnitInstance instances = (*inst)->getUnitInstances();
      if(!instances.get()){
        continue;
      }
      
      for(TVec_RefCSLOmUnitInstance::iterator ist = instances->begin(); ist != instances->end(); ++ist){
        RefTMap_RefCSLOmExprLink_RefCSLOmExprLink connections = (*ist)->getConnectionMap();
        if(!connections.get()){
          continue;
        }
        
        for(TMap_RefCSLOmExprLink_RefCSLOmExprLink::iterator itm = connections->begin(); itm != connections->end(); ++itm){
          RefCSLOmConnectable a = CSLOmConnectable::cast(itm->first->doEval());
          RefCSLOmConnectable b = CSLOmConnectable::cast(itm->second->doEval());

          if(a == port){
            /**existance*/
            bool exists = false;
            for(TVec_PairRefScope_RefConnectable::iterator e = result->begin(); e != result->end(); ++e){
              if(e->second == b){
                exists = true;
                break;
              }
            }
            if(!exists) result->push_back(pair<RefCSLOmUnitInstance, RefCSLOmConnectable>(*ist,b));
          }//if
        }//for itm: connections
      }//for ist: instances
    }//for inst: instantiations
  }//for it : unit decl

  return result;
}



/**
 * A port can be childern of a design, unitdecl or interface.
 * If the scope is a design or ifc then parent is evaluation of 
 * the exprlink. If the scope is unitdecl than parent is the 1st 
 * child opf the unit.
 */
RefCSLOmPortDecl findPort(RefCSLOmExprLink scope, RefString name){
  if(!scope.get()){
    return RefCSLOmPortDecl();
  }

  RefCSLOmBase parent = scope->doEval();

  if(!parent.get()){
    return RefCSLOmPortDecl();
  }

  if(parent->isUnitDecl()){
    parent = parent->getChild(0);
  }

  if(!parent.get()){
    return RefCSLOmPortDecl();
  }

  RefTVec_RefCSLOmPortDecl ports = parent->getChildren<CSLOmPortDecl>(TYPE_ALL_PORTS);

  if(!ports.get()){
    return RefCSLOmPortDecl();
  }
  
  for(TVec_RefCSLOmPortDecl::iterator it = ports->begin(); it!=ports->end(); ++it){
    if((*it)->getName() == name){
      return *it;
    }
  }
  
  return RefCSLOmPortDecl();
}


/**
 * Signals can be children of design and units.
 * If the scope is unitdecl than the parent is the 1st child of the unit.
 */
RefCSLOmSignal findSignal(RefCSLOmExprLink scope, RefString name){
  if(!scope.get()){
    return RefCSLOmSignal();
  }

  RefCSLOmBase parent = scope->doEval();

  if(!parent.get()){
    return RefCSLOmSignal();
  }

  if(parent->isUnitDecl()){
    parent = parent->getChild(0);
  }

  if(!parent.get()){
    return RefCSLOmSignal();
  }

  RefTVec_RefCSLOmSignal signals = parent->getChildren<CSLOmSignal>(TYPE_ALL_SIGNALS);

  if(!signals.get()){
    return RefCSLOmSignal();
  }
  
  for(TVec_RefCSLOmSignal::iterator it = signals->begin(); it!=signals->end(); ++it){
    if((*it)->getName() == name){
      return *it;
    }
  }
  
  return RefCSLOmSignal();
}

/**
 * interfaces can only have parent a design
 */
RefCSLOmInterface findInterface(RefCSLOmExprLink scope, RefString name){
  if(!scope.get()){
    return RefCSLOmInterface();
  }

  RefCSLOmBase parent = scope->doEval();

  if(!parent.get()){
    return RefCSLOmInterface();
  }

  RefTVec_RefCSLOmInterface ifc = parent->getChildren<CSLOmInterface>(TYPE_ALL_INTERFACES);

  if(!ifc.get()){
    return RefCSLOmInterface();
  }
  
  for(TVec_RefCSLOmInterface::iterator it = ifc->begin(); it!=ifc->end(); ++it){
    if((*it)->getName() == name){
      return *it;
    }
  }
  
  return RefCSLOmInterface();
}


/**
 * A signal group can only have parent a design
 */
RefCSLOmGroupSignal findSignalGroup(RefCSLOmExprLink scope, RefString name){
  if(!scope.get()){
    return RefCSLOmGroupSignal();
  }

  RefCSLOmBase parent = scope->doEval();

  if(!parent.get()){
    return RefCSLOmGroupSignal();
  }

  RefTVec_RefCSLOmGroupSignal groups = parent->getChildren<CSLOmGroupSignal>(TYPE_ALL_GROUPS);

  if(!groups.get()){
    return RefCSLOmGroupSignal();
  }
  
  for(TVec_RefCSLOmGroupSignal::iterator it = groups->begin(); it!=groups->end(); ++it){
    if((*it)->getName() == name){
      return *it;
    }
  }
  
  return RefCSLOmGroupSignal();  
}




RefTVec_PairRefScope_RefPort getEndpoints(RefCSLOmSignal signal){
  RefTVec_PairRefScope_RefPort result(new TVec_PairRefScope_RefPort());
  
  if(!signal.get()){
    return RefTVec_PairRefScope_RefPort();
  }

  RefCSLOmBase parent = signal->getParent();
  while(parent.get() && !parent->isDesign()){
    parent = parent->getParent();
  }

  if(!parent.get()){
    return RefTVec_PairRefScope_RefPort();
  }

  RefCSLOmDesign cslom_design = CSLOmDesign::cast(parent);

  RefTVec_RefCSLOmUnitDecl units = cslom_design->getUnitDeclarations();
  if(!units.get()){
    return RefTVec_PairRefScope_RefPort();
  }
  
  for(TVec_RefCSLOmUnitDecl::iterator unit = units->begin(); unit!=units->end(); ++unit){
    RefTVec_RefCSLOmUnitInstantiation instantiations = (*unit)->getInstantiations();
    if(!instantiations.get()){
      continue;
    }

    for(TVec_RefCSLOmUnitInstantiation::iterator instantiation = instantiations->begin();instantiation != instantiations->end(); ++instantiation){
      RefTVec_RefCSLOmUnitInstance instances =(*instantiation)->getUnitInstances();
      if(!instances.get()){
        continue;
      }
      
      for(TVec_RefCSLOmUnitInstance::iterator instance = instances->begin(); instance != instances->end(); ++instance){
        RefTMap_RefCSLOmExprLink_RefCSLOmExprLink connections = (*instance)->getConnectionMap();
        if(!connections.get()){
          continue;
        }

        for(TMap_RefCSLOmExprLink_RefCSLOmExprLink::iterator connection = connections->begin(); connection != connections->end(); ++connection){
          RefCSLOmExprLink expr_a = connection->first;
          RefCSLOmExprLink expr_b = connection->second;
          
          RefCSLOmBase     base_a = expr_a->doEval();
          RefCSLOmBase     base_b = expr_b->doEval();
          
          if(base_a->isSignal() && base_b->isPort()){
            RefCSLOmSignal s = CSLOmSignal::cast(base_a);
            if(s == signal){
              RefCSLOmPortDecl port = CSLOmPortDecl::cast(base_b);
              result->push_back(pair<RefCSLOmUnitInstance,RefCSLOmPortDecl>(*instance,port));
            }
          }else if(base_b->isSignal() && base_a->isPort()){
            //            cout<<*(expr_a->getName())<<" "<<*(expr_b->getName())<<endl;
            RefCSLOmSignal s = CSLOmSignal::cast(base_b);
            if(s == signal){
              RefCSLOmPortDecl port = CSLOmPortDecl::cast(base_a);
              result->push_back(pair<RefCSLOmUnitInstance,RefCSLOmPortDecl>(*instance,port));
            }
          }
        }
      }
    }
  }
  return result;
}


RefCSLOmPortDecl getLeafPort(RefCSLOmPortDecl port){
  RefCSLOmPortDecl leafPort = port;

  RefTVec_PairRefScope_RefPort upper = getEndpointsLowerPorts(leafPort);
  
  while(upper->size()){
    leafPort = upper->begin()->second;
    upper = getEndpointsLowerPorts(leafPort);
  }

  return leafPort;
}
