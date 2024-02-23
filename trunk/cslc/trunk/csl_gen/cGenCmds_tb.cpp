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

#include "cGenBase_tb.h"

//-----------------------------------global functions-----------------------------------//
void testGlobalPlainDeclGlobalCallAux(CSLCmdPoint cmd,
                                      CSLClassPoint cls,
                                      bool legal,
                                      CSLParamPointVect paramVect,
                                      CSLClassPointCSLParamVectPointPairVect preDeclVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, fileName, fileHeader, legal, "//Testing non-scope-holder object command call on global scope", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect cmdParamVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, cmdParamVect);
  printPlainDecl(output, cls, cslObj1Name, paramVect);
  printPlainCall(output, cls, cslObj1Name, cmd);

  closeFile(output, fileName, fileHeader);
}

void testGlobalPlainDeclGlobalCall(CSLCmdPoint cmd,
                                   CSLClassPoint cls) {

  CSLParamPointVectVect params = cls->getParams();
  bool isLegal = (cmd->isCaller(cls->getClass())) && (cmd->getCanCallFromGlobalScope());

  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());

    for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
      testGlobalPlainDeclGlobalCallAux(cmd, cls, isLegal, *paramVect, *preDeclVect);
    }

    if (preDeclOrder.empty()) {
      testGlobalPlainDeclGlobalCallAux(cmd, cls, isLegal, *paramVect);
    }
  }

  if (params.empty()) {
    testGlobalPlainDeclGlobalCallAux(cmd, cls, isLegal);
  }
}

void testGlobalPlainDeclScopeCallAux(CSLCmdPoint cmd,
                                     CSLClassPoint cls,
                                     CSLClassPoint scope,
                                     bool legal,
                                     CSLParamPointVect paramVect,
                                     CSLClassPointCSLParamVectPointPairVect preDeclVect) {

  string fileName;
  string fileHeader;

  determineFileName(scope, cls, fileName, fileHeader, legal, "//Testing non-scope-holder object command call in scope-holder object", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect cmdParamVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, cmdParamVect);
  printPlainDecl(output, cls, cslObj1Name, paramVect);
  printScopeBegin(output, scope, cslObj2Name);
  printPlainCall(output, cls, cslObj1Name, cmd, ALIGN_SCOPE);
  printScopeConstrBegin(output, scope, cslObj2Name, ALIGN_SCOPE);
  printScopeConstrEnd(output, ALIGN_SCOPE);

  closeFile(output, fileName, fileHeader);
}

void testGlobalPlainDeclScopeCall(CSLCmdPoint cmd,
                                  CSLClassPoint cls,
                                  CSLClassPoint scope) {

  CSLParamPointVectVect params = cls->getParams();

  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());

    for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
      testGlobalPlainDeclScopeCallAux(cmd, cls, scope, false, *paramVect, *preDeclVect);
    }

    if (preDeclOrder.empty()) {
      testGlobalPlainDeclScopeCallAux(cmd, cls, scope, false, *paramVect);
    }
  }

  if (params.empty()) {
    testGlobalPlainDeclScopeCallAux(cmd, cls, scope, false);
  }
}

void testGlobalPlainDeclConstrCallAux(CSLCmdPoint cmd,
                                      CSLClassPoint cls,
                                      CSLClassPoint scope,
                                      bool legal,
                                      CSLParamPointVect paramVect,
                                      CSLClassPointCSLParamVectPointPairVect preDeclVect) {

  string fileName;
  string fileHeader;

  determineFileName(scope, cls, fileName, fileHeader, legal, "//Testing non-scope-holder object command call in scope-holder object's constructor", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect cmdParamVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, cmdParamVect);
  printPlainDecl(output, cls, cslObj1Name, paramVect);
  printScopeBegin(output, scope, cslObj2Name);
  printScopeConstrBegin(output, scope, cslObj2Name, ALIGN_SCOPE);
  printPlainCall(output, cls, cslObj1Name, cmd, ALIGN_CSTR);
  printScopeConstrEnd(output, ALIGN_SCOPE);

  closeFile(output, fileName, fileHeader);
}

