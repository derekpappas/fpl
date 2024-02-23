//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007, 2008 Fastpath Logic
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

// Author BogdanZ

#include "CSLOM.h"
#include "CSLOM_Visitor.h"
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include <algorithm>
#include <iterator>
#include <sstream>
#include <cstdlib>
#include <cmath>
#include "../support/CommonSupport.h"

/**
 * Bit that tells the cslc if errors appeared in the CSLOM
 */
extern TBool cslomHasErrors;


namespace NSCSLOm {

// ********************************************************************************
// CSLOmMemoryMapLocation class
// ********************************************************************************
CSLOmMemoryMapLocation::CSLOmMemoryMapLocation(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase addressableObject) : 
  CSLOmBase(TYPE_MEMORY_MAP_LOCATION, lineNumber, fileName), 
  m_addressableObject(addressableObject),
  m_hasWidthOne(FALSE) {}

RefCSLOmMemoryMapLocation CSLOmMemoryMapLocation::cast(RefCSLOmBase object) {
  if(!object.get()){
    return RefCSLOmMemoryMapLocation();
  } 
  else {
    ASSERT(object->getType() == TYPE_MEMORY_MAP_LOCATION, "type check on cast failure");
    return boost::static_pointer_cast<CSLOmMemoryMapLocation>(object);
  }
}

RefCSLOmMemoryMapLocation CSLOmMemoryMapLocation::build(TLineNumberType               lineNumber       ,
                                                        RefString                     fileName         ,
                                                        RefCSLOmMemoryMapPage         parent           ,
                                                        const RefString&              symbol           ,
                                                        RefCSLOmBase                  addressableObject,
                                                        RefCSLOmAddressRange          localAddr        , 
                                                        RefCSLOmAddressRange          globalAddr        ) {
  ASSERT(parent           .get(), "received null parent           ");
  ASSERT(symbol           .get(), "received null symbol           ");
  ASSERT(!symbol       ->empty(), "received empty symbol          ");
  ASSERT(addressableObject.get(), "received null addressableObject");
  ASSERT(localAddr        .get(), "received null localAddr        ");
  ASSERT(globalAddr       .get(), "received null globalAddr       ");

  
  CSLOmMemoryMapLocation* memLocation;
  try {
    memLocation = new CSLOmMemoryMapLocation(lineNumber, fileName, addressableObject);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }
  RefCSLOmMemoryMapLocation refMemLocation(memLocation);
  memLocation->m_weakRef = boost::weak_ptr<CSLOmBase>( refMemLocation);
  memLocation->setParent(parent);
  memLocation->m_addressableObject = addressableObject;;

  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refMemLocation, CSLOmIdentifier::ID_MEMORY_MAP_LOCATION, symbol);
  
  ASSERT(id.get(),"the build function for ID returned NULL .. something is not right");

  if (CSLOmNumber::cast(localAddr->getWidth()->doEval())->getValue() == 1) {
    memLocation->m_hasWidthOne = TRUE;
  }
  RefCSLOmAddressRange localAddress = CSLOmAddressRange::build(localAddr->getLineNumber(), 
                                                               localAddr->getFileName(),
                                                               refMemLocation, 
                                                               localAddr->getLower(), 
                                                               localAddr->getUpper(), 
                                                               localAddr->getAddressRangeType());
  RefCSLOmAddressRange globalAddress = CSLOmAddressRange::build(globalAddr->getLineNumber(), 
                                                                globalAddr->getFileName(),
                                                                refMemLocation, 
                                                                globalAddr->getLower(), 
                                                                globalAddr->getUpper(), 
                                                                globalAddr->getAddressRangeType());

  localAddress->setOffset(localAddr->getOffset());
  globalAddress->setOffset(globalAddr->getOffset());

  return refMemLocation;
}

const RefCSLOmIdentifier CSLOmMemoryMapLocation::getSymbol() const {
  return CSLOmIdentifier::cast(getSymbolAsBase());
}

const RefCSLOmAddressRange CSLOmMemoryMapLocation::getGlobalAddress() const {
  return CSLOmAddressRange::cast(getGlobalAddrAsBase());
}

const RefCSLOmAddressRange CSLOmMemoryMapLocation::getLocalAddress() const {
  if(getChildrenSize() > MEM_MAP_LOC_LOCAL_ADDR) {
    ASSERT(getChild(MEM_MAP_LOC_LOCAL_ADDR).get(), "something is wrong");
    return CSLOmAddressRange::cast(getLocalAddrAsBase());
  }
  else {
    return RefCSLOmAddressRange();
  }
}

