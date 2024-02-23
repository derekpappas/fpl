//----------------------------------------------------------------------
// Copyright (c) 2006 Fastpathlogic
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

/*
 *   Part of the Csl parser
 *   Author: David Mishelashvili <dm@internet.ge>
 *   2005
 */

#ifndef CSL_NUMBER_HPP
#define CSL_NUMBER_HPP

#include <string>
#include "Def.hpp"
#include "../../cslom/CSLOM.h"

class CslNumber;
typedef boost::shared_ptr<CslNumber> RefCslNumber;


class CslNumber
    {
    public:
        enum TNumberType { NUM_UNDEF, NUM_INT, NUM_REAL, NUM_BASED };
        enum TNumberBase { BASE_BIN, BASE_OCT, BASE_DEC, BASE_HEX };
        enum TNotSized { NOT_SIZED = 0 };

        // strVal is the original text representation of the number,
	// in example: "4 'b0011"
    private:
        CslNumber(const RefString strVal, TNumberType type, TBool isSigned, 
            TNumberBase base, TUInt size, TBool hasXZ) :
            m_type(type),
            m_base(base),
            m_isSigned(isSigned),
            m_size(size),
            m_strVal(strVal),
            m_hasXZ(hasXZ) { }
    
    public:
        static RefCslNumber build(const RefString strVal, TNumberType type,
            TBool isSigned = FALSE, TNumberBase base = BASE_DEC, TUInt size = NOT_SIZED, TBool hasXZ = true){
          return RefCslNumber( new CslNumber( strVal, type, isSigned, base, size, hasXZ ) );
        }
        TNumberType getType() const { return m_type; }
        TNumberBase getBase() const { return m_base; }
        TBool isSigned() const { return m_isSigned; }
        TBool isSized() const { return m_size != NOT_SIZED; }
        TInt getSize() const { return m_size; }
	void setSize(TInt sz) { m_size = sz; }
        const RefString getStringValue() const { return m_strVal; }
        TBool hasXZ() const { return m_hasXZ; }
    protected:
        TNumberType m_type;
        TNumberBase m_base;
        TBool m_isSigned;
        TUInt m_size;
        RefString m_strVal;
        TBool m_hasXZ;
    };


#endif

// End of File
