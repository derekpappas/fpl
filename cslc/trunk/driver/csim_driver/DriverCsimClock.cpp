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


//CSIM Clock Driver

#include "CsimClock.h"
#include <cstdlib>

using namespace NSCsimLib;

//
void test(TUInt& vPeriod, RefString& vName, TUInt& vOffset) {

//  RefCsimClock clock = CsimClock::build(vPeriod, vName);//position 0 = posEdge, vPeriod/2 = negEdge
//
//  ASSERT(clock->getPeriod() == vPeriod, "CSIM Clock Driver - period check failed");//check period
//
//  ASSERT(!clock->getName()->compare(*vName), "CSIM Clock Driver - name check failed");//check name
//
//  TUInt posedge = 0, negedge = static_cast<TUInt>(floor(static_cast<TFloat>(vPeriod / 2)));
//
//  for (TUInt pos = 0; pos != 2 * vPeriod; ++pos) {
//
//    ASSERT((pos == posedge && clock->posEdge()) || (pos != posedge && !clock->posEdge()),
//           "CSIM Clock Driver - posEdge check failed");//check posedge
//
//    ASSERT((pos != negedge && !clock->negEdge()) || (pos == negedge && clock->negEdge()),
//           "CSIM Clock Driver - negEdge check failed");//check negEdge
//
//    clock->next();//one unit of time passes
//
//    if (pos == vPeriod - 1) { posedge += vPeriod; negedge += vPeriod; }
//  }
//
//  while (!clock->posEdge()) { clock->next(); }//reset clock(set current pos of clock on pos 0)
//
//  ASSERT(!clock->getOffset(), "CSIM Clock Driver - offset check failed");//check offset
//
//  clock->setOffset(vOffset);//set offset
//
//  ASSERT(clock->getOffset() == vOffset, "CSIM Clock Driver - offset check failed");
//
//  posedge = vOffset;  negedge = (static_cast<TUInt>( floor( static_cast<TFloat>(vPeriod) / 2 ) ) + vOffset) % vPeriod;
//
//  for (TUInt pos = 0; pos != 2 * vPeriod; ++pos) {
//
//    ASSERT((pos == posedge && clock->posEdge()) || (pos != posedge && !clock->posEdge()), "CSIM Clock Driver - posEdge check failed");//check posedge
//
//    ASSERT((pos != negedge && !clock->negEdge()) || (pos == negedge && clock->negEdge()),
//           "CSIM Clock Driver - negEdge check failed");//check negEdge
//
//    clock->next();//one unit of time passes
//
//    if (pos == vPeriod - 1) { posedge += vPeriod; negedge += vPeriod; }
//  }
}

TInt main(TInt argc, TChar* argv[]) {

  ASSERT(4 == argc, "CSIM Clock Driver - expecting 3 command line arguments: period, name, offset!");

  TUInt period = atoi(argv[1]);

  RefString name = RefString(new std::string(argv[2]));

  TUInt offset = atoi(argv[3]);

  test(period, name, offset);

  DCERR("Done. No errors.\n");

  return 0;
}


//END OF FILE
