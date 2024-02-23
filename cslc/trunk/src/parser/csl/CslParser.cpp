/* $ANTLR 2.7.7 (2006-11-01): "csl.parser.g" -> "CslParser.cpp"$ */
#include "CslParser.hpp"
#include <antlr/NoViableAltException.hpp>
#include <antlr/SemanticException.hpp>
#include <antlr/ASTFactory.hpp>
#line 50 "csl.parser.g"

#define _RS(str) RefString(new string(str))

ANTLR_USING_NAMESPACE(antlr);


#include "../../support/Base.hpp"
#include "../../csl_xml_warn_error/CSLC_Errors.h"
#include "../../csl_xml_warn_error/we_logic.h"
#include "../../support/CommonSupport.h"
#include "../../cslom/CSLOM_Declarations.h"
#include "../../cslc/cslc_Typedef.h"

//*** type declarations ***//
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


//*** mask for all object from symTree
TInt ALL_OBJECTS = MAX_INT;



//*** FILENAME + LINE TRACKING ***/
//************************************************************************//
struct FilenameLineStruct {
private:
RefString                   m_filename                           ;
TInt                        m_lineDifference                     ;
public:
FilenameLineStruct();
void                        setFilename(RefString )              ;
void                        setLine    (TInt, TInt)              ;
RefString                   getFilename()                        ;
TInt                        getLine(TInt)                        ;
TInt                        getRealLine(TInt)                    ;
string                      operator*() { return *m_filename; }  ;
TBool                       wasFilenameSet()                     ;
};

FilenameLineStruct::FilenameLineStruct() : m_filename(), m_lineDifference(0) {}

void FilenameLineStruct::setFilename(RefString filename) {
ASSERT(filename.get()    , "PARSER - null filename" );
ASSERT(!filename->empty(), "PARSER - empty filename");

m_filename = filename;
}

void FilenameLineStruct::setLine(TInt currentLine, TInt actualLine) {
ASSERT(0 <= currentLine && 0 < actualLine , "PARSER - invalid line");

//  if (m_lineDifference != 0) { 
//    DCERR("   REAL LINE: " << currentLine+1);
//    currentLine -= (m_lineDifference + (m_lineDifference > 0 ? (-1) : 1)); 
//    DCERR("    is really REAL LINE: " << currentLine);
//}//current should be the actual line of the file, not 
//a line set with another preprocessor directive

m_lineDifference = actualLine - (currentLine + 1);

}

RefString  FilenameLineStruct::getFilename() {
ASSERT(m_filename.get(), "PARSER - null filename requested");

return m_filename;
}

TInt FilenameLineStruct::getLine(TInt currentLine) {//used for retrieving logical line
ASSERT(0 <= currentLine, "PARSER - invalid line");

return currentLine + m_lineDifference;
}

TInt FilenameLineStruct::getRealLine(TInt actualLine) {//used for retrieving real line
ASSERT(actualLine - m_lineDifference > 0, "PARSER - invalid line");//real line must be >0

return actualLine - m_lineDifference;
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

if (-1 == column) { tag->setColumn(tag->getColumn()); }
else { tag->setColumn(column); }

if (-1 == line) { tag->setLine(currentFilename.getLine(tag->getLine())); }
else { tag->setLine(line); }
}


/*** stringToInt ***/
/******************************************************************************************/
TInt stringToInt(RefString str) {
ASSERT(str.get(), "null string");
ASSERT(str->size(), "0 sized string");
TInt returnVal = -1;
for (TUInt i = 0; i < str->size() ; ++i) {
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
if (NSSymbolTable::TPARAM_DECL & mask) {
if (output->size()) { output->append( "/");} 
output->append( "csl_parameter");
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

/*
* //// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\ \
* //// map that holds the declaration and instantiation options - to see what every part of this type is see setDeclarationAndInstantiationOptions() arguments
*/
RefTMap_EObjType_TPair_TInt_TPair_TInt_TInt declarationAndInstantiationMap = 
RefTMap_EObjType_TPair_TInt_TPair_TInt_TInt(new TMap_EObjType_TPair_TInt_TPair_TInt_TInt);


/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\ \
* //// #****** set the object declaration and instantiation options
* //// (where can it be declared and instantiated) and if predeclaration is allowed 
* //// #*should only be called from csl_*_declaration rules
* //// #*argument names are self explanatory - the mask arguments are bitwise masks of NSSymbolTable::EObjType enums(see src/parser/csl/SymTree.h)
*/
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



/* 
* //// *** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
* ////map that holds the command options - to see what every part of this map is see setCommandCallOptions() arguments
*/
RefTMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt commandCallOptionsMap =
RefTMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt(new TMap_RefString_TPair_TInt_TPair_RefTMap_EObjType_TInt_RefTMap_EObjType_TInt);


/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\ \
* //// #****** set the command call options
* //// (where can it be called and on what objects)
* //// #*should only be called from command rules
* //// #*argument names are self explanatory
* //// #*first two argument types are maps between
* ////   1- enum : which represents the scope the command can be called in (NSSymbolTable::EObjName enum - see src/parser/csl/SymTree.h)
* ////   2- mask : which represents the objects that the command can be called on(bitwise mask of NSSymbolTable::EObjType enums - see src/parser/csl/SymTree.h)
* //// #*the third argument is a mask of scopes for which you can call the command without object
*/
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


/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
* //// #****** test if an object type is allowed to be declared in a certain scope
* //// #*symTree implementation internal function
* //// #*argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
*/
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


/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
* //// #****** test if an object type is allowed to be predeclared in a certain scope
* //// #*symTree implementation internal function
* //// #*argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
*/
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


/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
* //// #****** test if an object type is allowed to be instantiated in a certain scope
* //// #*symTree implementation internal function
* //// 3*argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
*/
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


/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
* //// #****** verify if an object can be declared with a certain type - returns FALSE if another object with same name
* ////       but different type was declared in current (not upper) scope
* //// #*symTree implementation internal function
*/
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


/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
* //// #****** test if a command can be called in a scope without object
* //// #*symTree implementation internal function
* //// #* argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
*/
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



/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
* //// #****** test if a command can be called in a scope on a certain object
* //// #*symTree implementation internal function
* //// 3* argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
*/
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
else { //maybe call allowed on all types of objects in current scope

objectTypeToScopesMaskMapIterator = objectTypeToScopesMaskMap->find(EObjType(ALL_OBJECTS)   );

if (objectTypeToScopesMaskMapEnd != objectTypeToScopesMaskMapIterator) { 

TInt commandCallScopeMask = objectTypeToScopesMaskMapIterator->second;
if (commandCallScopeMask & scopeType) { return TRUE; }
}
}
return FALSE;
}



/* 
* //// #*** ATTENTION! THIS SHOULD NOT BE MODIFIED! SymTree IMPLEMENTATION INTERNALS ! IF YOU DON'T KNOW WHAT YOU ARE DOING DON'T MODIFY *** \\\\
* //// #****** test if a command can be called in a scope on a certain instance
* //// #*symTree implementation internal function
* //// #* argument names are self explanatory (NSSymbolTable::EObjType is enum found in src/parser/csl/SymTree.h)
*/
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
else { //maybe call allowed on all types of instances in current scope

instanceTypeToScopesMaskMapIterator = instanceTypeToScopesMaskMap->find(EObjType(ALL_OBJECTS));

if (instanceTypeToScopesMaskMapEnd != instanceTypeToScopesMaskMapIterator) { 

TInt commandCallScopeMask = instanceTypeToScopesMaskMapIterator->second;
if (commandCallScopeMask & scopeType) { return TRUE; }
}
}
return FALSE;
}



/* 
* //// #****** symTree predeclare object - API
* //// #* argument names are self explanatory
* //// #* NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
*/
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
}
}



/* 
* //// #****** symTree declare object
* //// #* argument names are self explanatory
* //// #* NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
*/
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
}
}


/* 
* //// #****** symTree define object
* //// #* must be called after declareObject() because it does not declare object
* //// #* argument names are self explanatory
* //// #* NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
*/
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
error->append( "' cannot be accepted because an object with name '");
error->append( *objectName                                          );
error->append( "' was already defined in scope "                    );
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
}
}



/* 
* //// #****** symTree declare instance
* //// #* argument names are self explanatory
* //// #* NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
*/
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
}
}
else {
NSSymbolTable::RefCSymNode actualInstanceObject      = symTree->lookup(instanceTypeName);
if (NSSymbolTable::TUSER_DEFINED == actualInstanceObject->getType()) {

RefString error = _RS("Instantiation type '");
error->append( *instanceTypeName);
error->append( "' does not name an instantiable type. Maybe another instance of the type has the type name?");
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
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
throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*error, *fileName, currentFilename.getRealLine(line), column);
}
}



/* 
* //// #****** symTree declare instance
* //// #* argument names are self explanatory
* //// #* NSSymbolTable::RefCsymNode is the type of a symTree node (more info in src/parser/csl/SymTree.h or by using doxygen)
*/
void callCommand(RefString commandName, RefTVec_RefString commandScope, NSSymbolTable::RefCSymNode currentScope, RefString fileName, TInt line, TInt column, 
TBool doNotCheck = FALSE) {
ASSERT(commandName.get() && commandName->size(), "PARSER - command name is null or command name size is 0");
ASSERT(commandScope.get()                      , "PARSER - command scope is null"                         );
ASSERT(currentScope.get()                      , "PARSER - scope is null"                                 );
ASSERT(0 <= line         && 0 <= column        , "PARSER - invalid line or column"                        );

RefString error = _RS();
NSSymbolTable::EObjType currentScopeType = currentScope->getType();

if (!commandScope->size() && !doNotCheck) {
if (!commandCallAllowedInScope(commandName, currentScopeType)) {
error->append( "command '"                     );
error->append( *commandName                    );
error->append( "' : call not allowed in ");//scope '");
if (currentScope->getType() != NSSymbolTable::TDESIGN) {
error->append("scope '");
error->append(*(currentScope->getName()));
error->append( "'");
}
else {
error->append("design scope");
}
}
}
else {
TBool canSkipCheck = FALSE;

if (doNotCheck) { canSkipCheck = TRUE; }

if (doNotCheck) {

NSSymbolTable::RefCSymNode lastFoundScopeNode;

RefTVec_RefString temp = RefTVec_RefString(new TVec_RefString);
for (TUInt i = 0; i < commandScope->size(); ++i) {
temp->clear();
for (TUInt j = 0; j <= i; ++j) {
temp->push_back(commandScope->at(j));
}
if (!(symTree->lookup(*temp)).get()) { break; }
else { lastFoundScopeNode = symTree->lookup(*temp); }
}
if (lastFoundScopeNode.get()) {
NSSymbolTable::EObjType lastFoundScopeNodeType = lastFoundScopeNode->getType();
if (lastFoundScopeNodeType == TUSER_DEFINED) {
NSSymbolTable::RefCSymNode actualNode = lastFoundScopeNode->getUserDefinedType();
lastFoundScopeNodeType = actualNode->getType();
}
if (lastFoundScopeNodeType == TREG_DECL || 
lastFoundScopeNodeType == TRF_DECL  ||
lastFoundScopeNodeType == TFIFO_DECL) {
canSkipCheck = TRUE;
}
}
}

NSSymbolTable::RefCSymNode commandScopeNode;

if (!canSkipCheck) { commandScopeNode = symTree->lookup(*commandScope); }

if (!commandScopeNode.get() && !canSkipCheck) {
error->append( "command '"                                       );
error->append( *commandName                                      );
error->append( "' : command scope '");
RefTVec_RefString temp = RefTVec_RefString(new TVec_RefString);
for (TUInt i = 0; i < commandScope->size(); ++i) {
temp->clear();
for (TUInt j = 0; j <= i; ++j) {
temp->push_back(commandScope->at(j));
}
if (!(symTree->lookup(*temp)).get()) { break; }
}
for (TVec_RefString::iterator it = temp->begin(); it != temp->end(); ++it) {
if (it != temp->begin()) { error->append("."); }
error->append(*(*it));
}
error->append( "' was not found");
}
else {
if (!canSkipCheck) {
NSSymbolTable::EObjType commandScopeNodeType = commandScopeNode->getType();
if (commandScopeNode->isUserDefined()) {
NSSymbolTable::EObjType commandScopeNodeRealType = commandScopeNode->getUserDefinedType()->getType();
if (!commandCallAllowedInScopeOnInstance(commandName, currentScopeType, commandScopeNodeRealType) ) {
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
if (error->empty()) {
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
K_LITERAL_RF_ADDRESS,
K_LITERAL_MEM_ADDRESS,
K_LITERAL_IM,
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
K_LITERAL_MAX_LITERAL_TOKEN,
K_LITERAL_LOAD,
K_LITERAL_RESET_
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
literalToEnumMap->insert(make_pair(_RS("rf_address"                          ), K_LITERAL_RF_ADDRESS                          ));
literalToEnumMap->insert(make_pair(_RS("mem_address"                         ), K_LITERAL_MEM_ADDRESS                         ));
literalToEnumMap->insert(make_pair(_RS("im"                                  ), K_LITERAL_IM                                  ));
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
literalToEnumMap->insert(make_pair(_RS("load"                                ), K_LITERAL_LOAD                                ));
literalToEnumMap->insert(make_pair(_RS("reset_"                              ), K_LITERAL_RESET_                              ));
}

////////// ////*****************************************************************************************************************
//////////
//////////void Parser::reportError(const ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex)
//////////{
////////////    ANTLR_USE_NAMESPACE(std)string err,tname,tnupper;
////////////    ANTLR_USE_NAMESPACE(antlr)MismatchedTokenException *mtex;
////////////    ANTLR_USE_NAMESPACE(antlr)NoViableAltException *naex;
////////////    int i;
////////////    
////////////    if(typeid(ex)==typeid(ANTLR_USE_NAMESPACE(antlr)MismatchedTokenException))
////////////    {
////////////        mtex=(ANTLR_USE_NAMESPACE(antlr)MismatchedTokenException*)&ex;
////////////        
////////////        switch (mtex->mismatchType)
////////////        {
////////////            case TOKEN:
////////////                tname=tokenNames[mtex->expecting];
////////////                err= "expecting " + tname + ", found '" + mtex->tokenText + "'";
////////////            break;
////////////            case NOT_TOKEN:
////////////                tname=tokenNames[mtex->expecting];
////////////                err= "expecting anything but " + tname + "; got it anyway";
////////////            break;
////////////            case RANGE:
////////////                tname=tokenNames[mtex->expecting];
////////////                tnupper=tokenNames[mtex->upper];   
////////////                err= "expecting token in range: " + tname + ".." + tnupper + ", found '" + mtex->tokenText + "'";
////////////            break;
////////////            case NOT_RANGE:
////////////                tname=tokenNames[mtex->expecting];
////////////                tnupper=tokenNames[mtex->upper];   
////////////                err= "expecting token NOT in range: " + tname + ".." + tnupper + ", found '" + mtex->tokenText + "'";
////////////            break;
////////////            case SET:
////////////            case NOT_SET:
////////////                {
////////////                    err= ANTLR_USE_NAMESPACE(std)string("expecting ") + (mtex->mismatchType == NOT_SET ? "NOT " : "") + "one of (";
////////////                    ANTLR_USE_NAMESPACE(std)vector<unsigned int> elems = mtex->set.toArray();
////////////                    for ( unsigned int i = 0; i < elems.size(); i++ )
////////////                    {
////////////                        tname=tokenNames[elems[i]];
////////////                        err += " "+tname;
////////////                    }
////////////                    err += "), found '" + mtex->tokenText + "'";
////////////                }
////////////            break;
////////////        }
////////////    }
////////////    
////////////    if(typeid(ex)==typeid(ANTLR_USE_NAMESPACE(antlr)NoViableAltException))
////////////    {
////////////        naex=(ANTLR_USE_NAMESPACE(antlr)NoViableAltException*)&ex;
////////////        
////////////        if (naex->token)      
////////////        {
////////////            if(naex->token->getType() == ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE) err="unexpected end of file";
////////////            else 
////////////            if(naex->token->getType() == ANTLR_USE_NAMESPACE(antlr)Token::NULL_TREE_LOOKAHEAD ) err="unexpected end of tree";
////////////            else
////////////            err="unexpected token: "+naex->token->getText();
////////////        }
////////////
////////////        // must a tree parser error if token==null
////////////        if (!naex->node) err="unexpected end of subtree";
////////////
////////////    }
////////////    
////////////    printf("generic %d %d %s - ",ex.getLine(),ex.getColumn(),ex.getFilename().c_str());
////////////    printf("%s\n",err.c_str());
////////////    fflush(stdout);
//////////    // original output
//////////  ANTLR_USE_NAMESPACE(std)cerr << "Octav - " << ex.toString().c_str() << ANTLR_USE_NAMESPACE(std)endl;
//////////}



////*****************************************************************************************************************

TInt componentMask = NSCslc::CslcTool::COMP_ALL;

void setComponents(TInt mask) {
//  DCERR("OCTAV - setComponent called - " << mask);
//  NSCslc::ECSLcComponent a;
}

void checkAllowedCompDecl(NSCslc::CslcTool::ECSLcComponent comp, RefString name, TInt line, TInt column) {
if (!(comp & componentMask)) {
RefString err = _RS();
err->append(*name);
err->append(" declaration not allowed because it's component is disabled. To enable it you need another licence.");
throwError(err, line, column);
}
}


void checkAllowedCompCommand(NSCslc::CslcTool::ECSLcComponent comp, RefString name, TInt line, TInt column) {
if (!(comp & componentMask)) {
RefString err = _RS("'");
err->append(*name);
err->append("' command call not allowed because it's component is disabled. To enable it you need another licence.");
throwError(err, line, column);
}
}


#line 1579 "CslParser.cpp"
CslParser::CslParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,k)
{
}

CslParser::CslParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,1)
{
}

CslParser::CslParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,k)
{
}

CslParser::CslParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,1)
{
}

CslParser::CslParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(state,1)
{
}

void CslParser::select_components(
	 TInt mask 
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST select_components_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 1917 "csl.parser.g"
	setComponents(mask);
#line 1615 "CslParser.cpp"
	}
	select_components_AST = antlr::RefCslAST(currentAST.root);
	returnAST = select_components_AST;
}

void CslParser::source_text() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST source_text_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1924 "csl.parser.g"
	
	initializeMap();
	
#line 1629 "CslParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_0.member(LA(1)))) {
				description();
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			else {
				goto _loop5;
			}
			
		}
		_loop5:;
		} // ( ... )*
		match(ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE);
		source_text_AST = antlr::RefCslAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
#line 1935 "csl.parser.g"
		
		args.push_back(intToString(ex.getColumn()));
		args.push_back(ex.getMessage());
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(ex.getLine()));
		cslParserHasErrors = TRUE;
		consume();
		
#line 1657 "CslParser.cpp"
	}
	catch (ANTLRException &ex) {
#line 1942 "csl.parser.g"
		//catch the rest and print them as my errors
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
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(stringToInt(line)));
		cslParserHasErrors = true;
		//  consumeUntil( SEMI );
		consume();
		
#line 1677 "CslParser.cpp"
	}
	returnAST = source_text_AST;
}

void CslParser::description() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST description_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST tok_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1962 "csl.parser.g"
	
	static TBool firstTimeInDescription     = TRUE;
	static TBool wasPreprocessorFilenameSet = FALSE;
	currentFilename.setFilename(_RS(currentParsedFile.top())); //soon the be deprecated
	//  currentFilename.setLine(0,1);
	RefString filename = _RS(currentParsedFile.top());
	
#line 1696 "CslParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_SET_TYPE:
		case K_SET_ATTR:
		case K_SET_UNIT_PREFIX:
		case K_SET_SIGNAL_PREFIX:
		case K_SET_SIGNAL_PREFIX_LOCAL:
		case K_SET_DEPTH:
		case K_SET_ATTRIBUTES:
		case K_SET_WIDTH:
		case K_SET_DIM_WIDTH:
		case K_SET_BITRANGE:
		case K_SET_DIM_BITRANGE:
		case K_SET_RANGE:
		case K_SET_DIM_RANGE:
		case K_SET_OFFSET:
		case K_SET_DIM_OFFSET:
		case K_SET_NUMBER_OF_DIMENSIONS:
		case K_SET_INSTANCE_ALTERATION_BIT:
		case K_SET_TESTBENCH_VERILOG_FILENAME:
		case K_SET_NAME:
		case K_SET_DIRECTION:
		case K_SET_MEM_INSTANCE_NAME:
		case K_SET_VC_OUTPUT_FILENAME:
		case K_SET_RADIX:
		case K_SET_MNEMONIC:
		case K_SET_PHYSICAL_IMPLEMENTATION:
		case K_SET_UNIT_ID:
		case K_SET_VALUE:
		case K_SET_ENUM:
		case K_SET_ENUM_ITEM:
		case K_SET_FIELD:
		case K_SET_POSITION:
		case K_SET_NEXT:
		case K_SET_PREVIOUS:
		case K_SET_FIELD_POSITION:
		case K_SET_TOP_UNIT:
		case K_SET_ADDRESS_INCREMENT:
		case K_SET_NEXT_ADDRESS:
		case K_SET_ACCESS_RIGHTS:
		case K_SET_ACCESS_RIGHTS_ENUM:
		case K_SET_DATA_WORD_WIDTH:
		case K_SET_ALIGNMENT:
		case K_SET_ENDIANESS:
		case K_SET_PREFIX:
		case K_SET_UNIT_NAME:
		case K_SET_SUFFIX:
		case K_SET_SYMBOL_MAX_LENGTH:
		case K_SET_VC_START_GENERATION_TRIGGER:
		case K_SET_VC_MAX_NUMBER_OF_MISMATCHES:
		case K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
		case K_SET_VC_VALID_OUTPUT_TRANSACTION:
		case K_SET_VC_COMPARE_TRIGGER:
		case K_SET_VC_MAX_CYCLES:
		case K_SET_VC_NAME:
		case K_SET_VC_HEADER_COMMENT:
		case K_SET_VERSION:
		case K_SET_VC_CLOCK:
		case K_SET_VC_RESET:
		case K_SET_VC_STALL:
		case K_SET_VC_END_GENERATION_TRIGGER:
		case K_SET_VC_CAPTURE_EDGE_TYPE:
		case K_SET_RESET_NAME:
		case K_SET_CLOCK_NAME:
		case K_SET_RD_CLOCK_NAME:
		case K_SET_WR_CLOCK_NAME:
		case K_SET_PUSH_NAME:
		case K_SET_POP_NAME:
		case K_SET_FULL_NAME:
		case K_SET_EMPTY_NAME:
		case K_SET_WR_DATA_NAME:
		case K_SET_RD_DATA_NAME:
		case K_SET_VALID_NAME:
		case K_SET_WR_ADDR_NAME:
		case K_SET_RD_ADDR_NAME:
		case K_SET_WR_EN_NAME:
		case K_SET_RD_EN_NAME:
		case K_SET_NUM_RD_IFC:
		case K_SET_NUM_WR_IFC:
		case K_SET_CLOCK:
		case K_ADD_PORT_LIST:
		case K_REVERSE:
		case K_OVERRIDE_PARAMETER:
		case K_CREATE_RTL_MODULE:
		case K_DIRECTIVE:
		case K_ADD_LOGIC:
		case K_MERGE:
		case K_EXCLUSION_LIST:
		case K_INCLUDE_ONLY:
		case K_GEN_DECODER:
		case K_ADD_ALLOWED_RANGE:
		case K_ADD_ADDRESS_RANGE:
		case K_ADD_RESERVED_ADDRESS_RANGE:
		case K_ADD:
		case K_AUTO_GEN_MEMORY_MAP:
		case K_ADD_TO_MEMORY_MAP:
		case K_PIPESTAGE_NAMING_CONVENTION:
		case K_INITIALIZE_RANDOM_VALUES:
		case K_INITIALIZE_RANDOM:
		case K_GEN_UNIQUE_RTL_MODULES:
		case K_NO_PREFIX_COMMAND:
		case K_DO_NOT_GEN_RTL:
		case K_DO_NOT_GEN_CPP:
		case K_REGISTER_IOS:
		case K_CONNECT_UNITS:
		case K_CONNECT_BY_PATTERN:
		case K_CONNECT_BY_NAME:
		case ASSIGN:
		case LCURLY:
		case IDENTIFIER:
		{
			csl_command();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			break;
		}
		case K_CSL_UNIT:
		case K_CSL_LIST:
		case K_CSL_INTERFACE:
		case K_CSL_REGISTER_FILE:
		case K_CSL_READ_INTERFACE:
		case K_CSL_WRITE_INTERFACE:
		case K_CSL_REGISTER:
		case K_CSL_PORT:
		case K_CSL_SIGNAL:
		case K_CSL_BITRANGE:
		case K_CSL_SIGNAL_GROUP:
		case K_CSL_TESTBENCH:
		case K_CSL_INCLUDE:
		case K_CSL_ISA_FIELD:
		case K_CSL_ISA_ELEMENT:
		case K_CSL_ENUM:
		case K_CSL_FIELD:
		case K_CSL_FIFO:
		case K_CSL_MEMORY_MAP:
		case K_CSL_MEMORY_MAP_PAGE:
		case K_CSL_STATE_DATA:
		case K_CSL_VECTOR:
		case K_CSL_MEMORY:
		case K_CSL_MULTI_DIM_BITRANGE:
		case K_CSL_PIPELINE:
		case K_CSL_PIPESTAGE:
		case K_CSL_PARAMETER:
		case K_CONST:
		{
			csl_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			break;
		}
		case POUND:
		{
			preprocessor_directive();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 1977 "csl.parser.g"
			wasPreprocessorFilenameSet = TRUE;
#line 1853 "CslParser.cpp"
			break;
		}
		case SEMI:
		{
			tok = LT(1);
			tok_AST = astFactory->create(tok);
			match(SEMI);
			break;
		}
		case BACKTICK:
		case AT:
		case COLON:
		case COMMA:
		case LBRACK:
		case RBRACK:
		case RCURLY:
		case LPAREN:
		case RPAREN:
		case QUESTION:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case TAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case TRIGGER:
		case PPATH:
		case FPATH:
		case STARP:
		case PO_POS:
		case PO_NEG:
		case SUPERSTAR:
		case UNSIGNED_NUMBER:
		case NZ_UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case REAL_NUMBER_EXP:
		case TICK:
		case PSTAR:
		{
			unexpected();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 1982 "csl.parser.g"
		
		if (firstTimeInDescription && !wasPreprocessorFilenameSet) {
		if (!filename->compare(*currentFilename)) {
		DCERR("PARSER - WARNING - Filename is not being set by preprocessor - setting it the old fashion way ");
		//      currentFilename.setFilename(_RS(currentParsedFile.top())); //soon the be deprecated
		//      currentFilename.setLine(-1,0);
		}
		}
		if (firstTimeInDescription) { firstTimeInDescription = FALSE; }
		
#line 1935 "CslParser.cpp"
		description_AST = antlr::RefCslAST(currentAST.root);
	}
	catch (NoViableAltException &noViable) {
#line 1995 "csl.parser.g"
		
		args.push_back(intToString(noViable.getColumn()));
		args.push_back(noViable.getMessage());
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(noViable.getLine()));
		cslParserHasErrors = true;
		//consume();
		
#line 1947 "CslParser.cpp"
	}
	returnAST = description_AST;
}

void CslParser::csl_command() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_command_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST re_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ex_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dot = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dot_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com0 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com0_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com3 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com4 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com5 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com5_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com6 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com6_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com7 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com7_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com10 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com10_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com11 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com11_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com12 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com12_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com13 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com13_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com14 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com14_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com15 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com15_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com16 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com16_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com19 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com19_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com20 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com20_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com21 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com21_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com22 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com22_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com25 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com25_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com28 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com28_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com31 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com31_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com37 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com37_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com39 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com39_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com40 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com40_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com41 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com41_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com45 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com45_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com47 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com47_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com48 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com48_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com49 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com49_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com50 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com50_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com51 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com51_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com52 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com52_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com53 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com53_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com54 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com54_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com55 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com55_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com56 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com56_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com57 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com57_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com58 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com58_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com59 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com59_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com61 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com61_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com62 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com62_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com63 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com63_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com64 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com64_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com65 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com65_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com66 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com66_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com71 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com71_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com72 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com72_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com73 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com73_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com74 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com74_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com75 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com75_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com76 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com76_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com77 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com77_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com78 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com78_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com80 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com80_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com81 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com81_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com89 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com89_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com98 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com98_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com102 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com102_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com107 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com107_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com121 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com121_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com125 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com125_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com126 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com126_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com127 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com127_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com128 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com128_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com129 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com129_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com130 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com130_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com131 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com131_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com132 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com132_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com134 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com134_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com135 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com135_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com136 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com136_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com138 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com138_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com141 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com141_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com142 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com142_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com143 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com143_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com144 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com144_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com145 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com145_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com146 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com146_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com147 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com147_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com148 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com148_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com149 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com149_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com150 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com150_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com151 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com151_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com152 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com152_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com153 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com153_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com154 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com154_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com155 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com155_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com156 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com156_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com157 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com157_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com163 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com163_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com164 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com164_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com165 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com165_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com168 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com168_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com169 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com169_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com170 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com170_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com171 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com171_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com172 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com172_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com173 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com173_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com174 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com174_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com175 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com175_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com176 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com176_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com177 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com177_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com178 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com178_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com179 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com179_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  ass = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST ass_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4398 "csl.parser.g"
	
	TBool hasDot = TRUE;
	TBool hasAssign = FALSE;
	TBool hasId = FALSE;
	TInt count = 0;
	TBool wasConcat = FALSE;
	TInt lastDotColumn = 0;
	TBool wasRangeExpr = FALSE;
	TInt rangeExprLine, rangeExprColumn = 0;
	RefTVec_RefString scopeId = RefTVec_RefString(new TVec_RefString);
	RefCslAST command;
	TBool wasAllowedLhsPartSelectCmd = FALSE;
	
#line 2188 "CslParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LCURLY || LA(1) == IDENTIFIER)) {
				{
				switch ( LA(1)) {
				case IDENTIFIER:
				{
					id = LT(1);
					id_AST = astFactory->create(id);
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
					match(IDENTIFIER);
#line 4498 "csl.parser.g"
					//set real filename + line
					setCurrentFilename(id_AST);
					if (!hasDot) { 
					RefString msg = _RS("Unexpected identifier '");
					msg->append( id_AST->getText());
					msg->append( "'. Expecting command or statement");
					throwError( msg, currentFilename.getRealLine(id_AST->getLine()), id_AST->getColumn());
					}
					++count;
					if (!hasId) { hasId = TRUE; }
					if(wasConcat) {
					RefString msg = _RS("When using concatenation as left hand side of command call, the left hand side is only allowed to be formed of one concatenation statement.");
					throwError( msg, currentFilename.getRealLine(ex_AST->getLine()), ex_AST->getColumn());
					}
					scopeId->push_back(_RS(id_AST->getText()));
					hasDot = FALSE;
					
#line 2220 "CslParser.cpp"
					{
					switch ( LA(1)) {
					case LBRACK:
					{
						match(LBRACK);
						range_expression();
						re_AST = returnAST;
#line 4518 "csl.parser.g"
						
						wasRangeExpr = TRUE; rangeExprLine = re_AST->getLine(); rangeExprColumn = re_AST->getColumn();
						RefCslAST temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(RANGE_EXPRESSION,"RANGE_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(re_AST))));
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
						
#line 2234 "CslParser.cpp"
						match(RBRACK);
						break;
					}
					case K_SET_TYPE:
					case K_SET_ATTR:
					case K_SET_UNIT_PREFIX:
					case K_SET_SIGNAL_PREFIX:
					case K_SET_SIGNAL_PREFIX_LOCAL:
					case K_SET_DEPTH:
					case K_SET_ATTRIBUTES:
					case K_SET_WIDTH:
					case K_SET_DIM_WIDTH:
					case K_SET_BITRANGE:
					case K_SET_DIM_BITRANGE:
					case K_SET_RANGE:
					case K_SET_DIM_RANGE:
					case K_SET_OFFSET:
					case K_SET_DIM_OFFSET:
					case K_SET_NUMBER_OF_DIMENSIONS:
					case K_SET_INSTANCE_ALTERATION_BIT:
					case K_SET_TESTBENCH_VERILOG_FILENAME:
					case K_SET_NAME:
					case K_SET_DIRECTION:
					case K_SET_MEM_INSTANCE_NAME:
					case K_SET_VC_OUTPUT_FILENAME:
					case K_SET_RADIX:
					case K_SET_MNEMONIC:
					case K_SET_PHYSICAL_IMPLEMENTATION:
					case K_SET_UNIT_ID:
					case K_SET_VALUE:
					case K_SET_ENUM:
					case K_SET_ENUM_ITEM:
					case K_SET_FIELD:
					case K_SET_POSITION:
					case K_SET_NEXT:
					case K_SET_PREVIOUS:
					case K_SET_FIELD_POSITION:
					case K_SET_TOP_UNIT:
					case K_SET_ADDRESS_INCREMENT:
					case K_SET_NEXT_ADDRESS:
					case K_SET_ACCESS_RIGHTS:
					case K_SET_ACCESS_RIGHTS_ENUM:
					case K_SET_DATA_WORD_WIDTH:
					case K_SET_ALIGNMENT:
					case K_SET_ENDIANESS:
					case K_SET_PREFIX:
					case K_SET_UNIT_NAME:
					case K_SET_SUFFIX:
					case K_SET_SYMBOL_MAX_LENGTH:
					case K_SET_VC_START_GENERATION_TRIGGER:
					case K_SET_VC_MAX_NUMBER_OF_MISMATCHES:
					case K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
					case K_SET_VC_VALID_OUTPUT_TRANSACTION:
					case K_SET_VC_COMPARE_TRIGGER:
					case K_SET_VC_MAX_CYCLES:
					case K_SET_VC_NAME:
					case K_SET_VC_HEADER_COMMENT:
					case K_SET_VERSION:
					case K_SET_VC_CLOCK:
					case K_SET_VC_RESET:
					case K_SET_VC_STALL:
					case K_SET_VC_END_GENERATION_TRIGGER:
					case K_SET_VC_CAPTURE_EDGE_TYPE:
					case K_SET_RESET_NAME:
					case K_SET_CLOCK_NAME:
					case K_SET_RD_CLOCK_NAME:
					case K_SET_WR_CLOCK_NAME:
					case K_SET_PUSH_NAME:
					case K_SET_POP_NAME:
					case K_SET_FULL_NAME:
					case K_SET_EMPTY_NAME:
					case K_SET_WR_DATA_NAME:
					case K_SET_RD_DATA_NAME:
					case K_SET_VALID_NAME:
					case K_SET_WR_ADDR_NAME:
					case K_SET_RD_ADDR_NAME:
					case K_SET_WR_EN_NAME:
					case K_SET_RD_EN_NAME:
					case K_SET_NUM_RD_IFC:
					case K_SET_NUM_WR_IFC:
					case K_SET_CLOCK:
					case K_ADD_PORT_LIST:
					case K_REVERSE:
					case K_OVERRIDE_PARAMETER:
					case K_CREATE_RTL_MODULE:
					case K_DIRECTIVE:
					case K_ADD_LOGIC:
					case K_MERGE:
					case K_EXCLUSION_LIST:
					case K_INCLUDE_ONLY:
					case K_GEN_DECODER:
					case K_ADD_ALLOWED_RANGE:
					case K_ADD_ADDRESS_RANGE:
					case K_ADD_RESERVED_ADDRESS_RANGE:
					case K_ADD:
					case K_AUTO_GEN_MEMORY_MAP:
					case K_ADD_TO_MEMORY_MAP:
					case K_PIPESTAGE_NAMING_CONVENTION:
					case K_INITIALIZE_RANDOM_VALUES:
					case K_INITIALIZE_RANDOM:
					case K_GEN_UNIQUE_RTL_MODULES:
					case K_NO_PREFIX_COMMAND:
					case K_DO_NOT_GEN_RTL:
					case K_DO_NOT_GEN_CPP:
					case K_REGISTER_IOS:
					case K_CONNECT_UNITS:
					case K_CONNECT_BY_PATTERN:
					case K_CONNECT_BY_NAME:
					case DOT:
					case ASSIGN:
					case LCURLY:
					case IDENTIFIER:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					break;
				}
				case LCURLY:
				{
					concatenation();
					ex_AST = returnAST;
#line 4531 "csl.parser.g"
					
					if (!hasDot) { 
					RefString msg = _RS("Unexpected token '");
					if (ex_AST->getFirstChild()->getFirstChild()->getFirstChild() != 0) {
					msg->append(ex_AST->getFirstChild()->getFirstChild()->getFirstChild()->getText());
					}
					else { msg->append(ex_AST->getFirstChild()->getFirstChild()->getText()); }
					msg->append( "'. Expecting command or statement");
					throwError( msg, currentFilename.getRealLine(ex_AST->getLine()), ex_AST->getColumn());
					}
					
					wasConcat = TRUE; 
					
					++count;
					
					//   if(wasConcat ) {
					if (count > 1) {
					RefString msg = _RS("When using concatenation as left hand side of command call, the left hand side is only allowed to be formed of one concatenation statement.");
					throwError( msg, currentFilename.getRealLine(ex_AST->getLine()), ex_AST->getColumn());
					}
					else if (ex_AST->getType() == K_REPLICATION) {
					RefString msg = _RS("Replication is not allowed to be on the left hand side of any expression.");
					throwError( msg, currentFilename.getRealLine(ex_AST->getLine()), ex_AST->getColumn());
					}
					else {
					
					TBool error = FALSE;
					RefAST tmp = ex_AST->getFirstChild()->getFirstChild();
					
					while (tmp && !error) {
					
					//       DCERR(tmp->getText());
					if (tmp->getType() != EXPR_PRIMARY_IDENTIFIER 
					&& tmp->getType() != RANGE_EXPRESSION) { error = TRUE; }
					
					if (!error) { tmp = tmp->getNextSibling(); }
					}
					
					if (error) { 
					
					RefString msg = _RS("When using concatenation as left hand side of command call, no member of the concatenation is allowed to be number.");
					throwError( msg, currentFilename.getRealLine(ex_AST->getLine()), ex_AST->getColumn());
					}
					}
					//   }
					
					//   DCERR(#ex->getText());
					//   DCERR(#ex->getFirstChild()->getText());
					//   DCERR(#ex->getFirstChild()->getFirstChild()->getText());
					
					
					RefCslAST temp2 = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EXPRESSION,"EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(ex_AST))));
					RefCslAST temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TO_USE_FOR_NONDETERMINISM_IN_WALKER,"NONDETERMINISM_TOKEN")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(temp2))));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
					
					if (!hasId) { hasId = TRUE; }
					hasDot = FALSE;
					
#line 2421 "CslParser.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				{
				switch ( LA(1)) {
				case DOT:
				{
					dot = LT(1);
					dot_AST = astFactory->create(dot);
					match(DOT);
#line 4594 "csl.parser.g"
					if (!hasDot) { hasDot = TRUE; } 
					lastDotColumn = dot_AST->getColumn(); 
					//    if (wasRangeExpr) { 
					//      RefString msg = _RS("When part select is used on the left hand side of a statement, the statement is only allowed to be assignment statement.");
					//      throwError( msg, currentFilename.getRealLine(rangeExprLine), rangeExprColumn);
					//    }
					
#line 2445 "CslParser.cpp"
					break;
				}
				case K_SET_TYPE:
				case K_SET_ATTR:
				case K_SET_UNIT_PREFIX:
				case K_SET_SIGNAL_PREFIX:
				case K_SET_SIGNAL_PREFIX_LOCAL:
				case K_SET_DEPTH:
				case K_SET_ATTRIBUTES:
				case K_SET_WIDTH:
				case K_SET_DIM_WIDTH:
				case K_SET_BITRANGE:
				case K_SET_DIM_BITRANGE:
				case K_SET_RANGE:
				case K_SET_DIM_RANGE:
				case K_SET_OFFSET:
				case K_SET_DIM_OFFSET:
				case K_SET_NUMBER_OF_DIMENSIONS:
				case K_SET_INSTANCE_ALTERATION_BIT:
				case K_SET_TESTBENCH_VERILOG_FILENAME:
				case K_SET_NAME:
				case K_SET_DIRECTION:
				case K_SET_MEM_INSTANCE_NAME:
				case K_SET_VC_OUTPUT_FILENAME:
				case K_SET_RADIX:
				case K_SET_MNEMONIC:
				case K_SET_PHYSICAL_IMPLEMENTATION:
				case K_SET_UNIT_ID:
				case K_SET_VALUE:
				case K_SET_ENUM:
				case K_SET_ENUM_ITEM:
				case K_SET_FIELD:
				case K_SET_POSITION:
				case K_SET_NEXT:
				case K_SET_PREVIOUS:
				case K_SET_FIELD_POSITION:
				case K_SET_TOP_UNIT:
				case K_SET_ADDRESS_INCREMENT:
				case K_SET_NEXT_ADDRESS:
				case K_SET_ACCESS_RIGHTS:
				case K_SET_ACCESS_RIGHTS_ENUM:
				case K_SET_DATA_WORD_WIDTH:
				case K_SET_ALIGNMENT:
				case K_SET_ENDIANESS:
				case K_SET_PREFIX:
				case K_SET_UNIT_NAME:
				case K_SET_SUFFIX:
				case K_SET_SYMBOL_MAX_LENGTH:
				case K_SET_VC_START_GENERATION_TRIGGER:
				case K_SET_VC_MAX_NUMBER_OF_MISMATCHES:
				case K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
				case K_SET_VC_VALID_OUTPUT_TRANSACTION:
				case K_SET_VC_COMPARE_TRIGGER:
				case K_SET_VC_MAX_CYCLES:
				case K_SET_VC_NAME:
				case K_SET_VC_HEADER_COMMENT:
				case K_SET_VERSION:
				case K_SET_VC_CLOCK:
				case K_SET_VC_RESET:
				case K_SET_VC_STALL:
				case K_SET_VC_END_GENERATION_TRIGGER:
				case K_SET_VC_CAPTURE_EDGE_TYPE:
				case K_SET_RESET_NAME:
				case K_SET_CLOCK_NAME:
				case K_SET_RD_CLOCK_NAME:
				case K_SET_WR_CLOCK_NAME:
				case K_SET_PUSH_NAME:
				case K_SET_POP_NAME:
				case K_SET_FULL_NAME:
				case K_SET_EMPTY_NAME:
				case K_SET_WR_DATA_NAME:
				case K_SET_RD_DATA_NAME:
				case K_SET_VALID_NAME:
				case K_SET_WR_ADDR_NAME:
				case K_SET_RD_ADDR_NAME:
				case K_SET_WR_EN_NAME:
				case K_SET_RD_EN_NAME:
				case K_SET_NUM_RD_IFC:
				case K_SET_NUM_WR_IFC:
				case K_SET_CLOCK:
				case K_ADD_PORT_LIST:
				case K_REVERSE:
				case K_OVERRIDE_PARAMETER:
				case K_CREATE_RTL_MODULE:
				case K_DIRECTIVE:
				case K_ADD_LOGIC:
				case K_MERGE:
				case K_EXCLUSION_LIST:
				case K_INCLUDE_ONLY:
				case K_GEN_DECODER:
				case K_ADD_ALLOWED_RANGE:
				case K_ADD_ADDRESS_RANGE:
				case K_ADD_RESERVED_ADDRESS_RANGE:
				case K_ADD:
				case K_AUTO_GEN_MEMORY_MAP:
				case K_ADD_TO_MEMORY_MAP:
				case K_PIPESTAGE_NAMING_CONVENTION:
				case K_INITIALIZE_RANDOM_VALUES:
				case K_INITIALIZE_RANDOM:
				case K_GEN_UNIQUE_RTL_MODULES:
				case K_NO_PREFIX_COMMAND:
				case K_DO_NOT_GEN_RTL:
				case K_DO_NOT_GEN_CPP:
				case K_REGISTER_IOS:
				case K_CONNECT_UNITS:
				case K_CONNECT_BY_PATTERN:
				case K_CONNECT_BY_NAME:
				case ASSIGN:
				case LCURLY:
				case IDENTIFIER:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else {
				goto _loop221;
			}
			
		}
		_loop221:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case K_SET_TYPE:
		case K_SET_ATTR:
		case K_SET_UNIT_PREFIX:
		case K_SET_SIGNAL_PREFIX:
		case K_SET_SIGNAL_PREFIX_LOCAL:
		case K_SET_DEPTH:
		case K_SET_ATTRIBUTES:
		case K_SET_WIDTH:
		case K_SET_DIM_WIDTH:
		case K_SET_BITRANGE:
		case K_SET_DIM_BITRANGE:
		case K_SET_RANGE:
		case K_SET_DIM_RANGE:
		case K_SET_OFFSET:
		case K_SET_DIM_OFFSET:
		case K_SET_NUMBER_OF_DIMENSIONS:
		case K_SET_INSTANCE_ALTERATION_BIT:
		case K_SET_TESTBENCH_VERILOG_FILENAME:
		case K_SET_NAME:
		case K_SET_DIRECTION:
		case K_SET_MEM_INSTANCE_NAME:
		case K_SET_VC_OUTPUT_FILENAME:
		case K_SET_RADIX:
		case K_SET_MNEMONIC:
		case K_SET_PHYSICAL_IMPLEMENTATION:
		case K_SET_UNIT_ID:
		case K_SET_VALUE:
		case K_SET_ENUM:
		case K_SET_ENUM_ITEM:
		case K_SET_FIELD:
		case K_SET_POSITION:
		case K_SET_NEXT:
		case K_SET_PREVIOUS:
		case K_SET_FIELD_POSITION:
		case K_SET_TOP_UNIT:
		case K_SET_ADDRESS_INCREMENT:
		case K_SET_NEXT_ADDRESS:
		case K_SET_ACCESS_RIGHTS:
		case K_SET_ACCESS_RIGHTS_ENUM:
		case K_SET_DATA_WORD_WIDTH:
		case K_SET_ALIGNMENT:
		case K_SET_ENDIANESS:
		case K_SET_PREFIX:
		case K_SET_UNIT_NAME:
		case K_SET_SUFFIX:
		case K_SET_SYMBOL_MAX_LENGTH:
		case K_SET_VC_START_GENERATION_TRIGGER:
		case K_SET_VC_MAX_NUMBER_OF_MISMATCHES:
		case K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
		case K_SET_VC_VALID_OUTPUT_TRANSACTION:
		case K_SET_VC_COMPARE_TRIGGER:
		case K_SET_VC_MAX_CYCLES:
		case K_SET_VC_NAME:
		case K_SET_VC_HEADER_COMMENT:
		case K_SET_VERSION:
		case K_SET_VC_CLOCK:
		case K_SET_VC_RESET:
		case K_SET_VC_STALL:
		case K_SET_VC_END_GENERATION_TRIGGER:
		case K_SET_VC_CAPTURE_EDGE_TYPE:
		case K_SET_RESET_NAME:
		case K_SET_CLOCK_NAME:
		case K_SET_RD_CLOCK_NAME:
		case K_SET_WR_CLOCK_NAME:
		case K_SET_PUSH_NAME:
		case K_SET_POP_NAME:
		case K_SET_FULL_NAME:
		case K_SET_EMPTY_NAME:
		case K_SET_WR_DATA_NAME:
		case K_SET_RD_DATA_NAME:
		case K_SET_VALID_NAME:
		case K_SET_WR_ADDR_NAME:
		case K_SET_RD_ADDR_NAME:
		case K_SET_WR_EN_NAME:
		case K_SET_RD_EN_NAME:
		case K_SET_NUM_RD_IFC:
		case K_SET_NUM_WR_IFC:
		case K_SET_CLOCK:
		case K_ADD_PORT_LIST:
		case K_REVERSE:
		case K_OVERRIDE_PARAMETER:
		case K_CREATE_RTL_MODULE:
		case K_DIRECTIVE:
		case K_ADD_LOGIC:
		case K_MERGE:
		case K_EXCLUSION_LIST:
		case K_INCLUDE_ONLY:
		case K_GEN_DECODER:
		case K_ADD_ALLOWED_RANGE:
		case K_ADD_ADDRESS_RANGE:
		case K_ADD_RESERVED_ADDRESS_RANGE:
		case K_ADD:
		case K_AUTO_GEN_MEMORY_MAP:
		case K_ADD_TO_MEMORY_MAP:
		case K_PIPESTAGE_NAMING_CONVENTION:
		case K_INITIALIZE_RANDOM_VALUES:
		case K_INITIALIZE_RANDOM:
		case K_GEN_UNIQUE_RTL_MODULES:
		case K_NO_PREFIX_COMMAND:
		case K_DO_NOT_GEN_RTL:
		case K_DO_NOT_GEN_CPP:
		case K_REGISTER_IOS:
		case K_CONNECT_UNITS:
		case K_CONNECT_BY_PATTERN:
		case K_CONNECT_BY_NAME:
		{
			{
			{
			switch ( LA(1)) {
			case K_ADD_PORT_LIST:
			{
				com0 = LT(1);
				com0_AST = astFactory->create(com0);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com0_AST));
				match(K_ADD_PORT_LIST);
				param_list_add_port_list(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4605 "csl.parser.g"
				command = com0_AST;
#line 2694 "CslParser.cpp"
				break;
			}
			case K_SET_TYPE:
			{
				com1 = LT(1);
				com1_AST = astFactory->create(com1);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com1_AST));
				match(K_SET_TYPE);
				param_list_set_type(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4606 "csl.parser.g"
				command = com1_AST;
#line 2707 "CslParser.cpp"
				break;
			}
			case K_SET_ATTR:
			{
				com2 = LT(1);
				com2_AST = astFactory->create(com2);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com2_AST));
				match(K_SET_ATTR);
				param_list_set_attr(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4607 "csl.parser.g"
				command = com2_AST;
#line 2720 "CslParser.cpp"
				break;
			}
			case K_SET_UNIT_PREFIX:
			{
				com3 = LT(1);
				com3_AST = astFactory->create(com3);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com3_AST));
				match(K_SET_UNIT_PREFIX);
				param_list_set_unit_prefix(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4608 "csl.parser.g"
				command = com3_AST;
#line 2733 "CslParser.cpp"
				break;
			}
			case K_SET_SIGNAL_PREFIX:
			{
				com4 = LT(1);
				com4_AST = astFactory->create(com4);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com4_AST));
				match(K_SET_SIGNAL_PREFIX);
				param_list_set_signal_prefix(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4609 "csl.parser.g"
				command = com4_AST;
#line 2746 "CslParser.cpp"
				break;
			}
			case K_SET_SIGNAL_PREFIX_LOCAL:
			{
				com5 = LT(1);
				com5_AST = astFactory->create(com5);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com5_AST));
				match(K_SET_SIGNAL_PREFIX_LOCAL);
				param_list_set_signal_prefix_local(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4610 "csl.parser.g"
				command = com5_AST;
#line 2759 "CslParser.cpp"
				break;
			}
			case K_SET_DEPTH:
			{
				com6 = LT(1);
				com6_AST = astFactory->create(com6);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com6_AST));
				match(K_SET_DEPTH);
				param_list_set_depth(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4611 "csl.parser.g"
				command = com6_AST;
#line 2772 "CslParser.cpp"
				break;
			}
			case K_CREATE_RTL_MODULE:
			{
				com7 = LT(1);
				com7_AST = astFactory->create(com7);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com7_AST));
				match(K_CREATE_RTL_MODULE);
				param_list_create_rtl_module(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4612 "csl.parser.g"
				command = com7_AST;
#line 2785 "CslParser.cpp"
				break;
			}
			case K_DIRECTIVE:
			{
				com10 = LT(1);
				com10_AST = astFactory->create(com10);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com10_AST));
				match(K_DIRECTIVE);
				param_list_directive(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4615 "csl.parser.g"
				command = com10_AST;
#line 2798 "CslParser.cpp"
				break;
			}
			case K_SET_WIDTH:
			{
				com11 = LT(1);
				com11_AST = astFactory->create(com11);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com11_AST));
				match(K_SET_WIDTH);
				param_list_set_width(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4616 "csl.parser.g"
				command = com11_AST;
#line 2811 "CslParser.cpp"
				break;
			}
			case K_SET_DIM_WIDTH:
			{
				com12 = LT(1);
				com12_AST = astFactory->create(com12);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com12_AST));
				match(K_SET_DIM_WIDTH);
				param_list_set_dim_width(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4617 "csl.parser.g"
				command = com12_AST;
#line 2824 "CslParser.cpp"
				break;
			}
			case K_SET_BITRANGE:
			{
				com13 = LT(1);
				com13_AST = astFactory->create(com13);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com13_AST));
				match(K_SET_BITRANGE);
				param_list_set_bitrange(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4618 "csl.parser.g"
				command = com13_AST;
#line 2837 "CslParser.cpp"
				break;
			}
			case K_SET_DIM_BITRANGE:
			{
				com14 = LT(1);
				com14_AST = astFactory->create(com14);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com14_AST));
				match(K_SET_DIM_BITRANGE);
				param_list_set_dim_bitrange(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4619 "csl.parser.g"
				command = com14_AST;
#line 2850 "CslParser.cpp"
				break;
			}
			case K_SET_RANGE:
			{
				com15 = LT(1);
				com15_AST = astFactory->create(com15);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com15_AST));
				match(K_SET_RANGE);
				param_list_set_range(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4620 "csl.parser.g"
				command = com15_AST;
#line 2863 "CslParser.cpp"
				break;
			}
			case K_SET_DIM_RANGE:
			{
				com16 = LT(1);
				com16_AST = astFactory->create(com16);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com16_AST));
				match(K_SET_DIM_RANGE);
				param_list_set_dim_range(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4621 "csl.parser.g"
				command = com16_AST;
#line 2876 "CslParser.cpp"
				break;
			}
			case K_SET_OFFSET:
			{
				com19 = LT(1);
				com19_AST = astFactory->create(com19);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com19_AST));
				match(K_SET_OFFSET);
				param_list_set_offset(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4622 "csl.parser.g"
				command = com19_AST;
#line 2889 "CslParser.cpp"
				break;
			}
			case K_SET_DIM_OFFSET:
			{
				com20 = LT(1);
				com20_AST = astFactory->create(com20);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com20_AST));
				match(K_SET_DIM_OFFSET);
				param_list_set_dim_offset(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4623 "csl.parser.g"
				command = com20_AST;
#line 2902 "CslParser.cpp"
				break;
			}
			case K_SET_NUMBER_OF_DIMENSIONS:
			{
				com21 = LT(1);
				com21_AST = astFactory->create(com21);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com21_AST));
				match(K_SET_NUMBER_OF_DIMENSIONS);
				param_list_set_number_of_dimensions(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4624 "csl.parser.g"
				command = com21_AST;
#line 2915 "CslParser.cpp"
				break;
			}
			case K_REVERSE:
			{
				com22 = LT(1);
				com22_AST = astFactory->create(com22);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com22_AST));
				match(K_REVERSE);
				param_list_reverse(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4625 "csl.parser.g"
				command = com22_AST;
#line 2928 "CslParser.cpp"
				break;
			}
			case K_SET_INSTANCE_ALTERATION_BIT:
			{
				com25 = LT(1);
				com25_AST = astFactory->create(com25);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com25_AST));
				match(K_SET_INSTANCE_ALTERATION_BIT);
				param_list_set_instance_alteration_bit(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4628 "csl.parser.g"
				command = com25_AST;
#line 2941 "CslParser.cpp"
				break;
			}
			case K_SET_TESTBENCH_VERILOG_FILENAME:
			{
				com28 = LT(1);
				com28_AST = astFactory->create(com28);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com28_AST));
				match(K_SET_TESTBENCH_VERILOG_FILENAME);
				param_list_set_testbench_verilog_filename(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4631 "csl.parser.g"
				command = com28_AST;
#line 2954 "CslParser.cpp"
				break;
			}
			case K_SET_VC_COMPARE_TRIGGER:
			{
				com31 = LT(1);
				com31_AST = astFactory->create(com31);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com31_AST));
				match(K_SET_VC_COMPARE_TRIGGER);
				param_list_set_vc_compare_trigger(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4634 "csl.parser.g"
				command = com31_AST;
#line 2967 "CslParser.cpp"
				break;
			}
			case K_SET_NAME:
			{
				com37 = LT(1);
				com37_AST = astFactory->create(com37);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com37_AST));
				match(K_SET_NAME);
				param_list_set_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4640 "csl.parser.g"
				command = com37_AST;
#line 2980 "CslParser.cpp"
				break;
			}
			case K_SET_DIRECTION:
			{
				com39 = LT(1);
				com39_AST = astFactory->create(com39);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com39_AST));
				match(K_SET_DIRECTION);
				param_list_set_direction(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4642 "csl.parser.g"
				command = com39_AST;
#line 2993 "CslParser.cpp"
				break;
			}
			case K_EXCLUSION_LIST:
			{
				com40 = LT(1);
				com40_AST = astFactory->create(com40);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com40_AST));
				match(K_EXCLUSION_LIST);
				param_list_exclusion_list(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4643 "csl.parser.g"
				command = com40_AST;
#line 3006 "CslParser.cpp"
				break;
			}
			case K_INCLUDE_ONLY:
			{
				com41 = LT(1);
				com41_AST = astFactory->create(com41);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com41_AST));
				match(K_INCLUDE_ONLY);
				param_list_include_only(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4644 "csl.parser.g"
				command = com41_AST;
#line 3019 "CslParser.cpp"
				break;
			}
			case K_SET_RADIX:
			{
				com45 = LT(1);
				com45_AST = astFactory->create(com45);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com45_AST));
				match(K_SET_RADIX);
				param_list_set_radix(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4648 "csl.parser.g"
				command = com45_AST;
#line 3032 "CslParser.cpp"
				break;
			}
			case K_SET_TOP_UNIT:
			{
				com47 = LT(1);
				com47_AST = astFactory->create(com47);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com47_AST));
				match(K_SET_TOP_UNIT);
				param_list_set_top_unit(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4650 "csl.parser.g"
				command = com47_AST;
#line 3045 "CslParser.cpp"
				break;
			}
			case K_ADD:
			{
				com48 = LT(1);
				com48_AST = astFactory->create(com48);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com48_AST));
				match(K_ADD);
				param_list_add(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4651 "csl.parser.g"
				command = com48_AST;
#line 3058 "CslParser.cpp"
				break;
			}
			case K_ADD_ADDRESS_RANGE:
			{
				com49 = LT(1);
				com49_AST = astFactory->create(com49);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com49_AST));
				match(K_ADD_ADDRESS_RANGE);
				param_list_add_address_range(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4652 "csl.parser.g"
				command = com49_AST;
#line 3071 "CslParser.cpp"
				break;
			}
			case K_ADD_RESERVED_ADDRESS_RANGE:
			{
				com50 = LT(1);
				com50_AST = astFactory->create(com50);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com50_AST));
				match(K_ADD_RESERVED_ADDRESS_RANGE);
				param_list_add_reserved_address_range(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4653 "csl.parser.g"
				command = com50_AST;
#line 3084 "CslParser.cpp"
				break;
			}
			case K_SET_DATA_WORD_WIDTH:
			{
				com51 = LT(1);
				com51_AST = astFactory->create(com51);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com51_AST));
				match(K_SET_DATA_WORD_WIDTH);
				param_list_set_data_word_width(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4654 "csl.parser.g"
				command = com51_AST;
#line 3097 "CslParser.cpp"
				break;
			}
			case K_SET_ADDRESS_INCREMENT:
			{
				com52 = LT(1);
				com52_AST = astFactory->create(com52);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com52_AST));
				match(K_SET_ADDRESS_INCREMENT);
				param_list_set_address_increment(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4655 "csl.parser.g"
				command = com52_AST;
#line 3110 "CslParser.cpp"
				break;
			}
			case K_SET_NEXT_ADDRESS:
			{
				com53 = LT(1);
				com53_AST = astFactory->create(com53);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com53_AST));
				match(K_SET_NEXT_ADDRESS);
				param_list_set_next_address(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4656 "csl.parser.g"
				command = com53_AST;
#line 3123 "CslParser.cpp"
				break;
			}
			case K_SET_ALIGNMENT:
			{
				com54 = LT(1);
				com54_AST = astFactory->create(com54);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com54_AST));
				match(K_SET_ALIGNMENT);
				param_list_set_alignment(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4657 "csl.parser.g"
				command = com54_AST;
#line 3136 "CslParser.cpp"
				break;
			}
			case K_SET_PREFIX:
			{
				com55 = LT(1);
				com55_AST = astFactory->create(com55);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com55_AST));
				match(K_SET_PREFIX);
				param_list_set_prefix(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4658 "csl.parser.g"
				command = com55_AST;
#line 3149 "CslParser.cpp"
				break;
			}
			case K_SET_SUFFIX:
			{
				com56 = LT(1);
				com56_AST = astFactory->create(com56);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com56_AST));
				match(K_SET_SUFFIX);
				param_list_set_suffix(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4659 "csl.parser.g"
				command = com56_AST;
#line 3162 "CslParser.cpp"
				break;
			}
			case K_SET_ENDIANESS:
			{
				com57 = LT(1);
				com57_AST = astFactory->create(com57);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com57_AST));
				match(K_SET_ENDIANESS);
				param_list_set_endianess(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4660 "csl.parser.g"
				command = com57_AST;
#line 3175 "CslParser.cpp"
				break;
			}
			case K_AUTO_GEN_MEMORY_MAP:
			{
				com58 = LT(1);
				com58_AST = astFactory->create(com58);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com58_AST));
				match(K_AUTO_GEN_MEMORY_MAP);
				param_list_auto_gen_memory_map(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4661 "csl.parser.g"
				command = com58_AST;
#line 3188 "CslParser.cpp"
				break;
			}
			case K_ADD_TO_MEMORY_MAP:
			{
				com59 = LT(1);
				com59_AST = astFactory->create(com59);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com59_AST));
				match(K_ADD_TO_MEMORY_MAP);
				param_list_add_to_memory_map(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4662 "csl.parser.g"
				command = com59_AST;
#line 3201 "CslParser.cpp"
				break;
			}
			case K_SET_ACCESS_RIGHTS:
			{
				com61 = LT(1);
				com61_AST = astFactory->create(com61);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com61_AST));
				match(K_SET_ACCESS_RIGHTS);
				param_list_set_access_rights(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4664 "csl.parser.g"
				command = com61_AST;
#line 3214 "CslParser.cpp"
				break;
			}
			case K_SET_ACCESS_RIGHTS_ENUM:
			{
				com62 = LT(1);
				com62_AST = astFactory->create(com62);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com62_AST));
				match(K_SET_ACCESS_RIGHTS_ENUM);
				param_list_set_access_rights_enum(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4665 "csl.parser.g"
				command = com62_AST;
#line 3227 "CslParser.cpp"
				break;
			}
			case K_SET_SYMBOL_MAX_LENGTH:
			{
				com63 = LT(1);
				com63_AST = astFactory->create(com63);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com63_AST));
				match(K_SET_SYMBOL_MAX_LENGTH);
				param_list_set_symbol_max_length(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4666 "csl.parser.g"
				command = com63_AST;
#line 3240 "CslParser.cpp"
				break;
			}
			case K_SET_ENUM:
			{
				com64 = LT(1);
				com64_AST = astFactory->create(com64);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com64_AST));
				match(K_SET_ENUM);
				param_list_set_enum(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4667 "csl.parser.g"
				command = com64_AST;
#line 3253 "CslParser.cpp"
				break;
			}
			case K_SET_ENUM_ITEM:
			{
				com65 = LT(1);
				com65_AST = astFactory->create(com65);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com65_AST));
				match(K_SET_ENUM_ITEM);
				param_list_set_enum_item(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4668 "csl.parser.g"
				command = com65_AST;
#line 3266 "CslParser.cpp"
				break;
			}
			case K_SET_MNEMONIC:
			{
				com66 = LT(1);
				com66_AST = astFactory->create(com66);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com66_AST));
				match(K_SET_MNEMONIC);
				param_list_set_mnemonic(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4669 "csl.parser.g"
				command = com66_AST;
#line 3279 "CslParser.cpp"
				break;
			}
			case K_GEN_DECODER:
			{
				com71 = LT(1);
				com71_AST = astFactory->create(com71);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com71_AST));
				match(K_GEN_DECODER);
				param_list_gen_decoder(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4674 "csl.parser.g"
				command = com71_AST;
#line 3292 "CslParser.cpp"
				break;
			}
			case K_SET_PHYSICAL_IMPLEMENTATION:
			{
				com72 = LT(1);
				com72_AST = astFactory->create(com72);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com72_AST));
				match(K_SET_PHYSICAL_IMPLEMENTATION);
				param_list_set_physical_implementation(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4675 "csl.parser.g"
				command = com72_AST;
#line 3305 "CslParser.cpp"
				break;
			}
			case K_SET_VALUE:
			{
				com73 = LT(1);
				com73_AST = astFactory->create(com73);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com73_AST));
				match(K_SET_VALUE);
				param_list_set_value(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4676 "csl.parser.g"
				command = com73_AST;
#line 3318 "CslParser.cpp"
				break;
			}
			case K_SET_FIELD:
			{
				com74 = LT(1);
				com74_AST = astFactory->create(com74);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com74_AST));
				match(K_SET_FIELD);
				param_list_set_field(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4677 "csl.parser.g"
				command = com74_AST;
#line 3331 "CslParser.cpp"
				break;
			}
			case K_SET_FIELD_POSITION:
			{
				com75 = LT(1);
				com75_AST = astFactory->create(com75);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com75_AST));
				match(K_SET_FIELD_POSITION);
				param_list_set_field_position(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4678 "csl.parser.g"
				command = com75_AST;
#line 3344 "CslParser.cpp"
				break;
			}
			case K_SET_POSITION:
			{
				com76 = LT(1);
				com76_AST = astFactory->create(com76);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com76_AST));
				match(K_SET_POSITION);
				param_list_set_position(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4679 "csl.parser.g"
				command = com76_AST;
#line 3357 "CslParser.cpp"
				break;
			}
			case K_SET_NEXT:
			{
				com77 = LT(1);
				com77_AST = astFactory->create(com77);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com77_AST));
				match(K_SET_NEXT);
				param_list_set_next(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4680 "csl.parser.g"
				command = com77_AST;
#line 3370 "CslParser.cpp"
				break;
			}
			case K_SET_PREVIOUS:
			{
				com78 = LT(1);
				com78_AST = astFactory->create(com78);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com78_AST));
				match(K_SET_PREVIOUS);
				param_list_set_previous(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4681 "csl.parser.g"
				command = com78_AST;
#line 3383 "CslParser.cpp"
				break;
			}
			case K_ADD_ALLOWED_RANGE:
			{
				com80 = LT(1);
				com80_AST = astFactory->create(com80);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com80_AST));
				match(K_ADD_ALLOWED_RANGE);
				param_list_add_allowed_range(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4683 "csl.parser.g"
				command = com80_AST;
#line 3396 "CslParser.cpp"
				break;
			}
			case K_SET_ATTRIBUTES:
			{
				com81 = LT(1);
				com81_AST = astFactory->create(com81);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com81_AST));
				match(K_SET_ATTRIBUTES);
				param_list_set_attributes(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4684 "csl.parser.g"
				command = com81_AST;
#line 3409 "CslParser.cpp"
				break;
			}
			case K_ADD_LOGIC:
			{
				com89 = LT(1);
				com89_AST = astFactory->create(com89);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com89_AST));
				match(K_ADD_LOGIC);
				param_list_add_logic(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4692 "csl.parser.g"
				command = com89_AST;
#line 3422 "CslParser.cpp"
				break;
			}
			case K_SET_VC_START_GENERATION_TRIGGER:
			{
				com98 = LT(1);
				com98_AST = astFactory->create(com98);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com98_AST));
				match(K_SET_VC_START_GENERATION_TRIGGER);
				param_list_set_vc_start_generation_trigger(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4701 "csl.parser.g"
				command = com98_AST;
#line 3435 "CslParser.cpp"
				break;
			}
			case K_SET_UNIT_NAME:
			{
				com102 = LT(1);
				com102_AST = astFactory->create(com102);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com102_AST));
				match(K_SET_UNIT_NAME);
				param_list_set_unit_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4705 "csl.parser.g"
				command = com102_AST;
#line 3448 "CslParser.cpp"
				break;
			}
			case K_PIPESTAGE_NAMING_CONVENTION:
			{
				com107 = LT(1);
				com107_AST = astFactory->create(com107);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com107_AST));
				match(K_PIPESTAGE_NAMING_CONVENTION);
				param_list_pipestage_naming_convention(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4710 "csl.parser.g"
				command = com107_AST;
#line 3461 "CslParser.cpp"
				break;
			}
			case K_MERGE:
			{
				com121 = LT(1);
				com121_AST = astFactory->create(com121);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com121_AST));
				match(K_MERGE);
				param_list_merge(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4724 "csl.parser.g"
				command = com121_AST;
#line 3474 "CslParser.cpp"
				break;
			}
			case K_SET_VC_NAME:
			{
				com125 = LT(1);
				com125_AST = astFactory->create(com125);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com125_AST));
				match(K_SET_VC_NAME);
				param_list_set_vc_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4728 "csl.parser.g"
				command = com125_AST;
#line 3487 "CslParser.cpp"
				break;
			}
			case K_SET_VC_HEADER_COMMENT:
			{
				com126 = LT(1);
				com126_AST = astFactory->create(com126);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com126_AST));
				match(K_SET_VC_HEADER_COMMENT);
				param_list_set_vc_header_comment(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4729 "csl.parser.g"
				command = com126_AST;
#line 3500 "CslParser.cpp"
				break;
			}
			case K_SET_VERSION:
			{
				com127 = LT(1);
				com127_AST = astFactory->create(com127);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com127_AST));
				match(K_SET_VERSION);
				param_list_set_version(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4730 "csl.parser.g"
				command = com127_AST;
#line 3513 "CslParser.cpp"
				break;
			}
			case K_SET_VC_CLOCK:
			{
				com128 = LT(1);
				com128_AST = astFactory->create(com128);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com128_AST));
				match(K_SET_VC_CLOCK);
				param_list_set_vc_clock(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4731 "csl.parser.g"
				command = com128_AST;
#line 3526 "CslParser.cpp"
				break;
			}
			case K_SET_VC_RESET:
			{
				com129 = LT(1);
				com129_AST = astFactory->create(com129);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com129_AST));
				match(K_SET_VC_RESET);
				param_list_set_vc_reset(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4732 "csl.parser.g"
				command = com129_AST;
#line 3539 "CslParser.cpp"
				break;
			}
			case K_SET_VC_STALL:
			{
				com130 = LT(1);
				com130_AST = astFactory->create(com130);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com130_AST));
				match(K_SET_VC_STALL);
				param_list_set_vc_stall(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4733 "csl.parser.g"
				command = com130_AST;
#line 3552 "CslParser.cpp"
				break;
			}
			case K_SET_VC_END_GENERATION_TRIGGER:
			{
				com131 = LT(1);
				com131_AST = astFactory->create(com131);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com131_AST));
				match(K_SET_VC_END_GENERATION_TRIGGER);
				param_list_set_vc_end_generation_trigger(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4734 "csl.parser.g"
				command = com131_AST;
#line 3565 "CslParser.cpp"
				break;
			}
			case K_SET_VC_CAPTURE_EDGE_TYPE:
			{
				com132 = LT(1);
				com132_AST = astFactory->create(com132);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com132_AST));
				match(K_SET_VC_CAPTURE_EDGE_TYPE);
				param_list_set_vc_capture_edge_type(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4735 "csl.parser.g"
				command = com132_AST;
#line 3578 "CslParser.cpp"
				break;
			}
			case K_SET_VC_MAX_NUMBER_OF_MISMATCHES:
			{
				com134 = LT(1);
				com134_AST = astFactory->create(com134);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com134_AST));
				match(K_SET_VC_MAX_NUMBER_OF_MISMATCHES);
				param_list_set_vc_max_number_of_mismatches(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4737 "csl.parser.g"
				command = com134_AST;
#line 3591 "CslParser.cpp"
				break;
			}
			case K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
			{
				com135 = LT(1);
				com135_AST = astFactory->create(com135);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com135_AST));
				match(K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS);
				param_list_set_vc_max_number_of_valid_transactions(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4738 "csl.parser.g"
				command = com135_AST;
#line 3604 "CslParser.cpp"
				break;
			}
			case K_SET_VC_VALID_OUTPUT_TRANSACTION:
			{
				com136 = LT(1);
				com136_AST = astFactory->create(com136);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com136_AST));
				match(K_SET_VC_VALID_OUTPUT_TRANSACTION);
				param_list_set_vc_valid_output_transaction(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4739 "csl.parser.g"
				command = com136_AST;
#line 3617 "CslParser.cpp"
				break;
			}
			case K_SET_VC_OUTPUT_FILENAME:
			{
				com138 = LT(1);
				com138_AST = astFactory->create(com138);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com138_AST));
				match(K_SET_VC_OUTPUT_FILENAME);
				param_list_set_vc_output_filename(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4741 "csl.parser.g"
				command = com138_AST;
#line 3630 "CslParser.cpp"
				break;
			}
			case K_SET_VC_MAX_CYCLES:
			{
				com141 = LT(1);
				com141_AST = astFactory->create(com141);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com141_AST));
				match(K_SET_VC_MAX_CYCLES);
				param_list_set_vc_max_cycles(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4744 "csl.parser.g"
				command = com141_AST;
#line 3643 "CslParser.cpp"
				break;
			}
			case K_SET_MEM_INSTANCE_NAME:
			{
				com142 = LT(1);
				com142_AST = astFactory->create(com142);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com142_AST));
				match(K_SET_MEM_INSTANCE_NAME);
				param_list_set_mem_instance_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4745 "csl.parser.g"
				command = com142_AST;
#line 3656 "CslParser.cpp"
				break;
			}
			case K_SET_RESET_NAME:
			{
				com143 = LT(1);
				com143_AST = astFactory->create(com143);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com143_AST));
				match(K_SET_RESET_NAME);
				param_list_set_reset_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4746 "csl.parser.g"
				command = com143_AST;
#line 3669 "CslParser.cpp"
				break;
			}
			case K_SET_CLOCK_NAME:
			{
				com144 = LT(1);
				com144_AST = astFactory->create(com144);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com144_AST));
				match(K_SET_CLOCK_NAME);
				param_list_set_clock_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4747 "csl.parser.g"
				command = com144_AST;
#line 3682 "CslParser.cpp"
				break;
			}
			case K_SET_RD_CLOCK_NAME:
			{
				com145 = LT(1);
				com145_AST = astFactory->create(com145);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com145_AST));
				match(K_SET_RD_CLOCK_NAME);
				param_list_set_rd_clock_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4748 "csl.parser.g"
				command = com145_AST;
#line 3695 "CslParser.cpp"
				break;
			}
			case K_SET_WR_CLOCK_NAME:
			{
				com146 = LT(1);
				com146_AST = astFactory->create(com146);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com146_AST));
				match(K_SET_WR_CLOCK_NAME);
				param_list_set_wr_clock_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4749 "csl.parser.g"
				command = com146_AST;
#line 3708 "CslParser.cpp"
				break;
			}
			case K_SET_PUSH_NAME:
			{
				com147 = LT(1);
				com147_AST = astFactory->create(com147);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com147_AST));
				match(K_SET_PUSH_NAME);
				param_list_set_push_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4750 "csl.parser.g"
				command = com147_AST;
#line 3721 "CslParser.cpp"
				break;
			}
			case K_SET_POP_NAME:
			{
				com148 = LT(1);
				com148_AST = astFactory->create(com148);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com148_AST));
				match(K_SET_POP_NAME);
				param_list_set_pop_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4751 "csl.parser.g"
				command = com148_AST;
#line 3734 "CslParser.cpp"
				break;
			}
			case K_SET_FULL_NAME:
			{
				com149 = LT(1);
				com149_AST = astFactory->create(com149);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com149_AST));
				match(K_SET_FULL_NAME);
				param_list_set_full_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4752 "csl.parser.g"
				command = com149_AST;
#line 3747 "CslParser.cpp"
				break;
			}
			case K_SET_EMPTY_NAME:
			{
				com150 = LT(1);
				com150_AST = astFactory->create(com150);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com150_AST));
				match(K_SET_EMPTY_NAME);
				param_list_set_empty_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4753 "csl.parser.g"
				command = com150_AST;
#line 3760 "CslParser.cpp"
				break;
			}
			case K_SET_WR_DATA_NAME:
			{
				com151 = LT(1);
				com151_AST = astFactory->create(com151);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com151_AST));
				match(K_SET_WR_DATA_NAME);
				param_list_set_wr_data_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4754 "csl.parser.g"
				command = com151_AST;
#line 3773 "CslParser.cpp"
				break;
			}
			case K_SET_RD_DATA_NAME:
			{
				com152 = LT(1);
				com152_AST = astFactory->create(com152);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com152_AST));
				match(K_SET_RD_DATA_NAME);
				param_list_set_rd_data_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4755 "csl.parser.g"
				command = com152_AST;
#line 3786 "CslParser.cpp"
				break;
			}
			case K_SET_VALID_NAME:
			{
				com153 = LT(1);
				com153_AST = astFactory->create(com153);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com153_AST));
				match(K_SET_VALID_NAME);
				param_list_set_valid_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4756 "csl.parser.g"
				command = com153_AST;
#line 3799 "CslParser.cpp"
				break;
			}
			case K_SET_WR_ADDR_NAME:
			{
				com154 = LT(1);
				com154_AST = astFactory->create(com154);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com154_AST));
				match(K_SET_WR_ADDR_NAME);
				param_list_set_wr_addr_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4757 "csl.parser.g"
				command = com154_AST;
#line 3812 "CslParser.cpp"
				break;
			}
			case K_SET_RD_ADDR_NAME:
			{
				com155 = LT(1);
				com155_AST = astFactory->create(com155);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com155_AST));
				match(K_SET_RD_ADDR_NAME);
				param_list_set_rd_addr_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4758 "csl.parser.g"
				command = com155_AST;
#line 3825 "CslParser.cpp"
				break;
			}
			case K_SET_WR_EN_NAME:
			{
				com156 = LT(1);
				com156_AST = astFactory->create(com156);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com156_AST));
				match(K_SET_WR_EN_NAME);
				param_list_set_wr_en_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4759 "csl.parser.g"
				command = com156_AST;
#line 3838 "CslParser.cpp"
				break;
			}
			case K_SET_RD_EN_NAME:
			{
				com157 = LT(1);
				com157_AST = astFactory->create(com157);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com157_AST));
				match(K_SET_RD_EN_NAME);
				param_list_set_rd_en_name(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4760 "csl.parser.g"
				command = com157_AST;
#line 3851 "CslParser.cpp"
				break;
			}
			case K_INITIALIZE_RANDOM_VALUES:
			{
				com163 = LT(1);
				com163_AST = astFactory->create(com163);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com163_AST));
				match(K_INITIALIZE_RANDOM_VALUES);
				param_list_initialize_random_values(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4766 "csl.parser.g"
				command = com163_AST;
#line 3864 "CslParser.cpp"
				break;
			}
			case K_INITIALIZE_RANDOM:
			{
				com164 = LT(1);
				com164_AST = astFactory->create(com164);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com164_AST));
				match(K_INITIALIZE_RANDOM);
				param_list_initialize_random(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4767 "csl.parser.g"
				command = com164_AST;
#line 3877 "CslParser.cpp"
				break;
			}
			case K_SET_UNIT_ID:
			{
				com165 = LT(1);
				com165_AST = astFactory->create(com165);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com165_AST));
				match(K_SET_UNIT_ID);
				param_list_set_unit_id(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4768 "csl.parser.g"
				command = com165_AST;
#line 3890 "CslParser.cpp"
				break;
			}
			case K_SET_NUM_RD_IFC:
			{
				com168 = LT(1);
				com168_AST = astFactory->create(com168);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com168_AST));
				match(K_SET_NUM_RD_IFC);
				param_list_set_num_rd_ifc(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4771 "csl.parser.g"
				command = com168_AST;
#line 3903 "CslParser.cpp"
				break;
			}
			case K_SET_NUM_WR_IFC:
			{
				com169 = LT(1);
				com169_AST = astFactory->create(com169);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com169_AST));
				match(K_SET_NUM_WR_IFC);
				param_list_set_num_wr_ifc(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4772 "csl.parser.g"
				command = com169_AST;
#line 3916 "CslParser.cpp"
				break;
			}
			case K_GEN_UNIQUE_RTL_MODULES:
			{
				com170 = LT(1);
				com170_AST = astFactory->create(com170);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com170_AST));
				match(K_GEN_UNIQUE_RTL_MODULES);
				param_list_gen_unique_rtl_modules(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4773 "csl.parser.g"
				command = com170_AST;
#line 3929 "CslParser.cpp"
				break;
			}
			case K_NO_PREFIX_COMMAND:
			{
				com171 = LT(1);
				com171_AST = astFactory->create(com171);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com171_AST));
				match(K_NO_PREFIX_COMMAND);
				param_list_no_prefix(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4774 "csl.parser.g"
				command = com171_AST;
#line 3942 "CslParser.cpp"
				break;
			}
			case K_OVERRIDE_PARAMETER:
			{
				com172 = LT(1);
				com172_AST = astFactory->create(com172);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com172_AST));
				match(K_OVERRIDE_PARAMETER);
				param_list_override_parameter(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4775 "csl.parser.g"
				command = com172_AST;
#line 3955 "CslParser.cpp"
				break;
			}
			case K_DO_NOT_GEN_RTL:
			{
				com173 = LT(1);
				com173_AST = astFactory->create(com173);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com173_AST));
				match(K_DO_NOT_GEN_RTL);
				param_list_do_not_gen_rtl(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4776 "csl.parser.g"
				command = com173_AST;
#line 3968 "CslParser.cpp"
				break;
			}
			case K_DO_NOT_GEN_CPP:
			{
				com174 = LT(1);
				com174_AST = astFactory->create(com174);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com174_AST));
				match(K_DO_NOT_GEN_CPP);
				param_list_do_not_gen_cpp(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4777 "csl.parser.g"
				command = com174_AST;
#line 3981 "CslParser.cpp"
				break;
			}
			case K_SET_CLOCK:
			{
				com175 = LT(1);
				com175_AST = astFactory->create(com175);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com175_AST));
				match(K_SET_CLOCK);
				param_list_set_clock(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4778 "csl.parser.g"
				command = com175_AST;
#line 3994 "CslParser.cpp"
				break;
			}
			case K_REGISTER_IOS:
			{
				com176 = LT(1);
				com176_AST = astFactory->create(com176);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com176_AST));
				match(K_REGISTER_IOS);
				param_list_register_ios(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4779 "csl.parser.g"
				command = com176_AST;
#line 4007 "CslParser.cpp"
				break;
			}
			case K_CONNECT_UNITS:
			{
				com177 = LT(1);
				com177_AST = astFactory->create(com177);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com177_AST));
				match(K_CONNECT_UNITS);
				param_list_connect_units(scopeId);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4780 "csl.parser.g"
				command = com177_AST;
#line 4020 "CslParser.cpp"
				break;
			}
			case K_CONNECT_BY_PATTERN:
			{
				com178 = LT(1);
				com178_AST = astFactory->create(com178);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com178_AST));
				match(K_CONNECT_BY_PATTERN);
				param_list_connect_by_pattern(scopeId, wasConcat);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4781 "csl.parser.g"
				command = com178_AST; 
				wasAllowedLhsPartSelectCmd = TRUE;
#line 4034 "CslParser.cpp"
				break;
			}
			case K_CONNECT_BY_NAME:
			{
				com179 = LT(1);
				com179_AST = astFactory->create(com179);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(com179_AST));
				match(K_CONNECT_BY_NAME);
				param_list_connect_by_name(scopeId, wasConcat);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4783 "csl.parser.g"
				command = com179_AST; 
				wasAllowedLhsPartSelectCmd = TRUE;
#line 4048 "CslParser.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 4787 "csl.parser.g"
			setCurrentFilename(command); 
			if (!hasDot) {
			RefString msg = _RS("Expecting dot(\".\") before command.");
			throwError( msg, currentFilename.getRealLine(command->getLine()), command->getColumn());
			}
			
#line 4064 "CslParser.cpp"
			}
			break;
		}
		case ASSIGN:
		{
			{
			ass = LT(1);
			ass_AST = astFactory->create(ass);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(ass_AST));
			match(ASSIGN);
			csl_statement_assign(scopeId);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4798 "csl.parser.g"
			
			setCurrentFilename(ass_AST);
			hasAssign = TRUE;
			if (!hasId) {
			RefString msg = _RS("Expecting identifier before assign statement");
			DCERR("01");
			throwError(msg, currentFilename.getRealLine(ass_AST->getLine()), ass_AST->getColumn());
			}
			else if (hasDot) {
			RefString msg = _RS("Expecting identifier before assign statement");
			DCERR("02");
			throwError(msg, currentFilename.getRealLine(ass_AST->getLine()), ass_AST->getColumn()); }
			
			wasAllowedLhsPartSelectCmd = TRUE;
			
#line 4093 "CslParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 4817 "csl.parser.g"
		
		if (hasId && (!hasDot && !hasAssign)) {
		RefString msg = _RS("Unexpected identifier '");
		msg->append( id_AST->getText());
		msg->append( "'. Expecting command or statement");
		DCERR("03");
		throwError(msg, currentFilename.getRealLine(id_AST->getLine()), id_AST->getColumn());
		}
		
		if (wasRangeExpr && !wasAllowedLhsPartSelectCmd) {
		RefString msg = _RS("When part select is used on the left hand side of a statement, that statement is only allowed to be assignment or a connect_by_pattern()/connect_by_name() command call.");
		DCERR("04");
		throwError(msg, currentFilename.getRealLine(rangeExprLine), rangeExprColumn);
		}
		
#line 4119 "CslParser.cpp"
		match(SEMI);
		csl_command_AST = antlr::RefCslAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
#line 4836 "csl.parser.g"
		
		args.push_back(intToString(ex.getColumn()));
		args.push_back(ex.getMessage());
		//  DCERR(ex.toString());
		//  DCERR(ex.getLine());
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(ex.getLine()));
		cslParserHasErrors = true;
		consumeUntil( SEMI );
		
#line 4134 "CslParser.cpp"
	}
	catch (ANTLRException &ex) {
#line 4845 "csl.parser.g"
		
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
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(stringToInt(line)));
		cslParserHasErrors = true;
		consumeUntil( SEMI );
		
#line 4153 "CslParser.cpp"
	}
	returnAST = csl_command_AST;
}

void CslParser::csl_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec3 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec4 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec5 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec5_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec6 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec6_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec7 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec7_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec8 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec8_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec9 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec9_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec13 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec13_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec14 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec14_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec15 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec15_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec16 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec16_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec17 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec17_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec18 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec18_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec19 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec19_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec20 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec20_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec21 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec21_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec22 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec22_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec23 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec23_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec24 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec24_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec25 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec25_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec26 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec26_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec27 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec27_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec28 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec28_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec29 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec29_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec30 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec30_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dec31 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dec31_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2141 "csl.parser.g"
	
	RefCslAST temp;
	
#line 4222 "CslParser.cpp"
	
	try {      // for error handling
		{
		{
		switch ( LA(1)) {
		case K_CSL_UNIT:
		{
			dec1 = LT(1);
			dec1_AST = astFactory->create(dec1);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec1_AST));
			match(K_CSL_UNIT);
			csl_unit_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2149 "csl.parser.g"
			temp = dec1_AST;
#line 4238 "CslParser.cpp"
			break;
		}
		case K_CSL_SIGNAL:
		{
			dec2 = LT(1);
			dec2_AST = astFactory->create(dec2);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec2_AST));
			match(K_CSL_SIGNAL);
			csl_signal_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2150 "csl.parser.g"
			temp = dec2_AST;
#line 4251 "CslParser.cpp"
			break;
		}
		case K_CSL_PORT:
		{
			dec3 = LT(1);
			dec3_AST = astFactory->create(dec3);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec3_AST));
			match(K_CSL_PORT);
			csl_port_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2151 "csl.parser.g"
			temp = dec3_AST;
#line 4264 "CslParser.cpp"
			break;
		}
		case K_CSL_BITRANGE:
		{
			dec4 = LT(1);
			dec4_AST = astFactory->create(dec4);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec4_AST));
			match(K_CSL_BITRANGE);
			csl_bitrange_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2152 "csl.parser.g"
			temp = dec4_AST;
#line 4277 "CslParser.cpp"
			break;
		}
		case K_CSL_SIGNAL_GROUP:
		{
			dec5 = LT(1);
			dec5_AST = astFactory->create(dec5);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec5_AST));
			match(K_CSL_SIGNAL_GROUP);
			csl_signal_group_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2153 "csl.parser.g"
			temp = dec5_AST;
#line 4290 "CslParser.cpp"
			break;
		}
		case K_CSL_INTERFACE:
		{
			dec6 = LT(1);
			dec6_AST = astFactory->create(dec6);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec6_AST));
			match(K_CSL_INTERFACE);
			csl_interface_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2154 "csl.parser.g"
			temp = dec6_AST;
#line 4303 "CslParser.cpp"
			break;
		}
		case K_CSL_LIST:
		{
			dec7 = LT(1);
			dec7_AST = astFactory->create(dec7);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec7_AST));
			match(K_CSL_LIST);
			csl_list_declaration(dec7_AST->getLine(), dec7_AST->getColumn());
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2155 "csl.parser.g"
			temp = dec7_AST;
#line 4316 "CslParser.cpp"
			break;
		}
		case K_CSL_REGISTER_FILE:
		{
			dec8 = LT(1);
			dec8_AST = astFactory->create(dec8);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec8_AST));
			match(K_CSL_REGISTER_FILE);
			csl_register_file_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2156 "csl.parser.g"
			temp = dec8_AST;
#line 4329 "CslParser.cpp"
			break;
		}
		case K_CSL_TESTBENCH:
		{
			dec9 = LT(1);
			dec9_AST = astFactory->create(dec9);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec9_AST));
			match(K_CSL_TESTBENCH);
			csl_testbench_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2157 "csl.parser.g"
			temp = dec9_AST;
#line 4342 "CslParser.cpp"
			break;
		}
		case K_CSL_INCLUDE:
		{
			dec13 = LT(1);
			dec13_AST = astFactory->create(dec13);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec13_AST));
			match(K_CSL_INCLUDE);
			csl_include_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2159 "csl.parser.g"
			temp = dec13_AST;
#line 4355 "CslParser.cpp"
			break;
		}
		case K_CSL_ISA_FIELD:
		{
			dec14 = LT(1);
			dec14_AST = astFactory->create(dec14);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec14_AST));
			match(K_CSL_ISA_FIELD);
			csl_isa_field_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2160 "csl.parser.g"
			temp = dec14_AST;
#line 4368 "CslParser.cpp"
			break;
		}
		case K_CSL_ISA_ELEMENT:
		{
			dec15 = LT(1);
			dec15_AST = astFactory->create(dec15);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec15_AST));
			match(K_CSL_ISA_ELEMENT);
			csl_isa_element_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2161 "csl.parser.g"
			temp = dec15_AST;
#line 4381 "CslParser.cpp"
			break;
		}
		case K_CSL_ENUM:
		{
			dec16 = LT(1);
			dec16_AST = astFactory->create(dec16);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec16_AST));
			match(K_CSL_ENUM);
			csl_enum_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2162 "csl.parser.g"
			temp = dec16_AST;
#line 4394 "CslParser.cpp"
			break;
		}
		case K_CSL_FIELD:
		{
			dec17 = LT(1);
			dec17_AST = astFactory->create(dec17);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec17_AST));
			match(K_CSL_FIELD);
			csl_field_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2163 "csl.parser.g"
			temp = dec17_AST;
#line 4407 "CslParser.cpp"
			break;
		}
		case K_CSL_FIFO:
		{
			dec18 = LT(1);
			dec18_AST = astFactory->create(dec18);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec18_AST));
			match(K_CSL_FIFO);
			csl_fifo_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2164 "csl.parser.g"
			temp = dec18_AST;
#line 4420 "CslParser.cpp"
			break;
		}
		case K_CSL_MEMORY_MAP:
		{
			dec19 = LT(1);
			dec19_AST = astFactory->create(dec19);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec19_AST));
			match(K_CSL_MEMORY_MAP);
			csl_memory_map_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2165 "csl.parser.g"
			temp = dec19_AST;
#line 4433 "CslParser.cpp"
			break;
		}
		case K_CSL_MEMORY_MAP_PAGE:
		{
			dec20 = LT(1);
			dec20_AST = astFactory->create(dec20);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec20_AST));
			match(K_CSL_MEMORY_MAP_PAGE);
			csl_memory_map_page_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2166 "csl.parser.g"
			temp = dec20_AST;
#line 4446 "CslParser.cpp"
			break;
		}
		case K_CSL_REGISTER:
		{
			dec21 = LT(1);
			dec21_AST = astFactory->create(dec21);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec21_AST));
			match(K_CSL_REGISTER);
			csl_register_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2167 "csl.parser.g"
			temp = dec21_AST;
#line 4459 "CslParser.cpp"
			break;
		}
		case K_CSL_READ_INTERFACE:
		{
			dec22 = LT(1);
			dec22_AST = astFactory->create(dec22);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec22_AST));
			match(K_CSL_READ_INTERFACE);
			csl_read_interface_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2168 "csl.parser.g"
			temp = dec22_AST;
#line 4472 "CslParser.cpp"
			break;
		}
		case K_CSL_WRITE_INTERFACE:
		{
			dec23 = LT(1);
			dec23_AST = astFactory->create(dec23);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec23_AST));
			match(K_CSL_WRITE_INTERFACE);
			csl_write_interface_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2169 "csl.parser.g"
			temp = dec23_AST;
#line 4485 "CslParser.cpp"
			break;
		}
		case K_CSL_STATE_DATA:
		{
			dec24 = LT(1);
			dec24_AST = astFactory->create(dec24);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec24_AST));
			match(K_CSL_STATE_DATA);
			csl_state_data_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2170 "csl.parser.g"
			temp = dec24_AST;
#line 4498 "CslParser.cpp"
			break;
		}
		case K_CSL_VECTOR:
		{
			dec25 = LT(1);
			dec25_AST = astFactory->create(dec25);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec25_AST));
			match(K_CSL_VECTOR);
			csl_vector_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2171 "csl.parser.g"
			temp = dec25_AST;
#line 4511 "CslParser.cpp"
			break;
		}
		case K_CSL_MEMORY:
		{
			dec26 = LT(1);
			dec26_AST = astFactory->create(dec26);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec26_AST));
			match(K_CSL_MEMORY);
			csl_memory_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2172 "csl.parser.g"
			temp = dec26_AST;
#line 4524 "CslParser.cpp"
			break;
		}
		case K_CSL_MULTI_DIM_BITRANGE:
		{
			dec27 = LT(1);
			dec27_AST = astFactory->create(dec27);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec27_AST));
			match(K_CSL_MULTI_DIM_BITRANGE);
			csl_multi_dim_bitrange_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2173 "csl.parser.g"
			temp = dec27_AST;
#line 4537 "CslParser.cpp"
			break;
		}
		case K_CSL_PIPELINE:
		{
			dec28 = LT(1);
			dec28_AST = astFactory->create(dec28);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec28_AST));
			match(K_CSL_PIPELINE);
			csl_pipeline_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2174 "csl.parser.g"
			temp = dec28_AST;
#line 4550 "CslParser.cpp"
			break;
		}
		case K_CSL_PIPESTAGE:
		{
			dec29 = LT(1);
			dec29_AST = astFactory->create(dec29);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec29_AST));
			match(K_CSL_PIPESTAGE);
			csl_pipestage_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2175 "csl.parser.g"
			temp = dec29_AST;
#line 4563 "CslParser.cpp"
			break;
		}
		case K_CONST:
		{
			dec30 = LT(1);
			dec30_AST = astFactory->create(dec30);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec30_AST));
			match(K_CONST);
			csl_const_int_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2176 "csl.parser.g"
			temp = dec30_AST;
#line 4576 "CslParser.cpp"
			break;
		}
		case K_CSL_PARAMETER:
		{
			dec31 = LT(1);
			dec31_AST = astFactory->create(dec31);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(dec31_AST));
			match(K_CSL_PARAMETER);
			csl_parameter_declaration();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2177 "csl.parser.g"
			temp = dec31_AST;
#line 4589 "CslParser.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 2181 "csl.parser.g"
		setCurrentFilename(temp);
#line 4600 "CslParser.cpp"
		match(SEMI);
		}
		csl_declaration_AST = antlr::RefCslAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
#line 2187 "csl.parser.g"
		
		args.push_back(intToString(ex.getColumn()));
		args.push_back(ex.getMessage());
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(ex.getLine()));
		cslParserHasErrors = true;
		consume();
		
#line 4614 "CslParser.cpp"
	}
	catch (ANTLRException &ex) {
#line 2194 "csl.parser.g"
		
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
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(stringToInt(line)));
		cslParserHasErrors = true;
		consume();
		
#line 4633 "CslParser.cpp"
	}
	returnAST = csl_declaration_AST;
}

void CslParser::preprocessor_directive() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST preprocessor_directive_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  pd = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST pd_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  str = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST str_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  un = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST un_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2105 "csl.parser.g"
	
	RefString filename = _RS();
	
#line 4652 "CslParser.cpp"
	
	{
	pd = LT(1);
	pd_AST = astFactory->create(pd);
	match(POUND);
	str = LT(1);
	str_AST = astFactory->create(str);
	match(STRING);
#line 2115 "csl.parser.g"
	filename->append(str->getText());
#line 4663 "CslParser.cpp"
	un = LT(1);
	un_AST = astFactory->create(un);
	match(UNSIGNED_NUMBER);
#line 2118 "csl.parser.g"
	
	currentFilename.setFilename(filename);
	currentFilename.setLine(pd_AST->getLine(), stringToInt(_RS(un_AST->getText())));
	//change the current parsed file so that errors have the right filename
	::currentParsedFile.pop();
	::currentParsedFile.push(*filename);
	
#line 4675 "CslParser.cpp"
	}
	preprocessor_directive_AST = antlr::RefCslAST(currentAST.root);
	returnAST = preprocessor_directive_AST;
}

void CslParser::unexpected() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST unexpected_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		{
			match(UNSIGNED_NUMBER);
			break;
		}
		case NZ_UNSIGNED_NUMBER:
		{
			match(NZ_UNSIGNED_NUMBER);
			break;
		}
		case REAL_NUMBER:
		{
			match(REAL_NUMBER);
			break;
		}
		case REAL_NUMBER_EXP:
		{
			match(REAL_NUMBER_EXP);
			break;
		}
		case TICK:
		{
			match(TICK);
			break;
		}
		case BACKTICK:
		{
			match(BACKTICK);
			break;
		}
		case AT:
		{
			match(AT);
			break;
		}
		case COLON:
		{
			match(COLON);
			break;
		}
		case COMMA:
		{
			match(COMMA);
			break;
		}
		case LBRACK:
		{
			match(LBRACK);
			break;
		}
		case RBRACK:
		{
			match(RBRACK);
			break;
		}
		case RCURLY:
		{
			match(RCURLY);
			break;
		}
		case LPAREN:
		{
			match(LPAREN);
			break;
		}
		case RPAREN:
		{
			match(RPAREN);
			break;
		}
		case QUESTION:
		{
			match(QUESTION);
			break;
		}
		case LNOT:
		{
			match(LNOT);
			break;
		}
		case NOT:
		{
			match(NOT);
			break;
		}
		case AND:
		{
			match(AND);
			break;
		}
		case NAND:
		{
			match(NAND);
			break;
		}
		case OR:
		{
			match(OR);
			break;
		}
		case NOR:
		{
			match(NOR);
			break;
		}
		case XOR:
		{
			match(XOR);
			break;
		}
		case XNOR:
		{
			match(XNOR);
			break;
		}
		case STAR:
		{
			match(STAR);
			break;
		}
		case POW:
		{
			match(POW);
			break;
		}
		case DIV:
		{
			match(DIV);
			break;
		}
		case MOD:
		{
			match(MOD);
			break;
		}
		case EQUAL:
		{
			match(EQUAL);
			break;
		}
		case NOT_EQ:
		{
			match(NOT_EQ);
			break;
		}
		case NOT_EQ_CASE:
		{
			match(NOT_EQ_CASE);
			break;
		}
		case EQ_CASE:
		{
			match(EQ_CASE);
			break;
		}
		case LAND:
		{
			match(LAND);
			break;
		}
		case TAND:
		{
			match(TAND);
			break;
		}
		case LOR:
		{
			match(LOR);
			break;
		}
		case LT_:
		{
			match(LT_);
			break;
		}
		case LE:
		{
			match(LE);
			break;
		}
		case GT:
		{
			match(GT);
			break;
		}
		case GE:
		{
			match(GE);
			break;
		}
		case SL:
		{
			match(SL);
			break;
		}
		case SSL:
		{
			match(SSL);
			break;
		}
		case SR:
		{
			match(SR);
			break;
		}
		case SSR:
		{
			match(SSR);
			break;
		}
		case TRIGGER:
		{
			match(TRIGGER);
			break;
		}
		case PPATH:
		{
			match(PPATH);
			break;
		}
		case FPATH:
		{
			match(FPATH);
			break;
		}
		case PSTAR:
		{
			match(PSTAR);
			break;
		}
		case STARP:
		{
			match(STARP);
			break;
		}
		case PO_POS:
		{
			match(PO_POS);
			break;
		}
		case PO_NEG:
		{
			match(PO_NEG);
			break;
		}
		case SUPERSTAR:
		{
			match(SUPERSTAR);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 2062 "csl.parser.g"
		
		args.push_back(intToString((LT(1))->getColumn()));
		string errorMessage;
		errorMessage.append("Unexpected Token: ");
		errorMessage.append((LT(1))->getText());   
		args.push_back(errorMessage);
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine((LT(1))->getLine()));
		cslParserHasErrors = true;
		//consume();
		
#line 4956 "CslParser.cpp"
		unexpected_AST = antlr::RefCslAST(currentAST.root);
	}
	catch (NoViableAltException &ex) {
#line 2075 "csl.parser.g"
		
		args.push_back(intToString(ex.getColumn()));
		args.push_back(ex.getMessage());
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(ex.getLine()));
		cslParserHasErrors = true;
		//  consumeUntil ( SEMI )
		
#line 4968 "CslParser.cpp"
	}
	catch (ANTLRException &ex) {
#line 2082 "csl.parser.g"
		
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
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(stringToInt(line)));
		cslParserHasErrors = true;
		//  consumeUntil( SEMI );
		
#line 4987 "CslParser.cpp"
	}
	returnAST = unexpected_AST;
}

void CslParser::csl_unit_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_unit_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2962 "csl.parser.g"
	
	TBool             wasPredeclaration  = FALSE; 
	TBool             wasDefinition      = FALSE;
	RefString         objectName;
	
#line 5006 "CslParser.cpp"
	
#line 2971 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TUNIT_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5016 "CslParser.cpp"
	{
	id1 = LT(1);
	id1_AST = astFactory->create(id1);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id1_AST));
	match(IDENTIFIER);
#line 2979 "csl.parser.g"
	setCurrentFilename(id1_AST);
#line 5024 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2982 "csl.parser.g"
			// set real filename + line for id2 identifier
			setCurrentFilename(id2_AST);
			// symTree predeclare id2 identifier (id1 is predeclared at the end of rule)
			objectName = _RS(id2_AST->getText());
			predeclareObject(objectName, NSSymbolTable::TUNIT_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			wasPredeclaration = TRUE; 
			
#line 5041 "CslParser.cpp"
		}
		else {
			goto _loop104;
		}
		
	}
	_loop104:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY || LA(1) == SEMI))&&(!wasPredeclaration)) {
		{
		switch ( LA(1)) {
		case LCURLY:
		{
#line 2993 "csl.parser.g"
			//symTree declare id1 identifier
			objectName = _RS(id1_AST->getText());
			declareObject(objectName, NSSymbolTable::TUNIT_DECL, symTree, currentFilename.getFilename(), id1_AST->getLine(), id1_AST->getColumn());
			
#line 5061 "CslParser.cpp"
			csl_unit_definition(objectName, NSSymbolTable::TUNIT_DECL);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2998 "csl.parser.g"
			wasDefinition = TRUE;
#line 5066 "CslParser.cpp"
			break;
		}
		case SEMI:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 3000 "csl.parser.g"
	
	// symTree predeclare id1 identifier
	if (!wasPredeclaration && !wasDefinition) { objectName = _RS(id1_AST->getText());
	declareObject(objectName, NSSymbolTable::TUNIT_DECL, symTree, currentFilename.getFilename(), id1_AST->getLine(), id1_AST->getColumn());
	}
	
#line 5094 "CslParser.cpp"
	}
	csl_unit_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_unit_declaration_AST;
}

void CslParser::csl_signal_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_signal_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
#line 3550 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TSIGNAL_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5117 "CslParser.cpp"
	{
	id1 = LT(1);
	id1_AST = astFactory->create(id1);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id1_AST));
	match(IDENTIFIER);
#line 3560 "csl.parser.g"
	// set real filename + line for id1 identifier
	setCurrentFilename(id1_AST);
	// symTree declare + define id1 object
	RefString objectName = _RS(id1_AST->getText());
	declareObject(objectName, NSSymbolTable::TSIGNAL_DECL, symTree, currentFilename.getFilename(), id1_AST->getLine(), id1_AST->getColumn());
	defineObject(objectName, NSSymbolTable::TSIGNAL_DECL, symTree, currentFilename.getFilename(), id1_AST->getLine(), id1_AST->getColumn());
	
#line 5131 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case LPAREN:
	{
		match(LPAREN);
		param_list_csl_signal();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		match(RPAREN);
		break;
	}
	case COMMA:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 3571 "csl.parser.g"
			// set real filename + line for id2 identifier
			setCurrentFilename(id2_AST);
			//symTree declare + define id2 object
			RefString objectName = _RS(id2_AST->getText());
			declareObject(objectName, NSSymbolTable::TSIGNAL_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			defineObject(objectName, NSSymbolTable::TSIGNAL_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 5169 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				match(LPAREN);
				param_list_csl_signal();
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				match(RPAREN);
				break;
			}
			case COMMA:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
		}
		else {
			goto _loop166;
		}
		
	}
	_loop166:;
	} // ( ... )*
	}
	csl_signal_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_signal_declaration_AST;
}

void CslParser::csl_port_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_port_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
#line 3507 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0;
	TInt declarationMask    = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TPORT_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5221 "CslParser.cpp"
	{
	id1 = LT(1);
	id1_AST = astFactory->create(id1);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id1_AST));
	match(IDENTIFIER);
#line 3517 "csl.parser.g"
	// set real filename + line for id1 identifier
	setCurrentFilename(id1_AST);
	// symTree declare + define id1 object
	RefString objectName = _RS(id1_AST->getText());
	declareObject(objectName, NSSymbolTable::TPORT_DECL, symTree, currentFilename.getFilename(), id1_AST->getLine(), id1_AST->getColumn());
	defineObject(objectName, NSSymbolTable::TPORT_DECL, symTree, currentFilename.getFilename(), id1_AST->getLine(), id1_AST->getColumn());
	
#line 5235 "CslParser.cpp"
	{
	match(LPAREN);
	param_list_csl_port();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(RPAREN);
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 3528 "csl.parser.g"
			// set real filename + line for id2 identifier
			setCurrentFilename(id2_AST);
			// symTree declare + define id2 object
			RefString objectName = _RS(id2_AST->getText());
			declareObject(objectName, NSSymbolTable::TPORT_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			defineObject(objectName, NSSymbolTable::TPORT_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 5258 "CslParser.cpp"
			{
			match(LPAREN);
			param_list_csl_port();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			match(RPAREN);
			}
		}
		else {
			goto _loop160;
		}
		
	}
	_loop160:;
	} // ( ... )*
	}
	csl_port_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_port_declaration_AST;
}

void CslParser::csl_bitrange_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_bitrange_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3954 "csl.parser.g"
	
	TBool wasDefinition       = FALSE;
	
#line 5294 "CslParser.cpp"
	
#line 3962 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TBITRANGE_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5304 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 3970 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 5312 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case LPAREN:
	{
		match(LPAREN);
		expression();
		exp_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3971 "csl.parser.g"
		if (STRING == exp_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_bitrange"), _RS("Expecting numeric expression as first argument"), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); }
#line 5323 "CslParser.cpp"
		{
		switch ( LA(1)) {
		case COMMA:
		{
			match(COMMA);
			expression();
			exp2_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3974 "csl.parser.g"
			//first expression is not allowed to be STRING
			if (STRING == exp2_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_bitrange"), _RS("Expecting numeric expression as second argument"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); } 
			
#line 5336 "CslParser.cpp"
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 3980 "csl.parser.g"
		wasDefinition = TRUE; 
		declareObject(_RS(id_AST->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		defineObject(_RS(id_AST->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		
#line 5354 "CslParser.cpp"
		match(RPAREN);
		break;
	}
	case COMMA:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 3988 "csl.parser.g"
	if (!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); } else { wasDefinition = TRUE; }
#line 5371 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 3990 "csl.parser.g"
			setCurrentFilename(id2_AST);
#line 5382 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				match(LPAREN);
				expression();
				exp3_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3991 "csl.parser.g"
				if (STRING == exp3_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_bitrange"), _RS("Expecting numeric expression as first argument"), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn()); }
#line 5393 "CslParser.cpp"
				{
				switch ( LA(1)) {
				case COMMA:
				{
					match(COMMA);
					expression();
					exp4_AST = returnAST;
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3994 "csl.parser.g"
					//first expression is not allowed to be STRING
					if (STRING == exp4_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_bitrange"), _RS("Expecting numeric expression as second argument"), currentFilename.getRealLine(exp4_AST->getLine()), exp4_AST->getColumn()); } 
					
#line 5406 "CslParser.cpp"
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
#line 4000 "csl.parser.g"
				//declare object id2
				declareObject(_RS(id2_AST->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
				defineObject(_RS(id2_AST->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
				wasDefinition = TRUE;
				
#line 5425 "CslParser.cpp"
				match(RPAREN);
				break;
			}
			case COMMA:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 4009 "csl.parser.g"
			if (!wasDefinition) { predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TBITRANGE_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn()); } else { wasDefinition = TRUE; }
#line 5442 "CslParser.cpp"
		}
		else {
			goto _loop189;
		}
		
	}
	_loop189:;
	} // ( ... )*
	}
	csl_bitrange_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_bitrange_declaration_AST;
}

void CslParser::csl_signal_group_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_signal_group_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3915 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 5469 "CslParser.cpp"
	
#line 3924 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TSIGNALGR_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5479 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 3932 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 5487 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 3935 "csl.parser.g"
			//predeclare id and id2
			if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TSIGNALGR_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
			setCurrentFilename(id2_AST);
			predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TSIGNALGR_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 5502 "CslParser.cpp"
		}
		else {
			goto _loop180;
		}
		
	}
	_loop180:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TSIGNALGR_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3942 "csl.parser.g"
		wasDefinition = TRUE;
#line 5517 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 3944 "csl.parser.g"
	if (!wasPredeclaration && !wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TSIGNALGR_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 5528 "CslParser.cpp"
	}
	csl_signal_group_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_signal_group_declaration_AST;
}

void CslParser::csl_interface_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_interface_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3451 "csl.parser.g"
	
	TBool wasDefinition    = FALSE;
	TBool wasPredeclaration = FALSE;
	
#line 5547 "CslParser.cpp"
	
#line 3459 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN ;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TIFC_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5557 "CslParser.cpp"
	{
	id1 = LT(1);
	id1_AST = astFactory->create(id1);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id1_AST));
	match(IDENTIFIER);
#line 3467 "csl.parser.g"
	setCurrentFilename(id1_AST);
#line 5565 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 3470 "csl.parser.g"
			// set real filename + line for id1 identifier
			setCurrentFilename(id2_AST);
			// symTree predeclare id2 object
			RefString objectName = _RS(id2_AST->getText());
			predeclareObject(objectName, NSSymbolTable::TIFC_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			wasPredeclaration = TRUE;
			
#line 5582 "CslParser.cpp"
		}
		else {
			goto _loop153;
		}
		
	}
	_loop153:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
#line 3481 "csl.parser.g"
		//symTree declare id1 object
		RefString objectName = _RS(id1_AST->getText());
		declareObject(objectName, NSSymbolTable::TIFC_DECL, symTree, currentFilename.getFilename(), id1_AST->getLine(), id1_AST->getColumn());
		
#line 5598 "CslParser.cpp"
		csl_unit_definition(_RS(id1_AST->getText()), NSSymbolTable::TIFC_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3486 "csl.parser.g"
		wasDefinition = TRUE;
#line 5603 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 3489 "csl.parser.g"
	//if there was no id1 definition then predeclare id1
	if (!wasDefinition) {
	RefString objectName = _RS(id1_AST->getText());
	predeclareObject(objectName, NSSymbolTable::TIFC_DECL, symTree, currentFilename.getFilename(), id1_AST->getLine(), id1_AST->getColumn());
	}
	
#line 5619 "CslParser.cpp"
	}
	csl_interface_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_interface_declaration_AST;
}

void CslParser::csl_list_declaration(
	TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_list_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3016 "csl.parser.g"
	
	TBool isIdList = FALSE;
	TBool isNotAnonymous = FALSE;
	
#line 5640 "CslParser.cpp"
	
#line 3024 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 ;
	TInt declarationMask    = 0 | ALL_SCOPE_HOLDERS_AND_DESIGN;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TLIST_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5650 "CslParser.cpp"
	{
	{
	switch ( LA(1)) {
	case IDENTIFIER:
	{
		id = LT(1);
		id_AST = astFactory->create(id);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
		match(IDENTIFIER);
#line 3035 "csl.parser.g"
		
		setCurrentFilename(id_AST);
		RefString objectName = _RS(id_AST->getText());
		declareObject(objectName, NSSymbolTable::TLIST_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		defineObject(objectName, NSSymbolTable::TLIST_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		isNotAnonymous = TRUE;
		
#line 5668 "CslParser.cpp"
		break;
	}
	case COMMA:
	case LPAREN:
	case RPAREN:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{
	switch ( LA(1)) {
	case LPAREN:
	{
		isIdList=param_list_csl_list();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case COMMA:
	case RPAREN:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 3046 "csl.parser.g"
	
	if (!isNotAnonymous && !isIdList) {
	throwDeclarationError(_RS("csl_list"),  _RS("You must provide an identifier followed by a list or an anonymous list "), currentFilename.getRealLine(line), column);
	}
	
#line 5710 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if (((LA(1) == COMMA))&&(isNotAnonymous)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 3054 "csl.parser.g"
			
			setCurrentFilename(id2_AST);
			RefString objectName = _RS(id2_AST->getText());
			declareObject(objectName, NSSymbolTable::TLIST_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			defineObject(objectName, NSSymbolTable::TLIST_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 5726 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				isIdList=param_list_csl_list();
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				break;
			}
			case COMMA:
			case RPAREN:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
		}
		else {
			goto _loop113;
		}
		
	}
	_loop113:;
	} // ( ... )*
	}
	csl_list_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_list_declaration_AST;
}

void CslParser::csl_register_file_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_register_file_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2805 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 5773 "CslParser.cpp"
	
#line 2814 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TRF_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5783 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2822 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 5791 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2825 "csl.parser.g"
			//predeclare id and id2
			if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TRF_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
			setCurrentFilename(id2_AST);
			predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TRF_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 5806 "CslParser.cpp"
		}
		else {
			goto _loop85;
		}
		
	}
	_loop85:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), TRF_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2832 "csl.parser.g"
		wasDefinition = TRUE;
#line 5821 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2834 "csl.parser.g"
	if (!wasDefinition && !wasPredeclaration) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TRF_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 5832 "CslParser.cpp"
	}
	csl_register_file_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_register_file_declaration_AST;
}

void CslParser::csl_testbench_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_testbench_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2727 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 5851 "CslParser.cpp"
	
#line 2736 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 ;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TRF_DECL | NSSymbolTable::TFIFO_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TTB_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 5861 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2744 "csl.parser.g"
	setCurrentFilename(id_AST); checkAllowedCompDecl(NSCslc::CslcTool::COMP_TESTBENCH, getTypeStr(NSSymbolTable::TTB_DECL), id_AST->getLine(), id_AST->getColumn());
#line 5869 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2747 "csl.parser.g"
			//predeclare id and id2
			if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TTB_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());}
			setCurrentFilename(id2_AST);
			predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TTB_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 5884 "CslParser.cpp"
		}
		else {
			goto _loop75;
		}
		
	}
	_loop75:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TTB_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2754 "csl.parser.g"
		wasDefinition = TRUE;
#line 5899 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2756 "csl.parser.g"
	if (!wasDefinition && !wasPredeclaration) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TTB_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 5910 "CslParser.cpp"
	}
	csl_testbench_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_testbench_declaration_AST;
}

void CslParser::csl_include_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_include_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	match(LPAREN);
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	match(IDENTIFIER);
#line 2653 "csl.parser.g"
	//set real filename + line for id
	setCurrentFilename(id_AST);
	// checl if literal received and if so add fake vertex to AST
	RefString literalString = _RS(id_AST->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_FILE_CPLUSPLUS :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_FILE_CPLUSPLUS,"K_FILE_PLUSPLUS")))));
	break;
	case K_LITERAL_FILE_VERILOG :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_FILE_VERILOG,"K_FILE_VERILOG")))));
	break;
	default :
	RefString msg = _RS("Unexpected token '");
	msg->append( id_AST->getText());
	msg->append( "' ");
	throwDeclarationError(_RS("csl_include"), msg, currentFilename.getRealLine(id_AST->getLine()), id_AST->getColumn());
	}
	setCurrentFilename(temp, id_AST->getColumn(), id_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	
#line 5955 "CslParser.cpp"
	}
	com = LT(1);
	com_AST = astFactory->create(com);
	match(COMMA);
	expression();
	exp_AST = returnAST;
#line 2679 "csl.parser.g"
	//exp is allowed to be only string
	if (STRING                    != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwDeclarationError(_RS("csl_include"), _RS("Expecting a string as second argument "), currentFilename.getRealLine(exp_AST->getLine()),exp_AST->getColumn());
	}
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	
#line 5970 "CslParser.cpp"
	match(RPAREN);
	}
	csl_include_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_include_declaration_AST;
}

void CslParser::csl_isa_field_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_isa_field_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp5_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp6_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2365 "csl.parser.g"
	
	TBool wasDefinition        = FALSE;
	TBool wasSecondDeclaration = FALSE;
	TBool wasSecondDefinition  = FALSE;
	
#line 5997 "CslParser.cpp"
	
#line 2374 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 ;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL;
	TInt instantiationMask  = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TISAF_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 6007 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2382 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 6015 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case LPAREN:
	{
		match(LPAREN);
#line 2385 "csl.parser.g"
		wasDefinition = TRUE; 
		//symTree declare + define id object
		declareObject(_RS(id_AST->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		defineObject(_RS(id_AST->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		
#line 6027 "CslParser.cpp"
		expression();
		exp1_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2391 "csl.parser.g"
		if (STRING == exp1_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting numeric expression or identifier as first argument"), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); }
#line 6033 "CslParser.cpp"
		{
		switch ( LA(1)) {
		case COMMA:
		{
			match(COMMA);
			expression();
			exp2_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2392 "csl.parser.g"
			if (STRING == exp2_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting numeric expression or identifier as second argument"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); }
#line 6044 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				expression();
				exp3_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2395 "csl.parser.g"
				if (EXPR_PRIMARY_IDENTIFIER != exp3_AST->getFirstChild()->getType() //third argument must be identifier
				&& FUNCTION_CALL_RET_ID != exp3_AST->getFirstChild()->getType()) 
				{ throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting identifier as third argument"), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn()); } 
				
#line 6058 "CslParser.cpp"
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		break;
	}
	case COMMA:
	case LCURLY:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
#line 2404 "csl.parser.g"
			if (!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 6104 "CslParser.cpp"
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2405 "csl.parser.g"
			setCurrentFilename(id2_AST); if (!wasSecondDeclaration) { wasSecondDeclaration = TRUE; }
#line 6111 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				match(LPAREN);
#line 2406 "csl.parser.g"
				wasSecondDefinition = TRUE;
#line 6119 "CslParser.cpp"
				expression();
				exp4_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2407 "csl.parser.g"
				if (STRING == exp4_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting numeric expression or identifier as first argument"), currentFilename.getRealLine(exp4_AST->getLine()), exp4_AST->getColumn()); }
#line 6125 "CslParser.cpp"
				{
				switch ( LA(1)) {
				case COMMA:
				{
					match(COMMA);
					expression();
					exp5_AST = returnAST;
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2408 "csl.parser.g"
					if (STRING == exp5_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting numeric expression or identifier as second argument"), currentFilename.getRealLine(exp5_AST->getLine()), exp5_AST->getColumn()); }
#line 6136 "CslParser.cpp"
					{
					switch ( LA(1)) {
					case COMMA:
					{
						match(COMMA);
						expression();
						exp6_AST = returnAST;
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2411 "csl.parser.g"
						if (EXPR_PRIMARY_IDENTIFIER != exp6_AST->getFirstChild()->getType() //third argument must be identifier
						&& FUNCTION_CALL_RET_ID != exp6_AST->getFirstChild()->getType()) 
						{ throwDeclarationError(_RS("csl_isa_field"), _RS("Expecting identifier as third argument"), currentFilename.getRealLine(exp6_AST->getLine()), exp6_AST->getColumn()); } 
						
#line 6150 "CslParser.cpp"
						break;
					}
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				match(RPAREN);
				break;
			}
			case COMMA:
			case LCURLY:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 2421 "csl.parser.g"
			//if not defined symTree predeclare id2, if defined symTree declare + define id2
			if (!wasSecondDefinition) { predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn()); }
			else {declareObject(_RS(id2_AST->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			defineObject(_RS(id2_AST->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			}
			
#line 6197 "CslParser.cpp"
		}
		else {
			goto _loop43;
		}
		
	}
	_loop43:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasDefinition && !wasSecondDeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TISAF_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2429 "csl.parser.g"
		wasDefinition = TRUE;
#line 6212 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2431 "csl.parser.g"
	if (!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TISAF_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 6223 "CslParser.cpp"
	}
	csl_isa_field_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_isa_field_declaration_AST;
}

void CslParser::csl_isa_element_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_isa_element_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  col = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST col_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2440 "csl.parser.g"
	
	RefString inheritString;
	TInt line = -1, column = -1;
	RefCslAST temporary;
	
#line 6245 "CslParser.cpp"
	
#line 2449 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 ;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TISAE_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 6255 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	match(IDENTIFIER);
#line 2459 "csl.parser.g"
	//set real filename + line for id
	setCurrentFilename(id_AST);
	//create fake vertex that tells walker that CSL_ISA_ELEMENT_DECLARATION follows + add to AST
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CSL_ISA_ELEMENT_DECLARATION,"CSL_ISA_ELEMENT_DECLARATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST))));
	setCurrentFilename(temporary, id_AST->getColumn(), id_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
	
#line 6268 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COLON:
	{
		col = LT(1);
		col_AST = astFactory->create(col);
		match(COLON);
		id2 = LT(1);
		id2_AST = astFactory->create(id2);
		match(IDENTIFIER);
#line 2469 "csl.parser.g"
		//set real filename + line for id2 
		setCurrentFilename(id2_AST);
		//create fake vertex that tells walker that inheritance follows + add to AST
		RefCslAST temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PARENT_CLASS,"PARENT_CLASS")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST))));
		setCurrentFilename(temp, id2_AST->getColumn(), id2_AST->getLine());
		temporary->addChild(temp);
		inheritString = _RS(id2_AST->getText());
		line = id2_AST->getLine();
		column = id2_AST->getColumn();
		
#line 6290 "CslParser.cpp"
		break;
	}
	case LCURLY:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{
	csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TISAE_DECL, inheritString, line, column);
#line 2481 "csl.parser.g"
	temporary->addChild(returnAST);
#line 6307 "CslParser.cpp"
	}
	}
	csl_isa_element_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_isa_element_declaration_AST;
}

void CslParser::csl_enum_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_enum_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
#line 2494 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 ;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TENUM_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 6329 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2504 "csl.parser.g"
	//set real filename + line for id
	setCurrentFilename(id_AST);
	// symTree declare + define object id
	declareObject(_RS(id_AST->getText()), NSSymbolTable::TENUM_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
	defineObject(_RS(id_AST->getText()), NSSymbolTable::TENUM_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
	
#line 6342 "CslParser.cpp"
	match(LCURLY);
	{
	switch ( LA(1)) {
	case IDENTIFIER:
	{
		csl_enum_declaration_item();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				csl_enum_declaration_item();
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			else {
				goto _loop53;
			}
			
		}
		_loop53:;
		} // ( ... )*
		break;
	}
	case RCURLY:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RCURLY);
	}
	csl_enum_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_enum_declaration_AST;
}

void CslParser::csl_field_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_field_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp5_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp6_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2569 "csl.parser.g"
	
	TBool wasDefinition        = FALSE;
	TBool wasSecondDeclaration = FALSE;
	TBool wasSecondDefinition  = FALSE;
	NSSymbolTable::EObjType currentScope = NSSymbolTable::TUNDEF;
	
#line 6403 "CslParser.cpp"
	
#line 2580 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 ;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TFIELD_DECL;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TFIELD_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TFIELD_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 6413 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2588 "csl.parser.g"
	setCurrentFilename(id_AST); currentScope = symTree->getCurrentScope()->getType();
#line 6421 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case LPAREN:
	{
		match(LPAREN);
#line 2591 "csl.parser.g"
		wasDefinition = TRUE; 
		//symTree declare + define id object
		declareObject(_RS(id_AST->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		defineObject(_RS(id_AST->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		
#line 6433 "CslParser.cpp"
		expression();
		exp1_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2597 "csl.parser.g"
		if (STRING == exp1_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_field"), _RS("Expecting numeric expression or identifier as first argument"), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); }
#line 6439 "CslParser.cpp"
		{
		switch ( LA(1)) {
		case COMMA:
		{
			match(COMMA);
			expression();
			exp2_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2598 "csl.parser.g"
			if (STRING == exp2_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_field"), _RS("Expecting numeric expression or identifier as second argument"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); }
#line 6450 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				expression();
				exp3_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2601 "csl.parser.g"
				if (EXPR_PRIMARY_IDENTIFIER != exp3_AST->getFirstChild()->getType() //third argument must be identifier
				&& FUNCTION_CALL_RET_ID != exp3_AST->getFirstChild()->getType()) 
				{ throwDeclarationError(_RS("csl_field"), _RS("Expecting identifier as third argument"), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn()); } 
				
#line 6464 "CslParser.cpp"
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		break;
	}
	case COMMA:
	case LCURLY:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
#line 2610 "csl.parser.g"
			if (!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 6510 "CslParser.cpp"
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2611 "csl.parser.g"
			setCurrentFilename(id2_AST); if (!wasSecondDeclaration) { wasSecondDeclaration = TRUE; }
#line 6517 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				match(LPAREN);
#line 2612 "csl.parser.g"
				if (!wasSecondDefinition) { wasSecondDefinition = TRUE; }
#line 6525 "CslParser.cpp"
				expression();
				exp4_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2613 "csl.parser.g"
				if (STRING == exp4_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_field"), _RS("Expecting numeric expression or identifier as first argument"), currentFilename.getRealLine(exp4_AST->getLine()), exp4_AST->getColumn()); }
#line 6531 "CslParser.cpp"
				{
				switch ( LA(1)) {
				case COMMA:
				{
					match(COMMA);
					expression();
					exp5_AST = returnAST;
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2614 "csl.parser.g"
					if (STRING == exp5_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_field"), _RS("Expecting numeric expression or identifier as second argument"), currentFilename.getRealLine(exp5_AST->getLine()), exp5_AST->getColumn()); }
#line 6542 "CslParser.cpp"
					{
					switch ( LA(1)) {
					case COMMA:
					{
						match(COMMA);
						expression();
						exp6_AST = returnAST;
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2617 "csl.parser.g"
						if (EXPR_PRIMARY_IDENTIFIER != exp6_AST->getFirstChild()->getType() //third argument must be identifier
						&& FUNCTION_CALL_RET_ID != exp6_AST->getFirstChild()->getType()) 
						{ throwDeclarationError(_RS("csl_field"), _RS("Expecting identifier as third argument"), currentFilename.getRealLine(exp6_AST->getLine()), exp6_AST->getColumn()); } 
						
#line 6556 "CslParser.cpp"
						break;
					}
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				match(RPAREN);
				break;
			}
			case COMMA:
			case LCURLY:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 2627 "csl.parser.g"
			//if not defined symTree predeclare id2, if defined symTree declare + define id2
			if (!wasSecondDefinition) { predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn()); }
			else {declareObject(_RS(id2_AST->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			defineObject(_RS(id2_AST->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			}
			
#line 6603 "CslParser.cpp"
		}
		else {
			goto _loop67;
		}
		
	}
	_loop67:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasDefinition && !wasSecondDeclaration && TDESIGN == currentScope)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TFIELD_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2635 "csl.parser.g"
		wasDefinition = TRUE;
#line 6618 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2637 "csl.parser.g"
	if (!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TFIELD_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 6629 "CslParser.cpp"
	}
	csl_field_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_field_declaration_AST;
}

void CslParser::csl_fifo_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_fifo_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2766 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 6648 "CslParser.cpp"
	
#line 2775 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TFIFO_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 6658 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2783 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 6666 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2786 "csl.parser.g"
			// predeclaration of id and id2
			if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TFIFO_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
			setCurrentFilename(id2_AST);
			predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TFIFO_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 6681 "CslParser.cpp"
		}
		else {
			goto _loop80;
		}
		
	}
	_loop80:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TFIFO_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2793 "csl.parser.g"
		wasDefinition = TRUE;
#line 6696 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2795 "csl.parser.g"
	if (!wasPredeclaration && !wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TFIFO_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 6707 "CslParser.cpp"
	}
	csl_fifo_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_fifo_declaration_AST;
}

void CslParser::csl_memory_map_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_memory_map_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2844 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 6726 "CslParser.cpp"
	
#line 2853 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TMEMMAP_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 6736 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2861 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 6744 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2864 "csl.parser.g"
			//predeclare id and id2
			if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TMEMMAP_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
			setCurrentFilename(id2_AST);
			predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TMEMMAP_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 6759 "CslParser.cpp"
		}
		else {
			goto _loop90;
		}
		
	}
	_loop90:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), TMEMMAP_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2871 "csl.parser.g"
		wasDefinition = TRUE;
#line 6774 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2873 "csl.parser.g"
	if (!wasDefinition && !wasPredeclaration) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TMEMMAP_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 6785 "CslParser.cpp"
	}
	csl_memory_map_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_memory_map_declaration_AST;
}

void CslParser::csl_memory_map_page_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_memory_map_page_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2883 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 6804 "CslParser.cpp"
	
#line 2892 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 | NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TMEMMAPP_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 6814 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2900 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 6822 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		id2 = LT(1);
		id2_AST = astFactory->create(id2);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
		match(IDENTIFIER);
#line 2903 "csl.parser.g"
		
		if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TMEMMAPP_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
		setCurrentFilename(id_AST);
		predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TMEMMAPP_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
		
#line 6838 "CslParser.cpp"
		break;
	}
	case LCURLY:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TMEMMAPP_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2911 "csl.parser.g"
		wasDefinition = TRUE;
#line 6858 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2913 "csl.parser.g"
	if (!wasDefinition && !wasPredeclaration) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TMEMMAPP_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 6869 "CslParser.cpp"
	}
	csl_memory_map_page_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_memory_map_page_declaration_AST;
}

void CslParser::csl_register_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_register_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2923 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 6888 "CslParser.cpp"
	
#line 2932 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TREG_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 6898 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2940 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 6906 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2943 "csl.parser.g"
			//predeclare id and id2
			if (!wasPredeclaration) { wasPredeclaration = TRUE; predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TREG_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());  }
			setCurrentFilename(id2_AST);
			predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TREG_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 6921 "CslParser.cpp"
		}
		else {
			goto _loop99;
		}
		
	}
	_loop99:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TREG_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2950 "csl.parser.g"
		wasDefinition = TRUE;
#line 6936 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2952 "csl.parser.g"
	if (!wasPredeclaration && !wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TREG_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
#line 6947 "CslParser.cpp"
	}
	csl_register_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_register_declaration_AST;
}

void CslParser::csl_read_interface_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_read_interface_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2219 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 6967 "CslParser.cpp"
	}
	csl_read_interface_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_read_interface_declaration_AST;
}

void CslParser::csl_write_interface_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_write_interface_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2231 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 6987 "CslParser.cpp"
	}
	csl_write_interface_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_write_interface_declaration_AST;
}

void CslParser::csl_state_data_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_state_data_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2239 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 7006 "CslParser.cpp"
	
#line 2247 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TSTATED_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 7016 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2255 "csl.parser.g"
	setCurrentFilename(id_AST); checkAllowedCompDecl(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, getTypeStr(NSSymbolTable::TSTATED_DECL), id_AST->getLine(), id_AST->getColumn());
#line 7024 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
#line 2256 "csl.parser.g"
			if (!wasPredeclaration) { wasPredeclaration = TRUE; }
#line 7031 "CslParser.cpp"
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2259 "csl.parser.g"
			//set real filename + line for identifier id2
			setCurrentFilename(id2_AST);
			//symTree predeclare object id2
			RefString objectName = _RS(id2_AST->getText());
			predeclareObject(objectName, NSSymbolTable::TSTATED_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			wasPredeclaration = TRUE;
			
#line 7044 "CslParser.cpp"
		}
		else {
			goto _loop22;
		}
		
	}
	_loop22:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TSTATED_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2268 "csl.parser.g"
		wasDefinition = TRUE;
#line 7059 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2270 "csl.parser.g"
	//if no definition symTree predeclare object id
	if (!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TSTATED_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
	
#line 7072 "CslParser.cpp"
	}
	csl_state_data_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_state_data_declaration_AST;
}

void CslParser::csl_vector_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_vector_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2282 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 7091 "CslParser.cpp"
	
#line 2290 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TVEC_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 7101 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2298 "csl.parser.g"
	setCurrentFilename(id_AST);   checkAllowedCompDecl(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, getTypeStr(NSSymbolTable::TVEC_DECL), id_AST->getLine(), id_AST->getColumn());
#line 7109 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
#line 2299 "csl.parser.g"
			if (!wasPredeclaration) { wasPredeclaration = TRUE; }
#line 7116 "CslParser.cpp"
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2302 "csl.parser.g"
			//set real filename + line for object id2
			setCurrentFilename(id2_AST);
			//symTree predeclare object id2
			predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TVEC_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			wasPredeclaration = TRUE;
			
#line 7128 "CslParser.cpp"
		}
		else {
			goto _loop27;
		}
		
	}
	_loop27:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TVEC_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2310 "csl.parser.g"
		wasDefinition = TRUE;
#line 7143 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2312 "csl.parser.g"
	//if no definition symTree predeclare object id
	if (!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TVEC_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
	
#line 7156 "CslParser.cpp"
	}
	csl_vector_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_vector_declaration_AST;
}

void CslParser::csl_memory_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_memory_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2324 "csl.parser.g"
	
	TBool wasPredeclaration = FALSE;
	TBool wasDefinition     = FALSE;
	
#line 7175 "CslParser.cpp"
	
#line 2332 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 | NSSymbolTable::TDESIGN;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TMEM_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 7185 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 2340 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 7193 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
#line 2341 "csl.parser.g"
			if (!wasPredeclaration) {wasPredeclaration = TRUE; }
#line 7200 "CslParser.cpp"
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 2344 "csl.parser.g"
			//set real filename + line for id2
			setCurrentFilename(id2_AST);
			//symTree predeclare id2
			predeclareObject(_RS(id2->getText()), NSSymbolTable::TMEM_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 7211 "CslParser.cpp"
		}
		else {
			goto _loop32;
		}
		
	}
	_loop32:;
	} // ( ... )*
	{
	if (((LA(1) == LCURLY))&&(!wasPredeclaration)) {
		csl_unit_definition(_RS(id_AST->getText()), NSSymbolTable::TMEM_DECL);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 2351 "csl.parser.g"
		wasDefinition = TRUE;
#line 7226 "CslParser.cpp"
	}
	else if ((LA(1) == SEMI)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
#line 2353 "csl.parser.g"
	// if no definition predeclare object id
	if (!wasDefinition) { predeclareObject(_RS(id->getText()), NSSymbolTable::TMEM_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); }
	
#line 7239 "CslParser.cpp"
	}
	csl_memory_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_memory_declaration_AST;
}

void CslParser::csl_multi_dim_bitrange_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_multi_dim_bitrange_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4020 "csl.parser.g"
	
	TBool wasDefinition = FALSE;
	
#line 7259 "CslParser.cpp"
	
#line 4027 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL;
	TInt instantiationMask  = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TDESIGN;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TMDB_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 7269 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 4035 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 7277 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case LPAREN:
	{
		match(LPAREN);
		expression();
		exp_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4038 "csl.parser.g"
		// exp cannot be STRING
		if (STRING == exp_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_multi_dim_bitrange"), _RS("Expecting identifier or numeric experssion as argument"), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); } 
		declareObject(_RS(id_AST->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		defineObject(_RS(id_AST->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		wasDefinition = TRUE;
		
#line 7293 "CslParser.cpp"
		match(RPAREN);
		break;
	}
	case COMMA:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 4048 "csl.parser.g"
	if (!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); } else { wasDefinition = FALSE; }
#line 7310 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 4050 "csl.parser.g"
			setCurrentFilename(id2_AST);
#line 7321 "CslParser.cpp"
			match(LPAREN);
			expression();
			exp2_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4053 "csl.parser.g"
			// exp2 cannot be STRING
			if (STRING == exp2_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_multi_dim_bitrange"), _RS("Expecting identifier or numeric experssion as argument"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); }
			declareObject(_RS(id2_AST->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			defineObject(_RS(id2_AST->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 7332 "CslParser.cpp"
			match(RPAREN);
#line 4061 "csl.parser.g"
			if (!wasDefinition) { predeclareObject(_RS(id2_AST->getText()), NSSymbolTable::TMDB_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn()); } else { wasDefinition = FALSE; }
#line 7336 "CslParser.cpp"
		}
		else {
			goto _loop194;
		}
		
	}
	_loop194:;
	} // ( ... )*
	}
	csl_multi_dim_bitrange_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_multi_dim_bitrange_declaration_AST;
}

void CslParser::csl_pipeline_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_pipeline_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4072 "csl.parser.g"
	
	TBool wasDefinition = FALSE;
	
#line 7364 "CslParser.cpp"
	
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 4079 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 7373 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case LPAREN:
	{
		match(LPAREN);
		expression();
		exp_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4082 "csl.parser.g"
		//exp is not allowed to be STRING 
		if (STRING == exp_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_pipeline"), _RS("Expecting numeric expression as argument"), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); }
		//declare+define id object
		declareObject(_RS(id_AST->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		defineObject(_RS(id_AST->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
		wasDefinition = TRUE;
		
#line 7390 "CslParser.cpp"
		match(RPAREN);
		break;
	}
	case COMMA:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 4093 "csl.parser.g"
	if(!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); } else { wasDefinition = FALSE; }
#line 7407 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 4095 "csl.parser.g"
			setCurrentFilename(id2_AST);
#line 7418 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				match(LPAREN);
				expression();
				exp2_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4098 "csl.parser.g"
				//exp2 is not allowed to be STRING 
				if (STRING == exp2_AST->getFirstChild()->getType()) { throwDeclarationError(_RS("csl_pipeline"), _RS("Expecting numeric expression as argument"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); }
				//declare+define id object
				declareObject(_RS(id2_AST->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
				defineObject(_RS(id2_AST->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
				wasDefinition = TRUE;
				
#line 7435 "CslParser.cpp"
				break;
			}
			case COMMA:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 4108 "csl.parser.g"
			if(!wasDefinition) { predeclareObject(_RS(id_AST->getText()), NSSymbolTable::TPIPELINE_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn()); } else { wasDefinition = FALSE; }
#line 7451 "CslParser.cpp"
		}
		else {
			goto _loop200;
		}
		
	}
	_loop200:;
	} // ( ... )*
	}
	csl_pipeline_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_pipeline_declaration_AST;
}

void CslParser::csl_pipestage_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_pipestage_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 4126 "csl.parser.g"
	setCurrentFilename(id_AST); 
	RefString str = _RS(id_AST->getText());
	declareObject(str, NSSymbolTable::TPIPESTG_DECL, symTree, currentFilename.getFilename(), id->getLine(), id->getColumn());
	defineObject(str, NSSymbolTable::TPIPESTG_DECL, symTree, currentFilename.getFilename(), id->getLine(), id->getColumn());
	
#line 7485 "CslParser.cpp"
	{
	match(COMMA);
	id2 = LT(1);
	id2_AST = astFactory->create(id2);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
	match(IDENTIFIER);
#line 4134 "csl.parser.g"
	
	setCurrentFilename(id2_AST);
	RefString str2 = _RS(id2_AST->getText());
	declareObject(str2, NSSymbolTable::TPIPESTG_DECL, symTree, currentFilename.getFilename(), id2->getLine(), id2->getColumn());
	defineObject(str2, NSSymbolTable::TPIPESTG_DECL, symTree, currentFilename.getFilename(), id2->getLine(), id2->getColumn());
	
#line 7499 "CslParser.cpp"
	}
	}
	csl_pipestage_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_pipestage_declaration_AST;
}

void CslParser::csl_const_int_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_const_int_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  it = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST it_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  as = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST as_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id3 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  as2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST as2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4149 "csl.parser.g"
	
	antlr::RefCslAST temp = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
#line 7526 "CslParser.cpp"
	
#line 4156 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0;
	TInt declarationMask    = 0 | NSSymbolTable::TUNIT_DECL;
	TInt instantiationMask  = 0;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TCONSTINT_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 7536 "CslParser.cpp"
	{
	it = LT(1);
	it_AST = astFactory->create(it);
	match(K_INT);
#line 4164 "csl.parser.g"
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(it_AST));
#line 7543 "CslParser.cpp"
	id2 = LT(1);
	id2_AST = astFactory->create(id2);
	match(IDENTIFIER);
#line 4192 "csl.parser.g"
	setCurrentFilename(id2_AST);
#line 7549 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case ASSIGN:
	{
		as = LT(1);
		as_AST = astFactory->create(as);
		match(ASSIGN);
		expression();
		exp_AST = returnAST;
#line 4195 "csl.parser.g"
		//manually construct sub-tree and add to AST
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(4))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(as_AST))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ASSIGNOR,"ASSIGNOR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(exp_AST))));
		RefCslAST tmp = temp;
		tmp = tmp->getFirstChild()->getNextSibling();
		setCurrentFilename(tmp, exp_AST->getColumn(), exp_AST->getLine());
		
#line 7566 "CslParser.cpp"
		break;
	}
	case COMMA:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 4204 "csl.parser.g"
	if (!temp) { throwDeclarationError(_RS("const int"), _RS("Const int value must be given at declaration. Const int's cannot be modified after declaration/definition"), currentFilename.getRealLine(id2_AST->getLine()), id2_AST->getColumn()); } 
	else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp)); 
	declareObject(_RS(id2_AST->getText()), NSSymbolTable::TCONSTINT_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
	defineObject(_RS(id2_AST->getText()), NSSymbolTable::TCONSTINT_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
	}   
	temp = RefCslAST();
	
#line 7588 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id3 = LT(1);
			id3_AST = astFactory->create(id3);
			match(IDENTIFIER);
#line 4212 "csl.parser.g"
			setCurrentFilename(id3_AST);
#line 7598 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case ASSIGN:
			{
				as2 = LT(1);
				as2_AST = astFactory->create(as2);
				match(ASSIGN);
				expression();
				exp2_AST = returnAST;
#line 4215 "csl.parser.g"
				//manually construct sub-tree and add to AST
				temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(4))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(as2_AST))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(id3_AST))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ASSIGNOR,"ASSIGNOR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(exp2_AST))));
				RefCslAST tmp = temp;
				tmp = tmp->getFirstChild()->getNextSibling();
				setCurrentFilename(tmp, exp2_AST->getColumn(), exp2_AST->getLine());
				
#line 7615 "CslParser.cpp"
				break;
			}
			case COMMA:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 4224 "csl.parser.g"
			if (!temp) { throwDeclarationError(_RS("const int"), _RS("Const int value must be given at declaration. Const int's cannot be modified after declaration/definition"), currentFilename.getRealLine(id3_AST->getLine()), id3_AST->getColumn()); } 
			else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp)); 
			declareObject(_RS(id3_AST->getText()), NSSymbolTable::TCONSTINT_DECL, symTree, currentFilename.getFilename(), id3_AST->getLine(), id3_AST->getColumn());
			defineObject(_RS(id3_AST->getText()), NSSymbolTable::TCONSTINT_DECL, symTree, currentFilename.getFilename(), id3_AST->getLine(), id3_AST->getColumn());
			}
			temp = RefCslAST();
			
#line 7637 "CslParser.cpp"
		}
		else {
			goto _loop209;
		}
		
	}
	_loop209:;
	} // ( ... )*
	}
	csl_const_int_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_const_int_declaration_AST;
}

void CslParser::csl_parameter_declaration() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_parameter_declaration_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
#line 4245 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0;
	TInt declarationMask    = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TREG_DECL
	| NSSymbolTable::TRF_DECL | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TMEM_DECL;
	TInt instantiationMask  = 0;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TPARAM_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 7673 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 4254 "csl.parser.g"
	setCurrentFilename(id_AST);
#line 7681 "CslParser.cpp"
	match(LPAREN);
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4258 "csl.parser.g"
	
	if (exp1_AST->getFirstChild()->getType() == STRING) {
	throwDeclarationError(_RS("csl_parameter"), _RS("Expecting numeric expression as first argument"), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn());
	}
	
#line 7692 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		exp2_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4266 "csl.parser.g"
		
		if (exp2_AST->getFirstChild()->getType() == STRING) {
		throwDeclarationError(_RS("csl_parameter"), _RS("Expecting numeric expression as second argument"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
		}
		
#line 7707 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
#line 4276 "csl.parser.g"
	
	declareObject(_RS(id_AST->getText()), NSSymbolTable::TPARAM_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
	defineObject(_RS(id_AST->getText()), NSSymbolTable::TPARAM_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
	
#line 7726 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 4281 "csl.parser.g"
			setCurrentFilename(id2_AST);
#line 7737 "CslParser.cpp"
			match(LPAREN);
			expression();
			exp3_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4285 "csl.parser.g"
			
			if (exp3_AST->getFirstChild()->getType() == STRING) {
			throwDeclarationError(_RS("csl_parameter"), _RS("Expecting numeric expression as first argument"), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn());
			}
			
#line 7748 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				expression();
				exp4_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 4293 "csl.parser.g"
				
				if (exp4_AST->getFirstChild()->getType() == STRING) {
				throwDeclarationError(_RS("csl_parameter"), _RS("Expecting numeric expression as second argument"), currentFilename.getRealLine(exp4_AST->getLine()), exp4_AST->getColumn());
				}
				
#line 7763 "CslParser.cpp"
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			match(RPAREN);
#line 4303 "csl.parser.g"
			
			declareObject(_RS(id2_AST->getText()), NSSymbolTable::TPARAM_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			defineObject(_RS(id2_AST->getText()), NSSymbolTable::TPARAM_DECL, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 7782 "CslParser.cpp"
		}
		else {
			goto _loop215;
		}
		
	}
	_loop215:;
	} // ( ... )*
	}
	csl_parameter_declaration_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_parameter_declaration_AST;
}

void CslParser::csl_unit_definition(
	RefString objectName, NSSymbolTable::EObjType type, RefString inheritanceId, TInt inheritanceLine, TInt inheritanceColumn
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_unit_definition_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lc = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lc_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST decl_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ic_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3138 "csl.parser.g"
	
	TInt  nrCstor = 0;
	TBool wasCstor = FALSE;
	RefCslAST temp;
	
#line 7812 "CslParser.cpp"
	
	try {      // for error handling
		{
		lc = LT(1);
		lc_AST = astFactory->create(lc);
		match(LCURLY);
#line 3149 "csl.parser.g"
		//add false vertex to AST to tell that scope holder defnition is next
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CSL_UNIT_DEFINITION,"CSL_UNIT_DEFINITION"))))); 
		//set real filename + line of the fake vertex
		setCurrentFilename(temp, lc_AST->getColumn(), currentFilename.getLine(lc_AST->getLine()));
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
		
		//symTree define object @objectName
		declareObject(objectName, type, symTree, currentFilename.getFilename(), temp->getLine(), temp->getColumn());
		defineObject(objectName, type, symTree, currentFilename.getFilename(), temp->getLine(), temp->getColumn());
		//enter symTree scope of @objectName
		symTree->enterScope(objectName); 
		
		//inheritance checks
		if (inheritanceId) {
		NSSymbolTable::RefCSymNode parent = symTree->lookup(inheritanceId);
		if (!parent.get()) {
		RefString error = _RS("Inherited object '");
		error->append( *objectName);
		error->append( "' not found in scope");
		throwDeclarationError(getScopeHolderTypeStr(type), error, currentFilename.getRealLine(inheritanceLine), inheritanceColumn);
		}
		else if (NSSymbolTable::TISAE_DECL != type) {//inheritance allowed only for csl_isa_element objects
		RefString error = _RS("Inheritance is only allowed for type 'csl_isa_element'");
		throwDeclarationError(getScopeHolderTypeStr(type), error, currentFilename.getRealLine(inheritanceLine), inheritanceColumn);
		}
		else if (NSSymbolTable::TISAE_DECL != parent->getType()) {//inheritance allowed only from csl_isa_elements
		RefString error = _RS("Inherited object '");
		error->append( *objectName);
		error->append( "' is only allowed to be of type 'csl_isa_element'");
		throwDeclarationError(getTypeStr(type), error, currentFilename.getRealLine(inheritanceLine), inheritanceColumn);
		}
		//symTree add the children on the inherited object object to the current object
		NSSymbolTable::RefTMap_RefString_RefCSymNode children = parent->getChildren();
		if (children.get()) {
		TMap_RefString_RefCSymNode::iterator iter = children->begin();
		for (; children->end() != iter; ++iter) {
		if (!iter->second->isUserDefined()) {//symTree adding the objects from the inherited object to the current object
		declareObject(iter->first, iter->second->getType(), symTree, currentFilename.getFilename(), temp->getLine(), lc->getColumn());
		defineObject(iter->first, iter->second->getType(), symTree, currentFilename.getFilename(), temp->getLine(), lc->getColumn());
		}
		else {//symTree adding the instances from the inherited object to the current object
		instantiateObject(iter->first, iter->second->getUserDefinedType()->getName(), symTree, currentFilename.getFilename(),  temp->getLine(), lc->getColumn());
		}
		}
		}
		}
		
#line 7867 "CslParser.cpp"
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case K_CSL_UNIT:
			case K_CSL_LIST:
			case K_CSL_INTERFACE:
			case K_CSL_REGISTER_FILE:
			case K_CSL_READ_INTERFACE:
			case K_CSL_WRITE_INTERFACE:
			case K_CSL_REGISTER:
			case K_CSL_PORT:
			case K_CSL_SIGNAL:
			case K_CSL_BITRANGE:
			case K_CSL_SIGNAL_GROUP:
			case K_CSL_TESTBENCH:
			case K_CSL_INCLUDE:
			case K_CSL_ISA_FIELD:
			case K_CSL_ISA_ELEMENT:
			case K_CSL_ENUM:
			case K_CSL_FIELD:
			case K_CSL_FIFO:
			case K_CSL_MEMORY_MAP:
			case K_CSL_MEMORY_MAP_PAGE:
			case K_CSL_STATE_DATA:
			case K_CSL_VECTOR:
			case K_CSL_MEMORY:
			case K_CSL_MULTI_DIM_BITRANGE:
			case K_CSL_PIPELINE:
			case K_CSL_PIPESTAGE:
			case K_CSL_PARAMETER:
			case K_CONST:
			{
				csl_declaration();
				decl_AST = returnAST;
#line 3197 "csl.parser.g"
				temp->addChild(returnAST);
#line 7904 "CslParser.cpp"
				break;
			}
			case IDENTIFIER:
			{
				wasCstor=csl_inst_or_cstor();
				ic_AST = returnAST;
#line 3200 "csl.parser.g"
				
				temp->addChild(returnAST);
				if (wasCstor) {
				++nrCstor;
				}
				
#line 7918 "CslParser.cpp"
				break;
			}
			case POUND:
			{
				preprocessor_directive();
				break;
			}
			case SEMI:
			{
				match(SEMI);
				break;
			}
			default:
			{
				goto _loop121;
			}
			}
		}
		_loop121:;
		} // ( ... )*
#line 3211 "csl.parser.g"
		//exit the scope of the current object 
		symTree->exitScope();
		// verify that only one constructor appears in the object definition
		if (1 < nrCstor) {
		RefString error = _RS("A scope holder can't have more than one constructor. It currently has ");
		error->append( intToString(nrCstor));
		throwDeclarationError(getTypeStr(type), error, currentFilename.getRealLine(lc->getLine()), lc->getColumn());
		}
		
#line 7949 "CslParser.cpp"
		match(RCURLY);
		}
		csl_unit_definition_AST = antlr::RefCslAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
#line 3225 "csl.parser.g"
		
		args.push_back(intToString(ex.getColumn()));
		args.push_back(ex.getMessage());
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, currentFilename.getLine(ex.getLine()));
		cslParserHasErrors = true;
		consumeUntil( RCURLY );
		
#line 7963 "CslParser.cpp"
	}
	returnAST = csl_unit_definition_AST;
}

void CslParser::expression() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST expression_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST con_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	conditional_expr();
	con_AST = returnAST;
#line 16099 "csl.parser.g"
	//add fake vertex to AST for tree walker
	RefCslAST temp =antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EXPRESSION,"EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST))));
	setCurrentFilename(temp, con_AST->getColumn(), con_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	
#line 7983 "CslParser.cpp"
	}
	expression_AST = antlr::RefCslAST(currentAST.root);
	returnAST = expression_AST;
}

void CslParser::csl_enum_declaration_item() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_enum_declaration_item_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  as = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST as_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2520 "csl.parser.g"
	
	RefCslAST temp;
	
#line 8002 "CslParser.cpp"
	
#line 2528 "csl.parser.g"
	
	//symTree predecl/decl/def options
	TInt predeclarationMask = 0 ;
	TInt declarationMask    = 0 | NSSymbolTable::TDESIGN;
	TInt instantiationMask  = 0 ;
	setDeclarationAndInstantiationOptions(NSSymbolTable::TENUMIT_DECL, predeclarationMask, declarationMask, instantiationMask);
	
#line 8012 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	match(IDENTIFIER);
#line 2538 "csl.parser.g"
	//set real filename + line for id
	setCurrentFilename(id_AST);
	//symTree declare + define id
	declareObject(_RS(id_AST->getText()), NSSymbolTable::TENUMIT_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
	defineObject(_RS(id_AST->getText()), NSSymbolTable::TENUMIT_DECL, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
	//add fake vertex to AST so that walker knows that enum item follows
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ENUM_ITEM,"ENUM_ITEM")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST))));
	setCurrentFilename(temp, id_AST->getColumn(), id_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	
#line 8028 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case ASSIGN:
	{
		as = LT(1);
		as_AST = astFactory->create(as);
		match(ASSIGN);
		{
		expression();
		exp_AST = returnAST;
#line 2552 "csl.parser.g"
		//exp is only allowed to be numeric value (identifiers can be numeric for example enum items :) )
		if (STRING == exp_AST->getFirstChild()->getType()) { 
		throwDeclarationError(_RS("csl_enum"), _RS("Expecting numeric expression in assignment "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
		}
		temp->addChild(returnAST);
		
#line 8046 "CslParser.cpp"
		}
		break;
	}
	case COMMA:
	case RCURLY:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	}
	csl_enum_declaration_item_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_enum_declaration_item_AST;
}

 bool  CslParser::param_list_csl_list() {
#line 3105 "csl.parser.g"
	 bool isIdList;
#line 8069 "CslParser.cpp"
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_csl_list_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	match(LPAREN);
#line 3109 "csl.parser.g"
	isIdList = true;
#line 8080 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3112 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	|| exp_AST->getFirstChild()->getNumberOfChildren() != 1) {
	throwDeclarationError(_RS("csl_list"),  _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 8091 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			expression();
			exp2_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3121 "csl.parser.g"
			
			if (EXPR_PRIMARY_IDENTIFIER != exp2_AST->getFirstChild()->getType()
			|| exp2_AST->getFirstChild()->getNumberOfChildren() != 1) {
			throwDeclarationError(_RS("csl_list"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
			}
			
#line 8106 "CslParser.cpp"
		}
		else {
			goto _loop117;
		}
		
	}
	_loop117:;
	} // ( ... )*
	match(RPAREN);
	}
	param_list_csl_list_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_csl_list_AST;
	return isIdList;
}

TBool  CslParser::csl_inst_or_cstor() {
#line 3238 "csl.parser.g"
	TBool isCstor = FALSE;
#line 8125 "CslParser.cpp"
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_inst_or_cstor_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST inst_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST cstor_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3238 "csl.parser.g"
	
	RefString str         = _RS();
	RefCslAST temp               ;
	
#line 8138 "CslParser.cpp"
	
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	match(IDENTIFIER);
#line 3248 "csl.parser.g"
	//set real filename + line for id
	setCurrentFilename(id_AST);
	str = _RS(id_AST->getText());
	
#line 8149 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case POUND:
	case IDENTIFIER:
	{
		csl_inst(_RS(id_AST->getText()));
		inst_AST = returnAST;
#line 3255 "csl.parser.g"
		//add false vertex to tell walker that a instantiation follows
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CSL_INST,"CSL_INST")))));
		//set the real filename + line of false vertex
		setCurrentFilename(temp, id_AST->getColumn(), id_AST->getLine());
		//add the id and instantiation rule as children of the fake vertex
		temp->addChild(id_AST);
		temp->addChild(returnAST);
		
#line 8166 "CslParser.cpp"
		break;
	}
	case LPAREN:
	{
		csl_cstor();
		cstor_AST = returnAST;
#line 3265 "csl.parser.g"
		//set the return value
		isCstor = TRUE;
		//add false vertex that tells walker that constructor follows
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CSL_CSTOR,"CSL_CSTOR")))));
		//add the id and the constructor rule as children of the fake vertex
		temp->addChild(id_AST);
		temp->addChild(returnAST);
		//verify that the constructor has the same name as the scope it is in
		NSSymbolTable::RefCSymNode currentScope = symTree->getCurrentScope();
		RefString currentScopeName = currentScope->getName();
		if (str->compare(*currentScopeName)) {
		RefString error = _RS("Constructor name '");
		error->append(*str);
		error->append("' is not allowed to have a different name from the name of the scope '");
		error->append(*currentScopeName);
		error->append("'");
		throwDeclarationError(getTypeStr(currentScope->getType()), error, currentFilename.getRealLine(id_AST->getLine()), id_AST->getColumn());
		}
		
#line 8193 "CslParser.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 3287 "csl.parser.g"
	/*set the real filename+line of the fake vertex*/setCurrentFilename(temp, id_AST->getColumn(), id_AST->getLine()); 
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	
#line 8206 "CslParser.cpp"
	}
	csl_inst_or_cstor_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_inst_or_cstor_AST;
	return isCstor;
}

void CslParser::csl_inst(
	RefString str
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_inst_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	{
	switch ( LA(1)) {
	case POUND:
	{
		parameter_overridding_instantiation();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case IDENTIFIER:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 3308 "csl.parser.g"
	//set real filename + line for id
	setCurrentFilename(id_AST);
	//instantiate object id with type str
	RefString name = _RS(id_AST->getText());
	instantiateObject(name, str, symTree, currentFilename.getFilename(), id_AST->getLine(), id_AST->getColumn());
	
#line 8260 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case LPAREN:
	{
		lp1 = LT(1);
		lp1_AST = astFactory->create(lp1);
		match(LPAREN);
		{
		switch ( LA(1)) {
		case DOT:
		{
			param_list_formal_to_actual_mapping();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			break;
		}
		case K_GET_INTERFACE:
		case K_GET_SIGNAL_VALUE:
		case K_GET_TYPE:
		case K_GET_ATTR:
		case K_GET_UNIT_PREFIX:
		case K_GET_SIGNAL_PREFIX:
		case K_GET_SIGNAL_PREFIX_LOCAL:
		case K_GET_DEPTH:
		case K_GET_ATTRIBUTES:
		case K_GET_INPUT_FIELD:
		case K_GET_OUTPUT_FIELD:
		case K_GET_LOCK_ENABLE_BIT:
		case K_GET_CNT_DIR_SIGNAL:
		case K_GET_WIDTH:
		case K_GET_DIM_WIDTH:
		case K_GET_BITRANGE:
		case K_GET_DIM_BITRANGE:
		case K_GET_LOWER_INDEX:
		case K_GET_DIM_LOWER_INDEX:
		case K_GET_UPPER_INDEX:
		case K_GET_DIM_UPPER_INDEX:
		case K_GET_OFFSET:
		case K_GET_DIM_OFFSET:
		case K_GET_NUMBER_OF_DIMENSIONS:
		case K_GET_CELL:
		case K_GET_TRANSACTION_TIMEOUT_COUNT:
		case K_GET_SIMULATION_TIMEOUT_COUNT:
		case K_GET_VC_ID:
		case K_GET_VC_MAX_NUM_STATES:
		case K_GET_NAME:
		case K_GET_FILENAME:
		case K_GET_MAX_NUM_VECTORS:
		case K_GET_MAX_ERROR_COUNT:
		case K_GET_MNEMONIC:
		case K_GET_VALUE:
		case K_GET_ENUM:
		case K_GET_ENUM_ITEM:
		case K_GET_NEXT_ADDRESS:
		case K_GET_LOWER_BOUND:
		case K_GET_UPPER_BOUND:
		case K_GET_DATA_WORD_WIDTH:
		case K_GET_ALIGNMENT:
		case K_GET_ENDIANESS:
		case K_GET_NAME_LENGTH:
		case K_GET_PREFIX:
		case K_GET_SUFFIX:
		case K_GET_SYMBOL_LENGTH:
		case K_GET_ADDR_INCREMENT:
		case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
		case K_GET_VC_NAME:
		case K_GET_VC_HEADER_COMMENT:
		case K_GET_VC_CLOCK:
		case K_GET_VC_RESET:
		case K_GET_VC_STALL:
		case K_GET_VC_COMPARE_TRIGGER:
		case K_GET_VC_START_GENERATION_TRIGGER:
		case K_GET_VC_END_GENERATION_TRIGGER:
		case K_GET_VC_CAPTURE_EDGE_TYPE:
		case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
		case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
		case K_GET_VC_TIMEOUT:
		case K_GET_VC_OUTPUT_FILENAME:
		case K_GET_VC_CPP_RD_NAME:
		case K_GET_VC_CPP_WR_NAME:
		case K_GET_VC_MODULE:
		case K_GET_OUTPUT_FILENAME:
		case K_GET_RESET_NAME:
		case K_GET_CLOCK_NAME:
		case K_GET_RD_CLOCK_NAME:
		case K_GET_WR_CLOCK_NAME:
		case K_GET_PUSH_NAME:
		case K_GET_POP_NAME:
		case K_GET_FULL_NAME:
		case K_GET_EMPTY_NAME:
		case K_GET_WR_DATA_NAME:
		case K_GET_RD_DATA_NAME:
		case K_GET_VALID_NAME:
		case K_GET_WR_ADDR_NAME:
		case K_GET_RD_ADDR_NAME:
		case K_GET_WR_EN_NAME:
		case K_GET_RD_EN_NAME:
		case K_GET_MSB:
		case K_GET_LSB:
		case K_GET_RADIX:
		case MINUS:
		case LCURLY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case STRING:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case K_DATA_GENERATION:
		{
			expression();
			exp_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3320 "csl.parser.g"
			//only numeric or identifier allowed
			if (STRING == exp_AST->getFirstChild()->getType()) {
			throwDeclarationError(str, _RS("Expecting numeric expression or identifier as argument of instantiation"), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
			}
			
#line 8388 "CslParser.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		break;
	}
	case COMMA:
	case SEMI:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			id2 = LT(1);
			id2_AST = astFactory->create(id2);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
			match(IDENTIFIER);
#line 3330 "csl.parser.g"
			//set real filename + line for id2
			setCurrentFilename(id2_AST);
			//instantiate object id2 with type str
			RefString name = _RS(id2_AST->getText());
			instantiateObject(name, str, symTree, currentFilename.getFilename(), id2_AST->getLine(), id2_AST->getColumn());
			
#line 8426 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				lp2 = LT(1);
				lp2_AST = astFactory->create(lp2);
				match(LPAREN);
				{
				switch ( LA(1)) {
				case DOT:
				{
					param_list_formal_to_actual_mapping();
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					break;
				}
				case K_GET_INTERFACE:
				case K_GET_SIGNAL_VALUE:
				case K_GET_TYPE:
				case K_GET_ATTR:
				case K_GET_UNIT_PREFIX:
				case K_GET_SIGNAL_PREFIX:
				case K_GET_SIGNAL_PREFIX_LOCAL:
				case K_GET_DEPTH:
				case K_GET_ATTRIBUTES:
				case K_GET_INPUT_FIELD:
				case K_GET_OUTPUT_FIELD:
				case K_GET_LOCK_ENABLE_BIT:
				case K_GET_CNT_DIR_SIGNAL:
				case K_GET_WIDTH:
				case K_GET_DIM_WIDTH:
				case K_GET_BITRANGE:
				case K_GET_DIM_BITRANGE:
				case K_GET_LOWER_INDEX:
				case K_GET_DIM_LOWER_INDEX:
				case K_GET_UPPER_INDEX:
				case K_GET_DIM_UPPER_INDEX:
				case K_GET_OFFSET:
				case K_GET_DIM_OFFSET:
				case K_GET_NUMBER_OF_DIMENSIONS:
				case K_GET_CELL:
				case K_GET_TRANSACTION_TIMEOUT_COUNT:
				case K_GET_SIMULATION_TIMEOUT_COUNT:
				case K_GET_VC_ID:
				case K_GET_VC_MAX_NUM_STATES:
				case K_GET_NAME:
				case K_GET_FILENAME:
				case K_GET_MAX_NUM_VECTORS:
				case K_GET_MAX_ERROR_COUNT:
				case K_GET_MNEMONIC:
				case K_GET_VALUE:
				case K_GET_ENUM:
				case K_GET_ENUM_ITEM:
				case K_GET_NEXT_ADDRESS:
				case K_GET_LOWER_BOUND:
				case K_GET_UPPER_BOUND:
				case K_GET_DATA_WORD_WIDTH:
				case K_GET_ALIGNMENT:
				case K_GET_ENDIANESS:
				case K_GET_NAME_LENGTH:
				case K_GET_PREFIX:
				case K_GET_SUFFIX:
				case K_GET_SYMBOL_LENGTH:
				case K_GET_ADDR_INCREMENT:
				case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
				case K_GET_VC_NAME:
				case K_GET_VC_HEADER_COMMENT:
				case K_GET_VC_CLOCK:
				case K_GET_VC_RESET:
				case K_GET_VC_STALL:
				case K_GET_VC_COMPARE_TRIGGER:
				case K_GET_VC_START_GENERATION_TRIGGER:
				case K_GET_VC_END_GENERATION_TRIGGER:
				case K_GET_VC_CAPTURE_EDGE_TYPE:
				case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
				case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
				case K_GET_VC_TIMEOUT:
				case K_GET_VC_OUTPUT_FILENAME:
				case K_GET_VC_CPP_RD_NAME:
				case K_GET_VC_CPP_WR_NAME:
				case K_GET_VC_MODULE:
				case K_GET_OUTPUT_FILENAME:
				case K_GET_RESET_NAME:
				case K_GET_CLOCK_NAME:
				case K_GET_RD_CLOCK_NAME:
				case K_GET_WR_CLOCK_NAME:
				case K_GET_PUSH_NAME:
				case K_GET_POP_NAME:
				case K_GET_FULL_NAME:
				case K_GET_EMPTY_NAME:
				case K_GET_WR_DATA_NAME:
				case K_GET_RD_DATA_NAME:
				case K_GET_VALID_NAME:
				case K_GET_WR_ADDR_NAME:
				case K_GET_RD_ADDR_NAME:
				case K_GET_WR_EN_NAME:
				case K_GET_RD_EN_NAME:
				case K_GET_MSB:
				case K_GET_LSB:
				case K_GET_RADIX:
				case MINUS:
				case LCURLY:
				case LPAREN:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case IDENTIFIER:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case K_DATA_GENERATION:
				{
					expression();
					exp2_AST = returnAST;
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3342 "csl.parser.g"
					//only numeric or id allowed
					if (STRING == exp2_AST->getFirstChild()->getType()) {
					throwDeclarationError(str, _RS("Expecting numeric expression or identifier as argument of instantiation"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
					}
					
#line 8554 "CslParser.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				match(RPAREN);
				break;
			}
			case COMMA:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
		}
		else {
			goto _loop133;
		}
		
	}
	_loop133:;
	} // ( ... )*
	match(SEMI);
	}
	csl_inst_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_inst_AST;
}

void CslParser::csl_cstor() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_cstor_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3397 "csl.parser.g"
	
	TBool wasAssignment = FALSE;
	
#line 8609 "CslParser.cpp"
	
	{
	match(LPAREN);
	{
	switch ( LA(1)) {
	case IDENTIFIER:
	{
		id1 = LT(1);
		id1_AST = astFactory->create(id1);
		match(IDENTIFIER);
#line 3405 "csl.parser.g"
		setCurrentFilename(id1_AST);
#line 8622 "CslParser.cpp"
		{
		switch ( LA(1)) {
		case ASSIGN:
		{
			lp1 = LT(1);
			lp1_AST = astFactory->create(lp1);
			match(ASSIGN);
			expression();
			exp_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 3406 "csl.parser.g"
			wasAssignment = TRUE;
#line 8635 "CslParser.cpp"
			break;
		}
		case COMMA:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 3408 "csl.parser.g"
		//add false vertex to AST to let the walker know that a unit parameter follows
		RefCslAST temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(UNIT_PARAMETER,"UNIT_PARAMETER")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(id1_AST))));
		//set real filename + line of fake vertex
		setCurrentFilename(temp, id1_AST->getColumn(), id1_AST->getLine());
		//if the optional assignment is there add it as the child of the fake vertex
		if (wasAssignment) {
		temp->addChild(returnAST);
		wasAssignment = FALSE;
		}
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
		
#line 8661 "CslParser.cpp"
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				id2 = LT(1);
				id2_AST = astFactory->create(id2);
				match(IDENTIFIER);
#line 3420 "csl.parser.g"
				setCurrentFilename(id2_AST);
#line 8671 "CslParser.cpp"
				{
				switch ( LA(1)) {
				case ASSIGN:
				{
					lp2 = LT(1);
					lp2_AST = astFactory->create(lp2);
					match(ASSIGN);
					expression();
					exp2_AST = returnAST;
#line 3421 "csl.parser.g"
					wasAssignment = TRUE;
#line 8683 "CslParser.cpp"
					break;
				}
				case COMMA:
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
#line 3423 "csl.parser.g"
				//add false vertex to AST to let the walker know that a unit parameter follows
				RefCslAST temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(UNIT_PARAMETER,"UNIT_PARAMETER")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST))));
				//set real filename + line of fake vertex
				setCurrentFilename(temp, id2_AST->getColumn(), id2_AST->getColumn());
				//if the optional assignment is there add it as the child of the fake vertex
				if (wasAssignment) {
				temp->addChild(returnAST);
				wasAssignment = FALSE;
				}
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
				
#line 8709 "CslParser.cpp"
			}
			else {
				goto _loop147;
			}
			
		}
		_loop147:;
		} // ( ... )*
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	match(LCURLY);
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case K_SET_TYPE:
		case K_SET_ATTR:
		case K_SET_UNIT_PREFIX:
		case K_SET_SIGNAL_PREFIX:
		case K_SET_SIGNAL_PREFIX_LOCAL:
		case K_SET_DEPTH:
		case K_SET_ATTRIBUTES:
		case K_SET_WIDTH:
		case K_SET_DIM_WIDTH:
		case K_SET_BITRANGE:
		case K_SET_DIM_BITRANGE:
		case K_SET_RANGE:
		case K_SET_DIM_RANGE:
		case K_SET_OFFSET:
		case K_SET_DIM_OFFSET:
		case K_SET_NUMBER_OF_DIMENSIONS:
		case K_SET_INSTANCE_ALTERATION_BIT:
		case K_SET_TESTBENCH_VERILOG_FILENAME:
		case K_SET_NAME:
		case K_SET_DIRECTION:
		case K_SET_MEM_INSTANCE_NAME:
		case K_SET_VC_OUTPUT_FILENAME:
		case K_SET_RADIX:
		case K_SET_MNEMONIC:
		case K_SET_PHYSICAL_IMPLEMENTATION:
		case K_SET_UNIT_ID:
		case K_SET_VALUE:
		case K_SET_ENUM:
		case K_SET_ENUM_ITEM:
		case K_SET_FIELD:
		case K_SET_POSITION:
		case K_SET_NEXT:
		case K_SET_PREVIOUS:
		case K_SET_FIELD_POSITION:
		case K_SET_TOP_UNIT:
		case K_SET_ADDRESS_INCREMENT:
		case K_SET_NEXT_ADDRESS:
		case K_SET_ACCESS_RIGHTS:
		case K_SET_ACCESS_RIGHTS_ENUM:
		case K_SET_DATA_WORD_WIDTH:
		case K_SET_ALIGNMENT:
		case K_SET_ENDIANESS:
		case K_SET_PREFIX:
		case K_SET_UNIT_NAME:
		case K_SET_SUFFIX:
		case K_SET_SYMBOL_MAX_LENGTH:
		case K_SET_VC_START_GENERATION_TRIGGER:
		case K_SET_VC_MAX_NUMBER_OF_MISMATCHES:
		case K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
		case K_SET_VC_VALID_OUTPUT_TRANSACTION:
		case K_SET_VC_COMPARE_TRIGGER:
		case K_SET_VC_MAX_CYCLES:
		case K_SET_VC_NAME:
		case K_SET_VC_HEADER_COMMENT:
		case K_SET_VERSION:
		case K_SET_VC_CLOCK:
		case K_SET_VC_RESET:
		case K_SET_VC_STALL:
		case K_SET_VC_END_GENERATION_TRIGGER:
		case K_SET_VC_CAPTURE_EDGE_TYPE:
		case K_SET_RESET_NAME:
		case K_SET_CLOCK_NAME:
		case K_SET_RD_CLOCK_NAME:
		case K_SET_WR_CLOCK_NAME:
		case K_SET_PUSH_NAME:
		case K_SET_POP_NAME:
		case K_SET_FULL_NAME:
		case K_SET_EMPTY_NAME:
		case K_SET_WR_DATA_NAME:
		case K_SET_RD_DATA_NAME:
		case K_SET_VALID_NAME:
		case K_SET_WR_ADDR_NAME:
		case K_SET_RD_ADDR_NAME:
		case K_SET_WR_EN_NAME:
		case K_SET_RD_EN_NAME:
		case K_SET_NUM_RD_IFC:
		case K_SET_NUM_WR_IFC:
		case K_SET_CLOCK:
		case K_ADD_PORT_LIST:
		case K_REVERSE:
		case K_OVERRIDE_PARAMETER:
		case K_CREATE_RTL_MODULE:
		case K_DIRECTIVE:
		case K_ADD_LOGIC:
		case K_MERGE:
		case K_EXCLUSION_LIST:
		case K_INCLUDE_ONLY:
		case K_GEN_DECODER:
		case K_ADD_ALLOWED_RANGE:
		case K_ADD_ADDRESS_RANGE:
		case K_ADD_RESERVED_ADDRESS_RANGE:
		case K_ADD:
		case K_AUTO_GEN_MEMORY_MAP:
		case K_ADD_TO_MEMORY_MAP:
		case K_PIPESTAGE_NAMING_CONVENTION:
		case K_INITIALIZE_RANDOM_VALUES:
		case K_INITIALIZE_RANDOM:
		case K_GEN_UNIQUE_RTL_MODULES:
		case K_NO_PREFIX_COMMAND:
		case K_DO_NOT_GEN_RTL:
		case K_DO_NOT_GEN_CPP:
		case K_REGISTER_IOS:
		case K_CONNECT_UNITS:
		case K_CONNECT_BY_PATTERN:
		case K_CONNECT_BY_NAME:
		case ASSIGN:
		case LCURLY:
		case IDENTIFIER:
		{
			csl_command();
#line 3438 "csl.parser.g"
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 8847 "CslParser.cpp"
			break;
		}
		case POUND:
		{
			preprocessor_directive();
			break;
		}
		case SEMI:
		{
			match(SEMI);
			break;
		}
		default:
		{
			goto _loop149;
		}
		}
	}
	_loop149:;
	} // ( ... )*
	match(RCURLY);
	}
	csl_cstor_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_cstor_AST;
}

void CslParser::parameter_overridding_instantiation() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST parameter_overridding_instantiation_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST f2a_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3360 "csl.parser.g"
	
	TBool wasExpr = FALSE;
	RefCslAST temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(UNIT_PARAMETER,"UNIT_PARAMETER")))));
	
#line 8886 "CslParser.cpp"
	
	{
	match(POUND);
	match(LPAREN);
	{
	switch ( LA(1)) {
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case COMMA:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case RPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		{
		switch ( LA(1)) {
		case K_GET_INTERFACE:
		case K_GET_SIGNAL_VALUE:
		case K_GET_TYPE:
		case K_GET_ATTR:
		case K_GET_UNIT_PREFIX:
		case K_GET_SIGNAL_PREFIX:
		case K_GET_SIGNAL_PREFIX_LOCAL:
		case K_GET_DEPTH:
		case K_GET_ATTRIBUTES:
		case K_GET_INPUT_FIELD:
		case K_GET_OUTPUT_FIELD:
		case K_GET_LOCK_ENABLE_BIT:
		case K_GET_CNT_DIR_SIGNAL:
		case K_GET_WIDTH:
		case K_GET_DIM_WIDTH:
		case K_GET_BITRANGE:
		case K_GET_DIM_BITRANGE:
		case K_GET_LOWER_INDEX:
		case K_GET_DIM_LOWER_INDEX:
		case K_GET_UPPER_INDEX:
		case K_GET_DIM_UPPER_INDEX:
		case K_GET_OFFSET:
		case K_GET_DIM_OFFSET:
		case K_GET_NUMBER_OF_DIMENSIONS:
		case K_GET_CELL:
		case K_GET_TRANSACTION_TIMEOUT_COUNT:
		case K_GET_SIMULATION_TIMEOUT_COUNT:
		case K_GET_VC_ID:
		case K_GET_VC_MAX_NUM_STATES:
		case K_GET_NAME:
		case K_GET_FILENAME:
		case K_GET_MAX_NUM_VECTORS:
		case K_GET_MAX_ERROR_COUNT:
		case K_GET_MNEMONIC:
		case K_GET_VALUE:
		case K_GET_ENUM:
		case K_GET_ENUM_ITEM:
		case K_GET_NEXT_ADDRESS:
		case K_GET_LOWER_BOUND:
		case K_GET_UPPER_BOUND:
		case K_GET_DATA_WORD_WIDTH:
		case K_GET_ALIGNMENT:
		case K_GET_ENDIANESS:
		case K_GET_NAME_LENGTH:
		case K_GET_PREFIX:
		case K_GET_SUFFIX:
		case K_GET_SYMBOL_LENGTH:
		case K_GET_ADDR_INCREMENT:
		case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
		case K_GET_VC_NAME:
		case K_GET_VC_HEADER_COMMENT:
		case K_GET_VC_CLOCK:
		case K_GET_VC_RESET:
		case K_GET_VC_STALL:
		case K_GET_VC_COMPARE_TRIGGER:
		case K_GET_VC_START_GENERATION_TRIGGER:
		case K_GET_VC_END_GENERATION_TRIGGER:
		case K_GET_VC_CAPTURE_EDGE_TYPE:
		case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
		case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
		case K_GET_VC_TIMEOUT:
		case K_GET_VC_OUTPUT_FILENAME:
		case K_GET_VC_CPP_RD_NAME:
		case K_GET_VC_CPP_WR_NAME:
		case K_GET_VC_MODULE:
		case K_GET_OUTPUT_FILENAME:
		case K_GET_RESET_NAME:
		case K_GET_CLOCK_NAME:
		case K_GET_RD_CLOCK_NAME:
		case K_GET_WR_CLOCK_NAME:
		case K_GET_PUSH_NAME:
		case K_GET_POP_NAME:
		case K_GET_FULL_NAME:
		case K_GET_EMPTY_NAME:
		case K_GET_WR_DATA_NAME:
		case K_GET_RD_DATA_NAME:
		case K_GET_VALID_NAME:
		case K_GET_WR_ADDR_NAME:
		case K_GET_RD_ADDR_NAME:
		case K_GET_WR_EN_NAME:
		case K_GET_RD_EN_NAME:
		case K_GET_MSB:
		case K_GET_LSB:
		case K_GET_RADIX:
		case MINUS:
		case LCURLY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case STRING:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case K_DATA_GENERATION:
		{
			expression();
			exp_AST = returnAST;
#line 3371 "csl.parser.g"
			temp->addChild(exp_AST); wasExpr = TRUE;
#line 9107 "CslParser.cpp"
			break;
		}
		case COMMA:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 3373 "csl.parser.g"
		
		if (!wasExpr) { temp->addChild(antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SKIP_PARAMETER,"K_SKIP_PARAMETER")))))); }
		
#line 9125 "CslParser.cpp"
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
#line 3377 "csl.parser.g"
				if (wasExpr) { wasExpr = FALSE; }
#line 9132 "CslParser.cpp"
				{
				switch ( LA(1)) {
				case K_GET_INTERFACE:
				case K_GET_SIGNAL_VALUE:
				case K_GET_TYPE:
				case K_GET_ATTR:
				case K_GET_UNIT_PREFIX:
				case K_GET_SIGNAL_PREFIX:
				case K_GET_SIGNAL_PREFIX_LOCAL:
				case K_GET_DEPTH:
				case K_GET_ATTRIBUTES:
				case K_GET_INPUT_FIELD:
				case K_GET_OUTPUT_FIELD:
				case K_GET_LOCK_ENABLE_BIT:
				case K_GET_CNT_DIR_SIGNAL:
				case K_GET_WIDTH:
				case K_GET_DIM_WIDTH:
				case K_GET_BITRANGE:
				case K_GET_DIM_BITRANGE:
				case K_GET_LOWER_INDEX:
				case K_GET_DIM_LOWER_INDEX:
				case K_GET_UPPER_INDEX:
				case K_GET_DIM_UPPER_INDEX:
				case K_GET_OFFSET:
				case K_GET_DIM_OFFSET:
				case K_GET_NUMBER_OF_DIMENSIONS:
				case K_GET_CELL:
				case K_GET_TRANSACTION_TIMEOUT_COUNT:
				case K_GET_SIMULATION_TIMEOUT_COUNT:
				case K_GET_VC_ID:
				case K_GET_VC_MAX_NUM_STATES:
				case K_GET_NAME:
				case K_GET_FILENAME:
				case K_GET_MAX_NUM_VECTORS:
				case K_GET_MAX_ERROR_COUNT:
				case K_GET_MNEMONIC:
				case K_GET_VALUE:
				case K_GET_ENUM:
				case K_GET_ENUM_ITEM:
				case K_GET_NEXT_ADDRESS:
				case K_GET_LOWER_BOUND:
				case K_GET_UPPER_BOUND:
				case K_GET_DATA_WORD_WIDTH:
				case K_GET_ALIGNMENT:
				case K_GET_ENDIANESS:
				case K_GET_NAME_LENGTH:
				case K_GET_PREFIX:
				case K_GET_SUFFIX:
				case K_GET_SYMBOL_LENGTH:
				case K_GET_ADDR_INCREMENT:
				case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
				case K_GET_VC_NAME:
				case K_GET_VC_HEADER_COMMENT:
				case K_GET_VC_CLOCK:
				case K_GET_VC_RESET:
				case K_GET_VC_STALL:
				case K_GET_VC_COMPARE_TRIGGER:
				case K_GET_VC_START_GENERATION_TRIGGER:
				case K_GET_VC_END_GENERATION_TRIGGER:
				case K_GET_VC_CAPTURE_EDGE_TYPE:
				case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
				case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
				case K_GET_VC_TIMEOUT:
				case K_GET_VC_OUTPUT_FILENAME:
				case K_GET_VC_CPP_RD_NAME:
				case K_GET_VC_CPP_WR_NAME:
				case K_GET_VC_MODULE:
				case K_GET_OUTPUT_FILENAME:
				case K_GET_RESET_NAME:
				case K_GET_CLOCK_NAME:
				case K_GET_RD_CLOCK_NAME:
				case K_GET_WR_CLOCK_NAME:
				case K_GET_PUSH_NAME:
				case K_GET_POP_NAME:
				case K_GET_FULL_NAME:
				case K_GET_EMPTY_NAME:
				case K_GET_WR_DATA_NAME:
				case K_GET_RD_DATA_NAME:
				case K_GET_VALID_NAME:
				case K_GET_WR_ADDR_NAME:
				case K_GET_RD_ADDR_NAME:
				case K_GET_WR_EN_NAME:
				case K_GET_RD_EN_NAME:
				case K_GET_MSB:
				case K_GET_LSB:
				case K_GET_RADIX:
				case MINUS:
				case LCURLY:
				case LPAREN:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case IDENTIFIER:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case K_DATA_GENERATION:
				{
					expression();
					exp2_AST = returnAST;
#line 3378 "csl.parser.g"
					temp->addChild(exp2_AST); wasExpr = TRUE;
#line 9242 "CslParser.cpp"
					break;
				}
				case COMMA:
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
#line 3379 "csl.parser.g"
				if (!wasExpr) { temp->addChild(antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SKIP_PARAMETER,"K_SKIP_PARAMETER")))))); }
#line 9258 "CslParser.cpp"
			}
			else {
				goto _loop140;
			}
			
		}
		_loop140:;
		} // ( ... )*
		break;
	}
	case DOT:
	{
		param_list_formal_to_actual_mapping();
		f2a_AST = returnAST;
#line 3381 "csl.parser.g"
		temp->addChild(f2a_AST);
#line 9275 "CslParser.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	parameter_overridding_instantiation_AST = antlr::RefCslAST(currentAST.root);
#line 3385 "csl.parser.g"
	
	parameter_overridding_instantiation_AST = temp;
	
#line 9290 "CslParser.cpp"
	currentAST.root = parameter_overridding_instantiation_AST;
	if ( parameter_overridding_instantiation_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
		parameter_overridding_instantiation_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		  currentAST.child = parameter_overridding_instantiation_AST->getFirstChild();
	else
		currentAST.child = parameter_overridding_instantiation_AST;
	currentAST.advanceChildToEnd();
	}
	parameter_overridding_instantiation_AST = antlr::RefCslAST(currentAST.root);
	returnAST = parameter_overridding_instantiation_AST;
}

void CslParser::param_list_formal_to_actual_mapping() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_formal_to_actual_mapping_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST f2a_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	f2a_pair_expr();
	f2a_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			f2a_pair_expr();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {
			goto _loop510;
		}
		
	}
	_loop510:;
	} // ( ... )*
	param_list_formal_to_actual_mapping_AST = antlr::RefCslAST(currentAST.root);
#line 13618 "csl.parser.g"
	
	param_list_formal_to_actual_mapping_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING,"PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(param_list_formal_to_actual_mapping_AST))));
	setCurrentFilename(param_list_formal_to_actual_mapping_AST, f2a_AST->getColumn(), f2a_AST->getLine());
	
#line 9332 "CslParser.cpp"
	currentAST.root = param_list_formal_to_actual_mapping_AST;
	if ( param_list_formal_to_actual_mapping_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
		param_list_formal_to_actual_mapping_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		  currentAST.child = param_list_formal_to_actual_mapping_AST->getFirstChild();
	else
		currentAST.child = param_list_formal_to_actual_mapping_AST;
	currentAST.advanceChildToEnd();
	param_list_formal_to_actual_mapping_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_formal_to_actual_mapping_AST;
}

void CslParser::param_list_csl_port() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_csl_port_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3589 "csl.parser.g"
	
	TBool isDirOutput  = FALSE;
	TBool canBeComma = TRUE;
	TBool canBeRange = TRUE;
	TBool wasRange = FALSE;
	
#line 9359 "CslParser.cpp"
	
	{
	expression();
	exp1_AST = returnAST;
#line 3601 "csl.parser.g"
	//check if expression is port direction and add false vertex to AST if so; if expression is 
	// port hierarchial identifier then add it to AST
	RefCslAST exp1 = exp1_AST;
	exp1 = exp1->getFirstChild();
	//if expression doesn't have EXPR_PRIMARY_IDENTIFIER or FUNCTION_CALL_RET_ID type then it can not be port
	// direction or port hierarchical identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp1->getType()
	&& FUNCTION_CALL_RET_ID != exp1->getType()) { 
	throwDeclarationError(_RS("csl_port"), _RS("Expecting port direction or port hierarchical identifier as first argument"), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); 
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
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INPUT,"K_INPUT")))));
	break;
	case K_LITERAL_OUTPUT :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OUTPUT,"K_OUTPUT")))));
	isDirOutput = TRUE;// 'reg', 'integer' and 'time' types require 'output' direction
	break;
	case K_LITERAL_INOUT :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INOUT,"K_INOUT")))));
	break;
	default :
	canBeComma = FALSE;//expression has only one identifier, but that identifier is not port direction 
	// so it must be a port hierarchical identifier 
	}
	if (temporary) { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary)); 
	setCurrentFilename(temporary, exp1_AST->getColumn(), exp1_AST->getLine()); }
	else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));}
	}
	}// if expression if FUNCTION_CALL_RET_id add it to AST
	else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST)); }
	
#line 9412 "CslParser.cpp"
	{
	if (((LA(1) == COMMA))&&(canBeComma)) {
		match(COMMA);
		expression();
		exp2_AST = returnAST;
#line 3651 "csl.parser.g"
		
		TBool error = FALSE;
		if (EXPR_PRIMARY_IDENTIFIER == exp2_AST->getFirstChild()->getType()) {
		
		if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp2_AST->getFirstChild()->getFirstChild()->getFirstChild()
		&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp2_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
		
		RefString literalString = _RS(exp2_AST->getFirstChild()->getFirstChild()->getText());
		TLInt literalEnum = getLiteralEnum(literalString);
		RefCslAST temporary;
		TBool expectingOutput = FALSE;
		switch (literalEnum) {
		case K_LITERAL_WIRE :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WIRE,"K_WIRE")))));
		break;
		case K_LITERAL_REG :
		if (!isDirOutput) {// 'reg', 'integer' and 'time' types require 'output' direction
		expectingOutput = TRUE;
		}
		else {
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REG,"K_REG")))));
		}
		break;
		case K_LITERAL_TRI :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI,"K_TRI")))));
		break;
		case K_LITERAL_TRIAND :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIAND,"K_TRIAND")))));
		break;
		case K_LITERAL_SUPPLY0 :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SUPPLY0,"K_SUPPLY0")))));
		break;
		case K_LITERAL_SUPPLY1 :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SUPPLY1,"K_SUPPLY1")))));
		break;
		case K_LITERAL_TRIOR :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIOR,"K_TRIOR")))));
		break;
		case K_LITERAL_TRI0 :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI0,"K_TRI0")))));
		break;
		case K_LITERAL_TRI1 :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI1,"K_TRI1")))));
		break;
		case K_LITERAL_TRIREG :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIREG,"K_TRIREG")))));
		break;
		case K_LITERAL_WAND :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WAND,"K_WAND")))));
		break;
		case K_LITERAL_WOR :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WOR,"K_WOR")))));
		break;
		case K_LITERAL_INTEGER :
		if (!isDirOutput) {// 'reg', 'integer' and 'time' types require 'output' direction
		expectingOutput = TRUE;
		}
		else {
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INTEGER,"K_INTEGER")))));
		canBeComma = FALSE;//integer does not allow bitrange
		}
		break;
		case K_LITERAL_TIME :
		if (!isDirOutput) {// 'reg', 'integer' and 'time' types require 'output' direction
		expectingOutput = TRUE;
		}
		else {
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TIME,"K_TIME")))));
		}
		break;
		default :
		error = TRUE;
		}
		if (expectingOutput) {
		throwDeclarationError(_RS("csl_port"), _RS("'reg', 'integer' and 'time' types require 'output' direction"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); 
		}
		
		if (!error) {
		
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
		setCurrentFilename(temporary, exp2_AST->getColumn(), exp2_AST->getLine());
		}
		}
		else { error = TRUE; }
		}
		else if (FUNCTION_CALL_RET_ID == exp2_AST->getFirstChild()->getType()) {
		
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		wasRange = TRUE;
		}
		else { error = TRUE; }
		
		if (error) {
		if (STRING == exp2_AST->getFirstChild()->getType()) {
		
		throwDeclarationError(_RS("csl_port"), _RS("Expecting port type or range as second argument"), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); 
		}
		else {
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		wasRange = TRUE;
		}
		}
		
#line 9522 "CslParser.cpp"
		{
		if (((LA(1) == COMMA))&&(canBeRange)) {
			match(COMMA);
			expression();
			exp3_AST = returnAST;
#line 3757 "csl.parser.g"
			//exp3 can only be numeric
			if (STRING == exp3_AST->getFirstChild()->getType()) {
			
			throwCommandError(_RS("csl_port"), _RS("Expecting range as thrid argument"), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn());
			}
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			if (wasRange && canBeRange) { canBeRange = FALSE; }
			
#line 9537 "CslParser.cpp"
			{
			if (((LA(1) == COMMA))&&(canBeRange)) {
				match(COMMA);
				expression();
				exp4_AST = returnAST;
#line 3768 "csl.parser.g"
				//exp4 can only be numeric
				if (STRING == exp4_AST->getFirstChild()->getType()) {
				
				throwCommandError(_RS("csl_port"), _RS("Expecting range as thrid argument"), currentFilename.getRealLine(exp4_AST->getLine()), exp4_AST->getColumn());
				}
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				
#line 9551 "CslParser.cpp"
			}
			else if ((LA(1) == RPAREN)) {
			}
			else {
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			
			}
		}
		else if ((LA(1) == RPAREN)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
	}
	else if ((LA(1) == RPAREN)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
	}
	param_list_csl_port_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_csl_port_AST;
}

void CslParser::param_list_csl_signal() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_csl_signal_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3788 "csl.parser.g"
	
	TBool wasType = FALSE;
	TBool canBeComma = TRUE;
	
#line 9593 "CslParser.cpp"
	
	{
	switch ( LA(1)) {
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		expression();
		exp1_AST = returnAST;
#line 3798 "csl.parser.g"
		//first expression can be anything but STRING
		RefCslAST exp1 = exp1_AST;
		exp1 = exp1->getFirstChild();
		//error
		if (STRING == exp1->getType()) {
		throwDeclarationError(_RS("csl_signal"), _RS("Expecting signal type, width, upper limit, bitrange identifier or another signal identifier as first argument"), exp1_AST->getLine(), exp1_AST->getColumn());
		}
		//if expression if EXPR_PRIMARY_IDENTIFIER then if it only contains one identifier
		// check if it is type, if so add false vertex to AST, else just add to AST
		else if (RANGE_EXPRESSION == exp1->getType()) {
		throwDeclarationError(_RS("csl_signal"), _RS("Part select not allowed as argument for constructor. Expecting signal type, width, upper limit, bitrange identifier or another signal identifier as first argument."), exp1_AST->getLine(), exp1_AST->getColumn());
		}
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
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INTEGER,"K_INTEGER")))));
		break;
		case K_LITERAL_WIRE :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WIRE,"K_WIRE")))));
		break;
		case K_LITERAL_REG :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REG,"K_REG")))));
		break;
		case K_LITERAL_TRI :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI,"K_TRI")))));
		break;
		case K_LITERAL_TRIAND :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIAND,"K_TRIAND")))));
		break;
		case K_LITERAL_TRIOR :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIOR,"K_TRIOR")))));
		break;
		case K_LITERAL_TRI0 :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI0,"K_TRI0")))));
		break;
		case K_LITERAL_TRI1 :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI1,"K_TRI1")))));
		break;
		case K_LITERAL_TRIREG :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIREG,"K_TRIREG")))));
		break;
		case K_LITERAL_WAND :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WAND,"K_WAND")))));
		break;
		case K_LITERAL_WOR :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WOR,"K_WOR")))));
		break;
		case K_LITERAL_SUPPLY0 :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SUPPLY0,"K_SUPPLY0")))));
		break;
		case K_LITERAL_SUPPLY1 :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SUPPLY1,"K_SUPPLY1")))));
		break;
		case K_LITERAL_TIME :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TIME,"K_TIME")))));
		break;
		case K_LITERAL_REALTIME :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REALTIME,"K_REALTIME")))));
		break;
		case K_LITERAL_REAL :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REAL,"K_REAL")))));
		break;
		default :
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if (temporary) { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary)); 
		setCurrentFilename(temporary, exp1_AST->getColumn(), exp1_AST->getLine());
		wasType = TRUE;
		}
		}
		}// if expression is anything but STRING and EXPR_PRIMARY_IDENTIFIER add to AST
		else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST)); }
		
#line 9788 "CslParser.cpp"
		{
		if (((LA(1) == COMMA))&&(canBeComma)) {
			match(COMMA);
			{
			switch ( LA(1)) {
			case K_GET_INTERFACE:
			case K_GET_SIGNAL_VALUE:
			case K_GET_TYPE:
			case K_GET_ATTR:
			case K_GET_UNIT_PREFIX:
			case K_GET_SIGNAL_PREFIX:
			case K_GET_SIGNAL_PREFIX_LOCAL:
			case K_GET_DEPTH:
			case K_GET_ATTRIBUTES:
			case K_GET_INPUT_FIELD:
			case K_GET_OUTPUT_FIELD:
			case K_GET_LOCK_ENABLE_BIT:
			case K_GET_CNT_DIR_SIGNAL:
			case K_GET_WIDTH:
			case K_GET_DIM_WIDTH:
			case K_GET_BITRANGE:
			case K_GET_DIM_BITRANGE:
			case K_GET_LOWER_INDEX:
			case K_GET_DIM_LOWER_INDEX:
			case K_GET_UPPER_INDEX:
			case K_GET_DIM_UPPER_INDEX:
			case K_GET_OFFSET:
			case K_GET_DIM_OFFSET:
			case K_GET_NUMBER_OF_DIMENSIONS:
			case K_GET_CELL:
			case K_GET_TRANSACTION_TIMEOUT_COUNT:
			case K_GET_SIMULATION_TIMEOUT_COUNT:
			case K_GET_VC_ID:
			case K_GET_VC_MAX_NUM_STATES:
			case K_GET_NAME:
			case K_GET_FILENAME:
			case K_GET_MAX_NUM_VECTORS:
			case K_GET_MAX_ERROR_COUNT:
			case K_GET_MNEMONIC:
			case K_GET_VALUE:
			case K_GET_ENUM:
			case K_GET_ENUM_ITEM:
			case K_GET_NEXT_ADDRESS:
			case K_GET_LOWER_BOUND:
			case K_GET_UPPER_BOUND:
			case K_GET_DATA_WORD_WIDTH:
			case K_GET_ALIGNMENT:
			case K_GET_ENDIANESS:
			case K_GET_NAME_LENGTH:
			case K_GET_PREFIX:
			case K_GET_SUFFIX:
			case K_GET_SYMBOL_LENGTH:
			case K_GET_ADDR_INCREMENT:
			case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
			case K_GET_VC_NAME:
			case K_GET_VC_HEADER_COMMENT:
			case K_GET_VC_CLOCK:
			case K_GET_VC_RESET:
			case K_GET_VC_STALL:
			case K_GET_VC_COMPARE_TRIGGER:
			case K_GET_VC_START_GENERATION_TRIGGER:
			case K_GET_VC_END_GENERATION_TRIGGER:
			case K_GET_VC_CAPTURE_EDGE_TYPE:
			case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
			case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
			case K_GET_VC_TIMEOUT:
			case K_GET_VC_OUTPUT_FILENAME:
			case K_GET_VC_CPP_RD_NAME:
			case K_GET_VC_CPP_WR_NAME:
			case K_GET_VC_MODULE:
			case K_GET_OUTPUT_FILENAME:
			case K_GET_RESET_NAME:
			case K_GET_CLOCK_NAME:
			case K_GET_RD_CLOCK_NAME:
			case K_GET_WR_CLOCK_NAME:
			case K_GET_PUSH_NAME:
			case K_GET_POP_NAME:
			case K_GET_FULL_NAME:
			case K_GET_EMPTY_NAME:
			case K_GET_WR_DATA_NAME:
			case K_GET_RD_DATA_NAME:
			case K_GET_VALID_NAME:
			case K_GET_WR_ADDR_NAME:
			case K_GET_RD_ADDR_NAME:
			case K_GET_WR_EN_NAME:
			case K_GET_RD_EN_NAME:
			case K_GET_MSB:
			case K_GET_LSB:
			case K_GET_RADIX:
			case MINUS:
			case LCURLY:
			case LPAREN:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case IDENTIFIER:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case K_DATA_GENERATION:
			{
				expression();
				exp2_AST = returnAST;
#line 3886 "csl.parser.g"
				// this expression can be anything but STRING because identifiers can also have numeric value (for example enums)
				if (STRING == exp2_AST->getFirstChild()->getType()) {
				throwDeclarationError(_RS("csl_signal"), _RS("Expecting width, currentFilename.getRealLine(upper limit), lower limit or bitrange identifier as second argument"), exp2_AST->getLine(), exp2_AST->getColumn());
				}
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				
#line 9906 "CslParser.cpp"
				{
				if (((LA(1) == COMMA))&&(canBeComma && wasType)) {
					match(COMMA);
					expression();
					exp3_AST = returnAST;
#line 3895 "csl.parser.g"
					//this expression can be anything but STRING because identifiers can have numeric values (for example enums)
					if (STRING == exp3_AST->getFirstChild()->getType()) {
					throwDeclarationError(_RS("csl_signal"), _RS("Expecting lower limit as third argument"), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn());
					}
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					
#line 9919 "CslParser.cpp"
				}
				else if ((LA(1) == RPAREN)) {
				}
				else {
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				
				}
				break;
			}
			case LBRACK:
			{
				bitrange_pure();
#line 3904 "csl.parser.g"
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9935 "CslParser.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
		}
		else if ((LA(1) == RPAREN)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	param_list_csl_signal_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_csl_signal_AST;
}

void CslParser::bitrange_pure() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST bitrange_pure_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LBRACK);
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(COLON);
	expression();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(RBRACK);
	bitrange_pure_AST = antlr::RefCslAST(currentAST.root);
#line 13495 "csl.parser.g"
	bitrange_pure_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(BITRANGE,"BITRANGE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(bitrange_pure_AST)))); 
	setCurrentFilename(bitrange_pure_AST, exp_AST->getColumn(), exp_AST->getLine());
#line 9986 "CslParser.cpp"
	currentAST.root = bitrange_pure_AST;
	if ( bitrange_pure_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
		bitrange_pure_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		  currentAST.child = bitrange_pure_AST->getFirstChild();
	else
		currentAST.child = bitrange_pure_AST;
	currentAST.advanceChildToEnd();
	bitrange_pure_AST = antlr::RefCslAST(currentAST.root);
	returnAST = bitrange_pure_AST;
}

void CslParser::range_expression() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST range_expression_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  col = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST col_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  pneg = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST pneg_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	expression();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{
	switch ( LA(1)) {
	case COLON:
	case COMMA:
	case PO_NEG:
	{
		{
		switch ( LA(1)) {
		case COLON:
		{
			col = LT(1);
			col_AST = astFactory->create(col);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(col_AST));
			match(COLON);
#line 16067 "csl.parser.g"
			setCurrentFilename(col_AST);
#line 10026 "CslParser.cpp"
			expression();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			break;
		}
		case PO_NEG:
		{
			pneg = LT(1);
			pneg_AST = astFactory->create(pneg);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(pneg_AST));
			match(PO_NEG);
#line 16071 "csl.parser.g"
			setCurrentFilename(pneg_AST);
#line 10039 "CslParser.cpp"
			expression();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			break;
		}
		case COMMA:
		{
			match(COMMA);
			expression();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		break;
	}
	case RBRACK:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	}
	range_expression_AST = antlr::RefCslAST(currentAST.root);
	returnAST = range_expression_AST;
}

void CslParser::concatenation() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST concatenation_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ex_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST sc_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST mc_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 16475 "csl.parser.g"
	
	TBool wasSimpleConcat = FALSE;
	TBool wasMultiConcat = FALSE;
	RefCslAST temp;
	
#line 10087 "CslParser.cpp"
	
	{
	match(LCURLY);
	expression();
	ex_AST = returnAST;
	{
	switch ( LA(1)) {
	case COMMA:
	{
		simple_concat();
		sc_AST = returnAST;
#line 16489 "csl.parser.g"
		
		wasSimpleConcat = TRUE; 
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CONCATENATION,"K_CONCATENATION")))));
		temp->addChild(ex_AST);
		temp->addChild(sc_AST);
		
#line 10106 "CslParser.cpp"
		break;
	}
	case LCURLY:
	case RCURLY:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{
	if (((LA(1) == LCURLY))&&(!wasSimpleConcat)) {
		multi_concat();
		mc_AST = returnAST;
#line 16502 "csl.parser.g"
		
		wasMultiConcat = TRUE; 
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REPLICATION,"K_REPLICATION")))));
		temp->addChild(ex_AST);
		temp->addChild(mc_AST);
		
#line 10131 "CslParser.cpp"
	}
	else if ((LA(1) == RCURLY)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	
	}
	match(RCURLY);
	concatenation_AST = antlr::RefCslAST(currentAST.root);
#line 16511 "csl.parser.g"
	
	if (!wasSimpleConcat && !wasMultiConcat) {
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CONCATENATION,"K_CONCATENATION")))));
	temp->addChild(ex_AST);
	}
	concatenation_AST = temp; 
	
#line 10150 "CslParser.cpp"
	currentAST.root = concatenation_AST;
	if ( concatenation_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
		concatenation_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		  currentAST.child = concatenation_AST->getFirstChild();
	else
		currentAST.child = concatenation_AST;
	currentAST.advanceChildToEnd();
	}
	concatenation_AST = antlr::RefCslAST(currentAST.root);
	returnAST = concatenation_AST;
}

void CslParser::param_list_add_port_list(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_add_port_list_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  dot = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST dot_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  com = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST com_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 13649 "csl.parser.g"
	
	TBool hasDot = FALSE;
	TBool hasComma = FALSE;
	TBool hasId = FALSE;
	TBool wasAddedToAst = FALSE;
	TBool filenameSet = FALSE;
	
#line 10185 "CslParser.cpp"
	
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
	param_list_add_port_list_AST = antlr::RefCslAST(currentAST.root);
#line 13661 "csl.parser.g"
	
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
	param_list_add_port_list_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PARAM_LIST_ADD_PORT_LIST,"PARAM_LIST_ADD_PORT_LIST"))))); 
	
#line 10215 "CslParser.cpp"
	currentAST.root = param_list_add_port_list_AST;
	if ( param_list_add_port_list_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
		param_list_add_port_list_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		  currentAST.child = param_list_add_port_list_AST->getFirstChild();
	else
		currentAST.child = param_list_add_port_list_AST;
	currentAST.advanceChildToEnd();
	{ // ( ... )+
	int _cnt516=0;
	for (;;) {
		if ((LA(1) == IDENTIFIER)) {
			id = LT(1);
			id_AST = astFactory->create(id);
			match(IDENTIFIER);
			param_list_add_port_list_AST = antlr::RefCslAST(currentAST.root);
#line 13686 "csl.parser.g"
			
			setCurrentFilename(id_AST);
			if (!filenameSet) { setCurrentFilename(param_list_add_port_list_AST, id_AST->getColumn(), id_AST->getLine()); filenameSet = TRUE; }
			if (wasAddedToAst) {
			wasAddedToAst = FALSE;
			}
			if (hasId) {
			RefString msg = _RS("command 'add_port_list()' : Unexpected token '");
			msg->append( id_AST->getText());
			msg->append( "' ");
			throw ANTLR_USE_NAMESPACE(antlr)RecognitionException(*msg,
			*currentFilename,
			id_AST->getLine(),
			id_AST->getColumn());
			}
			hasId = TRUE;
			
#line 10249 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case DOT:
			{
				dot = LT(1);
				dot_AST = astFactory->create(dot);
				match(DOT);
				param_list_add_port_list_AST = antlr::RefCslAST(currentAST.root);
#line 13705 "csl.parser.g"
				
				hasDot = TRUE;
				param_list_add_port_list_AST->addChild(id_AST);
				wasAddedToAst = TRUE;
				hasId = FALSE;
				
#line 10265 "CslParser.cpp"
				break;
			}
			case COMMA:
			{
				com = LT(1);
				com_AST = astFactory->create(com);
				match(COMMA);
				param_list_add_port_list_AST = antlr::RefCslAST(currentAST.root);
#line 13713 "csl.parser.g"
				
				if (hasComma) {
				throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_port_list()' : Unexpected token ',' ",
				*currentFilename,
				com->getLine(),
				com->getColumn());
				}
				if (hasDot) {
				throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_port_list()' : First argument should be 'input', 'output' or 'inout' ",
				*currentFilename,
				id_AST->getLine(),
				id_AST->getColumn());
				}
				hasComma = TRUE;
				hasId = FALSE;
				RefString literalString = _RS(id_AST->getText());
				TLInt literalEnum = getLiteralEnum(literalString);
				RefCslAST temp;
				switch (literalEnum) {
				case K_LITERAL_INPUT  :  
				temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INPUT,"K_INPUT")))));
				param_list_add_port_list_AST->addChild(temp); 
				wasAddedToAst = TRUE; 
				break;
				case K_LITERAL_OUTPUT :  
				temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OUTPUT,"K_OUTPUT")))));
				param_list_add_port_list_AST->addChild(temp); 
				wasAddedToAst = TRUE; 
				break;
				case K_LITERAL_INOUT  :  
				temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INOUT,"K_INOUT")))));
				param_list_add_port_list_AST->addChild(temp); 
				wasAddedToAst = TRUE; 
				break;
				default :
				throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("command 'add_port_list()' : Expecting 'input', 'output' or 'inout' as first argument ",
				*currentFilename,
				id_AST->getLine(),
				id_AST->getColumn());
				}
				setCurrentFilename(temp, id_AST->getColumn(), id_AST->getLine());
				
#line 10317 "CslParser.cpp"
				break;
			}
			case RPAREN:
			case IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			param_list_add_port_list_AST = antlr::RefCslAST(currentAST.root);
#line 13756 "csl.parser.g"
			
			if (!wasAddedToAst) {
			param_list_add_port_list_AST->addChild(id_AST);
			wasAddedToAst = TRUE;
			}
			
#line 10339 "CslParser.cpp"
		}
		else {
			if ( _cnt516>=1 ) { goto _loop516; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt516++;
	}
	_loop516:;
	}  // ( ... )+
	antlr::RefCslAST tmp158_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	tmp158_AST = astFactory->create(LT(1));
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp158_AST));
	match(RPAREN);
	param_list_add_port_list_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_add_port_list_AST;
}

void CslParser::param_list_set_type(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_type_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 14900 "csl.parser.g"
	
	TBool typeError = FALSE;
	TBool error = FALSE;
	
#line 10371 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14910 "csl.parser.g"
	//set real filename + line 
	setCurrentFilename(lp_AST);
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
	
#line 10403 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 14938 "csl.parser.g"
	//exp should be one of the following literals
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
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
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_COUNTER,"K_COUNTER")))));
	break;
	case K_LITERAL_REGISTER :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REGISTER,"K_REGISTER")))));
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
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REG,"K_REG")))));
	break;
	case K_LITERAL_WIRE :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WIRE,"K_WIRE")))));
	break;
	case K_LITERAL_TRI :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI,"K_TRI")))));
	break;
	case K_LITERAL_TRIAND :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIAND,"K_TRIAND")))));
	break;
	case K_LITERAL_SUPPLY0 :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SUPPLY0,"K_SUPPLY0")))));
	break;
	case K_LITERAL_SUPPLY1 :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SUPPLY1,"K_SUPPLY1")))));
	break;
	case K_LITERAL_TRIOR :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIOR,"K_TRIOR")))));
	break;
	case K_LITERAL_TRI0 :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI0,"K_TRI0")))));
	break;
	case K_LITERAL_TRI1 :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRI1,"K_TRI1")))));
	break;
	case K_LITERAL_TRIREG :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TRIREG,"K_TRIREG")))));
	break;
	case K_LITERAL_WAND :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WAND,"K_WAND")))));
	break;
	case K_LITERAL_WOR :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WOR,"K_WOR")))));
	break;
	case K_LITERAL_INTEGER :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INTEGER,"K_INTEGER")))));
	break;
	case K_LITERAL_TIME :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_TIME,"K_TIME")))));
	break;
	case K_LITERAL_REAL :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REAL,"K_REAL")))));
	break;
	case K_LITERAL_REALTIME :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_REALTIME,"K_REALTIME")))));
	break;
	case K_LITERAL_HIERARCHICAL :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_HIERARCHICAL,"K_HIERARCHICAL")))));
	break;
	case K_LITERAL_FLAT :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_FLAT,"K_FLAT")))));
	break;
	case K_LITERAL_PAGE :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PAGE,"K_PAGE")))));
	break;
	case K_LITERAL_VIRTUAL_WITH_BASE_ADDRESS :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_VIRTUAL_WITH_BASE_ADDRESS,"K_VIRTUAL_WITH_BASE_ADDRESS")))));
	break;
	case K_LITERAL_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS,"K_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS")))));
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
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RESERVED,"K_RESERVED")))));
	break;
	case K_LITERAL_OPCODE :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OPCODE,"K_OPCODE")))));
	break;
	case K_LITERAL_SUBOPCODE :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SUBOPCODE,"K_SUBOPCODE")))));
	break;
	case K_LITERAL_ADDRESS :
	//***           temporary = #(#[K_ADDRESS, "K_ADDRESS"]);
	error = TRUE;
	break;
	case K_LITERAL_SELECTOR :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SELECTOR,"K_SELECTOR")))));
	break;
	case K_LITERAL_CONSTANT :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CONSTANT,"K_CONSTANT")))));
	break;
	case K_LITERAL_RF_ADDRESS :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RF_ADDRESS,"K_RF_ADDRESS")))));
	break;
	case K_LITERAL_MEM_ADDRESS :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_MEM_ADDRESS,"K_MEM_ADDRESS")))));
	break;
	case K_LITERAL_IM :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_IM,"K_IM")))));
	break;
	case K_LITERAL_UNUSED :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_UNUSED,"K_UNUSED")))));
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
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INSTR_FORMAT,"K_INSTR_FORMAT")))));
	break;
	case K_LITERAL_INSTR :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INSTR,"K_INSTR")))));
	break;
	case K_LITERAL_ROOT_FORMAT :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ROOT_FORMAT,"K_ROOT_FORMAT")))));
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
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_COMBINATIONAL,"K_COMBINATIONAL")))));
	break;
	case K_LITERAL_SEQUENTIAL :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SEQUENTIAL,"K_SEQUENTIAL")))));
	break;
	default:
	typeError = TRUE;
	}
	if (error) {
	throwCommandError(_RS("set_type()"), _RS("Unknown type (probably removed from version 1.0) "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	if (!typeError) {
	setCurrentFilename(temporary, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
	}
	}
	else { typeError = TRUE; }
	
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { typeError = TRUE; }
	
	if (typeError) {
	RefString msg = _RS("Expecting type as argument, found '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("set_type()"),msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 10667 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_type_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_type_AST;
}

void CslParser::param_list_set_attr(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_attr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 15208 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 10687 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15218 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 10715 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 15242 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temporary;
	switch (literalEnum) {
	case K_LITERAL_ENABLE :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ENABLE,"K_ENABLE")))));
	break;
	case K_LITERAL_STALL :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_STALL,"K_STALL")))));
	break;
	case K_LITERAL_MUX_SELECT :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_MUX_SELECT,"K_MUX_SELECT")))));
	break;
	case K_LITERAL_DECODE :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_DECODE,"K_DECODE")))));
	break;
	case K_LITERAL_CLOCK_SIGNAL :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CLOCK_SIGNAL,"K_CLOCK_SIGNAL")))));
	break;
	case K_LITERAL_RESET_SIGNAL :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RESET_SIGNAL,"K_RESET_SIGNAL")))));
	break;
	default :
	error = TRUE;
	}
	if (!error) {
	setCurrentFilename(temporary, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
	}
	
	}
	else { error = TRUE; }
	
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting attribute as argument, found '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("set_attr()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
	
#line 10772 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_attr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_attr_AST;
}

void CslParser::param_list_set_unit_prefix(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_unit_prefix_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 13517 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 10793 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13526 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_unit_prefix()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary (not allowed)
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 10815 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 13544 "csl.parser.g"
	//exp should be ifc_only or local_only
	if (FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()
	&& STRING != exp_AST->getFirstChild()->getType()){
	throwCommandError(_RS("set_unit_prefix()"), _RS("Expecting string as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	
#line 10826 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		exp2_AST = returnAST;
#line 13554 "csl.parser.g"
		
		if (EXPR_PRIMARY_IDENTIFIER == exp2_AST->getFirstChild()->getType()) {
		
		if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp2_AST->getFirstChild()->getFirstChild()->getNextSibling()
		&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp2_AST->getFirstChild()->getFirstChild()->getFirstChild()) {
		
		RefString literalString = _RS(exp2_AST->getFirstChild()->getFirstChild()->getText());
		TLInt literalEnum = getLiteralEnum(literalString);
		RefCslAST temp;
		switch (literalEnum) {
		case K_LITERAL_IFC_ONLY :
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_IFC_ONLY,"K_IFC_ONLY")))));
		break;
		case K_LITERAL_LOCAL_ONLY :
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_LOCAL_ONLY,"K_LOCAL_ONLY")))));
		break;
		default :
		error = TRUE;
		}
		if (!error) {
		setCurrentFilename(temp, exp2_AST->getColumn(), exp2_AST->getLine());
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
		}
		}
		else { error = TRUE; }
		}
		else if (FUNCTION_CALL_RET_ID == exp2_AST->getFirstChild()->getType()) {
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else { error = TRUE; }
		
		if (error) {
		RefString msg = _RS("Expecting 'ifc_only' or 'local_only' as second argument, found '");
		msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
		msg->append( "' ");
		throwCommandError(_RS("set_unit_prefix()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
		} 
		
#line 10873 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	param_list_set_unit_prefix_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_unit_prefix_AST;
}

void CslParser::param_list_set_signal_prefix(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_signal_prefix_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14807 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_signal_prefix()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);//not necessary (not allowed)
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 10922 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14825 "csl.parser.g"
	//exp is only allowed to be string
	if(FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()
	&& STRING != exp_AST->getFirstChild()->getType()){
	throwCommandError(_RS("set_signal_prefix()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 10933 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_signal_prefix_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_signal_prefix_AST;
}

void CslParser::param_list_set_signal_prefix_local(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_signal_prefix_local_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14847 "csl.parser.g"
	//set real filename + column
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_signal_prefix_local()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);//not necessary (not allowed)
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 10970 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14865 "csl.parser.g"
	//exp is only allowed to be string
	if(FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()
	&& STRING != exp_AST->getFirstChild()->getType()){ 
	throwCommandError(_RS("set_prefix_local()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 10981 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_signal_prefix_local_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_signal_prefix_local_AST;
}

void CslParser::param_list_set_depth(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_depth_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14388 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	
	//command call options
	RefString command = _RS("set_depth()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL | NSSymbolTable::TMEM_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11019 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14407 "csl.parser.g"
	
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_depth()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(lp->getLine()), lp->getColumn());
	}
	
#line 11029 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_depth_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_depth_AST;
}

void CslParser::param_list_create_rtl_module(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_create_rtl_module_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14428 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("create_rtl_module()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11065 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_create_rtl_module_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_create_rtl_module_AST;
}

void CslParser::param_list_directive(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_directive_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 4897 "csl.parser.g"
	//directive calls are not allowed for ver 1.0
	TInt                  callAllowedInScopesWithoutObjectMask = 0;
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap;
	
	setCommandCallOptions(_RS("directive(...)"), callAllowedInScopesWithoutObjectMask);
	callCommand(_RS("directive(...)"), scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11096 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	match(IDENTIFIER);
#line 4908 "csl.parser.g"
	//set real filename + line for id
	setCurrentFilename(id_AST);
	//id should be one of the following literals
	RefString literalString = _RS(id_AST->getText());
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
	throwCommandError(_RS("directive()"), _RS("First argument should be 'disconnect_register_fields_from_ios', 'connect_register_fields_to_ios' or 'name_register' "), currentFilename.getRealLine(id_AST->getLine()), id_AST->getColumn());
	}
	ASSERT(directive, "PARSER - null ast vertex");
	//set real filename + column for fake vertex directive
	directive->addChild(returnAST);
	setCurrentFilename(directive, id_AST->getColumn(), id_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(directive));
	
#line 11142 "CslParser.cpp"
	}
	}
	param_list_directive_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_directive_AST;
}

void CslParser::param_list_set_width(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_width_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14342 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 11186 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14367 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_width()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11196 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_width_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_width_AST;
}

void CslParser::param_list_set_dim_width(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_dim_width_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14160 "csl.parser.g"
	
	setCurrentFilename(lp_AST);
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
	
#line 11242 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14186 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_width()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11252 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14194 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_width()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 11263 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_dim_width_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_dim_width_AST;
}

void CslParser::param_list_set_bitrange(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_bitrange_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14296 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 11306 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14320 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_bitrange()"), _RS("Expecting identifier as argument"), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11317 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_bitrange_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_bitrange_AST;
}

void CslParser::param_list_set_dim_bitrange(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_dim_bitrange_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14096 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 11364 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14123 "csl.parser.g"
	//exp is only allowed to ne numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_bitrange()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11374 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14131 "csl.parser.g"
	//exp2 is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp2_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_bitrange()"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 11386 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_dim_bitrange_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_dim_bitrange_AST;
}

void CslParser::param_list_set_range(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_range_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14521 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 11430 "CslParser.cpp"
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14545 "csl.parser.g"
	//exp1 and exp2 can only be numeric
	if (STRING == exp1_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_range()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn());
	}
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_range()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 11447 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_range_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_range_AST;
}

void CslParser::param_list_set_dim_range(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_dim_range_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14569 "csl.parser.g"
	
	setCurrentFilename(lp_AST);
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
	
#line 11494 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14595 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_range()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11504 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14603 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_range()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 11515 "CslParser.cpp"
	match(COMMA);
	expression();
	exp3_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14611 "csl.parser.g"
	//exp3 is only allowed to be numeric
	if (STRING == exp3_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_range()"), _RS("Expecting numeric expression as third argument "), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn());
	}
	
#line 11526 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_dim_range_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_dim_range_AST;
}

void CslParser::param_list_set_offset(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_offset_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14632 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL));
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIELD_DECL, 
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL 
	| NSSymbolTable::TFIELD_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
	NSSymbolTable::TISAE_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11587 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14674 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_offset()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11597 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_offset_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_offset_AST;
}

void CslParser::param_list_set_dim_offset(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_dim_offset_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14695 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 11644 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14722 "csl.parser.g"
	//exp is only allowed to be numeric 
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_offset()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11654 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14730 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_dim_offset()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 11665 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_dim_offset_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_dim_offset_AST;
}

void CslParser::param_list_set_number_of_dimensions(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_number_of_dimensions_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14751 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_number_of_dimensions()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 ;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TMDB_DECL,
	NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL
	| NSSymbolTable::TISAF_DECL | NSSymbolTable::TFIELD_DECL));
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
	NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TTB_DECL));
	
	//RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11709 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14776 "csl.parser.g"
	
	if (STRING == exp_AST->getFirstChild()->getType()) {
	
	throwCommandError(_RS("set_number_of_dimensions()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11720 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_number_of_dimensions_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_number_of_dimensions_AST;
}

void CslParser::param_list_reverse(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_reverse_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15969 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 11762 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_reverse_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_reverse_AST;
}

void CslParser::param_list_set_instance_alteration_bit(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_instance_alteration_bit_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 14216 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 11782 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14225 "csl.parser.g"
	
	RefString command = _RS("set_instance_alteration_bit()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary (not allowed)
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11802 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 14241 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_OFF :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OFF,"K_OFF")))));
	break;
	case K_LITERAL_ON :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ON,"K_ON")))));
	break;
	default :
	error = TRUE;
	}
	if (!error) {
	setCurrentFilename(temp, exp_AST->getLine(), exp_AST->getColumn());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { error = TRUE; }
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	
	}
	else { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting 'on' or 'off' as argument, found '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("set_instance_alteration_bit()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11845 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_instance_alteration_bit_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_instance_alteration_bit_AST;
}

void CslParser::param_list_set_testbench_verilog_filename(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_testbench_verilog_filename_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12508 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_testbench_verilog_filename()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_TESTBENCH, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TTB_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11884 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12528 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_testbench_verilog_filename()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11895 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_testbench_verilog_filename_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_testbench_verilog_filename_AST;
}

void CslParser::param_list_set_vc_compare_trigger(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_compare_trigger_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12652 "csl.parser.g"
	
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_compare_trigger()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11935 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(RPAREN);
	}
	param_list_set_vc_compare_trigger_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_compare_trigger_AST;
}

void CslParser::param_list_set_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12030 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAF_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TISAF_DECL,
	NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL));
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 11978 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12051 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 11989 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_name_AST;
}

void CslParser::param_list_set_direction(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_direction_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 12273 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 12009 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12282 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_direction()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TVEC_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12033 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 12302 "csl.parser.g"
	//exp is only allowed to be 'input' or 'output'
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_INPUT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INPUT,"K_INPUT")))));
	break;
	case K_LITERAL_OUTPUT : 
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OUTPUT,"K_OUTPUT")))));
	break;
	default :
	error = TRUE;
	}
	
	if (!error) {
	
	setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { error = TRUE; }
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	throwCommandError(_RS("set_direction()"), _RS("Expecting 'input or 'output' as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12075 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_direction_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_direction_AST;
}

void CslParser::param_list_exclusion_list(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_exclusion_list_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12356 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("exclusion_list()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TVEC_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12115 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12376 "csl.parser.g"
	//exp is only allowed to be identifier 
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("exclusion_list()"), _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12127 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			expression();
			exp2_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12386 "csl.parser.g"
			//exp2 is only allowed to be identifier
			if (EXPR_PRIMARY_IDENTIFIER != exp2_AST->getFirstChild()->getType()
			&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
			&& FUNCTION_CALL_RET_ID != exp2_AST->getFirstChild()->getType()) {
			throwCommandError(_RS("exclusion_list()"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
			}
			
#line 12143 "CslParser.cpp"
		}
		else {
			goto _loop462;
		}
		
	}
	_loop462:;
	} // ( ... )*
	match(RPAREN);
	}
	param_list_exclusion_list_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_exclusion_list_AST;
}

void CslParser::param_list_include_only(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_include_only_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12410 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("include_only()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TVEC_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12191 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12430 "csl.parser.g"
	//exp is only allowed to be identifier 
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("include_only()"), _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12203 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			expression();
			exp2_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12440 "csl.parser.g"
			//exp2 is only allowed to be identifier 
			if (EXPR_PRIMARY_IDENTIFIER != exp2_AST->getFirstChild()->getType()
			&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
			&& FUNCTION_CALL_RET_ID != exp2_AST->getFirstChild()->getType()) {
			throwCommandError(_RS("include_only()"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
			}
			
#line 12219 "CslParser.cpp"
		}
		else {
			goto _loop466;
		}
		
	}
	_loop466:;
	} // ( ... )*
	match(RPAREN);
	}
	param_list_include_only_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_include_only_AST;
}

void CslParser::param_list_set_radix(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_radix_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 12089 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 12247 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12098 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_radix()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary (not allowed)
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12271 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 12118 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temporary;
	switch (literalEnum) {
	case K_LITERAL_BIN :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_BIN,"K_BIN")))));
	break;
	case K_LITERAL_HEX :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_HEX,"K_HEX")))));
	break;
	default :
	error = TRUE;
	}
	
	if (!error) {
	
	setCurrentFilename(temporary, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
	}
	}
	else { error = TRUE; }
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	
	throwCommandError(_RS("set_radix()"), _RS("Expecting radix as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
	
#line 12315 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_radix_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_radix_AST;
}

void CslParser::param_list_set_top_unit(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_top_unit_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11771 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_top_unit()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAP_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12352 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11789 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_top_unit()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 12363 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_top_unit_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_top_unit_AST;
}

void CslParser::param_list_add(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_add_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11811 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("add()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
	NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12405 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11832 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add()"), _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 12416 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		exp2_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11841 "csl.parser.g"
		//exp2 is only allowed to be string
		if (STRING != exp2_AST->getFirstChild()->getType()
		&& FUNCTION_CALL_RET_EXPR != exp2_AST->getFirstChild()->getType()) {
		throwCommandError(_RS("add()"), _RS("Expecting string as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); 
		}
		
#line 12432 "CslParser.cpp"
		{
		switch ( LA(1)) {
		case COMMA:
		{
			match(COMMA);
			expression();
			exp3_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11850 "csl.parser.g"
			//exp3 is only allowed to be numeric
			if (STRING == exp3_AST->getFirstChild()->getType()) {
			throwCommandError(_RS("add()"), _RS("Expecting numeric expression as third argument "), currentFilename.getRealLine(exp3_AST->getLine()), exp2_AST->getColumn()); 
			}
			
#line 12447 "CslParser.cpp"
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	param_list_add_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_add_AST;
}

void CslParser::param_list_add_address_range(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_add_address_range_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11872 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("add_address_range()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
	NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());//should probably add a flag that allows command to be called on upper scope object(if that exists)
	
#line 12512 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11893 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_address_range()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12522 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11901 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_address_range()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12533 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_add_address_range_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_add_address_range_AST;
}

void CslParser::param_list_add_reserved_address_range(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_add_reserved_address_range_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11922 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("add_reserved_address_range()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
	NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12574 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11943 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_reserved_address_range()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12584 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11951 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_reserved_address_range()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 12595 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_add_reserved_address_range_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_add_reserved_address_range_AST;
}

void CslParser::param_list_set_data_word_width(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_data_word_width_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11694 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	RefString command = _RS("set_data_word_width()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL | NSSymbolTable::TMEMMAP_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12631 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11711 "csl.parser.g"
	//exp is only allowed to be numeric 
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_data_word_width()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 12641 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_data_word_width_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_data_word_width_AST;
}

void CslParser::param_list_set_address_increment(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_address_increment_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10015 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_address_increment()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
	NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12681 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 10036 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_address_increment()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12691 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_address_increment_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_address_increment_AST;
}

void CslParser::param_list_set_next_address(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_next_address_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10057 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_next_address()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
	NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TMEMMAPP_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12731 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 10078 "csl.parser.g"
	
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_next_address()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12741 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_next_address_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_next_address_AST;
}

void CslParser::param_list_set_alignment(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_alignment_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10099 "csl.parser.g"
	//set real filename + line
	RefString command = _RS("set_alignment()");
	//command call options
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; //not necessary
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12776 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 10115 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_alignment()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12786 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_alignment_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_alignment_AST;
}

void CslParser::param_list_set_prefix(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_prefix_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 10130 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 12806 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10139 "csl.parser.g"
	//command call options
	RefString command = _RS("set_prefix()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TPIPESTG_DECL
	| NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
	//                                                           NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TIFC_DECL | NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
	NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TUNIT_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12836 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 10165 "csl.parser.g"
	//exp should either pipestage prefix_type literal or string
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_NO_PREFIX : 
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_NO_PREFIX,"K_NO_PREFIX")))));
	break;
	case K_LITERAL_PIPELINE_NAME :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PIPELINE_NAME,"K_PIPELINE_NAME")))));
	break;
	case K_LITERAL_PIPESTAGE_NAME :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PIPESTAGE_NAME,"K_PIPESTAGE_NAME")))));
	break;
	case K_LITERAL_PIPELINE_PIPESTAGE_NAME :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PIPELINE_PIPESTAGE_NAME,"K_PIPELINE_PIPESTAGE_NAME")))));
	break;
	default :
	error = TRUE;
	}
	
	if (!error) {
	
	setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { error = TRUE; }
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()
	|| STRING == exp_AST->getFirstChild()->getType()
	|| FUNCTION_CALL_RET_EXPR == exp_AST->getFirstChild()->getType()) {
	
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	
	RefString msg = _RS("Expecting string or prefix type, found '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("set_prefix()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
	
#line 12891 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_prefix_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_prefix_AST;
}

void CslParser::param_list_set_suffix(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_suffix_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10408 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_suffix()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAP_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
	//                                                           NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TIFC_DECL | NSSymbolTable::TUNIT_DECL ));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
	NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TUNIT_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12937 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 10435 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	
	throwCommandError(_RS("set_suffix()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 12949 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_suffix_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_suffix_AST;
}

void CslParser::param_list_set_endianess(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_endianess_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 10507 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 12969 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10516 "csl.parser.g"
	//set filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_endianess()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 12990 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 10533 "csl.parser.g"
	//exp should be endianess type literal
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	
	case K_LITERAL_LITTLE_ENDIAN :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_LITTLE_ENDIAN,"K_LITTLE_ENDIAN")))));
	break;
	case K_LITERAL_BIG_ENDIAN :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_BIG_ENDIAN,"K_BIG_ENDIAN")))));
	break;
	default :
	error = TRUE;
	}
	if (!error) {
	
	setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { error = TRUE; }
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting endianess type, found '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	throwCommandError(_RS("set_endianess()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 13034 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_endianess_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_endianess_AST;
}

void CslParser::param_list_auto_gen_memory_map(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_auto_gen_memory_map_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10589 "csl.parser.g"
	//set current filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("auto_gen_memory_map()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAP_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 13069 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_auto_gen_memory_map_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_auto_gen_memory_map_AST;
}

void CslParser::param_list_add_to_memory_map(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_add_to_memory_map_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  col = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST col_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp0_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 10613 "csl.parser.g"
	
	RefCslAST exp  ;
	RefCslAST exp0 ;
	RefCslAST exp2 ;
	RefCslAST exp3 ;
	TBool error    = FALSE;
	
#line 13098 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10626 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("add_to_memory_map()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TRF_DECL
	| NSSymbolTable::TMEM_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
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
	
#line 13133 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		expression();
		exp_AST = returnAST;
#line 10655 "csl.parser.g"
		exp = returnAST;
#line 13243 "CslParser.cpp"
		{
		switch ( LA(1)) {
		case COLON:
		{
			col = LT(1);
			col_AST = astFactory->create(col);
			match(COLON);
			expression();
			exp0_AST = returnAST;
#line 10655 "csl.parser.g"
			exp0 = returnAST;
#line 13255 "CslParser.cpp"
			break;
		}
		case COMMA:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		if (((LA(1) == COMMA))&&(col_AST == ANTLR_USE_NAMESPACE(antlr)nullAST)) {
			match(COMMA);
			expression();
			exp2_AST = returnAST;
#line 10656 "csl.parser.g"
			exp2 = returnAST;
#line 13276 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				expression();
				exp3_AST = returnAST;
#line 10656 "csl.parser.g"
				exp3 = returnAST;
#line 13286 "CslParser.cpp"
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
		}
		else if ((LA(1) == RPAREN)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 10658 "csl.parser.g"
	//checks
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
	throwCommandError(_RS("add_to_memory_map()"), msg, currentFilename.getRealLine(address->getLine()), address->getColumn());
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
	throwCommandError(_RS("add_to_memory_map()"), msg, currentFilename.getRealLine(exp0->getLine()), exp0->getColumn());
	}
	else { 
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(col_AST)); 
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
	throwCommandError(_RS("add_to_memory_map()"), msg, currentFilename.getRealLine(group->getLine()), group->getColumn());
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
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ACCESS_RIGHT_NONE,"K_ACCESS_RIGHT_NONE")))));
	break;
	case K_LITERAL_ACCESS_READ :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ACCESS_RIGHT_READ,"K_ACCESS_RIGHT_READ")))));
	break;
	case K_LITERAL_ACCESS_WRITE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ACCESS_RIGHT_WRITE,"K_ACCESS_RIGHT_WRITE")))));
	break;
	case K_LITERAL_ACCESS_READ_WRITE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ACCESS_RIGHT_READ_WRITE,"K_ACCESS_RIGHT_READ_WRITE")))));
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
	throwCommandError(_RS("add_to_memory_map()"), msg, currentFilename.getRealLine(accRight->getLine()), accRight->getColumn());
	}
	
	
#line 13439 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_add_to_memory_map_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_add_to_memory_map_AST;
}

void CslParser::param_list_set_access_rights(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_access_rights_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  col = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST col_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 11533 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 13464 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11542 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_access_rights()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEMMAPP_DECL,
	NSSymbolTable::TMEMMAPP_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 13489 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 11563 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_access_rights()"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	
#line 13499 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COLON:
	{
		col = LT(1);
		col_AST = astFactory->create(col);
		match(COLON);
		expression();
		exp2_AST = returnAST;
#line 11572 "csl.parser.g"
		//exp2 is only allowed to be numeric
		if (STRING == exp2_AST->getFirstChild()->getType()) {
		throwCommandError(_RS("set_access_rights()"), _RS("Expecting numeric expression as second expression of first argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
		}
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(col_AST));
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST)); 
		
#line 13517 "CslParser.cpp"
		break;
	}
	case COMMA:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(COMMA);
	expression();
	exp3_AST = returnAST;
#line 11583 "csl.parser.g"
	//exp3 is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp3_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp3_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_access_rights()"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn());
	}
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	
#line 13541 "CslParser.cpp"
	match(COMMA);
	expression();
	exp4_AST = returnAST;
#line 11593 "csl.parser.g"
	//exp4 is only allowed to be access right
	if (EXPR_PRIMARY_IDENTIFIER == exp4_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp4_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp4_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp4_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_ACCESS_NONE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ACCESS_RIGHT_NONE,"K_ACCESS_RIGHT_NONE")))));
	break;
	case K_LITERAL_ACCESS_READ :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ACCESS_RIGHT_READ,"K_ACCESS_RIGHT_READ")))));
	break;
	case K_LITERAL_ACCESS_WRITE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ACCESS_RIGHT_WRITE,"K_ACCESS_RIGHT_WRITE")))));
	break;
	case K_LITERAL_ACCESS_READ_WRITE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ACCESS_RIGHT_READ_WRITE,"K_ACCESS_RIGHT_READ_WRITE")))));
	break;
	default :
	error = TRUE;
	}
	if (!error) {
	setCurrentFilename(temp, exp4_AST->getColumn(), exp4_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	
	}
	else { error = TRUE; }
	
	}
	else if (FUNCTION_CALL_RET_ID == exp4_AST->getFirstChild()->getType()) {
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting access right, found '");
	msg->append( exp4_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("set_access_rights"), msg, currentFilename.getRealLine(exp4_AST->getLine()), exp4_AST->getColumn());
	}
	
#line 13592 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_access_rights_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_access_rights_AST;
}

void CslParser::param_list_set_access_rights_enum(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_access_rights_enum_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11654 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_access_rights_enum()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 13629 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11672 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_access_rights_enum()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 13640 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_access_rights_enum_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_access_rights_enum_AST;
}

void CslParser::param_list_set_symbol_max_length(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_symbol_max_length_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11732 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_symbol_max_length()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 13677 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11750 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_symbol_max_length()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 13687 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_symbol_max_length_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_symbol_max_length_AST;
}

void CslParser::param_list_set_enum(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_enum_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 9939 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 13738 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9971 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_enum()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 13749 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_enum_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_enum_AST;
}

void CslParser::param_list_set_enum_item(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_enum_item_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 5330 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 13800 "CslParser.cpp"
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5362 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER != exp1_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp1_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_enum_item()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); 
	}
	
#line 13811 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_enum_item_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_enum_item_AST;
}

void CslParser::param_list_set_mnemonic(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_mnemonic_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 9804 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 13854 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9829 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_mnemonic()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 13865 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_mnemonic_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_mnemonic_AST;
}

void CslParser::param_list_gen_decoder(
	RefTVec_RefString scopeId 
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_gen_decoder_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 9744 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 13921 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		expression();
		exp_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9781 "csl.parser.g"
		//exp is only allowed to be identifier 
		if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
		&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
		throwCommandError(_RS("gen_decoder()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
		}
		
#line 14037 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	param_list_gen_decoder_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_gen_decoder_AST;
}

void CslParser::param_list_set_physical_implementation(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_physical_implementation_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(LPAREN);
#line 5222 "csl.parser.g"
	//command calling options
	RefString command = _RS("set_physical_implementation()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;  //not necessary(not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap;
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(),lp1->getColumn());
	
#line 14083 "CslParser.cpp"
	{
	id = LT(1);
	id_AST = astFactory->create(id);
	match(IDENTIFIER);
#line 5236 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(id_AST);
	//id should be one of the following literals
	RefString literalString = _RS(id_AST->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_SRAM :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SRAM,"K_SRAM")))));
	setCurrentFilename(temp, id_AST->getColumn(), id_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	break;
	case K_LITERAL_FFA :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_FFA,"K_FFA")))));
	setCurrentFilename(temp, id_AST->getColumn(), id_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	break;
	default :
	RefString msg = _RS("Unexpected token '");
	msg->append( id_AST->getText());
	msg->append( "' ");
	throwCommandError(_RS("set_physical_implementation()"), msg, currentFilename.getRealLine(id_AST->getLine()), id_AST->getColumn());
	}
	
#line 14113 "CslParser.cpp"
	}
	match(RPAREN);
	}
	param_list_set_physical_implementation_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_physical_implementation_AST;
}

void CslParser::param_list_set_value(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_value_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 5277 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 14165 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5309 "csl.parser.g"
	//exp is only allowed to be numeric 
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_value()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14175 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_value_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_value_AST;
}

void CslParser::param_list_set_field(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_field_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(LPAREN);
#line 5384 "csl.parser.g"
	
	RefString command = _RS("set_field()");
	
	//   TInt                  callAllowedInScopesWithoutObjectMask = 0; // not necessary
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(),lp1->getColumn());
	
#line 14212 "CslParser.cpp"
	{
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5399 "csl.parser.g"
	//only identifier allowed for exp
	if( exp_AST->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER
	&& exp_AST->getFirstChild()->getType() != FUNCTION_CALL_RET_ID) {
	throwCommandError(_RS("set_field()"), _RS("Expecting identifier as the first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 14224 "CslParser.cpp"
	}
	lp2 = LT(1);
	lp2_AST = astFactory->create(lp2);
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5409 "csl.parser.g"
	//only number allowed for exp2
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_field()"), _RS("Expecting numeric expression as the second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); 
	}
	
#line 14238 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_field_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_field_AST;
}

void CslParser::param_list_set_field_position(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_field_position_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 5477 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_field_position()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIELD_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
	
#line 14275 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5494 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_field_position()"), _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14286 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5503 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_field_position()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 14297 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_field_position_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_field_position_AST;
}

void CslParser::param_list_set_position(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_position_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 5430 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_position()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TISAF_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
	
#line 14334 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5447 "csl.parser.g"
	//exp is only allowed to be identifier
	if(EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_position"), _RS("Expecting identifier as first argument"), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14345 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5456 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_position()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14356 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_position_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_position_AST;
}

void CslParser::param_list_set_next(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_next_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 5524 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_next()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TFIELD_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
	
#line 14393 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5541 "csl.parser.g"
	//exp is only allowed to be identifier
	if(EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_next()"), _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14404 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5550 "csl.parser.g"
	//exp2 is only allowed to be identifier
	if(EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType() 
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_next()"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14416 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_next_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_next_AST;
}

void CslParser::param_list_set_previous(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_previous_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 5573 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_previous()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TISAE_DECL | NSSymbolTable::TFIELD_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());
	
#line 14453 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5590 "csl.parser.g"
	//exp is only allowed to be identifier
	if(EXPR_PRIMARY_IDENTIFIER !=  exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_previous()"), _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14464 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5599 "csl.parser.g"
	//exp2 is only allowed to be identifier
	if(EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_previous()"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14476 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_previous_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_previous_AST;
}

void CslParser::param_list_add_allowed_range(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_add_allowed_range_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 5643 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
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
	
#line 14521 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5668 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) { 
	throwCommandError(_RS("add_allowed_range()"), _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());     
	}
	
#line 14531 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 5676 "csl.parser.g"
	
	if (STRING == exp2_AST->getFirstChild()->getType()) { 
	throwCommandError(_RS("add_allowed_range()"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());     
	}
	
#line 14542 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_add_allowed_range_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_add_allowed_range_AST;
}

void CslParser::param_list_set_attributes(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_attributes_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5691 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 14562 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 5700 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_attributes()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(),lp->getColumn());   
	
#line 14583 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 5717 "csl.parser.g"
	//exp should be one of the attribute literals
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText()); 
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_SHADOW :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SHADOW,"K_SHADOW")))));
	break;
	case K_LITERAL_READ :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_READ,"K_READ")))));
	break;
	case K_LITERAL_WRITE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WRITE,"K_WRITE")))));
	break;
	case K_LITERAL_READ_WRITE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_READ_WRITE,"K_READ_WRITE")))));
	break;
	default :
	error = TRUE;
	}
	
	if (!error) {
	
	setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { error = TRUE; }
	
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting attribute literal, found '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("set_attributes()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 14634 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_attributes_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_attributes_AST;
}

void CslParser::param_list_add_logic(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_add_logic_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6003 "csl.parser.g"
	
	TBool errorToken = FALSE;//unknown token id add_logic(token,...)
	
#line 14654 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 6012 "csl.parser.g"
	//add logics are not allowed to be called on objects, only for the current object
	if (scopeId->size()) {
	throwCommandError(_RS("add_logic(...)"), _RS("Command can't be called on an object. It must be called inside the constructor for the current object "), currentFilename.getRealLine(lp->getLine()), lp->getColumn());
	}
	
#line 14666 "CslParser.cpp"
	{
	expression();
	exp_AST = returnAST;
#line 6020 "csl.parser.g"
	//set real filename + line for id
	//   setCurrentFilename(#id);
	//id should be one of the following literals
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	TBool error = FALSE;//for the add_logics that were removed for now from language
	switch (literalEnum) {
	case K_LITERAL_NEG_OUTPUT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_NEG_OUTPUT,"K_NEG_OUTPUT")))));
	add_logic_neg_output(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_SERIAL_INPUT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SERIAL_INPUT,"K_SERIAL_INPUT")))));
	add_logic_serial_input(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_SERIAL_OUTPUT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SERIAL_OUTPUT,"K_SERIAL_OUTPUT")))));
	add_logic_serial_output(scopeId, exp_AST->getLine(), exp_AST->getColumn());
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
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_GRAY_OUTPUT,"K_GRAY_OUTPUT")))));
	add_logic_gray_output(scopeId, exp_AST->getLine(), exp_AST->getColumn());
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
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_START_VALUE,"K_START_VALUE")))));
	add_logic_start_value(scopeId);
	break;
	case K_LITERAL_END_VALUE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_END_VALUE,"K_END_VALUE")))));
	add_logic_end_value(scopeId);
	break;
	case K_LITERAL_COUNT_AMOUNT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_COUNT_AMOUNT,"K_COUNT_AMOUNT")))));
	add_logic_count_amount(scopeId);
	break;
	case K_LITERAL_COUNT_DIRECTION :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_COUNT_DIRECTION,"K_COUNT_DIRECTION")))));
	add_logic_count_direction(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_COUNT_ENABLE :
	//temp = #(#[K_COUNT_ENABLE, "K_COUNT_ENABLE"]);
	//add_logic_count_enable(scopeId, #exp->getLine(), #exp->getColumn());
	error = TRUE;
	break;
	case K_LITERAL_SET :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SET,"K_SET")))));
	add_logic_set(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_RESET_SIGNAL :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RESET,"K_RESET")))));
	add_logic_reset(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_PROGRAMMABLE_DEPTH :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PROGRAMMABLE_DEPTH,"K_PROGRAMMABLE_DEPTH")))));
	add_logic_programmable_depth(scopeId);
	break;
	case K_LITERAL_PRIORITY_BYPASS :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PRIORITY_BYPASS,"K_PRIORITY_BYPASS")))));
	add_logic_priority_bypass(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_SYNC_FIFO :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SYNC_FIFO,"K_SYNC_FIFO")))));
	add_logic_sync_fifo(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_ASYNC_FIFO :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ASYNC_FIFO,"K_ASYNC_FIFO")))));
	add_logic_async_fifo(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_DEPTH_EXTEND :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_DEPTH_EXTEND,"K_DEPTH_EXTEND")))));
	add_logic_depth_extend(scopeId);
	break;
	case K_LITERAL_WIDTH_EXTEND :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WIDTH_EXTEND,"K_WIDTH_EXTEND")))));
	add_logic_width_extend(scopeId);
	break;
	case K_LITERAL_WR_HOLD :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WR_HOLD,"K_WR_HOLD")))));
	add_logic_wr_hold(scopeId);
	break;
	case K_LITERAL_PARALLEL_OUTPUT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PARALLEL_OUTPUT,"K_PARALLEL_OUTPUT")))));
	add_logic_parallel_output(scopeId);
	break;
	case K_LITERAL_PARALLEL_INPUT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PARALLEL_INPUT,"K_PARALLEL_INPUT")))));
	add_logic_parallel_input(scopeId);
	break;
	case K_LITERAL_RD_WORDS :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RD_WORDS,"K_RD_WORDS")))));
	add_logic_rd_words(scopeId);
	break;
	case K_LITERAL_WR_WORDS :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WR_WORDS,"K_WR_WORDS")))));
	add_logic_wr_words(scopeId);
	break;
	case K_LITERAL_SRAM_RD :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SRAM_RD,"K_SRAM_RD")))));
	add_logic_sram_rd(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_SRAM_WR :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_SRAM_WR,"K_SRAM_WR")))));
	add_logic_sram_wr(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_PUSHBACK :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PUSHBACK,"K_PUSHBACK")))));
	add_logic_pushback(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_FLOW_THROUGH :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_FLOW_THROUGH,"K_FLOW_THROUGH")))));
	add_logic_flow_through(scopeId);
	break;
	case K_LITERAL_STALL :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_STALL,"K_STALL")))));
	add_logic_stall(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_STALL_RD_SIDE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_STALL_RD_SIDE,"K_STALL_RD_SIDE")))));
	add_logic_stall_rd_side(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_STALL_WR_SIDE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_STALL_WR_SIDE,"K_STALL_WR_SIDE")))));
	add_logic_stall_wr_side(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_WR_RELEASE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WR_RELEASE,"K_WR_RELEASE")))));
	add_logic_wr_release(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_ALMOST_EMPTY :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ALMOST_EMPTY,"K_ALMOST_EMPTY")))));
	add_logic_almost_empty(scopeId);
	break;
	case K_LITERAL_ALMOST_FULL :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ALMOST_FULL,"K_ALMOST_FULL")))));
	add_logic_almost_full(scopeId);
	break;
	case K_LITERAL_OUTPUT_WR_ADDR :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OUTPUT_WR_ADDR,"K_OUTPUT_WR_ADDR")))));
	add_logic_output_wr_addr(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_OUTPUT_RD_ADDR :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OUTPUT_RD_ADDR,"K_OUTPUT_RD_ADDR")))));
	add_logic_output_rd_addr(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_CREDIT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CREDIT,"K_CREDIT")))));
	add_logic_credit(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_RD_CREDIT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RD_CREDIT,"K_RD_CREDIT")))));
	add_logic_rd_credit(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_WR_CREDIT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WR_CREDIT,"K_WR_CREDIT")))));
	add_logic_wr_credit(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_FLOW :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_FLOW,"K_FLOW")))));
	add_logic_flow(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_READ_VALID :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_READ_VALID,"K_READ_VALID")))));
	add_logic_read_valid(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_BYPASS :
	//         add_logic_bypass(scopeId, #exp->getLine(), #exp->getColumn());
	//         #param_list_add_logic = #(#[K_BYPASS, "K_BYPASS"], returnAST);
	error = TRUE;
	break;
	case K_LITERAL_GENERATE_WAVES :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_GENERATE_WAVES,"K_GENERATE_WAVES")))));
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
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CLOCK_SIGNAL,"K_CLOCK_SIGNAL")))));
	add_logic_clock(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_GENERATE_REPORT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_GENERATE_REPORT,"K_GENERATE_REPORT")))));
	add_logic_generate_report(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_ASYNC_RESET :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ASYNC_RESET,"K_ASYNC_RESET")))));
	add_logic_async_reset(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_INIT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INIT,"K_INIT")))));
	add_logic_init(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_CLEAR :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CLEAR,"K_CLEAR")))));
	add_logic_clear(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_STOP :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_STOP,"K_STOP")))));
	add_logic_stop(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_DIRECTION_CONTROL :
	//           temp = #(#[K_DIRECTION_CONTROL, "K_DIRECTION_CONTROL"]);
	//           add_logic_direction_control(scopeId, #exp->getLine(), #exp->getColumn());
	error = TRUE;
	break;
	case K_LITERAL_INJECT_STALLS :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INJECT_STALLS,"K_INJECT_STALLS")))));
	add_logic_inject_stalls(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	case K_LITERAL_EXTERNAL_UNIT_ENABLE :
	//           temp = #(#[K_EXTERNAL_UNIT_ENABLE, "K_EXTERNAL_UNIT_ENABLE"]);
	//           add_logic_external_unit_enable(scopeId, #exp->getLine(), #exp->getColumn());
	error = TRUE;
	break;
	case K_LITERAL_UNIT_ADDRESS_DECODER :
	//           temp = #(#[K_UNIT_ADDRESS_DECODER, "K_UNIT_ADDRESS_DECODER"]);
	//           add_logic_unit_address_decoder(scopeId, #exp->getLine(), #exp->getColumn());
	error = TRUE;
	break;
	case K_LITERAL_LOAD :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_LOAD,"K_LOAD")))));
	add_logic_load(scopeId, exp_AST->getLine(), exp_AST->getColumn());
	break;
	default :
	errorToken = TRUE;
	//           RefString msg = _RS("Unexpected token '");
	//           msg->append( #exp->getFirstChild()->getFirstChild()->getText());
	//           msg->append( "' ");
	//           throwCommandError(_RS("add_logic()"), msg, #exp->getLine(), currentFilename.getRealLine(#exp->getColumn());
	}
	if (error) {//the add logics that were removed from language for now
	RefString msg = _RS("Command add_logic(");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( ") was removed from language");
	throwError( msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	//set real filename + line for fake vertex and add it to AST
	// the fake vertex has as child the add logic rule for that literal
	//       setCurrentFilename(temp, #id->getColumn(), #exp->getLine());
	if (!errorToken) {
	setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
	temp->addChild(returnAST);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { errorToken = TRUE; }
	}
	else { errorToken = TRUE; }
	
	if (errorToken) {
	
	RefString msg = _RS("Unexpected token '");
	if ((exp_AST->getFirstChild()->getFirstChild()).get()) {
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	}
	else {
	msg->append( exp_AST->getFirstChild()->getText());
	}
	msg->append( "' ");
	throwCommandError(_RS("add_logic()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
	
#line 14988 "CslParser.cpp"
	}
	}
	param_list_add_logic_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_add_logic_AST;
}

void CslParser::param_list_set_vc_start_generation_trigger(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_start_generation_trigger_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 8790 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_start_generation_trigger()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15026 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 8809 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_start_generation_trigger()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15038 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_start_generation_trigger_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_start_generation_trigger_AST;
}

void CslParser::param_list_set_unit_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_unit_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 8918 "csl.parser.g"
	//set real filename + line for lp
	setCurrentFilename(lp_AST);
	
	//command call options
	RefString command = _RS("set_unit_name()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEMMAPP_DECL | NSSymbolTable::TVEC_DECL | NSSymbolTable::TSTATED_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15077 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 8938 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_unit_name()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15088 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_unit_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_unit_name_AST;
}

void CslParser::param_list_pipestage_naming_convention(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_pipestage_naming_convention_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 9067 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("pipestage_naming_conventions()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TPIPESTG_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15124 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(RPAREN);
	}
	param_list_pipestage_naming_convention_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_pipestage_naming_convention_AST;
}

void CslParser::param_list_merge(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_merge_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 9561 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 15149 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 9570 "csl.parser.g"
	//set real flename + line for lp
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("merge()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 ;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
	NSSymbolTable::TDESIGN | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL | NSSymbolTable::TSIGNALGR_DECL));
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15174 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9591 "csl.parser.g"
	//exp should be one of merge operators
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_NAND :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_NAND,"K_NAND")))));
	break;
	case K_LITERAL_NOR :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_NOR,"K_NOR")))));
	break;
	case K_LITERAL_XNOR :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_XNOR,"K_XNOR")))));
	break;
	case K_LITERAL_AND :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_AND,"K_AND")))));
	break;
	case K_LITERAL_OR :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OR,"K_OR")))));
	break;
	case K_LITERAL_XOR :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_XOR,"K_XOR")))));
	break;
	case K_LITERAL_NOT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_NOT,"K_NOT")))));
	break;
	case K_LITERAL_PLUS :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OR,"K_OR")))));
	break;
	default :
	error = TRUE;
	}
	if (!error) {
	setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	
	}
	else { error = TRUE; }
	
	}
	else { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting merge operator, found '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("merge()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15234 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		exp2_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9649 "csl.parser.g"
		
		if (EXPR_PRIMARY_IDENTIFIER != exp2_AST->getFirstChild()->getType()
		&& FUNCTION_CALL_RET_ID != exp2_AST->getFirstChild()->getType()) {
		throwCommandError(_RS("merge()"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
		}
		
#line 15250 "CslParser.cpp"
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				expression();
				exp3_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9658 "csl.parser.g"
				
				if (EXPR_PRIMARY_IDENTIFIER != exp3_AST->getFirstChild()->getType()
				&& FUNCTION_CALL_RET_ID != exp3_AST->getFirstChild()->getType()) {
				throwCommandError(_RS("merge()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn());
				}
				
#line 15265 "CslParser.cpp"
			}
			else {
				goto _loop373;
			}
			
		}
		_loop373:;
		} // ( ... )*
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	param_list_merge_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_merge_AST;
}

void CslParser::param_list_set_vc_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12720 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15322 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12738 "csl.parser.g"
	//exp is only allowed to be identifier
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15333 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_name_AST;
}

void CslParser::param_list_set_vc_header_comment(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_header_comment_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12760 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_header_comment()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15372 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12780 "csl.parser.g"
	
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_header_comment()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15383 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_header_comment_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_header_comment_AST;
}

void CslParser::param_list_set_version(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_version_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12802 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_version()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15422 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12822 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_version()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15432 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_version_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_version_AST;
}

void CslParser::param_list_set_vc_clock(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_clock_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12843 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_clock()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15471 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12863 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_clock()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15483 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_clock_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_clock_AST;
}

void CslParser::param_list_set_vc_reset(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_reset_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12886 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_reset()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15522 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12906 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_reset()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15534 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_reset_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_reset_AST;
}

void CslParser::param_list_set_vc_stall(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_stall_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12929 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_stall()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15573 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12949 "csl.parser.g"
	//expression is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_stall()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15585 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_stall_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_stall_AST;
}

void CslParser::param_list_set_vc_end_generation_trigger(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_end_generation_trigger_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12972 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_end_generation_trigger()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15624 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 12992 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_end_generation_trigger()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15636 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_end_generation_trigger_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_end_generation_trigger_AST;
}

void CslParser::param_list_set_vc_capture_edge_type(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_capture_edge_type_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 13009 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 15656 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13018 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_capture_edge_type()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15680 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 13038 "csl.parser.g"
	
	
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_RISE :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RISE,"K_RISE")))));
	break;
	case K_LITERAL_FALL :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_FALL,"K_FALL")))));
	break;
	default :
	error = TRUE;
	}
	
	if (!error) {
	setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { error = TRUE; }
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting 'rise' or 'fall' as argument");
	//     if (#exp->getFirstChild()->getFirstChild()) {
	//       msg->append( #exp->getFirstChild()->getFirstChild()->getText());
	//     }
	//     else {
	//       msg->append( #exp->getFirstChild()->getText());
	//     }
	//     msg->append( "' ");
	throwCommandError(_RS("set_vc_capture_edge_type()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15730 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_capture_edge_type_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_capture_edge_type_AST;
}

void CslParser::param_list_set_vc_max_number_of_mismatches(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_max_number_of_mismatches_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13123 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_max_number_of_mismatches()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15769 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13143 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_max_number_of_mismatches()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15779 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_max_number_of_mismatches_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_max_number_of_mismatches_AST;
}

void CslParser::param_list_set_vc_max_number_of_valid_transactions(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_max_number_of_valid_transactions_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13164 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_max_number_of_valid_transactions()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15816 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13182 "csl.parser.g"
	
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_max_number_of_valid_transactions()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15826 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_max_number_of_valid_transactions_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_max_number_of_valid_transactions_AST;
}

void CslParser::param_list_set_vc_valid_output_transaction(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_valid_output_transaction_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13203 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_valid_output_transaction()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15865 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13223 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_valid_output_transaction()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15876 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_valid_output_transaction_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_valid_output_transaction_AST;
}

void CslParser::param_list_set_vc_output_filename(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_output_filename_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13268 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_output_filename()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15915 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13288 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_output_filename()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15926 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_output_filename_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_output_filename_AST;
}

void CslParser::param_list_set_vc_max_cycles(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_vc_max_cycles_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13356 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_vc_max_cycles()");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 15965 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13376 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_vc_max_cycles()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 15975 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_vc_max_cycles_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_vc_max_cycles_AST;
}

void CslParser::param_list_set_mem_instance_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_mem_instance_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10880 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_mem_instance_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL ; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16012 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 10898 "csl.parser.g"
	//exp is only allowed to be identifier
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_mem_instance_name()"), _RS("Expecting identifier as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16023 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_mem_instance_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_mem_instance_name_AST;
}

void CslParser::param_list_set_reset_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_reset_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10920 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_reset_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16059 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 10937 "csl.parser.g"
	//exp in only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_reset_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(lp->getLine()), lp->getColumn()); 
	}
	
#line 16070 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_reset_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_reset_name_AST;
}

void CslParser::param_list_set_clock_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_clock_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10959 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_clock_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16106 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 10976 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_clock_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16117 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_clock_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_clock_name_AST;
}

void CslParser::param_list_set_rd_clock_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_rd_clock_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 10998 "csl.parser.g"
	
	RefString command = _RS("set_rd_clock_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16151 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11013 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_rd_clock_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16162 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_rd_clock_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_rd_clock_name_AST;
}

void CslParser::param_list_set_wr_clock_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_wr_clock_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11035 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_wr_clock_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16198 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11052 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_wr_clock_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16209 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_wr_clock_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_wr_clock_name_AST;
}

void CslParser::param_list_set_push_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_push_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11074 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_push_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16245 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11091 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_push_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16256 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_push_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_push_name_AST;
}

void CslParser::param_list_set_pop_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_pop_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11113 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_pop_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16292 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11130 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_pop_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16303 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_pop_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_pop_name_AST;
}

void CslParser::param_list_set_full_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_full_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11152 "csl.parser.g"
	//set real filename
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_full_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16339 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11169 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_full_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16350 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_full_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_full_name_AST;
}

void CslParser::param_list_set_empty_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_empty_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11191 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_empty_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16386 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11208 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_empty_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16397 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_empty_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_empty_name_AST;
}

void CslParser::param_list_set_wr_data_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_wr_data_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11230 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_wr_data_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16433 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11247 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_wr_data_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16444 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_wr_data_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_wr_data_name_AST;
}

void CslParser::param_list_set_rd_data_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_rd_data_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11269 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_rd_data_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16480 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11286 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_rd_data_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16491 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_rd_data_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_rd_data_name_AST;
}

void CslParser::param_list_set_valid_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_valid_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11308 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_valid_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16527 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11325 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_valid_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 16538 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_valid_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_valid_name_AST;
}

void CslParser::param_list_set_wr_addr_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_wr_addr_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11347 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_wr_addr_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16574 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11364 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_wr_addr_name()"), _RS("Expecting string as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16585 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_wr_addr_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_wr_addr_name_AST;
}

void CslParser::param_list_set_rd_addr_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_rd_addr_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11386 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_rd_addr_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16621 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11403 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_rd_addr_name()"), _RS("Expecting string as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16632 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_rd_addr_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_rd_addr_name_AST;
}

void CslParser::param_list_set_wr_en_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_wr_en_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11425 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_wr_en_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16668 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11442 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_wr_en_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16679 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_wr_en_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_wr_en_name_AST;
}

void CslParser::param_list_set_rd_en_name(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_rd_en_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 11464 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_rd_en_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16715 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 11481 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_rd_en_name()"), _RS("Expecting string as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16726 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_rd_en_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_rd_en_name_AST;
}

void CslParser::param_list_initialize_random_values(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_initialize_random_values_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 9353 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("initialize_random_values()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16762 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9370 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("initialize_random_values()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16772 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_initialize_random_values_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_initialize_random_values_AST;
}

void CslParser::param_list_initialize_random(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_initialize_random_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 9391 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("initialize_random()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16808 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 9408 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("initialize_random()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16818 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_initialize_random_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_initialize_random_AST;
}

void CslParser::param_list_set_unit_id(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_unit_id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15311 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_unit_id()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16858 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 15332 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_unit_id()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16868 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_unit_id_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_unit_id_AST;
}

void CslParser::param_list_set_num_rd_ifc(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_num_rd_ifc_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15447 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_num_rd_ifc()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16905 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 15465 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_num_rd_ifc()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16915 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_num_rd_ifc_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_num_rd_ifc_AST;
}

void CslParser::param_list_set_num_wr_ifc(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_num_wr_ifc_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15486 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_num_wr_ifc()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16952 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 15504 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("set_num_wr_ifc()"), _RS("Expecting numeric expression as argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 16962 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_num_wr_ifc_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_num_wr_ifc_AST;
}

void CslParser::param_list_gen_unique_rtl_modules(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_gen_unique_rtl_modules_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15525 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("gen_unique_rtl_modules()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TFIFO_DECL
	| NSSymbolTable::TRF_DECL | NSSymbolTable::TMEM_DECL | NSSymbolTable::TTB_DECL; 
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); // not necessary
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 16999 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_gen_unique_rtl_modules_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_gen_unique_rtl_modules_AST;
}

void CslParser::param_list_no_prefix(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_no_prefix_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15558 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("no_prefix()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TIFC_DECL | NSSymbolTable::TSIGNALGR_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TIFC_DECL | NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
	NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TUNIT_DECL));
	
	//   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
	//                                                           NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 17044 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_no_prefix_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_no_prefix_AST;
}

void CslParser::param_list_override_parameter(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_override_parameter_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15599 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("override_parameter()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 ; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TIFC_DECL | NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
	NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TUNIT_DECL));
	
	//   callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TTB_DECL,
	//                                                           NSSymbolTable::TUNIT_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TRF_DECL
	//                                                           | NSSymbolTable::TFIFO_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL));
	/*                                                           NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL
	| NSSymbolTable::TREG_DECL | NSSymbolTable::TRF_DECL | NSSymbolTable::TFIFO_DECL
	| TMEM_DECL));*/
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TREG_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL));
	
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TRF_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL));
	
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIFO_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TTB_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEM_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 17112 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 15647 "csl.parser.g"
	
	if (exp_AST->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER) {
	throwCommandError(command, _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 17122 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 15655 "csl.parser.g"
	
	if (exp_AST->getFirstChild()->getType() == STRING) {
	throwCommandError(command, _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 17133 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_override_parameter_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_override_parameter_AST;
}

void CslParser::param_list_do_not_gen_rtl(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_do_not_gen_rtl_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15677 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("do_not_gen_rtl()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TFIFO_DECL
	| NSSymbolTable::TRF_DECL | NSSymbolTable::TMEM_DECL | NSSymbolTable::TTB_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 17170 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_do_not_gen_rtl_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_do_not_gen_rtl_AST;
}

void CslParser::param_list_do_not_gen_cpp(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_do_not_gen_cpp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15710 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("do_not_gen_cpp()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL | NSSymbolTable::TREG_DECL | NSSymbolTable::TFIFO_DECL
	| NSSymbolTable::TRF_DECL | NSSymbolTable::TMEM_DECL | NSSymbolTable::TTB_DECL; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 17207 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_do_not_gen_cpp_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_do_not_gen_cpp_AST;
}

void CslParser::param_list_set_clock(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_set_clock_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15743 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("set_clock()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSIGNALGR_DECL | NSSymbolTable::TIFC_DECL | NSSymbolTable::TUNIT_DECL ; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TIFC_DECL));
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL));
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TUNIT_DECL | TIFC_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 17256 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 15773 "csl.parser.g"
	
	if (exp_AST->getFirstChild()->getType() == STRING
	|| exp_AST->getFirstChild()->getType() == UNSIGNED_NUMBER) {
	throwCommandError(command, _RS("Expecting identifier as argument"), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 17267 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_set_clock_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_set_clock_AST;
}

void CslParser::param_list_register_ios(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_register_ios_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  rp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST rp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id3 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp3 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 15789 "csl.parser.g"
	
	TBool wasEnable = FALSE;
	TBool wasReset = FALSE;
	TBool wasResetVal = FALSE;
	RefCslAST temp;
	
#line 17304 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 15802 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("register_ios()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TUNIT_DECL ; 
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 17329 "CslParser.cpp"
	id = LT(1);
	id_AST = astFactory->create(id);
	match(IDENTIFIER);
#line 15823 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(id_AST);
	RefString literalString = _RS(id_AST->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temporary;
	switch (literalEnum) {
	case K_LITERAL_INPUT :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_INPUT,"K_INPUT")))));
	break;
	case K_LITERAL_OUTPUT :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OUTPUT,"K_OUTPUT")))));
	break;
	default :
	throwCommandError(command, _RS("Expecting 'input' or 'output' as first argument "), currentFilename.getRealLine(id_AST->getLine()), id_AST->getColumn());
	}
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
	
#line 17351 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		match(DOT);
		id2 = LT(1);
		id2_AST = astFactory->create(id2);
		match(IDENTIFIER);
#line 15846 "csl.parser.g"
		//set real filename + line
		setCurrentFilename(id2_AST);
		RefString literalString = _RS(id2_AST->getText());
		TLInt literalEnum = getLiteralEnum(literalString);
		RefCslAST temporary;
		switch (literalEnum) {
		case K_LITERAL_RESET_SIGNAL :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RESET,"K_RESET")))));
		wasReset = TRUE;
		break;
		case K_LITERAL_RESET_ :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_RESET_,"K_RESET_")))));
		wasReset = TRUE;
		break;
		case K_LITERAL_ENABLE :
		temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ENABLE,"K_ENABLE")))));
		wasEnable = TRUE;
		break;  
		default :
		throwCommandError(command, _RS("Expecting 'reset', 'reset_' or 'en' as formal to actual first argument "), currentFilename.getRealLine(id2_AST->getLine()), id2_AST->getColumn());
		}
		temp = temporary;
		//    astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
		
#line 17386 "CslParser.cpp"
		lp2 = LT(1);
		lp2_AST = astFactory->create(lp2);
		match(LPAREN);
		expression();
		exp_AST = returnAST;
#line 15875 "csl.parser.g"
		
		if (exp_AST->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER) {
		throwCommandError(command, _RS("Expecting identifier as formal to actual parameter "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
		}
		temp->addChild(exp_AST);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
		
#line 17400 "CslParser.cpp"
		rp = LT(1);
		rp_AST = astFactory->create(rp);
		match(RPAREN);
#line 15883 "csl.parser.g"
		setCurrentFilename(rp_AST);
#line 17406 "CslParser.cpp"
		{
		if (((LA(1) == COMMA))&&(!wasEnable)) {
			match(COMMA);
			expression();
			exp2_AST = returnAST;
#line 15888 "csl.parser.g"
			
			wasResetVal = TRUE;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(exp2_AST));
			
#line 17417 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				match(DOT);
				id3 = LT(1);
				id3_AST = astFactory->create(id3);
				match(IDENTIFIER);
#line 15898 "csl.parser.g"
				//set real filename + line
				setCurrentFilename(id3_AST);
				RefString literalString = _RS(id3_AST->getText());
				TLInt literalEnum = getLiteralEnum(literalString);
				RefCslAST temporary;
				switch (literalEnum) {
				case K_LITERAL_ENABLE :
				temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ENABLE,"K_ENABLE")))));
				break;  
				default :
				throwCommandError(command, _RS("Expecting 'en' as formal to actual second argument "), currentFilename.getRealLine(id3_AST->getLine()), id3_AST->getColumn());
				}
				temp = temporary;
				//    astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
				
#line 17443 "CslParser.cpp"
				lp3 = LT(1);
				lp3_AST = astFactory->create(lp3);
				match(LPAREN);
				expression();
				exp3_AST = returnAST;
#line 15917 "csl.parser.g"
				
				if (exp3_AST->getFirstChild()->getType() != EXPR_PRIMARY_IDENTIFIER) {
				throwCommandError(command, _RS("Expecting identifier as formal to actual parameter "), currentFilename.getRealLine(exp3_AST->getLine()), exp3_AST->getColumn());
				}
				temp->addChild(exp3_AST);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
				
#line 17457 "CslParser.cpp"
				match(RPAREN);
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
		}
		else if ((LA(1) == RPAREN)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
#line 15929 "csl.parser.g"
		
		if (wasReset && !wasResetVal) {
		throwCommandError(command, _RS("Expecting reset value after reset formal to actual "), currentFilename.getRealLine(rp_AST->getLine()), rp_AST->getColumn());
		}
		
#line 17485 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	param_list_register_ios_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_register_ios_AST;
}

void CslParser::param_list_connect_units(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_connect_units_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13869 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	
	//   if (wasConcat) {
	//     throwCommandError(_RS("connect()"), _RS("Command call not allowed on concatenation "), currentFilename.getRealLine(#lp->getLine()), #lp->getColumn());
	//   }
	//command call options
	RefString command = _RS("connect_units()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
	//                                                         NSSymbolTable::TUNIT_DECL));
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TREG_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TRF_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TFIFO_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TMEM_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 17557 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13909 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(command, _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 17569 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		exp2_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13920 "csl.parser.g"
		
		if (STRING != exp2_AST->getFirstChild()->getType()) {
		throwCommandError(command, _RS("Expecting string as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
		}
		
#line 17584 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	param_list_connect_units_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_connect_units_AST;
}

void CslParser::param_list_connect_by_pattern(
	RefTVec_RefString scopeId, TBool wasConcat
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_connect_by_pattern_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13943 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	
	//   if (wasConcat) {
	//     throwCommandError(_RS("connect()"), _RS("Command call not allowed on concatenation "), currentFilename.getRealLine(#lp->getLine()), #lp->getColumn());
	//   }
	//command call options
	RefString command = _RS("connect_by_pattern()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn(), wasConcat);
	
#line 17650 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13977 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& RANGE_EXPRESSION     != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throwCommandError(command, _RS("Expecting identifier as first argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 17662 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		exp2_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13988 "csl.parser.g"
		
		if (EXPR_PRIMARY_IDENTIFIER != exp2_AST->getFirstChild()->getType()
		&& FUNCTION_CALL_RET_ID != exp2_AST->getFirstChild()->getType()) {
		throwCommandError(command, _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
		}
		
#line 17678 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	param_list_connect_by_pattern_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_connect_by_pattern_AST;
}

void CslParser::param_list_connect_by_name(
	RefTVec_RefString scopeId, TBool wasConcat
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_connect_by_name_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 14012 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	
	//   if (wasConcat) {
	//     throwCommandError(_RS("connect()"), _RS("Command call not allowed on concatenation "), currentFilename.getRealLine(#lp->getLine()), #lp->getColumn());
	//   }
	//command call options
	RefString command = _RS("connect_by_name()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TPORT_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TSIGNAL_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn(), wasConcat);
	
#line 17744 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		exp2_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 14057 "csl.parser.g"
		
		if (EXPR_PRIMARY_IDENTIFIER != exp2_AST->getFirstChild()->getType()
		&& FUNCTION_CALL_RET_ID != exp2_AST->getFirstChild()->getType()) {
		throwCommandError(command, _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
		}
		
#line 17763 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	param_list_connect_by_name_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_connect_by_name_AST;
}

void CslParser::csl_statement_assign(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST csl_statement_assign_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	expression();
	exp_AST = returnAST;
#line 4872 "csl.parser.g"
	//DCERR(#exp->getText() << " --- linenumber:" << #exp->getLine());
	////   RefCslAST temp = #exp->getFirstChild();
	//DCERR(#exp->getFirstChild()->getText() );//<< " --- linenumber:" << #exp->getFirstChild()->getLine());
	//DCERR(#exp->getFirstChild()->getFirstChild()->getText() );//<< " --- linenumber:" << #exp->getFirstChild()->getFirstChild()->getLine());
	//add fake vertex to AST
	RefCslAST currentFilenameTemp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ASSIGNOR,"ASSIGNOR")))));
	setCurrentFilename(currentFilenameTemp, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST,  ANTLR_USE_NAMESPACE(antlr)RefAST(currentFilenameTemp));
	astFactory->addASTChild(currentAST,  ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	
#line 17804 "CslParser.cpp"
	}
	csl_statement_assign_AST = antlr::RefCslAST(currentAST.root);
	returnAST = csl_statement_assign_AST;
}

void CslParser::add_logic_neg_output(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_neg_output_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 6353 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(neg_output)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
	
#line 17831 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_neg_output_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_neg_output_AST;
}

void CslParser::add_logic_serial_input(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_serial_input_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 6381 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(serial_input)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
	
#line 17859 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_serial_input_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_serial_input_AST;
}

void CslParser::add_logic_serial_output(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_serial_output_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 6409 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(serial_output)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
	
#line 17887 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_serial_output_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_serial_output_AST;
}

void CslParser::add_logic_clock(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_clock_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6479 "csl.parser.g"
	
	RefCslAST exp_name, exp_period, exp_base;
	TBool error = FALSE;
	
#line 17905 "CslParser.cpp"
	
	{
#line 6489 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(clock)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL | NSSymbolTable::TTB_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
	
#line 17921 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
#line 6502 "csl.parser.g"
		exp_name = returnAST;
#line 17930 "CslParser.cpp"
		match(COMMA);
		expression();
#line 6502 "csl.parser.g"
		exp_period = returnAST;
#line 17935 "CslParser.cpp"
		match(COMMA);
		expression();
#line 6502 "csl.parser.g"
		exp_base = returnAST;
#line 17940 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 6504 "csl.parser.g"
	//checks for long version of add_logic(clock)
	RefCslAST temp;
	TBool wasLiteral = FALSE;
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST !=  exp_base) {
	
	//time_base checks
	if (EXPR_PRIMARY_IDENTIFIER == exp_base->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_base->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_base->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_base->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	switch (literalEnum) {
	case K_LITERAL_PIPE_STALL :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_PS,"K_PS")))));
	break;
	case K_LITERAL_NS :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_NS,"K_NS")))));
	break;
	case K_LITERAL_US :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_US,"K_US")))));
	break;
	case K_LITERAL_MUX_SELECT :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_MS,"K_MS")))));
	break;
	case K_LITERAL_S :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_S,"K_S")))));
	break;
	default :
	error = TRUE;
	}
	
	if (!error) {
	
	setCurrentFilename(temp, exp_base->getColumn(), exp_base->getLine());
	wasLiteral = TRUE;
	}
	}
	else { error = TRUE; }
	
	}
	else if (FUNCTION_CALL_RET_ID != exp_base->getFirstChild()->getType()) { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting time base as fourth argument, found '");
	msg->append( exp_base->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("add_logic(clock,...)"), msg, currentFilename.getRealLine(exp_base->getLine()), exp_base->getColumn());
	}
	
	//period checks
	if (STRING == exp_period->getFirstChild()->getType()) {
	
	throwCommandError(_RS("add_logic(clock),...)"), _RS("Expecting numeric as third argument "), currentFilename.getRealLine(exp_period->getLine()), exp_period->getColumn());
	}
	
	//clock_name checks
	if (EXPR_PRIMARY_IDENTIFIER != exp_name->getFirstChild()->getType()
	&& RANGE_EXPRESSION != exp_name->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_name->getFirstChild()->getType()) {
	
	throwCommandError(_RS("add_logic(clock,...)"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp_name->getLine()), exp_name->getColumn());
	}
	else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(exp_name)); }
	
	}//the order that the vertexes should be added to the AST is opposite to the order of the checking(which was done from the last to the first)
	
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(exp_period));
	
	if (wasLiteral) { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp)); }
	else { astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(exp_base));}
	
	
#line 18029 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_clock_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_clock_AST;
}

void CslParser::add_logic_generate_report(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_generate_report_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6589 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 18047 "CslParser.cpp"
	
	{
#line 6598 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(generate_report,...)");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_TESTBENCH, command, line, column);
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TTB_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);   
	
#line 18065 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		exp_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 6615 "csl.parser.g"
		
		if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
		
		if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
		&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
		
		RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
		TLInt literalEnum = getLiteralEnum(literalString);
		RefCslAST temp;
		switch (literalEnum) {
		case K_LITERAL_COLUMNS :
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_COLUMNS,"K_COLUMNS")))));
		break;
		case K_LITERAL_ROWS :
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ROWS,"K_ROWS")))));
		break;
		default :
		error = TRUE;
		}
		
		if (!error) {
		
		setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
		}
		}
		else { error = TRUE; }
		}
		else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
		
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else { error = TRUE; }
		
		if (error) {
		RefString msg = _RS("Expecting 'columns' or 'rows', found '");
		if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp_AST->getFirstChild()->getFirstChild()) {
		msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
		}
		else { msg->append( exp_AST->getFirstChild()->getText()); }
		msg->append( "' ");
		throwCommandError(_RS("add_logic(generate_report,...)"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
		}
		
#line 18119 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	add_logic_generate_report_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_generate_report_AST;
}

void CslParser::add_logic_async_reset(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_async_reset_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 6677 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(async_reset)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18159 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_async_reset_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_async_reset_AST;
}

void CslParser::add_logic_init(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_init_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6699 "csl.parser.g"
	
	RefCslAST exp;
	
#line 18176 "CslParser.cpp"
	
	{
#line 6708 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(init)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18192 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 6721 "csl.parser.g"
		exp = returnAST;
#line 18202 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 6723 "csl.parser.g"
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {
	
	if (STRING == exp->getFirstChild()->getType()) {
	
	throwCommandError(_RS("add_logic(init,...)"), _RS("Expecting numeric value as second argument "), currentFilename.getRealLine(exp->getLine()), exp->getColumn());
	}
	}
	
#line 18225 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_init_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_init_AST;
}

void CslParser::add_logic_clear(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_clear_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6742 "csl.parser.g"
	
	RefCslAST exp;
	
#line 18242 "CslParser.cpp"
	
	{
#line 6751 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(clear)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18258 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 6764 "csl.parser.g"
		exp = returnAST;
#line 18268 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 6766 "csl.parser.g"
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {
	
	if (STRING == exp->getFirstChild()->getType()) {
	
	throwCommandError(_RS("add_logic(clear,...)"), _RS("Expecting numeric value as second argument "), currentFilename.getRealLine(exp->getLine()), exp->getColumn());
	}
	}
	
#line 18291 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_clear_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_clear_AST;
}

void CslParser::add_logic_stop(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_stop_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 6791 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(stop,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18320 "CslParser.cpp"
	match(COMMA);
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 6806 "csl.parser.g"
	
	if (STRING != exp_AST->getFirstChild()->getType()) {
	
	throwCommandError(_RS("add_logic(stop,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 18332 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_stop_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_stop_AST;
}

void CslParser::add_logic_inject_stalls(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_inject_stalls_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 6860 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(inject_stalls)");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_VERIFICATION_COMPONENTS, command, line, column);
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSTATED_DECL | NSSymbolTable::TVEC_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; //not necessary (not allowed)
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18363 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_inject_stalls_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_inject_stalls_AST;
}

void CslParser::add_logic_load(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_load_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 6891 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(load)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; //not necessary (not allowed)
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18392 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_load_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_load_AST;
}

void CslParser::add_logic_generate_waves(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_generate_waves_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7043 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 18414 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(COMMA);
#line 7052 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("add_logic(generate_waves,...)");
	
	checkAllowedCompCommand(NSCslc::CslcTool::COMP_TESTBENCH, command, lp_AST->getLine(), lp_AST->getColumn());
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TTB_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 18438 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 7072 "csl.parser.g"
	//exp is only allowed to be string
	if (STRING != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_EXPR != exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(generate_waves,...)"), _RS("Expecting string as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	
#line 18449 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
#line 7082 "csl.parser.g"
	//exp2 is only allowed to be wave_type literal
	if (EXPR_PRIMARY_IDENTIFIER == exp2_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp2_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp2_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp2_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_WAVE_TYPE_FSDB :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WAVE_TYPE_FSDB,"K_WAVE_TYPE_FSDB")))));
	break;
	case K_LITERAL_WAVE_TYPE_VCD :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_WAVE_TYPE_VCD,"K_WAVE_TYPE_VCD")))));
	break;
	default :
	error = TRUE;
	}
	
	if (!error) {
	
	setCurrentFilename(temp, exp2_AST->getColumn(), exp2_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { error = TRUE; }
	}
	else if (FUNCTION_CALL_RET_ID == exp2_AST->getFirstChild()->getType()) {
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) { 
	RefString msg = _RS("Expecting wave type as third argument, found '");
	msg->append( exp2_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("add_logic(generate_waves,...)"), msg, currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn());
	}
	
#line 18494 "CslParser.cpp"
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			expression();
			exp3_AST = returnAST;
#line 7125 "csl.parser.g"
			//exp3 is only allowed to be identifier
			if (EXPR_PRIMARY_IDENTIFIER != exp3_AST->getFirstChild()->getType()
			&& FUNCTION_CALL_RET_ID != exp3_AST->getFirstChild()->getType()) {
			
			throwCommandError(_RS("add_logic(generate_waves),...)"), _RS("Expecting identifier as argument"), exp3_AST->getLine(), exp3_AST->getColumn());
			}
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			
#line 18510 "CslParser.cpp"
		}
		else {
			goto _loop285;
		}
		
	}
	_loop285:;
	} // ( ... )*
	match(RPAREN);
	}
	add_logic_generate_waves_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_generate_waves_AST;
}

void CslParser::add_logic_gray_output(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_gray_output_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 7174 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(gray_output)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18547 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_gray_output_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_gray_output_AST;
}

void CslParser::add_logic_start_value(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_start_value_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(COMMA);
#line 7251 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("add_logic(start_value,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 18584 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7269 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(start_value,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 18594 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_start_value_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_start_value_AST;
}

void CslParser::add_logic_end_value(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_end_value_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(COMMA);
#line 7290 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("add_logic(end_value,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 18631 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7308 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(end_value,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 18641 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_end_value_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_end_value_AST;
}

void CslParser::add_logic_count_amount(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_count_amount_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(COMMA);
#line 7329 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("add_logic(count_amount,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 18678 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7347 "csl.parser.g"
	//exp is only allowed to be numeric
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(count_amount,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 18688 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_count_amount_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_count_amount_AST;
}

void CslParser::add_logic_count_direction(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_count_direction_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(COMMA);
#line 7368 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	
	//command call options
	
	RefString command = _RS("add_logic(count_direction,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 18727 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 7388 "csl.parser.g"
	
	TBool error = FALSE;
	
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temp;
	switch (literalEnum) {
	case K_LITERAL_UP :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_UP,"K_UP")))));
	break;
	case K_LITERAL_DOWN :
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_DOWN,"K_DOWN")))));
	break;
	default :
	error = TRUE;
	}
	
	if (!error) {
	
	setCurrentFilename(temp, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temp));
	}
	}
	else { error = TRUE; }
	}
	else { error = TRUE; }
	
	if (error) {
	
	RefString msg = _RS("Unexpected token '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError( _RS("add_logic(count_direction,..."), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 18771 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_count_direction_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_count_direction_AST;
}

void CslParser::add_logic_set(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_set_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7449 "csl.parser.g"
	
	RefCslAST exp;
	
#line 18788 "CslParser.cpp"
	
	{
#line 7458 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(set,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TREG_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18805 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7472 "csl.parser.g"
		exp = returnAST;
#line 18815 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 7474 "csl.parser.g"
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {
	
	if (STRING == exp->getFirstChild()->getType()) {
	
	throwCommandError(_RS("add_logic(set,...)"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp->getLine()), exp->getColumn());
	}
	}
	
#line 18838 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_set_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_set_AST;
}

void CslParser::add_logic_reset(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_reset_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7493 "csl.parser.g"
	
	RefCslAST exp;
	
#line 18855 "CslParser.cpp"
	
	{
#line 7502 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(reset,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TMEM_DECL | NSSymbolTable::TREG_DECL;
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap; // not necessary
	
	//   RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18872 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case COMMA:
	{
		match(COMMA);
		expression();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7516 "csl.parser.g"
		exp = returnAST;
#line 18882 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 7518 "csl.parser.g"
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST != exp) {
	
	if (STRING == exp->getFirstChild()->getType()) {
	
	throwCommandError(_RS("add_logic(reset,...)"), _RS("Expecting numeric expression as first argument "), currentFilename.getRealLine(exp->getLine()), exp->getColumn());
	}
	}
	
#line 18905 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_reset_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_reset_AST;
}

void CslParser::add_logic_programmable_depth(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_programmable_depth_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(COMMA);
#line 7566 "csl.parser.g"
	//set the command call options
	RefString command = _RS("add_logic(programmable_depth,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(),lp1->getColumn());
	
#line 18939 "CslParser.cpp"
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7581 "csl.parser.g"
	
	if (STRING == exp1_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(programmable_depth,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); 
	}
	
#line 18949 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_programmable_depth_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_programmable_depth_AST;
}

void CslParser::add_logic_priority_bypass(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_priority_bypass_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
#line 7600 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(priority_bypass,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 18976 "CslParser.cpp"
	match(RPAREN);
	add_logic_priority_bypass_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_priority_bypass_AST;
}

void CslParser::add_logic_sync_fifo(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_sync_fifo_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
#line 7625 "csl.parser.g"
	
	RefString command = _RS("add_logic(synch_fifo)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19002 "CslParser.cpp"
	match(RPAREN);
	add_logic_sync_fifo_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_sync_fifo_AST;
}

void CslParser::add_logic_async_fifo(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_async_fifo_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
#line 7650 "csl.parser.g"
	
	RefString command = _RS("add_logic(async_fifo)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19028 "CslParser.cpp"
	match(RPAREN);
	add_logic_async_fifo_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_async_fifo_AST;
}

void CslParser::add_logic_depth_extend(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_depth_extend_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(COMMA);
#line 7677 "csl.parser.g"
	
	RefString command = _RS("add_logic(depth_extend,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 19061 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7692 "csl.parser.g"
	
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(depth_extend,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 19071 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_depth_extend_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_depth_extend_AST;
}

void CslParser::add_logic_width_extend(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_width_extend_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(COMMA);
#line 7713 "csl.parser.g"
	
	RefString command = _RS("add_logic(width_extend,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 19105 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7728 "csl.parser.g"
	
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(width_extend,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 19115 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_width_extend_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_width_extend_AST;
}

void CslParser::add_logic_wr_hold(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_wr_hold_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(COMMA);
#line 7749 "csl.parser.g"
	
	RefString command = _RS("add_logic(wr_hold,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 19149 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7764 "csl.parser.g"
	
	if (STRING == exp_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(wr_hold,...)"), _RS("Expecting numeric expression as seond argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn()); 
	}
	
#line 19159 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_wr_hold_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_wr_hold_AST;
}

void CslParser::add_logic_parallel_output(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_parallel_output_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  list = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST list_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(COMMA);
#line 7785 "csl.parser.g"
	
	setCurrentFilename(lp1_AST);
	//set command call options
	RefString command = _RS("add_logic(parallel_output,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
	
#line 19197 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		expression();
		exp_AST = returnAST;
#line 7802 "csl.parser.g"
		//verify if the all option was supplied
		if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
		//the identifier in the expression does not have siblings or children
		if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()
		&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()) {
		
		//if the option is all add the fake vertex to AST, else add the expr to AST
		RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
		TLInt literalEnum = getLiteralEnum(literalString);
		RefCslAST temp;
		switch (literalEnum) {
		case K_LITERAL_ALL :
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ALL,"K_ALL")))));
		setCurrentFilename(temp, exp_AST->getLine(), exp_AST->getColumn());
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
		else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {//expression is function call that returns id
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {//expression is only allowed to be id
		throwCommandError(_RS("add_logic(parallel_output,...)"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
		}
		
		
#line 19340 "CslParser.cpp"
		break;
	}
	case K_CSL_LIST:
	{
		{
		list = LT(1);
		list_AST = astFactory->create(list);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(list_AST));
		match(K_CSL_LIST);
#line 7838 "csl.parser.g"
		setCurrentFilename(list_AST);
#line 19352 "CslParser.cpp"
		csl_list_declaration(list_AST->getLine(), list_AST->getColumn());
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	add_logic_parallel_output_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_parallel_output_AST;
}

void CslParser::add_logic_parallel_input(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_parallel_input_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  list = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST list_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(COMMA);
#line 7857 "csl.parser.g"
	
	setCurrentFilename(lp1_AST);
	//set command call options
	RefString command = _RS("add_logic(parallel_input,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
	
#line 19401 "CslParser.cpp"
	{
	switch ( LA(1)) {
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		expression();
		exp_AST = returnAST;
#line 7874 "csl.parser.g"
		//verify if the all option was supplied
		if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
		//the identifier in the expression does not have siblings or children
		if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()
		&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()) {
		
		//if the option is all add the fake vertex to AST, else add the expr to AST
		RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
		TLInt literalEnum = getLiteralEnum(literalString);
		RefCslAST temp;
		switch (literalEnum) {
		case K_LITERAL_ALL :
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ALL,"K_ALL")))));
		setCurrentFilename(temp, exp_AST->getLine(), exp_AST->getColumn());
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
		else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {//expression is function call that returns id
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {//expression is only allowed to be id
		throwCommandError(_RS("add_logic(parallel_input,...)"), _RS("Expecting identifier as second argument "), currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
		}
		
		
#line 19544 "CslParser.cpp"
		break;
	}
	case K_CSL_LIST:
	{
		{
		list = LT(1);
		list_AST = astFactory->create(list);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(list_AST));
		match(K_CSL_LIST);
#line 7910 "csl.parser.g"
		setCurrentFilename(list_AST);
#line 19556 "CslParser.cpp"
		csl_list_declaration(list_AST->getLine(), list_AST->getColumn());
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RPAREN);
	}
	add_logic_parallel_input_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_parallel_input_AST;
}

void CslParser::add_logic_rd_words(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_rd_words_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(COMMA);
#line 7929 "csl.parser.g"
	//set real filename for lp1
	setCurrentFilename(lp1_AST);
	// command call options
	RefString command = _RS("add_logic(rd_words,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
	
#line 19604 "CslParser.cpp"
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7946 "csl.parser.g"
	//exp1 is allowed to be only numeric
	if (STRING == exp1_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(rd_words,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); 
	}                                               
	
#line 19614 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7954 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(rd_words,...)"), _RS("Expecting numeric expression as third argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); 
	}
	
#line 19625 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_rd_words_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_rd_words_AST;
}

void CslParser::add_logic_wr_words(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_wr_words_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(COMMA);
#line 7975 "csl.parser.g"
	
	setCurrentFilename(lp1_AST);
	//command call options
	RefString command = _RS("add_logic(wr_words,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
	
#line 19662 "CslParser.cpp"
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 7992 "csl.parser.g"
	//exp1 is only allowed to be numeric
	if (STRING == exp1_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(wr_words,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); 
	}
	
#line 19672 "CslParser.cpp"
	match(COMMA);
	expression();
	exp2_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 8000 "csl.parser.g"
	//exp2 is only allowed to be numeric
	if (STRING == exp2_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(wr_words,...)"), _RS("Expecting numeric expression as third argument "), currentFilename.getRealLine(exp2_AST->getLine()), exp2_AST->getColumn()); 
	}                                               
	
#line 19683 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_wr_words_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_wr_words_AST;
}

void CslParser::add_logic_sram_rd(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_sram_rd_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8021 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(sram_rd,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19711 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_sram_rd_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_sram_rd_AST;
}

void CslParser::add_logic_sram_wr(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_sram_wr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8049 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(sram_wr,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19739 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_sram_wr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_sram_wr_AST;
}

void CslParser::add_logic_pushback(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_pushback_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8077 "csl.parser.g"
	
	RefString command = _RS("add_logic(pushback)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19767 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_pushback_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_pushback_AST;
}

void CslParser::add_logic_flow_through(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_flow_through_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(COMMA);
#line 8103 "csl.parser.g"
	//set real filename + line for lp1
	setCurrentFilename(lp1_AST);
	//command call options
	RefString command = _RS("add_logic(flow_through,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
	
#line 19803 "CslParser.cpp"
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 8120 "csl.parser.g"
	//exp1 is only allowed to be numeric
	if (STRING == exp1_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(flow_through,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); 
	}
	
#line 19813 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_flow_through_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_flow_through_AST;
}

void CslParser::add_logic_read_valid(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_read_valid_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8141 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(read_valid)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TRF_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19841 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_read_valid_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_read_valid_AST;
}

void CslParser::add_logic_stall(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_stall_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8179 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(stall)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19869 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_stall_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_stall_AST;
}

void CslParser::add_logic_stall_rd_side(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_stall_rd_side_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8207 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(stall_rd_side)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19897 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_stall_rd_side_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_stall_rd_side_AST;
}

void CslParser::add_logic_stall_wr_side(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_stall_wr_side_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8235 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(stall_wr_side)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL; 
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19925 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_stall_wr_side_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_stall_wr_side_AST;
}

void CslParser::add_logic_wr_release(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_wr_release_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8263 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(wr_release)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 19953 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_wr_release_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_wr_release_AST;
}

void CslParser::add_logic_almost_empty(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_almost_empty_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(COMMA);
#line 8291 "csl.parser.g"
	//set real filename + line for lp1
	setCurrentFilename(lp1_AST);
	//command call options
	RefString command = _RS("add_logic(almost_empty,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
	
#line 19989 "CslParser.cpp"
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 8308 "csl.parser.g"
	//exp1 is only allowed to be numeric
	if (STRING == exp1_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic_almost_empty()"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); 
	}
	
#line 19999 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_almost_empty_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_almost_empty_AST;
}

void CslParser::add_logic_almost_full(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_almost_full_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(COMMA);
#line 8329 "csl.parser.g"
	//set real filename + line for lp1
	setCurrentFilename(lp1_AST);
	//command call options
	RefString command = _RS("add_logic(almost_full,...)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp1->getLine(), lp1->getColumn());
	
#line 20035 "CslParser.cpp"
	expression();
	exp1_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 8346 "csl.parser.g"
	//exp1 is only allowed to be numeric
	if (STRING == exp1_AST->getFirstChild()->getType()) {
	throwCommandError(_RS("add_logic(almost_full,...)"), _RS("Expecting numeric expression as second argument "), currentFilename.getRealLine(exp1_AST->getLine()), exp1_AST->getColumn()); 
	}
	
#line 20045 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_almost_full_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_almost_full_AST;
}

void CslParser::add_logic_output_wr_addr(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_output_wr_addr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8367 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(output_wr_addr)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 20073 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_output_wr_addr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_output_wr_addr_AST;
}

void CslParser::add_logic_output_rd_addr(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_output_rd_addr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8395 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(output_rd_addr)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 20101 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_output_rd_addr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_output_rd_addr_AST;
}

void CslParser::add_logic_credit(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_credit_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8423 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(credit)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 20129 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_credit_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_credit_AST;
}

void CslParser::add_logic_rd_credit(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_rd_credit_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8451 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(rd_credit)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 20157 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_rd_credit_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_rd_credit_AST;
}

void CslParser::add_logic_wr_credit(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_wr_credit_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8479 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(wr_credit)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 20185 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_wr_credit_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_wr_credit_AST;
}

void CslParser::add_logic_flow(
	RefTVec_RefString scopeId, TInt line, TInt column
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST add_logic_flow_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
#line 8506 "csl.parser.g"
	//command call options
	RefString command = _RS("add_logic(flow)");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TFIFO_DECL;
	
	//    RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt); //not necessary (not allowed)
	//    RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), line, column);
	
#line 20213 "CslParser.cpp"
	match(RPAREN);
	}
	add_logic_flow_AST = antlr::RefCslAST(currentAST.root);
	returnAST = add_logic_flow_AST;
}

void CslParser::param_list_add_dut_instance() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_add_dut_instance_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	if (!( exp_AST->getType() == EXPR_PRIMARY_IDENTIFIER ))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" exp_AST->getType() == EXPR_PRIMARY_IDENTIFIER ");
	match(COMMA);
	id = LT(1);
	id_AST = astFactory->create(id);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
	match(IDENTIFIER);
#line 11991 "csl.parser.g"
	
	setCurrentFilename(id_AST);
	
#line 20243 "CslParser.cpp"
	match(RPAREN);
	param_list_add_dut_instance_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_add_dut_instance_AST;
}

void CslParser::param_list_gen_indiv_rtl_sig(
	RefTVec_RefString scopeId
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_gen_indiv_rtl_sig_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 12566 "csl.parser.g"
	
	TBool error = FALSE;
	
#line 20262 "CslParser.cpp"
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 12575 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	//command call options
	RefString command = _RS("generate_individual_rtl_signals()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0 | NSSymbolTable::TSIGNALGR_DECL;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TSIGNALGR_DECL,
	NSSymbolTable::TUNIT_DECL | NSSymbolTable::TSIGNALGR_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 20287 "CslParser.cpp"
	expression();
	exp_AST = returnAST;
#line 12596 "csl.parser.g"
	//exp should be on or off or function call that returns id
	if (EXPR_PRIMARY_IDENTIFIER == exp_AST->getFirstChild()->getType()) {
	
	if (ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getNextSibling()
	&& ANTLR_USE_NAMESPACE(antlr)nullAST == exp_AST->getFirstChild()->getFirstChild()->getFirstChild()) {
	
	RefString literalString = _RS(exp_AST->getFirstChild()->getFirstChild()->getText());
	TLInt literalEnum = getLiteralEnum(literalString);
	RefCslAST temporary;
	switch (literalEnum) {
	case K_LITERAL_OFF :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_OFF,"K_OFF")))));
	break;
	case K_LITERAL_ON :
	temporary = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_ON,"K_ON")))));
	break;
	default :
	error = TRUE;
	}
	if (!error) {
	setCurrentFilename(temporary, exp_AST->getColumn(), exp_AST->getLine());
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(temporary));
	}
	}
	else { error = TRUE; }
	
	}
	else if (FUNCTION_CALL_RET_ID == exp_AST->getFirstChild()->getType()) {
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	else { error = TRUE; }
	
	if (error) {
	RefString msg = _RS("Expecting 'on' or 'off' as argument, found '");
	msg->append( exp_AST->getFirstChild()->getFirstChild()->getText());
	msg->append( "' ");
	throwCommandError(_RS("generate_individual_rtl_signals()"), msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
	
#line 20331 "CslParser.cpp"
	match(RPAREN);
	}
	param_list_gen_indiv_rtl_sig_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_gen_indiv_rtl_sig_AST;
}

void CslParser::param_list_simulation_timeout_counter() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_simulation_timeout_counter_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(RPAREN);
	param_list_simulation_timeout_counter_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_simulation_timeout_counter_AST;
}

void CslParser::param_list_data_generation() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_data_generation_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	lp1 = LT(1);
	lp1_AST = astFactory->create(lp1);
	match(LPAREN);
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13411 "csl.parser.g"
	
	if (EXPR_PRIMARY_IDENTIFIER != exp_AST->getFirstChild()->getType()
	&& FUNCTION_CALL_RET_ID != exp_AST->getFirstChild()->getType()) {
	throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Expecting identifier",
	lp1->getFilename(),
	lp1->getLine(),
	lp1->getColumn());
	}
	
#line 20377 "CslParser.cpp"
	match(RPAREN);
	param_list_data_generation_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_data_generation_AST;
}

void CslParser::param_list_no_args_command() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_no_args_command_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	match(RPAREN);
	param_list_no_args_command_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_no_args_command_AST;
}

void CslParser::param_list_get_interface() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_get_interface_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST tok1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST tok2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok3 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST tok3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 13500 "csl.parser.g"
	
	RefCslAST temp;
	
#line 20408 "CslParser.cpp"
	
	match(LPAREN);
	{
	switch ( LA(1)) {
	case K_INPUT:
	{
		tok1 = LT(1);
		tok1_AST = astFactory->create(tok1);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok1_AST));
		match(K_INPUT);
#line 13505 "csl.parser.g"
		temp = tok1_AST;
#line 20421 "CslParser.cpp"
		break;
	}
	case K_OUTPUT:
	{
		tok2 = LT(1);
		tok2_AST = astFactory->create(tok2);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok2_AST));
		match(K_OUTPUT);
#line 13505 "csl.parser.g"
		temp = tok2_AST;
#line 20432 "CslParser.cpp"
		break;
	}
	case K_INOUT:
	{
		tok3 = LT(1);
		tok3_AST = astFactory->create(tok3);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok3_AST));
		match(K_INOUT);
#line 13505 "csl.parser.g"
		temp = tok3_AST;
#line 20443 "CslParser.cpp"
		break;
	}
	case RPAREN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 13506 "csl.parser.g"
	
	if (!temp.get()) { setCurrentFilename(temp); }
	
#line 20460 "CslParser.cpp"
	match(RPAREN);
	param_list_get_interface_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_get_interface_AST;
}

void CslParser::f2a_pair_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST f2a_pair_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(DOT);
	expression();
	exp_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 13627 "csl.parser.g"
	
	if (RANGE_EXPRESSION == exp_AST->getFirstChild()->getType()) {
	RefString msg = _RS("Part select is not allowed to be on the left hand side( formal ) of formal to actual statement.");
	throwError(msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	else 
	if (exp_AST->getFirstChild()->getType() == K_CONCATENATION
	|| exp_AST->getFirstChild()->getType() == K_REPLICATION) {
	RefString msg = _RS("Concatenation and replication are not allowed to be on the left hand side( formal ) of formal to actual statement.");
	throwError(msg, currentFilename.getRealLine(exp_AST->getLine()), exp_AST->getColumn());
	}
	
#line 20489 "CslParser.cpp"
	match(LPAREN);
	{
	expression();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	}
	match(RPAREN);
	f2a_pair_expr_AST = antlr::RefCslAST(currentAST.root);
#line 13642 "csl.parser.g"
	
	f2a_pair_expr_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(F2A_PAIR_EXPR,"F2A_PAIR_EXPR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(f2a_pair_expr_AST))));
	setCurrentFilename(f2a_pair_expr_AST, exp_AST->getColumn(), exp_AST->getLine());
	
#line 20502 "CslParser.cpp"
	currentAST.root = f2a_pair_expr_AST;
	if ( f2a_pair_expr_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
		f2a_pair_expr_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		  currentAST.child = f2a_pair_expr_AST->getFirstChild();
	else
		currentAST.child = f2a_pair_expr_AST;
	currentAST.advanceChildToEnd();
	f2a_pair_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = f2a_pair_expr_AST;
}

void CslParser::param_list_connect(
	RefTVec_RefString scopeId, TBool wasConcat
) {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_connect_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lp_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	lp = LT(1);
	lp_AST = astFactory->create(lp);
	match(LPAREN);
#line 13801 "csl.parser.g"
	//set real filename + line
	setCurrentFilename(lp_AST);
	
	if (wasConcat) {
	throwCommandError(_RS("connect()"), _RS("Command call not allowed on concatenation "), currentFilename.getRealLine(lp_AST->getLine()), lp_AST->getColumn());
	}
	//command call options
	RefString command = _RS("connect()");
	
	TInt                  callAllowedInScopesWithoutObjectMask = 0;
	
	RefTMap_EObjType_TInt callAllowedInScopesOnObjectMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	//   callAllowedInScopesOnObjectMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	//                                                         NSSymbolTable::TUNIT_DECL));
	
	RefTMap_EObjType_TInt callAllowedInScopesOnInstanceMap = RefTMap_EObjType_TInt(new TMap_EObjType_TInt);
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TUNIT_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	callAllowedInScopesOnInstanceMap->insert(std::make_pair(NSSymbolTable::TIFC_DECL,
	NSSymbolTable::TUNIT_DECL));
	
	setCommandCallOptions(command, callAllowedInScopesWithoutObjectMask, callAllowedInScopesOnObjectMap, callAllowedInScopesOnInstanceMap);
	
	callCommand(command, scopeId, symTree->getCurrentScope(), currentFilename.getFilename(), lp->getLine(), lp->getColumn());
	
#line 20556 "CslParser.cpp"
	param_list_formal_to_actual_mapping();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(RPAREN);
	}
	param_list_connect_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_connect_AST;
}

void CslParser::param_list_get_dim_bitrange() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_get_dim_bitrange_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	expression();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(RPAREN);
	param_list_get_dim_bitrange_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_get_dim_bitrange_AST;
}

void CslParser::param_list_get_dim_width() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_get_dim_width_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	expression();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	match(RPAREN);
	param_list_get_dim_width_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_get_dim_width_AST;
}

void CslParser::param_list_get_address_width() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_get_address_width_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	match(RPAREN);
	param_list_get_address_width_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_get_address_width_AST;
}

void CslParser::param_list_get_dim_offset() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_get_dim_offset_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ex_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	expression();
	ex_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	if (!( ex_AST->getFirstChild()->getType() != FUNCTION_CALL_RET_ID
    && ex_AST->getFirstChild()->getType() != EXPR_HYBRID ))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" ex_AST->getFirstChild()->getType() != FUNCTION_CALL_RET_ID\n    && ex_AST->getFirstChild()->getType() != EXPR_HYBRID ");
	match(RPAREN);
	param_list_get_dim_offset_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_get_dim_offset_AST;
}

void CslParser::param_list_get_dim_upper_index() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_get_dim_upper_index_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ex_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	expression();
	ex_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	if (!( ex_AST->getFirstChild()->getType() != FUNCTION_CALL_RET_ID
    && ex_AST->getFirstChild()->getType() != EXPR_HYBRID ))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" ex_AST->getFirstChild()->getType() != FUNCTION_CALL_RET_ID\n    && ex_AST->getFirstChild()->getType() != EXPR_HYBRID ");
	match(RPAREN);
	param_list_get_dim_upper_index_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_get_dim_upper_index_AST;
}

void CslParser::param_list_get_dim_lower_index() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST param_list_get_dim_lower_index_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ex_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	match(LPAREN);
	expression();
	ex_AST = returnAST;
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	if (!( ex_AST->getFirstChild()->getType() != FUNCTION_CALL_RET_ID
    && ex_AST->getFirstChild()->getType() != EXPR_HYBRID ))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" ex_AST->getFirstChild()->getType() != FUNCTION_CALL_RET_ID\n    && ex_AST->getFirstChild()->getType() != EXPR_HYBRID ");
	match(RPAREN);
	param_list_get_dim_lower_index_AST = antlr::RefCslAST(currentAST.root);
	returnAST = param_list_get_dim_lower_index_AST;
}

void CslParser::conditional_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST conditional_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  qe = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST qe_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	logical_or_expr();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{
	switch ( LA(1)) {
	case QUESTION:
	{
		qe = LT(1);
		qe_AST = astFactory->create(qe);
		astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(qe_AST));
		match(QUESTION);
#line 16117 "csl.parser.g"
		setCurrentFilename(qe_AST);
#line 20676 "CslParser.cpp"
		conditional_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		match(COLON);
		conditional_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case COLON:
	case COMMA:
	case RBRACK:
	case LCURLY:
	case RCURLY:
	case LPAREN:
	case RPAREN:
	case SEMI:
	case PO_NEG:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	}
	conditional_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = conditional_expr_AST;
}

void CslParser::logical_or_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST logical_or_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lor = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lor_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	logical_and_expr();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LOR)) {
			lor = LT(1);
			lor_AST = astFactory->create(lor);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(lor_AST));
			match(LOR);
#line 16129 "csl.parser.g"
			setCurrentFilename(lor_AST);
#line 20726 "CslParser.cpp"
			logical_and_expr();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {
			goto _loop603;
		}
		
	}
	_loop603:;
	} // ( ... )*
	}
	logical_or_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = logical_or_expr_AST;
}

void CslParser::logical_and_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST logical_and_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  land = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST land_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	or_expr();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LAND)) {
			land = LT(1);
			land_AST = astFactory->create(land);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(land_AST));
			match(LAND);
#line 16141 "csl.parser.g"
			setCurrentFilename(land_AST);
#line 20761 "CslParser.cpp"
			or_expr();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {
			goto _loop607;
		}
		
	}
	_loop607:;
	} // ( ... )*
	}
	logical_and_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = logical_and_expr_AST;
}

void CslParser::or_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST or_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  o = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST o_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  nor = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST nor_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  or2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST or2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  nor2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST nor2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case OR:
	case NOR:
	{
		{
		switch ( LA(1)) {
		case OR:
		{
			o = LT(1);
			o_AST = astFactory->create(o);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(o_AST));
			match(OR);
#line 16155 "csl.parser.g"
			setCurrentFilename(o_AST);
#line 20805 "CslParser.cpp"
			break;
		}
		case NOR:
		{
			nor = LT(1);
			nor_AST = astFactory->create(nor);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(nor_AST));
			match(NOR);
#line 16157 "csl.parser.g"
			setCurrentFilename(nor_AST);
#line 20816 "CslParser.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		xor_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case XOR:
	case XNOR:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		xor_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OR || LA(1) == NOR)) {
				{
				switch ( LA(1)) {
				case OR:
				{
					or2 = LT(1);
					or2_AST = astFactory->create(or2);
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(or2_AST));
					match(OR);
#line 16166 "csl.parser.g"
					setCurrentFilename(or2_AST);
#line 20945 "CslParser.cpp"
					break;
				}
				case NOR:
				{
					nor2 = LT(1);
					nor2_AST = astFactory->create(nor2);
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(nor2_AST));
					match(NOR);
#line 16168 "csl.parser.g"
					setCurrentFilename(nor2_AST);
#line 20956 "CslParser.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				xor_expr();
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			else {
				goto _loop613;
			}
			
		}
		_loop613:;
		} // ( ... )*
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	or_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = or_expr_AST;
}

void CslParser::xor_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST xor_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  xr = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST xr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  xnor = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST xnor_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  xor2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST xor2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  xnor2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST xnor2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case XOR:
	case XNOR:
	{
		{
		switch ( LA(1)) {
		case XOR:
		{
			xr = LT(1);
			xr_AST = astFactory->create(xr);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(xr_AST));
			match(XOR);
#line 16186 "csl.parser.g"
			setCurrentFilename(xr_AST);
#line 21015 "CslParser.cpp"
			break;
		}
		case XNOR:
		{
			xnor = LT(1);
			xnor_AST = astFactory->create(xnor);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(xnor_AST));
			match(XNOR);
#line 16188 "csl.parser.g"
			setCurrentFilename(xnor_AST);
#line 21026 "CslParser.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		and_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		and_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == XOR || LA(1) == XNOR)) {
				{
				switch ( LA(1)) {
				case XOR:
				{
					xor2 = LT(1);
					xor2_AST = astFactory->create(xor2);
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(xor2_AST));
					match(XOR);
#line 16197 "csl.parser.g"
					setCurrentFilename(xor2_AST);
#line 21153 "CslParser.cpp"
					break;
				}
				case XNOR:
				{
					xnor2 = LT(1);
					xnor2_AST = astFactory->create(xnor2);
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(xnor2_AST));
					match(XNOR);
#line 16199 "csl.parser.g"
					setCurrentFilename(xnor2_AST);
#line 21164 "CslParser.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				and_expr();
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			else {
				goto _loop619;
			}
			
		}
		_loop619:;
		} // ( ... )*
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	xor_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = xor_expr_AST;
}

void CslParser::and_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST and_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  an = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST an_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  nand = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST nand_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  and2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST and2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  nand2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST nand2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case AND:
	case NAND:
	{
		{
		switch ( LA(1)) {
		case AND:
		{
			an = LT(1);
			an_AST = astFactory->create(an);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(an_AST));
			match(AND);
#line 16217 "csl.parser.g"
			setCurrentFilename(an_AST);
#line 21223 "CslParser.cpp"
			break;
		}
		case NAND:
		{
			nand = LT(1);
			nand_AST = astFactory->create(nand);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(nand_AST));
			match(NAND);
#line 16219 "csl.parser.g"
			setCurrentFilename(nand_AST);
#line 21234 "CslParser.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		equality_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case MINUS:
	case LCURLY:
	case LPAREN:
	case PLUS:
	case LNOT:
	case NOT:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		equality_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == AND || LA(1) == NAND)) {
				{
				switch ( LA(1)) {
				case AND:
				{
					and2 = LT(1);
					and2_AST = astFactory->create(and2);
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(and2_AST));
					match(AND);
#line 16228 "csl.parser.g"
					setCurrentFilename(and2_AST);
#line 21359 "CslParser.cpp"
					break;
				}
				case NAND:
				{
					nand2 = LT(1);
					nand2_AST = astFactory->create(nand2);
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(nand2_AST));
					match(NAND);
#line 16230 "csl.parser.g"
					setCurrentFilename(nand2_AST);
#line 21370 "CslParser.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				equality_expr();
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			else {
				goto _loop625;
			}
			
		}
		_loop625:;
		} // ( ... )*
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	and_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = and_expr_AST;
}

void CslParser::equality_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST equality_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  eq = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST eq_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  neq = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST neq_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  neqc = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST neqc_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  eqc = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST eqc_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	relational_expr();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{ // ( ... )*
	for (;;) {
		if (((LA(1) >= EQUAL && LA(1) <= EQ_CASE))) {
			{
			switch ( LA(1)) {
			case EQUAL:
			{
				eq = LT(1);
				eq_AST = astFactory->create(eq);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(eq_AST));
				match(EQUAL);
#line 16250 "csl.parser.g"
				setCurrentFilename(eq_AST);
#line 21430 "CslParser.cpp"
				break;
			}
			case NOT_EQ:
			{
				neq = LT(1);
				neq_AST = astFactory->create(neq);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(neq_AST));
				match(NOT_EQ);
#line 16252 "csl.parser.g"
				setCurrentFilename(neq_AST);
#line 21441 "CslParser.cpp"
				break;
			}
			case NOT_EQ_CASE:
			{
				neqc = LT(1);
				neqc_AST = astFactory->create(neqc);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(neqc_AST));
				match(NOT_EQ_CASE);
#line 16254 "csl.parser.g"
				setCurrentFilename(neqc_AST);
#line 21452 "CslParser.cpp"
				break;
			}
			case EQ_CASE:
			{
				eqc = LT(1);
				eqc_AST = astFactory->create(eqc);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(eqc_AST));
				match(EQ_CASE);
#line 16256 "csl.parser.g"
				setCurrentFilename(eqc_AST);
#line 21463 "CslParser.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			relational_expr();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {
			goto _loop630;
		}
		
	}
	_loop630:;
	} // ( ... )*
	}
	equality_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = equality_expr_AST;
}

void CslParser::relational_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST relational_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lt = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lt_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  gt = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST gt_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  le = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST le_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  ge = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST ge_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	shift_expr();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{ // ( ... )*
	for (;;) {
		if (((LA(1) >= LT_ && LA(1) <= GE))) {
			{
			switch ( LA(1)) {
			case LT_:
			{
				lt = LT(1);
				lt_AST = astFactory->create(lt);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(lt_AST));
				match(LT_);
#line 16276 "csl.parser.g"
				setCurrentFilename(lt_AST);
#line 21516 "CslParser.cpp"
				break;
			}
			case GT:
			{
				gt = LT(1);
				gt_AST = astFactory->create(gt);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(gt_AST));
				match(GT);
#line 16278 "csl.parser.g"
				setCurrentFilename(gt_AST);
#line 21527 "CslParser.cpp"
				break;
			}
			case LE:
			{
				le = LT(1);
				le_AST = astFactory->create(le);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(le_AST));
				match(LE);
#line 16280 "csl.parser.g"
				setCurrentFilename(le_AST);
#line 21538 "CslParser.cpp"
				break;
			}
			case GE:
			{
				ge = LT(1);
				ge_AST = astFactory->create(ge);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(ge_AST));
				match(GE);
#line 16282 "csl.parser.g"
				setCurrentFilename(ge_AST);
#line 21549 "CslParser.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			shift_expr();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {
			goto _loop635;
		}
		
	}
	_loop635:;
	} // ( ... )*
	}
	relational_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = relational_expr_AST;
}

void CslParser::shift_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST shift_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  sl = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST sl_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  ssl = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST ssl_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  sr = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST sr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  ssr = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST ssr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	additive_expr();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{ // ( ... )*
	for (;;) {
		if (((LA(1) >= SL && LA(1) <= SSR))) {
			{
			switch ( LA(1)) {
			case SL:
			{
				sl = LT(1);
				sl_AST = astFactory->create(sl);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(sl_AST));
				match(SL);
#line 16301 "csl.parser.g"
				setCurrentFilename(sl_AST);
#line 21602 "CslParser.cpp"
				break;
			}
			case SSL:
			{
				ssl = LT(1);
				ssl_AST = astFactory->create(ssl);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(ssl_AST));
				match(SSL);
#line 16303 "csl.parser.g"
				setCurrentFilename(ssl_AST);
#line 21613 "CslParser.cpp"
				break;
			}
			case SR:
			{
				sr = LT(1);
				sr_AST = astFactory->create(sr);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(sr_AST));
				match(SR);
#line 16305 "csl.parser.g"
				setCurrentFilename(sr_AST);
#line 21624 "CslParser.cpp"
				break;
			}
			case SSR:
			{
				ssr = LT(1);
				ssr_AST = astFactory->create(ssr);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(ssr_AST));
				match(SSR);
#line 16307 "csl.parser.g"
				setCurrentFilename(ssr_AST);
#line 21635 "CslParser.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			additive_expr();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {
			goto _loop640;
		}
		
	}
	_loop640:;
	} // ( ... )*
	}
	shift_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = shift_expr_AST;
}

void CslParser::additive_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST additive_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  pl = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST pl_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  min = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST min_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case MINUS:
	case PLUS:
	{
		{
		switch ( LA(1)) {
		case PLUS:
		{
			antlr::RefCslAST tmp383_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			tmp383_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp383_AST));
			match(PLUS);
			break;
		}
		case MINUS:
		{
			antlr::RefCslAST tmp384_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			tmp384_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp384_AST));
			match(MINUS);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		multiplicative_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		additive_expr_AST = antlr::RefCslAST(currentAST.root);
#line 16331 "csl.parser.g"
		
		setCurrentFilename(additive_expr_AST);
		//negative verilog numbers (-2'd123) are not allowed 
		if (SIZED_NUMBER == returnAST->getType()) {
		
		if (MINUS == additive_expr_AST->getType()) {
		
		throwError(_RS("Negative verilog numbers are not allowed"), currentFilename.getRealLine(additive_expr_AST->getLine()), additive_expr_AST->getColumn());
		}
		}
		
#line 21712 "CslParser.cpp"
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case LCURLY:
	case LPAREN:
	case LNOT:
	case NOT:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		multiplicative_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == MINUS || LA(1) == PLUS)) {
				{
				switch ( LA(1)) {
				case PLUS:
				{
					pl = LT(1);
					pl_AST = astFactory->create(pl);
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(pl_AST));
					match(PLUS);
#line 16348 "csl.parser.g"
					setCurrentFilename(pl_AST);
#line 21825 "CslParser.cpp"
					break;
				}
				case MINUS:
				{
					min = LT(1);
					min_AST = astFactory->create(min);
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(min_AST));
					match(MINUS);
#line 16350 "csl.parser.g"
					setCurrentFilename(min_AST);
#line 21836 "CslParser.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				multiplicative_expr();
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			else {
				goto _loop646;
			}
			
		}
		_loop646:;
		} // ( ... )*
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	additive_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = additive_expr_AST;
}

void CslParser::multiplicative_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST multiplicative_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  st = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST st_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  div = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST div_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  mod = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST mod_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	pow_expr();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == STAR || LA(1) == DIV || LA(1) == MOD)) {
			{
			switch ( LA(1)) {
			case STAR:
			{
				st = LT(1);
				st_AST = astFactory->create(st);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(st_AST));
				match(STAR);
#line 16370 "csl.parser.g"
				setCurrentFilename(st_AST);
#line 21894 "CslParser.cpp"
				break;
			}
			case DIV:
			{
				div = LT(1);
				div_AST = astFactory->create(div);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(div_AST));
				match(DIV);
#line 16372 "csl.parser.g"
				setCurrentFilename(div_AST);
#line 21905 "CslParser.cpp"
				break;
			}
			case MOD:
			{
				mod = LT(1);
				mod_AST = astFactory->create(mod);
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(mod_AST));
				match(MOD);
#line 16374 "csl.parser.g"
				setCurrentFilename(mod_AST);
#line 21916 "CslParser.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			pow_expr();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {
			goto _loop651;
		}
		
	}
	_loop651:;
	} // ( ... )*
	}
	multiplicative_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = multiplicative_expr_AST;
}

void CslParser::pow_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST pow_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  pow = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST pow_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	unary_not();
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
	{
	switch ( LA(1)) {
	case POW:
	{
		pow = LT(1);
		pow_AST = astFactory->create(pow);
		astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(pow_AST));
		match(POW);
#line 16391 "csl.parser.g"
		setCurrentFilename(pow_AST);
#line 21960 "CslParser.cpp"
		unary_not();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case COLON:
	case COMMA:
	case MINUS:
	case RBRACK:
	case LCURLY:
	case RCURLY:
	case LPAREN:
	case RPAREN:
	case QUESTION:
	case SEMI:
	case PLUS:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case PO_NEG:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	}
	pow_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = pow_expr_AST;
}

void CslParser::unary_not() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST unary_not_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  nt = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST nt_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  lnot = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST lnot_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case LNOT:
	case NOT:
	{
		{
		switch ( LA(1)) {
		case NOT:
		{
			nt = LT(1);
			nt_AST = astFactory->create(nt);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(nt_AST));
			match(NOT);
#line 16439 "csl.parser.g"
			setCurrentFilename(nt_AST);
#line 22038 "CslParser.cpp"
			break;
		}
		case LNOT:
		{
			lnot = LT(1);
			lnot_AST = astFactory->create(lnot);
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(lnot_AST));
			match(LNOT);
#line 16441 "csl.parser.g"
			setCurrentFilename(lnot_AST);
#line 22049 "CslParser.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		unary_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case LCURLY:
	case LPAREN:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		unary_expr();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	unary_not_AST = antlr::RefCslAST(currentAST.root);
	returnAST = unary_not_AST;
}

void CslParser::unary_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST unary_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case LCURLY:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		concatenation_dummy();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case LPAREN:
	{
		match(LPAREN);
		expression();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		match(RPAREN);
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	unary_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = unary_expr_AST;
}

void CslParser::concatenation_dummy() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST concatenation_dummy_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case LCURLY:
	{
		concatenation();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case K_DATA_GENERATION:
	{
		expr_primary();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	concatenation_dummy_AST = antlr::RefCslAST(currentAST.root);
	returnAST = concatenation_dummy_AST;
}

void CslParser::simple_concat() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST simple_concat_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	{ // ( ... )+
	int _cnt667=0;
	for (;;) {
		if ((LA(1) == COMMA)) {
			match(COMMA);
			expression();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		else {
			if ( _cnt667>=1 ) { goto _loop667; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt667++;
	}
	_loop667:;
	}  // ( ... )+
	}
	simple_concat_AST = antlr::RefCslAST(currentAST.root);
	returnAST = simple_concat_AST;
}

void CslParser::multi_concat() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST multi_concat_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ex_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST sc_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 16572 "csl.parser.g"
	
	TBool wasSimpleConcat = FALSE;
	TBool wasMultiConcat = FALSE;
	RefCslAST temp;
	
#line 22447 "CslParser.cpp"
	
	{
	match(LCURLY);
	expression();
	ex_AST = returnAST;
	{
	switch ( LA(1)) {
	case COMMA:
	{
		simple_concat();
		sc_AST = returnAST;
#line 16587 "csl.parser.g"
		
		wasSimpleConcat = TRUE; 
		temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CONCATENATION,"K_CONCATENATION")))));
		temp->addChild(ex_AST);
		temp->addChild(sc_AST);
		
#line 22466 "CslParser.cpp"
		break;
	}
	case RCURLY:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	match(RCURLY);
	multi_concat_AST = antlr::RefCslAST(currentAST.root);
#line 16610 "csl.parser.g"
	
	if (!wasSimpleConcat && !wasMultiConcat) {
	temp = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(K_CONCATENATION,"K_CONCATENATION")))));
	temp->addChild(ex_AST);
	}
	
	multi_concat_AST = temp; 
	
#line 22490 "CslParser.cpp"
	currentAST.root = multi_concat_AST;
	if ( multi_concat_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
		multi_concat_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		  currentAST.child = multi_concat_AST->getFirstChild();
	else
		currentAST.child = multi_concat_AST;
	currentAST.advanceChildToEnd();
	}
	multi_concat_AST = antlr::RefCslAST(currentAST.root);
	returnAST = multi_concat_AST;
}

void CslParser::expr_primary() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST expr_primary_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  st = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST st_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	{
		number();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case STRING:
	{
		st = LT(1);
		st_AST = astFactory->create(st);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(st_AST));
		match(STRING);
#line 16650 "csl.parser.g"
		setCurrentFilename(st_AST);
#line 22528 "CslParser.cpp"
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case IDENTIFIER:
	case K_DATA_GENERATION:
	{
		expr_primary_identifier();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	expr_primary_AST = antlr::RefCslAST(currentAST.root);
	returnAST = expr_primary_AST;
}

void CslParser::number() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST number_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST un_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST bn_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case UNSIGNED_NUMBER:
	{
		unsigned_number();
		un_AST = returnAST;
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		{
		switch ( LA(1)) {
		case BASED_NUMBER:
		{
			based_number();
			bn_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			number_AST = antlr::RefCslAST(currentAST.root);
#line 16668 "csl.parser.g"
			
			string  numText = un_AST->getText() + bn_AST->getText();
			number_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(SIZED_NUMBER,numText)))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(number_AST))));
			setCurrentFilename(number_AST, un_AST->getColumn(), un_AST->getLine());
			
#line 22660 "CslParser.cpp"
			currentAST.root = number_AST;
			if ( number_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				number_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = number_AST->getFirstChild();
			else
				currentAST.child = number_AST;
			currentAST.advanceChildToEnd();
			break;
		}
		case COLON:
		case COMMA:
		case MINUS:
		case RBRACK:
		case LCURLY:
		case RCURLY:
		case LPAREN:
		case RPAREN:
		case QUESTION:
		case SEMI:
		case PLUS:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case PO_NEG:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		break;
	}
	case BASED_NUMBER:
	{
		based_number();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	case REAL_NUMBER:
	{
		real_number();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	number_AST = antlr::RefCslAST(currentAST.root);
	returnAST = number_AST;
}

void CslParser::expr_primary_identifier() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST expr_primary_identifier_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  id2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST id2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 16819 "csl.parser.g"
	
	TBool wasDot = FALSE;
	TBool wasRange = FALSE;
	TBool wasPartSelect = FALSE;
	TBool wasHybrid = FALSE;
	TBool wasFC     = FALSE;
	TBool wasFCRI   = FALSE;
	RefCslAST firstTok;
	
#line 22757 "CslParser.cpp"
	
	{
	{
	{
	switch ( LA(1)) {
	case IDENTIFIER:
	{
		id = LT(1);
		id_AST = astFactory->create(id);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id_AST));
		match(IDENTIFIER);
#line 16834 "csl.parser.g"
		setCurrentFilename(id_AST); firstTok = id_AST;
#line 22771 "CslParser.cpp"
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			match(LBRACK);
			range_expression();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			match(RBRACK);
#line 16835 "csl.parser.g"
			wasRange = TRUE; firstTok = returnAST;
#line 22782 "CslParser.cpp"
			break;
		}
		case K_GET_INTERFACE:
		case K_GET_SIGNAL_VALUE:
		case K_GET_TYPE:
		case K_GET_ATTR:
		case K_GET_UNIT_PREFIX:
		case K_GET_SIGNAL_PREFIX:
		case K_GET_SIGNAL_PREFIX_LOCAL:
		case K_GET_DEPTH:
		case K_GET_ATTRIBUTES:
		case K_GET_INPUT_FIELD:
		case K_GET_OUTPUT_FIELD:
		case K_GET_LOCK_ENABLE_BIT:
		case K_GET_CNT_DIR_SIGNAL:
		case K_GET_WIDTH:
		case K_GET_DIM_WIDTH:
		case K_GET_BITRANGE:
		case K_GET_DIM_BITRANGE:
		case K_GET_LOWER_INDEX:
		case K_GET_DIM_LOWER_INDEX:
		case K_GET_UPPER_INDEX:
		case K_GET_DIM_UPPER_INDEX:
		case K_GET_OFFSET:
		case K_GET_DIM_OFFSET:
		case K_GET_NUMBER_OF_DIMENSIONS:
		case K_GET_CELL:
		case K_GET_TRANSACTION_TIMEOUT_COUNT:
		case K_GET_SIMULATION_TIMEOUT_COUNT:
		case K_GET_VC_ID:
		case K_GET_VC_MAX_NUM_STATES:
		case K_GET_NAME:
		case K_GET_FILENAME:
		case K_GET_MAX_NUM_VECTORS:
		case K_GET_MAX_ERROR_COUNT:
		case K_GET_MNEMONIC:
		case K_GET_VALUE:
		case K_GET_ENUM:
		case K_GET_ENUM_ITEM:
		case K_GET_NEXT_ADDRESS:
		case K_GET_LOWER_BOUND:
		case K_GET_UPPER_BOUND:
		case K_GET_DATA_WORD_WIDTH:
		case K_GET_ALIGNMENT:
		case K_GET_ENDIANESS:
		case K_GET_NAME_LENGTH:
		case K_GET_PREFIX:
		case K_GET_SUFFIX:
		case K_GET_SYMBOL_LENGTH:
		case K_GET_ADDR_INCREMENT:
		case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
		case K_GET_VC_NAME:
		case K_GET_VC_HEADER_COMMENT:
		case K_GET_VC_CLOCK:
		case K_GET_VC_RESET:
		case K_GET_VC_STALL:
		case K_GET_VC_COMPARE_TRIGGER:
		case K_GET_VC_START_GENERATION_TRIGGER:
		case K_GET_VC_END_GENERATION_TRIGGER:
		case K_GET_VC_CAPTURE_EDGE_TYPE:
		case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
		case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
		case K_GET_VC_TIMEOUT:
		case K_GET_VC_OUTPUT_FILENAME:
		case K_GET_VC_CPP_RD_NAME:
		case K_GET_VC_CPP_WR_NAME:
		case K_GET_VC_MODULE:
		case K_GET_OUTPUT_FILENAME:
		case K_GET_RESET_NAME:
		case K_GET_CLOCK_NAME:
		case K_GET_RD_CLOCK_NAME:
		case K_GET_WR_CLOCK_NAME:
		case K_GET_PUSH_NAME:
		case K_GET_POP_NAME:
		case K_GET_FULL_NAME:
		case K_GET_EMPTY_NAME:
		case K_GET_WR_DATA_NAME:
		case K_GET_RD_DATA_NAME:
		case K_GET_VALID_NAME:
		case K_GET_WR_ADDR_NAME:
		case K_GET_RD_ADDR_NAME:
		case K_GET_WR_EN_NAME:
		case K_GET_RD_EN_NAME:
		case K_GET_MSB:
		case K_GET_LSB:
		case K_GET_RADIX:
		case COLON:
		case COMMA:
		case DOT:
		case MINUS:
		case RBRACK:
		case LCURLY:
		case RCURLY:
		case LPAREN:
		case RPAREN:
		case QUESTION:
		case SEMI:
		case PLUS:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case PO_NEG:
		case IDENTIFIER:
		case K_DATA_GENERATION:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case K_DATA_GENERATION:
	{
		{
		switch ( LA(1)) {
		case K_GET_INTERFACE:
		case K_GET_TYPE:
		case K_GET_ATTR:
		case K_GET_UNIT_PREFIX:
		case K_GET_SIGNAL_PREFIX:
		case K_GET_SIGNAL_PREFIX_LOCAL:
		case K_GET_INPUT_FIELD:
		case K_GET_OUTPUT_FIELD:
		case K_GET_CNT_DIR_SIGNAL:
		case K_GET_BITRANGE:
		case K_GET_DIM_BITRANGE:
		case K_GET_CELL:
		case K_GET_ENUM:
		case K_GET_ENUM_ITEM:
		case K_GET_VC_CLOCK:
		case K_GET_VC_RESET:
		case K_GET_VC_STALL:
		case K_GET_VC_COMPARE_TRIGGER:
		case K_GET_VC_START_GENERATION_TRIGGER:
		case K_GET_VC_END_GENERATION_TRIGGER:
		case K_GET_VC_CAPTURE_EDGE_TYPE:
		case K_GET_VC_MODULE:
		case K_GET_RADIX:
		{
			function_call_ret_id();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16840 "csl.parser.g"
			wasFCRI = TRUE; firstTok = returnAST;
#line 23035 "CslParser.cpp"
			break;
		}
		case K_GET_SIGNAL_VALUE:
		case K_GET_DEPTH:
		case K_GET_ATTRIBUTES:
		case K_GET_LOCK_ENABLE_BIT:
		case K_GET_WIDTH:
		case K_GET_DIM_WIDTH:
		case K_GET_LOWER_INDEX:
		case K_GET_DIM_LOWER_INDEX:
		case K_GET_UPPER_INDEX:
		case K_GET_DIM_UPPER_INDEX:
		case K_GET_OFFSET:
		case K_GET_DIM_OFFSET:
		case K_GET_NUMBER_OF_DIMENSIONS:
		case K_GET_TRANSACTION_TIMEOUT_COUNT:
		case K_GET_SIMULATION_TIMEOUT_COUNT:
		case K_GET_VC_ID:
		case K_GET_VC_MAX_NUM_STATES:
		case K_GET_NAME:
		case K_GET_FILENAME:
		case K_GET_MAX_NUM_VECTORS:
		case K_GET_MAX_ERROR_COUNT:
		case K_GET_MNEMONIC:
		case K_GET_VALUE:
		case K_GET_NEXT_ADDRESS:
		case K_GET_LOWER_BOUND:
		case K_GET_UPPER_BOUND:
		case K_GET_DATA_WORD_WIDTH:
		case K_GET_ALIGNMENT:
		case K_GET_ENDIANESS:
		case K_GET_NAME_LENGTH:
		case K_GET_PREFIX:
		case K_GET_SUFFIX:
		case K_GET_SYMBOL_LENGTH:
		case K_GET_ADDR_INCREMENT:
		case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
		case K_GET_VC_NAME:
		case K_GET_VC_HEADER_COMMENT:
		case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
		case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
		case K_GET_VC_TIMEOUT:
		case K_GET_VC_OUTPUT_FILENAME:
		case K_GET_VC_CPP_RD_NAME:
		case K_GET_VC_CPP_WR_NAME:
		case K_GET_OUTPUT_FILENAME:
		case K_GET_RESET_NAME:
		case K_GET_CLOCK_NAME:
		case K_GET_RD_CLOCK_NAME:
		case K_GET_WR_CLOCK_NAME:
		case K_GET_PUSH_NAME:
		case K_GET_POP_NAME:
		case K_GET_FULL_NAME:
		case K_GET_EMPTY_NAME:
		case K_GET_WR_DATA_NAME:
		case K_GET_RD_DATA_NAME:
		case K_GET_VALID_NAME:
		case K_GET_WR_ADDR_NAME:
		case K_GET_RD_ADDR_NAME:
		case K_GET_WR_EN_NAME:
		case K_GET_RD_EN_NAME:
		case K_GET_MSB:
		case K_GET_LSB:
		case K_DATA_GENERATION:
		{
			function_call_ret_expr();
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16842 "csl.parser.g"
			firstTok = returnAST;
#line 23105 "CslParser.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 16845 "csl.parser.g"
		wasFC = TRUE;
#line 23116 "CslParser.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	{
	switch ( LA(1)) {
	case DOT:
	{
		match(DOT);
#line 16848 "csl.parser.g"
		wasDot = TRUE;
#line 23132 "CslParser.cpp"
		break;
	}
	case K_GET_INTERFACE:
	case K_GET_SIGNAL_VALUE:
	case K_GET_TYPE:
	case K_GET_ATTR:
	case K_GET_UNIT_PREFIX:
	case K_GET_SIGNAL_PREFIX:
	case K_GET_SIGNAL_PREFIX_LOCAL:
	case K_GET_DEPTH:
	case K_GET_ATTRIBUTES:
	case K_GET_INPUT_FIELD:
	case K_GET_OUTPUT_FIELD:
	case K_GET_LOCK_ENABLE_BIT:
	case K_GET_CNT_DIR_SIGNAL:
	case K_GET_WIDTH:
	case K_GET_DIM_WIDTH:
	case K_GET_BITRANGE:
	case K_GET_DIM_BITRANGE:
	case K_GET_LOWER_INDEX:
	case K_GET_DIM_LOWER_INDEX:
	case K_GET_UPPER_INDEX:
	case K_GET_DIM_UPPER_INDEX:
	case K_GET_OFFSET:
	case K_GET_DIM_OFFSET:
	case K_GET_NUMBER_OF_DIMENSIONS:
	case K_GET_CELL:
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	case K_GET_VC_ID:
	case K_GET_VC_MAX_NUM_STATES:
	case K_GET_NAME:
	case K_GET_FILENAME:
	case K_GET_MAX_NUM_VECTORS:
	case K_GET_MAX_ERROR_COUNT:
	case K_GET_MNEMONIC:
	case K_GET_VALUE:
	case K_GET_ENUM:
	case K_GET_ENUM_ITEM:
	case K_GET_NEXT_ADDRESS:
	case K_GET_LOWER_BOUND:
	case K_GET_UPPER_BOUND:
	case K_GET_DATA_WORD_WIDTH:
	case K_GET_ALIGNMENT:
	case K_GET_ENDIANESS:
	case K_GET_NAME_LENGTH:
	case K_GET_PREFIX:
	case K_GET_SUFFIX:
	case K_GET_SYMBOL_LENGTH:
	case K_GET_ADDR_INCREMENT:
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	case K_GET_VC_NAME:
	case K_GET_VC_HEADER_COMMENT:
	case K_GET_VC_CLOCK:
	case K_GET_VC_RESET:
	case K_GET_VC_STALL:
	case K_GET_VC_COMPARE_TRIGGER:
	case K_GET_VC_START_GENERATION_TRIGGER:
	case K_GET_VC_END_GENERATION_TRIGGER:
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	case K_GET_VC_TIMEOUT:
	case K_GET_VC_OUTPUT_FILENAME:
	case K_GET_VC_CPP_RD_NAME:
	case K_GET_VC_CPP_WR_NAME:
	case K_GET_VC_MODULE:
	case K_GET_OUTPUT_FILENAME:
	case K_GET_RESET_NAME:
	case K_GET_CLOCK_NAME:
	case K_GET_RD_CLOCK_NAME:
	case K_GET_WR_CLOCK_NAME:
	case K_GET_PUSH_NAME:
	case K_GET_POP_NAME:
	case K_GET_FULL_NAME:
	case K_GET_EMPTY_NAME:
	case K_GET_WR_DATA_NAME:
	case K_GET_RD_DATA_NAME:
	case K_GET_VALID_NAME:
	case K_GET_WR_ADDR_NAME:
	case K_GET_RD_ADDR_NAME:
	case K_GET_WR_EN_NAME:
	case K_GET_RD_EN_NAME:
	case K_GET_MSB:
	case K_GET_LSB:
	case K_GET_RADIX:
	case COLON:
	case COMMA:
	case MINUS:
	case RBRACK:
	case LCURLY:
	case RCURLY:
	case LPAREN:
	case RPAREN:
	case QUESTION:
	case SEMI:
	case PLUS:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case PO_NEG:
	case IDENTIFIER:
	case K_DATA_GENERATION:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if (((_tokenSet_1.member(LA(1))))&&(wasDot && !wasRange)) {
#line 16850 "csl.parser.g"
			wasDot = FALSE;
#line 23272 "CslParser.cpp"
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			{
				id2 = LT(1);
				id2_AST = astFactory->create(id2);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(id2_AST));
				match(IDENTIFIER);
#line 16851 "csl.parser.g"
				setCurrentFilename(id2_AST);
#line 23283 "CslParser.cpp"
				{
				switch ( LA(1)) {
				case LBRACK:
				{
					match(LBRACK);
					range_expression();
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					match(RBRACK);
#line 16852 "csl.parser.g"
					wasRange = TRUE;
#line 23294 "CslParser.cpp"
					break;
				}
				case K_GET_INTERFACE:
				case K_GET_SIGNAL_VALUE:
				case K_GET_TYPE:
				case K_GET_ATTR:
				case K_GET_UNIT_PREFIX:
				case K_GET_SIGNAL_PREFIX:
				case K_GET_SIGNAL_PREFIX_LOCAL:
				case K_GET_DEPTH:
				case K_GET_ATTRIBUTES:
				case K_GET_INPUT_FIELD:
				case K_GET_OUTPUT_FIELD:
				case K_GET_LOCK_ENABLE_BIT:
				case K_GET_CNT_DIR_SIGNAL:
				case K_GET_WIDTH:
				case K_GET_DIM_WIDTH:
				case K_GET_BITRANGE:
				case K_GET_DIM_BITRANGE:
				case K_GET_LOWER_INDEX:
				case K_GET_DIM_LOWER_INDEX:
				case K_GET_UPPER_INDEX:
				case K_GET_DIM_UPPER_INDEX:
				case K_GET_OFFSET:
				case K_GET_DIM_OFFSET:
				case K_GET_NUMBER_OF_DIMENSIONS:
				case K_GET_CELL:
				case K_GET_TRANSACTION_TIMEOUT_COUNT:
				case K_GET_SIMULATION_TIMEOUT_COUNT:
				case K_GET_VC_ID:
				case K_GET_VC_MAX_NUM_STATES:
				case K_GET_NAME:
				case K_GET_FILENAME:
				case K_GET_MAX_NUM_VECTORS:
				case K_GET_MAX_ERROR_COUNT:
				case K_GET_MNEMONIC:
				case K_GET_VALUE:
				case K_GET_ENUM:
				case K_GET_ENUM_ITEM:
				case K_GET_NEXT_ADDRESS:
				case K_GET_LOWER_BOUND:
				case K_GET_UPPER_BOUND:
				case K_GET_DATA_WORD_WIDTH:
				case K_GET_ALIGNMENT:
				case K_GET_ENDIANESS:
				case K_GET_NAME_LENGTH:
				case K_GET_PREFIX:
				case K_GET_SUFFIX:
				case K_GET_SYMBOL_LENGTH:
				case K_GET_ADDR_INCREMENT:
				case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
				case K_GET_VC_NAME:
				case K_GET_VC_HEADER_COMMENT:
				case K_GET_VC_CLOCK:
				case K_GET_VC_RESET:
				case K_GET_VC_STALL:
				case K_GET_VC_COMPARE_TRIGGER:
				case K_GET_VC_START_GENERATION_TRIGGER:
				case K_GET_VC_END_GENERATION_TRIGGER:
				case K_GET_VC_CAPTURE_EDGE_TYPE:
				case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
				case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
				case K_GET_VC_TIMEOUT:
				case K_GET_VC_OUTPUT_FILENAME:
				case K_GET_VC_CPP_RD_NAME:
				case K_GET_VC_CPP_WR_NAME:
				case K_GET_VC_MODULE:
				case K_GET_OUTPUT_FILENAME:
				case K_GET_RESET_NAME:
				case K_GET_CLOCK_NAME:
				case K_GET_RD_CLOCK_NAME:
				case K_GET_WR_CLOCK_NAME:
				case K_GET_PUSH_NAME:
				case K_GET_POP_NAME:
				case K_GET_FULL_NAME:
				case K_GET_EMPTY_NAME:
				case K_GET_WR_DATA_NAME:
				case K_GET_RD_DATA_NAME:
				case K_GET_VALID_NAME:
				case K_GET_WR_ADDR_NAME:
				case K_GET_RD_ADDR_NAME:
				case K_GET_WR_EN_NAME:
				case K_GET_RD_EN_NAME:
				case K_GET_MSB:
				case K_GET_LSB:
				case K_GET_RADIX:
				case COLON:
				case COMMA:
				case DOT:
				case MINUS:
				case RBRACK:
				case LCURLY:
				case RCURLY:
				case LPAREN:
				case RPAREN:
				case QUESTION:
				case SEMI:
				case PLUS:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case PO_NEG:
				case IDENTIFIER:
				case K_DATA_GENERATION:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				break;
			}
			case K_GET_INTERFACE:
			case K_GET_SIGNAL_VALUE:
			case K_GET_TYPE:
			case K_GET_ATTR:
			case K_GET_UNIT_PREFIX:
			case K_GET_SIGNAL_PREFIX:
			case K_GET_SIGNAL_PREFIX_LOCAL:
			case K_GET_DEPTH:
			case K_GET_ATTRIBUTES:
			case K_GET_INPUT_FIELD:
			case K_GET_OUTPUT_FIELD:
			case K_GET_LOCK_ENABLE_BIT:
			case K_GET_CNT_DIR_SIGNAL:
			case K_GET_WIDTH:
			case K_GET_DIM_WIDTH:
			case K_GET_BITRANGE:
			case K_GET_DIM_BITRANGE:
			case K_GET_LOWER_INDEX:
			case K_GET_DIM_LOWER_INDEX:
			case K_GET_UPPER_INDEX:
			case K_GET_DIM_UPPER_INDEX:
			case K_GET_OFFSET:
			case K_GET_DIM_OFFSET:
			case K_GET_NUMBER_OF_DIMENSIONS:
			case K_GET_CELL:
			case K_GET_TRANSACTION_TIMEOUT_COUNT:
			case K_GET_SIMULATION_TIMEOUT_COUNT:
			case K_GET_VC_ID:
			case K_GET_VC_MAX_NUM_STATES:
			case K_GET_NAME:
			case K_GET_FILENAME:
			case K_GET_MAX_NUM_VECTORS:
			case K_GET_MAX_ERROR_COUNT:
			case K_GET_MNEMONIC:
			case K_GET_VALUE:
			case K_GET_ENUM:
			case K_GET_ENUM_ITEM:
			case K_GET_NEXT_ADDRESS:
			case K_GET_LOWER_BOUND:
			case K_GET_UPPER_BOUND:
			case K_GET_DATA_WORD_WIDTH:
			case K_GET_ALIGNMENT:
			case K_GET_ENDIANESS:
			case K_GET_NAME_LENGTH:
			case K_GET_PREFIX:
			case K_GET_SUFFIX:
			case K_GET_SYMBOL_LENGTH:
			case K_GET_ADDR_INCREMENT:
			case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
			case K_GET_VC_NAME:
			case K_GET_VC_HEADER_COMMENT:
			case K_GET_VC_CLOCK:
			case K_GET_VC_RESET:
			case K_GET_VC_STALL:
			case K_GET_VC_COMPARE_TRIGGER:
			case K_GET_VC_START_GENERATION_TRIGGER:
			case K_GET_VC_END_GENERATION_TRIGGER:
			case K_GET_VC_CAPTURE_EDGE_TYPE:
			case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
			case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
			case K_GET_VC_TIMEOUT:
			case K_GET_VC_OUTPUT_FILENAME:
			case K_GET_VC_CPP_RD_NAME:
			case K_GET_VC_CPP_WR_NAME:
			case K_GET_VC_MODULE:
			case K_GET_OUTPUT_FILENAME:
			case K_GET_RESET_NAME:
			case K_GET_CLOCK_NAME:
			case K_GET_RD_CLOCK_NAME:
			case K_GET_WR_CLOCK_NAME:
			case K_GET_PUSH_NAME:
			case K_GET_POP_NAME:
			case K_GET_FULL_NAME:
			case K_GET_EMPTY_NAME:
			case K_GET_WR_DATA_NAME:
			case K_GET_RD_DATA_NAME:
			case K_GET_VALID_NAME:
			case K_GET_WR_ADDR_NAME:
			case K_GET_RD_ADDR_NAME:
			case K_GET_WR_EN_NAME:
			case K_GET_RD_EN_NAME:
			case K_GET_MSB:
			case K_GET_LSB:
			case K_GET_RADIX:
			case K_DATA_GENERATION:
			{
				{
				switch ( LA(1)) {
				case K_GET_INTERFACE:
				case K_GET_TYPE:
				case K_GET_ATTR:
				case K_GET_UNIT_PREFIX:
				case K_GET_SIGNAL_PREFIX:
				case K_GET_SIGNAL_PREFIX_LOCAL:
				case K_GET_INPUT_FIELD:
				case K_GET_OUTPUT_FIELD:
				case K_GET_CNT_DIR_SIGNAL:
				case K_GET_BITRANGE:
				case K_GET_DIM_BITRANGE:
				case K_GET_CELL:
				case K_GET_ENUM:
				case K_GET_ENUM_ITEM:
				case K_GET_VC_CLOCK:
				case K_GET_VC_RESET:
				case K_GET_VC_STALL:
				case K_GET_VC_COMPARE_TRIGGER:
				case K_GET_VC_START_GENERATION_TRIGGER:
				case K_GET_VC_END_GENERATION_TRIGGER:
				case K_GET_VC_CAPTURE_EDGE_TYPE:
				case K_GET_VC_MODULE:
				case K_GET_RADIX:
				{
					function_call_ret_id();
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16857 "csl.parser.g"
					if (!wasFCRI) { wasFCRI = TRUE; }
#line 23547 "CslParser.cpp"
					break;
				}
				case K_GET_SIGNAL_VALUE:
				case K_GET_DEPTH:
				case K_GET_ATTRIBUTES:
				case K_GET_LOCK_ENABLE_BIT:
				case K_GET_WIDTH:
				case K_GET_DIM_WIDTH:
				case K_GET_LOWER_INDEX:
				case K_GET_DIM_LOWER_INDEX:
				case K_GET_UPPER_INDEX:
				case K_GET_DIM_UPPER_INDEX:
				case K_GET_OFFSET:
				case K_GET_DIM_OFFSET:
				case K_GET_NUMBER_OF_DIMENSIONS:
				case K_GET_TRANSACTION_TIMEOUT_COUNT:
				case K_GET_SIMULATION_TIMEOUT_COUNT:
				case K_GET_VC_ID:
				case K_GET_VC_MAX_NUM_STATES:
				case K_GET_NAME:
				case K_GET_FILENAME:
				case K_GET_MAX_NUM_VECTORS:
				case K_GET_MAX_ERROR_COUNT:
				case K_GET_MNEMONIC:
				case K_GET_VALUE:
				case K_GET_NEXT_ADDRESS:
				case K_GET_LOWER_BOUND:
				case K_GET_UPPER_BOUND:
				case K_GET_DATA_WORD_WIDTH:
				case K_GET_ALIGNMENT:
				case K_GET_ENDIANESS:
				case K_GET_NAME_LENGTH:
				case K_GET_PREFIX:
				case K_GET_SUFFIX:
				case K_GET_SYMBOL_LENGTH:
				case K_GET_ADDR_INCREMENT:
				case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
				case K_GET_VC_NAME:
				case K_GET_VC_HEADER_COMMENT:
				case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
				case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
				case K_GET_VC_TIMEOUT:
				case K_GET_VC_OUTPUT_FILENAME:
				case K_GET_VC_CPP_RD_NAME:
				case K_GET_VC_CPP_WR_NAME:
				case K_GET_OUTPUT_FILENAME:
				case K_GET_RESET_NAME:
				case K_GET_CLOCK_NAME:
				case K_GET_RD_CLOCK_NAME:
				case K_GET_WR_CLOCK_NAME:
				case K_GET_PUSH_NAME:
				case K_GET_POP_NAME:
				case K_GET_FULL_NAME:
				case K_GET_EMPTY_NAME:
				case K_GET_WR_DATA_NAME:
				case K_GET_RD_DATA_NAME:
				case K_GET_VALID_NAME:
				case K_GET_WR_ADDR_NAME:
				case K_GET_RD_ADDR_NAME:
				case K_GET_WR_EN_NAME:
				case K_GET_RD_EN_NAME:
				case K_GET_MSB:
				case K_GET_LSB:
				case K_DATA_GENERATION:
				{
					function_call_ret_expr();
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
#line 16862 "csl.parser.g"
				if (wasFC) { wasHybrid = TRUE; } else { wasFC = TRUE; }
#line 23625 "CslParser.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case DOT:
			{
				match(DOT);
#line 16865 "csl.parser.g"
				wasDot = TRUE;
#line 23641 "CslParser.cpp"
				break;
			}
			case K_GET_INTERFACE:
			case K_GET_SIGNAL_VALUE:
			case K_GET_TYPE:
			case K_GET_ATTR:
			case K_GET_UNIT_PREFIX:
			case K_GET_SIGNAL_PREFIX:
			case K_GET_SIGNAL_PREFIX_LOCAL:
			case K_GET_DEPTH:
			case K_GET_ATTRIBUTES:
			case K_GET_INPUT_FIELD:
			case K_GET_OUTPUT_FIELD:
			case K_GET_LOCK_ENABLE_BIT:
			case K_GET_CNT_DIR_SIGNAL:
			case K_GET_WIDTH:
			case K_GET_DIM_WIDTH:
			case K_GET_BITRANGE:
			case K_GET_DIM_BITRANGE:
			case K_GET_LOWER_INDEX:
			case K_GET_DIM_LOWER_INDEX:
			case K_GET_UPPER_INDEX:
			case K_GET_DIM_UPPER_INDEX:
			case K_GET_OFFSET:
			case K_GET_DIM_OFFSET:
			case K_GET_NUMBER_OF_DIMENSIONS:
			case K_GET_CELL:
			case K_GET_TRANSACTION_TIMEOUT_COUNT:
			case K_GET_SIMULATION_TIMEOUT_COUNT:
			case K_GET_VC_ID:
			case K_GET_VC_MAX_NUM_STATES:
			case K_GET_NAME:
			case K_GET_FILENAME:
			case K_GET_MAX_NUM_VECTORS:
			case K_GET_MAX_ERROR_COUNT:
			case K_GET_MNEMONIC:
			case K_GET_VALUE:
			case K_GET_ENUM:
			case K_GET_ENUM_ITEM:
			case K_GET_NEXT_ADDRESS:
			case K_GET_LOWER_BOUND:
			case K_GET_UPPER_BOUND:
			case K_GET_DATA_WORD_WIDTH:
			case K_GET_ALIGNMENT:
			case K_GET_ENDIANESS:
			case K_GET_NAME_LENGTH:
			case K_GET_PREFIX:
			case K_GET_SUFFIX:
			case K_GET_SYMBOL_LENGTH:
			case K_GET_ADDR_INCREMENT:
			case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
			case K_GET_VC_NAME:
			case K_GET_VC_HEADER_COMMENT:
			case K_GET_VC_CLOCK:
			case K_GET_VC_RESET:
			case K_GET_VC_STALL:
			case K_GET_VC_COMPARE_TRIGGER:
			case K_GET_VC_START_GENERATION_TRIGGER:
			case K_GET_VC_END_GENERATION_TRIGGER:
			case K_GET_VC_CAPTURE_EDGE_TYPE:
			case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
			case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
			case K_GET_VC_TIMEOUT:
			case K_GET_VC_OUTPUT_FILENAME:
			case K_GET_VC_CPP_RD_NAME:
			case K_GET_VC_CPP_WR_NAME:
			case K_GET_VC_MODULE:
			case K_GET_OUTPUT_FILENAME:
			case K_GET_RESET_NAME:
			case K_GET_CLOCK_NAME:
			case K_GET_RD_CLOCK_NAME:
			case K_GET_WR_CLOCK_NAME:
			case K_GET_PUSH_NAME:
			case K_GET_POP_NAME:
			case K_GET_FULL_NAME:
			case K_GET_EMPTY_NAME:
			case K_GET_WR_DATA_NAME:
			case K_GET_RD_DATA_NAME:
			case K_GET_VALID_NAME:
			case K_GET_WR_ADDR_NAME:
			case K_GET_RD_ADDR_NAME:
			case K_GET_WR_EN_NAME:
			case K_GET_RD_EN_NAME:
			case K_GET_MSB:
			case K_GET_LSB:
			case K_GET_RADIX:
			case COLON:
			case COMMA:
			case MINUS:
			case RBRACK:
			case LCURLY:
			case RCURLY:
			case LPAREN:
			case RPAREN:
			case QUESTION:
			case SEMI:
			case PLUS:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case PO_NEG:
			case IDENTIFIER:
			case K_DATA_GENERATION:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
		}
		else {
			goto _loop696;
		}
		
	}
	_loop696:;
	} // ( ... )*
	expr_primary_identifier_AST = antlr::RefCslAST(currentAST.root);
#line 16868 "csl.parser.g"
	
	if (wasHybrid) {
	
	expr_primary_identifier_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EXPR_HYBRID,"EXPR_HYBRID")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expr_primary_identifier_AST))));
	}
	else if (wasRange) {
	
	expr_primary_identifier_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(RANGE_EXPRESSION,"RANGE_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expr_primary_identifier_AST))));
	}
	else if (wasFC) {
	
	if (wasFCRI) {
	
	expr_primary_identifier_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(FUNCTION_CALL_RET_ID,"FUNCTION_CALL_RET_ID")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expr_primary_identifier_AST))));
	}
	else {
	
	expr_primary_identifier_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(FUNCTION_CALL_RET_EXPR,"FUNCTION_CALL_RET_EXPR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expr_primary_identifier_AST))));
	}
	}
	else {
	
	expr_primary_identifier_AST = antlr::RefCslAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EXPR_PRIMARY_IDENTIFIER,"EXPR_PRIMARY_IDENTIFIER")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expr_primary_identifier_AST))));
	}
	setCurrentFilename(expr_primary_identifier_AST, firstTok->getColumn(), firstTok->getLine());
	
#line 23811 "CslParser.cpp"
	currentAST.root = expr_primary_identifier_AST;
	if ( expr_primary_identifier_AST!=antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
		expr_primary_identifier_AST->getFirstChild() != antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		  currentAST.child = expr_primary_identifier_AST->getFirstChild();
	else
		currentAST.child = expr_primary_identifier_AST;
	currentAST.advanceChildToEnd();
	}
	expr_primary_identifier_AST = antlr::RefCslAST(currentAST.root);
	returnAST = expr_primary_identifier_AST;
}

void CslParser::unsigned_number() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST unsigned_number_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST tok_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	tok = LT(1);
	tok_AST = astFactory->create(tok);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok_AST));
	match(UNSIGNED_NUMBER);
	unsigned_number_AST = antlr::RefCslAST(currentAST.root);
#line 16693 "csl.parser.g"
	
	setCurrentFilename(tok_AST); 
	TUInt MAX_NUMBER_DIGITS = 9;
	if (tok->getText().size() > MAX_NUMBER_DIGITS) {//bz said to use numbers in code
	
	throwError(_RS("cslc does not support numbers bigger than 999,999,999 for version 1.0"), currentFilename.getRealLine(tok_AST->getLine()), tok_AST->getColumn());
	}
	
	CslToken *vt = static_cast<CslToken*>(tok.get()); unsigned_number_AST->setNumber(vt->getNumber()); 
	
#line 23848 "CslParser.cpp"
	}
	unsigned_number_AST = antlr::RefCslAST(currentAST.root);
	returnAST = unsigned_number_AST;
}

void CslParser::based_number() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST based_number_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST tok_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	tok = LT(1);
	tok_AST = astFactory->create(tok);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok_AST));
	match(BASED_NUMBER);
	based_number_AST = antlr::RefCslAST(currentAST.root);
#line 16718 "csl.parser.g"
	
	setCurrentFilename(tok_AST); 
	CslToken *vt = static_cast<CslToken*>(tok.get()); based_number_AST->setNumber(vt->getNumber()); 
	
#line 23872 "CslParser.cpp"
	}
	based_number_AST = antlr::RefCslAST(currentAST.root);
	returnAST = based_number_AST;
}

void CslParser::real_number() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST real_number_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST tok_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	tok = LT(1);
	tok_AST = astFactory->create(tok);
	astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok_AST));
	match(REAL_NUMBER);
	real_number_AST = antlr::RefCslAST(currentAST.root);
#line 16737 "csl.parser.g"
	
	setCurrentFilename(tok_AST); 
	
	throwError(_RS("Real numbers not allowed for version 1.0"), currentFilename.getRealLine(tok_AST->getLine()), tok_AST->getColumn());
	
	CslToken *vt = static_cast<CslToken*>(tok.get()); real_number_AST->setNumber(vt->getNumber()); 
	
#line 23899 "CslParser.cpp"
	}
	real_number_AST = antlr::RefCslAST(currentAST.root);
	returnAST = real_number_AST;
}

void CslParser::function_call_ret_id() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST function_call_ret_id_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri3 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri4 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri5 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri5_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri6 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri6_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri7 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri7_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri8 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri8_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri9 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri9_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri10 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri10_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri11 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri11_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri12 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri12_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri13 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri13_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri14 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri14_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri15 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri15_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri16 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri16_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri17 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri17_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri18 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri18_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri19 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri19_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri20 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri20_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri21 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri21_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri22 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri22_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcri23 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcri23_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 16986 "csl.parser.g"
	
	RefCslAST temp;
	
#line 23959 "CslParser.cpp"
	
	{
	{
	switch ( LA(1)) {
	case K_GET_TYPE:
	{
		fcri1 = LT(1);
		fcri1_AST = astFactory->create(fcri1);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri1_AST));
		match(K_GET_TYPE);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16995 "csl.parser.g"
		temp = fcri1_AST;
#line 23974 "CslParser.cpp"
		break;
	}
	case K_GET_INTERFACE:
	{
		fcri2 = LT(1);
		fcri2_AST = astFactory->create(fcri2);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri2_AST));
		match(K_GET_INTERFACE);
		param_list_get_interface();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16996 "csl.parser.g"
		temp = fcri2_AST;
#line 23987 "CslParser.cpp"
		break;
	}
	case K_GET_UNIT_PREFIX:
	{
		fcri3 = LT(1);
		fcri3_AST = astFactory->create(fcri3);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri3_AST));
		match(K_GET_UNIT_PREFIX);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16997 "csl.parser.g"
		temp = fcri3_AST;
#line 24000 "CslParser.cpp"
		break;
	}
	case K_GET_SIGNAL_PREFIX:
	{
		fcri4 = LT(1);
		fcri4_AST = astFactory->create(fcri4);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri4_AST));
		match(K_GET_SIGNAL_PREFIX);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16998 "csl.parser.g"
		temp = fcri4_AST;
#line 24013 "CslParser.cpp"
		break;
	}
	case K_GET_SIGNAL_PREFIX_LOCAL:
	{
		fcri5 = LT(1);
		fcri5_AST = astFactory->create(fcri5);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri5_AST));
		match(K_GET_SIGNAL_PREFIX_LOCAL);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16999 "csl.parser.g"
		temp = fcri5_AST;
#line 24026 "CslParser.cpp"
		break;
	}
	case K_GET_BITRANGE:
	{
		fcri6 = LT(1);
		fcri6_AST = astFactory->create(fcri6);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri6_AST));
		match(K_GET_BITRANGE);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17000 "csl.parser.g"
		temp = fcri6_AST;
#line 24039 "CslParser.cpp"
		break;
	}
	case K_GET_DIM_BITRANGE:
	{
		fcri7 = LT(1);
		fcri7_AST = astFactory->create(fcri7);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri7_AST));
		match(K_GET_DIM_BITRANGE);
		param_list_get_dim_bitrange();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17001 "csl.parser.g"
		temp = fcri7_AST;
#line 24052 "CslParser.cpp"
		break;
	}
	case K_GET_ATTR:
	{
		fcri8 = LT(1);
		fcri8_AST = astFactory->create(fcri8);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri8_AST));
		match(K_GET_ATTR);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17002 "csl.parser.g"
		temp = fcri8_AST;
#line 24065 "CslParser.cpp"
		break;
	}
	case K_GET_CELL:
	{
		fcri9 = LT(1);
		fcri9_AST = astFactory->create(fcri9);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri9_AST));
		match(K_GET_CELL);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17003 "csl.parser.g"
		temp = fcri9_AST;
#line 24078 "CslParser.cpp"
		break;
	}
	case K_GET_INPUT_FIELD:
	{
		fcri10 = LT(1);
		fcri10_AST = astFactory->create(fcri10);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri10_AST));
		match(K_GET_INPUT_FIELD);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17004 "csl.parser.g"
		temp = fcri10_AST;
#line 24091 "CslParser.cpp"
		break;
	}
	case K_GET_OUTPUT_FIELD:
	{
		fcri11 = LT(1);
		fcri11_AST = astFactory->create(fcri11);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri11_AST));
		match(K_GET_OUTPUT_FIELD);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17005 "csl.parser.g"
		temp = fcri11_AST;
#line 24104 "CslParser.cpp"
		break;
	}
	case K_GET_CNT_DIR_SIGNAL:
	{
		fcri12 = LT(1);
		fcri12_AST = astFactory->create(fcri12);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri12_AST));
		match(K_GET_CNT_DIR_SIGNAL);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17006 "csl.parser.g"
		temp = fcri12_AST;
#line 24117 "CslParser.cpp"
		break;
	}
	case K_GET_ENUM:
	{
		fcri13 = LT(1);
		fcri13_AST = astFactory->create(fcri13);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri13_AST));
		match(K_GET_ENUM);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17007 "csl.parser.g"
		temp = fcri13_AST;
#line 24130 "CslParser.cpp"
		break;
	}
	case K_GET_ENUM_ITEM:
	{
		fcri14 = LT(1);
		fcri14_AST = astFactory->create(fcri14);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri14_AST));
		match(K_GET_ENUM_ITEM);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17008 "csl.parser.g"
		temp = fcri14_AST;
#line 24143 "CslParser.cpp"
		break;
	}
	case K_GET_VC_CLOCK:
	{
		fcri15 = LT(1);
		fcri15_AST = astFactory->create(fcri15);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri15_AST));
		match(K_GET_VC_CLOCK);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17009 "csl.parser.g"
		temp = fcri15_AST;
#line 24156 "CslParser.cpp"
		break;
	}
	case K_GET_VC_RESET:
	{
		fcri16 = LT(1);
		fcri16_AST = astFactory->create(fcri16);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri16_AST));
		match(K_GET_VC_RESET);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17010 "csl.parser.g"
		temp = fcri16_AST;
#line 24169 "CslParser.cpp"
		break;
	}
	case K_GET_VC_STALL:
	{
		fcri17 = LT(1);
		fcri17_AST = astFactory->create(fcri17);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri17_AST));
		match(K_GET_VC_STALL);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17011 "csl.parser.g"
		temp = fcri17_AST;
#line 24182 "CslParser.cpp"
		break;
	}
	case K_GET_VC_COMPARE_TRIGGER:
	{
		fcri18 = LT(1);
		fcri18_AST = astFactory->create(fcri18);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri18_AST));
		match(K_GET_VC_COMPARE_TRIGGER);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17012 "csl.parser.g"
		temp = fcri18_AST;
#line 24195 "CslParser.cpp"
		break;
	}
	case K_GET_VC_START_GENERATION_TRIGGER:
	{
		fcri19 = LT(1);
		fcri19_AST = astFactory->create(fcri19);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri19_AST));
		match(K_GET_VC_START_GENERATION_TRIGGER);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17013 "csl.parser.g"
		temp = fcri19_AST;
#line 24208 "CslParser.cpp"
		break;
	}
	case K_GET_VC_END_GENERATION_TRIGGER:
	{
		fcri20 = LT(1);
		fcri20_AST = astFactory->create(fcri20);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri20_AST));
		match(K_GET_VC_END_GENERATION_TRIGGER);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17014 "csl.parser.g"
		temp = fcri20_AST;
#line 24221 "CslParser.cpp"
		break;
	}
	case K_GET_VC_CAPTURE_EDGE_TYPE:
	{
		fcri21 = LT(1);
		fcri21_AST = astFactory->create(fcri21);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri21_AST));
		match(K_GET_VC_CAPTURE_EDGE_TYPE);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17015 "csl.parser.g"
		temp = fcri21_AST;
#line 24234 "CslParser.cpp"
		break;
	}
	case K_GET_VC_MODULE:
	{
		fcri22 = LT(1);
		fcri22_AST = astFactory->create(fcri22);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri22_AST));
		match(K_GET_VC_MODULE);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17016 "csl.parser.g"
		temp = fcri22_AST;
#line 24247 "CslParser.cpp"
		break;
	}
	case K_GET_RADIX:
	{
		fcri23 = LT(1);
		fcri23_AST = astFactory->create(fcri23);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcri23_AST));
		match(K_GET_RADIX);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 17017 "csl.parser.g"
		temp = fcri23_AST;
#line 24260 "CslParser.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 17020 "csl.parser.g"
	setCurrentFilename(temp);
#line 24271 "CslParser.cpp"
	}
	function_call_ret_id_AST = antlr::RefCslAST(currentAST.root);
	returnAST = function_call_ret_id_AST;
}

void CslParser::function_call_ret_expr() {
	returnAST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	antlr::RefCslAST function_call_ret_expr_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre1_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre2_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre3 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre3_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre4 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre4_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre5 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre5_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre6 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre6_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre7 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre7_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre8 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre8_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre9 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre9_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre10 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre10_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre11 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre11_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre12 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre12_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre13 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre13_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre14 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre14_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre15 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre15_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre16 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre16_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre17 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre17_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre18 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre18_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre19 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre19_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre20 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre20_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre21 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre21_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre22 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre22_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre23 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre23_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre24 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre24_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre25 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre25_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre26 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre26_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre27 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre27_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre28 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre28_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre29 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre29_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre30 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre30_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre31 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre31_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre32 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre32_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre33 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre33_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre34 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre34_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre35 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre35_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre36 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre36_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre37 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre37_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre38 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre38_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre39 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre39_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre40 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre40_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre41 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre41_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre42 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre42_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre43 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre43_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre44 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre44_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre45 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre45_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre46 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre46_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre47 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre47_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre48 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre48_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre49 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre49_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre50 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre50_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre51 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre51_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre52 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre52_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre53 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre53_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre54 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre54_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre55 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre55_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre56 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre56_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre57 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre57_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre58 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre58_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre59 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre59_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre60 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre60_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre61 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre61_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  fcre62 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	antlr::RefCslAST fcre62_AST = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 16903 "csl.parser.g"
	
	RefCslAST temp;
	
#line 24409 "CslParser.cpp"
	
	{
	{
	switch ( LA(1)) {
	case K_GET_WIDTH:
	{
		fcre1 = LT(1);
		fcre1_AST = astFactory->create(fcre1);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre1_AST));
		match(K_GET_WIDTH);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16912 "csl.parser.g"
		temp = fcre1_AST;
#line 24424 "CslParser.cpp"
		break;
	}
	case K_GET_DIM_WIDTH:
	{
		fcre2 = LT(1);
		fcre2_AST = astFactory->create(fcre2);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre2_AST));
		match(K_GET_DIM_WIDTH);
		param_list_get_dim_width();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16913 "csl.parser.g"
		temp = fcre2_AST;
#line 24437 "CslParser.cpp"
		break;
	}
	case K_GET_LOWER_INDEX:
	{
		fcre3 = LT(1);
		fcre3_AST = astFactory->create(fcre3);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre3_AST));
		match(K_GET_LOWER_INDEX);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16914 "csl.parser.g"
		temp = fcre3_AST;
#line 24450 "CslParser.cpp"
		break;
	}
	case K_GET_DIM_LOWER_INDEX:
	{
		fcre4 = LT(1);
		fcre4_AST = astFactory->create(fcre4);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre4_AST));
		match(K_GET_DIM_LOWER_INDEX);
		param_list_get_dim_lower_index();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16915 "csl.parser.g"
		temp = fcre4_AST;
#line 24463 "CslParser.cpp"
		break;
	}
	case K_GET_UPPER_INDEX:
	{
		fcre5 = LT(1);
		fcre5_AST = astFactory->create(fcre5);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre5_AST));
		match(K_GET_UPPER_INDEX);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16916 "csl.parser.g"
		temp = fcre5_AST;
#line 24476 "CslParser.cpp"
		break;
	}
	case K_GET_DIM_UPPER_INDEX:
	{
		fcre6 = LT(1);
		fcre6_AST = astFactory->create(fcre6);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre6_AST));
		match(K_GET_DIM_UPPER_INDEX);
		param_list_get_dim_upper_index();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16917 "csl.parser.g"
		temp = fcre6_AST;
#line 24489 "CslParser.cpp"
		break;
	}
	case K_GET_OFFSET:
	{
		fcre7 = LT(1);
		fcre7_AST = astFactory->create(fcre7);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre7_AST));
		match(K_GET_OFFSET);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16918 "csl.parser.g"
		temp = fcre7_AST;
#line 24502 "CslParser.cpp"
		break;
	}
	case K_GET_DIM_OFFSET:
	{
		fcre8 = LT(1);
		fcre8_AST = astFactory->create(fcre8);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre8_AST));
		match(K_GET_DIM_OFFSET);
		param_list_get_dim_offset();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16919 "csl.parser.g"
		temp = fcre8_AST;
#line 24515 "CslParser.cpp"
		break;
	}
	case K_GET_NUMBER_OF_DIMENSIONS:
	{
		fcre9 = LT(1);
		fcre9_AST = astFactory->create(fcre9);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre9_AST));
		match(K_GET_NUMBER_OF_DIMENSIONS);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16920 "csl.parser.g"
		temp = fcre9_AST;
#line 24528 "CslParser.cpp"
		break;
	}
	case K_GET_FILENAME:
	{
		fcre10 = LT(1);
		fcre10_AST = astFactory->create(fcre10);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre10_AST));
		match(K_GET_FILENAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16921 "csl.parser.g"
		temp = fcre10_AST;
#line 24541 "CslParser.cpp"
		break;
	}
	case K_GET_NAME:
	{
		fcre11 = LT(1);
		fcre11_AST = astFactory->create(fcre11);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre11_AST));
		match(K_GET_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16922 "csl.parser.g"
		temp = fcre11_AST;
#line 24554 "CslParser.cpp"
		break;
	}
	case K_GET_VC_ID:
	{
		fcre12 = LT(1);
		fcre12_AST = astFactory->create(fcre12);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre12_AST));
		match(K_GET_VC_ID);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16923 "csl.parser.g"
		temp = fcre12_AST;
#line 24567 "CslParser.cpp"
		break;
	}
	case K_GET_VC_MAX_NUM_STATES:
	{
		fcre13 = LT(1);
		fcre13_AST = astFactory->create(fcre13);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre13_AST));
		match(K_GET_VC_MAX_NUM_STATES);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16924 "csl.parser.g"
		temp = fcre13_AST;
#line 24580 "CslParser.cpp"
		break;
	}
	case K_GET_MAX_NUM_VECTORS:
	{
		fcre14 = LT(1);
		fcre14_AST = astFactory->create(fcre14);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre14_AST));
		match(K_GET_MAX_NUM_VECTORS);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16925 "csl.parser.g"
		temp = fcre14_AST;
#line 24593 "CslParser.cpp"
		break;
	}
	case K_GET_SIMULATION_TIMEOUT_COUNT:
	{
		fcre15 = LT(1);
		fcre15_AST = astFactory->create(fcre15);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre15_AST));
		match(K_GET_SIMULATION_TIMEOUT_COUNT);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16926 "csl.parser.g"
		temp = fcre15_AST;
#line 24606 "CslParser.cpp"
		break;
	}
	case K_GET_TRANSACTION_TIMEOUT_COUNT:
	{
		fcre16 = LT(1);
		fcre16_AST = astFactory->create(fcre16);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre16_AST));
		match(K_GET_TRANSACTION_TIMEOUT_COUNT);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16927 "csl.parser.g"
		temp = fcre16_AST;
#line 24619 "CslParser.cpp"
		break;
	}
	case K_GET_MAX_ERROR_COUNT:
	{
		fcre17 = LT(1);
		fcre17_AST = astFactory->create(fcre17);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre17_AST));
		match(K_GET_MAX_ERROR_COUNT);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16928 "csl.parser.g"
		temp = fcre17_AST;
#line 24632 "CslParser.cpp"
		break;
	}
	case K_GET_SIGNAL_VALUE:
	{
		fcre18 = LT(1);
		fcre18_AST = astFactory->create(fcre18);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre18_AST));
		match(K_GET_SIGNAL_VALUE);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16929 "csl.parser.g"
		temp = fcre18_AST;
#line 24645 "CslParser.cpp"
		break;
	}
	case K_GET_SYMBOL_LENGTH:
	{
		fcre19 = LT(1);
		fcre19_AST = astFactory->create(fcre19);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre19_AST));
		match(K_GET_SYMBOL_LENGTH);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16930 "csl.parser.g"
		temp = fcre19_AST;
#line 24658 "CslParser.cpp"
		break;
	}
	case K_GET_DATA_WORD_WIDTH:
	{
		fcre20 = LT(1);
		fcre20_AST = astFactory->create(fcre20);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre20_AST));
		match(K_GET_DATA_WORD_WIDTH);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16931 "csl.parser.g"
		temp = fcre20_AST;
#line 24671 "CslParser.cpp"
		break;
	}
	case K_GET_LOWER_BOUND:
	{
		fcre21 = LT(1);
		fcre21_AST = astFactory->create(fcre21);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre21_AST));
		match(K_GET_LOWER_BOUND);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16932 "csl.parser.g"
		temp = fcre21_AST;
#line 24684 "CslParser.cpp"
		break;
	}
	case K_GET_UPPER_BOUND:
	{
		fcre22 = LT(1);
		fcre22_AST = astFactory->create(fcre22);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre22_AST));
		match(K_GET_UPPER_BOUND);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16933 "csl.parser.g"
		temp = fcre22_AST;
#line 24697 "CslParser.cpp"
		break;
	}
	case K_GET_ADDR_INCREMENT:
	{
		fcre23 = LT(1);
		fcre23_AST = astFactory->create(fcre23);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre23_AST));
		match(K_GET_ADDR_INCREMENT);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16934 "csl.parser.g"
		temp = fcre23_AST;
#line 24710 "CslParser.cpp"
		break;
	}
	case K_GET_NEXT_ADDRESS:
	{
		fcre24 = LT(1);
		fcre24_AST = astFactory->create(fcre24);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre24_AST));
		match(K_GET_NEXT_ADDRESS);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16935 "csl.parser.g"
		temp = fcre24_AST;
#line 24723 "CslParser.cpp"
		break;
	}
	case K_GET_ALIGNMENT:
	{
		fcre25 = LT(1);
		fcre25_AST = astFactory->create(fcre25);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre25_AST));
		match(K_GET_ALIGNMENT);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16936 "csl.parser.g"
		temp = fcre25_AST;
#line 24736 "CslParser.cpp"
		break;
	}
	case K_GET_ENDIANESS:
	{
		fcre26 = LT(1);
		fcre26_AST = astFactory->create(fcre26);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre26_AST));
		match(K_GET_ENDIANESS);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16937 "csl.parser.g"
		temp = fcre26_AST;
#line 24749 "CslParser.cpp"
		break;
	}
	case K_GET_NAME_LENGTH:
	{
		fcre27 = LT(1);
		fcre27_AST = astFactory->create(fcre27);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre27_AST));
		match(K_GET_NAME_LENGTH);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16938 "csl.parser.g"
		temp = fcre27_AST;
#line 24762 "CslParser.cpp"
		break;
	}
	case K_GET_PREFIX:
	{
		fcre28 = LT(1);
		fcre28_AST = astFactory->create(fcre28);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre28_AST));
		match(K_GET_PREFIX);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16939 "csl.parser.g"
		temp = fcre28_AST;
#line 24775 "CslParser.cpp"
		break;
	}
	case K_GET_SUFFIX:
	{
		fcre29 = LT(1);
		fcre29_AST = astFactory->create(fcre29);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre29_AST));
		match(K_GET_SUFFIX);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16940 "csl.parser.g"
		temp = fcre29_AST;
#line 24788 "CslParser.cpp"
		break;
	}
	case K_GET_LOCK_ENABLE_BIT:
	{
		fcre30 = LT(1);
		fcre30_AST = astFactory->create(fcre30);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre30_AST));
		match(K_GET_LOCK_ENABLE_BIT);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16941 "csl.parser.g"
		temp = fcre30_AST;
#line 24801 "CslParser.cpp"
		break;
	}
	case K_GET_DEPTH:
	{
		fcre31 = LT(1);
		fcre31_AST = astFactory->create(fcre31);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre31_AST));
		match(K_GET_DEPTH);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16942 "csl.parser.g"
		temp = fcre31_AST;
#line 24814 "CslParser.cpp"
		break;
	}
	case K_GET_ATTRIBUTES:
	{
		fcre32 = LT(1);
		fcre32_AST = astFactory->create(fcre32);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre32_AST));
		match(K_GET_ATTRIBUTES);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16943 "csl.parser.g"
		temp = fcre32_AST;
#line 24827 "CslParser.cpp"
		break;
	}
	case K_GET_MNEMONIC:
	{
		fcre33 = LT(1);
		fcre33_AST = astFactory->create(fcre33);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre33_AST));
		match(K_GET_MNEMONIC);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16944 "csl.parser.g"
		temp = fcre33_AST;
#line 24840 "CslParser.cpp"
		break;
	}
	case K_DATA_GENERATION:
	{
		fcre34 = LT(1);
		fcre34_AST = astFactory->create(fcre34);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre34_AST));
		match(K_DATA_GENERATION);
		param_list_data_generation();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16945 "csl.parser.g"
		temp = fcre34_AST;
#line 24853 "CslParser.cpp"
		break;
	}
	case K_GET_VALUE:
	{
		fcre35 = LT(1);
		fcre35_AST = astFactory->create(fcre35);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre35_AST));
		match(K_GET_VALUE);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16946 "csl.parser.g"
		temp = fcre35_AST;
#line 24866 "CslParser.cpp"
		break;
	}
	case K_GET_VC_NAME:
	{
		fcre36 = LT(1);
		fcre36_AST = astFactory->create(fcre36);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre36_AST));
		match(K_GET_VC_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16947 "csl.parser.g"
		temp = fcre36_AST;
#line 24879 "CslParser.cpp"
		break;
	}
	case K_GET_VC_HEADER_COMMENT:
	{
		fcre37 = LT(1);
		fcre37_AST = astFactory->create(fcre37);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre37_AST));
		match(K_GET_VC_HEADER_COMMENT);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16948 "csl.parser.g"
		temp = fcre37_AST;
#line 24892 "CslParser.cpp"
		break;
	}
	case K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	{
		fcre38 = LT(1);
		fcre38_AST = astFactory->create(fcre38);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre38_AST));
		match(K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16949 "csl.parser.g"
		temp = fcre38_AST;
#line 24905 "CslParser.cpp"
		break;
	}
	case K_GET_VC_MAX_NUMBER_OF_MISMATCHES:
	{
		fcre39 = LT(1);
		fcre39_AST = astFactory->create(fcre39);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre39_AST));
		match(K_GET_VC_MAX_NUMBER_OF_MISMATCHES);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16950 "csl.parser.g"
		temp = fcre39_AST;
#line 24918 "CslParser.cpp"
		break;
	}
	case K_GET_VC_TIMEOUT:
	{
		fcre40 = LT(1);
		fcre40_AST = astFactory->create(fcre40);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre40_AST));
		match(K_GET_VC_TIMEOUT);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16951 "csl.parser.g"
		temp = fcre40_AST;
#line 24931 "CslParser.cpp"
		break;
	}
	case K_GET_VC_OUTPUT_FILENAME:
	{
		fcre41 = LT(1);
		fcre41_AST = astFactory->create(fcre41);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre41_AST));
		match(K_GET_VC_OUTPUT_FILENAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16952 "csl.parser.g"
		temp = fcre41_AST;
#line 24944 "CslParser.cpp"
		break;
	}
	case K_GET_VC_CPP_RD_NAME:
	{
		fcre42 = LT(1);
		fcre42_AST = astFactory->create(fcre42);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre42_AST));
		match(K_GET_VC_CPP_RD_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16953 "csl.parser.g"
		temp = fcre42_AST;
#line 24957 "CslParser.cpp"
		break;
	}
	case K_GET_VC_CPP_WR_NAME:
	{
		fcre43 = LT(1);
		fcre43_AST = astFactory->create(fcre43);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre43_AST));
		match(K_GET_VC_CPP_WR_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16954 "csl.parser.g"
		temp = fcre43_AST;
#line 24970 "CslParser.cpp"
		break;
	}
	case K_GET_RESET_NAME:
	{
		fcre44 = LT(1);
		fcre44_AST = astFactory->create(fcre44);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre44_AST));
		match(K_GET_RESET_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16955 "csl.parser.g"
		temp = fcre44_AST;
#line 24983 "CslParser.cpp"
		break;
	}
	case K_GET_CLOCK_NAME:
	{
		fcre45 = LT(1);
		fcre45_AST = astFactory->create(fcre45);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre45_AST));
		match(K_GET_CLOCK_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16956 "csl.parser.g"
		temp = fcre45_AST;
#line 24996 "CslParser.cpp"
		break;
	}
	case K_GET_RD_CLOCK_NAME:
	{
		fcre46 = LT(1);
		fcre46_AST = astFactory->create(fcre46);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre46_AST));
		match(K_GET_RD_CLOCK_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16957 "csl.parser.g"
		temp = fcre46_AST;
#line 25009 "CslParser.cpp"
		break;
	}
	case K_GET_WR_CLOCK_NAME:
	{
		fcre47 = LT(1);
		fcre47_AST = astFactory->create(fcre47);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre47_AST));
		match(K_GET_WR_CLOCK_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16958 "csl.parser.g"
		temp = fcre47_AST;
#line 25022 "CslParser.cpp"
		break;
	}
	case K_GET_PUSH_NAME:
	{
		fcre48 = LT(1);
		fcre48_AST = astFactory->create(fcre48);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre48_AST));
		match(K_GET_PUSH_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16959 "csl.parser.g"
		temp = fcre48_AST;
#line 25035 "CslParser.cpp"
		break;
	}
	case K_GET_POP_NAME:
	{
		fcre49 = LT(1);
		fcre49_AST = astFactory->create(fcre49);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre49_AST));
		match(K_GET_POP_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16960 "csl.parser.g"
		temp = fcre49_AST;
#line 25048 "CslParser.cpp"
		break;
	}
	case K_GET_FULL_NAME:
	{
		fcre50 = LT(1);
		fcre50_AST = astFactory->create(fcre50);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre50_AST));
		match(K_GET_FULL_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16961 "csl.parser.g"
		temp = fcre50_AST;
#line 25061 "CslParser.cpp"
		break;
	}
	case K_GET_EMPTY_NAME:
	{
		fcre51 = LT(1);
		fcre51_AST = astFactory->create(fcre51);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre51_AST));
		match(K_GET_EMPTY_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16962 "csl.parser.g"
		temp = fcre51_AST;
#line 25074 "CslParser.cpp"
		break;
	}
	case K_GET_WR_DATA_NAME:
	{
		fcre52 = LT(1);
		fcre52_AST = astFactory->create(fcre52);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre52_AST));
		match(K_GET_WR_DATA_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16963 "csl.parser.g"
		temp = fcre52_AST;
#line 25087 "CslParser.cpp"
		break;
	}
	case K_GET_RD_DATA_NAME:
	{
		fcre53 = LT(1);
		fcre53_AST = astFactory->create(fcre53);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre53_AST));
		match(K_GET_RD_DATA_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16964 "csl.parser.g"
		temp = fcre53_AST;
#line 25100 "CslParser.cpp"
		break;
	}
	case K_GET_VALID_NAME:
	{
		fcre54 = LT(1);
		fcre54_AST = astFactory->create(fcre54);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre54_AST));
		match(K_GET_VALID_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16965 "csl.parser.g"
		temp = fcre54_AST;
#line 25113 "CslParser.cpp"
		break;
	}
	case K_GET_WR_ADDR_NAME:
	{
		fcre55 = LT(1);
		fcre55_AST = astFactory->create(fcre55);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre55_AST));
		match(K_GET_WR_ADDR_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16966 "csl.parser.g"
		temp = fcre55_AST;
#line 25126 "CslParser.cpp"
		break;
	}
	case K_GET_RD_ADDR_NAME:
	{
		fcre56 = LT(1);
		fcre56_AST = astFactory->create(fcre56);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre56_AST));
		match(K_GET_RD_ADDR_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16967 "csl.parser.g"
		temp = fcre56_AST;
#line 25139 "CslParser.cpp"
		break;
	}
	case K_GET_WR_EN_NAME:
	{
		fcre57 = LT(1);
		fcre57_AST = astFactory->create(fcre57);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre57_AST));
		match(K_GET_WR_EN_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16968 "csl.parser.g"
		temp = fcre57_AST;
#line 25152 "CslParser.cpp"
		break;
	}
	case K_GET_RD_EN_NAME:
	{
		fcre58 = LT(1);
		fcre58_AST = astFactory->create(fcre58);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre58_AST));
		match(K_GET_RD_EN_NAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16969 "csl.parser.g"
		temp = fcre58_AST;
#line 25165 "CslParser.cpp"
		break;
	}
	case K_GET_OUTPUT_FILENAME:
	{
		fcre59 = LT(1);
		fcre59_AST = astFactory->create(fcre59);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre59_AST));
		match(K_GET_OUTPUT_FILENAME);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16970 "csl.parser.g"
		temp = fcre59_AST;
#line 25178 "CslParser.cpp"
		break;
	}
	case K_GET_MSB:
	{
		fcre60 = LT(1);
		fcre60_AST = astFactory->create(fcre60);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre60_AST));
		match(K_GET_MSB);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16971 "csl.parser.g"
		temp = fcre60_AST;
#line 25191 "CslParser.cpp"
		break;
	}
	case K_GET_LSB:
	{
		fcre61 = LT(1);
		fcre61_AST = astFactory->create(fcre61);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre61_AST));
		match(K_GET_LSB);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16972 "csl.parser.g"
		temp = fcre61_AST;
#line 25204 "CslParser.cpp"
		break;
	}
	case K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	{
		fcre62 = LT(1);
		fcre62_AST = astFactory->create(fcre62);
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(fcre62_AST));
		match(K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS);
		param_list_no_args_command();
		astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
#line 16973 "csl.parser.g"
		temp = fcre62_AST;
#line 25217 "CslParser.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
#line 16976 "csl.parser.g"
	setCurrentFilename(temp);
#line 25228 "CslParser.cpp"
	}
	function_call_ret_expr_AST = antlr::RefCslAST(currentAST.root);
	returnAST = function_call_ret_expr_AST;
}

void CslParser::initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& factory )
{
	factory.setMaxNodeType(777);
}
const char* CslParser::tokenNames[] = {
	"<0>",
	"EOF",
	"<2>",
	"NULL_TREE_LOOKAHEAD",
	"\"csl_unit\"",
	"\"csl_list\"",
	"\"csl_interface\"",
	"\"csl_register_file\"",
	"\"csl_read_interface\"",
	"\"csl_write_interface\"",
	"\"csl_register\"",
	"\"csl_port\"",
	"\"csl_signal\"",
	"\"csl_bitrange\"",
	"\"csl_signal_group\"",
	"\"csl_testbench\"",
	"\"csl_event\"",
	"\"csl_include\"",
	"\"csl_isa_field\"",
	"\"csl_isa_element\"",
	"\"csl_enum\"",
	"\"csl_field\"",
	"\"csl_fifo\"",
	"\"csl_memory_map\"",
	"\"csl_memory_map_page\"",
	"\"csl_state_data\"",
	"\"csl_vector\"",
	"\"csl_memory\"",
	"\"csl_multi_dim_bitrange\"",
	"\"csl_pipeline\"",
	"\"csl_pipestage\"",
	"\"csl_parameter\"",
	"\"set_type\"",
	"\"set_attr\"",
	"\"set_unit_prefix\"",
	"\"set_signal_prefix\"",
	"\"set_signal_prefix_local\"",
	"\"set_depth\"",
	"\"set_const_value\"",
	"\"set_external\"",
	"\"set_number_of_ports\"",
	"\"set_address\"",
	"\"set_attributes\"",
	"\"set_lock_enable_bit\"",
	"\"set_mask\"",
	"\"set_feedback_mask\"",
	"\"set_feedback_element\"",
	"\"set_shift_type\"",
	"\"set_shift_amount\"",
	"\"set_final_shift_value\"",
	"\"set_width\"",
	"\"set_dim_width\"",
	"\"set_bitrange\"",
	"\"set_dim_bitrange\"",
	"\"set_range\"",
	"\"set_dim_range\"",
	"\"set_dim_lower_index\"",
	"\"set_dim_upper_index\"",
	"\"set_offset\"",
	"\"set_dim_offset\"",
	"\"set_number_of_dimensions\"",
	"\"set_cell\"",
	"\"set_instance_alteration_bit\"",
	"\"set_testbench_verilog_filename\"",
	"\"set_vc_timeout\"",
	"\"set_period\"",
	"\"set_timebase\"",
	"\"set_transaction_timeout_count\"",
	"\"set_dut_compare_trigger\"",
	"\"set_generate_waves_filename\"",
	"\"set_instance_name\"",
	"\"set_dut_mem\"",
	"\"set_dut_mem_init\"",
	"\"set_single_line\"",
	"\"set_vc_id\"",
	"\"set_dut_input_filename\"",
	"\"set_dut_output_filename\"",
	"\"set_vc_max_num_states\"",
	"\"set_connection_type\"",
	"\"set_name\"",
	"\"set_direction\"",
	"\"set_max_num_vectors\"",
	"\"set_mem_instance_name\"",
	"\"set_event_type\"",
	"\"set_stimulus_filename\"",
	"\"set_expected_filename\"",
	"\"set_vc_output_filename\"",
	"\"set_tb_dut_name\"",
	"\"set_csim_unit_name\"",
	"\"set_pli_socket_name\"",
	"\"set_max_error_count\"",
	"\"set_radix\"",
	"\"set_generator_type\"",
	"\"set_pattern\"",
	"\"set_start_signal\"",
	"\"set_default_value\"",
	"\"set_reset\"",
	"\"set_duration\"",
	"\"set_clk_divider\"",
	"\"set_clk_multiplier\"",
	"\"set_phase_difference\"",
	"\"set_signal_name\"",
	"\"set_isa\"",
	"\"set_mnemonic\"",
	"\"set_decoder_name\"",
	"\"set_decoder_out_name_prefix\"",
	"\"set_decoder_out_name_suffix\"",
	"\"set_dimensions\"",
	"\"set_physical_implementation\"",
	"\"set_unit_id_address\"",
	"\"set_unit_id\"",
	"\"set_external_unit_enable\"",
	"\"set_value\"",
	"\"set_enum\"",
	"\"set_enum_item\"",
	"\"set_const\"",
	"\"set_field\"",
	"\"set_position\"",
	"\"set_next\"",
	"\"set_previous\"",
	"\"set_field_position\"",
	"\"set_top_unit\"",
	"\"set_address_increment\"",
	"\"set_next_address\"",
	"\"set_access_rights\"",
	"\"set_access_rights_enum\"",
	"\"set_data_word_width\"",
	"\"set_alignment\"",
	"\"set_endianess\"",
	"\"set_name_length\"",
	"\"set_address_visibility\"",
	"\"set_prefix\"",
	"\"set_unit_name\"",
	"\"set_suffix\"",
	"\"set_addr_abs\"",
	"\"set_addr_rel\"",
	"\"set_page_no\"",
	"\"set_name_max_length\"",
	"\"set_symbol_max_length\"",
	"\"set_source\"",
	"\"set_compare_event\"",
	"\"set_file_name\"",
	"\"set_vc_cpp_rd_name\"",
	"\"set_vc_cpp_wr_name\"",
	"\"set_vc_start_generation_trigger\"",
	"\"set_vc_max_number_of_mismatches\"",
	"\"set_vc_max_number_of_valid_transactions\"",
	"\"set_vc_valid_output_transaction\"",
	"\"set_transaction_type\"",
	"\"set_dut_mem_init_file\"",
	"\"set_capture_event\"",
	"\"set_vc_compare_trigger\"",
	"\"add_clock\"",
	"\"set_model\"",
	"\"set_cpp_vector_rd_name\"",
	"\"set_cpp_vector_wr_name\"",
	"\"set_max_num_of_vectors\"",
	"\"set_vc_max_cycles\"",
	"\"set_number_of_pipestages\"",
	"\"set_previous_pipestage\"",
	"\"set_next_pipestage\"",
	"\"set_pipestage_number\"",
	"\"set_pipestage_name\"",
	"\"set_pipestage_valid_input\"",
	"\"set_pipestage_valid_output\"",
	"\"set_vc_name\"",
	"\"set_vc_header_comment\"",
	"\"set_version\"",
	"\"set_vc_clock\"",
	"\"set_vc_reset\"",
	"\"set_vc_stall\"",
	"\"set_vc_end_generation_trigger\"",
	"\"set_vc_capture_edge_type\"",
	"\"set_vc_max_number_of_capture_events\"",
	"\"set_vc_max_num_of_transaction_events\"",
	"\"set_reset_name\"",
	"\"set_clock_name\"",
	"\"set_rd_clock_name\"",
	"\"set_wr_clock_name\"",
	"\"set_push_name\"",
	"\"set_pop_name\"",
	"\"set_full_name\"",
	"\"set_empty_name\"",
	"\"set_wr_data_name\"",
	"\"set_rd_data_name\"",
	"\"set_valid_name\"",
	"\"set_wr_addr_name\"",
	"\"set_rd_addr_name\"",
	"\"set_wr_en_name\"",
	"\"set_rd_en_name\"",
	"\"set_method\"",
	"\"set_pipestage\"",
	"\"set_msb\"",
	"\"set_lsb\"",
	"\"set_upper_index\"",
	"\"set_lower_index\"",
	"\"set_num_rd_ifc\"",
	"\"set_num_wr_ifc\"",
	"\"set_clock\"",
	"\"const\"",
	"\"int\"",
	"\"get_interface\"",
	"\"get_signal_value\"",
	"\"get_type\"",
	"\"get_attr\"",
	"\"get_unit_prefix\"",
	"\"get_signal_prefix\"",
	"\"get_signal_prefix_local\"",
	"\"get_depth\"",
	"\"get_attributes\"",
	"\"get_input_field\"",
	"\"get_output_field\"",
	"\"get_lock_enable_bit\"",
	"\"get_cnt_dir_signal\"",
	"\"get_width\"",
	"\"get_dim_width\"",
	"\"get_bitrange\"",
	"\"get_dim_bitrange\"",
	"\"get_range\"",
	"\"get_lower\"",
	"\"get_dim_lower\"",
	"\"get_upper\"",
	"\"get_dim_upper\"",
	"\"get_offset\"",
	"\"get_dim_offset\"",
	"\"get_number_of_dimensions\"",
	"\"get_cell\"",
	"\"get_transaction_timeout_count\"",
	"\"get_simulation_timeout_count\"",
	"\"get_vc_id\"",
	"\"get_vc_max_num_states\"",
	"\"get_name\"",
	"\"get_filename\"",
	"\"get_max_num_vectors\"",
	"\"get_max_error_count\"",
	"\"get_isa\"",
	"\"get_mnemonic\"",
	"\"get_value\"",
	"\"get_enum\"",
	"\"get_enum_item\"",
	"\"get_const\"",
	"\"get_field\"",
	"\"get_fieldlist\"",
	"\"get_next_address\"",
	"\"get_access_rights_enum\"",
	"\"get_lower_bound\"",
	"\"get_upper_bound\"",
	"\"get_data_word_width\"",
	"\"get_alignment\"",
	"\"get_endianess\"",
	"\"get_name_length\"",
	"\"get_address_visibility\"",
	"\"get_prefix\"",
	"\"get_suffix\"",
	"\"get_symbol_length\"",
	"\"get_address_increment\"",
	"\"get_vc_max_number_of_valid_transactions\"",
	"\"get_vc_name\"",
	"\"get_vc_header_comment\"",
	"\"get_vc_clock\"",
	"\"get_vc_reset\"",
	"\"get_vc_stall\"",
	"\"get_vc_compare_trigger\"",
	"\"get_vc_start_generation_trigger\"",
	"\"get_vc_end_generation_trigger\"",
	"\"get_vc_capture_edge_type\"",
	"\"get_vc_max_number_of_capture_events\"",
	"\"get_vc_max_number_of_mismatches\"",
	"\"get_vc_timeout\"",
	"\"get_vc_output_filename\"",
	"\"get_vc_cpp_rd_name\"",
	"\"get_vc_cpp_wr_name\"",
	"\"get_vc_radix\"",
	"\"get_vc_module\"",
	"\"get_output_filename\"",
	"\"get_reset_name\"",
	"\"get_clock_name\"",
	"\"get_rd_clock_name\"",
	"\"get_wr_clock_name\"",
	"\"get_push_name\"",
	"\"get_pop_name\"",
	"\"get_full_name\"",
	"\"get_empty_name\"",
	"\"get_wr_data_name\"",
	"\"get_rd_data_name\"",
	"\"get_valid_name\"",
	"\"get_wr_addr_name\"",
	"\"get_rd_addr_name\"",
	"\"get_wr_en_name\"",
	"\"get_rd_en_name\"",
	"\"get_pipestage\"",
	"\"get_msb\"",
	"\"get_lsb\"",
	"\"get_radix\"",
	"\"class\"",
	"\"public\"",
	"\"initialize\"",
	"\"#include\"",
	"\"add_instance\"",
	"\"add_instance_list\"",
	"\"add_port\"",
	"\"add_port_list\"",
	"\"remove_port\"",
	"\"remove_port_list\"",
	"\"reverse\"",
	"\"add_interface\"",
	"\"add_signal\"",
	"\"add_signal_list\"",
	"\"add_unit_parameter\"",
	"\"override_parameter\"",
	"\"auto_connect_width_inference\"",
	"\"auto_connect_verilog_and_csl\"",
	"\"auto_connect_filter\"",
	"\"add_valid_to_register\"",
	"\"create_rtl_module\"",
	"\"directive\"",
	"\"index_data_pair\"",
	"\"add_logic\"",
	"\"reset_value\"",
	"\"clear_value\"",
	"\"stop_at_end_value\"",
	"\"add_value\"",
	"\"column_name\"",
	"\"row_name\"",
	"\"add_column\"",
	"\"add_row\"",
	"\"matrix\"",
	"\"connect_split\"",
	"\"merge\"",
	"\"invert\"",
	"\"buffer\"",
	"\"concat\"",
	"\"connect\"",
	"\"input_verilog_type\"",
	"\"output_verilog_type\"",
	"\"autorouter\"",
	"\"remove_signal\"",
	"\"remove_signal_list\"",
	"\"add_signal_group\"",
	"\"add_port_group\"",
	"\"v1995\"",
	"\"v2001\"",
	"\"v2005\"",
	"\"sysv\"",
	"\"CA\"",
	"\"TA\"",
	"\"VecName\"",
	"\"SimVer\"",
	"\"SimArgs\"",
	"\"date\"",
	"\"user\"",
	"\"MachineArch\"",
	"\"oscillator\"",
	"\"pwl\"",
	"\"continuous\"",
	"\"add_dut_instance\"",
	"\"include_file\"",
	"\"add_clock_gen\"",
	"\"clk_output\"",
	"\"add_reset\"",
	"\"add_vector_instance\"",
	"\"add_arch_state_instance\"",
	"\"add_dut_compare_trigger\"",
	"\"add_comment\"",
	"\"add_tb_read_event\"",
	"\"exclusion_list\"",
	"\"include_only\"",
	"\"add_event\"",
	"\"add_write_event\"",
	"\"add_read_event\"",
	"\"print_signal_name_list\"",
	"\"print_signal_values_list\"",
	"\"generate_header_comment\"",
	"\"add_valid_bit_to_last_vector\"",
	"\"add_io_list\"",
	"\"add_missmatch_logic\"",
	"\"add_sample_event\"",
	"\"add_csim_unit\"",
	"\"rtl_compare_level\"",
	"\"csim_compare_level\"",
	"\"csim_sample_level\"",
	"\"add_instruction_format\"",
	"\"add_instruction_format_list\"",
	"\"add_instruction\"",
	"\"add_instruction_list\"",
	"\"add_field\"",
	"\"generate_cpp_header\"",
	"\"generate_verilog_header\"",
	"\"print\"",
	"\"generate_decoder\"",
	"\"gen_internal_unit_enable\"",
	"\"gen_part_select\"",
	"\"gen_mux\"",
	"\"add_enum\"",
	"\"add_fieldlist\"",
	"\"add_allowed_range\"",
	"\"create_signal\"",
	"\"add_address_range\"",
	"\"add_reserved_address_range\"",
	"\"add\"",
	"\"auto_gen_memory_map\"",
	"\"add_to_memory_map\"",
	"\"start_state_data_generation\"",
	"\"start_vector_generation\"",
	"\"pipestage_naming_convention\"",
	"\"associate_pipeline\"",
	"\"replicate\"",
	"\"add_pipestage\"",
	"\"connect_stall\"",
	"\"connect_enable\"",
	"\"branch\"",
	"\"inline_file\"",
	"\"inline_code\"",
	"\"reset_init_value\"",
	"\"add_pipeline_delay\"",
	"\"add_equation\"",
	"\"initialize_random_values\"",
	"\"initialize_random\"",
	"\"gen_unique_rtl_modules\"",
	"\"no_prefix\"",
	"\"do_not_gen_rtl\"",
	"\"do_not_gen_cpp\"",
	"\"register_ios\"",
	"\"connect_units\"",
	"\"connect_by_pattern\"",
	"\"connect_by_name\"",
	"backtick (\'`\') ",
	"at (\'@\')",
	"colon (\':\')",
	"comma (\',\')",
	"dot (\'.\')",
	"assign (\'=\')",
	"minus (\'-\')",
	"left bracket (\'[\')",
	"right bracket (\']\')",
	"left curly bracket (\'{\')",
	"right curly bracket (\'}\')",
	"left paranthesis (\'(\')",
	"right paranthesis (\')\')",
	"pound (\'#\')",
	"question mark (\'?\')",
	"semi colon (\';\')",
	"plus (\'+\')",
	"logical not (\'!\')",
	"not (\'~\')",
	"and (\'&\')",
	"nand (\'~&\')",
	"or (\'|\')",
	"nor (\'~|\')",
	"xor (\'^\')",
	"xnor (\'~^\')",
	"star (\'*\')",
	"power (\'**\')",
	"divide (\'/\')",
	"mod (\'%\')",
	"equal (\'==\')",
	"not equal (\'!=\')",
	"not equal case (\'!==\')",
	"equal case (\'===\')",
	"logical and (\'&&\')",
	"tand (\'&&&\')",
	"logical or (\'||\')",
	"lower then (\'<\')",
	"lower then or equal to (\'<=\')",
	"greater then (\'>\')",
	"greater then or equal to (\'>=\')",
	"shift left (\'<<\')",
	"arithmetic left shift (\'<<<\')",
	"shift right (\'>>\')",
	"arithmetic right shift (\'>>>\')",
	"trigger (\'->\')",
	"ppath (\'=>\')",
	"fpath (\'*>\')",
	"star paranthesis (\'*)\')",
	"p0_pos (\'+:\')",
	"p0_neg (\'-:\')",
	"superstar (\'(*)\')",
	"W",
	"END_OF_LINE",
	"VOCAB",
	"ALPHA",
	"DIGIT",
	"NZ_DIGIT",
	"BIN_DIGIT",
	"OCT_DIGIT",
	"HEX_DIGIT",
	"XZ_DIGIT",
	"an identifier",
	"ESCAPED_IDENTIFIER",
	"STRING",
	"UNSIGNED_NUMBER",
	"NZ_UNSIGNED_NUMBER",
	"REAL_NUMBER",
	"REAL_NUMBER_EXP",
	"SIGN",
	"EXP",
	"XZ_NUMBER",
	"BIN_NUMBER",
	"OCT_NUMBER",
	"HEX_NUMBER",
	"NUMBER",
	"BASED_NUMBER_HEADER",
	"BASED_NUMBER",
	"SYSTEM_TASK_NAME",
	"FILENAME",
	"DIRECTIVE",
	"WS",
	"SL_COMMENT",
	"ML_COMMENT",
	"UNIT_PARAMETER",
	"CSL_COMMAND",
	"CSL_UNIT_DEFINITION",
	"CSL_UNIT_INSTANTIATION",
	"CSL_INTERFACE_INSTANTIATION",
	"CSL_CSTOR",
	"CSL_INST",
	"CSL_INST_OR_CSTOR",
	"CSL_MEMORY_MAP_DEFINITION",
	"CSL_MEMORY_MAP_PAGE_DEFINITION",
	"CSL_MEMORY_MAP_PAGE_INSTANTIATION",
	"CSL_MEMORY_MAP_PAGE_CSTOR",
	"CSL_MEMORY_MAP_CSTOR",
	"EXPRESSION_LIST",
	"CONCATENATION",
	"MULTI_CONCATENATION",
	"EXPRESSION",
	"RANGE_EXPRESSION",
	"MINTYPMAX_EXPRESSION",
	"EXPR_PRIMARY_IDENTIFIER",
	"U_PLUS",
	"U_MINUS",
	"U_AND",
	"U_NAND",
	"U_OR",
	"U_NOR",
	"U_XOR",
	"U_XNOR",
	"FUNCTION_CALL_RET_ID",
	"FUNCTION_CALL_RET_EXPR",
	"EXPR_HYBRID",
	"SIZED_NUMBER",
	"BITRANGE",
	"PARAM_LIST_ADD_SIGNAL",
	"PARAM_LIST_ADD_SIGNAL_LIST",
	"PARAM_LIST_SIGNAL_GROUP",
	"PARAM_LIST_ADD_PORT",
	"PARAM_LIST_ADD_PORT_LIST",
	"PARAM_LIST_ADD_INSTANCE",
	"PARAM_LIST_ADD_INSTANCE_LIST",
	"PARAM_LIST_ADD_UNIT_PARAMETER",
	"PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING",
	"CSL_LIST",
	"TIME_EXPR",
	"F2A_PAIR_EXPR",
	"PARAM_LIST_SET_POSITION",
	"PARAM_LIST_SET_NEXT",
	"PARAM_LIST_SET_PREVIOUS",
	"PARENT_CLASS",
	"PARAM_LIST_ADD_TO_MEMORY_MAP",
	"INST_PARAM",
	"ENUM_ITEM",
	"ASSIGNOR",
	"CSL_ISA_ELEMENT_DECLARATION",
	"K_INPUT",
	"K_OUTPUT",
	"K_INOUT",
	"K_ACTION",
	"K_ATOM",
	"K_COUNTER",
	"K_REGISTER",
	"K_CTL",
	"K_DFF",
	"K_EVNT",
	"K_LFSR",
	"K_SFT",
	"K_SEMA",
	"K_STATISTIC",
	"K_STATUS",
	"K_PRODUCER",
	"K_CONSUMER",
	"K_REAL",
	"K_REALTIME",
	"K_HIERARCHICAL",
	"K_FLAT",
	"K_PAGE",
	"K_VIRTUAL_WITH_BASE_ADDRESS",
	"K_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS",
	"K_DIAGNOSTIC",
	"K_STIM_EXPECT",
	"K_SERIAL_BUS",
	"K_FILE",
	"K_SOCKET",
	"K_SHARED_OBJ",
	"K_UNDEFINED",
	"K_ILLEGAL",
	"K_RESERVED",
	"K_VALID",
	"K_OPCODE",
	"K_SUBOPCODE",
	"K_ADDRESS",
	"K_SELECTOR",
	"K_CONSTANT",
	"K_RF_ADDRESS",
	"K_MEM_ADDRESS",
	"K_IM",
	"K_BRANCH_ADDRESS",
	"K_BRANCH_SELECT",
	"K_INSTR_FORMAT",
	"K_INSTR",
	"K_ROOT_FORMAT",
	"K_VALID_ENUM",
	"K_DATA_ENUM",
	"K_CONTROL_ENUM",
	"K_OTHER_ENUM",
	"K_UNUSED",
	"K_ENABLE",
	"K_STALL",
	"K_PIPE_ENABLE",
	"K_PIPE_STALL",
	"K_MUX_SELECT",
	"K_DECODE",
	"K_CLOCK_SIGNAL",
	"K_RESET_SIGNAL",
	"K_WRITE_ENABLE",
	"K_IFC_ONLY",
	"K_LOCAL_ONLY",
	"K_REGISTER_GROUP",
	"K_DISCONNECT_REG_FIELDS_IOS",
	"K_CONNECT_REG_FIELDS_IOS",
	"K_FIELD_GROUP",
	"K_ALL",
	"K_INPUTS",
	"K_OUTPUTS",
	"K_INOUTS",
	"K_NAME_REGISTER",
	"K_ON",
	"K_OFF",
	"K_CLK",
	"K_NO_PREFIX",
	"K_PIPELINE_NAME",
	"K_PIPESTAGE_NAME",
	"K_PIPELINE_PIPESTAGE_NAME",
	"K_NO_SUFFIX",
	"K_BIN",
	"K_HEX",
	"K_LITTLE_ENDIAN",
	"K_BIG_ENDIAN",
	"K_ACCESS_RIGHT_NONE",
	"K_ACCESS_RIGHT_READ",
	"K_ACCESS_RIGHT_WRITE",
	"K_ACCESS_RIGHT_READ_WRITE",
	"K_SRAM",
	"K_FFA",
	"K_READ",
	"K_WRITE",
	"K_SHADOW",
	"K_READ_WRITE",
	"K_STALL_ENUM",
	"K_NO_STALL_ENUM",
	"K_XOR",
	"K_XNOR",
	"K_NEG_OUTPUT",
	"K_SERIAL_INPUT",
	"K_SERIAL_OUTPUT",
	"K_RD_EN",
	"K_CONNECT_INPUT_TO_FIELD",
	"K_CONNECT_OUTPUT_TO_FIELD",
	"K_GRAY_OUTPUT",
	"K_CNT_DIR_SIGNAL",
	"K_INC_SIGNAL",
	"K_DEC_SIGNAL",
	"K_SH_OP_SIGNAL",
	"K_START_VALUE",
	"K_END_VALUE",
	"K_COUNT_AMOUNT",
	"K_COUNT_DIRECTION",
	"K_COUNT_ENABLE",
	"K_SET",
	"K_RESET",
	"K_PROGRAMMABLE_DEPTH",
	"K_PRIORITY_BYPASS",
	"K_SYNC_FIFO",
	"K_ASYNC_FIFO",
	"K_DEPTH_EXTEND",
	"K_WIDTH_EXTEND",
	"K_WR_HOLD",
	"K_PARALLEL_OUTPUT",
	"K_PARALLEL_INPUT",
	"K_RD_WORDS",
	"K_WR_WORDS",
	"K_SRAM_RD",
	"K_SRAM_WR",
	"K_PUSHBACK",
	"K_FLOW_THROUGH",
	"K_STALL_RD_SIDE",
	"K_STALL_WR_SIDE",
	"K_WR_RELEASE",
	"K_ALMOST_EMPTY",
	"K_ALMOST_FULL",
	"K_OUTPUT_WR_ADDR",
	"K_OUTPUT_RD_ADDR",
	"K_CREDIT",
	"K_RD_CREDIT",
	"K_WR_CREDIT",
	"K_FLOW",
	"K_READ_VALID",
	"K_BYPASS",
	"K_GENERATE_WAVES",
	"K_SIMULATION_TIMEOUT_COUNTER",
	"K_STALL_GENERATION",
	"K_GENERATE_REPORT",
	"K_ASYNC_RESET",
	"K_INIT",
	"K_CLEAR",
	"K_STOP",
	"K_DIRECTION_CONTROL",
	"K_INJECT_STALLS",
	"K_EXTERNAL_UNIT_ENABLE",
	"K_UNIT_ADDRESS_DECODER",
	"K_SAL",
	"K_SAR",
	"K_SHL",
	"K_SHR",
	"K_ROL",
	"K_ROR",
	"K_PLI_SOCKET",
	"K_CPP",
	"K_TB",
	"K_TRANSACTION",
	"K_CYCLE_ACCURATE",
	"K_NAND",
	"K_NOR",
	"K_AND",
	"K_OR",
	"K_NOT",
	"K_PLUS",
	"K_RISE",
	"K_FALL",
	"K_REG",
	"K_WIRE",
	"K_TRI",
	"K_TRIAND",
	"K_SUPPLY0",
	"K_SUPPLY1",
	"K_TRIOR",
	"K_TRI0",
	"K_TRI1",
	"K_TRIREG",
	"K_WAND",
	"K_WOR",
	"K_INTEGER",
	"K_TIME",
	"K_TRUE",
	"K_FALSE",
	"K_FILE_CPLUSPLUS",
	"K_FILE_VERILOG",
	"K_S",
	"K_US",
	"K_MS",
	"K_NS",
	"K_PS",
	"K_COLUMNS",
	"K_ROWS",
	"K_WAVE_TYPE_FSDB",
	"K_WAVE_TYPE_VCD",
	"K_UP",
	"K_DOWN",
	"K_COMBINATIONAL",
	"K_SEQUENTIAL",
	"K_LOAD",
	"K_CONCATENATION",
	"K_REPLICATION",
	"K_SKIP_PARAMETER",
	"K_RESET_",
	"K_TO_USE_FOR_NONDETERMINISM_IN_WALKER",
	"TICK",
	"PSTAR",
	"K_DATA_GENERATION",
	0
};

const unsigned long CslParser::_tokenSet_0_data_[] = { 4294901744UL, 3707503679UL, 138772480UL, 4294398080UL, 546243641UL, 1073717216UL, 240UL, 0UL, 0UL, 740368384UL, 256UL, 24576UL, 1304608UL, 4227776511UL, 536870911UL, 15488UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 384UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "csl_unit" "csl_list" "csl_interface" "csl_register_file" "csl_read_interface" 
// "csl_write_interface" "csl_register" "csl_port" "csl_signal" "csl_bitrange" 
// "csl_signal_group" "csl_testbench" "csl_include" "csl_isa_field" "csl_isa_element" 
// "csl_enum" "csl_field" "csl_fifo" "csl_memory_map" "csl_memory_map_page" 
// "csl_state_data" "csl_vector" "csl_memory" "csl_multi_dim_bitrange" 
// "csl_pipeline" "csl_pipestage" "csl_parameter" "set_type" "set_attr" 
// "set_unit_prefix" "set_signal_prefix" "set_signal_prefix_local" "set_depth" 
// "set_attributes" "set_width" "set_dim_width" "set_bitrange" "set_dim_bitrange" 
// "set_range" "set_dim_range" "set_offset" "set_dim_offset" "set_number_of_dimensions" 
// "set_instance_alteration_bit" "set_testbench_verilog_filename" "set_name" 
// "set_direction" "set_mem_instance_name" "set_vc_output_filename" "set_radix" 
// "set_mnemonic" "set_physical_implementation" "set_unit_id" "set_value" 
// "set_enum" "set_enum_item" "set_field" "set_position" "set_next" "set_previous" 
// "set_field_position" "set_top_unit" "set_address_increment" "set_next_address" 
// "set_access_rights" "set_access_rights_enum" "set_data_word_width" "set_alignment" 
// "set_endianess" "set_prefix" "set_unit_name" "set_suffix" "set_symbol_max_length" 
// "set_vc_start_generation_trigger" "set_vc_max_number_of_mismatches" 
// "set_vc_max_number_of_valid_transactions" "set_vc_valid_output_transaction" 
// "set_vc_compare_trigger" "set_vc_max_cycles" "set_vc_name" "set_vc_header_comment" 
// "set_version" "set_vc_clock" "set_vc_reset" "set_vc_stall" "set_vc_end_generation_trigger" 
// "set_vc_capture_edge_type" "set_reset_name" "set_clock_name" "set_rd_clock_name" 
// "set_wr_clock_name" "set_push_name" "set_pop_name" "set_full_name" "set_empty_name" 
// "set_wr_data_name" "set_rd_data_name" "set_valid_name" "set_wr_addr_name" 
// "set_rd_addr_name" "set_wr_en_name" "set_rd_en_name" "set_num_rd_ifc" 
// "set_num_wr_ifc" "set_clock" "const" "add_port_list" "reverse" "override_parameter" 
// "create_rtl_module" "directive" "add_logic" "merge" "exclusion_list" 
// "include_only" "generate_decoder" "add_allowed_range" "add_address_range" 
// "add_reserved_address_range" "add" "auto_gen_memory_map" "add_to_memory_map" 
// "pipestage_naming_convention" "initialize_random_values" "initialize_random" 
// "gen_unique_rtl_modules" "no_prefix" "do_not_gen_rtl" "do_not_gen_cpp" 
// "register_ios" "connect_units" "connect_by_pattern" "connect_by_name" 
// BACKTICK AT COLON COMMA ASSIGN LBRACK RBRACK LCURLY RCURLY LPAREN RPAREN 
// POUND QUESTION SEMI LNOT NOT AND NAND OR NOR XOR XNOR STAR POW DIV MOD 
// EQUAL NOT_EQ NOT_EQ_CASE EQ_CASE LAND TAND LOR LT_ LE GT GE SL SSL SR 
// SSR TRIGGER PPATH FPATH STARP PO_POS PO_NEG SUPERSTAR IDENTIFIER UNSIGNED_NUMBER 
// NZ_UNSIGNED_NUMBER REAL_NUMBER REAL_NUMBER_EXP TICK PSTAR 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslParser::_tokenSet_0(_tokenSet_0_data_,52);
const unsigned long CslParser::_tokenSet_1_data_[] = { 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 4227857920UL, 4159240191UL, 4294901759UL, 59UL, 0UL, 0UL, 0UL, 0UL, 0UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 512UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "get_interface" "get_signal_value" "get_type" "get_attr" "get_unit_prefix" 
// "get_signal_prefix" "get_signal_prefix_local" "get_depth" "get_attributes" 
// "get_input_field" "get_output_field" "get_lock_enable_bit" "get_cnt_dir_signal" 
// "get_width" "get_dim_width" "get_bitrange" "get_dim_bitrange" "get_lower" 
// "get_dim_lower" "get_upper" "get_dim_upper" "get_offset" "get_dim_offset" 
// "get_number_of_dimensions" "get_cell" "get_transaction_timeout_count" 
// "get_simulation_timeout_count" "get_vc_id" "get_vc_max_num_states" "get_name" 
// "get_filename" "get_max_num_vectors" "get_max_error_count" "get_mnemonic" 
// "get_value" "get_enum" "get_enum_item" "get_next_address" "get_lower_bound" 
// "get_upper_bound" "get_data_word_width" "get_alignment" "get_endianess" 
// "get_name_length" "get_prefix" "get_suffix" "get_symbol_length" "get_address_increment" 
// "get_vc_max_number_of_valid_transactions" "get_vc_name" "get_vc_header_comment" 
// "get_vc_clock" "get_vc_reset" "get_vc_stall" "get_vc_compare_trigger" 
// "get_vc_start_generation_trigger" "get_vc_end_generation_trigger" "get_vc_capture_edge_type" 
// "get_vc_max_number_of_capture_events" "get_vc_max_number_of_mismatches" 
// "get_vc_timeout" "get_vc_output_filename" "get_vc_cpp_rd_name" "get_vc_cpp_wr_name" 
// "get_vc_module" "get_output_filename" "get_reset_name" "get_clock_name" 
// "get_rd_clock_name" "get_wr_clock_name" "get_push_name" "get_pop_name" 
// "get_full_name" "get_empty_name" "get_wr_data_name" "get_rd_data_name" 
// "get_valid_name" "get_wr_addr_name" "get_rd_addr_name" "get_wr_en_name" 
// "get_rd_en_name" "get_msb" "get_lsb" "get_radix" IDENTIFIER K_DATA_GENERATION 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslParser::_tokenSet_1(_tokenSet_1_data_,52);


