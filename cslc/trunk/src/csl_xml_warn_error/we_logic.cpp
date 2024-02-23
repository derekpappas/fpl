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

#include <iostream>
#include "we_logic.h"
#include <vector>
#include <map>
#include <sstream>

using namespace std;

namespace NSWarnError {

// *********************************************************************
// CslException class
// *********************************************************************
CslException::CslException(const char* msg) throw()
  : m_msg(msg) {}

CslException::~CslException() throw() {}

const char* CslException::what() const throw() {
  return m_msg.c_str();
}

// *********************************************************************
// CslWE class
// *********************************************************************
CslWE* CslWE::instance = 0;

CslWE::~CslWE() {
}

  RefCslWE CslWE::Instance(unsigned int filter) {
    if(!instance)
      instance = new CslWE(filter);
    static RefCslWE refInstance = RefCslWE(instance);
    return refInstance;
  }

  bool CslWE::filterIsValid() const {
    if(filter == 0)
      return true;
    unsigned long long tmpFilter = filter;
    tmpFilter >>= allErrors.maxNameDigits * 4;
    unsigned int typeMask = 1;
    unsigned int phaseMask = 1;
    unsigned int catMask = 1;
    unsigned int mask = 1;
    for(unsigned int i = 0; i < (allErrors.maxTypesDigits * 4 - 1); ++i) {
      typeMask <<= 1;
      typeMask |= 1;
    }
    for(unsigned int i = 0; i < (allErrors.maxPhasesDigits * 4 - 1); ++i) {
      phaseMask <<= 1;
      phaseMask |= mask;
    }
    for(unsigned int i = 0; i < (allErrors.maxCategoryDigits * 4 - 1); ++i) {
      catMask <<= 1;
      catMask |= mask;
    }
    tmpFilter &= typeMask;
    if(tmpFilter > allErrors.nrOfTypes)
      return false;
    tmpFilter = filter; tmpFilter >>= (allErrors.maxNameDigits * 4 + allErrors.maxTypesDigits * 4);
    tmpFilter &= phaseMask;
    if(tmpFilter > allErrors.nrOfPhases)
      return false;
    tmpFilter = filter; tmpFilter >>= (allErrors.maxNameDigits * 4 + (allErrors.maxPhasesDigits + allErrors.maxTypesDigits)* 4);
    tmpFilter &= catMask;
    if(tmpFilter > allErrors.nrOfCategories)
      return false;
    return true;
  }

CslWE::CslWE(unsigned int filter):m_found_fatal_error(false), MAX_ERRORS(30), MAX_WARNINGS(30), allErrors(), errCount(0), warnCount(0), filter(filter) {
    if(!filterIsValid()) {
      cerr << "Invalid filter, using default = 0" << endl;
      this->filter = 0;
    }
  }

  void CslWE::foundFatal(NSWarningErr::all_errors err) {
    m_found_fatal_error = true;
    //cerr << "Fatal error found..." << endl;
//     exit(err);
    //TODO: '1' is actually the FATAL_ERROR const int defined in support/Assert.h; get rid of it
    throw 1;
  }

  inline void CslWE::setFilter(unsigned int newValue) const {
    unsigned int currentFilter = filter;
    filter = newValue;
    if(!filterIsValid())
      filter = currentFilter;
  }
  
  void CslWE::setMaxErrors(int newValue) const {
    MAX_ERRORS = newValue;
  }

  void CslWE::setMaxWarnings(int newValue) const {
    MAX_WARNINGS = newValue;
  }

  inline bool CslWE::verifiesFilter(NSWarningErr::all_errors value) const {
    if(filter == 0)
      return true;
    unsigned long long tmpFilter = filter;
    tmpFilter >>= allErrors.maxNameDigits * 4;
    unsigned long long tmpValue = value;
    tmpValue >>= allErrors.maxNameDigits * 4;
    unsigned int typeMask = 1;
    unsigned int phaseMask = 1;
    unsigned int catMask = 1;
    unsigned int mask = 1;
    for(unsigned int i = 0; i < (allErrors.maxTypesDigits * 4 - 1); ++i) {
      typeMask <<= 1;
      typeMask |= 1;
    }
    for(unsigned int i = 0; i < (allErrors.maxPhasesDigits * 4 - 1); ++i) {
      phaseMask <<= 1;
      phaseMask |= mask;
    }
    for(unsigned int i = 0; i < (allErrors.maxCategoryDigits * 4 - 1); ++i) {
      catMask <<= 1;
      catMask |= mask;
    }
    tmpFilter &= typeMask;
    if((tmpValue & typeMask) == (tmpFilter))
      if(tmpFilter)
        return false;
    tmpFilter = filter; tmpFilter >>= (allErrors.maxNameDigits * 4 + allErrors.maxTypesDigits * 4);
    tmpValue = value; tmpValue >>= (allErrors.maxNameDigits * 4 + allErrors.maxTypesDigits * 4);
    tmpFilter &= phaseMask;
    if((tmpValue & phaseMask) == (tmpFilter))
      if(tmpFilter)
        return false;
    tmpFilter = filter; tmpFilter >>= (allErrors.maxNameDigits * 4 + (allErrors.maxPhasesDigits + allErrors.maxTypesDigits)* 4);
    tmpValue = value; tmpValue >>= (allErrors.maxNameDigits * 4 + (allErrors.maxPhasesDigits + allErrors.maxTypesDigits)* 4);
    tmpFilter &= catMask;
    if((tmpValue & catMask) == (tmpFilter))
      if(tmpFilter)
        return false;
    return true;
  }

