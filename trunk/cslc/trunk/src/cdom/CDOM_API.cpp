#include "CDOM_API.h"

namespace NSCdom {
  CDOmModulePortIterator::CDOmModulePortIterator(RefCDOmModuleDecl theModule) {
#ifdef _DEBUG_CDOM_API
    assert(theModule.get());
#endif
    m_portDecls = theModule->getPortDecls();
    if(!m_portDecls.get()) {
      return;
    }
    m_portDeclIter = m_portDecls->begin();
    if(m_portDeclIter == m_portDecls->end()) {
      m_portDecls = RefTVec_RefCDOmPortDecl();
      return;
    }
    m_ports = (*m_portDeclIter)->getIDs();
    if(!m_ports.get() || !m_ports->size()) {
      for( ; m_portDeclIter<m_portDecls->end(); ++m_portDeclIter) {
        m_ports = (*m_portDeclIter)->getIDs();
        if(m_ports.get() && m_ports->size())
          break;
      }
      if(!m_ports.get() || !m_ports->size()) {
        m_portDecls = RefTVec_RefCDOmPortDecl();
        return;
      }
    }
    m_idIter = m_ports->begin();
  }

  void CDOmModulePortIterator::nextPort() {
    if(isEnd())
      return;
    ++m_idIter;
    if( !(m_idIter < m_ports->end()) ) {
      while(++m_portDeclIter < m_portDecls->end()) {
        m_ports = (*m_portDeclIter)->getIDs();
        if(m_ports.get() && m_ports->size()) {
          m_idIter = m_ports->begin();
          return;
        }
      }
      if(!m_ports.get() || !m_ports->size() || !(m_portDeclIter < m_portDecls->end()))
        m_portDecls = RefTVec_RefCDOmPortDecl();
    }
  }

  bool CDOmModulePortIterator::isEnd() const {
    return !m_portDecls.get();
  }

  NSCdom::ECDOmPortType CDOmModulePortIterator::getPortType() const {
    if(!m_portDecls.get())
      throw NSBase::IllegalStateException("[CDOmModulePortIterator::getPortType() const] illegal state for this method call");
    return (*m_portDeclIter)->getPortType();
  }

  NSCdom::ECDOmNetType CDOmModulePortIterator::getNetType() const {
    if(!m_portDecls.get())
      throw NSBase::IllegalStateException("[CDOmModulePortIterator::getNetType() const] illegal state for this method call");
    return (*m_portDeclIter)->getNetType();
  }

  NSCdom::ECDOmVarType CDOmModulePortIterator::getVarType() const {
    if(!m_portDecls.get())
      throw NSBase::IllegalStateException("[CDOmModulePortIterator::getVarType() const] illegal state for this method call");
    return (*m_portDeclIter)->getVarType();
  }

  TBool CDOmModulePortIterator::isSigned() const {
    if(!m_portDecls.get())
      throw NSBase::IllegalStateException("[CDOmModulePortIterator::isSigned() const] illegal state for this method call");
    return (*m_portDeclIter)->isSigned();
  }
  
  NSCdom::RefCDOmRange CDOmModulePortIterator::getRange() const {
    if(!m_portDecls.get())
      throw NSBase::IllegalStateException("[CDOmModulePortIterator::getRange() const] illegal state for this method call");
    return (*m_portDeclIter)->getRange();
  }

  const RefString CDOmModulePortIterator::getPortName() const {
    if(!m_portDecls.get())
      throw NSBase::IllegalStateException("[CDOmModulePortIterator::getPortName() const] illegal state for this method call");
    return (*m_idIter)->getName();
  }
 
}
