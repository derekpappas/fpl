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


//CsimFlipFlop driver

#include "CsimFlipFlop.h"
#include "CsimPort.h"


using namespace NSCsimLib;


typedef CsimPort<TUInt>                              CsimPort_TUInt;
typedef boost::shared_ptr<CsimPort_TUInt>            RefCsimPort_TUInt;

typedef CsimFlipFlop<TUInt>                          CsimFlipFlop_TUInt;
typedef boost::shared_ptr<CsimFlipFlop_TUInt>        RefCsimFlipFlop_TUInt;

//
//class myUnit : public CsimUnit {
//  public:
//    void execute() {}
//    void initialize() {}
//    void connect() {}
//
//#    myUnit(RefString unitName, RefString instanceName, RefCsimUnit parent) : CsimUnit(unitName, instanceName, parent) {}
//    myUnit(RefString unitName, RefString instanceName, RefCsimUnit parent) : CsimUnit(unitName) {}
//};
//
//typedef boost::shared_ptr<myUnit>               RefMyUnit;
//
//
//void test(RefString& vName) {
//
//  RefString unitName = RefString(new std::string("unit"));
//
//  RefString instanceName = RefString(new std::string("instance"));
//
//  RefMyUnit          unit = RefMyUnit(new myUnit(unitName, instanceName, RefCsimUnit()));
//
//  TUInt period = 5;
//
//  RefString clockName = RefString(new std::string("clock"));
//
//  RefCsimClock clock = CsimClock::build(period, clockName);//if not setting offset for clock then posedge should be at pos 0
//
//  RefCsimFlipFlop_TUInt flipFlop = CsimFlipFlop_TUInt::build(clock, vName);//
//
//  ASSERT(!vName->compare(*(flipFlop->getName())), "CSIM - FlipFlop - name check failed" );
//
//  ASSERT(!clockName->compare(*(flipFlop->getClock()->getName())) && flipFlop->getClock()->getPeriod() == period,
//         "CSIM - FlipFlop - clock check failed");
//
//  TUInt width = 10;
//
//  flipFlop->m_d = CsimPort_TUInt::build(RefString(new std::string("D")), width, unit, PORT_DIR_OUTPUT);
//
//  flipFlop->m_q = CsimPort_TUInt::build(RefString(new std::string("Q")), width, unit, PORT_DIR_INPUT);
//
//  flipFlop->m_d->allocateValue();//allocate the value of d
//
//  flipFlop->m_q->allocateValue();//allocate the value of q
//
//  flipFlop->m_d->setValue(1);
//
//  flipFlop->m_q->setValue(0);
//
//  flipFlop->propagateValue();//because no offset was set for clock the clock should be on posEdge so d should be copied to q
//
//  ASSERT(flipFlop->m_d->getValue() == flipFlop->m_q->getValue(), "CSIM FlipFlop Driver - either clock posEdge is not on pos 0 or propagateValue() does not work");
//
//  flipFlop->m_d->setValue(0);
//
//  clock->next();//the clock should no lenger be on posEdge
//
//  flipFlop->propagateValue();//d shouldn't be copied to q
//
//  ASSERT(flipFlop->m_d->getValue() != flipFlop->m_q->getValue() && flipFlop->m_q->getValue() == 1, "CSIM FlipFlip Driver - propagateValue() failed");
//
//}
//
//TInt main(TInt argc, TChar* argv[]) {
//
//  ASSERT(2 == argc, "CSIM Flip Flop  Driver - expecting 1 command line argument: name!");
//
//  RefString name = RefString(new std::string(argv[1]));
//
//  test(name);
//
//  DCERR("Done. No errors.\n");
//
//  return 0;
//}


//END OF FILE
