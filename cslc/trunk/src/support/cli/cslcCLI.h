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
//Author: Tb

#ifndef INC_GUARD_cslcCLI_h_
#define INC_GUARD_cslcCLI_h_

#include "cslcCLI_Support.h"


namespace NSCLi {

  using NSCLi::CLiTool;

// *********************************************************************
// CLiArgumentBase class
// *********************************************************************
class CLiArgumentBase {
  protected:
    WeakRefCLiArgumentBase                      m_selfRef;
    RefString                                   m_argToken;

  private:
    CLiTool::ECLiArgumentType                            m_argType;

    WeakRefCLiArgumentList                      m_parent;

    RefTVec_RefString                           m_keyWordList;

    THandler                                    m_handler;

    TBool                                       m_multiple;
    TBool                                       m_selected;

  public:
    virtual ~CLiArgumentBase();

    TBool isEmpty() const;
    TBool isNumber() const;
    TBool isOption() const;
    TBool isFileName() const;
    TBool isDirName() const;
    TBool isCslDefine() const;
    TBool isVerilogDefine() const;
    TBool isVerilogDirList() const;
    TBool isVerilogExtList() const;
    TBool isVerilogSpecial() const;

    TVec_RefString_iter findKeyWord(const std::string& token);
    TBool isKeyWord(const std::string& token);

    CLiTool::ECLiError execHandler(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);

    RefString getArgToken() const;

  protected:
    CLiArgumentBase(CLiTool::ECLiArgumentType argType,
                    const RefCLiArgumentList& parent,
                    const RefTVec_RefString& keyWordList,
                    const THandler& handler,
                    TBool multiple);

    virtual CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                                  TVec_RefCLiToken_iter& tokenIndex) = 0;

    RefCLiArgumentList getParent() const;

  private:
    RefCLiArgumentBase getThis() const;
};

// *********************************************************************
// CLiArgumentEmpty class
// *********************************************************************
class CLiArgumentEmpty : public CLiArgumentBase {
  public:
    virtual ~CLiArgumentEmpty();

    static RefCLiArgumentEmpty build(const RefCLiArgumentList& parent,
                                     const RefTVec_RefString& keyWordList,
                                     const THandler& handler,
                                     TBool multiple);

    static RefCLiArgumentEmpty cast(const RefCLiArgumentBase& argBase);

  private:
    CLiArgumentEmpty(const RefCLiArgumentList& parent,
                     const RefTVec_RefString& keyWordList,
                     const THandler& handler,
                     TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);
};

// *********************************************************************
// CLiArgumentNumber class
// *********************************************************************
class CLiArgumentNumber : public CLiArgumentBase {
  private:
    TInt                                        m_lowerBound;
    TInt                                        m_upperBound;
    TInt                                        m_value;

  public:
    virtual ~CLiArgumentNumber();

    static RefCLiArgumentNumber build(const RefCLiArgumentList& parent,
                                      const RefTVec_RefString& keyWordList,
                                      const THandler& handler,
                                      TBool multiple,
                                      TInt lowerBound,
                                      TInt upperBound);

    static RefCLiArgumentNumber cast(const RefCLiArgumentBase& argBase);

    TInt getValue() const;

  private:
    CLiArgumentNumber(const RefCLiArgumentList& parent,
                      const RefTVec_RefString& keyWordList,
                      const THandler& handler,
                      TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);
};

// *********************************************************************
// CLiArgumentOption class
// *********************************************************************
class CLiArgumentOption : public CLiArgumentBase {
  private:
    RefTVec_RefString                           m_optionList;
    RefString                                   m_selOption;

  public:
    virtual ~CLiArgumentOption();

    static RefCLiArgumentOption build(const RefCLiArgumentList& parent,
                                      const RefTVec_RefString& keyWordList,
                                      const THandler& handler,
                                      TBool multiple,
                                      const RefTVec_RefString& optionList);

    static RefCLiArgumentOption cast(const RefCLiArgumentBase& argBase);

    RefString getSelOption() const;

  private:
    CLiArgumentOption(const RefCLiArgumentList& parent,
                      const RefTVec_RefString& keyWordList,
                      const THandler& handler,
                      TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);

