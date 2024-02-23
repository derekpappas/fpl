//----------------------------------------------------------------------
// Copyright (c) 2006, 2007 Fastpathlogic
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

#ifndef _WARN_ERR
#define _WARN_ERR

#include <iostream>
#include <vector>
#include <string>
#include <map>

namespace NSWarnErr {

  inline int getNumberOfArguments(std::string);  
  
  struct error {
  public:
    error();
    std::string category, phase, type, description, name, we;
    bool v1995, v2001, sys_verilog, csl;
  };
  
  class allErrors {
  private:
    std::vector<error> errors;
    std::map<std::string, int> categories;
    std::map<std::string, int> phases;
    std::map<std::string, int> types;
    std::map<std::string, int> names;
  public:
    allErrors();
    void print() const;
    void print(std::map<std::string, int>) const;
    std::vector<error> getAllErrors() const;
    std::map<std::string, int> getCategories() const;
    std::map<std::string, int> getPhases() const;
    std::map<std::string, int> getTypes() const;
    std::map<std::string, int> getNames() const;
    void setAllErrors(std::vector<error>);
    int start(char* xmlFile, char* outFile);
    void processMaps(char* outFile);
    std::pair<std::string, std::string> computeErrorValue(error);
  };
}

#endif
