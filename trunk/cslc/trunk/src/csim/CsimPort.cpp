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

#include "CsimPort.h"


namespace NSCsimLib {


template<typename T>
CsimPort<T>::CsimPort(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) : CsimSignal<T>::CsimSignal(name, width, parent), m_dir(dir) {}


template<typename T>
ECsimPortDir CsimPort<T>::getDirection() const {  return m_dir; }


template<typename T>
boost::shared_ptr< CsimPort<T> >   CsimPort<T>::build(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) {
  ASSERT(name.get()                                    , "CSIM - Port - null reference received"  );
  ASSERT(name->size()                                  , "CSIM - Port - string of size 0 received");
  ASSERT(width                                         , "CSIM - Port - width 0 received"         );
  ASSERT(PORT_DIR_UNDEFINED < dir && PORT_DIR_MAX > dir, "CSIM - Port - invalid dir received"     );
  ASSERT(parent.get()                                  , "CSIM - Port - null ref received"        );

  CsimPortT* port;

  try {

    port = new CsimPort(name, width, parent, dir);
  }
  catch(std::exception& e) {
    ASSERT(FAIL, "CSIM - Port - new operator failed");
  }

  RefCsimPortT  refPort = RefCsimPortT(port);
  port->m_weakRef = WeakRefCsimPortT(refPort);
  port->m_value->registerSignal(port->m_weakRef);

  port->allocateValue();

  return refPort;
}


template CsimPort<TBool>::CsimPort(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir);
template CsimPort<TChar>::CsimPort(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir);
template CsimPort<TShort>::CsimPort(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir);
template CsimPort<TInt>::CsimPort(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir);
template CsimPort<TLongLong>::CsimPort(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir);


template ECsimPortDir CsimPort<TBool>::getDirection() const;
template ECsimPortDir CsimPort<TChar>::getDirection() const;
template ECsimPortDir CsimPort<TShort>::getDirection() const;
template ECsimPortDir CsimPort<TInt>::getDirection() const;
template ECsimPortDir CsimPort<TLongLong>::getDirection() const;


template CsimPort<TBool>::RefCsimPortT   CsimPort<TBool>::build(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) ;
template CsimPort<TChar>::RefCsimPortT   CsimPort<TChar>::build(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) ;
template CsimPort<TShort>::RefCsimPortT   CsimPort<TShort>::build(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) ;
template CsimPort<TInt>::RefCsimPortT   CsimPort<TInt>::build(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) ;
template CsimPort<TLongLong>::RefCsimPortT   CsimPort<TLongLong>::build(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) ;


}


//END OF FILE