void testGlobalPlainDeclConstrCall(CSLCmdPoint cmd,
                                   CSLClassPoint cls,
                                   CSLClassPoint scope) {

  CSLParamPointVectVect params = cls->getParams();
  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());

    for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
      testGlobalPlainDeclConstrCallAux(cmd, cls, scope, false, *paramVect, *preDeclVect);
    }

    if (preDeclOrder.empty()) {
      testGlobalPlainDeclConstrCallAux(cmd, cls, scope, false, *paramVect);
    }
  }

  if (params.empty()) {
    testGlobalPlainDeclConstrCallAux(cmd, cls, scope, false);
  }
}

void testGlobalScopeDeclScopeCallAux(CSLCmdPoint cmd,
                                     CSLClassPoint cls,
                                     bool legal,
                                     CSLClassPointCSLParamVectPointPairVect preDeclVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, fileName, fileHeader, legal, "//Testing scope-holder object command call in scope", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect paramVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, paramVect);
  printScopeBegin(output, cls, cslObj1Name);
  printParamDecl(output, PD_SCOPE, paramVect, cls->getObjCount(), ALIGN_SCOPE);
  printScopeCall(output, cmd, ALIGN_SCOPE);
  printScopeConstrBegin(output, cls, cslObj1Name, ALIGN_SCOPE);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testGlobalScopeDeclScopeCall(CSLCmdPoint cmd,
                                  CSLClassPoint cls) {

  CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());
  
  for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
    testGlobalScopeDeclScopeCallAux(cmd, cls, false, *preDeclVect);
  }

  if (preDeclOrder.empty()) {
    testGlobalScopeDeclScopeCallAux(cmd, cls, false);
  }
}

void testGlobalScopeDeclConstrCallAux(CSLCmdPoint cmd,
                                      CSLClassPoint cls,
                                      bool legal,
                                      CSLClassPointCSLParamVectPointPairVect preDeclVect,
                                      CSLClassPointCSLParamVectPointPairVect cmdDeclVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, fileName, fileHeader, legal, "//Testing scope-holder object command call in constructor", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect paramVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, paramVect);
  printScopeBegin(output, cls, cslObj1Name);
  printParamDecl(output, PD_SCOPE, paramVect, cls->getObjCount(), ALIGN_SCOPE);
  printScopeConstrBegin(output, cls, cslObj1Name, ALIGN_SCOPE);
  printScopeCall(output, cmd, ALIGN_CSTR);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testGlobalScopeDeclConstrCall(CSLCmdPoint cmd,
                                   CSLClassPoint cls) {

  CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());
  bool isLegal = cmd->isCaller(cls->getClass());
  
  for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
    testGlobalScopeDeclConstrCallAux(cmd, cls, isLegal, *preDeclVect);
  }

  if (preDeclOrder.empty()) {
    testGlobalScopeDeclConstrCallAux(cmd, cls, isLegal);
  }
}

void testGlobalScopeDeclGlobalCallAux(CSLCmdPoint cmd,
                                      CSLClassPoint cls,
                                      bool legal,
                                      CSLClassPointCSLParamVectPointPairVect preDeclVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, fileName, fileHeader, legal, "//Testing scope-holder object command call on global scope", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect paramVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, paramVect);
  printScopeBegin(output, cls, cslObj1Name);
  printParamDecl(output, PD_SCOPE, paramVect, cls->getObjCount(), ALIGN_SCOPE);
  printScopeConstrBegin(output, cls, cslObj1Name, ALIGN_SCOPE);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);
  printPlainCall(output, cls, cslObj1Name, cmd);

  closeFile(output, fileName, fileHeader);
}