void CSLOmMemoryMapLocation::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


// ********************************************************************************
// CSLOmMemoryMapPage class
// ********************************************************************************

CSLOmMemoryMapPage::CSLOmMemoryMapPage(TLineNumberType lineNumber, RefString fileName/*, TUInt incAmount*/) : 
  CSLOmBase(TYPE_MEMORY_MAP_PAGE, lineNumber, fileName),
  m_map(new TMap_TUInt_RefCSLOmMemoryMapLocation),
  m_incAmount     (ZERO),
  m_currentAddress(ZERO),
  m_nextAddress   (ZERO),
  m_dataWordWidth (ZERO),
  m_alignment     (ZERO),
  m_symbolLength  (ZERO),
  m_lowerBound    (ZERO - ONE),
  m_upperBound    (ZERO),
  m_pageType      (MM_UNDEFINED),
  m_scope         (),
  m_unitName      (),
  m_prefix        (),
  m_suffix        () {
  m_isDefined = FALSE;
  m_addAddressRangePresent=FALSE;
}

RefCSLOmMemoryMapPage CSLOmMemoryMapPage::cast(RefCSLOmBase object){
  if(!object.get()){
    return RefCSLOmMemoryMapPage();
  }
  else {
    ASSERT(object->isMemoryMapLocationPage(), "type check cast on failure");
    return boost::static_pointer_cast<CSLOmMemoryMapPage>(object);
  }
}

RefCSLOmMemoryMapPage CSLOmMemoryMapPage::allocate(TLineNumberType      lineNumber,
                                                   RefString            fileName  ,
                                                   RefCSLOmDesign       parent    ,
                                                   const RefString&     name      ) {
  ASSERT(parent.get(), "received null parent");
  ASSERT(name.get(), "received null name");
  ASSERT(!name->empty(), "received empty name");

  CSLOmMemoryMapPage* memMapLocationPage;
  try {
    memMapLocationPage = new CSLOmMemoryMapPage(lineNumber, fileName/*, incAmount*/);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmMemoryMapPage refMemoryMapLocationPage(memMapLocationPage);
  memMapLocationPage->m_weakRef = boost::weak_ptr<CSLOmBase>( refMemoryMapLocationPage);
  memMapLocationPage->setParent(parent);


  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refMemoryMapLocationPage, CSLOmIdentifier::ID_MEM_MAP_PAGE, name);

  memMapLocationPage->m_scope = CSLOmScope::build(id);

  RefCSLOmContainer legalContainer = CSLOmContainer::build(refMemoryMapLocationPage->getLineNumber(),
                                                           refMemoryMapLocationPage->getFileName() ,
                                                           refMemoryMapLocationPage                 ,  
                                                           TYPE_ADDRESS_RANGE                       );

  RefCSLOmContainer reservedContainer = CSLOmContainer::build(refMemoryMapLocationPage->getLineNumber(),
                                                              refMemoryMapLocationPage->getFileName() ,
                                                              refMemoryMapLocationPage                 ,
                                                              TYPE_ADDRESS_RANGE                       );

  RefCSLOmContainer freeContainer = CSLOmContainer::build(refMemoryMapLocationPage->getLineNumber(),
                                                          refMemoryMapLocationPage->getFileName(),
                                                          refMemoryMapLocationPage                 ,
                                                          TYPE_ADDRESS_RANGE                       );
 
  RefCSLOmContainer accRightsContainer = CSLOmContainer::build(refMemoryMapLocationPage->getLineNumber(),
                                                               refMemoryMapLocationPage->getFileName(),
                                                               refMemoryMapLocationPage                 ,
                                                               TYPE_ADDRESS_RANGE                       );
  return refMemoryMapLocationPage;
}

RefCSLOmMemoryMapPage CSLOmMemoryMapPage::build(TLineNumberType      lineNumber, 
                                                RefString            fileName,
                                                RefCSLOmDesign       parent    ,
                                                const RefString&     name      ) {

  ASSERT(parent.get(), "received null parent");
  ASSERT(name.get(), "received null name");
  ASSERT(!name->empty(), "received empty name");

  return allocate(lineNumber, fileName, parent, name);
}

