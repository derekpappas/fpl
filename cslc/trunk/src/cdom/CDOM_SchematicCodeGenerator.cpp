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

#include "CDOM_SchematicCodeGenerator.h"
//#include "CDOM_SchematicCodeTbGenerator.h" //-----OB added---
#include <fstream>
#include "../support/CommonSupport.h"
#include "../support/TypeDefs.h"

using namespace std;


using namespace NSCdom;

namespace NSCdomSchematicCodeGenerator {  

	//depth counter -- used for indentation control
	TInt m_depth;

  
//********************************************************************************

// CUnitInstances class - OB added
// class with unit name and the instances it contains
//********************************************************************************
  CUnitInstances::CUnitInstances() {

  }

  void CUnitInstances::setUnitName(RefString &uName) {
    unitName = RefString(new std::string(*uName));
  }

  RefString CUnitInstances::getUnitName() {
    return unitName;
  }

  // add an instance of the current unit
  void CUnitInstances::addUnitInstance(RefString &inst) {
    if(!unitInstances.get()) {
      unitInstances = Ref_TVec_RefString(new TVec_RefString);
    }
    unitInstances->push_back(inst);
  } 

  Ref_TVec_RefString CUnitInstances::getUnitInstances() {
    return unitInstances;
  } 

  // add an instance in the current unit
  void CUnitInstances::addInstance(RefString &inst) {
    if(!instanceNames.get()) {
      instanceNames = Ref_TVec_RefString(new TVec_RefString);
    }
    instanceNames->push_back(inst);
  } 

   Ref_TVec_RefString CUnitInstances::getInstanceNames() {
    return instanceNames;
  } 

  CUnitInstances::~CUnitInstances() {
    if(unitName.get()) {
      unitName.reset();
    }

    if(instanceNames.get()) {
      instanceNames.reset();
    }

    if(unitInstances.get()) {
      unitInstances.reset();
    }
  }


// CUnitsInst class holds all the objects for every unit

    CUnitsInst::CUnitsInst() {

}

    void CUnitsInst::addUnitObj(Ref_CUnitInstances &inst) {
	if(!unitInst.get()) {
      unitInst = RefTVec_Ref_CUnitInstances(new TVec_Ref_CUnitInstances);
    }
    unitInst->push_back(inst);
}

    RefTVec_Ref_CUnitInstances CUnitsInst::getUnitObjs() {
		return unitInst;
}

    CUnitsInst::~CUnitsInst() {

    if(unitInst.get()) {
      unitInst.reset();
    }
}



	//********************************************************************************//
	//                  CSchematicCodeGenerator class                                       //
	//********************************************************************************//

	CSchematicCodeGenerator::CSchematicCodeGenerator(std::string filename):m_ctorFileName(filename) {

		//------OB commented---start
		// if (!filename.empty()) {
		//fileCpp = RefOfstream(new std::ofstream(filename.c_str()));
		//--------end
		//-------OB added---start
		//    fileCpp = new std::ofstream(filename.c_str());
		//   file=TRUE; 
		//  }
		//--------end
		//-------OB added---start
		out = &(std::cout);
		//--------end
	}
  
	CSchematicCodeGenerator::~CSchematicCodeGenerator() {
		//------OB commented---start
		//  if (file) {
		//    (*fileCpp).close();
		//  }
		//--------end
	}


  // global object used to hold vector with units, unit instances and the instances they contain
  Ref_CUnitsInst unitInst;
  // global object used to hold unit name and the intances it contains
  Ref_CUnitInstances unitNI;


	//********************************************************************************//
	//                 Helper Functions                                               //
	//********************************************************************************//

	void CSchematicCodeGenerator::indt(TInt size) {
		size = size*2;
		for(int i=0; i < size; i++){
			*(out) << " ";
		}
	}

	//void CSchematicCodeGenerator::indtFile(TInt size, RefOfstream file) { //---OB commented
	void CSchematicCodeGenerator::indtFile(TInt size, std::ostream* file) {
		size = size*2;
		for(TInt i=0; i<size; ++i) {
			*(file) << " ";
		}
	}

	//void CSchematicCodeGenerator::portListIndtFile(TInt size, RefOfstream file) { //---OB commented
	void CSchematicCodeGenerator::portListIndtFile(TInt size, std::ostream* file) {
		for(TInt i=0; i<size; ++i) {
			*(file) << " ";
		}
	}


	void CSchematicCodeGenerator::portListIndt(TInt size) {
		size = size*1;
		for(int i=0; i < size; i++){
			*(out) << " ";
		}
	}

      
	//------------OB added---start---copyright notice
	void CSchematicCodeGenerator::copyrightNotice(std::string fileName){
		//Copyright notice

		*(out) << "//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER\n//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc" << std::endl;
		// *(out) << "//OUTPUT FILE NAME  : " << fileName << std::endl;
	}

	// function to get the HID for the instance name

	void CSchematicCodeGenerator::getHID(RefString rs, TBool firstTime = true) {
		if(firstTime) {
			*rs = *instName;
			firstTime = false;
		}
		else {
			*rs = *instName + "." + *rs;
		}

		cout << "instance name: " << *instName << std::endl;
		cout << "hid:" << *rs << std::endl;

		//if(m_parent) {
			//m_parent->getHID(rs,firstTime);
		//}
	}
	//---------end

