// Copyright (c) 2005, 2006, 2007 Fastpathlogic
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

#ifndef CSL_SUPPORT_CODE_GEN_H
#define CSL_SUPPORT_CODE_GEN_H

#include <iostream>
#include <string>
#include <sstream>

using namespace std;

const string UNARY_POSTFIXED_OP[2]  = {"++", "--"};
const string BINARY_OP[5]           = {"*", "/", "%", "+", "-"};
const short NAME_STRINGS_SIZE       = 2;

struct numExpr {
    string value;
    numExpr* left;
    numExpr* right;
};

string randString();
string IntToString ( int number );
numExpr* createTree( int i);
void displayTree(numExpr* node, string nE);
string randNumExpr();

string intToStr (const int& no);

void CslFifo(ostream* out); 
ostream* lCbrace(ostream* out);
ostream* rCbrace(ostream* out);
ostream* init(ostream& out);
ostream* lParenthesis(ostream* out);
ostream* rParenthesis(ostream* out);
ostream* semicolon(ostream* out);
ostream* comma(ostream* out);
       
ostream* funct0param(ostream* out, string functName);
ostream* funct1param(ostream* out, string functName, string firstParam);
ostream* funct2param(ostream* out, string functName, string firstParam, string secondParam);
ostream* funct3param(ostream* out, string functName, string firstParam, string secondParam, string thirdParam);
       
ostream* displayFunctDecl(ostream* out, string command, string name);

ostream* cslIsaField(ostream* out);
ostream* cslIsaElement(ostream* out);

ostream* cslMemoryMapPage(ostream* out);
ostream* cslMemoryMap(ostream* out);
ostream* cslMemory(ostream* out);
ostream* cslRegister(ostream* out);
ostream* cslRegisterFile(ostream* out);
ostream* cslField(ostream* out);

void dot(ostream* out);

void space(ostream* out);

void decl0param(ostream* out, string type, string name);
void decl1param(ostream* out, string type, string name, string firstParam);
void decl2param(ostream* out, string type, string name, string firstParam, string secondParam);
void decl3param(ostream* out, string type, string name, string firstParam, string secondParam, string thirdParam);

void declSHbegin(ostream* out, string type, string name);
void declSHend(ostream* out);

void constrSHbegin(ostream* out, string name);
void constrSHend(ostream* out);

void call0param(ostream* out, string scope, string caller, string funct);
void call1param(ostream* out, string scope, string caller, string funct, string firstParam);
void call2param(ostream* out, string scope, string caller, string funct, string firstParam, string secondParam);

#endif //CSL_SUPPORT_CODE_GEN_H