RefCSLOmMemoryMapPage CSLOmMemoryMapPage::build(TLineNumberType               lineNumber, 
                                                RefString                     fileName,
                                                RefCSLOmDesign                parent    ,
                                                const RefString&              name      ,
                                                RefCSLOmMemoryMapPage sourcePage) {

  ASSERT(parent.get(), "received null parent");
  ASSERT(name.get(), "received null name");
  ASSERT(!name->empty(), "received empty name");
  ASSERT(sourcePage.get(), "received null parent");

  RefCSLOmMemoryMapPage page = allocate(lineNumber, fileName, parent, name);

  RefTVec_RefCSLOmAddressRange legalRanges = sourcePage->getChild(MEM_MAP_LOC_PAGE_LEGAL)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
  for (TVec_RefCSLOmAddressRange::iterator it = legalRanges->begin(); it < legalRanges->end(); ++it) {
    page->addAddressRange(CSLOmNumber::cast((*it)->getLower()->doEval()),CSLOmNumber::cast((*it)->getUpper()->doEval()));
  }

  RefTVec_RefCSLOmAddressRange reservedRanges = sourcePage->getChild(MEM_MAP_LOC_PAGE_RESERVED)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
  for (TVec_RefCSLOmAddressRange::iterator it = reservedRanges->begin(); it < reservedRanges->end(); ++it) {
    page->addReservedRange(CSLOmNumber::cast((*it)->getLower()->doEval()),CSLOmNumber::cast((*it)->getUpper()->doEval()));
  }

  page->m_incAmount      = sourcePage->m_incAmount     ;
  page->m_currentAddress = sourcePage->m_currentAddress;
  page->m_nextAddress    = sourcePage->m_nextAddress   ;
  page->m_dataWordWidth  = sourcePage->m_dataWordWidth ;
  page->m_alignment      = sourcePage->m_alignment     ;
  page->m_symbolLength   = sourcePage->m_symbolLength  ;
  page->m_prefix         = RefString(new std::string(*(sourcePage->m_prefix)));
  page->m_suffix         = RefString(new std::string(*(sourcePage->m_suffix)));

  page->add(sourcePage);

  return page;
}

RefCSLOmScope CSLOmMemoryMapPage::getAttachedScope() const {
  return m_scope;
}

TBool CSLOmMemoryMapPage::hasFree(TInt width) const {
  RefTVec_RefCSLOmAddressRange freeRanges = getChild(MEM_MAP_LOC_PAGE_FREE)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
  TBool gotFree = FALSE;
  if (freeRanges.get()) {
    TVec_RefCSLOmAddressRange::iterator it = freeRanges->begin();
    for (; it < freeRanges->end(); it++) {
      if (width <= CSLOmNumber::cast((*it)->getWidth()->doEval())->getValue()) {
        gotFree = TRUE;
        break;
      }
    }
  }
  return gotFree;
}

TBool CSLOmMemoryMapPage::isFree(RefCSLOmAddressRange range) const {
  ASSERT(range.get(), "null range received");
  ASSERT(range->hasWidthOrRange(), "empty range received");

  TBool isFree = FALSE;

  RefTVec_RefCSLOmAddressRange freeRanges = getChild(MEM_MAP_LOC_PAGE_FREE)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
  if(freeRanges.get()) {
    for (TVec_RefCSLOmAddressRange::iterator it = freeRanges->begin(); it < freeRanges->end(); ++it) {
      if ((*it)->includes(range)) {
        isFree = TRUE;
      }
    }
  }
  else {
    DCERR("OUT OF RANGE: THIS should be an error in cmd: trying to add an object when no more free ranges exists");
  }
  return isFree;
}

TBool CSLOmMemoryMapPage::isIllegal(RefCSLOmAddressRange range) const {
  ASSERT(range.get(), "null range received");
  ASSERT(range->hasWidthOrRange(), "empty range received");

  TBool isIllegal = TRUE;

  RefTVec_RefCSLOmAddressRange legalRanges = getChild(MEM_MAP_LOC_PAGE_LEGAL)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
  if(legalRanges.get()) {
    for (TVec_RefCSLOmAddressRange::iterator it = legalRanges->begin(); it < legalRanges->end(); ++it) {
      if ((*it)->includes(range)) {
        isIllegal = FALSE;
      }
    }
  }

  return isIllegal;
}

