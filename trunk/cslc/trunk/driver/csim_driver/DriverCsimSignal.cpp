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


//CsimSignal driver

#include "CsimSignal.h"

using namespace NSCsimLib;

typedef CsimSignal<TUInt>                          CsimSignal_TUInt;
typedef boost::shared_ptr<CsimSignal_TUInt>        RefCsimSignal_TUInt;


class myUnit : public CsimUnit {
  public:
    void execute() {}
    void initialize() {}
    void connect() {}

    // TODO: FIXME DEP - 2010-01-15     myUnit(RefString unitName, RefString instanceName, RefCsimUnit parent) : CsimUnit(unitName, instanceName, parent) {}
    myUnit(RefString unitName, RefString instanceName, RefCsimUnit parent) : CsimUnit(unitName) {}
};

typedef boost::shared_ptr<myUnit>       RefMyUnit;


void test(RefString& vName, TUInt& vWidth, TUInt& vValue) {

  RefString unitName = RefString(new std::string("unit"));

  RefString instanceName = RefString(new std::string("instance"));

  // TODO: FIXME DEP - 2010-01-15       RefMyUnit          unit = RefMyUnit(new myUnit(unitName, instanceName, RefCsimUnit()));
  RefMyUnit          unit = RefMyUnit(new myUnit(unitName));

  RefCsimSignal_TUInt signal = CsimSignal<TUInt>::build(vName, vWidth, unit);

  ASSERT(signal->getWidth() == vWidth, "CSIM Signal Driver - width check failed");//check width

  ASSERT(!signal->getName()->compare(*vName), "CSIM Signal Driver - name check failed");//check name

  ASSERT(!signal->hasAllocatedValue(), "Csim Signal Driver - signal says value is allocated when it is not");

  signal->allocateValue();

  ASSERT(signal->hasAllocatedValue(), "Csim Signal Driver - signal says value is not allocated when it is");

  DCERR("This should at least show a hand-written error in debug mode: Trying to set the value of the signal with value width > signal width :");

  TUInt tempVal = static_cast<TUInt>(floor(pow(static_cast<TLDouble>(2), static_cast<TLDouble>(vWidth))));

  signal->setValue(tempVal);

  ASSERT(signal->getValue() < tempVal, "CSIM Signal Driver - signal should only hold values of max width = signal width");

  DCERR("Value set!");

  signal->setValue(vValue);

  ASSERT(signal->getValue() == vValue, "CSIM Signal Driver - either value entered has width > width or signal value problem");

  RefCsimSignal_TUInt signal2 = CsimSignal<TUInt>::build(RefString(new std::string("signal2")), vWidth, unit);

  RefCsimSignal_TUInt signal3 = CsimSignal<TUInt>::build(RefString(new std::string("signal3")), vWidth, unit);

  signal2->connect(signal);
  signal3->connect(signal2);

  ASSERT(signal->getValue() == signal3->getValue() && signal3->getValue() == signal2->getValue(), "Csim Signal Driver - something doesn't work in signal value holding");

  TUInt temp = vValue + 1;

  signal2->setValue(temp);

  ASSERT(signal->getValue() == signal3->getValue() && signal3->getValue() == signal2->getValue(), "Csim Signal Driver - something doesn't work in signal value holding");

  RefCsimSignal_TUInt signal4 = CsimSignal<TUInt>::build(RefString(new std::string("signal4")), vWidth, unit);

  signal4->allocateValue();

  signal4->copyValue(signal);

  ASSERT(signal->getValue() == signal4->getValue(), "Csim Signal Driver - copyValue() failed");

  TUInt temp2 = signal4->getValue();

  temp = temp - 1;

  signal->setValue(temp);

  ASSERT(signal->getValue() != signal4->getValue() && signal4->getValue() == temp2, "Csim Signal Driver - copyValue() doesn't do it's job");
}

TInt main(TInt argc, TChar* argv[]) {

  ASSERT(4 == argc, "CSIM Signal Driver - expecting 3 command line arguments: name, width and value(unsigned int && bit width <= width)!");

  RefString name = RefString(new std::string(argv[1]));

  TUInt width = atoi(argv[2]);

  TUInt value = atoi(argv[3]);

  test(name, width, value);

  DCERR("Done. No errors.\n");

  return 0;
}