    TBool isValidOption(const std::string& opt) const;
};

// *********************************************************************
// CLiArgumentFileName class
// *********************************************************************
class CLiArgumentFileName : public CLiArgumentBase {
  private:
    TBool                                       m_mustExist;
    RefString                                   m_fileExt;
    RefString                                   m_fileName;

  public:
    virtual ~CLiArgumentFileName();

    static RefCLiArgumentFileName build(const RefCLiArgumentList& parent,
                                        const RefTVec_RefString& keyWordList,
                                        const THandler& handler,
                                        TBool multiple,
                                        TBool mustExist,
                                        const RefString& fileExt);

    static RefCLiArgumentFileName cast(const RefCLiArgumentBase& argBase);

    RefString getFileName() const;

  private:
    CLiArgumentFileName(const RefCLiArgumentList& parent,
                        const RefTVec_RefString& keyWordList,
                        const THandler& handler,
                        TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);
};

// *********************************************************************
// CLiArgumentDirName class
// *********************************************************************
class CLiArgumentDirName : public CLiArgumentBase {
  private:
    TBool                                       m_mustExist;
    TBool                                       m_mustCreate;
    RefString                                   m_dirName;

  public:
    virtual ~CLiArgumentDirName();

    static RefCLiArgumentDirName build(const RefCLiArgumentList& parent,
                                       const RefTVec_RefString& keyWordList,
                                       const THandler& handler,
                                       TBool multiple,
                                       TBool mustExist);

    static RefCLiArgumentDirName cast(const RefCLiArgumentBase& argBase);

    RefString getDirName() const;
    TBool getMustCreate() const;

  private:
    CLiArgumentDirName(const RefCLiArgumentList& parent,
                       const RefTVec_RefString& keyWordList,
                       const THandler& handler,
                       TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);
};

// *********************************************************************
// CLiArgumentCslDefine class
// *********************************************************************
class CLiArgumentCslDefine : public CLiArgumentBase {
  private:
    RefString                                   m_macroDef;

  public:
    virtual ~CLiArgumentCslDefine();

    static RefCLiArgumentCslDefine build(const RefCLiArgumentList& parent,
                                         const RefTVec_RefString& keyWordList,
                                         const THandler& handler,
                                         TBool multiple);

    static RefCLiArgumentCslDefine cast(const RefCLiArgumentBase& argBase);

    RefString getMacroDef() const;

  private:
    CLiArgumentCslDefine(const RefCLiArgumentList& parent,
                         const RefTVec_RefString& keyWordList,
                         const THandler& handler,
                         TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);
};

// *********************************************************************
// CLiArgumentVerilogDefine class
// *********************************************************************
class CLiArgumentVerilogDefine : public CLiArgumentBase {
  private:
    RefString                                   m_verilogDefine;

  public:
    virtual ~CLiArgumentVerilogDefine();

    static RefCLiArgumentVerilogDefine build(const RefCLiArgumentList& parent,
                                             const RefTVec_RefString& keyWordList,
                                             const THandler& handler,
                                             TBool multiple);

    static RefCLiArgumentVerilogDefine cast(const RefCLiArgumentBase& argBase);

    RefString getVerilogDefine() const;

  private:
    CLiArgumentVerilogDefine(const RefCLiArgumentList& parent,
                             const RefTVec_RefString& keyWordList,
                             const THandler& handler,
                             TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);
};

// *********************************************************************
// CLiArgumentVerilogDirList class
// *********************************************************************
class CLiArgumentVerilogDirList : public CLiArgumentBase {
  private:
    TBool                                       m_mustExist;
    RefTVec_RefString                           m_verilogDirList;

  public:
    virtual ~CLiArgumentVerilogDirList();

    static RefCLiArgumentVerilogDirList build(const RefCLiArgumentList& parent,
                                              const RefTVec_RefString& keyWordList,
                                              const THandler& handler,
                                              TBool multiple,
                                              TBool mustExist);

    static RefCLiArgumentVerilogDirList cast(const RefCLiArgumentBase& argBase);

    RefTVec_RefString getVerilogDirList() const;