TBool CSLOmMemoryMapPage::isReserved(RefCSLOmAddressRange range) const {
  ASSERT(range.get(), "null range received");
  ASSERT(range->hasWidthOrRange(), "empty range received");

  TBool isReserved = FALSE;

  RefTVec_RefCSLOmAddressRange reservedRanges = getChild(MEM_MAP_LOC_PAGE_RESERVED)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
  if(reservedRanges.get()) {
    for (TVec_RefCSLOmAddressRange::iterator it = reservedRanges->begin(); it < reservedRanges->end(); ++it) {
      if ((*it)->overlaps(range)) {
        isReserved = TRUE;
      }
    }
  }

  return isReserved;
}

void CSLOmMemoryMapPage::allocLocation(RefCSLOmAddressRange range) {
  ASSERT(isFree(range), "range is not free, this should be tested already");
  
  RefCSLOmBase container = getChild(MEM_MAP_LOC_PAGE_FREE);
  RefTVec_RefCSLOmAddressRange freeRanges = getChild(MEM_MAP_LOC_PAGE_FREE)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
  if (freeRanges.get()) {
    for (TVec_RefCSLOmAddressRange::iterator it = freeRanges->begin(); it < freeRanges->end(); ++it) {
      if ((*it)->includes(range)) {
        RefCSLOmAddressRange cRange = *it;
        cRange->remove(range);
        container->removeChild(cRange);
        freeRanges = getChild(MEM_MAP_LOC_PAGE_FREE)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
        if (freeRanges.get()) {
          it = freeRanges->begin();
        }
        else {
          break;
        }
      }
      else if (range->includes(*it)) {
        container->removeChild(*it);
        freeRanges = getChild(MEM_MAP_LOC_PAGE_FREE)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
        if (freeRanges.get()) {
          it = freeRanges->begin();
        } 
        else {
          break;
        }
      }
    }
  }
}

TBool CSLOmMemoryMapPage::inc(TInt incAmount){
  TInt incA = incAmount;
  if (incAmount == 0) {
    incA = m_incAmount;
  }

  TInt tempAddr = m_nextAddress + incA;
  RefCSLOmAddressRange addr = CSLOmAddressRange::build(m_lineNumber, m_fileName, m_nextAddress, tempAddr);
  
  while (isIllegal(addr) || isReserved(addr) || !isFree(addr) || tempAddr < getUpperBound()->getValue()) {
    m_nextAddress++;
    tempAddr = m_nextAddress + incA;
    addr = CSLOmAddressRange::build(m_lineNumber, m_fileName, m_nextAddress, tempAddr);
  }

  if (tempAddr >= getUpperBound()->getValue()) {
    return FALSE;
  }
  else {
    return TRUE;
  }
}

void CSLOmMemoryMapPage::setUnitName(RefCSLOmExpr unitName) {
  ASSERT(unitName.get(), "null expr received");
  
  m_mandatoryCounter++;

  RefCSLOmBase eval = unitName->doEval();
  
  ASSERT(eval.get(), "unit name does not evaluate to an object: cmd should check for it");
  ASSERT(eval->isUnitDecl(), "unit name does not evaluate to an unit declaration: cmd should check for it");

  m_unitName = unitName;  
}

void CSLOmMemoryMapPage::addAddressRange(RefCSLOmNumber lower, RefCSLOmNumber upper) {
  ASSERT(lower.get(), "null lower received");
  ASSERT(upper.get(), "null upper received");
  ASSERT(!lower->hasXZ(), "XZ lower received");
  ASSERT(!upper->hasXZ(), "XZ upper received");

  if (lower->getValue() < m_lowerBound) {
    m_lowerBound = lower->getValue();
  }

  if (upper->getValue() > m_upperBound) {
    m_upperBound = upper->getValue();
  }

  RefCSLOmAddressRange legalRange = CSLOmAddressRange::build(m_lineNumber, m_fileName, getThis()->getChild(MEM_MAP_LOC_PAGE_LEGAL), lower, upper, CSLOmAddressRange::ADDR_VALID);
  RefCSLOmAddressRange freeRange = CSLOmAddressRange::build(m_lineNumber, m_fileName, getThis()->getChild(MEM_MAP_LOC_PAGE_FREE), lower, upper,   CSLOmAddressRange::ADDR_VALID);

  if(!m_addAddressRangePresent){
    m_mandatoryCounter++;
  }
}

