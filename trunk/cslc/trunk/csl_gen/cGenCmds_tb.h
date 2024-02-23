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

#ifndef _CGEN_CMDS_H_
#define _CGEN_CMDS_H_

#include "cGen_Support.h"

//-----------------------------------global functions-----------------------------------//
/* test case:
   type name(...);
   name.call(...);
 */
void testGlobalPlainDeclGlobalCallAux(CSLCmdPoint cmd,
                                      CSLClassPoint cls,
                                      bool legal,
                                      CSLParamPointVect paramVect = CSLParamPointVect(),
                                      CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testGlobalPlainDeclGlobalCall(CSLCmdPoint cmd,
                                   CSLClassPoint cls);

/* test case:
   type name(...);
   type1 name1 {
     name.call(...);
     name1() {
       ...
     }
   };
 */
void testGlobalPlainDeclScopeCallAux(CSLCmdPoint cmd,
                                     CSLClassPoint cls,
                                     CSLClassPoint scope,
                                     bool legal,
                                     CSLParamPointVect paramVect = CSLParamPointVect(),
                                     CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testGlobalPlainDeclScopeCall(CSLCmdPoint cmd,
                                  CSLClassPoint cls,
                                  CSLClassPoint scope);

/* test case:
   type name(...);
   type1 name1 {
     name1() {
       ...
       name.call(...);
     }
   };
 */
void testGlobalPlainDeclConstrCallAux(CSLCmdPoint cmd,
                                      CSLClassPoint cls,
                                      CSLClassPoint scope,
                                      bool legal,
                                      CSLParamPointVect paramVect = CSLParamPointVect(),
                                      CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testGlobalPlainDeclConstrCall(CSLCmdPoint cmd,
                                   CSLClassPoint cls,
                                   CSLClassPoint scope);

/* test case:
   type name {
     call(...);
     name() {
       ...
     }
   };
 */
void testGlobalScopeDeclScopeCallAux(CSLCmdPoint cmd,
                                     CSLClassPoint cls,
                                     bool legal,
                                     CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testGlobalScopeDeclScopeCall(CSLCmdPoint cmd,
                                  CSLClassPoint cls);

/* test case:
   type name {
     name() {
       ...
       call(...);
     }
   };
 */
void testGlobalScopeDeclConstrCallAux(CSLCmdPoint cmd,
                                      CSLClassPoint cls,
                                      bool legal,
                                      CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect(),
                                      CSLClassPointCSLParamVectPointPairVect cmdDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testGlobalScopeDeclConstrCall(CSLCmdPoint cmd,
                                   CSLClassPoint cls);

/* test case:
   type name {
     name() {
       ...
     }
   };
   name.call(...);
 */
void testGlobalScopeDeclGlobalCallAux(CSLCmdPoint cmd,
                                      CSLClassPoint cls,
                                      bool legal,
                                      CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testGlobalScopeDeclGlobalCall(CSLCmdPoint cmd,
                                   CSLClassPoint cls);

/* test case:
   type name {
     type1 name1(...);
     name1.call(...);
     name() {
       ...
     }
   };
 */
void testScopePlainDeclScopeCallAux(CSLCmdPoint cmd,
                                    CSLClassPoint cls,
                                    CSLClassPoint scope,
                                    bool legal,
                                    CSLParamPointVect paramVect = CSLParamPointVect(),
                                    CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testScopePlainDeclScopeCall(CSLCmdPoint cmd,
                                 CSLClassPoint cls,
                                 CSLClassPoint scope);

/* test case:
   type name {
     type1 name1(...);
     name() {
       ...
       name1.call(...);
     }
   };
 */
void testScopePlainDeclConstrCallAux(CSLCmdPoint cmd,
                                     CSLClassPoint cls,
                                     CSLClassPoint scope,
                                     bool legal,
                                     CSLParamPointVect paramVect = CSLParamPointVect(),
                                     CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testScopePlainDeclConstrCall(CSLCmdPoint cmd,
                                  CSLClassPoint cls,
                                  CSLClassPoint scope);

/* test case:
   type name {
     type1 name1(...);
     name() {
       ...
     }
   };
   name.name1.call(...);
 */
void testScopePlainDeclGlobalCallAux(CSLCmdPoint cmd,
                                     CSLClassPoint cls,
                                     CSLClassPoint scope,
                                     bool legal,
                                     CSLParamPointVect paramVect = CSLParamPointVect(),
                                     CSLClassPointCSLParamVectPointPairVect preDeclVect = CSLClassPointCSLParamVectPointPairVect());

void testScopePlainDeclGlobalCall(CSLCmdPoint cmd,
                                  CSLClassPoint cls,
                                  CSLClassPoint scope);

void buildTests();

#endif //_CGEN_CMDS_H_
