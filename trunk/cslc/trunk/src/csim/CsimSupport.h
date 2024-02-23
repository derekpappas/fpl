//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007 Fastpath Logic
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


#ifndef INC_GUARD_CSIM_SUPPORT
#define INC_GUARD_CSIM_SUPPORT

#include "CsimInclude.h"
#include <climits>

namespace NSCsimLib {



//template <typename T>
//std::ostream& std::operator<<(std::ostream& os, const CsimMemory<T>& mem);


//WARNING - type T should be one of the integer types
template<class T>
TBool valueHasMaxWidth(T value, TUInt width) {
  ASSERT(0 < width, "CSIM - Support - width cannot be 0");

  for (TUInt i = sizeof(T) * 8 - 1; i >= width; --i) {

    T temp = static_cast<T>(floor(pow(static_cast<TLDouble>(2), static_cast<TLDouble>(i))));

    if (temp & value) {//check if position i from value is 1
      
      return FALSE;
    }
  }

  return TRUE;
}


//returns a string with value in hex or bin
//T should be one of the integer types
template<class T>
  RefString convertValueTo(T value, TRadix radix, TUInt width = 0) {
  ASSERT(T_UNDEF < radix && T_MAX > radix, "CSIm - Support - invalid radix");

  RefString returnVal = RefString(new std::string);

  if (T_BIN == radix) {//convert to binary

    for (TUInt i = ( width ? (width - 1) : (sizeof(T) * 8 - 1)); i != UINT_MAX; --i) {

      T temp = static_cast<T>(floor(pow(static_cast<TLDouble>(2), static_cast<TLDouble>(i))));

      if (temp & value) {//check if position i from value is 1
      
        returnVal->append("1");
      }
      else { returnVal->append("0"); }
    } 
  }
  else {//convert to hexadecimal
    
    for (TUInt i =(width ? ((width % 4) ? (width / 4) : (width / 4 - 1)) : (static_cast<TUInt>(sizeof(T)) * 2 - 1)); i != UINT_MAX; --i) {

      T shiftVal = static_cast<T>(floor(pow(static_cast<TLDouble>(2), static_cast<TLDouble>(i*4))));//how many positions to shift towards MSB

      T mask = ((i == width / 4 && width % 4 != 0) ? (static_cast<T>(floor(pow(static_cast<TLDouble>(2), static_cast<TLDouble>(width % 4)))) - 1) : static_cast<T>(0xF)) * shiftVal;//shift 0xF by shiftVal positions towards MSB

      TUInt temp = (mask & value)/shiftVal;//get the value at that position

      RefTChar p = RefTChar(new TChar);

      if (9 < temp) { *p = static_cast<TChar>(temp - 10 + 'A'); }
      else { *p = static_cast<TChar>(temp + '0'); }

      returnVal->append(p.get());
    }
  }

  return returnVal;
}



}

#endif //INC_GUARD_CSIM_SUPPORT

//END OF FILE
