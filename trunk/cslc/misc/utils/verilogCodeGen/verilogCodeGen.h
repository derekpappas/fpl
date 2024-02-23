#ifndef __VERILOG_CODE_GEN

#define __VERILOG_CODE_GEN

#include "CDOM.h"
#include <cstdlib>
#include <ctime>
#include <vector>
#include <sstream>

#define MAXBUFF_SIZE 10000

// Auto generate Verilog test cases
// the functions which generate string are meant to generate a single module
// the functions which generate CDOM objects are meant to generate a module hierarchies
// the CDOm code is generated and is linked to the CDOm
class CRandomNumber {
  public:
    CRandomNumber(){ std::srand((unsigned)time(NULL)); }
    unsigned int createRandomNum(){ return rand(); }

    // create a random number between 0 and upper Bound
    // called by the functions which randomly generate numbers
    unsigned int createRandomNum(unsigned int upperBound){
      return (int)(((double)rand()/(double)RAND_MAX)*(double)(++upperBound));
    }
    unsigned int createRandomNum(unsigned int lowerBound, unsigned int upperBound){
      if( lowerBound > upperBound )
        std::swap( lowerBound, upperBound );
      return this->createRandomNum( upperBound - lowerBound ) + lowerBound;
    } 

};
class CVerilogTestGen {
  private:
    unsigned int counter;
    unsigned int m_firstLetterIdSize;
    std::vector<char> m_identifChars; // [a-zA-Z_]{[a-zA-Z_0-9$]}
    // this vector holds the vars which are created by the functions in the // verilogTestGen class
    //vector<CDOmVars> vec_var; // check the name of the class in the CDOm
    std::vector<NSCdom::CDOmExprOp::EOpType> vectOpType;
    std::vector<NSCdom::CDOmExpr::EExprType> vectExprType;
    // vectors for storing the 
    //NSCdom::TVec_RefCDOmExpr ve;
    //NSCdom::TVec_RefCDOmStmt vs;
    //NSCdom::TVec_RefCDOmModuleDecl vm;
    CRandomNumber m_randomNumberGen;
    unsigned int state;
    // 0 - random id generation
    // 1 - incremental id generation
    
    // fix type vector<CDOmModuleItem*>   vmi;
    //CDOmModuleItemk
    //vector<CDOmModule*>   vm;
  public:
    char *m_out;
    std::ostringstream buffout;
    CVerilogTestGen();
    friend std::ostream& operator << ( std::ostream& out, CVerilogTestGen& x) { out << x.buffout.str(); return out;}
    
    // auto generate test cases
    //  if the expression fucntion randomly creates variables then the variables are 
    // added to the vec_var. 

    // In the next version of the test generator which will cerate CDOM objects and not verilog code if there is a hierarchy of scopes then add the variable to // the correct scope in the next version of the test generator which will use the // CDOm classes to hold the generated code

    /////////////////////////////


    /////////////////////////////

    //NSCdom::RefString createVarUsingPrefix(NSCdom::RefString prefix);
    //NSCdom::RefString createRandomVar();
    void createRandomIdentifier(NSCdom::RefString prefix = NSCdom::RefString(0), TUInt maxIdSize = 10);

/*
    /////////////////////////////

    CDOmId* createVarUsingPrefix(string prefix);
    CDOmId* string createRandomVar();

    /////////////////////////////
*/
    // use the enumerated types in the CDOM
    // rules for verilog width  calculations using operators
    // There aer rules for determining the width of expression operations using variables 
    // which are declared with a width (e.g. wire [3:0] x; ) 
    // input              input result
    // width operator width width
    // n      +            m      max(n,m) + 1
    // n       *            m      n+m
    // n       /            m      
    // n       >>         m      n-m
    // n       <<         m      n+m
    // ...see specification
    // also add support for part selects in expressions (e.g. a[4:2] + b)

