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
void testScopeDeclAux(CSLClassPoint cls,
                      bool legal,
                      CSLClassPointCSLParamVectPointPairVect mandatoryDecl) {
  
  string fileName;
  string fileHeader;

  determineFileName(cls, fileName, fileHeader, legal, "//Testing global object declaration as scope");

  ofstream output;
  openFile(output, fileName);

  printParamDeclVect(output, PD_GLOBAL, mandatoryDecl);
  printScopeBegin(output, cls, cslObj1Name);
  printPlainDeclVect(output, mandatoryDecl, cslObjName, ALIGN_SCOPE);
  printScopeConstrBegin(output, cls, cslObj1Name, ALIGN_SCOPE);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopeDecl(CSLClassPoint cls) {
  bool isLegal = cls->isScopeHolder();
  CSLClassPointVect mandatoryObjs = cls->getMandatoryObjs();

  if (!mandatoryObjs.empty()) {
    CSLClassPointCSLParamVectPointPairVectVect mandatoryDecls = createPreDeclVectOrder(mandatoryObjs);

    for (CSLClassPointCSLParamVectPointPairVectVect_const_iter mandatoryDecl = mandatoryDecls.begin(); mandatoryDecl != mandatoryDecls.end(); mandatoryDecl++) {
      testScopeDeclAux(cls, isLegal, *mandatoryDecl);
    }
  }
  else {
    testScopeDeclAux(cls, isLegal);
  }
}

void testPlainDeclAux(CSLClassPoint cls,
                      bool legal,
                      ECSLParamDecl declType,
                      CSLParamPointVect paramVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, fileName, fileHeader, legal, "//Testing global object declaration as non-scope");

  ofstream output;
  openFile(output, fileName);

  printParamDecl(output, declType, paramVect);
  printPlainDecl(output, cls, cslObj1Name, paramVect);
  printPlainCallVect(output, cls, cslObj1Name, cls->getMandatoryCmds());

  closeFile(output, fileName, fileHeader);
}

void testPlainDecl(CSLClassPoint cls) {
  CSLParamPointVectVect params = cls->getParams();
  bool isLegal = (!cls->isScopeHolder()) || ((cls->isScopeHolder()) && (!params.empty()));

  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    testPlainDeclAux(cls, isLegal, PD_GLOBAL, *paramVect);
  }

  if (params.empty()) {
    testPlainDeclAux(cls, isLegal, PD_GLOBAL);
  }
}

void testScopeObjDeclAux(CSLClassPoint cls,
                         CSLClassPoint obj,
                         bool legal,
                         ECSLParamDecl declType,
                         CSLParamPointVect paramVect,
                         CSLClassPointCSLParamVectPointPairVect mandatoryDecl) {

  string fileName;
  string fileHeader;

  determineFileName(cls, obj, fileName, fileHeader, legal, "//Testing object declaration inside a scope-holder object");

  ofstream output;
  openFile(output, fileName);

  printParamDeclVect(output, declType, mandatoryDecl);
  printParamDecl(output, declType, paramVect, obj->getObjCount());
  printScopeBegin(output, cls, cslObj1Name);
  printPlainDeclVect(output, mandatoryDecl, cslObjName, ALIGN_SCOPE);
  printPlainDecl(output, obj, cslObjName, paramVect, ALIGN_SCOPE);
  printScopeConstrBegin(output, cls, cslObj1Name, ALIGN_SCOPE);
  printPlainCallVect(output, obj, cslObjName, obj->getMandatoryCmds(), ALIGN_CSTR);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopeObjDecl(CSLClassPoint cls,
                      CSLClassPoint obj) {

  bool isLegal = cls->isLegalDecl(obj->getClass());
  CSLClassPointVect mandatoryObjs = cls->getMandatoryObjs();

  if (!mandatoryObjs.empty()) {
    CSLClassPointCSLParamVectPointPairVectVect mandatoryDecls = createPreDeclVectOrder(mandatoryObjs);

    for (CSLClassPointCSLParamVectPointPairVectVect_const_iter mandatoryDecl = mandatoryDecls.begin(); mandatoryDecl != mandatoryDecls.end(); mandatoryDecl++) {
      CSLParamPointVectVect params = obj->getParams();

      for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
        testScopeObjDeclAux(cls, obj, isLegal, PD_GLOBAL, *paramVect, *mandatoryDecl);
      }

      if (params.empty()) {
        testScopeObjDeclAux(cls, obj, isLegal, PD_GLOBAL, CSLParamPointVect(), *mandatoryDecl);
      }
    }
  }
  else {
    CSLParamPointVectVect params = obj->getParams();

    for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
      testScopeObjDeclAux(cls, obj, isLegal, PD_GLOBAL, *paramVect);
    }

    if (params.empty()) {
      testScopeObjDeclAux(cls, obj, isLegal, PD_GLOBAL);
    }
  }
}

