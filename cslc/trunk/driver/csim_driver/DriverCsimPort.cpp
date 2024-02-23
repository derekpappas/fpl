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


//CsimPort driver

#include "CsimPort.h"

using namespace NSCsimLib;

typedef CsimPort<TUInt>                            CsimPort_TUInt;
typedef boost::shared_ptr<CsimPort_TUInt>          RefCsimPort_TUInt;


class myUnit : public CsimUnit {
  public:
    void execute() {}
    void initialize() {}
    void connect() {}

    myUnit(RefString unitName, RefString instanceName, RefCsimUnit parent) : CsimUnit(unitName) {}
};

typedef boost::shared_ptr<myUnit>               RefMyUnit;


//
void test(RefString& vName, TUInt& vWidth,ECsimPortDir& vDirection, TUInt& vValue) {

  RefString unitName = RefString(new std::string("unit"));

  RefString instanceName = RefString(new std::string("instance"));

  RefMyUnit          unit = RefMyUnit(new myUnit(unitName));

  RefCsimPort_TUInt port = CsimPort<TUInt>::build(vName, vWidth, unit, vDirection);

  ASSERT(port->getWidth() == vWidth, "CSIM Port Driver - width check failed");//check width

  ASSERT(!port->getName()->compare(*vName), "CSIM Port Driver - name check failed");//check name

  ASSERT(port->getDirection() == vDirection, "CSIM Port Driver - direction check failed");//check direction

  ASSERT(!port->hasAllocatedValue(), "Csim Port Driver - port says value is allocated when it is not");

  port->allocateValue();

  ASSERT(port->hasAllocatedValue(), "Csim Port Driver - port says value is not allocated when it is");

  DCERR("This should at least show a hand-written error in debug mode: Trying to set the value of the port with value width > port width :");

  TUInt tempVal = static_cast<TUInt>(floor(pow(static_cast<TLDouble>(2), static_cast<TLDouble>(vWidth))));

  port->setValue(tempVal);

  ASSERT(port->getValue() < tempVal, "CSIM Port Driver - port should only hold values of max width = port width");

  DCERR("Value set!");

  port->setValue(vValue);

  ASSERT(port->getValue() == vValue, "CSIM Port Driver - either value entered has width > width or there is a port value problem");

  RefCsimPort_TUInt port2 = CsimPort<TUInt>::build(RefString(new std::string("port2")), vWidth, unit, vDirection);

  port2->connect(port);

  ASSERT(port2->getValue() == port->getValue(), "CSIM Port Driver - connect doesn't work for port");

  TUInt temp = vValue + 1;

  port2->setValue(temp);

  ASSERT(port2->getValue() == port->getValue(), "CSIM Port Driver - connect doesn't work for port");

}

TInt main(TInt argc, TChar* argv[]) {

  ASSERT(5 == argc, "CSIM Signal Driver - expecting 4 command line arguments: name, width, direction(input/output) and value(unsigned int && bit width <= width)!");

  RefString name = RefString(new std::string(argv[1]));

  TUInt width = atoi(argv[2]);

  ECsimPortDir direction = PORT_DIR_UNDEFINED;

  RefString dirName = RefString(new std::string(argv[3]));

  if (!dirName->compare("input")) { direction = PORT_DIR_INPUT; }
  else if (!dirName->compare("output")) { direction = PORT_DIR_OUTPUT; }
  else { ASSERT(FAIL, "CSIM Port Driver - expecting direction(input/output) as third argument"); }

  TUInt value = atoi(argv[4]);

  test(name, width, direction, value);

  DCERR("Done. No errors.\n");

  return 0;
}
