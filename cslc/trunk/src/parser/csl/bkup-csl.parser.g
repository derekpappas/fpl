//----------------------------------------------------------------------
// Copyright (c) 2006, 2007 Fastpath Logic,Inc 
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpath Logic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpath Logic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set_ forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

/*
 *   Part of the Csl_ parser
 *   Authors: Eugen Cazacu & 
 *            Alina Patelli & 
 *            Gabriel Dramba &
 *            Stolnicu Octavian
 *   2005-2006-2007
 */

//****************************************************************************************//
//****************************************************************************************//
//****************************** WARNING! ************************************************//
//*  IF YOU ARE NOT IN CHARGE OF THE PARSER YOU ARE PROBABLY NOT ALLOWED TO MODIFY THIS  *//
//********************* DON'T TOUCH IT - I KILL YOU! *************************************//
//****************************************************************************************//
//****************************************************************************************//


header "post_include_hpp" {
#include "Def.hpp"
#include "CslNumber.hpp"
#include "CslToken.hpp"
#include "CslAST.hpp"
#include "SymTree.h"
#define DEBUG_PARSER
}


options {
  language = "Cpp";
}

{
#define _RS(str) RefString(new string(str))

  ANTLR_USING_NAMESPACE(antlr);


#include "Base.hpp"
#include "../../csl_xml_warn_error/CSLC_Errors.h"
#include "../../csl_xml_warn_error/we_logic.h"
#include "../../support/CommonSupport.h"
#include "../../cslom/CSLOM_Declarations.h"

//*** type declartations ***//
//**********************************************************************************************************************//
typedef std::vector<antlr::RefCslAST>                                                                                   TVec_RefCslAST;
typedef TVec_RefCslAST::iterator                                                                                        TVec_RefCslAST_iterator;
typedef boost::shared_ptr<TVec_RefCslAST>                                                                               RefTVec_RefCslAST;
typedef boost::shared_ptr<std::stringstream>                                                                            RefStringstream;
typedef long int                                                                                                        TLInt;
typedef std::pair<TInt, TInt>                                                                                           TPair_TInt_TInt;
typedef std::pair<TInt , TPair_TInt_TInt>                                                                               TPair_TInt_TPair_TInt_TInt;
typedef std::map<NSSymbolTable::EObjType, TPair_TInt_TPair_TInt_TInt>                                                   TMap_EObjType_TPair_TInt_TPair_TInt_TInt;
typedef TMap_EObjType_TPair_TInt_TPair_TInt_TInt::iterator                                                              TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator;
typedef boost::shared_ptr<TMap_EObjType_TPair_TInt_TPair_TInt_TInt>                                                     RefTMap_EObjType_TPair_TInt_TPair_TInt_TInt;
typedef std::map<NSSymbolTable::EObjType, TInt>                                                                         TMap_EObjType_TInt;
typedef TMap_EObjType_TInt::iterator                                                                                    TMap_EObjType_TInt_iterator;
typedef boost::shared_ptr<TMap_EObjType_TInt>                                                                           RefTMap_EObjType_TInt;
typedef std::pair<RefTMap_EObjType_TInt, RefTMap_EObjType_TInt>                                                         TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt;
typedef std::pair<TInt, TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt>                                              TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt;
typedef std::map<RefString, TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt, NSCSLOm::less_RefString>      TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt;
typedef TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt::iterator                           TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator;
typedef boost::shared_ptr<TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt>                  RefTMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt;
typedef boost::shared_ptr<char>                                                                                         RefChar;
//**********************************************************************************************************************//


//*** extern var that tells the main if parser has errors ***//
extern TBool cslParserHasErrors;

//*** symbol tree namespace ***//
using namespace NSSymbolTable;
//*** symbol tree object ***//
RefCSymTree symTree = RefCSymTree(new CSymTree());

//*** masks for scope holders from symTree ***//
TInt ALL_SCOPE_HOLDERS_AND_DESIGN = NSSymbolTable::TDESIGN | NSSymbolTable::TFIELD_DECL | NSSymbolTable::TFIFO_DECL
  | NSSymbolTable::TIFC_DECL | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL | NSSymbolTable::TMEMMAP_DECL
  | NSSymbolTable::TMEMMAPP_DECL | NSSymbolTable::TRF_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TMEM_DECL
  | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TVEC_DECL |  NSSymbolTable::TSTATED_DECL;


TInt ALL_SCOPE_HOLDERS_NO_DESIGN = NSSymbolTable::TFIELD_DECL | NSSymbolTable::TFIFO_DECL
  | NSSymbolTable::TIFC_DECL | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL | NSSymbolTable::TMEMMAP_DECL
  | NSSymbolTable::TMEMMAPP_DECL | NSSymbolTable::TRF_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TMEM_DECL
  | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TVEC_DECL |  NSSymbolTable::TSTATED_DECL;



//*** FILENAME + LINE TRACKING ***/
//************************************************************************//
struct FilenameLineStruct {
  private:
    RefString                   m_filename                           ;
    TInt                        m_lineDifference                     ;
  public:
    void                        setFilename(RefString )              ;
    void                        setLine    (TInt, TInt)              ;
    RefString                   getFilename()                        ;
    TInt                        getLine(TInt)                        ;
    string                      operator*() { return *m_filename; }  ;
    TBool                       wasFilenameSet()                     ;
};

void FilenameLineStruct::setFilename(RefString filename) {
  ASSERT(filename.get()    , "PARSER - null filename" );
  ASSERT(!filename->empty(), "PARSER - empty filename");

  m_filename = filename;
}

void FilenameLineStruct::setLine(TInt currentLine, TInt actualLine) {
  ASSERT(-1 <= currentLine && 0 <= actualLine , "PARSER - invalid line");

  m_lineDifference = currentLine + 1 - actualLine;
  if (0 != m_lineDifference) { m_lineDifference *= (-1); }
}

RefString  FilenameLineStruct::getFilename() {
  ASSERT(m_filename.get(), "PARSER - null filename requested");
  
  return m_filename;
}

TInt FilenameLineStruct::getLine(TInt currentLine) {
  ASSERT(0 <= currentLine, "PARSER - invalid line");
  
  return currentLine + m_lineDifference;
}

TBool FilenameLineStruct::wasFilenameSet() {
  return m_filename;
}
//************************************************************************//


//*** FILENAME + LINE TRACKER ***//
FilenameLineStruct currentFilename;


//*** error throwing for type declaration***//
void throwDeclarationError(RefString typeName, RefString error, TInt line, TInt column) {
  ASSERT(typeName.get()   && error.get()  , "PARSER - null type or error received"     );
  ASSERT(typeName->size() && error->size(), "PARSER - type or error of size 0 received");
  ASSERT(0 <= line        && 0 <= column  , "PARSER - invalid line or column received" );
  
  RefString message = _RS("'");
  message->append( *typeName               );
  message->append( "' declaration error : ");
  message->append( *error                  );
  
  throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*message, *currentFilename, line, column);
}


//*** error throwing for commands ***//
void throwCommandError(RefString commandName, RefString error, TInt line, TInt column) {
  ASSERT(commandName.get()   && error.get()  , "PARSER - null command or error received"     );
  ASSERT(commandName->size() && error->size(), "PARSER - command or error of size 0 received");
  ASSERT(0 <= line           && 0 <= column  , "PARSER - invalid line or column received"    );

  RefString message = _RS("command '"          );
  message->append( *commandName);
  message->append( "' error : ");
  message->append( *error      );
  
  throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*message, *currentFilename, line, column);
}


//*** error throwing for other ***//
void throwError(RefString error, TInt line, TInt column) {
  ASSERT(0 <= line           && 0 <= column  , "PARSER - invalid line or column received"    );
  ASSERT(error.get()                         , "PARSER - null error received"                );
  ASSERT(error->size()                       , "PARSER - error of size 0 received"           );

  RefString message = _RS("error : " );
  message->append( *error);
  
  throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*message, *currentFilename, line, column);
}



//*** sets the real filename + line and sets the column if the ast received is a fake vertex for a CslAST***//
void setCurrentFilename(RefCslAST tag, TInt column = -1, TInt line = -1) {
  ASSERT(tag.get(), "PARSER - null tag received");
  
  tag->setFilename(*currentFilename);

  if (-1 == line) { tag->setLine(currentFilename.getLine(tag->getLine())); }
  else { tag->setLine(line); }

  if (-1 == column) { tag->setColumn(tag->getColumn()); }
  else { tag->setColumn(column); }
}


/*** stringToInt ***/
/******************************************************************************************/
TInt stringToInt(RefString str) {
  ASSERT(str.get(), "null string");
  ASSERT(str->size(), "0 sized string");
  TInt returnVal = -1;
  for (int i = 0; i < str->size() ; ++i) {
    RefChar ch = RefChar(new char(str->at(i)));
    ASSERT(48 <= *ch && 57 >= *ch, "invalid string received(non numerical value)");
    if (-1 == returnVal) { returnVal = *ch % 48; }
    else { returnVal = returnVal * 10 + (*ch % 48); }
  }
  return returnVal;
}

/*** typeToStr ***/
/***************************************************************************/
void typeToStr(TInt mask, RefString& output, TBool onlyScopeHolder = FALSE) {

  if (!output.get()) {
    output = _RS();
  }

  if (NSSymbolTable::TDESIGN & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "design");
  } 
  if (NSSymbolTable::TFIELD_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_field");
  }
  if (NSSymbolTable::TFIFO_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_fifo");
  }
  if (NSSymbolTable::TIFC_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_interface");
  }
  if (NSSymbolTable::TISAE_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_isa_element");
  }
  if (NSSymbolTable::TISAF_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_isa_field");
  }
  if (NSSymbolTable::TMEMMAP_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_memory_map");
  }
  if (NSSymbolTable::TMEMMAPP_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_memory_map_page");
  }
  if (NSSymbolTable::TRF_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_register_file");
  }
  if (NSSymbolTable::TREG_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_register");
  }
  if (NSSymbolTable::TMEM_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_memory");
  }
  //  else if (NSSymbolTable::TSIGPATG_DECL & mask) {
  //    if (output->size()) { output->append( "/");} 
  //    output->append( "signal_pattern_generator");
  //  }
  if (NSSymbolTable::TUNIT_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_unit");
  }
  if (NSSymbolTable::TTB_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_testbench");
  }
  if (NSSymbolTable::TVEC_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_vector");
  }
  if (NSSymbolTable::TSTATED_DECL & mask) {
    if (output->size()) { output->append( "/");} 
    output->append( "csl_state_data");
  }

  if (!onlyScopeHolder) {
    if (NSSymbolTable::TBITRANGE_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_bitrange");
    }
    if (NSSymbolTable::TENUM_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_enum");
    }
    if (NSSymbolTable::TENUMIT_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_enum_item");
    }
    if (NSSymbolTable::TEVENT_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_event");
    }
    if (NSSymbolTable::TLIST_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_list");
    }
    if (NSSymbolTable::TMDB_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_multi_dim_bitrange");
    }
    if (NSSymbolTable::TPIPELINE_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_pipeline");
    }
    if (NSSymbolTable::TPIPESTG_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_pipestage");
    }
    if (NSSymbolTable::TPORT_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_port");
    }
    if (NSSymbolTable::TSIGNAL_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_signal");
    }
    if (NSSymbolTable::TSIGNALGR_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "csl_signal_group");
    }
    if (NSSymbolTable::TCONSTINT_DECL & mask) {
      if (output->size()) { output->append( "/");} 
      output->append( "const int");
    }
  }
}

/*** getTypeStr ***/
/*******************************/
RefString getTypeStr(TInt mask) {

  ASSERT(mask, "PARSER - getTypeStr() - mask received should not be 0");

  RefString msg = _RS();
  typeToStr( mask, msg);

  ASSERT(msg->size(), "PARSER - getTypeStr() - should not return empty string ");
  return msg;
}

/*** getScopeHolderTypeStr ***/
/******************************************/
RefString getScopeHolderTypeStr(TInt mask) {

  ASSERT(mask, "PARSER - getScopeHolderTypeStr() - mask received should not be 0");

  RefString msg = _RS();
  TBool onlyScopeHolder = TRUE;
  typeToStr( mask, msg, onlyScopeHolder);

  return msg;
} 

//**********************************************************************************************************************************************************************//
//PARSER symTree implementation
//**********************************************************************************************************************************************************************//

//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
//// map that holds the declaration and instantiation options - to see what every part of this type is see setDeclarationAndInstantiationOptions() arguments
RefTMap_EObjType_TPair_TInt_TPair_TInt_TInt declarationAndInstantiationMap = 
  RefTMap_EObjType_TPair_TInt_TPair_TInt_TInt(new TMap_EObjType_TPair_TInt_TPair_TInt_TInt);


//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** set the object declaration and instantiation options
//// (where can it be declared and instantiated) and if predeclaration is allowed 
//// *should only be called from csl_*_declaration rules
//// *argument names are self explanatory - the mask arguments are bitwise masks of NSSymbolTable::EObjType enums(see src/parser/csl/SymTree.h)
void setDeclarationAndInstantiationOptions(NSSymbolTable::EObjType objectType                 = NSSymbolTable::TUNDEF,
                                           TInt                    maskForPredeclarationScopes= 0                    ,
                                           TInt                    maskForDeclarationScopes   = 0                    , 
                                           TInt                    maskForInstantiationScopes = 0                    ) {
  ASSERT(declarationAndInstantiationMap.get(), "PARSER - NULL map");
  
  if (NSSymbolTable::TUNDEF == objectType) { return; }
  
  TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator declarationAndInstantiationMapIterator = declarationAndInstantiationMap->find(objectType);
  TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator declarationAndInstantiationMapEnd      = declarationAndInstantiationMap->end();
  
  if (declarationAndInstantiationMapEnd != declarationAndInstantiationMapIterator) { return; }
  else {
    
    if (!maskForDeclarationScopes) { 
      RefString temp = getTypeStr(objectType);
      DCERR("PARSER WARNING - objects of type '" << *temp << "' are not allowed to be declared "); 
    }
    
    TPair_TInt_TInt             temporarySmallPair = std::make_pair(maskForDeclarationScopes, maskForInstantiationScopes);
    TPair_TInt_TPair_TInt_TInt  temporaryBigPair   = std::make_pair(maskForPredeclarationScopes, temporarySmallPair);
    declarationAndInstantiationMap->insert(std::make_pair(objectType, temporaryBigPair));
  }
}



//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////map that holds the command options - to see what every part of this map is see setCommandCallOptions() arguments
RefTMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt commandCallOptionsMap =
  RefTMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt(new TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt);


//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** set the command call options
//// (where can it be called and on what objects)
//// *should only be called from command rules
//// *argument names are self explanatory
//// *first two argument types are maps between
////   1- enum : which represents the scope the command can be called in (NSSymbolTable::EObjName enum - see src/parser/csl/SymTree.h)
////   2- mask : which represents the objects that the command can be called on(bitwise mask of NSSymbolTable::EObjType enums - see src/parser/csl/SymTree.h)
//// *the third argument is a mask of scopes for which you can call the command without object
void setCommandCallOptions(RefString             commandName                          = RefString            (),
                           TInt                  callAllowedInScopesWithoutObjectMask = 0                      ,
                           RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap       = RefTMap_EObjType_TInt(new TMap_EObjType_TInt),
                           RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap     = RefTMap_EObjType_TInt(new TMap_EObjType_TInt)) {
  ASSERT(commandCallOptionsMap.get(), "PARSER - NULL map");

  if (!commandName.get()) { DCERR("PARSER - null command received."); return; }

  TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator commandCallOptionsMapIterator = commandCallOptionsMap->find(commandName);
  TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator commandCallOptionsMapEnd      = commandCallOptionsMap->end();

  if (commandCallOptionsMapEnd != commandCallOptionsMapIterator) { return; }
  else {
    
    if (!callAllowedInScopesWithoutObjectMask &&
        !callAllowedInScopesOnObjectMap.get() &&
        !callAllowedInScopesOnInstanceMap.get() ) {
      DCERR("PARSER WARNING - command '" << *commandName << "' is not allowed to be called at all"); 
    }
    
    TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt             temporarySmallPair = std::make_pair(callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
    TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt  temporaryBigPair   = std::make_pair(callAllowedInScopesWithoutObjectMask, temporarySmallPair);
    commandCallOptionsMap->insert(std::make_pair(commandName, temporaryBigPair));
  }
}


//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** test if an object type is allowed to be declared in a certain scope
//// *symTree implementation internal function
//// *argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
TBool declarationAllowed(NSSymbolTable::EObjType objectType, NSSymbolTable::EObjType scopeType) {
  ASSERT(NSSymbolTable::TUNDEF < objectType && NSSymbolTable::TMAX > objectType, "PARSER - invalid object type");
  ASSERT(NSSymbolTable::TUNDEF < scopeType  && NSSymbolTable::TMAX > scopeType , "PARSER - invalid scope type" );

  TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator declarationAndInstantiationMapIterator = declarationAndInstantiationMap->find(objectType);
  TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator declarationAndInstantiationMapEnd      = declarationAndInstantiationMap->end();

  if (declarationAndInstantiationMapIterator != declarationAndInstantiationMapEnd) {

    TPair_TInt_TPair_TInt_TInt bigPair   = declarationAndInstantiationMapIterator->second;//the declaration mask is the first TInt from the second pair(the pair in pair)
    TPair_TInt_TInt            smallPair = bigPair.second;
    TInt declarationScopesMask           = smallPair.first;
    if (declarationScopesMask & scopeType) { return TRUE; }
  }
  return FALSE;
}


//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** test if an object type is allowed to be predeclared in a certain scope
//// *symTree implementation internal function
//// *argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
TBool predeclarationAllowed(NSSymbolTable::EObjType objectType, NSSymbolTable::EObjType scopeType) {
  ASSERT(NSSymbolTable::TUNDEF < objectType && NSSymbolTable::TMAX > objectType, "PARSER - invalid object type");
  ASSERT(NSSymbolTable::TUNDEF < scopeType  && NSSymbolTable::TMAX > scopeType , "PARSER - invalid scope type" );

  TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator declarationAndInstantiationMapIterator = declarationAndInstantiationMap->find(objectType);
  TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator declarationAndInstantiationMapEnd      = declarationAndInstantiationMap->end();

  if (declarationAndInstantiationMapIterator != declarationAndInstantiationMapEnd) {

    TPair_TInt_TPair_TInt_TInt bigPair   = declarationAndInstantiationMapIterator->second;//the predeclaration mask is the first TInt from the big pair(the pair that has a  pair as second)
    TInt preDeclarationScopesMask        = bigPair.first;
    if (preDeclarationScopesMask & scopeType) { return TRUE; }
  }
  return FALSE;
}


//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** test if an object type is allowed to be instantiated in a certain scope
//// *symTree implementation internal function
//// *argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
TBool instantiationAllowed(NSSymbolTable::EObjType objectType, NSSymbolTable::EObjType scopeType) {
  ASSERT(NSSymbolTable::TUNDEF < objectType && NSSymbolTable::TMAX > objectType, "PARSER - invalid object type");
  ASSERT(NSSymbolTable::TUNDEF < scopeType  && NSSymbolTable::TMAX > scopeType , "PARSER - invalid scope type" );

  TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator declarationAndInstantiationMapIterator = declarationAndInstantiationMap->find(objectType);
  TMap_EObjType_TPair_TInt_TPair_TInt_TInt_iterator declarationAndInstantiationMapEnd      = declarationAndInstantiationMap->end()             ;

  if (declarationAndInstantiationMapIterator != declarationAndInstantiationMapEnd) {

    TPair_TInt_TPair_TInt_TInt bigPair   = declarationAndInstantiationMapIterator->second;//the instantiation mask is the second TInt from the second pair(the pair in pair)
    TPair_TInt_TInt            smallPair = bigPair.second;
    TInt instantiationScopesMask         = smallPair.second;
    if (instantiationScopesMask & scopeType) { return TRUE; }
  }
  return FALSE;
}


//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** verify if an object can be declared with a certain type - returns FALSE if another object with same name
////       but different type was declared in current (not upper) scope
//// *symTree implementation internal function
 TBool declarationPossible(RefString objectName, NSSymbolTable::EObjType objectType, NSSymbolTable::RefCSymTree symbolTree, RefString instantiationType = _RS(), TBool testDefinition = FALSE) {
  ASSERT(objectName.get()                   && !objectName->empty()            , "PARSER - null string or empty string");
  ASSERT(NSSymbolTable::TUNDEF < objectType && NSSymbolTable::TMAX > objectType, "PARSER - invalid object type"        );
  ASSERT(symbolTree.get()                                                      , "PARSER - null symbol tree"           );
  ASSERT(instantiationType.get()                                               , "PARSER - null instantiation type received - if declaration is not of a user defined type please try calling the function without last(optional) argument");

  NSSymbolTable::RefCSymNode previousDeclaration = symbolTree->lookup(objectName);
  if (!previousDeclaration.get()) { return TRUE; }

  NSSymbolTable::EObjType     previousDeclarationType  = previousDeclaration->getType();
  NSSymbolTable::RefCSymNode  currentScope             = symbolTree->getCurrentScope();
  NSSymbolTable::RefCSymNode  previousDeclarationScope = previousDeclaration->getParent();

  if (currentScope == previousDeclarationScope) {
    if (objectType != previousDeclarationType) { return FALSE; }
    else if (NSSymbolTable::TUSER_DEFINED == objectType) {
      ASSERT(!instantiationType->empty(), "PARSER - null instantiation type name ");
      RefString previousType = previousDeclaration->getName();
      if (instantiationType->compare(*previousType)){
        return FALSE;
      }
    }
    else if (testDefinition) {

      if (previousDeclaration->isDefined()) {

        return FALSE;
      }
    }
  }
  return TRUE; 
}


//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** test if a command can be called in a scope without object
//// *symTree implementation internal function
//// * argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
TBool commandCallAllowedInScope(RefString commandName, NSSymbolTable::EObjType scopeType) {
  ASSERT(commandName.get() && commandName->size()                              , "PARSER - command name is null or command name size is 0");
  ASSERT(scopeType > NSSymbolTable::TUNDEF  && scopeType < NSSymbolTable::TMAX , "PARSER - invalid scope type"                            );

  TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator commandCallOptionsMapIterator = commandCallOptionsMap->find(commandName);
  TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator commandCallOptionsMapEnd      = commandCallOptionsMap->end();

  ASSERT(commandCallOptionsMapEnd != commandCallOptionsMapIterator, "PARSER - no data about command call options");

  TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt bigPair                           = commandCallOptionsMapIterator->second;//the mask we need is the TInt (first) of the big pair
  TInt                                                         commandCallWithoutObjectScopeMask = bigPair.first;//the mask for command call without object scopes
  if (commandCallWithoutObjectScopeMask & scopeType) { return TRUE; }
  return FALSE;
}



//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** test if a command can be called in a scope on a certain object
//// *symTree implementation internal function
//// * argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
TBool commandCallAllowedInScopeOnObject(RefString commandName, NSSymbolTable::EObjType scopeType, NSSymbolTable::EObjType objectType) {
  ASSERT(commandName.get() && commandName->size()                                , "PARSER - command name is null or command name size is 0");
  ASSERT(scopeType > NSSymbolTable::TUNDEF  && scopeType < NSSymbolTable::TMAX   , "PARSER - invalid scope type"                            );
  ASSERT(objectType > NSSymbolTable::TUNDEF  && objectType < NSSymbolTable::TMAX , "PARSER - invalid object type"                           );

  TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator commandCallOptionsMapIterator = commandCallOptionsMap->find(commandName);
  TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator commandCallOptionsMapEnd      = commandCallOptionsMap->end();

  ASSERT(commandCallOptionsMapEnd != commandCallOptionsMapIterator, "PARSER - no data about command call options");

  TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt bigPair                           = commandCallOptionsMapIterator->second;//the map we need is the first map of the small pair (the pair inside the big pair)
  TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt            smallPair                         = bigPair.second;
  RefTMap_EObjType_TInt                                        objectTypeToScopesMaskMap         = smallPair.first;//the first map is for declaration
  TMap_EObjType_TInt_iterator                                  objectTypeToScopesMaskMapIterator = objectTypeToScopesMaskMap->find(objectType);
  TMap_EObjType_TInt_iterator                                  objectTypeToScopesMaskMapEnd      = objectTypeToScopesMaskMap->end();
  if (objectTypeToScopesMaskMapEnd != objectTypeToScopesMaskMapIterator) {
    TInt commandCallScopeMask = objectTypeToScopesMaskMapIterator->second;
    if (commandCallScopeMask & scopeType) { return TRUE; }
  }
  return FALSE;
}


//// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
////****** test if a command can be called in a scope on a certain instance
//// *symTree implementation internal function
//// * argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
TBool commandCallAllowedInScopeOnInstance(RefString commandName, NSSymbolTable::EObjType scopeType, NSSymbolTable::EObjType instanceType) {
  ASSERT(commandName.get() && commandName->size()                                   , "PARSER - command name is null or command name size is 0");
  ASSERT(scopeType > NSSymbolTable::TUNDEF  && scopeType < NSSymbolTable::TMAX      , "PARSER - invalid scope type"                            );
  ASSERT(instanceType > NSSymbolTable::TUNDEF  && instanceType < NSSymbolTable::TMAX, "PARSER - invalid instance type"                         );

  TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator commandCallOptionsMapIterator = commandCallOptionsMap->find(commandName);
  TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt_iterator commandCallOptionsMapEnd      = commandCallOptionsMap->end();

  ASSERT(commandCallOptionsMapEnd != commandCallOptionsMapIterator, "PARSER - no data about command call options");

  TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt bigPair                            = commandCallOptionsMapIterator->second;//the map we need is the second map of the small pair (the pair inside the big pair)
  TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt            smallPair                          = bigPair.second;
  RefTMap_EObjType_TInt                                        instanceTypeToScopesMaskMap        = smallPair.second;//the second map is for instantiations
  TMap_EObjType_TInt_iterator                                  instanceTypeToScopesMaskMapIterator= instanceTypeToScopesMaskMap->find(instanceType);
  TMap_EObjType_TInt_iterator                                  instanceTypeToScopesMaskMapEnd     = instanceTypeToScopesMaskMap->end();
  if (instanceTypeToScopesMaskMapEnd != instanceTypeToScopesMaskMapIterator) { 
    TInt commandCallScopeMask = instanceTypeToScopesMaskMapIterator->second;
    if (commandCallScopeMask & scopeType) { return TRUE; }
  }
  return FALSE;
}




////****** symTree predeclare object - API
//// * argument names are self explanatory
//// * NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
void predeclareObject(RefString objectName, NSSymbolTable::EObjType objectType, NSSymbolTable::RefCSymTree symbolTree, RefString fileName, TInt line, TInt column) {
   ASSERT(objectName.get()                   && objectName->size()              , "PARSER - object name is null or object name size is 0");
   ASSERT(objectType > NSSymbolTable::TUNDEF && objectType < NSSymbolTable::TMAX, "PARSER - invalid object type"                         );
   ASSERT(symbolTree.get()                                                      , "PARSER - null symbol tree"                            );
   ASSERT(fileName.get()                     && fileName->size()                , "PARSER - file name is null or file name size is 0"    );
   ASSERT(0 <= line                          && 0 <= column                     , "PARSER - invalid line or column"                      );

   NSSymbolTable::RefCSymNode currentScope     = symbolTree->getCurrentScope();
   NSSymbolTable::EObjType    currentScopeType = currentScope->getType();

   if (predeclarationAllowed(objectType, currentScopeType)) {
     if (declarationPossible(objectName, objectType, symbolTree)) {
       symTree->declare(objectName, objectType, fileName, line, column);
     }
     else {
       RefString error = _RS("Predeclaration of object '");
       error->append( *objectName                                        );
       error->append( "' with type '"                                    );
       error->append( *getTypeStr(objectType)                            );
       error->append( "' cannot be accepted because a object with name '");//declaration of '");
       error->append( *objectName                                        );
       error->append( "' but with different type was found in scope "    );
       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
     }
   }
   else {
     RefString error = _RS("Predeclaration of object '");
     error->append( *objectName                                       );
     error->append( "' with type '"                                   );
     error->append( *getTypeStr(objectType)                           );
     error->append( "' cannot be accepted because predeclaration of '");
     error->append( *getTypeStr(objectType)                           );
     error->append( "' in '"                                          );
     error->append( *getTypeStr(currentScopeType)                     );
     error->append( "' scope is not allowed "                         );
     throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
   }
}



////****** symTree declare object
//// * argument names are self explanatory
//// * NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
void declareObject(RefString objectName, NSSymbolTable::EObjType objectType, NSSymbolTable::RefCSymTree symbolTree, RefString fileName, TInt line, TInt column) {
   ASSERT(objectName.get()                   && objectName->size()              , "PARSER - object name is null or object name size is 0");
   ASSERT(objectType > NSSymbolTable::TUNDEF && objectType < NSSymbolTable::TMAX, "PARSER - invalid object type"                         );
   ASSERT(symbolTree.get()                                                      , "PARSER - null symbol tree"                            );
   ASSERT(fileName.get()                     && fileName->size()                , "PARSER - file name is null or file name size is 0"    );
   ASSERT(0 <= line                          && 0 <= column                     , "PARSER - invalid line or column"                      );

   NSSymbolTable::RefCSymNode currentScope     = symbolTree->getCurrentScope();
   NSSymbolTable::EObjType    currentScopeType = currentScope->getType();

   if (declarationAllowed(objectType, currentScopeType)) {
     if (declarationPossible(objectName, objectType, symbolTree)) {
       symTree->declare(objectName, objectType, fileName, line, column);
     }
     else {
       RefString error = _RS("Declaration of object '");
       error->append( *objectName                                        );
       error->append( "' with type '"                                    );
       error->append( *getTypeStr(objectType)                            );
       error->append( "' cannot be accepted because a object with name '");
       error->append( *objectName                                        );
       error->append( "' but with different type was found in scope "    );
       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
     }
   }
   else {
     RefString error = _RS("Declaration of object '");
     error->append( *objectName                                    );
     error->append( "' with type '"                                );
     error->append( *getTypeStr(objectType)                        );
     error->append( "' cannot be accepted because declaration of '");
     error->append( *getTypeStr(objectType)                        );
     error->append( "' in '"                                       );
     error->append( *getTypeStr(currentScopeType)                  );
     error->append( "' scope is not allowed "                      );
     throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
   }
}



////****** symTree define object
//// * must be called after declareObject() because it does not declare object
//// * argument names are self explanatory
//// * NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
void defineObject(RefString objectName, NSSymbolTable::EObjType objectType, NSSymbolTable::RefCSymTree symbolTree, RefString fileName, TInt line, TInt column) {
   ASSERT(objectName.get()                   && objectName->size()              , "PARSER - object name is null or object name size is 0");
   ASSERT(objectType > NSSymbolTable::TUNDEF && objectType < NSSymbolTable::TMAX, "PARSER - invalid object type"                         );
   ASSERT(symbolTree.get()                                                      , "PARSER - null symbol tree"                            );
   ASSERT(fileName.get()                     && fileName->size()                , "PARSER - file name is null or file name size is 0"    );
   ASSERT(0 <= line                          && 0 <= column                     , "PARSER - invalid line or column"                      );

   NSSymbolTable::RefCSymNode currentScope     = symbolTree->getCurrentScope();
   NSSymbolTable::EObjType    currentScopeType = currentScope->getType();
   
   if (declarationAllowed(objectType, currentScopeType)) {
     if (declarationPossible(objectName, objectType, symbolTree)) {
       if (declarationPossible(objectName, objectType, symbolTree, _RS(), TRUE)) { //test if definition allowed
         symTree->define(objectName, objectType, line, column); 
       }
       else {
         RefString error = _RS("Definition of object '");
         error->append( *objectName                                          );
         error->append( "' with type '"                                      );
         error->append( *getTypeStr(objectType)                              );
         error->append( "' cannot be accepted because a object with name '");
         error->append( *objectName                                          );
         error->append( "' was already defined in scope "                    );
         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
       }
     }
     else {
       RefString error = _RS("Definition of object '");
       error->append( *objectName                                          );
       error->append( "' with type '"                                      );
       error->append( *getTypeStr(objectType)                              );
       error->append( "' cannot be accepted because an object with name '" );
       error->append( *objectName                                          );
       error->append( "' but with different type was found in scope "      );
       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
     }
   }
   else {
     RefString error = _RS("Definition of object '");
     error->append( *objectName                                    );
     error->append( "' with type '"                                );
     error->append( *getTypeStr(objectType)                        );
     error->append( "' cannot be accepted because definition of '" );
     error->append( *getTypeStr(objectType)                        );
     error->append( "' in '"                                       );
     error->append( *getTypeStr(currentScopeType)                  );
     error->append( "' scope is not allowed "                            );
     throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
   }
}



////****** symTree declare instance
//// * argument names are self explanatory
//// * NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
void instantiateObject(RefString instanceName, RefString instanceTypeName, NSSymbolTable::RefCSymTree symbolTree, RefString fileName, TInt line, TInt column) {
   ASSERT(instanceName.get()                 && instanceName->size()            , "PARSER - instance name is null or instance name size is 0"          );
   ASSERT(instanceTypeName.get()             && instanceTypeName->size()        , "PARSER - instance type name is null or instance type name size is 0");
   ASSERT(symbolTree.get()                                                      , "PARSER - null symbol tree"                                          );
   ASSERT(fileName.get()                     && fileName->size()                , "PARSER - file name is null or file name size is 0"                  );
   ASSERT(0 <= line                          && 0 <= column                     , "PARSER - invalid line or column"                                    );

   
   NSSymbolTable::RefCSymNode currentScope     = symbolTree->getCurrentScope();
   NSSymbolTable::EObjType    currentScopeType = currentScope->getType();

   NSSymbolTable::RefCSymNode instanceObject   = symbolTree->lookup(instanceTypeName);
   
   if (!instanceObject.get()) {
     RefString error = _RS("Type '");
     error->append( *instanceTypeName);
     error->append( "' was not found in scope ");
     throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
   }

//it seems that instantiation of types only predeclared is allowed...wild isn't it :(
//   else {
//     if (!instanceObject->isDefined()) {
//       RefString error = _RS("Type '");
//       error->append( *instanceTypeName);
//       error->append( "' was not defined ");
//       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
//     }
//   }

   NSSymbolTable::EObjType    instanceType = instanceObject->getType();

   if (instantiationAllowed(instanceType, currentScopeType)) {
     if (declarationPossible(instanceName, NSSymbolTable::TUSER_DEFINED, symbolTree, instanceTypeName)) {
       symTree->declare(instanceName, NSSymbolTable::TUSER_DEFINED, fileName, line, column, instanceTypeName);//no definition required for instantiation
     }
     else {
       RefString error = _RS("Declaration of object '");
       error->append( *instanceName                                            );
       error->append( "' with type '"                                          );
       error->append( *instanceTypeName                                        );
       error->append( "' cannot be accepted because another object with name '");
       error->append( *instanceName                                            );
       error->append( "' but with different type was found in scope "          );
       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
     }
   }
   else {
     NSSymbolTable::RefCSymNode actualInstanceObject      = symTree->lookup(instanceTypeName);
     if (NSSymbolTable::TUSER_DEFINED == actualInstanceObject->getType()) {

       RefString error = _RS("Instantiation type '");
       error->append( *instanceTypeName);
       error->append( "' does not name an instantiable type. Maybe another instance of the type has the type name?");
       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
     }
     NSSymbolTable::EObjType    actualInstanceObjectType  = actualInstanceObject->getType();
     NSSymbolTable::EObjType    currentScopeType          = currentScope->getType();
     RefString error = _RS("Declaration of object '");
     error->append( *instanceName                                  );
     error->append( "' with type '"                                );
     error->append( *instanceTypeName                              );
     error->append( "' cannot be accepted because declaration of '");
     error->append( *getTypeStr(actualInstanceObjectType)          );
     error->append( "' in '"                                       );
     error->append( *getTypeStr(currentScopeType)                  );
     error->append( "' scope is not allowed "                      );
     throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
   }
}



////****** symTree declare instance
//// * argument names are self explanatory
//// * NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
void callCommand(RefString commandName, RefTVec_RefString commandScope, NSSymbolTable::RefCSymNode currentScope, RefString fileName, TInt line, TInt column) {
  ASSERT(commandName.get() && commandName->size(), "PARSER - command name is null or command name size is 0");
  ASSERT(commandScope.get()                      , "PARSER - command scope is null"                         );
  ASSERT(currentScope.get()                      , "PARSER - scope is null"                                 );
  ASSERT(0 <= line         && 0 <= column        , "PARSER - invalid line or column"                        );

  RefString error = _RS();
  NSSymbolTable::EObjType currentScopeType = currentScope->getType();

  if (!commandScope->size()) {
    if (!commandCallAllowedInScope(commandName, currentScopeType)) {
      error->append( "command '"                     );
      error->append( *commandName                    );
      error->append( "' : call not allowed in scope ");
    }
  }
  else {
    NSSymbolTable::RefCSymNode commandScopeNode = symTree->lookup(*commandScope);
    if (!commandScopeNode.get()) {
      error->append( "command '"                                       );
      error->append( *commandName                                      );
      error->append( "' : command scope was not found in current scope");
    }
    else {
      NSSymbolTable::EObjType commandScopeNodeType = commandScopeNode->getType();
      if (commandScopeNode->isUserDefined()) {
        NSSymbolTable::EObjType commandScopeNodeRealType = commandScopeNode->getUserDefinedType()->getType();
        if (!commandCallAllowedInScopeOnInstance(commandName, currentScopeType, commandScopeNodeRealType)) {
          error->append( "command '"                             );
          error->append( *commandName                            );
          error->append( "' : call not allowed on instances of '");
          error->append( *getTypeStr(commandScopeNodeRealType));
          error->append( "' in current scope "                   );
        }
      }
      else {
        if (!commandCallAllowedInScopeOnObject(commandName, currentScopeType, commandScopeNodeType)) {
          error->append( "command '");
          error->append( *commandName);
          error->append( "' : call not allowed on objects of type '");
          error->append( *getTypeStr(commandScopeNodeType));
          error->append( "' in current scope");
        }
      }
      if (!error->size()) {
        if (!commandScopeNode->isDefined() && commandScopeNodeType != NSSymbolTable::TUSER_DEFINED) {
          error->append( "command '");
          error->append( *commandName);
          error->append( "' : command call not accepted because command scope '");
          error->append( *commandScopeNode->getName());
          error->append( "' was only declared (no definition). Please provide definition. ");
        }
      }
    }
    
  }
  if (error->size()) {
    throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, line, column);
  }
}



//*** enums used in removing tokens from parser ***//
 enum literals {
   K_LITERAL_UNDEFINED_TOKEN,
   K_LITERAL_INPUT,
   K_LITERAL_OUTPUT,
   K_LITERAL_INOUT,
   K_LITERAL_REG,               
   K_LITERAL_WIRE,
   K_LITERAL_TRI,
   K_LITERAL_TRIAND,
   K_LITERAL_SUPPLY0,
   K_LITERAL_SUPPLY1,
   K_LITERAL_TRIOR,
   K_LITERAL_TRI0,
   K_LITERAL_TRI1,
   K_LITERAL_TRIREG,
   K_LITERAL_WAND,
   K_LITERAL_WOR,
   K_LITERAL_INTEGER,
   K_LITERAL_TIME,
   K_LITERAL_ACTION,
   K_LITERAL_ATOM,
   K_LITERAL_COUNTER,
   K_LITERAL_REGISTER,
   K_LITERAL_CTL,
   K_LITERAL_DFF,
   K_LITERAL_EVNT,
   K_LITERAL_INT,
   K_LITERAL_LFSR ,
   K_LITERAL_SFT,
   K_LITERAL_SEMA,
   K_LITERAL_STATISTIC,
   K_LITERAL_STATUS,
   K_LITERAL_PRODUCER,
   K_LITERAL_CONSUMER,
   K_LITERAL_REAL,
   K_LITERAL_REALTIME,
   K_LITERAL_HIERARCHICAL,
   K_LITERAL_FLAT,
   K_LITERAL_PAGE,
   K_LITERAL_VIRTUAL_WITH_BASE_ADDRESS,
   K_LITERAL_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS,
   K_LITERAL_DIAGNOSTIC,
   K_LITERAL_STIM_EXPECT,
   K_LITERAL_SERIAL_BUS,
   K_LITERAL_FILE,
   K_LITERAL_SOCKET,
   K_LITERAL_SHARED_OBJ,
   K_LITERAL_UNDEFINED,
   K_LITERAL_ILLEGAL,
   K_LITERAL_RESERVED,
   K_LITERAL_VALID,
   K_LITERAL_OPCODE,
   K_LITERAL_SUBOPCODE,
   K_LITERAL_ADDRESS,
   K_LITERAL_SELECTOR,
   K_LITERAL_CONSTANT,
   K_LITERAL_BRANCH_ADDRESS,
   K_LITERAL_BRANCH_SELECT,
   K_LITERAL_INSTR_FORMAT,
   K_LITERAL_INSTR,
   K_LITERAL_ROOT_FORMAT,
   K_LITERAL_VALID_ENUM,
   K_LITERAL_DATA_ENUM,
   K_LITERAL_CONTROL_ENUM,
   K_LITERAL_OTHER_ENUM,
   K_LITERAL_UNUSED,
   K_LITERAL_ENABLE ,
   K_LITERAL_STALL,
   K_LITERAL_PIPE_ENABLE,
   K_LITERAL_PIPE_STALL,
   K_LITERAL_MUX_SELECT,
   K_LITERAL_DECODE,
   K_LITERAL_CLOCK_SIGNAL,
   K_LITERAL_RESET_SIGNAL,
   K_LITERAL_WRITE_ENABLE,
   K_LITERAL_IFC_ONLY,
   K_LITERAL_LOCAL_ONLY,
   K_LITERAL_REGISTER_GROUP,
   K_LITERAL_DISCONNECT_REG_FIELDS_IOS,
   K_LITERAL_CONNECT_REG_FIELDS_IOS,
   K_LITERAL_FIELD_GROUP,
   K_LITERAL_ALL,
   K_LITERAL_INPUTS,
   K_LITERAL_OUTPUTS,
   K_LITERAL_INOUTS,
   K_LITERAL_NAME_REGISTER,
   K_LITERAL_ON,
   K_LITERAL_OFF,
   K_LITERAL_CLK,
   K_LITERAL_NO_PREFIX,
   K_LITERAL_PIPELINE_NAME,
   K_LITERAL_PIPESTAGE_NAME,
   K_LITERAL_PIPELINE_PIPESTAGE_NAME,
   K_LITERAL_NO_SUFFIX,
   K_LITERAL_BIN,
   K_LITERAL_HEX,
   K_LITERAL_LITTLE_ENDIAN,
   K_LITERAL_BIG_ENDIAN,
   K_LITERAL_ACCESS_NONE,
   K_LITERAL_ACCESS_READ,
   K_LITERAL_ACCESS_WRITE,
   K_LITERAL_ACCESS_READ_WRITE,
   K_LITERAL_SRAM,
   K_LITERAL_FFA,
   K_LITERAL_READ,
   K_LITERAL_WRITE,
   K_LITERAL_SHADOW,
   K_LITERAL_READ_WRITE,
   K_LITERAL_STALL_ENUM,
   K_LITERAL_NO_STALL_ENUM,
   K_LITERAL_XOR,
   K_LITERAL_XNOR,
   K_LITERAL_NEG_OUTPUT,
   K_LITERAL_SERIAL_INPUT,
   K_LITERAL_SERIAL_OUTPUT,
   K_LITERAL_RD_EN,
   K_LITERAL_CONNECT_INPUT_TO_FIELD,
   K_LITERAL_CONNECT_OUTPUT_TO_FIELD,
   K_LITERAL_GRAY_OUTPUT,
   K_LITERAL_CNT_DIR_SIGNAL,
   K_LITERAL_INC_SIGNAL,
   K_LITERAL_DEC_SIGNAL,
   K_LITERAL_SH_OP_SIGNAL,
   K_LITERAL_START_VALUE,
   K_LITERAL_END_VALUE,
   K_LITERAL_COUNT_AMOUNT,
   K_LITERAL_COUNT_DIRECTION,
   K_LITERAL_COUNT_ENABLE,
   K_LITERAL_SET,
   //   K_LITERAL_RESET,//K_LITERAL_RESET_SIGNAL
   K_LITERAL_PROGRAMMABLE_DEPTH,
   K_LITERAL_PRIORITY_BYPASS,
   K_LITERAL_SYNC_FIFO,
   K_LITERAL_ASYNC_FIFO,
   K_LITERAL_DEPTH_EXTEND,
   K_LITERAL_WIDTH_EXTEND,
   K_LITERAL_WR_HOLD,
   K_LITERAL_PARALLEL_OUTPUT,
   K_LITERAL_PARALLEL_INPUT,
   K_LITERAL_RD_WORDS,
   K_LITERAL_WR_WORDS,
   K_LITERAL_SRAM_RD,
   K_LITERAL_SRAM_WR,
   K_LITERAL_PUSHBACK,
   K_LITERAL_FLOW_THROUGH,
   K_LITERAL_STALL_RD_SIDE,
   K_LITERAL_STALL_WR_SIDE,
   K_LITERAL_WR_RELEASE,
   K_LITERAL_ALMOST_EMPTY,
   K_LITERAL_ALMOST_FULL,
   K_LITERAL_OUTPUT_WR_ADDR,
   K_LITERAL_OUTPUT_RD_ADDR,
   K_LITERAL_CREDIT,
   K_LITERAL_RD_CREDIT,
   K_LITERAL_WR_CREDIT,
   K_LITERAL_FLOW,
   K_LITERAL_READ_VALID,
   K_LITERAL_BYPASS,
   K_LITERAL_GENERATE_WAVES,
   K_LITERAL_SIMULATION_TIMEOUT_COUNTER,
   K_LITERAL_STALL_GENERATION,
   K_LITERAL_GENERATE_REPORT,
   K_LITERAL_ASYNC_RESET,
   K_LITERAL_INIT,
   K_LITERAL_CLEAR,
   K_LITERAL_STOP,
   K_LITERAL_DIRECTION_CONTROL,
   K_LITERAL_INJECT_STALLS,
   K_LITERAL_EXTERNAL_UNIT_ENABLE,
   K_LITERAL_UNIT_ADDRESS_DECODER,
   K_LITERAL_SAL,
   K_LITERAL_SAR,
   K_LITERAL_SHL,
   K_LITERAL_SHR,
   K_LITERAL_ROL,
   K_LITERAL_ROR,
   K_LITERAL_PLI_SOCKET,
   K_LITERAL_CPP,
   K_LITERAL_TB,
   K_LITERAL_TRANSACTION,
   K_LITERAL_CYCLE_ACCURATE,
   K_LITERAL_NAND,
   K_LITERAL_NOR,
   K_LITERAL_AND,
   K_LITERAL_OR,
   K_LITERAL_NOT,
   K_LITERAL_PLUS,
   K_LITERAL_RISE,
   K_LITERAL_FALL,
   K_LITERAL_TRUE,
   K_LITERAL_FALSE,
   K_LITERAL_FILE_CPLUSPLUS,
   K_LITERAL_FILE_VERILOG,
   K_LITERAL_S,
   K_LITERAL_US,
   //   K_LITERAL_MS, // the same as K_LITERAL_MUX_SELECT
   K_LITERAL_NS,
   //   K_LITERAL_PS, // the same as K_LITERAL_PIPE_STALL
   K_LITERAL_COLUMNS,
   K_LITERAL_ROWS,
   K_LITERAL_WAVE_TYPE_FSDB,
   K_LITERAL_WAVE_TYPE_VCD,
   K_LITERAL_UP,
   K_LITERAL_DOWN,
   K_LITERAL_COMBINATIONAL,
   K_LITERAL_SEQUENTIAL,
   K_LITERAL_MAX_LITERAL_TOKEN
 };


 //*** map of string to int (literal string to literal enum) ***//
 NSCSLOm::RefTMap_RefString_TInt literalToEnumMap = NSCSLOm::RefTMap_RefString_TInt(new NSCSLOm::TMap_RefString_TInt);


 //*** given a literal string this function returns the literal enum or K_LITERAL_UNDEFINED_TOKEN if literal does not exist ***//
 long int getLiteralEnum(RefString literal) {
   long int returnValue = K_LITERAL_UNDEFINED_TOKEN;
   NSCSLOm::TMap_RefString_TInt::const_iterator iter = literalToEnumMap->find(literal);
   if (iter != literalToEnumMap->end()) {
     returnValue = (*iter).second;
   }
   return returnValue;
 }


 //*** map of literal string to literal enum initialization ***//
 void initializeMap() {
   literalToEnumMap->insert(make_pair(_RS("input"                               ), K_LITERAL_INPUT                               ));
   literalToEnumMap->insert(make_pair(_RS("output"                              ), K_LITERAL_OUTPUT                              ));
   literalToEnumMap->insert(make_pair(_RS("inout"                               ), K_LITERAL_INOUT                               ));
   literalToEnumMap->insert(make_pair(_RS("reg"                                 ), K_LITERAL_REG                                 ));
   literalToEnumMap->insert(make_pair(_RS("wire"                                ), K_LITERAL_WIRE                                ));
   literalToEnumMap->insert(make_pair(_RS("tri"                                 ), K_LITERAL_TRI                                 ));
   literalToEnumMap->insert(make_pair(_RS("triand"                              ), K_LITERAL_TRIAND                              ));
   literalToEnumMap->insert(make_pair(_RS("supply0"                             ), K_LITERAL_SUPPLY0                             ));
   literalToEnumMap->insert(make_pair(_RS("supply1"                             ), K_LITERAL_SUPPLY1                             ));
   literalToEnumMap->insert(make_pair(_RS("trior"                               ), K_LITERAL_TRIOR                               ));
   literalToEnumMap->insert(make_pair(_RS("tri0"                                ), K_LITERAL_TRI0                                ));
   literalToEnumMap->insert(make_pair(_RS("tri1"                                ), K_LITERAL_TRI1                                ));
   literalToEnumMap->insert(make_pair(_RS("trireg"                              ), K_LITERAL_TRIREG                              ));
   literalToEnumMap->insert(make_pair(_RS("wand"                                ), K_LITERAL_WAND                                ));
   literalToEnumMap->insert(make_pair(_RS("wor"                                 ), K_LITERAL_WOR                                 ));
   literalToEnumMap->insert(make_pair(_RS("integer"                             ), K_LITERAL_INTEGER                             ));
   literalToEnumMap->insert(make_pair(_RS("time"                                ), K_LITERAL_TIME                                ));
   literalToEnumMap->insert(make_pair(_RS("action"                              ), K_LITERAL_ACTION                              ));
   literalToEnumMap->insert(make_pair(_RS("atom"                                ), K_LITERAL_ATOM                                ));
   literalToEnumMap->insert(make_pair(_RS("counter"                             ), K_LITERAL_COUNTER                             ));
   literalToEnumMap->insert(make_pair(_RS("register"                            ), K_LITERAL_REGISTER                            ));
   literalToEnumMap->insert(make_pair(_RS("ctl"                                 ), K_LITERAL_CTL                                 ));
   literalToEnumMap->insert(make_pair(_RS("dff"                                 ), K_LITERAL_DFF                                 ));
   literalToEnumMap->insert(make_pair(_RS("evnt"                                ), K_LITERAL_EVNT                                ));
   literalToEnumMap->insert(make_pair(_RS("int"                                 ), K_LITERAL_INT                                 ));
   literalToEnumMap->insert(make_pair(_RS("lfsr"                                ), K_LITERAL_LFSR                                ));
   literalToEnumMap->insert(make_pair(_RS("sft"                                 ), K_LITERAL_SFT                                 ));
   literalToEnumMap->insert(make_pair(_RS("sema"                                ), K_LITERAL_SEMA                                ));
   literalToEnumMap->insert(make_pair(_RS("statistic"                           ), K_LITERAL_STATISTIC                           ));
   literalToEnumMap->insert(make_pair(_RS("status"                              ), K_LITERAL_STATUS                              ));
   literalToEnumMap->insert(make_pair(_RS("producer"                            ), K_LITERAL_PRODUCER                            ));
   literalToEnumMap->insert(make_pair(_RS("consumer"                            ), K_LITERAL_CONSUMER                            ));
   literalToEnumMap->insert(make_pair(_RS("real"                                ), K_LITERAL_REAL                                ));
   literalToEnumMap->insert(make_pair(_RS("realtime"                            ), K_LITERAL_REALTIME                            ));
   literalToEnumMap->insert(make_pair(_RS("hierarchical"                        ), K_LITERAL_HIERARCHICAL                        ));
   literalToEnumMap->insert(make_pair(_RS("flat"                                ), K_LITERAL_FLAT                                ));
   literalToEnumMap->insert(make_pair(_RS("page"                                ), K_LITERAL_PAGE                                ));
   literalToEnumMap->insert(make_pair(_RS("virtual_with_base_address"           ), K_LITERAL_VIRTUAL_WITH_BASE_ADDRESS           ));
   literalToEnumMap->insert(make_pair(_RS("virtual_with_page_number_and_address"), K_LITERAL_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS));
   literalToEnumMap->insert(make_pair(_RS("diagnostic"                          ), K_LITERAL_DIAGNOSTIC                          ));
   literalToEnumMap->insert(make_pair(_RS("stim_expect"                         ), K_LITERAL_STIM_EXPECT                         ));
   literalToEnumMap->insert(make_pair(_RS("serial_bus"                          ), K_LITERAL_SERIAL_BUS                          ));
   literalToEnumMap->insert(make_pair(_RS("file"                                ), K_LITERAL_FILE                                ));
   literalToEnumMap->insert(make_pair(_RS("socket"                              ), K_LITERAL_SOCKET                              ));
   literalToEnumMap->insert(make_pair(_RS("shared_obj"                          ), K_LITERAL_SHARED_OBJ                          ));
   literalToEnumMap->insert(make_pair(_RS("undefined"                           ), K_LITERAL_UNDEFINED                           ));
   literalToEnumMap->insert(make_pair(_RS("illegal"                             ), K_LITERAL_ILLEGAL                             ));
   literalToEnumMap->insert(make_pair(_RS("reserved"                            ), K_LITERAL_RESERVED                            ));
   literalToEnumMap->insert(make_pair(_RS("valid"                               ), K_LITERAL_VALID                               ));
   literalToEnumMap->insert(make_pair(_RS("opcode"                              ), K_LITERAL_OPCODE                              ));
   literalToEnumMap->insert(make_pair(_RS("subopcode"                           ), K_LITERAL_SUBOPCODE                           ));
   literalToEnumMap->insert(make_pair(_RS("address"                             ), K_LITERAL_ADDRESS                             ));
   literalToEnumMap->insert(make_pair(_RS("selector"                            ), K_LITERAL_SELECTOR                            ));
   literalToEnumMap->insert(make_pair(_RS("constant"                            ), K_LITERAL_CONSTANT                            ));
   literalToEnumMap->insert(make_pair(_RS("branch_address"                      ), K_LITERAL_BRANCH_ADDRESS                      ));
   literalToEnumMap->insert(make_pair(_RS("branch_select"                       ), K_LITERAL_BRANCH_SELECT                       ));
   literalToEnumMap->insert(make_pair(_RS("instr_format"                        ), K_LITERAL_INSTR_FORMAT                        ));
   literalToEnumMap->insert(make_pair(_RS("instr"                               ), K_LITERAL_INSTR                               ));
   literalToEnumMap->insert(make_pair(_RS("root_format"                         ), K_LITERAL_ROOT_FORMAT                         ));
   literalToEnumMap->insert(make_pair(_RS("VALID"                               ), K_LITERAL_VALID_ENUM                          ));
   literalToEnumMap->insert(make_pair(_RS("DATA"                                ), K_LITERAL_DATA_ENUM                           ));
   literalToEnumMap->insert(make_pair(_RS("CONTROL"                             ), K_LITERAL_CONTROL_ENUM                        ));
   literalToEnumMap->insert(make_pair(_RS("OTHER"                               ), K_LITERAL_OTHER_ENUM                          ));
   literalToEnumMap->insert(make_pair(_RS("unused"                              ), K_LITERAL_UNUSED                              ));
   literalToEnumMap->insert(make_pair(_RS("en"                                  ), K_LITERAL_ENABLE                              ));
   literalToEnumMap->insert(make_pair(_RS("stall"                               ), K_LITERAL_STALL                               ));
   literalToEnumMap->insert(make_pair(_RS("pe"                                  ), K_LITERAL_PIPE_ENABLE                         ));
   literalToEnumMap->insert(make_pair(_RS("ps"                                  ), K_LITERAL_PIPE_STALL                          ));
   literalToEnumMap->insert(make_pair(_RS("mux_sel"                             ), K_LITERAL_MUX_SELECT                          ));
   literalToEnumMap->insert(make_pair(_RS("decode"                              ), K_LITERAL_DECODE                              ));
   literalToEnumMap->insert(make_pair(_RS("clock"                               ), K_LITERAL_CLOCK_SIGNAL                        ));
   literalToEnumMap->insert(make_pair(_RS("reset"                               ), K_LITERAL_RESET_SIGNAL                        ));
   literalToEnumMap->insert(make_pair(_RS("wr_en"                               ), K_LITERAL_WRITE_ENABLE                        ));
   literalToEnumMap->insert(make_pair(_RS("ifc_only"                            ), K_LITERAL_IFC_ONLY                            ));
   literalToEnumMap->insert(make_pair(_RS("local_only"                          ), K_LITERAL_LOCAL_ONLY                          ));
   literalToEnumMap->insert(make_pair(_RS("register_group"                      ), K_LITERAL_REGISTER_GROUP                      ));
   literalToEnumMap->insert(make_pair(_RS("disconnect_register_fields_from_ios" ), K_LITERAL_DISCONNECT_REG_FIELDS_IOS           ));
   literalToEnumMap->insert(make_pair(_RS("connect_register_fields_to_ios"      ), K_LITERAL_CONNECT_REG_FIELDS_IOS              ));
   literalToEnumMap->insert(make_pair(_RS("field_group"                         ), K_LITERAL_FIELD_GROUP                         ));
   literalToEnumMap->insert(make_pair(_RS("all"                                 ), K_LITERAL_ALL                                 ));
   literalToEnumMap->insert(make_pair(_RS("inputs"                              ), K_LITERAL_INPUTS                              ));
   literalToEnumMap->insert(make_pair(_RS("outputs"                             ), K_LITERAL_OUTPUTS                             ));
   literalToEnumMap->insert(make_pair(_RS("inouts"                              ), K_LITERAL_INOUTS                              ));
   literalToEnumMap->insert(make_pair(_RS("name_register"                       ), K_LITERAL_NAME_REGISTER                       ));
   literalToEnumMap->insert(make_pair(_RS("on"                                  ), K_LITERAL_ON                                  ));
   literalToEnumMap->insert(make_pair(_RS("off"                                 ), K_LITERAL_OFF                                 ));
   literalToEnumMap->insert(make_pair(_RS("clk"                                 ), K_LITERAL_CLK                                 ));
   literalToEnumMap->insert(make_pair(_RS("bin"                                 ), K_LITERAL_BIN                                 ));
   literalToEnumMap->insert(make_pair(_RS("hex"                                 ), K_LITERAL_HEX                                 ));
   literalToEnumMap->insert(make_pair(_RS("NO_PREFIX"                           ), K_LITERAL_NO_PREFIX                           ));
   literalToEnumMap->insert(make_pair(_RS("PIPELINE_NAME"                       ), K_LITERAL_PIPELINE_NAME                       ));
   literalToEnumMap->insert(make_pair(_RS("PIPESTAGE_NAME"                      ), K_LITERAL_PIPESTAGE_NAME                      ));
   literalToEnumMap->insert(make_pair(_RS("PIPELINE_PIPESTAGE_NAME"             ), K_LITERAL_PIPELINE_PIPESTAGE_NAME             ));
   literalToEnumMap->insert(make_pair(_RS("NO_SUFFIX"                           ), K_LITERAL_NO_SUFFIX                           ));
   literalToEnumMap->insert(make_pair(_RS("little_endian"                       ), K_LITERAL_LITTLE_ENDIAN                       ));
   literalToEnumMap->insert(make_pair(_RS("big_endian"                          ), K_LITERAL_BIG_ENDIAN                          ));
   literalToEnumMap->insert(make_pair(_RS("access_none"                         ), K_LITERAL_ACCESS_NONE                         ));
   literalToEnumMap->insert(make_pair(_RS("access_read"                         ), K_LITERAL_ACCESS_READ                         ));
   literalToEnumMap->insert(make_pair(_RS("access_write"                        ), K_LITERAL_ACCESS_WRITE                        ));
   literalToEnumMap->insert(make_pair(_RS("access_read_write"                   ), K_LITERAL_ACCESS_READ_WRITE                   ));
   literalToEnumMap->insert(make_pair(_RS("sram"                                ), K_LITERAL_SRAM                                ));
   literalToEnumMap->insert(make_pair(_RS("ffa"                                 ), K_LITERAL_FFA                                 ));
   literalToEnumMap->insert(make_pair(_RS("rd"                                  ), K_LITERAL_READ                                ));
   literalToEnumMap->insert(make_pair(_RS("wr"                                  ), K_LITERAL_WRITE                               ));
   literalToEnumMap->insert(make_pair(_RS("sh"                                  ), K_LITERAL_SHADOW                              ));
   literalToEnumMap->insert(make_pair(_RS("rd_wr"                               ), K_LITERAL_READ_WRITE                          ));
   literalToEnumMap->insert(make_pair(_RS("STALL"                               ), K_LITERAL_STALL_ENUM                          ));
   literalToEnumMap->insert(make_pair(_RS("NO_STALL"                            ), K_LITERAL_NO_STALL_ENUM                       ));
   literalToEnumMap->insert(make_pair(_RS("xor"                                 ), K_LITERAL_XOR                                 ));
   literalToEnumMap->insert(make_pair(_RS("xnor"                                ), K_LITERAL_XNOR                                ));
   literalToEnumMap->insert(make_pair(_RS("neg_output"                          ), K_LITERAL_NEG_OUTPUT                          ));
   literalToEnumMap->insert(make_pair(_RS("serial_input"                        ), K_LITERAL_SERIAL_INPUT                        ));
   literalToEnumMap->insert(make_pair(_RS("serial_output"                       ), K_LITERAL_SERIAL_OUTPUT                       ));
   literalToEnumMap->insert(make_pair(_RS("rd_en"                               ), K_LITERAL_RD_EN                               ));
   literalToEnumMap->insert(make_pair(_RS("connect_input_to_field"              ), K_LITERAL_CONNECT_INPUT_TO_FIELD              ));
   literalToEnumMap->insert(make_pair(_RS("connect_output_to_field"             ), K_LITERAL_CONNECT_OUTPUT_TO_FIELD             ));
   literalToEnumMap->insert(make_pair(_RS("gray_output"                         ), K_LITERAL_GRAY_OUTPUT                         ));
   literalToEnumMap->insert(make_pair(_RS("cnt_dir_signal"                      ), K_LITERAL_CNT_DIR_SIGNAL                      ));
   literalToEnumMap->insert(make_pair(_RS("inc_signal"                          ), K_LITERAL_INC_SIGNAL                          ));
   literalToEnumMap->insert(make_pair(_RS("dec_signal"                          ), K_LITERAL_DEC_SIGNAL                          ));
   literalToEnumMap->insert(make_pair(_RS("sh_op_signal"                        ), K_LITERAL_SH_OP_SIGNAL                        ));
   literalToEnumMap->insert(make_pair(_RS("start_value"                         ), K_LITERAL_START_VALUE                         ));
   literalToEnumMap->insert(make_pair(_RS("end_value"                           ), K_LITERAL_END_VALUE                           ));
   literalToEnumMap->insert(make_pair(_RS("count_amount"                        ), K_LITERAL_COUNT_AMOUNT                        ));
   literalToEnumMap->insert(make_pair(_RS("count_direction"                     ), K_LITERAL_COUNT_DIRECTION                     ));
   literalToEnumMap->insert(make_pair(_RS("count_enable"                        ), K_LITERAL_COUNT_ENABLE                        ));
   literalToEnumMap->insert(make_pair(_RS("set"                                 ), K_LITERAL_SET                                 ));
   //   literalToEnumMap->insert(make_pair(_RS("reset"                               ), K_LITERAL_RESET                               ));//K_LITERAL_RESET_SIGNAL
   literalToEnumMap->insert(make_pair(_RS("programmable_depth"                  ), K_LITERAL_PROGRAMMABLE_DEPTH                  ));
   literalToEnumMap->insert(make_pair(_RS("priority_bypass"                     ), K_LITERAL_PRIORITY_BYPASS                     ));
   literalToEnumMap->insert(make_pair(_RS("sync_fifo"                           ), K_LITERAL_SYNC_FIFO                           ));
   literalToEnumMap->insert(make_pair(_RS("async_fifo"                          ), K_LITERAL_ASYNC_FIFO                          ));
   literalToEnumMap->insert(make_pair(_RS("depth_extend"                        ), K_LITERAL_DEPTH_EXTEND                        ));
   literalToEnumMap->insert(make_pair(_RS("width_extend"                        ), K_LITERAL_WIDTH_EXTEND                        ));
   literalToEnumMap->insert(make_pair(_RS("wr_hold"                             ), K_LITERAL_WR_HOLD                             ));
   literalToEnumMap->insert(make_pair(_RS("parallel_output"                     ), K_LITERAL_PARALLEL_OUTPUT                     ));
   literalToEnumMap->insert(make_pair(_RS("parallel_input"                      ), K_LITERAL_PARALLEL_INPUT                      ));
   literalToEnumMap->insert(make_pair(_RS("rd_words"                            ), K_LITERAL_RD_WORDS                            ));
   literalToEnumMap->insert(make_pair(_RS("wr_words"                            ), K_LITERAL_WR_WORDS                            ));
   literalToEnumMap->insert(make_pair(_RS("sram_rd"                             ), K_LITERAL_SRAM_RD                             ));
   literalToEnumMap->insert(make_pair(_RS("sram_wr"                             ), K_LITERAL_SRAM_WR                             ));
   literalToEnumMap->insert(make_pair(_RS("pushback"                            ), K_LITERAL_PUSHBACK                            ));
   literalToEnumMap->insert(make_pair(_RS("flow_through"                        ), K_LITERAL_FLOW_THROUGH                        ));
   literalToEnumMap->insert(make_pair(_RS("stall_rd_side"                       ), K_LITERAL_STALL_RD_SIDE                       ));
   literalToEnumMap->insert(make_pair(_RS("stall_wr_side"                       ), K_LITERAL_STALL_WR_SIDE                       ));
   literalToEnumMap->insert(make_pair(_RS("wr_release"                          ), K_LITERAL_WR_RELEASE                          ));
   literalToEnumMap->insert(make_pair(_RS("almost_empty"                        ), K_LITERAL_ALMOST_EMPTY                        ));
   literalToEnumMap->insert(make_pair(_RS("almost_full"                         ), K_LITERAL_ALMOST_FULL                         ));
   literalToEnumMap->insert(make_pair(_RS("output_wr_addr"                      ), K_LITERAL_OUTPUT_WR_ADDR                      ));
   literalToEnumMap->insert(make_pair(_RS("output_rd_addr"                      ), K_LITERAL_OUTPUT_RD_ADDR                      ));
   literalToEnumMap->insert(make_pair(_RS("credit"                              ), K_LITERAL_CREDIT                              ));
   literalToEnumMap->insert(make_pair(_RS("rd_credit"                           ), K_LITERAL_RD_CREDIT                           ));
   literalToEnumMap->insert(make_pair(_RS("wr_credit"                           ), K_LITERAL_WR_CREDIT                           ));
   literalToEnumMap->insert(make_pair(_RS("flow"                                ), K_LITERAL_FLOW                                ));
   literalToEnumMap->insert(make_pair(_RS("read_valid"                          ), K_LITERAL_READ_VALID                          ));
   literalToEnumMap->insert(make_pair(_RS("bypass"                              ), K_LITERAL_BYPASS                              ));
   literalToEnumMap->insert(make_pair(_RS("generate_waves"                      ), K_LITERAL_GENERATE_WAVES                      ));
   literalToEnumMap->insert(make_pair(_RS("simulation_timeout_counter"          ), K_LITERAL_SIMULATION_TIMEOUT_COUNTER          ));
   literalToEnumMap->insert(make_pair(_RS("stall_generation"                    ), K_LITERAL_STALL_GENERATION                    ));
   literalToEnumMap->insert(make_pair(_RS("generate_report"                     ), K_LITERAL_GENERATE_REPORT                     ));
   literalToEnumMap->insert(make_pair(_RS("async_reset"                         ), K_LITERAL_ASYNC_RESET                         ));
   literalToEnumMap->insert(make_pair(_RS("init"                                ), K_LITERAL_INIT                                ));
   literalToEnumMap->insert(make_pair(_RS("clear"                               ), K_LITERAL_CLEAR                               ));
   literalToEnumMap->insert(make_pair(_RS("stop"                                ), K_LITERAL_STOP                                ));
   literalToEnumMap->insert(make_pair(_RS("direction_control"                   ), K_LITERAL_DIRECTION_CONTROL                   ));
   literalToEnumMap->insert(make_pair(_RS("inject_stalls"                       ), K_LITERAL_INJECT_STALLS                       ));
   literalToEnumMap->insert(make_pair(_RS("external_unit_enable"                ), K_LITERAL_EXTERNAL_UNIT_ENABLE                ));
   literalToEnumMap->insert(make_pair(_RS("unit_address_decoder"                ), K_LITERAL_UNIT_ADDRESS_DECODER                )); 
   literalToEnumMap->insert(make_pair(_RS("sal"                                 ), K_LITERAL_SAL                                 ));
   literalToEnumMap->insert(make_pair(_RS("sar"                                 ), K_LITERAL_SAR                                 ));
   literalToEnumMap->insert(make_pair(_RS("shl"                                 ), K_LITERAL_SHL                                 ));
   literalToEnumMap->insert(make_pair(_RS("shr"                                 ), K_LITERAL_SHR                                 ));
   literalToEnumMap->insert(make_pair(_RS("rol"                                 ), K_LITERAL_ROL                                 ));
   literalToEnumMap->insert(make_pair(_RS("ror"                                 ), K_LITERAL_ROR                                 ));
   literalToEnumMap->insert(make_pair(_RS("PLIsocket"                           ), K_LITERAL_PLI_SOCKET                          ));
   literalToEnumMap->insert(make_pair(_RS("file"                                ), K_LITERAL_FILE                                ));
   literalToEnumMap->insert(make_pair(_RS("cpp"                                 ), K_LITERAL_CPP                                 ));
   literalToEnumMap->insert(make_pair(_RS("tb"                                  ), K_LITERAL_TB                                  ));
   literalToEnumMap->insert(make_pair(_RS("transaction"                         ), K_LITERAL_TRANSACTION                         ));
   literalToEnumMap->insert(make_pair(_RS("cycle_accurate"                      ), K_LITERAL_CYCLE_ACCURATE                      ));
   literalToEnumMap->insert(make_pair(_RS("nand"                                ), K_LITERAL_NAND                                ));
   literalToEnumMap->insert(make_pair(_RS("nor"                                 ), K_LITERAL_NOR                                 ));
   literalToEnumMap->insert(make_pair(_RS("and"                                 ), K_LITERAL_AND                                 ));
   literalToEnumMap->insert(make_pair(_RS("or"                                  ), K_LITERAL_OR                                  ));
   literalToEnumMap->insert(make_pair(_RS("not"                                 ), K_LITERAL_NOT                                 ));
   literalToEnumMap->insert(make_pair(_RS("plus"                                ), K_LITERAL_PLUS                                ));
   literalToEnumMap->insert(make_pair(_RS("rise"                                ), K_LITERAL_RISE                                ));
   literalToEnumMap->insert(make_pair(_RS("fall"                                ), K_LITERAL_FALL                                ));
   literalToEnumMap->insert(make_pair(_RS("true"                                ), K_LITERAL_TRUE                                ));
   literalToEnumMap->insert(make_pair(_RS("false"                               ), K_LITERAL_FALSE                               ));
   literalToEnumMap->insert(make_pair(_RS("file_cplusplus"                      ), K_LITERAL_FILE_CPLUSPLUS                      ));
   literalToEnumMap->insert(make_pair(_RS("file_verilog"                        ), K_LITERAL_FILE_VERILOG                        ));
   literalToEnumMap->insert(make_pair(_RS("s"                                   ), K_LITERAL_S                                   ));
   literalToEnumMap->insert(make_pair(_RS("us"                                  ), K_LITERAL_US                                  ));
   //   literalToEnumMap->insert(make_pair(_RS("ms"                                  ), K_LITERAL_MS                                  )); //the same as K_LITERAL_MUX_SELECT
   literalToEnumMap->insert(make_pair(_RS("ns"                                  ), K_LITERAL_NS                                  ));
   //   literalToEnumMap->insert(make_pair(_RS("ps"                                  ), K_LITERAL_PS                                  )); // the same as K_LITERAL_PIPE_STALL
   literalToEnumMap->insert(make_pair(_RS("columns"                             ), K_LITERAL_COLUMNS                             ));
   literalToEnumMap->insert(make_pair(_RS("rows"                                ), K_LITERAL_ROWS                                ));
   literalToEnumMap->insert(make_pair(_RS("fsdb"                                ), K_LITERAL_WAVE_TYPE_FSDB                      ));
   literalToEnumMap->insert(make_pair(_RS("vcd"                                 ), K_LITERAL_WAVE_TYPE_VCD                       ));
   literalToEnumMap->insert(make_pair(_RS("up"                                  ), K_LITERAL_UP                                  ));
   literalToEnumMap->insert(make_pair(_RS("down"                                ), K_LITERAL_DOWN                                ));
   literalToEnumMap->insert(make_pair(_RS("combinational"                       ), K_LITERAL_COMBINATIONAL                       ));
   literalToEnumMap->insert(make_pair(_RS("sequential"                          ), K_LITERAL_SEQUENTIAL                          ));
 }

}

class CslParser extends Parser;
options {
  k = 1;
  importVocab = Csl;
  exportVocab = CslParser;
  buildAST=true;
  ASTLabelType = "antlr::RefCslAST";
  defaultErrorHandler = false;
}


tokens {
  UNIT_PARAMETER;
  CSL_COMMAND;
  //interconnect definitions and instantiations
  CSL_UNIT_DEFINITION;
  CSL_UNIT_INSTANTIATION;
  //CSL_INTERFACE_DEFINITION;
  CSL_INTERFACE_INSTANTIATION;
  CSL_CSTOR;
  CSL_INST;
  CSL_INST_OR_CSTOR;
  //memory map definitions and instantiations
  CSL_MEMORY_MAP_DEFINITION;
  CSL_MEMORY_MAP_PAGE_DEFINITION;
  //CSL_ADDRESS_RANGE_INSTANTIATION;
  CSL_MEMORY_MAP_PAGE_INSTANTIATION;
  CSL_MEMORY_MAP_PAGE_CSTOR;
  CSL_MEMORY_MAP_CSTOR;
  //  CSL_FIELD_DEFINITION;
  EXPRESSION_LIST;
  CONCATENATION;
  MULTI_CONCATENATION;
  EXPRESSION;
  RANGE_EXPRESSION;
  MINTYPMAX_EXPRESSION;
  EXPR_PRIMARY_IDENTIFIER;
  U_PLUS;
  U_MINUS;
  U_AND;
  U_NAND;
  U_OR;
  U_NOR;
  U_XOR;
  U_XNOR;
  FUNCTION_CALL_RET_ID;
  FUNCTION_CALL_RET_EXPR;
  EXPR_HYBRID;
  SIZED_NUMBER;
  BITRANGE;
  PARAM_LIST_ADD_SIGNAL;
  PARAM_LIST_ADD_SIGNAL_LIST;
  PARAM_LIST_SIGNAL_GROUP;
  PARAM_LIST_ADD_PORT;
  PARAM_LIST_ADD_PORT_LIST;
  PARAM_LIST_ADD_INSTANCE;
  PARAM_LIST_ADD_INSTANCE_LIST;
  PARAM_LIST_ADD_UNIT_PARAMETER;
  PARAM_LIST_OVERRIDE_UNIT_PARAMETER;
  PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING;
  CSL_LIST;
  TIME_EXPR;
  F2A_PAIR_EXPR;
  PARAM_LIST_SET_POSITION;
  PARAM_LIST_SET_NEXT;
  PARAM_LIST_SET_PREVIOUS;
  PARENT_CLASS;
  PARAM_LIST_ADD_TO_MEMORY_MAP;
  INST_PARAM ;
  ENUM_ITEM;
  ASSIGNOR;
  CSL_ISA_ELEMENT_DECLARATION;
  K_INPUT;
  K_OUTPUT;
  K_INOUT;
  K_ACTION;
  K_ATOM;
  K_COUNTER;
  K_REGISTER;
  K_CTL;
  K_DFF;
  K_EVNT;
  K_LFSR ;
  K_SFT;
  K_SEMA;
  K_STATISTIC;
  K_STATUS;
  K_PRODUCER;
  K_CONSUMER;
  K_REAL;
  K_REALTIME;
  K_HIERARCHICAL;
  K_FLAT;
  K_PAGE;
  K_VIRTUAL_WITH_BASE_ADDRESS;
  K_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS;
  K_DIAGNOSTIC;
  K_STIM_EXPECT;
  K_SERIAL_BUS;
  K_FILE;
  K_SOCKET;
  K_SHARED_OBJ;
  K_UNDEFINED;
  K_ILLEGAL;
  K_RESERVED;
  K_VALID;
  K_OPCODE;
  K_SUBOPCODE;
  K_ADDRESS;
  K_SELECTOR;
  K_CONSTANT;
  K_BRANCH_ADDRESS;
  K_BRANCH_SELECT;
  K_INSTR_FORMAT;
  K_INSTR;
  K_ROOT_FORMAT;
  K_VALID_ENUM;
  K_DATA_ENUM;
  K_CONTROL_ENUM;
  K_OTHER_ENUM;
  K_UNUSED;
  K_ENABLE;
  K_STALL;
  K_PIPE_ENABLE;
  K_PIPE_STALL;
  K_MUX_SELECT;
  K_DECODE;
  K_CLOCK_SIGNAL;
  K_RESET_SIGNAL;
  K_WRITE_ENABLE;
  K_IFC_ONLY;
  K_LOCAL_ONLY;
  K_REGISTER_GROUP;
  K_DISCONNECT_REG_FIELDS_IOS;
  K_CONNECT_REG_FIELDS_IOS;
  K_FIELD_GROUP;
  K_ALL;
  K_INPUTS;
  K_OUTPUTS;
  K_INOUTS;
  K_NAME_REGISTER;
  K_ON;
  K_OFF;
  K_CLK;
  K_NO_PREFIX;
  K_PIPELINE_NAME;
  K_PIPESTAGE_NAME;
  K_PIPELINE_PIPESTAGE_NAME;
  K_NO_SUFFIX;
  K_BIN;
  K_HEX;
  K_LITTLE_ENDIAN;
  K_BIG_ENDIAN;
  K_ACCESS_RIGHT_NONE;
  K_ACCESS_RIGHT_READ;
  K_ACCESS_RIGHT_WRITE;
  K_ACCESS_RIGHT_READ_WRITE;
  K_SRAM;
  K_FFA;
  K_READ;
  K_WRITE;
  K_SHADOW;
  K_READ_WRITE;
  K_STALL_ENUM;
  K_NO_STALL_ENUM;
  K_XOR;
  K_XNOR;
  K_NEG_OUTPUT;
  K_SERIAL_INPUT;
  K_SERIAL_OUTPUT;
  K_RD_EN;
  K_CONNECT_INPUT_TO_FIELD;
  K_CONNECT_OUTPUT_TO_FIELD;
  K_GRAY_OUTPUT;
  K_CNT_DIR_SIGNAL;
  K_INC_SIGNAL;
  K_DEC_SIGNAL;
  K_SH_OP_SIGNAL;
  K_START_VALUE;
  K_END_VALUE;
  K_COUNT_AMOUNT;
  K_COUNT_DIRECTION;
  K_COUNT_ENABLE;
  K_SET;
  K_RESET;
  K_PROGRAMMABLE_DEPTH;
  K_PRIORITY_BYPASS;
  K_SYNC_FIFO;
  K_ASYNC_FIFO;
  K_DEPTH_EXTEND;
  K_WIDTH_EXTEND;
  K_WR_HOLD;
  K_PARALLEL_OUTPUT;
  K_PARALLEL_INPUT;
  K_RD_WORDS;
  K_WR_WORDS;
  K_SRAM_RD;
  K_SRAM_WR;
  K_PUSHBACK;
  K_FLOW_THROUGH;
  K_STALL_RD_SIDE;
  K_STALL_WR_SIDE;
  K_WR_RELEASE;
  K_ALMOST_EMPTY;
  K_ALMOST_FULL;
  K_OUTPUT_WR_ADDR;
  K_OUTPUT_RD_ADDR;
  K_CREDIT;
  K_RD_CREDIT;
  K_WR_CREDIT;
  K_FLOW;
  K_READ_VALID;
  K_BYPASS;
  K_GENERATE_WAVES;
  K_SIMULATION_TIMEOUT_COUNTER;
  K_STALL_GENERATION;
  K_GENERATE_REPORT;
  K_ASYNC_RESET;
  K_INIT;
  K_CLEAR;
  K_STOP;
  K_DIRECTION_CONTROL;
  K_INJECT_STALLS;
  K_EXTERNAL_UNIT_ENABLE;
  K_UNIT_ADDRESS_DECODER;
  K_SAL;
  K_SAR;
  K_SHL;
  K_SHR;
  K_ROL;
  K_ROR;
  K_PLI_SOCKET;
  K_CPP;
  K_TB;
  K_TRANSACTION;
  K_CYCLE_ACCURATE;
  K_NAND;
  K_NOR;
  K_AND;
  K_OR;
  K_NOT;
  K_PLUS;
  K_RISE;
  K_FALL;
  K_REG;
  K_WIRE;
  K_TRI;
  K_TRIAND;
  K_SUPPLY0;
  K_SUPPLY1;
  K_TRIOR;
  K_TRI0;
  K_TRI1;
  K_TRIREG;
  K_WAND;  
  K_WOR;
  K_INTEGER;
  K_TIME;
  K_TRUE;
  K_FALSE;
  K_FILE_CPLUSPLUS;
  K_FILE_VERILOG;
  K_S;
  K_US;
  K_MS;
  K_NS;
  K_PS;
  K_COLUMNS;
  K_ROWS;
  K_WAVE_TYPE_FSDB;
  K_WAVE_TYPE_VCD;
  K_UP;
  K_DOWN;
  K_COMBINATIONAL;
  K_SEQUENTIAL;
}

//*** the rule that starts the parser - called form main ***//
//**********************************************************//
source_text 

{
  if (!currentFilename.wasFilenameSet()) {
    DCERR("PARSER - WARNING - Filename is not being set by preprocessor - setting it the old fashion way ");
    currentFilename.setFilename(_RS(currentParsedFile.top())); //soon the be deprecated
    currentFilename.setLine(-1,0);
  }
  initializeMap();
}
:

  (description)* 
  EOF!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, ex.getLine());
  cslParserHasErrors = TRUE;
  consume();
}
catch [ANTLRException &ex] {
  RefString temp = _RS(ex.toString());
  TInt first = temp->find(':', 0) + 1;
  TInt second = temp->find(':', first);
  RefString line = _RS(temp->substr(first, second - first));
  first = ++second;
  second = temp->find(':', first);
  RefString column = _RS(temp->substr(first, second - first));
  RefString msg = _RS(temp->substr(++second));
  args.push_back(*column);
  args.push_back(*msg);
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, stringToInt(line));
  cslParserHasErrors = true;
  consumeUntil( SEMI );
}


//*** the rule that calls the most important(and first) rules from parser ***//
//***************************************************************************//
description 

:

(
 csl_command
 | csl_declaration
 | preprocessor_directive
 | tok:SEMI!
 | unexpected
)
;
exception
catch [NoViableAltException &noViable] {
  args.push_back(intToString(noViable.getColumn()));
  args.push_back(noViable.getMessage());
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, noViable.getLine());
  cslParserHasErrors = true;
  //consume();
}
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, ex.getLine());
  cslParserHasErrors = true;
  //consume();
}

unexpected

:

( 
 UNSIGNED_NUMBER      !
 | NZ_UNSIGNED_NUMBER !
 | REAL_NUMBER        !
 | REAL_NUMBER_EXP    !
 | TICK               !
 | BACKTICK           !
 | AT                 !
 | COLON              !
 | COMMA              !
 | LBRACK             !
 | RBRACK             !
 | LCURLY             !
 | RCURLY             !
 | LPAREN             !
 | RPAREN             !
 | QUESTION           !
 | LNOT               !
 | NOT                !
 | AND                !
 | NAND               !
 | OR                 !
 | NOR                !
 | XOR                !
 | XNOR               !
 | STAR               !
 | POW                !
 | DIV                !
 | MOD                !
 | EQUAL              !
 | NOT_EQ             !
 | NOT_EQ_CASE        !
 | EQ_CASE            !
 | LAND               !
 | TAND               !
 | LOR                !
 | LT_                !
 | LE                 !
 | GT                 !
 | GE                 !
 | SL                 !
 | SSL                !
 | SR                 !
 | SSR                !
 | TRIGGER            !
 | PPATH              !
 | FPATH              !
 | PSTAR              !
 | STARP              !
 | PO_POS             !
 | PO_NEG             !
 | SUPERSTAR          !
)

{
  args.push_back(intToString(1));
  string errorMessage;
  errorMessage.append("Unexpected Token: ");
  errorMessage.append((LT(1))->getText());   
  args.push_back(errorMessage);
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, (LT(1))->getLine());
  cslParserHasErrors = true;
  //consume();
}

;
exception
catch [NoViableAltException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, ex.getLine());
  cslParserHasErrors = true;
  //consume()
}
catch [ANTLRException &ex] {
  RefString temp = _RS(ex.toString());
  TInt first = temp->find(':', 0) + 1;
  TInt second = temp->find(':', first);
  RefString line = _RS(temp->substr(first, second - first));
  first = ++second;
  second = temp->find(':', first);
  RefString column = _RS(temp->substr(first, second - first));
  RefString msg = _RS(temp->substr(++second));
  args.push_back(*column);
  args.push_back(*msg);
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, stringToInt(line));
  cslParserHasErrors = true;
  consumeUntil( SEMI );
}



//***** PREPROCESSOR DIRECTIVE *****//
//*** - has form '# @filename @line'
//*** - @filename is the name of the current parsed file
//*** - @line is the current line in @filename(next line is the line @line from @filename)
//***************************************************************************************//
preprocessor_directive

:
(
 pd:POUND!
 exp:expression!
 un:unsigned_number!

               { 
                 RefString filename =_RS();
                 RefCslAST temp = #exp;
                 temp = temp->getFirstChild()->getFirstChild();// the filename should always be expr_primary_identifier (a.c.b.d) FILENAME IS NOT ALLOWED TO END IN DOT
                 while (ANTLR_USE_NAMESPACE(antlr)nullAST != temp) {
                   if (!filename->empty()) { filename->append( "."); }
                   filename->append( temp->getText());
                   temp = temp->getNextSibling();
                 }
                 currentFilename.setFilename(filename);
                 currentFilename.setLine(#pd->getLine(), stringToInt(_RS(#un->getText())));
               }

)
;


//*****************************************************************************************************************************************************//
//*****************************************************************************************************************************************************//
//************************************************************* TYPE DECLARATIONS *********************************************************************//
//*****************************************************************************************************************************************************//
//*****************************************************************************************************************************************************//



//*************************************************************************************************************************************************************************//
//*** csl declarations rule ***//
//*************************************************************************************************************************************************************************//
csl_declaration

{
  RefCslAST temp;
}
:

(
(dec1:K_CSL_UNIT^                            csl_unit_declaration                                                          {temp = #dec1; }
 |  dec2:K_CSL_SIGNAL^                        csl_signal_declaration                                                       {temp = #dec2; }
 |  dec3:K_CSL_PORT^                          csl_port_declaration                                                         {temp = #dec3; }
 |  dec4:K_CSL_BITRANGE^                      csl_bitrange_declaration                                                     {temp = #dec4; }
 |  dec5:K_CSL_SIGNAL_GROUP^                  csl_signal_group_declaration                                                 {temp = #dec5; }
 |  dec6:K_CSL_INTERFACE^                     csl_interface_declaration                                                    {temp = #dec6; }
 |  dec7:K_CSL_LIST^                          csl_list_declaration[#dec7->getLine(), #dec7->getColumn()]                   {temp = #dec7; }
 |  dec8:K_CSL_REGISTER_FILE^                 csl_register_file_declaration                                                {temp = #dec8; }
 |  dec9:K_CSL_TESTBENCH^                     csl_testbench_declaration                                                    {temp = #dec9; }
 // | dec10:K_CSL_EVENT^                         csl_event_declaration                                                        {temp = #dec10;}
 | dec13:K_CSL_INCLUDE^                       csl_include_declaration                                                      {temp = #dec13;}
 | dec14:K_CSL_ISA_FIELD^                     csl_isa_field_declaration                                                    {temp = #dec14;}
 | dec15:K_CSL_ISA_ELEMENT^                   csl_isa_element_declaration                                                  {temp = #dec15;}
 | dec16:K_CSL_ENUM^                          csl_enum_declaration                                                         {temp = #dec16;}
 | dec17:K_CSL_FIELD^                         csl_field_declaration                                                        {temp = #dec17;}
 | dec18:K_CSL_FIFO^                          csl_fifo_declaration                                                         {temp = #dec18;}
 | dec19:K_CSL_MEMORY_MAP^                    csl_memory_map_declaration                                                   {temp = #dec19;}
 | dec20:K_CSL_MEMORY_MAP_PAGE^               csl_memory_map_page_declaration                                              {temp = #dec20;}
 | dec21:K_CSL_REGISTER^                      csl_register_declaration                                                     {temp = #dec21;}
 | dec22:K_CSL_READ_INTERFACE^                csl_read_interface_declaration                                               {temp = #dec22;}
 | dec23:K_CSL_WRITE_INTERFACE^               csl_write_interface_declaration                                              {temp = #dec23;}
 | dec24:K_CSL_STATE_DATA^                    csl_state_data_declaration                                                   {temp = #dec24;}
 | dec25:K_CSL_VECTOR^                        csl_vector_declaration                                                       {temp = #dec25;}
 | dec26:K_CSL_MEMORY^                        csl_memory_declaration                                                       {temp = #dec26;}
 | dec27:K_CSL_MULTI_DIM_BITRANGE^            csl_multi_dim_bitrange_declaration                                           {temp = #dec27;}
 | dec28:K_CSL_PIPELINE^                      csl_pipeline_declaration                                                     {temp = #dec28;}
 | dec29:K_CSL_PIPESTAGE^                     csl_pipestage_declaration                                                    {temp = #dec29;}
 | dec30:K_CONST^                             csl_const_int_declaration                                                    {temp = #dec30;}
//   | K_CSL_SIGNAL_PATTERN_GENERATOR^      csl_signal_pattern_generator_declaration 
)

{ setCurrentFilename(temp); }

    SEMI!
)
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, ex.getLine());
  cslParserHasErrors = true;
  consumeUntil( SEMI );
}



//*************************************************************************************************************************************************************************//
//*** csl_read_interface delaration ***//
//*************************************************************************************************************************************************************************//
csl_read_interface_declaration

:

( id:IDENTIFIER      { setCurrentFilename(#id); } )
;



//*************************************************************************************************************************************************************************//
//*** csl_write_interface declaration ***//
//*************************************************************************************************************************************************************************//
csl_write_interface_declaration

:

( id:IDENTIFIER  { setCurrentFilename(#id); } )
;



//*************************************************************************************************************************************************************************//
//*** csl_state_data declaration ***//
//*************************************************************************************************************************************************************************//
csl_state_data_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}
:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TSTATED_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER  { setCurrentFilename(#id); }
  ( COMMA!     { if (!wasPredeclaration) { wasPredeclaration = TRUE; } }
    id2:IDENTIFIER

    {//set real filename + line for identifier id2
    setCurrentFilename(#id2);
    //symTree predeclare object id2
    RefString objectName = _RS(#id2->getText());
    predeclareObject(objectName, NSSymbolTable::TSTATED_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
    wasPredeclaration = TRUE;
  }

  )*
  ( {!wasPredeclaration}?  csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TSTATED_DECL]  { wasDefinition = TRUE; }  )?

 {//if no definition symTree predeclare object id
   if (!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TSTATED_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }
 }

)
;



//*************************************************************************************************************************************************************************//
//*** csl_vector declaration ***//
//*************************************************************************************************************************************************************************//
csl_vector_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}
:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TVEC_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER    { setCurrentFilename(#id); }
 ( COMMA!     { if (!wasPredeclaration) { wasPredeclaration = TRUE; } }
   id2:IDENTIFIER

 {//set real filename + line for object id2
   setCurrentFilename(#id2);
   //symTree predeclare object id2
   predeclareObject(_RS(#id2->getText()), NSSymbolTable::TVEC_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
   wasPredeclaration = TRUE;
 }

 )*
  ( {!wasPredeclaration}?  csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TVEC_DECL]  { wasDefinition = TRUE; } )?

 {//if no definition symTree predeclare object id
   if (!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TVEC_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }
 }

)
;



//*************************************************************************************************************************************************************************//
//*** csl_memory declaration ***//
//*************************************************************************************************************************************************************************//
csl_memory_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}
:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TMEM_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER   { setCurrentFilename(#id); }
  ( COMMA!    { if (!wasPredeclaration) {wasPredeclaration = TRUE; } }
    id2:IDENTIFIER

  {//set real filename + line for id2
    setCurrentFilename(#id2);
    //symTree predeclare id2
    predeclareObject(_RS(id2->getText()), NSSymbolTable::TMEM_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

 )*
  ( {!wasPredeclaration}?     csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TMEM_DECL]   { wasDefinition = TRUE; } )?

 {// if no definition predeclare object id
   if (!wasDefinition) { predeclareObject(_RS(id->getText()), NSSymbolTable::TMEM_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }
 }

)
;



//*************************************************************************************************************************************************************************//
//*** csl_isa_field declaration ***//
//*************************************************************************************************************************************************************************//
csl_isa_field_declaration

{
  TBool wasDefinition        = FALSE;
  TBool wasSecondDeclaration = FALSE;
  TBool wasSecondDefinition  = FALSE;
}
:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 ;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL;
  TInt instantiationMask  = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TISAF_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER { setCurrentFilename(#id); }
  ( LPAREN! 

  { wasDefinition = TRUE; 
    //symTree declare + define id object
    declareObject(_RS(#id->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
    defineObject(_RS(#id->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
  }

    exp1:expression  { if (STRING == #exp1->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting numeric expression or identifier as first argument"), #exp1->getLine(), #exp1->getColumn()); } }
    ( COMMA! exp2:expression   { if (STRING == #exp2->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting numeric expression or identifier as second argument"), #exp2->getLine(), #exp2->getColumn()); } }
      ( COMMA! exp3:expression

      { if (EXPR_PRIMARY_IDENTIFIER != #exp3->getFirstChild()->getType() //third argument must be identifier
            && FUNCTION_CALL_RET_ID != #exp3->getFirstChild()->getType()) 
          { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting identifier as third argument"), #exp3->getLine(), #exp3->getColumn()); } 
      } 

       )? 
    )?
    RPAREN!
  )?
  ( COMMA!  { if (!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }
    id2:IDENTIFIER    { setCurrentFilename(#id2); if (!wasSecondDeclaration) { wasSecondDeclaration = TRUE; } }
    ( LPAREN! { wasSecondDefinition = TRUE; }
      exp4:expression   { if (STRING == #exp4->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting numeric expression or identifier as first argument"), #exp4->getLine(), #exp4->getColumn()); } }
      ( COMMA! exp5:expression   { if (STRING == #exp5->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting numeric expression or identifier as second argument"), #exp5->getLine(), #exp5->getColumn()); } }
        ( COMMA! exp6:expression
          
        { if (EXPR_PRIMARY_IDENTIFIER != #exp6->getFirstChild()->getType() //third argument must be identifier
              && FUNCTION_CALL_RET_ID != #exp6->getFirstChild()->getType()) 
            { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting identifier as third argument"), #exp6->getLine(), #exp6->getColumn()); } 
        }
          
        )? 
      )?
      RPAREN!
    )?
    
  {//if not defined symTree predeclare id2, if defined symTree declare + define id2
    if (!wasSecondDefinition) { predeclareObject(_RS(#id2->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn()); }
    else {declareObject(_RS(#id2->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
      defineObject(_RS(#id2->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
    }
  }

  )*
  ( {!wasDefinition && !wasSecondDeclaration}?  csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TISAF_DECL] { wasDefinition = TRUE; } )?
  //if not defined symTree predeclare id object
 { if (!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }
)
;



//*************************************************************************************************************************************************************************//
//*** csl_isa_element declaration ***//
//*************************************************************************************************************************************************************************//
csl_isa_element_declaration

{
  RefString inheritString;
  TInt line = -1, column = -1;
  RefCslAST temporary;
}
:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 ;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TISAE_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER!

 {//set real filename + line for id
   setCurrentFilename(#id);
   //create fake vertex that tells walker that CSL_ISA_ELEMENT_DECLARATION follows + add to AST
   temporary = #(#[CSL_ISA_ELEMENT_DECLARATION, "CSL_ISA_ELEMENT_DECLARATION"], #id);
   setCurrentFilename(temporary, #id->getColumn(), #id->getLine());
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
 }

  ( col:COLON!  id2:IDENTIFIER!

  {//set real filename + line for id2 
    setCurrentFilename(#id2);
    //create fake vertex that tells walker that inheritance follows + add to AST
    RefCslAST temp = #(#[PARENT_CLASS, "PARENT_CLASS"], #id2);
    setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
    temporary->addChild(temp);
    inheritString = _RS(#id2->getText());
    line = #id2->getLine();
    column = #id2->getColumn();
  }

  )?
  (  csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TISAE_DECL, inheritString, line, column]!  { temporary->addChild(returnAST); }  )
)
;



//*************************************************************************************************************************************************************************//
//*** csl_enum declaration ***//
//*************************************************************************************************************************************************************************//
csl_enum_declaration

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 ;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TENUM_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER   

 {//set real filename + line for id
   setCurrentFilename(#id);
   // symTree declare + define object id
   declareObject(_RS(#id->getText()), NSSymbolTable::TENUM_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
   defineObject(_RS(#id->getText()), NSSymbolTable::TENUM_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
 }

  LCURLY!  (  csl_enum_declaration_item  (  COMMA!  csl_enum_declaration_item  )*  )?  RCURLY! 
)
;



//*************************************************************************************************************************************************************************//
//*** csl_enum item declaration ***//
//*************************************************************************************************************************************************************************//
csl_enum_declaration_item

{
  RefCslAST temp;
}

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 ;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TENUMIT_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(  id:IDENTIFIER!

 {//set real filename + line for id
   setCurrentFilename(#id);
   //symTree declare + define id
   declareObject(_RS(#id->getText()), NSSymbolTable::TENUMIT_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
   defineObject(_RS(#id->getText()), NSSymbolTable::TENUMIT_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
   //add fake vertex to AST so that walker knows that enum item follows
   temp = #(#[ENUM_ITEM, "ENUM_ITEM"], #id);
   setCurrentFilename(temp, #id->getColumn(), #id->getLine());
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
 }

   ( as:ASSIGN! 
     ( exp:expression!

     {//exp is only allowed to be numeric value (identifiers can be numeric for example enum items :) )
       if (STRING == #exp->getFirstChild()->getType()) { 
         throwDeclarationError(_RS("csl_enum"), _RS("Expecting numeric expression in assignment "), #exp->getLine(), #exp->getColumn()); 
       }
       temp->addChild(returnAST);
     }  

     )  
   )?
)
;



//*************************************************************************************************************************************************************************//
//*** csl_field declaration ***//
//*************************************************************************************************************************************************************************//
csl_field_declaration

{
  TBool wasDefinition        = FALSE;
  TBool wasSecondDeclaration = FALSE;
  TBool wasSecondDefinition  = FALSE;
  NSSymbolTable::EObjType currentScope = NSSymbolTable::TUNDEF;
}

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 ;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TFIELD_DECL;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TFIELD_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TFIELD_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER { setCurrentFilename(#id); currentScope = symTree->getCurrentScope()->getType();}
  ( LPAREN! 

  { wasDefinition = TRUE; 
    //symTree declare + define id object
    declareObject(_RS(#id->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
    defineObject(_RS(#id->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
  }

    exp1:expression  { if (STRING == #exp1->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_field"), _RS("Expecting numeric expression or identifier as first argument"), #exp1->getLine(), #exp1->getColumn()); } }
    ( COMMA! exp2:expression   { if (STRING == #exp2->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_field"), _RS("Expecting numeric expression or identifier as second argument"), #exp2->getLine(), #exp2->getColumn()); } }
      ( COMMA! exp3:expression 

      { if (EXPR_PRIMARY_IDENTIFIER != #exp3->getFirstChild()->getType() //third argument must be identifier
            && FUNCTION_CALL_RET_ID != #exp3->getFirstChild()->getType()) 
          { throwDeclarationError(_RS("csl_field"), _RS("Expecting identifier as third argument"), #exp3->getLine(), #exp3->getColumn()); } 
      } 

       )? 
    )?
    RPAREN!
  )?
  ( COMMA!  { if (!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }
    id2:IDENTIFIER    { setCurrentFilename(#id2); if (!wasSecondDeclaration) { wasSecondDeclaration = TRUE; } }
    ( LPAREN! { if (!wasSecondDefinition) { wasSecondDefinition = TRUE; } }
      exp4:expression   { if (STRING == #exp4->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_field"), _RS("Expecting numeric expression or identifier as first argument"), #exp4->getLine(), #exp4->getColumn()); } }
      ( COMMA! exp5:expression   { if (STRING == #exp5->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_field"), _RS("Expecting numeric expression or identifier as second argument"), #exp5->getLine(), #exp5->getColumn()); } }
        ( COMMA! exp6:expression
          
        { if (EXPR_PRIMARY_IDENTIFIER != #exp6->getFirstChild()->getType() //third argument must be identifier
              && FUNCTION_CALL_RET_ID != #exp6->getFirstChild()->getType()) 
            { throwDeclarationError(_RS("csl_field"), _RS("Expecting identifier as third argument"), #exp6->getLine(), #exp6->getColumn()); } 
        }
          
        )? 
      )?
      RPAREN!
    )?
    
  {//if not defined symTree predeclare id2, if defined symTree declare + define id2
    if (!wasSecondDefinition) { predeclareObject(_RS(#id2->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn()); }
    else {declareObject(_RS(#id2->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
      defineObject(_RS(#id2->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
    }
  }

  )*
  ( {!wasDefinition && !wasSecondDeclaration && TDESIGN == currentScope}?  csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TFIELD_DECL] { wasDefinition = TRUE; } )?
  //if not defined symTree predeclare id object
 { if (!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }
)
;



//*************************************************************************************************************************************************************************//
//*** csl_include declaration ***//
//*************************************************************************************************************************************************************************//
csl_include_declaration

:

( LPAREN! 
  ( id:IDENTIFIER!

  {//set real filename + line for id
    setCurrentFilename(#id);
    // checl if literal received and if so add fake vertex to AST
    RefString literalString = _RS(#id->getText());
    TLInt literalEnum = getLiteralEnum(literalString);
    RefCslAST temp;
    switch (literalEnum) {
      case K_LITERAL_FILE_CPLUSPLUS :
        temp = #(#[K_FILE_CPLUSPLUS, "K_FILE_PLUSPLUS"]);
        break;
      case K_LITERAL_FILE_VERILOG :
        temp = #(#[K_FILE_VERILOG, "K_FILE_VERILOG"]);
        break;
      default :
        RefString msg = _RS("Unexpected token '");
        msg->append( #id->getText());
        msg->append( "' ");
        throwDeclarationError(_RS("csl_include"), msg, #id->getLine(), #id->getColumn());
    }
    setCurrentFilename(temp, #id->getColumn(), #id->getLine());
    astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
  }

  ) 
  com:COMMA!  exp:expression!
  
 {//exp is allowed to be only string
   if (STRING                    != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwDeclarationError(_RS("csl_include"), _RS("Expecting a string as second argument "), #exp->getLine(),#exp->getColumn());
   }
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** csl_event declaration ***//
//*************************************************************************************************************************************************************************//
// not v1 
//csl_event_declaration
//
//: 
//
//(  id:IDENTIFIER
//
// {//set real filename + line for id
//    setCurrentFilename(#tok);
//    //symTree declare + define id object 
//    declareObject(_RS(#id->getText()), NSSymbolTable::TEVENT_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
//    defineObject(_RS(#id->getText()), NSSymbolTable::TEVENT_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
//  }
//  
//   ( COMMA!  id2:IDENTIFIER
//
//   {//set real filename + line for id2
//     setCurrentFilename(#id2);
//     //symTree declare + define id2 object
//     declareObject(_RS(#id2->getText()), NSSymbolTable::TEVENT_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
//     defineObject(_RS(#id2->getText()), NSSymbolTable::TEVENT_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
//   }
//  )*
//)
//;



//*************************************************************************************************************************************************************************//
//*** csl_testbench declaration ***//
//*************************************************************************************************************************************************************************//
csl_testbench_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 ;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TRF_DECL | NSSymbolTable::TFIFO_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TTB_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER   { setCurrentFilename(#id); }
  ( COMMA!  id2:IDENTIFIER
  
  {//predeclare id and id2
    if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(#id->getText()), NSSymbolTable::TTB_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());}
    setCurrentFilename(#id2);
    predeclareObject(_RS(#id2->getText()), NSSymbolTable::TTB_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

   )*
  (  {!wasPredeclaration}?   csl_unit_definition [_RS(#id->getText()), NSSymbolTable::TTB_DECL]  { wasDefinition = TRUE; } )?

 { if (!wasDefinition && !wasPredeclaration) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TTB_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }

)
;



//*************************************************************************************************************************************************************************//
//*** csl_fifo declaration ***//
//*************************************************************************************************************************************************************************//
csl_fifo_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TFIFO_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(  id:IDENTIFIER  { setCurrentFilename(#id); }
   (  COMMA! id2:IDENTIFIER 

   {// predeclaration of id and id2
     if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(#id->getText()), NSSymbolTable::TFIFO_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }
     setCurrentFilename(#id2);
     predeclareObject(_RS(#id2->getText()), NSSymbolTable::TFIFO_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
   }

   )*
   ( {!wasPredeclaration}?  csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TFIFO_DECL] { wasDefinition = TRUE; } )? 

 { if (!wasPredeclaration && !wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TFIFO_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }
   
)
;



//*************************************************************************************************************************************************************************//
//*** csl_register_file declaration ***//
//*************************************************************************************************************************************************************************//
csl_register_file_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TRF_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(  id:IDENTIFIER  { setCurrentFilename(#id); }
  (  COMMA!  id2:IDENTIFIER 

  {//predeclare id and id2
    if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(#id->getText()), NSSymbolTable::TRF_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }
    setCurrentFilename(#id2);
    predeclareObject(_RS(#id2->getText()), NSSymbolTable::TRF_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

  )*
   ( {!wasPredeclaration}?  csl_unit_definition[_RS(#id->getText()), TRF_DECL]  { wasDefinition = TRUE; }   )?

 { if (!wasDefinition && !wasPredeclaration) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TRF_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }

)
;      



//*************************************************************************************************************************************************************************//
//*** csl_memory_map declaration ***//
//*************************************************************************************************************************************************************************//
csl_memory_map_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TMEMMAP_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(  id:IDENTIFIER  { setCurrentFilename(#id); }
  ( COMMA!  id2:IDENTIFIER

  {//predeclare id and id2
    if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(#id->getText()), NSSymbolTable::TMEMMAP_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }
    setCurrentFilename(#id2);
    predeclareObject(_RS(#id2->getText()), NSSymbolTable::TMEMMAP_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

  )*
   (  {!wasPredeclaration}?  csl_unit_definition[_RS(#id->getText()), TMEMMAP_DECL]  { wasDefinition = TRUE; }  )?

 { if (!wasDefinition && !wasPredeclaration) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TMEMMAP_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }

)
;  



//*************************************************************************************************************************************************************************//
//*** csl_memory_map_page declaration ***//
//*************************************************************************************************************************************************************************//
csl_memory_map_page_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 | NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TMEMMAPP_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER  { setCurrentFilename(#id); }
  ( COMMA!  id2:IDENTIFIER 

  {
    if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(#id->getText()), NSSymbolTable::TMEMMAPP_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }
    setCurrentFilename(#id);
    predeclareObject(_RS(#id2->getText()), NSSymbolTable::TMEMMAPP_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

  )?

  ( {!wasPredeclaration}?  csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TMEMMAPP_DECL]  { wasDefinition = TRUE; } )?

 {  if (!wasDefinition && !wasPredeclaration) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TMEMMAPP_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }

)
;



//*************************************************************************************************************************************************************************//
//*** csl_register declaration ***//
//*************************************************************************************************************************************************************************//
csl_register_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TREG_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id:IDENTIFIER  { setCurrentFilename(#id); }
  ( COMMA!  id2:IDENTIFIER

  {//predeclare id and id2
    if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(#id->getText()), NSSymbolTable::TREG_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());  }
    setCurrentFilename(#id2);
    predeclareObject(_RS(#id2->getText()), NSSymbolTable::TREG_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

  )*
  ( {!wasPredeclaration}?  csl_unit_definition[_RS(#id->getText()), NSSymbolTable::TREG_DECL]  { wasDefinition = TRUE; }  )?

 { if (!wasPredeclaration && !wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TREG_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } }

)
;



//*************************************************************************************************************************************************************************//
//*** csl_unit declaration ***//
//*************************************************************************************************************************************************************************//
csl_unit_declaration

{ 
  TBool             wasPredeclaration  = FALSE; 
  TBool             wasDefinition      = FALSE;
  RefString         objectName;
}
:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TUNIT_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id1:IDENTIFIER   { setCurrentFilename(#id1); } 
  ( COMMA!  id2:IDENTIFIER 

  { // set real filename + line for id2 identifier
    setCurrentFilename(#id2);
    // symTree predeclare id2 identifier (id1 is predeclared at the end of rule)
    objectName = _RS(#id2->getText());
    predeclareObject(objectName, NSSymbolTable::TUNIT_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
    wasPredeclaration = TRUE; 
  }

  )*  
  ( {!wasPredeclaration}?  (

    { //symTree declare id1 identifier
      objectName = _RS(#id1->getText());
      declareObject(objectName, NSSymbolTable::TUNIT_DECL, symTree, currentFilename.getFilename(), #id1->getLine(), #id1->getColumn());
    }

    csl_unit_definition[objectName, NSSymbolTable::TUNIT_DECL]   { wasDefinition = TRUE; }  )? )?

 {
   // symTree predeclare id1 identifier
   if (!wasPredeclaration && !wasDefinition) { objectName = _RS(#id1->getText());
     declareObject(objectName, NSSymbolTable::TUNIT_DECL, symTree, currentFilename.getFilename(), #id1->getLine(), #id1->getColumn());
   }
 }

)
;



//*************************************************************************************************************************************************************************//
//*** csl_list declaration ***//
//*************************************************************************************************************************************************************************//
//not for ver 1.0
csl_list_declaration[TInt line, TInt column]

{
  TBool isIdList = FALSE;
  TBool isNotAnonymous = FALSE;
}
: 

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0 ;
  TInt declarationMask    = 0 | ALL_SCOPE_HOLDERS_AND_DESIGN;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TLIST_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(
 ( id:IDENTIFIER  
   
 {
   setCurrentFilename(#id);
   RefString objectName = _RS(#id->getText());
   declareObject(objectName, NSSymbolTable::TLIST_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
   defineObject(objectName, NSSymbolTable::TLIST_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
   isNotAnonymous = TRUE;
 }

 )?
 ( isIdList = param_list_csl_list )?
   
 {
   if (!isNotAnonymous && !isIdList) {
     throwDeclarationError(_RS("csl_list"),  _RS("You must provide an identifier followed by a list or an anonymous list "), line, column);
   }
 }
 
 ( {isNotAnonymous}?  COMMA!  id2:IDENTIFIER
   
 {
   setCurrentFilename(#id2);
   RefString objectName = _RS(#id2->getText());
   declareObject(objectName, NSSymbolTable::TLIST_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
   defineObject(objectName, NSSymbolTable::TLIST_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
 }
 
  ( isIdList = param_list_csl_list  )?
 )*
)
;



//A csl_list can only contain ids(simple or hierarchical) and get function calls(those functions also have to return ids).
//There are two main types of lists:
//  1.A csl_list has no type. It gets one when used as an argument for different commands.
//    csl_list l(a,b,c);
//    csl_unit u,v;
//    u.add_instance_list(v,l);  //l becomes an instance_list
//    u.add_signal_list(wire,32,l);  // l becomes a list of signals
//    u.add_port_list(input,32,l);   // l becomes a list of ports
//  2.A csl_list can contain predeclared objects. This case is strictly related to the pass-by-value mechanism in csl. I'm writing a full csl example to emphasize on that.
//    csl_unit u,v,z;
//    scope u { 
//      csl_signal s; 
//      csl_bitrange br;
//      s.set_number_of_dimensions(2);
//      s.set_dim_bitrange(0,32);
//      s.set_dim_bitange(1,br);          // s is a two dimension signal with 2 bitranges: 16 and 32
//    }
//    scope v { 
//      csl_signal t(0,31); 
//      t.set_signal_prefix(v_);          // t is a one dimension signal with the bitrange of 32 and v_ prefix
//    }
//    csl_list l(u.s, v.t);               // s and t are included(copied) in a list
//    scope z { 
//      add_signal_list (wire, 8, l);     // the list has been added to the z unit meaning that the 2 signals s and t have been copied inside the unit
//                                        // and heir properties have been overriden: now they are both wires with one dimension and the bitrange of 8
//    }  // Because of the pass by value machanism there are, at this point, two copies of signal s(one in unit u and one in unit z) and
//       // two copies of signal t( one in unit v and one in unit z). Both the copies in unit z have altered properties compared to their "originals".
//       // In yhe pass by reference model this wouldn't have been possible. When adding the signal list, the proprieties of the u.s and v.t signals would have changed too.
//Most lists can be declared in both ways. An instance_list cannot(You cannot predeclare instances, so the only way to declare an instance_list is like in 1. ). 
//As this rule is used in all the rules that accept a csl_list(including add_instance_list),
//it is mandatory that we use a return var to flag the situations when the list is entirely made of simple ids, thus could be used as a param for add_instance_list.
//That's the use of the isIdList flag. If, at any time, while adding an expression to the csl_list that expression turns out to be a hid, the flag is set to false.
//That will cause the(*1) check in the add_instance_list rule to generate an antlr exception, but will have no effect on add_signal_list and add_port_list(they can both accept hids).
//*************************************************************************************************************************************************************************//
//*** csl_list parameter list ***//
//*************************************************************************************************************************************************************************//
//not for ver 1.0
param_list_csl_list returns [ bool isIdList]

{
  TBool isFunctionCall = FALSE;
  TBool isEPI          = FALSE;
}
: 

(  LPAREN!  { isIdList = true; }
   exp:expression 

 {
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       || #exp->getFirstChild()->getNumberOfChildren() != 1) {
     throwDeclarationError(_RS("csl_list"),  _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 ( COMMA!  exp2:expression 
   
 {
   if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
       || #exp2->getFirstChild()->getNumberOfChildren() != 1) {
     throwDeclarationError(_RS("csl_list"), _RS("Expecting identifier as argument "), #exp2->getLine(), #exp2->getColumn());
   }
 }

 )*
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** scope holder definition rule ***//
//*************************************************************************************************************************************************************************//
csl_unit_definition[RefString objectName = RefString(), NSSymbolTable::EObjType type = NSSymbolTable::TUNDEF, RefString inheritanceId = RefString(), TInt inheritanceLine = -1, TInt inheritanceColumn = -1]

{
    TInt  nrCstor = 0;
    TBool wasCstor = FALSE;
    RefCslAST temp;
}
:

(  lc:LCURLY!

 {//add false vertex to AST to tell that scope holder defnition is next
    temp = #(#[CSL_UNIT_DEFINITION, "CSL_UNIT_DEFINITION"]); 
    //set real filename + line of the fake vertex
    setCurrentFilename(temp, #lc->getColumn(), #lc->getLine());
    astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));

    //symTree define object @objectName
    declareObject(objectName, type, symTree, currentFilename.getFilename(), lc->getLine(), lc->getColumn());
    defineObject(objectName, type, symTree, currentFilename.getFilename(), lc->getLine(), lc->getColumn());
    //enter symTree scope of @objectName
    symTree->enterScope(objectName); 

    //inheritance checks
    if (inheritanceId) {
      NSSymbolTable::RefCSymNode parent = symTree->lookup(inheritanceId);
      if (!parent.get()) {
        RefString error = _RS("Inherited object '");
        error->append( *objectName);
        error->append( "' not found in scope");
        throwDeclarationError(getScopeHolderTypeStr(type), error, inheritanceLine, inheritanceColumn);
      }
      else if (NSSymbolTable::TISAE_DECL != type) {//inheritance allowed only for csl_isa_element objects
        RefString error = _RS("Inheritance is only allowed for type 'csl_isa_element'");
        throwDeclarationError(getScopeHolderTypeStr(type), error, inheritanceLine, inheritanceColumn);
      }
      else if (NSSymbolTable::TISAE_DECL != parent->getType()) {//inheritance allowed only from csl_isa_elements
        RefString error = _RS("Inherited object '");
        error->append( *objectName);
        error->append( "' is only allowed to be of type 'csl_isa_element'");
        throwDeclarationError(getTypeStr(type), error, inheritanceLine, inheritanceColumn);
      }
      //symTree add the children on the inherited object object to the current object
      NSSymbolTable::RefTMap_RefString_RefCSymNode children = parent->getChildren();
      if (children.get()) {
        TMap_RefString_RefCSymNode::iterator iter = children->begin();
        for (; children->end() != iter; ++iter) {
          if (!iter->second->isUserDefined()) {//symTree adding the objects from the inherited object to the current object
            declareObject(iter->first, iter->second->getType(), symTree, currentFilename.getFilename(), lc->getLine(), lc->getColumn());
            defineObject(iter->first, iter->second->getType(), symTree, currentFilename.getFilename(), lc->getLine(), lc->getColumn());
          }
          else {//symTree adding the instances from the inherited object to the current object
            instantiateObject(iter->first, iter->second->getUserDefinedType()->getName(), symTree, currentFilename.getFilename(),  lc->getLine(), lc->getColumn());
          }
        }
      }
    }
  }

   (  decl:csl_declaration!  { temp->addChild(returnAST);}
      | wasCstor = ic:csl_inst_or_cstor!

   {
     temp->addChild(returnAST);
     if (wasCstor) {
       ++nrCstor;
     }
   }

      | preprocessor_directive!
      | SEMI!
   )*

 {//exit the scope of the current object 
   symTree->exitScope();
   // verify that only one constructor appears in the object definition
   if (1 < nrCstor) {
     RefString error = _RS("A scope holder can't have more than one constructor. It currently has ");
     error->append( intToString(nrCstor));
     throwDeclarationError(getTypeStr(type), error, lc->getLine(), lc->getColumn());
   }
 }

   RCURLY!
)
;



//*************************************************************************************************************************************************************************//
//*** scope holder instantiations and constructor rule ***//
//*************************************************************************************************************************************************************************//
csl_inst_or_cstor returns [TBool isCstor = FALSE]

{ 
  RefString str         = _RS();
  RefCslAST temp               ;
}
:

(  id:IDENTIFIER!

 {//set real filename + line for id
    setCurrentFilename(#id);
    str = _RS(#id->getText());
  }

   (  inst:csl_inst[_RS(#id->getText())]!

   {//add false vertex to tell walker that a instantiation follows
     temp = #(#[CSL_INST, "CSL_INST"]);
     //set the real filename + line of false vertex
     setCurrentFilename(temp, #id->getColumn(), #id->getLine());
     //add the id and instantiation rule as children of the fake vertex
     temp->addChild(#id);
     temp->addChild(#returnAST);
   }
      |
      cstor:csl_cstor!
   {//set the return value
     isCstor = TRUE;
     //add false vertex that tells walker that constructor follows
     temp = #(#[CSL_CSTOR, "CSL_CSTOR"]);
     //add the id and the constructor rule as children of the fake vertex
     temp->addChild(#id);
     temp->addChild(returnAST);
     //verify that the constructor has the same name as the scope it is in
     NSSymbolTable::RefCSymNode currentScope = symTree->getCurrentScope();
     RefString currentScopeName = currentScope->getName();
     if (str->compare(*currentScopeName)) {
       RefString error = _RS("Constructor is not allowed to have a different name from the name of the scope");
       throwDeclarationError(getTypeStr(currentScope->getType()), error, #id->getLine(), #id->getColumn());
     }
   }

   )

 { /*set the real filename+line of the fake vertex*/setCurrentFilename(temp, #id->getColumn(), #id->getLine()); 
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
 }

)
;



//*************************************************************************************************************************************************************************//
//*** scope holder instantiations rule ***//
//*************************************************************************************************************************************************************************//
csl_inst[RefString str]

:

( id:IDENTIFIER

 {//set real filename + line for id
   setCurrentFilename(#id);
   //instantiate object id with type str
   RefString name = _RS(#id->getText());
   instantiateObject(name, str, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
 }

  ( lp1:LPAREN! 
    ( param_list_formal_to_actual_mapping
      | 
      exp:expression

    {//only numeric or identifier allowed
      if (STRING == #exp->getFirstChild()->getType()) {
        throwDeclarationError(str, _RS("Expecting numeric expression or identifier as argument of instantiation"), #exp->getLine(), #exp->getColumn());
      }
    }
      
     )  RPAREN!
   )? 
  ( COMMA!   id2:IDENTIFIER

  {//set real filename + line for id2
    setCurrentFilename(#id2);
    //instantiate object id2 with type str
    RefString name = _RS(#id2->getText());
    instantiateObject(name, str, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

    ( lp2:LPAREN! 
      ( param_list_formal_to_actual_mapping
        | 
        exp2:expression

      {//only numeric or id allowed
        if (STRING == #exp2->getFirstChild()->getType()) {
          throwDeclarationError(str, _RS("Expecting numeric expression or identifier as argument of instantiation"), #exp2->getLine(), #exp2->getColumn());
        }
      }

       )  RPAREN!
      )? 
    )* 
  SEMI!
)
;



//*************************************************************************************************************************************************************************//
//*** constructor rule ***//
//*************************************************************************************************************************************************************************//
csl_cstor

{
  TBool wasAssignment = FALSE;
}
:

(  LPAREN!  
   (  id1:IDENTIFIER! {setCurrentFilename(#id1);}   
      ( lp1:ASSIGN!   exp:expression { wasAssignment = TRUE; }  )?

   {//add false vertex to AST to let the walker know that a unit parameter follows
     RefCslAST temp = #(#[UNIT_PARAMETER, "UNIT_PARAMETER"], #id1);
     //set real filename + line of fake vertex
     setCurrentFilename(temp, #id1->getColumn(), #id1->getLine());
     //if the optional assignment is there add it as the child of the fake vertex
     if (wasAssignment) {
       temp->addChild(returnAST);
       wasAssignment = FALSE;
     }
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
    }
      
   ( COMMA!  id2:IDENTIFIER! {setCurrentFilename(#id2);}
     ( lp2:ASSIGN!  exp2:expression!  { wasAssignment = TRUE; } )?

   {//add false vertex to AST to let the walker know that a unit parameter follows
     RefCslAST temp = #(#[UNIT_PARAMETER, "UNIT_PARAMETER"], #id2);
     //set real filename + line of fake vertex
     setCurrentFilename(temp, #id2->getColumn(), #id2->getColumn());
     //if the optional assignment is there add it as the child of the fake vertex
     if (wasAssignment) {
       temp->addChild(returnAST);
       wasAssignment = FALSE;
     }
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
   }

    )*
  )?
   RPAREN!  LCURLY!
   ( csl_command!                     { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST)); }
     | preprocessor_directive!        
     | SEMI! 
   )*
   RCURLY!
)
;



//*************************************************************************************************************************************************************************//
//*** csl_interface declaration ***//
//*************************************************************************************************************************************************************************//
csl_interface_declaration

{
  TBool wasDefinition    = FALSE;
  TBool wasPredeclaration = FALSE;
}    
: 

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN ;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TIFC_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id1:IDENTIFIER   { setCurrentFilename(#id1); }
  ( COMMA!  id2:IDENTIFIER
  
  {// set real filename + line for id1 identifier
    setCurrentFilename(#id2);
    // symTree predeclare id2 object
    RefString objectName = _RS(#id2->getText());
    predeclareObject(objectName, NSSymbolTable::TIFC_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
    wasPredeclaration = TRUE;
  }

  )* 
  ( {!wasPredeclaration}?   
    
  {//symTree declare id1 object
    RefString objectName = _RS(#id1->getText());
    declareObject(objectName, NSSymbolTable::TIFC_DECL, symTree, currentFilename.getFilename(), #id1->getLine(), #id1->getColumn());
  }
    
    csl_unit_definition [_RS(#id1->getText()), NSSymbolTable::TIFC_DECL] { wasDefinition = TRUE; }
  )?
  
 {//if there was no id1 definition then predeclare id1
   if (!wasDefinition) {
     RefString objectName = _RS(#id1->getText());
     predeclareObject(objectName, NSSymbolTable::TIFC_DECL, symTree, currentFilename.getFilename(), #id1->getLine(), #id1->getColumn());
   }
 }
)
;



//*************************************************************************************************************************************************************************//
//*** csl_port declaration ***//
//*************************************************************************************************************************************************************************//
csl_port_declaration 

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0;
  TInt declarationMask    = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TPORT_DECL, predeclarationMask, declarationMask, instantiationMask);
}
 
( id1:IDENTIFIER
  
 {// set real filename + line for id1 identifier
   setCurrentFilename(#id1);
   // symTree declare + define id1 object
   RefString objectName = _RS(#id1->getText());
   declareObject(objectName, NSSymbolTable::TPORT_DECL, symTree, currentFilename.getFilename(), #id1->getLine(), #id1->getColumn());
   defineObject(objectName, NSSymbolTable::TPORT_DECL, symTree, currentFilename.getFilename(), #id1->getLine(), #id1->getColumn());
 }

  ( LPAREN!  param_list_csl_port   RPAREN!  )
  ( COMMA!  id2:IDENTIFIER

  {// set real filename + line for id2 identifier
    setCurrentFilename(#id2);
    // symTree declare + define id2 object
    RefString objectName = _RS(#id2->getText());
    declareObject(objectName, NSSymbolTable::TPORT_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
    defineObject(objectName, NSSymbolTable::TPORT_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

    ( LPAREN!  param_list_csl_port   RPAREN!  )
  )*
)
;



//*************************************************************************************************************************************************************************//
//*** csl_signal declaration ***//
//*************************************************************************************************************************************************************************//
csl_signal_declaration

:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TSIGNAL_DECL, predeclarationMask, declarationMask, instantiationMask);
}

( id1:IDENTIFIER 

 {// set real filename + line for id1 identifier
   setCurrentFilename(#id1);
   // symTree declare + define id1 object
   RefString objectName = _RS(#id1->getText());
   declareObject(objectName, NSSymbolTable::TSIGNAL_DECL, symTree, currentFilename.getFilename(), #id1->getLine(), #id1->getColumn());
   defineObject(objectName, NSSymbolTable::TSIGNAL_DECL, symTree, currentFilename.getFilename(), #id1->getLine(), #id1->getColumn());
 }

  ( LPAREN!  param_list_csl_signal   RPAREN! )?
  ( COMMA!  id2:IDENTIFIER 
  
  {// set real filename + line for id2 identifier
    setCurrentFilename(#id2);
    //symTree declare + define id2 object
    RefString objectName = _RS(#id2->getText());
    declareObject(objectName, NSSymbolTable::TSIGNAL_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
    defineObject(objectName, NSSymbolTable::TSIGNAL_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
  }

    ( LPAREN!  param_list_csl_signal  RPAREN! )?  
  )*
)
;



//*************************************************************************************************************************************************************************//
//*** csl_port parameter list ***//
//*************************************************************************************************************************************************************************//
param_list_csl_port

{
  TBool isDirOutput  = FALSE;
  TBool canBeComma = TRUE;
  TBool canBeRange = TRUE;
  TBool wasRange = FALSE;
}
: 

( exp1:expression! //*** direction ***//

 {//check if expression is port direction and add false vertex to AST if so; if expression is 
   // port hierarchial identifier then add it to AST
   RefCslAST exp1 = #exp1;
   exp1 = exp1->getFirstChild();
   //if expression doesn't have EXPR_PRIMARY_IDENTIFIER or FUNCTION_CALL_RET_ID type then it can not be port
   // direction or port hierarchical identifier
   if (EXPR_PRIMARY_IDENTIFIER != exp1->getType()
       && FUNCTION_CALL_RET_ID != exp1->getType()) { 
     throwDeclarationError(_RS("csl_port"), _RS("Expecting port direction or port hierarchical identifier as first argument"), #exp1->getLine(), #exp1->getColumn()); 
   }
   // if expression has EXPR_PRIMARY_IDENTIFIER type
   else if (FUNCTION_CALL_RET_ID != exp1->getType()) {
     exp1 = exp1->getFirstChild();
     //if expression contains nore than one identifier then expression is port hierarchical identifier so add it to AST
     if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp1->getNextSibling()
         || ANTLR_USE_NAMESPACE(antlr)nullAST != exp1->getFirstChild()) { 
       canBeComma = FALSE;//if port hierarchical identifier than it can't be followed by anything else
       astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
     }
     // if expression has only one identifier check to see if it is port direction;
     // if so then add the false vertex to AST
     else {
       RefString literalString = _RS(exp1->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temporary;
       switch (literalEnum) {
         case K_LITERAL_INPUT :
           temporary = #(#[K_INPUT, "K_INPUT"]);
           break;
         case K_LITERAL_OUTPUT :
           temporary = #(#[K_OUTPUT, "K_OUTPUT"]);
           isDirOutput = TRUE;// 'reg', 'integer' and 'time' types require 'output' direction
           break;
         case K_LITERAL_INOUT :
           temporary = #(#[K_INOUT, "K_INOUT"]);
           break;
         default :
           canBeComma = FALSE;//expression has only one identifier, but that identifier is not port direction 
           // so it must be a port hierarchical identifier 
       }
       if (temporary) { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary)); 
         setCurrentFilename(temporary, #exp1->getColumn(), #exp1->getLine()); }
       else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));}
     }
   }// if expression if FUNCTION_CALL_RET_id add it to AST
   else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST)); }
 }

  ( {canBeComma}? COMMA!  exp2:expression! //*** type or range ***//

  {
    TBool error = FALSE;
    if (EXPR_PRIMARY_IDENTIFIER == #exp2->getFirstChild()->getType()) {

      if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp2->getFirstChild()->getFirstChild()->getFirstChild()
          && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp2->getFirstChild()->getFirstChild()->getNextSibling()) {

        RefString literalString = _RS(#exp2->getFirstChild()->getFirstChild()->getText());
        TLInt literalEnum = getLiteralEnum(literalString);
        RefCslAST temporary;
        TBool expectingOutput = FALSE;
        switch (literalEnum) {
          case K_LITERAL_WIRE :
            temporary = #(#[K_WIRE, "K_WIRE"]);
            break;
          case K_LITERAL_REG :
            if (!isDirOutput) {// 'reg', 'integer' and 'time' types require 'output' direction
              expectingOutput = TRUE;
            }
            else {
              temporary = #(#[K_REG, "K_REG"]);
            }
            break;
          case K_LITERAL_TRI :
            temporary = #(#[K_TRI, "K_TRI"]);
            break;
          case K_LITERAL_TRIAND :
            temporary = #(#[K_TRIAND, "K_TRIAND"]);
            break;
          case K_LITERAL_SUPPLY0 :
            temporary = #(#[K_SUPPLY0, "K_SUPPLY0"]);
            break;
          case K_LITERAL_SUPPLY1 :
            temporary = #(#[K_SUPPLY1, "K_SUPPLY1"]);
            break;
          case K_LITERAL_TRIOR :
            temporary = #(#[K_TRIOR, "K_TRIOR"]);
            break;
          case K_LITERAL_TRI0 :
            temporary = #(#[K_TRI0, "K_TRI0"]);
            break;
          case K_LITERAL_TRI1 :
            temporary = #(#[K_TRI1, "K_TRI1"]);
            break;
          case K_LITERAL_TRIREG :
            temporary = #(#[K_TRIREG, "K_TRIREG"]);
            break;
          case K_LITERAL_WAND :
            temporary = #(#[K_WAND, "K_WAND"]);
            break;
          case K_LITERAL_WOR :
            temporary = #(#[K_WOR, "K_WOR"]);
            break;
          case K_LITERAL_INTEGER :
            if (!isDirOutput) {// 'reg', 'integer' and 'time' types require 'output' direction
              expectingOutput = TRUE;
            }
            else {
              temporary = #(#[K_INTEGER, "K_INTEGER"]);
              canBeComma = FALSE;//integer does not allow bitrange
            }
            break;
          case K_LITERAL_TIME :
            if (!isDirOutput) {// 'reg', 'integer' and 'time' types require 'output' direction
              expectingOutput = TRUE;
            }
            else {
              temporary = #(#[K_TIME, "K_TIME"]);
            }
            break;
          default :
            error = TRUE;
        }
        if (expectingOutput) {
          throwDeclarationError(_RS("csl_port"), _RS("'reg', 'integer' and 'time' types require 'output' direction"), #exp2->getLine(), #exp2->getColumn()); 
        }

        if (!error) {

          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
          setCurrentFilename(temporary, #exp2->getColumn(), #exp2->getLine());
        }
      }
      else { error = TRUE; }
    }
    else if (FUNCTION_CALL_RET_ID == #exp2->getFirstChild()->getType()) {

      astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
      wasRange = TRUE;
    }
    else { error = TRUE; }

    if (error) {
      if (STRING == #exp2->getFirstChild()->getType()) {
      
        throwDeclarationError(_RS("csl_port"), _RS("Expecting port type or range as second argument"), #exp2->getLine(), #exp2->getColumn()); 
      }
      else {
        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
        wasRange = TRUE;
      }
    }
  }

    ( {canBeRange}? COMMA! exp3:expression! //*** range ***//

    {//exp3 can only be numeric
      if (STRING == #exp3->getFirstChild()->getType()) {

        throwCommandError(_RS("csl_port"), _RS("Expecting range as thrid argument"), #exp3->getLine(), #exp3->getColumn());
      }
      astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
      if (wasRange && canBeRange) { canBeRange = FALSE; }
    }

      ( {canBeRange}? COMMA! exp4:expression!  //*** range ***//

      {//exp4 can only be numeric
        if (STRING == #exp4->getFirstChild()->getType()) {

          throwCommandError(_RS("csl_port"), _RS("Expecting range as thrid argument"), #exp4->getLine(), #exp4->getColumn());
        }
        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
      }

       )?

     )?
  )?
)
;



//*************************************************************************************************************************************************************************//
//*** csl_signal parameter list ***//
//*************************************************************************************************************************************************************************//
param_list_csl_signal

{
  TBool wasType = FALSE;
  TBool canBeComma = TRUE;
}
:

( exp1:expression! //*** type, signal id, width, upper limit or bitrange id ***//

 {//first expression can be anything but STRING
   RefCslAST exp1 = #exp1;
   exp1 = exp1->getFirstChild();
   //error
   if (STRING == exp1->getType()) {
     throwDeclarationError(_RS("csl_signal"), _RS("Expecting signal type, width, upper limit, bitrange identifier or another signal identifier as first argument"), #exp1->getLine(), #exp1->getColumn());
   }
   //if expression if EXPR_PRIMARY_IDENTIFIER then if it only contains one identifier
   // check if it is type, if so add false vertex to AST, else just add to AST
   else if (EXPR_PRIMARY_IDENTIFIER == exp1->getType()) {
     exp1 = exp1->getFirstChild();
     //if expression has more than one identifier add to AST
     if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp1->getNextSibling()
         || ANTLR_USE_NAMESPACE(antlr)nullAST != exp1->getFirstChild()) {
       astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
     }
     // if expression has only one identifier check if type and if so add false
     //vertex to AST, if not just add to AST
     else {
       RefString literalString = _RS(exp1->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temporary;
       switch (literalEnum) {
         case K_LITERAL_INTEGER :
           temporary = #(#[K_INTEGER, "K_INTEGER"]);
           break;
         case K_LITERAL_WIRE :
           temporary = #(#[K_WIRE, "K_WIRE"]);
           break;
         case K_LITERAL_REG :
           temporary = #(#[K_REG, "K_REG"]);
           break;
         case K_LITERAL_TRI :
           temporary = #(#[K_TRI, "K_TRI"]);
           break;
         case K_LITERAL_TRIAND :
           temporary = #(#[K_TRIAND, "K_TRIAND"]);
           break;
         case K_LITERAL_TRIOR :
           temporary = #(#[K_TRIOR, "K_TRIOR"]);
           break;
         case K_LITERAL_TRI0 :
           temporary = #(#[K_TRI0, "K_TRI0"]);
           break;
         case K_LITERAL_TRI1 :
           temporary = #(#[K_TRI1, "K_TRI1"]);
           break;
         case K_LITERAL_TRIREG :
           temporary = #(#[K_TRIREG, "K_TRIREG"]);
           break;
         case K_LITERAL_WAND :
           temporary = #(#[K_WAND, "K_WAND"]);
           break;
         case K_LITERAL_WOR :
           temporary = #(#[K_WOR, "K_WOR"]);
           break;
         case K_LITERAL_SUPPLY0 :
           temporary = #(#[K_SUPPLY0, "K_SUPPLY0"]);
           break;
         case K_LITERAL_SUPPLY1 :
           temporary = #(#[K_SUPPLY1, "K_SUPPLY1"]);
           break;
         case K_LITERAL_TIME :
           temporary = #(#[K_TIME, "K_TIME"]);
           break;
         case K_LITERAL_REALTIME :
           temporary = #(#[K_REALTIME, "K_REALTIME"]);
           break;
         case K_LITERAL_REAL :
           temporary = #(#[K_REAL, "K_REAL"]);
           break;
         default :
           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
       }
       if (temporary) { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary)); 
         setCurrentFilename(temporary, #exp1->getColumn(), #exp1->getLine());
         wasType = TRUE;
       }
     }
   }// if expression is anything but STRING and EXPR_PRIMARY_IDENTIFIER add to AST
   else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST)); }
 }

  ({canBeComma}? COMMA!  ( exp2:expression! //*** width, upper limit, lower limit or bitrange id ***//
   
  {// this expression can be anything but STRING because identifiers can also have numeric value (for example enums)
    if (STRING == #exp2->getFirstChild()->getType()) {
      throwDeclarationError(_RS("csl_signal"), _RS("Expecting width, upper limit, lower limit or bitrange identifier as second argument"), #exp2->getLine(), #exp2->getColumn());
    }
    astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
  }

   ({canBeComma && wasType}? COMMA! exp3:expression! //*** lower limit ****//

   {//this expression can be anything but STRING because identifiers can have numeric values (for example enums)
     if (STRING == #exp3->getFirstChild()->getType()) {
       throwDeclarationError(_RS("csl_signal"), _RS("Expecting lower limit as third argument"), #exp3->getLine(), #exp3->getColumn());
     }
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
    
    )?
    |
     bitrange_pure! { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST)); }
    )
   )?
)?
;



//*************************************************************************************************************************************************************************//
//*** csl_signal_group declaration ***//
//*************************************************************************************************************************************************************************//
csl_signal_group_declaration

{
  TBool wasPredeclaration = FALSE;
  TBool wasDefinition     = FALSE;
}    

: 

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TSIGNALGR_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(  id:IDENTIFIER  { setCurrentFilename(#id); }
   ( COMMA!   id2:IDENTIFIER
  
   {//predeclare id and id2
     if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(#id->getText()), NSSymbolTable::TSIGNALGR_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }
     setCurrentFilename(#id2);
     predeclareObject(_RS(#id2->getText()), NSSymbolTable::TSIGNALGR_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
   }

  )*
   ( {!wasPredeclaration}?  csl_unit_definition [_RS(#id->getText()), NSSymbolTable::TSIGNALGR_DECL]   { wasDefinition = TRUE; }  )?

 { if (!wasPredeclaration && !wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TSIGNALGR_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); }  }

)
;



//*************************************************************************************************************************************************************************//
//*** csl_bitrange declaration ***//
//*************************************************************************************************************************************************************************//
csl_bitrange_declaration

{
  TBool wasDefinition       = FALSE;
}

: 

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL;
  TInt instantiationMask  = 0 ;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TBITRANGE_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(  id:IDENTIFIER { setCurrentFilename(#id); }
   ( LPAREN!   exp:expression  { if (STRING == #exp->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_bitrange"), _RS("Expecting numeric expression as first argument"), #exp->getLine(), #exp->getColumn()); } }
     ( COMMA!  exp2:expression

     { //first expression is not allowed to be STRING
       if (STRING == #exp2->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_bitrange"), _RS("Expecting numeric expression as second argument"), #exp2->getLine(), #exp2->getColumn()); } 
     }

      )?

   { wasDefinition = TRUE; 
     declareObject(_RS(#id->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
     defineObject(_RS(#id->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
   }

    RPAREN! 
   )?

 { if (!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } else { wasDefinition = TRUE; } }

   ( COMMA! id2:IDENTIFIER { setCurrentFilename(#id2); }
     ( LPAREN!   exp3:expression  { if (STRING == #exp3->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_bitrange"), _RS("Expecting numeric expression as first argument"), #exp3->getLine(), #exp3->getColumn()); } }
       ( COMMA!  exp4:expression

       { //first expression is not allowed to be STRING
         if (STRING == #exp4->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_bitrange"), _RS("Expecting numeric expression as second argument"), #exp4->getLine(), #exp4->getColumn()); } 
       }

       )?

     {//declare object id2
       declareObject(_RS(#id2->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
       defineObject(_RS(#id2->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
       wasDefinition = TRUE;
     }

       RPAREN! 
      )?

   { if (!wasDefinition) { predeclareObject(_RS(#id2->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn()); } else { wasDefinition = TRUE; } }

   )*
)
;



//*************************************************************************************************************************************************************************//
//*** csl_multi_dim_bitrange declaration ***//
//*************************************************************************************************************************************************************************//
csl_multi_dim_bitrange_declaration

{
  TBool wasDefinition = FALSE;
}
:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0;
  TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL;
  TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TDESIGN;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TMDB_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(  id:IDENTIFIER  { setCurrentFilename(#id); }
   ( LPAREN!  exp:expression 

   { // exp cannot be STRING
     if (STRING == #exp->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_multi_dim_bitrange"), _RS("Expecting identifier or numeric experssion as argument"), #exp->getLine(), #exp->getColumn()); } 
     declareObject(_RS(#id->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
     defineObject(_RS(#id->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
     wasDefinition = TRUE;
   }

     RPAREN!  
   )?

 { if (!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } else { wasDefinition = FALSE; }  }

   ( COMMA!  id2:IDENTIFIER  { setCurrentFilename(#id2); }
     LPAREN!  exp2:expression

   {// exp2 cannot be STRING
     if (STRING == #exp2->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_multi_dim_bitrange"), _RS("Expecting identifier or numeric experssion as argument"), #exp2->getLine(), #exp2->getColumn()); }
     declareObject(_RS(#id2->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
     defineObject(_RS(#id2->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
   }

   RPAREN!

   { if (!wasDefinition) { predeclareObject(_RS(#id2->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn()); } else { wasDefinition = FALSE; }  }

  )*
)
;



//*************************************************************************************************************************************************************************//
//*** csl_pipeline declaration ***//
//*************************************************************************************************************************************************************************//
csl_pipeline_declaration

{
  TBool wasDefinition = FALSE;
}
:

(  id:IDENTIFIER  { setCurrentFilename(#id); }
   ( LPAREN!  exp:expression

 {//exp is not allowed to be STRING 
   if (STRING == #exp->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_pipeline"), _RS("Expecting numeric expression as argument"), #exp->getLine(), #exp->getColumn()); }
   //declare+define id object
   declareObject(_RS(#id->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
   defineObject(_RS(#id->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn());
   wasDefinition = TRUE;
 }

     RPAREN!
   )?

 { if(!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } else { wasDefinition = FALSE; } }

   ( COMMA! id2:IDENTIFIER { setCurrentFilename(#id2); }
     ( LPAREN! exp2:expression

     {//exp2 is not allowed to be STRING 
       if (STRING == #exp2->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_pipeline"), _RS("Expecting numeric expression as argument"), #exp2->getLine(), #exp2->getColumn()); }
       //declare+define id object
       declareObject(_RS(#id2->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
       defineObject(_RS(#id2->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
       wasDefinition = TRUE;
     }

      )?

   { if(!wasDefinition) { predeclareObject(_RS(#id->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), #id->getLine(), #id->getColumn()); } else { wasDefinition = FALSE; } }

   )*
)
;



//*************************************************************************************************************************************************************************//
//*** csl_pipestage declaration ***//
//*************************************************************************************************************************************************************************//
// v2
csl_pipestage_declaration

:

(  id:IDENTIFIER  

{ setCurrentFilename(#id); 
  RefString str = _RS(#id->getText());
  declareObject(str, NSSymbolTable::TPIPESTG_DECL, symTree, currentFilename.getFilename(), id->getLine(), id->getColumn());
  defineObject(str, NSSymbolTable::TPIPESTG_DECL, symTree, currentFilename.getFilename(), id->getLine(), id->getColumn());
}

   ( COMMA! id2:IDENTIFIER

   {
     setCurrentFilename(#id2);
     RefString str2 = _RS(#id2->getText());
     declareObject(str2, NSSymbolTable::TPIPESTG_DECL, symTree, currentFilename.getFilename(), id2->getLine(), id2->getColumn());
     defineObject(str2, NSSymbolTable::TPIPESTG_DECL, symTree, currentFilename.getFilename(), id2->getLine(), id2->getColumn());
   }
)
)
;



//*************************************************************************************************************************************************************************//
//*** csl_const_int declaration ***//
//*************************************************************************************************************************************************************************//
csl_const_int_declaration

{
  antlr::RefCslAST temp = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
}
:

{
  //symTree predecl/decl/def options
  TInt predeclarationMask = 0;
  TInt declarationMask    = 0 | NSSymbolTable::TUNIT_DECL;
  TInt instantiationMask  = 0;
  setDeclarationAndInstantiationOptions(NSSymbolTable::TCONSTINT_DECL, predeclarationMask, declarationMask, instantiationMask);
}

(  it:K_INT! { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(#it)); }
// exp0:expression!
//
// {//check if literal 'int' was provided after const and add to AST fake vertex 
//   if (EXPR_PRIMARY_IDENTIFIER != #exp0->getFirstChild()->getType()
//       && FUNCTION_CALL_RET_ID != #exp0->getFirstChild()->getType()) {
//     throwDeclarationError(_RS("const"), _RS("Expecting 'int' after modifier 'const'"), #exp0->getLine(), #exp0->getColumn());
//   }
//   else if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp0->getFirstChild()->getFirstChild()->getNextSibling()
//            && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp0->getFirstChild()->getFirstChild()->getFirstChild()) {
//     RefString literalString = _RS(#exp0->getFirstChild()->getFirstChild()->getText());
//     TLInt literalEnum = getLiteralEnum(literalString);
//     switch (literalEnum) {
//       case K_LITERAL_INT :
//         temp = #(#[K_INT, "K_INT"]);
//         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//         break;
//       default:
//         RefString msg = _RS("Unknown type '");
//         msg->append( *literalString);
//         msg->append( "'. Expecting 'int' after modifier 'const'");
//         throwDeclarationError(_RS("const"), msg, #exp0->getLine(), #exp0->getColumn());
//     }
//     setCurrentFilename(temp, #exp0->getColumn(), #exp0->getLine());
//   }
//   else {throwDeclarationError(_RS("const"), _RS("Expecting 'int' after modifier 'const'"), #exp0->getLine(), #exp0->getColumn());}
// }

   id2:IDENTIFIER! { setCurrentFilename(#id2); }
   (  as:ASSIGN!   exp:expression!

   {//manually construct sub-tree and add to AST
     temp = #(#as, #id2, #[ASSIGNOR, "ASSIGNOR"], #exp);
     RefCslAST tmp = temp;
     tmp = tmp->getFirstChild()->getNextSibling();
     setCurrentFilename(tmp, #exp->getColumn(), #exp->getLine());
   }

   )?

 { if (!temp) { throwDeclarationError(_RS("const int"), _RS("Const int value must be given at declaration. Const int's cannot be modified after declaration/definition"), #id2->getLine(), #id2->getColumn()); } 
    else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp)); 
      declareObject(_RS(#id2->getText()), NSSymbolTable::TCONSTINT_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
      defineObject(_RS(#id2->getText()), NSSymbolTable::TCONSTINT_DECL, symTree, currentFilename.getFilename(), #id2->getLine(), #id2->getColumn());
    }   
   temp = RefCslAST();
  }

  ( COMMA!  id3:IDENTIFIER!  { setCurrentFilename(#id3); }
    ( as2:ASSIGN!   exp2:expression!

    {//manually construct sub-tree and add to AST
      temp = #(#as2, #id3, #[ASSIGNOR, "ASSIGNOR"], #exp2);
      RefCslAST tmp = temp;
      tmp = tmp->getFirstChild()->getNextSibling();
      setCurrentFilename(tmp, #exp2->getColumn(), #exp2->getLine());
    }

    )?

  { if (!temp) { throwDeclarationError(_RS("const int"), _RS("Const int value must be given at declaration. Const int's cannot be modified after declaration/definition"), #id3->getLine(), #id3->getColumn()); } 
    else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp)); 
      declareObject(_RS(#id3->getText()), NSSymbolTable::TCONSTINT_DECL, symTree, currentFilename.getFilename(), #id3->getLine(), #id3->getColumn());
      defineObject(_RS(#id3->getText()), NSSymbolTable::TCONSTINT_DECL, symTree, currentFilename.getFilename(), #id3->getLine(), #id3->getColumn());
    }
    temp = RefCslAST();
  }

  )*
)
;



//*************************************************************************************************************************************************************************//
//*** csl_cell declaration ***//
//*************************************************************************************************************************************************************************//
// not v1.0 type
//csl_cell_declaration
//
//{
//  bool stop = false;
//}
//
//: 
//
//(  tok:IDENTIFIER
//  {
//    setCurrentFilename(#tok);
//    RefString str = _RS(#tok->getText());
//    declareDefineNonScopeHolder(str, NSSymbolTable::TCELL_DECL, #tok->getLine(), #tok->getColumn());
//  }
//  ( LPAREN!
//    exp:expression
//    {
//      if( #exp->getFirstChild()->getType() == FUNCTION_CALL_RET_ID) {
//        stop = true;
//      }
//    }
//    ( {!stop}?
//      COMMA!
//      exp1:expression { #exp1->getFirstChild()->getType() != FUNCTION_CALL_RET_ID}?
//    )?
//    RPAREN!
//  )?
//  (
//    COMMA!
//    tok2:IDENTIFIER
//    {
//      setCurrentFilename(#tok2);
//      RefString str2 = _RS(#tok2->getText());
//      declareDefineNonScopeHolder(str2, NSSymbolTable::TCELL_DECL, #tok2->getLine(), #tok2->getColumn());
//    }
//    ( LPAREN!
//      exp2:expression
//      {
//        if( #exp2->getFirstChild()->getType() == FUNCTION_CALL_RET_ID)
//          stop = true;
//      }
//      ( {!stop}?
//        COMMA!
//        exp3:expression { #exp3->getFirstChild()->getType() != FUNCTION_CALL_RET_ID}?
//      )?
//      RPAREN!
//    )?
// )*
//)
//;






//*** csl commands rule ***//
// This rule handles all csl commands. A csl command is a function with no return type(set functions, add functions, etc).
// The functions that have a return type(get functions) are treated as expressions(see expr_primary_identifier rule).
// The typical syntax for a csl command is    scope. command_name(list of expressions);
// The scope can be a simple id (a) or a hierarchical id, also known as hid(a.b.c).
// There's a special rule in the parser that deals with ids(expr_primary_identifier) by setting an artificial root node in the AST (EXPR_PRIMARY_IDENTIFIER) for all the ids in the input.
// In most cases that's usefull, in this case it would only mean uselessly complicating the AST as there is no nondeterminism danger.
// Thus, the ids will be directly added to the tree with no intermediary node between them and the keyword root.(*1)
// What is the keyword root? Every coomand name is set as a token(keyword) in the lexer. When the parser reads a keyword in the input, that keyword is set as parent for all
// the other nodes that belong to the current rule(that's the meaning of the "^" mark that follows after each keyword (*2)). In this case the keyword will be set as parent for all 
// the ids in the scope and for all the children of the corresponding param_list rules. The reason for this is facilitating the CSLOM calls in the walker(the command name is
// more represenatative for the object model than the scope or the param list).
// The count var is incremented each time the parser reads a new simple id in the input csl code. For the input a.set_.....  count is 1, for a.b.c.set_..... count is 3.
// This is used for the connect command (*3). 
// If there's no identifier(count is 0), the connect is global( connect(a[3:0],b[5:2]);). 
// If there is an explicit scope(IDENTIFIER DOT! rule) (count is greater than 0), the connect is local (a.connect(b[5:2]);). Both situations are handled by the param_list_connect rule. 
//*************************************************************************************************************************************************************************//
//*** csl commands ***//
//*************************************************************************************************************************************************************************//
csl_command

{
  TBool hasDot = TRUE;
  TBool hasAssign = FALSE;
  TBool hasId = FALSE;
  TInt count = 0;
  RefTVec_RefString scopeId = RefTVec_RefString(new TVec_RefString);
  RefCslAST command;
}
:

//           /* **** DO NOT REMOVE!!!! **** OCTAV
//              {
//              #csl_command = #(#[CSL_COMMAND, "CSL_COMMAND"]);
//              }
//              (
//              (
//              {DCERR("start");}
//              tok:IDENTIFIER!
//              {
//              #csl_command->addChild(#tok);
//              hasDot = FALSE;
//              DCERR("entree");
//              //    DCERR(LA(1)->getText());
//              }
//              (
//              {DCERR("entree2");}
//              DOT!
//              {
//              if (!hasDot) {
//              hasDot = TRUE;
//              }
//              }
//              |
//              ASSIGN!
//              {
//              if (!hasAssign) {
//              hasAssign = TRUE;
//              }
//              else {
//              throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("prea multe assign",
//              *currentFilename,
//              #tok->getLine(),
//              #tok->getColumn());
//              }
//              }
//              )?
//              {DCERR("termina cmd");}
//              //  param_list_set_width[scopeId]
//              )+
//              lp1:LPAREN!
//              {DCERR("haide mai");}
//              {
//              if (hasDot) {
//              throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("prea multe puncte",
//              *currentFilename,
//              #tok->getLine(),
//              #tok->getColumn());
//              }
//              RefString literalString = _RS(#tok->getText());
//              long int literalEnum = getLiteralEnum(literalString);
//              DCERR("boom");
//              DCERR(K_SET_WIDTH);
//              DCERR(literalEnum);
//              switch (literalEnum) {
//              case K_SET_WIDTH : 
//              DCERR("he he");
//              //      param_list_set_width(scopeId, lp1->getLine(), lp1->getColumn());
//              param_list_set_width(scopeId, lp1->getLine(), lp1->getColumn());
//              #csl_command->addChild(returnAST);
//              DCERR("after");
//              //      astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
//              break;
//              default : 
//              if (hasAssign) {
//              //call assign statement rule
//              }
//              else {
//              throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("expecting assign or command",
//              *currentFilename,
//              #tok->getLine(),
//              #tok->getColumn());
//              }
//              }
//              }
//              RPAREN!
//              {DCERR("nu se poate asa ceva");}
//           */// **** END OF DO NOT REMOVE!!!! **** OCTAV

( id:IDENTIFIER

 {//set real filename + line
   setCurrentFilename(#id);
   if (!hasDot) { 
     RefString msg = _RS("Unexpected identifier '");
     msg->append( #id->getText());
     msg->append( "'. Expecting command or statement");
     throwError( msg, #id->getLine(), #id->getColumn());
   }
   ++count;
   if (!hasId) { hasId = TRUE; }
   scopeId->push_back(_RS(#id->getText()));
   hasDot = FALSE;
 }

 ( DOT!  { hasDot = TRUE; }  )? 
)*
 ( ( {hasDot}?
     (  com0:K_ADD_PORT_LIST^                                                    param_list_add_port_list[scopeId]                              { command = #com0;   }
        |   com1:K_SET_TYPE^                                                     param_list_set_type[scopeId]                                   { command = #com1;   }
        |   com2:K_SET_ATTR^                                                     param_list_set_attr[scopeId]                                   { command = #com2;   }
        |   com3:K_SET_UNIT_PREFIX^                                              param_list_set_unit_prefix[scopeId]                            { command = #com3;   }
        |   com4:K_SET_SIGNAL_PREFIX^                                            param_list_set_signal_prefix[scopeId]                          { command = #com4;   }
        |   com5:K_SET_SIGNAL_PREFIX_LOCAL^                                      param_list_set_signal_prefix_local[scopeId]                    { command = #com5;   }
        |   com6:K_SET_DEPTH^                                                    param_list_set_depth[scopeId]                                  { command = #com6;   }
        |   com7:K_CREATE_RTL_MODULE^                                            param_list_create_rtl_module[scopeId]                          { command = #com7;   }
        //        |   com8:K_SET_CONST_VALUE^                                              param_list_set_const_value[scopeId]                            { command = #com8;   }
        //        |   com9:K_SET_EXTERNAL^                                                 param_list_set_external[scopeId]                               { command = #com9;   }
        |  com10:K_DIRECTIVE^                                                    param_list_directive[scopeId]                                  { command = #com10;  }
        |  com11:K_SET_WIDTH^                                                    param_list_set_width[scopeId]                                  { command = #com11;  }
        |  com12:K_SET_DIM_WIDTH^                                                param_list_set_dim_width[scopeId]                              { command = #com12;  }
        |  com13:K_SET_BITRANGE^                                                 param_list_set_bitrange[scopeId]                               { command = #com13;  }
        |  com14:K_SET_DIM_BITRANGE^                                             param_list_set_dim_bitrange[scopeId]                           { command = #com14;  }
        |  com15:K_SET_RANGE^                                                    param_list_set_range[scopeId]                                  { command = #com15;  }
        |  com16:K_SET_DIM_RANGE^                                                param_list_set_dim_range[scopeId]                              { command = #com16;  }
        |  com19:K_SET_OFFSET^                                                   param_list_set_offset[scopeId]                                 { command = #com19;  }
        |  com20:K_SET_DIM_OFFSET^                                               param_list_set_dim_offset[scopeId]                             { command = #com20;  }
        //        |  com21:K_SET_NUMBER_OF_DIMENSIONS^                                     param_list_set_number_of_dimensions[scopeId]                   { command = #com21;  }
        |  com22:K_REVERSE^                                                      param_list_reverse[scopeId]                                    { command = #com22;  }
        //        |  com23:K_CONCAT^                                                       param_list_concat[scopeId]                                     { command = #com23;  }
        //        |  com24:K_CONNECT^                                                      param_list_connect[count, scopeId]                             { command = #com24;  }
        |  com25:K_SET_INSTANCE_ALTERATION_BIT^                                  param_list_set_instance_alteration_bit[scopeId]                { command = #com25;  }
        |  com26:K_GENERATE_INDIVIDUAL_RTL_SIGNALS^                              param_list_gen_indiv_rtl_sig[scopeId]                          { command = #com26;  }
        //        |  com27:K_ADD_SIGNAL_GROUP^                                             param_list_add_signal_group[scopeId]                           { command = #com27;  }
        |  com28:K_SET_TESTBENCH_VERILOG_FILENAME^                               param_list_set_testbench_verilog_filename[scopeId]             { command = #com28;  }
        //        |  com29:K_SET_FILE_NAME^                                                param_list_set_file_name[scopeId]                              { command = #com29;  }
        //        |  com30:K_ADD_RESET^                                                    param_list_add_reset[scopeId]                                  { command = #com30;  }
        //        |  com31:K_SET_VC_COMPARE_TRIGGER^                                       param_list_set_vc_compare_trigger[scopeId]                     { command = #com31;  }
        //        |  com32:K_SET_GENERATE_WAVES_FILENAME^                                  param_list_set_filename[scopeId]                               { command = #com32;  }
        //        |  com33:K_ADD_EQUATION^                                                 param_list_add_equation[scopeId]                               { command = #com33;  }
        //        |  com34:K_SET_DUT_MEM_INIT^                                             param_list_set_dut_mem_init[scopeId]                           { command = #com34;  }
        //        |  com35:K_SET_DUT_OUTPUT_FILENAME^                                      param_list_set_dut_output_filename[scopeId]                    { command = #com35;  }
        //        |  com36:K_ADD_COMMENT^                                                  param_list_add_comment[scopeId]                                { command = #com36;  }
        |  com37:K_SET_NAME^                                                     param_list_set_name[scopeId]                                   { command = #com37;  }
        //        |  com38:K_ADD_TESTBENCH_READ_EVENT^                                     param_list_add_tb_read_event[scopeId]                          { command = #com38;  }
        |  com39:K_SET_DIRECTION^                                                param_list_set_direction[scopeId]                              { command = #com39;  }
        |  com40:K_EXCLUSION_LIST^                                               param_list_exclusion_list[scopeId]                             { command = #com40;  }
        |  com41:K_INCLUDE_ONLY^                                                 param_list_include_only[scopeId]                               { command = #com41;  }
        //        |  com42:K_SET_MAX_NUM_VECTORS^                                          param_list_set_max_num_vectors[scopeId]                        { command = #com42;  }
        //        |  com43:K_ADD_EVENT^                                                    param_list_add_event[scopeId]                                  { command = #com43;  }
        //        |  com44:K_SET_MAX_ERROR_COUNT^                                          param_list_set_max_error_count[scopeId]                        { command = #com44;  }
        |  com45:K_SET_RADIX^                                                    param_list_set_radix[scopeId]                                  { command = #com45;  }
        //        |  com46:K_ADD_CLOCK^                                                    param_list_add_clock[scopeId]                                  { command = #com46;  }
        |  com47:K_SET_TOP_UNIT^                                                 param_list_set_top_unit[scopeId]                               { command = #com47;  }
        |  com48:K_ADD^                                                          param_list_add[scopeId]                                        { command = #com48;  }
        |  com49:K_ADD_ADDRESS_RANGE^                                            param_list_add_address_range[scopeId]                          { command = #com49;  }
        |  com50:K_ADD_RESERVED_ADDRESS_RANGE^                                   param_list_add_reserved_address_range[scopeId]                 { command = #com50;  }
        |  com51:K_SET_DATA_WORD_WIDTH^                                          param_list_set_data_word_width[scopeId]                        { command = #com51;  }
        |  com52:K_SET_ADDRESS_INCREMENT^                                        param_list_set_address_increment[scopeId]                      { command = #com52;  }
        |  com53:K_SET_NEXT_ADDRESS^                                             param_list_set_next_address[scopeId]                           { command = #com53;  }
        |  com54:K_SET_ALIGNMENT^                                                param_list_set_alignment[scopeId]                              { command = #com54;  }
        |  com55:K_SET_PREFIX^                                                   param_list_set_prefix[scopeId]                                 { command = #com55;  }
        |  com56:K_SET_SUFFIX^                                                   param_list_set_suffix[scopeId]                                 { command = #com56;  }
        |  com57:K_SET_ENDIANESS^                                                param_list_set_endianess[scopeId]                              { command = #com57;  }
        |  com58:K_AUTO_GEN_MEMORY_MAP^                                          param_list_auto_gen_memory_map[scopeId]                        { command = #com58;  }
        |  com59:K_ADD_TO_MEMORY_MAP^                                            param_list_add_to_memory_map[scopeId]                          { command = #com59;  }
        //        |  com60:K_SET_INSTANCE_NAME^                                            param_list_set_instance_name[scopeId]                          { command = #com60;  }
        |  com61:K_SET_ACCESS_RIGHTS^                                            param_list_set_access_rights[scopeId]                          { command = #com61;  }
        |  com62:K_SET_ACCESS_RIGHTS_ENUM^                                       param_list_set_access_rights_enum[scopeId]                     { command = #com62;  }
        |  com63:K_SET_SYMBOL_MAX_LENGTH^                                        param_list_set_symbol_max_length[scopeId]                      { command = #com63;  }
        |  com64:K_SET_ENUM^                                                     param_list_set_enum[scopeId]                                   { command = #com64;  }
        |  com65:K_SET_ENUM_ITEM^                                                param_list_set_enum_item[scopeId]                              { command = #com65;  }
        |  com66:K_SET_MNEMONIC^                                                 param_list_set_mnemonic[scopeId]                               { command = #com66;  }
        //        |  com67:K_SET_DECODER_NAME^                                             param_list_set_decoder_name[scopeId]                           { command = #com67;  }
        //        |  com68:K_SET_DECODER_OUT_NAME_PREFIX^                                  param_list_set_decoder_out_name_prefix[scopeId]                { command = #com68;  }
        //        |  com69:K_SET_DECODER_OUT_NAME_SUFFIX^                                  param_list_set_decoder_out_name_suffix[scopeId]                { command = #com69;  }
        //        |  com70:K_PRINT^                                                        param_list_print[scopeId]                                      { command = #com70;  }
        |  com71:K_GEN_DECODER^                                                  param_list_gen_decoder[scopeId]                                { command = #com71;  }
        |  com72:K_SET_PHYSICAL_IMPLEMENTATION^                                  param_list_set_physical_implementation[scopeId]                { command = #com72;  }
        |  com73:K_SET_VALUE^                                                    param_list_set_value[scopeId]                                  { command = #com73;  }
        |  com74:K_SET_FIELD^                                                    param_list_set_field[scopeId]                                  { command = #com74;  }
        |  com75:K_SET_FIELD_POSITION^                                           param_list_set_field_position[scopeId]                         { command = #com75;  }
        |  com76:K_SET_POSITION^                                                 param_list_set_position[scopeId]                               { command = #com76;  }
        |  com77:K_SET_NEXT^                                                     param_list_set_next[scopeId]                                   { command = #com77;  }
        |  com78:K_SET_PREVIOUS^                                                 param_list_set_previous[scopeId]                               { command = #com78;  }
        //        |  com79:K_CREATE_SIGNAL^                                                param_list_create_signal[scopeId]                              { command = #com79;  }
        |  com80:K_ADD_ALLOWED_RANGE^                                            param_list_add_allowed_range[scopeId]                          { command = #com80;  }
        |  com81:K_SET_ATTRIBUTES^                                               param_list_set_attributes[scopeId]                             { command = #com81;  }
        //        |  com82:K_CONSTANT^                                                     param_list_constant[scopeId]                                   { command = #com82;  }
        //        |  com83:K_RESET_VALUE^                                                  param_list_reset_value[scopeId]                                { command = #com83;  }
        //        |  com84:K_CLEAR_VALUE^                                                  param_list_clear_value[scopeId]                                { command = #com84;  }
        //        |  com85:K_SET_LOCK_ENABLE_BIT^                                          param_list_set_lock_enable_bit[scopeId]                        { command = #com85;  }
        //        |  com86:K_STOP_AT_END_VALUE^                                            param_list_stop_at_end_value[scopeId]                          { command = #com86;  }
        //        |  com87:K_SET_FEEDBACK_MASK^                                            param_list_set_feedback_mask[scopeId]                          { command = #com87;  }
        //        |  com88:K_SET_FEEDBACK_ELEMENT^                                         param_list_set_feedback_element[scopeId]                       { command = #com88;  }
        |  com89:K_ADD_LOGIC^                                                    param_list_add_logic[scopeId]                                  { command = #com89;  }
        //        |  com90:K_SET_MASK^                                                     param_list_set_mask[scopeId]                                   { command = #com90;  }
        //        |  com91:K_SET_SHIFT_TYPE^                                               param_list_set_shift_type[scopeId]                             { command = #com91;  }
        //        |  com92:K_SET_SHIFT_AMOUNT^                                             param_list_set_shift_amount[scopeId]                           { command = #com92;  }
        //        |  com93:K_SET_FINAL_SHIFT_VALUE^                                        param_list_set_final_shift_value[scopeId]                      { command = #com93;  }
        //        |  com94:K_SET_SOURCE^                                                   param_list_set_source[scopeId]                                 { command = #com94;  }
        //        |  com95:K_SET_COMPARE_EVENT^                                            param_list_set_compare_event[scopeId]                          { command = #com95;  }
        //        |  com96:K_SET_VC_CPP_RD_NAME^                                           param_list_set_vc_cpp_rd_name[scopeId]                         { command = #com96;  }
        //        |  com97:K_SET_VC_CPP_WR_NAME^                                           param_list_set_vc_cpp_wr_name[scopeId]                         { command = #com97;  }
        |  com98:K_SET_VC_START_GENERATION_TRIGGER^                              param_list_set_vc_start_generation_trigger[scopeId]            { command = #com98;  }
        //        |  com99:K_SET_CAPTURE_EVENT^                                            param_list_set_capture_event[scopeId]                          { command = #com99;  }
        //        | com100:K_START_VECTOR_GENERATION^                                      param_list_start_vector_generation[scopeId]                    { command = #com100; }
        //        | com101:K_SET_MODEL^                                                    param_list_set_model[scopeId]                                  { command = #com101; }
        | com102:K_SET_UNIT_NAME^                                                param_list_set_unit_name[scopeId]                              { command = #com102; }
        //        | com103:K_SET_CPP_VECTOR_RD_NAME^                                       param_list_set_cpp_vector_rd_name[scopeId]                     { command = #com103; }
        //        | com104:K_SET_CPP_VECTOR_WR_NAME^                                       param_list_set_cpp_vector_wr_name[scopeId]                     { command = #com104; }
        //        | com105:K_SET_MAX_NUM_OF_VECTORS^                                       param_list_set_max_num_of_vectors[scopeId]                     { command = #com105; }
        //        | com106:K_SET_TRANSACTION_TYPE^                                         param_list_set_transaction_type[scopeId]                       { command = #com106; }
        | com107:K_PIPESTAGE_NAMING_CONVENTION^                                  param_list_pipestage_naming_convention[scopeId]                { command = #com107; }
        //        | com108:K_SET_NUMBER_OF_PIPESTAGES^                                     param_list_set_number_of_pipestages[scopeId]                   { command = #com108; }
        //        | com109:K_ASSOCIATE_PIPELINE^                                           param_list_associate_pipeline[scopeId]                         { command = #com109; }
        //        | com110:K_REPLICATE^                                                    param_list_replicate[scopeId]                                  { command = #com110; }
        //        | com111:K_ADD_PIPESTAGE^                                                param_list_add_pipestage[scopeId]                              { command = #com111; }
        //        | com112:K_SET_PREVIOUS_PIPESTAGE^                                       param_list_set_previous_pipestage[scopeId]                     { command = #com112; }
        //        | com113:K_SET_NEXT_PIPESTAGE^                                           param_list_set_next_pipestage[scopeId]                         { command = #com113; }
        //        | com114:K_SET_PIPESTAGE_NUMBER^                                         param_list_set_pipestage_number[scopeId]                       { command = #com114; }
        //        | com115:K_SET_PIPESTAGE_NAME^                                           param_list_set_pipestage_name[scopeId]                         { command = #com115; }
        //        | com116:K_CONNECT_STALL^                                                param_list_connect_stall[scopeId]                              { command = #com116; }
        //        | com117:K_CONNECT_ENABLE^                                               param_list_connect_enable[scopeId]                             { command = #com117; }
        //        | com118:K_SET_PIPESTAGE_VALID_INPUT^                                    param_list_set_pipestage_valid_input[scopeId]                  { command = #com118; }
        //        | com119:K_SET_PIPESTAGE_VALID_OUTPUT^                                   param_list_set_pipestage_valid_output[scopeId]                 { command = #com119; }
        //        | com120:K_BRANCH^                                                       param_list_branch[scopeId]                                     { command = #com120; }
        | com121:K_MERGE^                                                        param_list_merge[scopeId]                                      { command = #com121; }
        //        | com122:K_INLINE_FILE^                                                  param_list_inline_file[scopeId]                                { command = #com122; }
        //        | com123:K_RESET_INIT_VALUE^                                             param_list_reset_init_value[scopeId]                           { command = #com123; }
        //        | com124:K_SET_VC_ID^                                                    param_list_set_vc_id[scopeId]                                  { command = #com124; }
        | com125:K_SET_VC_NAME^                                                  param_list_set_vc_name[scopeId]                                { command = #com125; }
        | com126:K_SET_VC_HEADER_COMMENT^                                        param_list_set_vc_header_comment[scopeId]                      { command = #com126; }
        | com127:K_SET_VERSION^                                                  param_list_set_version[scopeId]                                { command = #com127; }
        | com128:K_SET_VC_CLOCK^                                                 param_list_set_vc_clock[scopeId]                               { command = #com128; }
        | com129:K_SET_VC_RESET^                                                 param_list_set_vc_reset[scopeId]                               { command = #com129; }
        | com130:K_SET_VC_STALL^                                                 param_list_set_vc_stall[scopeId]                               { command = #com130; }
        | com131:K_SET_VC_END_GENERATION_TRIGGER^                                param_list_set_vc_end_generation_trigger[scopeId]              { command = #com131; }
        | com132:K_SET_VC_CAPTURE_EDGE_TYPE^                                     param_list_set_vc_capture_edge_type[scopeId]                   { command = #com132; }
        //        | com133:K_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS^                          param_list_set_vc_max_number_of_capture_events[scopeId]        { command = #com133; }
        | com134:K_SET_VC_MAX_NUMBER_OF_MISMATCHES^                              param_list_set_vc_max_number_of_mismatches[scopeId]            { command = #com134; }
        | com135:K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS^                      param_list_set_vc_max_number_of_valid_transactions[scopeId]    { command = #com135; }
        | com136:K_SET_VC_VALID_OUTPUT_TRANSACTION^                              param_list_set_vc_valid_output_transaction[scopeId]            { command = #com136; }
        //        | com137:K_SET_VC_TIMEOUT^                                               param_list_set_vc_timeout[scopeId]                             { command = #com137; }
        | com138:K_SET_VC_OUTPUT_FILENAME^                                       param_list_set_vc_output_filename[scopeId]                     { command = #com138; }
        //        | com139:K_SET_VC_MAX_NUM_STATES^                                        param_list_set_vc_max_num_states[scopeId]                      { command = #com139; }
        //        | com140:K_SET_VC_MAX_NUM_OF_TRANSACTION_EVENTS^                         param_list_set_vc_max_num_of_transaction_events[scopeId]       { command = #com140; }
        | com141:K_SET_VC_MAX_CYCLES^                                            param_list_set_vc_max_cycles[scopeId]                          { command = #com141; }
        | com142:K_SET_MEM_INSTANCE_NAME^                                        param_list_set_mem_instance_name[scopeId]                      { command = #com142; }
        | com143:K_SET_RESET_NAME^                                               param_list_set_reset_name[scopeId]                             { command = #com143; }
        | com144:K_SET_CLOCK_NAME^                                               param_list_set_clock_name[scopeId]                             { command = #com144; }
        | com145:K_SET_RD_CLOCK_NAME^                                            param_list_set_rd_clock_name[scopeId]                          { command = #com145; }
        | com146:K_SET_WR_CLOCK_NAME^                                            param_list_set_wr_clock_name[scopeId]                          { command = #com146; }
        | com147:K_SET_PUSH_NAME^                                                param_list_set_push_name[scopeId]                              { command = #com147; }
        | com148:K_SET_POP_NAME^                                                 param_list_set_pop_name[scopeId]                               { command = #com148; }
        | com149:K_SET_FULL_NAME^                                                param_list_set_full_name[scopeId]                              { command = #com149; }
        | com150:K_SET_EMPTY_NAME^                                               param_list_set_empty_name[scopeId]                             { command = #com150; }
        | com151:K_SET_WR_DATA_NAME^                                             param_list_set_wr_data_name[scopeId]                           { command = #com151; }
        | com152:K_SET_RD_DATA_NAME^                                             param_list_set_rd_data_name[scopeId]                           { command = #com152; }
        | com153:K_SET_VALID_NAME^                                               param_list_set_valid_name[scopeId]                             { command = #com153; }
        | com154:K_SET_WR_ADDR_NAME^                                             param_list_set_wr_addr_name[scopeId]                           { command = #com154; }
        | com155:K_SET_RD_ADDR_NAME^                                             param_list_set_rd_addr_name[scopeId]                           { command = #com155; }
        | com156:K_SET_WR_EN_NAME^                                               param_list_set_wr_en_name[scopeId]                             { command = #com156; }
        | com157:K_SET_RD_EN_NAME^                                               param_list_set_rd_en_name[scopeId]                             { command = #com157; }
        //        | com158:K_SET_METHOD^                                                   param_list_set_method[scopeId]                                 { command = #com158; }
        //        | com159:K_SET_PIPESTAGE^                                                param_list_set_pipestage[scopeId]                              { command = #com159; }
        //        | com160:K_SET_MSB^                                                      param_list_set_msb[scopeId]                                    { command = #com160; }
        //        | com161:K_SET_LSB^                                                      param_list_set_lsb[scopeId]                                    { command = #com161; }
        //        | com162:K_CSL_BUILD^                                                    param_list_initialize[scopeId]                                 { command = #com162; }
        | com163:K_INITIALIZE_RANDOM_VALUES^                                     param_list_initialize_random_values[scopeId]                   { command = #com163; }
        | com164:K_INITIALIZE_RANDOM^                                            param_list_initialize_random[scopeId]                          { command = #com164; }
        | com165:K_SET_UNIT_ID^                                                  param_list_set_unit_id[scopeId]                                { command = #com165; }
        //        | com166:K_SET_UPPER_INDEX^                                              param_list_set_upper_index[scopeId]                            { command = #com166; }
        //        | com167:K_SET_LOWER_INDEX^                                              param_list_set_lower_index[scopeId]                            { command = #com167; }
        | com168:K_SET_NUM_RD_IFC^                                               param_list_set_num_rd_ifc[scopeId]                             { command = #com168; }
        | com169:K_SET_NUM_WR_IFC^                                               param_list_set_num_wr_ifc[scopeId]                             { command = #com169; }
   )
              
   { setCurrentFilename(command); }

  )     
  |     
  (  { hasId }?  ASSIGN^  csl_statement_assign[scopeId]   {hasAssign = TRUE;}  )     
)

{      
  if (hasId && (!hasDot && !hasAssign)) {
    RefString msg = _RS("Unexpected identifier '");
    msg->append( #id->getText());
    msg->append( "'. Expecting command or statement");
    throwError(msg, #id->getLine(), #id->getColumn());
  }
}

SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, ex.getLine());
  cslParserHasErrors = true;
  consumeUntil( SEMI );
}      



//*************************************************************************************************************************************************************************//
//*** csl assign statement  ***//
//*************************************************************************************************************************************************************************//
csl_statement_assign[NSCSLOm::RefTVec_RefString scopeId]

:

(  exp:expression!

 {//add fake vertex to AST
   RefCslAST currentFilenameTemp = #(#[ASSIGNOR, "ASSIGNOR"]);
   setCurrentFilename(currentFilenameTemp, #exp->getColumn(), #exp->getLine());
   astFactory->addASTChild(currentAST,  ANTLR_USE_NAMESPACE(antlr)RefAST(currentFilenameTemp));
   astFactory->addASTChild(currentAST,  ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
 }

)
;



//*************************************************************************************************************************************************************************//
//*** csl directive command  ***//
//*************************************************************************************************************************************************************************//
param_list_directive[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//directive calls are not allowed for ver 1.0
   TInt                  callAllowedInScopesWithoutObjectMask = 0;
   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary
   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap;

   setCommandCallOptions(_RS("directive(...)"), callAllowedInScopesWithoutObjectMask);
   callCommand(_RS("directive(...)"), scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  ( id:IDENTIFIER!
  
  {//set real filename + line for id
    setCurrentFilename(#id);
    //id should be one of the following literals
    RefString literalString = _RS(#id->getText());
    TLInt literalEnum = getLiteralEnum(literalString);
    RefCslAST directive;
    switch (literalEnum) {
      //       case K_LITERAL_REGISTER_GROUP :
      //         #param_list_directive = #(#[K_REGISTER_GROUP, "K_REGISTER_GROUP"]);
      //         directive_register_group(scopeId);
      //         #param_list_directive->addChild(returnAST);
      //         //         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
      //         break;
      //      case K_LITERAL_DISCONNECT_REG_FIELDS_IOS :
      //        directive = #(#[K_DISCONNECT_REG_FIELDS_IOS, "K_DISCONNECT_REG_FIELDS_IOS"]);
      //        directive_disconnect_register_fields_from_ios(scopeId, #id->getLine(), #id->getColumn());
      //      break;
      //      case K_LITERAL_CONNECT_REG_FIELDS_IOS :
      //        directive = #(#[K_CONNECT_REG_FIELDS_IOS, "K_CONNECT_REG_FIELDS_IOS"]);
      //        directive_connect_register_fields_to_ios(scopeId);
      //        break;
      //       case K_LITERAL_FIELD_GROUP :
      //         #param_list_directive = #(#[K_FIELD_GROUP, "K_FIELD_GROUP"]);
      //         directive_field_group(scopeId);
      //         #param_list_directive->addChild(returnAST);
      //         //         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
      //         break;
      //      case K_LITERAL_NAME_REGISTER :
      //        directive = #(#[K_NAME_REGISTER, "K_NAME_REGISTER"]);
      //        directive_name_register(scopeId);
      //        break;
      default :
        throwCommandError(_RS("directive()"), _RS("First argument should be 'disconnect_register_fields_from_ios', 'connect_register_fields_to_ios' or 'name_register' "), #id->getLine(), #id->getColumn());
     }
     ASSERT(directive, "PARSER - null ast vertex");
     //set real filename + column for fake vertex directive
     directive->addChild(returnAST);
     setCurrentFilename(directive, #id->getColumn(), #id->getLine());
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(directive));
   }

 )
)
;



//*************************************************************************************************************************************************************************//
//*** csl directive disconnect_register_fields_from_ios command  ***//
//*************************************************************************************************************************************************************************//
//not allowed for v1.0
//directive_disconnect_register_fields_from_ios[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//
//{
//  TBool wasDot = TRUE;
//  TBool wasId = FALSE;
//  TInt dotLine = 0;
//  TInt dotColumn = 0;
//
//  antlr::RefCslAST lastIdentifier = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
//}
//:
//
//  {
//    RefString str = _RS("directive(disconnect_register_fields_from_ios,...)");
//    TInt mask = NSSymbolTable::TRF_DECL;
//    commandCheck(str, scopeId, mask, line, column);
//  }
// (
//  lp1:COMMA!
//  (
//    id:IDENTIFIER!
//    {
//      setCurrentFilename(#id);
//      if (!wasDot) {
//        throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'directive(disconnect_register_fields_from_ios,...)' : Expecting Dot '.' ",
//                                                             *currentFilename,
//                                                             #id->getLine(),
//                                                             #id->getColumn());
//      }
//      wasDot = FALSE;
//      RefString literalString = _RS(#id->getText());
//      TLInt literalEnum = getLiteralEnum(literalString);
//      if (!wasId) {
//        if ( K_LITERAL_ALL == literalEnum ) {
//          #directive_disconnect_register_fields_from_ios = #(#[K_ALL, "K_ALL"]);
//          setCurrentFilename(#directive_disconnect_register_fields_from_ios, #id->getColumn(), #id->getLine());
//          
//        }
//        else {
//          #directive_disconnect_register_fields_from_ios = #(#id);
//        }
//      }
//      else {
//        if (!lastIdentifier.get()) {
//          #directive_disconnect_register_fields_from_ios->setNextSibling(#id); 
//          lastIdentifier = #id; 
//        }
//        else { 
//          lastIdentifier->setNextSibling(#id); 
//          lastIdentifier = #id; 
//        }
//      }
//      wasId = TRUE;
//    }
//    (
//     dot:DOT!
//     {
//       wasDot = TRUE;
//       dotLine = #dot->getLine();
//       dotColumn = #dot->getColumn();
//     }
//    )?
//   )+
//    )?
//{
//  if (wasDot && dotLine && dotColumn) {
//    throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'directive(disconnect_register_fields_from_ios,...)' : Unexpected token Dot '.' ",
//                                                         *currentFilename,
//                                                         dotLine,
//                                                         dotColumn);
//  }
//}
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** csl directive connect_register_fields_to_ios command  ***//
//*************************************************************************************************************************************************************************//
//not allowed for v1.0
//directive_connect_register_fields_to_ios[NSCSLOm::RefTVec_RefString scopeId]
//{
//  TBool wasFirstOptional = FALSE;
//  TBool wasSecondOptional = FALSE;
//  
//  TBool invalidOrderOfOptionals = FALSE;
//  TBool wasDot = TRUE;
//  TBool canBeDot = TRUE;
//
//  antlr::RefCslAST optionalIdentifier = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
//}
//  :
// (
//  lp1:COMMA!
//  {
//    if (wasSecondOptional) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'directive(connect_register_fields_to_ios,...)' : Unexpected token Comma ','  ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//    else if (!wasFirstOptional) {
//      RefString str = _RS("directive(connect_register_fields_to_ios,...)");
//      TInt mask = NSSymbolTable::TRF_DECL;
//      commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//    }
//    if (!wasDot) { wasDot = TRUE; }
//  }
// (
//  id:IDENTIFIER!
//  {
//    setCurrentFilename(#id);
//    if (!wasDot) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'directive(connect_register_fields_to_ios,...)' : Expecting Dot '.' ",
//                                                           *currentFilename,
//                                                           #id->getLine(),
//                                                           #id->getColumn());
//    }
//    wasDot = FALSE;
//    RefString literalString = _RS(#id->getText());
//    TLInt literalEnum = getLiteralEnum(literalString);
//    switch (literalEnum) {
//      case K_LITERAL_INPUTS :
//        if (wasSecondOptional || wasFirstOptional) { invalidOrderOfOptionals = TRUE; }
//        else { wasFirstOptional = TRUE; 
//          #directive_connect_register_fields_to_ios = #(#[K_INPUTS, "K_INPUTS"]);  }
//          setCurrentFilename(#directive_connect_register_fields_to_ios, #id->getColumn(), #id->getLine());
//        if (canBeDot) { canBeDot = FALSE; }
//        break;
//      case K_LITERAL_OUTPUTS :
//        if (wasSecondOptional || wasFirstOptional) { invalidOrderOfOptionals = TRUE; }
//        else { wasFirstOptional = TRUE; 
//          #directive_connect_register_fields_to_ios = #(#[K_OUTPUTS, "K_OUTPUTS"]); }
//          setCurrentFilename(#directive_connect_register_fields_to_ios, #id->getColumn(), #id->getLine());
//        if (canBeDot) { canBeDot = FALSE; }
//        break;
//      case K_LITERAL_INOUTS :
//        if (wasSecondOptional || wasFirstOptional) { invalidOrderOfOptionals = TRUE; }
//        else { wasFirstOptional = TRUE; 
//          #directive_connect_register_fields_to_ios = #(#[K_INOUTS, "K_INOUTS"]); }
//          setCurrentFilename(#directive_connect_register_fields_to_ios, #id->getColumn(), #id->getLine());
//        if (canBeDot) { canBeDot = FALSE; }
//        break;
//      case K_LITERAL_ALL :
//        if (wasSecondOptional) { invalidOrderOfOptionals = TRUE; }
//        else {
//          wasSecondOptional = TRUE;
//          if (!wasFirstOptional) { #directive_connect_register_fields_to_ios = #(#[K_ALL, "K_ALL"]); 
//                                   setCurrentFilename(#directive_connect_register_fields_to_ios, #id->getColumn(), #id->getLine()); }
//          else { #directive_connect_register_fields_to_ios->setNextSibling(#[K_ALL, "K_ALL"]); 
//                 RefCslAST currentFilenameTemp = #directive_connect_register_fields_to_ios;
//                 currentFilenameTemp = currentFilenameTemp->getNextSibling();
//                 setCurrentFilename(currentFilenameTemp, #id->getColumn(), #id->getLine()); }
//          
//        }
//        if (canBeDot) { canBeDot = FALSE; }
//        break;
//      default :
//        if (!optionalIdentifier.get()) {
//          if (!wasFirstOptional && !wasSecondOptional) { 
//            #directive_connect_register_fields_to_ios = #(#id); }
//          else { 
//            #directive_connect_register_fields_to_ios->setNextSibling(#id); }
//          optionalIdentifier = #id;
//        }
//        else {
//          optionalIdentifier->setNextSibling(#id);
//          optionalIdentifier = #id;
//        }
//        if (!canBeDot) { canBeDot = TRUE; }
//        if (!wasSecondOptional) {wasSecondOptional = TRUE; }
//    }
//    if (invalidOrderOfOptionals) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'directive(connect_register_fields_to_ios,...)' : Invalid order of arguments ",
//                                                           *currentFilename,
//                                                           #id->getLine(),
//                                                           #id->getColumn());
//    }
//  }
//  (
//   dot:DOT!
//   {
//     if (!canBeDot) {
//       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'directive(connect_register_fields_to_ios,...)' : Unexpected token Dot '.' ",
//                                                            *currentFilename,
//                                                            dot->getLine(),
//                                                            dot->getColumn());
//     }
//     wasDot = TRUE;
//   }
//  )?
// )*
//)*
//   RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** csl directive register command  ***//
//*************************************************************************************************************************************************************************//
//not allowed for v1.0
//directive_name_register[NSCSLOm::RefTVec_RefString scopeId]
//{
//  TBool wasDot = TRUE;
//  TBool wasId = FALSE;
//  TInt dotLine = 0;
//  TInt dotColumn = 0;
//
//  antlr::RefCslAST lastIdentifier = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
//}
//  :
//  com:COMMA!
//  {
//    RefString str = _RS("directive(name_register,...)");
//    TInt mask = NSSymbolTable::TRF_DECL;
//    commandCheck(str, scopeId, mask, com->getLine(), com->getColumn());
//  }
//  exp:expression!
//  {
//    if (STRING == #exp->getFirstChild()->getType()
//        || EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()
//        || FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'directive(name_register,...)' : Expecting numeric expression as second argument ",
//                                                           *currentFilename,
//                                                           com->getLine(),
//                                                           com->getColumn());
//    }
//    // *** DO NOT MODIFY - ANTLR GENERATED CODE - octav ***
//    currentAST.root = exp_AST;
//	if ( exp_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
//		exp_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
//		  currentAST.child = exp_AST->getFirstChild();
//	else
//		currentAST.child = exp_AST;
//	currentAST.advanceChildToEnd();
//	exp_AST = antlr::RefCslAST(currentAST.root);
//    // *** END OF ANTLR GENERATED CODE ***
//    //    #directive_name_register = #(#exp);//won't work
//  }
//  com2:COMMA!
//   (
//    id:IDENTIFIER!
//    {
//      setCurrentFilename(#id);
//      #directive_name_register->setNextSibling(#id);
//    }
//   )
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** csl set_physical_implementation command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_physical_implementation[NSCSLOm::RefTVec_RefString scopeId]

:

(  lp1:LPAREN!

 {//command calling options
    RefString command = _RS("set_physical_implementation()");
    
    TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;  //not necessary(not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap;

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(),lp1->getColumn());
  }

  ( id:IDENTIFIER!
  
  {//set real filename + line
    setCurrentFilename(#id);
    //id should be one of the following literals
    RefString literalString = _RS(#id->getText());
    TLInt literalEnum = getLiteralEnum(literalString);
    RefCslAST temp;
    switch (literalEnum) {
      case K_LITERAL_SRAM :
        temp = #(#[K_SRAM, "K_SRAM"]);
        setCurrentFilename(temp, #id->getColumn(), #id->getLine());
        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
        break;
      case K_LITERAL_FFA :
        temp = #(#[K_FFA, "K_FFA"]);
        setCurrentFilename(temp, #id->getColumn(), #id->getLine());
        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
        break;
      default :
        RefString msg = _RS("Unexpected token '");
        msg->append( #id->getText());
        msg->append( "' ");
        throwCommandError(_RS("set_physical_implementation()"), msg, #id->getLine(), #id->getColumn());
     }
   }

  )
   RPAREN!
)
;
 


//*************************************************************************************************************************************************************************//
//*** csl set_value command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_value[NSCSLOm::RefTVec_RefString scopeId]    

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_value()");
   
   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIELD_DECL | NSSymbolTable::TISAF_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap       = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
   
   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL));

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TISAE_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
 }

  exp:expression  

 {//exp is only allowed to be numeric 
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_value()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** csl set_enum_item command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_enum_item[NSCSLOm::RefTVec_RefString scopeId] 

:

(  lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_enum_item");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 ;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL));
    
   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                           NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
  }

  exp1:expression

  { 
    if (EXPR_PRIMARY_IDENTIFIER != #exp1->getFirstChild()->getType()
        && FUNCTION_CALL_RET_ID != #exp1->getFirstChild()->getType()) {
      throwCommandError(_RS("set_enum_item()"), _RS("Expecting identifier as argument "), #exp1->getLine(), #exp1->getColumn()); 
    }
  }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** csl set_field command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_field[NSCSLOm::RefTVec_RefString scopeId]    

{
  TBool isHybrid = false;
  TBool isEPI = false;
  TBool isFunctionCall = false;
}
:

(  lp1:LPAREN!
  
 {
   RefString command = _RS("set_field()");

//   TInt                  callAllowedInScopesWithoutObjectMask = 0; // not necessary

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(),lp1->getColumn());
 } 

  ( exp:expression

  {//only identifier allowed for exp
      if( #exp->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER
          && #exp->getFirstChild()->getType() != FUNCTION_CALL_RET_ID) {
        throwCommandError(_RS("set_field()"), _RS("Expecting identifier as the first argument "), #exp->getLine(), #exp->getColumn()); 
      }
   }

 )
 lp2:COMMA!  exp2:expression
 
 {//only number allowed for exp2
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("set_field()"), _RS("Expecting numeric expression as the second argument "), #exp2->getLine(), #exp2->getColumn()); 
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** csl set_position() command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_position[NSCSLOm::RefTVec_RefString scopeId]

:

(  lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_position()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
 }

   exp:expression
   
 {//exp is only allowed to be identifier
   if(EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
      && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_position"), _RS("Expecting identifier as first argument"), #exp->getLine(), #exp->getColumn());
   }
 }
 
   COMMA!   exp2:expression
 
 {//exp2 is only allowed to be numeric
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("set_position()"), _RS("Expecting numeric expression as second argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** csl set_field_position() command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_field_position[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_field_position()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIELD_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_field_position()"), _RS("Expecting identifier as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }

  COMMA!  exp2:expression
 
 {//exp2 is only allowed to be numeric
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("set_field_position()"), _RS("Expecting numeric expression as second argument "), #exp2->getLine(), #exp2->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** csl set_next() command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_next[NSCSLOm::RefTVec_RefString scopeId]    

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_next()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TFIELD_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
 }

  exp:expression
    
 {//exp is only allowed to be identifier
   if(EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
      && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_next()"), _RS("Expecting identifier as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
  COMMA!  exp2:expression

 {//exp2 is only allowed to be identifier
   if(EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType() 
      && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_next()"), _RS("Expecting identifier as second argument "), #exp->getLine(), #exp->getColumn());
   }
 }


 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** csl set_previous() command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_previous[NSCSLOm::RefTVec_RefString scopeId]    

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_previous()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TFIELD_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
 }
 
  exp:expression
    
 {//exp is only allowed to be identifier
   if(EXPR_PRIMARY_IDENTIFIER !=  #exp->getFirstChild()->getType()
      && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_previous()"), _RS("Expecting identifier as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
  COMMA!  exp2:expression
    
 {//exp2 is only allowed to be identifier
   if(EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
      && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_previous()"), _RS("Expecting identifier as second argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_create_signal[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("create_signal()");
//    TInt mask = /*NSSymbolTable::TFIELD_DECL*/ 0;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'create_signal()' : Expecting identifier as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** add_allowed_range() command  ***//
//*************************************************************************************************************************************************************************//
param_list_add_allowed_range[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add_allowed_range()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAF_DECL | NSSymbolTable::TFIELD_DECL; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());   
 }

  exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) { 
     throwCommandError(_RS("add_allowed_range()"), _RS("Expecting identifier as first argument "), #exp->getLine(), #exp->getColumn());     
   }
 }
 
  COMMA!   exp2:expression
  
 {
   if (STRING == #exp2->getFirstChild()->getType()) { 
     throwCommandError(_RS("add_allowed_range()"), _RS("Expecting identifier as second argument "), #exp->getLine(), #exp->getColumn());     
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_attributes() command  ***//
//*************************************************************************************************************************************************************************//
param_list_set_attributes[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_attributes()");

      TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());   
 }

  exp:expression!

 {//exp should be one of the attribute literals
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText()); 
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_SHADOW :
           temp = #(#[K_SHADOW, "K_SHADOW"]);
           break;
         case K_LITERAL_READ :
           temp = #(#[K_READ, "K_READ"]);
           break;
         case K_LITERAL_WRITE :
           temp = #(#[K_WRITE, "K_WRITE"]);
           break;
         case K_LITERAL_READ_WRITE :
           temp = #(#[K_READ_WRITE, "K_READ_WRITE"]);
           break;
         default :
           error = TRUE;
       }

       if (!error) {

         setCurrentFilename(temp, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { error = TRUE; }

   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) {
     RefString msg = _RS("Expecting attribute literal, found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("set_attributes()"), msg, #exp->getLine(), #exp->getColumn());
   }
 }
 
//  (
//  (
//   K_CSL_LIST^
//   LPAREN!
//   (
//    id:IDENTIFIER!
//    {
//      setCurrentFilename(#id);
//      RefString literalString = _RS(#id->getText()); 
//      TLInt literalEnum = getLiteralEnum(literalString);
//      RefCslAST temp;
//      switch (literalEnum) {
//        case K_LITERAL_SHADOW :
//          temp = #(#[K_SHADOW, "K_SHADOW"]);
//          setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//        case K_LITERAL_READ :
//          temp = #(#[K_READ, "K_READ"]);
//          setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//        case K_LITERAL_WRITE :
//          temp = #(#[K_WRITE, "K_WRITE"]);
//          setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//        case K_LITERAL_READ_WRITE :
//          temp = #(#[K_SRAM, "K_SRAM"]);
//          setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//        default :
//          RefString msg = _RS("command 'set_attributes()' : Unexpected token '");
//          msg->append( #id->getText());
//          msg->append( "' ");
//          throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                               *currentFilename,
//                                                               #id->getLine(),
//                                                               #id->getColumn());
//      }
//    }
//   )
//   
//   (
//    COMMA!
//    (
//     id2:IDENTIFIER!
//     {
//       setCurrentFilename(#id2);
//       RefString literalString = _RS(#id2->getText());
//       TLInt literalEnum = getLiteralEnum(literalString);
//       RefCslAST temp;
//       switch (literalEnum) {
//         case K_LITERAL_SHADOW :
//           temp = #(#[K_SHADOW, "K_SHADOW"]);
//           setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//         case K_LITERAL_READ :
//           temp = #(#[K_READ, "K_READ"]);
//           setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//         case K_LITERAL_WRITE :
//           temp = #(#[K_WRITE, "K_WRITE"]);
//           setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//         case K_LITERAL_READ_WRITE :
//           temp = #(#[K_READ_WRITE, "K_READ_WRITE"]);
//           setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//         default :
//           RefString msg = _RS("command 'set_attributes()' : Unexpected token '");
//           msg->append( "' ");
//           msg->append( #id2->getText());
//           throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                                *currentFilename,
//                                                                #id2->getLine(),
//                                                                #id2->getColumn());
//       }
//     }
//     )
//    )*
//   RPAREN!
//  )
//  |
//   exp:expression!
//   {
//     if (FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//         && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_attributes()' : expecting attribute list as argument ",
//                                                            *currentFilename,
//                                                            lp1->getLine(),
//                                                            lp1->getColumn());
//     }
//   }
//  )

 RPAREN!
)
;


//param_list_constant[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("constant()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    TInt trueColumn = lp1->getColumn();
//    commandCheck(str, scopeId, mask, lp1->getLine(), trueColumn);
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()
//        || FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'constant()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!  
//;


//param_list_reset_value[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("reset_value()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expression
//  RPAREN!
//;


//param_list_clear_value[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("clear_value()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expression
//  RPAREN!
//;


//param_list_set_lock_enable_bit[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_lock_enable_bit()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expression
//  RPAREN!
//;


//param_list_stop_at_end_value[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("stop_at_end_value()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  RPAREN!
//;


//param_list_set_feedback_mask[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_feedback_mask()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expression
//  RPAREN!
//;


//param_list_set_feedback_element[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_feedback_element()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  (
//   id:IDENTIFIER
//   {
//     setCurrentFilename(#id);
//     RefString literalString = _RS(#id->getText());
//     TLInt literalEnum = getLiteralEnum(literalString);
//     RefCslAST temp;
//     switch (literalEnum) {
//       case K_LITERAL_XOR :
//         temp = #(#[K_XOR, "K_XOR"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//         break;
//       case K_LITERAL_XNOR :
//         temp = #(#[K_XNOR, "K_XNOR"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//         break;
//       default :
//         RefString msg = _RS("command 'set_feedback_element()' : Unexpected token '");
//         msg->append( #id->getText());
//         msg->append( "' ");
//         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                              *currentFilename,
//                                                              #id->getLine(),
//                                                              #id->getColumn());
//     }
//   }
//  )
//  RPAREN!
//;



//*************************************************************************************************************************************************************************//
//*** csl add logic commands command  ***//
//*************************************************************************************************************************************************************************//
param_list_add_logic[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool errorToken = FALSE;//unknown token id add_logic(token,...)
}
:

(  lp:LPAREN!

 {//add logics are not allowed to be called on objects, only for the current object
   if (scopeId->size()) {
     throwCommandError(_RS("add_logic(...)"), _RS("Command can't be called on an object. It must be called inside the constructor for the current object "), lp->getLine(), lp->getColumn());
   }
 }

 ( exp:expression!  //id:IDENTIFIER!

 {//set real filename + line for id
   //   setCurrentFilename(#id);
   //id should be one of the following literals
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {


       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       TBool error = FALSE;//for the add_logics that were removed for now from language
       switch (literalEnum) {
         case K_LITERAL_NEG_OUTPUT :
           temp = #(#[K_NEG_OUTPUT, "K_NEG_OUTPUT"]);
           add_logic_neg_output(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_SERIAL_INPUT :
           temp = #(#[K_SERIAL_INPUT, "K_SERIAL_INPUT"]);
           add_logic_serial_input(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_SERIAL_OUTPUT :
           temp = #(#[K_SERIAL_OUTPUT, "K_SERIAL_OUTPUT"]);
           add_logic_serial_output(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_RD_EN :
           //temp = #(#[K_RD_EN, "K_RD_EN"]);
           //add_logic_rd_en(scopeId, #exp->getLine(), #exp->getColumn());
           error = TRUE;
           break;
         case K_LITERAL_WRITE_ENABLE :
           //temp = #(#[K_WRITE_ENABLE, "K_WRITE_ENABLE"]);
           //add_logic_wr_en(scopeId, #exp->getLine(), #exp->getColumn());
           error = TRUE;
           break;
         case K_LITERAL_CONNECT_INPUT_TO_FIELD :
           //         add_logic_connect_input_to_field(scopeId);
           //         #param_list_add_logic = #(#[K_CONNECT_INPUT_TO_FIELD, "K_CONNECT_INPUT_TO_FIELD"], returnAST);
           error = TRUE;
           break;
         case K_LITERAL_CONNECT_OUTPUT_TO_FIELD :
           //temp = #(#[K_CONNECT_OUTPUT_TO_FIELD, "K_CONNECT_OUTPUT_TO_FIELD"]);
           //add_logic_connect_output_to_field(scopeId);
           error = TRUE;
           break;
         case K_LITERAL_GRAY_OUTPUT :
           temp = #(#[K_GRAY_OUTPUT, "K_GRAY_OUTPUT"]);
           add_logic_gray_output(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_CNT_DIR_SIGNAL :
           //temp = #(#[K_CNT_DIR_SIGNAL, "K_CNT_DIR_SIGNAL"]);
           //add_logic_cnt_dir_signal(scopeId, #exp->getLine(), #exp->getColumn());
           error = TRUE;
           break;
         case K_LITERAL_INC_SIGNAL :
           //temp = #(#[K_INC_SIGNAL, "K_INC_SIGNAL"]);
           //add_logic_inc_signal(scopeId, #exp->getLine(), #exp->getColumn());
           error = TRUE;
           break;
         case K_LITERAL_DEC_SIGNAL :
           error = TRUE;
           //         add_logic_dec_signal(scopeId, #exp->getLine(), #exp->getColumn());
           //         #param_list_add_logic = #(#[K_DEC_SIGNAL, "K_DEC_SIGNAL"], returnAST);
           break;
         case K_LITERAL_SH_OP_SIGNAL :
           //temp = #(#[K_SH_OP_SIGNAL, "K_SH_OP_SIGNAL"]);
           //add_logic_sh_op_signal(scopeId, #exp->getLine(), #exp->getColumn());
           error = TRUE;
           break;
         case K_LITERAL_START_VALUE :
           temp = #(#[K_START_VALUE, "K_START_VALUE"]);
           add_logic_start_value(scopeId);
           break;
         case K_LITERAL_END_VALUE :
           temp = #(#[K_END_VALUE, "K_END_VALUE"]);
           add_logic_end_value(scopeId);
           break;
         case K_LITERAL_COUNT_AMOUNT :
           temp = #(#[K_COUNT_AMOUNT, "K_COUNT_AMOUNT"]);
           add_logic_count_amount(scopeId);
           break;
         case K_LITERAL_COUNT_DIRECTION :
           //temp = #(#[K_COUNT_DIRECTION, "K_COUNT_DIRECTION"]);
           //add_logic_count_direction(scopeId, #exp->getLine(), #exp->getColumn());
           error = TRUE;
           break;
         case K_LITERAL_COUNT_ENABLE :
           //temp = #(#[K_COUNT_ENABLE, "K_COUNT_ENABLE"]);
           //add_logic_count_enable(scopeId, #exp->getLine(), #exp->getColumn());
           error = TRUE;
           break;
         case K_LITERAL_SET :
           temp = #(#[K_SET, "K_SET"]);
           add_logic_set(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_RESET_SIGNAL :
           temp = #(#[K_RESET, "K_RESET"]);
           add_logic_reset(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_PROGRAMMABLE_DEPTH :
           temp = #(#[K_PROGRAMMABLE_DEPTH, "K_PROGRAMMABLE_DEPTH"]);
           add_logic_programmable_depth(scopeId);
           break;
         case K_LITERAL_PRIORITY_BYPASS :
           temp = #(#[K_PRIORITY_BYPASS, "K_PRIORITY_BYPASS"]);
           add_logic_priority_bypass(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_SYNC_FIFO :
           temp = #(#[K_SYNC_FIFO, "K_SYNC_FIFO"]);
           add_logic_sync_fifo(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_ASYNC_FIFO :
           temp = #(#[K_ASYNC_FIFO, "K_ASYNC_FIFO"]);
           add_logic_async_fifo(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_DEPTH_EXTEND :
           temp = #(#[K_DEPTH_EXTEND, "K_DEPTH_EXTEND"]);
           add_logic_depth_extend(scopeId);
           break;
         case K_LITERAL_WIDTH_EXTEND :
           temp = #(#[K_WIDTH_EXTEND, "K_WIDTH_EXTEND"]);
           add_logic_width_extend(scopeId);
           break;
         case K_LITERAL_WR_HOLD :
           temp = #(#[K_WR_HOLD, "K_WR_HOLD"]);
           add_logic_wr_hold(scopeId);
           break;
         case K_LITERAL_PARALLEL_OUTPUT :
           temp = #(#[K_PARALLEL_OUTPUT, "K_PARALLEL_OUTPUT"]);
           add_logic_parallel_output(scopeId);
           break;
         case K_LITERAL_PARALLEL_INPUT :
           temp = #(#[K_PARALLEL_INPUT, "K_PARALLEL_INPUT"]);
           add_logic_parallel_input(scopeId);
           break;
         case K_LITERAL_RD_WORDS :
           temp = #(#[K_RD_WORDS, "K_RD_WORDS"]);
           add_logic_rd_words(scopeId);
           break;
         case K_LITERAL_WR_WORDS :
           temp = #(#[K_WR_WORDS, "K_WR_WORDS"]);
           add_logic_wr_words(scopeId);
           break;
         case K_LITERAL_SRAM_RD :
           temp = #(#[K_SRAM_RD, "K_SRAM_RD"]);
           add_logic_sram_rd(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_SRAM_WR :
           temp = #(#[K_SRAM_WR, "K_SRAM_WR"]);
           add_logic_sram_wr(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_PUSHBACK :
           temp = #(#[K_PUSHBACK, "K_PUSHBACK"]);
           add_logic_pushback(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_FLOW_THROUGH :
           temp = #(#[K_FLOW_THROUGH, "K_FLOW_THROUGH"]);
           add_logic_flow_through(scopeId);
           break;
         case K_LITERAL_STALL :
           temp = #(#[K_STALL, "K_STALL"]);
           add_logic_stall(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_STALL_RD_SIDE :
           temp = #(#[K_STALL_RD_SIDE, "K_STALL_RD_SIDE"]);
           add_logic_stall_rd_side(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_STALL_WR_SIDE :
           temp = #(#[K_STALL_WR_SIDE, "K_STALL_WR_SIDE"]);
           add_logic_stall_wr_side(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_WR_RELEASE :
           temp = #(#[K_WR_RELEASE, "K_WR_RELEASE"]);
           add_logic_wr_release(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_ALMOST_EMPTY :
           temp = #(#[K_ALMOST_EMPTY, "K_ALMOST_EMPTY"]);
           add_logic_almost_empty(scopeId);
           break;
         case K_LITERAL_ALMOST_FULL :
           temp = #(#[K_ALMOST_FULL, "K_ALMOST_FULL"]);
           add_logic_almost_full(scopeId);
           break;
         case K_LITERAL_OUTPUT_WR_ADDR :
           temp = #(#[K_OUTPUT_WR_ADDR, "K_OUTPUT_WR_ADDR"]);
           add_logic_output_wr_addr(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_OUTPUT_RD_ADDR :
           temp = #(#[K_OUTPUT_RD_ADDR, "K_OUTPUT_RD_ADDR"]);
           add_logic_output_rd_addr(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_CREDIT :
           temp = #(#[K_CREDIT, "K_CREDIT"]);
           add_logic_credit(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_RD_CREDIT :
           temp = #(#[K_RD_CREDIT, "K_RD_CREDIT"]);
           add_logic_rd_credit(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_WR_CREDIT :
           temp = #(#[K_WR_CREDIT, "K_WR_CREDIT"]);
           add_logic_wr_credit(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_FLOW :
           temp = #(#[K_FLOW, "K_FLOW"]);
           add_logic_flow(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_READ_VALID :
           temp = #(#[K_READ_VALID, "K_READ_VALID"]);
           add_logic_read_valid(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_BYPASS :
           //         add_logic_bypass(scopeId, #exp->getLine(), #exp->getColumn());
           //         #param_list_add_logic = #(#[K_BYPASS, "K_BYPASS"], returnAST);
           error = TRUE;
           break;
         case K_LITERAL_GENERATE_WAVES :
           temp = #(#[K_GENERATE_WAVES, "K_GENERATE_WAVES"]);
           add_logic_generate_waves(scopeId);
           break;
         case K_LITERAL_SIMULATION_TIMEOUT_COUNTER :
           //temp = #(#[K_SIMULATION_TIMEOUT_COUNTER, "K_SIMULATION_TIMEOUT_COUNTER"]);
           //add_logic_simulation_timeout_counter(scopeId);
           error = TRUE;
           break;
         case K_LITERAL_STALL_GENERATION :
           //temp = #(#[K_STALL_GENERATION, "K_STALL_GENERATION"]);
           //add_logic_stall_generation(scopeId);
           error = TRUE; 
           break;
         case K_LITERAL_CLOCK_SIGNAL :
           temp = #(#[K_CLOCK_SIGNAL, "K_CLOCK_SIGNAL"]);
           add_logic_clock(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_GENERATE_REPORT :
           temp = #(#[K_GENERATE_REPORT, "K_GENERATE_REPORT"]);
           add_logic_generate_report(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_ASYNC_RESET :
           temp = #(#[K_ASYNC_RESET, "K_ASYNC_RESET"]);
           add_logic_async_reset(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_INIT :
           temp = #(#[K_INIT, "K_INIT"]);
           add_logic_init(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_CLEAR :
           temp = #(#[K_CLEAR, "K_CLEAR"]);
           add_logic_clear(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_STOP :
           temp = #(#[K_STOP, "K_STOP"]);
           add_logic_stop(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_DIRECTION_CONTROL :
           temp = #(#[K_DIRECTION_CONTROL, "K_DIRECTION_CONTROL"]);
           add_logic_direction_control(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_INJECT_STALLS :
           temp = #(#[K_INJECT_STALLS, "K_INJECT_STALLS"]);
           add_logic_inject_stalls(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_EXTERNAL_UNIT_ENABLE :
           temp = #(#[K_EXTERNAL_UNIT_ENABLE, "K_EXTERNAL_UNIT_ENABLE"]);
           add_logic_external_unit_enable(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         case K_LITERAL_UNIT_ADDRESS_DECODER :
           temp = #(#[K_UNIT_ADDRESS_DECODER, "K_UNIT_ADDRESS_DECODER"]);
           add_logic_unit_address_decoder(scopeId, #exp->getLine(), #exp->getColumn());
           break;
         default :
           errorToken = TRUE;
//           RefString msg = _RS("Unexpected token '");
//           msg->append( #exp->getFirstChild()->getFirstChild()->getText());
//           msg->append( "' ");
//           throwCommandError(_RS("add_logic()"), msg, #exp->getLine(), #exp->getColumn());
       }
       if (error) {//the add logics that were removed from language for now
         RefString msg = _RS("Command add_logic(");
         msg->append( #exp->getFirstChild()->getFirstChild()->getText());
         msg->append( ") was removed from language");
         throwError( msg, #exp->getLine(), #exp->getColumn());
       }
       //set real filename + line for fake vertex and add it to AST
       // the fake vertex has as child the add logic rule for that literal
       //       setCurrentFilename(temp, #id->getColumn(), #exp->getLine());
       if (!errorToken) {
         temp->addChild(returnAST);
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { errorToken = TRUE; }
   }
   else { errorToken = TRUE; }

   if (errorToken) {

     RefString msg = _RS("Unexpected token '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("add_logic()"), msg, #exp->getLine(), #exp->getColumn());
   }

 }

 )
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(neg_output) command  ***//
//*************************************************************************************************************************************************************************//
add_logic_neg_output[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(
 
 {//command call options
   RefString command = _RS("add_logic(neg_output)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(serial_input) command  ***//
//*************************************************************************************************************************************************************************//
add_logic_serial_input[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
    RefString command = _RS("add_logic(serial_input)");

    TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
  }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(serial_output) command  ***//
//*************************************************************************************************************************************************************************//
add_logic_serial_output[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(
 
 {//command call options
   RefString command = _RS("add_logic(serial_output)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
   
   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
 }

 RPAREN!
)
;


//add_logic_rd_en[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  {
//    RefString str = _RS("add_logic(rd_en)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    TInt trueColumn = column - 10;
//    commandCheck(str, scopeId, mask, line, trueColumn);
//  }
//  RPAREN!
//  ;


//add_logic_wr_en[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  {
//    RefString str = _RS("add_logic(wr_en)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    TInt trueColumn = column - 10;
//    commandCheck(str, scopeId, mask, line, trueColumn);
//  }
//  RPAREN!
//  ;


//add_logic_stall_generation[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:COMMA!
//  {
//    RefString str = _RS("add_logic(stall_generation,...)");
//    TInt mask = NSSymbolTable::TREG_DECL | NSSymbolTable::TTB_DECL;
//    TInt trueColumn = lp1->getColumn() - 10;//should remove -10 -first no numbers in code, -second there might be white spaces inserted
//    commandCheck(str, scopeId, mask, lp1->getLine(), trueColumn);
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_logic(stall_generation,...)' : Expecting identifier as second argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** csl add_logic(clock) command  ***//
//*************************************************************************************************************************************************************************//
add_logic_clock[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

{
  RefCslAST exp_name, exp_period, exp_base;
  TBool error = FALSE;
}
:

(

 {//command call options
   RefString command = _RS("add_logic(clock)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL | NSSymbolTable::TTB_DECL; 

   //    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
   //    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
 }

 ( COMMA! expression! { exp_name = returnAST; } COMMA! expression! { exp_period = returnAST; } COMMA! expression! { exp_base = returnAST; } )?

 {//checks for long version of add_logic(clock)
   RefCslAST temp;
   TBool wasLiteral = FALSE;

   if (ANTLR_USE_NAMESPACE(antlr)nullAST !=  exp_base) {
     
     //time_base checks
     if (EXPR_PRIMARY_IDENTIFIER == exp_base->getFirstChild()->getType()) {

       if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_base->getFirstChild()->getFirstChild()->getFirstChild()
           && ANTLR_USE_NAMESPACE(antlr)nullAST == exp_base->getFirstChild()->getFirstChild()->getNextSibling()) {

         RefString literalString = _RS(#exp_base->getFirstChild()->getFirstChild()->getText());
         TLInt literalEnum = getLiteralEnum(literalString);
         switch (literalEnum) {
           case K_LITERAL_PIPE_STALL :
             temp = #(#[K_PS, "K_PS"]);
             break;
           case K_LITERAL_NS :
             temp = #(#[K_NS, "K_NS"]);
             break;
           case K_LITERAL_US :
             temp = #(#[K_US, "K_US"]);
             break;
           case K_LITERAL_MUX_SELECT :
             temp = #(#[K_MS, "K_MS"]);
             break;
           case K_LITERAL_S :
             temp = #(#[K_S, "K_S"]);
             break;
           default :
             error = TRUE;
         }

         if (!error) {

           setCurrentFilename(temp, #exp_base->getColumn(), #exp_base->getLine());
           wasLiteral = TRUE;
         }
       }
       else { error = TRUE; }

     }
     else if (FUNCTION_CALL_RET_ID != exp_base->getFirstChild()->getType()) { error = TRUE; }

     if (error) {
       RefString msg = _RS("Expecting time base as fourth argument, found '");
       msg->append( #exp_base->getFirstChild()->getFirstChild()->getText());
       msg->append( "' ");
       throwCommandError(_RS("add_logic(clock,...)"), msg, exp_base->getLine(), exp_base->getColumn());
     }

     //period checks
     if (STRING == exp_period->getFirstChild()->getType()) {

       throwCommandError(_RS("add_logic(clock,...)"), _RS("Expecting numeric as third argument "), exp_period->getLine(), exp_period->getColumn());
     }

     //clock_name checks
     if (EXPR_PRIMARY_IDENTIFIER != exp_name->getFirstChild()->getType()
         && FUNCTION_CALL_RET_ID != exp_name->getFirstChild()->getType()) {

       throwCommandError(_RS("add_logic(clock,...)"), _RS("Expecting identifier as third identifier "), exp_name->getLine(), exp_name->getColumn());
     }
     else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(exp_name)); }

   }//the order that the vertexes should be added to the AST is opposite to the order of the checking(which was done from the last to the first)

   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(exp_period));

   if (wasLiteral) { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp)); }
   else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(exp_base));}

 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** csl add_logic(generate_report,...) command  ***//
//*************************************************************************************************************************************************************************//
add_logic_generate_report[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

{
  TBool error = FALSE;
}
:

(

 {//command call options
   RefString command = _RS("add_logic(generate_report,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TTB_DECL; 

   //    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
   //    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
 }

 ( COMMA! exp:expression

 {
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_COLUMNS :
           temp = #(#[K_COLUMNS, "K_COLUMNS"]);
           break;
         case K_LITERAL_ROWS :
           temp = #(#[K_ROWS, "K_ROWS"]);
           break;
         default :
           error = TRUE;
       }

       if (!error) {

          setCurrentFilename(temp, #exp->getColumn(), #exp->getLine());
          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { error = TRUE; }
   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {

     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }
              
   if (error) {
     RefString msg = _RS("Expecting 'columns' or 'rows', found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("add_logic(generate_report,...)"), msg, #exp ->getLine(), #exp->getColumn());
   }
 }

 )?
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(async_reset,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_async_reset[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(async_reset)");
   
   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(init,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_init[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

{
  RefCslAST exp;
}
:

(

 {//command call options
   RefString command = _RS("add_logic(init)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 ( COMMA!  expression { exp = returnAST; } )?

 {
   if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {

     if (STRING == exp->getFirstChild()->getType()) {

       throwCommandError(_RS("add_logic(init,...)"), _RS("Expecting numeric value as second argument "), exp->getLine(), exp->getColumn());
     }
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(clear,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_clear[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

{
  RefCslAST exp;
}
:

(

 {//command call options
   RefString command = _RS("add_logic(clear)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 ( COMMA!  expression { exp = returnAST; } )?

 {
   if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {

     if (STRING == exp->getFirstChild()->getType()) {

       throwCommandError(_RS("add_logic(clear,...)"), _RS("Expecting numeric value as second argument "), exp->getLine(), exp->getColumn());
     }
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(stop,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_stop[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(stop,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 COMMA!  exp:expression

 {
   if (STRING != #exp->getFirstChild()->getType()) {

     throwCommandError(_RS("add_logic(stop,...)"), _RS("Expecting numeric expression as second argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(direction_control) command ***//
//*************************************************************************************************************************************************************************//
add_logic_direction_control[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(direction_control)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; //not necessary (not allowed)

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TREG_DECL,
                                                           NSSymbolTable::TUNIT_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(inject_stalls) command ***//
//*************************************************************************************************************************************************************************//
add_logic_inject_stalls[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(  
 
 {//command call options
   RefString command = _RS("add_logic(inject_stalls)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; //not necessary (not allowed)

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(external_unit_enable) command ***//
//*************************************************************************************************************************************************************************//
add_logic_external_unit_enable[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(external_unit_enable)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask/*, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap*/);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(unit_address_decoder,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_unit_address_decoder[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {
   RefString command = _RS("add_logic(unit_address_decoder,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap;

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 com:COMMA!  exp:expression

 {
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(unit_address_decoder,...)"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
 RPAREN!
)
;



////*************************************************************************************************************************************************************************//
////*** add_logic(gen_decoder) command ***//
////*************************************************************************************************************************************************************************//
//add_logic_gen_decoder[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//
//:
//
//(
//
// {//command call options
//   RefString command = _RS("add_logic(gen_decoder,...)");
//
//   TInt                  callAllowedInScopesWithoutObjectMask = 0 ;
//
//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
//
//   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
//                                                           NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));
//
//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
//
//   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
//                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
//                                                         | NSSymbolTable::TFIELD_DECL));
//
//   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
//                                                         NSSymbolTable::TISAE_DECL));
//
//   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
//
//   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
// }
//
// RPAREN!
//)
//;


//add_logic_simulation_timeout_counter[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:COMMA!
//  {
//    RefString str = _RS("add_logic(simulation_timeout_counter,...)");
//    TInt mask = NSSymbolTable::TTB_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//   exp1:expression
//   {
//     if (UNSIGNED_NUMBER != #exp1->getFirstChild()->getType()
//         && EXPR_HYBRID != #exp1->getFirstChild()->getType()
//         && FUNCTION_CALL_RET_EXPR != #exp1->getFirstChild()->getType()) {
//       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_logic(simulation_timeout_counter,...)' : Expecting numeric expression as argument ",
//                                                            *currentFilename,
//                                                            lp1->getLine(),
//                                                            lp1->getColumn());
//     }
//   }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** add_logic(generate_waves,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_generate_waves[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:COMMA!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add_logic(generate_waves,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TTB_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression!
   
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(generate_waves,...)"), _RS("Expecting string as second argument "), #exp->getLine(), #exp->getColumn());
   }
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
 }
 
  COMMA!  exp2:expression!

 {//exp2 is only allowed to be wave_type literal
   if (EXPR_PRIMARY_IDENTIFIER == #exp2->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp2->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp2->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp2->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_WAVE_TYPE_FSDB :
           temp = #(#[K_WAVE_TYPE_FSDB, "K_WAVE_TYPE_FSDB"]);
           break;
         case K_LITERAL_WAVE_TYPE_VCD :
           temp = #(#[K_WAVE_TYPE_VCD, "K_WAVE_TYPE_VCD"]);
           break;
         default :
           error = TRUE;
       }

       if (!error) {

         setCurrentFilename(temp, #exp2->getColumn(), #exp2->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { error = TRUE; }
   }
   else if (FUNCTION_CALL_RET_ID == #exp2->getFirstChild()->getType()) {
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) { 
     RefString msg = _RS("Expecting wave type as third argument, found '");
     msg->append( #exp2->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("add_logic(generate_waves,...)"), msg, #exp2->getLine(), #exp2->getColumn());
   }
 }

   ( COMMA!   exp3:expression!

   {//exp3 is only allowed to be identifier
     if (EXPR_PRIMARY_IDENTIFIER != #exp3->getFirstChild()->getType()
         && FUNCTION_CALL_RET_ID != #exp3->getFirstChild()->getType()) {

       throwCommandError(_RS("add_logic(generate_waves,...)"), _RS("Expecting identifier as argument"), #exp3->getLine(), #exp3->getColumn());
     }
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   
   )*

 RPAREN!
)
;


//add_logic_connect_output_to_field[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:COMMA!
//  {
//    RefString str = _RS("add_logic(connect_output_to_field,...)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//   expr:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #expr->getFirstChild()->getType()
//        && EXPR_HYBRID != #expr->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #expr->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_logic(connect_output_to_field,...)' : Expecting identifier ",
//                                                           ln1->getFilename(),
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** add_logic(gray_output) command ***//
//*************************************************************************************************************************************************************************//
add_logic_gray_output[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(gray_output)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 RPAREN!
)
;


//add_logic_cnt_dir_signal[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  {
//    RefString str = _RS("add_logic(cnt_dir_signal,...)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    TInt trueColumn = column - 10;
//    commandCheck(str, scopeId, mask, line, trueColumn);
//  }
//  RPAREN!
//  ;


//add_logic_inc_signal[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  {
//    RefString str = _RS("add_logic(inc_signal)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    TInt trueColumn = column - 10;
//    commandCheck(str, scopeId, mask, line, trueColumn);
//  }
//  RPAREN!
//  ;


//add_logic_dec_signal[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  {
//    RefString str = _RS("add_logic(dec_signal)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    TInt trueColumn = column - 10;
//    commandCheck(str, scopeId, mask, line, trueColumn);
//  }
//  RPAREN!
//  ;


//add_logic_sh_op_signal[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  {
//    RefString str = _RS("add_logic(sh_op_signal)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    TInt trueColumn = column - 10;
//    commandCheck(str, scopeId, mask, line, trueColumn);
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** add_logic(start_value,...) command ***//
//*************************************************************************************************************************************************************************//
 add_logic_start_value[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:COMMA!
 
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add_logic(start_value,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(start_value,...)"), _RS("Expecting numeric expression as second argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(end_value,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_end_value[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:COMMA!
 
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add_logic(end_value,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(end_value,...)"), _RS("Expecting numeric expression as second argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(count_amount,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_count_amount[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:COMMA!
 
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add_logic(count_amount,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(count_amount,...)"), _RS("Expecting numeric expression as second argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//add_logic_count_direction[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  ln1:COMMA!
//  {
//    RefString str = _RS("add_logic(count_direction,...)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, line,column);
//  }
// (
//  id:IDENTIFIER
//  {
//    setCurrentFilename(#id);
//    RefString literalString = _RS(#id->getText());
//    TLInt literalEnum = getLiteralEnum(literalString);
//    RefCslAST temp;
//    switch (literalEnum) {
//      case K_LITERAL_UP :
//        temp = #(#[K_UP, "K_UP"]);
//        setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//        break;
//      case K_LITERAL_DOWN :
//        temp = #(#[K_DOWN, "K_DOWN"]);
//        setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//        break;
//      default :
//        RefString msg = _RS("command 'add_logic(count_direction,...)' : Unexpected token '");
//        msg->append( #id->getText());
//        msg->append( "' ");
//        throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                             *currentFilename,
//                                                             #id->getLine(),
//                                                             #id->getColumn());
//    }
//  }
// )
//  RPAREN!
//  ;


//add_logic_count_enable[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  {
//    RefString str = _RS("add_logic(count_enable,...)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, line,column);
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** add_logic(set,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_set[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

{
  RefCslAST exp;
}
:

(

 {//command call options
   RefString command = _RS("add_logic(set,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 ( COMMA!  expression { exp = returnAST; } )?

 {
   if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {

     if (STRING == exp->getFirstChild()->getType()) {

       throwCommandError(_RS("add_logic(set,...)"), _RS("Expecting numeric expression as first argument "), exp->getLine(), exp->getColumn());
     }
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(reset) command ***//
//*************************************************************************************************************************************************************************//
add_logic_reset[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

{
  RefCslAST exp;
}
:

(

 {//command call options
   RefString command = _RS("add_logic(reset,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL | NSSymbolTable::TREG_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 ( COMMA!  expression { exp = returnAST; } )?

 {
   if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {

     if (STRING == exp->getFirstChild()->getType()) {

       throwCommandError(_RS("add_logic(reset,...)"), _RS("Expecting numeric expression as first argument "), exp->getLine(), exp->getColumn());
     }
   }
 }

 RPAREN!
)
;


//add_logic_connect_input_to_field[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:COMMA!
//  {
//    RefString str = _RS("add_logic(connect_input_field_to_field,...)");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//   expr:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #expr->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #expr->getFirstChild()->getType()
//        && EXPR_HYBRID != #expr->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command add_logic(connect_input_to_field,...) : Expecting identifier as second argument ",
//                                                           ln1->getFilename(),
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** add_logic(programmable_depth,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_programmable_depth[NSCSLOm::RefTVec_RefString scopeId]

:

(  lp1:COMMA! 

 {//set the command call options
   RefString command = _RS("add_logic(programmable_depth,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(),lp1->getColumn());
 }

 exp1:expression
 
 {
   if (STRING == #exp1->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(programmable_depth,...)"), _RS("Expecting numeric expression as second argument "), #exp1->getLine(), #exp1->getColumn()); 
   }
  }

 RPAREN!
)
;      



//*************************************************************************************************************************************************************************//
//*** add_logic(priority_bypass) command ***//
//*************************************************************************************************************************************************************************//
add_logic_priority_bypass[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

 {//command call options
   RefString command = _RS("add_logic(priority_bypass,...)");
   
   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** add_logic(sync_fifo) command ***//
//*************************************************************************************************************************************************************************//
add_logic_sync_fifo[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

 {
   RefString command = _RS("add_logic(synch_fifo)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** add_logic(async_fifo) command ***//
//*************************************************************************************************************************************************************************//
add_logic_async_fifo[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

  {
    RefString command = _RS("add_logic(async_fifo)");

    TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
  }

RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** add_logic(depth_extend,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_depth_extend[NSCSLOm::RefTVec_RefString scopeId]

:

(  lp:COMMA!

 {
   RefString command = _RS("add_logic(depth_extend,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

 exp:expression

 {
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(depth_extend,...)"), _RS("Expecting numeric expression as second argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }

RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(width_extend,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_width_extend[NSCSLOm::RefTVec_RefString scopeId]      

:

(  lp:COMMA! 

 {
   RefString command = _RS("add_logic(width_extend,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
 exp:expression
 
 {
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(width_extend,...)"), _RS("Expecting numeric expression as second argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
 
RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(wr_hold,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_wr_hold[NSCSLOm::RefTVec_RefString scopeId]                                                               

:

( lp:COMMA! 
 
 {
   RefString command = _RS("add_logic(wr_hold,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
 exp:expression
 
 {
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(wr_hold,...)"), _RS("Expecting numeric expression as seond argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }

RPAREN!
) 
;



//*************************************************************************************************************************************************************************//
//*** add_logic(parallel_output,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_parallel_output[NSCSLOm::RefTVec_RefString scopeId]

:

( lp1:COMMA! 
 
 {
   setCurrentFilename(#lp1);
   //set command call options
   RefString command = _RS("add_logic(parallel_output,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
 }

( exp:expression!

 {//verify if the all option was supplied
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {
     //the identifier in the expression does not have siblings or children
     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()) {
       
       //if the option is all add the fake vertex to AST, else add the expr to AST
       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_ALL :
           temp = #(#[K_ALL, "K_ALL"]);
           setCurrentFilename(temp, #exp->getLine(), #exp->getColumn());
           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
           break;
         default :
           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
       }

     }
     else {//expression containing multiple ids
       astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
     }

   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {//expression is function call that returns id
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else {//expression is only allowed to be id
     throwCommandError(_RS("add_logic(parallel_output,...)"), _RS("Expecting identifier as second argument "), #exp->getLine(), #exp->getColumn());
   }
 
 }

 |
 (  list:K_CSL_LIST  { setCurrentFilename(#list); }
    csl_list_declaration[#list->getLine(), #list->getColumn()]
  )
 )
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(parallel_input,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_parallel_input[NSCSLOm::RefTVec_RefString scopeId]    

:

( lp1:COMMA! 
 
 {
   setCurrentFilename(#lp1);
   //set command call options
   RefString command = _RS("add_logic(parallel_input,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
 }

( exp:expression!

 {//verify if the all option was supplied
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {
     //the identifier in the expression does not have siblings or children
     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()) {
       
       //if the option is all add the fake vertex to AST, else add the expr to AST
       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_ALL :
           temp = #(#[K_ALL, "K_ALL"]);
           setCurrentFilename(temp, #exp->getLine(), #exp->getColumn());
           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
           break;
         default :
           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
       }

     }
     else {//expression containing multiple ids
       astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
     }

   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {//expression is function call that returns id
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else {//expression is only allowed to be id
     throwCommandError(_RS("add_logic(parallel_input,...)"), _RS("Expecting identifier as second argument "), #exp->getLine(), #exp->getColumn());
   }
 
 }

 |
 (  list:K_CSL_LIST  { setCurrentFilename(#list); }
    csl_list_declaration[#list->getLine(), #list->getColumn()]
  )
 )
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(rd_words,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_rd_words[NSCSLOm::RefTVec_RefString scopeId]

:

( lp1:COMMA!

 {//set real filename for lp1
   setCurrentFilename(#lp1);
   // command call options
   RefString command = _RS("add_logic(rd_words,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
 }

  exp1:expression
  
 {//exp1 is allowed to be only numeric
    if (STRING == #exp1->getFirstChild()->getType()) {
      throwCommandError(_RS("add_logic(rd_words,...)"), _RS("Expecting numeric expression as second argument "), #exp1->getLine(), #exp1->getColumn()); 
    }                                               
  }

  COMMA!  exp2:expression
 
 {//exp2 is only allowed to be numeric
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(rd_words,...)"), _RS("Expecting numeric expression as third argument "), #exp2->getLine(), #exp2->getColumn()); 
   }
 }

  RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(wr_words,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_wr_words[NSCSLOm::RefTVec_RefString scopeId]          

:

( lp1:COMMA!

 {
   setCurrentFilename(#lp1);
   //command call options
   RefString command = _RS("add_logic(wr_words,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
 }
 
  exp1:expression

 {//exp1 is only allowed to be numeric
   if (STRING == #exp1->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(wr_words,...)"), _RS("Expecting numeric expression as second argument "), #exp1->getLine(), #exp1->getColumn()); 
   }
 }
 
 COMMA! exp2:expression
 
 {//exp2 is only allowed to be numeric
  if (STRING == #exp2->getFirstChild()->getType()) {
    throwCommandError(_RS("add_logic(wr_words,...)"), _RS("Expecting numeric expression as third argument "), #exp2->getLine(), #exp2->getColumn()); 
  }                                               
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(sram_rd,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_sram_rd[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(sram_rd,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(sram_wr,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_sram_wr[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(  

 {//command call options
   RefString command = _RS("add_logic(sram_wr,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
  
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(pushback,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_pushback[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {
   RefString command = _RS("add_logic(pushback)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 RPAREN!
)
;

//*************************************************************************************************************************************************************************//
//*** add_logic(flow_through,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_flow_through[NSCSLOm::RefTVec_RefString scopeId]      

:

( lp1:COMMA! 
 
 {//set real filename + line for lp1
   setCurrentFilename(#lp1);
   //command call options
   RefString command = _RS("add_logic(flow_through,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
 }
 
  exp1:expression
  
 {//exp1 is only allowed to be numeric
   if (STRING == #exp1->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(flow_through,...)"), _RS("Expecting numeric expression as second argument "), #exp1->getLine(), #exp1->getColumn()); 
   }
 }
  
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(read_valid) command ***//
//*************************************************************************************************************************************************************************//
add_logic_read_valid[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(
 
 {//command call options
   RefString command = _RS("add_logic(read_valid)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 RPAREN!
)
;


//add_logic_bypass[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
//  :
//  {
//    RefString str = _RS("add_logic(bypass)");
//    TInt mask = NSSymbolTable::TRF_DECL;
//    commandCheck(str, scopeId, mask, line, column);
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** add_logic(stall) command ***//
//*************************************************************************************************************************************************************************//
add_logic_stall[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]
:

(  

 {//command call options
   RefString command = _RS("add_logic(stall)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(stall_rd_side) command ***//
//*************************************************************************************************************************************************************************//
add_logic_stall_rd_side[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(stall_rd_side)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(stall_rd_side) command ***//
//*************************************************************************************************************************************************************************//
add_logic_stall_wr_side[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(stall_wr_side)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(wr_release) command ***//
//*************************************************************************************************************************************************************************//
add_logic_wr_release[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(wr_release)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(almost_empty,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_almost_empty[NSCSLOm::RefTVec_RefString scopeId]      

:

( lp1:COMMA! 
 
 {//set real filename + line for lp1
   setCurrentFilename(#lp1);
   //command call options
   RefString command = _RS("add_logic(almost_empty,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
 }
 
  exp1:expression

 {//exp1 is only allowed to be numeric
   if (STRING == #exp1->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic_almost_empty()"), _RS("Expecting numeric expression as second argument "), #exp1->getLine(), #exp1->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(almost_full,...) command ***//
//*************************************************************************************************************************************************************************//
add_logic_almost_full[NSCSLOm::RefTVec_RefString scopeId]       

:

( lp1:COMMA! 
 
 {//set real filename + line for lp1
   setCurrentFilename(#lp1);
   //command call options
   RefString command = _RS("add_logic(almost_full,...)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
 }
 
  exp1:expression
  
 {//exp1 is only allowed to be numeric
   if (STRING == #exp1->getFirstChild()->getType()) {
     throwCommandError(_RS("add_logic(almost_full,...)"), _RS("Expecting numeric expression as second argument "), #exp1->getLine(), #exp1->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(output_wr_addr) command ***//
//*************************************************************************************************************************************************************************//
add_logic_output_wr_addr[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(output_wr_addr)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(output_rd_addr) command ***//
//*************************************************************************************************************************************************************************//
add_logic_output_rd_addr[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(output_rd_addr)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
  }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(credit) command ***//
//*************************************************************************************************************************************************************************//
add_logic_credit[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(credit)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(rd_credit) command ***//
//*************************************************************************************************************************************************************************//
add_logic_rd_credit[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 { //command call options
   RefString command = _RS("add_logic(rd_credit)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(wr_credit) command ***//
//*************************************************************************************************************************************************************************//
add_logic_wr_credit[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]

:

(

 {//command call options
   RefString command = _RS("add_logic(wr_credit)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_logic(flow) command ***//
//*************************************************************************************************************************************************************************//
add_logic_flow[NSCSLOm::RefTVec_RefString scopeId, TInt line, TInt column]     
:

(

 {//command call options
   RefString command = _RS("add_logic(flow)");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
 }

 RPAREN!
)
;


//param_list_set_mask[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_mask()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expression
//  RPAREN!
//;


//param_list_set_shift_type[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_shift_type()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  ( 
//   id:IDENTIFIER
//   {
//     setCurrentFilename(#id);
//     RefString literalString = _RS(#id->getText());
//     TLInt literalEnum = getLiteralEnum(literalString);
//     RefCslAST temp;
//     switch (literalEnum) {
//       case K_LITERAL_SAL :
//         temp = #(#[K_SAL, "K_SAL"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_shift_type = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_SAR :
//         temp = #(#[K_SAR, "K_SAR"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_shift_type = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_SHL :
//         temp = #(#[K_SHL, "K_SHL"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_shift_type = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_SHR :
//         temp = #(#[K_SHR, "K_SHR"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_shift_type = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_ROL :
//         temp = #(#[K_ROL, "K_ROL"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_shift_type = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_ROR :
//         temp = #(#[K_ROR, "K_ROR"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_shift_type = #(antlr::RefAST(temp));
//         break;
//       default :
//         RefString msg = _RS("command 'set_shift_type()' : Unexpected token '");
//         msg->append( #id->getText());
//         msg->append( "' ");
//         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                              *currentFilename,
//                                                              #id->getLine(),
//                                                              #id->getColumn());
//     }
//   }
//  )
//  RPAREN!
//;


//param_list_set_shift_amount[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_shift_amount()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expression
//  RPAREN!
//;


//param_list_set_final_shift_value[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_final_shift_value()");
//    TInt mask = NSSymbolTable::TREG_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expression
//  RPAREN!
//;


//param_list_set_source[NSCSLOm::RefTVec_RefString scopeId]        
//{
//  TBool wasFirstOpt = FALSE;
//}
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_source()");
//    TInt mask = NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expr:expression!
//  {
//    if (STRING != #expr->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #expr->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_source()' : Expecting string as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//    #param_list_set_source = #(returnAST);
//  }
//  COMMA!
//  (
//   id:IDENTIFIER!
//   {
//     setCurrentFilename(#id);
//     RefString literalString = _RS(#id->getText());
//     TLInt literalEnum = getLiteralEnum(literalString);
//     RefCslAST temp;
//     switch (literalEnum) {
//       case K_LITERAL_PLI_SOCKET :
//         temp = #(#[K_PLI_SOCKET, "K_PLI_SOCKET"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_source->addChild(ANTLR_USE_NAMESPACE(antlr)RefCslAST(temp));
//         break;
//       case K_LITERAL_FILE :
//         temp = #(#[K_FILE, "K_FILE"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_source->addChild(ANTLR_USE_NAMESPACE(antlr)RefCslAST(temp));
//         break;
//       default :
//         RefString msg = _RS("command 'set_source()' : Unexpected token '");
//         msg->append( #id->getText());
//         msg->append( "' ");
//         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                              *currentFilename,
//                                                              #id->getLine(),
//                                                              #id->getColumn());
//     }
//   }
//   )
//   (
//    COMMA!
//    (
//     id2:IDENTIFIER
//     {
//       setCurrentFilename(#id2);
//       RefString literalString = _RS(#id2->getText());
//       TLInt literalEnum = getLiteralEnum(literalString);
//       RefCslAST temp;
//       switch (literalEnum) {
//         case K_LITERAL_BIN :
//           temp = #(#[K_BIN, "K_BIN"]);
//           setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//           #param_list_set_source->addChild(ANTLR_USE_NAMESPACE(antlr)RefCslAST(temp));
//           break;
//         case K_LITERAL_HEX :
//           temp = #(#[K_HEX, "K_HEX"]);
//           setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//           #param_list_set_source->addChild(ANTLR_USE_NAMESPACE(antlr)RefCslAST(temp));
//           break;
//         default :
//           RefString msg = _RS("command 'set_source()' : Unexpected token '");
//           msg->append( #id2->getText());
//           msg->append( "' ");
//           throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                                *currentFilename,
//                                                                #id2->getLine(),
//                                                                #id2->getColumn());
//       }
//     }
//     )
//    )?
//  RPAREN!
//  ;


//param_list_set_compare_event[NSCSLOm::RefTVec_RefString scopeId] 
//  :
//  lp1:LPAREN!
//  { 
//    RefString str = _RS("set_compare_event()");
//    TInt mask = NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_compare_event()' : Expecting identifier as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_vc_cpp_rd_name[NSCSLOm::RefTVec_RefString scopeId]   
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_vc_cpp_rd_name()");
//    TInt mask = NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_vc_cpp_rd_name()' : Expecting string as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_vc_cpp_wr_name[NSCSLOm::RefTVec_RefString scopeId]   
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_vc_cpp_wr_name()");
//    TInt mask = NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        &&FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_vc_cpp_wr_name()' : Expecting string as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** set_vc_start_generation_trigger() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_start_generation_trigger[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_start_generation_trigger()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_start_generation_trigger()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_set_capture_event[NSCSLOm::RefTVec_RefString scopeId]      
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_capture_event()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_capture_event()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_start_vector_generation[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("start_vector_generation()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'start_vector_generation()' : Expecting identifier as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_model[NSCSLOm::RefTVec_RefString scopeId]              
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_model()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  (
//   id:IDENTIFIER!
//   {
//     setCurrentFilename(#id);
//     RefString literalString = _RS(#id->getText());
//     TLInt literalEnum = getLiteralEnum(literalString);
//     RefCslAST temp;
//     switch (literalEnum) {
//       case K_LITERAL_CPP :
//         temp = #(#[K_CPP, "K_CPP"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_model = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_TB :
//         temp = #(#[K_TB, "K_TB"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_model = #(antlr::RefAST(temp));
//         break;
//       default :
//         RefString msg = _RS("command 'set_model()' : Unexpected token '");
//         msg->append( #id->getText());
//         msg->append( "' ");
//         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                              *currentFilename,
//                                                              #id->getLine(),
//                                                              #id->getColumn());
//     }
//   }
//  )
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** set_unit_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_unit_name[NSCSLOm::RefTVec_RefString scopeId]        

:

( lp:LPAREN!
  
 {//set real filename + line for lp
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_unit_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL | NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_unit_name()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_set_cpp_vector_rd_name[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_cpp_vector_rd_name()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expr:expression
//  {
//    if (STRING != #expr->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #expr->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_cpp_vector_rd_name()' : Expecting string as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_cpp_vector_wr_name[NSCSLOm::RefTVec_RefString scopeId] 
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_cpp_vector_wr_name()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expr:expression
//  {
//    if (STRING != #expr->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #expr->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_cpp_vector_wr_name()' : Expecting string as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_max_num_of_vectors[NSCSLOm::RefTVec_RefString scopeId] 
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_max_num_of_vectors()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expr:expression
//  {
//    if (UNSIGNED_NUMBER != #expr->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #expr->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_max_num_of_vectors()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_transaction_type[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_transaction_type()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  (
//   id:IDENTIFIER
//   {
//     setCurrentFilename(#id);
//     RefString literalString = _RS(#id->getText());
//     TLInt literalEnum = getLiteralEnum(literalString);
//     RefCslAST temp;
//     switch (literalEnum) {
//       case K_LITERAL_TRANSACTION :
//         temp = #(#[K_TRANSACTION, "K_TRANSACTION"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_transaction_type = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_CYCLE_ACCURATE :
//         temp = #(#[K_CYCLE_ACCURATE, "K_CYCLE_ACCURATE"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_transaction_type = #(antlr::RefAST(temp));
//         break;
//       default :
//         RefString msg = _RS("command 'set_transaction_type()' : Unexpected token '");
//         msg->append( #id->getText());
//         msg->append( "' ");
//         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                              *currentFilename,
//                                                              #id->getLine(),
//                                                              #id->getColumn());
//     }
//   }
//  )
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** pipestage_naming_convention() command ***//
//*************************************************************************************************************************************************************************//
param_list_pipestage_naming_convention[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("pipestage_naming_conventions()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TPIPESTG_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression

 RPAREN!
)
;


//param_list_set_number_of_pipestages[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_number_of_pipestages()");
//    TInt mask = NSSymbolTable::TPIPELINE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING == #exp->getFirstChild()->getType()
//        || EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()
//        || FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_number_of_pipestages()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_associate_pipeline[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("associate_pipeline()");
//    TInt mask = NSSymbolTable::TPIPELINE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'associate_pipeline()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_replicate[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("replicate()");
//    TInt mask = NSSymbolTable::TPIPELINE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'replicate()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_add_pipestage[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("add_pipestage()");
//    TInt mask = NSSymbolTable::TPIPELINE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_pipestage()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_previous_pipestage[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_previous_pipestage()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_previous_pipestage()' : Expecting identifier as first argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  lp2:COMMA!
//  exp2:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp2->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp2->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_previous_pipestage()' : Expecting identifier as second argument ",
//                                                           *currentFilename,
//                                                           lp2->getLine(),
//                                                           lp2->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_next_pipestage[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_previous_pipestage()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_next_pipestage()' : Expecting identifier as first argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  lp2:COMMA!
//  exp2:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp2->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp2->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_next_pipestage()' : Expecting identifier as second argument ",
//                                                           *currentFilename,
//                                                           lp2->getLine(),
//                                                           lp2->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_pipestage_number[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_pipestage_number()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()
//        || FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()
//        || STRING == #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_pipestage_number()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_msb[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_msb()");
//    TInt mask = NSSymbolTable::TBITRANGE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (UNSIGNED_NUMBER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_msb()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_lsb[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_lsb()");
//    TInt mask = NSSymbolTable::TBITRANGE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (UNSIGNED_NUMBER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_lsb()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_initialize[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("initialize()");
//    TInt mask = NSSymbolTable::TMEM_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'initialize()' : Expecting string as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** initialize_random_values() command ***//
//*************************************************************************************************************************************************************************//
param_list_initialize_random_values[NSCSLOm::RefTVec_RefString scopeId]

:

 ( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("initialize_random_values()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
   exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("initialize_random_values()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** initialize_random() command ***//
//*************************************************************************************************************************************************************************//
param_list_initialize_random[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("initialize_random()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL;

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("initialize_random()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_set_pipestage_name[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_pipestage_name()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'set_pipestage_name()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_connect_stall[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("connect_stall()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL | NSSymbolTable::TPIPELINE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'connect_stall()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_connect_enable[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("connect_enable()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL | NSSymbolTable::TPIPELINE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'connect_enable()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_pipestage_valid_input[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_pipestage_valid_input()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'set_pipestage_valid_input()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_pipestage_valid_output[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_pipestage_valid_output()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'set_pipestage_valid_output()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_branch[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("branch()");
//    TInt mask = NSSymbolTable::TPIPESTG_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'branch()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** merge() command ***//
//*************************************************************************************************************************************************************************//
param_list_merge[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:LPAREN!

 {//set real flename + line for lp
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("merge()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 ;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression

 {//exp should be one of merge operators
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_NAND :
           temp = #(#[K_NAND, "K_NAND"]);
           break;
         case K_LITERAL_NOR :
           temp = #(#[K_NOR, "K_NOR"]);
           break;
         case K_LITERAL_XNOR :
           temp = #(#[K_XNOR, "K_XNOR"]);
           break;
         case K_LITERAL_AND :
           temp = #(#[K_AND, "K_AND"]);
           break;
         case K_LITERAL_OR :
           temp = #(#[K_OR, "K_OR"]);
           break;
         case K_LITERAL_XOR :
           temp = #(#[K_XOR, "K_XOR"]);
           break;
         case K_LITERAL_NOT :
           temp = #(#[K_NOT, "K_NOT"]);
           break;
         case K_LITERAL_PLUS :
           temp = #(#[K_OR, "K_OR"]);
           break;
         default :
           error = TRUE;
       }
       if (!error) {
         setCurrentFilename(temp, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }

     }
     else { error = TRUE; }

   }
   else { error = TRUE; }

   if (error) {
     RefString msg = _RS("Expecting merge operator, found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("merge()"), msg, #exp->getLine(), #exp->getColumn());
   }
 }

  ( COMMA! exp2:expression

  {
    if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
        && FUNCTION_CALL_RET_ID != #exp2->getFirstChild()->getType()) {
      throwCommandError(_RS("merge()"), _RS("Expecting identifier as second argument "), #exp2->getLine(), #exp2->getColumn());
    }
  }

    ( COMMA! exp3:expression

    {
      if (EXPR_PRIMARY_IDENTIFIER != #exp3->getFirstChild()->getType()
          && FUNCTION_CALL_RET_ID != #exp3->getFirstChild()->getType()) {
        throwCommandError(_RS("merge()"), _RS("Expecting identifier as argument "), #exp3->getLine(), #exp3->getColumn());
      }
    }

    )*

  )?
 
 RPAREN!
)
;


//param_list_inline_file[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("inline_file()");
//    TInt mask = NSSymbolTable::TPIPELINE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'inline_file()' : Expecting identifier as first argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  (
//   lp2:COMMA!
//   exp2:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp2->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp2->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'inline_file()' : Expecting identifier as second argument ",
//                                                           *currentFilename,
//                                                           lp2->getLine(),
//                                                           lp2->getColumn());
//    }
//  }
//  )
//  RPAREN!
//  ;


//param_list_reset_init_value[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("reset_init_value()");
//    TInt mask = NSSymbolTable::TPIPELINE_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()
//        || FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()
//        || STRING == #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Command 'reset_init_value()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }                                                        
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** gen_decoder() command ***//
//*************************************************************************************************************************************************************************//
param_list_gen_decoder[NSCSLOm::RefTVec_RefString scopeId ]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("gen_decoder()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAF_DECL | NSSymbolTable::TISAE_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TISAE_DECL));

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TISAE_DECL));

   

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  (  exp:expression
  
  {//exp is only allowed to be identifier 
    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
      throwCommandError(_RS("gen_decoder()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn()); 
    }
  }

 )?
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_mnemonic() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_mnemonic[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool isExpr   = FALSE;
  TBool isIdList = FALSE;
}
:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_mnemonic()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAF_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL));

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

  callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                          NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL));

  setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  
   exp:expression

 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_mnemonic()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_set_decoder_name[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:LPAREN!
//  {
//    RefString str = _RS("set_decoder_name()");
//    TInt mask = /*NSSymbolTable::TISA_DECL*/ 0;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//  expr:expression
//  {
//    if (STRING != #expr->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #expr->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("function 'set_decoder_name()' : Expecting string as first argument ",
//                                                           ln1->getFilename(),
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_decoder_out_name_prefix[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_decoder_out_name_prefix()");
//    TInt mask = /*NSSymbolTable::TISA_DECL*/ 0;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_decoder_out_name_prefix()' : Expecting string as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_decoder_out_name_suffix[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_decoder_out_name_suffix()");
//    TInt mask = /*NSSymbolTable::TISA_DECL*/ 0;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_decoder_out_name_suffix()' : Expecting string as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_print[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("print()");
//    TInt mask = /*NSSymbolTable::TISA_DECL*/ 0;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'print()' : Expecting string as first argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** set_enum() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_enum[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_enum()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAF_DECL | NSSymbolTable::TFIELD_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL));

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TISAE_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
  
  exp:expression
  
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_enum()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
 RPAREN!
)
;


//param_list_add_comment[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  ln1:LPAREN!
//  {
//    RefString str = _RS("add_comment()");
//    TInt mask = NSSymbolTable::TVEC_DECL ;
//    commandCheck(str, scopeId, mask, ln1->getLine(),ln1->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_comment()' : Expecting string as argument ",
//                                                           *currentFilename,
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }  
//  RPAREN!
//;



//*************************************************************************************************************************************************************************//
//*** set_address_increment() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_address_increment[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_address_increment()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
                                                           NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_address_increment()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_next_address() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_next_address[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_next_address()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
                                                           NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_next_address()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_alignment() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_alignment[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   RefString command = _RS("set_alignment()");
   //command call options
   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; //not necessary

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_alignment()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_prefix() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_prefix[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:LPAREN!

 {//command call options
   RefString command = _RS("set_prefix()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TPIPESTG_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression!

 {//exp should either pipestage prefix_type literal or string
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_NO_PREFIX : 
           temp = #(#[K_NO_PREFIX, "K_NO_PREFIX"]);
           break;
         case K_LITERAL_PIPELINE_NAME :
           temp = #(#[K_PIPELINE_NAME, "K_PIPELINE_NAME"]);
           break;
         case K_LITERAL_PIPESTAGE_NAME :
           temp = #(#[K_PIPESTAGE_NAME, "K_PIPESTAGE_NAME"]);
           break;
         case K_LITERAL_PIPELINE_PIPESTAGE_NAME :
           temp = #(#[K_PIPELINE_PIPESTAGE_NAME, "K_PIPELINE_PIPESTAGE_NAME"]);
           break;
         default :
           error = TRUE;
       }

       if (!error) {

         setCurrentFilename(temp, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { error = TRUE; }
   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()
            || STRING == #exp->getFirstChild()->getType()
            || FUNCTION_CALL_RET_EXPR == #exp->getFirstChild()->getType()) {
   
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) {

     RefString msg = _RS("Expecting string or prefix type, found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("set_prefix()"), msg, #exp->getLine(), #exp->getColumn());
   }
              
 }

RPAREN!
)
;
//  (
//   lp1:LPAREN!
//   {
//     RefString str = _RS("set_prefix()");
//     TInt mask = NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL | NSSymbolTable::TMEMMAP_DECL 
//       | NSSymbolTable::TLIST_DECL | NSSymbolTable::TPIPELINE_DECL;
//     commandCheck(str, scopeId, mask, lp1->getLine(),lp1->getColumn());
//   }
//   (
//    (IDENTIFIER)=> 
//    (id0:IDENTIFIER 
//     {
//       setCurrentFilename(#id0);
//       if (scopeId->size()) {
//         NSSymbolTable::RefCSymNode commandScope = symTree->lookup(*scopeId);
//         NSSymbolTable::EObjType commandScopeType = commandScope->getType();
//         if (NSSymbolTable::TPIPELINE_DECL != commandScopeType) {throwError = TRUE; }
//       }
//       else { throwError = TRUE; }
//       if (throwError) {
//         RefString msg = _RS("command 'set_prefix()' : Unexpected token '");
//         msg->append( #id0->getText());
//         msg->append( "' ");
//         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                              *currentFilename,
//                                                              #id0->getLine(),
//                                                              #id0->getColumn());
//       }
//       RefString literalString = _RS(#id0->getText());
//       TLInt literalEnum = getLiteralEnum(literalString);
//       RefCslAST temp;
//       switch (literalEnum) {
//         case K_LITERAL_NO_PREFIX : 
//           temp = #(#[K_NO_PREFIX, "K_NO_PREFIX"]);
//           setCurrentFilename(temp, #id0->getColumn(), #id0->getLine());
//           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//           break;
//         case K_LITERAL_PIPELINE_NAME :
//           temp = #(#[K_PIPELINE_NAME, "K_PIPELINE_NAME"]);
//           setCurrentFilename(temp, #id0->getColumn(), #id0->getLine());
//           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//           break;
//         case K_LITERAL_PIPESTAGE_NAME :
//           temp = #(#[K_PIPESTAGE_NAME, "K_PIPESTAGE_NAME"]);
//           setCurrentFilename(temp, #id0->getColumn(), #id0->getLine());
//           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//           break;
//         case K_LITERAL_PIPELINE_PIPESTAGE_NAME :
//           temp = #(#[K_PIPELINE_PIPESTAGE_NAME, "K_PIPELINE_PIPESTAGE_NAME"]);
//           setCurrentFilename(temp, #id0->getColumn(), #id0->getLine());
//           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//           break;
//         default :
//           RefString msg = _RS("command set_prefix() : Unexpected token '");
//           msg->append( #id0->getText());
//           msg->append( "' ");
//           throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                                *currentFilename,
//                                                                #id0->getLine(),
//                                                                #id0->getColumn());
//       }
//     }
//    )
//   |
//   (
//    exp:expression!
//   {
//     if (STRING != #exp->getFirstChild()->getType()
//         && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//         && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_prefix()' : Expecting string as argument ",
//                                                            *currentFilename,
//                                                            lp1->getLine(),
//                                                            lp1->getColumn());
//     }
//     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
//   }
//   (
//    {NSSymbolTable::TRF_DECL == currentScopeType}?
//    COMMA!
//    id:IDENTIFIER!
//    {
//      setCurrentFilename(#id);
//      wasRFSecondArgument = TRUE;
//      RefString literalString = _RS(#id->getText());
//      TLInt literalEnum = getLiteralEnum(literalString);
//      RefCslAST temp;
//      switch (literalEnum) {
//        case K_LITERAL_INPUT :
//          temp = #(#[K_INPUT, "K_INPUT"]);
//          setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//        case K_LITERAL_OUTPUT :
//          temp = #(#[K_OUTPUT, "K_OUTPUT"]);
//          setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//          break;
//        default :
//          throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_prefix()' : Expecting 'input' or 'output' as second argument ",
//                                                               *currentFilename,
//                                                               #id->getLine(),
//                                                               #id->getColumn());
//      }
//    }
//    (
//     COMMA!
//     (
//      id2:IDENTIFIER!
//      {
//        setCurrentFilename(#id2);
//        if (!wasDot) {
//          RefString msg = _RS("command 'set_prefix()' : Unexpected token '");
//          msg->append( #id2->getText());
//          msg->append( "' ");
//          throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                               *currentFilename,
//                                                               #id2->getLine(),
//                                                               #id2->getColumn());
//        }
//        wasDot = FALSE;
//        RefString literalString = _RS(#id2->getText());
//        TLInt literalEnum = getLiteralEnum(literalString);
//        RefCslAST temp;
//        switch (literalEnum) {
//          case K_LITERAL_ALL :
//            temp = #(#[K_ALL, "K_ALL"]);
//            setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//            astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//            if (canBeDot) { canBeDot = FALSE; }
//            break;
//          default :
//            astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(#id2));
//            if (!canBeDot) { canBeDot = TRUE; }
//        }
//      }
//      (
//       dot:DOT!
//       {
//         if (!canBeDot) {
//           throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_prefix()' : Unexpected token Dot '.' ",
//                                                                *currentFilename,
//                                                                dot->getLine(),
//                                                                dot->getColumn());
//         }
//         wasDot = TRUE;
//         dotLine = dot->getLine();
//         dotColumn = dot->getColumn();
//       }
//      )?
//     )*
//     {
//       if (wasDot) {
//         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_prefix()' : Unexpected token Dot '.' ",
//                                                              *currentFilename,
//                                                              dotLine,
//                                                              dotColumn);
//       }
//     }
//    )?
//   )?
//  )
//  )
//   rp:RPAREN!
//  {
//    if (NSSymbolTable::TRF_DECL == currentScopeType) {
//      if (!wasRFSecondArgument) {
//        throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_prefix()' : Expecting 'input' or 'output' as second argument ",
//                                                            *currentFilename,
//                                                            rp->getLine(),
//                                                            rp->getColumn());
//      }
//    }
//  }
//  )
//  ;



//*************************************************************************************************************************************************************************//
//*** set_suffix() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_suffix[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_suffix()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAP_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression

 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     
     throwCommandError(_RS("set_suffix()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

//(
//  (IDENTIFIER)=>
//  (
//   id:IDENTIFIER
//   {
//     setCurrentFilename(#id);
//     RefString literalString = _RS(#id->getText());
//     TLInt literalEnum = getLiteralEnum(literalString);
//     RefCslAST temp;
//     switch (literalEnum) {
//       case K_LITERAL_NO_SUFFIX :
//         temp = #(#[K_NO_SUFFIX, "K_NO_SUFFIX"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_suffix = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_PIPELINE_NAME :
//         temp = #(#[K_PIPELINE_NAME, "K_PIPELINE_NAME"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_suffix = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_PIPESTAGE_NAME :
//         temp = #(#[K_PIPESTAGE_NAME, "K_PIPESTAGE_NAME"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_suffix = #(antlr::RefAST(temp));
//         break;
//       case K_LITERAL_PIPELINE_PIPESTAGE_NAME :
//         temp = #(#[K_PIPELINE_PIPESTAGE_NAME, "K_PIPELINE_PIPESTAGE_NAME"]);
//         setCurrentFilename(temp, #id->getColumn(), #id->getLine());
//         #param_list_set_suffix = #(antlr::RefAST(temp));
//         break;
//       default :
//         RefString msg = _RS("command 'set_suffix()' : Unexpected token '");
//         msg->append( #id->getText());
//         msg->append( "' ");
//         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                              *currentFilename,
//                                                              #id->getLine(),
//                                                              #id->getColumn());
//     }
//   }
//  )
//  |
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_suffix()' : Expecting string as argument ",
//                                                          *currentFilename,
//                                                          lp1->getLine(),
//                                                          lp1->getColumn()); 
//    }
//  }
// )

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_endianess() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_endianess[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:LPAREN!
  
 {//set filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_endianess()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

    setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

    callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression!

 {//exp should be endianess type literal
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {
     
     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {

         case K_LITERAL_LITTLE_ENDIAN :
           temp = #(#[K_LITTLE_ENDIAN, "K_LITTLE_ENDIAN"]);
           break;
         case K_LITERAL_BIG_ENDIAN :
           temp = #(#[K_BIG_ENDIAN, "K_BIG_ENDIAN"]);
           break;
         default :
           error = TRUE;
       }
       if (!error) {

         setCurrentFilename(temp, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { error = TRUE; }
   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {

     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) {
     RefString msg = _RS("Expecting endianess type, found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     throwCommandError(_RS("set_endianess()"), msg, #exp->getLine(), #exp->getColumn());
   }
 }
  
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** auto_gen_memory_map() command ***//
//*************************************************************************************************************************************************************************//
param_list_auto_gen_memory_map[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set current filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("auto_gen_memory_map()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAP_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_to_memory_map() command ***//
//*************************************************************************************************************************************************************************//
param_list_add_to_memory_map[NSCSLOm::RefTVec_RefString scopeId]

{
  RefCslAST exp  ;
  RefCslAST exp0 ;
  RefCslAST exp2 ;
  RefCslAST exp3 ;
  TBool error    = FALSE;
}
:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add_to_memory_map()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TRF_DECL
     | NSSymbolTable::TMEM_DECL; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIFO_DECL,
                                                           NSSymbolTable::TUNIT_DECL));

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TRF_DECL,
                                                           NSSymbolTable::TUNIT_DECL));

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TREG_DECL,
                                                           NSSymbolTable::TUNIT_DECL));

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEM_DECL,
                                                           NSSymbolTable::TUNIT_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  (  exp:expression! { exp = returnAST; } ( col:COLON!  exp0:expression! { exp0 = returnAST; } )? 
     ( {#col == ANTLR_USE_NAMESPACE(antlr)nullAST}? COMMA!  exp2:expression!  { exp2 = returnAST; }  ( COMMA! exp3:expression! { exp3 = returnAST; } )?  )?  )?

 {//checks
   RefCslAST accRight;
   RefCslAST group   ;
   RefCslAST address ;

   if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp3) {

     accRight = exp3;
     group    = exp2;
     address  = exp;
   }
   else if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp2) {
     
     accRight = exp2;
     group    = exp;
   }
   else if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {
   
     address = exp;
   }

   //address_range
   if (ANTLR_USE_NAMESPACE(antlr)nullAST != address) {

     if (STRING == address->getFirstChild()->getType()
         || EXPR_PRIMARY_IDENTIFIER == address->getFirstChild()->getType()
         || FUNCTION_CALL_RET_ID == address->getFirstChild()->getType()) {

       RefString msg = _RS("Expecting numeric expression. Found '");
       msg->append( address->getFirstChild()->getFirstChild()->getText());
       msg->append( "' ");
       throwCommandError(_RS("add_to_memory_map()"), msg, address->getLine(), address->getColumn());
     }
     else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(address)); }

     //the second expression of the range
     if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp0) {

       if (STRING == exp0->getFirstChild()->getType()
           || EXPR_PRIMARY_IDENTIFIER == exp0->getFirstChild()->getType()
           || FUNCTION_CALL_RET_ID == exp0->getFirstChild()->getType()) {

         RefString msg = _RS("Expecting numeric expression. Found '");
         msg->append( exp0->getFirstChild()->getFirstChild()->getText());
         msg->append( "' ");
         throwCommandError(_RS("add_to_memory_map()"), msg, exp0->getLine(), exp0->getColumn());
       }
       else { 
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(#col)); 
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(exp0)); 
       }
     }  
     
   }

   if (ANTLR_USE_NAMESPACE(antlr)nullAST != accRight) {

     //group
     if (EXPR_PRIMARY_IDENTIFIER != group->getFirstChild()->getType()
         && FUNCTION_CALL_RET_ID != group->getFirstChild()->getType()) {

       RefString msg = _RS("Expecting identifier. Found '");
       msg->append( group->getFirstChild()->getFirstChild()->getText());
       msg->append( "' ");
       throwCommandError(_RS("add_to_memory_map()"), msg, group->getLine(), group->getColumn());
     }
     else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(group)); }

     //access right literal
     if (EXPR_PRIMARY_IDENTIFIER == accRight->getFirstChild()->getType()) {

       if (ANTLR_USE_NAMESPACE(antlr)nullAST == accRight->getFirstChild()->getFirstChild()->getFirstChild()
           && ANTLR_USE_NAMESPACE(antlr)nullAST == accRight->getFirstChild()->getFirstChild()->getNextSibling()) {

         RefString literalString = _RS(accRight->getFirstChild()->getFirstChild()->getText());
         TLInt literalEnum = getLiteralEnum(literalString);
         RefCslAST temp;
         switch (literalEnum) {

           case K_LITERAL_ACCESS_NONE :
             temp = #(#[K_ACCESS_RIGHT_NONE, "K_ACCESS_RIGHT_NONE"]);
             break;
           case K_LITERAL_ACCESS_READ :
             temp = #(#[K_ACCESS_RIGHT_READ, "K_ACCESS_RIGHT_READ"]);
             break;
           case K_LITERAL_ACCESS_WRITE :
             temp = #(#[K_ACCESS_RIGHT_WRITE, "K_ACCESS_RIGHT_WRITE"]);
             break;
           case K_LITERAL_ACCESS_READ_WRITE :
             temp = #(#[K_ACCESS_RIGHT_READ_WRITE, "K_ACCESS_RIGHT_READ_WRITE"]);
             break;
           default :
             error = TRUE;
         }
         if (!error) {

           setCurrentFilename(temp, accRight->getColumn(), accRight->getLine());
           astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
         }
       }
       else { error = TRUE; }
 
     }
     else if (FUNCTION_CALL_RET_ID == accRight->getFirstChild()->getType()) { 

       astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(accRight));
     }
     else { error = TRUE; }
   }

   if (error) {

     RefString msg = _RS("Expecting 'access_none', 'access_read', 'access_write' or 'access_read_write'. Found '");
     msg->append( accRight->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("add_to_memory_map()"), msg, accRight->getLine(), accRight->getColumn());
   }

 }
//  ( {!wasGroup}
//  com:COMMA!
//  exp2:expression!
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp2->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp2->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_to_memory_map()' : Expecting identifier as second argument ",
//                                                           *currentFilename,
//                                                           com->getLine(),
//                                                           com->getColumn());
//    }
//     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
//     hasGroup = TRUE;
//  }
// )?
// (
//  {hasGroup}?
//  com3:COMMA!
//  id2:IDENTIFIER!
//  {
//    setCurrentFilename(#id2);
//    RefString literalString = _RS(#id2->getText());
//    TLInt literalEnum = getLiteralEnum(literalString);
//    RefCslAST temp;
//    switch (literalEnum) {
//      case K_LITERAL_ACCESS_NONE :
//        temp = #(#[K_ACCESS_RIGHT_NONE, "K_ACCESS_RIGHT_NONE"]);
//        setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//        break;
//      case K_LITERAL_ACCESS_READ :
//        temp = #(#[K_ACCESS_RIGHT_READ, "K_ACCESS_RIGHT_READ"]);
//        setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//        break;
//      case K_LITERAL_ACCESS_WRITE :
//        temp = #(#[K_ACCESS_RIGHT_WRITE, "K_ACCESS_RIGHT_WRITE"]);
//        setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//        break;
//      case K_LITERAL_ACCESS_READ_WRITE :
//        temp = #(#[K_ACCESS_RIGHT_READ_WRITE, "K_ACCESS_RIGHT_READ_WRITE"]);
//        setCurrentFilename(temp, #id2->getColumn(), #id2->getLine());
//        astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
//        break;
//      default :
//        RefString msg = _RS("command 'add_to_memory_map()' : Expecting 'access_none', 'access_read', 'access_write' or 'access_read_write' ");
//        ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                       *currentFilename,
//                                                       #id2->getLine(),
//                                                       #id2->getColumn());
//    }
//    hasAccess = TRUE;
//  }
// )?
// {
//   if ((!hasGroup && hasAccess) || (hasGroup && !hasAccess)) {
//     throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_to_memory_map()' : Command arguments should be either both group and access right or none of them ",
//                                                          *currentFilename,
//                                                          #ln1->getLine(),
//                                                          #ln1->getColumn());
//   }
// }
   
 RPAREN!
)
;


//param_list_set_instance_name[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp:LPAREN!
//  {
//    RefString str = _RS("set_instance_name()");
//    TInt mask = NSSymbolTable::TTB_DECL | NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_instance_name()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp->getLine(),
//                                                           lp->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** set_mem_instance_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_mem_instance_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_mem_instance_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL ; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_mem_instance_name()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_reset_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_reset_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_reset_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp in only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_reset_name()"), _RS("Expecting string as argument "), lp->getLine(), lp->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_clock_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_clock_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_clock_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_clock_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_rd_clock_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_rd_clock_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {
   RefString command = _RS("set_rd_clock_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_rd_clock_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_wr_clock_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_wr_clock_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_wr_clock_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_wr_clock_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_push_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_push_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_push_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_push_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_pop_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_pop_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_pop_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_pop_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_full_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_full_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_full_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_full_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_empty_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_empty_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_empty_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_empty_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
    }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_wr_data_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_wr_data_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_wr_data_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_wr_data_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_rd_data_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_rd_data_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_rd_data_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_rd_data_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_valid_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_valid_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_valid_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
  
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_valid_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn()); 
    }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_wr_addr_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_wr_addr_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_wr_addr_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_wr_addr_name()"), _RS("Expecting string as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_rd_addr_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_rd_addr_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_rd_addr_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression

 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_rd_addr_name()"), _RS("Expecting string as first argument "), #exp->getLine(), #exp->getColumn());
    }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_wr_en_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_wr_en_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_wr_en_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_wr_en_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
    }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_rd_en_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_rd_en_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_rd_en_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 

//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_rd_en_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
    }
 }

 RPAREN!
)
;


//param_list_set_method[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:LPAREN!
//  {
//    RefString str = _RS("set_method()");
//    TInt mask = NSSymbolTable::TLIST_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//  exp:expression
//  RPAREN!
//  ;


//param_list_set_pipestage[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:LPAREN!
//  {
//    RefString str = _RS("set_pipestage()");
//    TInt mask = NSSymbolTable::TSIGNAL_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//  exp:expression
//  {      
//    if (UNSIGNED_NUMBER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_pipestage()' : Expecting numeric expression as first argument ",
//                                                           *currentFilename,
//                                                           ln1->getLine(),
//                                                           ln1->getColumn()); 
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** set_access_rights() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_access_rights[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_access_rights()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
                                                           NSSymbolTable::TMEMMAPP_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 } 

  exp:expression!
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_access_rights()"), _RS("Expecting numeric expression as first argument "), #exp->getLine(), #exp->getColumn()); 
   }
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
 }

  ( col:COLON!  exp2:expression!
  
  {//exp2 is only allowed to be numeric
    if (STRING == #exp2->getFirstChild()->getType()) {
      throwCommandError(_RS("set_access_rights()"), _RS("Expecting numeric expression as second expression of first argument "), #exp2->getLine(), #exp2->getColumn());
    }
    astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(#col));
    astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST)); 
  }

  )?
  COMMA!  exp3:expression!
  
 {//exp3 is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp3->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp3->getFirstChild()->getType()) {
     throwCommandError(_RS("set_access_rights()"), _RS("Expecting identifier as second argument "),#exp3->getLine(), #exp3->getColumn());
   }
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
 }

  COMMA!  exp4:expression!

 {//exp4 is only allowed to be access right
   if (EXPR_PRIMARY_IDENTIFIER == #exp4->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp4->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp4->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp4->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_ACCESS_NONE :
           temp = #(#[K_ACCESS_RIGHT_NONE, "K_ACCESS_RIGHT_NONE"]);
           break;
         case K_LITERAL_ACCESS_READ :
           temp = #(#[K_ACCESS_RIGHT_READ, "K_ACCESS_RIGHT_READ"]);
           break;
         case K_LITERAL_ACCESS_WRITE :
           temp = #(#[K_ACCESS_RIGHT_WRITE, "K_ACCESS_RIGHT_WRITE"]);
           break;
         case K_LITERAL_ACCESS_READ_WRITE :
           temp = #(#[K_ACCESS_RIGHT_READ_WRITE, "K_ACCESS_RIGHT_READ_WRITE"]);
           break;
         default :
           error = TRUE;
       }
       if (!error) {
         setCurrentFilename(temp, #exp4->getColumn(), #exp4->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }

     }
     else { error = TRUE; }

   }
   else if (FUNCTION_CALL_RET_ID == #exp4->getFirstChild()->getType()) {
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) {
     RefString msg = _RS("Expecting access right, found '");
     msg->append( #exp4->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("set_access_rights"), msg, #exp4->getLine(),  #exp4->getColumn());
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_access_rights_enum() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_access_rights_enum[NSCSLOm::RefTVec_RefString scopeId]
:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_access_rights_enum()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 

//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression
 
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_access_rights_enum()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
  
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_data_word_width() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_data_word_width[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   RefString command = _RS("set_data_word_width()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL | NSSymbolTable::TMEMMAP_DECL;

//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression
 
 {//exp is only allowed to be numeric 
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_data_word_width()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_symbol_max_length() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_symbol_max_length[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_symbol_max_length()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 

//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_symbol_max_length()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_top_unit() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_top_unit[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_top_unit()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAP_DECL; 

//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression
  
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_top_unit()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add() command ***//
//*************************************************************************************************************************************************************************//
param_list_add[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
                                                           NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add()"), _RS("Expecting identifier as first argument "), #exp->getLine(), #exp->getColumn()); 
   }
 }
  
  ( COMMA!  exp2:expression
    
  {//exp2 is only allowed to be string
    if (STRING != #exp2->getFirstChild()->getType()
        && FUNCTION_CALL_RET_EXPR != #exp2->getFirstChild()->getType()) {
      throwCommandError(_RS("add()"), _RS("Expecting string as second argument "), #exp2->getLine(), #exp2->getColumn()); 
    }
  }

    ( COMMA!  exp3:expression
     
    {//exp3 is only allowed to be numeric
      if (STRING == #exp3->getFirstChild()->getType()) {
        throwCommandError(_RS("add()"), _RS("Expecting numeric expression as third argument "), #exp3->getLine(), #exp2->getColumn()); 
      }
    }
    )?
  )?
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_address_range() command ***//
//*************************************************************************************************************************************************************************//
param_list_add_address_range[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add_address_range()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
                                                           NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());//should probably add a flag that allows command to be called on upper scope object(if that exists)
 }
 
  exp:expression
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_address_range()"), _RS("Expecting numeric expression as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
  COMMA!  exp2:expression
  
 {//exp2 is only allowed to be numeric
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("add_address_range()"), _RS("Expecting numeric expression as second argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** add_reserved_address_range() command ***//
//*************************************************************************************************************************************************************************//
param_list_add_reserved_address_range[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("add_reserved_address_range()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
                                                           NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("add_reserved_address_range()"), _RS("Expecting numeric expression as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }

  COMMA!   exp2:expression

 {//exp2 is only allowed to be numeric
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("add_reserved_address_range()"), _RS("Expecting numeric expression as second argument "), #exp2->getLine(), #exp2->getColumn());
   }
 }
 
 RPAREN!
)
;


//param_list_add_clock[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("add_clock()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  { 
//    if (#exp->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER 
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_clock()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//;


param_list_add_dut_instance
: LPAREN!
  exp:expression
  { #exp->getType() == EXPR_PRIMARY_IDENTIFIER }?
  COMMA!
  id:IDENTIFIER
  {
    setCurrentFilename(#id);
  }
  RPAREN!
;


//param_list_add_tb_read_event[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("add_tb_read_event()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  { 
//    if (#exp->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_tb_read_event()' : Expecting identifier as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    } 
//  }
//  RPAREN!
//;



//*************************************************************************************************************************************************************************//
//*** set_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAF_DECL; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_set_dut_output_filename[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_dut_output_filename()");
//    TInt mask = NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  { 
//    if (#exp->getFirstChild()->getType() != STRING
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_dut_output_filename()' : Expecting string as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//;



//*************************************************************************************************************************************************************************//
//*** set_radix() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_radix[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
: 

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_radix()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   //    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression!

 {
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temporary;
       switch (literalEnum) {
         case K_LITERAL_BIN :
           temporary = #(#[K_BIN, "K_BIN"]);
           break;
         case K_LITERAL_HEX :
           temporary = #(#[K_HEX, "K_HEX"]);
           break;
         default :
           error = TRUE;
       }
       
       if (!error) {

         setCurrentFilename(temporary, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
       }
     }
     else { error = TRUE; }
   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {

     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }
   
   if (error) {

     throwCommandError(_RS("set_radix()"), _RS("Expecting radix as argument "), #exp->getLine(), #exp->getColumn());
   }

 }
 
 RPAREN!
)
;


//param_list_set_max_error_count[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_max_error_count()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    #exp->getFirstChild()->getType() != STRING
//  }?
//  RPAREN!
//;


//param_list_add_event[NSCSLOm::RefTVec_RefString scopeId]
//{
//  antlr::RefCslAST lastIdentifier = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
//  TBool wasKClk = FALSE;
//  TBool wasError = FALSE;
//  TBool wasDot = TRUE;
//  TBool canBeDot = FALSE;
//}
//  : 
//  lp1:LPAREN!
//  (
//  {
//    RefString str = _RS("add_event()");
//    TInt mask = NSSymbolTable::TVEC_DECL ;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
// (
//  id:IDENTIFIER
//  {
//    setCurrentFilename(#id);
//    if (!wasDot) {
//      RefString msg = _RS("command 'add_event()' : Unexpected token '");
//      msg->append( #id->getText());
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                           *currentFilename,
//                                                           #id->getLine(),
//                                                           #id->getColumn());
//    }
//    wasDot = FALSE;
//    RefString literalString = _RS(#id->getText());
//    TLInt literalEnum = getLiteralEnum(literalString);
//    switch (literalEnum) {
//      case K_LITERAL_CLK :
//        #param_list_add_event = #(#id);
//        if (!wasKClk) { wasKClk = TRUE; canBeDot = FALSE;}
//        else { wasError = TRUE; }
//        break;
//      default :
//        if (lastIdentifier.get()) { lastIdentifier->setNextSibling(#id); lastIdentifier = #id; }
//        else { #param_list_add_event = #(#id); lastIdentifier = #id; }
//        if (!canBeDot) { canBeDot = TRUE; }
//    }
//    if (wasError) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_event()' : Expecting 'clk' or identifier as argument ",
//                                                           *currentFilename,
//                                                           #id->getLine(),
//                                                           #id->getColumn());
//    }
//  }
//  (
//   dot:DOT!
//   {
//     if (!canBeDot) {
//       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_event()' : Unexpected token Dot '.' ",
//                                                            *currentFilename,
//                                                            #id->getLine(),
//                                                            #id->getColumn());
//     }
//     wasDot = TRUE;
//   }
//  )?
//  )*
//  )
//  RPAREN!
//;


//param_list_set_max_num_vectors[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_max_num_vectors()");
//    TInt mask = NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (#exp->getFirstChild()->getType() != STRING
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Expecting string ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//;



//*************************************************************************************************************************************************************************//
//*** set_direction() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_direction[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_direction()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TVEC_DECL; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   //    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression!

 {//exp is only allowed to be 'input' or 'output'
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_INPUT :
           temp = #(#[K_INPUT, "K_INPUT"]);
         break;
         case K_LITERAL_OUTPUT : 
           temp = #(#[K_OUTPUT, "K_OUTPUT"]);
         break;
         default :
           error = TRUE;
       }

       if (!error) {

         setCurrentFilename(temp, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { error = TRUE; }
   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {

     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) {
     throwCommandError(_RS("set_direction()"), _RS("Expecting 'input or 'output' as argument "), #exp->getLine(), #exp->getColumn());
   }
 }
  
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** exclusion_list() command ***//
//*************************************************************************************************************************************************************************//
param_list_exclusion_list[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("exclusion_list()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TVEC_DECL; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   //    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
  
  exp:expression
 
 {//exp is only allowed to be identifier 
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("exclusion_list()"), _RS("Expecting identifier as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
  ( COMMA! exp2:expression

  {//exp2 is only allowed to be identifier
    if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
        && FUNCTION_CALL_RET_ID != #exp2->getFirstChild()->getType()) {
      throwCommandError(_RS("exclusion_list()"), _RS("Expecting identifier as second argument "), #exp2->getLine(), #exp2->getColumn());
    }
  }
  
  )*
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** include_only() command ***//
//*************************************************************************************************************************************************************************//
param_list_include_only[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("include_only()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TVEC_DECL; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   //    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
  }

  exp:expression
  
 {//exp is only allowed to be identifier 
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("include_only()"), _RS("Expecting identifier as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
  ( COMMA! exp2:expression
   
  {//exp2 is only allowed to be identifier 
    if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
        && FUNCTION_CALL_RET_ID != #exp2->getFirstChild()->getType()) {
      throwCommandError(_RS("include_only()"), _RS("Expecting identifier as second argument "), #exp2->getLine(), #exp2->getColumn());
    }
  }
  
  )*
 RPAREN!
)
;


//param_list_set_dut_mem_init[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_dut_mem_init()");
//    TInt mask = NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  ex:expression
//  { 
//    if (#ex->getFirstChild()->getType() != UNSIGNED_NUMBER
//        && FUNCTION_CALL_RET_EXPR != #ex->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_dut_mem_init()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//;


//param_list_add_signal_group[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("add_signal_group()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  ex:expression
//  {
//    if (#ex->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER
//        && #ex->getFirstChild()->getType() != FUNCTION_CALL_RET_ID) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("",
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//;



//*************************************************************************************************************************************************************************//
//*** set_testbench_verilog_filename() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_testbench_verilog_filename[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_testbench_verilog_filename()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TTB_DECL; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   //    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_testbench_verilog_filename()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_set_file_name[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_file_name()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_file_name()' : Expecting string as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** generate_individual_rtl_signals() command ***//
//*************************************************************************************************************************************************************************//
param_list_gen_indiv_rtl_sig[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:
 
( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("generate_individual_rtl_signals()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSIGNALGR_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
                                                           NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression!

 {//exp should be on or off or function call that returns id
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temporary;
       switch (literalEnum) {
         case K_LITERAL_OFF :
           temporary = #(#[K_OFF, "K_OFF"]);
           break;
         case K_LITERAL_ON :
           temporary = #(#[K_ON, "K_ON"]);
           break;
         default :
           error = TRUE;
       }
       if (!error) {
         setCurrentFilename(#temporary, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
       }
     }
     else { error = TRUE; }

   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) {
     RefString msg = _RS("Expecting 'on' or 'off' as argument, found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("generate_individual_rtl_signals()"), msg, #exp->getLine(), #exp->getColumn());
   }

 }
  
 RPAREN!
)
;


//param_list_set_vc_compare_trigger[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_vc_compare_trigger()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_vc_compare_trigger()' : Expecting identifier as argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//;


//param_list_set_vc_id[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  ln1:LPAREN!
//  {
//    RefString str = _RS("set_vc_id()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//  exp:expression
//  {
//    if (UNSIGNED_NUMBER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_vc_id()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }
//  RPAREN!
//;



//*************************************************************************************************************************************************************************//
//*** set_vc_name() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_name[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_name()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression

 {//exp is only allowed to be identifier
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_name()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_vc_header_comment() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_header_comment[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_header_comment()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_header_comment()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_version() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_version[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_version()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be numeric
  if (STRING == #exp->getFirstChild()->getType()) {
    throwCommandError(_RS("set_version()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
  }
}

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_vc_clock() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_clock[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_clock()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression

 {
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_clock()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_vc_reset() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_reset[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_reset()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression

 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_reset()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_vc_stall() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_stall[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_stall()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//expression is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_stall()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_vc_end_generation_trigger() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_end_generation_trigger[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
 
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_end_generation_trigger()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
  
  exp:expression
 
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_end_generation_trigger()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_vc_capture_edge_type() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_capture_edge_type[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_capture_edge_type()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression!

 {
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_RISE :
           temp = #(#[K_RISE, "K_RISE"]);
           break;
         case K_LITERAL_FALL :
           temp = #(#[K_FALL, "K_FALL"]);
           break;
         default :
           error = TRUE;
     }

       if (!error) {
         setCurrentFilename(temp, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { error = TRUE; }
   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {

     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) {
     RefString msg = _RS("Expecting 'rise' or 'fall', found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("set_vc_capture_edge_type()"), msg, #exp->getLine(), #exp->getColumn());
   }
 }
 
 RPAREN!
)
;


//param_list_set_vc_max_number_of_capture_events[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:LPAREN!
//  {
//    RefString str = _RS("set_vc_max_number_of_capture_events()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//  exp:expression
//  {
//    if (UNSIGNED_NUMBER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_vc_max_number_of_capture_events()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** set_vc_max_number_of_mismatches() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_max_number_of_mismatches[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_max_number_of_mismatches()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_max_number_of_mismatches()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_vc_max_number_of_valid_transactions() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_max_number_of_valid_transactions[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_max_number_of_valid_transactions()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_max_number_of_valid_transactions()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
    }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_vc_valid_output_transaction() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_valid_output_transaction[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_valid_output_transaction()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_valid_output_transaction()"), _RS("Expecting identifier as argument "), #exp->getLine(), #exp->getColumn());
    }
  }

 RPAREN!
)
;


//param_list_set_vc_timeout[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:LPAREN!
//  {
//    RefString str = _RS("set_vc_timeout()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//  exp:expression
//  {
//    if (UNSIGNED_NUMBER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_vc_timeout()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** set_vc_output_filename() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_output_filename[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_output_filename()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression

 {//exp is only allowed to be string
   if (STRING != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_output_filename()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_set_vc_max_num_states[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:LPAREN!
//  {
//    RefString str = _RS("set_vc_max_num_states()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//  exp:expression
//  {
//    if (UNSIGNED_NUMBER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_vc_max_num_states()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//param_list_set_vc_max_num_of_transaction_events[NSCSLOm::RefTVec_RefString scopeId]
//  :
//  ln1:LPAREN!
//  {
//    RefString str = _RS("set_vc_max_num_of_transaction_events()");
//    TInt mask = NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
//    commandCheck(str, scopeId, mask, ln1->getLine(), ln1->getColumn());
//  }
//  exp:expression
//  {
//    if (STRING != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
//        && EXPR_HYBRID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_vc_max_num_of_transaction_events()' : Expecting numeric expression as argument ",
//                                                           *currentFilename,
//                                                           ln1->getLine(),
//                                                           ln1->getColumn());
//    }
//  }
//  RPAREN!
//  ;



//*************************************************************************************************************************************************************************//
//*** set_vc_max_cycles() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_vc_max_cycles[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_vc_max_cycles()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_vc_max_cycles()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
    }
 }

 RPAREN!
)
;


//param_list_add_equation[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp:LPAREN!
//  {
//    RefString str = _RS("add_equation()");
//    TInt mask = NSSymbolTable::TEVENT_DECL;
//    commandCheck(str, scopeId, mask, lp->getLine(), lp->getColumn());
//  }
//  expression
//  RPAREN!
//  ;


param_list_simulation_timeout_counter
: LPAREN!
  exp:expression
  RPAREN!
;


param_list_data_generation//[NSCSLOm::RefTVec_RefString scopeId]
  :
  lp1:LPAREN!
  exp:expression
  {
    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Expecting identifier",
                                                           lp1->getFilename(),
                                                           lp1->getLine(),
                                                           lp1->getColumn());
    }
  }
  RPAREN!
  ;


param_list_no_args_command
: 
  LPAREN!
  RPAREN!
;


//param_list_add_reset[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("add_reset()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  ex:expression
//  { 
//    if (#ex->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER
//        && FUNCTION_CALL_RET_ID != #ex->getFirstChild()->getType()
//        && EXPR_HYBRID != #ex->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Expecting identifier",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//;


//param_list_set_filename[NSCSLOm::RefTVec_RefString scopeId]
//{
//  RefString str;
//}
//  : 
//  lp1:LPAREN!
//  {
//    str = _RS("set_generate_waves_filename()");
//    TInt mask = NSSymbolTable::TVEC_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (#exp->getFirstChild()->getType() != STRING) {
//      RefString msg = _RS("command '");
//      msg->append( *str);
//      msg->append( "' : Expecting string as argument ");
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
//                                                           *currentFilename,
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  RPAREN!
//  ;


//A bitrange param can be expressed in four ways:
//1. a numeric expession(32)
//2. afunction call a.get_bitrange()
//3. an id(br, s.br)
//4. a bitrange pure([31:0])
//This rule takes care of the last case. To mark the fact that this is a bitrange and not a range expression(they look exactly the same), a false BITRANGE node is inserted in the AST (*3)
//as root node for the 2 expressions(*1 and *2)
//The 2 connect examples inserted in the end of the comment for the previous rule contained range expressions.
bitrange_pure
: LBRACK!
  exp:expression  //*1
  COLON!
  expression  //*2
  RBRACK!
  { #bitrange_pure = #(#[BITRANGE, "BITRANGE"], #bitrange_pure); 
      setCurrentFilename(#bitrange_pure, #exp->getColumn(), #exp->getLine()); }  //*3
;


param_list_get_interface
{
  RefCslAST temp;
}
: LPAREN!
  (tok1:K_INPUT {temp = #tok1;} | tok2:K_OUTPUT {temp = #tok2;} | tok3:K_INOUT {temp = #tok3;})?
  {
    if (!temp.get()) { setCurrentFilename(temp); }
  }
  RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** set_unit_prefix() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_unit_prefix[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
: 

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_unit_prefix()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary (not allowed)

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
  
  exp:expression!
  
 {//exp should be ifc_only or local_only
   if (FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
       && STRING != #exp->getFirstChild()->getType()){
     throwCommandError(_RS("set_unit_prefix()"), _RS("Expecting string as first argument "), #exp->getLine(), #exp->getColumn());
   }
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
 }
 
  ( COMMA!   exp2:expression!
    
  {
    if (EXPR_PRIMARY_IDENTIFIER == #exp2->getFirstChild()->getType()) {

      if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp2->getFirstChild()->getFirstChild()->getNextSibling()
          && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp2->getFirstChild()->getFirstChild()->getFirstChild()) {

        RefString literalString = _RS(#exp2->getFirstChild()->getFirstChild()->getText());
        TLInt literalEnum = getLiteralEnum(literalString);
        RefCslAST temp;
        switch (literalEnum) {
          case K_LITERAL_IFC_ONLY :
            temp = #(#[K_IFC_ONLY, "K_IFC_ONLY"]);
            break;
          case K_LITERAL_LOCAL_ONLY :
            temp = #(#[K_LOCAL_ONLY, "K_LOCAL_ONLY"]);
            break;
          default :
            error = TRUE;
        }
        if (!error) {
          setCurrentFilename(temp, #exp2->getColumn(), #exp2->getLine());
          astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
        }
      }
      else { error = TRUE; }
    }
    else if (FUNCTION_CALL_RET_ID == #exp2->getFirstChild()->getType()) {
      astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
    }
    else { error = TRUE; }
    
    if (error) {
      RefString msg = _RS("Expecting 'ifc_only' or 'local_only' as second argument, found '");
      msg->append( #exp->getFirstChild()->getFirstChild()->getText());
      msg->append( "' ");
      throwCommandError(_RS("set_unit_prefix()"), msg, #exp->getLine(), #exp->getColumn());
    } 
  }
  
  )?
 RPAREN!
)
;


//b.add_instance(a , a0 ( .m(x), .n(c.x), .o(c.get_interface()), .p(c.get_interface().x) ) );
//Consider the example above. It does more than simply adding an instance to a unit, it also connects several ports in unit b to ports in instance a0 of unit a.
//Port m in instance a0 is connected to port x in unit b.
//Port n in instance a0 is connected to a port x, inside an instance c(of another unit), inside unit b.
//Port o in instance a0 is connected to all the ports in the interface of instance c(of another unit), inside unit b.
//Port p in instance a0 is connected to port x in the interfaceof the instance c(of another unit), inside unit b.
//.m(x), .n(c.x), .o(c.get_interface()), .p(c.get_interface().x) is the formal to actual mapping(this is the exact input that this rule deals with) .
// x is a simple id, c.x is a hid (*1)
// c.get_interface() is a function_call_ret_id(*2)
// c.get_interface().x is an expr_hybrid(*3)
//See the rule for expr_primary_identifier to better understand the concept of expr_hybrid.
param_list_formal_to_actual_mapping
: 
  //.expr_formal(expr_actual)
  f2a:f2a_pair_expr
  (
    COMMA!
    f2a_pair_expr
  )*
  {
    #param_list_formal_to_actual_mapping = #(#[PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING,"PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING"],#param_list_formal_to_actual_mapping);
    setCurrentFilename(#param_list_formal_to_actual_mapping, #f2a->getColumn(), #f2a->getLine());
  }
;

f2a_pair_expr
: DOT! 
  exp:expression
  LPAREN!
  ( expression)?
  RPAREN!
  {
    #f2a_pair_expr = #(#[F2A_PAIR_EXPR, "F2A_PAIR_EXPR"], #f2a_pair_expr);
    setCurrentFilename(#f2a_pair_expr, #exp->getColumn(), #exp->getLine());
  }
;


param_list_add_port_list[NSCSLOm::RefTVec_RefString scopeId]
{
  TBool hasDot = FALSE;
  TBool hasComma = FALSE;
  TBool hasId = FALSE;
  TBool wasAddedToAst = FALSE;
  TBool filenameSet = FALSE;
}
  : 
 
  lp:LPAREN!
    
  {
    //symTree command call options
    RefString               commandName                          = _RS("add_port_list()")                       ;
    TInt                    callAllowedInScopesWithoutObjectMask = 0                                            ;

    RefTMap_EObjType_TInt   callAllowedInScopeOnObjectsMap       = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
    NSSymbolTable::EObjType scope1                               = NSSymbolTable::TIFC_DECL                     ;
    TInt                    mask1                                = NSSymbolTable::TUNIT_DECL                    ;
    callAllowedInScopeOnObjectsMap->insert(std::make_pair(scope1, mask1))                                       ;

    //    NOT NECESSARY!!
    //    RefTMap_EObjType_TInt   callAllowedInScopeOnInstancesMap     = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
    //    NSSymbolTable::EObjType scope2                               = 0                                            ;
    //    TInt                    mask2                                = 0                                            ;
    //    callAllowedInScopeOnInstancesMap->insert(std::make_pair(scope2, mask2))                                     ;

    setCommandCallOptions(commandName, callAllowedInScopesWithoutObjectMask, callAllowedInScopeOnObjectsMap/*, callAllowedInScopeOnInstancesMap*/);

    //symtree command call check
    NSSymbolTable::RefCSymNode currentScope = symTree->getCurrentScope();
    callCommand(commandName, scopeId, currentScope, currentFilename.getFilename(), lp->getLine(), lp->getColumn());
    #param_list_add_port_list = #(#[PARAM_LIST_ADD_PORT_LIST,"PARAM_LIST_ADD_PORT_LIST"]); 
  }
  (
   id:IDENTIFIER!
  {
    setCurrentFilename(#id);
    if (!filenameSet) { setCurrentFilename(#param_list_add_port_list, #id->getColumn(), #id->getLine()); filenameSet = TRUE; }
    if (wasAddedToAst) {
      wasAddedToAst = FALSE;
    }
    if (hasId) {
      RefString msg = _RS("command 'add_port_list()' : Unexpected token '");
      msg->append( #id->getText());
      msg->append( "' ");
      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
                                                           *currentFilename,
                                                           #id->getLine(),
                                                           #id->getColumn());
    }
    hasId = TRUE;
  }
   (
    dot:DOT!
   {
     hasDot = TRUE;
     #param_list_add_port_list->addChild(#id);
     wasAddedToAst = TRUE;
     hasId = FALSE;
   }
    |
    com:COMMA!
   {
     if (hasComma) {
       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_port_list()' : Unexpected token ',' ",
                                                            *currentFilename,
                                                            com->getLine(),
                                                            com->getColumn());
     }
     if (hasDot) {
       throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_port_list()' : First argument should be 'input', 'output' or 'inout' ",
                                                            *currentFilename,
                                                            #id->getLine(),
                                                            #id->getColumn());
     }
     hasComma = TRUE;
     hasId = FALSE;
     RefString literalString = _RS(#id->getText());
     TLInt literalEnum = getLiteralEnum(literalString);
     RefCslAST temp;
     switch (literalEnum) {
       case K_LITERAL_INPUT  :  
         temp = #(#[K_INPUT , "K_INPUT" ]);
         #param_list_add_port_list->addChild(temp); 
         wasAddedToAst = TRUE; 
         break;
       case K_LITERAL_OUTPUT :  
         temp = #(#[K_OUTPUT , "K_OUTPUT" ]);
         #param_list_add_port_list->addChild(temp); 
         wasAddedToAst = TRUE; 
         break;
       case K_LITERAL_INOUT  :  
         temp = #(#[K_INOUT , "K_INOUT" ]);
         #param_list_add_port_list->addChild(temp); 
         wasAddedToAst = TRUE; 
         break;
       default :
         throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_port_list()' : Expecting 'input', 'output' or 'inout' as first argument ",
                                                              *currentFilename,
                                                              #id->getLine(),
                                                              #id->getColumn());
    }
     setCurrentFilename(temp, #id->getColumn(), #id->getLine());
   }
   )?
  {
    if (!wasAddedToAst) {
      #param_list_add_port_list->addChild(#id);
      wasAddedToAst = TRUE;
    }
  }
  )+
  RPAREN
;


//There are three ways of connecting two signals. 
//1. When we want to indicate the specific bits of the first signal that are to be connected (the specific bits of the second signal can be specified or not):     
//    connect(a[3:1],b[5:3]); 
//    connect(a[3:1],b);  //b implicitly has 3 bits
//2. When the bitrange of the first signal is not specified(again, the specific bits of the second signal can be specified or not):
//    a.connect(b[2:1]);      
//    a.connect(b);    //a and b have the same bitrange
//The first case is called global connect(it has no explicit scope), the second case is a local connect. 
//There is one case of connect with no explicit scope, yet not global:
//    csl_signal s(16),t(16);
//    scope s {
//      connect(t);  // equivalent to s.connect(t);
//    }***
//3. The (*1) branch applies to situations like this:
//    a.add_instance(b,b0);
//    a.b0.connect(.m(a.x),.n(a.y)); 
//When adding an instance to a unit, the specific ports that are to be connected can be mentioned directly in the add_instance command(see the example for
//the param_list_add_instance rule) or in the connect command, like in the csl line before.
//That means that port m in instance b0 (of unit b) is connected to port x in unit a and port n in instance b0 (of unit b) is connected to port y in unit a.
//.m(a.x),.n(a.y) is ONE formal to actual mapping(despite of the comma), therefore the local connect rule(local connect takes only one parameter) is not broken.
//The local connect rule is the reason for the (*2) validation semantic predicate: if there is a scope, meaning the connect is local(count>0 see comment for csl_command),
//then there must be only one parameter(has2params = false) and, respectively, if there is no scope,(count = 0), the connect command can take 2 params(global connect)
//or 1 param(see *** example).

//param_list_connect[int count, NSCSLOm::RefTVec_RefString scopeId]
//{
//  bool has2params = false;
//}
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("connect()");
//    TInt mask = /*NSSymbolTable::TISAI_DECL | NSSymbolTable::TFIELD_DECL | NSSymbolTable::TBITRANGE_DECL*/ 0;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("function 'connect()' : Expecting identifier as first argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
//  ( COMMA!
//    expression
//    lp3:COMMA!
//    exp3:expression
//    {
//      if (UNSIGNED_NUMBER != #exp3->getFirstChild()->getType()
//          && FUNCTION_CALL_RET_EXPR != #exp3->getFirstChild()->getType()) {
//        throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("function 'connect()' : Expecting numeric expression as third argument ",
//                                                           lp3->getFilename(),
//                                                           lp3->getLine(),
//                                                           lp3->getColumn());
//      }
//    }   
//  )?
//  RPAREN!
//;


param_list_add_offset
: LPAREN!
  expression 
  RPAREN!
;

param_list_add_dim_offset
: LPAREN!
  expression
  COMMA!
  expression
  RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** set_dim_bitrange() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_dim_bitrange[NSCSLOm::RefTVec_RefString scopeId]

:
 
( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_dim_bitrange()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TMDB_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
  
  exp:expression
  
 {//exp is only allowed to ne numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_bitrange()"), _RS("Expecting numeric expression as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }

  COMMA!  exp2:expression
    
 {//exp2 is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp2->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_bitrange()"), _RS("Expecting identifier as second argument "), #exp2->getLine(), #exp2->getColumn());
   }
 }

 RPAREN!
)
;


param_list_get_dim_bitrange
: LPAREN!
  expression
  RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** set_dim_width() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_dim_width[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {
   setCurrentFilename(#lp);
   RefString command = _RS("set_dim_width()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TMDB_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_width()"), _RS("Expecting numeric expression as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
  COMMA!  exp2:expression                                                             

 {//exp2 is only allowed to be numeric
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_width()"), _RS("Expecting numeric expression as second argument "), #exp2->getLine(), #exp2->getColumn());
   }
 }

 RPAREN!
)
;


param_list_get_dim_width
: LPAREN!
  expression
  RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** set_instance_alteration_bit() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_instance_alteration_bit[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool error = FALSE;
}
:

( lp:LPAREN!

 {
   RefString command = _RS("set_instance_alteration_bit()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL;

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary (not allowed)

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression!

 {
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {

     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temp;
       switch (literalEnum) {
         case K_LITERAL_OFF :
           temp = #(#[K_OFF, "K_OFF"]);
           break;
         case K_LITERAL_ON :
           temp = #(#[K_ON, "K_ON"]);
           break;
         default :
           error = TRUE;
       }
       if (!error) {
         setCurrentFilename(temp, #exp->getLine(), #exp->getColumn());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
       }
     }
     else { error = TRUE; }
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {
     
   }
   else { error = TRUE; }

   if (error) {
     RefString msg = _RS("Expecting 'on' or 'off' as argument, found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("set_instance_alteration_bit()"), msg, #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_bitrange() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_bitrange[NSCSLOm::RefTVec_RefString scopeId]

: 

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_bitrange()");
   
   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIELD_DECL | NSSymbolTable::TISAF_DECL; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); 
   
   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression
  
 {//exp is only allowed to be identifier
   if (EXPR_PRIMARY_IDENTIFIER != #exp->getFirstChild()->getType()
       && FUNCTION_CALL_RET_ID != #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_bitrange()"), _RS("Expecting identifier as argument"), #exp->getLine(), #exp->getColumn());
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_width() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_width[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_width()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TISAF_DECL
     | NSSymbolTable::TFIELD_DECL | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL | NSSymbolTable::TMEM_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_width()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }
  
RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_width() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_depth[NSCSLOm::RefTVec_RefString scopeId]
  : 
  lp1:LPAREN! 
  {
    RefString str = _RS("set_depth()");
    TInt mask = NSSymbolTable::TRF_DECL | NSSymbolTable::TMEM_DECL | NSSymbolTable::TFIFO_DECL;
    //    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
  }
  exp:expression
  {
    if (STRING == #exp->getFirstChild()->getType()
        || FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()
        || EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {
      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command set_depth() : Expecting numeric expression as argument ",
                                                           lp1->getFilename(),
                                                           lp1->getLine(),
                                                           lp1->getColumn());
    }
  }
  RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** create_rtl_module() command ***//
//*************************************************************************************************************************************************************************//
param_list_create_rtl_module[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("create_rtl_module()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary

   //    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

 RPAREN!
)
;


//param_list_set_const_value[NSCSLOm::RefTVec_RefString scopeId]
//: 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_const_value()");
//    TInt mask = NSSymbolTable::TRF_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  tok1:expression
//  {
//   if (#tok1->getFirstChild()->getType() != UNSIGNED_NUMBER
//       && FUNCTION_CALL_RET_EXPR != #tok1->getFirstChild()->getType()) {
//    throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Expecting numeric expression: ",
//                                                         lp1->getFilename(),
//                                                         lp1->getLine(),
//                                                         lp1->getColumn()); 
//   }                                               
//  }
//  RPAREN!
//;


//param_list_set_external[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {     
//    RefString str = _RS("set_external()");
//    TInt mask = NSSymbolTable::TRF_DECL;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  exp:expression
//  {
//    if (UNSIGNED_NUMBER != #exp->getFirstChild()->getType()
//        && FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_external()' : Expecting numeric expression as the first argument ",
//                                                           lp1->getFilename(),
//                                                           lp1->getLine(),
//                                                           lp1->getColumn()); 
//    }
//  }
//  tok:COMMA!
//  ex:expression {
//    if(#ex->getType() != EXPR_PRIMARY_IDENTIFIER
//       && FUNCTION_CALL_RET_ID != #ex->getType()
//       && EXPR_HYBRID != #ex->getType()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'set_external()' : Expecting identifier as the second argument ",
//                                                           tok->getFilename(),
//                                                           tok->getLine(),
//                                                           tok->getColumn());
//    }
//  }
//  RPAREN!
//;


param_list_get_address_width
: LPAREN!

  RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** set_range() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_range[NSCSLOm::RefTVec_RefString scopeId]

: 

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_range()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIELD_DECL | NSSymbolTable::TISAF_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
  
  exp1:expression  COMMA!  exp2:expression

 {//exp1 and exp2 can only be numeric
   if (STRING == #exp1->getFirstChild()->getType()) {
     throwCommandError(_RS("set_range()"), _RS("Expecting numeric expression as first argument "), #exp1->getLine(), #exp1->getColumn());
   }
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("set_range()"), _RS("Expecting numeric expression as second argument "), #exp2->getLine(), #exp2->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_dim_range() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_dim_range[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {
   setCurrentFilename(#lp);
   RefString command = _RS("set_dim_range()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TMDB_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_range()"), _RS("Expecting numeric expression as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
  COMMA!  exp2:expression

 {//exp2 is only allowed to be numeric
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_range()"), _RS("Expecting numeric expression as second argument "), #exp2->getLine(), #exp2->getColumn());
   }
 }

  COMMA!  exp3:expression

  {//exp3 is only allowed to be numeric
   if (STRING == #exp3->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_range()"), _RS("Expecting numeric expression as third argument "), #exp3->getLine(), #exp3->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_offset() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_offset[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_offset()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAF_DECL | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TFIELD_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TBITRANGE_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
                                                         | NSSymbolTable::TFIELD_DECL));

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TISAE_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_offset()"), _RS("Expecting numeric expression as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_dim_offset() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_dim_offset[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_dim_offset()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 ;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TMDB_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
 
 {//exp is only allowed to be numeric 
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_offset()"), _RS("Expecting numeric expression as first argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
  COMMA!  exp2:expression
 
 {//exp2 is only allowed to be numeric
   if (STRING == #exp2->getFirstChild()->getType()) {
     throwCommandError(_RS("set_dim_offset()"), _RS("Expecting numeric expression as second argument "), #exp2->getLine(), #exp2->getColumn());
   }
 }

 RPAREN!
)
;


//param_list_set_number_of_dimensions[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("set_number_of_dimensions()");
//    TInt mask = NSSymbolTable::TSIGNAL_DECL /*| NSSymbolTable::TBITRANGE_DECL*/;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  expression
//  RPAREN!
//;


param_list_get_dim_offset
: LPAREN!
  ex:expression
  { #ex->getFirstChild()->getType() != FUNCTION_CALL_RET_ID
    && #ex->getFirstChild()->getType() != EXPR_HYBRID }?
  RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** set_signal_prefix() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_signal_prefix[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_signal_prefix()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL; 

//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);//not necessary (not allowed)

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
  
  exp:expression
  
 {//exp is only allowed to be string
   if(FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
      && STRING != #exp->getFirstChild()->getType()){
     throwCommandError(_RS("set_signal_prefix()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_signal_prefix_local() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_signal_prefix_local[NSCSLOm::RefTVec_RefString scopeId]

{
  bool isFunctionCall = false;
  bool isEPI = false;
}
: 

( lp:LPAREN!
 
 {//set real filename + column
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_signal_prefix_local()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL; 

//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);//not necessary (not allowed)

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
  exp:expression
  
 {//exp is only allowed to be string
   if(FUNCTION_CALL_RET_EXPR != #exp->getFirstChild()->getType()
      && STRING != #exp->getFirstChild()->getType()){ 
     throwCommandError(_RS("set_prefix_local()"), _RS("Expecting string as argument "), #exp->getLine(), #exp->getColumn());
   }
 }
 
 RPAREN!
)
;


param_list_get_dim_upper_index
: LPAREN!
  ex:expression
  { #ex->getFirstChild()->getType() != FUNCTION_CALL_RET_ID
    && #ex->getFirstChild()->getType() != EXPR_HYBRID }?
  RPAREN!
;



param_list_get_dim_lower_index
: LPAREN!
  ex:expression
  { #ex->getFirstChild()->getType() != FUNCTION_CALL_RET_ID
    && #ex->getFirstChild()->getType() != EXPR_HYBRID }?
  RPAREN!
;



//*************************************************************************************************************************************************************************//
//*** set_type() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_type[NSCSLOm::RefTVec_RefString scopeId]

{
  TBool typeError = FALSE;
  TBool error = FALSE;
}
: 

( lp:LPAREN!

 {//set real filename + line 
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_type()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TISAF_DECL | NSSymbolTable::TISAE_DECL 
     | NSSymbolTable::TMEMMAPP_DECL | NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TREG_DECL;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression!

 {//exp should be one of the following literals
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {
     
     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temporary;
       switch (literalEnum) {
         // **** the commented options are for ver 2.0 ****
         case K_LITERAL_ACTION :
           //         #param_list_set_type = #(#[K_ACTION, "K_ACTION"]);
           error = TRUE;
           break;
         case K_LITERAL_ATOM :
           //         #param_list_set_type = #(#[K_ATOM, "K_ATOM"]);
           error = TRUE;
           break;
         case K_LITERAL_COUNTER :
           temporary = #(#[K_COUNTER, "K_COUNTER"]);
           break;
         case K_LITERAL_REGISTER :
           temporary = #(#[K_REGISTER, "K_REGISTER"]);
           break;
         case K_LITERAL_CTL :
           //         #param_list_set_type = #(#[K_CTL, "K_CTL"]);
           error = TRUE;
           break;
         case K_LITERAL_DFF :
           //         #param_list_set_type = #(#[K_DFF, "K_DFF"]);
           error = TRUE;
           break;
         case K_LITERAL_EVNT :
           //         #param_list_set_type = #(#[K_EVNT, "K_EVNT"]);
           error = TRUE;
           break;
         case K_LITERAL_INT :
           //         #param_list_set_type = #(#[K_INT, "K_INT"]);
           error = TRUE;
           break;
         case K_LITERAL_LFSR  :
           //         #param_list_set_type = #(#[K_LFSR, "K_LFSR"]);
           error = TRUE;
           break;
         case K_LITERAL_SFT :
           //         #param_list_set_type = #(#[K_SFT, "K_SFT"]);
           error = TRUE;
           break;
         case K_LITERAL_SEMA :
           //         #param_list_set_type = #(#[K_SEMA, "K_SEMA"]);
           error = TRUE;
           break;
         case K_LITERAL_STATISTIC :
           //         #param_list_set_type = #(#[K_STATISTIC, "K_STATISTIC"]);
           error = TRUE;
           break;
         case K_LITERAL_STATUS :
           //         #param_list_set_type = #(#[K_STATUS, "K_STATUS"]);
           error = TRUE;
           break;
         case K_LITERAL_PRODUCER :
           //         #param_list_set_type = #(#[K_PRODUCER, "K_PRODUCER"]);
           error = TRUE;
           break;
         case K_LITERAL_CONSUMER :
           //         #param_list_set_type = #(#[K_CONSUMER, "K_CONSUMER"]);
           error = TRUE;
           break;
         case K_LITERAL_REG :
           temporary = #(#[K_REG, "K_REG"]);
           break;
         case K_LITERAL_WIRE :
           temporary = #(#[K_WIRE, "K_WIRE"]);
           break;
         case K_LITERAL_TRI :
           temporary = #(#[K_TRI, "K_TRI"]);
           break;
         case K_LITERAL_TRIAND :
           temporary = #(#[K_TRIAND, "K_TRIAND"]);
           break;
         case K_LITERAL_SUPPLY0 :
           temporary = #(#[K_SUPPLY0, "K_SUPPLY0"]);
           break;
         case K_LITERAL_SUPPLY1 :
           temporary = #(#[K_SUPPLY1, "K_SUPPLY1"]);
           break;
         case K_LITERAL_TRIOR :
           temporary = #(#[K_TRIOR, "K_TRIOR"]);
           break;
         case K_LITERAL_TRI0 :
           temporary = #(#[K_TRI0, "K_TRI0"]);
           break;
         case K_LITERAL_TRI1 :
           temporary = #(#[K_TRI1, "K_TRI1"]);
           break;
         case K_LITERAL_TRIREG :
           temporary = #(#[K_TRIREG, "K_TRIREG"]);
           break;
         case K_LITERAL_WAND :
           temporary = #(#[K_WAND, "K_WAND"]);
           break;
         case K_LITERAL_WOR :
           temporary = #(#[K_WOR, "K_WOR"]);
           break;
         case K_LITERAL_INTEGER :
           temporary = #(#[K_INTEGER, "K_INTEGER"]);
           break;
         case K_LITERAL_TIME :
           temporary = #(#[K_TIME, "K_TIME"]);
           break;
         case K_LITERAL_REAL :
           temporary = #(#[K_REAL, "K_REAL"]);
           break;
         case K_LITERAL_REALTIME :
           temporary = #(#[K_REALTIME, "K_REALTIME"]);
           break;
         case K_LITERAL_HIERARCHICAL :
           temporary = #(#[K_HIERARCHICAL, "K_HIERARCHICAL"]);
           break;
         case K_LITERAL_FLAT :
           temporary = #(#[K_FLAT, "K_FLAT"]);
           break;
         case K_LITERAL_PAGE :
           temporary = #(#[K_PAGE, "K_PAGE"]);
           break;
         case K_LITERAL_VIRTUAL_WITH_BASE_ADDRESS :
           temporary = #(#[K_VIRTUAL_WITH_BASE_ADDRESS, "K_VIRTUAL_WITH_BASE_ADDRESS"]);
           break;
         case K_LITERAL_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS :
           temporary = #(#[K_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS, "K_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS"]);
           break;
         case K_LITERAL_DIAGNOSTIC :
           //         #param_list_set_type = #(#[K_DIAGNOSTIC, "K_DIAGNOSTIC"]);
           error = TRUE;
           break;
         case K_LITERAL_STIM_EXPECT :
           //         #param_list_set_type = #(#[K_STIM_EXPECT, "K_STIM_EXPECT"]);
           error = TRUE;
           break;
         case K_LITERAL_SERIAL_BUS :
           //         #param_list_set_type = #(#[K_SERIAL_BUS, "K_SERIAL_BUS"]);
           error = TRUE;
           break;
         case K_LITERAL_FILE :
           //         #param_list_set_type = #(#[K_FILE, "K_FILE"]);
           error = TRUE;
           break;
         case K_LITERAL_SOCKET :
           //         #param_list_set_type = #(#[K_SOCKET, "K_SOCKET"]);
           error = TRUE;
           break;
         case K_LITERAL_SHARED_OBJ :
           //         #param_list_set_type = #(#[K_SHARED_OBJ, "K_SHARED_OBJ"]);
           error = TRUE;
           break;
         case K_LITERAL_UNDEFINED :
           //         #param_list_set_type = #(#[K_UNDEFINED, "K_UNDEFINED"]);
           error = TRUE;
           break;
         case K_LITERAL_ILLEGAL :
           //         #param_list_set_type = #(#[K_ILLEGAL, "K_ILLEGAL"]);
           error = TRUE;
           break;
         case K_LITERAL_RESERVED :
           temporary = #(#[K_RESERVED, "K_RESERVED"]);
           break;
         case K_LITERAL_OPCODE :
           temporary = #(#[K_OPCODE, "K_OPCODE"]);
           break;
         case K_LITERAL_SUBOPCODE :
           temporary = #(#[K_SUBOPCODE, "K_SUBOPCODE"]);
           break;
         case K_LITERAL_ADDRESS :
           temporary = #(#[K_ADDRESS, "K_ADDRESS"]);
           break;
         case K_LITERAL_SELECTOR :
           temporary = #(#[K_SELECTOR, "K_SELECTOR"]);
           break;
         case K_LITERAL_CONSTANT :
           temporary = #(#[K_CONSTANT, "K_CONSTANT"]);
           break;
         case K_LITERAL_UNUSED :
           temporary = #(#[K_UNUSED, "K_UNUSED"]);
           break;
         case K_LITERAL_BRANCH_ADDRESS :
           //         #param_list_set_type = #(#[K_BRANCH_ADDRESS, "K_BRANCH_ADDRESS"]);
           error = TRUE;
           break;
         case K_LITERAL_BRANCH_SELECT :
           //         #param_list_set_type = #(#[K_BRANCH_SELECT, "K_BRANCH_SELECT"]);
           error = TRUE;
           break;
         case K_LITERAL_INSTR_FORMAT :
           temporary = #(#[K_INSTR_FORMAT, "K_INSTR_FORMAT"]);
           break;
         case K_LITERAL_INSTR :
           temporary = #(#[K_INSTR, "K_INSTR"]);
           break;
         case K_LITERAL_ROOT_FORMAT :
           temporary = #(#[K_ROOT_FORMAT, "K_ROOT_FORMAT"]);
           break;
         case K_LITERAL_VALID_ENUM :
           //         #param_list_set_type = #(#[K_VALID_ENUM, "K_VALID_ENUM"]);
           error = TRUE;
           break;
         case K_LITERAL_DATA_ENUM :
           //         #param_list_set_type = #(#[K_DATA_ENUM, "K_DATA_ENUM"]);
           error = TRUE;
           break;
         case K_LITERAL_CONTROL_ENUM :
           //         #param_list_set_type = #(#[K_CONTROL_ENUM, "K_CONTROL_ENUM"]);
           error = TRUE;
           break;
         case K_LITERAL_OTHER_ENUM :
           //         #param_list_set_type = #(#[K_OTHER_ENUM, "K_OTHER_ENUM"]);
           error = TRUE;
           break;
         case K_LITERAL_COMBINATIONAL :
           temporary = #(#[K_COMBINATIONAL, "K_COMBINATIONAL"]);
           break;
         case K_LITERAL_SEQUENTIAL :
           temporary = #(#[K_SEQUENTIAL, "K_SEQUENTIAL"]);
           break;
         default:
           typeError = TRUE;
       }
       if (error) {
         throwCommandError(_RS("set_type()"), _RS("Unknown type (probably removed from version 1.0) "), #exp->getLine(), #exp->getColumn());
       }
       if (!typeError) {
         setCurrentFilename(temporary, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
       }
     }
     else { typeError = TRUE; }
      
   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { typeError = TRUE; }

   if (typeError) {
     RefString msg = _RS("Expecting type as argument, found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("set_type()"),msg, #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_attr() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_attr[NSCSLOm::RefTVec_RefString scopeId]


{
  TBool error = FALSE;
}
: 

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_attr()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression!

 {
   if (EXPR_PRIMARY_IDENTIFIER == #exp->getFirstChild()->getType()) {
     
     if (ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getNextSibling()
         && ANTLR_USE_NAMESPACE(antlr)nullAST == #exp->getFirstChild()->getFirstChild()->getFirstChild()) {

       RefString literalString = _RS(#exp->getFirstChild()->getFirstChild()->getText());
       TLInt literalEnum = getLiteralEnum(literalString);
       RefCslAST temporary;
       switch (literalEnum) {
         case K_LITERAL_ENABLE :
           temporary = #(#[K_ENABLE, "K_ENABLE"]);
           break;
         case K_LITERAL_STALL :
           temporary = #(#[K_STALL, "K_STALL"]);
           break;
         case K_LITERAL_MUX_SELECT :
           temporary = #(#[K_MUX_SELECT, "K_MUX_SELECT"]);
           break;
         case K_LITERAL_DECODE :
           temporary = #(#[K_DECODE, "K_DECODE"]);
           break;
         case K_LITERAL_CLOCK_SIGNAL :
           temporary = #(#[K_CLOCK_SIGNAL, "K_CLOCK_SIGNAL"]);
           break;
         case K_LITERAL_RESET_SIGNAL :
           temporary = #(#[K_RESET_SIGNAL, "K_RESET_SIGNAL"]);
           break;
         default :
           error = TRUE;
       }
       if (!error) {
         setCurrentFilename(temporary, #exp->getColumn(), #exp->getLine());
         astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
       }

     }
     else { error = TRUE; }

   }
   else if (FUNCTION_CALL_RET_ID == #exp->getFirstChild()->getType()) {
     astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
   }
   else { error = TRUE; }

   if (error) {
     RefString msg = _RS("Expecting attribute as argument, found '");
     msg->append( #exp->getFirstChild()->getFirstChild()->getText());
     msg->append( "' ");
     throwCommandError(_RS("set_attr()"), msg, #exp->getLine(), #exp->getColumn());
   }

 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_unit_id() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_unit_id[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_unit_id()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0; 

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
                                                           NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression

 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_unit_id()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//looks like this command doesn't exist anymore
////*************************************************************************************************************************************************************************//
////*** set_upper_index() command ***//
////*************************************************************************************************************************************************************************//
//param_list_set_upper_index[NSCSLOm::RefTVec_RefString scopeId]
//
//:
//
//( lp:LPAREN!
//
// {//set real filename + line
//   setCurrentFilename(#lp);
//   //command call options
//   RefString command = _RS("set_upper_index()");
//
//   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIELD_DECL; 
//
//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
//
//   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TBITRANGE_DECL,
//                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL));
//
//   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL,
//                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL
//                                                         | NSSymbolTable::TFIELD_DECL));
//
////   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
//
//   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);
//
//   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
// }
//
//  exp:expression
//
// {//exp is only allowed to be numeric
//   if (STRING == #exp->getFirstChild()->getType()) {
//     throwCommandError(_RS("set_upper_index()"), _RS("Expecting numeric expression as argument"), #exp->getLine(), #exp->getColumn());
//   }
// }
//
// RPAREN!
//)
//;



//looks like this command doesn't exist anymore
////*************************************************************************************************************************************************************************//
////*** set_lower_index() command ***//
////*************************************************************************************************************************************************************************//
//param_list_set_lower_index[NSCSLOm::RefTVec_RefString scopeId]
//
//:
//
//( lp:LPAREN!
//
// {//set real filename + line
//   setCurrentFilename(#lp);
//   //command call options
//   RefString command = _RS("set_lower_index()");
//
//   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIELD_DECL; 
//
//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
//
//   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TBITRANGE_DECL,
//                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL));
//
//   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL,
//                                                         NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL
//                                                         | NSSymbolTable::TFIELD_DECL));
//
////   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
//
//   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);
//
//   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
// }
//
//  exp:expression
//
// {//exp is only allowed to be numeric
//   if (STRING == #exp->getFirstChild()->getType()) {
//     throwCommandError(_RS("set_lower_index()"), _RS("Expecting numeric expression as argument"), #exp->getLine(), #exp->getColumn());
//   }
// }
//
// RPAREN!
//)
//;



//*************************************************************************************************************************************************************************//
//*** set_num_rd_ifc() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_num_rd_ifc[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_num_rd_ifc()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression

 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_num_rd_ifc()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** set_num_wr_ifc() command ***//
//*************************************************************************************************************************************************************************//
param_list_set_num_wr_ifc[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!

 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("set_num_wr_ifc()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL; 

   //   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary

   //   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }

  exp:expression

 {//exp is only allowed to be numeric
   if (STRING == #exp->getFirstChild()->getType()) {
     throwCommandError(_RS("set_num_wr_ifc()"), _RS("Expecting numeric expression as argument "), #exp->getLine(), #exp->getColumn());
   }
 }

 RPAREN!
)
;



//param_list_concat[NSCSLOm::RefTVec_RefString scopeId]
//  : 
//  lp1:LPAREN!
//  {
//    RefString str = _RS("concat()");
//    TInt mask = /*NSSymbolTable::TBITRANGE_DECL | NSSymbolTable::TFIELD_DECL*/ 0;
//    commandCheck(str, scopeId, mask, lp1->getLine(), lp1->getColumn());
//  }
//  ( expression | bitrange_pure ) 
//  ( COMMA! 
//    (expression | bitrange_pure)
//  )* 
//  RPAREN!
//;



//*************************************************************************************************************************************************************************//
//*** reverse() command ***//
//*************************************************************************************************************************************************************************//
param_list_reverse[NSCSLOm::RefTVec_RefString scopeId]

:

( lp:LPAREN!
  
 {//set real filename + line
   setCurrentFilename(#lp);
   //command call options
   RefString command = _RS("reverse()");

   TInt                  callAllowedInScopesWithoutObjectMask = 0;

   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
                                                         NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);

   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
                                                           NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));

   setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);

   callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
 }
 
 RPAREN!
)
;





//multi_concatenation
//{
//  RefString str = _RS(0);
//}
//  :
//  LCURLY!
//  {
//    #multi_concatenation = #(#[MULTI_CONCATENATION, "MULTI_CONCATENATION"]);
//  }
//  exp:expression
//  {
//    setCurrentFilename(#multi_concatenation, #exp->getColumn(), #exp->getLine());
//    str = _RS(#exp->getText());
//  }
//  ( 
//   lp1:COMMA!
//   exp2:expression
//  {
//    if (str->c_str() != #exp2->getText()) {
//      throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("All elements of concat must have the same type", 
//                                                           lp1->getFilename(), 
//                                                           lp1->getLine(),
//                                                           lp1->getColumn());
//    }
//  }
// )*
//  RCURLY!
//  ;
  
//concatenation 
//: 
// LCURLY!
// (
//  LPAREN!
//  exp:expression
//  COMMA!
//  expression
//  RPAREN!
// )
// (
//  COMMA!
//  LPAREN!
//  expression
//  COMMA!
//  expression
//  RPAREN!
// )+
//{ #concatenation = #(#[CONCATENATION, "CONCATENATION"], #concatenation); setCurrentFilename(#concatenation, #exp->getColumn(), #exp->getLine()); }
// RCURLY!
//;

//expression_list 
//  : exp:expression 
//    (COMMA! expression)*
//{ #expression_list = #(#[EXPRESSION_LIST, "EXPRESSION_LIST"], #expression_list); setCurrentFilename(#expression_list, #exp->getColumn(), #exp->getLine()); }
//;



//*************************************************************************************************************************************************************************//
//*** range expression rule ***//
//*************************************************************************************************************************************************************************//
range_expression 

: 

( expression
  ( 
   ( col:COLON  { setCurrentFilename(#col); }  expression
     | 
     ppos:PO_POS  { setCurrentFilename(#ppos); }  expression
     | 
     pneg:PO_NEG  { setCurrentFilename(#pneg); }  expression
     | 
     COMMA!  expression
   )
   
   //   { #range_expression = #(#[RANGE_EXPRESSION, "RANGE_EXPRESSION"], #range_expression); }
  
  )?
)
;

//mintypmax_expression 
//  : exp:expression 
//  ( COLON! expression COLON! expression )?
//{ #mintypmax_expression = #(#[MINTYPMAX_EXPRESSION, "MINTYPMAX_EXPRESSION"], #mintypmax_expression); setCurrentFilename(#mintypmax_expression, #exp->getColumn(), #exp->getLine()); }
//;



//*************************************************************************************************************************************************************************//
//*** csl expression rule ***//
//*************************************************************************************************************************************************************************//
expression 

: 

( con:conditional_expr!

 {//add fake vertex to AST for tree walker
   RefCslAST temp =#(#[EXPRESSION, "EXPRESSION"], returnAST);
   setCurrentFilename(temp, #con->getColumn(), #con->getLine());
   astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
 }

)
;



//*************************************************************************************************************************************************************************//
//*** conditional expression rule ***//
//*************************************************************************************************************************************************************************//
conditional_expr //least precedence

:

( logical_or_expr ( qe:QUESTION^ { setCurrentFilename(#qe); } conditional_expr COLON! conditional_expr )? )
;



//*************************************************************************************************************************************************************************//
//*** logical or expression rule ***//
//*************************************************************************************************************************************************************************//
logical_or_expr

:

( logical_and_expr ( lor:LOR^ { setCurrentFilename(#lor); } logical_and_expr )* )
;



//*************************************************************************************************************************************************************************//
//*** logical and expression rule ***//
//*************************************************************************************************************************************************************************//
logical_and_expr

:

( or_expr ( land:LAND^ { setCurrentFilename(#land); } or_expr )* )
;



//*************************************************************************************************************************************************************************//
//*** unary or expression rule ***//
//*************************************************************************************************************************************************************************//
or_expr 

:

( 
 ( 
  o:OR^ { setCurrentFilename(#o); } 
  | 
  nor:NOR^ { setCurrentFilename(#nor); } 
 ) 
 xor_expr
 
 |
 
 xor_expr 
 ( 
  ( 
   or2:OR^ { setCurrentFilename(#or2); } 
   | 
   nor2:NOR^ { setCurrentFilename(#nor2); } 
  ) 
  xor_expr 
 )*
)
;



//*************************************************************************************************************************************************************************//
//*** unary xor expression rule ***//
//*************************************************************************************************************************************************************************//
xor_expr 

:

( 
 ( 
  xr:XOR^ { setCurrentFilename(#xr); } 
  | 
  xnor:XNOR^ { setCurrentFilename(#xnor); } 
 ) 
 and_expr
 
 | 
 
 and_expr 
 ( 
  ( 
   xor2:XOR^ { setCurrentFilename(#xor2); } 
   | 
   xnor2:XNOR^ { setCurrentFilename(#xnor2); } 
  ) 
  and_expr 
 )*
)
;



//*************************************************************************************************************************************************************************//
//*** unary and expression rule ***//
//*************************************************************************************************************************************************************************//
and_expr 

: 

(
 (
  an:AND^ { setCurrentFilename(#an); } 
  | 
  nand:NAND^ { setCurrentFilename(#nand); } 
 ) 
 equality_expr
 
 | 

 equality_expr 
 ( 
  (
   and2:AND^ {setCurrentFilename(#and2);} 
   | 
   nand2:NAND^ {setCurrentFilename(#nand2);}
  ) 
  equality_expr
 )*
)
;



//*************************************************************************************************************************************************************************//
//*** equality expression rule ***//
//*************************************************************************************************************************************************************************//
equality_expr 

: 

( 
 relational_expr
 (
   (
    eq:EQUAL^ { setCurrentFilename(#eq);} 
    | 
    neq:NOT_EQ^ {setCurrentFilename(#neq);} 
    | 
    neqc:NOT_EQ_CASE^ {setCurrentFilename(#neqc);} 
    | 
    eqc:EQ_CASE^ {setCurrentFilename(#eqc);}
   ) 
   relational_expr
  )*
)
;



//*************************************************************************************************************************************************************************//
//*** relational expression rule ***//
//*************************************************************************************************************************************************************************//
relational_expr 

:

(
 shift_expr 
 (
  (
   lt:LT_^ {setCurrentFilename(#lt);} 
   | 
   gt:GT^ {setCurrentFilename(#gt);} 
   | 
   le:LE^ {setCurrentFilename(#le);} 
   | 
   ge:GE^ {setCurrentFilename(#ge);}
  ) 
  shift_expr
 )*
)
;


//*************************************************************************************************************************************************************************//
//*** shift expression rule ***//
//*************************************************************************************************************************************************************************//
shift_expr 

: 
 
(
 additive_expr 
 (
  (
   sl:SL^ {setCurrentFilename(#sl);} 
   | 
   ssl:SSL^ {setCurrentFilename(#ssl);} 
   | 
   sr:SR^ {setCurrentFilename(#sr);} 
   | 
   ssr:SSR^ {setCurrentFilename(#ssr);}
   ) 
  additive_expr
  )*
)
;



//*************************************************************************************************************************************************************************//
//*** additive expression rule ***//
//*************************************************************************************************************************************************************************//
additive_expr 

:

(
 (
  PLUS^ 
  | 
  MINUS^
 ) 
 multiplicative_expr 

 {
   setCurrentFilename(#additive_expr);
   //negative verilog numbers (-2'd123) are not allowed 
   if (SIZED_NUMBER == returnAST->getType()) {

     if (MINUS == #additive_expr->getType()) {

       throwError(_RS("Negative verilog numbers are not allowed"), #additive_expr->getLine(), #additive_expr->getColumn());
     }
   }
 }

 |
 
 multiplicative_expr 
 (
  (
   pl:PLUS^ {setCurrentFilename(#pl);} 
   | 
   min:MINUS^ {setCurrentFilename(#min);}
  ) 
  multiplicative_expr
 )*
)
;



//*************************************************************************************************************************************************************************//
//*** multiplicative expression rule ***//
//*************************************************************************************************************************************************************************//
multiplicative_expr 

: 

(
 pow_expr 
 (
  (
   st:STAR^ {setCurrentFilename(#st);} 
   | 
   div:DIV^ {setCurrentFilename(#div);} 
   | 
   mod:MOD^ {setCurrentFilename(#mod);}
  ) 
  pow_expr
 )*
)
;



//*************************************************************************************************************************************************************************//
//*** power expression rule ***//
//*************************************************************************************************************************************************************************//
pow_expr 

: 

( unary_not
  ( pow:POW^ {setCurrentFilename(#pow);} unary_not )?
)
;

//unary_plus
//  : (pl:PLUS^ {setCurrentFilename(#pl);} )? unary_minus
//;
//
//unary_minus
//  : 
//  (min:MINUS^ {setCurrentFilename(#min);} )? unary_not
//;
//
//unary_and
//: (AND^)? unary_nand
//;
//
//unary_nand
//: (NAND^)? unary_or
//;
//
//unary_or
//: (OR^)? unary_nor
//;
//
//unary_nor
//: (NOR^)? unary_xor
//;
//
//unary_xor
//: (XOR^)? unary_xnor
//;
//
//unary_xnor
//: (XNOR^)? unary_logical_not
//;



//*************************************************************************************************************************************************************************//
//*** unary not expression rule ***//
//*************************************************************************************************************************************************************************//
unary_not //highest precedence

: 

(
 ( 
  nt:NOT^ { setCurrentFilename(#nt); } 
  | 
  lnot:LNOT^ {setCurrentFilename(#lnot);}
 ) 
 unary_expr

 | 
 
 unary_expr
)
;



//*************************************************************************************************************************************************************************//
//*** unary expression rule ***//
//*************************************************************************************************************************************************************************//
unary_expr 

: 

( 
 expr_primary
 | 
 LPAREN!
 expression
 RPAREN!
)
;



//*************************************************************************************************************************************************************************//
//*** primary expression rule ***//
//*************************************************************************************************************************************************************************//
expr_primary 

: 

( 
 number
 |  
 st:STRING {setCurrentFilename(#st);}
 |
 expr_primary_identifier 
)
;



//*************************************************************************************************************************************************************************//
//*** number rule ***//
//*************************************************************************************************************************************************************************//
number

: 

( 
 un:unsigned_number
 ( bn:based_number
  
   {
     string  numText = #un->getText() + #bn->getText();
     #number = #(#[SIZED_NUMBER, numText], #number);
     setCurrentFilename(#number, #un->getLine(), #un->getColumn());
   }

 )?
| 
 based_number
| 
 real_number
)
;



//*************************************************************************************************************************************************************************//
//*** number rule ***//
//*************************************************************************************************************************************************************************//
unsigned_number 

: 

( tok:UNSIGNED_NUMBER
  
 { 
   setCurrentFilename(#tok); 
   TInt MAX_NUMBER_DIGITS = 9;
   if (tok->getText().size() > MAX_NUMBER_DIGITS) {//bz said to use numbers in code

     throwError(_RS("cslc does not support numbers bigger than 999,999,999 for version 1.0"), #tok->getLine(), #tok->getColumn());
   }

   CslToken *vt = static_cast<CslToken*>(tok.get()); #unsigned_number->setNumber(vt->getNumber()); 
 }

)
;



//*************************************************************************************************************************************************************************//
//*** based number rule ***//
//*************************************************************************************************************************************************************************//
based_number 

: 

( tok:BASED_NUMBER

 { 
   setCurrentFilename(#tok); 

   CslToken *vt = static_cast<CslToken*>(tok.get()); #based_number->setNumber(vt->getNumber()); 
 }

)
;



//*************************************************************************************************************************************************************************//
//*** real number rule ***//
//*************************************************************************************************************************************************************************//
real_number 

:

( tok:REAL_NUMBER

 { 
   setCurrentFilename(#tok); 

   throwError(_RS("Real numbers not allowed for version 1.0"), #tok->getLine(), #tok->getColumn());

   CslToken *vt = static_cast<CslToken*>(tok.get()); #real_number->setNumber(vt->getNumber()); 
 }

)
;



//Gabriel:
/*This rule applies for a hid or a function call. We can arrange the possible ways of mixing those 2 toghether in 3 categories:
1. A simple hid :                                        (EXPR_PRIMARY_IDENTIFIER) a.b.c
2. A combination of the two ending with a function call:     (FUNCTION_CALL_RET_*) a.b.get_width()
3. A combination of the two ending with an identifier:               (EXPR_HYBRID) a.b.get_interface().x
wasDot indicates the presence of a point at the end of the scope hierarchy (*7).
wasRange is a flag that shows when we have something like this: a.b[3:0] meaning a RANGE_EXPRESSION (*2).
rightMostIsId flag indicates that the last element in line is an identifier (*1).
returnsExpr flag shows what kind of function is called, is it a function call that returns an expression (*3) or an identifier (*4).
isEPI flag is used to indicate if there is a hid (*0) or a function call or an expression hybrid (*5).
At *6 the rightMostIsId is reseted to indicate the presence of a function call at the end of the scope.
The scope can't end with point (eg: a.b. ) so after *7 it is tested with a semantic predicate.
At *8 the flags are tested and the apropriate node is created according to those 3 categories.
*/

//Alina:
//This rule covers ids(simple or hierarchical), function calls and hybrid expressions(all three concepts will be explained).
//First, take a look at the code section delimited by *group_start and *group_end. For starters, ignore the flags and focus on the expected input.
//Mainly, the expected input is an identifier(followed by a range expr or not) or a function_call( the rule for function call is separated into two rules depending on the return type).
//Notice that the code section you're analyzing ends with a )+ so all the following inputs are legal:
//1. a
//2. a.b.c
//3. a.function_call()
//4. a.b.c.function_call()
//5. a.b.c.function_call1().function_call2()
//6. a.b.function_call1().c.d.function_call2()
//7. a.b.function_call1().c.d.function_call2().e
//Now,let's focus on the flags:
//When the parser reads an id in the input stream it sets the rightMostIsId flag to true(*1). When it reads an expr, the same flag will be set to false(*6).
//Considering the 7 examples of legal input written above, here's what the rightMostIsId flag is set to, after a complete parse:
//1. true, 2. true, 3. false, 4. false, 5. false, 6. false, 7. true
//If an id in the input is followed by a range expr, the wasRange flag is set to true(*2).
//Depending on the return type of the functions in the input, the returnsExpr flag is set to true(*3) or false(*4).
//If,at any time while reading the input, the parser finds a function_call, the isEPI flag is set to false (*5) to show that the current expression is not an expr_primary_identifier
//REMEMBER: an expr_primary_identifier(EPI) can be a simple id or a hierarchical one(no function calls).
//Each identifier or function call in the input can be followed by a dot or not.
//If the dot is present another id or function_call can follow, if not, that marks the end of the input. These 2 situations are handled by the(*7) validation semantic predicate.
//Furthermore,no dot can follow after a range_expression(validation semantic predicate at *group_start).
//If the end of the input condition is met(no dot (*8)), then we can move on to setting the false nodes in the AST:
//If a range_expression was detected in the input, a RANGE_EXPRESSION node is set in the AST(*10) to serve as root for all the children of this rule.
//If the flag isEPI was not set to false at any time during the parser, then no function call was encountered and the exp is an EPI. 
//Therefore,a EXPR_PRIMARY_IDENTIFIER node is set in the AST(*11).
//If the rightMostIsId flag is set to false, than the rightmost item in the input was a function_call. The type of that rightmost function call is reflected by the returnsExpr flag.
//In consequence, a FUNCTION_CALL_RET_EXPR or FUNCTION_CALL_RET_ID node is set in the AST (*12 *13).
//if none of the above is true(no range, no EPI, no rightmost function call) then the rightmost item in the input was an id . 
//That,combined with the fact that the expr is not an EPI leads to the conclusion that the input looked something like example 7.
//The node set in the AST in this case is EXPR_HYBRID(*14).
//Concluding, here's what the root nodes in the AST are for the 7 examples:
//1. 2.             EXPR_PRIMARY_IDENTIFIER
//3. 4. 5. 6.       FUNCTION_CALL_RET_ID or FUNCTION_CALL_RET_EXPR
//7.                EXPR_HYBRID
//Now that the concept of hybrid expression is fully defined, I can explain why signals and bitranges cannot be hybrid expressions as I promised in the param_list_add_signal rule comment.
//A signal can only belong to a unit:
//csl_unit u; scope u { csl_signal s; }        or        csl_unit u; u.add_signal(wire,32,s);
//If a signal could be specified using a hybrid expression, then there should be a function that returns a unit object, but there is no such thing in csl.
//A bitrange can belong to a unit or a signal.
//First case: bitrange is declared inside the scope of a unit: csl_unit u; scope u { csl_bitrange br;}
//            Here bitrange is an object, it can be accesed by specifying its scope  u.br , but u cannot be replaced by a function call as there is none in csl that returns a unit object
//            thus a bitrange cannot be an expr_hybrid.
//Second case: bitrange belongs to a signal    s.set_bitrange(br);
//             Here br is not an object, it's a "feature" of the signal s, therefore s.br is not legal (only s.get_bitrange() can be used in this case).
//             Although a signal does have a scope there are no csl_declarations allowed inside its scope, so this is illegal:
//             csl_signal s; scope s { csl_bitrange br; }
//             Even if, in the future, it will be legal to declare objects inside the scope of a signal(s.br will be allowed) there is no function that returnes a signal object
//             leading to the same conclusion: a bitrange cannot be an expr_hybrid

//*************************************************************************************************************************************************************************//
//*** expression primary identifier rule ***//
//*************************************************************************************************************************************************************************//
expr_primary_identifier

{
  TBool wasDot = FALSE;
  TBool wasRange = FALSE;
  TBool wasHybrid = FALSE;
  TBool wasFC     = FALSE;
  TBool wasFCRI   = FALSE;
  RefCslAST firstTok;
}
:

(
 (
  ( id:IDENTIFIER { setCurrentFilename(#id); firstTok = #id; }
    ( LBRACK! range_expression RBRACK! { wasRange = TRUE; firstTok = returnAST; } )?
 
    |

    ( 
     function_call_ret_id   { wasFCRI = TRUE; firstTok = returnAST; }
     |
     function_call_ret_expr { firstTok = returnAST; }
    )

   { wasFC = TRUE; }

   )
  ( DOT! { wasDot = TRUE; } )?
 )
 ( {wasDot && !wasRange}?  { wasDot = FALSE; }
   ( id2:IDENTIFIER { setCurrentFilename(#id2); }
    ( LBRACK! range_expression RBRACK! { wasRange = TRUE; } )?
 
    |

    ( 
     function_call_ret_id       { if (!wasFCRI) { wasFCRI = TRUE; } }
     |
     function_call_ret_expr     
    )
     
   { if (wasFC) { wasHybrid = TRUE; } else { wasFC = TRUE; } }

   )
  ( DOT! { wasDot = TRUE; } )?
 )*

 {
   if (wasHybrid) {

     #expr_primary_identifier = #(#[EXPR_HYBRID, "EXPR_HYBRID"], #expr_primary_identifier );
   }
   else if (wasRange) {

     #expr_primary_identifier = #(#[RANGE_EXPRESSION, "RANGE_EXPRESSION"], #expr_primary_identifier );
   }
   else if (wasFC) {

     if (wasFCRI) {
       
       #expr_primary_identifier = #(#[FUNCTION_CALL_RET_ID, "FUNCTION_CALL_RET_ID"], #expr_primary_identifier );
     }
     else {

       #expr_primary_identifier = #(#[FUNCTION_CALL_RET_EXPR, "FUNCTION_CALL_RET_EXPR"], #expr_primary_identifier );
     }
   }
   else {

     #expr_primary_identifier = #(#[EXPR_PRIMARY_IDENTIFIER, "EXPR_PRIMARY_IDENTIFIER"], #expr_primary_identifier );
   }
   setCurrentFilename(#expr_primary_identifier, firstTok->getLine(), firstTok->getColumn());
 }

)
;



//*************************************************************************************************************************************************************************//
//*** function call return id rule ***//
//*************************************************************************************************************************************************************************//
function_call_ret_expr

{
  RefCslAST temp;
}
: 

(
 (
  fcre1:K_GET_WIDTH                                                             param_list_no_args_command              {temp = #fcre1; }
  |  fcre2:K_GET_DIM_WIDTH                                                      param_list_get_dim_width                {temp = #fcre2; }
  |  fcre3:K_GET_LOWER_INDEX                                                    param_list_no_args_command              {temp = #fcre3; }
  |  fcre4:K_GET_DIM_LOWER_INDEX                                                param_list_get_dim_lower_index          {temp = #fcre4; }
  |  fcre5:K_GET_UPPER_INDEX                                                    param_list_no_args_command              {temp = #fcre5; }
  |  fcre6:K_GET_DIM_UPPER_INDEX                                                param_list_get_dim_upper_index          {temp = #fcre6; }
  |  fcre7:K_GET_OFFSET                                                         param_list_no_args_command              {temp = #fcre7; }
  |  fcre8:K_GET_DIM_OFFSET                                                     param_list_get_dim_offset               {temp = #fcre8; }
  |  fcre9:K_GET_NUMBER_OF_DIMENSIONS                                           param_list_no_args_command              {temp = #fcre9; }
  | fcre10:K_GET_FILENAME                                                       param_list_no_args_command              {temp = #fcre10;}
  | fcre11:K_GET_NAME                                                           param_list_no_args_command              {temp = #fcre11;}
  | fcre12:K_GET_VC_ID                                                          param_list_no_args_command              {temp = #fcre12;}
  | fcre13:K_GET_VC_MAX_NUM_STATES                                              param_list_no_args_command              {temp = #fcre13;}
  | fcre14:K_GET_MAX_NUM_VECTORS                                                param_list_no_args_command              {temp = #fcre14;}
  | fcre15:K_GET_SIMULATION_TIMEOUT_COUNT                                       param_list_no_args_command              {temp = #fcre15;}
  | fcre16:K_GET_TRANSACTION_TIMEOUT_COUNT                                      param_list_no_args_command              {temp = #fcre16;}
  | fcre17:K_GET_MAX_ERROR_COUNT                                                param_list_no_args_command              {temp = #fcre17;}
  | fcre18:K_GET_SIGNAL_VALUE                                                   param_list_no_args_command              {temp = #fcre18;}
  | fcre19:K_GET_SYMBOL_LENGTH                                                  param_list_no_args_command              {temp = #fcre19;}
  | fcre20:K_GET_DATA_WORD_WIDTH                                                param_list_no_args_command              {temp = #fcre20;}
  | fcre21:K_GET_LOWER_BOUND                                                    param_list_no_args_command              {temp = #fcre21;}
  | fcre22:K_GET_UPPER_BOUND                                                    param_list_no_args_command              {temp = #fcre22;}
  | fcre23:K_GET_ADDR_INCREMENT                                                 param_list_no_args_command              {temp = #fcre23;}
  | fcre24:K_GET_NEXT_ADDRESS                                                   param_list_no_args_command              {temp = #fcre24;}
  | fcre25:K_GET_ALIGNMENT                                                      param_list_no_args_command              {temp = #fcre25;}
  | fcre26:K_GET_ENDIANESS                                                      param_list_no_args_command              {temp = #fcre26;}
  | fcre27:K_GET_NAME_LENGTH                                                    param_list_no_args_command              {temp = #fcre27;}
  | fcre28:K_GET_PREFIX                                                         param_list_no_args_command              {temp = #fcre28;}
  | fcre29:K_GET_SUFFIX                                                         param_list_no_args_command              {temp = #fcre29;}
  | fcre30:K_GET_LOCK_ENABLE_BIT                                                param_list_no_args_command              {temp = #fcre30;}
  | fcre31:K_GET_DEPTH                                                          param_list_no_args_command              {temp = #fcre31;}
  | fcre32:K_GET_ATTRIBUTES                                                     param_list_no_args_command              {temp = #fcre32;}
  | fcre33:K_GET_MNEMONIC                                                       param_list_no_args_command              {temp = #fcre33;}
  | fcre34:K_DATA_GENERATION                                                    param_list_data_generation              {temp = #fcre34;}
  | fcre35:K_GET_VALUE                                                          param_list_no_args_command              {temp = #fcre35;}
  | fcre36:K_GET_VC_NAME                                                        param_list_no_args_command              {temp = #fcre36;}
  | fcre37:K_GET_VC_HEADER_COMMENT                                              param_list_no_args_command              {temp = #fcre37;}
  | fcre38:K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS                                param_list_no_args_command              {temp = #fcre38;}
  | fcre39:K_GET_VC_MAX_NUMBER_OF_MISMATCHES                                    param_list_no_args_command              {temp = #fcre39;}
  | fcre40:K_GET_VC_TIMEOUT                                                     param_list_no_args_command              {temp = #fcre40;}
  | fcre41:K_GET_VC_OUTPUT_FILENAME                                             param_list_no_args_command              {temp = #fcre41;}
  | fcre42:K_GET_VC_CPP_RD_NAME                                                 param_list_no_args_command              {temp = #fcre42;}
  | fcre43:K_GET_VC_CPP_WR_NAME                                                 param_list_no_args_command              {temp = #fcre43;}
  | fcre44:K_GET_RESET_NAME                                                     param_list_no_args_command              {temp = #fcre44;}
  | fcre45:K_GET_CLOCK_NAME                                                     param_list_no_args_command              {temp = #fcre45;}
  | fcre46:K_GET_RD_CLOCK_NAME                                                  param_list_no_args_command              {temp = #fcre46;}
  | fcre47:K_GET_WR_CLOCK_NAME                                                  param_list_no_args_command              {temp = #fcre47;}
  | fcre48:K_GET_PUSH_NAME                                                      param_list_no_args_command              {temp = #fcre48;}
  | fcre49:K_GET_POP_NAME                                                       param_list_no_args_command              {temp = #fcre49;}
  | fcre50:K_GET_FULL_NAME                                                      param_list_no_args_command              {temp = #fcre50;}
  | fcre51:K_GET_EMPTY_NAME                                                     param_list_no_args_command              {temp = #fcre51;}
  | fcre52:K_GET_WR_DATA_NAME                                                   param_list_no_args_command              {temp = #fcre52;}
  | fcre53:K_GET_RD_DATA_NAME                                                   param_list_no_args_command              {temp = #fcre53;}
  | fcre54:K_GET_VALID_NAME                                                     param_list_no_args_command              {temp = #fcre54;}
  | fcre55:K_GET_WR_ADDR_NAME                                                   param_list_no_args_command              {temp = #fcre55;}
  | fcre56:K_GET_RD_ADDR_NAME                                                   param_list_no_args_command              {temp = #fcre56;}
  | fcre57:K_GET_WR_EN_NAME                                                     param_list_no_args_command              {temp = #fcre57;}
  | fcre58:K_GET_RD_EN_NAME                                                     param_list_no_args_command              {temp = #fcre58;}
  | fcre59:K_GET_OUTPUT_FILENAME                                                param_list_no_args_command              {temp = #fcre59;}
  | fcre60:K_GET_MSB                                                            param_list_no_args_command              {temp = #fcre60;}
  | fcre61:K_GET_LSB                                                            param_list_no_args_command              {temp = #fcre61;}
  | fcre62:K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS                            param_list_no_args_command              {temp = #fcre62;}
 )

 { setCurrentFilename(temp);}

)
;



//*************************************************************************************************************************************************************************//
//*** function call return id rule ***//
//*************************************************************************************************************************************************************************//
function_call_ret_id

{
  RefCslAST temp;
}
:

( 
 (
  fcri1:K_GET_TYPE                                                              param_list_no_args_command               {temp = #fcri1; }
  | fcri2:K_GET_INTERFACE                                                       param_list_get_interface                 {temp = #fcri2; }
  | fcri3:K_GET_UNIT_PREFIX                                                     param_list_no_args_command               {temp = #fcri3; }
  | fcri4:K_GET_SIGNAL_PREFIX                                                   param_list_no_args_command               {temp = #fcri4; }
  | fcri5:K_GET_SIGNAL_PREFIX_LOCAL                                             param_list_no_args_command               {temp = #fcri5; }
  | fcri6:K_GET_BITRANGE                                                        param_list_no_args_command               {temp = #fcri6; }
  | fcri7:K_GET_DIM_BITRANGE                                                    param_list_get_dim_bitrange              {temp = #fcri7; }
  | fcri8:K_GET_ATTR                                                            param_list_no_args_command               {temp = #fcri8; }
  | fcri9:K_GET_CELL                                                            param_list_no_args_command               {temp = #fcri9; }
  | fcri10:K_GET_INPUT_FIELD                                                    param_list_no_args_command               {temp = #fcri10;}
  | fcri11:K_GET_OUTPUT_FIELD                                                   param_list_no_args_command               {temp = #fcri11;}
  | fcri12:K_GET_CNT_DIR_SIGNAL                                                 param_list_no_args_command               {temp = #fcri12;}
  | fcri13:K_GET_ENUM                                                           param_list_no_args_command               {temp = #fcri13;}
  | fcri14:K_GET_ENUM_ITEM                                                      param_list_no_args_command               {temp = #fcri14;}
  | fcri15:K_GET_VC_CLOCK                                                       param_list_no_args_command               {temp = #fcri15;}
  | fcri16:K_GET_VC_RESET                                                       param_list_no_args_command               {temp = #fcri16;}
  | fcri17:K_GET_VC_STALL                                                       param_list_no_args_command               {temp = #fcri17;}
  | fcri18:K_GET_VC_COMPARE_TRIGGER                                             param_list_no_args_command               {temp = #fcri18;}
  | fcri19:K_GET_VC_START_GENERATION_TRIGGER                                    param_list_no_args_command               {temp = #fcri19;}
  | fcri20:K_GET_VC_END_GENERATION_TRIGGER                                      param_list_no_args_command               {temp = #fcri20;}
  | fcri21:K_GET_VC_CAPTURE_EDGE_TYPE                                           param_list_no_args_command               {temp = #fcri21;}
  | fcri22:K_GET_VC_MODULE                                                      param_list_no_args_command               {temp = #fcri22;}
  | fcri23:K_GET_RADIX                                                          param_list_no_args_command               {temp = #fcri23;}
 )

 { setCurrentFilename(temp); }

)
;


// End of File



  
  
