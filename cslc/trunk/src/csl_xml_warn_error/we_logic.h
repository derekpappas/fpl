//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007 Fastpathlogic
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

#ifndef _WE_LOGIC
#define _WE_LOGIC

#include <iostream>
#include <map>
#include <vector>
#include <boost/shared_ptr.hpp>
#include "CSLC_Errors.h"

namespace NSWarnError {
  
class CslWE;
class CslException;
typedef boost::shared_ptr<std::string> RefString;
typedef boost::shared_ptr<CslWE> RefCslWE;

// *********************************************************************
// CslException class
// *********************************************************************
class CslException : public std::exception {
  private:
    std::string m_msg;

  public:
    CslException(const char* msg) throw();
    ~CslException() throw();

    const char* what() const throw();
};

// *********************************************************************
// CslWE class
// *********************************************************************
class CslWE {
    static CslWE* instance;
    static const int ERROR_LEVEL_MAX = 0x03;
    std::map<NSWarningErr::all_errors, std::vector<RefString> > thrownErrors;
    std::map<NSWarningErr::all_errors, std::vector<RefString> > thrownWarnings;
    bool m_found_fatal_error;
    mutable int MAX_ERRORS;
    mutable int MAX_WARNINGS;
    NSWarningErr::error allErrors;
    int errCount;
    int warnCount;
    mutable unsigned int filter;
    bool filterIsValid() const;
    bool verifiesFilter(NSWarningErr::all_errors value) const;
  protected:
    CslWE(unsigned int filter = 0);
    CslWE(const CslWE&);
    CslWE& operator=(const CslWE&);
  public:
    void foundFatal(NSWarningErr::all_errors err);
    void printErrors();
    void printError(NSWarningErr::all_errors value);
    void printWarnings();
    void printWarning(NSWarningErr::all_errors value);
    void setFilter(unsigned int newValue) const;
    void setMaxErrors(int newValue) const;
    void setMaxWarnings(int newValue) const;
    static RefCslWE Instance(unsigned int filter = 0);
    static void destroy();
    void addWarnError(NSWarningErr::all_errors, std::vector<RefString> msgs);
    void addError(NSWarningErr::all_errors, std::vector<RefString> msgs);
    void addWarning(NSWarningErr::all_errors, std::vector<RefString> msgs);
    ~CslWE();
};

}

#endif
