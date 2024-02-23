//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007 Fastpath Logic
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

#ifndef _CGEN_INST_DECL_H_
#define _CGEN_INST_DECL_H_

#include "cGen_Support.h"

//-----------------------------------global functions-----------------------------------//
/* test case:
   type name {
     name() {
       ...
     }
   };
   name inst;
 */
void testGlobalInstDecl(CSLClassPoint cls);

/* test case:
   type name(...);
   name inst;
 */
void testGlobalInstPlainDeclAux(CSLClassPoint cls,
                                bool legal,
                                ECSLParamDecl declType,
                                CSLParamPointVect paramVect = CSLParamPointVect());

void testGlobalInstPlainDecl(CSLClassPoint cls);

/* test case:
   type name {
     name() {
       ...
     }
   };
   type1 name1 {
     name inst;
     name1() {
       ...
     }
   };
 */
void testScopeInstScopeDecl(CSLClassPoint cls,
                            CSLClassPoint obj);

/* test case:
   type name {
     name() {
       ...
     }
   };
   type1 name1 {
     name1() {
       ...
       name inst;
     }
   };
 */
void testScopeConstrInstScopeDecl(CSLClassPoint cls,
                                  CSLClassPoint obj);

/* test case:
   type name(...);
   type1 name1 {
     name inst;
     name1() {
       ...
     }
   };
 */
void testScopeInstPlainDeclAux(CSLClassPoint cls,
                               CSLClassPoint obj,
                               bool legal,
                               ECSLParamDecl declType,
                               CSLParamPointVect paramVect = CSLParamPointVect());

void testScopeInstPlainDecl(CSLClassPoint cls,
                            CSLClassPoint obj);

/* test case:
   type name(...);
   type1 name1 {
     name1() {
       ...
       name inst;
     }
   };
 */
void testScopeConstrInstPlainDeclAux(CSLClassPoint cls,
                                     CSLClassPoint obj,
                                     bool legal,
                                     ECSLParamDecl declType,
                                     CSLParamPointVect paramVect = CSLParamPointVect());

void testScopeConstrInstPlainDecl(CSLClassPoint cls,
                                  CSLClassPoint obj);

void buildTests();

#endif //_CGEN_INST_DECL_H_