	//********************************************************************************//
	//                 Before traversal block                                         //
	//********************************************************************************//

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){
		//// calling indenter function ////
		indt(m_depth);

  
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      ){
		//------OB added---start
		fileCpp = new std::ofstream((m_ctorFileName + "schematic.nlview").c_str());
		m_showRange = TRUE;
		m_widthRange = TRUE; //----width as range
		//hasParam = FALSE;
		//---------end
		//Initializations
		out = fileCpp; 
		m_design = design;
		m_depth = 0;
		m_addIndent = 0;
		m_designFuncIdNo = 1;
		m_designGenCode = TRUE;
		m_designTemplateModuleNamesVec = std::vector<std::string>();
		m_portWidthTypeMap = RefTMap_RefString_ESCPortWidthType(new TMap_RefString_ESCPortWidthType());
		contAssignNo = 1;
  
		//Copyright notice
		copyrightNotice("schematic"); //------OB added
		
		*(out) << std::endl;
		*(out) << "module new TOP v" << std::endl;

	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ){
		//-------OB commented---start
		// out = fileCpp;
		// m_ctorFileName = std::string(*moduleDecl->getModuleName() + std::string(".temp"));
		//  fileTemp = RefOfstream(new std::ofstream(m_ctorFileName.c_str()));  
		//---------end

		//-------OB added---start
		m_currentModuleName = moduleDecl->getModuleName(); // module name

		out = fileCpp;

		file = TRUE;

		//--------end
		m_modcnt = 0;
		m_depth++;


		//cout<<"print module decl\n";

  
		// if there is a module declaration
		if(moduleDecl->getKeywordType() == CDOmModuleDecl::KEYWORD_MODULE ||
		    moduleDecl->getKeywordType() == CDOmModuleDecl::KEYWORD_MACROMODULE) {
		  *(out) << std::endl;
		  *(out) << "  load symbol " ;
		} else {
			*(out) << "/* Error in unit declaration */" << std::endl;
		}


				// create object with CUnitInstances objects
				if(!unitInst.get()) {
				  unitInst = Ref_CUnitsInst(new CUnitsInst);
				}
				// create object for each unit and set unit name
				if(!unitNI.get()) {
					unitNI = Ref_CUnitInstances(new CUnitInstances);
				}
				//RefString uName = RefString(new std::string(*m_currentModuleName));
				unitNI->setUnitName(m_currentModuleName);
				// add object to vector
				unitInst->addUnitObj(unitNI);

		cout<<"unit:" << *(unitNI->getUnitName()) << endl;


 
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) {
		m_idPrintSemi = FALSE;

		if(TRUE == m_designGenCode) {
			//std::cout << "ID parent is " << id->getParent()->getType() << std::endl;
			RefCDOmBase parent = id->getParent();
			// add modules names
			if(parent->getType() == TYPE_DECL_MODULE){
				m_addIndent = id->getName()->size();
				
				//-----------OB added---start
								
				
				*(out) << *(id->getName()) << " ";
				//cout<<"module decl:" << *(id->getName()) << endl;
				//----------------end
			}
			// add modules instances
			else if(parent->getParent()->getType() == TYPE_MODULE_INSTANTIATION) {

				//RefString instName = RefString(new std::string((*(id->getName()) + std::string("_"))));

				//cout<<"mod inst:" << *(id->getName()) << endl;
			} 
			//-----------OB added---start

			// ports and signals declarations
			else if(parent->getType() != TYPE_PORT_ITEM && parent->getType() == TYPE_PORT_DECL) {
				*(out) << *(id->getName()) << " ";
				//cout<<"port decl\n";
			}
    
		}
  
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ){}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ){
		//Initializations
		m_exprLinkExprSize = 0;
		m_exprLinkExprCnt = 0;
		m_exprLinkListExprSize = 0;
		if(TRUE == m_designGenCode) {
			RefCDOmBase parent = exprLink->getParent();
			ECDOmType parentType = parent->getType();
			TMap_RefString_ESCPortWidthType_const_iter mapIter = m_portWidthTypeMap->find(exprLink->getName());

			
			if(!exprLink->isHID()) {
				if(parentType != TYPE_PORT_ITEM && 
				   parentType != TYPE_INST_MODULE || 
				   parentType == TYPE_RANGE && m_rangeGenExpr) {

				}

				if(parentType == TYPE_INST_MODULE) {
						
					//-----OB added----start
				  //*(out) << *(exprLink->getName());

				  if(TRUE == m_actualExpr) {
				    
				    //*(out) << *(exprLink->getName());
				    //cout<<"*********input formal with signal:" << *(exprLink->getName()) << endl;
				    
				    
				  }
				  //-------end
				}


				
			}
			else {
				m_exprLinkHidNames = exprLink->getHidNames();
				m_exprLinkExprs = exprLink->getHidExprs();
				if(m_exprLinkHidNames.get()) { 
					m_exprLinkExprSize = m_exprLinkHidNames->size();
					///*(out) << *(m_exprLinkHidNames->at(m_exprLinkExprCnt));
					//if((m_exprLinkExprs->at(m_exprLinkExprCnt)).get())
					  ///*(out) << "[";
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

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ){

	  //cout<<"----------beforeTraversal(const NSCdom::RefCDOmExprOp begin" << endl;
		//Initializations
		m_exprCnt.push_back(0);
		m_exprOpCloseParen = FALSE;
		RefCDOmBase parent = exprOp->getParent();
		if(parent.get() && parent->getType() == TYPE_EXPR){
			if(CDOmExpr::cast(parent)->getExprType() == CDOmExpr::EXPR_MINTYPMAX && m_designGenCode){
			  ///*(out) << "(";
			}
		}

		if(TRUE == m_designGenCode) {

			if(exprOp->isUnary()){
				// switch
			}
			else if(exprOp->isBinary() && m_exprCnt.back() == 1) {
				// switch
			}
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ){
		//Initializations
		m_listExprCnt = 0;
		m_listExprHasExprLinkParent = false;
		m_listExprHasFunctionCallParent = false;
		m_parent = listExpr->getParent();
		if(m_parent.get()){
			if(m_parent->getType() == TYPE_EXPR){
				if((CDOmExpr::cast(m_parent))->getExprType() == CDOmExpr::EXPR_HID){
					m_listExprHasExprLinkParent = true;
					//*(out) << "[";
				} else if((CDOmExpr::cast(m_parent))->getExprType() == CDOmExpr::EXPR_FUNCTION_CALL){
					m_listExprHasFunctionCallParent = true;
					///*(out) << "(";
				}
			}
		}
		m_listExprSize = listExpr->getNumberOfChildren();
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) {
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


			}

			*(out) << "  port ";

  
		}
		
		if(portDecl->getVarType() == VAR_UNDEFINED && 
		   (portDecl->getVarType() != VAR_INTEGER || 
			portDecl->getVarType() != VAR_TIME)){
			if(portDecl->isSigned()){
				m_portDeclSigned = TRUE;
			}
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ){
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
			// switch
		}else{
			std::cerr << "Error in var type" << std::endl;
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ){
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
			// switch
		} else {
			std::cerr << "Error in net type" << std::endl;
		}
  
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmRange                           & range                       ){
		if(m_designGenCode) {
			m_rangeGenExpr = TRUE;
			m_rangeAsWidth = TRUE;
			m_widthRange = 0;
			m_binaryExpr = FALSE; //--------OB added---default is no width as binary expression
			m_minusExpr = FALSE; //--------OB added---default is no width as binary expression with a minus

			//----------OB added----start

			RefTVec_RefCDOmBase rangeChildrenVec = range->getChildrenAsBase(TYPE_EXPR);
			// if the width is given as a range, then calculate the width using upper bound and lower bound
			if(rangeChildrenVec.get() && 
			   rangeChildrenVec->size() == 2){ 
				if(CDOmExpr::cast(rangeChildrenVec->at(0))->getExprType() == CDOmExpr::EXPR_NUMBER && 
				   CDOmExpr::cast(rangeChildrenVec->at(1))->getExprType() == CDOmExpr::EXPR_NUMBER){
					m_showRange = CDOmNumber::cast(rangeChildrenVec->at(0))->getValue() || CDOmNumber::cast(rangeChildrenVec->at(1))->getValue();
					m_widthRange = CDOmNumber::cast(rangeChildrenVec->at(0))->getValue() - CDOmNumber::cast(rangeChildrenVec->at(1))->getValue() + 1;
				}
			}
    
			//---------end

			//m_width = TRUE; //-------OB added
			if(m_showRange){ //---------OB added
				if(range->getParent()->getType() == TYPE_RANGE_LIST) {
					m_rangeGenExpr = FALSE;
					///*(out) << "[";
				}
				else {
				  ///*(out) << "<sc_int<";
					m_rangeExprs = 0;//----OB added
				}
			}

			else {
			  ///*(out) << "<sc_int<";
			}
			//    m_rangeExprs = 0;//----OB commented
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmNum32                           & num                         ){
		if(TRUE == m_designGenCode) {
			//Indenter
			//if(num->getParent()->getType() == TYPE_LIST_EXPR){
			//  //// calling indenter function ////
			//  indt(m_depth);
			//}
			//(*out) << num->getValue(); //-----OB commented

			//----OB added----start

			//cout<<"in beforeTrav num:" << num->getValue() << endl;

			m_inputExpr = FALSE; // there is no input port connected with an expression with numbers

			if(TRUE == m_width) {

			  if(m_showRange){ 

					if(m_widthRange) {
						//*(out) << m_widthRange; // add width calculated from upper and lower bounds
						m_width = FALSE;  // finished adding the width
						
						// add the width of the input port to the map - needed for the generated signal
						if(inputPortsMap.get() && TRUE == m_inputPorts) {
						  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
						  it->second = m_widthRange;
						  //cout<<">>>>>>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
						  m_inputPorts = FALSE;
						}

					}
					else {
						//*(out) << num->getValue();
						m_width = FALSE;  // finished adding the width

						// add the width of the input port to the map - needed for the generated signal
						if(inputPortsMap.get() && TRUE == m_inputPorts) {
						  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
						  it->second = num->getValue();
						  //cout<<">>>>>>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
						  m_inputPorts = FALSE;
						}
					}
				}

				else if(TRUE == m_minusExpr && TRUE == m_binaryExpr) {
					//*(out) <<  num->getValue();
					m_minusExpr = FALSE;
					m_width = FALSE;  // finished adding the width

					// add the width of the input port to the map - needed for the generated signal
					if(inputPortsMap.get() && TRUE == m_inputPorts) {
					  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
					  it->second = num->getValue();
					  //cout<<">>>>>>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
					  m_inputPorts = FALSE;
					}


				}
				else {
					//*(out) << "1";    // default width is 1 
					m_width = FALSE;  // finished adding the width

					// add the width of the input port to the map - needed for the generated signal
					if(inputPortsMap.get() && TRUE == m_inputPorts) {
					  iter_TMap_RefString_TInt it = inputPortsMap->find(formalName);
					  it->second = 1;
					  //cout<<">>>>>>>>insert width in map:" << num->getValue() << " for port:" << *formalName << endl;
					  m_inputPorts = FALSE;
					}

				}
			}

			//------end

		}
  

	}


	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmReal                            & realNum                      ){
		*(out) << *(realNum->getTokenString());
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) {
		//Initializations
		m_intcnt = 0;
		m_moduleInstantiationParamNo = 0;
		m_moduleInstantIsTemlateClass = FALSE;
		m_moduleInstantiationType = moduleInstantiation->getModuleInstantiationType();
		m_moduleInstantiationName = RefString();
		m_moduleInstantParamExprVec = RefTVec_RefCDOmExpr();
		m_portItems = RefTVec_RefCDOmPortItem();

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
		}
		m_moduleInstantiationName = moduleInstantiation->getModuleExprLink()->getName();

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

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ){
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
			if(exprVec.get()) {
				m_moduleInstanceExprSize = exprVec->size();
				TVec_RefCDOmBase_const_iter baseIter = exprVec->begin();

			}
		}

	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {}   

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {
		if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
			m_designGenCode = FALSE;
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ){
		//Initializations
		m_paramOverrideCnt = 0;
		m_paramOverrideSize = paramOverride->getChildrenSize();

		//// calling indenter function ////
		indt(m_depth);

		//*(out) << "defparam ";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ){
		m_minTypMaxCnt = 0;
		RefTVec_RefCDOmBase minTypMaxChildrenVec = minTypMax->getChildrenAsBase(TYPE_EXPR);
		if(minTypMaxChildrenVec.get()){
			m_minTypMaxChildren = minTypMaxChildrenVec->size();
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmDelay                           & delay                       ){
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

		///*(out) << "wait("; //--------OB added
		if(m_delayHasParanths){
			//if(delay->getDelayType() == CDOmDelay::DELAY_2 || delay->getDelayType() == CDOmDelay::DELAY_3){
			///*(out) << "(";
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ){
		m_stmtNonBlockingVec = RefTVec_RefCDOmStmt(new std::vector<RefCDOmStmt>);

		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;
 
		if(initOrAlways->getInitOrAlwaysType() == CDOmInitOrAlways::INIT_OR_ALWAYS_INIT ){
		  ///*(out) << "initial ";
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
				//*(out) << std::endl;
			}
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmAssn                            & assn                        ){
		m_assnPos = 0;
		indtFile(m_depth, out);
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ){
		if(contAssn->hasDelay3()){
			m_contAssnPos = -1;
		} else {
			m_contAssnPos = 0;
		}
 
		RefTVec_RefCDOmAssn contAssnVec = contAssn->getNetAssns();
		m_contAssnSize = contAssnVec->size();

		//// calling indenter function ////
		//(*out) << "\n";
		indt(m_depth);
		//indtFile(m_depth+2, fileTemp);
		
		m_designFuncIdNo++;
		m_depth++;

	
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ){
		if(stmt->getStmtType() == CDOmStmt::STMT_NULL){
			//// calling indenter function ////
			indt(m_depth);

			///*(out) << ";" << std::endl;
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ){
		m_stmtBlockHasBlockingAssn = FALSE;
  

		if(!(stmtBlock->getChildrenAsBase()).get()){
			m_stmtBlockSize = 0;
		}
		else {
			m_stmtBlockSize = stmtBlock->getChildrenSize(); 
		}
 
		if(CDOmStmtBlock::BLOCK_PARALLEL == stmtBlock->getBlockType()){
		  ///*(out) << "void nonblocking_" << m_designFuncIdNo << "() {\n";
			m_depth++;
			//indtFile(m_depth, fileTemp);
			if(m_eventExprVec.get() && m_eventExprVec->size() > 0) {
				TVec_RefCDOmExprLink_const_iter iter = m_eventExprVec->begin();
				//for(; iter != m_eventExprVec->end(); ++iter)
			}
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
  
		  ///(*out) << "{";
			//indtFile(m_depth, out);
		}
		else if(m_stmtBlockHasBlockingAssn == TRUE) {
		  ///(*out) << "\n";
			indtFile(m_depth, out);
			///(*out) << "void sequential_block_" << m_designFuncIdNo << "() {";
			m_depth++;
			if(m_eventExprVec.get() && m_eventExprVec->size() > 0) {
				TVec_RefCDOmExprLink_const_iter iter = m_eventExprVec->begin();
				//for(; iter != m_eventExprVec->end(); ++iter)
				  ///(*fileTemp) << "<<" << *(*iter)->getName();
			}
			++m_designFuncIdNo;  
		}
		if(stmtBlock->isNamed()){
			m_stmtBlockCnt = -1;
		} else {
			m_stmtBlockCnt = 0;
			//*(out) << std::endl;
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ){
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

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ){ 
		m_eventExprVec = RefTVec_RefCDOmExprLink(new std::vector<RefCDOmExprLink>);
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ){
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

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){
		if(delayCtrl->getDelayControlType() == CDOmDelayControl::DELAY_CONTROL_MINTYPMAX){
		  ///*(out) << "( ";
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){
		//Initialization
		m_stmtPCAssnType = stmtPCAssn->getProcContAssnType();

		//// calling indenter function ////
		indt(m_depth);
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){
		m_stmtPTCtrlPos = 0;
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
		//Initializations
		m_caseType = stmtCase->getCaseType();
		m_stmtCaseCnt = 0;
		m_stmtCaseDefault = stmtCase->hasDefault();
		m_stmtCaseSize = stmtCase->getChildrenSize();

		//*(out) << std::endl;
		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;

		if(m_caseType == CDOmStmtCase::CASE_CASE){
		  ///*(out) << "switch(";
		} 
		else if (m_caseType == CDOmStmtCase::CASE_CASE_Z) {
		  ///*(out) << "casez ( ";
		} 
		else if (m_caseType == CDOmStmtCase::CASE_CASE_X) {
		  ///*(out) << "casex ( ";
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
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
    
		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;

		if(!m_stmtIfHasAttrList){
		  ///*(out)  << "if(";
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
		//Initializations
		m_stmtLoopCnt = 0;
 
		//*(out) << std::endl;

		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;

		m_stmtLoopType = stmtLoop->getLoopType();

	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
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

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
		//Initializations
		m_stmtWaitCnt=0;

		//// calling indenter function ////
		indt(m_depth);

		///*(out) << "wait (";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){

		//// calling indenter function ////
		indt(m_depth);

		///*(out) << "disable ";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){
	  ///*(out) << "<-";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
		//Initializations
		m_rangeExprPos = 0;
		m_rangeExprType = rangeExpr->getRangeExprType();
  
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
		//Initializations
		m_exprConcatPos = 0;
		m_exprConcatSize = exprConcat->getChildrenSize();
		///*(out) << "(";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ){
		//Initializations
		m_exprMultiConcatPos = 0;
		///*(out) << "(";
	}


	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmUdpDecl                          & udpDecl                    ){
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
		///*(out) << "primitive ";
	}


	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmUdpPortDeclOutput                & udpPortDeclOutput                ) {
		//Initializations
		m_udpOutPortName = udpPortDeclOutput->getID()->getName();
		//indenter function
		indt(IND1);
		// switch
	}


	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput                ) {
		m_udpPdInputCnt = 0;
		RefTVec_RefCDOmIdentifier idVec = udpPortDeclInput->getIDs();
		if(idVec.get()){
			m_portIdSize = idVec->size();
		}
		indt(IND1);
		///*(out) << "input ";
	}


	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                    ) {
		indt(IND2);
		//if(m_combEntryCnt == 0)
		  ///*(out) << "table" << std::endl;
	}


	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                     ) {
		indt(IND2);
		//if(m_seqEntryCnt == 0)
		  ///*(out) << "table" << std::endl;
	}


	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                     ) {
		indt(IND2);
		///*(out) << "initial ";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        ){
		//Initializations
		m_taskDeclCnt = 0;
		m_taskDeclPortItemSize = -1;
		RefTVec_RefCDOmBase portItemsVec = taskDecl->getChildrenAsBase(TYPE_TF_PORT_DECL);
		if(portItemsVec.get()) {
			m_taskDeclPortItemSize = portItemsVec->size();
		}

		///*(out) << "task ";
		//if(taskDecl->isAutomatic()){
		  ///*(out) << "automatic ";
		//}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                       ) {
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

		ECDOmPortType portType = tfPortDecl->getPortType();
		ECDOmVarType varType = tfPortDecl->getVarType();

		// switch

		// switch
		//if(varType == VAR_REG && tfPortDecl->isSigned())
			//*(out) << "signed ";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
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
		//*(out) << std::endl;
		m_funcDeclType = funcDecl->getFuncDeclType();
		//*(out) << "function ";
		if(funcDecl->isAutomatic()){
			//*(out) << "automatic ";
		}
		if(funcDecl->isSigned()){
			//*(out) << "signed ";
		}
		if(m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE || 
		   m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE) {
			// switch
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmFunctionCall                        & functionCall                    ){
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmGenvarDecl                          & genvarDecl                      ){
		//Initializations
		m_genvarDeclCnt = 0;
		m_genvarDeclSize = genvarDecl->getChildrenSize();
		///*(out) << "genvar ";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmGenInst                             & genInst                         ){
	  ///*(out) << "generate " << std::endl;
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemNull                         & genItemNull                     ){
	  ///*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemIf                           & genItemIf                       ){
		//Initializations
		m_genItemIfCnt = 0;
		m_genItemIfSize = genItemIf->getChildrenSize();
		///*(out) << "if (";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemCase                         & genItemCase                     ){
		//Initializations
		m_genItemCaseCnt = 0;
		m_genItemCaseDefault = genItemCase->hasDefault();
		m_genItemCaseSize = genItemCase->getChildrenSize();

		///*(out) << "case ( ";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemLoop                         & genItemLoop                     ){
		//Initializations
		m_genItemLoopCnt = 0;
		///*(out) << "for( ";
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemBlock                        & genItemBlock                    ){
		//Initializations
		m_genItemBlockSize = genItemBlock->getChildrenSize(); 
		indt(IND1);

		///*(out) << "begin ";//<< std::endl;

		if(genItemBlock->isNamed()){
		  ///*(out) << ": ";
			m_genItemBlockCnt = -1;
		} else {
			m_genItemBlockCnt =  0;
			///*(out) << std::endl;
		}
		//indt(IND3);
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmString                              & stringObj                       ){
		if(TRUE == m_designGenCode) {
		  ///*(out) << "\"" << *(stringObj->getTokenString()) << "\"" ;
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmEventDecl                           & eventDecl                       ){
		//Initializations
		m_eventDeclCnt = 0;
		RefTVec_RefCDOmIdentifier eventDeclVec = eventDecl->getIDs();
		if(eventDeclVec.get()){
			m_eventDeclSize = eventDeclVec->size();
		}else{
			m_eventDeclSize = 0;
		}
		///*(out) << "event ";

	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmSpecifyBlock                        & specifyBlock                     ){
		//// calling indenter function ////
		indt(m_depth);
		//// entering new depth ////
		m_depth++;

		///*(out) << "specify " << std::endl;
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl       & pulseSSCd                        ){
		m_pulseSSCdType = pulseSSCd->getDeclType();

		//// calling indenter function ////
		indt(m_depth);

		// switch
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmPathDecl                            & pathDecl                         ){
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

		//if(m_pathDeclIsSimple || m_pathDeclIsEdge){
			//*(out) << "( ";
		//}
		//if(m_pathDeclIsEdge){
			//if( pathDecl->getEdgeIdentifier() == CDOmPathDecl::PATH_DECL_POSEDGE ){
				//*(out) << "posedge ";
			//}else if ( pathDecl->getEdgeIdentifier() == CDOmPathDecl::PATH_DECL_NEGEDGE ){
				//*(out) << "negedge ";
			//}
		//}
		//if(m_pathDeclIsStateSimpleIf || m_pathDeclIsStateEdgeIf){
			//*(out) << "if ( " ;
		//}
		//if(m_pathDeclIsStateSimpleIfNone){
			//*(out) << "ifnone ( ";
		//}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmPathDelayValue                      & pathDelayValue                   ){
		//if(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITH_PAREN){
			//*(out) << "( ";
		//}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmMinTypMaxList                       & minTypMaxList                    ){
		m_minTypMaxListCnt = 0;
		m_minTypMaxListSize = minTypMaxList->getNumberOfChildren();
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
		m_specifyTListCnt = 0;
		m_specifyTListSize = specifyTerminalList->getNumberOfChildren();
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmDelayedDataOrReference              & delayedDataOrRef                 ){
		m_delayedDataOrRefCnt = 0;
		m_delayedDataOrRefSize = delayedDataOrRef->getChildrenSize();
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                ){
		m_timingCheckType = timingCkEventCtrl->getTimingCheckType();
		switch(m_timingCheckType){
		case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_POSEDGE) : //*(out) << "posedge "; break;
		case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_NEGEDGE) : //*(out) << "negedge "; break;
		case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_EDGE   ) : {
			//*(out) << "edge [ ";
			RefTVec_TInt m_timingCheckEdgeDescriptor = timingCkEventCtrl->getEdgeDescriptors();
			if(m_timingCheckEdgeDescriptor.get()){
				//for(TVec_TInt_const_iter iter = m_timingCheckEdgeDescriptor->begin(); iter < m_timingCheckEdgeDescriptor->end(); iter++){
					// switch
				//}
			}
			//*(out) << "]";
		} break;
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmTimingCheckEvent                    & timingCkEvent               ){
		if(timingCkEvent->canBeControlled()){
			m_timingCheckEventCnt = -1;
		}else{
			m_timingCheckEventCnt = 0;
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmSystemTimingCheck                   & systemTimingCk              ){
		m_systemTimingCkCnt = 0;
		m_systemTimingCkSize = systemTimingCk->getChildrenSize();
		m_systemTimingCkType = systemTimingCk->getTimingCheckType();

		//// calling indenter function ////
		indt(m_depth);

		// switch
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmGateInstantiation              & gateInstantiation         ){
		//// calling indenter function ////
		indt(m_depth);

		m_gateInstanceType = gateInstantiation->getPrimitiveType();
		// switch
		gateVec = gateInstantiation->getChildrenAsBase();
		m_gateInstanceSize = gateVec->size();
		m_gateInstanceCnt = 0;
		m_gateInstanceFlag = false;


	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmPulseControl                   & pulseControl              ){
		m_pulseControlSection = true;
		m_pulseControlSize = pulseControl->getChildrenSize();
		indt(m_depth);
		//*(out) << "PATHPULSE$";
		if(!(m_pulseControlSize > 2)){
			m_pulseControlCnt = 0;
			//*(out) << " = ( ";
			m_pulseControlLong = false;
		}else {
			m_pulseControlCnt = -2;
			m_pulseControlLong = true;
		}
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmAttrList                       & attrList                  ){
		//Initializations
		m_attrListSize = attrList->getChildrenSize();
		m_attrListCnt = 0;
  
		//*(out) << "(* "; 
	}

	void CSchematicCodeGenerator::beforeTraversal(const NSCdom::RefCDOmDefine                         & define                   ){
		m_defineType = define->getDefineType();
		if(m_defineType == CDOmDefine::DEFINE_TYPE_DEFINE){
			//*(out) << "`define ";
		}
		else if(m_defineType == CDOmDefine::DEFINE_TYPE_UNDEF){
			//*(out) << "`undef ";
		}
		//*(out) << *(define->getMacroName()) << " ";
	}

	//********************************************************************************//
	//                     In traversal block                                         //
	//********************************************************************************//

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmDesign                          & design                      ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ){
		//--------OB added---start
		//  if(m_inst) {
		//   m_moduleFileName = RefString(new std::string(*m_currentModuleName + std::string(".h")));
		//    *(out) << "#include \"" << *m_moduleFileName << "\"" << std::endl;
		//  }

	  //------end

		m_modcnt++;
		if(m_modcnt == 1) {
		  ///*(out) << ") {" << std::endl;
		  *(out) << "v HIERBOX \\ " << std::endl;
			//    *(fileTemp) << ") {" << std::endl; //------OB fileTemp comm
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ){
		//  hasParam = FALSE; //------OB added
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ){
		if(TRUE == m_designGenCode) {
			m_exprLinkExprCnt++;
			if(m_exprLinkExprCnt < m_exprLinkExprSize) {
				//if((m_exprLinkExprs->at(m_exprLinkExprCnt - 1)).get())
					//*(out) << "].";
				//else
					//*(out) << ".";
				//*(out) << *(m_exprLinkHidNames->at(m_exprLinkExprCnt));
				//if((m_exprLinkExprs->at(m_exprLinkExprCnt)).get())
					//*(out) << "[";
			}
		}

	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ){

	  //cout<<"----------inTraversal(const NSCdom::RefCDOmExprOp begin" << endl;
	  m_assignPartSel = FALSE; // no assign with part sel

		//m_posCnt++;
		m_exprCnt.back()++;
		if(TRUE == m_designGenCode) {
		  //cout<<"----------inTraversal(const NSCdom::RefCDOmExprOp if(TRUE == m_designGenCode) {" << endl;
			if(exprOp->isUnary() && 
			   m_exprCnt.back() == 1) {
				// switch
			}
			else if(exprOp->isBinary() && 
					m_exprCnt.back() == 1){

			  //cout<<"----------binary op:" << endl;

				
				// if there are expressions used as actuals in f2a connections
				if(TRUE == m_exprSigPortActual || (TRUE == m_isExprActual && p == 'o')) {
				  //cout<<"--------binary opp\n";
				  if(TRUE == m_actualExpr) {
				    //cout<<"----------binary op: actual" << endl;

					// switch

				  }
				} 
				else if(FALSE == m_inputExpr && p != 'i') {
				  //cout<<"----------binary op: false" << endl;
					// switch
				}
			}
			if(exprOp->isTernary()){
				if(m_exprCnt.back() == 1){
					//*(out) << " ? ";
				} else if(m_exprCnt.back() == 2){
					//*(out) << " : ";
				}
			}
		}
		//cout<<"----------inTraversal(const NSCdom::RefCDOmExprOp end" << endl;
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ){
		m_listExprCnt++;
		if(m_listExprCnt < m_listExprSize && 
		   m_listExprSize > 1 ){
			if( m_listExprHasExprLinkParent){
				//*(out) << "][";
			} else {
				//*(out) << ", ";
			}
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ){
		m_pdcnt++;
		//if(m_pdcnt == 0) *(out) << "> ";
		if(m_pdcnt > 0 && m_pdcnt < m_portIdSize && m_portIdSize != 1){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ){
		//if(m_vrcnt < 0 && m_varType == VAR_REG) {
		//  *(out) << ">v ";
		//}

		m_vrcnt++;
		if(m_vrcnt > 0 && 
		   m_vrcnt < m_varIdSize && 
		   m_varIdSize > 1){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ){
		m_ntcnt++;
		//if(m_ntcnt == 0) *(out) << "> ";
		//if(m_ntcnt <= m_netIdSize && m_netIdSize != 1){
		if(m_ntcnt > 0 && 
		   m_ntcnt < m_netIdSize && 
		   m_netIdSize != 1){
			//*(out) << ", ";
		}
	}


	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmRange                           & range                       ){
		if(TRUE == m_designGenCode) {
			if(TYPE_RANGE_EXPR == range->getParent()->getType() && 
			   0 == m_rangeExprs) {
				//(*out) << ",";
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

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmNum32                           & num                         ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmReal                            & realNum                     ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ){
		if(CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_ORDERED_PARAM_ASSN == m_moduleInstantiationType) {
			if(m_intcnt == 0 && m_moduleInstantiationParamNo == 0) {
				if(m_moduleInstantIsTemlateClass) {
					//*(out) << "<>";
					m_moduleInstantiationParamNo = 1;
				}
				//*(out) << " *";
			}
			else if(m_intcnt*(-1) == m_moduleInstantiationParamNo){
				//*(out) << "<";
			}
			else if(m_moduleInstantiationParamNo != 0 && m_intcnt == 0) {
				//*(out) << "> *";
			}
			else if(m_intcnt < 0){
				//*(out) << ", ";
			}
		}
		else if(CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType) {
			if(m_intcnt == 0) {
				//*(out) << "<> *";
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
				//*(out) << "<>";
			}
			// write pointer to module instance
			// *(out) << " *"; //-----OB new comm
		}

		m_intcnt++;
		if(m_intcnt > 1 && 
		   m_intcnt <= m_instanceNumSize && 
		   m_instanceNumSize != 1) {
			//*(out) << ", " << std::endl;
			indt(m_depth);
			portListIndt(m_moduleInstantiationIndt);
			//*(out) << "*";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) {

		std::string instanceName = (*CDOmIdentifier::cast(moduleInstance->getChild(0))->getName()); 

		if(m_moduleInstanceCnt == 0 && (m_moduleInstantiationParamNo == 0 ||
										CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN == m_moduleInstantiationType)) {
			//   *(fileTemp) << "new " << *m_moduleInstantiationName; //-------OB fileTemp comm

			//-----OB added---start

			// set the name of the module which has instances
			RefString instModName = RefString(new std::string(*m_moduleInstantiationName));
			// add instances to the object in the current unit
			instName = RefString(new std::string(instanceName));

			RefString rs = RefString(new std::string(""));
			getHID(rs);

			if(unitNI.get()) {
				unitNI->addInstance(instName);
			}

			// test to see if previous units have been instantiated in the current unit
			CUnitInstances_iter itt;
			for(itt = (unitInst->getUnitObjs())->begin(); itt != (unitInst->getUnitObjs())->end(); itt++) {
			  // if a previously declared unit (unitZ) is instantiated in the current unit (unitY), all the instances in the previous unit must receive the name of the instance (unitZ has the instance z, then an instance from unitZ, reg_x_y_z must become z.reg_x_y_z)

			//cout<< "inst:" << *((*itt)->getUnitName()) << ":" << *instModName << ":" << *instName << endl;
			  if((*(*itt)->getUnitName()) == *instModName) {

			   //cout<< "inst:" << *((*itt)->getUnitName()) << ":" << *instModName << ":" << *instName << endl;
		  	   (*itt)->addUnitInstance(instName);
			    refString_iter it;

			    //for(it = (itt->getInstanceNames())->begin(); it != (itt->getInstanceNames())->end(); it++) {
			      //it = RefString(new std::string(*instanceName + "." + *it)); //?????
			    //}
			  }
			}

			//----end

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


		if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
		  //RefTMap_RefString_RefCDOmExpr explicitPortNameMap = moduleInstance->getExplicitPortMap(); //-----OB comm
		  explicitPortNameMap = moduleInstance->getExplicitPortMap();
		  
		  
		  if(explicitPortNameMap.get()) {
		    TMap_RefString_RefCDOmExpr_constIter iter = explicitPortNameMap->begin();
		    
		    TList_RefString_const_iter iter_list1; //--------OB added
		    TList_RefString_const_iter iter_list2; //--------OB added
		    
		    m_isExprActual = FALSE; // no expressions with numbers as actuals 
		    m_exprSigPortActual = FALSE; // no expressions with sigs/ports as actuals 
		    m_assignStmt = FALSE; // no assign statements, this is f2a's


		    if(m_moduleInstanceCnt == 0) { 
		      if(iter->second.get()) {
			
			//-----OB added----start
			
			
			// check if there is an actual or if the actual is a number
			if((iter->second)->getChildrenSize() > 0 || (iter->second)->getExprType() == CDOmExpr::EXPR_NUMBER ) { 
			  
			  RefString instName = RefString(new std::string(instanceName));
				
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
			  
			  //-----OB added----start
			  
			  // check if there is an actual or if the actual is a number or if the actual is a range expression
			  if((iter->second)->getChildrenSize() > 0 || (iter->second)->getExprType() == CDOmExpr::EXPR_NUMBER) { //has range --- OB added 2nd condition
	      
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
					//indtFile(m_depth+2, fileTemp);
					
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

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {} 

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ){
		m_paramOverrideCnt++;
		//The following could be done by retrieving the current child and calling getExprType() on it, however
		//this method may be simpler since it does not create any new objects and the Verilog syntax is fixed 
		//in this case: if the current child is in an odd position it's the hid, if it's on en even position, 
		//it's the minTypMax expression (Note: counting starts at 1, because counter is incremented before evaluation)
		if(m_paramOverrideCnt % 2 == 1){
			//*(out) << " = ";
		}else if (m_paramOverrideCnt % 2 == 0 && 
				  m_paramOverrideCnt < m_paramOverrideSize ){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ){
		m_minTypMaxCnt++;
		if((m_minTypMaxCnt == 1 || 
			m_minTypMaxCnt == 2) && 
		   m_minTypMaxChildren > 1){
			//*(out) << ":";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmDelay                           & delay                       ){
		m_delayPos++;
		//if(delay->getDelayType() == CDOmDelay::DELAY_2 || delay->getDelayType() == CDOmDelay::DELAY_3){
		if(m_delayHasParanths){
			if(m_delayPos < m_delaySize){
				//*(out) << ", ";
			}
		}
		/*
		  if( delay->getDelayType() == 0 && m_delayPos == 1 ){
		  //*(out) << ",";
		  } else if(delay->getDelayType() == 1 && (m_delayPos == 1 || m_delayPos == 2) ){
		  //*(out) << ",";
		  }
		*/
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmAssn                            & assn                        ){
		m_assnPos++;
		if(m_assnPos == 1){
			//*(out) << " = ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ){
		m_contAssnPos++;
		//  if(m_contAssnPos > 0 && m_contAssnPos < m_contAssnSize){
		//    *(out) << ", ";
		//  }
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ){
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) {
		m_stmtBlockCnt++; 
		if(CDOmStmtBlock::BLOCK_PARALLEL == stmtBlock->getBlockType()) {
			m_depth--;
			indtFile(m_depth, out);
			//(*out) << "}\n";
			m_depth--;
			if(m_stmtBlockCnt < m_stmtBlockSize) {
				//(*out) << "\n";
				indtFile(m_depth, out);
				//(*out) << "void nonblocking_" << m_designFuncIdNo << "() {\n";
				//(*fileTemp) << "SC_METHOD(nonblocking_" << m_designFuncIdNo << ");\n";
				m_designFuncIdNo++;
				indtFile(m_depth+2, fileTemp);
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

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ){
		m_stmtAssnPos++;
		if(m_stmtAssnPos == 1){
			if(stmtAssn->getAssnType() == CDOmStmtAssn::ASSN_BLOCKING){
				//*(out) << " = ";
			}
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ){
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

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){
		m_stmtPTCtrlPos++;
		//if(m_stmtPTCtrlPos == 1){
		//  *(out) << std::endl;
		//}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
		m_stmtCaseCnt++;
		if(m_stmtCaseCnt == 1){
			//*(out) << ") {" << std::endl;
			//indtFile(m_depth, out);
			//(*out) << "case ";
		}
		if( m_stmtCaseCnt > 1 && 
			m_stmtCaseCnt < m_stmtCaseSize ) {
			if(m_stmtCaseCnt % 2 == 0) {
				//*(out) << " : ";
			}
			else {
				//indtFile(m_depth+2, out);
				//(*out) << "break;\n";
				//indtFile(m_depth, out);
				//(*out) << "case ";
			}
		}
  
		if( m_stmtCaseDefault && 
			m_stmtCaseCnt == m_stmtCaseSize - 1){
			//// calling indenter function ////
			//indtFile(m_depth+2, out);
			//(*out) << "break;\n";
			indt(m_depth);
			//*(out) << "default : ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
		m_stmtIfCnt++;
		if(m_stmtIfHasAttrList && m_stmtIfCnt == 0){
			//*(out)  << " if(";
		}

		if(m_stmtIfCnt == 1 ){
			//*(out) << ") " /*<< std::endl*/;
		}
		if(m_stmtIfSize >= 3 && m_stmtIfCnt == 2){

			//// calling indenter function ////
			//// -1 because we want else at the same level of if, yet keep the indent depth for the rest ////
			indt(m_depth-1);

			//*(out) << "else ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
		m_stmtLoopCnt++;
		switch( m_stmtLoopType ) {
			//does not evaluate forever case as to avoid redundancy
		case( CDOmStmtLoop::LOOP_REPEAT ) :   
			{
				if(m_stmtLoopCnt == 1){
					//*(out) << " ) "; 
				}
				break;
			}
		case( CDOmStmtLoop::LOOP_WHILE ) :   
			{
				if(m_stmtLoopCnt == 1){
					//*(out) << " ) "; 
				}
				break;
			}
		case( CDOmStmtLoop::LOOP_FOR     )                            :
			{
				// switch
				break;
			}
			// default disabled due to above non evaluation of the forever case  :   *(out) << "/* codegen:: Unknown Loop Type */";          break;
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
		m_stmtTaskEnableCnt++;
		if(m_stmtTaskEnableSize > 1){
			if(m_stmtTaskEnableCnt == 1){
				//*(out) << "(";
			}else if(m_stmtTaskEnableCnt < m_stmtTaskEnableSize ){
				//*(out) << ", ";
			}else if(m_stmtTaskEnableCnt == m_stmtTaskEnableSize){
				//*(out) << ")";
			}
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
		m_stmtWaitCnt++;
		if(m_stmtWaitCnt == 1){
			//*(out) << ") ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
		m_rangeExprPos++;
		if(m_rangeExprPos == 1){
			m_partSelActual = TRUE; //--------OB added---part select is used in assign or f2a
			//cout<<"-------in inRangeExpr\n";
			if(TRUE == m_partSelActual) {
				// switch 
			}
			else {
				// switch
			}
		}
	}
	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
		m_exprConcatPos++;
		if(m_exprConcatSize > 1 && m_exprConcatPos < m_exprConcatSize){
			//*(out)<<",";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ){
		m_exprMultiConcatPos++;
		if(m_exprMultiConcatPos == 1){
			//*(out) << " ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                    ){
		m_udpcnt++;
		if(m_udpcnt == 1) {
			RefTVec_RefString portItems = udpDecl->getPortItemNames();
			//*(out) << " (" << *(*portItems->begin());
			//for(TVec_RefString_const_iter iter = portItems->begin()+1; iter < portItems->end(); ++iter)
				//*(out) << ", " << *(*iter);
			//*(out) << ");" << std::endl; 

		}
	}


	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput          ){
	}


	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput          ){
		m_udpPdInputCnt++;
		if(m_udpPdInputCnt > 0 && 
		   m_udpPdInputCnt< m_portIdSize && 
		   m_portIdSize != 1){
			//*(out) << ", ";
		}
	}


	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry              ){
		m_combEntryCnt++;
		RefTVec_ECDOmUdpSymbol levelInputList = udpCombEntry->getInputList();
		ECDOmUdpSymbol outputSymbol = udpCombEntry->getOutputSymbol();

		indt(IND2);
		if(m_combEntryCnt == 1) indt(IND2);
		for(TVec_ECDOmUdpSymbol_const_iter iter = levelInputList->begin(); iter < levelInputList->end(); ++iter) {
			// switch
		}

		// switch
	}


	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry               ) {
		m_seqEntryCnt++;
		indt(IND2);
		if(m_seqEntryCnt == 1) indt(IND2);

		if(udpSeqEntry->hasLevelInputList()) {
			RefTVec_ECDOmUdpSymbol levelInputList =  udpSeqEntry->getLevelInputList();
			if(levelInputList.get()) {
				for(TVec_ECDOmUdpSymbol_const_iter iter = levelInputList->begin(); iter < levelInputList->end(); ++iter) {
					// switch
				}
			}
		}
		else {
			RefTVec_ECDOmUdpSymbol levelSymbolList1 = udpSeqEntry->getLevelSymbolList1();
			RefTVec_ECDOmUdpSymbol levelSymbolList2 = udpSeqEntry->getLevelSymbolList2();
  
			if(levelSymbolList1.get()) {
				for (TVec_ECDOmUdpSymbol_const_iter iter = levelSymbolList1->begin(); iter < levelSymbolList1->end(); ++iter) {
					// switch
				}
			}
			if(udpSeqEntry->hasEdgeSymbol()) {
				// switch  
			}
			else {
				ECDOmUdpSymbol edgeIndicator1 = udpSeqEntry->getEdgeIndicator1();
				ECDOmUdpSymbol edgeIndicator2 = udpSeqEntry->getEdgeIndicator2();
				if(edgeIndicator1 != UDP_SYMBOL_UNDEF && edgeIndicator2 != UDP_SYMBOL_UNDEF) {
					// switch
					
					// switch
				}
			}
			if(levelSymbolList2.get()) {
				for (TVec_ECDOmUdpSymbol_const_iter iter = levelSymbolList2->begin(); iter < levelSymbolList2->end(); ++iter) {
					// switch
				}
			}
		}

		ECDOmUdpSymbol currentState = udpSeqEntry->getCurrState();
		ECDOmUdpSymbol nextState = udpSeqEntry->getNextState(); 

		// switch

		// switch
	}


	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt               ) {
		if(m_udpOutPortName.get()) {
			//*(out) << *m_udpOutPortName << " = ";
			// switch
		}
		//else *(out) << "Undeclared output port" << std::endl;
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        ) {
		++m_taskDeclCnt;
		if(taskDecl->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITH_TASK_PORT_LIST) {
			//if(m_taskDeclCnt == 1) *(out) << " (";
			//else if(m_taskDeclCnt-1 == m_taskDeclPortItemSize) {
				//*(out) << ");" << std::endl;
			//}
			//else if(m_taskDeclCnt-1 < m_taskDeclPortItemSize) {
				//*(out) << ", ";
			//}
		} 
		else if(m_taskDeclCnt == 1) {
			//*(out) << ";" << std::endl;
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                       ) {
		++m_tfPortDeclCnt;
		//if(m_tfPortDeclCnt > 0 && m_tfPortDeclCnt < m_tfPortDeclSize)
			//*(out) << ", ";
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
		m_funcDeclCnt++;
		if(m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE || 
		   m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE || 
		   m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST) {
			//if(m_funcDeclCnt == 1) *(out) << " (";
			//else if(m_funcDeclCnt == 2) *(out) << ");" << std::endl; 
		}
		else if(m_funcDeclCnt == 1) {
			//*(out) << ";" << std::endl;
			indt(IND2);
		}
		if(m_funcDeclCnt > 1 && 
		   m_funcDeclCnt < funcDecl->getChildrenSize()) 
			indt(IND2);
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmFunctionCall                        & functionCall                    ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmGenvarDecl                          & genvarDecl                      ){
		m_genvarDeclCnt++;
		if(m_genvarDeclCnt < m_genvarDeclSize){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmGenInst                             & genInst                         ){
		//indt(IND1);
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmGenItemNull                         & genItemNull                     ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmGenItemIf                           & genItemIf                       ){
		m_genItemIfCnt++;
		if(m_genItemIfCnt == 1){
			//*(out) << ")" << std::endl;
			indt(IND1);
		}else if (m_genItemIfCnt == 2 && m_genItemIfSize == 3){
			//*(out) << "else" << std::endl;
			indt(IND1);
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmGenItemCase                         & genItemCase                     ){
		m_genItemCaseCnt++;
		if(m_genItemCaseCnt == 1){
			//*(out) << " )" << std::endl;
		}
		if( m_genItemCaseCnt > 1 && 
			m_genItemCaseCnt % 2 == 0 && 
			m_genItemCaseCnt < m_genItemCaseSize ){ //checking for even position in children vector (expressionLists)
			//*(out) << " : ";
			//check the logic below - it may be optimised away
		} else if ( m_genItemCaseCnt > 1 && m_genItemCaseCnt % 2 != 0 ) { //checking for odd position in children vector (statements)
			//*(out) << std::endl;
			if( m_genItemCaseDefault && m_genItemCaseCnt == m_genItemCaseSize - 1){
				//*(out) << "default : ";
			}
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmGenItemLoop                         & genItemLoop                     ){
		m_genItemLoopCnt++;
		// switch
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmGenItemBlock                        & genItemBlock                    ){
		m_genItemBlockCnt++;
		if(m_genItemBlockCnt == 0){
			//*(out) << std::endl;
		}
		if(m_genItemBlockCnt < m_genItemBlockSize){
			indt(IND3);
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmString                              & stringObj                       ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmEventDecl                           & eventDecl                       ){
		m_eventDeclCnt++;
		if(m_eventDeclCnt < m_eventDeclSize){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmSpecifyBlock                        & specifyBlock                     ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl       & pulseSSCd                        ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmPathDecl                            & pathDecl                         ){
		m_pathDeclCnt++;
		if(m_pathDeclIsSimple || 
		   m_pathDeclIsStateSimpleIfNone){
			if(m_pathDeclCnt == 1 && 
			   m_pathDeclhasPolarityOp){
				if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
					//*(out) << " +";
				}else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
					//*(out) << " -";
				}
			}
			if(m_pathDeclCnt == 1){
				if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
					//*(out) << " => ";
				}else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
					//*(out) << " *> ";
				}
			}
			if(m_pathDeclCnt == 2){
				//*(out) << " ) = ";
			}
		}
		if(m_pathDeclIsEdge){
			if(m_pathDeclCnt == 1){
				if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
					//*(out) << " => ( ";
				}else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
					*(out) << " *> ( ";
				}
			}
			if(m_pathDeclCnt == 2){
				if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
					//*(out) << " +";
				}else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
					//*(out) << " -";
				}
				//*(out) << " : ";
			}
			if(m_pathDeclCnt == 3){
				//*(out) << " )) = ";
			}
		}
		if(m_pathDeclIsStateSimpleIf){
			if(m_pathDeclCnt == 1){
				///*(out) << " )( ";
			}
			if(m_pathDeclCnt == 2 && 
			   m_pathDeclhasPolarityOp){
				if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
					//*(out) << " +";
				}else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
					//*(out) << " -";
				}
			}
			if(m_pathDeclCnt == 2){
				if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
					//*(out) << " => ";
				}else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
					//*(out) << " *> ";
				}
			}
			if(m_pathDeclCnt == 3){
				///*(out) << " ) = ";
			}
		}
		if(m_pathDeclIsStateEdgeIf){
			if(m_pathDeclCnt == 1){
				//*(out) << " )( ";
			}
			if(m_pathDeclCnt == 2){
				if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
					//*(out) << " => ( ";
				}else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
					//*(out) << " *> ( ";
				}
			}
			if(m_pathDeclCnt == 3){
				if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
					//*(out) << " +";
				}else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
					//*(out) << " -";
				}
				//*(out) << " : ";
			}
			if(m_pathDeclCnt == 4){
				//*(out) << " )) = ";
			}
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmPathDelayValue                      & pathDelayValue                   ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmMinTypMaxList                       & minTypMaxList                    ){
		m_minTypMaxListCnt++;
		if(m_minTypMaxListCnt < m_minTypMaxListSize){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
		m_specifyTListCnt++;
		if(m_specifyTListCnt < m_specifyTListSize){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmDelayedDataOrReference              & delayedDataOrRef                 ){
		m_delayedDataOrRefCnt++;
		if(m_delayedDataOrRefCnt == 1 && 
		   m_delayedDataOrRefSize > 1){
			//*(out) << "[ ";
		}
		if(m_delayedDataOrRefCnt == 2){
			//*(out) << " ]";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                ){}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmTimingCheckEvent                    & timingCkEvent                    ){
		m_timingCheckEventCnt++;
		if(m_timingCheckEventCnt == 1 && 
		   timingCkEvent->hasTimingCheckCondition()){
			//*(out) << " &&& ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmSystemTimingCheck                   & systemTimingCk                   ){
		m_systemTimingCkCnt++;
		if(m_systemTimingCkCnt < m_systemTimingCkSize){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmGateInstantiation                   & gateInstantiation                ){
		m_gateInstanceCnt++;
		if(m_gateInstanceCnt < m_gateInstanceSize){
			if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_EXPR && 
			   m_gateInstanceFlag){
				//*(out) << ", ";
			}
			if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_EXPR && 
			   !m_gateInstanceFlag){
				//*(out) << "( ";
				m_gateInstanceFlag = true;
			}
			if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_ID_SCOPE_INDIRECT && 
			   m_gateInstanceCnt > 2){
				//*(out) << "), ";
				m_gateInstanceFlag = false;
			}
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmPulseControl                        & pulseControl                     ){
		m_pulseControlCnt++;
		//if(m_pulseControlLong){
			// switch
			//}

		//}else{
			//if(m_pulseControlCnt < m_pulseControlSize){
				//*(out) << ", ";
			//}
		//}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmAttrList                       & attrList                  ){
		m_attrListCnt++;
		if(m_attrListCnt < m_attrListSize){
			//*(out) << ", ";
		}
	}

	void CSchematicCodeGenerator::inTraversal(const NSCdom::RefCDOmDefine                         & define                   ){}


	//********************************************************************************//
	//                    After traversal block                                       // 
	//********************************************************************************//

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmInclude                       & fileInclude                 ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmDesign                        & design                      ){
		//----------OB added----start
		out = fileCpp;
		// adding main body
		///*(out) <<  "int sc_main (int argc , char *argv[]) {" << std::endl;
		///*(out) << std::endl;
		///*(out) << " return 0;" << std::endl << "}" << std::endl;

		// iterate through the vector with CUnitInstances objects and write the units and their instances
		CUnitInstances_rIter itr;
		refString_iter it;
  		int i;
		if(unitInst->getUnitObjs()) {	
		  *(out) << std::endl;
		  for(itr = (unitInst->getUnitObjs())->rbegin(), i = 1; itr != (unitInst->getUnitObjs())->rend(); itr++, i++) {
		  //for(it = ((*itr)->getInstanceNames())->begin(); it != ((*itr)->getInstanceNames())->end(); it++) {
		    // write instances
		    //*(out) << "load inst " << *it << " "; //????
		  //}
		  // write unit
		  *(out) << "  load inst ";

		  if(i == 1) {
			topUnitInst = RefString(new std::string(*((*itr)->getUnitName()) + "_inst"));
			*(out) << *topUnitInst << " ";
		  }

		    refString_iter itt1, itt2;
			if((*itr)->getInstanceNames()) {
			  for(itt2 = ((*itr)->getInstanceNames())->begin(); itt2 != ((*itr)->getInstanceNames())->end(); itt2++) {
				//*(out) << "." << *(*itt2);
				*(*itt2) = std::string(*topUnitInst + "." + *(*itt2));
				//cout<< "!!unit:" << *((*itr)->getUnitName()) << " inst:" << *(*itt2) << endl;
			  }
			}


		  *(out) << " " << *((*itr)->getUnitName()) << " v" << std::endl;

		    //cout<< "write unit:" << *((*itr)->getUnitName()) << std::endl;
		  }
		}

		if(unitInst) {	
			unitInst.reset();
		}

		*(out) << std::endl << std::endl;
		*(out) << "loadhier . " << std::endl;
		*(out) << "show" << std::endl;

		delete fileCpp; 
		//------------end

	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmModuleDecl                    & moduleDecl                  ){

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
 
		///std::remove((m_ctorFileName + *m_currentModuleName + ".temp").c_str()); // deleting temporary file  //-------OB added <+ *m_current....>
 
		//-----OB added----start

		if(unitNI) {
			unitNI.reset();
		}
		

		m_depth--;

		}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmIdentifier                    & id                          ){
		if(m_idPrintSemi) {
			//(*out) << ";" << std::endl;
		}
		//  out = fileCpp; //----OB commented
		//out = fileH; //----OB added

	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmPortItem                      & portItem                    ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmExprLink                      & exprLink                    ) {
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmExprOp                        & exprOp                      ){
	  //cout<<"----------afterTraversal(const NSCdom::RefCDOmExprOp begin" << endl;

		RefCDOmBase parent = exprOp->getParent();
		if(parent.get() && parent->getType() == TYPE_EXPR){
			if(CDOmExpr::cast(parent)->getExprType() == CDOmExpr::EXPR_MINTYPMAX && 
			   m_designGenCode){
			  //*(out) << ")";
			}
		} 
		m_exprCnt.pop_back();
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmListExpr                      & listExpr                    ){
		if(m_listExprHasFunctionCallParent){
			//*(out) << ")";
		}else if(m_listExprHasExprLinkParent){
			//*(out) << "]";
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmPortDecl                      & portDecl                    ){
	  ///*(out) << ";" << std::endl;
	  if(portDecl->getRange().get()) {
	    switch (portDecl->getPortType()){
	    case (PORT_INOUT)  :  *(out) << " "                              ;      break;
	    case (PORT_INPUT)  :  *(out) << "in \\ " << std::endl             ;      break;
	    case (PORT_OUTPUT) :  *(out) << "out \\ " << std::endl            ;      break;
	    default            :  *(out) << "/*Error in port direction*/" << std::endl ;      break;
	    }
	  }
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmVarDecl                       & varDecl                     ){
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmNetDecl                       & netDecl                     ){
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmRange                         & range                       ){
		if(TRUE == m_designGenCode) {
			if(m_rangeAsWidth) {
				//if(m_rangeGenExpr) {
				//*(out) << "+1";
				//}
				//      (*out) << "+1"; //------OB commented

				//      std::cerr << "range parent type is: " << range->getParent()->getType() << std::endl;
				if(range->getParent()->getType() == TYPE_RANGE_LIST) {
					//*(out) << "]";
				}
				else {
					//*(out) << "> > ";
				}
				m_rangeGenExpr = TRUE;
			}
			else {
				//*(fileTemp) << ")";
			}
		}
		m_showRange = TRUE; //----OB added
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmNum32                         & num                         ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmReal                          & realNum                     ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation      & moduleInstantiation         ){
		// *(out) << ";" << std::endl; //---OB new comm
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstance           & moduleInstance              ) {
		if(m_moduleInstanceCloseParen) {
			// *(fileTemp) << ");" << std::endl; //---OB fileTemp comm

			//----OB added---start

	
			TMap_RefString_RefCDOmExpr_constIter iter;

			if(explicitPortNameMap.get()) {
				//F2As->addFormalActualExpr(explicitPortNameMap);

     
				// this is only to print the expressions
				for(iter = explicitPortNameMap->begin(); iter != explicitPortNameMap->end(); iter++) {
					//cout<<"!!!!!!!!!map:" << *(iter->first) << "---";
				}
				//cout<<endl;
				explicitPortNameMap.reset();
			}


			//out = fileH; 
			//------end

			//    out = fileCpp; //------OB commentedgetExprsOutputActuals
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmParamDeclCollection           & paramDeclCollection         ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmParamDecl                     & paramDecl                   ) {
		if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE) {
			m_designGenCode = TRUE;
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmParamOverride                 & paramOverride               ){
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmMinTypMax                     & minTypMax                   ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmDelay                         & delay                       ){
		if(m_delayHasParanths){
			//if(delay->getDelayType() == 0 || delay->getDelayType() == 1){
			//*(out) << ")";
		}
		//*(out) << " ";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmInitOrAlways                  & initOrAlways                ){ 

		if(m_stmtNonBlockingVec.get()) {
			TVec_RefCDOmStmt_const_iter iter = m_stmtNonBlockingVec->begin();
			for(; iter != m_stmtNonBlockingVec->end(); ++iter) {
				// writing function definition
				//(*out) << "\n";
				indtFile(IND1, out);
				//(*out) << "void nonblocking_" << m_designFuncIdNo << "() {\n";
				m_depth++;
				indtFile(m_depth, out);
				//parseExpr(CDOmStmtAssn::cast(*iter)->getLvalue(), out);
				//(*out) << " = ";
				//parseExpr(CDOmStmtAssn::cast(*iter)->getExpr(), out);
				//(*out) << ";\n";
				m_depth--;
				indtFile(m_depth, out);
				//(*out) << "}\n";
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

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmAssn                          & assn                        ) { 
		//(*out) << ";\n";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmContAssn                      & contAssn                    ){
		--m_depth;
		// out = fileCpp; //-------OB commented
		//out = fileH; //--------OB added
		//(*out) << "\n";
		indt(m_depth);
		//(*out) << "}\n\n";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmt                          & stmt                        ){
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtBlock                     & stmtBlock                   ) {
		//// calling indenter function ////
		indt(m_depth - 1);

		if(CDOmStmtBlock::BLOCK_SEQUENTIAL == stmtBlock->getBlockType()) {
			//(*out) << "}\n";
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtAssn                       & stmtAssn                    ){
		if(CDOmStmtAssn::ASSN_NON_BLOCKING != stmtAssn->getAssnType()) {
			//(*out) << ";" << std::endl;
		}
		else {
			m_designGenCode = TRUE;
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmEventControl                   & eventCtrl                   ){
		//    if( m_eventCtrlType == CDOmEventControl::EVENT_CONTROL_EVENT_EXPR ){
		//      *(out) << " ) " /*<< std::endl*/;
		//    }else{
		//      *(out) /*<< std::endl*/;
		//    }
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmEventExpr                      & eventExpr                   ){
		m_eventExprCnt.pop_back();
		//eventExprtype reset
		m_eventExprType = -1;
		m_designGenCode = TRUE;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){
		if(delayCtrl->getDelayControlType() == CDOmDelayControl::DELAY_CONTROL_MINTYPMAX){
			//*(out) << "  )";
		}
		//*(out) << ");\n";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
		//// exiting depth ////
		m_depth--;
		//// calling indenter function ////
		indt(m_depth);

		//*(out) << "}" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
		//// exiting depth ////
		m_depth--;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
		//// exiting depth ////
		m_depth--;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
		//*(out) << ";";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){
		///*(out) << ";";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
		if(TRUE == m_partSelActual) {
			(fileSig) << ")";
			m_partSelActual = FALSE;
		}
		else {
			//(*out) << ")";
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
		//*(out) << ")";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) {
		//*(out) << ")";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) {
		//*(out) << "endprimitive"<< std::endl << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) {
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) {
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) {
		//*(out) << " ;" << std::endl;
		if(m_combEntryCnt == m_combEntrySize) {
			indt(IND2);
			//*(out) << "endtable" << std::endl;
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) {
		//*(out) << " ;" << std::endl;
		if(m_seqEntryCnt == m_seqEntrySize) {
			indt(IND2);
			//*(out) << "endtable" << std::endl;
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) {
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ){
		//*(out) << "endtask" <<std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) {
		//RefCDOmBase parent = tfPortDecl->getParent();
		
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
		//*(out) << "endfunction" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) {}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) {
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ){
		//*(out) << "endgenerate" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ){
		//*(out) << "endcase" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ){
		//*(out) << "end" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmString                          & stringObj                   ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ){
		//(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ){
		//// exiting depth ////
		m_depth--;
		//// calling indenter function ////
		indt(m_depth);

		//*(out) << "endspecify" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                  ){
		//*(out) << ";" <<std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                   ){
		//*(out) << ";" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue             ){
		if(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITH_PAREN){
			//*(out) << " )";
		}
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList              ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList        ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef           ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl          ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent              ){}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk             ){
		//*(out) << " );" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation          ){
		//*(out) << ");" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl               ){
		//*(out) << " );" << std::endl;
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmAttrList                        & attrList                   ){
		//*(out) << " *)";
	}

	void CSchematicCodeGenerator::afterTraversal(const NSCdom::RefCDOmDefine                          & define                     ){}

}

