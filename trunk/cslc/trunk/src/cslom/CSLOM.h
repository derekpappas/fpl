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

//----------------------------------------------------------------------
// The purpose of this code is to create an intermediate representation
// of csl language input
// In this file contains only a part of the object model. The
// representation on other language structures can be found in the
// following files:
// CSLOM_cmd.h
// CSLOM_EvalRes.h
// CVeriNum.h
// CSLOM_Visitor.h
// CSLOM_*.h
//----------------------------------------------------------------------

// Author BogdanZ

#ifndef INC_GUARD_CSLOm_h
#define INC_GUARD_CSLOm_h

#include "Base.h"
#include "../support/CommonSupport.h"
#include "VeriNum.h"
#include "CSLOM_Declarations.h"

#include <vector>
#include <map>
#include <iostream>
#include <cassert>

#include "CSLOM_Declarations.h"
#include "CSLOM_Base.h"
#include "CSLOM_Exprs.h"
#include "CSLOM_Scoping.h"
#include "CSLOM_Units.h"
#include "CSLOM_Misc.h"
#include "CSLOM_Stmt.h"
#include "CSLOM_UnitInstance.h"
#include "CSLOM_Ranges.h"
#include "CSLOM_Connectable.h"
#include "CSLOM_MemoryMap.h"
#include "CSLOM_Isa.h"
#include "CSLOM_VerifComp.h"


// visitor pattern
namespace NSCSLOmVisitor {
class CVisitor;
}

/**
 * CSLOm class hierarchy is based on single inheritance only. All constructors are private. The only way one can get
 * a new instance of a CSLOm class is by means of public static factory methods, that is public build methods.
 * Some CSLOm classes deny access to these factory methods as well (private factory methods). If this is the case,
 * instances of these particular classes are created in therms of other CSLOm classes. An example of such a class is
 * CSLOmAttrList class. An instance of it can be created only in terms of a CSLOmAttrListCollection object by means the
 * instance method CSLOmAttrListCollection::buildAttrList(). <br/>
 * Each factory method takes care to create a well initialized Ref<...> object of its particular class. It takes care of setting
 * m_weakref which is a selfpointer used to grab again the only strong ref to that object when needed. <br/> <br/>
 *
 * There is a scope tree and there is an object tree. The objects in the object tree point directly to the parent
 * of the object. Moreover the objects also point to their parent scope directly (not using indirection through their
 * object parent). <br/>
 * Example: given the following hierarchy: a (scope) -> b -> c -> ........... -> n -> (x, y, z) <br/>
 * b, c, .... n are non scope parents of x, y, z
 * Suppose that x, y and z are ids, and suppose that you call getParentScope() on x. Only the first time you call
 * getParentScope() on x the whole chain up to a (exclusive) is updated with a pointer to parent scope (that is a in this case). <br/>
 * In other words, during that metod call, b, c, ..., n and x are updated to contain a direct pointer to their
 * parent scope a. <br/>
 * Now suppose that you call getParentScope() on y. The parent scope info is already cached in y's parent, n.
 * So no additional calls up in the hierarchy are made, and y caches his parent scope (a) directly from his parent (n).
 * The same is for z.
 * So x, y and z does point directly to (a) as a parent scope but also points to their direct parent parent as well (n).
 * Moreover, these ids (x,y,z) self register to parent scope (a) when they are first created so we really have 2 hierarchies:
 * scope hierarchy (with their ids that may in turn point to scopes) and object hierarchy. <br/>
 * <b>NOTE: </b>We need the object hiearchy for code gens, to know the exact place where to generate code in the output.
 *
 * @author Eugen Cazacu and Bogdan Zamfir
 */
namespace NSCSLOm {

// ********************************************************************************
// global variables
// ********************************************************************************
extern const TChar DOT;

/**
 * Checks if the parameter passed in is a valid simple identifier.
 *
 * @param name - the name to be checked
 */
RefString convertLink(RefCSLOmExprLink link);

void checkIdName(const RefString& name, TLineNumberType lineNumber, RefString fileName);

RefString ltos(const TULong number); 

} // end namespace NSCSLOm

#endif /*INC_GUARD_CSLOm_h*/