  private:
    CLiArgumentVerilogDirList(const RefCLiArgumentList& parent,
                              const RefTVec_RefString& keyWordList,
                              const THandler& handler,
                              TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);
};

// *********************************************************************
// CLiArgumentVerilogExtList class
// *********************************************************************
class CLiArgumentVerilogExtList : public CLiArgumentBase {
  private:
    RefTVec_RefString                           m_verilogExtList;

  public:
    virtual ~CLiArgumentVerilogExtList();

    static RefCLiArgumentVerilogExtList build(const RefCLiArgumentList& parent,
                                              const RefTVec_RefString& keyWordList,
                                              const THandler& handler,
                                              TBool multiple);

    static RefCLiArgumentVerilogExtList cast(const RefCLiArgumentBase& argBase);

    RefTVec_RefString getVerilogExtList() const;

  private:
    CLiArgumentVerilogExtList(const RefCLiArgumentList& parent,
                              const RefTVec_RefString& keyWordList,
                              const THandler& handler,
                              TBool multiple);

    CLiTool::ECLiError parseParams(const RefTVec_RefCLiToken& tokenList,
                          TVec_RefCLiToken_iter& tokenIndex);
};

// *********************************************************************
// CLiToken class
// *********************************************************************
class CLiToken {
  private:
    RefString                                   m_token;
    RefString                                   m_relativePath;

  public:
    CLiToken(const std::string& token,
             const std::string& relativePath = CLiTool::Instance()->EMPTY_STRING);

    const std::string& getString(CLiTool::ETokenGet what) const;
};

// *********************************************************************
// CLiArgumentList class
// *********************************************************************
class CLiArgumentList {
  private:
    WeakRefCLiArgumentList                      m_selfRef;

    RefTVec_RefCLiArgumentBase                  m_acceptedArguments;

    RefTVec_RefCLiToken                         m_tokenList;
    TVec_RefCLiToken_iter                       m_tokenIndex;

    /** general purpose
     */
    RefString                                   m_outputDirectory;
    TBool                                       m_mustCreateOutputDirectory;
    RefString                                   m_configFile;
    RefTVec_RefString                           m_cliFiles;

    /** CSL specific
     */
    RefTVec_RefString                           m_cslSourceFiles;
    CLiTool::ECSLcPpOption                               m_cslPp;
    RefString                                   m_cslPpFile;
    RefString                                   m_cslItFile;
    TBool                                       m_cslPrintIt;
    TBool                                       m_cppGen;
    TBool                                       m_csimGen;
    TBool                                       m_verilogTbGen;
    TBool                                       m_verilogStimExpGen;
    TInt                                        m_cslMaxErr;
    TInt                                        m_cslMaxWarn;
    RefTVec_RefString                           m_cslIncludeDirectories;
    RefTVec_RefString                           m_cslMacroDefinitions;
    RefTVec_RefString                           m_cslVfIncludeDirectories;
    RefTVec_RefString                           m_cslVfIncludeFiles;
    RefTVec_RefString                           m_cslVerilogIncludeFiles;

    /** Verilog specific
     */
    RefTVec_RefString                           m_verilogSourceFiles;
    CLiTool::ECSLcPpOption                               m_verilogPp;
    RefString                                   m_verilogPpFile;
    RefTVec_RefString                           m_verilogLibraryDirectories;
    RefTVec_RefString                           m_verilogLibraryFiles;
    RefTVec_RefString                           m_verilogMacroDefinitions;
    RefTVec_RefString                           m_verilogIncludeDirectories;
    RefTVec_RefString                           m_verilogLibraryExtensions;
    TBool                                       m_verilogLibNoNameHide;
    TBool                                       m_verilogLibOrder;
    TBool                                       m_verilogLibRescan;

#   ifndef __RELEASE_VERSION
    /** debug only
     */
    TBool                                       m_displayInfo;
    TBool                                       m_displayCslomAst;
    TBool                                       m_displayCdomAst;
    CLiTool::ECSLcExecStage                              m_execStage;
    CLiTool::ECSLcVExecStage                             m_vExecStage;
#   endif

  public:
    CLiTool::ECLiError parseArgumentList(TInt argc,
                                TChar** argv);

    static RefCLiArgumentList build();

