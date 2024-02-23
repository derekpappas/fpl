//----------------------------------------------------------------------
//  Copyright (C) ***** TO BE COMPLETED *****
//
//  All rights reserved. No part of this file may be reproduced, stored
//  in a retrieval system, or transmitted in any form or by any other means,
//  electronic, mechanical, photocopying, recording, or otherwise,
//  without the prior consent of ***** TO BE COMPLETED *****
//----------------------------------------------------------------------

#include <fstream>
#include <sstream>
#include <iostream>
#include "testDriver.h"
#include "testException.h"
#define EXP_LPAR "Expected token \'(\', found "
#define EXP_RPAR "Expected token \')\', found "

using namespace std;
using namespace NSCdom;

// ---------------------------------------------
// |            Operators implementation       |
// ---------------------------------------------
ostream& operator<<(ostream& out, CTestException& e )  { out << e.toString(); return out; }

/*istream& operator>>(istream& in, RefCVeriNum &x ) {
    CTestVeriNum veriTest;
    veriTest.readInputData(in);
    x = veriTest.getValue();
    return in;
}
*/
istream& operator>>(istream& in, CVeriNum::TBase &base) throw(CTestExceptionSyntaxErr*) {
    string value;
    in >> value;
    if( value == "BIN") {
        base = CVeriNum::BIN;
    } else if( value == "OCT" ) {
        base == CVeriNum::OCT;
    } else if( value == "DEC" ) {
        base == CVeriNum::DEC;
    } else if( value == "HEX" ) {
        base == CVeriNum::HEX;
    } else {
        string place = "istream& operator>>(istream& in, CVeriNum::TBase &base)";
        ostringstream message;
        message << "invalid CVeriNum::TBase token, expecting BIN OCT DEC HEX, found : " << value;
        throw new CTestExceptionSyntaxErr(place, message.str());
    }

    return in;
}
istream& operator>>(istream &in, CVeriNum::TBit &b) throw(CTestExceptionSyntaxErr*) {
    string c;
    in >> c;
    if( c == "0" || c == "_0" )
        b = CVeriNum::_0;
    else if( c == "1" || c == "_1" )
        b = CVeriNum::_1;
    else if( c == "x" || c == "X" || c == "_X" )
        b = CVeriNum::_X;
    else if( c == "z" || c == "Z" || c == "_Z" )
        b = CVeriNum::_Z;
    else {
        string place = "istream& operator>>(istream &in, CVeriNum::TBit &b)";
        ostringstream message;
        message << "invalid CVeriNum::TBit token, expecting 0 _0 1 _1 x X _X z Z _Z, found : " << c;
        throw new CTestExceptionSyntaxErr(place, message.str());
    }

    return in;
}

istream& operator>>(istream &in, CVeriNum::TPadType &pad) throw(CTestExceptionSyntaxErr*){
    string value;
    in >> value;
    if ( value == "PAD_SIGN" ) 
        pad = CVeriNum::PAD_SIGN;
    else if (value == "PAD_ZERO" )
        pad == CVeriNum::PAD_ZERO;
    else {
        string place = "istream& operator>>(istream &in, CVeriNum::TPadType &pad)";
        ostringstream message;
        message << "invalid CVeriNum::TPadType token, expecting PAD_SIGN PAD_ZERO, found : " << value;
        throw new CTestExceptionSyntaxErr(place, message.str());
    }
    return in;
}

istream& operator>>(std::istream &in, NSCdom::CDOmPathDecl::EPathDeclType &type) throw(CTestExceptionSyntaxErr*) {
  string readType;
  in>>readType;
  if(readType == "simple") //simple path declaration
    type = NSCdom::CDOmPathDecl::PATH_DECL_SIMPLE;
  else
    if(readType == "edge") //edge path declaration
      type = NSCdom::CDOmPathDecl::PATH_DECL_EDGE;
    else
      if(readType == "stateIfSimple") //state dependent path declaration = if(...) simple path declaration
        type = NSCdom::CDOmPathDecl::PATH_DECL_SIMPLE_IF;
      else
        if(readType == "stateIfEdge") //state dependent path declaration = if(...) edge path declaration
          type = NSCdom::CDOmPathDecl::PATH_DECL_EDGE_IF;
        else
          if(readType == "stateIfNone")//state dependent path declaration = ifnone simple path declaration
            type = NSCdom::CDOmPathDecl::PATH_DECL_SIMPLE_IFNONE;
          else {
            ostringstream message;
            message << "Expecting tokens: simple, edge, stateIfSimple, stateIfEdge or stateIfnone , found: ";
            message << readType << endl;
            throw new CTestExceptionSyntaxErr("Operator>>(std::istream &, NSCdom::CDOmPathDecl::EPathDeclType &) throw(CTestExceptionSyntaxErr*);", message.str());
          }
}

// ---------------------------------------------
// |                CTestBase                  |
// ---------------------------------------------
CTestBase::CTestBase() {}

void CTestBase::outputTestInvalid(unsigned int i, char *buff) {
    cout << TEST_INVALID << buff << endl;
}

void CTestBase::outputTestFailed(unsigned int i, char *buff) {
    cout << TEST_FAIL << buff << endl;
}

void CTestBase::outputTestPassed(unsigned int i, char *buff) {
    cout << TEST_OK << endl;
}

void CTestBase::outputTestReport(unsigned int i, unsigned int ok, unsigned int badTests, unsigned int bug) {
    cout << TEST_NO;
    cout << " / " << TEST_NO_CHECK;
    cout << " / " << TEST_NO_INVALID;
    cout << " / " << TEST_NO_FAILED << endl;
    /*if(ok)
        cout << '/' << TEST_NO_CHECK;
    if(badTests)
        cout << '/' << TEST_NO_INVALID;
    if(bug)
        cout << '/' << TEST_NO_FAILED;
    cout << endl;
*/
    cout << i;
    cout << " / " << ok 
         << " / " << badTests 
         << " / " << bug << endl;
    
/*    if(ok)
        cout << '/' << ok;
    if(badTests)
        cout << '/' << badTests;
    if(bug)
        cout << '/' << bug;
    cout << endl;*/
}

void CTestBase::outputTestAll(unsigned int i, char *buff) {
    cout << TEST_EXEC << '[' << i << ']';
    if(ALLOUT)
        cout  << buff;
}

void CTestBase::test(char* in) {
    cout << "Test name : " << this->getTestName() << endl;
    cout << "Testing class : " << this->getClassToTest() << endl;
    cout << "Test class : " << this->getClassName() << endl;

    if(in == NULL) //if there is no needed special input file, switching to default
        in=this->getDefaultInputFile();

    ifstream fin(in); //opening the input file

    if(fin == NULL) {
        cout << "Can't open the input test file" << endl;
        exit(FINISH_NOTESTFILE);
    }
    unsigned int badTests = 0; // number of invalid tests
    unsigned int i=0; //total number of test
    unsigned int ok = 0; //number of passed tests
    unsigned int bug = 0; //number of tests witch didn't pass

    while(true) {
        char c, buff[MAX_BUFF_SIZE];

        fin.getline(buff,MAX_BUFF_SIZE); //buffered reading from file, line by line
        if( fin.eof() ) //checking to reach end of file
            break;
        istringstream buffin(buff);


        if( (buffin >> c) == 0)
            continue; //empty line, ignoring

        if( c == '#' )
            continue; //comment. ignoring

        i++; //else this is a test

        outputTestAll(i,buff); //default output for all tests

        while( c != '(') { //skipping the test Name, if there is one
            c = buffin.get();
            //    cout << c;
        }
        buffin.putback(c);

        try{
            this->readInputData(buffin); //here the input test data is read from the stream by the overrided function
        } catch(CTestExceptionInvalid * e) {
            badTests++;
            outputTestInvalid(i,buff);
            cout << e->toString() << endl;
            continue;
        }
        catch(CTestExceptionFailed *e) {
            bug++;
            outputTestFailed(i,buff);
            cout << e->toString() << endl;
            continue;
        }

        //In this part it is verified the what is left of the line to be valid
        char s1 = '/', s2 = '/'; //it only is permited to write comments after the test only in this style
        buffin >> s1 >> s2;
        if( s1 != '/' || s2 != '/' ) {
            badTests++;
            outputTestInvalid(i,buff);
            continue;
        }

        ok++;
        outputTestPassed(i,buff);
    }

    //Report the test results
    cout << TEST_END << this->getTestName() << endl;
    outputTestReport(i, ok, badTests, bug);

    //Exiting the program with the finish status
    if(bug == 0)
        exit(badTests?FINISH_OK_W:FINISH_OK);
    else
        exit(badTests?FINISH_BUG_W:FINISH_BUG_W);

} // end of test function in class CTestBase
/*
RefCOmElement CTestBase::getElement( istream &in, RefCOmModule module) {
    RefCOmElement element;
    string type;
    in >> type;
    if( type == "COmGate") {
        CTestGate inElement;
        inElement.readInputData(in, module);
        element = inElement.getValue();
    } else if( type == "COmParam") {
        CTestParam inElement;
        inElement.readInputData(in, module);
        element = inElement.getValue();
    } else if( type == "COmContAssign") {
        CTestContAssign inElement;
        inElement.readInputData(in, module);
        element = inElement.getValue();
    } else if( type == "COmProcess") {
        CTestProcess inElement;
        inElement.readInputData(in, module);
        element = inElement.getValue();
    } else if( type == "COmFunction") {
        CTestFunction inElement;
        inElement.readInputData(in, module);
        element = inElement.getValue();
    } else if( type == "COmTask") {
        CTestTask inElement;
        inElement.readInputData(in, module);
        element = inElement.getValue();
    } else
        throw new CTestExceptionInvalid("CTestBase::getElement( istream &, RefCOmModule)","Unknown type: " + type);
        

    return element;
}

RefCOmIOList CTestBase::getIOList( istream &in) {
    RefCOmIOList ioList;
    string type;
    in >> type;
    
    if( type == "COmModule") {
        CTestModule inIOList;
        inIOList.readInputData(in);
        ioList = inIOList.getValue();
    } else if( type == "COmGate") {
        CTestGate inIOList;
        inIOList.readInputData(in);
        ioList = inIOList.getValue();
    } else if( type == "COmProcess") {
        CTestProcess inIOList;
        inIOList.readInputData(in);
        ioList = inIOList.getValue();
    } else if( type == "COmFunction") {
        CTestFunction inIOList;
        inIOList.readInputData(in);
        ioList = inIOList.getValue();
    } else if( type == "COmTask") {
        CTestTask inIOList;
        inIOList.readInputData(in);
        ioList = inIOList.getValue();
    } else
        throw new CTestExceptionInvalid("CTestBase::getIOList( istream &)", "Unknown type: " + type);

    return ioList;
}
RefCOmStmt CTestBase::getStmt(istream &in) {
    RefCOmStmt stmt;
    string type;
    in >> type;
    if(type == "COmStmtAssn") {
        CTestStmtAssn inStmt;
        inStmt.readInputData(in);
        stmt = inStmt.getValue();
    } else if( type == "COmStmtIfElse") {
        CTestStmtIfElse inStmt;
        inStmt.readInputData(in);
        stmt = inStmt.getValue();
    } else if( type == "COmStmtLoop") {
        CTestStmtLoop inStmt;
        inStmt.readInputData(in);
        stmt = inStmt.getValue();
    } else if( type == "COmStmtCase") {
        CTestStmtCase inStmt;
        inStmt.readInputData(in);
        stmt = inStmt.getValue();
    } else
        throw new CTestExceptionInvalid("CTestBase::getStmt(istream &)", "Unknown type: " + type);

    return stmt;
}

RefCOmSignal CTestBase::getSignal(istream &in, RefCOmIOList iolist) {
    RefCOmSignal sig;
    string type;
    in >> type;
    if(type == "COmSignalPort") {
        CTestSignalPort inSig;
        inSig.readInputData(in, iolist);
        sig = inSig.getValue();
    } else if( type == "COmSignalSingleton") {
        CTestSignalSingleton inSig;
        inSig.readInputData(in, iolist);
        sig = inSig.getValue();
    } else
        throw new CTestExceptionInvalid("CTestBase::getSignal(istream &, RefCOmIOList)", "Unknown type: " + type);

    return sig;
}

RefCOmExpr CTestBase::getExpr(istream & in) {
    RefCOmExpr expr;
    string type;
    in >> type;
    if( type == "COmSignalPort") {
        CTestSignalPort inExpr;
        inExpr.readInputData(in);
        expr = inExpr.getValue();
    } else if (type == "COmSignalSingleton") {
        CTestSignalSingleton inExpr;
        inExpr.readInputData(in);
        expr = inExpr.getValue();
    } else if (type == "COmExprOp") {
        CTestExprOp inExpr;
        inExpr.readInputData(in);
        expr = inExpr.getValue();
    } else if (type == "COmExprValInt") {
        CTestExprValInt inExpr;
        inExpr.readInputData(in);
        expr = inExpr.getValue();
    } else if (type == "COmExprValReal") {
        CTestExprValReal inExpr;
        inExpr.readInputData(in);
        expr = inExpr.getValue();
    } else if( type == "COmParam") {
        CTestParam inExpr;
        inExpr.readInputData(in);
        expr = inExpr.getValue();
    } else
        throw new CTestExceptionInvalid("CTestBase::getExpr(istream &)","Unknown type:" + type);
    
    return expr;
    
}
*/
//end of CTestBase