void testGlobalScopeDeclGlobalCall(CSLCmdPoint cmd,
                                   CSLClassPoint cls) {

  CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());
  
  for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
    testGlobalScopeDeclGlobalCallAux(cmd, cls, false, *preDeclVect);
  }

  if (preDeclOrder.empty()) {
    testGlobalScopeDeclGlobalCallAux(cmd, cls, false);
  }
}

void testScopePlainDeclScopeCallAux(CSLCmdPoint cmd,
                                    CSLClassPoint cls,
                                    CSLClassPoint scope,
                                    bool legal,
                                    CSLParamPointVect paramVect,
                                    CSLClassPointCSLParamVectPointPairVect preDeclVect) {

  string fileName;
  string fileHeader;

  determineFileName(scope, cls, fileName, fileHeader, legal, "//Testing non-scope-holder in scope-holder object command call in scope", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect cmdParamVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, cmdParamVect);
  printParamDecl(output, PD_GLOBAL, paramVect);
  printScopeBegin(output, scope, cslObj1Name);
  printParamDecl(output, PD_SCOPE, cmdParamVect, cls->getObjCount(), ALIGN_SCOPE);
  printPlainDecl(output, cls, cslObj2Name, paramVect, ALIGN_SCOPE);
  printPlainCall(output, cls, cslObj2Name, cmd, ALIGN_SCOPE);
  printScopeConstrBegin(output, scope, cslObj1Name, ALIGN_SCOPE);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopePlainDeclScopeCall(CSLCmdPoint cmd,
                                 CSLClassPoint cls,
                                 CSLClassPoint scope) {

  CSLParamPointVectVect params = cls->getParams();

  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());

    for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
      testScopePlainDeclScopeCallAux(cmd, cls, scope, false, *paramVect, *preDeclVect);
    }

    if (preDeclOrder.empty()) {
      testScopePlainDeclScopeCallAux(cmd, cls, scope, false, *paramVect);
    }
  }

  if (params.empty()) {
    testScopePlainDeclScopeCallAux(cmd, cls, scope, false);
  }
}

void testScopePlainDeclConstrCallAux(CSLCmdPoint cmd,
                                     CSLClassPoint cls,
                                     CSLClassPoint scope,
                                     bool legal,
                                     CSLParamPointVect paramVect,
                                     CSLClassPointCSLParamVectPointPairVect preDeclVect) {

  string fileName;
  string fileHeader;

  determineFileName(scope, cls, fileName, fileHeader, legal, "//Testing non-scope-holder in scope-holder object command call in constructor", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect cmdParamVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, cmdParamVect);
  printParamDecl(output, PD_GLOBAL, paramVect);
  printScopeBegin(output, scope, cslObj1Name);
  printParamDecl(output, PD_SCOPE, cmdParamVect, cls->getObjCount(), ALIGN_SCOPE);
  printPlainDecl(output, cls, cslObj2Name, paramVect, ALIGN_SCOPE);
  printScopeConstrBegin(output, scope, cslObj1Name, ALIGN_SCOPE);
  printPlainCall(output, cls, cslObj2Name, cmd, ALIGN_CSTR);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopePlainDeclConstrCall(CSLCmdPoint cmd,
                                  CSLClassPoint cls,
                                  CSLClassPoint scope) {

  CSLParamPointVectVect params = cls->getParams();
  bool isLegal = cmd->isCaller(cls->getClass());

  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());

    for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
      testScopePlainDeclConstrCallAux(cmd, cls, scope, isLegal, *paramVect, *preDeclVect);
    }

    if (preDeclOrder.empty()) {
      testScopePlainDeclConstrCallAux(cmd, cls, scope, isLegal, *paramVect);
    }
  }

  if (params.empty()) {
    testScopePlainDeclConstrCallAux(cmd, cls, scope, cmd->isCaller(cls->getClass()));
  }
}

