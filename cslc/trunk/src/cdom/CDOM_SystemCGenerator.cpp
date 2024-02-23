//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in par2t, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

//------------modified and partly implemented by Oana B--------------------

//----------------------------------------------------------------------

#include "CDOM_SystemCGenerator.h"
//#include "CDOM_SystemCTbGenerator.h" //-----OB added---
#include <fstream>
#include "../support/CommonSupport.h"
#include "../support/TypeDefs.h"



using namespace std;

extern RefString cslomClockName;
RefMap_RefStr_TVec inst_map;


using namespace NSCdom;

namespace NSCdomSystemCGenerator {  

	//depth counter -- used for indentation control
	TInt m_depth;


	//********************************************************************************
	// CSystemCConstrData class - OB added
	//********************************************************************************
	CSystemCConstrData::CSystemCConstrData() {

	}

	// return the name of the module
	RefString CSystemCConstrData::getTopModuleName() {
		return topModuleName;
	}

	// set the name of the module
	void CSystemCConstrData::setTopModuleName(const NSCdom::RefCDOmIdentifier &id) { 

		topModuleName = RefString(new std::string(*(id->getName())));
	}

	// add a new instance in the instances vector
	void CSystemCConstrData::addInstanceData(Ref_CSystemCConstrInstance &inst) {
		if(!instanceData.get()) {
			instanceData = Ref_TVec_CSystemCConstrInstance(new TVec_CSystemCConstrInstance);
		}
		instanceData->push_back(inst);
	}

         Ref_TVec_CSystemCConstrInstance CSystemCConstrData::getInstanceData() {
		return instanceData;
	}

  
  void CSystemCConstrData::addGenSignal(RefString port,RefString inst) {
    if(!genSignals.get()) {
      genSignals = Ref_TMap_RefString_RefString(new TMap_RefString_RefString);
    }
    genSignals->insert(std::make_pair(port,inst));

  }

  Ref_TMap_RefString_RefString CSystemCConstrData::getGenSignals() {
    return genSignals;
  }

	CSystemCConstrData::~CSystemCConstrData() {
		if(topModuleName.get()) {
			topModuleName.reset();
		}

		if(instanceData.get()) {
			instanceData.reset();
		}

		if(genSignals.get()) {
			genSignals.reset();
		}

	}

	//********************************************************************************
	// CSystemCConstrInstance class - OB added
	//********************************************************************************
	CSystemCConstrInstance::CSystemCConstrInstance() {

	}

	void CSystemCConstrInstance::setModuleName(RefString &module) {
		moduleName = RefString(new std::string(*module)); 
	}
  
	RefString CSystemCConstrInstance::getModuleName() {
		return moduleName;
	}
  
	void CSystemCConstrInstance::setInstanceName(RefString &inst) {
		instanceName = RefString(new std::string(*inst));
	}

	RefString CSystemCConstrInstance::getInstanceName() {
		return instanceName;
	}

	// add a new f2a in the F2AData vector
	void CSystemCConstrInstance::addF2AData(Ref_CSystemCConstrF2A &f2a) {
		if(!F2AData.get()) {
			F2AData = Ref_TVec_CSystemCConstrF2A(new TVec_CSystemCConstrF2A);
		}
		F2AData->push_back(f2a);
	}

	Ref_TVec_CSystemCConstrF2A CSystemCConstrInstance::getF2AData() {
		return F2AData;
	}

	CSystemCConstrInstance::~CSystemCConstrInstance() {
		if(moduleName.get()) {
			moduleName.reset();
		}

		if(instanceName.get()) {
			instanceName.reset();
		}

		if(F2AData.get()) {
			F2AData.reset();
		}
	}


	//********************************************************************************
	// CSystemCConstrF2A class - OB added
	//********************************************************************************
	CSystemCConstrF2A::CSystemCConstrF2A() {

	}

        void CSystemCConstrF2A::addFormalActualExpr(RefTMap_RefString_RefCDOmExpr map) {
		if(!formalActualExpr.get()) {
			formalActualExpr = RefTMap_RefString_RefCDOmExpr(new TMap_RefString_RefCDOmExpr(*map));
		}
	}

	RefTMap_RefString_RefCDOmExpr CSystemCConstrF2A::getFormalActualExpr() {
		return formalActualExpr;
	}



	CSystemCConstrF2A::~CSystemCConstrF2A() {
		if(formalActualExpr.get()) {
			formalActualExpr.reset();
		}
	}

  //********************************************************************************
  // CSystemCVectors class - OB added
  //********************************************************************************

  void CSystemCVectors::addPort(RefCDOmPortDecl p) {
    if(!ports.get()) {
      ports = Ref_TVec_RefCDOmPortDecl(new TVec_RefCDOmPortDecl);
    }
    ports->push_back(p);
}

  Ref_TVec_RefCDOmPortDecl CSystemCVectors::getPorts() {
    return ports;
  }

  void CSystemCVectors::setUnit(RefString u) {
    if(!unitName) {
      unitName = RefString(new std::string);
    }
    unitName = u;
  }

  RefString CSystemCVectors::getUnit() {
    return unitName;
  }

  CSystemCVectors::~CSystemCVectors() {
    if(ports.get()) {
      ports.reset();
      }
  }

	//********************************************************************************//
	//                  CSystemCGenerator class                                       //
	//********************************************************************************//

	CSystemCGenerator::CSystemCGenerator(std::string filename):m_ctorFileName(filename) {

		//------OB commented---start
		// if (!filename.empty()) {
		//fileCpp = RefOfstream(new std::ofstream(filename.c_str()));
		//--------end
		
		//-------OB added---start
		out = &(std::cout);
		//--------end
	}
  
	CSystemCGenerator::~CSystemCGenerator() {
		//------OB commented---start
		//  if (file) {
		//    (*fileCpp).close();
		//  }
		//--------end
	}

	// global object used to hold constructor data
	Ref_CSystemCConstrData modDecl;
	// global object used to hold instances information
	Ref_CSystemCConstrInstance constrInst;
	// global object used to hold formals and actuals
	Ref_CSystemCConstrF2A F2As;
        // global object used to hold ports needed for VW
        Ref_TVec_CSystemCVectors vectors;
        Ref_CSystemCVectors oneVec;

	//********************************************************************************//
	//                 Helper Functions                                               //
	//********************************************************************************//

	void CSystemCGenerator::indt(TInt size) {
		size = size*2;
		for(int i=0; i < size; i++){
			*(out) << " ";
		}
	}

	//void CSystemCGenerator::indtFile(TInt size, RefOfstream file) { //---OB commented
	void CSystemCGenerator::indtFile(TInt size, std::ostream* file) {
		size = size*2;
		for(TInt i=0; i<size; ++i) {
			*(file) << " ";
		}
	}

	//void CSystemCGenerator::portListIndtFile(TInt size, RefOfstream file) { //---OB commented
	void CSystemCGenerator::portListIndtFile(TInt size, std::ostream* file) {
		for(TInt i=0; i<size; ++i) {
			*(file) << " ";
		}
	}


	void CSystemCGenerator::portListIndt(TInt size) {
		size = size*1;
		for(int i=0; i < size; i++){
			*(out) << " ";
		}
	}

 

	//------------OB added---start---copyright notice
	void CSystemCGenerator::copyrightNotice(std::string fileName){
		//Copyright notice

		*(out) << "//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER\n//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc" << std::endl;

	}
	//---------end

