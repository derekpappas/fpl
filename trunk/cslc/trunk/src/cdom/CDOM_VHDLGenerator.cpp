 //----------------------------------------------------------------------
// Copyright (c) 2005-2008 Fastpathlogic
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
//Author:Monica
//2009

#include "CDOM_VHDLGenerator.h"

#include <fstream>
#include <ctime>
//#include <iterator>

using namespace NSCdom;

namespace NSCdomVHDLGenerator {


//********************************************************************************
// Helper Functions
//********************************************************************************

//Normal indenter function
void CVHDLGenerator::indt(TInt size) {
  size = size*2;
  for(int i=0; i < size; i++){
    *(out) << " ";
  }
}

//portlist indenter function
void CVHDLGenerator::portListIndt(TInt size) {
  size = size*1;
  for(int i=0; i < size; i++){
    *(out) << " ";
  }
}

//dec to binary converter function
std::string dec2Bin(TInt value, TInt size) {

  std::string sOut;
  TInt temp;
  char b;

  for(TInt i = 0; i < size; i++){
    temp = value / 2;
    if(temp >= 0){
      b=48+(value % 2);
      sOut+=b;
      value = temp;
    } 
    else{
      sOut+='0';
    }
  }
  return sOut;
}

//copyright notice
void CVHDLGenerator::copyrightNotice(std::string fileName){
  //Copyright notice
  time_t* temp = new time_t;
  time_t cpright_date = time(temp);
  
  vhout << "--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER\n--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc\n";
  vhout << "--OUTPUT FILE NAME  : " << fileName << std::endl;
  vhout << "--FILE GENERATED ON : " << ctime(&cpright_date) << std::endl;
  
  delete temp;
 }

void CVHDLGenerator::setVhInclude(RefString plusPath){
  m_vhIncludeString = plusPath;
}


//********************************************************************************
// CVHDLRangeData class - MS added
//********************************************************************************
  CVHDLRangeData::CVHDLRangeData(){
   
  }
  //return upper limit of range
  TInt CVHDLRangeData::getUpperLimit(){
    return upperLimit;
  }
  //return lower limit of range
  TInt CVHDLRangeData::getLowerLimit(){
    return lowerLimit;
  }
 //set the range  upper limit 
  void  CVHDLRangeData::setUpperLimit( TInt &num ) {
   
    upperLimit = num;
  }
  //set the range  lower limit 
  void CVHDLRangeData::setLowerLimit(TInt &num) {
   
    lowerLimit = num;
  }

CVHDLRangeData::~CVHDLRangeData() {

}

//********************************************************************************
// CVHDLSignalData class - MS added
//********************************************************************************
  CVHDLSignalData::CVHDLSignalData(){
   
  }
//add a signal declaration  
  void CVHDLSignalData::addSignalName(RefString  &signalName) {
    
      sigName = signalName;
  
  }

  //get the signal name
  RefString CVHDLSignalData::getSignalName() {
    return sigName;
  }
  //add signal type
  void CVHDLSignalData::addSignalType(RefString  type) {
    sigType = type;
  }
 //get the signal type
  RefString CVHDLSignalData::getSignalType() {
    return sigType;
  }
  //add signal range
  void CVHDLSignalData::addSignalRange(Ref_CVHDLRangeData &range){
      signalRange = range;
     
    }

  //get signal range
  Ref_CVHDLRangeData CVHDLSignalData::getSignalRange(){
    return signalRange;
  }

	CVHDLSignalData::~CVHDLSignalData() {
	
		if(sigName.get()) {
			sigName.reset();
		}
	      	if(sigType.get()) {
			sigType.reset();
		}
	       if(signalRange.get()) {
			signalRange.reset();
		}
	}

//********************************************************************************
// CVHDLVarData class - MS added
//********************************************************************************
  CVHDLVarData::CVHDLVarData(){
   
  }
//add a variable declaration  
  void CVHDLVarData::addVarName(RefString  &variableName) {
    
      varName = variableName;
  
  }

  //get the variable name
  RefString CVHDLVarData::getVarName() {
    return varName;
  }
  //add variable type
  void CVHDLVarData::addVarType(RefString  type) {
    varType = type;
  }
 //get the variable type
  RefString CVHDLVarData::getVarType() {
    return varType;
  }
//add variable value
  void CVHDLVarData::addVarValue(TInt value) {
    varVal = value;
  }
 //get the variable value
  TInt CVHDLVarData::getVarValue() {
    return varVal;
  }
  //add signal range
  void CVHDLVarData::addVarRange(Ref_CVHDLRangeData &range){
      varRange = range;
     
    }

  //get variable range
  Ref_CVHDLRangeData CVHDLVarData::getVarRange(){
    return varRange;
  }

	CVHDLVarData::~CVHDLVarData() {
	
		if(varName.get()) {
			varName.reset();
		}
	      	if(varType.get()) {
			varType.reset();
		}
	       if(varRange.get()) {
			varRange.reset();
		}
	}

//********************************************************************************
// CVHDLPortData class - MS added---used for component scope
//********************************************************************************
  CVHDLPortData::CVHDLPortData(){
   
  }
//add a port declaration  
  void CVHDLPortData::addPortName(RefString  &portName) {
    
      pName = portName;
  
  }

  //get the port name
  RefString CVHDLPortData::getPortName() {
    return pName;
  }
  //add port type
  void CVHDLPortData::addPortType(RefString  type) {
    pType = type;
  }
 //get the port type
  RefString CVHDLPortData::getPortType() {
    return pType;
  }
 //add port dir
  void CVHDLPortData::addPortDir(RefString  direction) {
    pDir = direction;
  }
 //get the port dir
  RefString CVHDLPortData::getPortDir() {
    return pDir;
  }
  //add port range
  void CVHDLPortData::addPortRange(Ref_CVHDLRangeData &range){
      portRange = range;
     
    }

  //get port range
  Ref_CVHDLRangeData  CVHDLPortData::getPortRange(){
    return portRange;
  }

	CVHDLPortData::~CVHDLPortData() {
	
		if(pName.get()) {
		  pName.reset();
		}
	      	if(pType.get()) {
		  pType.reset();
		}
		if(pDir.get()){
		  pDir.reset();
		}
	       if(portRange.get()) {
		 portRange.reset();
		}
	}

//********************************************************************************
// CVHDLParameterData class - MS added
//********************************************************************************
  CVHDLParamData::CVHDLParamData(){
   
  }
//add a parameter declaration  
  void CVHDLParamData::addParamName(RefString &paramName) {
    
      parName = paramName;
  
  }

  //get the parameter name
  RefString CVHDLParamData::getParamName() {
    return parName;
  }
  //add parameter type
  void CVHDLParamData::addParamType(RefString  type) {
    parType = type;
  }
 //get the parameter type
  RefString CVHDLParamData::getParamType() {
    return parType;
  }
  //add parameter value
  void CVHDLParamData::addParamValue(TInt value){

      paramValue = value;
     
    }

  //get parameter value
  TInt CVHDLParamData::getParamValue(){
    return paramValue;
  }

//add parameter string
  void CVHDLParamData::addParamString(RefString str){

      paramString = str;
     
    }
//get parameter string
  RefString CVHDLParamData::getParamString(){
    return paramString;
  }
	CVHDLParamData::~CVHDLParamData() {
	
		if(parName.get()) {
		  parName.reset();
		}
	      	if(parType.get()) {
		  parType.reset();
		}
		if(paramString.get()) {
		  paramString.reset();
		}
		 
	}
         
	//********************************************************************************
	// CVHDLArchData class - MS added
	//********************************************************************************
	CVHDLArchData::CVHDLArchData() {
	  
	}

	// return the name of the module
	RefString CVHDLArchData::getTopModuleName() {
		return topModuleName;
	}

	// set the name of the module
	void CVHDLArchData::setTopModuleName(const NSCdom::RefCDOmIdentifier &id) { 
		topModuleName = RefString(new std::string(*(id->getName())));
	}

	// add a new instance in the instances vector
	void CVHDLArchData::addInstanceData(Ref_CVHDLModuleInstance &inst) {
		if(!instanceData.get()) {
			instanceData = Ref_TVec_CVHDLModuleInstance(new TVec_CVHDLModuleInstance);
		}
		instanceData->push_back(inst);
	}

         Ref_TVec_CVHDLModuleInstance CVHDLArchData::getInstanceData() {
		return instanceData;
	}

      // add a new signal in the signals vector
	void CVHDLArchData::addSignalData(Ref_CVHDLSignalData &signal) {
		if(!signalData.get()) {
			signalData = Ref_TVec_CVHDLSignalData(new TVec_CVHDLSignalData);
		}
		signalData->push_back(signal);
	}

	Ref_TVec_CVHDLSignalData CVHDLArchData::getSignalData() {
		return signalData;
	}
  // add a new var in the variable vector
	void CVHDLArchData::addVarData(Ref_CVHDLVarData &variable) {
		if(!varData.get()) {
			varData = Ref_TVec_CVHDLVarData(new TVec_CVHDLVarData);
		}
		varData->push_back(variable);
	}

	Ref_TVec_CVHDLVarData CVHDLArchData::getVarData() {
		return varData;
	}
      
        CVHDLArchData::~CVHDLArchData() {
		if(topModuleName.get()) {
			topModuleName.reset();
		}

		if(instanceData.get()) {
			instanceData.reset();
		}

		if(signalData.get()) {
			signalData.reset();
		}
		if(varData.get()) {
			varData.reset();
		}
	     
	}
	//********************************************************************************
	// CVHDLDesignData class - MS added
	//********************************************************************************
	CVHDLDesignData::CVHDLDesignData() {
	  
	}
        // add a new module in the module vector
	void CVHDLDesignData::addModuleData(Ref_CVHDLModuleData &module) {
		if(!moduleData.get()) {
			moduleData = Ref_TVec_CVHDLModuleData(new TVec_CVHDLModuleData);
		}
		moduleData->push_back(module);
	}
	Ref_TVec_CVHDLModuleData CVHDLDesignData::getModuleData() {
		return moduleData;
	}
        CVHDLDesignData::~CVHDLDesignData() {
		if(moduleData.get()) {
			moduleData.reset();
		}
	}
	//********************************************************************************
	// CVHDLModuleData class - MS added
	//********************************************************************************
	CVHDLModuleData::CVHDLModuleData() {
	  
	}
        // add a new port in the ports vector
	void CVHDLModuleData::addPortData(Ref_CVHDLPortData &port) {
		if(!portData.get()) {
			portData = Ref_TVec_CVHDLPortData(new TVec_CVHDLPortData);
		}
		portData->push_back(port);
	}

	Ref_TVec_CVHDLPortData CVHDLModuleData::getPortData() {
		return portData;
	}
     
        CVHDLModuleData::~CVHDLModuleData() {
		if(portData.get()) {
			portData.reset();
		}
		
	}
	//********************************************************************************
	// CVHDLModuleInstance class - MS added
	//********************************************************************************
	CVHDLModuleInstance:: CVHDLModuleInstance() {

	}

	void CVHDLModuleInstance::setModuleName(RefString &module) {
		moduleName = RefString(new std::string(*module)); 
	}
  
	RefString CVHDLModuleInstance::getModuleName() {
		return moduleName;
	}
  
	void CVHDLModuleInstance::setInstanceName(RefString &inst) {
		instanceName = RefString(new std::string(*inst));
	}

	RefString CVHDLModuleInstance::getInstanceName() {
		return instanceName;
	}

	// add a new f2a in the F2AData vector
	void CVHDLModuleInstance::addF2AData(Ref_CVHDLConstrF2A &f2a) {
		if(!F2AData.get()) {
			F2AData = Ref_TVec_CVHDLConstrF2A(new TVec_CVHDLConstrF2A);
		}
		F2AData->push_back(f2a);
	}

	Ref_TVec_CVHDLConstrF2A CVHDLModuleInstance::getF2AData() {
		return F2AData;
	}

        // add a new parameter in the parameters vector
	void CVHDLModuleInstance::addParamData(Ref_CVHDLParamData &param) {
		if(!paramData.get()) {
			paramData = Ref_TVec_CVHDLParamData(new TVec_CVHDLParamData);
		}
		paramData->push_back(param);
	}

	Ref_TVec_CVHDLParamData CVHDLModuleInstance::getParamData() {
		return paramData;
	}

	CVHDLModuleInstance::~CVHDLModuleInstance() {
		if(moduleName.get()) {
			moduleName.reset();
		}

		if(instanceName.get()) {
			instanceName.reset();
		}

		if(F2AData.get()) {
			F2AData.reset();
		}
		if(paramData.get()) {
		        paramData.reset();
		}
		
	}


	//********************************************************************************
	// CVHDLConstrF2A class - MS added
	//********************************************************************************
	CVHDLConstrF2A::CVHDLConstrF2A() {

	}

        void CVHDLConstrF2A::addFormalActualExpr(RefTMap_RefString_RefCDOmExpr map) {
		if(!formalActualExpr.get()) {
			formalActualExpr = RefTMap_RefString_RefCDOmExpr(new TMap_RefString_RefCDOmExpr(*map));
		}
	}

	RefTMap_RefString_RefCDOmExpr CVHDLConstrF2A::getFormalActualExpr() {
		return formalActualExpr;
	}



	CVHDLConstrF2A::~CVHDLConstrF2A() {
		if(formalActualExpr.get()) {
			formalActualExpr.reset();
		}
	}



//********************************************************************************
// CVHDLGenerator class
//********************************************************************************
CVHDLGenerator::CVHDLGenerator(std::string outputPath): m_outputPath(outputPath),
                                                              m_includeInUnit(FALSE),
                                                              m_pulseControlSection(TRUE),
                                                              m_num32TempStr(RefString(new std::string()))
{
  m_param = TRUE;
  //Changing output method below
  //file = FALSE;
  //if (!filename.empty()) {
  //  out = new std::ofstream(filename.c_str());
  //  file=TRUE;
  //  if(!out){
  //    std::cerr << "Warning opening output file" << std::endl;
  //  }
  //}
  //else {
  //  out = new std::ofstream("vhdl_generated_code.vhd");
  //  m_filename = "vhdl_generated_code.vhd";
  //  file = TRUE;
  //  //out = &(std::cout);
  //}
 
  //Safe initialization
  out = &(std::cout);
}
CVHDLGenerator::~CVHDLGenerator() {
  //Changing output method below
  //if (file) {
  //  ((std::ofstream*)(out))->close();
  //  delete out;
  //}
}

  //----MS added---------
	// global object used to hold constructor data
	Ref_CVHDLArchData modDecl;
	// global object used to hold instances information
	Ref_CVHDLModuleInstance modInst;
	// global object used to hold formals and actuals
	Ref_CVHDLConstrF2A F2As;
	// global object used to hold the range
         Ref_CVHDLRangeData rangeData;
       // global object used to hold the signal decl
         Ref_CVHDLSignalData signal;   
       //global object used to hold the port decl
         Ref_CVHDLPortData port;
       //global object used to hold the module decl
         Ref_CVHDLModuleData module;
       //global object used to hold the module from the design
         Ref_CVHDLDesignData designData;
       // global object used to hold the param decl
         Ref_CVHDLParamData parameter; 
      // global object used to hold the var decl
         Ref_CVHDLVarData variable;  
  



//********************************************************************************
// Before traversal block
//********************************************************************************

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){
  //// calling indenter function ////
  //  indt(m_depth);

  /* if(FILE_Verilog == fileInclude->getFileType()) {
    *(out) << "`include \"" << *(fileInclude->getFileName()) << "\" " << std::endl;
  }
  else {
    std::cout<<"You are not including a Vhdl file!\n";
    exit(1);
    }

  //setting the flag if the current unit has an include already
  RefCDOmBase parent = fileInclude->getParent();
  if(parent.get() && TYPE_DECL_MODULE == parent->getType()){
    m_includeInUnit = TRUE;*/

  }
  

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      ){
//Initializations
  // m_noRange = FALSE;
  m_depth = 0;
  m_addIndent = 0;
  m_moduleCnt=0;
  //other flags
  m_showRange = TRUE;
  m_expandNum32 = FALSE;
  opExpr = FALSE;
  m_assignStmt = FALSE; // no assign statements
  m_exprNum = FALSE;
  m_concatExpr = FALSE;
  m_vect = FALSE; //-------OB added
  m_designGenCode = TRUE;
  m_parOver = FALSE;	
  m_design = design;  //MS added
  m_hasVar = FALSE; //MS added
  m_doubleRange =FALSE;
  dutName = RefString(new std::string(" ") );
  //  portVec = Ref_TVec_CVHDLPortData (new TVec_CVHDLPortData); // MS added used to hold the port date for the component scope
  m_portWidthTypeMap = RefTMap_RefString_ESCPortWidthType(new TMap_RefString_ESCPortWidthType());
  //defines stream
  /*  NSCLi::CLiCommon::Instance()->openFile(m_outputPath + "defines.v", defout, std::ios::out);
  //adding inc guard in defines stream
  defout << "`ifndef DEFINES_FILE" << std::endl;
  defout << "`define DEFINES_FILE" << std::endl << std::endl;*/
  
  designData = Ref_CVHDLDesignData(new CVHDLDesignData::CVHDLDesignData);
  modNo=-1; //no of instantiated modules
 parameter = Ref_CVHDLParamData(new CVHDLParamData::CVHDLParamData);   //create parameter object
 //m_dutVec = Ref_TVec_RefString(new TVec_RefString); // used for testbench
 m_tb = FALSE;
  if (cslTopUnitName.get()
      && !cslTopUnitName->empty()) {

    RefString topModuleName(new std::string(*cslTopUnitName));
    topModuleName->append(".vh");
    NSCLi::CLiCommon::Instance()->openFile(m_outputPath + *topModuleName, vhout, std::ios::out);
    copyrightNotice(*topModuleName);

    /*    if (cslomHasEnum) {
      vhout << "enum_define.vh" << std::endl;
      }*/
  }
  if(m_param){
    // std::cout << "param=" << m_param;
    pVec = Ref_TVec_CVHDLParamData(new TVec_CVHDLParamData);
  }
  }

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ){
  //Inits
                cnt =0;
                m_modcnt = 0;
		m_depth++;
                m_portItemSize = -1; //for the case when no port item is created
                m_orderedPortNumSize = 0;
                m_portDeclNo=0;
		m_cnt=0;  //start the port counting
		s=0;
		i=0;
		m_parCnt=0;
		//-------MS added---start
		m_currentModuleName = moduleDecl->getModuleName(); // module name
		//m_inputNumActual = FALSE; // there is no number used as an actual in a f2a connection with an input port
		m_isNumActual = FALSE; // there is no number used as an actual in a f2a connection with an output port
		m_partSelActual = FALSE; // there is no part select used in a f2a connection with an input port
		m_isExprActual = FALSE; // there is no num expression used in a f2a connection
		m_exprSigPortActual = FALSE; // there is no sigs/ports expression used in a f2a connection
	 
               
                m_moduleFileName = RefString(new std::string(*m_currentModuleName));
                m_moduleFileName->append(".vhd");
	        out = new std::ofstream((m_outputPath + *m_moduleFileName).c_str());
		file = TRUE;

		// m_inst = FALSE;
		//--------end
	
		//     
		//----------MS added-----start
	        refNumVec = RefTVec_char (new TVec_char);
		RefTVec_RefCDOmPortItem portItemVec = moduleDecl->getPortItems();
                assignVec = RefTVec_RefString(new TVec_RefString);
		assignPair= Ref_pairRefString_Ref_TVec_RefString (new  pairRefString_Ref_TVec_RefString);
		assignMap = Ref_mapRefString_Ref_TVec_RefString(new mapRefString_Ref_TVec_RefString);
		numMap = Ref_mapRefString_TVec_char (new mapRefString_TVec_char);
                m_numAssMap = Ref_mapRefString_TVecRefString (new mapRefString_TVecRefString);
		actualNameVec = RefTVec_RefString(new TVec_RefString);
		paramNameVec = RefTVec_RefString(new TVec_RefString);
		paramOverMap = Ref_mapRefString_TVec_char (new mapRefString_TVec_char);

	
		if(portItemVec.get()){
			m_portItemSize = portItemVec->size();
		}

		//--------end


		
		//	m_moduleCnt++;
  //Module CSL type (if generated from CSL)
  m_moduleCslType = moduleDecl->getCslSourceUnitType();
  m_instantiationsMap = RefTMap_RefString_RefCDOmBase(new TMap_RefString_RefCDOmBase());

 
  //ACTUAL FILE INITIALIZATIONS
  //FileName init
 
  /*  if(m_moduleCslType == CDOmModuleDecl::GEN_FROM_TB){
    m_moduleFileName->append("_testbench");
    }*/
 

  //Vh FILE GENERATION
  vhout << *m_moduleFileName << std::endl;

   RefTVec_RefCDOmBase instDeclVec = moduleDecl->getInstancesDeclarationsAsBase();
//   if(instDeclVec.get() && (instDeclVec->size() > 0 || moduleDecl->isTopModule())){
//     vfout = new std::ofstream((m_outputPath + *(m_currentModuleName) + ".vf").c_str());
//     out = vfout;
//     copyrightNotice(*(m_currentModuleName)+".vf");
//     //includeing VF Include option in top unit vf
//     if(moduleDecl->isTopModule() && m_vfIncludeString.get()){
//       (*vfout) << "+incdir+" << *(m_vfIncludeString) << std::endl;
//     }

//     //Including enum defines file - not module dependent and only from CSL flow
//     //WARNING - USING UNDEFINED BECAUSE THERE IS NO ENUM FOR THE VERILOG FLOW
//     if(moduleDecl->isTopModule() && (NSCdom::CDOmModuleDecl::GEN_FROM_UNDEFINED < m_moduleCslType)){
//       (*vfout) << "enum_define.v" << std::endl << std::endl;
//     }

//     //Iterating through instances and printing their respecive names according to 
//     //the presence/absence of instantiations
//     for(TVec_RefCDOmBase_const_iter iter = instDeclVec->begin(); iter < instDeclVec->end(); ++iter){
//       //checking to see if instantiation name is already in the map
//       //no else here, if it is,do nothing (otherwise a duplicate name will show)
//       if(m_instantiationsMap.get() && (m_instantiationsMap->find((CDOmModuleDecl::cast(*iter))->getModuleName()) == m_instantiationsMap->end())){
         //if the name is not inn the map, add it so that we can test for it's existence later on
   //        m_instantiationsMap->insert(TPair_RefString_RefCDOmBase((CDOmModuleDecl::cast(*iter))->getModuleName(), *iter));
//         //print the name in the vf file
      
//         RefString vfItem = (CDOmModuleDecl::cast(*iter))->getModuleName();
//       }
  //    }
	 //         if((CDOmModuleDecl::cast(*iter))->hasInstantiations()){
//           (*vfout) << "-f " << *vfItem << ".vf";
//         }
//         else{
//           (*vfout) << *vfItem << ".v";
//         }
//         (*vfout) << std::endl;
//       }
//     }
//     //Printing the actual module name
//     (*vfout) << *(m_currentModuleName) << ".v" << std::endl;
//     delete vfout;
//   }

  //Output File Stream init
  //out = new std::ofstream(((*m_moduleFileName).append(".v")).c_str());
 
   
  indt(m_depth);
  //Including defines
  /* if(*(m_currentModuleName) != "stim_expect_mem_template") { //-------OB added so that the template it's not included in the defines file
    defout << "`include \"" << *(m_currentModuleName) << "_define.v\"" << std::endl << std::endl;
  }
  //---------OB added because there are 2 different define files for stim & exp vectors which are not independent modules---start
  if(m_moduleCslType == CDOmModuleDecl::GEN_FROM_TB){
    m_vect = TRUE;
  }
  if(TRUE == m_vect) {
    defout << "`include \"" << "stim_define.v\"" << std::endl << std::endl; 
    defout << "`include \"" << "exp_define.v\"" << std::endl << std::endl;
    m_vect = FALSE;
  }
  //--------OB---end
  *(out) << "`include \"defines.v\"" << std::endl << std::endl;
  */

	       

  //---------MS added----------

  time_t* temp = new time_t;
  time_t cpright_date = time(temp);

  *(out) << "--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER\n--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc\n";
  *(out) << "--OUTPUT FILE NAME  : " << *m_moduleFileName << std::endl;
  *(out) << "--FILE GENERATED ON : " << ctime(&cpright_date) << std::endl;
  *(out) << "\n";
  *(out) << "library ieee ; \n";
  *(out) << "use ieee.std_logic_1164.all;\n";
  *(out) << "use ieee.std_logic_unsigned.all; \n";
  *(out) << "use ieee.std_logic_arith.all;\n";
  *(out) << "use ieee.numeric_std.all;\n \n";
  *(out) << "use work.csl_util_package.all;\n\n";
  

  if(moduleDecl->getKeywordType()==CDOmModuleDecl::KEYWORD_MODULE){

     
    *(out) << "entity ";
 
  } else {
    *(out) << "/* Error in entity declaration */" << std::endl;
  }

  delete temp;
 
  
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) {
  //std::cout << "ID parent is " << id->getParent()->getType() << std::endl;
        	m_idPrintSemi = FALSE;
		m_inputExpr = FALSE;
		//	m_assignStmt = FALSE; // no assign statements
               
		//   m_hasSignal = FALSE;
				   
if(TRUE == m_designGenCode) {
  RefCDOmBase parent = id->getParent();

  if(parent->getType() == TYPE_DECL_MODULE){
	//-----------MS added---start

          module = Ref_CVHDLModuleData(new CVHDLModuleData::CVHDLModuleData); //create a new module object---MS added
	  
	// create a new module object to build the architecture
	  modDecl = Ref_CVHDLArchData(new CVHDLArchData::CVHDLArchData);
	  modDecl->setTopModuleName(id);
	  *(out) << *(id->getName()) << " is \n";
	 
	  // m_dutVec->push_back(dutName);
	  /*	    if( *(id->getName()) != "stim_expect_mem_template"){
	    dutName = RefString(new std::string(*(id->getName())) );
	  }
	  else{
	    if(dutName.get()){
	      m_tb = TRUE;
  
	    }
	    }*/
       //----------------end
          m_addIndent = id->getName()->size();
	  //  std::cout <<"---------ModuleName= " << *(id->getName()) <<"\n";


		    }

   else if ( parent->getParent()->getType() == TYPE_MODULE_INSTANTIATION  ){
     
     
         //-----------MS added---start
        // create a new object to hold the information about the instances in the architecture
     //  std::cout << "------- inside Module Inst-----\n";
	   modInst = Ref_CVHDLModuleInstance(new CVHDLModuleInstance::CVHDLModuleInstance);
	   RefString instName = RefString(new std::string(*(id->getName())) );
	  
	// add the instance name to modInst object
	   modInst->setInstanceName(instName);
	
	// add modInst object to vector
          modDecl->addInstanceData(modInst);
	  
	  	   }
       

    else if(parent->getType() == TYPE_NET_DECL ){
  // else if(parent->getType() != TYPE_PORT_ITEM ){
     
      //-----------MS added---start
          m_hasSignal = TRUE;
	  signal = Ref_CVHDLSignalData(new CVHDLSignalData::CVHDLSignalData);
          RefString signalName= RefString(new std::string(*(id->getName())) );
          signal->addSignalName(signalName);
    	 
       //----------------end
     
      
       }   
    else if(parent->getType() == TYPE_VAR_DECL ){
      variable = Ref_CVHDLVarData(new CVHDLVarData::CVHDLVarData);
      RefString varName= RefString(new std::string(*(id->getName())) );
     
      variable->addVarName(varName);
     
      m_hasVar = TRUE;
      // *(out) << std::endl;
      // *(out) << *(id->getName()) << std::endl;
}

    else if(parent->getType() != TYPE_PORT_ITEM  && parent->getType() != TYPE_PARAM_DECL){
      m_portDeclNo++;
      

     
      if(m_portDeclNo > 1){  
	*(out) << ";";
}
      
        *(out)<< std::endl;
        indt(m_depth+3);

	*(out)<< *(id->getName()) ;
	

	//----------MS added-used for component scope--------
	port = Ref_CVHDLPortData(new CVHDLPortData::CVHDLPortData);
        RefString portName = RefString (new std::string (*(id->getName())));
        port->addPortName(portName);
	//----------------------------------     
	  } 

    else if (parent->getType() == TYPE_PARAM_DECL){
      // parNo = (modInst->getParamData())->size();
      /*	std::string par;
	TInt num;
	RefString paramName;
	if(pVec.get()){
      paramName= RefString(new std::string (*(id)->getName()));
      parameter->addParamName(paramName);
      
      par = " : csl_integer := ";
      parameter->addParamType(RefString(new std::string (par)));

      RefCDOmExpr payloadExpr = CDOmExpr::cast((id)->getPayload()->getChild(0));
      num = CDOmNumber::cast(payloadExpr)->getValue() ;
      parameter->addParamValue(num);
      
      pVec->push_back(parameter);*/
     
      // *(out) << " paranName=" << *parameter->getParamName() << " paramType=" << *parameter->getParamType() << " paramValue=" << parameter->getParamValue();
    
       m_param = TRUE;     
    }
    else { m_param = FALSE;}

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
					if( id->getIdType() == CDOmIdentifier::ID_PARAM){
					  // m_param = TRUE;
					  // *(out) << "param =" << m_param;
					}
				}
				}
		}

 