void testScopeConstrObjDeclAux(CSLClassPoint cls,
                               CSLClassPoint obj,
                               bool legal,
                               ECSLParamDecl declType,
                               CSLParamPointVect paramVect) {

  string fileName;
  string fileHeader;

  determineFileName(cls, obj, fileName, fileHeader, legal, "//Testing object declaration inside a scope-holder object constructor");

  ofstream output;
  openFile(output, fileName);

  printParamDecl(output, declType, paramVect);
  printScopeBegin(output, cls, cslObj1Name);
  printScopeConstrBegin(output, cls, cslObj1Name, ALIGN_SCOPE);
  printPlainDecl(output, obj, cslObjName, paramVect, ALIGN_CSTR);
  printPlainCallVect(output, obj, cslObjName, obj->getMandatoryCmds(), ALIGN_CSTR);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopeConstrObjDecl(CSLClassPoint cls,
                            CSLClassPoint obj) {

  CSLParamPointVectVect params = obj->getParams();
  for (CSLParamPointVectVect_const_iter paramVect = params.begin(); paramVect != params.end(); paramVect++) {
    testScopeConstrObjDeclAux(cls, obj, false, PD_GLOBAL, *paramVect);
  }

  if (params.empty()) {
    testScopeConstrObjDeclAux(cls, obj, false, PD_GLOBAL);
  }
}

void testScopeObjScopeDecl(CSLClassPoint cls,
                           CSLClassPoint obj) {

  string fileName;
  string fileHeader;

  determineFileName(cls, obj, fileName, fileHeader, false, "//Testing scope object declaration inside a scope-holder object");

  ofstream output;
  openFile(output, fileName);

  printScopeBegin(output, cls, cslObj1Name);
  printScopeBegin(output, obj, cslObjName, ALIGN_SCOPE);
  printScopeConstrBegin(output, obj, cslObj1Name, ALIGN_CSTR);
  printScopeConstrEnd(output, ALIGN_CSTR);
  printScopeEnd(output, ALIGN_SCOPE);
  printScopeConstrBegin(output, cls, cslObj1Name, ALIGN_SCOPE);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void testScopeConstrObjScopeDecl(CSLClassPoint cls,
                                 CSLClassPoint obj) {

  string fileName;
  string fileHeader;

  determineFileName(cls, obj, fileName, fileHeader, false, "//Testing scope object declaration inside a scope-holder object constructor");

  ofstream output;
  openFile(output, fileName);

  printScopeBegin(output, cls, cslObj1Name);
  printScopeConstrBegin(output, cls, cslObj1Name, ALIGN_SCOPE);
  printScopeBegin(output, obj, cslObjName, ALIGN_CSTR);
  printScopeConstrBegin(output, obj, cslObj1Name, "      ");
  printScopeConstrEnd(output, "      ");
  printScopeEnd(output, ALIGN_CSTR);
  printScopeConstrEnd(output, ALIGN_SCOPE);
  printScopeEnd(output);

  closeFile(output, fileName, fileHeader);
}

void buildTests() {
  for (CSLClassPointVect_const_iter cls = cslClasses.begin(); cls != cslClasses.end(); cls++) {
    if (belongsToChapter(*cls)) {
      testScopeDecl(*cls);
      testPlainDecl(*cls);
      if ((*cls)->isScopeHolder()) {
        for (CSLClassPointVect_const_iter obj = cslClasses.begin(); obj != cslClasses.end(); obj++) {
          CSLClassPoint testObj = (*cls)->getObjDecl(*obj);

          testScopeObjDecl(*cls, testObj);
          testScopeConstrObjDecl(*cls, testObj);
          if (((*obj)->isScopeHolder()) && ((*cls)->isLegalDecl((*obj)->getClass()))) {
            testScopeObjScopeDecl(*cls, testObj);
            testScopeConstrObjScopeDecl(*cls, testObj);
          }
        }
      }
    }
  }
}

int main(int argc, char** argv) {
  if (runTestGen(TG_DECLARATION, argc, argv, &buildTests) != ERR_NONE) {
    return 1;
  }

  return 0;
}
