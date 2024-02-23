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
// global variables
// ********************************************************************************
const TChar DOT = '.';

RefString convertLink(RefCSLOmExprLink link) {
  RefString endPointName1 = RefString(new std::string(""));
  RefTVec_RefString names1 = link->getHidNames();
  TVec_RefString::iterator it = names1->begin();
  for (; it < names1->end()-1; ++it) {
    endPointName1->append(*(*it));
    endPointName1->append(".");
  }
  endPointName1->append(*(*it));
  return endPointName1;
}

TBool less_RefString::operator() (const RefString& s1, const RefString& s2) const {
  ASSERT(s1.get(), "null string 1");
  ASSERT(s2.get(), "null string 2");

  return s1->compare(*s2) < ZERO;
}

TBool less_RefCSLOmNumber::operator() (RefCSLOmNumber s1, RefCSLOmNumber s2) const {
  ASSERT(s1.get(), "null string 1");
  ASSERT(s2.get(), "null string 2");

  return (s1->relationalLess(s2))->getValue() == 1;
}

TBool less_RefCSLOmUnitInstance::operator() (RefCSLOmUnitInstance s1, RefCSLOmUnitInstance s2) const {
  return s1.get() < s2.get();
}

TBool less_RefCSLOmExprLink::operator() (RefCSLOmExprLink s1, RefCSLOmExprLink s2) const {
  ASSERT(s1.get(), "null string 1");
  ASSERT(s2.get(), "null string 2");

  RefString str1 = convertLink(s1);
  RefString str2 = convertLink(s2);
  if (str1->compare(*str2) < ZERO) {
    return TRUE;
  }
  

//   if (s1->getHidNames()->size() < s2->getHidNames()->size()) {
//     return TRUE;
//   }
//   else if (s1->getHidNames()->size() == s2->getHidNames()->size()) {
//     RefTVec_RefString names1 = s1->getHidNames();
//     RefTVec_RefString names2 = s2->getHidNames();
//     for (TInt i = names1->size()-1 ; i >= 0 ; i--) {
//       if ((names1->at(i))->compare(*(names2->at(i))) < ZERO) {
//         return TRUE;
//       }
//     }
//   }
  return FALSE;
}

TBool less_RefCSLOmSignal::operator() (RefCSLOmSignal s1, RefCSLOmSignal s2) const {
  return s1.get() < s2.get();
}

// ********************************************************************************
// global function
// ********************************************************************************
void checkIdName(const RefString& name, TLineNumberType lineNumber, RefString fileName) {
  ASSERT(name.get(), "invalid name: null");
  ASSERT(name->length(), "invalid name: length 0");

  if(name->find(DOT) != std::string::npos) {
    args.push_back(*name);
    addErr(NSWarningErr::CSE_CSC_ID_CSE_CSC_ID_ILLEGAL, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException(std::string("[checkIdName()] illegal identifier name: " + *name).c_str());
  }
}

/**
 * This function transforms a long number into a RefString.
 * Used on generating names for anonymous declarations.
 */

RefString ltos(const TULong number) {
  TULong copy = number;
  if (copy == 0) {
    return RefString(new std::string("0"));
  }
  TUInt size=ZERO;
  while (copy != 0) {
    copy/=10;
    size++;
  }
  copy = number;
  RefString temp(new std::string(size, ' '));
  for (TInt i=size-1;i>=0;i--) {
    TUInt ch = copy%10;
    temp->at(i)='0'+ch;
    copy/=10;
  }
  return temp;
}

#include "templateInit.inc"
} // end namespace NSCSLOm
