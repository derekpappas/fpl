//----------------------------------------------------------------------
// Copyright (c) 2005, 2006 Fastpathlogic
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

#ifndef INC_GUARD_Tools_h
#define INC_GUARD_Tools_h

#include <string>
#include <vector>

#include "Base.h"
#include "CDOM_TypeDefs.h"


namespace NSTools {

//********************************************************************************
// CStringTokenizer
//********************************************************************************
class CStringTokenizer {
private:
  std::vector<const std::string*> m_tokens;

public:
  CStringTokenizer(const std::string& str, const std::string* delimiters = 0) {
    if(!str.length()) {
      throw NSBase::IllegalArgumentException();
    }
    if(!delimiters || !delimiters->length()) {
      m_tokens.push_back(new std::string(str));
      return;
    }
    char* charTable = new char[256];
    memset(charTable, 0, 256);
    std::string::const_iterator iter;
    for(iter = delimiters->begin(); iter < delimiters->end(); ++iter) {
      ++charTable[*iter];
    }
    std::string* strToken = new std::string();
    for(iter = str.begin(); iter < str.end(); ++iter) {
      if(!charTable[*iter]) {
        *strToken += *iter;
      }
      else {
        if(!strToken->length()) {
          throw NSBase::IllegalArgumentException();
        }
        m_tokens.push_back(strToken);
        strToken = new std::string();
      }
    }
    if(!strToken->length()) {
      throw NSBase::IllegalArgumentException();
    }
    m_tokens.push_back(strToken);
    delete charTable;
  }

  ~CStringTokenizer() {
    for(std::vector<const std::string*>::iterator iter = m_tokens.begin(); iter < m_tokens.end(); iter++) {
      delete *iter;
    }
  }

  TUInt getNrTokens() const {
    return m_tokens.size();
  }

  const std::string* getToken(TUInt idx) const {
    return m_tokens.at(idx);
  }
};

} // end namespace NSTools

#endif /*INC_GUARD_Tools_h*/