/* if(id->supportsPayload()){
  RefCDOmBase payload = id->getPayload();
  if(payload.get()){
    //To be factored
    m_expandNum32 = TRUE;
    /*    if (id->getIdType() == CDOmIdentifier::ID_UDP_PORT_OUTPUT_PL || id->getIdType() == CDOmIdentifier::ID_PARAM || (id->getIdType() == CDOmIdentifier::ID_VAR && payload->getType() != TYPE_RANGE_LIST) || ( id->getIdType() == CDOmIdentifier::ID_NET && payload->getType() != TYPE_RANGE_LIST ) || id->getIdType() == CDOmIdentifier::ID_PORT) 
     *(out) << " = "; */
// }
//  }


}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ){

}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ){
  //Initializations
  m_exprLinkExprSize = 0;
  m_exprLinkExprCnt = 0;
  m_exprLinkListExprSize = 0;
  //m_LHS = RefString(new std::string(" "));
  assVec = RefTVec_RefString(new TVec_RefString);
  // TInt numeric;
  //opConcatVec = RefTVec_RefString(new TVec_RefString);
  // tmp; 
  // RefCDOmExprLink assnStmTemp;

  // *(out) << "input_Port";
if(TRUE == m_designGenCode) {
	RefCDOmBase parent = exprLink->getParent();
	ECDOmType parentType = parent->getType();
	TMap_RefString_ESCPortWidthType_const_iter mapIter = m_portWidthTypeMap->find(exprLink->getName());
	m_assignPartSel = FALSE; // there is no assign stmt with part sel


  if(!exprLink->isHID()){
	if(parentType != TYPE_PORT_ITEM && 
	   parentType != TYPE_INST_MODULE || 
	   parentType == TYPE_RANGE && m_rangeGenExpr) {
	
			// write names of instantiated modules
			if(TYPE_EXPR != parentType) { 
			  //	*(out) << *(exprLink->getName()); 
			  
					}
				}
	// print LHS and signal/port RHS of assign statement
	if(TRUE == m_assignStmt && parentType != TYPE_EXPR && parentType == TYPE_ASSN) {
	  m_assignStmt = TRUE;
	  opConcatVec = RefTVec_RefString(new TVec_RefString);
	  opExprVec = RefTVec_RefString(new TVec_RefString);

	  RefString assnStmTemp = RefString( new std::string( *(exprLink->getName()))); 
	  if(s==0){
	    assignVec->push_back(assnStmTemp); //MS added
	    
	    m_LHS = assnStmTemp;
	    s=1;
	  }
	  else {
	   
	    assVec->push_back(assnStmTemp);
	   
	   
	    if(i <= assignVec->size()){
	      // m_exprNum = TRUE;
	     
	      assignMap->insert(std::make_pair(assignVec->at(i), assVec));

	         if(assVec->size() == 1){
		//	*(out) << "TRUE";
		//m_exprNum = TRUE;
		m_LHS = assnStmTemp;
		}
	    
	      i=i+1;
	      // assVec.reset();
	    }
	    s=0;
	  }
	  
	}
	

	if(parentType == TYPE_EXPR ){
	  opExpr = TRUE;
	}

        if(parentType == TYPE_INST_MODULE) {
	
	//-----MS added----start

	  if(TRUE == m_actualExpr) {
	    *(out) << *(exprLink->getName());
	     
	      if(TRUE == m_partSelActual) {
	    
		    if(p == 'o') {
					      
		      // object to hold the information about the formals and actuals in the constructor
		      RefString actualName = RefString(new std::string(*(exprLink->getName())));
					      
		      // write part sel actual in f2a connection
		      // *(out) << *actualName << "("; 
		       m_isExprActual = FALSE;

		    }
					    
	    }
	 else {
	   if(!m_assignHID){
	     // *(out) << *(exprLink->getName());
	   }
	   else { 
	     
	     RefString actName = RefString(new std::string(*(exprLink->getName())));
	     actualNameVec->push_back(actName); 
	   }
	 }
	      m_actualExpr=FALSE;	
			  
	  }
	//-------end
        }
	if(TYPE_EXPR == parentType && 
				   CDOmExpr::EXPR_OP == CDOmExpr::cast(parent)->getExprType() && 
				   //	 mapIter != m_portWidthTypeMap->end()){  
				   parent->getType() != TYPE_PORT_ITEM) {
				
					//-------MS added----start
	  
				  // write RHS for assign statement
				  if(TRUE == m_assignStmt) {
				    // *(out) << *(exprLink->getName()) ; 
				 				 
				    if(opExpr){
				     
				    RefString opExprStmTemp = RefString( new std::string( *(exprLink->getName())));
				    if(!opExprStmTemp->empty()){
				      if(opExprVec.get()){
				      opExprVec->push_back(opExprStmTemp);
				      }
				      if(s==1){
					if(i < assignVec->size()){
					  
					  assignMap->insert(std::make_pair(assignVec->at(i), opExprVec));
					  
					}
					i=i+1;
				      }
				    }
				    s=0;
				    //}
				    
				    }
				  }
				  else {
				    
				    // f2a's with expression as actual
				    if(p == 'i') {
				      // generated signal name
				      
				      if(TRUE == m_actualExpr) {
				
					m_actualExpr = FALSE;
					
				      }
				      
				    } 					
				    else if(p == 'o') {
				      
				      
				      // object to hold the information about the formals and actuals in the architecture
				      RefString actualName = RefString(new std::string(*(exprLink->getName())));
				      
				      RefString s = RefString(new std::string(std::string(*actualName )));
				      
				      if(TRUE == m_actualExpr) {
						*(out) << *s;
					
										
				      }
				      
				    }
				  }


	}

// print RHS if it's a concat
	else if(TYPE_EXPR == parentType && 
	        CDOmExpr::EXPR_CONCAT == CDOmExpr::cast(parent)->getExprType() && 
	        parent->getType() != TYPE_PORT_ITEM) {
	  // *(out) << *(exprLink->getName()); 
	  m_concatExpr = TRUE;
	  
	  //----MS added-------------------
	  RefString opConcatTemp = RefString( new std::string( *(exprLink->getName())));
	 
	  if(opConcatTemp.get()&& opConcatVec.get()){
	    opConcatVec->push_back(opConcatTemp);
	   
	    if(s==1){
	      if(i < assignVec->size()){
		assignMap->insert(std::make_pair(assignVec->at(i), opConcatVec));
	     
	      }
	      i=i+1;
	    }
	  }
	  s=0;
	  //------------------------------------ 
	}
	else if(TYPE_EXPR == parentType && 
		CDOmExpr::EXPR_OP == CDOmExpr::cast(parent)->getExprType() && 
		parent->getType() != TYPE_PORT_ITEM) {
	  
		}
	}
 
else {
	m_exprLinkHidNames = exprLink->getHidNames();
	m_exprLinkExprs = exprLink->getHidExprs();
    if(m_exprLinkHidNames.get()) { 
	m_exprLinkExprSize = m_exprLinkHidNames->size();
	*(out) << *(m_exprLinkHidNames->at(m_exprLinkExprCnt));
	if((m_exprLinkExprs->at(m_exprLinkExprCnt)).get()){
	  	*(out) << "&";
	 
	  
		//RefString tmp = RefString(new std::string("&"));
		//opConcatVec->push_back(tmp);
	}
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


void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ){
  //Initializations
  //m_posCnt = 0;
  m_exprCnt.push_back(0);

  RefCDOmBase parent = exprOp->getParent();
  if(parent.get() && parent->getType() == TYPE_EXPR){
    if(CDOmExpr::cast(parent)->getExprType() == CDOmExpr::EXPR_MINTYPMAX){
      // *(out) << "(";
      }
  }

  if(exprOp->isUnary()){
    switch(exprOp->getOpType()){
      case(CDOmExprOp::OP_UNARY_ARITHMETIC_PLUS)  : *(out) << "+("               ;       break;
      case(CDOmExprOp::OP_UNARY_ARITHMETIC_MINUS) : *(out) << "-("               ;       break;
      case(CDOmExprOp::OP_UNARY_LOGIC_NOT)        : *(out) << "!("               ;       break;
      case(CDOmExprOp::OP_UNARY_BITWISE_NOT)      : *(out) << "~("               ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_AND)    : *(out) << "&("               ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_NAND)   : *(out) << "~&("              ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_OR)     : *(out) << "|("               ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_NOR)    : *(out) << "~|("              ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_XOR)    : *(out) << "^("               ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_XNOR)   : *(out) << "~^("              ;       break;
      default                                     : *(out) << "Error" <<std::endl;       break;
    }
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ){
  //Initializations
  m_listExprCnt = 0;
  m_listExprHasExprLinkParent = FALSE;
  m_listExprHasFunctionCallParent = FALSE;
  m_parent = listExpr->getParent();
  if(m_parent->getType() == TYPE_STMT){
    if(CDOmStmt::cast(m_parent)->getStmtType() == CDOmStmt::STMT_CASE){ 
      //// calling indenter function ////
      indt(m_depth);
    }
  } 
  if(m_parent.get()){
    if(m_parent->getType() == TYPE_EXPR){
      if((CDOmExpr::cast(m_parent))->getExprType() == CDOmExpr::EXPR_HID){
      m_listExprHasExprLinkParent = TRUE;
      // *(out) << "[";
    } else if((CDOmExpr::cast(m_parent))->getExprType() == CDOmExpr::EXPR_FUNCTION_CALL){
      m_listExprHasFunctionCallParent = TRUE;
      //  *(out) << "(";
    }
  }
  }
  m_listExprSize = listExpr->getNumberOfChildren();
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) {
  //Initializations

  m_orderedPortNumSize++;
if(portDecl->getVarType() != VAR_TIME && portDecl->getVarType() != VAR_INTEGER){
    RefCDOmRange testRange = portDecl->getRange();
    if(testRange.get()){
      m_pdcnt = -1;
    }else{
      m_pdcnt = 0;
    }
  }
   else{
    m_pdcnt = 0;
  }  
  RefTVec_RefCDOmIdentifier idVec = portDecl->getIDs();
  if(idVec.get()){
    m_portIdSize = idVec->size();
    }
  
  //*(out) << "m_pdcnt= "<< m_pdcnt;
  if(m_pdcnt == -1){
    // *(out) << " port( " << std::endl;
    m_pdcnt++;
  }
  //-----------------------MS added----------------

 if(portDecl->getRange().get()) {
   TVec_RefCDOmIdentifier_const_iter iter = idVec->begin();
   for(; iter != idVec->end(); ++iter) {
     m_portWidthTypeMap->insert(TPair_RefString_ESCPortWidthType((*iter)->getName(), TYPE_SC_VECTORED));
     //-------MS added----start:if an input port is declared, add the name of the port to m_inputPortCon
     if(portDecl->getPortType() == PORT_INPUT) {
       if(!m_inputPortCon.get()) {
	 m_inputPortCon = RefTList_RefString(new std::list<RefString>);
       }
       m_inputPortCon->push_back((*iter)->getName());
       p = 'i';
       
       // add input ports and their width to map 
       if(!inputPortsMap.get()) {
	 inputPortsMap = Ref_TMap_RefString_TInt(new TMap_RefString_TInt);
       }
       formalName = (*iter)->getName();
       inputPortsMap->insert(TPair_RefString_TInt(formalName,0));
       m_inputPorts = TRUE;
       //cout<<">>>>>>>>insert input port in map:" << *formalName << endl;
       
     }
     
     //-------MS added----start:if an output port is declared, add the name of the port to m_outputPortCon
     if(portDecl->getPortType() == PORT_OUTPUT) {
       if(!m_outputPortCon.get()) {
	 m_outputPortCon = RefTList_RefString(new std::list<RefString>);
       }
       m_outputPortCon->push_back((*iter)->getName());
       p = 'o';
     }
 //-------MS added----start:if an inout port is declared, add the name of the port to m_inoutPortCon
     if(portDecl->getPortType() == PORT_INOUT) {
       if(!m_inoutPortCon.get()) {
	 m_inoutPortCon = RefTList_RefString(new std::list<RefString>);
       }
       m_inoutPortCon->push_back((*iter)->getName());
       p = 'b';
     }
     
     //-----end

   }
 }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ){
  //Initializations
TVec_RefCDOmIdentifier::const_iterator iterId;
  if(varDecl->getVarType() == VAR_REG){
    RefCDOmRange testRange = varDecl->getRange();
    if(testRange.get()){
      m_vrcnt = -1;
    }else{
      m_vrcnt = 0;
    } 
  }else{
      m_vrcnt = 0;
  }
 
    RefTVec_RefCDOmIdentifier varIdVec = varDecl->getIDs();
  if(varIdVec.get()){
    m_varIdSize = varIdVec->size();
     
  }

}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ){
  //Initializations
  RefCDOmRange testRange = netDecl->getRange();
  if(testRange.get()){
    m_ntcnt = -1;
  }else{
    m_ntcnt = 0;
  }
   RefTVec_RefCDOmIdentifier netIdVec = netDecl->getIDs();
  if(netIdVec.get()){
    m_netIdSize = netIdVec->size();
  }
 
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmRange                           & range                       ){
  //if(range->getWidth() == 1){
  //  m_noRange = TRUE;
  //} else {
  //*(out) << "[";
  //}
   //redundat children retrival to cancel printing [0:0]
      
      RefTVec_RefCDOmBase rangeChildrenVec = range->getChildrenAsBase(TYPE_EXPR);
      
   if(rangeChildrenVec.get() && rangeChildrenVec->size() == 2){ 
     if(CDOmExpr::cast(rangeChildrenVec->at(0))->getExprType() == CDOmExpr::EXPR_NUMBER && CDOmExpr::cast(rangeChildrenVec->at(1))->getExprType() == CDOmExpr::EXPR_NUMBER){
       m_showRange = CDOmNumber::cast(rangeChildrenVec->at(0))->getValue() || CDOmNumber::cast(rangeChildrenVec->at(1))->getValue();
     }
   }
  
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmNum32                           & num                         ){
  //Indenter
  TVec_char_iter iter1;
  m_num32Indent = TRUE;
    char *numTemp ;
    if(m_showRange) {
    RefCDOmBase numParent = num->getParent();
    
    if(numParent.get() && numParent->getType() == TYPE_LIST_EXPR){
      // retrieving parent's parent: we need to check for the
      // particular case: case stmt -> list expr -> number when
      // the indent function should not be called
      RefCDOmBase numParentParent = numParent->getParent();
      if(numParentParent.get() && numParentParent->getType() == TYPE_STMT){
        if(CDOmStmt::cast(numParentParent)->getStmtType() == CDOmStmt::STMT_CASE){
          m_num32Indent = FALSE;
        }
      }
      if(m_num32Indent){
        //// calling indenter function ////
        indt(m_depth);
      }
    }
    m_num32value = num->getValue();
    m_num32width = num->getWidth();
    // this is for testing purposes (remove after CDOm/CSLOm fix)
    // m_num32width = 6;
    m_num32baseType = num->getNumBaseType();
    if(num->isSigned()){
      m_num32signed = TRUE;
    }
    else{
      m_num32signed = FALSE;
    }
    if(num->getIsVeriNumFlag()){
      m_expandNum32 = TRUE;
    }
    else{
      m_expandNum32 = FALSE; 
    }
    if(m_expandNum32){
      if(m_num32baseType != CDOmNumber::NUM_BASE_UNDEFINED){
	// *(out) << m_num32width << "'";
        if(m_num32signed){
	   *(out) << "s";
        } 
        switch(m_num32baseType){
          case (CDOmNumber::NUM_BASE_BIN) : 
            {
	      
	      if(!m_assignStmt && !m_param && !m_parOver && !m_hasVar){
		 *(out) << "\"";   
	      //----------MS added------------      
	    
              *(m_num32TempStr) = dec2Bin(m_num32value, m_num32width);
              //reverse printing the string to get the order right
              for(TInt i = (*m_num32TempStr).size()-1; i >= 0; --i){
	         *(out) <<  (*m_num32TempStr).at(i);
	
              }
              //m_num32TempStr.clear();
	     
	       *(out) << "\""; //----------MS added------------
	       if(m_isExprActual ==TRUE){
		 std::cout << m_isExprActual ;
	       }
	      }
	      //----------MS added- assign with numbers on RHS---------
	      else{
		
		if(m_exprNum == TRUE ){
		   char *strTemp = "\"";
		  
		  numVec.push_back(*strTemp);
		  
		*(m_num32TempStr) = dec2Bin(m_num32value, m_num32width);
	
              //reverse printing the string to get the order right
		 for(TInt i = (*m_num32TempStr).size()-1; i >= 0; --i){
		  		  
		   numVec.push_back((*m_num32TempStr).at(i));
		  
		 }
		 
		  char *strTemp1 = "\"";
	       numVec.push_back(*strTemp1);
	      
	       RefString m_assName = m_LHS;
	   
	       if(m_assName.get() && !numVec.empty()){
	
		 numMap->insert(std::map<RefString,TVec_char>::value_type(m_assName, numVec));
	       
	       }
	       numVec.erase(numVec.begin(),numVec.end());
	      
		}
		//--------parameter--------------------
		if(m_parOver){
		  
		  char *strTemp = "\"";
		  // *(out) << "\"";
		  //numVec.push_back(*strTemp);
		 numParVec.push_back(*strTemp);
	  
		  *(m_num32TempStr) = dec2Bin(m_num32value, m_num32width);
	
		  //reverse printing the string to get the order right
		 for(TInt i = (*m_num32TempStr).size()-1; i >= 0; --i){
		   
		   // numVec.push_back((*m_num32TempStr).at(i));
		   numParVec.push_back((*m_num32TempStr).at(i));
		   //*(out) << (*m_num32TempStr).at(i);
		 }
		 
		 char *strTemp1 = "\"";
		 //numVec.push_back(*strTemp1);
		 numParVec.push_back(*strTemp1);
		 // if( !numVec.empty()){

		 // for(TInt iter = 0; iter < numVec.size(); iter++)
		 //   numParVec.at(iter)

		    //paramOverMap->insert(std::map<RefString,TVec_char>::value_type(m_parName, numVec));
	       
		   // }
	         //numVec.erase(numVec.begin(),numVec.end());
		
		  m_parOver = FALSE;
		  m_param = FALSE;
		 }
	      //--------------------------------------------------------
	
	      }
	     	      
            }

            break;
          case (CDOmNumber::NUM_BASE_OCT) : 
            {
              *(out) << "O";
              m_num32Stream << std::oct << m_num32value;
              //m_num32Stream >> m_num32TempStr;
              (*m_num32TempStr) = m_num32Stream.str();
              //the width on which the number is represented
              //could be smaller and therefore zero-padding might
              //be required
              m_num32TempWidth = (*m_num32TempStr).size() * 3 ; //each oct digit is 3 bits
              while(m_num32TempWidth < m_num32width){
                *(out) << "0";
                m_num32TempWidth = m_num32TempWidth + 3;
              }
              *(out) << *m_num32TempStr;
              m_num32Stream.str(std::string());
              //m_num32TempStr.clear();
            }
            break;
          case (CDOmNumber::NUM_BASE_DEC) : 
            {
	      
              *(out) << "'" << m_num32value  << "'";  //----------MS added--------
	      if(m_parOver){
		*(out) << "'" << m_num32value  << "'";
	      }
            }
            break;
          case (CDOmNumber::NUM_BASE_HEX) : 
            {
	      std :: cout <<" hex number";
	      if(!m_assignStmt){
              *(out) << "x\"";          //----------MS added----------
              m_num32Stream << std::hex << m_num32value;
              //m_num32Stream >> m_num32TempStr;
              (*m_num32TempStr) = m_num32Stream.str();
              //the width on which the number is represented
              //could be smaller and therefore zero-padding might
              //be required
              m_num32TempWidth = (*m_num32TempStr).size() * 4 ; //each hex digit is 4 bits
              while(m_num32TempWidth < m_num32width){
                *(out) << "0";
                m_num32TempWidth = m_num32TempWidth + 4;
              }
	      *(out) << *m_num32TempStr; 
             
              m_num32Stream.str(std::string());
              //m_num32TempStr.clear();
	      *(out) << "\"";    //---------MS added-----------
            }
	    //----------MS added- assign with numbers on RHS---------
	      else{
		
		if(m_exprNum == TRUE ){
		  char *strTemp2 = "x\"";
		  numVec.push_back(*strTemp2);
		  std :: cout <<"strTemp2=" << *strTemp2;
		  m_num32Stream << std::hex << m_num32value;
		  (*m_num32TempStr) = m_num32Stream.str();
	
		  m_num32TempWidth = (*m_num32TempStr).size() * 4 ; //each hex digit is 4 bits
		  while(m_num32TempWidth < m_num32width){
		    char  *strTemp3 = "0";	  
		      numVec.push_back(*strTemp3);
		    m_num32TempWidth = m_num32TempWidth + 4;		
		 }
		  for(TInt i = 0; i<(*m_num32TempStr).size()-1; i++){
		    numVec.push_back((*m_num32TempStr).at(i));
		  }
	      char *strTemp4 = "\"";
	      numVec.push_back(*strTemp4);
	      
		}
	      }
	    }
	      //--------------------------------------------------------
            break;
        }
      }
    } 
    else {
      //  m_param = FALSE;
      // *(out) << m_param;  
        //-----------MS added---start
	// create a new range object 
      if(!m_assignPartSel && !m_param){
       rangeData = Ref_CVHDLRangeData(new CVHDLRangeData::CVHDLRangeData);
      
       rangeData->setLowerLimit(m_num32value);  
	  
       m_lower=rangeData->getLowerLimit();  
	  
       rangeData->setUpperLimit(m_num32value);
     
       m_upper=rangeData->getUpperLimit();
       m_upperVec.push_back(m_upper);
         
      }
     	
       //----------------end
     }

   
    //----------------------------------MS added----------------------------
	// check if there is a number used as an actual in a connection with an input or output port
		       if(TRUE == m_isNumActual && m_actualExpr && !m_assignStmt) {
			       

			  if(p == 'o') {
			    
			     *(out) << num->getValue();
			    std::cout<<"***********output port connected with number:" << num->getValue() << std::endl;
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
					    //std::cout<<"!!!!!!!!rangeNo is 0\n";
					  }
					  else if(rangeNo == 1) {
					    actualName = RefString(new std::string("downto" + ss.str() + ")"));
					    // std::cout<<"!!!!!!!!rangeNo is 1\n";
					  }
					  
					  // *(out) << *actualName;
					  
					  rangeNo++;
				}

				m_inputExpr = TRUE;
				m_isExprActual = FALSE;
				m_isNumActual = FALSE;
				m_binaryExpr = FALSE;
				m_width = FALSE;  // finished adding the width

			       	std::cout<<">>>>>Actual Expr: actual range part select:" << num->getValue() << std::endl;
      
			}
			// if there are numbers in statement
			else if(TRUE == m_assignStmt) {
			  // *(out) << "m_assignPartSel!!!=" << m_assignPartSel;
			  if(TRUE == m_assignPartSel) {
			    std::stringstream temp;
			    
			    // 2nd number in range has a "," before it to separate the 2 numbers in the range
			    if(rangeNo == 0) {

			      // *(out) << "(" << num->getValue();
			      // partSelVec.push_back(num->getValue());
			      temp << num->getValue();
			      
			      assVec->push_back(RefString(new std::string("(" + temp.str())));
			    }
			    else if(rangeNo == 1) {
			      // *(out) << "downto " << num->getValue() << ")";
			      // partSelVec.push_back(num->getValue());
			      temp << num->getValue();
			      assVec->push_back(RefString(new std::string((" downto " + temp.str()+ ")"))));
			      
			    }
			    rangeNo++;
			    
			  }
			  else {
			    //*(out) << num->getValue();
			   
			  }
			
			  m_binaryExpr = FALSE;
			  // m_assignStmt = FALSE;
			  //m_assignPartSel = FALSE;
			}
			//------end

		      
    //-----------------------------------------------------------------------

  }
  m_expandNum32 = FALSE;
 
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmReal                            & realNum                      ){
    *(out) << *(realNum->getTokenString());
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) {
  //Initializations
m_intcnt = 0;
m_moduleInstantiationParamNo = 0;
m_moduleInstantiationType = moduleInstantiation->getModuleInstantiationType();
m_moduleInstantiationName = RefString();
m_moduleInstantParamExprVec = RefTVec_RefCDOmExpr();
m_portItems = RefTVec_RefCDOmPortItem();

  m_intHasParams = FALSE;
  m_intExprCnt = 0;
  m_moduleInstantiationIndt = 0; //safe init
  /* RefTVec_RefCDOmBase exprsVec = moduleInstantiation->getChildrenAsBase(TYPE_EXPR);*/
  /* if(exprsVec.get()){
    m_intExprSize = exprsVec->size() - 1; //-1 because the first expr is the name of the instantiated module
    if(m_intExprSize > 0){
      m_intHasParams = TRUE;
    }
  }
  if(m_intHasParams){
    m_intcnt = -(m_intExprSize);
  }
  else {
    m_intcnt = 0;
    }*/
  
  /* m_moduleInstantiationIndt = moduleInstantiation->getModuleExprLink()->getName()->size() + 1; 

  //WARNING: disabled for now due to time constraints - it is fairly complex to calculate the width of the parameter 
  //assignment list as these can be identifiers or numbers (with variable digits)
  //if(m_intHasParams){
  //  m_moduleInstantiationIndt += 5; //for space, #, ( and ) and something else when params are used
  //  m_moduleInstantiationIndt += (m_intExprSize - 1);
  //}
  ///////////////////////////////////////////////////

  RefTVec_RefCDOmModuleOrUdpInstance moduleOrUdpInstanceVec = moduleInstantiation->getModuleInstances();
  if(moduleOrUdpInstanceVec.get()) {
    m_instanceNumSize = moduleOrUdpInstanceVec->size();
  }

  //// calling indenter function ////
  indt(m_depth);
  if(moduleInstantiation->getModuleInstantiationType() == CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN) {
    m_paramNameMapIt = moduleInstantiation->getExplicitParamNameMap()->begin();
    }*/



		//------MS added---start
		RefTVec_RefCDOmBase exprsVec = moduleInstantiation->getChildrenAsBase(TYPE_EXPR);
		

		if(exprsVec.get()){
			//    m_intExprSize = exprsVec->size() - 1; //-1 because the first expr is the name of the instantiated module
			if((exprsVec->size() - 1) > 0){
				//      m_intHasParams = TRUE;
			  m_param = TRUE;
			   m_parOver = TRUE;
			}
		}
		//-----------end


		RefCDOmScope designScope = m_design->getAttachedScope();
		RefCDOmIdentifier moduleInstID = designScope->lookupLocal(moduleInstantiation->getModuleExprLink()->getName());
		if(moduleInstID.get()) {
			m_portItems = CDOmModuleDecl::cast(moduleInstID->getParent())->getPortItems();
			}
		m_moduleInstantiationName = moduleInstantiation->getModuleExprLink()->getName();
		//	std::cout << "m_moduleInstantiationName= " << *m_moduleInstantiationName << "\n " ;

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
				//	*(out) << "2ParamNo =" <<m_moduleInstantiationParamNo;
			}
		}


		//// calling indenter function ////
		indt(m_depth); 
 if(moduleInstantiation->getModuleInstantiationType() == CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN) {
    m_paramNameMapIt = moduleInstantiation->getExplicitParamNameMap()->begin();
    // m_parOver = TRUE;
    //*(out) << "Map=" << *m_paramNameMapIt->first ; 
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ){
  //Initializations
  m_inscnt = 0;
  m_insctrl = 0;
  m_moduleInstanceSize = 0;
  m_moduleInstanceExprSize = 0;
  m_moduleInstanceExprCnt = 0;
  m_moduleInstanceCnt = 0;
  m_emptyIndexesVec = RefTVec_TUInt();
  m_moduleInstanceIndt = (CDOmIdentifier::cast(moduleInstance->getChild(0))->getName())->size() + 1;
  if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION) {
    RefTVec_RefCDOmBase exprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
    if(exprVec.get()) {
      m_moduleInstanceSize = exprVec->size();
      m_moduleInstanceExprSize = m_moduleInstanceSize;
    }
    
    m_emptyIndexesVec = moduleInstance->getEmptyIndexes();
    if(m_emptyIndexesVec != NULL) {
      reverse(m_emptyIndexesVec->begin(), m_emptyIndexesVec->end());
      m_moduleInstanceSize += m_emptyIndexesVec->size();
    }
  }
  else if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
    m_moduleInstanceSize = moduleInstance->getExplicitPortMap()->size();
    RefTVec_RefCDOmBase exprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
    if(exprVec.get())
      m_moduleInstanceExprSize = exprVec->size();
  }
        
	  
  //calling this if there are param assignments in instantiation
  //m_intHasParams and m_moduleInstanceIndt are initialized in the above function (beforeTraversal for
  //instantiation)
  if(m_param){
    indt(m_depth);
    portListIndt(m_moduleInstantiationIndt-1);
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {}   

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {
  // m_param = TRUE;

  // parameter = Ref_CVHDLParamData(new CVHDLParamData::CVHDLParamData);   
  
  //for initializations look below a few lines
  std::string par = " "; 
  m_nameMap = paramDecl->getNameMap();
  if(m_nameMap.get()){
    m_paramDeclChildren = m_nameMap->size();
    for(TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->begin(); iter != m_nameMap->end(); iter++) {
      m_namesVec.push_back(iter->first);
      // RefString paramName= RefString(new std::string(*iter->first));
      // parameter->addParamName(paramName);
    
    }
  }

  //// calling indenter function ////
  indt(m_depth);

  if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE){
    //WARNING: The following flag is set here for a quick fix - this may result
    //in a bug in CDOmPulseControl output
    m_pulseControlSection = FALSE;
    // m_param = TRUE;
    
    // *(out) << "generic ( ";
  } else if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_LOCAL){
    //WARNING: The following flag is set here for a quick fix - this may result
    //in a bug in CDOmPulseControl output
    m_pulseControlSection = FALSE;
    // *(out) << "localparam ";
  } else if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SPEC){
    m_pulseControlSection = FALSE;
    // *(out) << "specparam ";
    RefTVec_RefCDOmPulseControl pulseVec = paramDecl->getPulseControls();
    if(pulseVec.get()){
      *(out) << std::endl;
    }
  } else {
    DCERR("Error: parameter type not specified");
  }

  //*(out) << paramDecl->getParamDeclType2();
  if(paramDecl->getParamDeclType2() == 2){ //CDOmParamDecl::DECL_2
    if(paramDecl->getParamType() == CDOmParamDecl::PARAM_INTEGER){
      // *(out) << " : csl_integer ";
      par = " : csl_integer ";
    }
    if(paramDecl->getParamType() == CDOmParamDecl::PARAM_REAL){
      //*(out) << " : csl_real ";
      par = " : csl_real ";
    }
    if(paramDecl->getParamType() == CDOmParamDecl::PARAM_REALTIME){
      // *(out) << " : csl_realtime ";
      par = " : csl_realtime ";
    }
    if(paramDecl->getParamType() == CDOmParamDecl::PARAM_TIME){
      //*(out) << " : csl_time ";
      par = " : csl_time ";
    }
    //Initializations 
    m_paramDeclPos = 0;
  } else {
    //Initializations -- called here to avoid illegal states 
    RefCDOmRange range = paramDecl->getRange();
    if(range.get()){
      m_paramDeclPos = -1;
    } else {
      m_paramDeclPos = 0;
    }
    //the first test is to avoid checking for signed attribute on specparams (would throw an exception)
    if(paramDecl->getParamDeclType2() != 0 && paramDecl->isSigned()){
      *(out) << "signed ";
    }
  }
  par = ":csl_integer "; 
  
  // RefString parType = RefString (new std::string (par));
  // parameter->addParamType(parType);
  // module->addParamData(parameter);


    m_param = FALSE;
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ){
  //Initializations
  m_paramOverrideCnt = 0;
  m_paramOverrideSize = paramOverride->getChildrenSize();

  //// calling indenter function ////
  indt(m_depth);

  *(out) << "defparam ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ){
  m_minTypMaxCnt = 0;
  RefTVec_RefCDOmBase minTypMaxChildrenVec = minTypMax->getChildrenAsBase(TYPE_EXPR);
  if(minTypMaxChildrenVec.get()){
    m_minTypMaxChildren = minTypMaxChildrenVec->size();
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmDelay                           & delay                       ){
  //Initializations
  m_delayPos = 0;
  m_delaySize = delay->getChildrenSize();
  m_delayDeclType = delay->getDelayDeclType();
  switch(m_delayDeclType){
    case (CDOmDelay::DECL_1) : m_delayHasParanths = FALSE; break;
    case (CDOmDelay::DECL_2) : m_delayHasParanths = FALSE; break;
    case (CDOmDelay::DECL_3) : m_delayHasParanths = FALSE; break;
    case (CDOmDelay::DECL_4) : m_delayHasParanths = TRUE ; break;
  }
  

  RefCDOmBase parent = delay->getParent();
  if(parent.get() && parent->getType() == TYPE_STMT){
    if(CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_ASSN){
      //// calling indenter function ////
      indt(m_depth);  
    }
  }

  *(out) << "wait for ";
  if(m_delayHasParanths){
    //if(delay->getDelayType() == CDOmDelay::DELAY_2 || delay->getDelayType() == CDOmDelay::DELAY_3){
    //*(out) << "(";
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ){
  //// printing new line for readability ////
  *(out) << std::endl;
  ///////////////////////////////////////////

  //// calling indenter function ////
  indt(m_depth);
  //// entering new depth ////
  m_depth++;

  if(initOrAlways->getInitOrAlwaysType() == CDOmInitOrAlways::INIT_OR_ALWAYS_INIT ){
    *(out) << "initial ";
  } else if (initOrAlways->getInitOrAlwaysType() == CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS ){
    *(out) << "process ";
  }
  //the following may not be optimal but it works
  RefCDOmStmt initOrAlwaysChild = initOrAlways->getStmt();
  if(initOrAlwaysChild.get()){
    if(initOrAlwaysChild->getStmtType() == CDOmStmt::STMT_BLOCK_NAMED || initOrAlwaysChild->getStmtType() == CDOmStmt::STMT_BLOCK_UNNAMED){
      *(out) << std::endl;
    }
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmAssn                            & assn                        ){
  m_assnPos = 0;

  //// calling indenter function ////
  indt(m_depth);
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ){
  if(contAssn->hasDelay3()){
    m_contAssnPos = -1;
  } else {
    m_contAssnPos = 0;
  }
  
    RefTVec_RefCDOmAssn contAssnVec = contAssn->getNetAssns();
      m_contAssnSize = contAssnVec->size();

  //// calling indenter function ////
  indt(m_depth);

  //-------MS added------------------
	m_assignStmt = TRUE; // there is an assign statement

		m_designFuncIdNo++;
		m_depth++;

		m_assignHID = FALSE; // no assigns with signal/port as RHS

		TVec_RefCDOmAssn_const_iter it;
			for(it = contAssnVec->begin(); it != contAssnVec->end(); it++) {
		  if((*it)->getChildrenSize() > 0 && ((*it)->getExpr())->getExprType() == CDOmExpr::EXPR_HID) {
		    //cout<<">>>>>>>>>>>assign with expr!!!!\n";
		      m_assignHID = TRUE;
		  }
		  if((*it)->getChildrenSize() > 0 && ((*it)->getExpr())->getExprType() == CDOmExpr::EXPR_NUMBER){
		    m_exprNum = TRUE;
		    // m_assignStmt=TRUE;
		  }
		  }
//-------------------------------------
  //    if( contAssn->getFirstDriveStrength() != DRIVE_STRENGTH_UNDEFINED && contAssn->getSecondDriveStrength() != DRIVE_STRENGTH_UNDEFINED ){
      //  *(out) << "(";
  /* switch(contAssn->getFirstDriveStrength()){
      case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0, "                       ;      break;
      case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0, "                       ;      break;
      case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0, "                         ;      break;
      case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0, "                         ;      break;
      case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0, "                        ;      break;
      case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1, "                       ;      break;
      case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1, "                       ;      break;
      case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1, "                         ;      break;
      case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1, "                         ;      break;
      case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1, "                        ;      break;*/
  //   default                        : *(out) << "/* Error in drive strength */"   ;      break;
  /*   }
    switch(contAssn->getSecondDriveStrength()){
      case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0"                       ;      break;
      case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0"                       ;      break;
      case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0"                         ;      break;
      case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0"                         ;      break;
      case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0"                        ;      break;
      case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1"                       ;      break;
      case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1"                       ;      break;
      case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1"                         ;      break;
      case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1"                         ;      break;
      case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1"                        ;      break;*/
    //  default                        : *(out) << "/* Error in drive strength */" ;      break;
  //  }
   // *(out) << ") ";
   // } 
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ){
  if(stmt->getStmtType() == CDOmStmt::STMT_NULL){
    //// calling indenter function ////
    indt(m_depth);

    *(out) << ";" << std::endl;
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ){
  if(!(stmtBlock->getChildrenAsBase()).get()){
    m_stmtBlockSize = 0;
  }else {
    m_stmtBlockSize = stmtBlock->getChildrenSize(); 
  }
  //// calling indenter function ////
  //indt(m_depth);
  //// entering new depth ////
  //m_depth++;

  if(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_PARALLEL){
    *(out) << " fork "; //<< std::endl;
  } else if(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_SEQUENTIAL) {
    *(out) << " begin ";//<< std::endl;
  }
  if(stmtBlock->isNamed()){
    *(out) << ": ";
    m_stmtBlockCnt = -1;
  } else {
    m_stmtBlockCnt = 0;
    *(out) << std::endl;
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ){
  m_stmtAssnPos = 0;
  //// Indenter logic //// requires further optimization
  RefCDOmBase parent = stmtAssn->getParent();
  if(parent.get() && parent->getType() == TYPE_STMT){
    //To be factored
    m_assignStmt = TRUE;
    //The following types SHOULD NOT trigger indent
    //CDOmStmt::cast(parent)->getStmtType() != CDOmStmt::STMT_CASE 
    //CDOmStmt::cast(parent)->getStmtType() != CDOmStmt::STMT_IF

    //The following types SHOULD trigger indent
    if(CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_BLOCK_NAMED 
       || CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_BLOCK_UNNAMED ){
      //// calling indenter function ////
      indt(m_depth);
   } 
  }
  ///////////////////////
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ){
  m_eventExprVec = RefTVec_RefCDOmExprLink(new std::vector<RefCDOmExprLink>);

  /*  m_eventCtrlType = eventCtrl->getEventControlType();
  switch( m_eventCtrlType ){
    case (CDOmEventControl::EVENT_CONTROL_HID)                   : *(out) << " ";                                      break;
    case (CDOmEventControl::EVENT_CONTROL_EVENT_EXPR)            : *(out) << "( ";                                     break;
    case (CDOmEventControl::EVENT_CONTROL_STAR)                  : *(out) << "*";                                      break;
    case (CDOmEventControl::EVENT_CONTROL_STAR_WITH_PARENTHESIS) : *(out) << "(*)";                                    break;
 //   default                                                      : *(out) << "/* Could not fetch EventControl type */ //";break;
  // }
} 

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ){
  m_eventExprCnt.push_back(0);
  m_eventExprType = -1;
  m_eventExprType = eventExpr->getEventExprType();
  if( m_eventExprType == CDOmEventExpr::EVENT_EXPR_POSEDGE ){
    *(out) << " wait until ";
  } else if ( m_eventExprType == CDOmEventExpr::EVENT_EXPR_NEGEDGE ) {
    *(out) << " wait until ";
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){
  *(out) << " wait for";
  if(delayCtrl->getDelayControlType() == CDOmDelayControl::DELAY_CONTROL_MINTYPMAX){
    *(out) << " ";
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){
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

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){
  m_stmtPTCtrlPos = 0;
  if(stmtPTCtrl->getParent()->getType() != TYPE_INITIAL_OR_ALWAYS){
  //// calling indenter function ////
  indt(m_depth);
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
  //Initializations
  m_caseType = stmtCase->getCaseType();
  m_stmtCaseCnt = 0;
  m_stmtCaseDefault = stmtCase->hasDefault();
  m_stmtCaseSize = stmtCase->getChildrenSize();
  /*
  RefTVec_RefCDOmBase stmtCaseVec = stmtCase->getChildrenAsBase(TYPE_ALL_TYPES);
  if(stmtCaseVec.get()){
    m_stmtCaseCnt = stmtCaseVec->size();
  }
  */

  *(out) << std::endl;
  //// calling indenter function ////
  indt(m_depth);
  //// entering new depth ////
  m_depth++;

  if(m_caseType == CDOmStmtCase::CASE_CASE){
    *(out) << "case ( ";
  } else if (m_caseType == CDOmStmtCase::CASE_CASE_Z) {
    *(out) << "casez ( ";
  } else if (m_caseType == CDOmStmtCase::CASE_CASE_X) {
    *(out) << "casex ( ";
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
  TBool indent = TRUE;
  //Initializations
  RefTVec_RefCDOmBase attrLists = stmtIf->getChildrenAsBase(TYPE_ATTR_LIST_COLLECTION);
  if(attrLists.get()){
    m_stmtIfCnt = -1;
    m_stmtIfHasAttrList = TRUE;
  }else{
    m_stmtIfCnt = 0;
    m_stmtIfHasAttrList = FALSE;
  }
  m_stmtIfSize = stmtIf->getChildrenSize();

  RefCDOmBase parent = stmtIf->getParent();
  if(parent.get() && parent->getType() == TYPE_STMT){
    RefCDOmStmt parentStmt = CDOmStmt::cast(parent);
    if(parentStmt->getStmtType() == CDOmStmt::STMT_PROC_TIMING_CONTROL){
      *(out) << std::endl;
    }
    if(parentStmt->getStmtType() == CDOmStmt::STMT_IF){
      indent = FALSE;
    }
  }
    
  //// calling indenter function ////
  if(indent){
    indt(m_depth);
  }
  //// entering new depth ////
  m_depth++;

  if(!m_stmtIfHasAttrList){
    *(out)  << "if ( ";
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
  //Initializations
  m_stmtLoopCnt = 0;
 
 *(out) << std::endl;

  //// calling indenter function ////
  indt(m_depth);
  //// entering new depth ////
  m_depth++;

  m_stmtLoopType = stmtLoop->getLoopType();
    switch( m_stmtLoopType ) {
      case( CDOmStmtLoop::LOOP_FOREVER ) :   *(out) << "loop "                  ;          break;
   // case( CDOmStmtLoop::LOOP_REPEAT  ) :   *(out) << "repeat ( "              ;          break;
      case( CDOmStmtLoop::LOOP_WHILE   ) :   *(out) << "while ( "               ;          break;
      case( CDOmStmtLoop::LOOP_FOR     ) :   *(out) << "for ( "                 ;          break;
      default                            :   *(out) << "/* Unknown Loop Type */";          break;
    }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
  //Initializations
  m_stmtTaskEnableSize = stmtTaskEnable->getChildrenSize();
  m_stmtTaskEnableCnt = 0;

  //// Indenter logic //// requires further optimization
  RefCDOmBase parent = stmtTaskEnable->getParent();
  if(parent.get() && parent->getType() == TYPE_STMT){
    if(!(CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_PROC_TIMING_CONTROL || CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_CASE)){
      //// calling indenter function ////
      indt(m_depth);
    }
  } 
  ///////////////////////
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
  //Initializations
  m_stmtWaitCnt=0;

  //// calling indenter function ////
  indt(m_depth);

  *(out) << "wait for ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){

  //// calling indenter function ////
  indt(m_depth);

  *(out) << "disable ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){
  *(out) << "<-";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
  //Initializations
  m_rangeExprPos =0;
  m_partSelActual = TRUE; //--------MS added---part select is used in assign or f2a
  //m_assignPartSel = TRUE;
  m_rangeExprType = rangeExpr->getRangeExprType();

  //-------------------MS added-------------------------------
  if(CDOmRangeExpr::RANGE_EXPR_DOUBLE == m_rangeExprType || CDOmRangeExpr::RANGE_EXPR_SINGLE == m_rangeExprType){
    m_assignPartSel = TRUE;
 
   
    }
  rangeNo = 0;

  if(m_assignHID) {
    
    // cout<<"+++++++assign with part sel as HID\n";
     m_assignHID = FALSE;
  }
  
  //----------------------------------------------------
  // *(out) << "(";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
  m_showRange = TRUE;
  m_expandNum32 = TRUE;
  //Initializations
  if (!m_exprConcatSize.get()) {
    m_exprConcatSize = RefTStack_TInt(new TStack_TInt());
  }

  m_exprConcatSize->push(exprConcat->getChildrenSize());
  *(out) << " ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ){
  //Initializations
  m_exprMultiConcatPos = 0;
  *(out) << " ";
}


void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmUdpDecl                          & udpDecl                    ){
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


void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmUdpPortDeclOutput                & udpPortDeclOutput                ) {
  //Initializations
  m_udpOutPortName = udpPortDeclOutput->getID()->getName();
  //indenter function
  indt(IND1);
  switch (udpPortDeclOutput->getPortType()){
    case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT)     :    *(out) << "out "                                 ;      break;
    case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_REG)        :    *(out) << "csl_bit_vector "                      ;      break;
    case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT_REG) :    *(out) << ":out csl_bit_vector "                  ;      break;
    default                                                :    *(out) << "Error in port direction" << std::endl ;      break;
  }
}


void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput                ) {
  m_udpPdInputCnt = 0;
  RefTVec_RefCDOmIdentifier idVec = udpPortDeclInput->getIDs();
  if(idVec.get()){
    m_portIdSize = idVec->size();
  }
  indt(IND1);
  *(out) << " :in ";
}


void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                    ) {
  indt(IND2);
  if(m_combEntryCnt == 0)
    *(out) << "table" << std::endl;
}


void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                     ) {
  indt(IND2);
  if(m_seqEntryCnt == 0)
    *(out) << "table" << std::endl;
}


void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                     ) {
  indt(IND2);
    *(out) << "initial ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        ){
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

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                       ) {
  m_tfPortDeclSize = -1;
  if((tfPortDecl->getVarType() == VAR_REG || tfPortDecl->getVarType() == VAR_UNDEFINED) && (tfPortDecl->getRange()).get())
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
    case(PORT_INPUT)  : *(out) << "in "                                     ;   break;
    case(PORT_OUTPUT) : *(out) << "out "                                    ;   break;
    case(PORT_INOUT)  : *(out) << "inout "                                  ;   break;
    default           : ASSERT(FAIL, "Uninitialized or undefined enum data");   break;
  }

  switch(varType) {
    case(VAR_UNDEFINED): /* do nothing here */                                   ;  break;    
    case(VAR_REG)      : *(out) << "csl_bit_vector "                             ;  break;
    case(VAR_INTEGER)  : *(out) << "csl_integer "                                ;  break;
    case(VAR_REAL)     : *(out) << "csl_real "                                   ;  break;
    case(VAR_REALTIME) : *(out) << "csl_realtime "                               ;  break;
    case(VAR_TIME)     : *(out) << "csl_time "                                   ;  break;
    default            : ASSERT(FAIL, "Uninitialized or undefined enum data");  break;
  }
  if(varType == VAR_REG && tfPortDecl->isSigned())
    *(out) << "signed ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
  //Initializations
  m_funcDeclCnt = 0;
  //m_funcDeclPos Override in case of Range Object present
  RefTVec_RefCDOmBase funcDeclRange = funcDecl->getChildrenAsBase(TYPE_RANGE);
  if(funcDeclRange.get()) {
    m_funcDeclCnt = -1;
    m_hasRange = TRUE;
  }
  else
    m_hasRange = FALSE;
  *(out) << std::endl;
  m_funcDeclType = funcDecl->getFuncDeclType();
  *(out) << "function ";
  if(funcDecl->isAutomatic()){
    *(out) << "automatic ";
  }
  if(funcDecl->isSigned()){
    *(out) << "signed ";
  }
  if(m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE || m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE) {
    switch(funcDecl->getVarType()) {
      case(VAR_UNDEFINED): /* do nothing here */                                   ;  break;
      case(VAR_INTEGER)  : *(out) << "csl_integer "                                ;  break;
      case(VAR_REAL)     : *(out) << "csl_real "                                   ;  break;
      case(VAR_REALTIME) : *(out) << "csl_realtime "                               ;  break;
      case(VAR_TIME)     : *(out) << "csl_time "                                   ;  break;
      default            : ASSERT(FAIL, "Uninitialized or undefined enum data")    ;  break;
    }
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmFunctionCall                        & functionCall                    ){
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmGenvarDecl                          & genvarDecl                      ){
  //Initializations
  m_genvarDeclCnt = 0;
  m_genvarDeclSize = genvarDecl->getChildrenSize();
  *(out) << "genvar ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmGenInst                             & genInst                         ){
  *(out) << "generate " << std::endl;
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemNull                         & genItemNull                     ){
  *(out) << ";" << std::endl;
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemIf                           & genItemIf                       ){
  //Initializations
  m_genItemIfCnt = 0;
  m_genItemIfSize = genItemIf->getChildrenSize();
  *(out) << "if (";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemCase                         & genItemCase                     ){
  //Initializations
  m_genItemCaseCnt = 0;
  m_genItemCaseDefault = genItemCase->hasDefault();
  m_genItemCaseSize = genItemCase->getChildrenSize();

  *(out) << "case ( ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemLoop                         & genItemLoop                     ){
  //Initializations
  m_genItemLoopCnt = 0;
  *(out) << "for( ";
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemBlock                        & genItemBlock                    ){
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

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmString                              & stringObj                       ){
  //*(out) << "\"" << *(stringObj->getTokenString()) << "\"" ;
  // std::string str = "\""+ *(stringObj->getTokenString()) + "\"";
  
  // parameter->addParamString(str);
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmEventDecl                           & eventDecl                       ){
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

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmSpecifyBlock                        & specifyBlock                     ){
  //// calling indenter function ////
  indt(m_depth);
  //// entering new depth ////
  m_depth++;
  
  *(out) << "specify " << std::endl;
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl       & pulseSSCd                        ){
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

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmPathDecl                            & pathDecl                         ){
  //Initializations
  m_pathDeclIsSimple = FALSE;
  //m_pathDeclIsSimpleAndFull = FALSE;
  m_pathDeclIsEdge = FALSE;
  m_pathDeclIsStateSimpleIf = FALSE;
  m_pathDeclIsStateEdgeIf = FALSE;
  m_pathDeclIsStateSimpleIfNone = FALSE;
  m_pathDeclhasPolarityOp = FALSE;
  //children counter
  m_pathDeclCnt = 0;
  //path decl type
  m_pathDeclReturn = pathDecl->getType();
  switch(m_pathDeclReturn){
    case(CDOmPathDecl::PATH_DECL_SIMPLE       ): m_pathDeclIsSimple            = TRUE; break;
    case(CDOmPathDecl::PATH_DECL_EDGE         ): m_pathDeclIsEdge              = TRUE; break;
    case(CDOmPathDecl::PATH_DECL_SIMPLE_IF    ): m_pathDeclIsStateSimpleIf     = TRUE; break;
    case(CDOmPathDecl::PATH_DECL_EDGE_IF      ): m_pathDeclIsStateEdgeIf       = TRUE; break;
    case(CDOmPathDecl::PATH_DECL_SIMPLE_IFNONE): m_pathDeclIsStateSimpleIfNone = TRUE; break;
  }
  if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS || pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
    m_pathDeclhasPolarityOp = TRUE;
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

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmPathDelayValue                      & pathDelayValue                   ){
  if(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITH_PAREN){
    // *(out) << "( ";
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmMinTypMaxList                       & minTypMaxList                    ){
  m_minTypMaxListCnt = 0;
  m_minTypMaxListSize = minTypMaxList->getNumberOfChildren();
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
  m_specifyTListCnt = 0;
  m_specifyTListSize = specifyTerminalList->getNumberOfChildren();
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmDelayedDataOrReference              & delayedDataOrRef                 ){
  m_delayedDataOrRefCnt = 0;
  m_delayedDataOrRefSize = delayedDataOrRef->getChildrenSize();
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                ){
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

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmTimingCheckEvent                    & timingCkEvent               ){
  if(timingCkEvent->canBeControlled()){
    m_timingCheckEventCnt = -1;
  }else{
    m_timingCheckEventCnt = 0;
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmSystemTimingCheck                   & systemTimingCk              ){
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

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmGateInstantiation              & gateInstantiation         ){
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
  m_gateInstanceFlag = FALSE;


}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmPulseControl                   & pulseControl              ){
  m_pulseControlSection = TRUE;
  m_pulseControlSize = pulseControl->getChildrenSize();
  indt(m_depth);
  *(out) << "PATHPULSE$";
  if(!(m_pulseControlSize > 2)){
    m_pulseControlCnt = 0;
    *(out) << " = ( ";
    m_pulseControlLong = FALSE;
  }else {
    m_pulseControlCnt = -2;
    m_pulseControlLong = TRUE;
  }
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmAttrList                       & attrList                  ){
  //Initializations
  m_attrListSize = attrList->getChildrenSize();
  m_attrListCnt = 0;
  
  // *(out) << "(* "; 
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmDefine                         & define                   ){
  //saving the current output stream
  //Reason: defines may be inside modules
  /*  m_tempStream = out;
  //setting new output stream
//   out = defout;
  m_defineType = define->getDefineType();
  if(m_defineType == CDOmDefine::DEFINE_TYPE_DEFINE){
    defout << "`define ";
  }
  else if(m_defineType == CDOmDefine::DEFINE_TYPE_UNDEF){
    defout << "`undef ";
  }
  defout << *(define->getMacroName()) << " "; */
}

void CVHDLGenerator::beforeTraversal(const NSCdom::RefCDOmComment                         & comment                  ){
  m_commentType = comment->getCommentType();
  m_commentStar = FALSE;
  if(m_commentType == CDOmComment::TYPE_SLASH_SLASH){
    *(out) << "-- ";
  } else if (m_commentType == CDOmComment::TYPE_SLASH_STAR){
    m_commentStar = TRUE;
    *(out) << "--" << std::endl;
  }
  RefTVec_RefString commentsVec = comment->getCommentText();
  if(commentsVec.get()){
    for(TVec_RefString_const_iter iter = commentsVec->begin(); iter < commentsVec->end(); ++iter){
      *(out) << *(*iter) << std::endl;
    }
  }
}

//********************************************************************************
// In traversal block
//********************************************************************************

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmDesign                          & design                      ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ){

  TVec_CVHDLParamData_const_iter iterParam;
  refString_iter iterOp;
 //refVec_iter iterOp;

  m_modcnt++; 

  if(m_modcnt == 1 && m_portItemSize == -1){
    *(out) << std::endl;
    } 
 
  else if (m_modcnt == 1 && m_portItemSize != -1) {
  
    //------------MS added--------------------------------------
   
//----------------------------------paramDecl------------------------
	RefTVec_RefCDOmParamDecl paramDeclVec = moduleDecl->getChildren<CDOmParamDecl>(TYPE_PARAM_DECL);
	std::string par;
	TInt num;
	RefString paramName1;
		if(paramDeclVec.get()) {
			TBool ok = FALSE;
			TVec_RefCDOmParamDecl_const_iter iter = paramDeclVec->begin();
			for(; iter != paramDeclVec->end(); ++iter) {
			 
				if((*iter)->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
				  
				  *(out) << std::endl;
				  *(out) << "generic ( ";
					ok = TRUE;
					//	m_param = TRUE;
					break;
				}
							
			}
    
			if(ok) {
			  
				iter = paramDeclVec->begin();
			
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
									case CDOmExpr::EXPR_NUMBER : { 
									  *(out) << *(*idIter)->getName() << ": csl_integer" << " := "   << CDOmNumber::cast(payloadExpr)->getValue() ; 
									 
									  if(pVec.get()){
									  num = CDOmNumber::cast(payloadExpr)->getValue() ;
									  paramName1= RefString(new std::string (*(*idIter)->getName()));
									 
									  parameter->addParamName(paramName1);
									  num = CDOmNumber::cast(payloadExpr)->getValue() ;
									  par = " : csl_integer := ";
									  
									  parameter->addParamType(RefString(new std::string (par)));
									  parameter->addParamValue(num);
									 									  
									  pVec->push_back(parameter);
									  }

									  m_param =FALSE;
									}
									 	break;									  
								     
								
									case CDOmExpr::EXPR_STRING : { 
									  *(out)  << *(*idIter)->getName() << ": csl_string := \"" << *CDOmString::cast(payloadExpr)->getTokenString() << "\""; 
									    if(pVec.get()){
									  RefString paramName2= RefString(new std::string (*(*idIter)->getName()));
									  parameter->addParamName(paramName2);
									  par = " : csl_string := ";
									  RefString str = CDOmString::cast(payloadExpr)->getTokenString() ;
									  // TInt num = CDOmNumber::cast(payloadExpr)->getValue() ;
									  parameter->addParamType(RefString(new std::string (par)));
									  parameter->addParamString(str);
									  pVec->push_back(parameter);
									  }
									  m_param =FALSE;
									}
										break;
									case CDOmExpr::EXPR_OP     : {*(out) << *(*idIter)->getName() << " : csl_integer := " ; 
										  if(opExprVec.get()){
										    for(iterOp = opExprVec->begin(); iterOp != opExprVec->end(); iterOp++){
										      *(out) << *iterOp;
										      *(out) << "; ";
										    }
										  }
									}
									  //CDOmExprOp::cast(payloadExpr); 
										break;
										//	default                    : closeTemplate = FALSE;
										//	break;
									}
									//pVec->push_back(parameter);
									
								}
							       	
							}
							else {
								if((*idIter)->getPayload()->getType() == TYPE_EXPR) {
									RefCDOmExpr payloadExpr = CDOmExpr::cast((*idIter)->getPayload()->getChild(0));
								
										switch(payloadExpr->getExprType()) {
										case CDOmExpr::EXPR_NUMBER : { 
										    if(pVec.get()){
										   paramName1= RefString(new std::string (*(*idIter)->getName()));
										  parameter->addParamName(paramName1);
										  par = " : csl_integer := ";
										  num = CDOmNumber::cast(payloadExpr)->getValue() ;
										  parameter->addParamType(RefString(new std::string (par)));
										  parameter->addParamValue(num);
										  pVec->push_back(parameter);
										    }
										   m_param =FALSE;
										  
										 
										   *(out) << "; "  <<*(*idIter)->getName() << " : csl_integer := " << CDOmNumber::cast(payloadExpr)->getValue(); 
										}
										  break;
										case CDOmExpr::EXPR_STRING : { *(out) << "; " << *(*idIter)->getName() << ": csl_string := \"" << *CDOmString::cast(payloadExpr)->getTokenString() << "\""; 
										    if(pVec.get()){
										  RefString paramName3= RefString(new std::string (*(*idIter)->getName()));
										  parameter->addParamName(paramName3);
										  par = " : csl_string := ";
										  RefString str = CDOmString::cast(payloadExpr)->getTokenString() ;
										  parameter->addParamType(RefString(new std::string (par)));
										  parameter->addParamString(str);
										  pVec->push_back(parameter);
										  }
										    m_param = FALSE;
										}
										  break;
										case CDOmExpr::EXPR_OP     :  {*(out) << "; "         << *(*idIter)->getName() << ": csl_integer := "; 
										    if(opExprVec.get()){
										      for(iterOp = opExprVec->begin(); iterOp !=opExprVec->end(); iterOp++){
											*(out) << *iterOp;
											*(out) << "; ";
										      }
										    }
										}
										  //*CDOmExprOp::cast(payloadExpr);
											break;
										}
										//pVec->push_back(parameter);	
								}
								
							}
							//
					
																		
						}
						
					}
				
				
				}  //and for
		
				
			

				*(out) << " );" << std::endl;	
					m_param =FALSE;
			}
		}

  //--------------------------------------------------------------
    
      if(!m_param){
	*(out) << "\n port ( " ;
      }
    
 }
  ///-----------------------var decl-----------------
  /* if(m_hasVar){
   if(parent->getType() == TYPE_VAR_DECL ){
     if((parent ->getPayload())->getType() == TYPE_EXPR){
       RefCDOmExpr payloadExpr = CDOmExpr :: cast(parent->getPayload()->getChild(0));
       switch(payloadExpr->getExprType())
	 case CDOmExpr::EXPR_NUMBER: { 
	   num = CDOmNumber::cast(payloadExpr())->getValue();
	 }
     }
   }
   }*/
  //-------------------------------
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ){
  m_exprLinkExprCnt++;
  if(m_exprLinkExprCnt < m_exprLinkExprSize) {
    //  if((m_exprLinkExprs->at(m_exprLinkExprCnt - 1)).get())
      //  *(out) << "].";
    // else
      //  *(out) << ".";
      // *(out) << *(m_exprLinkHidNames->at(m_exprLinkExprCnt));
    //if((m_exprLinkExprs->at(m_exprLinkExprCnt)).get())
      // *(out) << "[";
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

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ){
  //m_posCnt++;
  m_exprCnt.back()++;
  std::string op;
  if(exprOp->isBinary() && m_exprCnt.back() == 1){
    if(opExprVec.get()){
    switch(exprOp->getOpType()){
      /*     case(CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS)          : *(out) << " + "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS)         : *(out) << ""                                           ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY)      : *(out) << " * "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_DIV)           : *(out) << " / "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_MOD)           : *(out) << " % "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_POW)           : *(out) << " ** "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT)    : *(out) << " <<< "                                      ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT)   : *(out) << " >>> "                                      ;       break;
      case(CDOmExprOp::OP_BINARY_EQUALITY_EQ)              : *(out) << " == "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ)          : *(out) << " != "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE)         : *(out) << " === "                                      ;       break;
      case(CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE)     : *(out) << " !== "                                      ;       break;
      case(CDOmExprOp::OP_BINARY_LOGIC_AND)                : *(out) << " && "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_LOGIC_OR)                 : *(out) << " || "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS)          : *(out) << " < "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL)    : *(out) << " <= "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER)       : *(out) << " > "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL) : *(out) << " >= "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_AND)              : *(out) << " & "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_NAND)             : *(out) << " ~& "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_OR)               : *(out) << " | "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_NOR)              : *(out) << " ~| "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_XOR)              : *(out) << " ^ "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_XNOR)             : *(out) << " ~^ "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_SHIFT_LEFT)               : *(out) << " << "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_SHIFT_RIGHT)              : *(out) << " >> "                                       ;       break;*/

      //-------------------MS added-------------------
    case(CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS)          : op = " + "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS)         : op = "   "      ;  /*opExprVec->push_back(RefString (new std::string (op)));*/       break;
    case(CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY)      : op = " * "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_ARITHMETIC_DIV)           : op = " / "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_ARITHMETIC_MOD)           : op = " % "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_ARITHMETIC_POW)           : op = " ** "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT)    : op = " <<< "    ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT)   : op = " >>> "    ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_EQUALITY_EQ)              : op = " == "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ)          : op = " != "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE)         : op = " === "    ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE)     : op = " !== "    ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_LOGIC_AND)                : op = " && "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_LOGIC_OR)                 : op = " || "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS)          : op = " < "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL)    : op = " <= "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER)       : op = " > "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL) : op = " >= "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_BITWISE_AND)              : op = " and "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_BITWISE_NAND)             : op = " nand "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_BITWISE_OR)               : op = " or "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_BITWISE_NOR)              : op = " ~| "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_BITWISE_XOR)              : op = " ^ "      ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_BITWISE_XNOR)             : op = " ~^ "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_SHIFT_LEFT)               : op = " << "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;
    case(CDOmExprOp::OP_BINARY_SHIFT_RIGHT)              : op = " >> "     ;  opExprVec->push_back(RefString (new std::string (op)));       break;

    default                                              : *(out) << "/*Error in binary expression */" <<std::endl;       break;
      }
    }
  }
  if(exprOp->isTernary()){
    if(m_exprCnt.back() == 1){
       *(out) << " ? ";
    } else if(m_exprCnt.back() == 2){
      *(out) << " : ";
    }
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ){
  m_listExprCnt++;
  if(m_listExprCnt < m_listExprSize && m_listExprSize > 1 ){
    if( m_listExprHasExprLinkParent){
      *(out) << "][";
    } else {
      *(out) << ", ";
    }
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ){

  m_pdcnt++;

 
  /*   if (m_pdcnt ==0 && m_pdcnt == m_portIdSize+1 && m_portIdSize==1) {
     *(out) << " " << std::endl;
  }
     else if(m_pdcnt > 0 && m_pdcnt <= m_portIdSize && m_portIdSize != 1){
       *(out) << "; ";
       } 
     else if(m_pdcnt !=0 && m_pdcnt == m_portIdSize+1){ 
     *(out) << " " << std::endl;
     }*/
    
  

 //// calling indenter function ////
  indt(m_depth);
 
}
void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ){
  m_vrcnt++;
  if(m_vrcnt > 0 && m_vrcnt < m_varIdSize && m_varIdSize > 1){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ){
  m_ntcnt++;
  //if(m_ntcnt <= m_netIdSize && m_netIdSize != 1){
  /*  if(m_ntcnt > 0 && m_ntcnt < m_netIdSize && m_netIdSize != 1){
   *(out) << ", ";
   }*/
}


void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmRange                           & range                       ){
  /*   if(m_showRange){
    m_rangeExprs++;
    //if(m_rangeExprs == 1 && !m_noRange){
    if(m_rangeExprs == 1){
      *(out) << " downto ";
    }
    }*/
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmNum32                           & num                         ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmReal                            & realNum                     ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ){
  //parameter value init logic(caution: named param assn only; no support for ordered yet)
     m_intExprCnt++;
    
    
     // if(m_parOver){
    if(m_intExprCnt == 1){
      // *(out) << " generic map (";
     
    }
    if(m_intExprCnt > 1 && m_intExprCnt <= m_intExprSize && m_intExprSize !=1){
      //    *(out) << ",";
      indt(m_depth);
      portListIndt(m_moduleInstantiationIndt);
    }
    if(m_intExprCnt == m_intExprSize+1 ){
      //  *(out) << ")" << std::endl;
    }

    if((moduleInstantiation->getModuleInstantiationType() == CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN )
       &&(m_intExprCnt <= m_intExprSize)) {    
     
      // *(out) << *(m_paramNameMapIt->first);
      // paramNameVec->push_back(m_paramNameMapIt->first);

      //	paramOverMap->insert(std::map<RefString,TVec_char>::value_type(m_parName, numParVec));
      ++m_paramNameMapIt;

      // paramNameVec->push_back(m_paramNameMapIt->first);
      // m_parName = (m_paramNameMapIt->first);
      // paramOverMap->insert(std::map<RefString,TVec_char>::value_type(m_parName, numParVec));
      // *(out) << "size2=" << paramOverMap->size();
    }
    // }
  //f2a / ordered connection logic
  m_intcnt++;

  if(m_intcnt == 1){
    // *(out) << " ";
  }
  if(m_intcnt > 1 && m_intcnt <= m_instanceNumSize && m_instanceNumSize != 1) {
    // *(out) << ", " << std::endl;
      indt(m_depth);
      DCERR ("moduleInstIndt is " << m_moduleInstanceIndt);
      portListIndt(m_moduleInstantiationIndt);
      }
 
  iter_TMap_RefString_RefCDOmMinTypMax iterParMap;

  	if(CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_ORDERED_PARAM_ASSN == m_moduleInstantiationType) {
	 
	
			if(m_intcnt == 0 && m_moduleInstantiationParamNo == 0) {
			
			  //	*(out) << " *";
			}
			else if(m_intcnt*(-1) == m_moduleInstantiationParamNo){
			  //	*(out) << "<";
			}
			else if(m_moduleInstantiationParamNo != 0 && m_intcnt == 0) {
			  //	*(out) << "> *";
			}
			else if(m_intcnt < 0){
			  //	*(out) << ", ";
			}
		}
		else if(CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType) {
		 
		  m_parName = (m_paramNameMapIt->first);
		 
			if(m_intcnt == 0) {
			  //	*(out) << "generic map (";
			}
			if(m_intcnt < m_moduleInstantiationParamNo) {
			 
				m_designGenCode = FALSE;
			}
			else {
			
				paramOverMap->insert(std::map<RefString,TVec_char>::value_type(m_parName, numParVec));
			       	m_designGenCode = TRUE;
			}

		}
		else if(m_intcnt == 0) {
	
		}

		m_intcnt++;
		if(m_intcnt > 1 && 
		   m_intcnt <= m_instanceNumSize && 
		   m_instanceNumSize != 1) {
		  //	*(out) << ", " << std::endl;
			indt(m_depth);
			portListIndt(m_moduleInstantiationIndt);

			//	*(out) << "*";
		}
  
		//	m_param = FALSE;

 	
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) {
  TVec_RefCDOmExpr_const_iter iterP;
  
  /*    if(moduleInstance->getModuleInstanceType()==CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
    RefTMap_RefString_RefCDOmExpr explicitPortNameMap = moduleInstance->getExplicitPortMap();
    if(explicitPortNameMap.get()) {
      TMap_RefString_RefCDOmExpr_constIter iter = explicitPortNameMap->begin();
      if(m_moduleInstanceCnt == 0) { 
        *(out) << "port map ( " << *(iter->first) << " <= " ;
        if(!iter->second.get()){
	//*(out) << "// not connected ";
        }
        m_moduleInstanceCnt++;
      }
      else {
        if(m_moduleInstanceCnt < m_moduleInstanceSize) {
          for(int i = 1; i <= m_moduleInstanceCnt; ++i)
            iter++; 
          *(out) << "," << std::endl;
          indt(m_depth);
          portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);
          *(out) << *(iter->first) << " <= " ;
          m_moduleInstanceCnt++;
          //if(!iter->second.get())
          //  *(out) << "()";
        }
        else if(m_moduleInstanceCnt == m_moduleInstanceSize)
          *(out) << ")";
      }
    }
  } else if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION) {
    if(m_emptyIndexesVec != NULL) {
      if(m_moduleInstanceCnt == 0) {
        *(out) << " port map ( ";
        m_moduleInstanceCnt++;
        //if(m_emptyIndexesVec->back() == 0)
        //  *(out) << " ";
      }
      if(m_emptyIndexesVec->size() == 1)
        m_emptyIndexesVec->pop_back();
      if((m_moduleInstanceCnt == 1 && m_emptyIndexesVec->size() == 0 && m_inscnt == 0) || (m_moduleInstanceCnt == 1 && m_emptyIndexesVec->back() != 0 && m_inscnt == 0)) {
        m_moduleInstanceCnt++;
        m_moduleInstanceExprCnt++;
      }
      else {
        if((m_inscnt + 2 < m_moduleInstanceSize) && (m_inscnt != m_emptyIndexesVec->back())) {
          *(out) << "," << std::endl;
          indt(m_depth);
          portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);
          m_inscnt++;
          m_moduleInstanceExprCnt++;
        }
        while(m_emptyIndexesVec->size() > 1 && m_inscnt == m_emptyIndexesVec->back()) {
          *(out) << "," << std::endl;
          indt(m_depth);
          portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);
          m_inscnt++;
          m_emptyIndexesVec->pop_back();
          if(m_emptyIndexesVec->size() == 1 && m_moduleInstanceExprCnt < m_moduleInstanceExprSize) {
            *(out) << "," << std::endl;
            indt(m_depth);
            portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);
          }
        }
      }
    }
    else {
      if(m_moduleInstanceCnt == 0) { 
        *(out) << "(";
        m_moduleInstanceCnt++;
      }
      else 
        if(m_moduleInstanceCnt < m_moduleInstanceExprSize) {
          *(out) << "," << std::endl;
          indt(m_depth);
          portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);  
          m_moduleInstanceCnt++;
        }
    }
    }  */

 	//----OB modified---added + "_" so that module and module instance have different names
  	//	std::string instanceName = (*CDOmIdentifier::cast(moduleInstance->getChild(0))->getName()); 


		if(m_moduleInstanceCnt == 0 && (m_moduleInstantiationParamNo == 0 ||
										CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType)) {
			//-----MS added---start
		  if(m_moduleInstantiationParamNo != 0){
		    if(m_moduleInstantParamExprVec.get()) {
		      for(iterP = m_moduleInstantParamExprVec->begin(); iterP !=m_moduleInstantParamExprVec->end(); iterP++)
			if( (*iterP)->getExprType() == CDOmExpr::EXPR_MINTYPMAX){
			  //*(out) << (*iterP)->getExprType();
			  //m_parOver = TRUE;
			}
		    }
		  }
		  
			// set the name of the module which has instances
			RefString instModName = RefString(new std::string(*m_moduleInstantiationName));
			// add the instance name to modInst object
		        //std::cout << "----------instModName= " << instModName <<"--------\n";
			modInst->setModuleName(instModName);


			// create a new object to hold the information about the formals and actuals in the constructor for each instance
			F2As = Ref_CVHDLConstrF2A(new CVHDLConstrF2A::CVHDLConstrF2A);

			//----end

		
			m_moduleInstanceCloseParen = FALSE;
		}
		else if(m_moduleInstanceCnt == 0 && 
				CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_ORDERED_PARAM_ASSN == m_moduleInstantiationType) {
		 
			if(m_moduleInstantParamExprVec.get()) {
			 
				TBool printComma = FALSE;
				TVec_RefCDOmExpr_const_iter iter = m_moduleInstantParamExprVec->begin();
				if((*iter)->getExprType() == CDOmExpr::EXPR_MINTYPMAX) {
				 
					printComma = TRUE;
				}
				++iter;
				for(; iter != m_moduleInstantParamExprVec->end(); ++iter) {
					if((*iter)->getExprType() == CDOmExpr::EXPR_MINTYPMAX) {
					  // m_parOver = TRUE;
						if(printComma) *(out) << ", " ;
					
						printComma = TRUE;
					}
				}
			}
		
			m_moduleInstanceCloseParen = FALSE;
		}
	

		if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
		  //RefTMap_RefString_RefCDOmExpr explicitPortNameMap = moduleInstance->getExplicitPortMap(); 
		  explicitPortNameMap = moduleInstance->getExplicitPortMap();
		 
		 
		  if(explicitPortNameMap.get()) {
		    TMap_RefString_RefCDOmExpr_constIter iter = explicitPortNameMap->begin();
		    
		    TList_RefString_const_iter iter_list1; //--------MS added
		    TList_RefString_const_iter iter_list2; //--------MS added
		    
		    m_isExprActual = FALSE; // no expressions with numbers as actuals 
		    m_exprSigPortActual = FALSE; // no expressions with sigs/ports as actuals 
		    //  m_assignStmt = FALSE; // no assign statements, this is f2a's


		    if(m_moduleInstanceCnt == 0) { 
		      if(iter->second.get()) {
		

			//-----MS added----start
			
			
			// check if there is an actual or if the actual is a number
			if((iter->second)->getChildrenSize() > 0 || (iter->second)->getExprType() == CDOmExpr::EXPR_NUMBER ) { 
			  
			  if(m_inputPortCon.get()) {
			    for(iter_list1 = m_inputPortCon->begin(); iter_list1 != m_inputPortCon->end(); iter_list1++) {   //*-------MS added
			      if(*(iter->first) == *(iter_list1->get()) ) {   //-------MS added----the actual is a number 
			
				p = 'i';
				m_rangeAsWidth = FALSE;
				m_isNumActual = TRUE; //-----MS added----the actual is a number but the port is not output

				// write declaration of generated signal
			
				//	RefString instName = RefString(new std::string(instanceName));
				
				
				
				// input port is formal and part select is actual
				if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				  m_partSelActual = TRUE; //-----MS added----the actual is a range and formal port is input
				 
				}
				
				else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				  
				  RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				  TVec_RefCDOmExpr_const_iter it;
				  if(vec.get()) {
				    for(it = vec->begin(); it != vec->end(); it++) {
				      if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
					m_isExprActual = TRUE; //-----MS added----the actual is an expression
				
				      }
				      else {
					m_exprSigPortActual = TRUE;	
					
				      }
				    }
				  }	  
				}
				
				else {
				  //m_inputNumActual = TRUE; //---MS added---the actual is a number and port is input
				 
				}
				
				
				break;
			      }
			      
			    else {
			      if(m_outputPortCon.get()) {
				for(iter_list2 = m_outputPortCon->begin(); iter_list2 != m_outputPortCon->end(); iter_list2++) {   //**-------MS added
				  
				  if(*(iter->first) == *(iter_list2->get()) ) { //*----ms
				    
				 
				    p = 'o';
				    m_rangeAsWidth = FALSE;
				    //m_inputNumActual = FALSE; //---MS added---the actual is a number but the port is not input
				    
				    if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				      m_partSelActual = TRUE; //-----MS added----the actual is a range and formal port is input
													}
				    
				    else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				      
				      RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				      TVec_RefCDOmExpr_const_iter it;
				      if(vec.get()) {
					for(it = vec->begin(); it != vec->end(); it++) {
					  if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
					    m_isExprActual = TRUE; //-----MS added----the actual is an expression
					    
					    ;
					  }
					  else {
					    m_exprSigPortActual = TRUE;
					   
					    
					  }
					}
				      }
				    }
				    
				    else {
				      m_isNumActual = TRUE;  //-----MS added----the actual is a number but the port is output
				      
				     
				    }
				  
				    break;
				  } //*----end of if
				} //**-----end of for with output ports
			      } // end of if for map with output ports
			    }
			    } //*---end of for with input ports
			  }// end of if for map with input ports
			  else if(m_inoutPortCon.get()) {
			    
			    for(iter_list2 = m_inoutPortCon->begin(); iter_list2 != m_inoutPortCon->end(); iter_list2++) {   //**-------MS added
			    
			      if(*(iter->first) == *(iter_list2->get()) ) { //*----MS
				
			       p = 'b';
			      m_rangeAsWidth = FALSE;
			      //m_inputNumActual = FALSE; //---MS added---the actual is a number but the port is not input
			      
			      if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				m_partSelActual = TRUE; //-----MS added----the actual is a range and formal port is input
			
			      }
			      
			      else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				
				RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				TVec_RefCDOmExpr_const_iter it;
				if(vec.get()) {
				  for(it = vec->begin(); it != vec->end(); it++) {
				    if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
				      m_isExprActual = TRUE; //-----MS added----the actual is an expression
				      
				      
				    }
				    else {
				      m_exprSigPortActual = TRUE;
				      
				     
				    }
				  }
				}
			      }
			      
			      else {
				m_isNumActual = TRUE;  //-----MS added----the actual is a number but the port is output
				
				
			      }
			     
			      break;
			      } //*----end of if
			    } //**-----end of for with output ports
			  } //end of if for map with output ports


			}
			
			  
		
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
			  
		
			
			}
			for(int i = 1; i <= m_moduleInstanceCnt; ++i)
			  iter++;
			if(iter->second.get()) {
			  
			
			  //-----MS added----start
			  
			  // check if there is an actual or if the actual is a number or if the actual is a range expression
			  if((iter->second)->getChildrenSize() > 0 || (iter->second)->getExprType() == CDOmExpr::EXPR_NUMBER) { //has range --- MS added 2nd condition
	      
			    if(m_inputPortCon.get()) {
			      for(iter_list1 = m_inputPortCon->begin(); iter_list1 != m_inputPortCon->end(); iter_list1++) {   //*-------MS added
				if(*(iter->first) == *(iter_list1->get())) {   //-------MS added----the actual is a number and input ports don't have write() method
				  
				 
				  p = 'i';
				  m_rangeAsWidth = FALSE;
				  m_isNumActual = TRUE; //-----MS added----the actual is a number but the port is not input

				  // write declaration of generated signal
				  //RefString genSig = RefString(new std::string("gen_sig_" + instanceName + *(iter->first)));
				  // RefString instName = RefString(new std::string(instanceName));
				  // modDecl->addGenSignal(iter->first,instName);

		  
				  if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				    m_partSelActual = TRUE; //-----MS added----the actual is a range and formal port is input
				   
				  }
				  
				  else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				    
				    RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				    TVec_RefCDOmExpr_const_iter it;
				    if(vec.get()) {
				      for(it = vec->begin(); it != vec->end(); it++) {
					if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
					  m_isExprActual = TRUE; //-----MS added----the actual is an expression
					 
					}
					else {
					  m_exprSigPortActual = TRUE;
					  
					  
					}
				      }
				    }
				  }
				  
				  else {
				   
				  }
				 
				  break;
				}
				
				else { 
				  if(m_outputPortCon.get()) {
				    for(iter_list2 = m_outputPortCon->begin(); iter_list2 != m_outputPortCon->end(); iter_list2++) {   //**-------MS added
				      if(*(iter->first) == *(iter_list2->get()) ) { //*----OB
					
				
					p = 'o';
					m_rangeAsWidth = FALSE;
					//m_inputNumActual = FALSE; //-----MS added----the actual is a number but the port is not input
					
					if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
					  m_partSelActual = TRUE; //-----MS added----the actual is a range and formal port is input
					  
					  
					}
					
					else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
					  
					  RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
					  TVec_RefCDOmExpr_const_iter it;
					  if(vec.get()) {
					    for(it = vec->begin(); it != vec->end(); it++) {
					      if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
						m_isExprActual = TRUE; //-----MS added----the actual is an expression
						
						
					      }
					      else {
						m_exprSigPortActual = TRUE;
					
					      }
					    }
					  }
					}
					
					else {
					  m_isNumActual = TRUE;  //---MS added---the actual is a number and port is input
					  
					  
					}
					break;
				      } //*----end of if
				    } //**-----end of for with output ports
				  } // end of if for map with output ports
				}
			      } //*---end of for with input ports
			    } // end of if for map with input ports
		
							
			  //
			    else if(m_inoutPortCon.get()) {
			      for(iter_list2 = m_inoutPortCon->begin(); iter_list2 != m_inoutPortCon->end(); iter_list2++) {   //**-------MS added
				if(*(iter->first) == *(iter_list2->get()) ) { //*----MS
			
				  p = 'b';
				  m_rangeAsWidth = FALSE;
				  //m_inputNumActual = FALSE; //-----MS added----the actual is a number but the port is not input
				  
				  if((iter->second)->getExprType() == CDOmExpr::EXPR_HID) {
				    m_partSelActual = TRUE; //-----MS added----the actual is a range and formal port is input
				    
				   
				  }
				  
				  else if((iter->second)->getExprType() == CDOmExpr::EXPR_OP) {
				    
				    RefTVec_RefCDOmExpr vec = (iter->second)->getExprs();
				    TVec_RefCDOmExpr_const_iter it;
				    if(vec.get()) {
				      for(it = vec->begin(); it != vec->end(); it++) {
					if( (*it)->getExprType() == CDOmExpr::EXPR_NUMBER) {
					  m_isExprActual = TRUE; //-----MS added----the actual is an expression
					  
					 
					}
					else {
					  m_exprSigPortActual = TRUE;
					 
					  
					}
				      }
				    }
				  }
				  
				  else {
				    m_isNumActual = TRUE;  //---MS added---the actual is a number and port is input
				    
				    
				  }
				  break;
				} //*----end of if
			      } //**-----end of for with inout ports
			    } // end of if for map with inout ports
			  //
			  }
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
					*(out) << ");\n";
					
				
					m_moduleInstanceCloseParen = FALSE;
				}
				while(m_emptyIndexesVec->size() > 0 && 
					  m_emptyIndexesVec->back() == m_moduleInstanceCnt) {
					m_emptyIndexesVec->pop_back();
					++m_moduleInstanceCnt;
				}
				if(m_moduleInstanceSize > m_moduleInstanceCnt && 
				   m_moduleInstanceCnt < m_portItems->size()) {
					
					RefCDOmExprLink exprLink = m_portItems->at(m_moduleInstanceCnt)->getExprLink();
					//	*(out) << instanceName << "->" << *(exprLink->getName());
					if(m_moduleInstanceExprVec->at(m_moduleInstanceExprCnt)->getChildrenSize() > 0) { // has range
					
						m_rangeAsWidth = FALSE;
					}
				
					++m_moduleInstanceCnt;
					++m_moduleInstanceExprCnt;
					m_moduleInstanceCloseParen = TRUE;
				}
			}
			else if(!m_moduleInstanceGenOrderedAsNamed) {
				if(m_moduleInstanceCnt == 0) {
								
					m_moduleInstanceCnt++;
				
					m_moduleInstanceCloseParen = FALSE;
				}
				else 
					if(m_moduleInstanceCnt < m_moduleInstanceExprSize) {
					
						m_moduleInstanceCnt++;
						m_moduleInstanceCloseParen = TRUE;
					}
			}
			else {
				if(m_moduleInstanceCloseParen) {
			
					m_moduleInstanceCloseParen = FALSE;
				}
				if(m_portItems.get() && 
				   m_moduleInstanceSize > m_moduleInstanceCnt && 
				   m_moduleInstanceCnt < m_portItems->size()) {
				
					RefCDOmExprLink exprLink = m_portItems->at(m_moduleInstanceCnt)->getExprLink();
				
					if(m_moduleInstanceExprVec->at(m_moduleInstanceExprCnt)->getChildrenSize() > 0) { // has range
					
						m_rangeAsWidth = FALSE;
					}
				
					++m_moduleInstanceCnt;
					++m_moduleInstanceExprCnt;
					m_moduleInstanceCloseParen = TRUE;
				}
			}
		}  


}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {} 
  
