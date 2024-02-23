//----------------------------------------------------------------------
// Copyright (c) 2005, 2006 Fastpathlogic
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

#ifndef INC_GUARD_Base_h
#define INC_GUARD_Base_h

#include <string>
#include <exception>

namespace NSBase {

//********************************************************************************
// Exception classes
//********************************************************************************
class Exception : public std::exception {
private:
  std::string m_msg;
  unsigned long m_lineNumber;
public:
  Exception(const char* msg, unsigned long lineNumber) throw() : m_msg(msg ? msg : "Unknown exception"), 
                                                                 m_lineNumber(lineNumber) {}
    ~Exception() throw() {}
  const char* what() const throw() { return m_msg.c_str(); }
  const unsigned long getLineNumber() const throw() { return m_lineNumber; }
};

class IllegalArgumentException : public Exception {
public:
  IllegalArgumentException(const char* msg = 0, unsigned long lineNumber = 0) throw() : Exception(msg, lineNumber) {}
    ~IllegalArgumentException() throw() {}
};

class IllegalStateException : public Exception {
public:
  IllegalStateException(const char* msg = 0, unsigned long lineNumber = 0) throw() : Exception(msg, lineNumber) {}
    ~IllegalStateException() throw() {}
};

class UnsupportedOperationException : public Exception {
public:
  UnsupportedOperationException(const char* msg = 0, unsigned long lineNumber = 0) throw() : Exception(msg, lineNumber) {}
    ~UnsupportedOperationException() throw() {}
};

class NoSuchElementException : public Exception {
public:
  NoSuchElementException(const char* msg = 0, unsigned long lineNumber = 0) throw() : Exception(msg, lineNumber) {}
    ~NoSuchElementException() throw() {}
};

class ConcurrentModificationException : public Exception {
public:
  ConcurrentModificationException(const char* msg = 0, unsigned long lineNumber = 0) throw() : Exception(msg, lineNumber) {}
    ~ConcurrentModificationException() throw() {}
};

class NotImplementedException : public Exception {
public:
  NotImplementedException(const char* msg = 0, unsigned long lineNumber = 0) throw() : Exception(msg, lineNumber) {}
    ~NotImplementedException() throw() {}
};




} // end namespace NSBase

#endif /*INC_GUARD_Base_h*/
