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


/*
 * Copyright 1999-2001,2004 The Apache Software Foundation.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// ---------------------------------------------------------------------------
//  Includes
// ---------------------------------------------------------------------------
#include <iostream>
#include <xercesc/util/XMLUniDefs.hpp>
#include <xercesc/sax/AttributeList.hpp>
#include "WESAXHandlers.h"
#include "warn_err.h"

using namespace std;

// ---------------------------------------------------------------------------
//  WESAXHandlers: Constructors and Destructor
// ---------------------------------------------------------------------------
WESAXHandlers::WESAXHandlers( const   char* const              encodingName
                                    , const XMLFormatter::UnRepFlags unRepFlags) :

  fFormatter
(
 encodingName
 , 0
 , this
 , XMLFormatter::NoEscapes
 , unRepFlags
 )
{
  encounteredErrors = false;
}

WESAXHandlers::~WESAXHandlers()
{
}


// ---------------------------------------------------------------------------
//  WESAXHandlers: Overrides of the output formatter target interface
// ---------------------------------------------------------------------------
void WESAXHandlers::writeChars(const XMLByte* const /* toWrite */)
{
}

// ---------------------------------------------------------------------------
//  WESAXHandlers: Overrides of the SAX ErrorHandler interface
// ---------------------------------------------------------------------------
void WESAXHandlers::error(const SAXParseException& e)
{
  cerr << "\nError at file " << e.getSystemId()
       << ", line " << e.getLineNumber()
       << ", char " << e.getColumnNumber()
       << "\n  Message: " << e.getMessage() << endl;
}

void WESAXHandlers::fatalError(const SAXParseException& e)
{
  cerr << "\nFatal Error at file " << e.getSystemId()
       << ", line " << e.getLineNumber()
       << ", char " << e.getColumnNumber()
       << "\n  Message: " << e.getMessage() << endl;
}

void WESAXHandlers::warning(const SAXParseException& e)
{
  cerr << "\nWarning at file " << e.getSystemId()
       << ", line " << e.getLineNumber()
       << ", char " << e.getColumnNumber()
       << "\n  Message: " << e.getMessage() << endl;
}


// ---------------------------------------------------------------------------
//  WESAXHandlers: Overrides of the SAX DTDHandler interface
// ---------------------------------------------------------------------------
void WESAXHandlers::unparsedEntityDecl(const     XMLCh* const /* name */
                                          , const   XMLCh* const /* publicId */
                                          , const   XMLCh* const /* systemId */
                                          , const   XMLCh* const /* notationName */)
{
  // Not used at this time
}


void WESAXHandlers::notationDecl(const   XMLCh* const /* name */
                                    , const XMLCh* const /* publicId */
                                    , const XMLCh* const /* systemId */)
{
  // Not used at this time
}


// ---------------------------------------------------------------------------
//  WESAXHandlers: Overrides of the SAX DocumentHandler interface
// ---------------------------------------------------------------------------


void WESAXHandlers::endDocument()
{
}

void WESAXHandlers::writeChars(const XMLByte* const toWrite,
                                  const unsigned int count,
                                  XMLFormatter* const /* formatter */)
{
}

void WESAXHandlers::removeUnwantedChars(string& chars) {
  if(!chars.empty()) {
    while((chars.at(chars.length()-1) == '\n') || ((chars.at(chars.length()-1) == ' '))) {
      if(chars.length() == 1)
        chars.clear();
      else
        chars.erase(chars.length()-1);
    }
  }
  if(!chars.empty()) {
    while((chars.at(0) == '\n') || (chars.at(0) == ' ')) {
      if(chars.length() == 1)
        chars.clear();
      else
        chars.erase(0,1);
    }
  }
}


static int line = 0;
NSWarnErr::error* anError;


void WESAXHandlers::characters(const     XMLCh* const    chars
                                  , const   unsigned int    length)
{
}

