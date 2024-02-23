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
#ifndef INC_GUARD_CSLOM_CPPFileHandler_h
#define INC_GUARD_CSLOM_CPPFileHandler_h

#include "CSLOM.h"
#include "CSLOM_Visitor.h"
#include "CSLOM_Declarations.h"

#include "../support/CommonSupport.h"

#include <iostream>
#include <fstream>
#include <string>
#include <ctime>

#include "CSLOM_CPPFileHandler.h"

using namespace NSCSLOm;

namespace NSCCPPGenerator {


void CUncopyableFile::printCopyright(wRefFile out) {

  ASSERT(out.get(), "Null file !\n");

  (*out) << " // Copyright (c) 2005, 2006, 2007 Fastpathlogic \n";
  (*out) << " // All Rights Reserved. \n";
  (*out) << " // This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic; \n";
  (*out) << " // the contents of this file may not be disclosed to third parties, \n";
  (*out) << " // copied or duplicated in any form, in whole or in part, without the prior \n";
  (*out) << " // written permission of Fastpathlogic. \n";
  (*out) << " // \n";
  (*out) << " // RESTRICTED RIGHTS LEGEND: \n";
  (*out) << " // Use, duplication or disclosure by the Government is subject to \n";
  (*out) << " // restrictions as set forth in subdivision (c)(1)(ii) of the Rights in \n";
  (*out) << " // Technical Data and Computer Software clause at DFARS 252.227-7013, \n";
  (*out) << " // and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement. \n";
  (*out) << " // Unpublished rights reserved under the Copyright Laws of the United States \n";
  (*out) << " //----------------------------------------------------------------------\n";
}

//______________________________________________________________________________________________________________

void CUncopyableFile::printInclude(wRefFile out,string include) {

  ASSERT(out.get(), "Null file !\n");

  if (include[0] == '<') {
    *out << "#include " << include <<"\n\n"; 
  } else {
    *out << "#include \"" << include <<"\"\n\n"; 
  }

}

//______________________________________________________________________________________________________________

void CUncopyableFile::printGenericIncludes(wRefFile out) {

  ASSERT(out.get(), "Null file !\n");

  printInclude(out, "<string>");
  printInclude(out, "../csim/csim.h"); 
  printInclude(out, "../csim/csim_support.h");     

}



CHeaderFile::CHeaderFile(wRefFile file,RefString fileName,RefString headerTitle,RefTMap_RefString_RefString units) : CUncopyableFile(file,fileName) {

  ASSERT(file.get(),"Null file !\n");
  ASSERT(fileName.get(), "Null fileName !\n");
  ASSERT(headerTitle.get(), "Null title\n");
  ASSERT(units.get(),"Null map !\n");

  if (headerTitle) {
    cerr << "File name should not be empty !\n";
  }

  m_name->append(".h");
  m_file->open(m_name->c_str());
  *m_file << "ifndef " << *fileName << "_HEADER\n";
  *m_file << "define " << *fileName << "_HEADER\n";

  printCopyright(m_file);
  
  time_t rawtime;
  time ( &rawtime );      
  *m_file << "   * generated on " << ctime (&rawtime) << "\n";
  *m_file << "   */\n";
  *m_file << "\n\n";
  
  *m_file << "\n\n";
  *m_file << "  /**  \n";
  *m_file << "   *  Declaration for " << *headerTitle << "\n";
  *m_file << "   ***************************************************\n\n";
  
  printIncludeList(units);
  
}

void CHeaderFile::reopen() const {
  m_file->open(m_name->c_str());
}

void CHeaderFile::printIncludeList(RefTMap_RefString_RefString units) {  

  printGenericIncludes(m_file); 
  
  if (exist(units)) {

    RefTVec_RefString includeList = RefTVec_RefString(new TVec_RefString);

    for(TMap_RefString_RefString::const_iterator iter = units->begin(); iter != units->end(); ++iter) {
      includeList->push_back(iter->first);        
    }
    
    for(TVec_RefString::iterator iter = includeList->begin(); iter != includeList->end(); ++iter) {
      for(TVec_RefString::iterator iterChecker = iter; iterChecker != includeList->end(); ++iterChecker) {
        if ( **iter == **iterChecker) {
          includeList->erase(iterChecker);
        }
      }
    }

    for (TVec_RefString::const_iterator iter = includeList->begin(); iter != includeList->end(); ++iter) {
      printInclude(m_file,**iter);
    }   
  }

  *m_file << "\n\n";
}

void CHeaderFile::operator << (std::string msg) {
  *m_file << msg;
}

void CHeaderFile::operator << (const char* msg) {
  *m_file << msg << "\0";
}

void CHeaderFile::close() const {
  m_file->close();
}

CHeaderFile::~CHeaderFile() {
 *m_file << "endif \n";  
  m_file->close();
}


CCplusplusFile::CCplusplusFile(wRefFile file,RefString fileName) : CUncopyableFile(file, fileName) {

  ASSERT(file.get(),"Null file !\n");
  ASSERT(fileName.get(), "Null fileName !\n");
//   ASSERT(headerTitle.get(), "Null title\n");
//   ASSERT(units.get(),"Null map !\n");

  m_name->append(".cpp");
  m_file->open(m_name->c_str());
  printCopyright(m_file);

  time_t rawtime;
  time ( &rawtime );      
  *m_file << "   * generated on " << ctime (&rawtime) << "\n";
  *m_file << "   */\n";
  *m_file << "\n\n";
  
  *m_file << "\n\n";
}

void CCplusplusFile::reopen() const {
  m_file->open(m_name->c_str());
}

void CCplusplusFile::operator << (std::string msg) {
  *m_file << msg;
}

void CCplusplusFile::operator << (const char* msg) {
  *m_file << msg << "\0";
}

void CCplusplusFile::printIncludeList(RefTMap_RefString_RefString units) {
  printInclude(m_file,*m_name);
}

void CCplusplusFile::close() const {
  m_file->close();
}

CCplusplusFile::~CCplusplusFile() {
  m_file->close();
}

}



#endif// INC_GUARD_CSLOM_CPPFileHandler_h

