//----------------------------------------------------------------------
// Copyright (c) 2005-2008 Fastpathlogic
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
//Author: Tb/Derek

#ifndef INC_GUARD_cslcCLI_Support_h_
#define INC_GUARD_cslcCLI_Support_h_

#include "cslcCLI_Typedef.h"

namespace NSCLi {

// *********************************************************************
// CLiCommon struct
// *********************************************************************


  class CLiCommon {
  public:
    static CLiCommon* Instance();
    static void DestroyInstance() {
      delete pinstance;
      pinstance = NULL;
    };

  protected:
    CLiCommon();
    CLiCommon(const CLiCommon&);
    CLiCommon& operator= (const CLiCommon&);
  private:
    static CLiCommon* pinstance;

  public:

    std::string       m_failedPath;
    std::stringstream m_errorMessage;

    CLiTool::ECLiError stringToInt(const std::string& token,
                                   TInt& result);
  
    CLiTool::ECLiFileStat fileStat(const boost::filesystem::path& fsPath,
                                   CLiTool::TAccessRights& fileAccessRights);
    CLiTool::ECLiFileStat canCreateDirectory(const boost::filesystem::path& fsPath);
    CLiTool::ECLiFileStat openFile(const std::string& fileName,
                                   std::fstream& file,
                                   const std::ios_base::openmode fileMode);
    CLiTool::ECLiFileStat deleteFile(const std::string& fileName);

    TBool isAccessRight(const boost::filesystem::path& fsPath,
                        CLiTool::TAccessRights accessMask);
    TBool isFileExtension(const boost::filesystem::path& fsPath,
                          const std::string& fileExt);
    TBool isAbsolutePath(const std::string& path);

    RefString completePath   (const RefString& path);
    RefString getRelativePath(const std::string& path);
    RefString getRoot        (const std::string& path);
    void resolveEnvironmentVars(std::string& token);

    RefString generateRandomFileName( void );

    //  CLiCommon();
  };


} //NSCLi

#endif //INC_GUARD_cslcCLI_Support_h_
