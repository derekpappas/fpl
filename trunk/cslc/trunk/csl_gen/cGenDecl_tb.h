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

#ifndef _CGEN_DECL_H_
#define _CGEN_DECL_H_

#include "cGen_Support.h"

//-----------------------------------global functions-----------------------------------//
/* test case:
   type name {
     name() {
       ...
     }
   };
 */
void testScopeDeclAux(CSLClassPoint cls,
                      bool legal,
                      CSLClassPointCSLParamVectPointPairVect mandatoryDecl = CSLClassPointCSLParamVectPointPairVect());

void testScopeDecl(CSLClassPoint cls);

/* test case:
   type name(...);
 */
void testPlainDeclAux(CSLClassPoint cls,
                      bool legal,
                      ECSLParamDecl declType,
                      CSLParamPointVect paramVect = CSLParamPointVect());

void testPlainDecl(CSLClassPoint cls);

/* test case:
   type name {
     type1 name1(...);
     name() {
       ...
     }
   };
 */
void testScopeObjDeclAux(CSLClassPoint cls,
                         CSLClassPoint obj,
                         bool legal,
                         ECSLParamDecl declType,
                         CSLParamPointVect paramVect = CSLParamPointVect(),
                         CSLClassPointCSLParamVectPointPairVect mandatoryDecl = CSLClassPointCSLParamVectPointPairVect());

void testScopeObjDecl(CSLClassPoint cls,
                      CSLClassPoint obj);

/* test case:
   type name {
     name() {
       ...
       type1 name1(...);
     }
   };
 */
void testScopeConstrObjDeclAux(CSLClassPoint cls,
                               CSLClassPoint obj,
                               bool legal,
                               ECSLParamDecl declType,
                               CSLParamPointVect paramVect = CSLParamPointVect());

void testScopeConstrObjDecl(CSLClassPoint cls,
                            CSLClassPoint obj);

/* test case:
   type name {
     type1 name1 {
       name1() {
         ...
       }
     };
     name() {
       ...
     }
   };
*/
void testScopeObjScopeDecl(CSLClassPoint cls,
                           CSLClassPoint obj);

/* test case:
   type name {
     name() {
       ...
       type1 name1 {
         name1() {
           ...
         }
       };
     }
   };
 */
void testScopeConstrObjScopeDecl(CSLClassPoint cls,
                                 CSLClassPoint obj);

void buildTests();

#endif //_CGEN_DECL_H_
