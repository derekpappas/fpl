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
#include "testTables.h"
#include "RefCount.h"
#include "Tools.h"
#include "testException.h"
#define EXP_LPAR "Expected token \'(\', found "
#define EXP_RPAR "Expected token \')\', found "
using namespace NSTestExceptions;
using namespace NSTables;
using namespace std;
using namespace NSChipDesignOm;
using namespace NSRefCount;

// ---------------------------------------------
// |                CTestBase                  |
// ---------------------------------------------
CTestBase::CTestBase(){}

void CTestBase::outputTestInvalid(unsigned int i, char *buff){
	if(!ALLOUT)
		cout << '[' << i << ']';
	cout << TEST_INVALID << buff;
	if(ALLOUT)
		cout << TEST_SKIP;
	cout << endl;
}

void CTestBase::outputTestFailed(unsigned int i, char *buff){
	if(!ALLOUT)
		cout << '[' << i << ']';
	cout << TEST_FAIL << buff << endl;
}

void CTestBase::outputTestPassed(unsigned int i, char *buff){
	cout << TEST_OK << endl;
}

void CTestBase::outputTestReport(unsigned int i, unsigned int ok, unsigned int badTests, unsigned int bug){
	cout << TEST_NO;
	if(ok)
		cout << '/' << TEST_NO_CHECK;
	if(badTests)
		cout << '/' << TEST_NO_INVALID;
	if(bug)
		cout << '/' << TEST_NO_FAILED;
	cout << endl;

	cout << i;
	if(ok)
		cout << '/' << ok;
	if(badTests)
		cout << '/' << badTests;
	if(bug)
		cout << '/' << bug;
	cout << endl;
}

void CTestBase::outputTestAll(unsigned int i, char *buff){
	cout << TEST_EXEC << '[' << i << ']';
	if(ALLOUT)
		cout  << buff;
}

