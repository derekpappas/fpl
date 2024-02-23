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

#ifndef CSLOMSUPPORT_H
#define CSLOMSUPPORT_H

#include "../cslom/CSLOM_Connectable.h"
#include "../cslom/CSLOM.h"

#include <iostream>
#include <string>
#include <queue>
#include <map>
typedef std::vector<std::pair<NSCSLOm::RefCSLOmUnitInstance,NSCSLOm::RefCSLOmPortDecl> >  TVec_PairRefScope_RefPort;
typedef boost::shared_ptr<TVec_PairRefScope_RefPort> RefTVec_PairRefScope_RefPort;

typedef boost::shared_ptr<std::vector<std::pair<NSCSLOm::RefCSLOmUnitInstance,NSCSLOm::RefCSLOmConnectable> > > RefTVec_PairRefScope_RefConnectable;
typedef std::vector<std::pair<NSCSLOm::RefCSLOmUnitInstance,NSCSLOm::RefCSLOmConnectable> >  TVec_PairRefScope_RefConnectable;

class PortPath;
typedef boost::shared_ptr<PortPath>          RefPortPath;
typedef std  ::queue<RefPortPath>            Queue_RefPortPath;
typedef boost::shared_ptr<Queue_RefPortPath> RefQueue_RefPortPath;

class PortPath{
  public:
    static RefPortPath build(NSCSLOm::RefCSLOmPortDecl);

    NSCSLOm::RefCSLOmPortDecl     getPort();
    NSCSLOm::RefCSLOmUnitInstance getScope();
    RefQueue_RefPortPath          getUpperPorts();

  private:
    NSCSLOm::RefCSLOmPortDecl     m_port;
    NSCSLOm::RefCSLOmUnitInstance m_scope;
    RefQueue_RefPortPath          m_children;
  
    PortPath(NSCSLOm::RefCSLOmPortDecl);
};



/**
 * CSLOm support functions
 * example:
 *
 *      -----------------------------------------
 *      |z             |  p0  |                 |
 *      |              ---^----                 |
 *      |                 |                     |
 *      |                 |                     |
 *      |                 |                     |
 *      |                 |                     |
 *      |  ------------   |        -----------  |
 *      |  |x         |   |        |y        |  |
 *      |  |          |   |        |         |  |
 *      |  | ----   --|   |        |---      |  |
 *      |  | |z |   | <----        |  |      |  |
 *      |  | |p2<--->p|     s      |p1|      |  |
 *      |  | |  |   | <------------>  |      |  |
 *      |  | ----   --|            |---      |  |
 *      |  ------------            -----------  |
 *      |                                       |
 *      -----------------------------------------
 *      
 * explication:
 *      p, p0, p1, p2 are ports
 *      s is a signal
 *      x, y, z are units
 *      cslom map:
 *            {p2, p }
 *            {p , p0}
 *            {p , s }
 *            {p1 ,s }
 *            
 */



/**
 * getEndpointsUpperPorts(p) = {p0, p1}
*/
RefTVec_PairRefScope_RefPort getEndpointsUpperPorts  (NSCSLOm::RefCSLOmPortDecl);

/**
 * getEndpointsLowerPorts(p) = {p2}
*/
RefTVec_PairRefScope_RefPort getEndpointsLowerPorts  (NSCSLOm::RefCSLOmPortDecl);

/**
 * getEndpointsUpper(p) = {p0, s}
*/
RefTVec_PairRefScope_RefConnectable getEndpointsUpper(NSCSLOm::RefCSLOmPortDecl);


/**
 * unused functions....
 * nobody needs them, but i had to make them
*/
NSCSLOm::RefCSLOmPortDecl    findPort       (NSCSLOm::RefCSLOmExprLink, RefString);
NSCSLOm::RefCSLOmSignal      findSignal     (NSCSLOm::RefCSLOmExprLink, RefString);
NSCSLOm::RefCSLOmInterface   findInterface  (NSCSLOm::RefCSLOmExprLink, RefString);
NSCSLOm::RefCSLOmGroupSignal findSignalGroup(NSCSLOm::RefCSLOmExprLink, RefString);


/**
 * getEndpoints(s) = {p, p1}
*/
RefTVec_PairRefScope_RefPort getEndpoints(NSCSLOm::RefCSLOmSignal);


/**
 * return the lowest port(leaft port) from a PortPath
 * parameter is any port from the path
*/
NSCSLOm::RefCSLOmPortDecl getLeafPort(NSCSLOm::RefCSLOmPortDecl);

#endif

