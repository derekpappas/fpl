#ifndef TESTDRIVERH

#define TESTDRIVERH

#include <iostream>

#include "ObjectModel.h"
#include "RefCount.h"

using namespace std;
using namespace NSChipDesignOm;
using namespace NSRefCount;

#define FINISH_OK 0
#define FINISH_OK_W 1
#define FINISH_BUG 2
#define FINISH_BUG_W 3
#define FINISH_ERR_SYNTAX 10
#define FINISH_NOTESTFILE 11
#define FINISH_NO_INPUT_TESTS 12

#define TEST_OK " PASSED"
#define TEST_FAIL " FAILED "
#define TEST_INVALID " INVALID "
#define TEST_SKIP ", SKIPPING"
#define TEST_EXEC "Executing test "
#define TEST_END "Ended testing ... "

#define TEST_NO "No. of tests"
#define TEST_NO_CHECK "Passed"
#define TEST_NO_FAILED "Failed"
#define TEST_NO_INVALID "Invalid"

#define ALLOUT 0

#define MAX_BUFF_SIZE 2000

// ---------------------------------------------
// |              CTestBase                    |
// ---------------------------------------------
class CTestBase {
private:
	void outputTestAll(unsigned int, char *);
	void outputTestInvalid(unsigned int, char *);
	void outputTestFailed(unsigned int, char *);
	void outputTestPassed(unsigned int, char *);
	void outputTestReport(unsigned int, unsigned int, unsigned int, unsigned int);
protected:
	virtual char* getTestName() = 0;
	virtual char* getDefaultInputFile() = 0;
	
	RefCOmExpr getExpr( istream &);
	RefCOmSignal getSignal( istream &, RefCOmIOList = RefCOmIOList());
	RefCOmStmt getStmt( istream & );
	RefCOmIOList getIOList( istream & );
	RefCOmElement getElement( istream &, RefCOmModule);
public:
	CTestBase();
	void test( char*);
	virtual void readInputData(istream &) = 0;
	virtual int verify() = 0;
};


// ---------------------------------------------
// |              CTestBitRange                |
// ---------------------------------------------
class CTestBitRange : public CTestBase {
private:
	RefCOmBitRange m_br;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestBitRange();
	void readInputData(istream &);
	int verify();
	RefCOmBitRange getValue();
};

// ---------------------------------------------
// |              CTestSignalPort              |
// ---------------------------------------------
class CTestSignalPort : public CTestBase {
private:
	RefCOmSignalPort m_sigPort;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestSignalPort();
	void readInputData(istream &, RefCOmIOList);
	void readInputData(istream &);
	int verify();
	RefCOmSignalPort getValue();
};

// ---------------------------------------------
// |          CTestSignalSingleton             |
// ---------------------------------------------
class CTestSignalSingleton : public CTestBase {
private:
	RefCOmSignalSingleton m_sigSingleton;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestSignalSingleton();
	void readInputData(istream &, RefCOmIOList);
	void readInputData(istream &);
	int verify();
	RefCOmSignalSingleton getValue();
};

// ---------------------------------------------
// |              CTestEvent                   |
// ---------------------------------------------
class CTestEvent : public CTestBase {
private:
	RefCOmEvent m_event;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestEvent();
	void readInputData(istream &);
	int verify();
	RefCOmEvent getValue();
};

// ---------------------------------------------
// |          CTestExprValInt                  |
// ---------------------------------------------
class CTestExprValInt: public CTestBase {
private:
	RefCOmExprValInt m_exprValInt;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestExprValInt();
	void readInputData(istream &);
	int verify();
	RefCOmExprValInt getValue();
};

// ---------------------------------------------
// |          CTestExprValReal                 |
// ---------------------------------------------
class CTestExprValReal: public CTestBase {
private:
	RefCOmExprValReal m_exprValReal;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestExprValReal();
	void readInputData(istream &);
	int verify();
	RefCOmExprValReal getValue();
};

// ---------------------------------------------
// |          CTestStmtAssn                    |
// ---------------------------------------------
class CTestStmtAssn : public CTestBase {
private:
	RefCOmStmtAssn m_stmtAssn;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestStmtAssn();
	void readInputData(istream &);
	int verify();
	RefCOmStmtAssn getValue();
};


// ---------------------------------------------
// |          CTestStmtIfElse                  |
// ---------------------------------------------
class CTestStmtIfElse : public CTestBase {
private:
	RefCOmStmtIfElse m_stmtIfElse;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestStmtIfElse();
	void readInputData(istream &);
	int verify();
	RefCOmStmtIfElse getValue();
};