void CTestBase::test(char* in){
	cout << "Testing : " << this->getTestName() << endl;

        if(in == NULL) //if there is no needed special input file, switching to default
                in=this->getDefaultInputFile();

        ifstream fin(in); //opening the input file

        if(fin == NULL){
                cout << "Can't open the input test file" << endl;
                exit(FINISH_NOTESTFILE);
        }
        unsigned int badTests = 0; // number of invalid tests
        unsigned int i=0; //total number of test
        unsigned int ok = 0; //number of passed tests
        unsigned int bug = 0; //number of tests witch didn't pass

	while(true){
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

		while( c != '('){ //skipping the test Name, if there is one
			c = buffin.get();
		//	cout << c;
		}
		buffin.putback(c);
		
		try{
			this->readInputData(buffin); //here the input test data is read from the stream by the overrided function
		} catch(CTestExceptionInvalid * e){
			badTests++;
			outputTestInvalid(i,buff);
			cout << e->toString() << endl;
			continue;
		}
		catch(CTestExceptionFailed *e){
			bug++;
			outputTestFailed(i,buff);
			cout << e->toString() << endl;
			continue;
		}
		catch(CTestException * e){
			cout << "unknown exception: " << e->toString() << endl;
			continue;
		}
		catch(CTestExceptionInvalid e){
			badTests++;
			outputTestInvalid(i,buff);
			cout << e.toString() << endl;
			continue;
		}
		catch(CTestExceptionFailed e){
			bug++;
			outputTestFailed(i,buff);
			cout << e.toString() << endl;
			continue;
		}
		catch(CTestException e){
			cout << "unknown exception: " << e.toString() << endl;
			continue;
		}	

		//In this part it is verified the what is left of the line to be valid
		char s1 = '/', s2 = '/'; //it only is permited to write comments after the test only in this style
		buffin >> s1 >> s2;
		if( s1 != '/' || s2 != '/' ){
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

RefCOmElement CTestBase::getElement( istream &in, RefCOmModule module){
	RefCOmElement element;
	string type;
	in >> type;
	if( type == "COmGate"){
		CTestGate inElement;
		inElement.readInputData(in, module);
		element = inElement.getValue();
	} else if( type == "COmParam"){
		CTestParam inElement;
		inElement.readInputData(in, module);
		element = inElement.getValue();
	} else if( type == "COmContAssign"){
		CTestContAssign inElement;
		inElement.readInputData(in, module);
		element = inElement.getValue();
	} else if( type == "COmProcess"){
		CTestProcess inElement;
		inElement.readInputData(in, module);
		element = inElement.getValue();
	} else if( type == "COmFunction"){
		CTestFunction inElement;
		inElement.readInputData(in, module);
		element = inElement.getValue();
	} else if( type == "COmTask"){
		CTestTask inElement;
		inElement.readInputData(in, module);
		element = inElement.getValue();
	} else
		throw new CTestExceptionInvalid("CTestBase::getElement( istream &, RefCOmModule)","Unknown type: " + type);
		

	return element;
}

RefCOmIOList CTestBase::getIOList( istream &in){
	RefCOmIOList ioList;
	string type;
	in >> type;
	
	if( type == "COmModule"){
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
	} else if( type == "COmUDP") {
/*		CTestUDP inIOList;
		if( inIOList.readInputData(in) == 0)
			return ioList;
		if( inIOList.verify() == 0)
			return ioList;
		ioList = inIOList.getValue();
*/	} else
		throw new CTestExceptionInvalid("CTestBase::getIOList( istream &)", "Unknown type: " + type);

	return ioList;
}
RefCOmStmt CTestBase::getStmt(istream &in){
	RefCOmStmt stmt;
	string type;
	in >> type;
	if(type == "COmStmtAssn"){
		CTestStmtAssn inStmt;
		inStmt.readInputData(in);
		stmt = inStmt.getValue();
	} else if( type == "COmStmtIfElse"){
		CTestStmtIfElse inStmt;
		inStmt.readInputData(in);
		stmt = inStmt.getValue();
	} else if( type == "COmStmtLoop"){
		CTestStmtLoop inStmt;
		inStmt.readInputData(in);
		stmt = inStmt.getValue();
	} else if( type == "COmStmtCase"){
		CTestStmtCase inStmt;
		inStmt.readInputData(in);
		stmt = inStmt.getValue();
	} else
		throw new CTestExceptionInvalid("CTestBase::getStmt(istream &)", "Unknown type: " + type);

	return stmt;
}

RefCOmSignal CTestBase::getSignal(istream &in, RefCOmIOList iolist){
	RefCOmSignal sig;
	string type;
	in >> type;
	if(type == "COmSignalPort"){
		CTestSignalPort inSig;
		inSig.readInputData(in, iolist);
		sig = inSig.getValue();
	} else if( type == "COmSignalSingleton"){
		CTestSignalSingleton inSig;
		inSig.readInputData(in, iolist);
		sig = inSig.getValue();
	} else
		throw new CTestExceptionInvalid("CTestBase::getSignal(istream &, RefCOmIOList)", "Unknown type: " + type);

	return sig;
}

RefCOmExpr CTestBase::getExpr(istream & in){
	RefCOmExpr expr;
	string type;
	in >> type;
	if( type == "COmSignalPort"){
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
//end of CTestBase

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
	if( c != '(' ){ //bad input
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
	  ){
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

void CTestSignalPort::readInputData(istream &in){
	this->readInputData(in, RefCOmIOList());
}

void CTestSignalPort::readInputData(istream &in, RefCOmIOList iolist){
	string place = "CTestSignalPort::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	if(c == '0'){
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
	} else if(c == '3'){
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
	if (c != ')'){
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
		){
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

void CTestSignalSingleton::readInputData(istream &in){
	this->readInputData(in, RefCOmIOList());
}

void CTestSignalSingleton::readInputData(istream &in, RefCOmIOList iolist){
	string place = "CTestSignalSingleton::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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

	if( !iolist.get()){
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
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( br != this->m_sigSingleton->getBitRange() || \
		this->m_sigSingleton->getSignalType() != sigType || \
		this->m_sigSingleton->getIOList() != iolist || \
		this->m_sigSingleton->getOmType() != BASE_EXPR_SIGNAL || \
		*this->m_sigSingleton->getName() != name
		){
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

void CTestEvent::readInputData(istream &in){
	string place = "CTestEvent::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}


	if( this->m_event->getEventType() != evType || \
		this->m_event->getExpr() != expr || \
		this->m_event->getOmType() != BASE_EXPR_EVENT \
		){
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

void CTestExprValInt::readInputData(istream &in){
	string place = "CTestExprValInt::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( this->m_exprValInt->getSize() != size || \
		this->m_exprValInt->getBaseType() != base || \
		this->m_exprValInt->getVal() != retValue || \
		this->m_exprValInt->isConst() != retIsConst || \
		*this->m_exprValInt->getNumStr() != numStr  \
		){
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

void CTestExprValReal::readInputData(istream &in){
	string place = "CTestExprValReal::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( *this->m_exprValReal->getNumStr() != numStr || \
		this->m_exprValReal->getNonExp() != retNonExp || \
		this->m_exprValReal->getExp() != retExp || \
		this->m_exprValReal->getVal() != retVal || \
		this->m_exprValReal->isConst() != retIsConst \
		){
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

void CTestStmtAssn::readInputData(istream &in){
	string place = "CTestStmtAssn::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	
	if(c == '1'){
		this->m_stmtAssn = COmStmtAssn::build(assignType, sig, expr);
	} else if (c == '2'){
		in >> stmtAttr;
		this->m_stmtAssn = COmStmtAssn::build(assignType, sig, expr, stmtAttr);
	} else
		throw new CTestExceptionInvalid(place, "Invalid parameter");
	
	in >> c;
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( this->m_stmtAssn->getAssignType() != assignType || \
		this->m_stmtAssn->getLhs() != sig || \
		this->m_stmtAssn->getRhs() != expr || \
		this->m_stmtAssn->getStmtAttr() != stmtAttr \
		){
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

void CTestStmtIfElse::readInputData(istream &in){
	string place = "CTestStmtIfElse::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	for(int j = 0; j < nrStmtsIf; j++){
		RefCOmStmt refStmt = this->getStmt(in);
		stmtsIf.push_back(refStmt);
		this->m_stmtIfElse->addStmtIf(refStmt);
	}
	
	in >> nrStmtsElse;
	for(int j = 0; j < nrStmtsElse; j++){
		RefCOmStmt refStmt = this->getStmt(in);
		stmtsElse.push_back(refStmt);
		this->m_stmtIfElse->addStmtElse(refStmt);
	}
	in >> c;
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( this->m_stmtIfElse->getExprCond() != expr ){
		throw new CTestExceptionFailed(place, "TEST FAILED");
	}

	for( int j = 0; j < nrStmtsIf; j++){
		if( this->m_stmtIfElse->getStmtIf(j) != stmtsIf[j]){
			throw new CTestExceptionFailed(place, "TEST FAILED");
		}
	}

	for(int j=0; j < nrStmtsElse; j++){
		if( this->m_stmtIfElse->getStmtElse(j) != stmtsElse[j]){
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

void CTestStmtLoop::readInputData(istream &in){
	string place = "CTestStmtLoop::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	} else if ( c == '3'){
		exprInit = this->getExpr(in);
		exprCond = this->getExpr(in);
		this->m_stmtLoop = COmStmtLoop::build(exprInit,exprCond);
	} else if( c == '4' ){
		exprInit = this->getExpr(in);
		exprCond = this->getExpr(in);
		exprLoop = this->getExpr(in);
		this->m_stmtLoop = COmStmtLoop::build(exprInit, exprCond, exprLoop);
	} else
		throw new CTestExceptionInvalid(place, "Invalid Parameter");

	in >> nrStmts;
	for(int j = 0; j < nrStmts; j++){
		RefCOmStmt refStmt = this->getStmt(in);
		stmts.push_back(refStmt);
		this->m_stmtLoop->addStmt(refStmt);
	}
	
	in >> c;
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( this->m_stmtLoop->getExprInit() != exprInit || \
		this->m_stmtLoop->getExprCond() != exprCond || \
		this->m_stmtLoop->getExprLoop() != exprLoop \
		){
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

void CTestStmtCase::readInputData(istream &in){
	string place = "CTestStmtCase::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	for(int j = 0; j < nrCaseItems; j++){
		CTestCaseItem inCaseItem;
		inCaseItem.readInputData(in, this->m_stmtCase);
		RefCOmCaseItem refCaseItem = inCaseItem.getValue();
		caseItems.push_back(refCaseItem);
	}
	
	in >> c;
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( this->m_stmtCase->getCaseType() != caseType || \
		this->m_stmtCase->getExprSwitch() != exprSwitch \
		){
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

void CTestCaseItem::readInputData(istream &in){
	this->readInputData(in, RefCOmStmtCase());
}

void CTestCaseItem::readInputData(istream &in, RefCOmStmtCase _parent){
	string place = "CTestCaseItem::readInputData";
	RefCOmStmtCase parent = _parent;
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	for(int i = 0; i < nrMatchExpr; i++){
		RefCOmExpr refExpr = this->getExpr(in);
		matchExprs.push_back(refExpr);
		this->m_caseItem->addMatchExpr(refExpr);
	}

	in >> nrStmts;
	for( int i = 0; i < nrStmts; i++ ){
		RefCOmStmt refStmt = this->getStmt(in);
		stmts.push_back(refStmt);
		this->m_caseItem->addStmt(refStmt);
	}
	
	in >> c;
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( this->m_caseItem->getCaseItemType() != caseItemType || \
		this->m_caseItem->getParentStmtCase() != parent \
		){
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
CTestIOList::CTestIOList(){
	this->m_check = 1;
}

void CTestIOList::setIOList(RefCOmIOList list){
	this->m_check = 0;
	this->m_IOList = list;
}

int CTestIOList::readIOList(istream &in){
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
	if(c != '('){
		string message = EXP_LPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}
	
	in >> nrChildren;
	for ( int i=0; i< nrChildren; i++ ){
		RefCOmIOList ioList;
		ioList = this->getIOList(in);
		this->m_IOList->addChildIOList(ioList);
		childIOLists.push_back(ioList);
	}
		
	in >> nrPorts;
	for( int i=0; i<nrPorts; i++ ){
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
	for(int i=0; i<nrPortDir; i++){
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
		switch (sigPort->getDir()){
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
	if (c != ')'){
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
	  ){
		cout << "check iolist failed\n";
		cout << this->m_IOList->getNrInputPorts() << " = " << nrInputPorts << endl;
//		cout << this->m_IOList->getNrOutputPorts() << " = " << nrOutputPorts << endl;
//		cout << this->m_IOList->getNrInOutPorts() << " = " << nrInOutPorts << endl;
//		cout << this->m_IOList->getNrSignals() << " = " << nrSignals << endl;
//		cout << this->m_IOList->getNrPorts() << " = " << nrPorts << endl;
		throw new CTestExceptionFailed(place, "TEST FAILED");
	}

	for( int i=0; i < nrChildren; i++)
		if( this->m_IOList->getChildIOListByIdx(i) != childIOLists[i])
			throw new CTestExceptionFailed(place, "TEST FAILED");

	for( int i = 0; i< nrPorts; i++){
		if( this->m_IOList->getPortByIdx(i) != ports[i] )
			throw new CTestExceptionFailed(place, "TEST FAILED");
		if( this->m_IOList->getPortByName(*ports[i]->getName()) != ports[i])
			throw new CTestExceptionFailed(place, "TEST FAILED");
	}

	for( int i = 0; i<nrSignals; i++){
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

int CTestIOList::verifyIOList(){
	return m_check;
}

//end of CTestIOList

// ---------------------------------------------
// |               CTestModule                 |
// ---------------------------------------------
CTestModule::CTestModule():m_check(0) {}

char* CTestModule::getTestName() { return "COmModule"; }

char* CTestModule::getDefaultInputFile() { return "testFiles/testModule.in"; }

void CTestModule::readInputData(istream &in){
	this->readInputData(in, RefCOmIOList());
}

void CTestModule::readInputData(istream &in, RefCOmIOList _parent){
	string place = "CTestModule::readInputData";
	RefCOmIOList parent = _parent;
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
		} else if (c == 'n'){
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
	if( c == 'y'){
		this->setIOList(this->m_module);
		this->readIOList(in);
	} else if ( c == 'n' ){
		//no ioList tests
	} else {
		string message = "Expecting y or n at COmIOList test, found: ";
		message += c;
		throw new CTestExceptionInvalid(place, message);
	}
	//the IOList test ended
	

	in >> nrParams;
	for(int i = 0; i < nrParams; i++){
		RefCOmParam param;
		CTestParam inParam;
		inParam.readInputData(in);
		param = inParam.getValue();
		params.push_back(param);
		paramName2index_map.insert(make_pair(*param->getName(),i));
		this->m_module->addParam(param);
	}

	in >> nrElements;
	for( int i = 0; i < nrElements; i++ ){
		elements.push_back(this->getElement(in, m_module));
	}
	
	in >> c;
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	if( *this->m_module->getName() != name || \
		this->m_module->getNrParams() != nrParams || \
		this->m_module->getNrElements() != nrElements || \
		this->m_module->getParentIOList() != parent\
		){
		throw new CTestExceptionFailed(place, "TEST FAILED");
	}
	for( int i = 0; i < nrParams; i++)
		if(this->m_module->getParamByIdx(i) != params[i] || this->m_module->getParamByName(*params[i]->getName()) != params[i]){
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

void CTestGate::readInputData(istream &in){
	this->readInputData(in, RefCOmModule());
}

void CTestGate::readInputData(istream &in, RefCOmModule module){
	string place = "CTestGate::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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
	if( !module.get() ){
		CTestModule inModule;
		inModule.readInputData(in);
		module = inModule.getValue();
	}

	this->m_gate = COmGate::build(gateType, module, name);

	//set base IOList params
	in >> c;
	if( c == 'y'){
		this->setIOList(this->m_gate);
		this->readIOList(in);
	}
	else if(c == 'n'){
		//don't do anything
	} else
		throw new CTestExceptionInvalid(place, "Expecting y or n here");
		
	
	

	in >> c;
	if (c != ')'){
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

void CTestSignalRef::readInputData(istream &in){
	this->readInputData(in, RefCOmModule());
}

void CTestSignalRef::readInputData(istream &in, RefCOmModule module){
	string place = "CTestSignalRef::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
		string message = EXP_LPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	string name;
	
	in >> name;

	//Reading the module
	if( !module.get() ){
		CTestModule inModule;
		inModule.readInputData(in);
		module = inModule.getValue();
	}

	this->m_signalRef = COmSignalRef::build(name, module);

	in >> c;
	if (c != ')'){
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

void CTestExprOp::readInputData(istream &in){
	string place = "CTestExprOp::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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

	if( c == '1'){
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
	for( int i=0; i< nrOther; i++){
		expr = this->getExpr(in);
		exprs.push_back(expr);
		this->m_exprOp->addExpr(expr);
	}
	in >> isConst;
	TLong retEvalConst;
	if( isConst )
		in >> retEvalConst;
	in >> c;
	if (c != ')'){
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

void CTestParam::readInputData(istream &in){
	this->readInputData(in, RefCOmModule());
}

void CTestParam::readInputData(istream &in, RefCOmModule module){
	string place = "CTestParam::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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

	if( !module.get()){
		CTestModule inModule;
		inModule.readInputData(in);
		module = inModule.getValue();
	}

	in >> name;
	expr = this->getExpr(in);

	in >> c;
	CTestBitRange inBr;
	switch(c){
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
	if (c != ')'){
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

void CTestContAssign::readInputData(istream &in){
	this->readInputData(in, RefCOmModule());
}

void CTestContAssign::readInputData(istream &in, RefCOmModule module){
	string place = "CTestContAssign::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
		string message = EXP_LPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}
	RefCOmSignal signalLhs;
	RefCOmExpr exprRhs;

	if( !module.get()){
		CTestModule inModule;
		inModule.readInputData(in);
		module = inModule.getValue();
	}

	signalLhs = this->getSignal(in, module);
	exprRhs = this->getExpr(in);

	this->m_contAssign = COmContAssign::build(module, signalLhs, exprRhs);
	
	in >> c;
	if (c != ')'){
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

void CTestProcess::readInputData(istream &in){
	this->readInputData(in, RefCOmModule());
}

void CTestProcess::readInputData(istream &in, RefCOmModule module){
	string place = "CTestProcess::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
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

	if( !module.get()){
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
	if( c == 'y'){
		this->setIOList(this->m_process);
		this->readIOList(in);
	} else if( c == 'n'){
		//no iolist test
	} else
		throw new CTestExceptionInvalid(place, "Expecting y or n here");
	
	in >> nrEvents;
	for(int i=0; i<nrEvents;i++){
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
	for(int i = 0; i < nrStmts; i++){
		RefCOmStmt stmt;
		stmt = this->getStmt(in);
		stmts.push_back(stmt);
		this->m_process->addStmt(stmt);
	}
	
	
	in >> c;
	if (c != ')'){
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

	for( int i=0; i<nrEvents; i++){
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

void CTestFunction::readInputData(istream &in){
	this->readInputData(in, RefCOmModule());
}

void CTestFunction::readInputData(istream &in, RefCOmModule module){
	string place = "CTestFunction::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
		string message = EXP_LPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	string name;
	RefCOmBitRange br;
	TVecStmt stmts;
	int nrStmts;

	if( !module.get()){
		CTestModule inModule;
		inModule.readInputData(in);
		module = inModule.getValue();
	}

	in >> name >> c;
	if (c == '1'){
		this->m_function = COmFunction::build(name, module);
	} else if (c == '2'){
		CTestBitRange inBr;
		inBr.readInputData(in);
		br = inBr.getValue();
		this->m_function = COmFunction::build(name, module, br);
	} else
		throw new CTestExceptionInvalid(place, "Invalid Parameter");

	in >> c;
	if( c == 'y'){
		this->setIOList(this->m_function);
		this->readIOList(in);
	} else if( c == 'n'){
		//no iolist test
	} else
		throw new CTestExceptionInvalid(place, "Expecting y or n here");
	
	in >> nrStmts;
	for( int i = 0; i < nrStmts; i++){
		RefCOmStmt stmt;
		stmt = this->getStmt(in);
		stmts.push_back(stmt);
		this->m_function->addStmt(stmt);
	}
	
	in >> c;
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}
	
	
	if( this->m_function->getOmType() != BASE_FUNCTION || \
	/*!!!!	this->m_function->getNrStmts() != nrStmts ||*/ \
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

void CTestTask::readInputData(istream &in){
	this->readInputData(in, RefCOmModule());
}

void CTestTask::readInputData(istream &in, RefCOmModule module){
	string place = "CTestTask::readInputData";
	char c;
	in >> c;
	this->m_check = 0;
	if(c != '('){
		string message = EXP_LPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}

	string name;
	TVecStmt stmts;
	int nrStmts;

	if( !module.get()){
		CTestModule inModule;
		inModule.readInputData(in);
		module = inModule.getValue();
	}

	in >> name;
		this->m_task = COmTask::build(name, module);

	in >> c;
	if( c == 'y'){
		this->setIOList(this->m_task);
		this->readIOList(in);
	} else if( c == 'n'){
		//no iolist test
	} else
		throw new CTestExceptionInvalid(place, "Expecting y or n here");
	
	in >> nrStmts;
	for( int i = 0; i < nrStmts; i++){
		RefCOmStmt stmt;
		stmt = this->getStmt(in);
		stmts.push_back(stmt);
		this->m_task->addStmt(stmt);
	}
	
	in >> c;
	if (c != ')'){
		string message = EXP_RPAR;
		message += c;
		throw new CTestExceptionInvalid(place, message );
	}
	
	if( this->m_task->getOmType() != BASE_FUNCTION || \
	/*!!!!	this->m_task->getNrStmts() != nrStmts ||*/ \
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

//end of file