    /** general purpose get functions
     */
    RefString getOutputDirectory() const       { return m_outputDirectory; }
    TBool getMustCreateOutputDirectory() const { return m_mustCreateOutputDirectory; }
    RefString getConfigFile()const             { return m_configFile; }

    /** CSL specific get functions
     */
    RefTVec_RefString getCslSourceFiles() const         { return m_cslSourceFiles; }
    CLiTool::ECSLcPpOption getCslPp() const                      { return m_cslPp; }
    RefString getCslPpFile() const                      { return m_cslPpFile; }
    RefString getCslItFile() const                      { return m_cslItFile; }
    TBool getCslPrintIt() const                         { return m_cslPrintIt; }
    TInt getCslMaxErr() const                           { return m_cslMaxErr; }
    TInt getCslMaxWarn() const                          { return m_cslMaxWarn; }
    TBool getCppGen() const                             { return m_cppGen; }
    TBool getCsimGen() const                            { return m_csimGen; }
    TBool getVerilogTbGen() const                       { return m_verilogTbGen; }
    TBool getVerilogStimExpGen() const                  { return m_verilogStimExpGen; }
    RefTVec_RefString getCslIncludeDirectories() const  { return m_cslIncludeDirectories; }
    RefTVec_RefString getCslMacroDefinitions() const    { return m_cslMacroDefinitions; }
    RefTVec_RefString getCslVfIncludeFiles() const      { return m_cslVfIncludeFiles; }
    RefTVec_RefString getCslVerilogIncludeFiles() const { return m_cslVerilogIncludeFiles; }
    RefString getVfIncdir() const;

    /** Verilog specific get functions
     */
    RefTVec_RefString getVerilogSourceFiles() const        { return m_verilogSourceFiles; }
    CLiTool::ECSLcPpOption getVerilogPp() const                     { return m_verilogPp; }
    RefString getVerilogPpFile()const                      { return m_verilogPpFile; }
    RefTVec_RefString getVerilogIncludeDirectories() const { return m_verilogIncludeDirectories; }
    RefTVec_RefString getVerilogMacroDefinitions() const   { return m_verilogMacroDefinitions; }

#   ifndef __RELEASE_VERSION
    /** debug only get functions
     */
    TBool getDisplayInfo() const          { return m_displayInfo; }
    TBool getDisplayCslomAst() const      { return m_displayCslomAst; }
    TBool getDisplayCdomAst() const       { return m_displayCdomAst; }
    CLiTool::ECSLcExecStage getExecStage() const   { return ((m_execStage == CLiTool::EXEC_STAGE_NO_SELECTION)
                                                    ? (CLiTool::EXEC_STAGE_CDOM_CODE_GENS)
                                                    : (m_execStage)); }
    CLiTool::ECSLcVExecStage getVExecStage() const { return ((m_vExecStage == CLiTool::VEXEC_STAGE_NO_SELECTION)
                                                    ? (CLiTool::VEXEC_STAGE_CDOM_CODE_GENS)
                                                    : (m_vExecStage)); }
#   endif

  private:
    CLiArgumentList();

    RefCLiArgumentList getThis();

    /** parser related functions
     */
    TVec_RefCLiArgumentBase_const_iter findArgument(const std::string& token);

    TBool isCslFile(const boost::filesystem::path& fileName) const;
    TBool isVerFile(const boost::filesystem::path& fileName) const;
    TBool isSourceFile(const boost::filesystem::path& fileName) const;

    TVec_RefString_iter findToken(const RefTVec_RefString& tokenList,
                                  const std::string& token);

    TVec_RefCLiToken_iter findToken(const RefTVec_RefCLiToken& tokenList,
                                    const std::string& token);

    void addCslFile(const std::string& fileName);
    void addVerFile(const std::string& fileName);
    void addSourceFile(const std::string& fileName);

    void addCliFileArguments(const RefTVec_RefCLiToken& argumentList);
    CLiTool::ECLiError parseCliFile(const std::string& fileName);