void WESAXHandlers::endElement(const XMLCh* const name)
{
  if(string(XMLString::transcode(name)) == string("ROW")) {
    vectorOfErrors.push_back(*anError);
  }
}


void WESAXHandlers::ignorableWhitespace( const   XMLCh* const chars
                                            ,const  unsigned int length)
{
}


void WESAXHandlers::processingInstruction(const  XMLCh* const target
                                             , const XMLCh* const data)
{
}


void WESAXHandlers::startDocument()
{
}

bool inline getVersion(AttributeList&  attributes, const int i) {//returns the version where the warn/err could appear (v1995, v2001, sys_ver, csl)
  return (string(XMLString::transcode(attributes.getValue(i)))).find(string("x")) != string::npos;
}

bool inline checkAttributeName(AttributeList&  attributes, const int i, string str) {
  return string(XMLString::transcode(attributes.getName(i))) == str;
}

std::string inline getAttributeValue(AttributeList&  attributes, const int i) {
  return string(XMLString::transcode(attributes.getValue(i)));
}

bool inline empty(AttributeList&  attributes, const int i) {
  return string(XMLString::transcode(attributes.getValue(i))).empty();
}

int inline WESAXHandlers::checkAttributeValue(AttributeList&  attributes, const int i, const int type) {
  if(empty(attributes, i))
    return 1;
  std::map<std::string, int>::const_iterator itCat;
  if(type == 1) {
    itCat = categories.find(string(XMLString::transcode(attributes.getValue(i))));
    if(itCat == categories.end())
      return 2;
  }
  else if(type == 2) {
    itCat = phases.find(string(XMLString::transcode(attributes.getValue(i))));
    if(itCat == phases.end())
      return 3;
  }
  else if(type == 3) {
    itCat = types.find(string(XMLString::transcode(attributes.getValue(i))));
    if(itCat == types.end())
      return 4;
  }
  else if(type == 4) {
    if((string(XMLString::transcode(attributes.getValue(i))).compare(string("e")) != 0) &&\
       (string(XMLString::transcode(attributes.getValue(i))).compare(string("w")) != 0) &&\
       (string(XMLString::transcode(attributes.getValue(i))).compare(string("we")) != 0) &&\
       (string(XMLString::transcode(attributes.getValue(i))).compare(string("ew")) != 0)) {
      return 5;
    }
  }
  return 0;
}