void testScopePlainDeclGlobalCallAux(CSLCmdPoint cmd,
                                     CSLClassPoint cls,
                                     CSLClassPoint scope,
                                     bool legal,
                                     CSLParamPointVect paramVect,
                                     CSLClassPointCSLParamVectPointPairVect preDeclVect) {

  string scopeName = GET_CLASS(cslObj1Name, scope->getClass());
  string fileName;
  string fileHeader;

  determineFileName(scope, cls, fileName, fileHeader, legal, "//Testing non-scope-holder in scope-holder object command call on global scope", cmd);

  ofstream output;
  openFile(output, fileName);

  CSLParamPointVect cmdParamVect = cmd->getParamVect();

  printPlainDeclVect(output, preDeclVect, cslParamName);
  printParamDecl(output, PD_GLOBAL, cmdParamVect);
  printParamDecl(output, PD_GLOBAL, paramVect);
  printScopeBegin(output, scope, cslObj1Name);
  printParamDecl(output, PD_SCOPE, cmdParamVect, cls->getObjCount(), ALIGN_SCOPE);
  printPlainDecl(output, cls, cslObj2Name, paramVect, ALIGN_SCOPE);
  printScopeConstrBegin(output, scope, cslObj1Name, ALIGN_SCOPE);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);
  printPlainHidCall(output, scopeName, cls, cslObj2Name, cmd);

  closeFile(output, fileName, fileHeader);
}

void testScopePlainDeclGlobalCall(CSLCmdPoint cmd,
                                  CSLClassPoint cls,
                                  CSLClassPoint scope) {

  CSLParamPointVectVect params = cls->getParams();
  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    CSLClassPointCSLParamVectPointPairVectVect preDeclOrder = getPreDeclVectOrder(cmd->getParamVect());

    for (CSLClassPointCSLParamVectPointPairVectVect_const_iter preDeclVect = preDeclOrder.begin(); preDeclVect != preDeclOrder.end(); preDeclVect++) {
      testScopePlainDeclGlobalCallAux(cmd, cls, scope, false, *paramVect, *preDeclVect);
    }

    if (preDeclOrder.empty()) {
      testScopePlainDeclGlobalCallAux(cmd, cls, scope, false, *paramVect);
    }
  }

  if (params.empty()) {
    testScopePlainDeclGlobalCallAux(cmd, cls, scope, false);
  }
}

void buildTests() {
  for (CSLCmdPointVect_const_iter cmd = cslCmds.begin(); cmd != cslCmds.end(); cmd++) {
    if (!(*cmd)->getReturnValue()) {
      for (CSLClassPointVect_const_iter cls = cslClasses.begin(); cls != cslClasses.end(); cls++) {
        if (belongsToChapter(*cls)) {
          if ((*cls)->isPlainDecl()) {
            testGlobalPlainDeclGlobalCall(*cmd, *cls);
            for (CSLClassPointVect_const_iter scope = cslClasses.begin(); scope != cslClasses.end(); scope++) {
              if ((*scope)->isScopeHolder()) {
                testGlobalPlainDeclScopeCall(*cmd, *cls, *scope);
                testGlobalPlainDeclConstrCall(*cmd, *cls, *scope);

                if ((*scope)->isLegalDecl((*cls)->getClass())) {
                  testScopePlainDeclScopeCall(*cmd, *cls, *scope);
                  testScopePlainDeclConstrCall(*cmd, *cls, *scope);
                  testScopePlainDeclGlobalCall(*cmd, *cls, *scope);
                }
              }
            }
          }

          if ((*cls)->isScopeHolder()) {
            testGlobalScopeDeclScopeCall(*cmd, *cls);
            testGlobalScopeDeclConstrCall(*cmd, *cls);
            testGlobalScopeDeclGlobalCall(*cmd, *cls);
          }
        }
      }
    }
  }
}

int main(int argc, char** argv) {
  if (runTestGen(TG_COMMAND_CALL, argc, argv, &buildTests) != ERR_NONE) {
    return 1;
  }

  return 0;
}
