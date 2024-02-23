//---------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpath Logic, Inc.
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpath Logic, Inc.;
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

/**
 * Author: Bogdan Zamfir <bogdanz@fplsrl.com>
 */

#include <string>
#include "SupportFunctions.h"

RefString refStrToLower(RefString str) {

  const char* upperString = (*str).c_str();
  char* lowerString = new char[str->length()+1];
  for(TUInt i = 0; i < str->length(); ++i) { 
    lowerString[i] = tolower(upperString[i]);
  }
  lowerString[str->length()] = '\0';
  RefString name = RefString(new std::string(lowerString)); 
  delete []lowerString;
  return name;
}

RefString refStrToUpper(RefString str) {
  const char* lowerString = (*str).c_str();
  char* upperString = new char[str->length()+1];
  for(TUInt i = 0; i < str->length(); ++i) { 
    upperString[i] = toupper(lowerString[i]);
  }
  upperString[str->length()] = '\0';
  RefString name = RefString(new std::string(upperString));
  delete []upperString;
  return name;
}

double log2(double x) { return log(x)/log(2.0);}
