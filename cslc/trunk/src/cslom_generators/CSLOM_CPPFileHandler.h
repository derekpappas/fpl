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


#include "CSLOM_CPP_Generator.h"

using namespace NSCSLOm;
using namespace std;

namespace NSCCPPGenerator {

class CCplusplusFile;
class CHeaderFile;

class CUncopyableFile{

  public :

/*
  // DEP 2010-01-15
	CUncopyableFile(wRefFile file,RefString name)  : m_file(file), m_name(name) { }

    static void printCopyright(wRefFile);

    static void printGenericIncludes(wRefFile);

    static void printInclude(wRefFile,std::string);
*/

  protected :
    
    wRefFile  m_file;

    RefString m_name;


    CUncopyableFile();

    CUncopyableFile(CUncopyableFile&);

    CUncopyableFile& operator = (CUncopyableFile&);


    virtual void printIncludeList(RefTMap_RefString_RefString)=0;

};

class CHeaderFile : public CUncopyableFile{ 

    void printIncludeList(RefTMap_RefString_RefString);

  public :

    CHeaderFile(wRefFile, RefString, RefString, RefTMap_RefString_RefString);

    ~CHeaderFile();

    void reopen() const;

    void close() const;

    void operator << (std::string);

    void operator << (const char*);
    
};

class CCplusplusFile : public CUncopyableFile{

    void printIncludeList(RefTMap_RefString_RefString);

  public :

    CCplusplusFile(wRefFile,RefString);
 
    ~CCplusplusFile();

    void reopen() const;

    void close() const;

    void operator << (std::string);

    void operator << (const char*);

};

}