// ---------------------------------------------
// |                CTestCDOmPathDecl          |
// ---------------------------------------------

CTestCDOmPathDecl::CTestCDOmPathDecl():m_check(0), m_pathDecl(0) {}
char* CTestCDOmPathDecl::getTestName() {
  return "NSCdom::CDOmPathDecl";
}
char* CTestCDOmPathDecl::getDefaultInputFile() {
  return "testFiles/testNSCdom.CDOmPathDecl.in";
}
char* CTestCDOmPathDecl::getClassToTest() { return "CDOmPathDecl"; }
char* CTestCDOmPathDecl::getClassName() { return "CTestCDOmPathDecl"; }

int CTestCDOmPathDecl::verify() { return m_check; }
void CTestCDOmPathDecl::readInputData(istream &in) throw(CTestExceptionInvalid*, CTestExceptionFailed*) {
  string place = "CTestCDOmPathDecl::readInputData(istream &)";
  char c;
  in >> c;
  m_check = 0;
  if( c != '(' ) //bad input
    throw new CTestExceptionInvalid(place, "Expected token \'(\', found: " + c );
  in >> c;
  if(c == '1' ) { //constructors building
//static RefCDOmPathDecl build(
//  RefCDOmSpecifyBlock   parent,
//  EPathDeclType         type,
//  RefCDOmBase           specInptTermDesc,
//  RefCDOmBase           specOutTermDesc,
//  RefCDOmPathDelayValue pathDelayValue,
//  EPathDeclPolarityOp   polOp          = PATH_DECL_NOOP,
//  EPathDeclEdgeIdenfier edge           = PATH_DECL_NOEDGE,
//  RefCDOmExpr           dataSourceExpr = RefCDOmExpr(0),
//  RefCDOmExpr           modulePathExpr = RefCDOmExpr(0)
//);
//    TODO: find a possibility to read those vars from a file!
    RefCDOmSpecifyBlock   parent;//this is a: typedef NSRefCount::RefCount<CDOmSpecifyBlock>  RefCDOmSpecifyBlock;
    
    string moduleName ="mymodule";//name of the parent's parent ( name of the module )
    const RefString* name = new RefString(&moduleName);//It is: typedef NSRefCount::RefCount<std::string> RefString;
    CDOmModuleDecl::EKeywordType keywordType = CDOmModuleDecl::KEYWORD_MODULE ; //supposing that this is a module for the sake of simplicity
    RefCDOmDesign design = CDOmDesign::build();
    unsigned long int lineNumber;
    RefCDOmModuleDecl parentsparent = design->buildModuleDecl( lineNumber, *name, keywordType);
    parent = CDOmSpecifyBlock::build( lineNumber, parentsparent );
    
    CDOmPathDecl::EPathDeclType         type;//is needed to be read from input file (istream &in)
    in >> type;
    RefCDOmBase                         specInptTermDesc; //is needed to be read from input file (istream &in)
//    in >> specInptTermDesc;
    RefCDOmBase                         specOutTermDesc;//is needed to be read from input file (istream &in)
//    in >> specOutTermDesc;
    RefCDOmPathDelayValue               pathDelayValue;//is needed to be read from input file (istream &in)
//    in >> pathDelayValue;
    CDOmPathDecl::EPathDeclPolarityOp   polOp;//is needed to be read from input file (istream &in)

    CDOmPathDecl::EPathDeclEdgeIdenfier edge;//is needed to be read from input file (istream &in)
    RefCDOmExpr                         dataSourceExpr;//is needed to be read from input file (istream &in)
    RefCDOmExpr                         modulePathExpr;//is needed to be read from input file (istream &in)

  }
  string invoke;
  in >> invoke;
  while( invoke != "END" ) {//methods calling

    in >> invoke;
  }
  
  in >> c;
  if( c != ')' ) //bad input
    throw new CTestExceptionInvalid(place, "Expected token \')\', found: " +c);
  
  m_check = 1;
}
/*
// ---------------------------------------------
// |                CTestBitArray              |
// ---------------------------------------------

CTestBitArray::CTestBitArray():m_check(0), m_ba(0) {}

char* CTestBitArray::getTestName() { return "CVeriNum::CBitArray"; }

char* CTestBitArray::getDefaultInputFile() { return "testFiles/testVeriNum.BitArray.in"; }
char* CTestBitArray::getClassToTest() { return "CBitArray"; }
char* CTestBitArray::getClassName() { return "CTestBitArray"; }
    
void CTestBitArray::readInputData(istream &in) throw(CTestExceptionInvalid*, CTestExceptionFailed*) {
    string place = "CTestBitArray::readInputData(istream &)";
    ostringstream message;
    char c;
    in >> c;
    this->m_check = 0;
    if( c != '(' ) { //bad input
        message << "Expected token \'(\', found : ";
        message << c;
        throw new CTestExceptionInvalid(place, message.str());
    }
    
    // These are the class members
    TUInt len;
    // Setting the default members values
    len = 0;

    in >> c;//So here we have 3 contructor types
    CTestBitArray in_ba;
    switch(c) {
        case '1'://option 1, no init params
            this->m_ba = new CVeriNum::CBitArray();
            break;
        case '2'://option 2, set len to init param
            in >> len;
            this->m_ba = new CVeriNum::CBitArray(len);
            break;
        case '3'://option 3 copy from
            in_ba.readInputData(in);
            this->m_ba = new CVeriNum::CBitArray(*in_ba.getValue());
            break;
        default:
            message << "Invalid constructor options, expecting 1, 2 or 3, found: ";
            message << c;
            throw new CTestExceptionInvalid(place, message.str());
    }

    // this little syntax should work, but it is still possible some exceptions aren't catched were thay should be
    // because of the poor c++ exception management, or there could be a problem with the syntax of the method invokation
    // if any problems should occur, contact me (eugenc)
    string invoke;
    in >> invoke;
    while(invoke != "END") {
        if (invoke == "blockSize") { //this is static method that is tested
            int blksize;
            in >> blksize;
            if( blksize != CVeriNum::CBitArray::blockSize() ) {
                message << "in blockSize, blocksize didn't match : " << blksize << " with returned : " << CVeriNum::CBitArray::blockSize();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if( invoke == "bitPos" ) {//this also is a static method test
            int bitIndex, blkNum, blkOffset, retNum, retOffset;
            in >> bitIndex >> retNum >> retOffset;
            CVeriNum::CBitArray::bitPos(bitIndex, blkNum, blkOffset);
            if(retNum != blkNum) {
                message << "in bitPos, blkNum didn't match : " << retNum << " with returned : " << blkNum;
                throw new CTestExceptionFailed(place, message.str());
            }
            if(retOffset != blkOffset) {
                message << "in bitPos, blkOffset didn't match" << retOffset << " with returned : " << blkOffset;
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if( invoke == "len" ) { //this is a test to a non-static method
            in >> len;
            if( this->m_ba->len() != len ) {
                message << "in len, len didn't match :" << len << " with returned : " << this->m_ba->len();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if( invoke == "bit" ) { //this is a test to a non-static method
            CVeriNum::TBit retBit;
            int index;
            // the CVeriNum::TBit >> operator may throw an exception if the input is not valid
            // it throws the unmached characted, possible chars to read are : '0' '1' 'x' 'X' 'z' 'Z'
            try{
                in >> index >> retBit; 
                //CVeriNum::CBitArray::bit may throw a VeriNumException is index is out of range
                if( retBit != this->m_ba->bit(index) ) { 
                    message << "in bit, bit with index " << index << " didn't match : " << retBit << " with returned "
                        << this->m_ba->bit(index);
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch(CTestExceptionSyntaxErr * e) {
                // the CVeriNum::TBit >> operator may throw an exception if the input is not valid
                // it throws the unmached characted, possible chars to read are : '0' '1' 'x' 'X' 'z' 'Z'
                message << "in bit, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch( VeriNumException &e ) {
                //CVeriNum::CBitArray::bit may throw a VeriNumException if index is out of range
                message << "in bit, " << e.what();
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if( invoke == "validateIndex" ) {//non-static test
            TUInt index;
            in >> index;
            //CVeriNum::CBitArray::bit may throw a VeriNumException is index is out of range
            try{
                this->m_ba->validateIndex(index);
            } catch( VeriNumException &e) {
                message << "in validateIndex, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if( invoke == "[]" ) {//non-static test of operator[]
            CVeriNum::TBit retBit;
            TInt index;
            // the CVeriNum::TBit >> operator may throw an exception if the input is not valid
            // it throws the unmached characted, possible chars to read are : '0' '1' 'x' 'X' 'z' 'Z'
            try{ 
                in >> index >> retBit; 
                //CVeriNum::CBitArray::bit may throw a VeriNumException if index is out of range
                if( (*this->m_ba)[index] != retBit ) { 
                    message << "in [], bit with index " << index << " didn't match : " << retBit << " with returned "
                        << (*this->m_ba)[index];
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch(CTestExceptionSyntaxErr * e) {
                // the CVeriNum::TBit >> operator may throw an exception if the input is not valid
                // it throws the unmached characted, possible chars to read are : '0' '1' 'x' 'X' 'z' 'Z'
                message << "in [], " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch( VeriNumException &e ) {
                //CVeriNum::CBitArray::bit may throw a VeriNumException if index is out of range
                message << "in bit" << e.what();
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if( invoke == "setLen" ) {//non-static method, non-test
            TUInt _len;
            in >> _len;
            this->m_ba->setLen(_len);
        } else if( invoke == "setBit" ) {//non-static method, non-test
            TInt index;
            CVeriNum::TBit bit;
            try{
                in >> index >> bit;
                this->m_ba->setBit(index, bit);
            } catch( VeriNumException &e ) {
                //CVeriNum::CBitArray::setBit may throw a VeriNumException if index is out of range
                message << "in setBit" << string(e.what());
                throw new CTestExceptionInvalid(place, message.str());
            } catch(CTestExceptionSyntaxErr * e) {
                // the CVeriNum::TBit >> operator may throw an exception if the input is not valid
                // it throws the unmached characted, possible chars to read are : '0' '1' 'x' 'X' 'z' 'Z'
                message << "in setBit, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if( invoke == "=" ) {//non-static operator non-test
            CTestBitArray inTest;
            inTest.readInputData(in);
            (*m_ba) = *inTest.getValue();
        } else {
            message << "Invalid method, expecting a CBitArray method or END, found: ";
            message << invoke;
            throw new CTestExceptionInvalid(place, message.str());
        }
        in >> invoke;
    }
    
    in >> c;
    if( c != ')' ) {//bad input
        message << "Expected token \')\', found : ";
        message << c;
        throw new CTestExceptionInvalid(place, message.str());
    }

    this->m_check = 1;
}

int CTestBitArray::verify() { return this->m_check; }

CVeriNum::CBitArray* CTestBitArray::getValue() { return m_ba; }
//end of CTestBitArray
*/
// ---------------------------------------------
// |                CTestVeriNum               |
// ---------------------------------------------
/*
CTestVeriNum::CTestVeriNum():m_check(0) {}

char* CTestVeriNum::getTestName() { return "CVeriNum"; }

char* CTestVeriNum::getDefaultInputFile() { return "testFiles/testVeriNum.in"; }
char* CTestVeriNum::getClassToTest() { return "CVeriNum"; }
char* CTestVeriNum::getClassName() { return "CTestVeriNum"; }
    
void CTestVeriNum::readInputData(istream &in) throw (CTestExceptionInvalid*, CTestExceptionFailed*) {
    string place = "CTestVeriNum::readInputData(istream &)";
    ostringstream message;
    char c;
    in >> c;
    this->m_check = 0;
    if( c != '(' ) { //bad input
        message << "Expected token \'(\', found ";
        message << c;
        throw new CTestExceptionInvalid(place, message.str());
    }

    in >> c;
    // there are 5 possible CVeriNum contructor invokations
    string str;
    TUInt val;
    TInt nbits = 1;
    CVeriNum::TBit bit;
    CVeriNum::TBase base;
    // the constructor is CVeriNum should be private and there should be a factory build method to create an instance
    // until this is done this code should work, but when the factory pattern is set the code will no longer compile and should be changed
    switch(c) {
        case '1'://Constructor with nu parameters
            this->m_veriNum = RefCVeriNum( new CVeriNum() );
            break;
        case '2'://Constructor with a string as a parameter
            in >> str;
            //My guess is that the input string has a special meaning for each bit
            this->m_veriNum = RefCVeriNum( new CVeriNum(str) );
            break;
        case '3'://Constructor with TUInt val and TInt nbits ar parameters
            in >> val >> nbits;
            this->m_veriNum = RefCVeriNum( new CVeriNum(val, nbits));
            break;
        case '4': //Constructor with TBit b and TInt nbits as paramters
            try{
                in >> bit;
                in >> c;
                if( c == 'y' )
                    in >> nbits;
                else if( c != 'n') {
                    message << "Invalid constructor option, expecting y or n, found : ";
                    message << c;
                    throw new CTestExceptionInvalid(place, message.str());
                }
            } catch(CTestExceptionSyntaxErr * e) {
                // the CVeriNum::TBit >> operator may throw an exception if the input is not valid
                // it throws the unmached characted, possible chars to read are : '0' '1' 'x' 'X' 'z' 'Z'
                message << "In constructor, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
            this->m_veriNum = RefCVeriNum( new CVeriNum(bit, nbits));
            break;
        case '5'://Constructor with TBase base and string str as parameters
            try{
                in >> base >> str;
            } catch( CTestExceptionSyntaxErr * e ) {
                //CVeriNum::TBase operator >> might throw an exception if the input is not correct
                //possible inputs are only BIN OCT DEC HEX, any other string will be thrown as an exception
                message << "In constructor, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
            this->m_veriNum = RefCVeriNum( new CVeriNum(base, str));
            break;
        default :
            message << "Invalid constructor option, expecting 1 2 3 or 4, found : ";
            message << c;
            throw new CTestExceptionInvalid(place, message.str());
    }
    string invoke;
    in >> invoke;
    while( invoke != "END") {
        if( invoke == "bitToChar") { //static method test
            CVeriNum::TBit bit;
            TChar retChar;
            try {
                in >> bit >> retChar;
            } catch (CTestExceptionSyntaxErr * e) {
                message << "in bitToChar, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
            if( CVeriNum::bitToChar(bit) != retChar ) {
                message << "in bitToChar, no match : " << retChar << " with returned : " << CVeriNum::bitToChar(bit);
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if( invoke == "zero" ) { //static method test
            TUInt len;
            TBool sign = FALSE;
            CVeriNum result;
            in >> len >> c;
            if( c == 'y' ){
                in >> sign;
                result = CVeriNum::zero(len, sign);
            } else if( c != 'n' ){
                message << "in static zero, bad sign option, expecting y or n, found " << c;
                throw new CTestExceptionInvalid(place, message.str());
            } else
                result = CVeriNum::zero(len);
            //testing ...
            if( result.len() != len ){
                message << "in static zero, len didn't match : " << len << " with returned : " << result.len();
                throw new CTestExceptionFailed(place, message.str());
            }
            try {
                for( int i=0; i<len; i++)
                    if( result.get(i) != CVeriNum::_0 ) {
                        message << "in static zero, bit : " << i << " didn't match : " << CVeriNum::_0 << " with returned : " 
                            << result.get(i);
                        throw new CTestExceptionFailed(place, message.str());
                    }
                if( result.hasSign() != sign ) {
                    message << "in static zero, sign didn't match : " << sign << " with returned : " << result.hasSign();
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException &e ){
                message << "in static zero, Verinum Exception : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if( invoke == "one" ) { // static method test
            TUInt len;
            TBool sign = FALSE;
            CVeriNum result;
            in >> len >> c;
            if( c == 'y' ){
                in >> sign;
                result = CVeriNum::one(len, sign);
            } else if( c != 'n' ){
                message << "in static one, bad sign option, expecting y or n, found " << c;
                throw new CTestExceptionInvalid(place, message.str());
            } else
                result = CVeriNum::one(len);
            //testing ...
            if( result.len() != len ){
                message << "in static one, len didn't match : " << len << " with returned : " << result.len();
                throw new CTestExceptionFailed(place, message.str());
            }
            try {
                if( len > 0 && result.get(0) != CVeriNum::_1 ) {
                    message << " in static one, first bit didn't match 1, it is : " << result.get(0);
                    throw new CTestExceptionFailed(place, message.str());
                }
                for( int i=1; i<len; i++)
                    if( result.get(i) != CVeriNum::_0 ) {
                        message << "in static one, bit : " << i << " didn't match : " << CVeriNum::_0 << " with returned : " 
                            << result.get(i);
                        throw new CTestExceptionFailed(place, message.str());
                    }
                if( result.hasSign() != sign ) {
                    message << "in static one, sign didn't match : " << sign << " with returned : " << result.hasSign();
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException &e ){
                message << "in static one, Verinum Exception : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if( invoke == "minusOne" ) { // static method test
            TUInt len;
            TBool sign = TRUE;
            CVeriNum result;
            in >> len >> c;
            if( c == 'y' ){
                in >> sign;
                result = CVeriNum::minusOne(len, sign);
            } else if( c != 'n' ){
                message << "in static minusOne, bad sign option, expecting y or n, found " << c;
                throw new CTestExceptionInvalid(place, message.str());
            } else
                result = CVeriNum::minusOne(len);
            //testing ...
            if( result.len() != len ){
                message << "in static minusOne, len didn't match : " << len << " with returned : " << result.len();
                throw new CTestExceptionFailed(place, message.str());
            }
            try {
                for( int i=0; i<len; i++)
                    if( result.get(i) != CVeriNum::_1 ) {
                        message << "in static minusOne, bit : " << i << " didn't match : " << CVeriNum::_1 << " with returned : " 
                            << result.get(i);
                        throw new CTestExceptionFailed(place, message.str());
                    }
                if( result.hasSign() != sign ) {
                    message << "in static minusOne, sign didn't match : " << sign << " with returned : " << result.hasSign();
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException &e ){
                message << "in static minusOne, Verinum Exception : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if( invoke == "undef" ) { // static method test
            TUInt len;
            TBool sign = FALSE;
            CVeriNum result;
            in >> len >> c;
            if( c == 'y' ){
                in >> sign;
                result = CVeriNum::undef(len, sign);
            } else if( c != 'n' ){
                message << "in static undef, bad sign option, expecting y or n, found " << c;
                throw new CTestExceptionInvalid(place, message.str());
            } else
                result = CVeriNum::undef(len);
            //testing ...
            if( result.len() != len ){
                message << "in static undef, len didn't match : " << len << " with returned : " << result.len();
                throw new CTestExceptionFailed(place, message.str());
            }
            try {
                for( int i=0; i<len; i++)
                    if( result.get(i) != CVeriNum::_X ) {
                        message << "in static undef, bit : " << i << " didn't match : " << CVeriNum::_X << " with returned : " 
                            << result.get(i);
                        throw new CTestExceptionFailed(place, message.str());
                    }
                if( result.hasSign() != sign ) {
                    message << "in static undef, sign didn't match : " << sign << " with returned : " << result.hasSign();
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException &e ){
                message << "in static undef, Verinum Exception : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isConst" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isConst() != retValue ){
                message << "in isConst, didn't match : " << retValue << " with returned : " << this->m_veriNum->isConst();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "hasSign" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->hasSign() != retValue ){
                message << "in hasSign, didn't match : " << retValue << " with returned : " << this->m_veriNum->hasSign();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isDefined" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isDefined() != retValue ){
                message << "in isDefined, didn't match : " << retValue << " with returned : " << this->m_veriNum->isDefined();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isZero" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isZero() != retValue ){
                message << "in isZero, didn't match : " << retValue << " with returned : " << this->m_veriNum->isZero();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isNeg" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isNeg() != retValue ){
                message << "in isNeg, didn't match : " << retValue << " with returned : " << this->m_veriNum->isNeg();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isEven" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isEven() != retValue ){
                message << "in isEven, didn't match : " << retValue << " with returned : " << this->m_veriNum->isEven();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isOne" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isOne() != retValue ){
                message << "in isOne, didn't match : " << retValue << " with returned : " << this->m_veriNum->isOne();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isMinusOne" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isMinusOne() != retValue ){
                message << "in isMinusOne, didn't match : " << retValue << " with returned : " << this->m_veriNum->isMinusOne();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isTwo" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isTwo() != retValue ){
                message << "in isTwo, didn't match : " << retValue << " with returned : " << this->m_veriNum->isTwo();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "isString" ) { // non-static method test
            TBool retValue;
            in >> retValue;
            if( this->m_veriNum->isString() != retValue ){
                message << "in isString, didn't match : " << retValue << " with returned : " << this->m_veriNum->isString();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "len" ) { //non-static test
            TUInt len;
            in >> len;
            if( len != this->m_veriNum->len() ) {
                message << "in len, didn't match : " << len << " with returned : " << this->m_veriNum->len();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "setWidth" ) { //non-static, non-test
            TUInt width;
            in >> width;
            this->m_veriNum->setWidth(width);
        } else if ( invoke == "get") { //non-static test
            TInt index;
            CVeriNum::TBit bit;
            try {
                in >> index >> bit;
                if ( bit != this->m_veriNum->get(index) ){
                    message << " in get, bit at index : " << index << " didn't match : " << bit 
                        << " with returned : " << this->m_veriNum->get(index);
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch (VeriNumException& e){
                message << "in get, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch (CTestExceptionSyntaxErr* e){
                message << "in get, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "set" ) { //non-static non-test
            TInt index;
            CVeriNum::TBit bit;
            try {
                in >> index >> bit;
                this->m_veriNum->set(index, bit);
            } catch (VeriNumException &e) {
                message << "in set, a VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e) {
                message << "in set, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if( invoke == "[]" ) { //non-static operator[] test
            TInt index;
            CVeriNum::TBit bit;
            try {
                in >> index >> bit;
                if ( bit != (*m_veriNum)[index] ){
                    message << " in [], bit at index : " << index << " didn't match : " << bit 
                        << " with returned : " << (*m_veriNum)[index];
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch (VeriNumException& e){
                message << "in [], VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch (CTestExceptionSyntaxErr* e){
                message << "in [], " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if( invoke == "setSign" ) { //non-static non-test
            TBool sign;
            in >> sign;
            this->m_veriNum->setSign(sign);
        } else if( invoke == "setStringFlag" ) { //non-static non-test
            TBool stringFlag;
            in >> stringFlag;
            this->m_veriNum->setSign(stringFlag);
        } else if ( invoke == "setOctet" ) { //non-static non-test
            TInt bitIndex;
            TChar ch;
            in >> bitIndex >> ch;
            try {
                this->m_veriNum->setOctet(bitIndex, ch);
            } catch (VeriNumException &e){
                message << "in setOctet, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "getOctet" ) { //non-static test
            TInt bitIndex;
            TChar ch;
            in >> bitIndex >> ch;
            try {
                if( this->m_veriNum->getOctet(bitIndex) != ch ) {
                    message << "in getOctet, octet at index : " << bitIndex << " didn't match : "
                        << ch << " with returned : " << this->m_veriNum->getOctet(bitIndex);
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch (VeriNumException &e){
                message << "in getOctet, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "asInt" ) { //non-static test
            TInt retAsInt;
            in >> retAsInt;
            if ( retAsInt != this->m_veriNum->asInt() ) {
                message << "in asInt, didn't match : " << retAsInt << " with returned : " << this->m_veriNum->asInt();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "asUInt" ) { //non-static test
            TUInt retAsUInt;
            in >> retAsUInt;
            if ( retAsUInt != this->m_veriNum->asUInt() ) {
                message << "in asUInt, didn't match : " << retAsUInt << " with returned : " << this->m_veriNum->asUInt();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "asString" ) { //non-static test
            string retAsString;
            in >> retAsString;
            try {
                if ( retAsString != this->m_veriNum->asString() ) {
                    message << "in asString, didn't match : " << retAsString << " with returned : " 
                        << this->m_veriNum->asString();
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch (VeriNumException &e) {
                message << "in asString, a VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "msb" ) { //non-static test
            CVeriNum::TBit bit;
            try {
                in >> bit;
                if ( bit != this->m_veriNum->msb() ) {
                    message << "in msb, didn't match : " << bit << " with returned : " << this->m_veriNum->msb();
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch (VeriNumException& e){
                message << "in msb, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch (CTestExceptionSyntaxErr* e){
                message << "in msb, " << *e;
                throw new CTestExceptionInvalid(place,message.str());
            }
        } else if ( invoke == "padBit" ) { //non-static test
            try {
                CVeriNum::TBit bit;
                in >> c;
                if( c == 'y' ) {
                    CVeriNum::TPadType p;
                    in >> p >> bit;
                    if( this->m_veriNum->padBit(p) != bit ) {
                        message << "in padBit, padBit didn't match : " << bit << " with returned : " 
                            << this->m_veriNum->padBit(p);
                        throw new CTestExceptionFailed(place, message.str());
                    }
                } else if( c == 'n' ) {
                    in >> bit;
                    if( this->m_veriNum->padBit() != bit ) {
                        message << "in padBit, padBit didn't match : " << bit << " with returned : " 
                            << this->m_veriNum->padBit();
                        throw new CTestExceptionFailed(place, message.str());
                    }
                } else {
                    message << "in padBit, expecting token y or n, found : " << c;
                    throw new CTestExceptionInvalid(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in padBit, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in padBit, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "safeGet" ) { //non-static test
            try {
                TUInt index;
                CVeriNum::TBit bit;
                in >> index >> c;
                if( c == 'y' ){
                    CVeriNum::TPadType pad;
                    in >> pad >> bit;
                    if( this->m_veriNum->safeGet(index, pad) != bit ) {
                        message << "in safeGet, at index : " << index << " didn't match " << bit 
                            << " with returned : " << this->m_veriNum->safeGet(index,pad);
                        throw new CTestExceptionFailed(place, message.str());
                    }
                } else if ( c == 'n' ) {
                    in >> bit;
                    if( this->m_veriNum->safeGet(index) != bit ) {
                        message << "in safeGet, at index : " << index << " didn't match " << bit 
                            << " with returned : " << this->m_veriNum->safeGet(index);
                        throw new CTestExceptionFailed(place, message.str());
                    }
                } else {
                    message << "in safeGet, expecting token y or n, found : " << c;
                    throw new CTestExceptionInvalid(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in safeGet, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in safeGet, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "logicVal" ) { //non-static test
            try {
                CVeriNum::TBit bit;
                in >> bit;
                if( this->m_veriNum->logicVal() != bit ) {
                    message << "in logicVal, logicVal didn't match : " << bit 
                        << " with returned : " << this->m_veriNum->logicVal();
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e) {
                message << "in logicVal, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e) {
                message << "in logicVal, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "inc") { //non-static non-test
            try {
                this->m_veriNum->inc();
            } catch ( VeriNumException& e) {
                message << "in inc, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "dec") { //non-static non-test
            try {
                this->m_veriNum->dec();
            } catch ( VeriNumException& e) {
                message << "in dec, VeriNumException occured : " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else { //invalid token
            message << "Invalid method, expecting a CVeriNum method or END, found: ";
            message << invoke;
            throw new CTestExceptionInvalid(place, message.str());
        }
        in >> invoke;
    }

    in >> c;
    if( c != ')' ) {//bad input
        message << "Expected token \')\', found : ";
        message << c;
        throw new CTestExceptionInvalid(place, message.str());
    }
    this->m_check = 1;
}
//end of readInputData method

int CTestVeriNum::verify() { return this->m_check; }

RefCVeriNum CTestVeriNum::getValue() { return m_veriNum; }
//end of CTestVeriNum
*/

