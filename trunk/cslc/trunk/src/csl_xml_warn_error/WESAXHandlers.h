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
 * Copyright 1999-2000,2004 The Apache Software Foundation.
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
#ifndef _WE_SAX_HANDLERS
#define _WE_SAX_HANDLERS

#include <xercesc/util/PlatformUtils.hpp>
#include <xercesc/util/TransService.hpp>
#include <xercesc/parsers/SAXParser.hpp>
#include <xercesc/util/OutOfMemoryException.hpp>
#include <xercesc/util/XMLUniDefs.hpp>
#include <xercesc/sax/AttributeList.hpp>
#include <xercesc/sax/HandlerBase.hpp>
#include <xercesc/framework/XMLFormatter.hpp>
#include "warn_err.h"

XERCES_CPP_NAMESPACE_USE

class Exception : public std::exception {
private:
  std::string mesg;
  unsigned long lineNumber;
public:
  Exception(const char* m_mesg, unsigned long m_lineNumber) throw() : mesg(m_mesg ? m_mesg : "Unknown error"), lineNumber(m_lineNumber) {
  }
  ~Exception() throw() {
  }
  const std::string errorMessage() const throw() {
    return mesg;
  }
  const int getLine() const throw() {
    return lineNumber;
  }
};

class NoValueException : public Exception {
public:
  NoValueException(const char* mesg = 0, unsigned long lineNumber = 0) throw() : Exception(mesg, lineNumber) {
  }
  ~NoValueException() throw() {
  }
};

class IllegalValueException : public Exception {
public:
  IllegalValueException(const char* mesg = 0, unsigned long lineNumber = 0) throw() : Exception(mesg, lineNumber) {
  }
  ~IllegalValueException() throw() {
  }
};

class WESAXHandlers : public HandlerBase, private XMLFormatTarget
{
public:
    // -----------------------------------------------------------------------
    //  Constructors
    // -----------------------------------------------------------------------
    WESAXHandlers
    (
        const   char* const                 encodingName
        , const XMLFormatter::UnRepFlags    unRepFlags
    );
    ~WESAXHandlers();


    // -----------------------------------------------------------------------
    //  Implementations of the format target interface
    // -----------------------------------------------------------------------
    void writeChars
    (
        const   XMLByte* const  toWrite
    );

    void writeChars
    (
        const   XMLByte* const  toWrite
        , const unsigned int    count
        , XMLFormatter* const   formatter
    );


    // -----------------------------------------------------------------------
    //  Implementations of the SAX DocumentHandler interface
    // -----------------------------------------------------------------------
    void endDocument();

    void endElement(const XMLCh* const name);

    void characters(const XMLCh* const chars, const unsigned int length);

    void ignorableWhitespace
    (
        const   XMLCh* const    chars
        , const unsigned int    length
    );

    void processingInstruction
    (
        const   XMLCh* const    target
        , const XMLCh* const    data
    );

    void startDocument();

    void startElement(const XMLCh* const name, AttributeList& attributes);



    // -----------------------------------------------------------------------
    //  Implementations of the SAX ErrorHandler interface
    // -----------------------------------------------------------------------
    void warning(const SAXParseException& exc);
    void error(const SAXParseException& exc);
    void fatalError(const SAXParseException& exc);



    // -----------------------------------------------------------------------
    //  Implementation of the SAX DTDHandler interface
    // -----------------------------------------------------------------------
    void notationDecl
    (
        const   XMLCh* const    name
        , const XMLCh* const    publicId
        , const XMLCh* const    systemId
    );

    void unparsedEntityDecl
    (
        const   XMLCh* const    name
        , const XMLCh* const    publicId
        , const XMLCh* const    systemId
        , const XMLCh* const    notationName
    );
  int inline checkAttributeValue(AttributeList&  attributes, const int i, const int type);
  std::vector<NSWarnErr::error> vectorOfErrors;
  std::map<std::string, int> categories;
  std::map<std::string, int> phases;
  std::map<std::string, int> types;
  std::map<std::string, int> names;
  bool encounteredErrors;
  void removeUnwantedChars(std::string&);
private :
    // -----------------------------------------------------------------------
    //  Private data members
    //
    //  fFormatter
    //      This is the formatter object that is used to output the data
    //      to the target. It is set up to format to the standard output
    //      stream.
    // -----------------------------------------------------------------------
    XMLFormatter    fFormatter;
};

#endif