void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {
  m_paramDeclPos++;

  if(m_paramDeclPos > 0 && m_paramDeclPos < m_paramDeclChildren ){
     *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ){
  m_paramOverrideCnt++;
  //The following could be done by retrieving the current child and calling getExprType() on it, however
  //this method may be simpler since it does not create any new objects and the Verilog syntax is fixed 
  //in this case: if the current child is in an odd position it's the hid, if it's on en even position, 
  //it's the minTypMax expression (Note: counting starts at 1, because counter is incremented before evaluation)
  if(m_paramOverrideCnt % 2 == 1){
    *(out) << "=> ";
  }else if (m_paramOverrideCnt % 2 == 0 && m_paramOverrideCnt < m_paramOverrideSize ){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ){
  m_minTypMaxCnt++;
  if((m_minTypMaxCnt == 1 || m_minTypMaxCnt == 2) && m_minTypMaxChildren > 1){
    *(out) << "downto";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmDelay                           & delay                       ){
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

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmAssn                            & assn                        ){
  m_assnPos++;
  // if(m_assnPos == 1){
    //   *(out) << " <= ";
  // }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ){
  m_contAssnPos++;
  if(m_contAssnPos > 0 && m_contAssnPos < m_contAssnSize){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) {
  //*(out) << std::endl;
  m_stmtBlockCnt++;
  //if(m_stmtBlockCnt < m_stmtBlockSize)
    //indt(IND3);
  //if(stmtBlock->isNamed() && m_stmtBlockCnt == 1){
  //  ;//*(out) << std::endl;
  //}
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ){
  m_stmtAssnPos++;
  if(m_stmtAssnPos == 1){
    if(stmtAssn->getAssnType() == CDOmStmtAssn::ASSN_BLOCKING){
      *(out) << " := ";
    } else if(stmtAssn->getAssnType() == CDOmStmtAssn::ASSN_NON_BLOCKING){
      *(out) << " <= ";
    }
    m_expandNum32 = TRUE;
    /*  } else if(m_stmtAssnPos == 2) {
    *(out) << ";";
    } */
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ){
  m_eventExprCnt.back()++;
  if(m_eventExprCnt.back() == 1){
    if(eventExpr->getEventExprType() == CDOmEventExpr::EVENT_EXPR_COMMA ){
      *(out) << ", ";
    }else if(eventExpr->getEventExprType() == CDOmEventExpr::EVENT_EXPR_OR ){
      *(out) << " or ";
    }
  }
  // }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){
  m_stmtPTCtrlPos++;
  //if(m_stmtPTCtrlPos == 1){
  //  *(out) << std::endl;
  //}
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
  m_stmtCaseCnt++;
  if(m_stmtCaseCnt == 1){
    *(out) << " is " << std::endl;
  }
  if( m_stmtCaseCnt > 1 && m_stmtCaseCnt % 2 == 0 && m_stmtCaseCnt < m_stmtCaseSize ){ //checking for even position in children vector (expressionLists)
      *(out) << " => ";
      //check the logic below - it may be optimised away
  } else if ( m_stmtCaseCnt > 1 && m_stmtCaseCnt % 2 != 0 ) { //checking for odd position in children vector (statements)
    //*(out) << std::endl;
    if( m_stmtCaseDefault && m_stmtCaseCnt == m_stmtCaseSize - 1){
      //// calling indenter function ////
      indt(m_depth);
      
      *(out) << "others => ";
    }
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
  m_stmtIfCnt++;
  if(m_stmtIfHasAttrList && m_stmtIfCnt == 0){
    *(out)  << " if ( ";
  }
   
  if(m_stmtIfCnt == 1 ){
    *(out) << " ) then" /*<< std::endl*/;
  }
  if(m_stmtIfSize >= 3 && m_stmtIfCnt == 2){

    //// calling indenter function ////
    //// -1 because we want else at the same level of if, yet keep the indent depth for the rest ////
    indt(m_depth-1);

    *(out) << " else " /*<< std::endl*/;
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
  m_stmtLoopCnt++;
  switch( m_stmtLoopType ) {
    //does not evaluate forever case as to avoid redundancy
    /* case( CDOmStmtLoop::LOOP_REPEAT ) :   
      {
        if(m_stmtLoopCnt == 1){
          *(out) << " ) "; 
        }
        break;
	}*/
    case( CDOmStmtLoop::LOOP_WHILE ) :   
      {
        if(m_stmtLoopCnt == 1){
          *(out) << " end loop "; 
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

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
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

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
  m_stmtWaitCnt++;
  if(m_stmtWaitCnt == 1){
    *(out) << ") ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
  m_rangeExprPos++;
  if(m_rangeExprPos == 1){
    m_partSelActual = TRUE; //--------MS added---part select is used in assign or f2a
    switch(m_rangeExprType){
    case 0 :                                             break;
      // case 1 : *(out) << ":" ;                             break;
    case 1 : *(out) << "  " ;                             break;
    case 2 : *(out) << "+:";                             break;
    case 3 : *(out) << "-:";                             break;
    default: *(out) << "/* Invalid range expression */"; break;
  }
}
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
  if (--m_exprConcatSize->top() > ZERO) {
    // *(out) << " & ";
	RefString tmp = RefString(new std::string(" & "));
	if(opConcatVec.get())
	opConcatVec->push_back(tmp);
  }

}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ){
  if(++m_exprMultiConcatPos == 1){
    *(out) << " ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                    ){
  m_udpcnt++;
  if(m_udpcnt == 1) {
    RefTVec_RefString portItems = udpDecl->getPortItemNames();
    *(out) << " : " << *(*portItems->begin());
    for(TVec_RefString_const_iter iter = portItems->begin()+1; iter < portItems->end(); ++iter)
      *(out) << "  " << *(*iter);
      *(out) << " ;" << std::endl; 

  }
}


void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput          ){
}


void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput          ){
  m_udpPdInputCnt++;
  if(m_udpPdInputCnt > 0 && m_udpPdInputCnt< m_portIdSize && m_portIdSize != 1){
    *(out) << "; ";
  }
}


void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry              ){
  m_combEntryCnt++;
  RefTVec_ECDOmUdpSymbol levelInputList = udpCombEntry->getInputList();
  ECDOmUdpSymbol outputSymbol = udpCombEntry->getOutputSymbol();

  indt(IND2);
  if(m_combEntryCnt == 1) indt(IND2);
  for(TVec_ECDOmUdpSymbol_const_iter iter = levelInputList->begin(); iter < levelInputList->end(); ++iter) {
    switch(*iter) {
      case   UDP_SYMBOL_0                  : *(out) << "0 "       ;                               break;
      case   UDP_SYMBOL_1                  : *(out) << "1 "       ;                               break;
      case   UDP_SYMBOL_x                  : *(out) << "x "       ;                               break;
      case   UDP_SYMBOL_X                  : *(out) << "X "       ;                               break;
      case   UDP_SYMBOL_Q                  : *(out) << "? "       ;                               break;
      case   UDP_SYMBOL_b                  : *(out) << "b "       ;                               break;
      case   UDP_SYMBOL_B                  : *(out) << "B "       ;                               break;
      case   UDP_SYMBOL_UNDEF              : /* do nothing here */                                break;
      case   UDP_SYMBOL_MASK_OUTPUT_SYMBOL : /* do nothing here */                                break;
      case   UDP_SYMBOL_MASK_LEVEL_SYMBOL  : /* do nothing here */                                break;
      case   UDP_SYMBOL_MASK_NEXT_STATE    : /* do nothing here */                                break;
      default                              : ASSERT(FAIL, "Unintialized or undefined enum data"); break;
    }
  }

  switch(outputSymbol) {
    case   UDP_SYMBOL_0                  : *(out) << ": 0"      ;                               break;
    case   UDP_SYMBOL_1                  : *(out) << ": 1"      ;                               break;
    case   UDP_SYMBOL_x                  : *(out) << ": x"      ;                               break;
    case   UDP_SYMBOL_X                  : *(out) << ": X"      ;                               break;
    case   UDP_SYMBOL_Q                  : /* do nothing here */                                break;
    case   UDP_SYMBOL_b                  : /* do nothing here */                                break;
    case   UDP_SYMBOL_B                  : /* do nothing here */                                break;
    case   UDP_SYMBOL_UNDEF              : /* do nothing here */                                break;
    case   UDP_SYMBOL_MASK_OUTPUT_SYMBOL : /* do nothing here */                                break;
    case   UDP_SYMBOL_MASK_LEVEL_SYMBOL  : /* do nothing here */                                break;
    case   UDP_SYMBOL_MASK_NEXT_STATE    : /* do nothing here */                                break;
    default                              : ASSERT(FAIL, "Unintialized or undefined enum data"); break;
  }
}


void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry               ) {
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
        case  CDOmUdpSeqEntry::EDGE_r     : *(out) << "r "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_R     : *(out) << "R "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_f     : *(out) << "f "                                      ;   break; 
        case  CDOmUdpSeqEntry::EDGE_F     : *(out) << "F "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_p     : *(out) << "p "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_P     : *(out) << "P "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_n     : *(out) << "n "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_N     : *(out) << "N "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_STAR  : *(out) << "* "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_UNDEF : /* do nothing here */                                   break;
        default                           : ASSERT(FAIL, "Uninitialized or undefined enum data");   break;
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


void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt               ) {
  if(m_udpOutPortName.get()) {
    *(out) << *m_udpOutPortName << " = ";
    switch(udpInitStmt->getInitVal()) {
      case  CDOmUdpInitStmt::INIT_VAL_1b0 : *(out) << "0;" << std::endl;   break; 
      case  CDOmUdpInitStmt::INIT_VAL_1b1 : *(out) << "1;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1bx : *(out) << "x;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1bX : *(out) << "X;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1B0 : *(out) << "0;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1B1 : *(out) << "1;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1Bx : *(out) << "x;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1BX : *(out) << "X;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1   : *(out) << "1;" << std::endl;   break; 
      case  CDOmUdpInitStmt::INIT_VAL_0   : *(out) << "0;" << std::endl;   break; 
    }
  }
  else *(out) << "Undeclared output port" << std::endl;
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        ) {
  ++m_taskDeclCnt;
  if(taskDecl->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITH_TASK_PORT_LIST) {
    if(m_taskDeclCnt == 1) *(out) << " (";
    else if(m_taskDeclCnt-1 == m_taskDeclPortItemSize)
      *(out) << ");" << std::endl;
    else if(m_taskDeclCnt-1 < m_taskDeclPortItemSize) *(out) << ", ";
  } 
  else if(m_taskDeclCnt == 1) {
    *(out) << ";" << std::endl;
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                       ) {
  ++m_tfPortDeclCnt;
  if(m_tfPortDeclCnt > 0 && m_tfPortDeclCnt < m_tfPortDeclSize)
    *(out) << ", ";
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
  m_funcDeclCnt++;
  if(m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE || m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE || m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST) {
    if(m_funcDeclCnt == 1) *(out) << " (";
    else if(m_funcDeclCnt == 2) *(out) << ");" << std::endl; 
  }
  else if(m_funcDeclCnt == 1) {
    *(out) << ";" << std::endl;
    indt(IND2);
  }
  if(m_funcDeclCnt > 1 && m_funcDeclCnt < funcDecl->getChildrenSize()) 
    indt(IND2);
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmFunctionCall                        & functionCall                    ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmGenvarDecl                          & genvarDecl                      ){
  m_genvarDeclCnt++;
  if(m_genvarDeclCnt < m_genvarDeclSize){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmGenInst                             & genInst                         ){
  //indt(IND1);
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmGenItemNull                         & genItemNull                     ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmGenItemIf                           & genItemIf                       ){
  m_genItemIfCnt++;
  if(m_genItemIfCnt == 1){
    *(out) << ") then" << std::endl;
    indt(IND1);
  }else if (m_genItemIfCnt == 2 && m_genItemIfSize == 3){
    *(out) << "else" << std::endl;
    indt(IND1);
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmGenItemCase                         & genItemCase                     ){
  m_genItemCaseCnt++;
  if(m_genItemCaseCnt == 1){
    *(out) << " ) is" << std::endl;
  }
  if( m_genItemCaseCnt > 1 && m_genItemCaseCnt % 2 == 0 && m_genItemCaseCnt < m_genItemCaseSize ){ //checking for even position in children vector (expressionLists)
      *(out) << " =>  ";
      //check the logic below - it may be optimised away
  } else if ( m_genItemCaseCnt > 1 && m_genItemCaseCnt % 2 != 0 ) { //checking for odd position in children vector (statements)
    //*(out) << std::endl;
    if( m_genItemCaseDefault && m_genItemCaseCnt == m_genItemCaseSize - 1){
      *(out) << " others : ";
    }
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmGenItemLoop                         & genItemLoop                     ){
  m_genItemLoopCnt++;
  switch ( m_genItemLoopCnt ) {
    case ( 1 ) : *(out) << " = "       ; break;
    case ( 2 ) : *(out) << "; "        ; break;
    case ( 3 ) : *(out) << "; "        ; break;
    case ( 4 ) : *(out) << " = "       ; break;
    case ( 5 ) : *(out) << ") "        ; break;
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmGenItemBlock                        & genItemBlock                    ){
  m_genItemBlockCnt++;
  if(m_genItemBlockCnt == 0){
    *(out) << std::endl;
  }
  if(m_genItemBlockCnt < m_genItemBlockSize){
    indt(IND3);
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmString                              & stringObj                       ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmEventDecl                           & eventDecl                       ){
  m_eventDeclCnt++;
  if(m_eventDeclCnt < m_eventDeclSize){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmSpecifyBlock                        & specifyBlock                     ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl       & pulseSSCd                        ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmPathDecl                            & pathDecl                         ){
  m_pathDeclCnt++;
  if(m_pathDeclIsSimple || m_pathDeclIsStateSimpleIfNone){
    if(m_pathDeclCnt == 1 && m_pathDeclhasPolarityOp){
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
    if(m_pathDeclCnt == 2 && m_pathDeclhasPolarityOp){
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

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmPathDelayValue                      & pathDelayValue                   ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmMinTypMaxList                       & minTypMaxList                    ){
  m_minTypMaxListCnt++;
  if(m_minTypMaxListCnt < m_minTypMaxListSize){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
  m_specifyTListCnt++;
  if(m_specifyTListCnt < m_specifyTListSize){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmDelayedDataOrReference              & delayedDataOrRef                 ){
  m_delayedDataOrRefCnt++;
  if(m_delayedDataOrRefCnt == 1 && m_delayedDataOrRefSize > 1){
    *(out) << "[ ";
  }
  if(m_delayedDataOrRefCnt == 2){
    *(out) << " ]";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmTimingCheckEvent                    & timingCkEvent                    ){
  m_timingCheckEventCnt++;
  if(m_timingCheckEventCnt == 1 && timingCkEvent->hasTimingCheckCondition()){
    *(out) << " &&& ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmSystemTimingCheck                   & systemTimingCk                   ){
  m_systemTimingCkCnt++;
  if(m_systemTimingCkCnt < m_systemTimingCkSize){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmGateInstantiation                   & gateInstantiation                ){
  m_gateInstanceCnt++;
  if(m_gateInstanceCnt < m_gateInstanceSize){
    if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_EXPR && m_gateInstanceFlag){
      *(out) << ", ";
    }
    if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_EXPR && !m_gateInstanceFlag){
      *(out) << "( ";
      m_gateInstanceFlag = TRUE;
    }
    if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_ID_SCOPE_INDIRECT && m_gateInstanceCnt > 2){
      *(out) << "), ";
      m_gateInstanceFlag = FALSE;
    }
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmPulseControl                        & pulseControl                     ){
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

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmAttrList                       & attrList                  ){
  m_attrListCnt++;
  if(m_attrListCnt < m_attrListSize){
    *(out) << ", ";
  }
}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmDefine                         & define                    ){}

void CVHDLGenerator::inTraversal(const NSCdom::RefCDOmComment                        & comment                   ){}


//********************************************************************************
// After traversal block
//********************************************************************************

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmInclude                       & fileInclude                 ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmDesign                        & design                      ){
  //finishing up defines files
  // defout << "`endif" << std::endl;
   designData.reset();
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmModuleDecl                    & moduleDecl                  ){
  //include logic statement
  /*  indt(m_depth);
  if(CDOmModuleDecl::GEN_FROM_UNIT == m_moduleCslType && FALSE == m_includeInUnit){
    /*  *(out) << "`include \"" <<  *(m_currentModuleName) << ".logic.v\"" << std::endl;
    RefString logicFileName = RefString(new std::string(m_outputPath));
    logicFileName->append(*(m_currentModuleName));
    logicFileName->append(".logic.v");
    std::ofstream *fs = new std::ofstream(logicFileName->c_str());
    fs->close();
    delete fs;*/

    //flag reset
    //WARNING: this may need further optimization
      m_includeInUnit = FALSE;
      //  }

//-----MS added----start

TVec_CVHDLSignalData_const_iter iter1;
TVec_CVHDLPortData_const_iter iter2;
TVec_CVHDLPortData_const_iter iter3;
TVec_CVHDLModuleData_const_iter iter4;
Ref_CVHDLModuleData currMod;
 modInst_iter it1,it11;
refString_iter it;
constrF2A_iter it2;
refString_iter it3, it4, it5, it6;
refVec_iter it7;
 refString_iter itAssn, itExpr, itConcat, itParam;
 TVec_TInt_const_iter itPartSel;
TMap_RefString_RefCDOmExpr_constIter iter;
 iter_mapRefString_Ref_TVec_RefString iterAss;
iter_mapRefString_Ref_TVec_char iterNum;
iter_mapRefString_Ref_TVec_char iterParOver;
 refString_iter iterSec;
 TVec_char_iter iter_num;
TList_RefString_const_iter iter_list1; //--------MS added
TList_RefString_const_iter iter_list2; //--------MS added

int designSize;
TVec_char_iter itNum; //-----------MS added
 int cntInst = 0;
  TBool m_p = FALSE;
  TBool m_c = FALSE;
  
 TVec_CVHDLParamData_const_iter iterParam;
 TVec_CVHDLVarData_const_iter iterVar;
 TInt c=0;
currMod = Ref_CVHDLModuleData( new CVHDLModuleData::CVHDLModuleData);

  if(m_portItemSize !=-1){
  *(out) <<std::endl<< " );" << std::endl;
  }

   *(out) << "end " <<  *(m_currentModuleName) << " ; " << std::endl << std::endl;

  m_depth--;

   *(out) << " architecture " << " arch_" << *m_currentModuleName << " of " << *m_currentModuleName << " is " << std::endl ;

    
     if(module->getPortData()){
      
        designData->addModuleData(module);
        
        module.reset();
       }
     if(modDecl->getInstanceData()) {
      	
       if(modInst->getModuleName()){
	
	
	 indt(m_depth+2);
	 *(out) << " component " <<*(modInst->getModuleName()) << std:: endl;
	 
       }
       //--------if module has params----------------
       //  if(CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType) {
      
	
	 if(pVec.get()){
	   RefTVec_RefCDOmParamDecl paramDeclVec = moduleDecl->getChildren<CDOmParamDecl>(TYPE_PARAM_DECL);
	 
	   indt(m_depth+2);
	  
	  for(iterParam = pVec->begin(); iterParam != pVec->end(); iterParam++){
	    if(iterParam == pVec->begin()){
	      *(out) << "generic ( ";
	    }
	    *(out) << *(*iterParam)->getParamName() << *(*iterParam)->getParamType();
	    if( (*iterParam)->getParamValue()){
	      *(out)<< (*iterParam)->getParamValue();
	    }
	    else {
	      if((*iterParam)->getParamString()){
		*(out) << (*iterParam)->getParamString();
	      }
	    }
		
		if(iterParam < pVec->end()-1){
		  *(out) << "; ";
		}
		else{ *(out) << "); " << std::endl ; }
	
		}
	  m_param = FALSE;
	  pVec.reset();
	 }
	
	 //	 }

	
	 /* if(paramDeclVec.get()) {
		  
		  	TVec_RefCDOmParamDecl_const_iter iter = paramDeclVec->begin();
				iter = paramDeclVec->begin();
			
				for(; iter != paramDeclVec->end(); ++iter) {
				  
				  //	if((*iter)->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
					 
				  		RefTVec_RefCDOmIdentifier idVec = (*iter)->getIDs();
						TVec_RefCDOmIdentifier_const_iter idIter = idVec->begin();
						for(; idIter != idVec->end(); ++idIter) {
							if(iter == paramDeclVec->begin() && 
							   idIter == idVec->begin()) {
								if((*idIter)->getPayload()->getType() == TYPE_EXPR) {
									RefCDOmExpr payloadExpr = CDOmExpr::cast((*idIter)->getPayload()->getChild(0));
									switch(payloadExpr->getExprType()) {
									case CDOmExpr::EXPR_NUMBER :  *(out) << *(*idIter)->getName() << " :" << "csl_integer" << " := "   << CDOmNumber::cast(payloadExpr)->getValue() ; 
										break;
									case CDOmExpr::EXPR_STRING : *(out)  << *(*idIter)->getName() << ": csl_string := \"" << *CDOmString::cast(payloadExpr)->getTokenString() << "\""; 
										break;
									case CDOmExpr::EXPR_OP     : *(out) << *(*idIter)->getName() << " : csl_integer := ";
										
										break;
									
									}
								}
							}
							else {
								if((*idIter)->getPayload()->getType() == TYPE_EXPR) {
									RefCDOmExpr payloadExpr = CDOmExpr::cast((*idIter)->getPayload()->getChild(0));
								
										switch(payloadExpr->getExprType()) {
										case CDOmExpr::EXPR_NUMBER : *(out) << "; " << *(*idIter)->getName() << " : csl_integer := " << CDOmNumber::cast(payloadExpr)->getValue(); 
											break;
										case CDOmExpr::EXPR_STRING : *(out) << "; " << *(*idIter)->getName() << ": csl_string := \"" << *CDOmString::cast(payloadExpr)->getTokenString() << "\""; 
											break;
										case CDOmExpr::EXPR_OP     : *(out) << "; "         << *(*idIter)->getName() << ": csl_integer := ";
											//parseExprOp(CDOmExprOp::cast(payloadExpr), out);
											break;
										}
																		
								}
							}
						} //--end for
				}
				*(out) << " );" << std::endl;	
				m_param = FALSE;		
				//	}
				}*/

	 // }
       //---------------------------------------------
	 if(m_tb == TRUE){
	   *(out) << "component " << dutName <<std::endl;
	 }

	 //-----------------------------------------
      
        indt(m_depth+2);
       *(out) << " port ( ";

       ////////////////////////////
	  
     }
    
     if(designData->getModuleData()){
       designSize =(designData->getModuleData())->size();
      
       //  if(module->getPortData()){
      for(iter4 = (designData->getModuleData())->begin(); iter4 != ((designData->getModuleData())->end()); iter4++){
	
	if(modNo > -1 && modNo < designSize){  
 
	if(*iter4 == (designData->getModuleData())->at(modNo)){ 
	   for(iter2 = ((*iter4)->getPortData())->begin(); iter2 != ((*iter4)->getPortData())->end(); iter2++){
	 
	   *(out) <<std::endl;
	   indt(m_depth+4);
	   *(out) << (*(*iter2)->getPortName()) << (*(*iter2)->getPortDir()) << " " <<(*(*iter2)->getPortType()); 
	   
	   
	   //////////////////////////////////////


	   //-------------add port range--start
	 
	   if(port->getPortRange()){
	     if((((*iter2)->getPortRange())->getUpperLimit()) < 65535 && (((*iter2)->getPortRange())->getLowerLimit())<65535 ){
	       if(m_showRange){  
		  *(out) << "(" ;
		 m_rangeExprs = 0;
	       
		 *(out)<< ((*iter2)->getPortRange())->getUpperLimit();
	       
		     
	       //----------------------------------------------
	       
		     
		 m_rangeExprs++;
	       
		 if(m_rangeExprs == 1){
		   *(out) << " downto ";
		 }
		 
		 *(out) << ((*iter2)->getPortRange())->getLowerLimit();
		 
		 //----------------------------------------------
	       
		 *(out) <<")";
   
	       }
	       m_showRange = TRUE;
	       //----------------------------------------------
	       //for the last port, the ; is missing
	       if(*iter2 !=((*iter4)->getPortData())->back()){
		 *(out) << ";"; 
	       }
	       else { *(out) << " ";}
	     }
	     //if the range is 1;

	     else  { 
	       *(out) << "(0 downto 0)";
	       if(*iter2 !=((*iter4)->getPortData())->back()){
		 *(out) << ";"; 
	       }
	       else { *(out) << " ";}
	     }

	     //-----------------------------------------
	   }
	   //---end---------
	   }
	}
	
	}
      }	 
      
     } 
  
        
     if(modDecl->getInstanceData()) {
       *(out) <<std::endl << " );" << std::endl;
       indt(m_depth+2);
       *(out) << "end component; " << std::endl << std::endl;
      
     }
     
     //******************************************************************

     //*********create the signals for concat as actual***********************
     if(m_isExprActual && m_concatExpr){
       // if(designData->getModuleData()){
       //	 for(iter4 = (designData->getModuleData())->begin(); iter4 != ((designData->getModuleData())->end()); iter4++){
       //   if(iter4 ==((designData->getModuleData())->end())-1){
       //     for(iter2 = ((*iter4)->getPortData())->begin(); iter2 != ((*iter4)->getPortData())->end(); iter2++){
	   
	       // if((*((*iter2)->getPortDir())== " : out ") && (modDecl->getInstanceData())){
	      *(out) << std::endl;
	      indt(m_depth+4);
	      *(out) << "signal gen_sig_" ;

	      //-------------add port range--start
	 
	   if(port->getPortRange()){
	     if((((*iter2)->getPortRange())->getUpperLimit()) < 65535){
	       if(m_showRange){  
		  *(out) << "(" ;
		 m_rangeExprs = 0;
	       
		 *(out)<< ((*iter2)->getPortRange())->getUpperLimit();
	       
		     
	       //----------------------------------------------
	       
		     
		 m_rangeExprs++;
	       
		 if(m_rangeExprs == 1){
		   *(out) << " downto ";
		 }
		 
		 *(out) << ((*iter2)->getPortRange())->getLowerLimit();
		 
		 //----------------------------------------------
	       
		 *(out) <<")";
   
	       }
	       m_showRange = TRUE;
	      
		 *(out) << ";"; 
	     }
	     //if the range is 1;

	     else  { 
	       *(out) << "(0 downto 0);";
	      
	     }

	     //-----------------------------------------
	   }
	   //---end---------
	
          //************************************************************************************** 
     }

      //**************************************************************************************    
	
		  
		   if(modDecl->getSignalData()){
                      if(m_hasSignal){
			for(iter1 = (modDecl->getSignalData())->begin(); iter1 != (modDecl->getSignalData())->end(); iter1++){
			*(out) << std::endl ;
                        indt(m_depth+4);
                        *(out) <<"signal " << (*(*iter1)->getSignalName()) << " : " << (*(*iter1)->getSignalType()); 

			//add signal range--start
 
 
			if(signal->getSignalRange()){
			  if((((*iter1)->getSignalRange())->getUpperLimit()) < 65535 && (((*iter1)->getSignalRange())->getLowerLimit()) < 65535){
			    if(m_showRange){  
			      *(out) << "(" ;
			      m_rangeExprs = 0;
			     
			      *(out)<< ((*iter1)->getSignalRange())->getUpperLimit();
			     
     //----------------------------------------------

   
			      m_rangeExprs++;
   
			      if(m_rangeExprs == 1){
				*(out) << " downto ";
			      }
			      
			      *(out) << ((*iter1)->getSignalRange())->getLowerLimit();
    
    //----------------------------------------------
  
			    *(out) <<")";
   
			  }
			    
			    m_showRange = TRUE;
     //----------------------------------------------
			  *(out) << ";"; 
			  }
			  else {
			    *(out) << "(0 downto 0);";
			  }
			}
     //---end---------
		       
			}
		      }
		   }
 
		   if(modDecl->getInstanceData()) {
			// if there are module instances, then write them in the architecture
		     *(out) << std::endl << std::endl;
		     *(out)<< " begin" << std::endl;
		     for(it11 = (modDecl->getInstanceData())->begin(); it11 != (modDecl->getInstanceData())->end(); it11++) {
		     

//-----------------process-----for assignment statement-----------------------------
		       if(m_assignStmt){
			
			 // if( m_stmtPCAssnType == CDOmStmtProcContAssn::PROC_CONT_ASSN_ASSIGN  ) {
			 //   *(out) << std::endl;
			   // indt(m_depth);

			 for(iterAss = (assignMap)->begin(); iterAss != (assignMap)->end(); iterAss++){
			indt(m_depth+2);
			*(out) << *((*iterAss).first) << " <= " ;
			
			for(iterSec = ((iterAss)->second)->begin(); iterSec != ((iterAss)->second)->end(); iterSec++){
			  *(out)<< *(*iterSec); 
			  
			}
			*(out) << ";" ; 
			m_c=TRUE;
			*(out) << std::endl;
		      }

			 // if(!m_exprNum  && !m_concatExpr  && !m_assignPartSel && !m_partSelActual ){   //process only where a sensitivity list exist
			     //  *(out) << "process( " ;
			   //------add sensitivity list----------------
			   // if(m_assignHID){
			   /*  int j1;
			     if(assignVec.get()){
			       
			       for(itAssn = assignVec->begin(); itAssn != assignVec->end(); itAssn++){
				 if(itAssn == assignVec->begin()+j1){
				   *(out) << *(*(itAssn));
				   j1=j1+2;
				   // if(assignVec->size() > 2){
				     if(itAssn != assignVec->end()-1){
				       *(out) <<",";
				     }
				     else { *(out) << ")" << std::endl;}
				     // }
				 }
				  
			       }
				 
			     }
			     //--------end---------------------
			     //------add sensitivity list for op expr----------------
			     if(opExprVec.get()){
			
			       for(itExpr = opExprVec->begin(); itExpr != opExprVec->end(); itExpr++){
				 if(itExpr == opExprVec->end()-1){
				   *(out) << *(*(itExpr));
				   *(out) << ")" << std::endl;
				 }
			      
			       }
			       opExprVec.reset();
			       }*/
			   //-----end-------------------------------------


			     //   *(out) << "    begin" << std::endl;
			 /* int noStmt1;  //no of assign stmts
			     int i1 = 0;
			     
			     if(assignVec->size() != 0){
			     noStmt1 = assignVec->size()/2;
			     }
			     else{ noStmt1 =0;}

			      if(assignVec.get()){
			       for(itAssn = assignVec->begin(); itAssn != assignVec->end(); itAssn++){
				 if(noStmt1 == 1){               //a single aasign stmt in a module
				   if(itAssn == assignVec->begin()){
				     indt(m_depth+2);
				     *(out) << *(*(itAssn)) ;
				     *(out) << " <= ";
				   }
				   else { 
				     
				       *(out) << *(*(itAssn)) << ";"; 
				   }
				 }
				 else{                         //many assign stmt in the same module
				   if(noStmt1 >1){
				   if(itAssn == assignVec->begin()+i1){
				     indt(m_depth+2);
				     *(out) << *(*(itAssn)) ;
				     *(out) << " <= ";
				     i1=i1+2;
				   }
				   else {
				     
				       *(out) << *(*(itAssn)) << ";" <<std::endl;
				     }
				   }
				 }
			       }
				  
			       }*/
			    
			     //-----------------process-----for operation exression  statement-----------------------------
			 /*  if(opExpr ){
			       /*       for(itAssn = assignVec->begin(); itAssn != assignVec->end(); itAssn++){
				 if(itAssn == assignVec->begin()){
				   indt(m_depth+2);
				   *(out) << *(*(itAssn)) ;
				   *(out) << " <= ";
				 }
				 }*/
			 /* if(opExprVec.get()){
				 for(itExpr = opExprVec->begin(); itExpr != opExprVec->end(); itExpr++){
				   *(out) << *(*(itExpr));
				   if(itExpr == opExprVec->end()-1){
				     if(!m_c){
				       *(out) << ";" << std::endl; m_c = TRUE;}
				   }
				 }
			      
			       }
			       opExpr = FALSE;
			     }*/

			     //------------------------------------------------------------------------------------------ 
			    
			     //  *(out) << std::endl << "    end process;" << std::endl; 
			 // }

			  
			   //------------Expression number --------------------------
			  
			 
			  if(m_exprNum){ 
			    if(((*it11)->getInstanceName())->size() == 1){
			     for(iterNum = (numMap)->begin(); iterNum != (numMap)->end(); iterNum++){
			      indt(m_depth+2);
			      *(out) << *((*iterNum).first) << " <= " ;
			
			      for(iter_num = ((iterNum)->second).begin(); iter_num != ((iterNum)->second).end(); iter_num++){
				*(out)<< (*iter_num); 
				
			      }
			      *(out) << ";" ; 
			      m_c=TRUE;
			      *(out) << std::endl;
			      }
			    }
			    else {
			      if( ((*it11)->getInstanceName())->size() > 1){
				c++;
				if(c == 1){
				  for(iterNum = (numMap)->begin(); iterNum != (numMap)->end(); iterNum++){
				    indt(m_depth+2);
				    *(out) << *((*iterNum).first) << " <= " ;
				    
				    for(iter_num = ((iterNum)->second).begin(); iter_num != ((iterNum)->second).end(); iter_num++){
				      *(out)<< (*iter_num); 
				      
				    }
				    *(out) << ";" ; 
				    m_c=TRUE;
				    *(out) << std::endl;
				  }
				}
			      }
			    }
			    //---------------------------------------------
			   
			  
			  }
			    /*  for(itAssn = assignVec->begin(); itAssn != assignVec->end(); itAssn++){
			       if(itAssn == assignVec->begin()){
				 indt(m_depth+2);
				 *(out) << *(*(itAssn)) ;
				 *(out) << " <= ";
			       }
			     }

			     for(itNum = numVec.begin(); itNum != numVec.end(); itNum++){  
			       *(out) << *itNum ;
			       
			     }
			     
			       *(out) << ";" << std::endl; 
			     
			     m_exprNum = FALSE;
			     // m_assignStmt = FALSE;
			     }*/
			   //-------------------------------------------------------
			   //-----------Concatenation-----------------------------
			 /*  else if(m_concatExpr){
			     for(itAssn = assignVec->begin(); itAssn != assignVec->end(); itAssn++){
			       if(itAssn == assignVec->begin()){
				 indt(m_depth+2);
				 *(out) << *(*(itAssn)) ;
				 *(out) << " <= ";
			       }
			     }
			     for(itConcat = opConcatVec->begin(); itConcat != opConcatVec->end(); itConcat++){  
			       *(out) << *(*itConcat) << " ";
			     }
			
			     *(out) << ";" << std::endl;
			     m_concatExpr = FALSE;
			     // m_assignStmt = FALSE;
			     }*/
			   //-------------------------------------------------------
			   
			   // -----------------Part Select in assign------------------
			  
			   
			 /*  else if(m_assignPartSel){
			     
			     int cnt1 = 0;
			     for(itAssn = assignVec->begin(); itAssn != assignVec->end(); itAssn++){
			       if(itAssn == assignVec->begin()){
				 indt(m_depth+2);
				 *(out) << *(*(itAssn)) ;
				 *(out) << " <= ";
			       }
			       else {  
				 *(out) << *(*(itAssn)) << "(" ;
				 for(itPartSel = partSelVec.begin(); itPartSel !=  partSelVec.end(); itPartSel++){
				   if(itPartSel == partSelVec.begin()+cnt1){
				     *(out) << *(itPartSel);
				     cnt1=cnt1+2;
				   } 
				   else{
				     *(out)<<" downto " << *(itPartSel) ;
				     *(out)<<");" << std::endl; 
				     m_c =TRUE ; 
				   }
				 }
			       }
			     }
			      m_assignPartSel=FALSE;
			      }*/
    //---------------------------------------------------------------------------------------
			  m_assignStmt = FALSE;	  
		       }
			    
		   //--------end---------------------




 //-------------------------------------------------------------------------------------------

                          indt(m_depth+2);
                         
			  *(out) << std::endl << (*(*it11)->getInstanceName()) << " : " << (*(*it11)->getModuleName()); 
			  //  }
			  //------------------Has parameters----------------------

			 
			
		       if(CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType) {
			    // *(out) << "m_intcnt=" <<m_intcnt;
			 /*   if(m_inscnt == 1) {
			      *(out) << " generic map (";
			    }
			    if(m_intcnt < m_moduleInstantiationParamNo) {
			      // *(out) << "#";
			      m_designGenCode = FALSE;
			    }
			    else {
			      
			    }*/
			
			 /* if(!paramNameVec->empty()){
			   *(out) << " generic map ( ";
			   for(itParam = paramNameVec->begin(); itParam != paramNameVec->end(); itParam++){
			     if(itParam == paramNameVec->end()-1){
			       
			       *(out) << *(*itParam) << "=> " << ")" <<std::endl;
			       }*/
			 // *(out) << "size=" << paramOverMap->size();
			  TInt mapSize = paramOverMap->size();
			  if(!paramOverMap->empty()){
			  *(out) << " generic map ( ";
			     for (iterParOver = paramOverMap->begin(); iterParOver != paramOverMap->end(); iterParOver++){
			       //  if(iterParOver == paramOverMap->end()){
			       // *(out) << (*iterParOver->first) << " <= " ;                  //?????
			       for(TInt n=0; n < ((*iterParOver).second).size(); n++){
				 *(out) <<((*iterParOver).second).at(n);
				
			       } 
			       *(out) << ") ";
			       // }
			
			       /*   else{
			       
			       *(out)  << (*iterParOver->first) << "<=" ;
			       //  *(out) << "sss=" << ((*iterParOver).second).size();
			       for(TInt n=0; n < ((*iterParOver).second).size(); n++){
			       *(out) <<((*iterParOver).second).at(n);
 
			       } 
			       *(out) << ", " <<std::endl;
			       indt(m_depth+2);
			       }*/
			       // *(out) << ")";
			     }
			 }
		      
		       *(out) <<std::endl;
		       indt(m_depth+2);
		       *(out) << " port map ( " << std::endl;
			
		       } 
		   
			  //-------------------------------end params override---------------------
			  else {

			    *(out) << " port map ( " << std::endl;
			  }
			  //}---------------

			int cnt = 0;  //used to hold the number of f2a expression from a module instance
			int cnt_item = 0; //used to be incremented after each f2a
			
			// for every module instance, get the formals and actuals   
			//	std::cout << " instance data= " << (modDecl->getInstanceData())->size();
			for(it1 = (modDecl->getInstanceData())->begin(); it1 != (modDecl->getInstanceData())->end(); it1++) {
			  
			  if((*it1)->getF2AData()) {
			   
			    if(*it1 == (modDecl->getInstanceData())->at(cntInst)){   //---each unit instance has an instance data 
			      for(it2 = ((*it1)->getF2AData())->begin(); it2 != ((*it1)->getF2AData())->end(); it2++) {

			      
					if( ((*it2)->getFormalActualExpr()).get() ) {
					   cnt =((*it2)->getFormalActualExpr())->size(); 
						for(iter = ((*it2)->getFormalActualExpr())->begin(); iter != ((*it2)->getFormalActualExpr())->end(); iter++) {
						  
							m_actualExpr = TRUE; // is TRUE when printing an expression used as an actual
                                                        cnt_item++;  

							indt(m_depth+10);
							*(out) << *(iter->first) << " =>" ;
							*(out) << "(";

							// write the actuals for the input formals
							
							if(m_inputPortCon.get()) {
							  // *(out) << "(";
							  for(iter_list1 = m_inputPortCon->begin(); iter_list1 != m_inputPortCon->end(); iter_list1++) {   
							    if(*(iter->first) == *(iter_list1->get()) ) { 

							      std::cout<< "input port:" << *(iter->first) << std::endl;

							      // if the formal is connected to a number or expression, then the actual is the generated signal
							      switch(iter->second->getExprType()) {
							      case CDOmExpr::EXPR_NUMBER    : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_NUMBER   " << std::endl; 
								m_isNumActual = TRUE; p = 'o'; 
								m_partSelActual = FALSE;
								// write number to generated signal
								//	*(out) << *(iter->first);
									CVisitorTraversal::visit(CDOmNum32::cast(iter->second)); 
								//*(out) << ");\n"; 
									m_actualExpr = FALSE;
								break;
							      case CDOmExpr::EXPR_HID       : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_HID      " << std::endl; 
								p = 'o'; 
								// if the actual is a part select, then the actual is the generated signal
								if((iter->second)->getChildrenSize() > 0) {
								  // write part select to generated signal
								  m_partSelActual = TRUE;
								  m_isNumActual = FALSE;
								  // *(out) << *(iter->first) ;
								    CVisitorTraversal::visit(CDOmExprLink::cast(iter->second)); 
								  //*(out) << ");\n";
								    m_actualExpr = FALSE;
								}
								break;
							      case CDOmExpr::EXPR_OP        : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_OP       " << std::endl; 
								p = 'o'; m_isExprActual = TRUE; m_isNumActual = FALSE;
								// write expression to generated signal
								//*(out) <<*(iter->first) ;
									CVisitorTraversal::visit(CDOmExprOp::cast(iter->second)); 
								//*(out) << ");\n";
								break;
							      case CDOmExpr::EXPR_MINTYPMAX : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_MINTYPMAX" << std::endl; 
								p = 'o'; break;
							      }

							      //*(out) << ");\n";

							    }
							  }
							}

							// write the actuals for the input formals
							      if(m_inputPortCon.get()) {
								//	*(out) << "(";
								for(iter_list1 = m_inputPortCon->begin(); iter_list1 != m_inputPortCon->end(); iter_list1++) {   
								  if(*(iter->first) == *(iter_list1->get()) ) { 

							      switch(iter->second->getExprType()) {
							      case CDOmExpr::EXPR_NUMBER    : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_NUMBER   " << std::endl; 
								m_isNumActual = TRUE; p = 'i'; 
								for(itNum = numVec.begin(); itNum != numVec.end(); itNum++){  
								  *(out) << *itNum ;
								}
			     
								//	*(out)<< "exp_number";
							
								CVisitorTraversal::visit(CDOmNum32::cast(iter->second));
								m_actualExpr = FALSE; 
								break;
							      case CDOmExpr::EXPR_STRING    : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_STRING   " << std::endl; 
								p = 'i';
								
								CVisitorTraversal::visit(CDOmString::cast(iter->second));
								m_actualExpr = FALSE; 
								break;
							      case CDOmExpr::EXPR_HID       : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_HID      " << std::endl; 
								p = 'i';
								if((iter->second)->getChildrenSize() > 0) {
								  // write f2a with generated signal
								   m_partSelActual = TRUE;
								  *(out) << *(iter->first);
								}
								else {
								  
								  //  m_actualExpr = FALSE;	
								  m_isNumActual = FALSE;
								}
							       
								  CVisitorTraversal::visit(CDOmExprLink::cast(iter->second)); 
								  m_actualExpr = FALSE; 
								break;
							      case CDOmExpr::EXPR_OP        : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_OP       " << std::endl; 
								p = 'i'; m_isExprActual = TRUE; m_isNumActual = FALSE;
								// write f2a with generated signal
								//		*(out) << "(gen_sig_" << (*(*it1)->getInstanceName()) << *(iter->first);
								m_actualExpr = FALSE; 
								break;
														      
							      }
							      m_actualExpr = FALSE; 
								  }
								}
							      }


							// write the actuals for the output formals
							if(m_outputPortCon.get()) {
							  // *(out) << "(";
							  for(iter_list2 = m_outputPortCon->begin(); iter_list2 != m_outputPortCon->end(); iter_list2++) {   //*-------MS added
							    if(*(iter->first) == *(iter_list2->get()) ) { 

							      std::cout<< "output port:" << *(iter->first) << std::endl;
							      
							      switch(iter->second->getExprType()) {
							      case CDOmExpr::EXPR_NUMBER    : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_NUMBER   " << std::endl; 
								m_isNumActual = TRUE; 
								m_partSelActual =  FALSE;
								p = 'o'; 
							     
								CVisitorTraversal::visit(CDOmNum32::cast(iter->second)); break;
							      case CDOmExpr::EXPR_STRING    : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_STRING   " << std::endl; 
								p = 'o'; 
								
								CVisitorTraversal::visit(CDOmString::cast(iter->second)); break;
							      case CDOmExpr::EXPR_HID       : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_HID      " << std::endl; 
								p = 'o'; 
                                                                 
								// if the actual is a part select, then it must be written
								if((iter->second)->getChildrenSize() > 0) {
								   
								  m_partSelActual = TRUE; 
								  
								}
								else {
								  m_partSelActual = FALSE;
								}
								m_isNumActual = FALSE;
								//	*(out) << "gen_sig_" ;
								CVisitorTraversal::visit(CDOmExprLink::cast(iter->second)); 
								
								if(m_partSelActual){
								  //  *(out) << "( partSel );" ;
								 
								}
							         break;
							      case CDOmExpr::EXPR_OP        : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_OP       " << std::endl; 
								p = 'o'; m_isExprActual = TRUE; m_isNumActual = FALSE;
							       
								CVisitorTraversal::visit(CDOmExprOp::cast(iter->second)); break;
							      case CDOmExpr::EXPR_MINTYPMAX : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_MINTYPMAX" << std::endl; 
								p = 'o'; break;
							       
							
							      }
							      							      
							    }
							  }
							}
							//write the actuals for the inout formals
							if(m_inoutPortCon.get()) {
							  // *(out) << "(";
							  for(iter_list2 = m_inoutPortCon->begin(); iter_list2 != m_inoutPortCon->end(); iter_list2++) {   //*-------MS added
							    if(*(iter->first) == *(iter_list2->get()) ) { 

							      std::cout<< "inout port:" << *(iter->first) << std::endl;
							      
							      switch(iter->second->getExprType()) {
							      case CDOmExpr::EXPR_NUMBER    : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_NUMBER   " << std::endl; 
								m_isNumActual = TRUE; m_partSelActual =  FALSE;
								p = 'b'; 
							     
								CVisitorTraversal::visit(CDOmNum32::cast(iter->second)); break;
							      case CDOmExpr::EXPR_STRING    : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_STRING   " << std::endl; 
								p = 'b'; 
							      
                                                                CVisitorTraversal::visit(CDOmString::cast(iter->second)); break;
							      case CDOmExpr::EXPR_HID       : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_HID      " << std::endl; 
								p = 'b'; 
								// if the actual is a part select, then it must be written
								if((iter->second)->getChildrenSize() > 0) {
								   
								  m_partSelActual = TRUE; 
								}
								else {
								  
								}
								m_isNumActual = FALSE;
							       
								CVisitorTraversal::visit(CDOmExprLink::cast(iter->second)); break;
							      case CDOmExpr::EXPR_OP        : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_OP       " << std::endl; 
								p = 'b'; m_isExprActual = TRUE; m_isNumActual = FALSE;
							      
								CVisitorTraversal::visit(CDOmExprOp::cast(iter->second)); break;
							      case CDOmExpr::EXPR_MINTYPMAX : std::cout<<"************CVisitorTraversal::CDOMExpr type = EXPR_MINTYPMAX" << std::endl; 
								p = 'b'; break;
							       
							
							      }
							     
							    }
							  }
							}
						
							m_actualExpr = FALSE; 
							// the last item hasn't comma
							if( cnt_item < cnt){
							*(out) << ")," << std::endl;
							}
							else{ *(out) << ")" << std::endl; }
		
					
						}
					}
			      }
			      
			     
			    }//---cntInst
			
			    
			  }
						  
										
			}
			cntInst++;
			*(out) << std::endl ;
			indt(m_depth+8);
			*(out) << ");" << std::endl;
		         }//----------

		} // end of if
		else {
		  *(out) << std::endl << " begin " << std::endl; 

		  //---------------Variable declaration-------------------------
		 
		  if(m_hasVar){
		    indt(m_depth);
		    *(out) << "  process " << std::endl;
		    if(modDecl->getVarData()){
		      for(iterVar = (modDecl->getVarData())->begin(); iterVar != (modDecl->getVarData())->end(); iterVar++){
			indt(m_depth+2);
			*(out) << " variable " << *(*iterVar)->getVarName() << *(*iterVar)->getVarType() ; 
			if(*(*iterVar)->getVarType()== " : csl_bit_vector "){

			  //add signal range--start
 			if(variable->getVarRange()){
			  if((((*iterVar)->getVarRange())->getUpperLimit()) < 65535 && (((*iterVar)->getVarRange())->getLowerLimit()) < 65535){
			    if(m_showRange){  
			      *(out) << "(" ;
			      m_rangeExprs = 0;
			     
			      *(out)<< ((*iterVar)->getVarRange())->getUpperLimit();
			     
     //----------------------------------------------

   
			      m_rangeExprs++;
   
			      if(m_rangeExprs == 1){
				*(out) << " downto ";
			      }
			      
			      *(out) << ((*iterVar)->getVarRange())->getLowerLimit();
    
    //----------------------------------------------
  
			    *(out) <<")";
   
			  }
			    
			    m_showRange = TRUE;
     //----------------------------------------------
			    //  *(out) << ";"; 
			  }
			  else {
			    *(out) << "(0 downto 0)";
			  }
			}
     //---end---------
			 
			}
			*(out) <<" ;" ;
			//	*(out) << ":= " << (*iterVar)->getVarValue() << ";";
			*(out) <<std::endl;
		      }
		    }
		    indt(m_depth);
		    *(out) << "  begin " << std::endl;
		  }

		  //-------------------------------------------------------------
 
		  //-----------------process-----for assignment statement----------
		  if(m_assignStmt){
		   
		    // indt(m_depth);
		    
		    	    
		      for(iterAss = (assignMap)->begin(); iterAss != (assignMap)->end(); iterAss++){
			indt(m_depth+2);
			*(out) << *((*iterAss).first) << " <= " ;
			
			for(iterSec = ((iterAss)->second)->begin(); iterSec != ((iterAss)->second)->end(); iterSec++){
			  *(out)<< *(*iterSec); 
			  
			}
			*(out) << ";" ; 
			m_c=TRUE;
			*(out) << std::endl;
		      }

		      if(m_exprNum){
		
		       	for(iterNum = (numMap)->begin(); iterNum != (numMap)->end(); iterNum++){
			  indt(m_depth+2);
			  *(out) << *((*iterNum).first) << " <= " ;
			
			  for(iter_num = ((iterNum)->second).begin(); iter_num != ((iterNum)->second).end(); iter_num++){
			    *(out)<< (*iter_num); 
			    
			  }
			  *(out) << ";" ; 
			  m_c=TRUE;
			  *(out) << std::endl;
			  }
		      }
		      //------------------------------------------------------
		      // -----------------Part Select in assign------------------

		      /*  if(m_assignPartSel){
			int cnt = 0;
		       	*(out) << "PartSel!!";
			for(itAssn = assignVec->begin(); itAssn != assignVec->end(); itAssn++){
			 
			    if(itAssn == assignVec->begin()){
			      indt(m_depth+2);
			      *(out) << *(*(itAssn)) ;
			      *(out) << " <= ";
			    }
			    else {  
			      *(out) << *(*(itAssn)) << "(" ;
			      for(itPartSel = partSelVec.begin(); itPartSel !=  partSelVec.end(); itPartSel++){
				if(itPartSel == partSelVec.begin()+cnt){
				  *(out) << *(itPartSel);
				  cnt=cnt+2;
				} 
				else{
				  *(out)<<" downto " << *(itPartSel) ;
				  *(out)<<");" << std::endl; 
				  m_c =TRUE ; 
				}
			      }
			      
			    }
			 
			
			}
				m_assignPartSel=FALSE;
				}*/
    //--------------------------------------------------------------------------------------- 
		      m_assignStmt = FALSE;
		  }
		}
		   if(m_hasVar){
		     indt(m_depth);
		     *(out) << "end process; " ;
		     m_hasVar = FALSE;
		   }
		   *(out) << std::endl<< " end " << " arch_" << *(modDecl->getTopModuleName())<< " ; " << std::endl;
 
		
		//------end
			
	
		m_depth--;

               
                modDecl.reset();
		modInst.reset();
		F2As.reset();
                signal.reset();
                module.reset();
		assignVec.reset();
		opExprVec.reset();
		opConcatVec.reset();
		//paramVec.reset();
		numVec.erase(numVec.begin(), numVec.end());
		numMap.reset();
	
            
		modNo++;
  if(TRUE == file){
    delete out;
   
  }
	  	       
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmIdentifier                    & id                          ){
  m_expandNum32 = FALSE;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmPortItem                      & portItem                    ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmExprLink                      & exprLink                    ) {
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmExprOp                        & exprOp                      ){
  RefCDOmBase parent = exprOp->getParent();

  if (exprOp->isUnary()) {
    // *(out) << ")";
  }

  if(parent.get() && parent->getType() == TYPE_EXPR){
    if(CDOmExpr::cast(parent)->getExprType() == CDOmExpr::EXPR_MINTYPMAX){
      // *(out) << ")";
      }
  }
  m_exprCnt.pop_back();
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmListExpr                      & listExpr                    ){
  if(m_listExprHasFunctionCallParent){
    *(out) << ")";
  }else if(m_listExprHasExprLinkParent){
    *(out) << "]";
  }
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmPortDecl                      & portDecl   ){  

 std::string p;
 std::string dir;


switch (portDecl->getPortType()){
 case (PORT_INOUT)  :  {        *(out) << ": inout "                                    ;   
                        	dir = " : inout "                                      ; } break;
 case (PORT_INPUT)  :  {        *(out) << ": in "                                      ;   
                         	dir = " : in "                                         ; }  break;
 case (PORT_OUTPUT) :  {        *(out) << ": out "                                     ;  
	                        dir = " : out "                                        ; }  break;
    default            :    *(out) << "/*Error in port direction*/" << std::endl   ;      break;
  }


  if(portDecl->getNetType()){
    switch (portDecl->getNetType()){
      /*  case (NET_SUPPLY0) :         *(out) << "supply0 "                                 ;  break;
      case (NET_SUPPLY1) :         *(out) << "supply1 "                                 ;  break;
      case (NET_TRI)     :         *(out) << "tri "                                     ;  break;
      case (NET_TRIAND)  :         *(out) << "triand "                                  ;  break;
      case (NET_TRIOR)   :         *(out) << "trior "                                   ;  break;
      case (NET_TRI0)    :         *(out) << "tri0 "                                    ;  break;
      case (NET_TRI1)    :         *(out) << "tri1 "                                    ;  break;*/
      case (NET_WIRE)    :       {  *(out) << "csl_bit_vector "                          ;  
                                    p = " csl_bit_vector" ; }                             break;
     
      /*  case (NET_WAND)    :         *(out) << "wand "                                    ;  break;
      case (NET_WOR)     :         *(out) << "wor "                                     ;  break;
      case (NET_TRIREG)  :         *(out) << "trireg "                                  ;  break;*/
      default            :         *(out) << "/*Error in net declaration*/" << std::endl;  break;
    }
  }
    else if(portDecl->getVarType()){
      switch (portDecl->getVarType()) {
        case (VAR_UNDEFINED) : *(out) << "csl_bit_vector " ; break;
        case (VAR_REG      ) : *(out) << "csl_bit_vector " ; break;
      }
    }
 else{
    switch (portDecl->getVarType()){
      case (VAR_REG     ) : *(out) << "csl_bit "                                     ;  break;
      case (VAR_REAL    ) : *(out) << "csl_real "                                    ;  break;
      case (VAR_REALTIME) : *(out) << "csl_realtime "                                ;  break;
      case (VAR_TIME    ) : *(out) << "csl_time "                                    ;  break;
      case (VAR_INTEGER ) : *(out) << "csl_integer "                                  ;  break;             
      default             : *(out) << "/*Error in var declaration*/" << std::endl;  break;
    }
  }
 
  if(portDecl->getVarType() == VAR_UNDEFINED && (portDecl->getVarType() != VAR_INTEGER || portDecl->getVarType() != VAR_TIME)){
    if(portDecl->isSigned()){
      *(out) << "signed ";
    }
  }
  // ---------MS added----------
    port->addPortType( RefString (new std::string (p)));
    port->addPortDir( RefString (new std::string (dir)));
    module->addPortData(port); 
   
 //----------------------------------------
    // std::cout << "port =" << *(port->getPortName()) << "\n";
     
  TInt i;
  TInt upper;
  rangeData = Ref_CVHDLRangeData(new CVHDLRangeData::CVHDLRangeData);
  
  if(m_showRange){
    *(out) << "(" ;
    m_rangeExprs = 0;
    if(!m_upperVec.empty()){
      if( m_upperVec[1] == 1){
      
	*(out) << m_upperVec[0] << " - " << m_upperVec[1];
	
	upper = m_upperVec[0]-1;
	rangeData->setUpperLimit(upper);
	
	//      std::cout << " ---------MS------------ upperVec2 =" << m_upperVec[0] << std::endl;
	m_upperVec.erase(m_upperVec.begin(),m_upperVec.end());
      }
      else {
	*(out) << m_upperVec[0];
	
        rangeData->setUpperLimit(m_upperVec[0]);
	
	//     std::cout << " ---------MS------------ upperVec3 =" << m_upperVec[0] << std::endl;
	m_upperVec.erase(m_upperVec.begin(),m_upperVec.end());
	//----------------------------------------------
      }
    }
    m_rangeExprs++;
 
    if(m_rangeExprs == 1){
     *(out) << " downto ";
    }
     *(out) << m_lower;
       rangeData->setLowerLimit(m_lower);
     *(out) <<")";
     
    
  }
  else { *(out) << "(0 downto 0)";}

  port->addPortRange(rangeData);
  m_showRange = TRUE;
     //----------------------------------------------
  
  //  *(out) << ";"; 

   
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmVarDecl                       & varDecl                     ){

  //// calling indenter function ////
  indt(m_depth);
 std::string var;

  if(varDecl->getVarType()){
    switch (varDecl->getVarType()){
      /* case (VAR_REG)      :  *(out) << " : csl_bit_vector "                                  ;      break;
      case (VAR_INTEGER)  :  *(out) << " : csl_integer "                                     ;      break;
      case (VAR_REAL)     :  *(out) << " : csl_real "                                        ;      break;
      case (VAR_REALTIME) :  *(out) << " : csl_realtime "                                    ;      break;
      case (VAR_TIME)     :  *(out) << " : csl_time "                                        ;      break;*/

      case (VAR_REG)      :  var = " : csl_bit_vector "                                  ;      break;
      case (VAR_INTEGER)  :  var = " : csl_integer "                                     ;      break;
      case (VAR_REAL)     :  var = " : csl_real "                                        ;      break;
      case (VAR_REALTIME) :  var = " : csl_realtime "                                    ;      break;
      case (VAR_TIME)     :  var = " : csl_time "                                        ;      break;
      default             :  *(out) << "/* Error in var declaration */" << std::endl         ;      break;
    }
    variable->addVarType(RefString(new std::string (var)));
    variable->addVarValue(5);
    modDecl->addVarData(variable);

  }else{
    DCERR("Error in var type");
  }
  

 //------------MS added----------------

  TInt i;
  TInt upper;
  TInt zero = 0;
  rangeData = Ref_CVHDLRangeData(new CVHDLRangeData::CVHDLRangeData);

   if(m_showRange){
     if(!m_upperVec.empty()){
       if( m_upperVec[1] != 0){
        
	 upper = m_upperVec[0]-1;             //use to get upperLimit-1
	 rangeData->setUpperLimit(upper);

	 m_upperVec.erase(m_upperVec.begin(),m_upperVec.end());
       }
       else {
     
	 rangeData->setUpperLimit(m_upperVec[0]);
	 m_upperVec.erase(m_upperVec.begin(),m_upperVec.end());
      }
     }
   //----------------------------------------------

  
       rangeData->setLowerLimit(m_lower);
     
   }
   
 
  //----------------------------------------------
        
   variable->addVarRange(rangeData); 
   m_showRange = TRUE;
   //----------------------------------------------
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmNetDecl                       & netDecl                     ){
  //indenter function
  indt(m_depth);
  std::string sig;
   if(netDecl->getNetType()){
    switch (netDecl->getNetType()) {
      /* case (NET_UNDEFINED):  /* do nothing here */                           //;      break;
      /* case (NET_SUPPLY0)  :  *(out) << "supply0 "                              ;      break;
      case (NET_SUPPLY1)  :  *(out) << "supply1 "                                 ;      break;
      case (NET_TRI)      :  *(out) << "tri "                                     ;      break;
      case (NET_TRIAND)   :  *(out) << "triand "                                  ;      break;
      case (NET_TRIOR)    :  *(out) << "trior "                                   ;      break;
      case (NET_TRI0)     :  *(out) << "tri0 "                                    ;      break;
      case (NET_TRI1)     :  *(out) << "tri1 "                                    ;      break;
      case (NET_WIRE)     :  *(out) << "csl_bit_vector "                           ;      break;*/

      case (NET_SUPPLY0)  :  sig= "csl_bit_vector "                                 ;      break;
      case (NET_SUPPLY1)  :  sig= "csl_bit_vector "                                 ;      break;
      case (NET_TRI)      :  sig= "csl_bit_vector "                                 ;      break;
      case (NET_TRIAND)   :  sig= "csl_bit_vector "                                 ;      break;
      case (NET_TRIOR)    :  sig= "csl_bit_vector "                                 ;      break;
      case (NET_TRI0)     :  sig= "csl_bit_vector "                                 ;      break;
      case (NET_TRI1)     :  sig= "csl_bit_vector "                                 ;      break;
      case (NET_WIRE)     :  sig= "csl_bit_vector"                                  ;      break; 
      case (NET_WAND)     :  sig= "csl_bit_vector"                                  ;      break;
      case (NET_WOR)      :  sig= "csl_bit_vector"                                  ;      break;
      case (NET_TRIREG)   :  sig= "csl_bit_vector"                                  ;      break;
      
      /*  case (NET_WIRE)     :  *(out) << "wire "                                    ;      break;
      case (NET_WAND)     :  *(out) << "wand "                                    ;      break;
      case (NET_WOR)      :  *(out) << "wor "                                     ;      break;
      case (NET_TRIREG)   :  *(out) << "trireg "                                  ;      break;*/
      default             :  ASSERT(FAIL, "Uninitialized or undefined enum data") ;      break;
    }
   
    // ---------MS added----------
    signal->addSignalType( RefString (new std::string (sig)));
    modDecl->addSignalData(signal);

  } else {
    DCERR("Error in net type");
  }

   
  
  //condition: getNetDeclType returns NET_DECL_ID_ONLY
   /*  if (netDecl->getNetDeclType() == 1 && netDecl->getNetType() == NET_TRIREG){
    switch(netDecl->getChargeStrength()){
      case (CDOmNetDecl::CHARGE_STRENGTH_UNDEFINED): /* do nothing here                                ;   break;
      case (CDOmNetDecl::CHARGE_STRENGTH_SMALL)    : *(out) << "( small )"                               ;   break;
      case (CDOmNetDecl::CHARGE_STRENGTH_MEDIUM)   : *(out) << "( medium )"                              ;   break;
      case (CDOmNetDecl::CHARGE_STRENGTH_LARGE)    : *(out) << "( large )"                               ;   break;
      default                                      : ASSERT(FAIL, "Uninitialized or undefined enum data");   break;
    }
  }*/

  //condition: getNetDeclType returns NET_DECL_ID_EXPR_PAIR
  if (netDecl->getNetDeclType() == 2){
    switch(netDecl->getFirstDriveStrength()){
      case (DRIVE_STRENGTH_UNDEFINED): /* do nothing here */                               ; break;
      case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "( supply0, "                             ; break;
      case (DRIVE_STRENGTH_STRONG_0) : *(out) << "( strong0, "                             ; break;
      case (DRIVE_STRENGTH_PULL_0)   : *(out) << "( pull0, "                               ; break;
      case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "( weak0, "                               ; break;
      case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "( highz0, "                              ; break;
      case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "( supply1, "                             ; break;
      case (DRIVE_STRENGTH_STRONG_1) : *(out) << "( strong1, "                             ; break;
      case (DRIVE_STRENGTH_PULL_1)   : *(out) << "( pull1, "                               ; break;
      case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "( weak1, "                               ; break;
      case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "( highz1, "                              ; break;
      default                        : ASSERT(FAIL, "Uninitialized or undefined enum data"); break;
    }
    switch(netDecl->getSecondDriveStrength()){
      case (DRIVE_STRENGTH_UNDEFINED): /* do nothing here */                               ; break;
      case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0 )"                               ; break;
      case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0 )"                               ; break;
      case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0 )"                                 ; break;
      case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0 )"                                 ; break;
      case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0 )"                                ; break;
      case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1 )"                               ; break;
      case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1 )"                               ; break;
      case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1 )"                                 ; break;
      case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1 )"                                 ; break;
      case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1 )"                                ; break;
      default                        : ASSERT(FAIL, "Uninitialized or undefined enum data"); break;
    }
  }


 
  if(netDecl->getVectorAccessType() == CDOmNetDecl::VECTOR_ACCESS_VECTORED){
    *(out) << "vectored ";
  }
  else if (netDecl->getVectorAccessType() == CDOmNetDecl::VECTOR_ACCESS_SCALARED){
    *(out) << "scalared ";
  }
  if(netDecl->isSigned()){
    *(out) << "signed ";
  }
  //  *(out) << ";" << std::endl;

  //------------MS added----------------

  TInt i;
  TInt upper;
  TInt zero = 0;
  rangeData = Ref_CVHDLRangeData(new CVHDLRangeData::CVHDLRangeData);

   if(m_showRange){
     if(!m_upperVec.empty()){
       if( m_upperVec[1] != 0){
        
	 upper = m_upperVec[0]-1;             //use to get upperLimit-1
	 rangeData->setUpperLimit(upper);

	 m_upperVec.erase(m_upperVec.begin(),m_upperVec.end());
       }
       else {
     
	 rangeData->setUpperLimit(m_upperVec[0]);
	 m_upperVec.erase(m_upperVec.begin(),m_upperVec.end());
      }
     }
   //----------------------------------------------

  
       rangeData->setLowerLimit(m_lower);
     
   }
   
 
  //----------------------------------------------
        
   signal->addSignalRange(rangeData); 
   m_showRange = TRUE;
   //----------------------------------------------
}   


void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmRange                         & range                       ){
  //if(!m_noRange){
  //  *(out) << "] ";
  //}else{
  //  m_noRange = FALSE;
  //}
 
  /*  if(m_showRange){
    *(out) <<")";
    *(out) << ";";
     }
     m_showRange = TRUE; */
 
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmNum32                         & num                         ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmReal                          & realNum                     ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation      & moduleInstantiation         ){
  // *(out) << ";" << std::endl;
   explicitPortNameMap.reset();
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstance           & moduleInstance              ) {
 
	if(m_moduleInstanceCloseParen) {
		        //----MS added---start

			// add F2As object to vector
			modInst->addF2AData(F2As);


			TVec_RefString_const_iter itt;

		        TMap_RefString_RefCDOmExpr_constIter iter;

			if(explicitPortNameMap.get()) {
				F2As->addFormalActualExpr(explicitPortNameMap);
			
				// this is only to print the expressions
				//	for(iter = explicitPortNameMap->begin(); iter != explicitPortNameMap->end(); iter++) {
				
				//	}
			       
				explicitPortNameMap.reset();
			}

		}
	
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmParamDeclCollection           & paramDeclCollection         ){}
   
void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmParamDecl                     & paramDecl                   ){
  //TVec_CVHDLParamData_const_iter iterParam;
  //TVec_char_iter iterVal;
  // int iVal;

 // int parNo = (module->getParamData())->size();

 //m_parCnt++;
  if(!m_pulseControlSection){
    *(out) << " " << std::endl;
  }else{
    m_pulseControlSection = FALSE;
  }
   m_namesVec.clear();

if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
			m_designGenCode = TRUE;
		}
  /* if((module->getParamData()).get()){
    if(m_parCnt == 1){
      *(out) << std::endl;
      *(out) << " generic ( ";

    }
      for(iterParam=(module->getParamData())->begin();iterParam !=(module->getParamData())->end(); iterParam++){

	*(out) << *(*iterParam)->getParamName() << *(*iterParam)->getParamType();
	if ( ((*iterParam)->getParamValue()).get()){ 
	  *(out) << ":= ";
	  for( iVal = 0; iVal < ((*iterParam)->getParamValue())->size(); iVal++){
	    *(out) << ((*iterParam)->getParamValue())->at(iVal);
	    if(parNo == 1){                         //one parameter inside the unit
	    *(out) << ");" << std::endl;
	    }
	    else { *(out)<< ", "; }                //a list of params
	  }

  	}
	else{ 
	  if(parNo==1){
	    *(out) << " );" ; 
	  }
	  else { *(out) << ", "; }
	  
	}
      }
      }*/
  //  *(out) << "!!!!m_parCnt= "<< m_parCnt <<" !!!parNo = " << parNo; 
  // if(m_parCnt == parNo-1){
  //    *(out) <<std::endl << " port ( " <<std::endl;
      m_param = FALSE;
      // }
 }

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmParamOverride                 & paramOverride               ){
  *(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmMinTypMax                     & minTypMax                   ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmDelay                         & delay                       ){
  if(m_delayHasParanths){
  //if(delay->getDelayType() == 0 || delay->getDelayType() == 1){
    //*(out) << ")";
  }
  *(out) << " ";
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmInitOrAlways                  & initOrAlways                ){
  //// exiting depth ////
  m_depth--;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmAssn                          & assn                        ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmContAssn                      & contAssn                    ){
  // *(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmt                          & stmt                        ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtBlock                     & stmtBlock                   ) {
  //// exiting depth ////
  //m_depth--;

  //// calling indenter function ////
  indt(m_depth - 1);

  if(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_PARALLEL){
    *(out)  << "join" << std::endl;
  } else if(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_SEQUENTIAL) {
    *(out)  << "end" << std::endl;
  }
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtAssn                       & stmtAssn                    ){
  // *(out) << ";" << std::endl;
  m_expandNum32 = FALSE;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmEventControl                   & eventCtrl                   ){
  if( m_eventCtrlType == CDOmEventControl::EVENT_CONTROL_EVENT_EXPR ){
    *(out) << " ) " /*<< std::endl*/;
  }else{
    *(out) /*<< std::endl*/;
  }
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmEventExpr                      & eventExpr                   ){
  m_eventExprCnt.pop_back();
  //eventExprtype reset
  m_eventExprType = -1;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){
  if(delayCtrl->getDelayControlType() == CDOmDelayControl::DELAY_CONTROL_MINTYPMAX){
    // *(out) << "  )";
  }
  // *(out) << " ";
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){
  //*(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
  //// exiting depth ////
  m_depth--;
  //// calling indenter function ////
  indt(m_depth);

  *(out) << "end case" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
  //// exiting depth ////
  m_depth--;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
  //// exiting depth ////
  m_depth--;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
  // *(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
  //*(out) << ";";
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){
  // *(out) << ";";
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){
  // *(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
  // *(out) << ")";
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
  ASSERT(m_exprConcatSize->top() == ZERO, "this should be \'0\'");
  m_exprConcatSize->pop();

  if (m_exprConcatSize->empty()) {
    m_exprConcatSize = RefTStack_TInt();
  }

 
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) {
  // *(out) << "";
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) {
  *(out) << "endprimitive"<< std::endl << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) {
  // *(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) {
  // *(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) {
  // *(out) << " ;" << std::endl;
  if(m_combEntryCnt == m_combEntrySize) {
    indt(IND2);
    *(out) << "endtable" << std::endl;
  }
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) {
  // *(out) << " ;" << std::endl;
  if(m_seqEntryCnt == m_seqEntrySize) {
    indt(IND2);
    *(out) << "endtable" << std::endl;
  }
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) {
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ){
  *(out) << "endtask" <<std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) {
  RefCDOmBase parent = tfPortDecl->getParent();
  if(parent.get() && (parent->getType() == TYPE_DECL_TASK && CDOmTaskDecl::cast(parent)->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST ||
      (parent->getType() == TYPE_DECL_FUNCTION && (CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE  ||
                                                   CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE ||
                                                   CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST))))
     *(out) << " " << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
  *(out) << "endfunction" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) {}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) {
  //*(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ){
  *(out) << "endgenerate" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ){
  *(out) << "endcase" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ){
  *(out) << "end" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmString                          & stringObj                   ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ){
  // *(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ){
  //// exiting depth ////
  m_depth--;
  //// calling indenter function ////
  indt(m_depth);

  *(out) << "endspecify" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                  ){
  // *(out) << ";" <<std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                   ){
  //*(out) << ";" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue             ){
  if(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITH_PAREN){
    // *(out) << " )";
  }
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList              ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList        ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef           ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl          ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent              ){}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk             ){
  *(out) << " );" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation          ){
  *(out) << ");" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl               ){
  *(out) << " );" << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmAttrList                        & attrList                   ){
  *(out) << " *)";
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmDefine                          & define                     ){
  defout << std::endl;
}

void CVHDLGenerator::afterTraversal(const NSCdom::RefCDOmComment                         & comment                     ){
  if(m_commentStar){
    *(out) << "*/" << std::endl;
  }
}

}
