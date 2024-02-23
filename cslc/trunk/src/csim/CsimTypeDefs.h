//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007 Fastpath Logic
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

#ifndef INC_GUARD_CSIM_TYPEDEFS_H
#define INC_GUARD_CSIM_TYPEDEFS_H

#include "../support/CommonSupport.h"


namespace NSCsimLib {


typedef boost::shared_ptr<TChar>                   RefTChar;

typedef std::string                                TString;

typedef TString::iterator                          TString_iter;

typedef std::vector<RefString>                     TVec_RefString;

typedef boost::shared_ptr<TVec_RefString>          RefTVec_RefString;

typedef TVec_RefString::iterator                   TVec_RefString_iter;

typedef boost::shared_ptr<std::stringstream>       RefStringstream;

typedef std::vector<TLongLong>                     TVec_TLongLong;

typedef boost::shared_ptr<TVec_TLongLong>          RefTVec_TLongLong;


typedef enum {
  T_UNDEF,
  T_BIN,
  T_HEX,
  T_MAX
} TRadix;


//CsimPort direction enum
typedef enum {
  PORT_DIR_UNDEFINED,
  PORT_DIR_INOUT,
  PORT_DIR_INPUT,
  PORT_DIR_OUTPUT,
  PORT_DIR_MAX
} ECsimPortDir;

//return values for CsimMain
typedef enum {
  MAIN_UNDEFINED,
  MAIN_NO_ERROR,
  //  VECTOR_RADIX_HEX,
  MAIN_MAX
} ECsimMainReturnValue;


//CsimVector type enum
typedef enum {
  VECTOR_TYPE_UNDEFINED,
  VECTOR_TYPE_STIM,
  VECTOR_TYPE_EXPECT,
  VECTOR_TYPE_MAX
} ECsimVectorType;


class CsimClock;
class CsimFlipFlopBase;
template <class T>class CsimFlipFlop;
class CsimSignalBase;
template<class T> class CsimSignal;
template<class T> class CsimPort;
class CsimVectorWriter;
class CsimMemoryBase;
template<class T> class CsimMemory;
class CsimUnit;
class CsimSimulator;
class CsimCmdLine;
class CsimShell;

typedef boost::shared_ptr<CsimClock>                                   RefCsimClock;
typedef boost::weak_ptr<CsimClock>                                     WeakRefCsimClock;
typedef std::vector<RefCsimClock>                                      TVec_RefCsimClock;
typedef boost::shared_ptr<TVec_RefCsimClock>                           RefTVec_RefCsimClock;
typedef TVec_RefCsimClock::iterator                                    TVec_RefCsimClock_iterator;
typedef TVec_RefCsimClock::const_iterator                              TVec_RefCsimClock_const_iterator;

typedef boost::shared_ptr<CsimFlipFlopBase>                            RefCsimFlipFlopBase;
typedef boost::weak_ptr<CsimFlipFlopBase>                              WeakRefCsimFlipFlop;
typedef std::vector<RefCsimFlipFlopBase>                               TVec_RefCsimFlipFlopBase;
typedef boost::shared_ptr<TVec_RefCsimFlipFlopBase>                    RefTVec_RefCsimFlipFlopBase;
typedef TVec_RefCsimFlipFlopBase::iterator                             TVec_RefCsimFlipFlopBase_iterator;
typedef TVec_RefCsimFlipFlopBase::const_iterator                       TVec_RefCsimFlipFlopBase_const_iterator;

typedef boost::shared_ptr<CsimSignalBase>                              RefCsimSignalBase;
typedef boost::weak_ptr<CsimSignalBase>                                WeakRefCsimSignalBase;
typedef std::vector<RefCsimSignalBase>                                 TVec_RefCsimSignalBase;
typedef std::vector<WeakRefCsimSignalBase>                             TVec_WeakRefCsimSignalBase;
typedef boost::shared_ptr<TVec_RefCsimSignalBase>                      RefTVec_RefCsimSignalBase;
typedef boost::shared_ptr<TVec_WeakRefCsimSignalBase>                  RefTVec_WeakRefCsimSignalBase;
typedef TVec_RefCsimSignalBase::const_iterator                         TVec_RefCsimSignalBase_const_iterator;
typedef TVec_RefCsimSignalBase::iterator                               TVec_RefCsimSignalBase_iterator;
typedef TVec_WeakRefCsimSignalBase::const_iterator                     TVec_WeakRefCsimSignalBase_const_iterator;
typedef TVec_WeakRefCsimSignalBase::iterator                           TVec_WeakRefCsimSignalBase_iterator;

typedef boost::shared_ptr<CsimVectorWriter>                            RefCsimVectorWriter;
typedef boost::weak_ptr<CsimVectorWriter>                              WeakRefCsimVectorWriter;
typedef std::vector<RefCsimVectorWriter>                               TVec_RefCsimVectorWriter;
typedef std::vector<WeakRefCsimVectorWriter>                           TVec_WeakRefCsimVectorWriter;
typedef boost::shared_ptr<TVec_RefCsimVectorWriter>                    RefTVec_RefCsimVectorWriter;
typedef boost::shared_ptr<TVec_WeakRefCsimVectorWriter>                RefTVec_WeakRefCsimVectorWriter;
typedef TVec_RefCsimVectorWriter::const_iterator                       TVec_RefCsimVectorWriter_const_iterator;
typedef TVec_RefCsimVectorWriter::iterator                             TVec_RefCsimVectorWriter_iterator;
typedef TVec_WeakRefCsimVectorWriter::const_iterator                   TVec_WeakRefCsimVectorWriter_const_iterator;
typedef TVec_WeakRefCsimVectorWriter::iterator                         TVec_WeakRefCsimVectorWriter_iterator;


typedef boost::shared_ptr<CsimMemoryBase>                            RefCsimMemoryBase;
typedef boost::weak_ptr<CsimMemoryBase>                              WeakRefCsimMemoryBase;
typedef std::vector<RefCsimMemoryBase>                               TVec_RefCsimMemoryBase;
typedef std::vector<WeakRefCsimMemoryBase>                           TVec_WeakRefCsimMemoryBase;
typedef boost::shared_ptr<TVec_RefCsimMemoryBase>                    RefTVec_RefCsimMemoryBase;
typedef boost::shared_ptr<TVec_WeakRefCsimMemoryBase>                RefTVec_WeakRefCsimMemoryBase;
typedef TVec_RefCsimMemoryBase::const_iterator                       TVec_RefCsimMemoryBase_const_iterator;
typedef TVec_RefCsimMemoryBase::iterator                             TVec_RefCsimMemoryBase_iterator;
typedef TVec_WeakRefCsimMemoryBase::const_iterator                   TVec_WeakRefCsimMemoryBase_const_iterator;
typedef TVec_WeakRefCsimMemoryBase::iterator                         TVec_WeakRefCsimMemoryBase_iterator;



typedef boost::shared_ptr<CsimUnit>                                    RefCsimUnit;
typedef boost::weak_ptr<CsimUnit>                                      WeakRefCsimUnit;
typedef std::vector<RefCsimUnit>                                       TVec_RefCsimUnit;
typedef TVec_RefCsimUnit::const_iterator                               TVec_RefCsimUnit_const_iterator;
typedef TVec_RefCsimUnit::iterator                                     TVec_RefCsimUnit_iterator;
typedef boost::shared_ptr<TVec_RefCsimUnit>                            RefTVec_RefCsimUnit;
typedef std::vector<WeakRefCsimUnit>                                   TVec_WeakRefCsimUnit;
typedef TVec_WeakRefCsimUnit::const_iterator                           TVec_WeakRefCsimUnit_const_iterator;
typedef TVec_WeakRefCsimUnit::iterator                                 TVec_WeakRefCsimUnit_iterator;
typedef boost::shared_ptr<TVec_WeakRefCsimUnit>                        RefTVec_WeakRefCsimUnit;

typedef boost::shared_ptr<CsimSimulator>                               RefCsimSimulator; 
typedef boost::weak_ptr<CsimSimulator>                                 WeakRefCsimSimulator;

typedef boost::shared_ptr<CsimCmdLine>                                 RefCsimCmdLine;
typedef boost::weak_ptr<CsimCmdLine>                                   WeakRefCsimCmdLine;

typedef boost::shared_ptr<CsimShell>                                   RefCsimShell;
typedef boost::weak_ptr<CsimShell>                                     WeakRefCsimShell;

//CSIM signal typedef
typedef CsimSignal<TBool>                             CsimSignalTBool;
typedef CsimSignal<TChar>                             CsimSignalTChar;
typedef CsimSignal<TShort>                            CsimSignalTShort;
typedef CsimSignal<TInt>                              CsimSignalTInt;
typedef CsimSignal<TLongLong>                         CsimSignalTLongLong;

typedef boost::shared_ptr<CsimSignalTBool> RefCsimSignalTBool;
typedef boost::shared_ptr<CsimSignalTChar> RefCsimSignalTChar;
typedef boost::shared_ptr<CsimSignalTShort> RefCsimSignalTShort;
typedef boost::shared_ptr<CsimSignalTInt> RefCsimSignalTInt;
typedef boost::shared_ptr<CsimSignalTLongLong> RefCsimSignalTLongLong;

//CSIM port typedefs
typedef CsimPort<TBool>                             CsimPortTBool;
typedef CsimPort<TChar>                             CsimPortTChar;
typedef CsimPort<TShort>                            CsimPortTShort;
typedef CsimPort<TInt>                              CsimPortTInt;
typedef CsimPort<TLongLong>                         CsimPortTLongLong;

typedef boost::shared_ptr<CsimPortTBool>     RefCsimPortTBool;
typedef boost::shared_ptr<CsimPortTChar>     RefCsimPortTChar;
typedef boost::shared_ptr<CsimPortTShort>    RefCsimPortTShort;
typedef boost::shared_ptr<CsimPortTInt>      RefCsimPortTInt;
typedef boost::shared_ptr<CsimPortTLongLong> RefCsimPortTLongLong;

//CSIM ff typedefs
typedef CsimFlipFlop<TBool>                             CsimFlipFlopTBool;
typedef CsimFlipFlop<TChar>                             CsimFlipFlopTChar;
typedef CsimFlipFlop<TShort>                            CsimFlipFlopTShort;
typedef CsimFlipFlop<TInt>                              CsimFlipFlopTInt;
typedef CsimFlipFlop<TLongLong>                         CsimFlipFlopTLongLong;

typedef boost::shared_ptr<CsimFlipFlopTBool>     RefCsimFlipFlopTBool;
typedef boost::shared_ptr<CsimFlipFlopTChar>     RefCsimFlipFlopTChar;
typedef boost::shared_ptr<CsimFlipFlopTShort>    RefCsimFlipFlopTShort;
typedef boost::shared_ptr<CsimFlipFlopTInt>      RefCsimFlipFlopTInt;
typedef boost::shared_ptr<CsimFlipFlopTLongLong> RefCsimFlipFlopTLongLong;

}

#endif //INC_GUARD_CSIM_TYPEDEFS_H


//END OF FILE
