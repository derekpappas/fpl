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
#include <iostream>
#include <iomanip>
#include <fstream>
#include "Base.hpp"
#include "VerilogToken.hpp"
#include "VerilogLexer.hpp"

ANTLR_USING_NAMESPACE(std);
ANTLR_USING_NAMESPACE(antlr);

int main(int argc, char *argv[])
    {
    const TInt COLUMN_WIDTH = 16;
    
    try
        {
        if (argc < 2)
            {
            cerr << "File name not specified" << endl;
            return -1;
            }
        
        const char *fileName = argv[1];

        ifstream input(fileName);

	VerilogLexer lexer(input);
	lexer.initialize();
	lexer.setFilename(fileName);
        lexer.setTokenObjectFactory(&VerilogToken::factory);
        
        //cout << setw(8) << "Token ID"
        //     << setw(8) << "Line"
        //     << setw(8) << "Column"
        //     << "    " << "Text"
        //     << endl;
        
        cout.flags(ios::left);
        
        RefToken rt;
        while ((rt = lexer.nextToken())->getType() != Token::EOF_TYPE)
            {
            VerilogToken *tk = static_cast<VerilogToken*>(rt.get());

            switch (tk->getType())
                {
                case VerilogTokenTypes::STRING:
                    {
                    string s = '"' + escapeStr(tk->getText()) + '"';
                    cout << setw(COLUMN_WIDTH) << s;
                    break;
                    }
                case VerilogTokenTypes::ESCAPED_IDENTIFIER:
                    cout << '\\' << setw(COLUMN_WIDTH - 1) << tk->getText();
                    break;
                case VerilogTokenTypes::SYSTEM_TASK_NAME:
                    cout << setw(COLUMN_WIDTH) << tk->getText();
                    break;
                case VerilogTokenTypes::DIRECTIVE:
                    cout << '`' << setw(COLUMN_WIDTH - 1) << tk->getText();
                    break;
                default:
                    cout << setw(COLUMN_WIDTH) << tk->getText();
                    break;
                };

            cout << " // ";
            
            cout << tokenName(tk->getType()) << " ";
            
            if (tk->number().type() != VerilogNumber::NUM_UNDEF)
                {
                cout << tk->number().toString();
                }
            
            cout << " <" << tk->fileName()
                 << "," << tk->getLine()
                 << ":" << tk->getColumn()
                 << ">";
            
            cout << endl;

            //cout << setw(8) << token->getType()
            //     << setw(8) << token->getLine()
            //     << setw(8) << token->getColumn()
            //     << "    " << token->getText() << endl;
            }        
        }
    catch(ANTLRException& e)
        {
        cerr << "Lexer exception: " << e.toString() << endl;
        return -1;
        }
    catch(VerilogLexerException& ve)
        {
        const TLexerState &st = ve.state();
        cerr << "Lexer<" << st.m_filename << ","
             << st.m_line << ","
             << st.m_col <<  ">: " << ve.what() << endl;
        return -1;
        }
    catch(BaseException& be)
        {
        cerr << "Base Exception: " << be.what() << endl;
        return -1;
        }
    catch(exception& e)
        {
        cerr << "exception: " << e.what() << endl;
        return -1;
        }

    return 0;
    }

// End of File
