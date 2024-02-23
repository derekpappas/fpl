#include "CSLOM_GUI_XML_generator.h"

using namespace NSCSLOm;

namespace NSCSLOmGuiXmlGenerator{

CSLOmGuiXmlGenerator::CSLOmGuiXmlGenerator(std::string fileName) :
  m_fileName(fileName){

  std::string nameDesign = fileName;
  nameDesign.append("output.xml");
  out = new std::ofstream(nameDesign.c_str());

}

CSLOmGuiXmlGenerator::~CSLOmGuiXmlGenerator(){
  delete out;
}

  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) {};

  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmDesign  & design ) {
 
    std::cout << "gui xml gen design\n";
    //(*m_design) << "<?xml version = \"1.0\" ?>" <<std::endl;
    //(*m_design) << "<?xml-stylesheet type=\"text/xsl\" href=\"output.xsl\"?>" <<std::endl;
    //(*m_design) << "<design>" << std::endl;


    (*out) << "<CSL>" << std::endl;
  
  }

  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {

    /*
    if((id->getParent())->getType() == TYPE_CONNECTABLE){
      if((id->getParent())->isInterface()){
        std::cout << "ifc:" << (*id->getName()) << std::endl;
      }
      }*/
    
  };
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {

    // current unit name
    crUnitName = CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName();

    // vector with interface instances
    if(!ifcInstVec.get()) {
      ifcInstVec = RefTVec_RefString(new TVec_RefString); 
    }

    // map with interface instances for each unit
    if(!ifcInstMap.get()) {
      ifcInstMap = RefTMap_RefString_RefTVec(new TMap_RefString_RefTVec());  
    }
     

    (*out) << "    <Unit>\n";
    (*out) << "        <Name>" << *CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName() << "</Name>\n";

    /*
    if((unitDecl->getDefaultInterface())->getInterfaceName()) {
      (*out) << "    <Interface>\n";
      (*out) << "        <Name>" << *(unitDecl->getDefaultInterface())->getInterfaceName() << "</Name>\n";
      }*/

    };
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {

    // interface definition
    
    //(*out) << "    <Interface>\n";
    //*(out) << "        <Name>" << *(interface->getInterfaceClassName()) << "</Name>\n";
    



    // managing interface instances
    if(!interface->isDefaultIfc() && ifcInstVec.get() && (interface->getInterfaceName()).get()) {
      std::cout << "adding ifc inst to vec:" << *(interface->getInterfaceName()) << std::endl;
      ifcInstVec->push_back(interface->getInterfaceName());
      
    }

    if(!interface->isDefaultIfc() && ifcInstMap.get() && ifcInstVec.get() && interface->getInterfaceClassName()) {

      std::cout << "adding ifc and ifc inst to map\n";
      ifcInstMap->insert(make_pair(interface->getInterfaceClassName(), ifcInstVec));

    }

    //(*out) << "    <Interface>\n";
    //(*out) << "        <Name>" << *interface->getInterfaceName() << "</Name>\n";
    //std::cout << "ifc decl:" << *CSLOmIdentifier::cast(interface->getChild(ID))->getName() << std::endl;

  };
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
    //(*out) << "        <Port>\n";
    //(*out) << "            <Name>" << *(portDecl->getName()) << "</Name>\n";
    ECSLOmPortDirection portDir = portDecl->getPortDirection();
    ECSLOmSignalType portType = portDecl->getPortType();

  };
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {};  
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {};    
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {};
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {};   
  void CSLOmGuiXmlGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {};
    
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmInclude                             & fileInclude                     ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmDesign                              & design                          ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmIdentifier                          & id                              ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmExprLink                            & exprLink                        ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitDecl                            & unitDecl                        ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmSignal                              & signal                          ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInstance                        & unitInst                        ) {
    RefCSLOmBase parentBase = unitInst->getParent()->getParent();
    RefCSLOmUnitDecl parent=CSLOmUnitDecl::cast(parentBase);
    RefTMap_RefCSLOmExprLink_RefCSLOmExpr mapNames = unitInst->getConnectionMap();

    (*out) << "        <UnitInstance>\n";
    (*out) << "            <Type>" << *CSLOmIdentifier::cast(unitInst->getUnitDecl()->getChild(ID))->getName() << "</Type>" << std::endl;
    (*out) << "            <Name>" << *CSLOmIdentifier::cast(unitInst->getChild(ID))->getName() << "</Name>" << std::endl;
    (*out) << "        </UnitInstance>\n";
 
    for(TMap_RefCSLOmExprLink_RefCSLOmExpr::const_iterator it = mapNames->begin(); it != mapNames->end(); ++it) {
      //(*out) << "<f2a formal = \"" << *convertLink(it->first);
      //(*out) << "\" actual = \"" << *CSLOmIdentifier::cast(unitInst->getUnitDecl()->getChild(ID))->getName() << std::endl;
      //it->second->acceptVisitor(*this);
      //(*out) << "\" />" << std::endl;
    }
};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                      & simpleBitRange                  ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                    & multiDimBitRange                ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmGroupSignal                         & groupSignal                     ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmNum32                               & number                          ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmVeriNum                             & veriNum                         ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmInterface                           & interface                       ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation                   & unitInstantiation               ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmPortDecl                            & portDecl                        ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmExprOp                              & exprOp                          ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmExprConcat                          & exprConcat                      ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                     & exprMultiConcat                 ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmList                                & list                            ) {};  
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmParameter                           & parameter                       ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmListExpr                            & listExpr                        ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall                & exprHybridOrFuncCall            ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature                   & exprFuncSignature               ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmEnum                                & enumeration                     ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmField                               & field                           ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMap                           & memoryMap                       ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmAddressRange                        & addressRange                    ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation                   & memoryMapLocation               ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                       & memoryMapPage                   ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance               & memoryMapPageInstance           ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmContainer                           & container                       ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaField                            & isaField                        ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaElement                          & isaElement                      ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInfo                            & unitInfo                        ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmStmtAssign                          & stmtAssign                      ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                          & memInfo                         ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmFifoInfo                            & fifoInfo                        ) {};    
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                    & regFileInfo                     ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                         & regInfo                         ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmTBInfo                              & tbInfo                          ) {};
  void CSLOmGuiXmlGenerator::inTraversal(const NSCSLOm::RefCSLOmVectorInfo                          & vectorInfo                      ) {};

  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmInclude                          & fileInclude                     ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmDesign                           & design                          ) {


    TMap_RefStrRefTVec_it map_iter;
    TVec_RefStr_it vec_iter;

    
    
    

    if(ifcInstMap.get()) {
      for(map_iter = ifcInstMap->begin(); map_iter != ifcInstMap->end(); map_iter++) {
        //std::cout << "ifc name:" << *map_iter->first;
        // interface definition
        (*out) << "    <Interface>\n";
        (*out) << "        <Name>" << *map_iter->first << "</Name>\n";
        
        // add ports to interface

        //close interface
        (*out) << "    </Interface>\n";
        for(vec_iter = map_iter->second->begin(); vec_iter != map_iter->second->end(); vec_iter++) 
          std::cout << "ifc inst:" << **vec_iter << "  ";
          //std::cout << std::endl;
        
      }
    }

    (*out) << "</CSL>" << std::endl;

    if(ifcInstMap.get()) {
      ifcInstMap.reset();
    }


  };
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmIdentifier                       & id                              ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprLink                         & exprLink                        ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                         & unitDecl                        ) {

    (*out) << "    </Unit>\n";

  };
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmSignal                           & signal                          ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                     & unitInst                        ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                   & simpleBitRange                  ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                 & multiDimBitRange                ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                      & groupSignal                     ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmNum32                            & number                          ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmVeriNum                          & veriNum                         ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmInterface                        & interface                       ) {

    //(*out) << "    </Interface>\n";
  };
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation                & unitInstantiation               ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmPortDecl                         & portDecl                        ) {
    //(*out) << "        </Port>\n";

};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprOp                           & exprOp                          ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprConcat                       & exprConcat                      ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                  & exprMultiConcat                 ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmList                             & list                            ) {};  
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmParameter                        & parameter                       ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmListExpr                         & listExpr                        ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall             & exprHybridOrFuncCall            ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature                & exprFuncSignature               ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmEnum                             & enumeration                     ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmField                            & field                           ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                        & memoryMap                       ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmAddressRange                     & addressRange                    ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation                & memoryMapLocation               ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                    & memoryMapPage                   ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance            & memoryMapPageInstance           ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmContainer                        & container                       ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaField                         & isaField                        ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaElement                       & isaElement                      ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                         & unitInfo                        ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                       & stmtAssign                      ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                       & memInfo                         ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                         & fifoInfo                        ) {};    
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                 & regFileInfo                     ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                      & regInfo                         ) {};
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmTBInfo                           & tbInfo                          ) {};    
  void CSLOmGuiXmlGenerator::afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                       & vectorInfo                      ) {};
  








} // end of namespace