void CSLOmMemoryMapPage::setAddressIncrement(RefCSLOmNumber incAmount) {
  ASSERT(incAmount.get(), "incAmount null received");
  
  m_incAmount = incAmount->getValue();
}

void CSLOmMemoryMapPage::setNextAddress(RefCSLOmNumber address) {
  ASSERT(address.get(), "nextAddress null received");
  
  m_nextAddress = address->getValue();
}


void CSLOmMemoryMapPage::addReservedRange(RefCSLOmNumber lower, RefCSLOmNumber upper) {
  ASSERT(lower.get(), "null lower received");
  ASSERT(upper.get(), "null upper received");

  RefCSLOmAddressRange reservedRange = CSLOmAddressRange::build(m_lineNumber, m_fileName, getThis()->getChild(MEM_MAP_LOC_PAGE_RESERVED), lower, upper, CSLOmAddressRange::ADDR_RESERVED);
}

void CSLOmMemoryMapPage::add(RefCSLOmBase addrObj, const RefString& name, RefCSLOmNumber baseAddress) {
  ASSERT(addrObj.get(),"null addressable object received");
  ASSERT(addrObj->isAddressable(),"object received is not addressable");
  ASSERT(name.get(), "null symbol received");
  ASSERT(!name->empty(), "empty symbol received");
  ASSERT(m_symbolLength ? name->length() <= m_symbolLength : TRUE, "symbol is longer than the maxSymbol specified size, this should be an error in the cmd");

  TBool noSpaceLeft = FALSE;

  // We get the address width of the addressable object
  RefCSLOmNumber width = RefCSLOmNumber();
  if (addrObj->isInstance()) {
//     RefCSLOmUnitDecl type = CSLOmUnitInstance::cast(addrObj)->getUnitDecl();
//     if (type->isFifo()) {
//       width = CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(type)->getUnitInfo())->getDepth();
//     }
//     else if (type->isRegisterFile()) {
//       width = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(type)->getUnitInfo())->getDepth();
//     }
//     else if (type->isRegister()) {
//       width = CSLOmNum32::build(m_lineNumber, m_fileName, 1);
//     }
//     else if(type->isMemory()) {
//       width = CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(type)->getUnitInfo())->getDepth();
//     }
//     else {
//       ASSERT(FAIL, "This is not an addressable object");
//     }
  }
  else {
    ASSERT(FAIL, "This is not an addressable object");
  }

  RefCSLOmAddressRange localAddress = RefCSLOmAddressRange();
  RefCSLOmAddressRange globalAddress = RefCSLOmAddressRange();

  // if the address width of the object is smaller than the specified increment amount then
  // we use the incAmount to calculate the space allocated by this object in the memory_map
  TInt incWith;
  if (m_incAmount < width->getValue()) {
    incWith = width->getValue();
  }
  else {
    incWith = m_incAmount;
  }

  if (baseAddress.get()) {
    localAddress = CSLOmAddressRange::build(m_lineNumber, m_fileName, baseAddress->getValue(), (baseAddress->getValue()) + incWith - 1);
    globalAddress = CSLOmAddressRange::build(m_lineNumber, m_fileName, baseAddress->getValue(), (baseAddress->getValue()) + incWith - 1);
  }
  else {
    localAddress = CSLOmAddressRange::build(m_lineNumber, m_fileName, m_nextAddress, m_nextAddress + incWith - 1);
    globalAddress = CSLOmAddressRange::build(m_lineNumber, m_fileName, m_nextAddress, m_nextAddress + incWith - 1);
  }
  if (!hasFree(CSLOmNumber::cast(localAddress->getWidth()->doEval())->getValue())) {
    noSpaceLeft = TRUE;
  }
  else {
    while (isIllegal(localAddress) || isReserved(localAddress) || !isFree(localAddress)) {
      if (m_nextAddress > getUpperBound()->getValue()) {
        m_nextAddress = getLowerBound()->getValue();
      }
      m_nextAddress++;
      localAddress = CSLOmAddressRange::build(m_lineNumber, m_fileName, m_nextAddress, m_nextAddress + incWith - 1);
      globalAddress = CSLOmAddressRange::build(m_lineNumber, m_fileName, m_nextAddress, m_nextAddress + incWith - 1);
    }
  }
  if (!noSpaceLeft) {
    m_nextAddress += incWith;
    allocLocation(localAddress);
    CSLOmMemoryMapLocation::build(m_lineNumber, m_fileName, getThis(), name, addrObj, localAddress, globalAddress);

    DCERR("WARNING -> IT DOES NOT CALCULATES THE GLOBAL ADDR FOR VIRTUAL MEM: see void CSLOmMemoryMapPage::add(RefCSLOmBase addrObj, const RefString& name, RefCSLOmNumber baseAddress = RefCSLOmNumber())" <<std::endl);
  }
  else {
    DCERR("ERROR: NO MORE SPACE LEFT, THIS SHOULD BE AN ERROR FROM CMD");
  }
}