void WESAXHandlers::startElement(const   XMLCh* const    name
                                    ,       AttributeList&  attributes)
{
  try {
    static int countCat = 0, countPh = 0, countTy = 0, namesCount = 0;
    if(string(XMLString::transcode(name)) == string("ROW")) {
      ++line;
      anError = new NSWarnErr::error;
      unsigned int len = attributes.getLength();
      int noValueError = 0;
      int illegalValueError = 0;
      std::string errorMessage;
      std::string errMesg;
      for (unsigned int i = 0; i < len; ++i) {
        if(string(XMLString::transcode(attributes.getName(i))) == string("desc")) {
          if(empty(attributes, i)) {
            anError->description.append(string("No Value yet"));
            errorMessage.append("desc ");
            ++noValueError;
          }
          else {
            anError->description.append(string(XMLString::transcode(attributes.getValue(i))));
          }
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("cat")) {
          std::cout << "";
          int aux = checkAttributeValue(attributes, i, 1);
          if(aux == 1) {
            anError->category.append(string("No Value yet"));
            errorMessage.append("cat ");
            ++noValueError;
            std::cout << "error" << std::endl;
          }
          else if(aux == 2) {
            anError->category.append("Illegal value");
            errMesg.append("cat ");
            ++illegalValueError;
          }
          else {
            anError->category.append(string(XMLString::transcode(attributes.getValue(i))));
          }
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("phase")) {
          int aux = checkAttributeValue(attributes, i, 2);
          if(aux == 1) {
            anError->phase.append(string("No Value yet"));
            errorMessage.append("phase ");
            ++noValueError;
          }
          else if (aux == 3) {
            anError->phase.append("Illegal value");
            errMesg.append("phase ");
            ++illegalValueError;
          }
          else {
            anError->phase.append(string(XMLString::transcode(attributes.getValue(i))));
          }
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("type")) {
          int aux = checkAttributeValue(attributes, i, 3);
          if(aux == 1) {
            anError->type.append(string("No Value yet"));
            errorMessage.append("type ");
            ++noValueError;
          }
          else if(aux == 4) {
            anError->type.append("Illegal value");
            errMesg.append("type ");
            ++illegalValueError;
          }
          else {
            anError->type.append(string(XMLString::transcode(attributes.getValue(i))));
          }
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("name")) {
          if(empty(attributes, i)) {
            anError->name.append(string("No Value yet"));
            errorMessage.append("name ");
            ++noValueError;
          }
          else {
            anError->name.append(string(XMLString::transcode(attributes.getValue(i))));
            if(names.count(string(XMLString::transcode(attributes.getValue(i)))) == 0) { 
              names[string(XMLString::transcode(attributes.getValue(i)))] = ++namesCount;
            }
          }
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("v1995")) {
          if(getVersion(attributes, i))
            anError->v1995 = true;
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("v2001")) {
          if(getVersion(attributes, i))
            anError->v2001 = true;
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("sys_ver")) {
          if(getVersion(attributes, i))
            anError->sys_verilog = true;
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("csl")) {
          if(getVersion(attributes, i))
            anError->csl = true;
        }
        else if(string(XMLString::transcode(attributes.getName(i))) == string("we")) {
          int aux = checkAttributeValue(attributes, i, 4);
          if(aux == 1) {
            anError->we.append(string("No Value yet"));
            errorMessage.append("we ");
            ++noValueError;
          }
          else if(aux == 5) {
            anError->type.append("Illegal value");
            errMesg.append("we ");
            ++illegalValueError;
          }
          else {
            anError->we.append(string(XMLString::transcode(attributes.getValue(i))));
          }
        }
      }
      if(noValueError) { 
        encounteredErrors = true;
        throw NoValueException((string("Missing value for ")+errorMessage+(string)(" attribute(s) at element:")).c_str(), line);
      }
      if(illegalValueError) {
        encounteredErrors = true;
        throw IllegalValueException((string("Illegal value for ")+errMesg+(string)(" attribute(s) at element:")).c_str(), line);
      }
    }
    else if(string(XMLString::transcode(name)) == string("categories")) {
      unsigned int len = attributes.getLength();
      for (unsigned int i = 0; i < len; ++i) {
        if(checkAttributeName(attributes, i, string("cat"))) {
          if(categories.count(string(XMLString::transcode(attributes.getValue(i)))) == 0) { 
              categories[getAttributeValue(attributes, i)] = ++countCat;
          }
        }
      }
    }
    else if(string(XMLString::transcode(name)) == string("phases")) {
      unsigned int len = attributes.getLength();
      for (unsigned int i = 0; i < len; ++i) {
        if(checkAttributeName(attributes, i, string("ph"))) {
          if(phases.count(string(XMLString::transcode(attributes.getValue(i)))) == 0) { 
              phases[getAttributeValue(attributes, i)] = ++countPh;
          }
        }
      }
    }
    else if(string(XMLString::transcode(name)) == string("types")) {
      unsigned int len = attributes.getLength();
      for (unsigned int i = 0; i < len; ++i) {
    
        if(checkAttributeName(attributes, i, string("type"))) {
          if(types.count(string(XMLString::transcode(attributes.getValue(i)))) == 0) { 
              types[getAttributeValue(attributes, i)] = ++countTy;
          }
        }
      }
    }
  }
  catch(NoValueException e) {
    cout << e.errorMessage() << e.getLine() << endl;
  }
  catch(IllegalValueException e) {
    cout << e.errorMessage() << e.getLine() << endl;
  }
}
