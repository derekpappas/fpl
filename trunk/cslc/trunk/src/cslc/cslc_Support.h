//----------------------------------------------------------------------
// Copyright (c) 2005-2008 Fastpathlogic
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
//Author: Tb

/* CSLOM exception classes:
 * Exception
 *      IllegalArgumentException
 *      IllegalStateException
 *      UnsupportedOperationException
 *      NoSuchElementException
 *      ConcurrentModificationException
 *      NotImplementedException
 */

#ifndef INC_GUARD_cslc_Support_h_
#define INC_GUARD_cslc_Support_h_

#include "cslc_Typedef.h"

// *********************************************************************
// extern variables
// *********************************************************************
/** This is sent by the CSL parser (TRUE if any errors occucred)
 */
extern TBool cslParserHasErrors;

/** This is sent by the CSLOM (TRUE if any errors occucred)
 */
extern TBool cslomHasErrors;

/** This is sent by the Verilog parser (TRUE if any errors occucred)
 */
extern TBool verilogParserHasErrors;

/** This is sent by the CDOM (TRUE if any errors occucred)
 */
extern TBool cdomHasErrors;

/** This is sent by the instance tree (TRUE if any errors occucred)
 */
extern TBool instTreeHasErrors;

/** This is sent by the checker (TRUE if any errors occucred)
 */
extern TBool m_arHasErrors;

/** This is sent by the checker (TRUE if any errors occucred)
 */
extern TBool checkerHasErrors;

/** This is sent by the checker (TRUE if any errors occucred)
 */
extern TBool ccHasErrors;

/** This is sent by CSLOM and represents the name of the top unit in the
 * design (or NULL if the design has no top unit)
 */
extern RefString cslTopUnitName;

/* This is sent by CDOM and represents the concatenation of top units names
 * the design (or NULL if the design has no top unit)
 */
extern RefString cdomTopModuleName;

// used by SystemC Vector Control to turn on/off vector generation
//extern NSCslc::RefMap_RefStr_TVec inst_map;


extern RefString cslomClockName;

#endif //INC_GUARD_cslc_Support_h_