void CSLOmMemoryMapPage::add(RefCSLOmMemoryMapPage sourcePage) {
  ASSERT(sourcePage.get(),"page is null");

  RefTMap_TUInt_RefCSLOmMemoryMapLocation map = sourcePage->m_map;
  TMap_TUInt_RefCSLOmMemoryMapLocation::iterator it;
  for (it = map->begin(); it != map->end() ;++it) {
    RefCSLOmNum32 base = CSLOmNum32::build(m_lineNumber, m_fileName, it->first);
    add(it->second->getAddressableObject(), it->second->getSymbol()->getName(), base);
  }
}

void CSLOmMemoryMapPage::setDataWordWidth(RefCSLOmNumber wordWidth) {
  ASSERT(wordWidth.get(), "wordWidth null received");
  ASSERT(wordWidth->getValue(), "wordWidth null received");
  
  m_dataWordWidth = wordWidth->getValue();
}

void CSLOmMemoryMapPage::setAlignment(RefCSLOmNumber align) {
  ASSERT(align.get(), "wordWidth null received");
  ASSERT(m_dataWordWidth, "wordWidth not set");
  
  m_alignment = align->getValue();
  
  ASSERT(!(m_dataWordWidth%m_alignment), "m_dataWordWidth%m_alignment is not 0 ")
  
    m_incAmount = m_dataWordWidth/m_alignment;
}

void CSLOmMemoryMapPage::setEndianess(Endianess endian) {
  ASSERT(endian > ENDIAN_UNDEFINED && endian < ENDIAN_MAX, "illegal enum value");
 
  m_endianess = endian;
}

void CSLOmMemoryMapPage::setSymbolMaxLength(RefCSLOmNumber length) {
  ASSERT(length.get(), "null length received");
  ASSERT(length->getValue(), "length cannot be zero received");
  
  m_symbolLength = length->getValue();
}


void CSLOmMemoryMapPage::setPrefix(RefString prefix) {
  ASSERT(prefix.get(), "null prefix received");
  ASSERT(!prefix->empty(), "empty prefix received");

  m_prefix = prefix;
}

void CSLOmMemoryMapPage::setSuffix(RefString suffix) {
  ASSERT(suffix.get(), "null suffix received");
  ASSERT(!suffix->empty(), "empty suffix received");
  
  m_suffix = suffix;
}

void CSLOmMemoryMapPage::setAccessRights(RefCSLOmNumber low, RefCSLOmNumber up, RefCSLOmExprLink group, CSLOmAddressRange::EAccessRights accessRights) {
  ASSERT(low.get(), "null param received");
  ASSERT(up.get(), "null param received");
  ASSERT(group.get(), "null param received");

  RefCSLOmAddressRange tempAddr = CSLOmAddressRange::build(m_lineNumber, m_fileName, low->getValue(), up->getValue());
  RefCSLOmBase eval = group->doEval();
  ASSERT(eval.get(), "cannot eval param");
  ASSERT(eval->isEnumItem(), "evaluated param is not a enum item");

  RefTVec_RefCSLOmAddressRange addrs = getChild(MEM_MAP_LOC_PAGE_ACC_RIGHTS)->getChildren<CSLOmAddressRange>(TYPE_ADDRESS_RANGE);
  TVec_RefCSLOmAddressRange::iterator it = addrs->begin();
  
  TBool rangeExists = FALSE;
  for(; it < addrs->end(); ++it) {
    if ((*it)->equals(tempAddr)) {
      (*it)->setAccessRights(CSLOmIdentifier::cast(eval), accessRights);
      rangeExists = TRUE;
    }
  }
  
  if (!rangeExists) {   
    RefCSLOmAddressRange reservedRange = CSLOmAddressRange::build(m_lineNumber, m_fileName, getThis()->getChild(MEM_MAP_LOC_PAGE_ACC_RIGHTS), low, up, CSLOmAddressRange::ADDR_VALID);
    reservedRange->setAccessRights(CSLOmIdentifier::cast(eval), accessRights);
  }
}