	//********************************************************************************//
	//                 Before traversal block                                         //
	//********************************************************************************//

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){
		//// calling indenter function ////
		indt(m_depth);

		*(out) << "#include \"" << *(fileInclude->getFileName()) << "\" " << std::endl;
  
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      ){
		//------OB added---start
		fileMain = new std::ofstream((m_ctorFileName + "main.cpp").c_str());
		m_showRange = TRUE;
		m_widthRange = TRUE; //----width as range
		//hasParam = FALSE;
		//---------end
		//Initializations
		out = fileMain; 
		m_design = design;
		m_depth = 0;
		m_addIndent = 0;
		m_designFuncIdNo = 1;
		m_designGenCode = TRUE;
		m_designTemplateModuleNamesVec = std::vector<std::string>();
		m_portWidthTypeMap = RefTMap_RefString_ESCPortWidthType(new TMap_RefString_ESCPortWidthType());
		contAssignNo = 1;
		  
		//Copyright notice
		copyrightNotice("main.cpp"); //------OB added
		*(out) << "#include \"SystemCVectorWriterTrace.h\" " << std::endl;
		*(out) << "#include \"SystemCVectorFunc.h\" " << std::endl;
		*(out) << "#include \"fpl_module_class.h\" " << std::endl;
		*(out) << "#include \"stim.h\" " << std::endl;


		// vector to store ports for every unit to be used by vector files
		if(!vectors) {
		  vectors = Ref_TVec_CSystemCVectors(new TVec_CSystemCVectors);
		}

		// create and write the Makefile
		std::ostream *fileMake;
		fileMake = new std::ofstream((m_ctorFileName + "Makefile").c_str());

		*(fileMake) << "ifeq ($(TARGET_ARCH), linux64) \nSYSTEMC_INCLUDE_DIR = $(SYSTEMC)/include \nBOOST_INCLUDE_DIR = $(BOOST_HOME) \nSYSTEMC_LIB_DIR = $(SYSTEMC)/lib-linux64\n";
        *(fileMake) << "else ifeq ($(TARGET_ARCH), x86_64) \nSYSTEMC_INCLUDE_DIR=$(SYSTEMC)/include \nBOOST_INCLUDE_DIR=$(BOOST_HOME) \nSYSTEMC_LIB_DIR=$(SYSTEMC)/lib-linux64\n";
		*(fileMake) << "else \nSYSTEMC_INCLUDE_DIR = $(SYSTEMC)/include\nBOOST_INCLUDE_DIR = $(BOOST_HOME) \nSYSTEMC_LIB_DIR = $(SYSTEMC)\nendif \n";
        *(fileMake) << "\nCC = g++ \nOPT    = -O3 \nDEBUG  = \n\nMODULE = main \n\n";
        *(fileMake) << "INCS = $(wildcard *.h) \nCPPS = $(INCS:.h=.o) \nMAINCPP = main.cpp \nMAIN = main \n\nOBJS = $(CPPS:.cpp=.o) SystemCVectorFunc.o SystemCVectorWriterTrace.o  fpl_module_class.o\n\n";
        *(fileMake) << "INC_PATHS= -I. -I.. -I$(SYSTEMC_INCLUDE_DIR) -I$(WORK)/trunk/src/cdom/ -I$(BOOST_INCLUDE_DIR)\n";
        *(fileMake) << "LIB_PATHS =  -L$(SYSTEMC_LIB_DIR) -L$(CURDIR) -L.\nLIBS     =  -lsystemc\nSHORT_ARCHIVE_NAME = units\nARCHIVE            = lib$(SHORT_ARCHIVE_NAME).a\n\n";
        *(fileMake) << "all: $(ARCHIVE) main\n\nprint:\n\techo SYSTEMC_LIB_DIR = ${SYSTEMC_LIB_DIR}\n\techo BOOST_INCLUDE_DIR = ${BOOST_INCLUDE_DIR}\n\techo SYSTEMC_INCLUDE_DIR = ${SYSTEMC_INCLUDE_DIR}\n\techo TARGET_ARCH = $(TARGET_ARCH)\n\techo BOOST_INCLUDE_DIR = $(BOOST_INCLUDE_DIR)\n\techo incs = $(INCS)\n\techo srcs = $(SRCS)\n\techo objs = $(OBJS)\n\techo SHORT_ARCHIVE_NAME = $(SHORT_ARCHIVE_NAME)\n\techo ARCHIVE = $(ARCHIVE)\n\n";
        *(fileMake) << "$(ARCHIVE): $(OBJS)\n\t$(AR) $(ARFLAGS) $@ $^\n\n";
        *(fileMake) << "fpl_module_class.o: $(WORK)/trunk/src/cdom/fpl_module_class.cpp\n\t$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@\n\n";
        *(fileMake) << "%.o:%.cpp fpl_module_class.o\n\t$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@\n\n";
        *(fileMake) << "SystemCVectorFunc.o: $(WORK)/trunk/src/cdom/SystemCVectorFunc.cpp\n\t$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@\n\n";
        *(fileMake) << "%.o:%.cpp SystemCVectorFunc.o\n\t$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@\n\n";
        *(fileMake) << "SystemCVectorWriterTrace.o: $(WORK)/trunk/src/cdom/SystemCVectorWriterTrace.cpp\n\t$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@\n\n";
        *(fileMake) << "%.o:%.cpp SystemCVectorWriterTrace.o\n\t$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@\n\n%.o:%.h\n\t$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@\n\n";
        *(fileMake) << "$(MAIN): $(ARCHIVE)  $(MAINCPP) \n\t$(CC) $(CFLAGS) $(INC_PATHS) -L$(SYSTEMC_LIB_DIR) -L. $(MAINCPP)  -l$(SHORT_ARCHIVE_NAME) $(LIBS) -o main 2>&1  | c++filt\n\n";
        *(fileMake) << "clean:\n\trm -f $(OBJS) *.a main \n";

		delete fileMake;

        // create and write the stim.h file with the stimulus module needed by vector files
		std::ostream *fileStim;
		fileStim = new std::ofstream((m_ctorFileName + "stim.h").c_str());

		*(fileStim) << "#include \"systemc.h\"\n\nSC_MODULE(stim) {\n";
		*(fileStim) << "  // input and output ports declared by the user\n";
        *(fileStim) << "  void stimGen() {\n\n";
		*(fileStim) << "  // ouput ports that will be connected to the DUT are written with values\n";
        *(fileStim) << "  }\n\n";
        *(fileStim) << "  SC_CTOR(stim) {\n    SC_THREAD(stimGen);\n    dont_initialize();\n    // sensitvity list, usually is clock: sensitive << clk.pos();\n  }\n};\n";

		delete fileStim;


	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ){


		//-------OB added---start
		m_currentModuleName = moduleDecl->getModuleName(); // module name
		//m_inputNumActual = FALSE; // there is no number used as an actual in a f2a connection with an input port
		m_isNumActual = FALSE; // there is no number used as an actual in a f2a connection with an output port
		m_partSelActual = FALSE; // there is no part select used in a f2a connection with an input port
		m_isExprActual = FALSE; // there is no num expression used in a f2a connection
		m_exprSigPortActual = FALSE; // there is no sigs/ports expression used in a f2a connection
		m_moduleCslType = moduleDecl->getCslSourceUnitType();
		
		// header file name for each module except vectors
		m_moduleFileName = RefString(new std::string(*m_currentModuleName + std::string(".h")));
        std::cout << "module:" << *m_moduleFileName << endl;

        if(moduleDecl->getType() == TYPE_DECL_MODULE) {

          //std::cout << "module decl\n";
        }

		out = fileMain;

        /*
        RefTVec_RefCDOmBase instVec;
        //instVec = 	moduleDecl->getInstancesDeclarationsAsBase();
        instVec = moduleDecl->getChildrenAsBase(TYPE_MODULE_INSTANTIATION);
        TVec_RefCDOmBase_const_iter itt;
        if(instVec) {
          for(itt = instVec->begin(); itt != instVec->end(); itt++) {
            RefString modInst = RefString (new std::string(*(CDOmModuleOrUdpInstantiation::cast(*itt))->getModuleExprLink()->getName() ) );
            //RefString modInst = RefString (new std::string(*(CDOmIdentifier::cast(*itt))->getName() ) );
		    cout << "\n!!!!!!" << *modInst << "\n\n";
          }
        }
        */ 

		if(m_moduleCslType != CDOmModuleDecl::GEN_FROM_TB && *m_currentModuleName != "stim_expect_mem_template"){
		  //cout<< "----------------------------------Gen from tb:" << *m_moduleFileName << std::endl;
		  // include header files in main.cpp without vectors and tb for now
		  *(out) << "#include \"" << *m_moduleFileName << "\"" << std::endl;
		
		}

		// create a header file for each module
		if(m_moduleCslType == CDOmModuleDecl::GEN_FROM_TB || *m_currentModuleName == "stim_expect_mem_template")  {
		  fileH = new std::ofstream("");
		  fileCpp = new std::ofstream("");

		  //fileTb = new std::ofstream((m_ctorFileName + std::string("tb_sysc.h")).c_str());
		  //*(fileTb) << "#include \"systemc.h\"\n\n";
		}
		else {
		  fileH = new std::ofstream((m_ctorFileName + *m_moduleFileName).c_str());
          fileCpp = new std::ofstream((m_ctorFileName + *m_currentModuleName + std::string(".cpp")).c_str());
		}
		out = fileH;
	

		// each module should have a stim and exp VW that use the ports in the module
		if(!oneVec) {
		  oneVec = Ref_CSystemCVectors(new CSystemCVectors);
		}
		oneVec->setUnit(m_currentModuleName);
		
		
		
		file = TRUE;
		// m_inst = FALSE;
		//--------end
		m_modcnt = 0;
		m_depth++;

		//----------OB added-----start
		m_portItemSize = -1; //for the case when no port item is created
		RefTVec_RefCDOmPortItem portItemVec = moduleDecl->getPortItems();
		if(portItemVec.get()){
			m_portItemSize = portItemVec->size();
		}

		//--------end


		RefTVec_RefCDOmParamDecl paramDeclVec = moduleDecl->getChildren<CDOmParamDecl>(TYPE_PARAM_DECL);
		if(paramDeclVec.get()) {
			TBool ok = FALSE;
			TVec_RefCDOmParamDecl_const_iter iter = paramDeclVec->begin();
			for(; iter != paramDeclVec->end(); ++iter) {
				if((*iter)->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
					ok = TRUE;
					break;
				}
			}
    
			if(ok) {
				iter = paramDeclVec->begin();
				//*(out) << "template<";
				TBool closeTemplate = TRUE;
				std::string paramType;
				for(; iter != paramDeclVec->end(); ++iter) {
					if((*iter)->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
						RefTVec_RefCDOmIdentifier idVec = (*iter)->getIDs();
						TVec_RefCDOmIdentifier_const_iter idIter = idVec->begin();
						for(; idIter != idVec->end(); ++idIter) {
							if(iter == paramDeclVec->begin() && 
							   idIter == idVec->begin()) {
								if((*idIter)->getPayload()->getType() == TYPE_EXPR) {
									RefCDOmExpr payloadExpr = CDOmExpr::cast((*idIter)->getPayload()->getChild(0));
									switch(payloadExpr->getExprType()) {
									case CDOmExpr::EXPR_NUMBER : *(out) << "template<int "         << *(*idIter)->getName() << " = "   << CDOmNumber::cast(payloadExpr)->getValue(); 
										break;
									case CDOmExpr::EXPR_STRING : *(out) << "template<std::string " << *(*idIter)->getName() << " = \"" << *CDOmString::cast(payloadExpr)->getTokenString() << "\""; 
										break;
									case CDOmExpr::EXPR_OP     : *(out) << "template<int "         << *(*idIter)->getName() << " = ";
										//parseExprOp(CDOmExprOp::cast(payloadExpr), out); 
										break;
									default                    : closeTemplate = FALSE;
										break;
									}
								}
							}
							else {
								if((*idIter)->getPayload()->getType() == TYPE_EXPR) {
									RefCDOmExpr payloadExpr = CDOmExpr::cast((*idIter)->getPayload()->getChild(0));
									if(closeTemplate) {
										switch(payloadExpr->getExprType()) {
										case CDOmExpr::EXPR_NUMBER : *(out) << ", int "         << *(*idIter)->getName() << " = " << CDOmNumber::cast(payloadExpr)->getValue(); 
											break;
										case CDOmExpr::EXPR_STRING : *(out) << ", std::string " << *(*idIter)->getName() << " = \"" << *CDOmString::cast(payloadExpr)->getTokenString() << "\""; 
											break;
										case CDOmExpr::EXPR_OP     : *(out) << ", int "         << *(*idIter)->getName() << " = ";
											//parseExprOp(CDOmExprOp::cast(payloadExpr), out);
											break;
										}
									}
									else {
										switch(payloadExpr->getExprType()) {
										case CDOmExpr::EXPR_NUMBER : *(out) << "template<int "         << *(*idIter)->getName() << " = "   << CDOmNumber::cast(payloadExpr)->getValue(); 
											closeTemplate = TRUE;
											break;
										case CDOmExpr::EXPR_STRING : *(out) << "template<std::string " << *(*idIter)->getName() << " = \"" << *CDOmString::cast(payloadExpr)->getTokenString() << "\""; 
											closeTemplate = TRUE;
											break;
										case CDOmExpr::EXPR_OP     : *(out) << "template<int "         << *(*idIter)->getName() << " = "; 
											//parseExprOp(CDOmExprOp::cast(payloadExpr), out);
											closeTemplate = TRUE;
											break;
										default                    : closeTemplate = FALSE;
											break;
										}
									}
								}
							}
						}
					}
				}
				if(closeTemplate) {
					m_designTemplateModuleNamesVec.push_back(*moduleDecl->getModuleName());
					*(out) << ">\n";
				}
			}
		}

		*(out) << "#ifndef INC_GUARD_" << *moduleDecl->getModuleName() << "_h\n";

		*(out) << "#define INC_GUARD_" <<  *moduleDecl->getModuleName() << "_h\n\n";

		(*out) << "#include \"systemc.h\"\n";
		(*out) << "#include \"SystemCVectorWriterTrace.h\"\n";
		(*out) << "#include \"SystemCVectorFunc.h\"\n";
        *(out) << "#include \"fpl_module_class.h\"\n";


		// include the h files for every module instantiated in the current module
		// get the module names of the instances in the current module
		RefTVec_RefCDOmBase moduleVec = moduleDecl->getInstantiationsAsBase();
		TVec_RefCDOmBase_const_iter it;
		if(moduleVec.get()) {
		  // include the h file for each module instance only once
		  RefString modInst =  RefString (new std::string(  *(CDOmModuleOrUdpInstantiation::cast(* moduleVec->begin()))->getModuleExprLink()->getName() ) ); 
		  *(out) << "#include \"" << *modInst << ".h\"\n";
		  for(it = moduleVec->begin(); it != moduleVec->end(); it++) {
		    if(*(CDOmModuleOrUdpInstantiation::cast(*it))->getModuleExprLink()->getName() == *modInst) {
		      continue;
		    }
		    modInst = RefString (new std::string(*(CDOmModuleOrUdpInstantiation::cast(*it))->getModuleExprLink()->getName() ) );
		    *(out) << "#include \"" << *modInst << ".h\"\n";
		    //cout<< "mda:" << *(CDOmModuleOrUdpInstantiation::cast(*it))->getModuleExprLink()->getName() << "\n";
		  }
		  
		  modInst.reset();
		}

		*(out) << "\n";


		
		/* RefString modInst =  RefString (new std::string( *(*((modDecl->getInstanceData())->begin()))->getModuleName() ) );
		*(out) << "#include \"" << *modInst << ".h\"\n";
		for(it1 = (modDecl->getInstanceData())->begin(); it1 != (modDecl->getInstanceData())->end(); it1++) {

		    if((*(*it1)->getModuleName()) == *modInst) {
		      continue;
		    }
		    modInst = RefString (new std::string(*(*it1)->getModuleName()));
		    *(out) << "#include \"" << *modInst << ".h\"\n";

		  }
		  modInst.reset(); */


        out = fileCpp;
  
        *(out) << "#include \"" << *m_moduleFileName << "\"\n" << std::endl;

        *(out) << "namespace ns_systemC {\n\n";

        out = fileH;
  
		if(moduleDecl->getKeywordType() == CDOmModuleDecl::KEYWORD_MODULE ||
		   moduleDecl->getKeywordType()==CDOmModuleDecl::KEYWORD_MACROMODULE) {
		  //*(out) << "#include \"" << *m_currentModuleName << "_class_includes.h\"" << "\n";


          *(out) << "namespace ns_systemC {\n\n";
          *(out) << "\nclass ";
		} else {
			*(out) << "/* Error in SC_MODULE declaration */" << std::endl;
		}



	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) {
		m_idPrintSemi = FALSE;
		m_inputExpr = FALSE;
		m_assignStmt = FALSE; // no assign statements

		if(TRUE == m_designGenCode) {
			//std::cout << "ID parent is " << id->getParent()->getType() << std::endl;
			RefCDOmBase parent = id->getParent();
			// add modules names
			if(parent->getType() == TYPE_DECL_MODULE){
				m_addIndent = id->getName()->size();

				//-----------OB added---start
				// create a new module object to build the constructor
				modDecl = Ref_CSystemCConstrData(new CSystemCConstrData::CSystemCConstrData);
				modDecl->setTopModuleName(id);
				*(out) << *(id->getName()) << " : public fpl_module\n";
				//----------------end
			}
			// add modules instances
			else if(parent->getParent()->getType() == TYPE_MODULE_INSTANTIATION) {
			  //-----------OB added---start

				// create a new object to hold the information about the instances in the constructor
				constrInst = Ref_CSystemCConstrInstance(new CSystemCConstrInstance::CSystemCConstrInstance);
				RefString instName = RefString(new std::string((*(id->getName()) + std::string("_"))));
				// add the instance name to constrInst object
				constrInst->setInstanceName(instName);

				// add constrInstr object to vector
				modDecl->addInstanceData(constrInst);

      
				//----------------end
			} 
			//-----------OB added---start

			// ports and signals declarations
			else if(parent->getType() != TYPE_PORT_ITEM) {
				*(out) << *(id->getName());
			}
    
			//----------------end

			if(id->supportsPayload()){
				RefCDOmBase payload = id->getPayload();
				if(payload.get()){
					//To be factored
					if (id->getIdType() == CDOmIdentifier::ID_UDP_PORT_OUTPUT_PL ||
						id->getIdType() == CDOmIdentifier::ID_PARAM ||
						(id->getIdType() == CDOmIdentifier::ID_VAR && 
						 payload->getType() != TYPE_RANGE_LIST) ||
						(id->getIdType() == CDOmIdentifier::ID_NET && 
						 payload->getType() != TYPE_RANGE_LIST) ||
						id->getIdType() == CDOmIdentifier::ID_PORT) { 
	  
						m_idPrintSemi = TRUE;
					}
				}
			}
		}
  
	
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ){}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ){
		//Initializations
		m_exprLinkExprSize = 0;
		m_exprLinkExprCnt = 0;
		m_exprLinkListExprSize = 0;
		if(TRUE == m_designGenCode) {
			RefCDOmBase parent = exprLink->getParent();
			ECDOmType parentType = parent->getType();
			TMap_RefString_ESCPortWidthType_const_iter mapIter = m_portWidthTypeMap->find(exprLink->getName());

			m_assignPartSel = FALSE; // there is no assign stmt with part sel


			if(!exprLink->isHID()) {
			  /*if(parentType != TYPE_PORT_ITEM && 
				   parentType != TYPE_INST_MODULE || 
				   parentType == TYPE_RANGE && m_rangeGenExpr) {

					// write names of instantiated modules
					if(TYPE_EXPR != parentType) { 
						//*(out) << *(exprLink->getName()); //-----OB new comm

					}
					} */

				// print LHS and signal/port RHS of assign statement
				if(TRUE == m_assignStmt && parentType != TYPE_EXPR && parentType == TYPE_ASSN) {
				  *(out) << *(exprLink->getName()); 
				  //cout<<">>>>>>>>>in before ExprLink:" << *(exprLink->getName()) << endl;
				}


				if(parentType == TYPE_INST_MODULE) {
					
					//-----OB added----start

					if(TRUE == m_actualExpr) {
					  
					  if(TRUE == m_partSelActual) {
					    
					    if(p == 'o') {
					      
					      // object to hold the information about the formals and actuals in the constructor
					      RefString actualName = RefString(new std::string(*(exprLink->getName())));
					      
					      // write part sel actual in f2a connection
					      *(out) << *actualName << ".read().range("; 
					      m_isExprActual = FALSE;

					      //cout<<"*********output formal with part sel:" << *(exprLink->getName()) << endl;

					    }
					    
					    //cout<< "----------addOutputActual : added actual for output port: " << *(exprLink->getName()) << endl; //---OB
					  }
					  else {
					    *(out) << *(exprLink->getName());
					    //cout<<"*********input formal with signal:" << *(exprLink->getName()) << endl;

					  }
					  
					}
					//-------end
				}


				// TMap_RefString_ESCPortWidthType_const_iter mapIter = m_portWidthTypeMap->find(exprLink->getName()); //---OB moved above

				// if the RHS is an expression with signals or ports
				if(TYPE_EXPR == parentType && 
				   CDOmExpr::EXPR_OP == CDOmExpr::cast(parent)->getExprType() && 
				   //	 mapIter != m_portWidthTypeMap->end()){  //---------OB commented
				   parent->getType() != TYPE_PORT_ITEM) {
				

					//-------OB added----start

				  // write RHS for assign statement
				  if(TRUE == m_assignStmt) {
				    *(out) << *(exprLink->getName()) << ".read()"; 
				    //cout<<">>>>>>in before ExprLink operator:" << *(exprLink->getName()) << endl;
				  }
				  else {

				    // f2a's with expression as actual
				    if(p == 'i') {
				      // generated signal name
				      
				      if(TRUE == m_actualExpr) {
					
					//cout<<"**********input port with signals/ports expr:" << *(exprLink->getName()) << endl;
					m_actualExpr = FALSE;
					
				      }
				      
				    } 					
				    else if(p == 'o') {
				      
				      
				      // object to hold the information about the formals and actuals in the constructor
				      RefString actualName = RefString(new std::string(*(exprLink->getName())));
				      
				      RefString s = RefString(new std::string(std::string(*actualName + std::string(".read()"))));
				      
				      if(TRUE == m_actualExpr) {
					*(out) << *s;
					
					//cout<<"*********output port with expr with sigs/p:" << *s << endl;
					
					
				      }
				      
				    }
				  }
	
					//cout<<"--------------added operand in actual expr:" << *s << endl; 

					//-------end


					//}



				}
				// print RHS if it's a concat/repl
				else if(TYPE_EXPR == parentType && 
					CDOmExpr::EXPR_CONCAT == CDOmExpr::cast(parent)->getExprType() && 
					parent->getType() != TYPE_PORT_ITEM) {
				  *(out) << *(exprLink->getName()); 
				  //cout<<">>>>>>>>>>>exprLink concat:" << *(exprLink->getName()) << endl;
				}
				else if(TYPE_EXPR == parentType && 
					CDOmExpr::EXPR_OP == CDOmExpr::cast(parent)->getExprType() && 
					parent->getType() != TYPE_PORT_ITEM) {
				  cout<<">>>>>>>exprLink part sel:" << *(exprLink->getName()) << endl;

				}
			}
			else {
				m_exprLinkHidNames = exprLink->getHidNames();
				m_exprLinkExprs = exprLink->getHidExprs();
				if(m_exprLinkHidNames.get()) { 
					m_exprLinkExprSize = m_exprLinkHidNames->size();
					*(out) << *(m_exprLinkHidNames->at(m_exprLinkExprCnt));
					if((m_exprLinkExprs->at(m_exprLinkExprCnt)).get())
						*(out) << "[";
				}
			}

			RefCDOmListExpr listExpr = exprLink->getArrayIndexes();
			if(listExpr.get()) {
				m_exprLinkListExprSize = listExpr->getChildrenSize();
			}
		}
		else {
			if(TYPE_EVENT_EXPR == exprLink->getParent()->getType()) {
				m_eventExprVec->push_back(exprLink);
			}
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ){

	  //cout<<"----------beforeTraversal(const NSCdom::RefCDOmExprOp begin" << endl;
		//Initializations
		m_exprCnt.push_back(0);
		m_exprOpCloseParen = FALSE;
		RefCDOmBase parent = exprOp->getParent();

		if(parent.get() && parent->getType() == TYPE_EXPR){

          if(CDOmExpr::cast(parent)->getExprType() == CDOmExpr::EXPR_MINTYPMAX && m_designGenCode){
				*(out) << "(";
			}
		}

		if(TRUE == m_designGenCode) {

          //std::cout << "before ExprOp:" <<  numOpsInExpr << std::endl;

          numOpsInExpr++; // increase the number of operands in expression

          

          //RefTVec_RefCDOmBase rangeChildrenVec = exprOp->getChildrenAsBase(TYPE_EXPR);
          RefTVec_RefCDOmExpr rangeChildrenVec = exprOp->getChildren<CDOmExpr>(TYPE_EXPR);
			// if the width is given as a range, then calculate the width using upper bound and lower bound
			if(rangeChildrenVec.get() && 
			   rangeChildrenVec->size() >= 2){ 
              for(int i = 0; i < rangeChildrenVec->size(); i++) {
				if(CDOmExpr::cast(rangeChildrenVec->at(i))->getExprType() == CDOmExpr::EXPR_NUMBER){
                  //std::cout << "smth:" << i << "  " <<  CDOmNumber::cast(rangeChildrenVec->at(i))->getValue() << "num ops:" << numOpsInExpr << std::endl;
                  if(CDOmNumber::cast(rangeChildrenVec->at(i))->getValue() > 1 && i == 0 && isRange == FALSE) {
                    //std::cout << "isRange in before exprOp is:" << isRange << std::endl;
                    *(out) << "<sc_uint<";
                  }
                }
                else if(CDOmExpr::cast(rangeChildrenVec->at(i))->getExprType() == CDOmExpr::EXPR_OP) {
                  //std::cout << "smth else :" << i << std::endl;
                }
            }
            }





			if(exprOp->isUnary()){
				switch(exprOp->getOpType()){
				case(CDOmExprOp::OP_UNARY_ARITHMETIC_PLUS)  : std::cout << "+\n"; *(out) << " + "                ;       break;
				case(CDOmExprOp::OP_UNARY_ARITHMETIC_MINUS) : *(out) << " - "                ;       break;
				case(CDOmExprOp::OP_UNARY_LOGIC_NOT)        : *(out) << " ! "                ;       break;
				case(CDOmExprOp::OP_UNARY_BITWISE_NOT)      : *(out) << " ~ "                ;       break;
				default                                     : *(out) << "Error" <<std::endl  ;       break;
				}
			}
			else if(exprOp->isBinary() && m_exprCnt.back() == 1) {
				switch(exprOp->getOpType()) {
				case(CDOmExprOp::OP_BINARY_BITWISE_XNOR)             : 
				case(CDOmExprOp::OP_BINARY_BITWISE_NOR)              : 
				case(CDOmExprOp::OP_BINARY_BITWISE_NAND)             : *(out) << " ~( ";         
					m_exprOpCloseParen = TRUE;       
					break;
					//default                                              : *(out) << "/*Error in binary expression */" <<std::endl;       break;
				}
			}
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ){
		//Initializations
		m_listExprCnt = 0;
		m_listExprHasExprLinkParent = false;
		m_listExprHasFunctionCallParent = false;
		m_parent = listExpr->getParent();
		if(m_parent.get()){
			if(m_parent->getType() == TYPE_EXPR){
				if((CDOmExpr::cast(m_parent))->getExprType() == CDOmExpr::EXPR_HID){
					m_listExprHasExprLinkParent = true;
					*(out) << "[";
				} else if((CDOmExpr::cast(m_parent))->getExprType() == CDOmExpr::EXPR_FUNCTION_CALL){
					m_listExprHasFunctionCallParent = true;
					*(out) << "(";
				}
			}
		}
		m_listExprSize = listExpr->getNumberOfChildren();
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) {
		//Initializations
		m_portDeclSigned = TRUE;
		m_width = TRUE; //-------OB added----has explicit width
		if(portDecl->getVarType() != VAR_TIME && 
		   portDecl->getVarType() != VAR_INTEGER){
			RefCDOmRange testRange = portDecl->getRange();
			m_pdcnt = testRange.get() ? -1 : 0; 
		}
		else{
			m_pdcnt = 0;
		}

		RefTVec_RefCDOmIdentifier idVec = portDecl->getIDs();
		if(idVec.get()){
			m_portIdSize = idVec->size();
		}

		//// calling indenter function ////
		indt(m_depth);

		if(portDecl->getRange().get()) {
			TVec_RefCDOmIdentifier_const_iter iter = idVec->begin();
			for(; iter != idVec->end(); ++iter) {
				m_portWidthTypeMap->insert(TPair_RefString_ESCPortWidthType((*iter)->getName(), TYPE_SC_VECTORED));

				// add the ports to the oneVec object for each module and add oneVec object to vectors object
				//cout << "\n\n adding ports to unit\n\n";
				oneVec->addPort(portDecl);
				vectors->push_back(oneVec);


				//-------OB added----start:if an input port is declared, add the name of the port to m_inputPortCon
				if(portDecl->getPortType() == PORT_INPUT || portDecl->getPortType() == PORT_INOUT) {
                  
                  p = 'i';
                  
                  //std::cout << "declared input port:" << *(*iter)->getName() << endl;
                  
                  // treat inout ports as input ports and add them to m_inputPortCon list
                  if(portDecl->getPortType() == PORT_INOUT) {

                    if(!m_inputPortCon.get()) {
                      m_inputPortCon = RefTList_RefString(new std::list<RefString>);
					}
					m_inputPortCon->push_back((*iter)->getName());
                    
                  }


					// add input ports and their width to map - width needed to declare generated signals
					if(!inputPortsMap.get()) {
					  inputPortsMap = Ref_TMap_RefString_TInt(new TMap_RefString_TInt);
					}
					formalName = (*iter)->getName();
					inputPortsMap->insert(TPair_RefString_TInt(formalName,0));
					m_inputPorts = TRUE;
					//cout<<">>>>>>>>insert input port in map:" << *formalName << endl;

				}

				//-------OB added----start:if an output port is declared, add the name of the port to m_outputPortCon
				if(portDecl->getPortType() == PORT_OUTPUT) {
                  /*if(!m_outputPortCon.get()) {
						m_outputPortCon = RefTList_RefString(new std::list<RefString>);
					}
					m_outputPortCon->push_back((*iter)->getName());*/
					p = 'o';
				}


				//-----end




			}
			switch (portDecl->getPortType()){
			case (PORT_INOUT)  :  *(out) << "sc_inout"                              ;      break;
			case (PORT_INPUT)  :  *(out) << "sc_in"                                 ;      break;
			case (PORT_OUTPUT) :  *(out) << "sc_out"                                ;      break;
			default            :  *(out) << "/*Error in port direction*/" << std::endl ;      break;
			}
   
		}
		else {
			TVec_RefCDOmIdentifier_const_iter iter = idVec->begin();
			for(; iter != idVec->end(); ++iter) {
				m_portWidthTypeMap->insert(TPair_RefString_ESCPortWidthType((*iter)->getName(), TYPE_SC_SIMPLE));
			}
    
			switch (portDecl->getPortType()){
			case (PORT_INOUT)  :  *(out) << "sc_inout_resolved "                       ;      break;
			case (PORT_INPUT)  :  *(out) << "sc_in_resolved "                          ;      break;
			case (PORT_OUTPUT) :  *(out) << "sc_out_resolved "                         ;      break;
			default            :  *(out) << "/*Error in port direction*/" << std::endl ;      break;
			}
		}

		//if(portDecl->getNetType()){
		//  switch (portDecl->getNetType()){
		//    case (NET_SUPPLY0) :         *(out) << "supply0 "                                 ;  break;
		//    case (NET_SUPPLY1) :         *(out) << "supply1 "                                 ;  break;
		//    case (NET_TRI)     :         *(out) << "tri "                                     ;  break;
		//    case (NET_TRIAND)  :         *(out) << "triand "                                  ;  break;
		//    case (NET_TRIOR)   :         *(out) << "trior "                                   ;  break;
		//    case (NET_TRI0)    :         *(out) << "tri0 "                                    ;  break;
		//    case (NET_TRI1)    :         *(out) << "tri1 "                                    ;  break;
		//    case (NET_WIRE)    :         *(out) << ""                                         ;  break;
		//    case (NET_WAND)    :         *(out) << "wand "                                    ;  break;
		//    case (NET_WOR)     :         *(out) << "wor "                                     ;  break;
		//    case (NET_TRIREG)  :         *(out) << "trireg "                                  ;  break;
		//    default            :         *(out) << "/*Error in net declaration*/" << std::endl;  break;
		//  }
		//}else if(portDecl->getVarType()){
		//  if(portDecl->getVarType())
		//    if(portDecl->getVarType() != VAR_REG) {
		//      *(out) << "double ";
		//    }
		//  if(portDecl->getVarType()) {
		//    switch (portDecl->getVarType()){
		//      case VAR_REG      : *(out) << "reg "                                     ;  break;
		//      case VAR_REAL     : *(out) << "real "                                    ;  break;
		//      case VAR_REALTIME : *(out) << "realtime "                                ;  break;
		//      case VAR_TIME     : *(out) << "time "                                    ;  break;
		//      default           : *(out) << "/*Error in var declaration*/" << std::endl;  break;
		//    }
		//  }

		if(portDecl->getVarType() == VAR_UNDEFINED && 
		   (portDecl->getVarType() != VAR_INTEGER || 
			portDecl->getVarType() != VAR_TIME)){
			if(portDecl->isSigned()){
				m_portDeclSigned = TRUE;
			}
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ){
		//Initializations
		m_width = TRUE; //-------OB added----has explicit width
		RefTVec_RefCDOmIdentifier varIdVec = varDecl->getIDs();
		if(varIdVec.get()){
			m_varIdSize = varIdVec->size();
		}
		TVec_RefCDOmIdentifier_const_iter iter;


		m_varType = varDecl->getVarType();
		if(m_varType == VAR_REG){
			RefCDOmRange testRange = varDecl->getRange();
			if(testRange.get()){
				m_vrcnt = -1;
				if(varIdVec.get()) {
					for(iter = varIdVec->begin(); iter != varIdVec->end(); ++iter) {
						m_portWidthTypeMap->insert(TPair_RefString_ESCPortWidthType((*iter)->getName(), TYPE_SC_VECTORED));
					}
				}
			}
			else { 
				m_vrcnt = 0;
				if(varIdVec.get()) {
					for(iter = varIdVec->begin(); iter != varIdVec->end(); ++iter) {
						m_portWidthTypeMap->insert(TPair_RefString_ESCPortWidthType((*iter)->getName(), TYPE_SC_SIMPLE));
					}
				}
			} 
		}
		else {
			m_vrcnt = 0;
		}

		////// calling indenter function ////
		indt(m_depth);

		if(varDecl->getVarType()){
			switch (varDecl->getVarType()){
				//      case VAR_REG      :  varDecl->getRange().get() ? *(out) << "sc_lv" : *(out) << "sc_logic "   ;      break; //--------OB commented
			case VAR_REG      :  varDecl->getRange().get() ? *(out) << "sc_signal" : *(out) << "sc_logic "   ;      break; //---------OB modified (regs should be signals in systemC)
			case VAR_INTEGER  :  *(out) << "int "                                                        ;      break;
			case VAR_REAL     : 
			case VAR_REALTIME :  *(out) << "double "                                                     ;      break;
			case VAR_TIME     :  *(out) << "sc_time "                                                    ;      break;     
			default           :  *(out) << "/* Error in var declaration */" << std::endl                 ;      break;
			}
		}else{
			std::cerr << "Error in var type" << std::endl;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ){
		//Initializations
		m_width = TRUE; //-------OB added----has explicit width


		RefCDOmRange testRange = netDecl->getRange();
		m_ntcnt = testRange.get() ? -1 : 0; 

		RefTVec_RefCDOmIdentifier netIdVec = netDecl->getIDs();
		if(netIdVec.get()){
			m_netIdSize = netIdVec->size();
		}
		//indenter function
		indt(m_depth);

		if(netDecl->getNetType()){
			switch (netDecl->getNetType()) {
			case (NET_SUPPLY0) ://  *(out) << "supply0 "                                 ;      break;
			case (NET_WAND)    ://  *(out) << "wand "                                    ;      break;
			case (NET_WOR)     ://  *(out) << "wor "                                     ;      break;
				// case (NET_TRIREG)  ://  *(out) << "trireg "                                  ;      break;
			case (NET_SUPPLY1) ://  *(out) << "supply1 "                                 ;      break;
			case (NET_TRI)     ://  *(out) << "tri "                                     ;      break;
			case (NET_TRIAND)  ://  *(out) << "triand "                                  ;      break;
			case (NET_TRIOR)   ://  *(out) << "trior "                                   ;      break;
			case (NET_TRI0)    ://  *(out) << "tri0 "                                    ;      break;
			case (NET_TRI1)    ://  *(out) << "tri1 "                                    ;      break;
			case (NET_TRIREG)  :                   *(out) << "sc_signal"              ;      break; //------OB added
			case (NET_WIRE)    : testRange.get() ? *(out) << "sc_signal" 
					: *(out) << "sc_signal_resolved"       ;      break;
            default            :  *(out) << "/*Error in net declaration*/" << std::endl;      break;
			}
		} else {
			std::cerr << "Error in net type" << std::endl;
		}


		//condition: getNetDeclType returns NET_DECL_ID_ONLY
		//if (netDecl->getNetDeclType() == 1 && netDecl->getNetType() == NET_TRIREG){
		//  switch(netDecl->getChargeStrength()){
		//    case (CDOmNetDecl::CHARGE_STRENGTH_UNDEFINED):                                                 ;      break;
		//    case (CDOmNetDecl::CHARGE_STRENGTH_SMALL)    : *(out) << "( small )"                           ;      break;
		//    case (CDOmNetDecl::CHARGE_STRENGTH_MEDIUM)   : *(out) << "( medium )"                          ;      break;
		//    case (CDOmNetDecl::CHARGE_STRENGTH_LARGE)    : *(out) << "( large )"                           ;      break;
		//    default                                      : *(out) << "/*Error in charge strength decl*/"   ;      break;
		//  }
		//}
		////condition: getNetDeclType returns NET_DECL_ID_EXPR_PAIR
		//if (netDecl->getNetDeclType() == 2){
		//  switch(netDecl->getFirstDriveStrength()){
		//    case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "( supply0, "                       ;      break;
		//    case (DRIVE_STRENGTH_STRONG_0) : *(out) << "( strong0, "                       ;      break;
		//    case (DRIVE_STRENGTH_PULL_0)   : *(out) << "( pull0, "                         ;      break;
		//    case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "( weak0, "                         ;      break;
		//    case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "( highz0, "                        ;      break;
		//    case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "( supply1, "                       ;      break;
		//    case (DRIVE_STRENGTH_STRONG_1) : *(out) << "( strong1, "                       ;      break;
		//    case (DRIVE_STRENGTH_PULL_1)   : *(out) << "( pull1, "                         ;      break;
		//    case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "( weak1, "                         ;      break;
		//    case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "( highz1, "                        ;      break;
		//                                     //default                        : *(out) << "/* Error in drive strength */"     ;      break;
		//  }
		//  switch(netDecl->getSecondDriveStrength()){
		//    case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0 )"                       ;      break;
		//    case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0 )"                       ;      break;
		//    case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0 )"                         ;      break;
		//    case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0 )"                         ;      break;
		//    case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0 )"                        ;      break;
		//    case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1 )"                       ;      break;
		//    case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1 )"                       ;      break;
		//    case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1 )"                         ;      break;
		//    case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1 )"                         ;      break;
		//    case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1 )"                        ;      break;
		//                                     //default                        : *(out) << "/* Error in drive strength */"   ;      break;
		//  }
		//}

		//if(netDecl->getVectorAccessType() == CDOmNetDecl::VECTOR_ACCESS_VECTORED){
		//  *(out) << "vectored ";
		//}
		//else if (netDecl->getVectorAccessType() == CDOmNetDecl::VECTOR_ACCESS_SCALARED){
		//  *(out) << "scalared ";
		//}
		//if(netDecl->isSigned()){
		//  *(out) << "signed ";
		//}
		//
		//if(m_ntcnt == 0) {
		//  *(out) << "bool> ";
		//}
  
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmRange                           & range                       ){
		if(m_designGenCode) {
			m_rangeGenExpr = TRUE;
			m_rangeAsWidth = TRUE;
			m_widthRange = 0;
			m_binaryExpr = FALSE; //--------OB added---default is no width as binary expression
			m_minusExpr = FALSE; //--------OB added---default is no width as binary expression with a minus
            genSigWidth = FALSE; // no generated signals width
            isRange = FALSE; // width is not range

			//----------OB added----start

            //std::cout << "before cdom range\n";

			RefTVec_RefCDOmBase rangeChildrenVec = range->getChildrenAsBase(TYPE_EXPR);
			// if the width is given as a range, then calculate the width using upper bound and lower bound
			if(rangeChildrenVec.get() && 
			   rangeChildrenVec->size() == 2){ 
				if(CDOmExpr::cast(rangeChildrenVec->at(0))->getExprType() == CDOmExpr::EXPR_NUMBER && 
				   CDOmExpr::cast(rangeChildrenVec->at(1))->getExprType() == CDOmExpr::EXPR_NUMBER){
					m_showRange = CDOmNumber::cast(rangeChildrenVec->at(0))->getValue() || CDOmNumber::cast(rangeChildrenVec->at(1))->getValue();
					m_widthRange = CDOmNumber::cast(rangeChildrenVec->at(0))->getValue() - CDOmNumber::cast(rangeChildrenVec->at(1))->getValue() + 1;
                    //std::cout << "m_showRange is:" << m_showRange << std::endl;
                    //std::cout << "------width out of range is:" << m_widthRange << endl;
                    if(m_showRange)
                      *(out) << "<sc_uint<" << CDOmNumber::cast(rangeChildrenVec->at(0))->getValue() << " - " << CDOmNumber::cast(rangeChildrenVec->at(1))->getValue() << " + 1";
                    m_binaryExpr = FALSE;
                    isRange = TRUE;
                    //std::cout << "isRange in before range is:" << isRange << std::endl;
				}
			}
            if (rangeChildrenVec.get()) {
              if(CDOmExpr::cast(rangeChildrenVec->at(0))->getExprType() == CDOmExpr::EXPR_NUMBER || CDOmExpr::cast(rangeChildrenVec->at(1))->getExprType() == CDOmExpr::EXPR_NUMBER) {
                numOpsInExpr = 0; 
                genSigWidth = TRUE;
                if(m_widthRange == 1) {
                  *(out) << "<bool";
                  m_binaryExpr = FALSE;
                }
                else if(m_widthRange > 1 && isRange == FALSE){
                  *(out) << "<sc_uint<";
                  m_binaryExpr = TRUE;
                  m_width = TRUE;
                  m_minusExpr = TRUE;
                }
              }

            }
    
			//---------end

			//m_width = TRUE; //-------OB added
			if(m_showRange){ //---------OB added
				if(range->getParent()->getType() == TYPE_RANGE_LIST) {
					m_rangeGenExpr = FALSE;
					*(out) << "[";
				}
				else {
				  //*(out) << "<sc_int<"; // moved to where the width is written
				  //*(out) << "<bool"; // to be removed when other data types are implemented for the vector writer
					m_rangeExprs = 0;//----OB added
				}
			}

			else {
			  //*(out) << "<sc_int<"; // moved to where the width is written
			  //*(out) << "<bool"; // to be removed when other data types are implemented for the vector writer
			}
			//    m_rangeExprs = 0;//----OB commented
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmNum32                           & num                         ){
		if(TRUE == m_designGenCode) {


			//----OB added----start

			//cout<<"in beforeTrav num:" << num->getValue() << endl;

			m_inputExpr = FALSE; // there is no input port connected with an expression with numbers

			if(TRUE == m_width) {

               std::cout << "m_width is true\n";

			  if(m_showRange && m_widthRange != 1 && num->getValue() != 1){ 
			    
			    //if(m_binaryExpr == FALSE)
                //*(out) << "<sc_uint<"; // sc_uint data type only if width is not 1 and written only once if width is an expression

					if(m_widthRange > 1) {
					  
					  //*(out) << m_widthRange; // add width calculated from upper and lower bounds
                      //std::cout << "m_widthRange is:" << m_widthRange << std::endl;
						m_width = FALSE;  // finished adding the width
                        m_binaryExpr = FALSE;
                        m_minusExpr = FALSE;
						
						// add the width of the input port to the map - needed for the generated signal
						if(inputPortsMap.get() && TRUE == m_inputPorts) {
						  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
						  it->second = m_widthRange;
						  //cout<<">>>>>1>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
						  m_inputPorts = FALSE;
						}

                        //*(out) << "> ";

					}
					else {
					  
					  *(out) << num->getValue();
                      //std::cout << "num_getValue is: " << num->getValue() << std::endl;

                      //if(m_binaryExpr == FALSE)
                      //*(out) << "> ";


                      m_binaryExpr = FALSE; // width is not expression unless an operator is coming next
                      m_width = FALSE;  // finished adding the width
                      m_minusExpr = FALSE;

						// add the width of the input port to the map - needed for the generated signal
						if(inputPortsMap.get() && TRUE == m_inputPorts) {
						  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
						  it->second = num->getValue();
						  //cout<<">>>2>>>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
						  m_inputPorts = FALSE;
						}
					}

					
			  }

			  else if((TRUE == m_minusExpr || TRUE == m_binaryExpr) && num->getValue() != 1) {

				  *(out) << "<sc_uint<";  // sc_uint data type only if width is not 1
				  
				  *(out) <<  num->getValue();

                  //std::cout << "width with expr:" << num->getValue() << std::endl;
					m_minusExpr = FALSE;
                    m_binaryExpr = FALSE;
					m_width = FALSE;  // finished adding the width

					// add the width of the input port to the map - needed for the generated signal
					if(inputPortsMap.get() && TRUE == m_inputPorts) {
					  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
					  it->second = num->getValue();
					  //cout<<">>>3>>>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
					  m_inputPorts = FALSE;
					}

                    //*(out) << "> ";

              }
              else {
                
                //if(m_binaryExpr == FALSE && m_widthRange == 1)
                //*(out) << "<bool";
                if(genSigWidth = TRUE && num->getValue() == 1) {
                  *(out) << "<bool";
                  //std::cout << "bool\n";
                  genSigWidth = FALSE;
                  m_widthRange = 1;
                }
                else if(m_binaryExpr == TRUE)
                  *(out) << "1"; // if 1 is part of an expression width
                
                // for now, only width 1
                // *(out) << "1";    // default width is 1 
                m_binaryExpr = FALSE;
                m_width = FALSE;  // finished adding the width
                m_minusExpr = FALSE;
                
                // add the width of the input port to the map - needed for the generated signal
                if(inputPortsMap.get() && TRUE == m_inputPorts) {
                  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
                  it->second = 1;
                  //cout<<">>>>>>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
                  m_inputPorts = FALSE;
                }
                
              }
			}
            
			else if(TRUE == m_binaryExpr && !m_assignStmt) {
			  // for now, only width 1
			  // *(out) <<  num->getValue();
				m_binaryExpr = FALSE;
				m_isExprActual = FALSE;
				m_width = FALSE;  // finished adding the width
                m_minusExpr = FALSE;

				// add the width of the input port to the map - needed for the generated signal
				if(inputPortsMap.get() && TRUE == m_inputPorts) {
				  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
				  it->second = num->getValue();
				  //cout<<">>>>>>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
				  m_inputPorts = FALSE;
				}
				//cout<<"--in beforeTrav num:" << num->getValue() << endl;

			}

			// check if there is a number used as an actual in a connection with an input or output port
			else if(TRUE == m_isNumActual && m_actualExpr && !m_assignStmt) {
				// *(out) << num->getValue(); //------OB fileTemp comm

			  if(p == 'o') {
			    
			    *(out) << num->getValue();
			    cout<<"***********output port connected with number:" << num->getValue() << endl;
			  }
			  
			  m_inputExpr = FALSE;
			  m_isNumActual = FALSE;
			  m_isExprActual = FALSE;
			  m_binaryExpr = FALSE;
			  m_width = FALSE;  // finished adding the width
			  
			}

			// check if there is an expr used as an actual in a f2a connection 
			else if(TRUE == m_isExprActual && m_actualExpr && !m_assignStmt) {
			  
			  if(p == 'o') {
			    
			    // write the number from the actual expression in the right place
			      *(out) << num->getValue();
			      //cout<<"***********output port connected with expr:" << num->getValue() << endl;

			  }
			  
			  m_inputExpr = TRUE;
			  m_isNumActual = FALSE;
			  m_partSelActual = FALSE;
			  m_binaryExpr = FALSE;
			  m_width = FALSE;  // finished adding the width
			  
			  //-------end
			}
			else if(TRUE == m_partSelActual && m_actualExpr && !m_assignStmt) {
      
				if(p == 'o') {
				  std::stringstream ss;
				  ss << num->getValue();
				  RefString actualName;

					  // 2nd number in range has a "," before it to separate the 2 numbers in the range
					  if(rangeNo == 0) {
					    actualName = RefString(new std::string(ss.str()));
					    cout<<"!!!!!!!!rangeNo is 0\n";
					  }
					  else if(rangeNo == 1) {
					    actualName = RefString(new std::string("," + ss.str() + ")"));
					    cout<<"!!!!!!!!rangeNo is 1\n";
					  }
					  
					  *(out) << *actualName;
					  
					  rangeNo++;
				}

				m_inputExpr = TRUE;
				m_isExprActual = FALSE;
				m_isNumActual = FALSE;
				m_binaryExpr = FALSE;
				m_width = FALSE;  // finished adding the width

				cout<<">>>>>actual range:" << num->getValue() << endl;
      
			}
			// if there are numbers in statement
			else if(TRUE == m_assignStmt) {

			  if(TRUE == m_assignPartSel) {

			    // 2nd number in range has a "," before it to separate the 2 numbers in the range
			    if(rangeNo == 0) {
			      *(out) << ".range(" << num->getValue();
			    }
			    else if(rangeNo == 1) {
			      *(out) << "," << num->getValue() << ")";
			    }
			    rangeNo++;
			    cout<<">>>>>range:" << num->getValue() << endl;
			  }
			  else {
			    *(out) << num->getValue();
			    //cout<<">>>>>>>>in before num:" << num->getValue() << endl;
			  }
			  cout<<">>>>>>>>in before num:" << num->getValue() << endl;
			  m_binaryExpr = FALSE;
			  //m_assignPartSel = FALSE;
			}
			//------end

		}
  

	}


	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmReal                            & realNum                      ){
		*(out) << *(realNum->getTokenString());
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) {
		//Initializations
		m_intcnt = 0;
		m_moduleInstantiationParamNo = 0;
		m_moduleInstantIsTemlateClass = FALSE;
		m_moduleInstantiationType = moduleInstantiation->getModuleInstantiationType();
		m_moduleInstantiationName = RefString();
		m_moduleInstantParamExprVec = RefTVec_RefCDOmExpr();
		m_portItems = RefTVec_RefCDOmPortItem();

        //cout<<"\n in module instantation!!\n";

		//------Ob added---start
		RefTVec_RefCDOmBase exprsVec = moduleInstantiation->getChildrenAsBase(TYPE_EXPR);
		if(exprsVec.get()){
			//    m_intExprSize = exprsVec->size() - 1; //-1 because the first expr is the name of the instantiated module
			if((exprsVec->size() - 1) > 0){
				//      m_intHasParams = TRUE;
			}
		}
		//-----------end


		RefCDOmScope designScope = m_design->getAttachedScope();
		RefCDOmIdentifier moduleInstID = designScope->lookupLocal(moduleInstantiation->getModuleExprLink()->getName());
		if(moduleInstID.get()) {
			m_portItems = CDOmModuleDecl::cast(moduleInstID->getParent())->getPortItems();
            RefTVec_RefCDOmPortDecl inputPortsDecl;
            inputPortsDecl = CDOmModuleDecl::cast(moduleInstID->getParent())->getInputPortDecls();
            portDecl_iter itr;
            if(inputPortsDecl) {
              for(itr = inputPortsDecl->begin(); itr != inputPortsDecl->end(); itr++) {
                RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
                TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				
                for(; iterr != idVec->end(); ++iterr) {
                  //std::cout << "   port:" << *(*iterr)->getName() << "\n";

                  // add input ports that are formals to list

                  if(!m_inputPortCon.get()) {
                    m_inputPortCon = RefTList_RefString(new std::list<RefString>);
                  }
                  m_inputPortCon->push_back((*iterr)->getName());

                }
              }
            }


            RefTVec_RefCDOmPortDecl outputPortsDecl;
            outputPortsDecl = CDOmModuleDecl::cast(moduleInstID->getParent())->getOutputPortDecls();
            if(outputPortsDecl) {
              for(itr = outputPortsDecl->begin(); itr != outputPortsDecl->end(); itr++) {
                RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
                TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				
                for(; iterr != idVec->end(); ++iterr) {
                  std::cout << "   port:" << *(*iterr)->getName() << "\n";

                  // add output ports that are formals to list

                  if(!m_outputPortCon.get()) {
                    m_outputPortCon = RefTList_RefString(new std::list<RefString>);
                  }
                  m_outputPortCon->push_back((*iterr)->getName());

                }
              }
            }






              
		}
		m_moduleInstantiationName = moduleInstantiation->getModuleExprLink()->getName();


		cout << "\n\nm_moduleInstantiationName:" << *m_moduleInstantiationName << "\n";

		m_moduleInstantiationIndt = m_moduleInstantiationName->size() + 1; 
		RefTVec_RefCDOmModuleOrUdpInstance moduleOrUdpInstanceVec = moduleInstantiation->getModuleInstances();
		if(moduleOrUdpInstanceVec.get()) {
			m_instanceNumSize = moduleOrUdpInstanceVec->size();
		}

		m_moduleInstantParamExprVec = moduleInstantiation->getChildren<CDOmExpr>(TYPE_EXPR);

		if(m_moduleInstantiationType == CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_ORDERED_PARAM_ASSN) {
			if(m_moduleInstantParamExprVec.get()) {
				m_intcnt = 1 - m_moduleInstantParamExprVec->size();
				m_moduleInstantiationParamNo = m_moduleInstantParamExprVec->size() - 1;
			}
		}
		else if(m_moduleInstantiationType == CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN) {
			if(m_moduleInstantParamExprVec.get()) {
				m_moduleInstantiationParamNo = m_moduleInstantParamExprVec->size() - 1;
			}
		}

		if(m_designTemplateModuleNamesVec.end() != find(m_designTemplateModuleNamesVec.begin(), 
														m_designTemplateModuleNamesVec.end(), *m_moduleInstantiationName)) {
			m_moduleInstantIsTemlateClass = TRUE;
		}

		//// calling indenter function ////
		indt(m_depth);
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ){
		//Initializations
		m_inscnt = 0;
		m_insctrl = 0;
		m_moduleInstanceCloseParen = TRUE;
		m_moduleInstanceSize = 0;
		m_moduleInstanceExprSize = 0;
		m_moduleInstanceExprCnt = 0;
		m_moduleInstanceCnt = 0;
		m_moduleInstanceGenOrderedAsNamed = FALSE;
		m_emptyIndexesVec = RefTVec_TUInt();
		m_moduleInstanceIndt = (CDOmIdentifier::cast(moduleInstance->getChild(0))->getName())->size() + 3;

        std::cout<<"\n in module instance!!!\n";


		if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION) {
			m_moduleInstanceExprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
			if(m_moduleInstanceExprVec.get()) {
				TVec_RefCDOmBase_const_iter baseIter = m_moduleInstanceExprVec->begin();
				for(; baseIter !=  m_moduleInstanceExprVec->end(); ++baseIter) {
					if((*baseIter)->getChildrenSize() > 0) {
						m_moduleInstanceGenOrderedAsNamed = TRUE;
						break;
					}
				}
				m_moduleInstanceSize = m_moduleInstanceExprVec->size();
				m_moduleInstanceExprSize = m_moduleInstanceSize;
			}
			m_emptyIndexesVec = moduleInstance->getEmptyIndexes();
			if(m_emptyIndexesVec.get()) {
				reverse(m_emptyIndexesVec->begin(), m_emptyIndexesVec->end());
				m_moduleInstanceSize += m_emptyIndexesVec->size();
			}
		}
		// connection with ports as formals using names
		else if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
			m_moduleInstanceSize = moduleInstance->getExplicitPortMap()->size();
			RefTVec_RefCDOmBase exprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
            //std::cout << " before trav module inst - name port conn\n";
			if(exprVec.get()) {
				m_moduleInstanceExprSize = exprVec->size();
				TVec_RefCDOmBase_const_iter baseIter = exprVec->begin();

			}
		}

	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {}   

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {
		if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
			m_designGenCode = FALSE;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ){
		//Initializations
		m_paramOverrideCnt = 0;
		m_paramOverrideSize = paramOverride->getChildrenSize();

		//// calling indenter function ////
		indt(m_depth);

		*(out) << "defparam ";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ){
		m_minTypMaxCnt = 0;
		RefTVec_RefCDOmBase minTypMaxChildrenVec = minTypMax->getChildrenAsBase(TYPE_EXPR);
		if(minTypMaxChildrenVec.get()){
			m_minTypMaxChildren = minTypMaxChildrenVec->size();
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmDelay                           & delay                       ){
		//Initializations
		m_delayPos = 0;
		m_delaySize = delay->getChildrenSize();
		m_delayDeclType = delay->getDelayDeclType();
		switch(m_delayDeclType){
		case (CDOmDelay::DECL_1) : m_delayHasParanths = false; break;
		case (CDOmDelay::DECL_2) : m_delayHasParanths = false; break;
		case (CDOmDelay::DECL_3) : m_delayHasParanths = false; break;
		case (CDOmDelay::DECL_4) : m_delayHasParanths = true ; break;
		}
  

		RefCDOmBase parent = delay->getParent();
		if(parent.get() && parent->getType() == TYPE_STMT){
			if(CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_ASSN){
				//// calling indenter function ////
				indt(m_depth);  
			}
		}

		//  *(out) << "#"; //------OB commented
		*(out) << "wait("; //--------OB added
		if(m_delayHasParanths){
			//if(delay->getDelayType() == CDOmDelay::DELAY_2 || delay->getDelayType() == CDOmDelay::DELAY_3){
			*(out) << "(";
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ){
		m_stmtNonBlockingVec = RefTVec_RefCDOmStmt(new std::vector<RefCDOmStmt>);

		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;
 
		if(initOrAlways->getInitOrAlwaysType() == CDOmInitOrAlways::INIT_OR_ALWAYS_INIT ){
			*(out) << "initial ";
		} else if (initOrAlways->getInitOrAlwaysType() == CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS ){
			//*(out) << "void always_method_" << m_designFuncIdNo << "() {\n";
			//indt(m_depth);
			//*(fileTemp) << "SC_METHOD(always_method_" << m_designFuncIdNo << ");\n";
			//m_designFuncIdNo++;
			//indtFile(m_depth+2, fileTemp);
		}
		//the following may not be optimal but it works
		RefCDOmStmt initOrAlwaysChild = initOrAlways->getStmt();
		if(initOrAlwaysChild.get()){
			if(initOrAlwaysChild->getStmtType() == CDOmStmt::STMT_BLOCK_NAMED ||
			   initOrAlwaysChild->getStmtType() == CDOmStmt::STMT_BLOCK_UNNAMED){
				*(out) << std::endl;
			}
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmAssn                            & assn                        ){
		m_assnPos = 0;
		indtFile(m_depth, out);
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ){
		if(contAssn->hasDelay3()){
			m_contAssnPos = -1;
		} else {
			m_contAssnPos = 0;
		}
 
		RefTVec_RefCDOmAssn contAssnVec = contAssn->getNetAssns();
		m_contAssnSize = contAssnVec->size();

		//// calling indenter function ////
		(*out) << "\n";
		//indt(m_depth);
		//indtFile(m_depth+2, fileTemp);
		//(*fileTemp) << "SC_METHOD(cont_assign_" << m_designFuncIdNo << ");\n"; //------OB fileTemp comm
        out = fileH;
        (*out) << "  void cont_assign_" << m_designFuncIdNo << "();\n";

        out = fileCpp;
		(*out) << "  void " << *m_currentModuleName << "::cont_assign_" << m_designFuncIdNo << "() {\n";

		cout<<">>>>>>>in before contAssign" << m_designFuncIdNo << endl;

		m_assignStmt = TRUE; // there is an assign statement

		m_designFuncIdNo++;
		m_depth++;

		//----OB added

		m_assignHID = FALSE; // no assigns with signal/port as RHS

		TVec_RefCDOmAssn_const_iter it;
		for(it = contAssnVec->begin(); it != contAssnVec->end(); it++) {
		  if((*it)->getChildrenSize() > 0 && ((*it)->getExpr())->getExprType() == CDOmExpr::EXPR_HID) {
		    //cout<<">>>>>>>>>>>assign with expr!!!!\n";
		      m_assignHID = TRUE;
		  }
		}


		// if( contAssn->getFirstDriveStrength() != DRIVE_STRENGTH_UNDEFINED && contAssn->getSecondDriveStrength() != DRIVE_STRENGTH_UNDEFINED ){
		// *(out) << "(";
		// switch(contAssn->getFirstDriveStrength()){
		//   case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0, "                       ;      break;
		//   case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0, "                       ;      break;
		//   case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0, "                         ;      break;
		//   case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0, "                         ;      break;
		//   case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0, "                        ;      break;
		//   case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1, "                       ;      break;
		//   case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1, "                       ;      break;
		//   case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1, "                         ;      break;
		//   case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1, "                         ;      break;
		//   case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1, "                        ;      break;
		//   default                        : *(out) << "/* Error in drive strength */"   ;      break;
		// }
		// switch(contAssn->getSecondDriveStrength()){
		//   case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0"                       ;      break;
		//   case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0"                       ;      break;
		//   case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0"                         ;      break;
		//   case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0"                         ;      break;
		//   case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0"                        ;      break;
		//   case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1"                       ;      break;
		//   case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1"                       ;      break;
		//   case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1"                         ;      break;
		//   case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1"                         ;      break;
		//   case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1"                        ;      break;
		//   default                        : *(out) << "/* Error in drive strength */" ;      break;
		// }
		// *(out) << ") ";
		// }
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ){
		if(stmt->getStmtType() == CDOmStmt::STMT_NULL){
			//// calling indenter function ////
			indt(m_depth);

			*(out) << ";" << std::endl;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ){
		m_stmtBlockHasBlockingAssn = FALSE;
  
		//std::cerr << "printing stmtBlock children...\n";
		//RefTVec_RefCDOmBase childs = stmtBlock->getChildrenAsBase();
		//TVec_RefCDOmBase_const_iter iter = childs->begin();
		//for(; iter != childs->end(); ++iter) {
		//  std::cerr << "type: " << (*iter)->getType() << " ";  
		//}
		//std::cerr << "\nend...\n\n";

		if(!(stmtBlock->getChildrenAsBase()).get()){
			m_stmtBlockSize = 0;
		}
		else {
			m_stmtBlockSize = stmtBlock->getChildrenSize(); 
		}
 
		if(CDOmStmtBlock::BLOCK_PARALLEL == stmtBlock->getBlockType()){
			*(out) << "void nonblocking_" << m_designFuncIdNo << "() {\n";
			m_depth++;
			//(*fileTemp) << "SC_METHOD(nonblocking_" << m_designFuncIdNo << ");\n";
			//indtFile(m_depth, fileTemp);
			if(m_eventExprVec.get() && m_eventExprVec->size() > 0) {
			  //(*fileTemp) << "sensitive";
				TVec_RefCDOmExprLink_const_iter iter = m_eventExprVec->begin();
				//for(; iter != m_eventExprVec->end(); ++iter)
				  //(*fileTemp) << "<<" << *(*iter)->getName();
			}
			//(*fileTemp) << ";\n";
			++m_designFuncIdNo;  
		} 
		else if(CDOmStmtBlock::BLOCK_SEQUENTIAL == stmtBlock->getBlockType()) {
			RefTVec_RefCDOmStmt stmts = stmtBlock->getStmts();
			if(stmts.get()) {
				TVec_RefCDOmStmt_const_iter iter = stmts->begin();
				for(; iter != stmts->end(); ++iter) {
					if((*iter)->getType() == TYPE_STMT && CDOmStmt::cast(*iter)->getStmtType() == CDOmStmt::STMT_ASSN) {
						if(CDOmStmtAssn::cast(*iter)->getAssnType() == CDOmStmtAssn::ASSN_NON_BLOCKING) {
							//std::cerr << "****** type = " << CDOmStmtAssn::cast(*iter)->getAssnType() << std::endl;
							m_stmtNonBlockingVec->push_back(*iter);
						}
						else {
							m_stmtBlockHasBlockingAssn = TRUE;
						}
					}
					else if((*iter)->getType() == TYPE_STMT) {
						m_stmtBlockHasBlockingAssn = TRUE;
					}
				}
			}
		}
		RefCDOmBase stmtParent = stmtBlock->getParent();
		if(stmtParent->getType() == TYPE_STMT && 
		   (CDOmStmt::cast(stmtParent)->getStmtType() == CDOmStmt::STMT_IF ||
			CDOmStmt::cast(stmtParent)->getStmtType() == CDOmStmt::STMT_CASE ||
			CDOmStmt::cast(stmtParent)->getStmtType() == CDOmStmt::STMT_LOOP)) {
  
			(*out) << "{";
			//indtFile(m_depth, out);
		}
		else if(m_stmtBlockHasBlockingAssn == TRUE) {
			(*out) << "\n";
			indtFile(m_depth, out);
			(*out) << "void sequential_block_" << m_designFuncIdNo << "() {";
			m_depth++;
			//(*fileTemp) << "SC_METHOD(sequential_block_" << m_designFuncIdNo << ");\n";
			if(m_eventExprVec.get() && m_eventExprVec->size() > 0) {
			  //(*fileTemp) << "sensitive";
				TVec_RefCDOmExprLink_const_iter iter = m_eventExprVec->begin();
				//for(; iter != m_eventExprVec->end(); ++iter)
				  //(*fileTemp) << "<<" << *(*iter)->getName();
			}
			//(*fileTemp) << ";\n";
			++m_designFuncIdNo;  
		}
		if(stmtBlock->isNamed()){
			m_stmtBlockCnt = -1;
		} else {
			m_stmtBlockCnt = 0;
			*(out) << std::endl;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ){
		m_stmtAssnPos = 0;

		//// Indenter logic //// requires further optimization
		RefCDOmBase parent = stmtAssn->getParent();
		if(parent.get() && parent->getType() == TYPE_STMT){
			RefCDOmStmt stmtParent = CDOmStmt::cast(parent);
			if(stmtParent->getStmtType() != CDOmStmt::STMT_IF
			   && stmtParent->getStmtType() != CDOmStmt::STMT_CASE) { 
				//// calling indenter function ////
				indt(m_depth);
			} 
		}
		if(CDOmStmtAssn::ASSN_NON_BLOCKING == stmtAssn->getAssnType()) {
			m_designGenCode = FALSE;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ){ 
		m_eventExprVec = RefTVec_RefCDOmExprLink(new std::vector<RefCDOmExprLink>);
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ){
		m_eventExprCnt.push_back(0);
		m_eventExprType = -1;
		m_designGenCode = FALSE;
		m_eventExprType = eventExpr->getEventExprType();
		if( m_eventExprType == CDOmEventExpr::EVENT_EXPR_POSEDGE ){
			//*(out) << "posedge ";
		} else if ( m_eventExprType == CDOmEventExpr::EVENT_EXPR_NEGEDGE ) {
			//*(out) << "negedge ";
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){
		// *(out) << "#"; //----------OB commented
		*(out) << "wait("; //--------OB added
		if(delayCtrl->getDelayControlType() == CDOmDelayControl::DELAY_CONTROL_MINTYPMAX){
			*(out) << "( ";
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){
		//Initialization
		m_stmtPCAssnType = stmtPCAssn->getProcContAssnType();

		//// calling indenter function ////
		indt(m_depth);

		switch( m_stmtPCAssnType ){
		case (CDOmStmtProcContAssn::PROC_CONT_ASSN_ASSIGN  ) : *(out) << "assign "                        ;                break;
		case (CDOmStmtProcContAssn::PROC_CONT_ASSN_DEASSIGN) : *(out) << "deassign "                      ;                break;
		case (CDOmStmtProcContAssn::PROC_CONT_ASSN_FORCE   ) : *(out) << "force "                         ;                break;
		case (CDOmStmtProcContAssn::PROC_CONT_ASSN_RELEASE ) : *(out) << "release "                       ;                break;
		default                                              : *(out) << "/* Error in Proc Cont Assign */";                break;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){
		m_stmtPTCtrlPos = 0;
		//if(stmtPTCtrl->getParent()->getType() != TYPE_INITIAL_OR_ALWAYS){
		//  //// calling indenter function ////
		//  indt(m_depth);
		//}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
		//Initializations
		m_caseType = stmtCase->getCaseType();
		m_stmtCaseCnt = 0;
		m_stmtCaseDefault = stmtCase->hasDefault();
		m_stmtCaseSize = stmtCase->getChildrenSize();

		*(out) << std::endl;
		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;

		if(m_caseType == CDOmStmtCase::CASE_CASE){
			*(out) << "switch(";
		} 
		else if (m_caseType == CDOmStmtCase::CASE_CASE_Z) {
			*(out) << "casez ( ";
		} 
		else if (m_caseType == CDOmStmtCase::CASE_CASE_X) {
			*(out) << "casex ( ";
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
		//Initializations
		RefTVec_RefCDOmBase attrLists = stmtIf->getChildrenAsBase(TYPE_ATTR_LIST_COLLECTION);
		if(attrLists.get()){
			m_stmtIfCnt = -1;
			m_stmtIfHasAttrList = true;
		}else{
			m_stmtIfCnt = 0;
			m_stmtIfHasAttrList = false;
		}
		m_stmtIfSize = stmtIf->getChildrenSize();

		RefCDOmBase parent = stmtIf->getParent();
		//if(parent.get() && parent->getType() == TYPE_STMT){
		//  RefCDOmStmt parentStmt = CDOmStmt::cast(parent);
		//  if(parentStmt->getStmtType() == CDOmStmt::STMT_PROC_TIMING_CONTROL){
		//    *(out) << std::endl;
		//  }
		//}
    
		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;

		if(!m_stmtIfHasAttrList){
			*(out)  << "if(";
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
		//Initializations
		m_stmtLoopCnt = 0;
 
		*(out) << std::endl;

		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;

		m_stmtLoopType = stmtLoop->getLoopType();
		switch( m_stmtLoopType ) {
		case( CDOmStmtLoop::LOOP_FOREVER ) :   *(out) << "forever "               ;          break;
		case( CDOmStmtLoop::LOOP_REPEAT  ) :   *(out) << "repeat ( "              ;          break;
		case( CDOmStmtLoop::LOOP_WHILE   ) :   *(out) << "while ( "               ;          break;
		case( CDOmStmtLoop::LOOP_FOR     ) :   *(out) << "for ( "                 ;          break;
		default                            :   *(out) << "/* Unknown Loop Type */";          break;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
		//Initializations
		m_stmtTaskEnableSize = stmtTaskEnable->getChildrenSize();
		m_stmtTaskEnableCnt = 0;

		//// Indenter logic //// requires further optimization
		RefCDOmBase parent = stmtTaskEnable->getParent();
		if(parent.get() && parent->getType() == TYPE_STMT){
			if(!(CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_PROC_TIMING_CONTROL ||
				 CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_CASE)){
				//// calling indenter function ////
				indt(m_depth);
			}
		} 
		///////////////////////
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
		//Initializations
		m_stmtWaitCnt=0;

		//// calling indenter function ////
		indt(m_depth);

		*(out) << "wait (";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){

		//// calling indenter function ////
		indt(m_depth);

		*(out) << "disable ";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){
		*(out) << "<-";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
		//Initializations
		m_rangeExprPos = 0;
		m_partSelActual = TRUE; //--------OB added---part select is used in assign or f2a
		m_assignPartSel = TRUE;
		//out = fileTemp;
		m_rangeExprType = rangeExpr->getRangeExprType();
  
		rangeNo = 0;

		cout<<"+++in before range expr!!!!\n"; //-----OB
		// (*out) << ".read().range("; //----OB fileTemp comm

		// 
		if(m_assignHID) {
		  *(out) << ".read()";
		  cout<<"+++++++assign with part sel as HID\n";
		  m_assignHID = FALSE;
		}

	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
		//Initializations
		m_exprConcatPos = 0;
		m_exprConcatSize = exprConcat->getChildrenSize();
		*(out) << "(";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ){
		//Initializations
		m_exprMultiConcatPos = 0;
		*(out) << "(";
	}


	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmUdpDecl                          & udpDecl                    ){
		//Initializations
		m_udpcnt = 0;
		//combEntry initializations
		m_combEntryCnt = 0;
		m_combEntrySize = -1;
		RefTVec_RefCDOmBase combEntriesAsBase = udpDecl->getChildrenAsBase(TYPE_UDP_COMB_ENTRY);
		if(combEntriesAsBase.get())
			m_combEntrySize = combEntriesAsBase->size();
		//seqEntry initializations
		m_seqEntryCnt = 0;
		m_seqEntrySize = -1;
		RefTVec_RefCDOmBase seqEntriesAsBase = udpDecl->getChildrenAsBase(TYPE_UDP_SEQ_ENTRY);
		if(seqEntriesAsBase.get())
			m_seqEntrySize = seqEntriesAsBase->size();
		m_udpOutPortName = RefString();
		*(out) << "primitive ";
	}


	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmUdpPortDeclOutput                & udpPortDeclOutput                ) {
		//Initializations
		m_udpOutPortName = udpPortDeclOutput->getID()->getName();
		//indenter function
		indt(IND1);
		switch (udpPortDeclOutput->getPortType()){
		case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT)     :    *(out) << "output "                              ;      break;
		case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_REG)        :    *(out) << "reg "                                 ;      break;
		case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT_REG) :    *(out) << "output reg "                          ;      break;
		default                                                :    *(out) << "Error in port direction" << std::endl ;      break;
		}
	}


	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput                ) {
		m_udpPdInputCnt = 0;
		RefTVec_RefCDOmIdentifier idVec = udpPortDeclInput->getIDs();
		if(idVec.get()){
			m_portIdSize = idVec->size();
		}
		indt(IND1);
		*(out) << "input ";
	}


	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                    ) {
		indt(IND2);
		if(m_combEntryCnt == 0)
			*(out) << "table" << std::endl;
	}


	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                     ) {
		indt(IND2);
		if(m_seqEntryCnt == 0)
			*(out) << "table" << std::endl;
	}


	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                     ) {
		indt(IND2);
		*(out) << "initial ";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        ){
		//Initializations
		m_taskDeclCnt = 0;
		m_taskDeclPortItemSize = -1;
		RefTVec_RefCDOmBase portItemsVec = taskDecl->getChildrenAsBase(TYPE_TF_PORT_DECL);
		if(portItemsVec.get()) {
			m_taskDeclPortItemSize = portItemsVec->size();
		}

		*(out) << "task ";
		if(taskDecl->isAutomatic()){
			*(out) << "automatic ";
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                       ) {
		m_tfPortDeclSize = -1;
		if((tfPortDecl->getVarType() == VAR_REG ||
			tfPortDecl->getVarType() == VAR_UNDEFINED) && 
		   (tfPortDecl->getRange()).get())
			m_tfPortDeclCnt = -1;
		else 
			m_tfPortDeclCnt = 0;
		RefTVec_RefCDOmIdentifier idVec = tfPortDecl->getIDs();
		if(idVec.get()) {
			m_tfPortDeclSize = idVec->size();
		} 

		//  RefCDOmBase parent = tfPortDecl->getParent();
		//  if(parent.get() && (parent->getType() == TYPE_DECL_TASK && CDOmTaskDecl::cast(parent)->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST ||
		//      (parent->getType() == TYPE_DECL_FUNCTION && (CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE  ||
		//                                                   CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE ||
		//                                                   CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST))))
		//
		//    indt(IND1);
		ECDOmPortType portType = tfPortDecl->getPortType();
		ECDOmVarType varType = tfPortDecl->getVarType();

		switch(portType) {
		case(PORT_INPUT)  : *(out) << "input " ;   break;
		case(PORT_OUTPUT) : *(out) << "output ";   break;
		case(PORT_INOUT)  : *(out) << "inout " ;   break;
		}

		switch(varType) {
		case(VAR_REG)      : *(out) << "reg "      ;  break;
		case(VAR_INTEGER)  : *(out) << "integer "  ;  break;
		case(VAR_REAL)     : *(out) << "real "     ;  break;
		case(VAR_REALTIME) : *(out) << "realtime " ;  break;
		case(VAR_TIME)     : *(out) << "time "     ;  break;
		}
		if(varType == VAR_REG && tfPortDecl->isSigned())
			*(out) << "signed ";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
		//Initializations
		m_funcDeclCnt = 0;
		//m_funcDeclPos Override in case of Range Object present
		RefTVec_RefCDOmBase funcDeclRange = funcDecl->getChildrenAsBase(TYPE_RANGE);
		if(funcDeclRange.get()) {
			m_funcDeclCnt = -1;
			m_hasRange = true;
		}
		else
			m_hasRange = false;
		*(out) << std::endl;
		m_funcDeclType = funcDecl->getFuncDeclType();
		*(out) << "function ";
		if(funcDecl->isAutomatic()){
			*(out) << "automatic ";
		}
		if(funcDecl->isSigned()){
			*(out) << "signed ";
		}
		if(m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE || 
		   m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE) {
			switch(funcDecl->getVarType()) {
			case(VAR_INTEGER)  : *(out) << "integer "  ;  break;
			case(VAR_REAL)     : *(out) << "real "     ;  break;
			case(VAR_REALTIME) : *(out) << "realtime " ;  break;
			case(VAR_TIME)     : *(out) << "time "     ;  break;
			}
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmFunctionCall                        & functionCall                    ){
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmGenvarDecl                          & genvarDecl                      ){
		//Initializations
		m_genvarDeclCnt = 0;
		m_genvarDeclSize = genvarDecl->getChildrenSize();
		*(out) << "genvar ";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmGenInst                             & genInst                         ){
		*(out) << "generate " << std::endl;
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemNull                         & genItemNull                     ){
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemIf                           & genItemIf                       ){
		//Initializations
		m_genItemIfCnt = 0;
		m_genItemIfSize = genItemIf->getChildrenSize();
		*(out) << "if (";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemCase                         & genItemCase                     ){
		//Initializations
		m_genItemCaseCnt = 0;
		m_genItemCaseDefault = genItemCase->hasDefault();
		m_genItemCaseSize = genItemCase->getChildrenSize();

		*(out) << "case ( ";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemLoop                         & genItemLoop                     ){
		//Initializations
		m_genItemLoopCnt = 0;
		*(out) << "for( ";
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemBlock                        & genItemBlock                    ){
		//Initializations
		m_genItemBlockSize = genItemBlock->getChildrenSize(); 
		indt(IND1);

		*(out) << "begin ";//<< std::endl;

		if(genItemBlock->isNamed()){
			*(out) << ": ";
			m_genItemBlockCnt = -1;
		} else {
			m_genItemBlockCnt =  0;
			*(out) << std::endl;
		}
		//indt(IND3);
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmString                              & stringObj                       ){
		if(TRUE == m_designGenCode) {
			*(out) << "\"" << *(stringObj->getTokenString()) << "\"" ;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmEventDecl                           & eventDecl                       ){
		//Initializations
		m_eventDeclCnt = 0;
		RefTVec_RefCDOmIdentifier eventDeclVec = eventDecl->getIDs();
		if(eventDeclVec.get()){
			m_eventDeclSize = eventDeclVec->size();
		}else{
			m_eventDeclSize = 0;
		}
		*(out) << "event ";

	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmSpecifyBlock                        & specifyBlock                     ){
		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;

		*(out) << "specify " << std::endl;
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl       & pulseSSCd                        ){
		m_pulseSSCdType = pulseSSCd->getDeclType();

		//// calling indenter function ////
		indt(m_depth);

		switch(m_pulseSSCdType){
		case (CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONEVENT ): *(out) << "pulsestyle_onevent " ; break;
		case (CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONDETECT): *(out) << "pulsestyle_ondetect "; break;
		case (CDOmPulseStyleOrShowCancelledDecl::SHOWCANCELLED      ): *(out) << "showcancelled "      ; break;
		case (CDOmPulseStyleOrShowCancelledDecl::NOSHOWCANCELLED    ): *(out) << "noshowcancelled "    ; break;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmPathDecl                            & pathDecl                         ){
		//Initializations
		m_pathDeclIsSimple = false;
		//m_pathDeclIsSimpleAndFull = false;
		m_pathDeclIsEdge = false;
		m_pathDeclIsStateSimpleIf = false;
		m_pathDeclIsStateEdgeIf = false;
		m_pathDeclIsStateSimpleIfNone = false;
		m_pathDeclhasPolarityOp = false;
		//children counter
		m_pathDeclCnt = 0;
		//path decl type
		m_pathDeclReturn = pathDecl->getType();
		switch(m_pathDeclReturn){
		case(CDOmPathDecl::PATH_DECL_SIMPLE       ): m_pathDeclIsSimple            = true; break;
		case(CDOmPathDecl::PATH_DECL_EDGE         ): m_pathDeclIsEdge              = true; break;
		case(CDOmPathDecl::PATH_DECL_SIMPLE_IF    ): m_pathDeclIsStateSimpleIf     = true; break;
		case(CDOmPathDecl::PATH_DECL_EDGE_IF      ): m_pathDeclIsStateEdgeIf       = true; break;
		case(CDOmPathDecl::PATH_DECL_SIMPLE_IFNONE): m_pathDeclIsStateSimpleIfNone = true; break;
		}
		if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS || pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
			m_pathDeclhasPolarityOp = true;
		}

		//// Beginning of output ////

		//// calling indenter function ////
		indt(m_depth);

		if(m_pathDeclIsSimple || m_pathDeclIsEdge){
			*(out) << "( ";
		}
		if(m_pathDeclIsEdge){
			if( pathDecl->getEdgeIdentifier() == CDOmPathDecl::PATH_DECL_POSEDGE ){
				*(out) << "posedge ";
			}else if ( pathDecl->getEdgeIdentifier() == CDOmPathDecl::PATH_DECL_NEGEDGE ){
				*(out) << "negedge ";
			}
		}
		if(m_pathDeclIsStateSimpleIf || m_pathDeclIsStateEdgeIf){
			*(out) << "if ( " ;
		}
		if(m_pathDeclIsStateSimpleIfNone){
			*(out) << "ifnone ( ";
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmPathDelayValue                      & pathDelayValue                   ){
		if(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITH_PAREN){
			*(out) << "( ";
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmMinTypMaxList                       & minTypMaxList                    ){
		m_minTypMaxListCnt = 0;
		m_minTypMaxListSize = minTypMaxList->getNumberOfChildren();
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
		m_specifyTListCnt = 0;
		m_specifyTListSize = specifyTerminalList->getNumberOfChildren();
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmDelayedDataOrReference              & delayedDataOrRef                 ){
		m_delayedDataOrRefCnt = 0;
		m_delayedDataOrRefSize = delayedDataOrRef->getChildrenSize();
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                ){
		m_timingCheckType = timingCkEventCtrl->getTimingCheckType();
		switch(m_timingCheckType){
		case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_POSEDGE) : *(out) << "posedge "; break;
		case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_NEGEDGE) : *(out) << "negedge "; break;
		case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_EDGE   ) : {
			*(out) << "edge [ ";
			RefTVec_TInt m_timingCheckEdgeDescriptor = timingCkEventCtrl->getEdgeDescriptors();
			if(m_timingCheckEdgeDescriptor.get()){
				for(TVec_TInt_const_iter iter = m_timingCheckEdgeDescriptor->begin(); iter < m_timingCheckEdgeDescriptor->end(); iter++){
					switch(*iter){
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_01) : *(out) << "01 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_10) : *(out) << "10 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_x0) : *(out) << "x0 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_z0) : *(out) << "z0 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_x1) : *(out) << "x1 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_z1) : *(out) << "z1 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0x) : *(out) << "0x "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0z) : *(out) << "0z "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1x) : *(out) << "1x "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1z) : *(out) << "1z "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_X0) : *(out) << "X0 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_Z0) : *(out) << "Z0 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_X1) : *(out) << "X1 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_Z1) : *(out) << "Z1 "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0X) : *(out) << "0X "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0Z) : *(out) << "0Z "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1X) : *(out) << "1X "; break;
					case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1Z) : *(out) << "1Z "; break;
					}
				}
			}
			*(out) << "]";
		} break;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmTimingCheckEvent                    & timingCkEvent               ){
		if(timingCkEvent->canBeControlled()){
			m_timingCheckEventCnt = -1;
		}else{
			m_timingCheckEventCnt = 0;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmSystemTimingCheck                   & systemTimingCk              ){
		m_systemTimingCkCnt = 0;
		m_systemTimingCkSize = systemTimingCk->getChildrenSize();
		m_systemTimingCkType = systemTimingCk->getTimingCheckType();

		//// calling indenter function ////
		indt(m_depth);

		switch(m_systemTimingCkType){
		case(CDOmSystemTimingCheck::TIMING_CHECK_SETUP    ) : *(out) << "$setup ( "    ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_HOLD     ) : *(out) << "$hold ( "     ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_SETUPHOLD) : *(out) << "$setuphold ( "; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_RECOVERY ) : *(out) << "$recovery ( " ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_REMOVAL  ) : *(out) << "$removal ( "  ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_RECREM   ) : *(out) << "$recrem ( "   ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_SKEW     ) : *(out) << "$skew ( "     ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_TIMESKEW ) : *(out) << "$timeskew ( " ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_FULLSKEW ) : *(out) << "$fullskew ( " ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_PERIOD   ) : *(out) << "$period ( "   ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_WIDTH    ) : *(out) << "$width ( "    ; break;
		case(CDOmSystemTimingCheck::TIMING_CHECK_NOCHANGE ) : *(out) << "$nochange ( " ; break;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmGateInstantiation              & gateInstantiation         ){
		//// calling indenter function ////
		indt(m_depth);

		m_gateInstanceType = gateInstantiation->getPrimitiveType();
		switch(m_gateInstanceType){
		case (CDOmGateInstantiation::GATE_INST_CMOS    ) : *(out) << "cmos "     ; break;
		case (CDOmGateInstantiation::GATE_INST_RCMOS   ) : *(out) << "rcmos "    ; break;
		case (CDOmGateInstantiation::GATE_INST_BUFIF0  ) : *(out) << "bufif0 "   ; break;
		case (CDOmGateInstantiation::GATE_INST_BUFIF1  ) : *(out) << "bufif1 "   ; break;
		case (CDOmGateInstantiation::GATE_INST_NOTIF0  ) : *(out) << "notif0 "   ; break;
		case (CDOmGateInstantiation::GATE_INST_NOTIF1  ) : *(out) << "notif1 "   ; break;
		case (CDOmGateInstantiation::GATE_INST_NMOS    ) : *(out) << "nmos "     ; break;
		case (CDOmGateInstantiation::GATE_INST_PMOS    ) : *(out) << "pmos "     ; break;
		case (CDOmGateInstantiation::GATE_INST_RNMOS   ) : *(out) << "rnmos "    ; break;
		case (CDOmGateInstantiation::GATE_INST_RPMOS   ) : *(out) << "rpmos "    ; break;
		case (CDOmGateInstantiation::GATE_INST_AND     ) : *(out) << "and "      ; break;
		case (CDOmGateInstantiation::GATE_INST_NAND    ) : *(out) << "nand "     ; break;
		case (CDOmGateInstantiation::GATE_INST_OR      ) : *(out) << "or "       ; break;
		case (CDOmGateInstantiation::GATE_INST_NOR     ) : *(out) << "nor "      ; break;
		case (CDOmGateInstantiation::GATE_INST_XOR     ) : *(out) << "xor "      ; break;
		case (CDOmGateInstantiation::GATE_INST_XNOR    ) : *(out) << "xnor "     ; break;
		case (CDOmGateInstantiation::GATE_INST_BUF     ) : *(out) << "buf "      ; break;
		case (CDOmGateInstantiation::GATE_INST_NOT     ) : *(out) << "not "      ; break;
		case (CDOmGateInstantiation::GATE_INST_TRANIF0 ) : *(out) << "tranif0 "  ; break;
		case (CDOmGateInstantiation::GATE_INST_TRANIF1 ) : *(out) << "tranif1 "  ; break;
		case (CDOmGateInstantiation::GATE_INST_RTRANIF1) : *(out) << "rtranif1 " ; break;
		case (CDOmGateInstantiation::GATE_INST_RTRANIF0) : *(out) << "rtranif0 " ; break;
		case (CDOmGateInstantiation::GATE_INST_TRAN    ) : *(out) << "tran "     ; break;
		case (CDOmGateInstantiation::GATE_INST_RTRAN   ) : *(out) << "rtran "    ; break;
		case (CDOmGateInstantiation::GATE_INST_PULLDOWN) : *(out) << "pulldown " ; break;
		case (CDOmGateInstantiation::GATE_INST_PULLUP  ) : *(out) << "pullup "   ; break;
		default :  *(out) << "/* Unknown gate type */"                           ; break;
		}
		gateVec = gateInstantiation->getChildrenAsBase();
		m_gateInstanceSize = gateVec->size();
		m_gateInstanceCnt = 0;
		m_gateInstanceFlag = false;


	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmPulseControl                   & pulseControl              ){
		m_pulseControlSection = true;
		m_pulseControlSize = pulseControl->getChildrenSize();
		indt(m_depth);
		*(out) << "PATHPULSE$";
		if(!(m_pulseControlSize > 2)){
			m_pulseControlCnt = 0;
			*(out) << " = ( ";
			m_pulseControlLong = false;
		}else {
			m_pulseControlCnt = -2;
			m_pulseControlLong = true;
		}
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmAttrList                       & attrList                  ){
		//Initializations
		m_attrListSize = attrList->getChildrenSize();
		m_attrListCnt = 0;
  
		*(out) << "(* "; 
	}

	void CSystemCGenerator::beforeTraversal(const NSCdom::RefCDOmDefine                         & define                   ){
		m_defineType = define->getDefineType();
		if(m_defineType == CDOmDefine::DEFINE_TYPE_DEFINE){
			*(out) << "`define ";
		}
		else if(m_defineType == CDOmDefine::DEFINE_TYPE_UNDEF){
			*(out) << "`undef ";
		}
		*(out) << *(define->getMacroName()) << " ";
	}

	//********************************************************************************//
	//                     In traversal block                                         //
	//********************************************************************************//

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmDesign                          & design                      ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ){
		//--------OB added---start
		//  if(m_inst) {
		//   m_moduleFileName = RefString(new std::string(*m_currentModuleName + std::string(".h")));
		//    *(out) << "#include \"" << *m_moduleFileName << "\"" << std::endl;
		//  }

	  //------end
      out = fileH;

		m_modcnt++;
		if(m_modcnt == 1) {
			*(out) << " {\n  public:\n" << std::endl;
			//    *(fileTemp) << ") {" << std::endl; //------OB fileTemp comm
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ){
		//  hasParam = FALSE; //------OB added
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ){
		if(TRUE == m_designGenCode) {
			m_exprLinkExprCnt++;
			if(m_exprLinkExprCnt < m_exprLinkExprSize) {
				if((m_exprLinkExprs->at(m_exprLinkExprCnt - 1)).get())
					*(out) << "].";
				else
					*(out) << ".";
				*(out) << *(m_exprLinkHidNames->at(m_exprLinkExprCnt));
				if((m_exprLinkExprs->at(m_exprLinkExprCnt)).get())
					*(out) << "[";
			}
		}

		// if(m_exprLinkListExprSize) {
		//    if(m_exprLinkExprCnt == m_exprLinkExprSize)
		//      *(out) << "[";
		//    else if((m_exprLinkExprCnt > m_exprLinkExprSize) && (m_exprLinkExprCnt < m_exprLinkExprSize + m_exprLinkListExprSize))
		//      *(out) << "][";
		//    else if(m_exprLinkExprCnt == m_exprLinkExprSize + m_exprLinkListExprSize)
		//      *(out) << "]"; 
		//  }
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ){

	  //cout<<"----------inTraversal(const NSCdom::RefCDOmExprOp begin" << endl;
	  m_assignPartSel = FALSE; // no assign with part sel

		//m_posCnt++;
		m_exprCnt.back()++;
		if(TRUE == m_designGenCode) {
		  //cout<<"----------inTraversal(const NSCdom::RefCDOmExprOp if(TRUE == m_designGenCode) {" << endl;
			if(exprOp->isUnary() && 
			   m_exprCnt.back() == 1) {
				switch(exprOp->getOpType()) {
				case(CDOmExprOp::OP_UNARY_REDUCTION_AND)    : *(out) << ".and_reduce()"    ;   break;
				case(CDOmExprOp::OP_UNARY_REDUCTION_NAND)   : *(out) << ".nand_reduce()"   ;   break;
				case(CDOmExprOp::OP_UNARY_REDUCTION_OR)     : *(out) << ".or_reduce()"     ;   break;
				case(CDOmExprOp::OP_UNARY_REDUCTION_NOR)    : *(out) << ".nor_reduce()"    ;   break;
				case(CDOmExprOp::OP_UNARY_REDUCTION_XOR)    : *(out) << ".xor_reduce()"    ;   break;
				case(CDOmExprOp::OP_UNARY_REDUCTION_XNOR)   : *(out) << ".xnor_reduce()"   ;   break;
				}
			}
			else if(exprOp->isBinary() && 
					m_exprCnt.back() == 1){

			  //cout<<"----------binary op:" << endl;

				if(TRUE == m_assignStmt) {
				  switch(exprOp->getOpType()){
				  case(CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS)         : *(out) << " - "; break;
				  }
				}



				// if there are expressions used as actuals in f2a connections
				if(TRUE == m_exprSigPortActual || (TRUE == m_isExprActual && p == 'o')) {
				  cout<<"--------binary opp\n";
				  if(TRUE == m_actualExpr) {
				    cout<<"----------binary op: actual" << endl;

					switch(exprOp->getOpType()){
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS)          : std::cout << "+\n"; *(out) << " + "; break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS)         : *(out) << " - "; break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY)      : *(out) << " * "; break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_DIV)           : *(out) << " / "; break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_MOD)           : *(out) << " % "; break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_POW)           : *(out) << " ** "; break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT)    : *(out) << " << "; break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT)   : *(out) << " >> "; break;
					case(CDOmExprOp::OP_BINARY_EQUALITY_EQ)              : *(out) << " == "; break;
					case(CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ)          : *(out) << " != "; break;
					case(CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE)         : *(out) << " == "; break;
					case(CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE)     : *(out) << " != "; break;
					case(CDOmExprOp::OP_BINARY_LOGIC_AND)                : *(out) << " && "; break;
					case(CDOmExprOp::OP_BINARY_LOGIC_OR)                 : *(out) << " || "; break;
					case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS)          : *(out) << " < "; break;
					case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL)    : *(out) << " <= "; break;
					case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER)       : *(out) << " > "; break;
					case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL) : *(out) << " >= "; break;
					case(CDOmExprOp::OP_BINARY_BITWISE_AND)              : *(out) << " & "; break;        
					case(CDOmExprOp::OP_BINARY_BITWISE_NAND)             : 
					case(CDOmExprOp::OP_BINARY_BITWISE_OR)               : *(out) << " | "; break; 
					case(CDOmExprOp::OP_BINARY_BITWISE_NOR)              : 
					case(CDOmExprOp::OP_BINARY_BITWISE_XOR)              : *(out) << " ^ "; break; 
					case(CDOmExprOp::OP_BINARY_BITWISE_XNOR)             : 
					case(CDOmExprOp::OP_BINARY_SHIFT_LEFT)               : *(out) << " << "; break;
					case(CDOmExprOp::OP_BINARY_SHIFT_RIGHT)              : *(out) << " >> "; break;
					default                                              : *(out) << "/*Error in binary expression */" <<std::endl;       break;
					}

				  }
				} 
				else if(FALSE == m_inputExpr && p != 'i' && numOpsInExpr > 1) {
				  //cout<<"----------binary op: false" << endl;
					switch(exprOp->getOpType()){
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS)          : std::cout << "+\n"; *(out) << " + "                                        ;  m_binaryExpr = TRUE; m_width = TRUE;       break;
						
                      //----------OB commented----start
						//      case(CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS)         : if(TRUE == m_width) {    *(out) << " - "                                        ;  m_binaryExpr = TRUE;
						//      }
						//	break;
						//---------end

					case(CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS)         : {*(out) << " - ";            m_binaryExpr = TRUE;   m_width = TRUE;   m_minusExpr = FALSE;    }  break; //--------OB added
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY)      : *(out) << " * "                                        ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_DIV)           : *(out) << " / "                                        ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_MOD)           : *(out) << " % "                                        ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_POW)           : *(out) << " ** "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT)    : *(out) << " << "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT)   : *(out) << " >> "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_EQUALITY_EQ)              : *(out) << " == "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ)          : *(out) << " != "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE)         : *(out) << " == "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE)     : *(out) << " != "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_LOGIC_AND)                : *(out) << " && "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_LOGIC_OR)                 : *(out) << " || "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS)          : *(out) << " < "                                        ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL)    : *(out) << " <= "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER)       : *(out) << " > "                                        ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL) : *(out) << " >= "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_BITWISE_AND)              :         
					case(CDOmExprOp::OP_BINARY_BITWISE_NAND)             : *(out) << " & "                                        ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_BITWISE_OR)               : 
					case(CDOmExprOp::OP_BINARY_BITWISE_NOR)              : *(out) << " | "                                        ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_BITWISE_XOR)              : 
					case(CDOmExprOp::OP_BINARY_BITWISE_XNOR)             : *(out) << " ^ "                                        ;  m_binaryExpr = TRUE; m_width = TRUE;    break;
					case(CDOmExprOp::OP_BINARY_SHIFT_LEFT)               : *(out) << " << "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					case(CDOmExprOp::OP_BINARY_SHIFT_RIGHT)              : *(out) << " >> "                                       ;  m_binaryExpr = TRUE;  m_width = TRUE;   break;
					default                                              : *(out) << "/*Error in binary expression */" <<std::endl;       break;
					}
                    numOpsInExpr--; // as operands/operators are being written, decrease the number


				}
			}
			if(exprOp->isTernary()){
				if(m_exprCnt.back() == 1){
					*(out) << " ? ";
				} else if(m_exprCnt.
back() == 2){
					*(out) << " : ";
				}
			}
		}
		//cout<<"----------inTraversal(const NSCdom::RefCDOmExprOp end" << endl;
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ){
		m_listExprCnt++;
		if(m_listExprCnt < m_listExprSize && 
		   m_listExprSize > 1 ){
			if( m_listExprHasExprLinkParent){
				*(out) << "][";
			} else {
				*(out) << ", ";
			}
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ){
		m_pdcnt++;
		//if(m_pdcnt == 0) *(out) << "> ";
		if(m_pdcnt > 0 && m_pdcnt < m_portIdSize && m_portIdSize != 1){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ){
		//if(m_vrcnt < 0 && m_varType == VAR_REG) {
		//  *(out) << ">v ";
		//}

		m_vrcnt++;
		if(m_vrcnt > 0 && 
		   m_vrcnt < m_varIdSize && 
		   m_varIdSize > 1){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ){
		m_ntcnt++;
		//if(m_ntcnt == 0) *(out) << "> ";
		//if(m_ntcnt <= m_netIdSize && m_netIdSize != 1){
		if(m_ntcnt > 0 && 
		   m_ntcnt < m_netIdSize && 
		   m_netIdSize != 1){
			*(out) << ", ";
		}
	}


	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmRange                           & range                       ){
		if(TRUE == m_designGenCode) {
			if(TYPE_RANGE_EXPR == range->getParent()->getType() && 
			   0 == m_rangeExprs) {
				(*out) << ",";
			}
			else {
				// m_width = FALSE; //----------OB added
				// if(0 == m_rangeExprs)  (*out) << "-("; //---------OB commented
				// if(1 == m_rangeExprs)  (*out) << ")"; //----------OB commented
			}
		}
		if(m_showRange){ //------OB added
			m_rangeExprs++;
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmNum32                           & num                         ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmReal                            & realNum                     ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ){
		if(CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_ORDERED_PARAM_ASSN == m_moduleInstantiationType) {
			if(m_intcnt == 0 && m_moduleInstantiationParamNo == 0) {
				if(m_moduleInstantIsTemlateClass) {
					*(out) << "<>";
					m_moduleInstantiationParamNo = 1;
				}
				*(out) << " *";
			}
			else if(m_intcnt*(-1) == m_moduleInstantiationParamNo){
				*(out) << "<";
			}
			else if(m_moduleInstantiationParamNo != 0 && m_intcnt == 0) {
				*(out) << "> *";
			}
			else if(m_intcnt < 0){
				*(out) << ", ";
			}
		}
		else if(CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType) {
			if(m_intcnt == 0) {
				*(out) << "<> *";
			}
			if(m_intcnt < m_moduleInstantiationParamNo) {
				m_designGenCode = FALSE;
			}
			else {
				m_designGenCode = TRUE;
			}
		}
		else if(m_intcnt == 0) {
			if(m_moduleInstantIsTemlateClass) {
				*(out) << "<>";
			}
			// write pointer to module instance
			// *(out) << " *"; //-----OB new comm
		}

		m_intcnt++;
		if(m_intcnt > 1 && 
		   m_intcnt <= m_instanceNumSize && 
		   m_instanceNumSize != 1) {
			*(out) << ", " << std::endl;
			indt(m_depth);
			portListIndt(m_moduleInstantiationIndt);
			*(out) << "*";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) {

		//----OB modified---added + "_" so that module and module instance have different names
		std::string instanceName = (*CDOmIdentifier::cast(moduleInstance->getChild(0))->getName()) + "_"; 

		if(m_moduleInstanceCnt == 0 && (m_moduleInstantiationParamNo == 0 ||
										CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType)) {
			//   *(fileTemp) << "new " << *m_moduleInstantiationName; //-------OB fileTemp comm

			//-----OB added---start

			// set the name of the module which has instances
			RefString instModName = RefString(new std::string(*m_moduleInstantiationName));

			// add the instance name to constrInst object
			constrInst->setModuleName(instModName);


			// create a new object to hold the information about the formals and actuals in the constructor for each instance
			F2As = Ref_CSystemCConstrF2A(new CSystemCConstrF2A::CSystemCConstrF2A);

			//----end

			if(m_moduleInstantIsTemlateClass) {
			  //*(fileTemp) << "<>";
			}
			//    *(fileTemp) << "(\"" << instanceName << "\");\n";  //-------OB fileTemp comm
			m_moduleInstanceCloseParen = FALSE;
		}
		else if(m_moduleInstanceCnt == 0 && 
				CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_ORDERED_PARAM_ASSN == m_moduleInstantiationType) {
		  //*(fileTemp) << "new " << *m_moduleInstantiationName << "<";
			if(m_moduleInstantParamExprVec.get()) {
				TBool printComma = FALSE;
				TVec_RefCDOmExpr_const_iter iter = m_moduleInstantParamExprVec->begin();
				if((*iter)->getExprType() == CDOmExpr::EXPR_MINTYPMAX) {
					//parseExpr(*iter, fileTemp);
					printComma = TRUE;
				}
				++iter;
				for(; iter != m_moduleInstantParamExprVec->end(); ++iter) {
					if((*iter)->getExprType() == CDOmExpr::EXPR_MINTYPMAX) {
					  //if(printComma) *(fileTemp) << ", " ;
						//parseExpr(*iter, fileTemp);
						printComma = TRUE;
					}
				}
			}
			//*(fileTemp) << ">(\"" << instanceName << "\");\n";  
			m_moduleInstanceCloseParen = FALSE;
		}
		//else if(m_moduleInstanceCnt == 0 && 
		//        CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType) {
		//  


		if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
		  //RefTMap_RefString_RefCDOmExpr explicitPortNameMap = moduleInstance->getExplicitPortMap(); //-----OB comm
		  explicitPortNameMap = moduleInstance->getExplicitPortMap();
		  
          //RefCDOmIdentifier moduleInstID = moduleInstance->getModuleExprLink();
          //RefCDOmBase parent = moduleInstID->getParent();
          RefTVec_RefCDOmPortDecl inputPortsDecl;
          //if(parent)
            //inputPortsDecl = CDOmModuleDecl::cast(parent)->getInputPortDecls();

				portDecl_iter itr;
				/*if(inputPortsDecl) {
				  for(itr = inputPortsDecl->begin(); itr != inputPortsDecl->end(); itr++) {
                    RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
                    TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				    
                    for(; iterr != idVec->end(); ++iterr) {
                      std::cout << "   port:" << instanceName << ", " << *(*iterr)->getName() << "\n";
                    }
                    }
                }*/


		  if(explicitPortNameMap.get()) {
		    TMap_RefString_RefCDOmExpr_constIter iter = explicitPortNameMap->begin();
		    
		    TList_RefString_const_iter iter_list1; //--------OB added
		    TList_RefString_const_iter iter_list2; //--------OB added
		    
		    m_isExprActual = FALSE; // no expressions with numbers as actuals 
		    m_exprSigPortActual = FALSE; // no expressions with sigs/ports as actuals 
		    m_assignStmt = FALSE; // no assign statements, this is f2a's

            //std::cout << instanceName << "->" << *(iter->first); 

		    if(m_moduleInstanceCnt == 0) { 
		      if(iter->second.get()) {
			// indtFile(m_depth+2, fileTemp); //------OB fileTemp comm

			//-----OB added----start
			
			
			// check if there is an actual or if the actual is a number
			if((iter->second)->getChildrenSize() > 0 || (iter->second)->getExprType() == CDOmExpr::EXPR_NUMBER ) { 
			  
			  if(m_inputPortCon.get()) {
			    for(iter_list1 = m_inputPortCon->begin(); iter_list1 != m_inputPortCon->end(); iter_list1++) {   

                  //*-------OB added
			      if(*(iter->first) == *(iter_list1->get()) ) {   //-------OB added----the actual is a number and input ports don't have write() method
				//out = fileTemp;  //-------OB fileTemp comm
				p = 'i';
				m_rangeAsWidth = FALSE;
				m_isNumActual = TRUE; //-----OB added----the actual is a number but the port is not output

				// write declaration of generated signal
				//RefString genSig = RefString(new std::string("gen_sig_" + instanceName + *(iter->first)));
				RefString instName = RefString(new std::string(instanceName));
				modDecl->addGenSignal(iter->first,instName);
				
				
				// input port is formal and part select is actual
				if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				  m_partSelActual = TRUE; //-----OB added----the actual is a range and formal port is input
				  //cout<<"----------input formal, actual is part sel1\n";
				}
				
				else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				  
				  RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				  TVec_RefCDOmExpr_const_iter it;
				  if(vec.get()) {
				    for(it = vec->begin(); it != vec->end(); it++) {
				      if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
					m_isExprActual = TRUE; //-----OB added----the actual is an expression
					//cout<<"-------input formal, actual is num expr1:" << *(iter->first) << endl;
				      }
				      else {
					m_exprSigPortActual = TRUE;	
					//cout<<"-------input formal, actual is sig/p expr1:" << *(iter->first) << endl;
				      }
				    }
				  }	  
				}
				
				else {
				  //m_inputNumActual = TRUE; //---OB added---the actual is a number and port is input
				  //cout<<"-------input formal, actual is num1:" << *(iter->first) << endl;
				}
				
				//cout<<"in in trav module instance:" << *(iter->first) << " " << *(iter_list1->get()) << endl; //----------OB
				break;
			      }
			      
			    else {
			      if(m_outputPortCon.get()) {
				for(iter_list2 = m_outputPortCon->begin(); iter_list2 != m_outputPortCon->end(); iter_list2++) {   //**-------OB added
				  
				  if(*(iter->first) == *(iter_list2->get()) ) { //*----OB
				    
				    // *(fileTemp) << ".write";  //-------OB fileTemp comm
				    //out = fileTemp;  //-------OB fileTemp comm
				    p = 'o';
				    m_rangeAsWidth = FALSE;
				    //m_inputNumActual = FALSE; //---OB added---the actual is a number but the port is not input
				    
				    if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				      m_partSelActual = TRUE; //-----OB added----the actual is a range and formal port is input
				      
				      //cout<<"----------output formal, actual is part sel1\n";
													}
				    
				    else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				      
				      RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				      TVec_RefCDOmExpr_const_iter it;
				      if(vec.get()) {
					for(it = vec->begin(); it != vec->end(); it++) {
					  if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
					    m_isExprActual = TRUE; //-----OB added----the actual is an expression
					    
					    //cout<<"-------output formal, actual is num expr1:" << *(iter->first) << endl;
					  }
					  else {
					    m_exprSigPortActual = TRUE;
					    //cout<<"-------output formal, actual is expr1:" << *(iter->first) << endl;
					    
					  }
					}
				      }
				    }
				    
				    else {
				      m_isNumActual = TRUE;  //-----OB added----the actual is a number but the port is output
				      
				      //cout<<"-------output formal, actual is num:" << *(iter->first) << endl;
				    }
				    //cout<<"in in trav module instance:" << *(iter->first) << " " << *(iter_list2->get()) << endl; //----------OB
				    break;
				  } //*----end of if
				} //**-----end of for with output ports
			      } // end of if for map with output ports
			    }
			    } //*---end of for with input ports
			  }// end of if for map with input ports
			  else if(m_outputPortCon.get()) {
			    
			    for(iter_list2 = m_outputPortCon->begin(); iter_list2 != m_outputPortCon->end(); iter_list2++) {   //**-------OB added
			    
			      if(*(iter->first) == *(iter_list2->get()) ) { //*----OB
				
				// *(fileTemp) << ".write";  //-------OB fileTemp comm
				//out = fileTemp;  //-------OB fileTemp comm
			      p = 'o';
			      m_rangeAsWidth = FALSE;
			      //m_inputNumActual = FALSE; //---OB added---the actual is a number but the port is not input
			      
			      if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				m_partSelActual = TRUE; //-----OB added----the actual is a range and formal port is input
				//cout<<"----------output formal, actual is part sel1\n";
			      }
			      
			      else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				
				RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				TVec_RefCDOmExpr_const_iter it;
				if(vec.get()) {
				  for(it = vec->begin(); it != vec->end(); it++) {
				    if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
				      m_isExprActual = TRUE; //-----OB added----the actual is an expression
				      
				      //cout<<"-------output formal, actual is num expr1:" << *(iter->first) << endl;
				    }
				    else {
				      m_exprSigPortActual = TRUE;
				      
				      //cout<<"-------output formal, actual is expr1:" << *(iter->first) << endl;
				      
				    }
				  }
				}
			      }
			      
			      else {
				m_isNumActual = TRUE;  //-----OB added----the actual is a number but the port is output
				
				//cout<<"-------output formal, actual is num:" << *(iter->first) << endl;
			      }
			      //cout<<"in in trav module instance:" << *(iter->first) << " " << *(iter_list2->get()) << endl; //----------OB
			      break;
			      } //*----end of if
			    } //**-----end of for with output ports
			  } //end of if for map with output ports
			}
			
			  
			//	  *(fileTemp) << "("; //-------OB fileTemp comm
			m_moduleInstanceCloseParen = TRUE;
		      } 
		      else {
			m_moduleInstanceCloseParen = FALSE;
		      }
		      m_moduleInstanceCnt++;
		    }
		    else {
		      if(m_moduleInstanceCnt < m_moduleInstanceSize) {
			if(m_moduleInstanceCloseParen) {
			  
			  //    *(fileTemp) << ");\n"; //-------OB fileTemp comm
			  //out = fileCpp;
			  
			}
			for(int i = 1; i <= m_moduleInstanceCnt; ++i)
			  iter++;
			if(iter->second.get()) {
			  
			  //   indtFile(m_depth+2, fileTemp); //-------OB fileTemp comm
			  //            *(fileTemp) << instanceName << "->" << *(iter->first); //-----OB fileTemp comm
			  
			  //-----OB added----start
			  
			  // check if there is an actual or if the actual is a number or if the actual is a range expression
			  if((iter->second)->getChildrenSize() > 0 || (iter->second)->getExprType() == CDOmExpr::EXPR_NUMBER) { //has range --- OB added 2nd condition
	      
			    if(m_inputPortCon.get()) {
			      for(iter_list1 = m_inputPortCon->begin(); iter_list1 != m_inputPortCon->end(); iter_list1++) {   //*-------OB added
				if(*(iter->first) == *(iter_list1->get())) {   //-------OB added----the actual is a number and input ports don't have write() method
				  
				  //out = fileTemp; //-------OB fileTemp comm
				  p = 'i';
				  m_rangeAsWidth = FALSE;
				  m_isNumActual = TRUE; //-----OB added----the actual is a number but the port is not input

				  // write declaration of generated signal
				  //RefString genSig = RefString(new std::string("gen_sig_" + instanceName + *(iter->first)));
				  RefString instName = RefString(new std::string(instanceName));
				  modDecl->addGenSignal(iter->first,instName);

		  
				  if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				    m_partSelActual = TRUE; //-----OB added----the actual is a range and formal port is input
				    //cout<<"----------input formal, actual is part sel2\n";
				  }
				  
				  else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				    
				    RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				    TVec_RefCDOmExpr_const_iter it;
				    if(vec.get()) {
				      for(it = vec->begin(); it != vec->end(); it++) {
					if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
					  m_isExprActual = TRUE; //-----OB added----the actual is an expression
					  //cout<<"-------input formal, actual is num expr2:" << *(iter->first) << endl;
					}
					else {
					  m_exprSigPortActual = TRUE;
					  //cout<<"-------input formal, actual is sig/p expr2:" << *(iter->first) << endl;
					  
					}
				      }
				    }
				  }
				  
				  else {
				    //m_inputNumActual = TRUE; //---OB added---the actual is a number and port is input
				    cout<<"-------input formal, actual is num2:" << *(iter->first) << endl;
				  }
				  //cout<<"in in trav module instance2:" << *(iter->first) << " " << *(iter_list1->get()) << endl; //----------OB
				  break;
				}
				
				else { 
				  if(m_outputPortCon.get()) {
				    for(iter_list2 = m_outputPortCon->begin(); iter_list2 != m_outputPortCon->end(); iter_list2++) {   //**-------OB added
				      if(*(iter->first) == *(iter_list2->get()) ) { //*----OB
					
					// *(fileTemp) << ".write";  //-------OB fileTemp comm
					//out = fileTemp; //-------OB fileTemp comm
					p = 'o';
					m_rangeAsWidth = FALSE;
					//m_inputNumActual = FALSE; //-----OB added----the actual is a number but the port is not input
					
					if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
					  m_partSelActual = TRUE; //-----OB added----the actual is a range and formal port is input
					  
					  //cout<<"----------output formal, actual is part sel2\n";
					}
					
					else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
					  
					  RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
					  TVec_RefCDOmExpr_const_iter it;
					  if(vec.get()) {
					    for(it = vec->begin(); it != vec->end(); it++) {
					      if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
						m_isExprActual = TRUE; //-----OB added----the actual is an expression
						
						//cout<<"-------output formal, actual is num expr2:" << *(iter->first) << endl;
					      }
					      else {
						m_exprSigPortActual = TRUE;
						
						//cout<<"-------output formal, actual is expr2:" << *(iter->first) << endl;
						
					      }
					    }
					  }
					}
					
					else {
					  m_isNumActual = TRUE;  //---OB added---the actual is a number and port is input
					  
					  //cout<<"-------output formal, actual is num2:" << *(iter->first) << endl;
					}
					break;
				      } //*----end of if
				    } //**-----end of for with output ports
				  } // end of if for map with output ports
				}
			      } //*---end of for with input ports
			    } // end of if for map with input ports
			    else if(m_outputPortCon.get()) {
			      for(iter_list2 = m_outputPortCon->begin(); iter_list2 != m_outputPortCon->end(); iter_list2++) {   //**-------OB added
				if(*(iter->first) == *(iter_list2->get()) ) { //*----OB
				  
				  // *(fileTemp) << ".write";  //-------OB fileTemp comm
				  //out = fileTemp; //-------OB fileTemp comm
				  p = 'o';
				  m_rangeAsWidth = FALSE;
				  //m_inputNumActual = FALSE; //-----OB added----the actual is a number but the port is not input
				  
				  if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				    m_partSelActual = TRUE; //-----OB added----the actual is a range and formal port is input
				    
				    //cout<<"----------output formal, actual is part sel2\n";
				  }
				  
				  else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				    
				    RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				    TVec_RefCDOmExpr_const_iter it;
				    if(vec.get()) {
				      for(it = vec->begin(); it != vec->end(); it++) {
					if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
					  m_isExprActual = TRUE; //-----OB added----the actual is an expression
					  
					  //cout<<"-------output formal, actual is num expr2:" << *(iter->first) << endl;
					}
					else {
					  m_exprSigPortActual = TRUE;
					  //cout<<"-------output formal, actual is expr2:" << *(iter->first) << endl;
					  
					}
				      }
				    }
				  }
				  
				  else {
				    m_isNumActual = TRUE;  //---OB added---the actual is a number and port is input
				    
				    //cout<<"-------output formal, actual is num2:" << *(iter->first) << endl;
				  }
				  break;
				} //*----end of if
			      } //**-----end of for with output ports
			    } // end of if for map with output ports
							}
			  
			  
			  //   *(fileTemp)  << "("; //-------OB fileTemp comm
			  m_moduleInstanceCloseParen = TRUE;
			}
			else {
			  m_moduleInstanceCloseParen = FALSE;
						}
			m_moduleInstanceCnt++;
		      }
		    }
		  }
		} else if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION) {
			if(m_emptyIndexesVec.get() && m_portItems.get()) {
				if(m_moduleInstanceCloseParen) {
				  //*(fileTemp) << ");\n";
                  //out = fileCpp; 
								
				  m_moduleInstanceCloseParen = FALSE;
				}
				while(m_emptyIndexesVec->size() > 0 && 
					  m_emptyIndexesVec->back() == m_moduleInstanceCnt) {
					m_emptyIndexesVec->pop_back();
					++m_moduleInstanceCnt;
				}
				if(m_moduleInstanceSize > m_moduleInstanceCnt && 
				   m_moduleInstanceCnt < m_portItems->size()) {
				  //indtFile(m_depth+2, fileTemp);
					RefCDOmExprLink exprLink = m_portItems->at(m_moduleInstanceCnt)->getExprLink();
					//*(fileTemp) << instanceName << "->" << *(exprLink->getName());
					if(m_moduleInstanceExprVec->at(m_moduleInstanceExprCnt)->getChildrenSize() > 0) { // has range
					  //*(fileTemp) << ".write";
					  //out = fileTemp;
						m_rangeAsWidth = FALSE;
					}
					//*(fileTemp) << "(";
					++m_moduleInstanceCnt;
					++m_moduleInstanceExprCnt;
					m_moduleInstanceCloseParen = TRUE;
				}
			}
			else if(!m_moduleInstanceGenOrderedAsNamed) {
				if(m_moduleInstanceCnt == 0) {
				  //indtFile(m_depth+2, fileTemp);
					// if a module has no ports, instantiate it like this (*a0)()
					//*(fileTemp) << "(*" << instanceName << ")("; //----OB commented
					m_moduleInstanceCnt++;
					// m_moduleInstanceCloseParen = TRUE; //----OB commented
					m_moduleInstanceCloseParen = FALSE;
				}
				else 
					if(m_moduleInstanceCnt < m_moduleInstanceExprSize) {
					  //*(fileTemp) << ", " << std::endl;
					  //indtFile(m_depth+2, fileTemp);
					  //portListIndtFile(m_moduleInstanceIndt+1, fileTemp);
						m_moduleInstanceCnt++;
						m_moduleInstanceCloseParen = TRUE;
					}
			}
			else {
				if(m_moduleInstanceCloseParen) {
				  //*(fileTemp) << ");\n";
                  out = fileCpp; 
				  
				  m_moduleInstanceCloseParen = FALSE;
				}
				if(m_portItems.get() && 
				   m_moduleInstanceSize > m_moduleInstanceCnt && 
				   m_moduleInstanceCnt < m_portItems->size()) {
				  //indtFile(m_depth+2, fileTemp);
					RefCDOmExprLink exprLink = m_portItems->at(m_moduleInstanceCnt)->getExprLink();
					//*(fileTemp) << instanceName << "->" << *(exprLink->getName());
					if(m_moduleInstanceExprVec->at(m_moduleInstanceExprCnt)->getChildrenSize() > 0) { // has range
					  //*(fileTemp) << ".write";
						m_rangeAsWidth = FALSE;
					}
					//*(fileTemp) << "(";
					//out = fileTemp;
					++m_moduleInstanceCnt;
					++m_moduleInstanceExprCnt;
					m_moduleInstanceCloseParen = TRUE;
				}
			}
		}  
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {} 

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ){
		m_paramOverrideCnt++;
		//The following could be done by retrieving the current child and calling getExprType() on it, however
		//this method may be simpler since it does not create any new objects and the Verilog syntax is fixed 
		//in this case: if the current child is in an odd position it's the hid, if it's on en even position, 
		//it's the minTypMax expression (Note: counting starts at 1, because counter is incremented before evaluation)
		if(m_paramOverrideCnt % 2 == 1){
			*(out) << " = ";
		}else if (m_paramOverrideCnt % 2 == 0 && 
				  m_paramOverrideCnt < m_paramOverrideSize ){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ){
		m_minTypMaxCnt++;
		if((m_minTypMaxCnt == 1 || 
			m_minTypMaxCnt == 2) && 
		   m_minTypMaxChildren > 1){
			*(out) << ":";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmDelay                           & delay                       ){
		m_delayPos++;
		//if(delay->getDelayType() == CDOmDelay::DELAY_2 || delay->getDelayType() == CDOmDelay::DELAY_3){
		if(m_delayHasParanths){
			if(m_delayPos < m_delaySize){
				*(out) << ", ";
			}
		}
		/*
		  if( delay->getDelayType() == 0 && m_delayPos == 1 ){
		  *(out) << ",";
		  } else if(delay->getDelayType() == 1 && (m_delayPos == 1 || m_delayPos == 2) ){
		  *(out) << ",";
		  }
		*/
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmAssn                            & assn                        ){
		m_assnPos++;
		if(m_assnPos == 1){
			*(out) << " = ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ){
		m_contAssnPos++;
		//  if(m_contAssnPos > 0 && m_contAssnPos < m_contAssnSize){
		//    *(out) << ", ";
		//  }
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ){
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) {
		m_stmtBlockCnt++; 
		if(CDOmStmtBlock::BLOCK_PARALLEL == stmtBlock->getBlockType()) {
			m_depth--;
			indtFile(m_depth, out);
			(*out) << "}\n";
			m_depth--;
			if(m_stmtBlockCnt < m_stmtBlockSize) {
				(*out) << "\n";
				indtFile(m_depth, out);
				(*out) << "void nonblocking_" << m_designFuncIdNo << "() {\n";
				//(*fileTemp) << "SC_METHOD(nonblocking_" << m_designFuncIdNo << ");\n";
				m_designFuncIdNo++;
				//indtFile(m_depth+2, fileTemp);
				if(m_eventExprVec.get() && 
				   m_eventExprVec->size() > 0) {
				  //(*fileTemp) << "sensitive";
					TVec_RefCDOmExprLink_const_iter iter = m_eventExprVec->begin();
					//for(; iter != m_eventExprVec->end(); ++iter)
					  //(*fileTemp) << "<<" << *(*iter)->getName();
					//m_depth++;
				}
				//(*fileTemp) << ";\n";
			}
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ){
		m_stmtAssnPos++;
		if(m_stmtAssnPos == 1){
			if(stmtAssn->getAssnType() == CDOmStmtAssn::ASSN_BLOCKING){
				*(out) << " = ";
			}
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ){
		m_eventExprCnt.back()++;
		if(m_eventExprCnt.back() == 1){
			//if(eventExpr->getEventExprType() == CDOmEventExpr::EVENT_EXPR_COMMA ){
			//  *(out) << ", ";
			//}else if(eventExpr->getEventExprType() == CDOmEventExpr::EVENT_EXPR_OR ){
			//  *(out) << " or ";
			//}
		}
		// }
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){
		m_stmtPTCtrlPos++;
		//if(m_stmtPTCtrlPos == 1){
		//  *(out) << std::endl;
		//}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
		m_stmtCaseCnt++;
		if(m_stmtCaseCnt == 1){
			*(out) << ") {" << std::endl;
			indtFile(m_depth, out);
			(*out) << "case ";
		}
		if( m_stmtCaseCnt > 1 && 
			m_stmtCaseCnt < m_stmtCaseSize ) {
			if(m_stmtCaseCnt % 2 == 0) {
				*(out) << " : ";
			}
			else {
				indtFile(m_depth+2, out);
				(*out) << "break;\n";
				indtFile(m_depth, out);
				(*out) << "case ";
			}
		}
  
		if( m_stmtCaseDefault && 
			m_stmtCaseCnt == m_stmtCaseSize - 1){
			//// calling indenter function ////
			indtFile(m_depth+2, out);
			(*out) << "break;\n";
			indt(m_depth);
			*(out) << "default : ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
		m_stmtIfCnt++;
		if(m_stmtIfHasAttrList && m_stmtIfCnt == 0){
			*(out)  << " if(";
		}

		if(m_stmtIfCnt == 1 ){
			*(out) << ") " /*<< std::endl*/;
		}
		if(m_stmtIfSize >= 3 && m_stmtIfCnt == 2){

			//// calling indenter function ////
			//// -1 because we want else at the same level of if, yet keep the indent depth for the rest ////
			indt(m_depth-1);

			*(out) << "else ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
		m_stmtLoopCnt++;
		switch( m_stmtLoopType ) {
			//does not evaluate forever case as to avoid redundancy
		case( CDOmStmtLoop::LOOP_REPEAT ) :   
			{
				if(m_stmtLoopCnt == 1){
					*(out) << " ) "; 
				}
				break;
			}
		case( CDOmStmtLoop::LOOP_WHILE ) :   
			{
				if(m_stmtLoopCnt == 1){
					*(out) << " ) "; 
				}
				break;
			}
		case( CDOmStmtLoop::LOOP_FOR     )                            :
			{
				switch ( m_stmtLoopCnt ) {
				case ( 1 ) : *(out) << "; "                ; break;
				case ( 2 ) : *(out) << "; "                ; break;
				case ( 3 ) : *(out) << ") "                ; break;
					//default disabled due to an extra increment at last traversal   : *(out) << "/*Out of bounds*/" ; break;
				}
				break;
			}
			// default disabled due to above non evaluation of the forever case  :   *(out) << "/* codegen:: Unknown Loop Type */";          break;
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
		m_stmtTaskEnableCnt++;
		if(m_stmtTaskEnableSize > 1){
			if(m_stmtTaskEnableCnt == 1){
				*(out) << "(";
			}else if(m_stmtTaskEnableCnt < m_stmtTaskEnableSize ){
				*(out) << ", ";
			}else if(m_stmtTaskEnableCnt == m_stmtTaskEnableSize){
				*(out) << ")";
			}
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
		m_stmtWaitCnt++;
		if(m_stmtWaitCnt == 1){
			*(out) << ") ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
		m_rangeExprPos++;
		if(m_rangeExprPos == 1){
			m_partSelActual = TRUE; //--------OB added---part select is used in assign or f2a
			//cout<<"-------in inRangeExpr\n";
			if(TRUE == m_partSelActual) {
				switch(m_rangeExprType){
				case 0 :                                             break;
				case 1 : (fileSig) << "," ;                             break;
				case 2 : (fileSig) << "+:";                             break;
				case 3 : (fileSig) << "-:";                             break;
				default: (fileSig) << "/* Invalid range expression */"; break;
				}
			}
			else {
				switch(m_rangeExprType){
				case 0 :                                             break;
				case 1 : *(out) << "," ;                             break;
				case 2 : *(out) << "+:";                             break;
				case 3 : *(out) << "-:";                             break;
				default: *(out) << "/* Invalid range expression */"; break;
				}
			}
		}
	}
	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
		m_exprConcatPos++;
		if(m_exprConcatSize > 1 && m_exprConcatPos < m_exprConcatSize){
			*(out)<<",";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ){
		m_exprMultiConcatPos++;
		if(m_exprMultiConcatPos == 1){
			*(out) << " ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                    ){
		m_udpcnt++;
		if(m_udpcnt == 1) {
			RefTVec_RefString portItems = udpDecl->getPortItemNames();
			*(out) << " (" << *(*portItems->begin());
			for(TVec_RefString_const_iter iter = portItems->begin()+1; iter < portItems->end(); ++iter)
				*(out) << ", " << *(*iter);
			*(out) << ");" << std::endl; 

		}
	}


	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput          ){
	}


	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput          ){
		m_udpPdInputCnt++;
		if(m_udpPdInputCnt > 0 && 
		   m_udpPdInputCnt< m_portIdSize && 
		   m_portIdSize != 1){
			*(out) << ", ";
		}
	}


	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry              ){
		m_combEntryCnt++;
		RefTVec_ECDOmUdpSymbol levelInputList = udpCombEntry->getInputList();
		ECDOmUdpSymbol outputSymbol = udpCombEntry->getOutputSymbol();

		indt(IND2);
		if(m_combEntryCnt == 1) indt(IND2);
		for(TVec_ECDOmUdpSymbol_const_iter iter = levelInputList->begin(); iter < levelInputList->end(); ++iter) {
			switch(*iter) {
			case   UDP_SYMBOL_0     : *(out) << "0 ";    break;
			case   UDP_SYMBOL_1     : *(out) << "1 ";    break;
			case   UDP_SYMBOL_x     : *(out) << "x ";    break;
			case   UDP_SYMBOL_X     : *(out) << "X ";    break;
			case   UDP_SYMBOL_Q     : *(out) << "? ";    break;
			case   UDP_SYMBOL_b     : *(out) << "b ";    break;
			case   UDP_SYMBOL_B     : *(out) << "B ";    break;
			case   UDP_SYMBOL_UNDEF :                    break;
			}
		}

		switch(outputSymbol) {
		case   UDP_SYMBOL_0     : *(out) << ": 0";    break;
		case   UDP_SYMBOL_1     : *(out) << ": 1";    break;
		case   UDP_SYMBOL_x     : *(out) << ": x";    break;
		case   UDP_SYMBOL_X     : *(out) << ": X";    break;
		}
	}


	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry               ) {
		m_seqEntryCnt++;
		indt(IND2);
		if(m_seqEntryCnt == 1) indt(IND2);

		if(udpSeqEntry->hasLevelInputList()) {
			RefTVec_ECDOmUdpSymbol levelInputList =  udpSeqEntry->getLevelInputList();
			if(levelInputList.get()) {
				for(TVec_ECDOmUdpSymbol_const_iter iter = levelInputList->begin(); iter < levelInputList->end(); ++iter) {
					switch(*iter) {
					case   UDP_SYMBOL_0     : *(out) << "0 ";                          break;
					case   UDP_SYMBOL_1     : *(out) << "1 ";                          break;
					case   UDP_SYMBOL_x     : *(out) << "x ";                          break;
					case   UDP_SYMBOL_X     : *(out) << "X ";                          break;
					case   UDP_SYMBOL_Q     : *(out) << "? ";                          break;
					case   UDP_SYMBOL_b     : *(out) << "b ";                          break;
					case   UDP_SYMBOL_B     : *(out) << "B ";                          break;
					default                 : *(out) << "/* illegal level_symbol */";  break; 
					}
				}
			}
		}
		else {
			RefTVec_ECDOmUdpSymbol levelSymbolList1 = udpSeqEntry->getLevelSymbolList1();
			RefTVec_ECDOmUdpSymbol levelSymbolList2 = udpSeqEntry->getLevelSymbolList2();
  
			if(levelSymbolList1.get()) {
				for (TVec_ECDOmUdpSymbol_const_iter iter = levelSymbolList1->begin(); iter < levelSymbolList1->end(); ++iter) {
					switch(*iter) {
					case   UDP_SYMBOL_0     : *(out) << "0 ";                          break;
					case   UDP_SYMBOL_1     : *(out) << "1 ";                          break;
					case   UDP_SYMBOL_x     : *(out) << "x ";                          break;
					case   UDP_SYMBOL_X     : *(out) << "X ";                          break;
					case   UDP_SYMBOL_Q     : *(out) << "? ";                          break;
					case   UDP_SYMBOL_b     : *(out) << "b ";                          break;
					case   UDP_SYMBOL_B     : *(out) << "B ";                          break;
					default                 : *(out) << "/* illegal level_symbol */";  break;
					}
				}
			}
			if(udpSeqEntry->hasEdgeSymbol()) {
				switch(udpSeqEntry->getSeqEdgeSymbol()) {
				case  CDOmUdpSeqEntry::EDGE_r     : *(out) << "r ";   break;
				case  CDOmUdpSeqEntry::EDGE_R     : *(out) << "R ";   break;
				case  CDOmUdpSeqEntry::EDGE_f     : *(out) << "f ";   break; 
				case  CDOmUdpSeqEntry::EDGE_F     : *(out) << "F ";   break;
				case  CDOmUdpSeqEntry::EDGE_p     : *(out) << "p ";   break;
				case  CDOmUdpSeqEntry::EDGE_P     : *(out) << "P ";   break;
				case  CDOmUdpSeqEntry::EDGE_n     : *(out) << "n ";   break;
				case  CDOmUdpSeqEntry::EDGE_N     : *(out) << "N ";   break;
				case  CDOmUdpSeqEntry::EDGE_STAR  : *(out) << "* ";   break;
				}  
			}
			else {
				ECDOmUdpSymbol edgeIndicator1 = udpSeqEntry->getEdgeIndicator1();
				ECDOmUdpSymbol edgeIndicator2 = udpSeqEntry->getEdgeIndicator2();
				if(edgeIndicator1 != UDP_SYMBOL_UNDEF && edgeIndicator2 != UDP_SYMBOL_UNDEF) {
					switch(edgeIndicator1) {
					case   UDP_SYMBOL_0     : *(out) << "(0 ";    break;
					case   UDP_SYMBOL_1     : *(out) << "(1 ";    break;
					case   UDP_SYMBOL_x     : *(out) << "(x ";    break;
					case   UDP_SYMBOL_X     : *(out) << "(X ";    break;
					case   UDP_SYMBOL_Q     : *(out) << "(? ";    break;
					case   UDP_SYMBOL_b     : *(out) << "(b ";    break;
					case   UDP_SYMBOL_B     : *(out) << "(B ";    break;
					case   UDP_SYMBOL_UNDEF :                     break;
					}
					switch(edgeIndicator2) {
					case   UDP_SYMBOL_0     : *(out) << "0) ";    break;
					case   UDP_SYMBOL_1     : *(out) << "1) ";    break;
					case   UDP_SYMBOL_x     : *(out) << "x) ";    break;
					case   UDP_SYMBOL_X     : *(out) << "X) ";    break;
					case   UDP_SYMBOL_Q     : *(out) << "?) ";    break;
					case   UDP_SYMBOL_b     : *(out) << "b) ";    break;
					case   UDP_SYMBOL_B     : *(out) << "B) ";    break;
					case   UDP_SYMBOL_UNDEF :                    break;
					}
				}
			}
			if(levelSymbolList2.get()) {
				for (TVec_ECDOmUdpSymbol_const_iter iter = levelSymbolList2->begin(); iter < levelSymbolList2->end(); ++iter) {
					switch(*iter) {
					case   UDP_SYMBOL_0     : *(out) << "0 ";    break;
					case   UDP_SYMBOL_1     : *(out) << "1 ";    break;
					case   UDP_SYMBOL_x     : *(out) << "x ";    break;
					case   UDP_SYMBOL_X     : *(out) << "X ";    break;
					case   UDP_SYMBOL_Q     : *(out) << "? ";    break;
					case   UDP_SYMBOL_b     : *(out) << "b ";    break;
					case   UDP_SYMBOL_B     : *(out) << "B ";    break;
					case   UDP_SYMBOL_UNDEF :                    break;
					}
				}
			}
		}

		ECDOmUdpSymbol currentState = udpSeqEntry->getCurrState();
		ECDOmUdpSymbol nextState = udpSeqEntry->getNextState(); 

		switch(currentState) {
		case   UDP_SYMBOL_0     : *(out) << ": 0 ";    break;
		case   UDP_SYMBOL_1     : *(out) << ": 1 ";    break;
		case   UDP_SYMBOL_x     : *(out) << ": x ";    break;
		case   UDP_SYMBOL_X     : *(out) << ": X ";    break;
		case   UDP_SYMBOL_Q     : *(out) << ": ? ";    break;
		case   UDP_SYMBOL_b     : *(out) << ": b ";    break;
		case   UDP_SYMBOL_B     : *(out) << ": B ";    break;
		}

		switch(nextState) {
		case   UDP_SYMBOL_0     : *(out) << ": 0";    break;
		case   UDP_SYMBOL_1     : *(out) << ": 1";    break;
		case   UDP_SYMBOL_x     : *(out) << ": x";    break;
		case   UDP_SYMBOL_X     : *(out) << ": X";    break;
		case   UDP_SYMBOL_D     : *(out) << ": -";    break;
		}
	}


	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt               ) {
		if(m_udpOutPortName.get()) {
			*(out) << *m_udpOutPortName << " = ";
			switch(udpInitStmt->getInitVal()) {
			case  CDOmUdpInitStmt::INIT_VAL_1b0 : *(out) << "1'b0;" << std::endl;   break; 
			case  CDOmUdpInitStmt::INIT_VAL_1b1 : *(out) << "1'b1;" << std::endl;   break;
			case  CDOmUdpInitStmt::INIT_VAL_1bx : *(out) << "1'bx;" << std::endl;   break;
			case  CDOmUdpInitStmt::INIT_VAL_1bX : *(out) << "1'bX;" << std::endl;   break;
			case  CDOmUdpInitStmt::INIT_VAL_1B0 : *(out) << "1'B0;" << std::endl;   break;
			case  CDOmUdpInitStmt::INIT_VAL_1B1 : *(out) << "1'B1;" << std::endl;   break;
			case  CDOmUdpInitStmt::INIT_VAL_1Bx : *(out) << "1'Bx;" << std::endl;   break;
			case  CDOmUdpInitStmt::INIT_VAL_1BX : *(out) << "1'BX;" << std::endl;   break;
			case  CDOmUdpInitStmt::INIT_VAL_1   : *(out) << "1;"    << std::endl;   break; 
			case  CDOmUdpInitStmt::INIT_VAL_0   : *(out) << "0;"    << std::endl;   break; 
			}
		}
		else *(out) << "Undeclared output port" << std::endl;
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        ) {
		++m_taskDeclCnt;
		if(taskDecl->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITH_TASK_PORT_LIST) {
			if(m_taskDeclCnt == 1) *(out) << " (";
			else if(m_taskDeclCnt-1 == m_taskDeclPortItemSize) {
				*(out) << ");" << std::endl;
			}
			else if(m_taskDeclCnt-1 < m_taskDeclPortItemSize) {
				*(out) << ", ";
			}
		} 
		else if(m_taskDeclCnt == 1) {
			*(out) << ";" << std::endl;
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                       ) {
		++m_tfPortDeclCnt;
		if(m_tfPortDeclCnt > 0 && m_tfPortDeclCnt < m_tfPortDeclSize)
			*(out) << ", ";
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
		m_funcDeclCnt++;
		if(m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE || 
		   m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE || 
		   m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST) {
			if(m_funcDeclCnt == 1) *(out) << " (";
			else if(m_funcDeclCnt == 2) *(out) << ");" << std::endl; 
		}
		else if(m_funcDeclCnt == 1) {
			*(out) << ";" << std::endl;
			indt(IND2);
		}
		if(m_funcDeclCnt > 1 && 
		   m_funcDeclCnt < funcDecl->getChildrenSize()) 
			indt(IND2);
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmFunctionCall                        & functionCall                    ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmGenvarDecl                          & genvarDecl                      ){
		m_genvarDeclCnt++;
		if(m_genvarDeclCnt < m_genvarDeclSize){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmGenInst                             & genInst                         ){
		//indt(IND1);
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmGenItemNull                         & genItemNull                     ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmGenItemIf                           & genItemIf                       ){
		m_genItemIfCnt++;
		if(m_genItemIfCnt == 1){
			*(out) << ")" << std::endl;
			indt(IND1);
		}else if (m_genItemIfCnt == 2 && m_genItemIfSize == 3){
			*(out) << "else" << std::endl;
			indt(IND1);
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmGenItemCase                         & genItemCase                     ){
		m_genItemCaseCnt++;
		if(m_genItemCaseCnt == 1){
			*(out) << " )" << std::endl;
		}
		if( m_genItemCaseCnt > 1 && 
			m_genItemCaseCnt % 2 == 0 && 
			m_genItemCaseCnt < m_genItemCaseSize ){ //checking for even position in children vector (expressionLists)
			*(out) << " : ";
			//check the logic below - it may be optimised away
		} else if ( m_genItemCaseCnt > 1 && m_genItemCaseCnt % 2 != 0 ) { //checking for odd position in children vector (statements)
			//*(out) << std::endl;
			if( m_genItemCaseDefault && m_genItemCaseCnt == m_genItemCaseSize - 1){
				*(out) << "default : ";
			}
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmGenItemLoop                         & genItemLoop                     ){
		m_genItemLoopCnt++;
		switch ( m_genItemLoopCnt ) {
		case ( 1 ) : *(out) << " = "       ; break;
		case ( 2 ) : *(out) << "; "        ; break;
		case ( 3 ) : *(out) << "; "        ; break;
		case ( 4 ) : *(out) << " = "       ; break;
		case ( 5 ) : *(out) << ") "        ; break;
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmGenItemBlock                        & genItemBlock                    ){
		m_genItemBlockCnt++;
		if(m_genItemBlockCnt == 0){
			*(out) << std::endl;
		}
		if(m_genItemBlockCnt < m_genItemBlockSize){
			indt(IND3);
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmString                              & stringObj                       ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmEventDecl                           & eventDecl                       ){
		m_eventDeclCnt++;
		if(m_eventDeclCnt < m_eventDeclSize){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmSpecifyBlock                        & specifyBlock                     ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl       & pulseSSCd                        ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmPathDecl                            & pathDecl                         ){
		m_pathDeclCnt++;
		if(m_pathDeclIsSimple || 
		   m_pathDeclIsStateSimpleIfNone){
			if(m_pathDeclCnt == 1 && 
			   m_pathDeclhasPolarityOp){
				if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
					*(out) << " +";
				}else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
					*(out) << " -";
				}
			}
			if(m_pathDeclCnt == 1){
				if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
					*(out) << " => ";
				}else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
					*(out) << " *> ";
				}
			}
			if(m_pathDeclCnt == 2){
				*(out) << " ) = ";
			}
		}
		if(m_pathDeclIsEdge){
			if(m_pathDeclCnt == 1){
				if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
					*(out) << " => ( ";
				}else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
					*(out) << " *> ( ";
				}
			}
			if(m_pathDeclCnt == 2){
				if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
					*(out) << " +";
				}else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
					*(out) << " -";
				}
				*(out) << " : ";
			}
			if(m_pathDeclCnt == 3){
				*(out) << " )) = ";
			}
		}
		if(m_pathDeclIsStateSimpleIf){
			if(m_pathDeclCnt == 1){
				*(out) << " )( ";
			}
			if(m_pathDeclCnt == 2 && 
			   m_pathDeclhasPolarityOp){
				if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
					*(out) << " +";
				}else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
					*(out) << " -";
				}
			}
			if(m_pathDeclCnt == 2){
				if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
					*(out) << " => ";
				}else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
					*(out) << " *> ";
				}
			}
			if(m_pathDeclCnt == 3){
				*(out) << " ) = ";
			}
		}
		if(m_pathDeclIsStateEdgeIf){
			if(m_pathDeclCnt == 1){
				*(out) << " )( ";
			}
			if(m_pathDeclCnt == 2){
				if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
					*(out) << " => ( ";
				}else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
					*(out) << " *> ( ";
				}
			}
			if(m_pathDeclCnt == 3){
				if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
					*(out) << " +";
				}else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
					*(out) << " -";
				}
				*(out) << " : ";
			}
			if(m_pathDeclCnt == 4){
				*(out) << " )) = ";
			}
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmPathDelayValue                      & pathDelayValue                   ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmMinTypMaxList                       & minTypMaxList                    ){
		m_minTypMaxListCnt++;
		if(m_minTypMaxListCnt < m_minTypMaxListSize){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
		m_specifyTListCnt++;
		if(m_specifyTListCnt < m_specifyTListSize){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmDelayedDataOrReference              & delayedDataOrRef                 ){
		m_delayedDataOrRefCnt++;
		if(m_delayedDataOrRefCnt == 1 && 
		   m_delayedDataOrRefSize > 1){
			*(out) << "[ ";
		}
		if(m_delayedDataOrRefCnt == 2){
			*(out) << " ]";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                ){}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmTimingCheckEvent                    & timingCkEvent                    ){
		m_timingCheckEventCnt++;
		if(m_timingCheckEventCnt == 1 && 
		   timingCkEvent->hasTimingCheckCondition()){
			*(out) << " &&& ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmSystemTimingCheck                   & systemTimingCk                   ){
		m_systemTimingCkCnt++;
		if(m_systemTimingCkCnt < m_systemTimingCkSize){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmGateInstantiation                   & gateInstantiation                ){
		m_gateInstanceCnt++;
		if(m_gateInstanceCnt < m_gateInstanceSize){
			if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_EXPR && 
			   m_gateInstanceFlag){
				*(out) << ", ";
			}
			if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_EXPR && 
			   !m_gateInstanceFlag){
				*(out) << "( ";
				m_gateInstanceFlag = true;
			}
			if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_ID_SCOPE_INDIRECT && 
			   m_gateInstanceCnt > 2){
				*(out) << "), ";
				m_gateInstanceFlag = false;
			}
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmPulseControl                        & pulseControl                     ){
		m_pulseControlCnt++;
		if(m_pulseControlLong){
			switch(m_pulseControlCnt){
			case(-1): *(out) << "$"   ; break;
			case( 0): *(out) << " = ( "; break;
			case( 1): {
				if(m_pulseControlCnt < m_pulseControlSize){
					*(out) << ", ";
				}
			}
			}

		}else{
			if(m_pulseControlCnt < m_pulseControlSize){
				*(out) << ", ";
			}
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmAttrList                       & attrList                  ){
		m_attrListCnt++;
		if(m_attrListCnt < m_attrListSize){
			*(out) << ", ";
		}
	}

	void CSystemCGenerator::inTraversal(const NSCdom::RefCDOmDefine                         & define                   ){}


	//********************************************************************************//
	//                    After traversal block                                       // 
	//********************************************************************************//

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmInclude                       & fileInclude                 ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmDesign                        & design                      ){
		//----------OB added----start
		out = fileMain;

        // maps needed by the vector control
        *(out) << "\nextern vec_func::Ref_TMap_RefString_TBool unit_inst; \nextern vec_func::Ref_TMap_RefString_TBool unit_inst_vcd; \nstd::map<RefString,fpl_module *> instMap; \nstd::map<RefString,fpl_module *>::iterator iterMap; \nstd::map<RefString,fpl_module *> instMapVcd; \nstd::map<RefString,fpl_module *>::iterator iterMapVcd;\n\n";


		// adding main body
		*(out) <<  "int sc_main (int argc , char *argv[]) {" << std::endl;
		
		*(out) << "\n  // user should add signals corresponding to the ports in the modules\n";
 
                *(out) << "  // default clock\n";
		*(out) << "  sc_clock clk(\"clk\", 10, SC_NS, 0.5);\n";
		*(out) << "\n  // user should instantiate the stim module and the dut's and connect them to the signals accordingly\n";
        *(out) << "  // the instantiated DUT must also be registered into the maps like the previous instantiations\n\n";


        // command line arguments passed to the main are read
        *(out) << "  // read command line args\n  vec_func::parseArgs(argv,argc);\n\n";

        // call createInstVec for the instances that are turned on
        *(out) << "  vec_func::iter_TMap_RefString_TBool itt;\n  if(unit_inst) {\n    for(itt = unit_inst->begin(); itt != unit_inst->end(); itt++) {\n      for(iterMap = instMap.begin(); iterMap != instMap.end(); iterMap++) {\n        if(itt->first == *iterMap->first && itt->second == TRUE) {\n          std::cout << \"turning on vectors for:\" << *iterMap->first << \"  \" << iterMap->second->name() << std::endl;          (iterMap->second)->createInstVec(*iterMap->first);\n        }\n      }\n    }\n  }\n\n";
*(out) << "  if(unit_inst_vcd) { \n    for(itt = unit_inst_vcd->begin(); itt != unit_inst_vcd->end(); itt++) { \n      for(iterMapVcd = instMapVcd.begin(); iterMapVcd != instMapVcd.end(); iterMapVcd++) { \n        if(itt->first == *iterMapVcd->first && itt->second == TRUE) { \n          std::cout << \"turning on vcd for:\" << *iterMapVcd->first << \"  \" << iterMapVcd->second->name() << std::endl;          (iterMapVcd->second)->createInstVcd(*iterMapVcd->first); \n        } \n      } \n    } \n  }\n\n";


		*(out) << "  sc_start();\n";
		*(out) << "\n return 0;" << std::endl << "}" << std::endl;

		delete fileMain; 

		if(vectors) {
		  vectors.reset();
		}
		
		//------------end

	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmModuleDecl                    & moduleDecl                  ){

		// indtFile(m_depth, fileTemp); //------OB fileTemp comm
		//  *(fileTemp) << "}" << std::endl; //------OB fileTemp comm

		//----OB commented---start
		// fileTemp->close();
		//-----end

	  

	  m_actualExpr = FALSE;

	  //delete fileTemp; 

		m_currentModuleName = moduleDecl->getModuleName();
		RefIfstream is = RefIfstream(new std::ifstream((m_ctorFileName + *m_currentModuleName + ".temp").c_str(), std::ifstream::in)); //-------OB added <+ *m_current....>
		while(is->good()) {
			TChar c = (TChar)is->get();
			if(is->eof()) {
				break;
			}
			*(out) << c;
		}
		is->close();
 
		std::remove((m_ctorFileName + *m_currentModuleName + ".temp").c_str()); // deleting temporary file  //-------OB added <+ *m_current....>
 
		//-----OB added----start

		constrInst_iter it1, it1_0;
		refString_iter it;

		if(modDecl->getInstanceData()) {

		  iter_TMap_RefString_RefString itt;
		  iter_TMap_RefString_TInt itr;

		  // write generated signals in module
		  if(modDecl->getGenSignals()) {
		      for(itt = (modDecl->getGenSignals())->begin(); itt != (modDecl->getGenSignals())->end(); itt++) {
			for(itr = inputPortsMap->begin(); itr != inputPortsMap->end(); itr++) {
			  if(*(itr->first) == *(itt->first)) {
			    *(out) << "  sc_signal<sc_int<";
			    *(out) << itr->second;
			    *(out) << "> > " << "gen_sig_" << *(itt->second) << *(itt->first) << ";\n";
			  }
			}
		      }
		  }

		  *(out) << "\n";

		  // include the h files for every module instantiated in the current module

		  /*RefString modInst =  RefString (new std::string( *(*((modDecl->getInstanceData())->begin()))->getModuleName() ) );
		*(out) << "#include \"" << *modInst << ".h\"\n";
		for(it1 = (modDecl->getInstanceData())->begin(); it1 != (modDecl->getInstanceData())->end(); it1++) {

		    if((*(*it1)->getModuleName()) == *modInst) {
		      continue;
		    }
		    modInst = RefString (new std::string(*(*it1)->getModuleName()));
		    *(out) << "#include \"" << *modInst << ".h\"\n";

		  }
		  modInst.reset(); */


          
          // external variable used by the SystemC Vector Control to store units and their instances
          
          if(!inst_map) {
            inst_map =  RefMap_RefStr_TVec(new map_RefStr_TVec);
          }
          

          // vector with instances as HID's
          Ref_TVec_RefString instances;
          if(!instances) {
            instances = Ref_TVec_RefString(new TVec_RefString);
          }

		  
          cout<< "####top module:" << *modDecl->getTopModuleName() << endl;
		  // write module names and their instances
		  for(it1 = (modDecl->getInstanceData())->begin(); it1 != (modDecl->getInstanceData())->end(); it1++) {

		    *(out) << "  " << (*(*it1)->getModuleName()) << " *" << (*(*it1)->getInstanceName()) << ";" << endl;


            cout<<"######module:" << (*(*it1)->getModuleName()) << "  instance:" << (*(*it1)->getInstanceName()) << endl << endl;


            // insert instance name as HID for current instantiated unit
            RefString s = RefString(new std::string(std::string(*modDecl->getTopModuleName()) + std::string(".") + std::string(*(*it1)->getInstanceName()) ));
            instances->push_back(s);


            // insert current instantiated unit and vector of instances in map
            if(inst_map) {
              if(inst_map->insert(std::make_pair((*it1)->getModuleName(),instances)).second) {
                //std::cout << "added unit\n";
              }
              else {
                std::cout << "unit already exists\n";
              }
            }

		  }
		}



	// VWs & vcd files part - generate VWs objects and add the ports in order to write the stim and exp vectors


		// declare vector/vcd files for every module but create one for each instance		    

		*(out) << "  // stimulus vector file \n  sc_trace_file * stimVecFile_" <<  *moduleDecl->getModuleName() <<";  \n";
		*(out) << "  // expected vector file \n  sc_trace_file * expVecFile_" <<  *moduleDecl->getModuleName() << ";  \n";
		

		// function that is called for each instance of the curent module to create separate vector files 

		*(out) << "\n";
		//	*(out) << "  // function to add ports\n";
        out = fileH;
		*(out) << "\n\n  void createInstVec(std::string inst); \n";
*(out) << "  void createInstVcd(std::string inst);\n";

        out = fileCpp;

        *(out) << "\nextern vec_func::Ref_TMap_RefString_TBool unit_inst;\nextern std::map<RefString,fpl_module *> instMap;\n";
*(out) << "extern std::map<RefString,fpl_module *> instMapVcd;\n\n";
			  
		// create the vector files and set time unit ------------------

		*(out) << "void " << *moduleDecl->getModuleName() << "::" << "createInstVec(std::string inst) { \n";

		*(out) << "\n  size_t len = inst.length();\n  char* stimName = new char[len+10];\n  strcpy(stimName, (std::string(\"stim_vec_\") + inst).c_str());\n  char* expName = new char[len+10];\n  strcpy(expName, (std::string(\"exp_vec_\") + inst).c_str()); \n\n";
		
		*(out) << "  // create the vector files\n";
		*(out) << "  stimVecFile_" << *moduleDecl->getModuleName() << " = NSSystemCVW::sc_create_vec_file(stimName,2,4);\n";
		*(out) << "  ((NSSystemCVW::vec_file*)stimVecFile_" << *moduleDecl->getModuleName() << ")->sc_set_vcd_time_unit(-9);\n";
		
		*(out) << "  expVecFile_" << *moduleDecl->getModuleName() << " = NSSystemCVW::sc_create_vec_file(expName,2,4);\n";
		*(out) << "  ((NSSystemCVW::vec_file*)expVecFile_" << *moduleDecl->getModuleName() << ")->sc_set_vcd_time_unit(-9);\n";
		
		*(out) << std::endl;


		// add the input and output ports to the vector files

 vectors_iter itt;
			  if(vectors) {
			    for(itt = vectors->begin(); itt != vectors->end(); itt++) {
			      
			      //cout<< "\n units in vectors:" << (*(*itt)->getUnit()) <<" \n\n";
			      if((*(*itt)->getUnit()) == *moduleDecl->getModuleName()) {
				
				// add the ports to stim or exp for each module instance
				
				Ref_TVec_RefCDOmPortDecl portDecls = (*itt)->getPorts();
				portDecl_iter itr;
				if(portDecls) {
				  for(itr = portDecls->begin(); itr != portDecls->end(); itr++) {
				    
				    if((*itr)->getPortType() == PORT_INPUT) {
				      RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
				      TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				      
				      for(; iterr != idVec->end(); ++iterr) {
					// clocks should not be added to vectors
					if(cslomClockName.get() && *cslomClockName == *(*iterr)->getName()) {
					  cout << "\n--------don't add clock to vectors\n";
					}
					else {
					  *(out) << "  sc_trace(stimVecFile_" << *moduleDecl->getModuleName() << ", " << *(*iterr)->getName() << ", std::string(\"" << *(*iterr)->getName() << "\") );\n";
					}
				      }
				    }
				    else if((*itr)->getPortType() == PORT_OUTPUT) {
				      RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
				      TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				      
				      for(; iterr != idVec->end(); ++iterr) {
					*(out) << "  sc_trace(expVecFile_" << *moduleDecl->getModuleName() << ", " << *(*iterr)->getName() << ", std::string(\"" << *(*iterr)->getName() << "\") );\n";
				      }
				      
				    }
				    //break;
				    
				  }
				} // if portDecl is defined
				
				break;
			      }
			    } // for every oneVec object in vector
			  } // if vectors object exists
			  *(out) << "\n";


              *(out) << "  if(stimName != NULL) delete [] stimName;\n  else std::cout << \"memory alloc failed\";\n  if(expName != NULL) delete [] expName;\n  else std::cout << \"memory alloc failed\";\n";

		
     		*(out) << "}\n"; // close createInstVec() function

		// end vector files part ----------------------------------



// create the vcd files and set time unit ---------------------------------

		*(out) << "\nvoid " << *moduleDecl->getModuleName() << "::" << "createInstVcd(std::string inst) { \n";

		*(out) << "\n  size_t len = inst.length();\n  char* stimName = new char[len+10];\n  strcpy(stimName, (std::string(\"stim_vcd_\") + inst).c_str());\n  char* expName = new char[len+10];\n  strcpy(expName, (std::string(\"exp_vcd_\") + inst).c_str()); \n\n";
		
		*(out) << "  // create the vcd files\n";
		*(out) << "  stimVecFile_" << *moduleDecl->getModuleName() << " = sc_core::sc_create_vcd_trace_file(stimName);\n";
		*(out) << "  ((vcd_trace_file*)stimVecFile_" << *moduleDecl->getModuleName() << ")->sc_set_vcd_time_unit(-9);\n";
		
		*(out) << "  expVecFile_" << *moduleDecl->getModuleName() << " = sc_core::sc_create_vcd_trace_file(expName);\n";
		*(out) << "  ((vcd_trace_file*)expVecFile_" << *moduleDecl->getModuleName() << ")->sc_set_vcd_time_unit(-9);\n";
		
		*(out) << std::endl;


		// add the input and output ports to the vcd files

			  if(vectors) {
			    for(itt = vectors->begin(); itt != vectors->end(); itt++) {
			      
			      //cout<< "\n units in vectors:" << (*(*itt)->getUnit()) <<" \n\n";
			      if((*(*itt)->getUnit()) == *moduleDecl->getModuleName()) {
				
				// add the ports to stim or exp for each module instance
				
				Ref_TVec_RefCDOmPortDecl portDecls = (*itt)->getPorts();
				portDecl_iter itr;
				if(portDecls) {
				  for(itr = portDecls->begin(); itr != portDecls->end(); itr++) {
				    
				    if((*itr)->getPortType() == PORT_INPUT) {
				      RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
				      TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				      
				      for(; iterr != idVec->end(); ++iterr) {
					// clocks should not be added to vectors
					if(cslomClockName.get() && *cslomClockName == *(*iterr)->getName()) {
					  cout << "\n--------don't add clock to vectors\n";
					}
					else {
					  *(out) << "  sc_trace(stimVecFile_" << *moduleDecl->getModuleName() << ", " << *(*iterr)->getName() << ", std::string(\"" << *(*iterr)->getName() << "\") );\n";
					}
				      }
				    }
				    else if((*itr)->getPortType() == PORT_OUTPUT) {
				      RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
				      TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				      
				      for(; iterr != idVec->end(); ++iterr) {
					*(out) << "  sc_trace(expVecFile_" << *moduleDecl->getModuleName() << ", " << *(*iterr)->getName() << ", std::string(\"" << *(*iterr)->getName() << "\") );\n";
				      }
				      
				    }
				    //break;
				    
				  }
				} // if portDecl is defined
				
				break;
			      }
			    } // for every oneVec object in vector
			  } // if vcd object exists
			  *(out) << "\n";


              *(out) << "  if(stimName != NULL) delete [] stimName;\n  else std::cout << \"memory alloc failed\";\n  if(expName != NULL) delete [] expName;\n  else std::cout << \"memory alloc failed\";\n";

		
     		*(out) << "}\n"; // close createInstVcd() function

		// end vcd files part ----------------------------------------

		

		// added by DEP
		//*(out) << "#include \"" << *m_currentModuleName << "_class_declarations.h\"" << "\n";



        out = fileH;
		*(out) << "  " << *modDecl->getTopModuleName() << "(sc_core::sc_module_name name);\n";

        out = fileCpp;

        *(out) << "\nSC_HAS_PROCESS(" << *modDecl->getTopModuleName() << ");\n\n";

		*(out) << *modDecl->getTopModuleName() << "::" << *modDecl->getTopModuleName() << "(sc_core::sc_module_name " << *modDecl->getTopModuleName() << ")  :\n" << "\tfpl_module(" << *modDecl->getTopModuleName() << ") {\n\n";

		//cout << "\n\ncurrent module:" << *modDecl->getTopModuleName() << "\n";

		//*(out) << "#include \"" << *m_currentModuleName << "_class_constructor.h\"" << "\n";

		// call the assign functions in constructor
		if(m_designFuncIdNo) {
		  TInt i = 1;
		  if(contAssignNo == 1) {
		    while(i < m_designFuncIdNo) {
		      *(out) << "  SC_METHOD(cont_assign_" << i << ");\n";
		      //cout<<"---------cont assign:" << i << endl;
		      i++;
		    }
		  }
		  else {
		    while(contAssignNo < m_designFuncIdNo) {
		      *(out) << "  SC_METHOD(cont_assign_" << contAssignNo << ");\n";
		      //cout<<"---------cont assign:" << contAssignNo << endl;
		      contAssignNo++;
		    }
		  }

		  contAssignNo = m_designFuncIdNo;

		}


 
		constrF2A_iter it2;
		refString_iter it3, it4, it5, it6;
		refVec_iter it7;

		TMap_RefString_RefCDOmExpr_constIter iter;
		
		TList_RefString_const_iter iter_list1; //--------OB added
		TList_RefString_const_iter iter_list2; //--------OB added


		if(modDecl->getInstanceData()) {
			// if there are module instances, then write them in the constructor
			for(it1 = (modDecl->getInstanceData())->begin(); it1 != (modDecl->getInstanceData())->end(); it1++) {
				*(out) << "  " << (*(*it1)->getInstanceName()) << " = new " << (*(*it1)->getModuleName()) << "(\"" << (*(*it1)->getInstanceName()) << "\");" << std::endl;

				// create vector files for every module instance by calling the createInstVec function -- this will be done in main
				//*(out) << "  " << (*(*it1)->getInstanceName()) << "->" << "createInstVec(\"" << (*(*it1)->getInstanceName()) << "\");\n";
       
                
			}
     
           
            
            // for every module instance, get the formals and actuals   
            for(it1 = (modDecl->getInstanceData())->begin(); it1 != (modDecl->getInstanceData())->end(); it1++) {
			  if((*it1)->getF2AData()) {
			    for(it2 = ((*it1)->getF2AData())->begin(); it2 != ((*it1)->getF2AData())->end(); it2++) {
                  
		      
			      if( ((*it2)->getFormalActualExpr()).get() ) {
				
				for(iter = ((*it2)->getFormalActualExpr())->begin(); iter != ((*it2)->getFormalActualExpr())->end(); iter++) {
				  
				  m_actualExpr = TRUE; // is TRUE when printing an expression used as an actual
				  
				  
				  // write the actuals for the input formals
				  if(m_inputPortCon.get()) {
				    for(iter_list1 = m_inputPortCon->begin(); iter_list1 != m_inputPortCon->end(); iter_list1++) {   
				      if(*(iter->first) == *(iter_list1->get()) ) { 
					
					//cout<< "input port:" << *(iter->first) << endl;
					
					// if the formal is connected to a number or expression, then the actual is the generated signal
					switch(iter->second->getExprType()) {
					case CDOmExpr::EXPR_NUMBER    : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_NUMBER   " << endl; 
					  m_isNumActual = TRUE; p = 'o'; 
					  m_partSelActual = FALSE;
					  // write number to generated signal
					  *(out) << "      gen_sig_" << (*(*it1)->getInstanceName()) << *(iter->first) << ".write(";
					  CVisitorTraversal::visit(CDOmNum32::cast(iter->second)); *(out) << ");\n";
					  break;
					case CDOmExpr::EXPR_HID       : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_HID      " << endl; 
					  p = 'o'; 
					  // if the actual is a part select, then the actual is the generated signal
					  if((iter->second)->getChildrenSize() > 0) {
					    // write part select to generated signal
					    m_partSelActual = TRUE;
					    m_isNumActual = FALSE;
					    *(out) << "      gen_sig_" << (*(*it1)->getInstanceName()) << *(iter->first) << ".write(";
					    CVisitorTraversal::visit(CDOmExprLink::cast(iter->second)); *(out) << ");\n";
					  }
					  break;
					case CDOmExpr::EXPR_OP        : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_OP       " << endl; 
					  p = 'o'; m_isExprActual = TRUE; m_isNumActual = FALSE;
					  // write expression to generated signal
					  *(out) << "      gen_sig_" << (*(*it1)->getInstanceName()) << *(iter->first) << ".write(";
					  CVisitorTraversal::visit(CDOmExprOp::cast(iter->second)); *(out) << ");\n";
					  break;
					case CDOmExpr::EXPR_MINTYPMAX : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_MINTYPMAX" << endl; 
					  p = 'o'; break;
					}
					
					//*(out) << ");\n";
					
				      }
				    }
				  }
				  
				  
				  *(out) << "  " << (*(*it1)->getInstanceName()) << "->" ;
				  *(out) << *(iter->first);
				  
				  if(iter->second->getExprType() == CDOmExpr::EXPR_HID) {
				    *(out) << "(";
				  }
				  
				  
				  // write the actuals for the input formals
				  if(m_inputPortCon.get()) {
				    for(iter_list1 = m_inputPortCon->begin(); iter_list1 != m_inputPortCon->end(); iter_list1++) {   


                      //std::cout << "f2a data input:" << *(iter->first) << "  " <<*(iter_list1->get()) << std::endl;
				      if(*(iter->first) == *(iter_list1->get()) ) {

                      				
					switch(iter->second->getExprType()) {
					case CDOmExpr::EXPR_NUMBER    : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_NUMBER   " << endl; 
					  m_isNumActual = TRUE; p = 'i'; 
					  // write f2a with generated signal
					  *(out) << "(gen_sig_" << (*(*it1)->getInstanceName()) << *(iter->first);
					  break;
					case CDOmExpr::EXPR_STRING    : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_STRING   " << endl; 
					  p = 'i'; *(out) << "("; 
					  CVisitorTraversal::visit(CDOmString::cast(iter->second)); break;
					case CDOmExpr::EXPR_HID       : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_HID      " << endl; 
					  p = 'i';

					  // if the actual is a part select, then the actual is the generated signal
					  if((iter->second)->getChildrenSize() > 0) {
					    // write f2a with generated signal
					    *(out) << "gen_sig_" << (*(*it1)->getInstanceName()) << *(iter->first); // removed ( before gen_sig
					  }
					  else {
					    /* *(out) << "("; lalala*/ CVisitorTraversal::visit(CDOmExprLink::cast(iter->second)); 
					    m_actualExpr = FALSE;	m_isNumActual = FALSE;
					  } 
					  break;
					case CDOmExpr::EXPR_OP        : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_OP       " << endl; 
					  p = 'i'; m_isExprActual = TRUE; m_isNumActual = FALSE;
					  // write f2a with generated signal
					  *(out) << "(gen_sig_" << (*(*it1)->getInstanceName()) << *(iter->first);
					  break;
					  
					}
					
					
					//*(out) << ");\n";
					
				      }
				    }
				  }
				  
				  
				  // write the actuals for the output formals
				  if(m_outputPortCon.get()) {
				    
				    for(iter_list2 = m_outputPortCon->begin(); iter_list2 != m_outputPortCon->end(); iter_list2++) {   //*-------OB added

                      //std::cout << "f2a data output:" << *(iter->first) << "  " <<*(iter_list2->get()) << std::endl; 


				      if(*(iter->first) == *(iter_list2->get()) ) { 

					
					//cout<< "output port:" << *(iter->first) << endl;
					
					switch(iter->second->getExprType()) {
					case CDOmExpr::EXPR_NUMBER    : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_NUMBER   " << endl; 
					  m_isNumActual = TRUE; m_partSelActual =  FALSE;
					  p = 'o'; *(out) << ".write(";  
					  CVisitorTraversal::visit(CDOmNum32::cast(iter->second)); break;
					case CDOmExpr::EXPR_STRING    : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_STRING   " << endl; 
					  p = 'o'; *(out) << "("; CVisitorTraversal::visit(CDOmString::cast(iter->second)); break;
					case CDOmExpr::EXPR_HID       : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_HID      " << endl; 
					  p = 'o'; 
					  // if the actual is a part select, then it must be written
					  if((iter->second)->getChildrenSize() > 0) {
					    *(out) << ".write("; 
					    m_partSelActual = TRUE;
					    CVisitorTraversal::visit(CDOmExprLink::cast(iter->second));
					  }
					  else {
					    /* *(out) << "("; lalala*/
					    CVisitorTraversal::visit(CDOmExprLink::cast(iter->second));
					    m_actualExpr = FALSE;	m_isNumActual = FALSE;
					  }
					  break;
					case CDOmExpr::EXPR_OP        : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_OP       " << endl; 
					  p = 'o'; m_isExprActual = TRUE; m_isNumActual = FALSE; *(out) << ".write("; 
					  CVisitorTraversal::visit(CDOmExprOp::cast(iter->second)); break;
					case CDOmExpr::EXPR_MINTYPMAX : //cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_MINTYPMAX" << endl; 
					  p = 'o'; *(out) << "("; break;
					}
					
					//*(out) << ");" << endl;
					
				      }
				    }
				  }
				  
				  *(out) << ");" << endl;
				 
				  
				  
				} // for every formal port
			      }
			    }
			  }
			  
			  m_actualExpr = FALSE;
			  

    //-------------old way to generate vector files for every instance


		// VWs part - generate VWs objects and add the ports in order to write the stim and exp vectors


		// declare vector files for every module instance

	// for every module instance, get the formals and add them to the trace (vector) files
			  
			  /*		    

			  *(out) << "      // stimulus vector file \n      sc_trace_file * stimVecFile_" << (*(*it1)->getInstanceName()) <<";  \n";
			  *(out) << "      // expected vector file \n      sc_trace_file * expVecFile_" << (*(*it1)->getInstanceName()) << ";  \n";
			  
			  
			  // create the vector files and set time unit
			  *(out) << "      // create the vector files\n";
			  *(out) << "      stimVecFile_" << (*(*it1)->getInstanceName()) << " = sc_create_vec_file(\"stim_vec_" << (*(*it1)->getInstanceName()) << "\",2,4);\n";
			  *(out) << "      ((vec_file*)stimVecFile_" << (*(*it1)->getInstanceName()) << ")->sc_set_vcd_time_unit(-9);\n";
			  
			  *(out) << "      expVecFile_" << (*(*it1)->getInstanceName()) << " = sc_create_vec_file(\"exp_vec_" << (*(*it1)->getInstanceName()) << "\",2,4);\n";
			  *(out) << "      ((vec_file*)expVecFile_" << (*(*it1)->getInstanceName()) << ")->sc_set_vcd_time_unit(-9);\n";



			  vectors_iter itt;
			  if(vectors) {
			    for(itt = vectors->begin(); itt != vectors->end(); itt++) {
			      
			      //cout<< "\n units in vectors:" << (*(*itt)->getUnit()) <<" \n\n";
			      if((*(*itt)->getUnit()) == (*(*it1)->getModuleName())) {
				
				// add the ports to stim or exp for each module instance
				
				Ref_TVec_RefCDOmPortDecl portDecls = (*itt)->getPorts();
				portDecl_iter itr;
				if(portDecls) {
				  for(itr = portDecls->begin(); itr != portDecls->end(); itr++) {
				    
				    if((*itr)->getPortType() == PORT_INPUT) {
				      RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
				      TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				      
				      for(; iterr != idVec->end(); ++iterr) {
					// clocks should not be added to vectors
					if(cslomClockName.get() && *cslomClockName == *(*iterr)->getName()) {
					  cout << "\n--------don't add clock to vectors\n";
					}
					else {
					  *(out) << "      sc_trace(stimVecFile_" << (*(*it1)->getInstanceName()) << ", " << (*(*it1)->getInstanceName()) << "->" << *(*iterr)->getName() << ", std::string(\"" << *(*iterr)->getName() << "\") );\n";
					}
				      }
				    }
				    else if((*itr)->getPortType() == PORT_OUTPUT) {
				      RefTVec_RefCDOmIdentifier idVec = (*itr)->getIDs();
				      TVec_RefCDOmIdentifier_const_iter iterr = idVec->begin();
				      
				      for(; iterr != idVec->end(); ++iterr) {
					*(out) << "      sc_trace(expVecFile_" << (*(*it1)->getInstanceName()) << ", " <<  (*(*it1)->getInstanceName()) << "->" << *(*iterr)->getName() << ", std::string(\"" << *(*iterr)->getName() << "\") );\n";
				      }
				      
				    }
				    //break;
				    
				  }
				} // if portDecl is defined
				
				break;
			      }
			    } // for every oneVec object in vector
			  } // if vectors object exists
			  *(out) << "\n";
			  
			  
			  
			  
			  // end of vectors part
			  */

   //----------------------------------


			  
			  
			  
			  
			  
			} // for every module instance




              // vector & vcd control - add instances to maps

            for(it1 = (modDecl->getInstanceData())->begin(); it1 != (modDecl->getInstanceData())->end(); it1++) {
              
              *(out) << "\n  // register module instances for vector and vcd control\n";
              *(out) << "  instMap.insert(std::make_pair(RefString(new std::string(" << (*(*it1)->getInstanceName()) << "->name())), " << (*(*it1)->getInstanceName()) << "));\n";
              *(out) << "  instMapVcd.insert(std::make_pair(RefString(new std::string(" << (*(*it1)->getInstanceName()) << "->name())), " << (*(*it1)->getInstanceName()) << "));\n";
              *(out) << "  vec_func::registerUnit(RefString(new std::string(" << (*(*it1)->getInstanceName()) << "->name())));\n\n";
            }  
            
            

			
		} // if module instance exists
		

		*(out) << "  dont_initialize();\n";
		*(out) << "}\n" << std::endl;
        *(out) << "}\n"; // close ns_systemc namespace

        out = fileH;
		*(out) << "};"<< std::endl;

        *(out) << "}\n"; //close ns_systemc namespace
		*(out) << "#endif\n";
		m_depth--;


		// write the testbench
		//if(fileTb) {
		//*(fileTb) << "SC_MODULE(tb_sysc) { \n";

		  // ports declarations to be added


		  // print function

		  // *(fileTb) << "\n";
// 		  *(fileTb) << "  void print() { \n";
// 		  *(fileTb) << "  // user code \n";
// 		  *(fileTb) << "  } \n\n";

		  
		  // add vector writer objects

		  // *(fileTb) << "  // stimulus vector writer \n  NSSystemCLib::Ref_SystemCInputVectorWriter stimVW;  \n";
// 		  *(fileTb) << "  // expected vector writer \n  NSSystemCLib::Ref_SystemCOutputVectorWriter expVW;  \n";

		  
		  // function to manipulate the vector writers

		  // *(fileTb) << "\n";
// 		  *(fileTb) << "  void genVec() { \n";
		  // more to be added

		  //*(fileTb) << "  } \n";



		  // write the constructor

		  // *(fileTb) << "\n";
// 		  *(fileTb) << "  SC_CTOR(tb_sysc) { \n";
// 		  *(fileTb) << "    SC_THREAD(print); \n";
// 		  *(fileTb) << "    sensitive << clk; \n";
// 		  *(fileTb) << "    SC_THREAD(genVec); \n";
// 		  *(fileTb) << "    sensitive << clk; \n";
// 		  *(fileTb) << "  } \n";


// 		  *(fileTb) << "}; \n";



		//}
		// end of write testbench

		//-------OB added----
		if(modDecl) {
		  modDecl.reset();
		}
		if(constrInst) {
		  constrInst.reset();
		}
		if(F2As) {
		  F2As.reset();
		}

		if(m_moduleFileName) {
		  m_moduleFileName.reset();
		}

		if(fileH) {
		  delete fileH;
		}

        if(fileCpp) {
		  delete fileCpp;
        }
		if(oneVec) {
		  oneVec.reset();
		}
		/*if(vectors) {
		  vectors.reset();
		  }*/
		

		// if(fileTb) {
// 		  delete fileTb;
// 		}

		
    }

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmIdentifier                    & id                          ){

      out = fileH;
      if(m_idPrintSemi) {
        (*out) << ";" << std::endl;
      }
      //  out = fileCpp; //----OB commented



	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmPortItem                      & portItem                    ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmExprLink                      & exprLink                    ) {
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmExprOp                        & exprOp                      ){
	  //cout<<"----------afterTraversal(const NSCdom::RefCDOmExprOp begin" << endl;

		RefCDOmBase parent = exprOp->getParent();
		if(parent.get() && parent->getType() == TYPE_EXPR){
			if(CDOmExpr::cast(parent)->getExprType() == CDOmExpr::EXPR_MINTYPMAX && 
			   m_designGenCode){
			  *(out) << ")";
			}
		} 
		m_exprCnt.pop_back();
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmListExpr                      & listExpr                    ){
		if(m_listExprHasFunctionCallParent){
			*(out) << ")";
		}else if(m_listExprHasExprLinkParent){
			*(out) << "]";
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmPortDecl                      & portDecl                    ){

      out = fileH;
      *(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmVarDecl                       & varDecl                     ){

      out = fileH;
      *(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmNetDecl                       & netDecl                     ){

      out = fileH;
      *(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmRange                         & range                       ){
		if(TRUE == m_designGenCode) {
			if(m_rangeAsWidth) {
				//if(m_rangeGenExpr) {
				//*(out) << "+1";
				//}
				//      (*out) << "+1"; //------OB commented

				//      std::cerr << "range parent type is: " << range->getParent()->getType() << std::endl;
				if(range->getParent()->getType() == TYPE_RANGE_LIST) {
					*(out) << "]";
				}
				else {
                  if(m_widthRange == 1) 
                    *(out) << "> ";
                  else
                    *(out) << "> > ";
				}
				m_rangeGenExpr = TRUE;
			}
			else {
			  //*(fileTemp) << ")";
			}
		}
		m_showRange = TRUE; //----OB added
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmNum32                         & num                         ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmReal                          & realNum                     ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation      & moduleInstantiation         ){
		// *(out) << ";" << std::endl; //---OB new comm
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstance           & moduleInstance              ) {
		if(m_moduleInstanceCloseParen) {
			// *(fileTemp) << ");" << std::endl; //---OB fileTemp comm

			//----OB added---start

			// add F2As object to vector
			constrInst->addF2AData(F2As);


			TVec_RefString_const_iter itt;

			// if there are expressions with signals/ports as actuals in conn with ports, then add them to the object
			// if(F2AExprMap.get()) {
			//       F2As->addFormalActualExpr(F2AExprMap);
      
			//       // this is only to print the expressions
			//       for(mapF2A_iter = F2AExprMap->begin(); mapF2A_iter != F2AExprMap->end(); mapF2A_iter++) {
			// 	//cout<<"!!!!!!!!!map:" << *(mapF2A_iter->first) << "---";
			// 	for(itt = (mapF2A_iter->second)->begin(); itt != (mapF2A_iter->second)->end(); itt++) {
			// 	  //cout<<*(*itt);
			// 	}
			// 	//cout<<endl;
			//       }
			//       F2AExprMap.reset();
			//     }


			TMap_RefString_RefCDOmExpr_constIter iter;

			if(explicitPortNameMap.get()) {
				F2As->addFormalActualExpr(explicitPortNameMap);

     
				// this is only to print the expressions
				for(iter = explicitPortNameMap->begin(); iter != explicitPortNameMap->end(); iter++) {
					//cout<<"!!!!!!!!!map:" << *(iter->first) << "---";
				}
				cout<<endl;
				explicitPortNameMap.reset();
			}

			//out = fileCpp; 

			//------end

			//    out = fileCpp; //------OB commentedgetExprsOutputActuals
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmParamDeclCollection           & paramDeclCollection         ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmParamDecl                     & paramDecl                   ) {
		if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
			m_designGenCode = TRUE;
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmParamOverride                 & paramOverride               ){
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmMinTypMax                     & minTypMax                   ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmDelay                         & delay                       ){
		if(m_delayHasParanths){
			//if(delay->getDelayType() == 0 || delay->getDelayType() == 1){
			*(out) << ")";
		}
		*(out) << " ";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmInitOrAlways                  & initOrAlways                ){ 

		if(m_stmtNonBlockingVec.get()) {
			TVec_RefCDOmStmt_const_iter iter = m_stmtNonBlockingVec->begin();
			for(; iter != m_stmtNonBlockingVec->end(); ++iter) {
				// writing function definition
				(*out) << "\n";
				indtFile(IND1, out);
				(*out) << "void nonblocking_" << m_designFuncIdNo << "() {\n";
				m_depth++;
				indtFile(m_depth, out);
				//parseExpr(CDOmStmtAssn::cast(*iter)->getLvalue(), out);
				(*out) << " = ";
				//parseExpr(CDOmStmtAssn::cast(*iter)->getExpr(), out);
				(*out) << ";\n";
				m_depth--;
				indtFile(m_depth, out);
				(*out) << "}\n";
				m_depth--;

				//writing method declaration in constructor
				//(*fileTemp) << "SC_METHOD(nonblocking_" << m_designFuncIdNo << ");\n";
				if(m_eventExprVec.get() && m_eventExprVec->size() > 0) {
				  //(*fileTemp) << "sensitive";
					TVec_RefCDOmExprLink_const_iter iter = m_eventExprVec->begin();
					//for(; iter != m_eventExprVec->end(); ++iter)
					  //(*fileTemp) << "<<" << *(*iter)->getName();
				}
				//(*fileTemp) << ";\n";
				++m_designFuncIdNo;  
			}
		}

		//// exiting depth ////
		m_depth--;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmAssn                          & assn                        ) { 
		(*out) << ";\n";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmContAssn                      & contAssn                    ){
		--m_depth;
		out = fileCpp; 

		//(*out) << "\n";
		indt(m_depth);
		(*out) << "}\n\n";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmt                          & stmt                        ){
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtBlock                     & stmtBlock                   ) {
		//// calling indenter function ////
		indt(m_depth - 1);

		if(CDOmStmtBlock::BLOCK_SEQUENTIAL == stmtBlock->getBlockType()) {
			(*out) << "}\n";
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtAssn                       & stmtAssn                    ){
		if(CDOmStmtAssn::ASSN_NON_BLOCKING != stmtAssn->getAssnType()) {
			(*out) << ";" << std::endl;
		}
		else {
			m_designGenCode = TRUE;
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmEventControl                   & eventCtrl                   ){
		//    if( m_eventCtrlType == CDOmEventControl::EVENT_CONTROL_EVENT_EXPR ){
		//      *(out) << " ) " /*<< std::endl*/;
		//    }else{
		//      *(out) /*<< std::endl*/;
		//    }
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmEventExpr                      & eventExpr                   ){
		m_eventExprCnt.pop_back();
		//eventExprtype reset
		m_eventExprType = -1;
		m_designGenCode = TRUE;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){
		if(delayCtrl->getDelayControlType() == CDOmDelayControl::DELAY_CONTROL_MINTYPMAX){
			*(out) << "  )";
		}
		*(out) << ");\n";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
		//// exiting depth ////
		m_depth--;
		//// calling indenter function ////
		indt(m_depth);

		*(out) << "}" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
		//// exiting depth ////
		m_depth--;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
		//// exiting depth ////
		m_depth--;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
		//*(out) << ";";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){
		*(out) << ";";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
		if(TRUE == m_partSelActual) {
			(fileSig) << ")";
			m_partSelActual = FALSE;
		}
		else {
			(*out) << ")";
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
		*(out) << ")";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) {
		*(out) << ")";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) {
		*(out) << "endprimitive"<< std::endl << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) {
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) {
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) {
		*(out) << " ;" << std::endl;
		if(m_combEntryCnt == m_combEntrySize) {
			indt(IND2);
			*(out) << "endtable" << std::endl;
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) {
		*(out) << " ;" << std::endl;
		if(m_seqEntryCnt == m_seqEntrySize) {
			indt(IND2);
			*(out) << "endtable" << std::endl;
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) {
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ){
		*(out) << "endtask" <<std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) {
		RefCDOmBase parent = tfPortDecl->getParent();
		if(parent.get() && 
		   (parent->getType() == TYPE_DECL_TASK && 
			CDOmTaskDecl::cast(parent)->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST ||
			(parent->getType() == TYPE_DECL_FUNCTION && 
			 (CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE  ||
			  CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE ||
			  CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST))))
			*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
		*(out) << "endfunction" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) {}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) {
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ){
		*(out) << "endgenerate" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ){
		*(out) << "endcase" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ){
		*(out) << "end" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmString                          & stringObj                   ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ){
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ){
		//// exiting depth ////
		m_depth--;
		//// calling indenter function ////
		indt(m_depth);

		*(out) << "endspecify" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                  ){
		*(out) << ";" <<std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                   ){
		*(out) << ";" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue             ){
		if(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITH_PAREN){
			*(out) << " )";
		}
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList              ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList        ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef           ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl          ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent              ){}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk             ){
		*(out) << " );" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation          ){
		*(out) << ");" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl               ){
		*(out) << " );" << std::endl;
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmAttrList                        & attrList                   ){
		*(out) << " *)";
	}

	void CSystemCGenerator::afterTraversal(const NSCdom::RefCDOmDefine                          & define                     ){}

}