// ---------------------------------------------
// |         CTestRogueVeriNumFunctions        |
// ---------------------------------------------
/*
char* CTestRogueVeriNumFunctions::getTestName() { return "CTestRogueVeriNumFunctions"; }
char* CTestRogueVeriNumFunctions::getDefaultInputFile() { return "testFiles/testRogueVeriNumFunctions.in"; }
char* CTestRogueVeriNumFunctions::getClassToTest() { return "VeriNum Rogue Functions"; }
char* CTestRogueVeriNumFunctions::getClassName() { return "CTestRogueVeriNumFunctions"; }
CTestRogueVeriNumFunctions::CTestRogueVeriNumFunctions() : m_check(0) { }
void CTestRogueVeriNumFunctions::readInputData( std::istream &in) throw(CTestExceptionInvalid*, CTestExceptionFailed*){
    this->m_check = 0;
    string place = "CTestRogueVeriNumFunctions::readInputData(istream &)";
    ostringstream message;
    char c;
    in >> c;
    this->m_check = 0;
    if( c != '(' ) { //bad input
        message << "Expected token \'(\', found ";
        message << c;
        throw new CTestExceptionInvalid(place, message.str());
    }

    //this should be the method that is to execute
    string invoke;
    in >> invoke;
    
    while ( invoke != "END" ) {
        if ( invoke == "isDefined" ) {
            CVeriNum::TBit a;
            TBool retValue;
            try {
                in >> a >> retValue;
                if ( isDefined(a) != retValue ) {
                    message << "in isDefined, didn't match : " << retValue << " with returned : " << isDefined(a);
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in isDefined, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "|" ) { //operator|
            CVeriNum::TBit retValue, a, b;
            try {
                in >> a >> b >> retValue;
                if( (a|b) != retValue ) {
                    message << "in |, didn't match : " << retValue << " with returned : " << (a|b) ;
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in |, " << *e;
                throw CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "&" ) {
            CVeriNum::TBit retValue, a, b;
            try {
                in >> a >> b >> retValue;
                if( (a&b) != retValue ) {
                    message << "in &, didn't match : " << retValue << " with returned : " << (a&b) ;
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in &, " << *e;
                throw CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "^" ) {
            CVeriNum::TBit retValue, a, b;
            try {
                in >> a >> b >> retValue;
                if( (a^b) != retValue ) {
                    message << "in ^, didn't match : " << retValue << " with returned : " << (a^b) ;
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in ^, " << *e;
                throw CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "combine" ) {
            CVeriNum::TBit retValue, a, b;
            try {
                in >> a >> b >> retValue;
                if( (combine(a,b)) != retValue ) {
                    message << "in combine, didn't match : " << retValue << " with returned : " << (combine(a,b)) ;
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in combine, " << *e;
                throw CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "add" ) {
            CVeriNum::TBit retValue, a, b, carry, retCarry, sum;
            try {
                in >> a >> b >> carry >> retValue >> retCarry;
                sum = add(a, b, carry);
                if( sum != retValue ) {
                    message << "in add, sum didn't match : " << retValue << " with returned : " << sum ;
                    throw new CTestExceptionFailed(place, message.str());
                }
                if( retCarry != carry ) {
                    message << "in add, carry didn't match : " << retCarry << " with returned : " << carry ;
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in add, " << *e;
                throw CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "neg" ) {
            CVeriNum::TBit retValue, a;
            try {
                in >> a >> retValue;
                if( (neg(a)) != retValue ) {
                    message << "in neg, didn't match : " << retValue << " with returned : " << (neg(a)) ;
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in neg, " << *e;
                throw CTestExceptionInvalid(place, message.str());
            }
        //end testing TBit functions
        //start testing comparison functions
        } else if ( invoke == "equal" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( equal(*a.get(), *b.get()) != result ) {
                    message << "in equal, didn't match : " << result << " with returned : " << equal(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in equal, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in equal, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "notEqual" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( notEqual(*a.get(), *b.get()) != result ) {
                    message << "in notEqual, didn't match : " << result << " with returned : " << notEqual(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in notEqual, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in notEqual, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "caseEqual" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( caseEqual(*a.get(), *b.get()) != result ) {
                    message << "in caseEqual, didn't match : " << result << " with returned : " << caseEqual(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in caseEqual, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in caseEqual, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "caseNotEqual" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( caseNotEqual(*a.get(), *b.get()) != result ) {
                    message << "in caseNotEqual, didn't match : " << result << " with returned : " << caseNotEqual(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in caseNotEqual, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in caseNotEqual, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "lessOrEqual" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( lessOrEqual(*a.get(), *b.get()) != result ) {
                    message << "in lessOrEqual, didn't match : " << result << " with returned : " << lessOrEqual(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in lessOrEqual, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in lessOrEqual, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "lessThan" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( lessThan(*a.get(), *b.get()) != result ) {
                    message << "in lessThan, didn't match : " << result << " with returned : " << lessThan(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in lessThan, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in lessThan, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "greaterOrEqual" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( greaterOrEqual(*a.get(), *b.get()) != result ) {
                    message << "in greaterOrEqual, didn't match : " << result << " with returned : " << greaterOrEqual(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in greaterOrEqual, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in greaterOrEqual, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "greaterThan" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( greaterThan(*a.get(), *b.get()) != result ) {
                    message << "in greaterThan, didn't match : " << result << " with returned : " << greaterThan(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in greaterThan, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in greaterThan, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        //end testing comparison functions
        //start testing shift functions
        } else if ( invoke == "shiftLeft" ) {
            RefCVeriNum a, result;
            TUInt n;
            try {
                in >> a >> n >> result;
                if( equal(*result.get(), shiftLeft(*a.get(), n)) != CVeriNum::_1  ) {
                    message << "in shiftLeft, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << shiftLeft(*a.get(), n);
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in shiftLeft, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "shiftRight" ) {
            RefCVeriNum a, result;
            TUInt n;
            try {
                in >> a >> n >> result;
                if( equal(*result.get(), shiftRight(*a.get(), n)) != CVeriNum::_1  ) {
                    message << "in shiftRight, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << shiftRight(*a.get(), n);
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in shiftRight, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "shiftRightArith" ) {
            RefCVeriNum a, result;
            TUInt n;
            try {
                in >> a >> n >> result;
                if( equal(*result.get(), shiftRightArith(*a.get(), n)) != CVeriNum::_1  ) {
                    message << "in shiftRightArith, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << shiftRightArith(*a.get(), n);
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in shiftRightArith, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        //end testing shift functions
        //starting bitwise tests
        } else if ( invoke == "bitwiseAnd" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), bitwiseAnd(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in bitwiseAnd, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << bitwiseAnd(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in bitwiseAnd, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "bitwiseNand" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), bitwiseNand(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in bitwiseNand, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << bitwiseNand(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in bitwiseNand, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "bitwiseOr" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), bitwiseOr(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in bitwiseOr, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << bitwiseOr(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in bitwiseOr, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "bitwiseNor" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), bitwiseNor(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in bitwiseNor, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << bitwiseNor(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in bitwiseNor, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "bitwiseXor" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), bitwiseXor(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in bitwiseXor, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << bitwiseXor(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in bitwiseXor, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "bitwiseNxor" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), bitwiseNxor(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in bitwiseNxor, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << bitwiseNxor(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in bitwiseNxor, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "bitwiseNeg" ) {
            RefCVeriNum a, result;
            try {
                in >> a >> result;
                if( equal(*result.get(), bitwiseNeg(*a.get())) != CVeriNum::_1  ) {
                    message << "in bitwiseNeg, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << bitwiseNeg(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in bitwiseNeg, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        //end bitwise tests
        //start reduction tests
        } else if ( invoke == "reductionAnd" ) {
            RefCVeriNum a;
            CVeriNum::TBit result;
            try {
                in >> a >> result;
                if( result != reductionAnd(*a.get()) ) {
                    message << "in reductionAnd, didn't match : " << result << " with returned : " << reductionAnd(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in reductionAnd, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in reductionAnd, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "reductionNand" ) {
            RefCVeriNum a;
            CVeriNum::TBit result;
            try {
                in >> a >> result;
                if( result != reductionNand(*a.get()) ) {
                    message << "in reductionNand, didn't match : " << result << " with returned : " << reductionNand(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in reductionNand, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in reductionNand, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "reductionOr" ) {
            RefCVeriNum a;
            CVeriNum::TBit result;
            try {
                in >> a >> result;
                if( result != reductionOr(*a.get()) ) {
                    message << "in reductionOr, didn't match : " << result << " with returned : " << reductionOr(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in reductionOr, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in reductionOr, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "reductionNor" ) {
            RefCVeriNum a;
            CVeriNum::TBit result;
            try {
                in >> a >> result;
                if( result != reductionNor(*a.get()) ) {
                    message << "in reductionNor, didn't match : " << result << " with returned : " << reductionNor(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in reductionNor, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in reductionNor, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "reductionXor" ) {
            RefCVeriNum a;
            CVeriNum::TBit result;
            try {
                in >> a >> result;
                if( result != reductionXor(*a.get()) ) {
                    message << "in reductionXor, didn't match : " << result << " with returned : " << reductionXor(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in reductionXor, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in reductionXor, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        } else if ( invoke == "reductionNxor" ) {
            RefCVeriNum a;
            CVeriNum::TBit result;
            try {
                in >> a >> result;
                if( result != reductionNxor(*a.get()) ) {
                    message << "in reductionNxor, didn't match : " << result << " with returned : " << reductionNxor(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in reductionNxor, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in reductionNxor, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            }
        //end reduction tests
        //start logical tests
        } else if ( invoke == "logicalAnd" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( logicalAnd(*a.get(), *b.get()) != result ) {
                    message << "in logicalAnd, didn't match : " << result << " with returned : " << logicalAnd(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in logicalAnd, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in logicalAnd, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "logicalOr" ) {
            RefCVeriNum a,b;
            CVeriNum::TBit result;
            try {
                in >> a >> b >> result;
                if ( logicalOr(*a.get(), *b.get()) != result ) {
                    message << "in logicalOr, didn't match : " << result << " with returned : " << logicalOr(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in logicalOr, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in logicalOr, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "logicalNeg" ) {
            RefCVeriNum a;
            CVeriNum::TBit result;
            try {
                in >> a >> result;
                if ( logicalNeg(*a.get()) != result ) {
                    message << "in logicalNeg, didn't match : " << result << " with returned : " << logicalNeg(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( CTestExceptionSyntaxErr* e ) {
                message << "in logicalNeg, " << *e;
                throw new CTestExceptionInvalid(place, message.str());
            } catch ( VeriNumException& e ) {
                message << "in logicalNeg, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        //end logical tests
        //start the rest of the function tests
        } else if ( invoke == "combine" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), combine(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in combine, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << combine(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in combine, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "concat" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), concat(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in concat, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << concat(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in concat, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "add" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), add(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in add, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << add(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in add, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "sub" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), sub(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in sub, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << sub(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in sub, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "multiply" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), multiply(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in multiply, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << multiply(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in multiply, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "power" ) {
            RefCVeriNum a, b, result;
            try {
                in >> a >> b >> result;
                if( equal(*result.get(), power(*a.get(), *b.get())) != CVeriNum::_1  ) {
                    message << "in power, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << power(*a.get(), *b.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in power, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "abs" ) {
            RefCVeriNum a, result;
            try {
                in >> a >> result;
                if( equal(*result.get(), abs(*a.get())) != CVeriNum::_1  ) {
                    message << "in abs, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << abs(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in abs, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "minus" ) {
            RefCVeriNum a, result;
            try {
                in >> a >> result;
                if( equal(*result.get(), NSCdom::minus(*a.get())) != CVeriNum::_1  ) {
                    message << "in minus, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << NSCdom::minus(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in minus, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "twosComplement" ) {
            RefCVeriNum a, result;
            try {
                in >> a >> result;
                if( equal(*result.get(), twosComplement(*a.get())) != CVeriNum::_1  ) {
                    message << "in twosComplement, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << twosComplement(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in twosComplement, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "div2" ) {
            RefCVeriNum a, result;
            try {
                in >> a >> result;
                if( equal(*result.get(), div2(*a.get())) != CVeriNum::_1  ) {
                    message << "in div2, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << div2(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in div2, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "log2" ) {
            RefCVeriNum a, result;
            try {
                in >> a >> result;
                if( equal(*result.get(), log2(*a.get())) != CVeriNum::_1  ) {
                    message << "in log2, didn't match : " << endl << *result.get() << endl 
                        << "------------------ with returned : ----------------" << endl << log2(*a.get());
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in log2, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "divide" ) {
            CVeriNum quotient, remainder;
            RefCVeriNum a, b, retQuotient, retRemainder;
            try {
                in >> a >> b >> retQuotient >> retRemainder;
                divide(*a.get(), *b.get(), quotient, remainder);
                if ( equal(*retQuotient.get(), quotient) != CVeriNum::_1 ) {
                    message << "in divide, quotient didn't match : " << *retQuotient.get() << endl
                        << "------------------ with returned : ----------------" << endl << quotient;
                    throw new CTestExceptionFailed(place, message.str());
                }
                if ( equal(*retRemainder.get(), remainder) != CVeriNum::_1 ) {
                    message << "in divide, remainder didn't match : " << *retRemainder.get() << endl
                        << "------------------ with returned : ----------------" << endl << remainder;
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in divide, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        } else if ( invoke == "signed_divide" ) {
            CVeriNum quotient, remainder;
            RefCVeriNum a, b, retQuotient, retRemainder;
            try {
                in >> a >> b >> retQuotient >> retRemainder;
                signed_divide(*a.get(), *b.get(), quotient, remainder);
                if ( equal(*retQuotient.get(), quotient) != CVeriNum::_1 ) {
                    message << "in signed_divide, quotient didn't match : " << *retQuotient.get() << endl
                        << "------------------ with returned : ----------------" << endl << quotient;
                    throw new CTestExceptionFailed(place, message.str());
                }
                if ( equal(*retRemainder.get(), remainder) != CVeriNum::_1 ) {
                    message << "in signed_divide, remainder didn't match : " << *retRemainder.get() << endl
                        << "------------------ with returned : ----------------" << endl << remainder;
                    throw new CTestExceptionFailed(place, message.str());
                }
            } catch ( VeriNumException& e ) {
                message << "in signed_divide, " << e.what();
                throw new CTestExceptionFailed(place, message.str());
            }
        //end the rest of the function tests
        } else {
            message << "Invalid method, expecting a VeriNum rogue method or END, found: ";
            message << invoke;
            throw new CTestExceptionInvalid(place, message.str());
        }
        in >> invoke;
    }

    in >> c;
    if( c != ')' ) { //bad input
        message << "Expected token \')\', found ";
        message << c;
        throw new CTestExceptionInvalid(place, message.str());
    }

    this->m_check = 1;
}
int CTestRogueVeriNumFunctions::verify() { return this->m_check; }
*/    
/*
// ---------------------------------------------
// |                CTestBitRange              |
// ---------------------------------------------

CTestBitRange::CTestBitRange():m_check(0) {}

char* CTestBitRange::getTestName() { return "COmBitRange"; }

char* CTestBitRange::getDefaultInputFile() { return "testFiles/testBitRange.in"; }

void CTestBitRange::readInputData(istream &in) {
    string place = "CTestBitRange::readInputData(istream &)";
    char c;
    in >> c;
    this->m_check = 0;
    if( c != '(' ) { //bad input
        string message = "Expected token \'(\', found ";
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    
    RefCOmExpr lowerExpr, upperExpr;

    lowerExpr = this->getExpr(in);

    upperExpr = this->getExpr(in);

    this->m_br = COmBitRange::build(upperExpr, lowerExpr);

    int retWidth;
    in >> retWidth;
    
    in >> c;
    if( c != ')' ) {//bad input
        string message = "Expected token \')\', found ";
        message += c;
        throw new CTestExceptionInvalid(place, message);
    }

    if( this->m_br->getOmType() != BASE_BITRANGE ||\
        this->m_br->getLowerExpr() != lowerExpr ||\
        this->m_br->getUpperExpr() != upperExpr ||\
        this->m_br->getWidth() != retWidth\
      ) {
        throw new CTestExceptionFailed(place);
    }

    
    this->m_check = 1;
}

int CTestBitRange::verify() { return this->m_check; }

RefCOmBitRange CTestBitRange::getValue() { return m_br; }
//end of CTestBitRange

// ---------------------------------------------
// |             CTestSignalPort               |
// ---------------------------------------------
CTestSignalPort::CTestSignalPort():m_check(0) {}

char* CTestSignalPort::getTestName() { return "COmSignalPort"; }

char* CTestSignalPort::getDefaultInputFile() { return "testFiles/testSignalPort.in"; }

void CTestSignalPort::readInputData(istream &in) {
    this->readInputData(in, RefCOmIOList());
}

void CTestSignalPort::readInputData(istream &in, RefCOmIOList iolist) {
    string place = "CTestSignalPort::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    
    bool isSigned = false;
    string name;
    EOmPortDir dir = PORT_DIR_UNDEF;
    EOmCslPort cslPortType = CSL_PORT_DECLARED;
    EOmSignal sigType;
    RefCOmBitRange br;
    int _sigType, _cslPortType, _dir;
    
    in >> c >> _sigType >> name;
    if(_sigType < 0 | _sigType >= signalSize)
        throw new CTestExceptionInvalid(place,"Bad signal type");
    sigType = ltabSignal[_sigType];

    if( !iolist.get())
        iolist = this->getIOList(in);

    if (c == '1') {
        this->m_sigPort = COmSignalPort::build(sigType, iolist, name); //aici pica testul de la COmProcess
    } else if (c == '2') {
        CTestBitRange inBr;
        inBr.readInputData(in);
        br = inBr.getValue();
        this->m_sigPort = COmSignalPort::build(sigType, iolist, name, br);
    } else if (c == '3') {
        CTestBitRange inBr;
        inBr.readInputData(in);
        br = inBr.getValue();
        in >> _dir;
        if(_dir < 0 || _dir >= portDirSize)
            throw new CTestExceptionInvalid(place,"Bad dir type");
        dir = ltabPortDir[_dir];
        this->m_sigPort = COmSignalPort::build(sigType, iolist, name, br, dir);
    } else if (c == '4') {
        CTestBitRange inBr;
        inBr.readInputData(in);
        br = inBr.getValue();
        in >> _dir >> isSigned;
        if(_dir < 0 || _dir >= portDirSize)
            throw new CTestExceptionInvalid(place,"Bad dir type");
        dir = ltabPortDir[_dir];
        this->m_sigPort = COmSignalPort::build(sigType, iolist, name, br, dir, isSigned);
    } else if (c == '5') {
        CTestBitRange inBr;
        inBr.readInputData(in);
        br = inBr.getValue();
        in >> _dir >> isSigned >> _cslPortType;
        if(_dir < 0 || _dir >= portDirSize || _cslPortType < 0 || _cslPortType >= cslPortSize)
            throw new CTestExceptionInvalid(place,"Bad dir type or cslPort type");
        dir = ltabPortDir[_dir];
        cslPortType = ltabCslPort[_cslPortType];
        this->m_sigPort = COmSignalPort::build(sigType, iolist, name, br, dir, isSigned, cslPortType);
    } else {
        throw new CTestExceptionInvalid(place,"Bad parameter, not 1 2 3 4 or 5");
    }

    //Here comes additional options ;)
    // 0 - no additional options ( yeah, you wish )
    // 1 - setDir
    // 2 - setSign
    // 3 - both

    in >> c;
    if(c == '0') {
        //nothing to do here
    } else if (c == '1') {
        in >> _dir;
        if(_dir < 0 || _dir >= portDirSize)
            throw new CTestExceptionInvalid(place,"Bad dir type");
        dir = ltabPortDir[_dir];
        this->m_sigPort->setDir(dir);
    } else if (c == '2') {
        in >> isSigned;
        this->m_sigPort->setSigned(isSigned);
    } else if(c == '3') {
        in >> _dir;
        dir = ltabPortDir[_dir];
        if(_dir < 0 || _dir >= portDirSize)
            throw new CTestExceptionInvalid(place,"Bad dir type");
        this->m_sigPort->setDir(dir);
        in >> isSigned;
        this->m_sigPort->setSigned(isSigned);
    } else {
        throw new CTestExceptionInvalid(place,"Bad second parameter, not 1 2 or 3");
    }
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message+=c;
        throw new CTestExceptionInvalid(place, message);
    }

    if( br != this->m_sigPort->getBitRange() || \
        this->m_sigPort->getSignalType() != sigType || \
        this->m_sigPort->getIOList() != iolist || \
        this->m_sigPort->getOmType() != BASE_PORT || \
        this->m_sigPort->getDir() != dir || \
        this->m_sigPort->isSigned() != isSigned || \
        *this->m_sigPort->getName() != name || \
        this->m_sigPort->getCslPortType() != cslPortType \
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    
    this->m_check = 1;
}

int CTestSignalPort::verify() { return this->m_check; }

RefCOmSignalPort CTestSignalPort::getValue() { return m_sigPort; }
//end of CTestSignalPort

// ---------------------------------------------
// |        CTestSignalSingleton               |
// ---------------------------------------------
CTestSignalSingleton::CTestSignalSingleton():m_check(0) {}

char* CTestSignalSingleton::getTestName() { return "COmSignalSingleton"; }

char* CTestSignalSingleton::getDefaultInputFile() { return "testFiles/testSignalSingleton.in"; }

void CTestSignalSingleton::readInputData(istream &in) {
    this->readInputData(in, RefCOmIOList());
}

void CTestSignalSingleton::readInputData(istream &in, RefCOmIOList iolist) {
    string place = "CTestSignalSingleton::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    
    bool isSigned = false;
    string name;
    EOmSignal sigType;
    RefCOmBitRange br;
    int _sigType;
    
    in >> c >> _sigType >> name;
    if(_sigType < 0 | _sigType >= signalSize)
        throw new CTestExceptionInvalid(place, "Bad signal type");
    sigType = ltabSignal[_sigType];

    if( !iolist.get()) {
        iolist = this->getIOList(in);
    }

    if (c == '1') {
        this->m_sigSingleton = COmSignalSingleton::build(sigType, iolist, name);
    } else if (c == '2') {
        CTestBitRange inBr;
        inBr.readInputData(in);
        br = inBr.getValue();
        this->m_sigSingleton = COmSignalSingleton::build(sigType, iolist, name, br);
    } else {
        string message = "Expected parameter 1 or 2, found ";
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( br != this->m_sigSingleton->getBitRange() || \
        this->m_sigSingleton->getSignalType() != sigType || \
        this->m_sigSingleton->getIOList() != iolist || \
        this->m_sigSingleton->getOmType() != BASE_EXPR_SIGNAL || \
        *this->m_sigSingleton->getName() != name
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    
    this->m_check = 1;
}

int CTestSignalSingleton::verify() { return this->m_check; }

RefCOmSignalSingleton CTestSignalSingleton::getValue() { return m_sigSingleton; }
//end of CTestSignalSingleton

// ---------------------------------------------
// |               CTestEvent                  |
// ---------------------------------------------
CTestEvent::CTestEvent():m_check(0) {}

char* CTestEvent::getTestName() { return "COmEvent"; }

char* CTestEvent::getDefaultInputFile() { return "testFiles/testEvent.in"; }

void CTestEvent::readInputData(istream &in) {
    string place = "CTestEvent::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    EOmEvent evType;
    RefCOmExpr expr;
    int _evType, _exprType;
    in >> _evType;

    expr = this->getExpr(in);
    
    if(_evType < 0 || _evType >= eventSize)
        throw new CTestExceptionInvalid(place, "Bad Event Type" );
    evType = ltabEvent[_evType];

    this->m_event = COmEvent::build(evType, expr);

    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }


    if( this->m_event->getEventType() != evType || \
        this->m_event->getExpr() != expr || \
        this->m_event->getOmType() != BASE_EXPR_EVENT \
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }
    
    this->m_check = 1;
    
}

int CTestEvent::verify() { return this->m_check; }

RefCOmEvent CTestEvent::getValue() { return m_event; }
//end of CTestEvent

// ---------------------------------------------
// |               CTestExprValInt             |
// ---------------------------------------------
CTestExprValInt::CTestExprValInt():m_check(0) {}

char* CTestExprValInt::getTestName() { return "COmExprValInt"; }

char* CTestExprValInt::getDefaultInputFile() { return "testFiles/testExprValInt.in"; }

void CTestExprValInt::readInputData(istream &in) {
    string place = "CTestExprValInt::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    string numStr;
    TBool retIsConst;
    TInt retValue;
    EOmNumberBase base;
    TUInt size;
    int _base;

    in >> numStr >> _base >> size >> retValue >> retIsConst;

    if( _base < 0 || _base >= numberBaseSize )
        throw new CTestExceptionInvalid(place, "Bad Base Type");
    base = ltabNumberBase[_base];

    
    this->m_exprValInt = COmExprValInt::build(numStr, base, size);

    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( this->m_exprValInt->getSize() != size || \
        this->m_exprValInt->getBaseType() != base || \
        this->m_exprValInt->getVal() != retValue || \
        this->m_exprValInt->isConst() != retIsConst || \
        *this->m_exprValInt->getNumStr() != numStr  \
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    
    this->m_check = 1;
    
}

int CTestExprValInt::verify() { return this->m_check; }

RefCOmExprValInt CTestExprValInt::getValue() { return m_exprValInt; }
//end of CTestExprValInt


// ---------------------------------------------
// |               CTestExprValReal             |
// ---------------------------------------------
CTestExprValReal::CTestExprValReal():m_check(0) {}

char* CTestExprValReal::getTestName() { return "COmExprValReal"; }

char* CTestExprValReal::getDefaultInputFile() { return "testFiles/testExprValReal.in"; }

void CTestExprValReal::readInputData(istream &in) {
    string place = "CTestExprValReal::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    string nonExpStr, expStr = "", numStr;
    TBool retIsConst;
    TInt retNonExp, retExp;
    TDouble retVal;
    TUInt size;

    in >> c >> nonExpStr;

    if(c == '1')
        expStr = "";
    else if (c == '2')
        in >> expStr;
    else
        throw new CTestExceptionInvalid(place, "Invalid parameter");

    in >> retNonExp >> retExp >> retVal >> retIsConst;

    numStr = nonExpStr + (expStr.size() > 0 ? "E" + expStr : "");
    
    this->m_exprValReal = COmExprValReal::build(nonExpStr, expStr);

    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( *this->m_exprValReal->getNumStr() != numStr || \
        this->m_exprValReal->getNonExp() != retNonExp || \
        this->m_exprValReal->getExp() != retExp || \
        this->m_exprValReal->getVal() != retVal || \
        this->m_exprValReal->isConst() != retIsConst \
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    
    this->m_check = 1;
    
}

int CTestExprValReal::verify() { return this->m_check; }

RefCOmExprValReal CTestExprValReal::getValue() { return m_exprValReal; }
//end of CTestExprValReal

// ---------------------------------------------
// |               CTestStmtAssn             |
// ---------------------------------------------
CTestStmtAssn::CTestStmtAssn():m_check(0) {}

char* CTestStmtAssn::getTestName() { return "COmStmtAssn"; }

char* CTestStmtAssn::getDefaultInputFile() { return "testFiles/testStmtAssn.in"; }

void CTestStmtAssn::readInputData(istream &in) {
    string place = "CTestStmtAssn::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    EOmProcAssign assignType;
    RefCOmSignal sig;
    int _assignType;
    TUInt stmtAttr = 0;
    RefCOmExpr expr;

    in >> c >> _assignType;
    if(_assignType < 0 || _assignType >= procAssignSize)
        throw new CTestExceptionInvalid(place, "Bad Assign Type");
    assignType = ltabProcAssign[_assignType];

    sig = this->getSignal(in);

    expr = this->getExpr(in);
    
    if(c == '1') {
        this->m_stmtAssn = COmStmtAssn::build(assignType, sig, expr);
    } else if (c == '2') {
        in >> stmtAttr;
        this->m_stmtAssn = COmStmtAssn::build(assignType, sig, expr, stmtAttr);
    } else
        throw new CTestExceptionInvalid(place, "Invalid parameter");
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( this->m_stmtAssn->getAssignType() != assignType || \
        this->m_stmtAssn->getLhs() != sig || \
        this->m_stmtAssn->getRhs() != expr || \
        this->m_stmtAssn->getStmtAttr() != stmtAttr \
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    
    this->m_check = 1;
    
}

int CTestStmtAssn::verify() { return this->m_check; }

RefCOmStmtAssn CTestStmtAssn::getValue() { return m_stmtAssn; }
//end of CTestStmtAssn

// ---------------------------------------------
// |               CTestStmtIfElse             |
// ---------------------------------------------
CTestStmtIfElse::CTestStmtIfElse():m_check(0) {}

char* CTestStmtIfElse::getTestName() { return "COmStmtIfElse"; }

char* CTestStmtIfElse::getDefaultInputFile() { return "testFiles/testStmtIfElse.in"; }

void CTestStmtIfElse::readInputData(istream &in) {
    string place = "CTestStmtIfElse::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    TVecStmt stmtsIf, stmtsElse;
    int nrStmtsIf, nrStmtsElse;
    in >> c;
    RefCOmExpr expr;
    

    if( c == '1' ) {
        this->m_stmtIfElse = COmStmtIfElse::build();
    } else if ( c == '2' ) {
        expr = this->getExpr(in);
        this->m_stmtIfElse = COmStmtIfElse::build(expr);
    } else
        throw new CTestExceptionInvalid(place, "Invalid Parameter");

    in >> nrStmtsIf;
    for(int j = 0; j < nrStmtsIf; j++) {
        RefCOmStmt refStmt = this->getStmt(in);
        stmtsIf.push_back(refStmt);
        this->m_stmtIfElse->addStmtIf(refStmt);
    }
    
    in >> nrStmtsElse;
    for(int j = 0; j < nrStmtsElse; j++) {
        RefCOmStmt refStmt = this->getStmt(in);
        stmtsElse.push_back(refStmt);
        this->m_stmtIfElse->addStmtElse(refStmt);
    }
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( this->m_stmtIfElse->getExprCond() != expr ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    for( int j = 0; j < nrStmtsIf; j++) {
        if( this->m_stmtIfElse->getStmtIf(j) != stmtsIf[j]) {
            throw new CTestExceptionFailed(place, "TEST FAILED");
        }
    }

    for(int j=0; j < nrStmtsElse; j++) {
        if( this->m_stmtIfElse->getStmtElse(j) != stmtsElse[j]) {
            throw new CTestExceptionFailed(place, "TEST FAILED");
        }
    }


    
    this->m_check = 1;
    
}

int CTestStmtIfElse::verify() { return this->m_check; }

RefCOmStmtIfElse CTestStmtIfElse::getValue() { return m_stmtIfElse; }
//end of CTestStmtIfElse


// ---------------------------------------------
// |               CTestStmtLoop             |
// ---------------------------------------------
CTestStmtLoop::CTestStmtLoop():m_check(0) {}

char* CTestStmtLoop::getTestName() { return "COmStmtLoop"; }

char* CTestStmtLoop::getDefaultInputFile() { return "testFiles/testStmtLoop.in"; }

void CTestStmtLoop::readInputData(istream &in) {
    string place = "CTestStmtLoop::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    TVecStmt stmts;
    int nrStmts;
    in >> c;
    RefCOmExpr exprInit;
    RefCOmExpr exprCond;
    RefCOmExpr exprLoop;

    if( c == '1' ) {
        this->m_stmtLoop = COmStmtLoop::build();
    } else if ( c == '2' ) {
        exprInit = this->getExpr(in);
        this->m_stmtLoop = COmStmtLoop::build(exprInit);
    } else if ( c == '3') {
        exprInit = this->getExpr(in);
        exprCond = this->getExpr(in);
        this->m_stmtLoop = COmStmtLoop::build(exprInit,exprCond);
    } else if( c == '4' ) {
        exprInit = this->getExpr(in);
        exprCond = this->getExpr(in);
        exprLoop = this->getExpr(in);
        this->m_stmtLoop = COmStmtLoop::build(exprInit, exprCond, exprLoop);
    } else
        throw new CTestExceptionInvalid(place, "Invalid Parameter");

    in >> nrStmts;
    for(int j = 0; j < nrStmts; j++) {
        RefCOmStmt refStmt = this->getStmt(in);
        stmts.push_back(refStmt);
        this->m_stmtLoop->addStmt(refStmt);
    }
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( this->m_stmtLoop->getExprInit() != exprInit || \
        this->m_stmtLoop->getExprCond() != exprCond || \
        this->m_stmtLoop->getExprLoop() != exprLoop \
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    for( int i = 0; i<nrStmts; i++)
        if(this->m_stmtLoop->getStmt(i) != stmts[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");
    
    this->m_check = 1;
    
}

int CTestStmtLoop::verify() { return this->m_check; }

RefCOmStmtLoop CTestStmtLoop::getValue() { return m_stmtLoop; }
//end of CTestStmtLoop

// ---------------------------------------------
// |               CTestStmtCase               |
// ---------------------------------------------
CTestStmtCase::CTestStmtCase():m_check(0) {}

char* CTestStmtCase::getTestName() { return "COmStmtCase"; }

char* CTestStmtCase::getDefaultInputFile() { return "testFiles/testStmtCase.in"; }

void CTestStmtCase::readInputData(istream &in) {
    string place = "CTestStmtCase::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    TVecCaseItem caseItems;
    int nrCaseItems, _caseType;
    in >> c;
    RefCOmExpr exprSwitch;
    EOmCase caseType = CASE_CASE;

    exprSwitch = this->getExpr(in);
    
    if( c == '1' ) {
        this->m_stmtCase = COmStmtCase::build(exprSwitch);
    } else if ( c == '2' ) {
        in >> _caseType;
        if ( _caseType < 0 || _caseType >= caseSize )
            throw new CTestExceptionInvalid(place, "Bad Case Type");
        caseType = ltabCase[_caseType];
        this->m_stmtCase = COmStmtCase::build(exprSwitch, caseType);
    } else
        throw new CTestExceptionInvalid(place, "Invalid Parameter");

    in >> nrCaseItems;
    for(int j = 0; j < nrCaseItems; j++) {
        CTestCaseItem inCaseItem;
        inCaseItem.readInputData(in, this->m_stmtCase);
        RefCOmCaseItem refCaseItem = inCaseItem.getValue();
        caseItems.push_back(refCaseItem);
    }
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( this->m_stmtCase->getCaseType() != caseType || \
        this->m_stmtCase->getExprSwitch() != exprSwitch \
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    for( int i = 0; i<nrCaseItems; i++)
        if(this->m_stmtCase->getCaseItem(i) != caseItems[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");
    
    this->m_check = 1;
    
}

int CTestStmtCase::verify() { return this->m_check; }

RefCOmStmtCase CTestStmtCase::getValue() { return m_stmtCase; }
//end of CTestStmtCase

// ---------------------------------------------
// |               CTestCaseItem               |
// ---------------------------------------------
CTestCaseItem::CTestCaseItem():m_check(0) {}

char* CTestCaseItem::getTestName() { return "COmCaseItem"; }

char* CTestCaseItem::getDefaultInputFile() { return "testFiles/testCaseItem.in"; }

void CTestCaseItem::readInputData(istream &in) {
    this->readInputData(in, RefCOmStmtCase());
}

void CTestCaseItem::readInputData(istream &in, RefCOmStmtCase _parent) {
    string place = "CTestCaseItem::readInputData";
    RefCOmStmtCase parent = _parent;
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    EOmCaseItem caseItemType = CASE_ITEM_CASE;
    TVecExpr matchExprs;
    TVecStmt stmts;
    TUInt idx;
    int _caseItemType, nrMatchExpr, nrStmts;

    if( !parent.get() ) {
        CTestStmtCase inStmtCase;
        inStmtCase.readInputData(in);
        parent = inStmtCase.getValue();
    }

    in >> c;
    if( c == '1' ) {
        this->m_caseItem = COmCaseItem::build(parent);
    } else if ( c == '2' ) {
        in >> _caseItemType;
        if ( _caseItemType < 0 || _caseItemType >= caseItemSize )
            throw new CTestExceptionInvalid(place, "Bad CaseItem Type");
        caseItemType = ltabCaseItem[_caseItemType];
        this->m_caseItem = COmCaseItem::build(parent, caseItemType);
    } else
        throw new CTestExceptionInvalid(place, "Invalid Parameter");

    in >> nrMatchExpr;
    for(int i = 0; i < nrMatchExpr; i++) {
        RefCOmExpr refExpr = this->getExpr(in);
        matchExprs.push_back(refExpr);
        this->m_caseItem->addMatchExpr(refExpr);
    }

    in >> nrStmts;
    for( int i = 0; i < nrStmts; i++ ) {
        RefCOmStmt refStmt = this->getStmt(in);
        stmts.push_back(refStmt);
        this->m_caseItem->addStmt(refStmt);
    }
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( this->m_caseItem->getCaseItemType() != caseItemType || \
        this->m_caseItem->getParentStmtCase() != parent \
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    for( int i = 0; i < nrMatchExpr; i++)
        if(this->m_caseItem->getMatchExpr(i) != matchExprs[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");
    
    for( int i = 0; i<nrStmts; i++)
        if(this->m_caseItem->getStmt(i) != stmts[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");

    this->m_check = 1;
    
}

int CTestCaseItem::verify() { return this->m_check; }

RefCOmCaseItem CTestCaseItem::getValue() { return m_caseItem; }
//end of CTestCaseItem

// ---------------------------------------------
// |               CTestIOList                 |
// ---------------------------------------------
CTestIOList::CTestIOList() {
    this->m_check = 1;
}

void CTestIOList::setIOList(RefCOmIOList list) {
    this->m_check = 0;
    this->m_IOList = list;
}

int CTestIOList::readIOList(istream &in) {
    string place = "CTestIOList::readIOList";
    this->m_check = 0;
    //Here come the COmIOList items
    TVecIOList childIOLists;
    TVecPort ports;
    TMapNm2TUInt portName2index_map;
    TVecPort inputPorts, outputPorts, inoutPorts;
    TVecSignal signals;
    TMapNm2TUInt signalName2index_map;
    TVecVecTUInt fanin_to_output_ports;
    TVecVecTUInt fanout_from_input_ports;
    TVecVecSignal m_fanin_to_input_ports;
    TVecVecSignal m_fanout_from_output_ports;
    int nrSignals, nrPorts, nrChildren, nrPortDir;
    nrSignals = nrPorts = nrChildren = nrPortDir = 0;
    int nrInputPorts = 0, nrOutputPorts = 0, nrInOutPorts = 0;
    //end of COmIOList items
    char c;
    in >> c;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    
    in >> nrChildren;
    for ( int i=0; i< nrChildren; i++ ) {
        RefCOmIOList ioList;
        ioList = this->getIOList(in);
        this->m_IOList->addChildIOList(ioList);
        childIOLists.push_back(ioList);
    }
        
    in >> nrPorts;
    for( int i=0; i<nrPorts; i++ ) {
        CTestSignalPort inPort;
        inPort.readInputData(in);
        this->m_IOList->addRawPort(inPort.getValue());
        ports.push_back(inPort.getValue());
        portName2index_map.insert(make_pair(*inPort.getValue()->getName(), i));
    }

    in >> nrSignals;
    for(int i=0; i<nrSignals; i++) {
        RefCOmSignal sig;
        sig = this->getSignal(in, this->m_IOList);
        signals.push_back(sig);
        signalName2index_map.insert(make_pair(*sig->getName(), i));
    }

    in >> nrPortDir;
    for(int i=0; i<nrPortDir; i++) {
        string thisName;
        int dir;
        in >> thisName >> dir;
        if( dir < 0 || dir >= portDirSize)// bad port dir
            throw new CTestExceptionInvalid(place, "Bad Direction Type");
        RefCOmSignalPort sigPort;
        TMapNm2TUInt_const_iter iter;
        iter = portName2index_map.find(thisName);
        if( iter == portName2index_map.end())//name not found
            throw new CTestExceptionInvalid(place, thisName + " was not found ");
        TUInt index = iter->second;
        sigPort = ports[index];

        sigPort->setDir(ltabPortDir[dir]);
        
        this->m_IOList->portDirSet(sigPort);
        switch (sigPort->getDir()) {
            case PORT_DIR_INPUT:
                inputPorts.push_back(sigPort);
                nrInputPorts++;
                break;
            case PORT_DIR_OUTPUT:
                outputPorts.push_back(sigPort);
                nrOutputPorts++;
                break;
            case PORT_DIR_INOUT:
                inoutPorts.push_back(sigPort);
                nrInOutPorts++;
                break;
            default: //bad port to setDir
                throw new CTestExceptionInvalid(place, "Bad Port Direction set");
        }
    }

    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    //Start checking the COmIOList base class
    if( this->m_IOList->getNrPorts() != nrPorts || \
        this->m_IOList->getNrInputPorts() != nrInputPorts || \
        this->m_IOList->getNrOutputPorts() != nrOutputPorts || \
        this->m_IOList->getNrInOutPorts() != nrInOutPorts || \
        this->m_IOList->getNrSignals() != nrSignals \
      ) {
        cout << "check iolist failed\n";
        cout << this->m_IOList->getNrInputPorts() << " = " << nrInputPorts << endl;
//        cout << this->m_IOList->getNrOutputPorts() << " = " << nrOutputPorts << endl;
//        cout << this->m_IOList->getNrInOutPorts() << " = " << nrInOutPorts << endl;
//        cout << this->m_IOList->getNrSignals() << " = " << nrSignals << endl;
//        cout << this->m_IOList->getNrPorts() << " = " << nrPorts << endl;
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    for( int i=0; i < nrChildren; i++)
        if( this->m_IOList->getChildIOListByIdx(i) != childIOLists[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");

    for( int i = 0; i< nrPorts; i++) {
        if( this->m_IOList->getPortByIdx(i) != ports[i] )
            throw new CTestExceptionFailed(place, "TEST FAILED");
        if( this->m_IOList->getPortByName(*ports[i]->getName()) != ports[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    for( int i = 0; i<nrSignals; i++) {
        if(this->m_IOList->getSignalByIdx(i) != signals[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");
        if(this->m_IOList->getSignalByName(*signals[i]->getName()) != signals[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");
    }
    //!!!!! why isn't there a getInputPortByName method or output or inout ???
    //!!!!! why isn't there a getNrChildren method ???

    for( int i = 0; i<nrInputPorts;i++)
        if(this->m_IOList->getInputPortByIdx(i) != inputPorts[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");
    for( int i = 0; i<nrOutputPorts;i++)
        if(this->m_IOList->getOutputPortByIdx(i) != outputPorts[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");
    for( int i = 0; i<nrInOutPorts;i++)
        if(this->m_IOList->getInOutPortByIdx(i) != inoutPorts[i])
            throw new CTestExceptionFailed(place, "TEST FAILED");

    //end checking COmIOList base class
    this->m_check = 1;
    
            
}

int CTestIOList::verifyIOList() {
    return m_check;
}

//end of CTestIOList

// ---------------------------------------------
// |               CTestModule                 |
// ---------------------------------------------
CTestModule::CTestModule():m_check(0) {}

char* CTestModule::getTestName() { return "COmModule"; }

char* CTestModule::getDefaultInputFile() { return "testFiles/testModule.in"; }

void CTestModule::readInputData(istream &in) {
    this->readInputData(in, RefCOmIOList());
}

void CTestModule::readInputData(istream &in, RefCOmIOList _parent) {
    string place = "CTestModule::readInputData";
    RefCOmIOList parent = _parent;
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    string name;
    TUInt idx;
    TVecElement elements;
    TVecParam params;
    TMapNm2TUInt paramName2index_map;
    int nrParams, nrElements;
    

    if( !parent.get() ) {//no parent, in this case, the parent is no required, but if the test needs it ...
        in >> c; // test charanter if we need a parent

        if( c == 'y') {
            parent = this->getIOList(in);
        } else if (c == 'n') {
            //don't try anything stupid here
        } else {
            string message = "Expecting y or n at parent IOList test, found: ";
            message += c;
            throw new CTestExceptionInvalid(place, message);
        }
    }

    in >> name;
    if( !parent.get())
        this->m_module = COmModule::build(name);
    else
        this->m_module = COmModule::build(name, parent);


    in >> c; //starting testing for COmIOList class
    if( c == 'y') {
        this->setIOList(this->m_module);
        this->readIOList(in);
    } else if ( c == 'n' ) {
        //no ioList tests
    } else {
        string message = "Expecting y or n at COmIOList test, found: ";
        message += c;
        throw new CTestExceptionInvalid(place, message);
    }
    //the IOList test ended
    

    in >> nrParams;
    for(int i = 0; i < nrParams; i++) {
        RefCOmParam param;
        CTestParam inParam;
        inParam.readInputData(in);
        param = inParam.getValue();
        params.push_back(param);
        paramName2index_map.insert(make_pair(*param->getName(),i));
        this->m_module->addParam(param);
    }

    in >> nrElements;
    for( int i = 0; i < nrElements; i++ ) {
        elements.push_back(this->getElement(in, m_module));
    }
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( *this->m_module->getName() != name || \
        this->m_module->getNrParams() != nrParams || \
        this->m_module->getNrElements() != nrElements || \
        this->m_module->getParentIOList() != parent\
        ) {
        throw new CTestExceptionFailed(place, "TEST FAILED");
    }
    for( int i = 0; i < nrParams; i++)
        if(this->m_module->getParamByIdx(i) != params[i] || this->m_module->getParamByName(*params[i]->getName()) != params[i]) {
            string message = "Bug in getParam, at index: ";
            // TODO add index i in string form to the message 
            throw new CTestExceptionFailed(place, message);
        }
    
    // !!!!!!NO getElement(int) method in this class, why ?
    this->m_check = 1;
    
}

int CTestModule::verify() { return this->m_check; }

RefCOmModule CTestModule::getValue() { return m_module; }
//end of CTestModule

// ---------------------------------------------
// |               CTestGate                 |
// ---------------------------------------------
CTestGate::CTestGate():m_check(0) {}

char* CTestGate::getTestName() { return "COmGate"; }

char* CTestGate::getDefaultInputFile() { return "testFiles/testGate.in"; }

void CTestGate::readInputData(istream &in) {
    this->readInputData(in, RefCOmModule());
}

void CTestGate::readInputData(istream &in, RefCOmModule module) {
    string place = "CTestGate::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    string name;
    EOmGateType gateType;
    int _gateType;
    
    in >> _gateType >> name;
    if(_gateType < 0 || _gateType >= gateTypeSize)
        throw new CTestExceptionInvalid(place, "Bad Gate Type");

    gateType = ltabGateType[_gateType];
            
    //Reading the module
    if( !module.get() ) {
        CTestModule inModule;
        inModule.readInputData(in);
        module = inModule.getValue();
    }

    this->m_gate = COmGate::build(gateType, module, name);

    //set base IOList params
    in >> c;
    if( c == 'y') {
        this->setIOList(this->m_gate);
        this->readIOList(in);
    }
    else if(c == 'n') {
        //don't do anything
    } else
        throw new CTestExceptionInvalid(place, "Expecting y or n here");
        
    
    

    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if(this->m_gate->getGateType() != gateType ||\
        *this->m_gate->getName() != name ||\
        this->m_gate->getOmType() != BASE_GATE ||\
        this->m_gate->getModule() != module \
      )
        throw new CTestExceptionFailed(place, "TEST FAILED");

    this->m_check = 1;
    
}

int CTestGate::verify() { return this->m_check; }

RefCOmGate CTestGate::getValue() { return m_gate; }
//end of CTestGate

// ---------------------------------------------
// |               CTestSignalRef              |
// ---------------------------------------------
CTestSignalRef::CTestSignalRef():m_check(0) {}

char* CTestSignalRef::getTestName() { return "COmSignalRef"; }

char* CTestSignalRef::getDefaultInputFile() { return "testFiles/testSignalRef.in"; }

void CTestSignalRef::readInputData(istream &in) {
    this->readInputData(in, RefCOmModule());
}

void CTestSignalRef::readInputData(istream &in, RefCOmModule module) {
    string place = "CTestSignalRef::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    string name;
    
    in >> name;

    //Reading the module
    if( !module.get() ) {
        CTestModule inModule;
        inModule.readInputData(in);
        module = inModule.getValue();
    }

    this->m_signalRef = COmSignalRef::build(name, module);

    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if(this->m_signalRef->getSignal() != module->getSignalByName(name) ||\
        this->m_signalRef->isConst() != module->getSignalByName(name)->isConst() ||\
        this->m_signalRef->getOmType() != BASE_EXPR_SIGNALREF \
      )
        throw new CTestExceptionFailed(place, "TEST FAILED");

    this->m_check = 1;
    
}

int CTestSignalRef::verify() { return this->m_check; }

RefCOmSignalRef CTestSignalRef::getValue() { return m_signalRef; }
//end of CTestSignalRef

// ---------------------------------------------
// |               CTestExprOp                 |
// ---------------------------------------------
CTestExprOp::CTestExprOp():m_check(0) {}

char* CTestExprOp::getTestName() { return "COmExprOp"; }

char* CTestExprOp::getDefaultInputFile() { return "testFiles/testExprOp.in"; }

void CTestExprOp::readInputData(istream &in) {
    string place = "CTestExprOp::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    TVecExpr exprs;
    EOmOp op;
    int _op;
    bool evaualted, isConst;
    long retVal;
    RefCOmExpr expr;

    in >> c;
    in >> _op;
    if( _op < 0 || _op >= opSize)
        throw new CTestExceptionInvalid(place, "Bad Operator Type");
    op = ltabOp[_op];

    if( c == '1') {
        expr = this->getExpr(in);
        exprs.push_back(expr);
        this->m_exprOp = COmExprOp::build(op,exprs[0]);
    } else if( c == '2' ) {
        expr = this->getExpr(in);
        exprs.push_back(expr);
        expr = this->getExpr(in);
        exprs.push_back(expr);
        this->m_exprOp = COmExprOp::build(op, exprs[0], exprs[1]);
    } else if( c == '3' ) {
        expr = this->getExpr(in);
        exprs.push_back(expr);
        expr = this->getExpr(in);
        exprs.push_back(expr);
        expr = this->getExpr(in);
        exprs.push_back(expr);
        this->m_exprOp = COmExprOp::build(op, exprs[0], exprs[1], exprs[2]);
    } else
        throw new CTestExceptionInvalid(place, "Invalid Parameter");

    
    int nrOther;
    in >> nrOther;
    for( int i=0; i< nrOther; i++) {
        expr = this->getExpr(in);
        exprs.push_back(expr);
        this->m_exprOp->addExpr(expr);
    }
    in >> isConst;
    TLong retEvalConst;
    if( isConst )
        in >> retEvalConst;
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    if( this->m_exprOp->isConst() != isConst ||\
        this->m_exprOp->getOmType() != BASE_EXPR_OP\
      )
        throw new CTestExceptionFailed(place, "TEST FAILED");
    if( isConst && this->m_exprOp->evalConst() != retEvalConst)
        throw new CTestExceptionFailed(place, "TEST FAILED");

    this->m_check = 1;
    
}

int CTestExprOp::verify() { return this->m_check; }

RefCOmExprOp CTestExprOp::getValue() { return m_exprOp;}
//end of CTestExprOp

// ---------------------------------------------
// |               CTestParam                 |
// ---------------------------------------------
CTestParam::CTestParam():m_check(0) {}

char* CTestParam::getTestName() { return "COmParam"; }

char* CTestParam::getDefaultInputFile() { return "testFiles/testParam.in"; }

void CTestParam::readInputData(istream &in) {
    this->readInputData(in, RefCOmModule());
}

void CTestParam::readInputData(istream &in, RefCOmModule module) {
    string place = "CTestParam::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    string name;
    RefCOmExpr expr;
    EOmParamType paramType;
    RefCOmBitRange br;
    bool isSigned;
    int _paramType;

    paramType = PARAM_UNDEF;
    isSigned = false;

    if( !module.get()) {
        CTestModule inModule;
        inModule.readInputData(in);
        module = inModule.getValue();
    }

    in >> name;
    expr = this->getExpr(in);

    in >> c;
    CTestBitRange inBr;
    switch(c) {
        case '1':
            this->m_param = COmParam::build(module, name, expr);
            break;
        case '2':
            in >> _paramType;
            if( _paramType < 0 || _paramType >= paramTypeSize )
                throw new CTestExceptionInvalid(place, "Bad Param Type");
            paramType = ltabParamType[_paramType];
            this->m_param = COmParam::build(module, name, expr, paramType);
            break;
        case '3':
            in >> _paramType;
            if( _paramType < 0 || _paramType >= paramTypeSize )
                throw new CTestExceptionInvalid(place, "Bad Param Type");
            paramType = ltabParamType[_paramType];
            inBr.readInputData(in);
            br = inBr.getValue();
            this->m_param = COmParam::build(module, name, expr, paramType, br);
            break;
        case '4':
            in >> _paramType;
            if( _paramType < 0 || _paramType >= paramTypeSize )
                throw new CTestExceptionInvalid(place, "Bad Param Type");
            paramType = ltabParamType[_paramType];
            inBr.readInputData(in);
            br = inBr.getValue();
            in >> isSigned;
            this->m_param = COmParam::build(module, name, expr, paramType, br, isSigned);
            break;
        default:
            throw new CTestExceptionInvalid(place, "Invalid Parameter");
    }
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    
    if( this->m_param->getOmType() != BASE_PARAM || \
        *this->m_param->getName() != name || \
        this->m_param->getExpr() != expr || \
        this->m_param->getParamType() != paramType || \
        this->m_param->getBitRange() != br || \
        this->m_param->getModule() != module || \
        this->m_param->isSigned() != isSigned || \
        !this->m_param->isConst() \
      )

        throw new CTestExceptionFailed(place, "TEST FAILED");

    
    
    this->m_check = 1;
    
}

int CTestParam::verify() { return this->m_check; }

RefCOmParam CTestParam::getValue() { return m_param;}
//end of CTestParam

// ---------------------------------------------
// |               CTestContAssign             |
// ---------------------------------------------
CTestContAssign::CTestContAssign():m_check(0) {}

char* CTestContAssign::getTestName() { return "COmContAssign"; }

char* CTestContAssign::getDefaultInputFile() { return "testFiles/testContAssign.in"; }

void CTestContAssign::readInputData(istream &in) {
    this->readInputData(in, RefCOmModule());
}

void CTestContAssign::readInputData(istream &in, RefCOmModule module) {
    string place = "CTestContAssign::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    RefCOmSignal signalLhs;
    RefCOmExpr exprRhs;

    if( !module.get()) {
        CTestModule inModule;
        inModule.readInputData(in);
        module = inModule.getValue();
    }

    signalLhs = this->getSignal(in, module);
    exprRhs = this->getExpr(in);

    this->m_contAssign = COmContAssign::build(module, signalLhs, exprRhs);
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    
    if( this->m_contAssign->getOmType() != BASE_STMT_ASSN || \
        this->m_contAssign->getLhs() != signalLhs || \
        this->m_contAssign->getModule() != module || \
        this->m_contAssign->getRhs() != exprRhs \
      )

        throw new CTestExceptionFailed(place, "TEST FAILED");

    
    
    this->m_check = 1;
    
}

int CTestContAssign::verify() { return this->m_check; }

RefCOmContAssign CTestContAssign::getValue() { return m_contAssign;}
//end of CTestContAssign

// ---------------------------------------------
// |               CTestProcess                |
// ---------------------------------------------
CTestProcess::CTestProcess():m_check(0) {}

char* CTestProcess::getTestName() { return "COmProcess"; }

char* CTestProcess::getDefaultInputFile() { return "testFiles/testProcess.in"; }

void CTestProcess::readInputData(istream &in) {
    this->readInputData(in, RefCOmModule());
}

void CTestProcess::readInputData(istream &in, RefCOmModule module) {
    string place = "CTestProcess::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    TVecSignal eventSignals;
    vector<EOmEvent> eventTypes;
    TVecStmt stmts;
    EOmProcess procType;
    int _procType, nrEvents, nrStmts;

    nrEvents = nrStmts = 0;

    if( !module.get()) {
        CTestModule inModule;
        inModule.readInputData(in);
        module = inModule.getValue();
    }

    in >> _procType;
    if( _procType < 0 || _procType >= processSize )
        throw new CTestExceptionInvalid(place, "Bad Process Type");
    procType = ltabProcess[_procType];
    
    this->m_process = COmProcess::build(procType, module);

    in >> c;
    if( c == 'y') {
        this->setIOList(this->m_process);
        this->readIOList(in);
    } else if( c == 'n') {
        //no iolist test
    } else
        throw new CTestExceptionInvalid(place, "Expecting y or n here");
    
    in >> nrEvents;
    for(int i=0; i<nrEvents;i++) {
        RefCOmSignal sig;
        int _eventType;
        in >> _eventType;
        if( _eventType <0 || _eventType >= eventSize )
            throw new CTestExceptionInvalid(place, "Bad Event Type");

        sig = this->getSignal(in);
        eventSignals.push_back(sig);
        eventTypes.push_back(ltabEvent[_eventType]);
        this->m_process->addEventSignal(sig, ltabEvent[_eventType]);
    }

    in >> nrStmts;
    for(int i = 0; i < nrStmts; i++) {
        RefCOmStmt stmt;
        stmt = this->getStmt(in);
        stmts.push_back(stmt);
        this->m_process->addStmt(stmt);
    }
    
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }


    if( this->m_process->getOmType() != BASE_PROCESS || \
        this->m_process->getModule() != module || \
        this->m_process->getNrEvents() != nrEvents || \
        this->m_process->getNrStmts() != nrStmts \
      )
        throw new CTestExceptionFailed(place, "TEST FAILED");

    for( int i=0; i<nrEvents; i++) {
        if( this->m_process->getEventSignal(i) != eventSignals[i] ||\
            this->m_process->getEventType(i) != eventTypes[i] \
          )
            throw new CTestExceptionFailed(place, "TEST FAILED");
    }

    for( int i=0; i<nrStmts; i++ )
        if( this->m_process->getStmt(i) != stmts[i] )
            throw new CTestExceptionFailed(place, "TEST FAILED");
    
    this->m_check = 1;
    
}

int CTestProcess::verify() { return this->m_check; }

RefCOmProcess CTestProcess::getValue() { return m_process;}
//end of CTestProcess

// ---------------------------------------------
// |               CTestFunction               |
// ---------------------------------------------
CTestFunction::CTestFunction():m_check(0) {}

char* CTestFunction::getTestName() { return "COmFunction"; }

char* CTestFunction::getDefaultInputFile() { return "testFiles/testFunction.in"; }

void CTestFunction::readInputData(istream &in) {
    this->readInputData(in, RefCOmModule());
}

void CTestFunction::readInputData(istream &in, RefCOmModule module) {
    string place = "CTestFunction::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    string name;
    RefCOmBitRange br;
    TVecStmt stmts;
    int nrStmts;

    if( !module.get()) {
        CTestModule inModule;
        inModule.readInputData(in);
        module = inModule.getValue();
    }

    in >> name >> c;
    if (c == '1') {
        this->m_function = COmFunction::build(name, module);
    } else if (c == '2') {
        CTestBitRange inBr;
        inBr.readInputData(in);
        br = inBr.getValue();
        this->m_function = COmFunction::build(name, module, br);
    } else
        throw new CTestExceptionInvalid(place, "Invalid Parameter");

    in >> c;
    if( c == 'y') {
        this->setIOList(this->m_function);
        this->readIOList(in);
    } else if( c == 'n') {
        //no iolist test
    } else
        throw new CTestExceptionInvalid(place, "Expecting y or n here");
    
    in >> nrStmts;
    for( int i = 0; i < nrStmts; i++) {
        RefCOmStmt stmt;
        stmt = this->getStmt(in);
        stmts.push_back(stmt);
        this->m_function->addStmt(stmt);
    }
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    
    
//    !!!!    this->m_function->getNrStmts() != nrStmts || \
    if( this->m_function->getOmType() != BASE_FUNCTION || \
        this->m_function->getModule() != module || \
        *this->m_function->getName() != name || \
        this->m_function->getBitRange() != br\
      )

        throw new CTestExceptionFailed(place, "TEST FAILED");

    for( int i = 0; i < nrStmts; i++)
        if( this->m_function->getStmt(i) != stmts[i] )
            throw new CTestExceptionFailed(place, "TEST FAILED");
    
    this->m_check = 1;
    
}

int CTestFunction::verify() { return this->m_check; }

RefCOmFunction CTestFunction::getValue() { return m_function;}
//end of CTestFunction

// ---------------------------------------------
// |               CTestTask               |
// ---------------------------------------------
CTestTask::CTestTask():m_check(0) {}

char* CTestTask::getTestName() { return "COmTask"; }

char* CTestTask::getDefaultInputFile() { return "testFiles/testTask.in"; }

void CTestTask::readInputData(istream &in) {
    this->readInputData(in, RefCOmModule());
}

void CTestTask::readInputData(istream &in, RefCOmModule module) {
    string place = "CTestTask::readInputData";
    char c;
    in >> c;
    this->m_check = 0;
    if(c != '(') {
        string message = EXP_LPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }

    string name;
    TVecStmt stmts;
    int nrStmts;

    if( !module.get()) {
        CTestModule inModule;
        inModule.readInputData(in);
        module = inModule.getValue();
    }

    in >> name;
        this->m_task = COmTask::build(name, module);

    in >> c;
    if( c == 'y') {
        this->setIOList(this->m_task);
        this->readIOList(in);
    } else if( c == 'n') {
        //no iolist test
    } else
        throw new CTestExceptionInvalid(place, "Expecting y or n here");
    
    in >> nrStmts;
    for( int i = 0; i < nrStmts; i++) {
        RefCOmStmt stmt;
        stmt = this->getStmt(in);
        stmts.push_back(stmt);
        this->m_task->addStmt(stmt);
    }
    
    in >> c;
    if (c != ')') {
        string message = EXP_RPAR;
        message += c;
        throw new CTestExceptionInvalid(place, message );
    }
    
//    !!!!    this->m_task->getNrStmts() != nrStmts || \
    if( this->m_task->getOmType() != BASE_FUNCTION || \
        this->m_task->getModule() != module || \
        *this->m_task->getName() != name \
      )

        throw new CTestExceptionFailed(place, "TEST FAILED");

    for( int i = 0; i < nrStmts; i++)
        if( this->m_task->getStmt(i) != stmts[i] )
            throw new CTestExceptionFailed(place, "TEST FAILED");
    
    this->m_check = 1;
    
}

int CTestTask::verify() { return this->m_check; }

RefCOmTask CTestTask::getValue() { return m_task;}
//end of CTestTask
*/
//end of file
