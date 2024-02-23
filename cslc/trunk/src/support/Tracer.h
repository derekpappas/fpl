//---------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpath Logic, Inc.
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpath Logic, Inc.;
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


/**
 * Author: EugenC
 */

//#define _RELEASE

#ifndef __INC_GUARD_TRACER

#define __INC_GUARD_TRACER

//#ifndef _RELEASE

extern bool __traceOnFlagOption;

//#if __traceOnFlagOption==true

#include <iostream>

template <unsigned int order>
class CTracer {
  private:
    static unsigned int depth;
    std::string m_funcName;

    void printDepth() {
        for(unsigned int i = 0; i < depth; ++i)
          std::cerr << ' ';
    }

  public:
    CTracer(std::string funcName) : m_funcName(funcName) {
      if (__traceOnFlagOption){
        printDepth();
        std::cerr << "> " << m_funcName << std::endl;
        ++depth;
      }
    }
    
    ~CTracer() {
      if (__traceOnFlagOption) {
        --depth;
        printDepth();
        std::cerr << "< " << m_funcName << std::endl;
      }
    }
};

template <unsigned int order>
unsigned int CTracer<order>::depth = 0;

//Visitor Traverce order = 11

#define TRACE_ME(order, _funcName_) \
  CTracer<order> __trace_me(_funcName_);

//#else

//#define TRACE_ME(order, _funcName_)

//#endif

#endif // __INC_GUARD_TRACER
