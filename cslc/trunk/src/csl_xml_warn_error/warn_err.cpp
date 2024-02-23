//-----------------------------------------------------------------------
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

#include <iostream>
#include <sstream>
#include <iomanip>
#include <fstream>
//#include "../support/xerces/xercesc/util/IOException.hpp"

#include <xercesc/util/IOException.hpp>
#include <cmath>
#include <cctype>
#include <algorithm>
#include "warn_err.h"
#include "WESAXHandlers.h"
//#include "../support/CommonSupport.h"

using namespace std;

namespace NSWarnErr {
error::error() {
  v1995 = false;
  v2001 = false;
  sys_verilog = false;
  csl = false;
}  

void allErrors::setAllErrors(std::vector<error> m_vector) {
  errors = m_vector;
}

void allErrors::print(std::map<std::string, int> aMap) const {
  std::map<std::string, int>::const_iterator it;
  for(it = aMap.begin(); it != aMap.end(); ++it) {
    cout << it->first << ", " << it->second << endl;
  }
  cout << endl << endl;
}

int allErrors::start(char* xmlFile, char* outFile) {
  ifstream in(xmlFile);
  if(!in) {
    string error = "Error opening file ";
    error.insert(error.size(), xmlFile);
    //cerr << "Error opening file" << endl;
    //exit(0);
    throw error;
  }
  in.close();
  const char* encodingName = "LATIN1";
  //const char* xmlFile = "table151net.xml";
  bool canProcess;
  try
    {
      XMLPlatformUtils::Initialize();
    }

  catch (const XMLException& toCatch)
    {
      cerr << "Error during initialization! :\n"
           << toCatch.getMessage() << endl;
      return 1;
    }
  XMLFormatter::UnRepFlags unRepFlags = XMLFormatter::UnRep_CharRef;
  SAXParser* parser = new SAXParser;
  parser->setDoNamespaces(false);
  parser->setDoSchema(false);
  parser->setValidationSchemaFullChecking(false);
  //
  //  Create the handler object and install it as the document and error
  //  handler for the parser-> Then parse the file and catch any exceptions
  //  that propogate out
  //
  int errorCode = 0;
  try
    {
      WESAXHandlers handler(encodingName, unRepFlags);
      parser->setDocumentHandler(&handler);
      parser->setErrorHandler(&handler);
      parser->parse(xmlFile);
      parser->getErrorCount();
      errors = handler.vectorOfErrors;
      categories = handler.categories;
      phases = handler.phases;
      types = handler.types;
      names = handler.names;
      canProcess = handler.encounteredErrors;
    }
  catch (const OutOfMemoryException&)
    {
      cerr << "OutOfMemoryException" << endl;
      errorCode = 5;
    }
  catch (const XMLException& toCatch)
    {
      cerr << "\nAn error occurred\n  Error: "
           << toCatch.getMessage()
           << "\n" << endl;
      errorCode = 4;
    }
  if(errorCode) {
    XMLPlatformUtils::Terminate();
    return errorCode;
  }

  //
  //  Delete the parser itself.  Must be done prior to calling Terminate, below.
  //
  delete parser;

  // And call the termination method
  XMLPlatformUtils::Terminate();
  if(!canProcess)
    processMaps(outFile);
  else {
    string error = "The XML doc has errors. Please fix them first";
    throw error;
    //cerr << "The XML doc has errors. Please fix them first" << endl;
    //exit(0);
  }
  return 0;
}

std::map<std::string, int> allErrors::getCategories() const{
  return categories;
}
  
std::map<std::string, int> allErrors::getPhases() const{
  return phases;
}

std::map<std::string, int> allErrors::getTypes() const{
  return types;
}

void allErrors::print() const {
  cout << "All errors:" << endl;
  std::vector<NSWarnErr::error>::const_iterator it;
  for (it = errors.begin(); it != errors.end(); ++it) {
    cout << "Category   : " << it->category << endl;
    cout << "Phase      : " << it->phase << endl;
    cout << "Type       : " << it->type << endl;
    cout << "Name       : " << it->name << endl;
    cout << "Description: " << it->description << endl;
    cout << "W/E        : " << it->we << endl;
    if(it->v1995) cout << "V1995      : " << it->v1995 << endl;
    if(it->v2001) cout << "V2001      : " << it->v2001 << endl;
    if(it->sys_verilog) cout << "Sys_verilog: " << it->sys_verilog << endl;
    if(it->csl) cout << "Csl        : " << it->csl << endl;
    cout << endl << endl;
  }
}
std::vector<error> allErrors::getAllErrors() const {
  return errors;
}
map<string, int> allErrors::getNames() const {
  return names;
}

allErrors::allErrors() {
}

inline int digits(int nr) {
  //    int digits = 1;
  //     while((nr/=10) != 0) {
  //       ++digits;
  //     }
  //     return digits;
  ostringstream ss;
  ss << hex << nr;
  return ss.str().length();
}

inline string toUpper(string str) {
  transform(str.begin(), str.end(), str.begin(), (int(*)(int)) toupper);
  return str;
}

pair<string, string> allErrors::computeErrorValue(NSWarnErr::error error) {
  ostringstream ss;
  /* unsigned long hexValue = static_cast<int>((((pow(static_cast<double>(10), digits(categories.size()) + 1) + \
     categories[error.category]) * pow(static_cast<double>(10), digits(phases.size())) + phases[error.phase]) \
     * pow(static_cast<double>(10), digits(types.size())) + types[error.type]) * pow(static_cast<double>(10), digits(names.size())) + names[error.name]);*/
    ss<< "(_"<<error.category;
    ss<< "<<" <<dec<< 4*(digits(phases.size())+digits(types.size())+digits(names.size())) << ")+";
    ss<< "(_" << error.phase;
    ss<< "<<" <<dec<< 4*(digits(types.size())+digits(names.size())) << ")+";
    ss<< "(_" << error.type;
    ss<< "<<" <<dec<< 4*(digits(names.size())) << ")+";
    ss<< names[error.name];
    pair<string, string> result;
    char* aux = new char;
    //sprintf(aux, "%d", hexValue);
    string aaa(aux);aaa.erase(0, 2);
    result.first.append(string("const all_errors ") + toUpper(error.category) + string("_") + toUpper(error.phase) + string("_") + toUpper(error.type) + string("_") + toUpper(error.name) + string(" = ") + (ss.str()));
    result.second.append(toUpper(error.category) + string("_") + toUpper(error.phase) + string("_") + toUpper(error.type) + string("_") + toUpper(error.name));
    return result;
}

inline int getNumberOfArguments(string description) {
  int counter = 0;
  for(unsigned int i = 0; i<description.length(); i++)
    if(description.at(i) == '@')
      ++counter;
  return counter;
}

void allErrors::processMaps(char* outFile) {
  assert(!categories.empty());
  assert(!phases.empty());
  assert(!types.empty());
  assert(!errors.empty());
  ofstream out(outFile);
  if(!out) {
    string error = "Error opening file " + string(outFile);
    throw error;
    //cerr << "Error opening file" << outFile << endl;
    //exit(0);
  }
  string cppFile = string(outFile);cppFile.erase(cppFile.length()-1);cppFile.append("cpp");
  ofstream cppOut(cppFile.c_str());
  if(!cppOut) {
    string error = "Error opening file " + cppFile; 
    throw error;
    //cerr << "Error opening file" << cppOut << endl;
    //exit(0);
  }
  vector<error>::const_iterator it;
  char* aux = new char;
  string buffer("//----------------------------------------------------------------------\n\
// Copyright (c) 2005, 2006, 2007 Fastpathlogic\n\
// All Rights Reserved.\n\
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;\n\
// the contents of this file may not be disclosed to third parties,\n\
// copied or duplicated in any form, in whole or in part, without the prior\n\
// written permission of Fastpathlogic.\n\
//\n\
// RESTRICTED RIGHTS LEGEND:\n\
// Use, duplication or disclosure by the Government is subject to\n\
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in\n\
// Technical Data and Computer Software clause at DFARS 252.227-7013,\n\
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.\n\
// Unpublished rights reserved under the Copyright Laws of the United States\n\
//----------------------------------------------------------------------\n\
#ifndef _INC_GUARD_WARNING_ERROR\n#define _INC_GUARD_WARNING_ERROR\n\n#include <vector>\n#include <string>\n#include <map>\n\nnamespace NSWarningErr {\n\n"); 
  buffer.append(string("\n  struct description {\n  public:\n    description(std::string, int, std::string);\n    std::string desc;\n    unsigned int numberOfArguments;\n    std::string type;\n  };\n"));
  out.write(buffer.c_str(), buffer.length());
  buffer.clear();
  buffer.append(string("//----------------------------------------------------------------------\n\
// Copyright (c) 2005, 2006, 2007 Fastpathlogic\n\
// All Rights Reserved.\n\
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;\n\
// the contents of this file may not be disclosed to third parties,\n\
// copied or duplicated in any form, in whole or in part, without the prior\n\
// written permission of Fastpathlogic.\n\
//\n\
// RESTRICTED RIGHTS LEGEND:\n\
// Use, duplication or disclosure by the Government is subject to\n\
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in\n\
// Technical Data and Computer Software clause at DFARS 252.227-7013,\n\
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.\n\
// Unpublished rights reserved under the Copyright Laws of the United States\n\
//----------------------------------------------------------------------\n#include <iostream>\n#include \"") + outFile + string("\"\n\nusing namespace std;\n\nnamespace NSWarningErr {\n description::description(string desc, int nrOfArgs, string type) {\n"));
  buffer.append("   this->desc.append(desc);\n   numberOfArguments = nrOfArgs;\n   this->type.append(type);\n }\n");
  buffer.append(" error::error() {\n");
  cppOut.write(buffer.c_str(), buffer.length());
  buffer.clear();
  buffer.append(string("  "));
  string value;
  pair<string, string> result;
  buffer = string("  typedef unsigned long long all_errors;\n");
  out.write(buffer.c_str(), buffer.length());
  buffer.clear();

  std::map<std::string, int>::iterator iter;
  for (iter = categories.begin() ; iter != categories.end(); iter++) {
    ostringstream stream;
    stream << "  const unsigned long long _" << iter->first << " = "<< iter->second <<";\n";
    buffer = stream.str();
    out.write(buffer.c_str(), buffer.length());
    buffer.clear();
  }
  for (iter = phases.begin() ; iter != phases.end(); iter++) {
    ostringstream stream;
    stream << "  const unsigned long long _" << iter->first << " = "<< iter->second <<";\n";
    buffer = stream.str();
    out.write(buffer.c_str(), buffer.length());
    buffer.clear();
  }
  for (iter = types.begin() ; iter != types.end(); iter++) {
    ostringstream stream;
    stream << "  const unsigned long long _" << iter->first << " = "<< iter->second <<";\n";
    buffer = stream.str();
    out.write(buffer.c_str(), buffer.length());
    buffer.clear();
  }
  int a = errors.size()-1;
  for(it = errors.begin(); it != errors.end(); ++it) {
    result.first.clear();
    result.second.clear();
    value.append("    ");
    result = computeErrorValue(*it);
    value.append(result.first);
    sprintf(aux, "%d", getNumberOfArguments(it->description));
    buffer.append("   errorData[" + result.second + "] = new description(\"" + it->description + "\", " + string(aux) + ", \"" + it->we + "\");\n");
    value.append(";\n");
    cppOut.write(buffer.c_str(), buffer.length());
    out.write(value.c_str(), value.length());
    --a;
    value.clear();
    buffer.clear();
  }

  buffer.clear();
  buffer.append("\n  class error {\n  public:\n  error();\n  ~error();\n");
  buffer.append(string("\n  std::map<all_errors,  description*> errorData;"));
  out.write(buffer.c_str(), buffer.length());
  buffer.clear();
  sprintf(aux, "%d", digits(categories.size()));
  buffer.append(string("\n  static const unsigned int maxCategoryDigits = ") + string(aux) + string(";\n  "));
  sprintf(aux, "%d", digits(phases.size()));
  buffer.append(string("static const unsigned int maxPhasesDigits = ") + string(aux) + string(";\n  "));
  sprintf(aux, "%d", digits(types.size()));
  buffer.append(string("static const unsigned int maxTypesDigits = ") + string(aux) + string(";\n  "));
  sprintf(aux, "%d", digits(names.size()));
  buffer.append(string("static const unsigned int maxNameDigits = ") + string(aux) + string(";\n  "));

  sprintf(aux, "%zd", (categories.size()));
  buffer.append(string("static const unsigned int nrOfCategories = ") + string(aux) + string(";\n  "));
  sprintf(aux, "%zd", (phases.size()));
  buffer.append(string("static const unsigned int nrOfPhases = ") + string(aux) + string(";\n  "));
  sprintf(aux, "%zd", (types.size()));
  buffer.append(string("static const unsigned int nrOfTypes = ") + string(aux) + string(";\n  "));
  sprintf(aux, "%zd", (names.size()));
  buffer.append(string("static const unsigned int nrOfNames = ") + string(aux) + string(";"));
  out.write(buffer.c_str(), buffer.length());
  buffer.clear();buffer.append("\n };\n}\n\n#endif\n");
  out.write(buffer.c_str(), buffer.length());
  out.close();
  buffer.clear();
  buffer.append(" }\n error::~error() {\n\
   map<all_errors, description*>::iterator it;\n\
   for(it = errorData.begin(); it != errorData.end(); ++it)\n\
    delete it->second;\n}\n}\n");
  cppOut.write(buffer.c_str(), buffer.length());
  cppOut.close();
}
}

int main(int argc, char** argv) {
  try {
    if (argc != 3) {
      string error = "Wrong number of arguments!!!(provide a XML file to parse and an output file name)";
      throw error;
      //cout << "Wrong number of arguments!!!(provide a XML file to parse and an output file name)" << endl;
      //exit(0);
    }
    NSWarnErr::allErrors we;
    we.start(argv[1], argv[2]);
    //we.print();
    //we.print(we.getCategories());
    //we.print(we.getPhases());
    //we.print(we.getTypes());
    //we.print(we.getNames());
  }
  catch (std::string e) {
    std::cout << e << std::endl;
    //    ASSERT(FAIL, "fail");
  }
  return 0;
}
