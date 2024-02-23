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


#include "support.h"

// string randString() {
//   string randStr = "";
//   randStr = rand() % ('Z' - 'A') + 'A';
//   for (int i = 1; i < NAME_STRINGS_SIZE; i++) {
//     randStr += rand() % ('z' - 'a') + 'a';
//   }
//   // names.push_back(randStr);
//   return randStr;
// }

string IntToString ( int number ) {
  ostringstream oss;
  oss << number;
  return oss.str();
}

string intToStr (const int& no){
  stringstream ss;
  ss << no;
  return ss.str();
}

numExpr* createTree( int i) {
  numExpr* node;
  int flag;
  int opFlag;

  //  flag = rand()%3;
  flag = 0;
  if( flag != 2 && i < 1 ) {
    node = new numExpr;
    node -> value = string("");
    if( !flag ) {
      //digit
      node -> value.append( IntToString( rand()%10) );
      node -> left = NULL;
      node -> right = NULL;
      return node;
    }
    else {
      //operator
      opFlag = rand()%2;
      if( !opFlag ) {
        //unary operator
        node -> value.append( UNARY_POSTFIXED_OP[ rand()%2 ] );

        numExpr* nou;
        nou = new numExpr;
        nou -> value = string("");
        nou -> value.append( IntToString( rand()%10) );
        nou -> left = NULL;
        nou -> right = NULL;

        node -> left = nou;;
        node -> right = NULL;
        delete nou;
        return node;
      }
      else {
        //binary operator
        node -> value.append( BINARY_OP[ rand()% 5] );
        node -> left = createTree( i);
        if( !node -> left ) {
          i++;
        }
        node -> right = createTree( i);
        if( !node -> right ) {
          i++;
        }
        return node;
      }
    }
  }
  else
    return 0;
}

void displayTree(numExpr* node, string nE) {
  //  srand( time( 0));
  if( node ) {
    displayTree( node -> left, nE);
    nE.append( node -> value);
    //    cerr << node->value;
    displayTree( node -> right, nE );
  }
}

string randNumExpr() {
  numExpr* node;
  string nE = IntToString( rand()%10 );
  //  node = new numExpr;
  node = createTree( 0);
  if( !node ) {
    nE = IntToString( rand()%10 );
  }
  else
    displayTree(node, nE);

  delete node;
  return nE;
}


ostream* lCbrace(ostream* out){
  (*out)<<"{\n";
}

ostream* rCbrace(ostream* out){
  (*out)<<"}\n";
}

ostream* init(ostream* out){
  (*out)<<"  void initialise()";
}

ostream* lParenthesis(ostream* out){
  (*out)<<"(";
}

ostream* rParenthesis(ostream* out){
  (*out)<<")";
}

ostream* comma(ostream* out){
  (*out)<<", ";
}

ostream* semicolon(ostream* out){
  (*out)<<";\n";
}

void CslFifo(ostream* out){
  (*out)<<"csl_fifo ";
}

ostream* cslIsaField(ostream* out) {
  (*out) << "csl_isa_field ";
}

ostream* cslIsaElement(ostream* out) {
  (*out) << "csl_isa_element ";
}

ostream* cslMemoryMapPage(ostream* out) {
  (*out) << "csl_memory_map_page ";
}

ostream* cslMemoryMap(ostream* out) {
  (*out) << "csl_memory_map ";
}

ostream* cslMemory(ostream* out) {
  (*out) << "csl_memory ";
}

ostream* cslRegister(ostream* out) {
  (*out) << "csl_register ";
}

ostream* cslRegisterFile(ostream* out) {
  (*out) << "csl_register_file ";
}

ostream* cslField(ostream* out) {
  (*out) << "csl_field ";
}

ostream* funct0param(ostream* out, string fuctName) {
  (*out) << "     ";
  (*out) << fuctName ;
  lParenthesis(out);
  rParenthesis(out);
  semicolon(out);
}

ostream* funct1param(ostream* out, string fuctName, string firstParam) {
  (*out) << "     ";
  (*out) << fuctName ;
  lParenthesis(out);
  (*out) << firstParam;
  rParenthesis(out);
  semicolon(out);
}

ostream* funct2param(ostream* out, string fuctName, string firstParam, string secondParam) {
  (*out) << "     ";
  (*out) << fuctName ;
  lParenthesis(out);
  (*out) << firstParam;
  comma(out);
  (*out) << secondParam;
  rParenthesis(out);
  semicolon(out);
}

ostream* funct3param(ostream* out, string fuctName, string firstParam, string secondParam, string thirdParam) {
  (*out) << "     ";
  (*out) << fuctName ;
  lParenthesis(out);
  (*out) << firstParam;
  comma(out);
  (*out) << secondParam;
  comma(out);
  (*out) << thirdParam;
  rParenthesis(out);
  semicolon(out);
}

ostream* displayFunctDecl(ostream* out, string command, string name) {
  (*out) << "  ";
  (*out) << command << ' ';
  (*out) << name;
  semicolon(out);
}

void dot(ostream* out) {
  (*out) << ".";
}

void space(ostream* out) {
  (*out) << " ";
}

void decl0param(ostream* out, string type, string name) {
  (*out) << "  " << type;
  space(out);
  (*out) << name;
  semicolon(out);
}

void decl1param(ostream* out, string type, string name, string firstParam) {
  (*out) << "  " << type;
  space(out);
  (*out) << name;
  lParenthesis(out);
  (*out) << firstParam;
  rParenthesis(out);
  semicolon(out);
}

void decl2param(ostream* out, string type, string name, string firstParam, string secondParam) {
  (*out) << "  " << type;
  space(out);
  (*out) << name;
  lParenthesis(out);
  (*out) << firstParam;
  comma(out);
  (*out) << secondParam;
  rParenthesis(out);
  semicolon(out);
}

void decl3param(ostream* out, string type, string name, string firstParam, string secondParam, string thirdParam) {
  (*out) << "  " << type;
  space(out);
  (*out) << name;
  lParenthesis(out);
  (*out) << firstParam;
  comma(out);
  (*out) << secondParam;
  comma(out);
  (*out) << thirdParam;
  rParenthesis(out);
  semicolon(out);
}

void declSHbegin(ostream* out, string type, string name) {
  (*out) << type;
  space(out);
  (*out) << name;
  lCbrace(out);
}

void declSHend(ostream* out) {
  (*out) << "};\n";
}

void constrSHbegin(ostream* out, string name) {
  (*out) << "  " << name;
  lParenthesis(out);
  rParenthesis(out);
  space(out);
  lCbrace(out);
}

void constrSHend(ostream* out) {
  (*out) << "  ";
  rCbrace(out);
}

void call0param(ostream* out, string scope, string caller, string funct) {
  (*out) << "    " << scope << caller;
  dot(out);
  (*out) << funct;
  lParenthesis(out);
  rParenthesis(out);
  semicolon(out);
}

void call1param(ostream* out, string scope, string caller, string funct, string firstParam) {
  (*out) << "    " << scope << caller;
  dot(out);
  (*out) << funct;
  lParenthesis(out);
  (*out) << firstParam;
  rParenthesis(out);
  semicolon(out);
}

void call2param(ostream* out, string scope, string caller, string funct, string firstParam, string secondParam) {
  (*out) << "    " << scope << caller;
  dot(out);
  (*out) << funct;
  lParenthesis(out);
  (*out) << firstParam;
  comma(out);
  (*out) << secondParam;
  rParenthesis(out);
  semicolon(out);
}