    void createOpString( NSCdom::CDOmExprOp::EOpType opType );
    //NSCdom::RefString createRandomExpr(ECDOmVarType nt, width = 1);
    void createRandomExpr();
    /*
    void createExpr(CDOmExpr::EExprType et, CDOmExprOp::EOpType ot, width = 1);

    void createExpr(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);

    void createExprNum(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, 
        int n, width = 1);

    ////////////////////////////////////////
    // create expression trees //
    ////////////////////////////////////////

    // n is the number of operators in the expression

    void createExprNum(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);
    int n, width = 1);

    void createExprTree(ECDOmVarType nt, width = 1);

    void createExprTree(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, width = 1);

    void createExprTree(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);

    void createExprTreeNum(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, 
        int n, width = 1);

    void createExprTreeNum(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);
    int n, width = 1);

    void createExprTreeNum(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);
    int n, width = 1);

    ////////////////////////////////////////

    CDOmExpr* createExprTree(ECDOmVarType nt, width = 1);

    CDOmExpr* createExprTree(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, width = 1);

    CDOmExpr* createExprTree(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);

    CDOmExpr* createExprTreeNum(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, 
        int n, width = 1);

    CDOmExpr* createExprTreeNum(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);
    int n, width = 1);

    CDOmExpr* createExprTreeNum(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);
    int n, width = 1);
    ////////////////////////////////////////

    CDOmExpr* createExprTree(ECDOmVarType nt, width = 1);

    CDOmExpr* createExprTree(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, width = 1);

    CDOmExpr* createExprTree(vector<CDOmExpr*> ve, 
        vector<CDOmExprOp::EOpType> ot, width = 1);

    CDOmExpr* createExprTreeNum(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, 
        int n, width = 1);

    CDOmExpr* createExprTreeNum(vector<CDOmExpr*> ve, 
        vector<CDOmExprOp::EOpType> ot, width = 1);
    int n, width = 1);

    CDOmExpr* createExprTreeNum(vector<CDOmExpr*> ve, 
        vector<CDOmExprOp::EOpType> ot, width = 1);
    int n, width = 1);

    ////////////////////////////////////////
    // width is the maximum width of any variable or expression in the expression tree
    // create expression trees that have variable width expressions
    // rw = random widths
    ////////////////////////////////////////

    CDOmExpr* createExprTreeRWRW(ECDOmVarType nt, width = 1);

    CDOmExpr* createExprTreeRW(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, width = 1);

    CDOmExpr* createExprTreeRW(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot, width = 1);

    CDOmExpr* createExprTreeRWNum(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, 
        int n, width = 1);

    CDOmExpr* createExprTreeRWNum(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot,
        int n, width = 1);

    CDOmExpr* createExprTreeRWNum(vector<CDOmExpr::EExprType> et, 
        vector<CDOmExprOp::EOpType> ot,
        int n, width = 1);
    ////////////////////////////////////////

    CDOmExpr* createExprTreeRW(ECDOmVarType nt, width = 1);

    CDOmExpr* createExprTreeRW(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, width = 1);

    CDOmExpr* createExprTreeRW(vector<CDOmExpr*> ve, 
        vector<CDOmExprOp::EOpType> ot, width = 1);

    CDOmExpr* createExprTreeRWNum(CDOmExpr::EExprType et, 
        CDOmExprOp::EOpType ot, 
        int n, width = 1);

    CDOmExpr* createExprTreeRWNum(vector<CDOmExpr*> ve, 
        vector<CDOmExprOp::EOpType> ot,
        int n, width = 1);

    CDOmExpr* createExprTreeRWNum(vector<CDOmExpr*> ve, 
        vector<CDOmExprOp::EOpType> ot,
        int n, width = 1);

    ////////////////////////////////////////

    string createStmt(ECDOmVarType nt, width = 1);

    string createStmt(CDOmStmt::EStmtType et, 
        CDOmStmtOp::EOpType ot, width = 1);

    ////////////////////////////////////////

    CDOmStmt* createStmt(ECDOmVarType nt,  string exp, width = 1);

    CDOmStmt* createStmt(CDOmStmt::EStmtType et, 
        CDOmStmtOp::EOpType ot, width = 1);
    ////////////////////////////////////////
    // LHS = left hand side
    // RHS = right hand side
    // when creating statments the things to vary are the LHS and RHS widths
    // and the statement types
    // gt  = LHS width greater than the RHS width

    stringcreateStmtGt(ECDOmVarType nt,  string exp, width = 1);

    string createStmtGt(CDOmStmt::EStmtType et, 
        CDOmStmtOp::EOpType ot, width = 1);

    // lt  = RHS width greater than the LHS width

    string createStmtLt(ECDOmVarType nt,  string exp, width = 1);

    string createStmtLt(CDOmStmt::EStmtType et, 
        CDOmExpr* e width = 1);

    // gteq  = LHS width greater than or equal to the RHS width

    string createStmtGtEq(ECDOmVarType nt,  string exp, width = 1);

    string createStmtGtEq(CDOmStmt::EStmtType et, 
        CDOmExpr* e width = 1);

    // lteq  = RHS width greater than or equal to the LHS width

    string createStmtLtEq(ECDOmVarType nt,  string exp, width = 1);

    string createStmtLtEq(CDOmStmt::EStmtType et, 
        CDOmExpr* e width = 1);

    ////////////////////////////////////////

    // gt  = LHS width greater than the RHS width

    CDOmStmt* createStmtGt(ECDOmVarType nt,  string exp, width = 1);

    CDOmStmt* createStmtGt(CDOmStmt::EStmtType et, 
        CDOmExpr* e width = 1);

    // lt  = RHS width greater than the LHS width

    CDOmStmt* createStmtLt(ECDOmVarType nt,  string exp, width = 1);

    CDOmStmt* createStmtLt(CDOmStmt::EStmtType et, 
        CDOmExpr* e width = 1);

    // gteq  = LHS width greater than or equal to the RHS width

    CDOmStmt* createStmtGtEq(ECDOmVarType nt,  string exp, width = 1);

    CDOmStmt* createStmtGtEq(CDOmStmt::EStmtType et, 
        CDOmExpr* e width = 1);

    // lteq  = RHS width greater than or equal to the LHS width

    CDOmStmt* createStmtLtEq(ECDOmVarType nt,  string exp, width = 1);

    CDOmStmt* createStmtLtEq(CDOmStmt::EStmtType et, 
        CDOmExpr* e width = 1);

    ////////////////////////////////////////

    string createModule();
    CDOmModule* createModule();

    ////////////////////////////////////////

    // randomly generate the name using prefix in the front of the randomly generated name
    string createModulePrefix(string prefix);
    CDOmModule* createModulePrefix(string prefix);

    ////////////////////////////////////////

    string createModuleName(string name);
    CDOmModule* createModuleName(string name);

    ////////////////////////////////////////
    // add ports
    // add functions




    // ECDOmPortType;
    // ECDOmNetType;
*/

};
#endif