RefCSLOmNumber CSLOmMemoryMapPage::getAddressIncrement() const {
  return CSLOmNum32::build(m_lineNumber, m_fileName, m_incAmount);
}

RefCSLOmNumber CSLOmMemoryMapPage::getNextAddress() const {
  return CSLOmNum32::build(m_lineNumber, m_fileName, m_nextAddress);
}

RefCSLOmNumber CSLOmMemoryMapPage::getDataWordWidth() const {
  return CSLOmNum32::build(m_lineNumber, m_fileName, m_dataWordWidth);
}

RefCSLOmNumber CSLOmMemoryMapPage::getAlignment() const {
  return CSLOmNum32::build(m_lineNumber, m_fileName, m_alignment);
}

CSLOmMemoryMapPage::Endianess CSLOmMemoryMapPage::getEndianess() const {
  return m_endianess;
}

RefCSLOmNumber CSLOmMemoryMapPage::getSymbolMaxLength() const {
  return CSLOmNum32::build(m_lineNumber, m_fileName, m_symbolLength);
}

RefString CSLOmMemoryMapPage::getPrefix() const {
  return m_prefix;
}

RefString CSLOmMemoryMapPage::getSuffix() const {
  return m_suffix;
}

void CSLOmMemoryMapPage::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmMemoryMapPageInstance class
// ********************************************************************************
CSLOmMemoryMapPageInstance::CSLOmMemoryMapPageInstance(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmBase(TYPE_MEMORY_MAP_PAGE_INST, lineNumber, fileName) {}

RefCSLOmMemoryMapPageInstance CSLOmMemoryMapPageInstance::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmMemoryMapPageInstance();
  }
  else {
    ASSERT(object->isMemoryMapLocationPageInstance() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmMemoryMapPageInstance>(object);
  }
}

RefCSLOmMemoryMapPageInstance CSLOmMemoryMapPageInstance::build(TLineNumberType  lineNumber ,
                                                                RefString        fileName   ,
                                                                RefCSLOmBase     parent     , 
                                                                RefCSLOmExprLink type       , 
                                                                const RefString& name       , 
                                                                RefCSLOmExprLink unitInst   ) {
  ASSERT(parent.get(), "null parent received");
  ASSERT(type.get(), "null type received");
  ASSERT(name.get(), "null name received");
  ASSERT(!name->empty(), "empty name received");

  RefCSLOmExprLink newLink = CSLOmExprLink::build(lineNumber, fileName, type->getName());

  RefCSLOmBase baseExpr = newLink->doEval();
  ASSERT(baseExpr.get(),"null expr link");

  CSLOmMemoryMapPageInstance *inst;
  try {
    inst = new CSLOmMemoryMapPageInstance(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmMemoryMapPageInstance refInst(inst);
  inst->m_weakRef = boost::weak_ptr<CSLOmBase>( refInst);
  inst->setParent(parent);

  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refInst, CSLOmIdentifier::ID_MEM_MAP_PAGE_INST, name);

  newLink->setParent(refInst);

  if (parent->isMemoryMapLocationPage()) {
    if (CSLOmMemoryMapPage::cast(parent)->m_pageType != MM_UNDEFINED && CSLOmMemoryMapPage::cast(parent)->m_pageType != MM_HIERARCHICAL) {
      DCERR("please add WE to mem map page instace build function!!"<<std::endl);
    }
    else {
      CSLOmMemoryMapPage::cast(parent)->m_pageType = MM_HIERARCHICAL;
    }
  }

  if (unitInst.get()) {
    if (parent->isMemoryMapLocationPage()) {
      if (CSLOmMemoryMapPage::cast(parent)->m_pageType != MM_UNDEFINED && CSLOmMemoryMapPage::cast(parent)->m_pageType != MM_HIERARCHICAL) {
        DCERR("please add WE to mem map page instace build function!!"<<std::endl);
      }
    }
    if (parent->isMemoryMap()) {
      if (CSLOmMemoryMap::cast(parent)->m_mapType != MM_UNDEFINED && CSLOmMemoryMap::cast(parent)->m_mapType != MM_HIERARCHICAL) {
        DCERR("please add WE to mem map page instace build function!!"<<std::endl);
      }
    }
    RefCSLOmBase unitEval = unitInst->doEval();
    ASSERT(unitEval.get(), "this should be tested in the symbol table");
    ASSERT(unitEval->isInstance(), "this should be tested in the symbol table");
    ASSERT(!unitInst->getParent().get(), "parent already set");
    unitInst->setParent(refInst);
  }

  return refInst;
}

void CSLOmMemoryMapPageInstance::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmMemoryMap class
// ********************************************************************************
TBool CSLOmMemoryMap::m_designHasMemoryMap = FALSE;

CSLOmMemoryMap::CSLOmMemoryMap(TLineNumberType lineNumber, RefString fileName) :
  CSLOmBase(TYPE_MEMORY_MAP, lineNumber, fileName), 
  m_topUnit(),
  m_mapType(MM_UNDEFINED) {}

RefCSLOmMemoryMap CSLOmMemoryMap::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmMemoryMap();
  }
  else {
    ASSERT(object->isMemoryMap() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmMemoryMap>(object);
  }
}

