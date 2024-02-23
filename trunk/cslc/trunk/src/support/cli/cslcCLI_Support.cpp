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

#include "cslcCLI_Typedef.h"
#include "cslcCLI_Support.h"
 
namespace NSCLi {
  
  // *********************************************************************
  // CLiCommon struct
  // *********************************************************************
  //  std::string CLiCommon::m_failedPath = CLiTool::EMPTY_STRING;
  //  std::stringstream CLiCommon::m_errorMessage;

  // *********************************************************************
  // CLiCommon 
  // *********************************************************************

 CLiCommon* CLiCommon::pinstance = 0;// initialize pointer
  CLiCommon* CLiCommon::Instance() 
  {
    if (pinstance == 0)  // is it the first call?
    {  
      pinstance = new CLiCommon; // create sole instance
    }
    return pinstance; // address of sole instance
  }



  // END SINGLETON STUFF

  CLiCommon::CLiCommon(): m_failedPath(CLiTool::Instance()->EMPTY_STRING) {


  }

  CLiTool::ECLiError CLiCommon::stringToInt(const std::string& token,
                                   TInt& result) {

    result = ZERO;
    TBool sign = FALSE;
    std::string::const_iterator tokenChar = token.begin();
    if (*tokenChar == '-') {
      ++tokenChar;
      sign = TRUE;
    }

    for (;
         tokenChar != token.end();
         ++tokenChar) {

      TInt digit = (*tokenChar) - '0';
      if (digit >= CLiTool::Instance()->MIN_DIGIT
          && digit <= CLiTool::Instance()->MAX_DIGIT) {

        result = (result * CLiTool::Instance()->BASE_DEC) + digit;
      }
      else {
        return CLiTool::Instance()->APARSE_NOT_NUMERIC;
      }
    }

    if (sign) {
      result = -result;
    }

    return CLiTool::Instance()->APARSE_SUCCESS;
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  CLiTool::ECLiFileStat CLiCommon::fileStat(const boost::filesystem::path& fsPath,
                                            CLiTool::TAccessRights& fileAccessRights) {

    try {

      if (boost::filesystem::exists(fsPath)) {
        RefString rootString = getRoot(fsPath.string());
        const std::string & str = *rootString.get();
        boost::filesystem::path fsRoot(str, boost::filesystem::native);

    // DEP debug         std::cout << "fileStat:: fsPath.string() :: " << fsPath.string() << " rootString:: " << *rootString << " rs.get :: " << *rootString.get()<< " FSROOT:: " << fsRoot << " str:: " << str << std::endl;

        if (isAccessRight(fsRoot, CLiTool::Instance()->ACCESS_EXECUTE)) {

          fileAccessRights = ZERO;
          if (isAccessRight(fsPath, CLiTool::Instance()->ACCESS_EXECUTE)) {
            fileAccessRights |= CLiTool::Instance()->ACCESS_EXECUTE;
          }
          if (isAccessRight(fsPath, CLiTool::Instance()->ACCESS_READ)) {
            fileAccessRights |= CLiTool::Instance()->ACCESS_READ;
          }
          if (isAccessRight(fsPath, CLiTool::Instance()->ACCESS_WRITE)) {
            fileAccessRights |= CLiTool::Instance()->ACCESS_WRITE;
          }

          if (boost::filesystem::is_directory(fsPath)) {
            return CLiTool::Instance()->FS_IS_DIRECTORY;
          }
          else {
            return CLiTool::Instance()->FS_NOT_DIRECTORY;
          }
        }
        else {
          m_failedPath = fsRoot.string();
          return CLiTool::Instance()->FS_DENIED;
        }
      }
      else {
        return CLiTool::Instance()->FS_NOT_EXISTS;
      }

    }
    catch(boost::filesystem::filesystem_error& e) {
      std::string msg = "\'" + fsPath.string() + "\' : ";
      // DEP 2010-06-06 boost::filesystem::system_error_type err = e.system_error();
      // DEP 2010-06-06 boost::filesystem::system_message(err, msg);

      m_errorMessage.str(msg);
      return CLiTool::Instance()->FS_FAIL;
    }
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  CLiTool::ECLiFileStat CLiCommon::canCreateDirectory(const boost::filesystem::path& fsPath) {
    m_failedPath = fsPath.string();

    CLiTool::TAccessRights fileAccessRights;
    CLiTool::ECLiFileStat result = CLiCommon::fileStat(fsPath, fileAccessRights);
    if (result != CLiTool::Instance()->FS_NOT_EXISTS) {
      return result;
    }
    else {
      m_failedPath = *CLiCommon::getRoot(fsPath.string());

      CLiTool::TAccessRights rootAccessRights;
      result = CLiCommon::fileStat(boost::filesystem::path(m_failedPath, boost::filesystem::native), rootAccessRights);
      if (result == CLiTool::Instance()->FS_IS_DIRECTORY
          && rootAccessRights & CLiTool::Instance()->ACCESS_WRITE) {

        return CLiTool::Instance()->FS_CAN_CREATE;
      }
      else {
        return result;
      }
    }
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  CLiTool::ECLiFileStat CLiCommon::openFile(const std::string& fileName,
                                   std::fstream& file,
                                   const std::ios_base::openmode fileMode) {

    /**
     * ios::app       = 1L << 0, --write
     * ios::ate       = 1L << 1, --write
     * ios::binary    = 1L << 2, --
     * ios::in        = 1L << 3, --read
     * ios::out       = 1L << 4, --write
     * ios::trunc     = 1L << 5, --
     */

    try {

      boost::filesystem::path fsPath(fileName, boost::filesystem::native);
      if (fileMode & std::ios::in
          && !CLiCommon::isAccessRight(fsPath, CLiTool::Instance()->ACCESS_READ)) {

        return CLiTool::Instance()->FS_READ_DENIED;
      }
      else if (fileMode & (std::ios::out
                           | std::ios::app
                           | std::ios::ate)) {

        if (boost::filesystem::exists(fsPath)) {
          if (!CLiCommon::isAccessRight(fsPath, CLiTool::Instance()->ACCESS_WRITE)) {
            return CLiTool::Instance()->FS_WRITE_DENIED;
          }
        }
        else {
          RefString root = CLiCommon::getRoot(fsPath.string());
          const std::string & str = *root.get();

          boost::filesystem::path fsRoot(str, boost::filesystem::native);
          if (!CLiCommon::isAccessRight(fsRoot, CLiTool::Instance()->ACCESS_WRITE | CLiTool::Instance()->ACCESS_EXECUTE)) {
            return CLiTool::Instance()->FS_EXECUTE_WRITE_DENIED;
          }
        }
      }

      file.open(fileName.c_str(), fileMode);
      if (!file) {
        return CLiTool::Instance()->FS_COULD_NOT_OPEN;
      }
      else {
        return CLiTool::Instance()->FS_SUCCESS;
      }

    }
    catch(boost::filesystem::filesystem_error& e) {
      std::string msg = "\'" + fileName + "\' : ";
      // DEP 2010-06-06boost::filesystem::system_error_type err = e.system_error();
      // DEP 2010-06-06boost::filesystem::system_message(err, msg);

      m_errorMessage.str(msg);
      return CLiTool::Instance()->FS_FAIL;
    }
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  CLiTool::ECLiFileStat CLiCommon::deleteFile(const std::string& fileName) {
    try {

      boost::filesystem::path fsPath(fileName, boost::filesystem::native);
      if (!boost::filesystem::exists(fsPath)) {
        return CLiTool::Instance()->FS_NOT_EXISTS;
      }
      else {
    // DEP debug     std::cout << "CLiCommon::deleteFile  fileName:: " << fileName << std::endl;

        RefString rootString = getRoot(fsPath.string());
        const std::string & str = *rootString.get();
        boost::filesystem::path fsRoot(str, boost::filesystem::native);
        if (!CLiCommon::isAccessRight(fsRoot, CLiTool::Instance()->ACCESS_WRITE | CLiTool::Instance()->ACCESS_EXECUTE)) {
          return CLiTool::Instance()->FS_EXECUTE_WRITE_DENIED;
        }
        else {
          ::remove(fsPath.string().c_str());
          return CLiTool::Instance()->FS_SUCCESS;
        }
      }

    }
    catch(boost::filesystem::filesystem_error& e) {
      std::string msg = "\'" + fileName + "\' : ";
      // DEP 2010-06-06boost::filesystem::system_error_type err = e.system_error();
      // DEP 2010-06-06boost::filesystem::system_message(err, msg);

      m_errorMessage.str(msg);
      return CLiTool::Instance()->FS_FAIL;
    }
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  TBool CLiCommon::isAccessRight(const boost::filesystem::path& fsPath,
                                 CLiTool::TAccessRights accessMask) {

# ifdef CSLC_POSIX
    const char* str = fsPath.string().c_str();
    return (   (!(accessMask & CLiTool::Instance()->ACCESS_EXECUTE) || (accessMask & CLiTool::Instance()->ACCESS_EXECUTE && ::access(str, X_OK) == CLiTool::Instance()->APARSE_SUCCESS))
               && (!(accessMask & CLiTool::Instance()->ACCESS_READ   ) || (accessMask & CLiTool::Instance()->ACCESS_READ    && ::access(str, R_OK) == CLiTool::Instance()->APARSE_SUCCESS))
               && (!(accessMask & CLiTool::Instance()->ACCESS_WRITE  ) || (accessMask & CLiTool::Instance()->ACCESS_WRITE   && ::access(str, W_OK) == CLiTool::Instance()->APARSE_SUCCESS)));
# else
    //TODO: perform checks for Windows platforms as well
    return TRUE;
# endif
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  TBool CLiCommon::isFileExtension(const boost::filesystem::path& fsPath,
                                   const std::string& fileExt) {

    if (fileExt.empty()) {
      return TRUE;
    }
    else {
      std::string ext = boost::filesystem::extension(fsPath);

      return (!ext.empty()
              && ext == fileExt);
    }
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  TBool CLiCommon::isAbsolutePath(const std::string& path) {
    return (path[CLiTool::Instance()->START_POSITION] == CLiTool::Instance()->CDIR_DELIMITER
#         ifdef CSLC_WINDOWS
            || path[CLiTool::Instance()->START_POSITION + 1] == ':'
#         endif
            );
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  RefString CLiCommon::completePath(const RefString& path) {
    std::string result = *path;

    if (result[result.size() - 1] != CLiTool::Instance()->CDIR_DELIMITER) {
      //      result.append(DIR_DELIMITER);
      path->append(CLiTool::Instance()->DIR_DELIMITER);
    }

    //    return result;
    return path;
  }

  // *********************************************************************
  // CLiCommon::
  // get the directory part of the path (not including the file name)
  // *********************************************************************

  RefString CLiCommon::getRelativePath(const std::string& path) {
   // DEP debug     std::cout << "getRelativePath:: path:: " << path << std::endl;

    const std::string DIR_DELIMITER = "/";

    std::string::size_type pos = path.rfind(CLiTool::Instance()->DIR_DELIMITER);

    // DEP debug 
    // DEP debug     std::cout << "getRelativePath:: DIR_DELIMITER = " << DIR_DELIMITER  << std::endl;
    // DEP debug     std::cout << "getRelativePath:: pos = " << pos << std::endl;

    //    int endpos = pos != std::string::npos ? pos + 1 : START_POSITION;
    std::string::size_type endpos = pos != std::string::npos ? pos + 1 : CLiTool::Instance()->START_POSITION;

    //   std::cout << "getRelativePath:: path = " << path << " delimiter pos = " << pos << " endpos = " << endpos << std::endl;

    std::string partialPath = path.substr(CLiTool::Instance()->START_POSITION, endpos);
    // DEP debug 
    //    std::cout << "getRelativePath:: path:: " << path << " delimiter pos:: " << pos << " npos:: " << std::string::npos  << " START_POSITION:: "  << START_POSITION  << " partialPath:: "  << partialPath << std::endl << std::endl;

    RefString str(new std::string(partialPath));

//    std::cout << "getRelativePath:: path:: " << path << std::endl;
//    std::cout << "getRelativePath:: partialPath:: " << partialPath << std::endl;
//    std::cout << "getRelativePath:: str:: " << *str << std::endl;

    return str;
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  RefString CLiCommon::getRoot(const std::string& path) {
    
    // DEP debug     std::cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" << std::endl;
    // DEP debug     std::cout << "CLiCommon::getRoot path  :: " << path << std::endl;

    RefString result = getRelativePath(path);
    //std::cout << "CLiCommon::getRoot CURRENT_DIR  :: " << CURRENT_DIR << std::endl;
    assert(result);

    //    TBool pathEmpty  = path.empty();
    TBool pathEmpty  = (*result).empty();
    //    std::cout << " path empty :: " << pathEmpty<< std::endl;
    //    std::cout << " CURRENT_DIR :: " << CURRENT_DIR<< std::endl;
    std::string str = pathEmpty ? CLiTool::Instance()->CURRENT_DIR : *result;

    // DEP debug     
    //std::cout << "getRoot::path:: " << path << " rootString result:: " << result << " path empty :: " << pathEmpty<< " result :: " << (*result) << " CURRENT_DIR:: " << CURRENT_DIR << " str:: " << str << std::endl;

    RefString retval(new std::string(str));

    return retval;
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  void CLiCommon::resolveEnvironmentVars(std::string& token) {
    std::string::size_type beginPos = CLiTool::Instance()->START_POSITION;
    std::string::size_type endPos = CLiTool::Instance()->START_POSITION;

    do {
      beginPos = token.find_first_of(CLiTool::Instance()->BEGIN_ENV_VAR_NAME, beginPos);

      if (beginPos != std::string::npos) {
        endPos = token.find_first_of(CLiTool::Instance()->END_ENV_VAR_NAME, ++beginPos);

        std::string envName = token.substr(beginPos, -beginPos + (endPos != std::string::npos
#                                                               ifdef CSLC_WINDOWS
                                                                  ? ++endPos
#                                                               else
                                                                  ? endPos
#                                                               endif
                                                                  : token.size()));

        TChar* envValue = getenv(envName.c_str());
        if (envValue != static_cast<TChar*>(NULL)) {
          token.erase(--beginPos, endPos);
          token.insert(beginPos, envValue);
        }
      }
      else {
        break;
      }
    } while (TRUE);
  }

  // *********************************************************************
  // CLiCommon::
  // *********************************************************************

  RefString CLiCommon::generateRandomFileName( void ) {

    std::string result = CLiTool::Instance()->EMPTY_STRING;
//    std::string baseName = (tmpDir == NULL
//                            ? CLiTool::Instance()->CURRENT_DIR
//                            : tmpDir);
//
//    if (tmpPrefix != NULL) {
//      baseName.append(tmpPrefix);
//    }
//

    std::string baseName = CLiTool::Instance()->CURRENT_DIR;

    baseName.append(NSCLi::CLiTool::Instance()->TMP_NAME_PREFIX);


    TUInt attempt = ZERO;
    while (attempt < CLiTool::Instance()->TMP_MAX_GEN_ATTEMPTS) {

      result = baseName;
      TUInt charsToGen = NSCLi::CLiTool::Instance()->TMP_NAME_SIZE;
      while (charsToGen > (TUInt)ZERO) {
        TChar newChar = (std::rand() % 2
                         ? 'a'
                         : 'A');

        newChar += std::rand() % CLiTool::Instance()->ASCII_ALPHA_COUNT;
        result.append(1, newChar);

        --charsToGen;
      }

      boost::filesystem::path fsPath(result, boost::filesystem::native);
      try {

        if (!boost::filesystem::exists(fsPath)) {
          RefString retval(new std::string(result));
          return retval;
        }

      }
      catch(boost::filesystem::filesystem_error& e) {
        std::string msg = "\'" + fsPath.string() + "\' : ";
        // DEP 2010-06-06 boost::filesystem::system_error_type err = e.system_error();
        // DEP 2010-06-06  boost::filesystem::system_message(err, msg);

        m_errorMessage.str(msg);
        
        RefString retval(new std::string(CLiTool::Instance()->EMPTY_STRING));
        return retval;
      }

      ++attempt;
    }

    RefString retval(new std::string(CLiTool::Instance()->EMPTY_STRING));
    return retval;
  }

} //NSCLi
