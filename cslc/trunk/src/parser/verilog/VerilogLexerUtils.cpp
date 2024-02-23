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
 *   Part of the Verilog parser
 *   Author: David Mishelashvili <dm@internet.ge>
 *   2005
 */

#include "../../support/Base.hpp"
#include "VerilogTokenTypes.hpp"
#include "VerilogLexerUtils.hpp"

TFileNameId FileNameCollection::getFileNameId(const string& fileName)
    {
    TInt i;
    
    for (i = 0; i < count(); i++)
        if (m_fileNames[i] == fileName)
            return i;
    
    m_fileNames.push_back(fileName);
    
    return count() - 1;
    }

string FileNameCollection::fileNameById(TFileNameId id) const
    {
    if (id == NO_FILE)
        return "NO_FILE";

    if (id < 0 || id >= count())
        return "NOT_FOUND";

    return m_fileNames[id];
    }

TInt FileNameCollection::count() const
    {
    return m_fileNames.size();
    }

const TChar* tokenName(TInt t)
    {
    switch (t)
        {
        case VerilogTokenTypes::K_ALWAYS:
        case VerilogTokenTypes::K_AND:
        case VerilogTokenTypes::K_ASSIGN:
        case VerilogTokenTypes::K_BEGIN:
        case VerilogTokenTypes::K_BUF:
        case VerilogTokenTypes::K_BUFIF0:
        case VerilogTokenTypes::K_BUFIF1:
        case VerilogTokenTypes::K_CASE:
        case VerilogTokenTypes::K_CASEX:
        case VerilogTokenTypes::K_CASEZ:
        case VerilogTokenTypes::K_CMOS:
        case VerilogTokenTypes::K_DEASSIGN:
        case VerilogTokenTypes::K_DEFAULT:
        case VerilogTokenTypes::K_DEFPARAM:
        case VerilogTokenTypes::K_DISABLE:
        case VerilogTokenTypes::K_EDGE:
        case VerilogTokenTypes::K_ELSE:
        case VerilogTokenTypes::K_END:
        case VerilogTokenTypes::K_ENDCASE:
        case VerilogTokenTypes::K_ENDFUNCTION:
        case VerilogTokenTypes::K_ENDMODULE:
        case VerilogTokenTypes::K_ENDPRIMITIVE:
        case VerilogTokenTypes::K_ENDSPECIFY:
        case VerilogTokenTypes::K_ENDTABLE:
        case VerilogTokenTypes::K_ENDTASK:
        case VerilogTokenTypes::K_EVENT:
        case VerilogTokenTypes::K_FOR:
        case VerilogTokenTypes::K_FORCE:
        case VerilogTokenTypes::K_FOREVER:
        case VerilogTokenTypes::K_FORK:
        case VerilogTokenTypes::K_FUNCTION:
        case VerilogTokenTypes::K_HIGHZ0:
        case VerilogTokenTypes::K_HIGHZ1:
        case VerilogTokenTypes::K_IF:
        case VerilogTokenTypes::K_INITIAL:
        case VerilogTokenTypes::K_INOUT:
        case VerilogTokenTypes::K_INPUT:
        case VerilogTokenTypes::K_INTEGER:
        case VerilogTokenTypes::K_JOIN:
        case VerilogTokenTypes::K_LARGE:
        case VerilogTokenTypes::K_LOCALPARAM:
        case VerilogTokenTypes::K_MACROMODULE:
        case VerilogTokenTypes::K_MEDIUM:
        case VerilogTokenTypes::K_MODULE:
        case VerilogTokenTypes::K_NAND:
        case VerilogTokenTypes::K_NEGEDGE:
        case VerilogTokenTypes::K_NMOS:
        case VerilogTokenTypes::K_NOR:
        case VerilogTokenTypes::K_NOT:
        case VerilogTokenTypes::K_NOTIF0:
        case VerilogTokenTypes::K_NOTIF1:
        case VerilogTokenTypes::K_OR:
        case VerilogTokenTypes::K_OUTPUT:
        case VerilogTokenTypes::K_PARAMETER:
        case VerilogTokenTypes::K_PMOS:
        case VerilogTokenTypes::K_POSEDGE:
        case VerilogTokenTypes::K_PRIMITIVE:
        case VerilogTokenTypes::K_PULL0:
        case VerilogTokenTypes::K_PULL1:
        case VerilogTokenTypes::K_PULLDOWN:
        case VerilogTokenTypes::K_PULLUP:
        case VerilogTokenTypes::K_RCMOS:
        case VerilogTokenTypes::K_REAL:
        case VerilogTokenTypes::K_REALTIME:
        case VerilogTokenTypes::K_REG:
        case VerilogTokenTypes::K_RELEASE:
        case VerilogTokenTypes::K_REPEAT:
        case VerilogTokenTypes::K_RNMOS:
        case VerilogTokenTypes::K_RPMOS:
        case VerilogTokenTypes::K_RTRAN:
        case VerilogTokenTypes::K_RTRANIF0:
        case VerilogTokenTypes::K_RTRANIF1:
        case VerilogTokenTypes::K_SCALARED:
        case VerilogTokenTypes::K_SIGNED:
        case VerilogTokenTypes::K_SMALL:
        case VerilogTokenTypes::K_SPECIFY:
        case VerilogTokenTypes::K_SPECPARAM:
        case VerilogTokenTypes::K_STRONG0:
        case VerilogTokenTypes::K_STRONG1:
        case VerilogTokenTypes::K_SUPPLY0:
        case VerilogTokenTypes::K_SUPPLY1:
        case VerilogTokenTypes::K_TABLE:
        case VerilogTokenTypes::K_TASK:
        case VerilogTokenTypes::K_TIME:
        case VerilogTokenTypes::K_TRAN:
        case VerilogTokenTypes::K_TRANIF0:
        case VerilogTokenTypes::K_TRANIF1:
        case VerilogTokenTypes::K_TRI:
        case VerilogTokenTypes::K_TRI0:
        case VerilogTokenTypes::K_TRI1:
        case VerilogTokenTypes::K_TRIAND:
        case VerilogTokenTypes::K_TRIOR:
        case VerilogTokenTypes::K_TRIREG:
        case VerilogTokenTypes::K_VECTORED:
        case VerilogTokenTypes::K_WAIT:
        case VerilogTokenTypes::K_WAND:
        case VerilogTokenTypes::K_WEAK0:
        case VerilogTokenTypes::K_WEAK1:
        case VerilogTokenTypes::K_WHILE:
        case VerilogTokenTypes::K_WIRE:
        case VerilogTokenTypes::K_WOR:
        case VerilogTokenTypes::K_XNOR:
        case VerilogTokenTypes::K_XOR:
            return "KEYWORD";

        case VerilogTokenTypes::K_S_SETUP:
        case VerilogTokenTypes::K_S_HOLD:
        case VerilogTokenTypes::K_S_SETUPHOLD:
        case VerilogTokenTypes::K_S_RECOVERY:
        case VerilogTokenTypes::K_S_REMOVAL:
        case VerilogTokenTypes::K_S_RECREM:
        case VerilogTokenTypes::K_S_SKEW:
        case VerilogTokenTypes::K_S_TIMESKEW:
        case VerilogTokenTypes::K_S_FULLSKEW:
        case VerilogTokenTypes::K_S_PERIOD:
        case VerilogTokenTypes::K_S_WIDTH:
        case VerilogTokenTypes::K_S_NOCHANGE:
        case VerilogTokenTypes::K_S_ATTRIBUTE:
            return "SYSTEM_TASK_KW";

        case VerilogTokenTypes::UNSIGNED_NUMBER:
            return "UNSIGNED_NUMBER";
        case VerilogTokenTypes::REAL_NUMBER:
            return "REAL_NUMBER";
        case VerilogTokenTypes::BASED_NUMBER:
            return "BASED_NUMBER";

        case VerilogTokenTypes::PSTAR: return "PSTAR";
        case VerilogTokenTypes::AT: return "AT";
        case VerilogTokenTypes::COLON: return "COLON";
        case VerilogTokenTypes::COMMA: return "COMMA";
        case VerilogTokenTypes::DOT: return "DOT";
        case VerilogTokenTypes::ASSIGN: return "ASSIGN";
        case VerilogTokenTypes::MINUS: return "MINUS";
        case VerilogTokenTypes::LBRACK: return "LBRACK";
        case VerilogTokenTypes::RBRACK: return "RBRACK";
        case VerilogTokenTypes::LCRULY: return "LCRULY";
        case VerilogTokenTypes::RCRULY: return "RCRULY";
        case VerilogTokenTypes::LPAREN: return "LPAREN";
        case VerilogTokenTypes::RPAREN: return "RPAREN";
        case VerilogTokenTypes::POUND: return "POUND";
        case VerilogTokenTypes::QUESTION: return "QUESTION";
        case VerilogTokenTypes::SEMI: return "SEMI";
        case VerilogTokenTypes::PLUS: return "PLUS";
        case VerilogTokenTypes::LNOT: return "LNOT";
        case VerilogTokenTypes::NOT: return "NOT";
        case VerilogTokenTypes::AND: return "AND";
        case VerilogTokenTypes::NAND: return "NAND";
        case VerilogTokenTypes::OR: return "OR";
        case VerilogTokenTypes::NOR: return "NOR";
        case VerilogTokenTypes::XOR: return "XOR";
        case VerilogTokenTypes::XNOR: return "XNOR";
        case VerilogTokenTypes::STAR: return "STAR";
        case VerilogTokenTypes::DIV: return "DIV";
        case VerilogTokenTypes::MOD: return "MOD";
        case VerilogTokenTypes::EQUAL: return "EQUAL";
        case VerilogTokenTypes::NOT_EQ: return "NOT_EQ";
        case VerilogTokenTypes::NOT_EQ_CASE: return "NOT_EQ_CASE";
        case VerilogTokenTypes::EQ_CASE: return "EQ_CASE";
        case VerilogTokenTypes::LAND: return "LAND";
        case VerilogTokenTypes::TAND: return "TAND";
        case VerilogTokenTypes::LOR: return "LOR";
        case VerilogTokenTypes::LT_: return "LT_";
        case VerilogTokenTypes::LE: return "LE";
        case VerilogTokenTypes::GT: return "GT";
        case VerilogTokenTypes::GE: return "GE";
        case VerilogTokenTypes::SL: return "SL";
        case VerilogTokenTypes::SR: return "SR";
        case VerilogTokenTypes::SSR: return "SSR";
        case VerilogTokenTypes::TRIGGER: return "TRIGGER";
        case VerilogTokenTypes::PPATH: return "PPATH";
        case VerilogTokenTypes::FPATH: return "FPATH";
        case VerilogTokenTypes::STARP: return "STARP";
        case VerilogTokenTypes::PO_POS: return "PO_POS";
        case VerilogTokenTypes::PO_NEG: return "PO_NEG";

        case VerilogTokenTypes::IDENTIFIER:
            return "IDENTIFIER";
        case VerilogTokenTypes::ESCAPED_IDENTIFIER:
            return "ESCAPED_IDENTIFIER";
        case VerilogTokenTypes::STRING:
            return "STRING";
        case VerilogTokenTypes::SYSTEM_TASK_NAME:
            return "SYSTEM_TASK_NAME";
        case VerilogTokenTypes::DIRECTIVE:
            return "DIRECTIVE";

	case VerilogTokenTypes::PATHPULSE:
            return "PATHPULSE$";

	// UDP Tokens
	case VerilogTokenTypes::UDP_Q0:
            return "UDP_Q0";
	case VerilogTokenTypes::UDP_Q1:
            return "UDP_Q1";
	case VerilogTokenTypes::UDP_QX:
            return "UDP_QX";
	case VerilogTokenTypes::UDP_QQ:
            return "UDP_QQ";
	case VerilogTokenTypes::UDP_01:
            return "UDP_01";
	case VerilogTokenTypes::UDP_0X:
            return "UDP_0X";
	case VerilogTokenTypes::UDP_0Q:
            return "UDP_0Q";
        case VerilogTokenTypes::UDP_10:
            return "UDP_10";
	case VerilogTokenTypes::UDP_1X:
            return "UDP_1X";
	case VerilogTokenTypes::UDP_1Q:
            return "UDP_1Q";
	case VerilogTokenTypes::UDP_BX:
            return "UDP_BX";
	case VerilogTokenTypes::UDP_X0:
            return "UDP_X0";
	case VerilogTokenTypes::UDP_X1:
            return "UDP_X1";
	case VerilogTokenTypes::UDP_XQ:
            return "UDP_XQ";
	case VerilogTokenTypes::UDP_B:
            return "UDP_B";
	case VerilogTokenTypes::UDP_F:
            return "UDP_F";
	case VerilogTokenTypes::UDP_R:
            return "UDP_R";
	case VerilogTokenTypes::UDP_X:
            return "UDP_X";
	case VerilogTokenTypes::UDP_N:
            return "UDP_N";
	case VerilogTokenTypes::UDP_P:
            return "UDP_P";
	case VerilogTokenTypes::UDP_0:
            return "UDP_0";
	case VerilogTokenTypes::UDP_1:
            return "UDP_1";
        }

    //throw BaseException("ERROR->UNKNOWN_TOKEN");
    return "ERROR->UNKNOWN_TOKEN";
    }

// End of File
