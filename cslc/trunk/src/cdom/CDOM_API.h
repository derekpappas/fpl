#include "CDOM.h"

#ifndef INC_GUARD_CDOM_API
#define INC_GUARD_CDOM_API

namespace NSCdom {
  class CDOmModulePortIterator {
    protected:
      TVec_RefCDOmPortDecl_const_iter m_portDeclIter;
      RefTVec_RefCDOmPortDecl m_portDecls;
      TVec_RefCDOmIdentifier_const_iter m_idIter;
      RefTVec_RefCDOmIdentifier m_ports;
    public:
      CDOmModulePortIterator(RefCDOmModuleDecl theModule);
      void nextPort();
      bool isEnd() const;
      ECDOmPortType getPortType() const;
      ECDOmNetType getNetType() const;
      ECDOmVarType getVarType() const;
      TBool isSigned() const;
      NSCdom::RefCDOmRange getRange() const;
      const RefString getPortName() const;
      
  };
}
#endif
