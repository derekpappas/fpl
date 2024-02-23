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

#ifndef CSLPARSER_ERROR_CODES_HPP
#define CSLPARSER_ERROR_CODES_HPP

// Basic error codes
#define CSLPARSER_PARSING_EXCEPTION  -1
#define CSLPARSER_LEXER_EXCEPTION    -2
#define CSLPARSER_BASE_EXCEPTION     -3
#define CSLPARSER_SYSTEM_EXCEPTION   -4

// Helper macros
#define CSLPARSER_BASE (-32)
#define CSLPARSER_STEP(s) (-1 * s)

// Additional error codes, starting down from -32
#define CSLPARSER_BAD_ARGS       (CSLPARSER_BASE + CSLPARSER_STEP(0))
#define CSLPARSER_NO_INPUT_FILES (CSLPARSER_BASE + CSLPARSER_STEP(1))
#define CSLPARSER_BATCH_FILE_OPEN_FAILURE (CSLPARSER_BASE + CSLPARSER_STEP(2))
#define CSLPARSER_INPUT_FILE_OPEN_FAILURE (CSLPARSER_BASE + CSLPARSER_STEP(3))

#endif

// End of File
