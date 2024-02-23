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
void testGlobalInstDecl(CSLClassPoint cls) {
  string fileName;
  string fileHeader;

  determineFileName(cls, fileName, fileHeader, false, "//Testing instance of scope-holder object on global scope");

  ofstream output;
  openFile(output, fileName);

  printScopeBegin(output, cls, cslObj1Name);
  printScopeConstrBegin(output, cls, cslObj1Name, "  ");
  printScopeConstrEnd(output, "  ");
  printScopeEnd(output);
  printInstDecl(output, cls, cslObj1Name);

  closeFile(output, fileName, fileHeader);
}

void testGlobalInstPlainDeclAux(CSLClassPoint cls,
                                bool legal,
                                ECSLParamDecl declType,
                                CSLParamPointVect paramVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, fileName, fileHeader, legal, "//Testing instance of non-scope-holder object on global scope");

  ofstream output;
  openFile(output, fileName);

  printParamDecl(output, declType, paramVect);
  printPlainDecl(output, cls, cslObj1Name, paramVect);
  printInstDecl(output, cls, cslObj1Name);

  closeFile(output, fileName, fileHeader);
}

void testGlobalInstPlainDecl(CSLClassPoint cls) {
  CSLParamPointVectVect params = cls->getParams();
  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    testGlobalInstPlainDeclAux(cls, false, PD_GLOBAL, *paramVect);
  }

  if (params.empty()) {
    testGlobalInstPlainDeclAux(cls, false, PD_GLOBAL);
  }
}

void testScopeInstScopeDecl(CSLClassPoint cls,
                            CSLClassPoint obj) {

  string fileName;
  string fileHeader;
  bool isLegal = cls->isLegalInst(obj->getClass());

  determineFileName(cls, obj, fileName, fileHeader, isLegal, "//Testing instance of scope-holder object in other scope-holder object");

  ofstream output;
  openFile(output, fileName);

  printScopeBegin(output, obj, cslObj1Name);
  printScopeConstrBegin(output, obj, cslObj1Name, "  ");
  printScopeConstrEnd(output, "  ");
  printScopeEnd(output);

  printScopeBegin(output, cls, cslObj2Name);
  printInstDecl(output, obj, cslObj1Name, "  ");
  printScopeConstrBegin(output, cls, cslObj2Name, "  ");
  printScopeConstrEnd(output, "  ");
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopeConstrInstScopeDecl(CSLClassPoint cls,
                                  CSLClassPoint obj) {

  string fileName;
  string fileHeader;

  determineFileName(cls, obj, fileName, fileHeader, false, "//Testing instance of scope-holder object in other scope-holder object's constructor");

  ofstream output;
  openFile(output, fileName);

  printScopeBegin(output, obj, cslObj1Name);
  printScopeConstrBegin(output, obj, cslObj1Name, "  ");
  printScopeConstrEnd(output, "  ");
  printScopeEnd(output);

  printScopeBegin(output, cls, cslObj2Name);
  printScopeConstrBegin(output, cls, cslObj2Name, "  ");
  printInstDecl(output, obj, cslObj1Name, "    ");
  printScopeConstrEnd(output, "  ");
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopeInstPlainDeclAux(CSLClassPoint cls,
                               CSLClassPoint obj,
                               bool legal,
                               ECSLParamDecl declType,
                               CSLParamPointVect paramVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, obj, fileName, fileHeader, legal, "//Testing instance of non-scope-holder object in a scope-holder object");

  ofstream output;
  openFile(output, fileName);

  printParamDecl(output, declType, paramVect);
  printPlainDecl(output, obj, cslObj1Name, paramVect);

  printScopeBegin(output, cls, cslObj2Name);
  printInstDecl(output, obj, cslObj1Name, "  ");
  printScopeConstrBegin(output, cls, cslObj2Name, "  ");
  printScopeConstrEnd(output, "  ");
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopeInstPlainDecl(CSLClassPoint cls,
                            CSLClassPoint obj) {

  CSLParamPointVectVect params = obj->getParams();
  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    testScopeInstPlainDeclAux(cls, obj, false, PD_GLOBAL, *paramVect);
  }

  if (params.empty()) {
    testScopeInstPlainDeclAux(cls, obj, false, PD_GLOBAL);
  }
}

void testScopeConstrInstPlainDeclAux(CSLClassPoint cls,
                                     CSLClassPoint obj,
                                     bool legal,
                                     ECSLParamDecl declType,
                                     CSLParamPointVect paramVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, obj, fileName, fileHeader, legal, "//Testing instance of non-scope-holder object in a scope-holder object's constructor");

  ofstream output;
  openFile(output, fileName);

  printParamDecl(output, declType, paramVect);
  printPlainDecl(output, obj, cslObj1Name, paramVect);

  printScopeBegin(output, cls, cslObj2Name);
  printScopeConstrBegin(output, cls, cslObj2Name, "  ");
  printInstDecl(output, obj, cslObj1Name, "    ");
  printScopeConstrEnd(output, "  ");
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopeConstrInstPlainDecl(CSLClassPoint cls,
                                  CSLClassPoint obj) {

  CSLParamPointVectVect params = obj->getParams();
  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    testScopeConstrInstPlainDeclAux(cls, obj, false, PD_GLOBAL, *paramVect);
  }

  if (params.empty()) {
    testScopeConstrInstPlainDeclAux(cls, obj, false, PD_GLOBAL);
  }
}

void buildTests() {
  for (CSLClassPointVect_const_iter cls = cslClasses.begin(); cls != cslClasses.end(); cls++) {
    if ((*cls)->isScopeHolder() && belongsToChapter(*cls)) {
      testGlobalInstDecl(*cls);
      for (CSLClassPointVect_const_iter obj = cslClasses.begin(); obj != cslClasses.end(); obj++) {
        if ((*obj)->isScopeHolder()) {
          testScopeInstScopeDecl(*cls, *obj);
          testScopeConstrInstScopeDecl(*cls, *obj);
        }
        else {
          testScopeInstPlainDecl(*cls, *obj);
          testScopeConstrInstPlainDecl(*cls, *obj);
        }
      }
    }
    else {
      testGlobalInstPlainDecl(*cls);
    }
  }
}

int main(int argc, char** argv) {
  if (runTestGen(TG_INSTANCE_DECLARATION, argc, argv, &buildTests) != ERR_NONE) {
    return 1;
  }

  return 0;
}