  void CslWE::addWarnError(NSWarningErr::all_errors value, vector<RefString> args) {
    bool canBeAdded = true;
    if(args.size() != allErrors.errorData[value]->numberOfArguments) {
      cerr << "Wrong number of arguments: expected " << allErrors.errorData[value]->numberOfArguments << " got: " << args.size() << "Error(Warning) not added" << endl;
      canBeAdded = false;
    }
    if(!verifiesFilter(value)) {
      canBeAdded = false;
    }
    if(canBeAdded) {
      if((allErrors.errorData[value]->type.find('e', 0) != string::npos)) {
        addError(value, args);
      }
      else if((allErrors.errorData[value]->type.find('w', 0) != string::npos)) {
        addWarning(value, args);
      }
    }
  }

  void CslWE::addError(NSWarningErr::all_errors value, vector<RefString> args) {
    if(++errCount <= MAX_ERRORS) {
      thrownErrors[value] = args;
      printError(value);
    }
    else {
      //printErrors();
//       string error = "Max number of errors reached, exiting...";
      throw CslException("Maximum number of errors reached");
    }
  }

  void CslWE::addWarning(NSWarningErr::all_errors value, vector<RefString> args) {
    if(++warnCount <= MAX_WARNINGS) {
      thrownWarnings[value] = args;
      printWarning(value);
    }
    else {
      //printWarnings();
//       string error = "Max number of warnings reached, exiting...";
      throw CslException("Maximum number of warnings reached");
    }
  }

inline void CslWE::printError(NSWarningErr::all_errors value) {
  NSWarningErr::description* error = allErrors.errorData[value];
  string buffer;
  buffer.append("Error no.: 0x");
  stringstream temp;
  temp << hex << value;
  string tempString;
  temp >> tempString;
  buffer.append(tempString);
  //  buffer.append(" ");
  if(error->type.find('e', 0) != string::npos) {
    buffer.append(":");
    buffer.append(error->desc);
  }
  if(error->numberOfArguments) {
    int currPos = 0;
    for(unsigned int i = 0; i < error->numberOfArguments; ++i) {
      int pos = buffer.find('@', currPos);
      buffer.erase(pos, 1);
      buffer.insert(pos, "\'" + *thrownErrors[value][i] + "\'");
      currPos = pos;
    }
  }
  cout << buffer << endl;
}

inline void CslWE::printWarning(NSWarningErr::all_errors value) {
  NSWarningErr::description* warning = allErrors.errorData[value];
  string buffer;
  buffer.append("Warning no.: 0x");
  stringstream temp;
  temp << hex << value;
  string tempString;
  temp >> tempString;
  buffer.append(tempString);
  //  buffer.append(" ");
  if(warning->type.find('w', 0) != string::npos) {
    buffer.append(":");
    buffer.append(warning->desc);
  }
  if(!warning->numberOfArguments)
    buffer.append(warning->desc);
  else {
    int currPos = 0;
    for(unsigned int i = 0; i < warning->numberOfArguments; ++i) {
      int pos = buffer.find('@', currPos);
      buffer.erase(pos, 1);
      buffer.insert(pos, "\'" + *thrownWarnings[value][i] + "\'");
      currPos = pos;
    }
  }
  cout << buffer << endl;
}

  inline void CslWE::printErrors() {
    if(errCount <= MAX_ERRORS) {
      map<NSWarningErr::all_errors, vector<RefString> >::const_iterator it;
      for(it = thrownErrors.begin(); it != thrownErrors.end(); ++it) {
        NSWarningErr::all_errors value = it->first;
        NSWarningErr::description* error = allErrors.errorData[value];
        string buffer;
        buffer.append("cslc error/warning no.: 0x");
        stringstream temp;
        temp << hex << value;
        string tempString;
        temp >> tempString;
        buffer.append(tempString);
        if(error->type.find('e', 0) != string::npos) {
          buffer.append("\n\tError: ");
          buffer.append(error->desc);
        }
        if(!error->numberOfArguments)
          buffer.append(error->desc);
        else {
          int currPos = 0;
          for(unsigned int i = 0; i < error->numberOfArguments; ++i) {
            int pos = buffer.find('@', currPos);
            buffer.erase(pos, 1);
            buffer.insert(pos, "\'" + *thrownErrors[value][i] + "\'");
            currPos = pos;
          }
        }
        cout << buffer << endl;
      }
    }
  }

  inline void CslWE::printWarnings() {
    if(warnCount <= MAX_WARNINGS) {
      map<NSWarningErr::all_errors, vector<RefString> >::const_iterator it;
      for(it = thrownWarnings.begin(); it != thrownWarnings.end(); ++it) {
        NSWarningErr::all_errors value = it->first;
        NSWarningErr::description* warning = allErrors.errorData[value];
        string buffer;
        buffer.append("cslc error/warning no.: 0x");
        stringstream temp;
        temp << hex << value;
        string tempString;
        temp >> tempString;
        buffer.append(tempString);
        if(warning->type.find('w', 0) != string::npos) {
          buffer.append("\n\tWarning: ");
          buffer.append(warning->desc);
        }
        if(!warning->numberOfArguments)
          buffer.append(warning->desc);
        else {
          int currPos = 0;
          for(unsigned int i = 0; i < warning->numberOfArguments; ++i) {
            int pos = buffer.find('@', currPos);
            buffer.erase(pos, 1);
            buffer.insert(pos, "\'" + *thrownWarnings[value][i] + "\'");
            currPos = pos;
          }
        }
        cout << buffer << endl;
      }
    }
  }
  
}
