//----------------------------------------------------------------------
//  Copyright (C) ***** TO BE COMPLETED *****
// 
//  All rights reserved. No part of this file may be reproduced, stored
//  in a retrieval system, or transmitted in any form or by any other means,
//  electronic, mechanical, photocopying, recording, or otherwise,
//  without the prior consent of ***** TO BE COMPLETED *****
//----------------------------------------------------------------------

#include <iostream>
#include "testDriver.h"
#include "Tools.h"

using namespace std;

#define MAXTESTNR 4

CTestBase* tabTest[] = { \
///*0*/    new CTestBitArray(), \
/*1*/    new CTestVeriNum(), \
///*2*/    new CTestRogueVeriNumFunctions(), \
/*3*/
    new CTestCDOmPathDecl() \
    /*new CTestSignalPort(), \
    new CTestSignalSingleton(), \
    new CTestEvent(), \
    new CTestExprValInt(), \
    new CTestExprValReal(), \
    new CTestStmtAssn(), \
    new CTestStmtIfElse(), \
    new CTestStmtLoop(), \
    new CTestStmtCase(), \
    new CTestCaseItem(), \
    new CTestModule(), \
    new CTestGate(), \
    new CTestSignalRef(), \
    new CTestExprOp(), \
    new CTestParam(), \
    new CTestContAssign(), \
    new CTestProcess(), \
    new CTestFunction(), \
    new CTestTask(), \
    new CTestBitRange() */\
};
void usage(){
    cout << "Bad line argument, try -h for help" << endl;
}

void printHelp(){
    cout << "Usage: Driver [OPTIONS]..." << endl;
    cout << "Executes tests from an input file" << endl;

    cout << "OPTIONS:" << endl;
    cout << "  -h\t\tPrints this help message" << endl;

    cout << "  -f FILE\tSets the input file to FILE" << endl;
    cout << "\t\tthere is a default input file for each test in testFile/" << endl;
    
    cout << "  -n NUMBER\tSelect the test number TEST"  << endl;
    cout << "  \t\t!!! without setting the test number the Driver will not test" << endl;
    cout << "  \t\tNUMBER may be: "                     << endl;
    cout << "  \t\t   0 - test VeriNum::BitArray"       << endl;
    cout << "  \t\t   1 - test VeriNum"                 << endl;
    cout << "  \t\t   2 - test Rogue VeriNum Functions" << endl;
    cout << "  \t\t   3 - test NSCdom::CDOmPathDecl"    << endl;
    /*
    cout << "  \t\tignore this for now   0 - test SignalPort" << endl;
    cout << "  \t\tignore this for now   1 - test SignalSingleton" << endl;
    cout << "  \t\tignore this for now   2 - test Event" << endl;
    cout << "  \t\tignore this for now   3 - test ExprValInt" << endl;
    cout << "  \t\tignore this for now   4 - test ExprValReal" << endl;
    cout << "  \t\tignore this for now   5 - test StmtAssn" << endl;
    cout << "  \t\tignore this for now   6 - test StmtIfElse" << endl;
    cout << "  \t\tignore this for now   7 - test StmtLoop" << endl;
    cout << "  \t\tignore this for now   8 - test StmtCase" << endl;
    cout << "  \t\tignore this for now   9 - test CaseItem" << endl;
    cout << "  \t\tignore this for now  10 - test Module" << endl;
    cout << "  \t\tignore this for now  11 - test Gate" << endl;
    cout << "  \t\tignore this for now  12 - test SignalRef" << endl;
    cout << "  \t\tignore this for now  13 - test ExprOp" << endl;
    cout << "  \t\tignore this for now  14 - test Param" << endl;
    cout << "  \t\tignore this for now  15 - test ContAssign" << endl;
    cout << "  \t\tignore this for now  16 - test Process" << endl;
    cout << "  \t\tignore this for now  17 - test Function" << endl;
    cout << "  \t\tignore this for now  18 - test Task" << endl;
    cout << "  \t\tignore this for now  19 - test BitRange" << endl;
    */
}


int main(int argc, char** argv) {
    int testnr = -1;
    char *input_file_name = NULL;
    bool change_input_file_name = false;

    int i = 1;

    while (i<argc){
        if(argv[i][0] != '-'){
            usage();
            return FINISH_ERR_SYNTAX;
        }

        switch (argv[i][1]){
            case 'h':
                printHelp();
                return FINISH_OK;
                break;
            case 'n':
                if(i+1>=argc || testnr != -1){
                    usage();
                    return FINISH_ERR_SYNTAX;
                }
                testnr = atoi(argv[i+1]);
                i+=2;
                break;
            case 'f':
                if(i+1>=argc || input_file_name != NULL){
                    usage();
                    return FINISH_ERR_SYNTAX;
                }
                        
                input_file_name = argv[i+1];        
                i+=2;
                break;
            default:
                usage();
                return FINISH_ERR_SYNTAX;
        }
            
    }
    
    if(testnr < 0 || testnr >= MAXTESTNR){
        usage();
        return FINISH_ERR_SYNTAX;
    }
    
    tabTest[testnr]->test(input_file_name);

    return 0;
}
