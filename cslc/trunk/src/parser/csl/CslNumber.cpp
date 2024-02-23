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

#include "../../support/Base.hpp"
#include "CslNumber.hpp"

/*
std::string CslNumber::toString() const
    {
    std::string s;
    
    s = "[";
    
    switch (type())
        {
        case NUM_UNDEF:
            {
            s += "undefined";
            break;
            }
        case NUM_INT:
            {
            s += "int: ";
            s += intToStr(intVal());
            break;
            }
        case NUM_REAL:
            {
            s += "real: ";
            s += realToStr(realVal());
            break;
            }
        case NUM_BASED:
            {
            s += "based ";
            switch(base())
                {
                case BASE_BIN:
                    s += "binary:";
                    break;
                case BASE_OCT:
                    s += "octal:";
                    break;
                case BASE_DEC:
                    s += "decimal:";
                    break;
                case BASE_HEX:
                    s += "hex:";
                    break;
                }
            s += "\"" + strVal() + "\"";
            if (sized())
                s += ", size: " + intToStr(size());
            if (isSigned())
                s += ", signed";
            break;
            }
        }
    
    s += "]";

    return s;
    }
*/
// End of File