RefCSLOmMemoryMap CSLOmMemoryMap::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmDesign parent, const RefString& name) {
  ASSERT(parent.get(),"null design");

  if (!m_designHasMemoryMap) {
    CSLOmMemoryMap* memMap;
    try {
      memMap = new CSLOmMemoryMap(lineNumber, fileName);
    }
    catch (std::exception& e) {
      ASSERT(FAIL,"new operator failed");
    }
    
    RefCSLOmMemoryMap refMemMap = RefCSLOmMemoryMap(memMap);
    memMap->m_weakRef = boost::weak_ptr<CSLOmBase>( refMemMap);
    memMap->setParent(parent);
    
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refMemMap, CSLOmIdentifier::ID_MEMORY_MAP, name);

    memMap->m_scope = CSLOmScope::build(id);

    RefCSLOmEnum defGroup = CSLOmEnum::build(lineNumber, fileName, refMemMap, RefString(new std::string("default_group")));
    defGroup->addPair(RefString(new std::string("user"))  ,CSLOmNum32::build(lineNumber, fileName, 0));
    defGroup->addPair(RefString(new std::string("sw"))    ,CSLOmNum32::build(lineNumber, fileName, 1));
    defGroup->addPair(RefString(new std::string("hw"))    ,CSLOmNum32::build(lineNumber, fileName, 2));
    defGroup->addPair(RefString(new std::string("test"))  ,CSLOmNum32::build(lineNumber, fileName, 3));
    defGroup->addPair(RefString(new std::string("driver")),CSLOmNum32::build(lineNumber, fileName, 4));

    m_designHasMemoryMap = TRUE;

    return refMemMap;
  }
  else {
    addErr(NSWarningErr::DEE_CSC_MMP_MULTIPLE_MEM_MAP, args, lineNumber, fileName, FALSE, TRUE);
    cslomHasErrors = TRUE;
    return RefCSLOmMemoryMap();
  }
}

RefCSLOmScope CSLOmMemoryMap::getAttachedScope() const {
  return m_scope;
}

void CSLOmMemoryMap::setTopUnit(RefCSLOmUnitDecl top) {
  ASSERT(top.get(), "null unit received");
  ASSERT(top->getUnitType() == CSLOmUnitDecl::CSL_UNIT_DECL, "top cannot be a built-in type unit");
  
  m_topUnit = top;
}

RefCSLOmUnitDecl CSLOmMemoryMap::getTopUnit() const {
  return m_topUnit;
}

void CSLOmMemoryMap::setMemMapType(EMemoryMapType type) {
  ASSERT(type > MM_UNDEFINED && type < MM_MAX, "not a memory map type");
  
  //for design checker
  m_mandatoryCounter++;

  m_mapType = type;

  //TODO: check page instances
  DCERR("TODO: WRITE CHECKS FOR PAGE INSTANCES ON SET_TYPE");
}

EMemoryMapType CSLOmMemoryMap::getMemMapType() const {
  return m_mapType;
}

void CSLOmMemoryMap::setAccessRightsEnum(RefCSLOmEnum group) {
  ASSERT(group.get(), "null group received");
  
  setChild(MEM_MAP_AR_ENUM, group);
}

RefCSLOmEnum CSLOmMemoryMap::getAccessRightsEnum() {
  return CSLOmEnum::cast(getChild(MEM_MAP_AR_ENUM));
}

void CSLOmMemoryMap::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


}
