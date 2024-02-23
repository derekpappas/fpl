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

#ifndef VPARSER_ERROR_CODES_HPP
#define VPARSER_ERROR_CODES_HPP

// Basic error codes
#define VPARSER_PARSING_EXCEPTION  -1
#define VPARSER_LEXER_EXCEPTION    -2
#define VPARSER_BASE_EXCEPTION     -3
#define VPARSER_SYSTEM_EXCEPTION   -4

// Helper macros
#define VPARSER_BASE (-32)
#define VPARSER_STEP(s) (-1 * s)

// Additional error codes, starting down from -32
#define VPARSER_BAD_ARGS       (VPARSER_BASE + VPARSER_STEP(0))
#define VPARSER_NO_INPUT_FILES (VPARSER_BASE + VPARSER_STEP(1))
#define VPARSER_BATCH_FILE_OPEN_FAILURE (VPARSER_BASE + VPARSER_STEP(2))
#define VPARSER_INPUT_FILE_OPEN_FAILURE (VPARSER_BASE + VPARSER_STEP(3))

#endif

// End of File