// ---------------------------------------------
// |          CTestStmtLoop                    |
// ---------------------------------------------
class CTestStmtLoop : public CTestBase {
private:
	RefCOmStmtLoop m_stmtLoop;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestStmtLoop();
	void readInputData(istream &);
	int verify();
	RefCOmStmtLoop getValue();
};


// ---------------------------------------------
// |          CTestStmtCase                    |
// ---------------------------------------------
class CTestStmtCase : public CTestBase {
private:
	RefCOmStmtCase m_stmtCase;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestStmtCase();
	void readInputData(istream &);
	int verify();
	RefCOmStmtCase getValue();
};

// ---------------------------------------------
// |          CTestCaseItem                    |
// ---------------------------------------------
class CTestCaseItem : public CTestBase {
private:
	RefCOmCaseItem m_caseItem;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestCaseItem();
	void readInputData(istream &);
	void readInputData(istream &, RefCOmStmtCase);
	int verify();

	RefCOmCaseItem getValue();
};


// ---------------------------------------------
// |          CTestIOList                      |
// ---------------------------------------------
class CTestIOList : virtual public CTestBase{
private:
	RefCOmIOList m_IOList;
	int m_check;
protected:
	void setIOList(RefCOmIOList);
	int readIOList(istream &);
	int verifyIOList();
public:
	CTestIOList();
};

// ---------------------------------------------
// |          CTestModule                      |
// ---------------------------------------------
class CTestModule : public CTestIOList{
private:
	RefCOmModule m_module;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestModule();
	void readInputData(istream &, RefCOmIOList);
	void readInputData(istream &);
	int verify();

	RefCOmModule getValue();
};

// ---------------------------------------------
// |          CTestGate                        |
// ---------------------------------------------
class CTestGate : public CTestIOList {
private:
	RefCOmGate m_gate;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestGate();
	void readInputData(istream &);
	void readInputData(istream &, RefCOmModule);
	int verify();

	RefCOmGate getValue();
};

// ---------------------------------------------
// |          CTestSignalRef                   |
// ---------------------------------------------
class CTestSignalRef : public CTestBase {
private:
	RefCOmSignalRef m_signalRef;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestSignalRef();
	void readInputData(istream &);
	void readInputData(istream &, RefCOmModule);
	int verify();

	RefCOmSignalRef getValue();
};

// ---------------------------------------------
// |          CTestExprOp                      |
// ---------------------------------------------
class CTestExprOp : public CTestBase {
private:
	RefCOmExprOp m_exprOp;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestExprOp();
	void readInputData(istream &);
	int verify();

	RefCOmExprOp getValue();
};

// ---------------------------------------------
// |          CTestParam                       |
// ---------------------------------------------
class CTestParam : public CTestBase {
private:
	RefCOmParam m_param;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestParam();
	void readInputData(istream &);
	void readInputData(istream &, RefCOmModule);
	int verify();

	RefCOmParam getValue();
};

// ---------------------------------------------
// |          CTestContAssign                  |
// ---------------------------------------------
class CTestContAssign : public CTestBase {
private:
	RefCOmContAssign m_contAssign;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestContAssign();
	void readInputData(istream &);
	void readInputData(istream &, RefCOmModule);
	int verify();

	RefCOmContAssign getValue();
};

// ---------------------------------------------
// |          CTestProcess                     |
// ---------------------------------------------
class CTestProcess : public CTestIOList {
private:
	RefCOmProcess m_process;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestProcess();
	void readInputData(istream &);
	void readInputData(istream &, RefCOmModule);
	int verify();

	RefCOmProcess getValue();
};


// ---------------------------------------------
// |          CTestFunction                    |
// ---------------------------------------------
class CTestFunction : public CTestIOList {
private:
	RefCOmFunction m_function;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestFunction();
	void readInputData(istream &);
	void readInputData(istream &, RefCOmModule);
	int verify();

	RefCOmFunction getValue();
};

// ---------------------------------------------
// |          CTestTask                        |
// ---------------------------------------------
class CTestTask : public CTestIOList {
private:
	RefCOmTask m_task;
	int m_check;
protected:
	char* getTestName();
	char* getDefaultInputFile();
public:
	CTestTask();
	void readInputData(istream &);
	void readInputData(istream &, RefCOmModule);
	int verify();

	RefCOmTask getValue();
};

#endif