    /** build functions for accepted CLI arguments
     */
    RefTVec_RefString buildKeyWordList(const std::string& keyWord1,
                                       const std::string& keyWord2);
    void buildArgumentEmpty(const THandler& handler,
                            TBool multiple,
                            const std::string& keyWord1,
                            const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentNumber(const THandler& handler,
                             TBool multiple,
                             TInt lowerBound,
                             TInt upperBound,
                             const std::string& keyWord1,
                             const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentFileName(const THandler& handler,
                               TBool multiple,
                               TBool mustExist,
                               const std::string& fileExt,
                               const std::string& keyWord1,
                               const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentDirName(const THandler& handler,
                              TBool multiple,
                              TBool mustExist,
                              const std::string& keyWord1,
                              const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentOptionList(const THandler& handler,
                                 TBool multiple,
                                 const RefTVec_RefString& optionList,
                                 const std::string& keyWord1,
                                 const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentCslDefine(const THandler& handler,
                                TBool multiple,
                                const std::string& keyWord1,
                                const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentVerilogDefine(const THandler& handler,
                                    TBool multiple,
                                    const std::string& keyWord1,
                                    const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentVerilogDirList(const THandler& handler,
                                     TBool multiple,
                                     TBool mustExist,
                                     const std::string& keyWord1,
                                     const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentVerilogExtList(const THandler& handler,
                                     TBool multiple,
                                     const std::string& keyWord1,
                                     const std::string& keyWord2 = CLiTool::Instance()->EMPTY_STRING);
    void buildArgumentList();

    /** handler functions for arguments
     */
    //---------------general purpose-----------------------------------------//
    CLiTool::ECLiError execArgHelp(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgDir(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgConfigFile(const RefCLiArgumentBase& argBase);

    //---------------CSL specific-----------------------------------------//
    CLiTool::ECLiError execArgCslPp(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslPpFileName(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslPrintIt(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslPrintItFileName(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCppGen(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCsimGen(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgVerilogTbGen(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgVerilogStimExpGen(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslMaxError(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslMaxWarning(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgI(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgD(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgVfIncdir(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslIncludeVf(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslIncludeVerilog(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslF(const RefCLiArgumentBase& argBase);

    //---------------Verilog specific-----------------------------------------//
    CLiTool::ECLiError execArgVerilogPp(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgVerilogPpFileName(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgY(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgV(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgPrj(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgDefine(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgIncdir(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgLibExt(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgLibNoNameHide(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgLibOrder(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgLibRescan(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgVerF(const RefCLiArgumentBase& argBase);

#   ifndef __RELEASE_VERSION
    //---------------Debug only-----------------------------------------//
    CLiTool::ECLiError execArgInfo(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCdomAst(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgCslomAst(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgExecutionStage(const RefCLiArgumentBase& argBase);
    CLiTool::ECLiError execArgVExecutionStage(const RefCLiArgumentBase& argBase);
#   endif

    CLiTool::ECSLcPpOption getPpOption(RefString opt) const;
};

// *********************************************************************
// CLiError class
// *********************************************************************
class CLiError {
    friend class CLiCommon;
    friend class CLiArgumentBase;
    friend class CLiArgumentEmpty;
    friend class CLiArgumentNumber;
    friend class CLiArgumentOption;
    friend class CLiArgumentFileName;
    friend class CLiArgumentDirName;
    friend class CLiArgumentCslDefine;
    friend class CLiArgumentVerilogDefine;
    friend class CLiArgumentVerilogDirList;
    friend class CLiArgumentVerilogExtList;
    friend class CLiArgumentList;

  private:
    static std::stringstream                    m_helpMessage;
    static std::stringstream                    m_warnMessage;
    static std::stringstream                    m_errMessage;

  public:
    static std::string getError();
    static std::string getWarning();
    static std::string getHelp();

  private:
    CLiError();

    static void buildHelp();

    static void buildWarning(CLiTool::ECLiWarning warn,
                             const std::string& token);
    static void buildError(CLiTool::ECLiError err);
    static void buildError(CLiTool::ECLiError err,
                           const std::string& token);
    static void buildError(CLiTool::ECLiError err,
                           const std::string& token1,
                           const std::string& token2);
    static void buildError(CLiTool::ECLiError err,
                           const std::string& token1,
                           const TInt token2);

};

} //NSCLi

#endif //INC_GUARD_cslcCLI_h_
