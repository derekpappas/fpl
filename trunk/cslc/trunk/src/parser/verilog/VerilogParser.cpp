/* $ANTLR 2.7.7 (20060906): "verilog.parser.g" -> "VerilogParser.cpp"$ */
#include "VerilogParser.hpp"
#include <antlr/NoViableAltException.hpp>
#include <antlr/SemanticException.hpp>
#include <antlr/ASTFactory.hpp>
#line 43 "verilog.parser.g"

ANTLR_USING_NAMESPACE(antlr);

#include <iostream>
#include "../../support/Base.hpp"
#include "../../csl_xml_warn_error/CSLC_Errors.h"
#include "../../csl_xml_warn_error/we_logic.h"

bool verilogParserHasErrors = false;


#line 19 "VerilogParser.cpp"
VerilogParser::VerilogParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,k)
{
}

VerilogParser::VerilogParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,1)
{
}

VerilogParser::VerilogParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,k)
{
}

VerilogParser::VerilogParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,1)
{
}

VerilogParser::VerilogParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(state,1)
{
}

void VerilogParser::unexpected() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST unexpected_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	{
	switch ( LA(1)) {
	case UNSIGNED_NUMBER:
	{
		match(UNSIGNED_NUMBER);
		break;
	}
	case NZ_UNSIGNED_NUMBER:
	{
		match(NZ_UNSIGNED_NUMBER);
		break;
	}
	case REAL_NUMBER:
	{
		match(REAL_NUMBER);
		break;
	}
	case REAL_NUMBER_EXP:
	{
		match(REAL_NUMBER_EXP);
		break;
	}
	case TICK:
	{
		match(TICK);
		break;
	}
	case BACKTICK:
	{
		match(BACKTICK);
		break;
	}
	case AT:
	{
		match(AT);
		break;
	}
	case COLON:
	{
		match(COLON);
		break;
	}
	case COMMA:
	{
		match(COMMA);
		break;
	}
	case MINUS:
	{
		match(MINUS);
		break;
	}
	case RBRACK:
	{
		match(RBRACK);
		break;
	}
	case LCRULY:
	{
		match(LCRULY);
		break;
	}
	case RCRULY:
	{
		match(RCRULY);
		break;
	}
	case LPAREN:
	{
		match(LPAREN);
		break;
	}
	case RPAREN:
	{
		match(RPAREN);
		break;
	}
	case POUND:
	{
		match(POUND);
		break;
	}
	case QUESTION:
	{
		match(QUESTION);
		break;
	}
	case PLUS:
	{
		match(PLUS);
		break;
	}
	case LNOT:
	{
		match(LNOT);
		break;
	}
	case NOT:
	{
		match(NOT);
		break;
	}
	case AND:
	{
		match(AND);
		break;
	}
	case NAND:
	{
		match(NAND);
		break;
	}
	case OR:
	{
		match(OR);
		break;
	}
	case NOR:
	{
		match(NOR);
		break;
	}
	case XOR:
	{
		match(XOR);
		break;
	}
	case XNOR:
	{
		match(XNOR);
		break;
	}
	case STAR:
	{
		match(STAR);
		break;
	}
	case POW:
	{
		match(POW);
		break;
	}
	case DIV:
	{
		match(DIV);
		break;
	}
	case MOD:
	{
		match(MOD);
		break;
	}
	case EQUAL:
	{
		match(EQUAL);
		break;
	}
	case NOT_EQ:
	{
		match(NOT_EQ);
		break;
	}
	case NOT_EQ_CASE:
	{
		match(NOT_EQ_CASE);
		break;
	}
	case EQ_CASE:
	{
		match(EQ_CASE);
		break;
	}
	case LAND:
	{
		match(LAND);
		break;
	}
	case TAND:
	{
		match(TAND);
		break;
	}
	case LOR:
	{
		match(LOR);
		break;
	}
	case LT_:
	{
		match(LT_);
		break;
	}
	case GT:
	{
		match(GT);
		break;
	}
	case GE:
	{
		match(GE);
		break;
	}
	case SL:
	{
		match(SL);
		break;
	}
	case SSL:
	{
		match(SSL);
		break;
	}
	case SR:
	{
		match(SR);
		break;
	}
	case SSR:
	{
		match(SSR);
		break;
	}
	case TRIGGER:
	{
		match(TRIGGER);
		break;
	}
	case PPATH:
	{
		match(PPATH);
		break;
	}
	case FPATH:
	{
		match(FPATH);
		break;
	}
	case STARP:
	{
		match(STARP);
		break;
	}
	case PO_POS:
	{
		match(PO_POS);
		break;
	}
	case PO_NEG:
	{
		match(PO_NEG);
		break;
	}
	case SUPERSTAR:
	{
		match(SUPERSTAR);
		break;
	}
	case K_BEGIN:
	{
		match(K_BEGIN);
		break;
	}
	case K_END:
	{
		match(K_END);
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
#line 232 "verilog.parser.g"
		
		args.push_back(intToString(1));
		string errorMessage;
		errorMessage.append("unexpected token: ");
		errorMessage.append((LT(1))->getText());   
		args.push_back(errorMessage);
		addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, (LT(1))->getLine());
		verilogParserHasErrors = true;
		consume();
		
#line 335 "VerilogParser.cpp"
	}
	unexpected_AST = RefVerAST(currentAST.root);
	returnAST = unexpected_AST;
}

void VerilogParser::source_text() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST source_text_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_0.member(LA(1)))) {
				description();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop5;
			}
			
		}
		_loop5:;
		} // ( ... )*
		match(ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE);
		source_text_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 254 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 375 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = source_text_AST;
}

void VerilogParser::description() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST description_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case K_MACROMODULE:
		case K_MODULE:
		{
			module();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_PRIMITIVE:
		{
			udp_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_BEGIN:
		case K_END:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BACKTICK:
		case AT:
		case COLON:
		case COMMA:
		case MINUS:
		case RBRACK:
		case LCRULY:
		case RCRULY:
		case LPAREN:
		case RPAREN:
		case POUND:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case TAND:
		case LOR:
		case LT_:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case TRIGGER:
		case PPATH:
		case FPATH:
		case STARP:
		case PO_POS:
		case PO_NEG:
		case SUPERSTAR:
		case NZ_UNSIGNED_NUMBER:
		case REAL_NUMBER_EXP:
		case TICK:
		{
			unexpected();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_ENDMODULE:
		{
			match(K_ENDMODULE);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		description_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 271 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 495 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = description_AST;
}

void VerilogParser::attrs_opt() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST attrs_opt_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == PSTAR)) {
				attribute_instance();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop702;
			}
			
		}
		_loop702:;
		} // ( ... )*
		attrs_opt_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4664 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 536 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = attrs_opt_AST;
}

void VerilogParser::module() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 279 "verilog.parser.g"
	TBool canDeclPort = FALSE; TInt nonemptyPorts;
#line 550 "VerilogParser.cpp"
	
	try {      // for error handling
		{
		module_keyword();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case POUND:
		{
			module_parameter_port_list();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		case SEMI:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case LPAREN:
		{
			match(LPAREN);
			{
			switch ( LA(1)) {
			case K_INOUT:
			case K_INPUT:
			case K_OUTPUT:
			case PSTAR:
			{
				list_of_port_declarations();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case COMMA:
			case DOT:
			case LCRULY:
			case RPAREN:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				nonemptyPorts=list_of_ports();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 289 "verilog.parser.g"
					canDeclPort = nonemptyPorts > 0;
#line 615 "VerilogParser.cpp"
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			match(RPAREN);
			break;
		}
		case SEMI:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(SEMI);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_1.member(LA(1)))) {
				module_item(canDeclPort);
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop14;
			}
			
		}
		_loop14:;
		} // ( ... )*
		match(K_ENDMODULE);
		}
		if ( inputState->guessing==0 ) {
			module_AST = RefVerAST(currentAST.root);
#line 297 "verilog.parser.g"
			module_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MODULE_DEF,"MODULE_DEF")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(module_AST))));
#line 660 "VerilogParser.cpp"
			currentAST.root = module_AST;
			if ( module_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				module_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = module_AST->getFirstChild();
			else
				currentAST.child = module_AST;
			currentAST.advanceChildToEnd();
		}
		module_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 300 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 681 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_AST;
}

void VerilogParser::udp_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2366 "verilog.parser.g"
	TBool canDeclPort = TRUE;
#line 695 "VerilogParser.cpp"
	
	try {      // for error handling
		RefVerAST tmp60_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp60_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp60_AST));
		}
		match(K_PRIMITIVE);
		udp_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(LPAREN);
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			udp_port_list();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_OUTPUT:
		case PSTAR:
		{
			udp_declaration_port_list();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 2372 "verilog.parser.g"
				canDeclPort = FALSE;
#line 730 "VerilogParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_2.member(LA(1)))) {
				udp_port_declaration();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if (!( canDeclPort ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" canDeclPort ");
			}
			else {
				goto _loop381;
			}
			
		}
		_loop381:;
		} // ( ... )*
		udp_body();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(K_ENDPRIMITIVE);
		udp_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2384 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 776 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_declaration_AST;
}

void VerilogParser::module_keyword() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_keyword_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  x1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST x1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  x2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST x2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_MODULE:
		{
			x1 = LT(1);
			if ( inputState->guessing == 0 ) {
				x1_AST = astFactory->create(x1);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(x1_AST));
			}
			match(K_MODULE);
			module_keyword_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_MACROMODULE:
		{
			x2 = LT(1);
			if ( inputState->guessing == 0 ) {
				x2_AST = astFactory->create(x2);
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(x2_AST));
			}
			match(K_MACROMODULE);
			module_keyword_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 313 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 833 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_keyword_AST;
}

void VerilogParser::module_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4858 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 863 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_identifier_AST;
}

void VerilogParser::module_parameter_port_list() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_parameter_port_list_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pdh1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pa1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pa2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pdh2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pa3_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 322 "verilog.parser.g"
	RefVerAST pdh;
#line 882 "VerilogParser.cpp"
	
	try {      // for error handling
		if ( inputState->guessing==0 ) {
			module_parameter_port_list_AST = RefVerAST(currentAST.root);
#line 323 "verilog.parser.g"
			module_parameter_port_list_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MODULE_PARAMETER_PORT_LIST,"MODULE_PARAMETER_PORT_LIST")))));
#line 889 "VerilogParser.cpp"
			currentAST.root = module_parameter_port_list_AST;
			if ( module_parameter_port_list_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				module_parameter_port_list_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = module_parameter_port_list_AST->getFirstChild();
			else
				currentAST.child = module_parameter_port_list_AST;
			currentAST.advanceChildToEnd();
		}
		match(POUND);
		match(LPAREN);
		parameter_declaration_header();
		if (inputState->guessing==0) {
			pdh1_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			module_parameter_port_list_AST = RefVerAST(currentAST.root);
#line 328 "verilog.parser.g"
			
			pdh = pdh1_AST;
			module_parameter_port_list_AST->addChild(pdh);
			
#line 911 "VerilogParser.cpp"
		}
		param_assignment();
		if (inputState->guessing==0) {
			pa1_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
#line 333 "verilog.parser.g"
			if (pdh) pdh->addChild(pa1_AST);
#line 920 "VerilogParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				{
				switch ( LA(1)) {
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				{
					param_assignment();
					if (inputState->guessing==0) {
						pa2_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 337 "verilog.parser.g"
						if (pdh) pdh->addChild(pa2_AST);
#line 938 "VerilogParser.cpp"
					}
					break;
				}
				case K_PARAMETER:
				{
					parameter_declaration_header();
					if (inputState->guessing==0) {
						pdh2_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
						module_parameter_port_list_AST = RefVerAST(currentAST.root);
#line 339 "verilog.parser.g"
						
						pdh = pdh2_AST;
						module_parameter_port_list_AST->addChild(pdh);
						
#line 955 "VerilogParser.cpp"
					}
					param_assignment();
					if (inputState->guessing==0) {
						pa3_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 344 "verilog.parser.g"
						if (pdh) pdh->addChild(pa3_AST);
#line 964 "VerilogParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else {
				goto _loop19;
			}
			
		}
		_loop19:;
		} // ( ... )*
		match(RPAREN);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 350 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 994 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_parameter_port_list_AST;
}

void VerilogParser::list_of_port_declarations() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_port_declarations_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST atr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pdecl1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST atr1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pdecl2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST vpi_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 384 "verilog.parser.g"
	
	TBool var; 
	TBool canBeVar; 
	RefVerAST cdecl1; 
	
#line 1017 "VerilogParser.cpp"
	
	try {      // for error handling
		if ( inputState->guessing==0 ) {
			list_of_port_declarations_AST = RefVerAST(currentAST.root);
#line 390 "verilog.parser.g"
			list_of_port_declarations_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(LIST_OF_PORT_DECLARATIONS,"LIST_OF_PORT_DECLARATIONS")))));
#line 1024 "VerilogParser.cpp"
			currentAST.root = list_of_port_declarations_AST;
			if ( list_of_port_declarations_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				list_of_port_declarations_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = list_of_port_declarations_AST->getFirstChild();
			else
				currentAST.child = list_of_port_declarations_AST;
			currentAST.advanceChildToEnd();
		}
		attrs_opt();
		if (inputState->guessing==0) {
			atr_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			list_of_port_declarations_AST = RefVerAST(currentAST.root);
#line 392 "verilog.parser.g"
			list_of_port_declarations_AST->addChild(atr_AST);
#line 1041 "VerilogParser.cpp"
		}
		canBeVar=port_declaration();
		if (inputState->guessing==0) {
			pdecl1_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			list_of_port_declarations_AST = RefVerAST(currentAST.root);
#line 394 "verilog.parser.g"
			cdecl1 = pdecl1_AST; list_of_port_declarations_AST->addChild(cdecl1);
#line 1051 "VerilogParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				{
				switch ( LA(1)) {
				case K_INOUT:
				case K_INPUT:
				case K_OUTPUT:
				case PSTAR:
				{
					attrs_opt();
					if (inputState->guessing==0) {
						atr1_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
						list_of_port_declarations_AST = RefVerAST(currentAST.root);
#line 397 "verilog.parser.g"
						list_of_port_declarations_AST->addChild(atr1_AST);
#line 1072 "VerilogParser.cpp"
					}
					canBeVar=port_declaration();
					if (inputState->guessing==0) {
						pdecl2_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
						list_of_port_declarations_AST = RefVerAST(currentAST.root);
#line 399 "verilog.parser.g"
						cdecl1 = pdecl2_AST; list_of_port_declarations_AST->addChild(cdecl1);
#line 1082 "VerilogParser.cpp"
					}
					break;
				}
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				{
					var=variable_port_identifier();
					if (inputState->guessing==0) {
						vpi_AST = returnAST;
					}
					if (!( canBeVar || !var ))
						throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" canBeVar || !var ");
					if ( inputState->guessing==0 ) {
#line 404 "verilog.parser.g"
						if (cdecl1) cdecl1->addChild(vpi_AST);
#line 1098 "VerilogParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else {
				goto _loop26;
			}
			
		}
		_loop26:;
		} // ( ... )*
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 409 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1127 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_port_declarations_AST;
}

TInt  VerilogParser::list_of_ports() {
#line 367 "verilog.parser.g"
	TInt nonemptyPorts;
#line 1138 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_ports_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 367 "verilog.parser.g"
	TBool empty; nonemptyPorts = 0;
#line 1144 "VerilogParser.cpp"
	
	try {      // for error handling
		empty=port();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
#line 369 "verilog.parser.g"
			if (!empty) nonemptyPorts++;
#line 1154 "VerilogParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				empty=port();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 372 "verilog.parser.g"
					if (!empty) nonemptyPorts++;
#line 1167 "VerilogParser.cpp"
				}
			}
			else {
				goto _loop22;
			}
			
		}
		_loop22:;
		} // ( ... )*
		list_of_ports_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 376 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1189 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_ports_AST;
	return nonemptyPorts;
}

void VerilogParser::module_item(
	TBool canDeclPort
) {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_item_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pdecl_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pid_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 518 "verilog.parser.g"
	TBool var, canBeVar;
#line 1208 "VerilogParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_SPECIFY:
		{
			specify_block();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_GENERATE:
		{
			generated_instantiation();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_ALWAYS:
		case K_AND:
		case K_ASSIGN:
		case K_BUF:
		case K_BUFIF0:
		case K_BUFIF1:
		case K_CMOS:
		case K_DEFPARAM:
		case K_EVENT:
		case K_FUNCTION:
		case K_GENVAR:
		case K_INITIAL:
		case K_INOUT:
		case K_INPUT:
		case K_INTEGER:
		case K_LOCALPARAM:
		case K_NAND:
		case K_NMOS:
		case K_NOR:
		case K_NOT:
		case K_NOTIF0:
		case K_NOTIF1:
		case K_OR:
		case K_OUTPUT:
		case K_PARAMETER:
		case K_PMOS:
		case K_PULLDOWN:
		case K_PULLUP:
		case K_RCMOS:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_RNMOS:
		case K_RPMOS:
		case K_RTRAN:
		case K_RTRANIF0:
		case K_RTRANIF1:
		case K_SPECPARAM:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TASK:
		case K_TIME:
		case K_TRAN:
		case K_TRANIF0:
		case K_TRANIF1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_TRIREG:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		case K_XNOR:
		case K_XOR:
		case PSTAR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case K_LOCALPARAM:
			{
				local_parameter_declaration();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(SEMI);
				break;
			}
			case K_ALWAYS:
			case K_AND:
			case K_ASSIGN:
			case K_BUF:
			case K_BUFIF0:
			case K_BUFIF1:
			case K_CMOS:
			case K_DEFPARAM:
			case K_EVENT:
			case K_FUNCTION:
			case K_GENVAR:
			case K_INITIAL:
			case K_INTEGER:
			case K_NAND:
			case K_NMOS:
			case K_NOR:
			case K_NOT:
			case K_NOTIF0:
			case K_NOTIF1:
			case K_OR:
			case K_PMOS:
			case K_PULLDOWN:
			case K_PULLUP:
			case K_RCMOS:
			case K_REAL:
			case K_REALTIME:
			case K_REG:
			case K_RNMOS:
			case K_RPMOS:
			case K_RTRAN:
			case K_RTRANIF0:
			case K_RTRANIF1:
			case K_SUPPLY0:
			case K_SUPPLY1:
			case K_TASK:
			case K_TIME:
			case K_TRAN:
			case K_TRANIF0:
			case K_TRANIF1:
			case K_TRI:
			case K_TRI0:
			case K_TRI1:
			case K_TRIAND:
			case K_TRIOR:
			case K_TRIREG:
			case K_WAND:
			case K_WIRE:
			case K_WOR:
			case K_XNOR:
			case K_XOR:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				module_or_generate_item();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case K_PARAMETER:
			{
				parameter_declaration();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(SEMI);
				break;
			}
			case K_SPECPARAM:
			{
				specparam_declaration();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case K_INOUT:
			case K_INPUT:
			case K_OUTPUT:
			{
				canBeVar=port_declaration();
				if (inputState->guessing==0) {
					pdecl_AST = returnAST;
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if (!( canDeclPort ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" canDeclPort ");
				{ // ( ... )*
				for (;;) {
					if ((LA(1) == COMMA)) {
						match(COMMA);
						var=variable_port_identifier();
						if (inputState->guessing==0) {
							pid_AST = returnAST;
						}
						if (!( canBeVar || !var ))
							throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" canBeVar || !var ");
						if ( inputState->guessing==0 ) {
#line 531 "verilog.parser.g"
							pdecl_AST->addChild(pid_AST);
#line 1405 "VerilogParser.cpp"
						}
					}
					else {
						goto _loop44;
					}
					
				}
				_loop44:;
				} // ( ... )*
				match(SEMI);
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			module_item_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 537 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1443 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_item_AST;
}

void VerilogParser::parameter_declaration_header() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST parameter_declaration_header_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp75_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp75_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp75_AST));
		}
		match(K_PARAMETER);
		{
		switch ( LA(1)) {
		case K_SIGNED:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp76_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp76_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp76_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_TIME:
		{
			parameter_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		parameter_declaration_header_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 620 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1546 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = parameter_declaration_header_AST;
}

void VerilogParser::param_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST param_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		parameter_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(ASSIGN);
		constant_mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			param_assignment_AST = RefVerAST(currentAST.root);
#line 1241 "verilog.parser.g"
			param_assignment_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PARAM_ASSIGNMENT,"PARAM_ASSIGNMENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(param_assignment_AST))));
#line 1573 "VerilogParser.cpp"
			currentAST.root = param_assignment_AST;
			if ( param_assignment_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				param_assignment_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = param_assignment_AST->getFirstChild();
			else
				currentAST.child = param_assignment_AST;
			currentAST.advanceChildToEnd();
		}
		param_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1244 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1594 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = param_assignment_AST;
}

TBool  VerilogParser::port() {
#line 417 "verilog.parser.g"
	TBool empty;
#line 1605 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST port_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		if ( inputState->guessing==0 ) {
#line 418 "verilog.parser.g"
			empty = FALSE;
#line 1614 "VerilogParser.cpp"
		}
		{
		switch ( LA(1)) {
		case DOT:
		case LCRULY:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			{
			switch ( LA(1)) {
			case LCRULY:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				port_expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case DOT:
			{
				named_port_expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case COMMA:
		case RPAREN:
		{
			if ( inputState->guessing==0 ) {
#line 422 "verilog.parser.g"
				empty = TRUE;
#line 1657 "VerilogParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			port_AST = RefVerAST(currentAST.root);
#line 424 "verilog.parser.g"
			port_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PORT,"PORT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(port_AST))));
#line 1671 "VerilogParser.cpp"
			currentAST.root = port_AST;
			if ( port_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				port_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = port_AST->getFirstChild();
			else
				currentAST.child = port_AST;
			currentAST.advanceChildToEnd();
		}
		port_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 427 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1692 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = port_AST;
	return empty;
}

TBool  VerilogParser::port_declaration() {
#line 501 "verilog.parser.g"
	TBool canBeVar;
#line 1704 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST port_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_INOUT:
		{
			inout_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 503 "verilog.parser.g"
				canBeVar = FALSE;
#line 1720 "VerilogParser.cpp"
			}
			port_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_INPUT:
		{
			input_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 505 "verilog.parser.g"
				canBeVar = FALSE;
#line 1734 "VerilogParser.cpp"
			}
			port_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_OUTPUT:
		{
			canBeVar=output_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			port_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 509 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1764 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = port_declaration_AST;
	return canBeVar;
}

TBool  VerilogParser::variable_port_identifier() {
#line 1201 "verilog.parser.g"
	TBool variable;
#line 1776 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST variable_port_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		if ( inputState->guessing==0 ) {
#line 1202 "verilog.parser.g"
			variable = FALSE;
#line 1785 "VerilogParser.cpp"
		}
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case ASSIGN:
		{
			match(ASSIGN);
			constant_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				variable_port_identifier_AST = RefVerAST(currentAST.root);
#line 1206 "verilog.parser.g"
				
				variable_port_identifier_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(VARIABLE_PORT_IDENTIFIER,"VARIABLE_PORT_IDENTIFIER")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(variable_port_identifier_AST))));
				variable = TRUE; 
				
#line 1807 "VerilogParser.cpp"
				currentAST.root = variable_port_identifier_AST;
				if ( variable_port_identifier_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					variable_port_identifier_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = variable_port_identifier_AST->getFirstChild();
				else
					currentAST.child = variable_port_identifier_AST;
				currentAST.advanceChildToEnd();
			}
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case COMMA:
		case RPAREN:
		case SEMI:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		variable_port_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1213 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1843 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = variable_port_identifier_AST;
	return variable;
}

void VerilogParser::port_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST port_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			port_reference();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LCRULY:
		{
			port_reference_concat();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			port_expression_AST = RefVerAST(currentAST.root);
#line 456 "verilog.parser.g"
			port_expression_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PORT_EXPRESSION,"PORT_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(port_expression_AST))));
#line 1887 "VerilogParser.cpp"
			currentAST.root = port_expression_AST;
			if ( port_expression_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				port_expression_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = port_expression_AST->getFirstChild();
			else
				currentAST.child = port_expression_AST;
			currentAST.advanceChildToEnd();
		}
		port_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 459 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1908 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = port_expression_AST;
}

void VerilogParser::named_port_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST named_port_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(DOT);
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(LPAREN);
		{
		switch ( LA(1)) {
		case LCRULY:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			port_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			named_port_expression_AST = RefVerAST(currentAST.root);
#line 441 "verilog.parser.g"
			named_port_expression_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(NAMED_PORT_EXPRESSION,"NAMED_PORT_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(named_port_expression_AST))));
#line 1955 "VerilogParser.cpp"
			currentAST.root = named_port_expression_AST;
			if ( named_port_expression_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				named_port_expression_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = named_port_expression_AST->getFirstChild();
			else
				currentAST.child = named_port_expression_AST;
			currentAST.advanceChildToEnd();
		}
		named_port_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 444 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 1976 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = named_port_expression_AST;
}

void VerilogParser::port_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST port_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		port_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4870 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2006 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = port_identifier_AST;
}

void VerilogParser::port_reference() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST port_reference_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			match(LBRACK);
			constant_range_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RBRACK);
			break;
		}
		case COMMA:
		case RCRULY:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			port_reference_AST = RefVerAST(currentAST.root);
#line 490 "verilog.parser.g"
			port_reference_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PORT_REFERENCE,"PORT_REFERENCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(port_reference_AST))));
#line 2052 "VerilogParser.cpp"
			currentAST.root = port_reference_AST;
			if ( port_reference_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				port_reference_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = port_reference_AST->getFirstChild();
			else
				currentAST.child = port_reference_AST;
			currentAST.advanceChildToEnd();
		}
		port_reference_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 493 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2073 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = port_reference_AST;
}

void VerilogParser::port_reference_concat() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST port_reference_concat_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		match(LCRULY);
		port_reference();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				port_reference();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop37;
			}
			
		}
		_loop37:;
		} // ( ... )*
		match(RCRULY);
		}
		if ( inputState->guessing==0 ) {
			port_reference_concat_AST = RefVerAST(currentAST.root);
#line 473 "verilog.parser.g"
			port_reference_concat_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PORT_REFERENCE_CONCAT,"PORT_REFERENCE_CONCAT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(port_reference_concat_AST))));
#line 2115 "VerilogParser.cpp"
			currentAST.root = port_reference_concat_AST;
			if ( port_reference_concat_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				port_reference_concat_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = port_reference_concat_AST->getFirstChild();
			else
				currentAST.child = port_reference_concat_AST;
			currentAST.advanceChildToEnd();
		}
		port_reference_concat_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 476 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2136 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = port_reference_concat_AST;
}

void VerilogParser::constant_range_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST constant_range_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		range_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		constant_range_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5100 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2166 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = constant_range_expression_AST;
}

void VerilogParser::inout_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST inout_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp87_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp87_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp87_AST));
		}
		match(K_INOUT);
		{
		switch ( LA(1)) {
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		{
			net_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_SIGNED:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case K_SIGNED:
		{
			RefVerAST tmp88_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp88_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp88_AST));
			}
			match(K_SIGNED);
			break;
		}
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			range();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		inout_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 682 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2279 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = inout_declaration_AST;
}

void VerilogParser::input_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST input_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp89_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp89_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp89_AST));
		}
		match(K_INPUT);
		{
		switch ( LA(1)) {
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		{
			net_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_SIGNED:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case K_SIGNED:
		{
			RefVerAST tmp90_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp90_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp90_AST));
			}
			match(K_SIGNED);
			break;
		}
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			range();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		input_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 698 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2392 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = input_declaration_AST;
}

TBool  VerilogParser::output_declaration() {
#line 706 "verilog.parser.g"
	TBool canBeVar;
#line 2403 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST output_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 706 "verilog.parser.g"
	TBool var;
#line 2409 "VerilogParser.cpp"
	
	try {      // for error handling
		RefVerAST tmp91_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp91_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp91_AST));
		}
		match(K_OUTPUT);
		{
		switch ( LA(1)) {
		case K_SIGNED:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			{
			switch ( LA(1)) {
			case K_SUPPLY0:
			case K_SUPPLY1:
			case K_TRI:
			case K_TRI0:
			case K_TRI1:
			case K_TRIAND:
			case K_TRIOR:
			case K_WAND:
			case K_WIRE:
			case K_WOR:
			{
				net_type();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case K_SIGNED:
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp92_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp92_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp92_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			port_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 713 "verilog.parser.g"
				canBeVar = FALSE;
#line 2519 "VerilogParser.cpp"
			}
			break;
		}
		case K_REG:
		{
			RefVerAST tmp93_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp93_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp93_AST));
			}
			match(K_REG);
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp94_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp94_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp94_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			var=variable_port_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 715 "verilog.parser.g"
				canBeVar = TRUE;
#line 2583 "VerilogParser.cpp"
			}
			break;
		}
		case K_INTEGER:
		case K_TIME:
		{
			output_variable_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			var=variable_port_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 717 "verilog.parser.g"
				canBeVar = TRUE;
#line 2601 "VerilogParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		output_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 721 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2623 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = output_declaration_AST;
	return canBeVar;
}

void VerilogParser::specify_block() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST specify_block_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp95_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp95_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp95_AST));
		}
		match(K_SPECIFY);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_3.member(LA(1)))) {
				specify_item();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop495;
			}
			
		}
		_loop495:;
		} // ( ... )*
		match(K_ENDSPECIFY);
		specify_block_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3263 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2672 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = specify_block_AST;
}

void VerilogParser::generated_instantiation() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST generated_instantiation_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp97_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp97_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp97_AST));
		}
		match(K_GENERATE);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_4.member(LA(1)))) {
				generate_item();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop356;
			}
			
		}
		_loop356:;
		} // ( ... )*
		match(K_ENDGENERATE);
		generated_instantiation_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2217 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2720 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = generated_instantiation_AST;
}

void VerilogParser::local_parameter_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST local_parameter_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		RefVerAST tmp99_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp99_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp99_AST));
		}
		match(K_LOCALPARAM);
		{
		switch ( LA(1)) {
		case K_SIGNED:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp100_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp100_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp100_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_TIME:
		{
			parameter_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		list_of_param_assignments();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		}
		local_parameter_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 604 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2829 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = local_parameter_declaration_AST;
}

void VerilogParser::module_or_generate_item() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_or_generate_item_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_EVENT:
		case K_FUNCTION:
		case K_GENVAR:
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TASK:
		case K_TIME:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_TRIREG:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		{
			module_or_generate_item_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_or_generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_DEFPARAM:
		{
			parameter_override();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_or_generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_ASSIGN:
		{
			continuous_assign();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_or_generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_AND:
		case K_BUF:
		case K_BUFIF0:
		case K_BUFIF1:
		case K_CMOS:
		case K_NAND:
		case K_NMOS:
		case K_NOR:
		case K_NOT:
		case K_NOTIF0:
		case K_NOTIF1:
		case K_OR:
		case K_PMOS:
		case K_PULLDOWN:
		case K_PULLUP:
		case K_RCMOS:
		case K_RNMOS:
		case K_RPMOS:
		case K_RTRAN:
		case K_RTRANIF0:
		case K_RTRANIF1:
		case K_TRAN:
		case K_TRANIF0:
		case K_TRANIF1:
		case K_XNOR:
		case K_XOR:
		{
			gate_instantiation();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_or_generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			module_or_udp_instantiation();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_or_generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_INITIAL:
		{
			initial_construct();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_or_generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_ALWAYS:
		{
			always_construct();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_or_generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 555 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 2968 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_or_generate_item_AST;
}

void VerilogParser::parameter_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST parameter_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pdh_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST lopa_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		parameter_declaration_header();
		if (inputState->guessing==0) {
			pdh_AST = returnAST;
		}
		list_of_param_assignments();
		if (inputState->guessing==0) {
			lopa_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			parameter_declaration_AST = RefVerAST(currentAST.root);
#line 631 "verilog.parser.g"
			parameter_declaration_AST = pdh_AST; parameter_declaration_AST->addChild(lopa_AST);
#line 2996 "VerilogParser.cpp"
			currentAST.root = parameter_declaration_AST;
			if ( parameter_declaration_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				parameter_declaration_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = parameter_declaration_AST->getFirstChild();
			else
				currentAST.child = parameter_declaration_AST;
			currentAST.advanceChildToEnd();
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 634 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 3016 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = parameter_declaration_AST;
}

void VerilogParser::specparam_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST specparam_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp101_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp101_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp101_AST));
		}
		match(K_SPECPARAM);
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			range();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case PATHPULSE:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		list_of_specparam_assignments();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		specparam_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 649 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 3075 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = specparam_declaration_AST;
}

void VerilogParser::module_or_generate_item_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_or_generate_item_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	switch ( LA(1)) {
	case K_SUPPLY0:
	case K_SUPPLY1:
	case K_TRI:
	case K_TRI0:
	case K_TRI1:
	case K_TRIAND:
	case K_TRIOR:
	case K_TRIREG:
	case K_WAND:
	case K_WIRE:
	case K_WOR:
	{
		net_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_REG:
	{
		reg_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_INTEGER:
	{
		integer_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_REAL:
	{
		real_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_TIME:
	{
		time_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_REALTIME:
	{
		realtime_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_EVENT:
	{
		event_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_GENVAR:
	{
		genvar_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_TASK:
	{
		task_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	case K_FUNCTION:
	{
		function_declaration();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_or_generate_item_declaration_AST = RefVerAST(currentAST.root);
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	returnAST = module_or_generate_item_declaration_AST;
}

void VerilogParser::parameter_override() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST parameter_override_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp103_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp103_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp103_AST));
		}
		match(K_DEFPARAM);
		list_of_defparam_assignments();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		parameter_override_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 582 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 3226 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = parameter_override_AST;
}

void VerilogParser::continuous_assign() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST continuous_assign_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp105_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp105_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp105_AST));
		}
		match(K_ASSIGN);
		{
		switch ( LA(1)) {
		case LPAREN:
		{
			match(LPAREN);
			drive_strength();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			break;
		}
		case LCRULY:
		case POUND:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case POUND:
		{
			delay3();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LCRULY:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		list_of_net_assignments();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		continuous_assign_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2734 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 3310 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = continuous_assign_AST;
}

void VerilogParser::gate_instantiation() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST gate_instantiation_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_CMOS:
		case K_RCMOS:
		{
			cmos_switchtype();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case POUND:
			{
				delay3();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case LPAREN:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			cmos_switch_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					cmos_switch_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop243;
				}
				
			}
			_loop243:;
			} // ( ... )*
			break;
		}
		case K_BUFIF0:
		case K_BUFIF1:
		case K_NOTIF0:
		case K_NOTIF1:
		{
			enable_gatetype();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			bool synPredMatched246 = false;
			if (((LA(1) == LPAREN))) {
				int _m246 = mark();
				synPredMatched246 = true;
				inputState->guessing++;
				try {
					{
					match(LPAREN);
					drive_strength();
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched246 = false;
				}
				rewind(_m246);
				inputState->guessing--;
			}
			if ( synPredMatched246 ) {
				match(LPAREN);
				drive_strength();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(RPAREN);
			}
			else if ((_tokenSet_5.member(LA(1)))) {
			}
			else {
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			
			}
			{
			switch ( LA(1)) {
			case POUND:
			{
				delay3();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case LPAREN:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			enable_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					enable_gate_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop249;
				}
				
			}
			_loop249:;
			} // ( ... )*
			break;
		}
		case K_NMOS:
		case K_PMOS:
		case K_RNMOS:
		case K_RPMOS:
		{
			mos_switchtype();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case POUND:
			{
				delay3();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case LPAREN:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			mos_switch_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					mos_switch_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop252;
				}
				
			}
			_loop252:;
			} // ( ... )*
			break;
		}
		case K_AND:
		case K_NAND:
		case K_NOR:
		case K_OR:
		case K_XNOR:
		case K_XOR:
		{
			n_input_gatetype();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			bool synPredMatched255 = false;
			if (((LA(1) == LPAREN))) {
				int _m255 = mark();
				synPredMatched255 = true;
				inputState->guessing++;
				try {
					{
					match(LPAREN);
					drive_strength();
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched255 = false;
				}
				rewind(_m255);
				inputState->guessing--;
			}
			if ( synPredMatched255 ) {
				match(LPAREN);
				drive_strength();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(RPAREN);
			}
			else if ((_tokenSet_5.member(LA(1)))) {
			}
			else {
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			
			}
			{
			switch ( LA(1)) {
			case POUND:
			{
				delay2();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case LPAREN:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			n_input_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					n_input_gate_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop258;
				}
				
			}
			_loop258:;
			} // ( ... )*
			break;
		}
		case K_BUF:
		case K_NOT:
		{
			n_output_gatetype();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			bool synPredMatched261 = false;
			if (((LA(1) == LPAREN))) {
				int _m261 = mark();
				synPredMatched261 = true;
				inputState->guessing++;
				try {
					{
					match(LPAREN);
					drive_strength();
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched261 = false;
				}
				rewind(_m261);
				inputState->guessing--;
			}
			if ( synPredMatched261 ) {
				match(LPAREN);
				drive_strength();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(RPAREN);
			}
			else if ((_tokenSet_5.member(LA(1)))) {
			}
			else {
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			
			}
			{
			switch ( LA(1)) {
			case POUND:
			{
				delay2();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case LPAREN:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			n_output_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					n_output_gate_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop264;
				}
				
			}
			_loop264:;
			} // ( ... )*
			break;
		}
		case K_RTRANIF0:
		case K_RTRANIF1:
		case K_TRANIF0:
		case K_TRANIF1:
		{
			pass_enable_switchtype();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case POUND:
			{
				delay2();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case LPAREN:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			pass_enable_switch_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					pass_enable_switch_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop267;
				}
				
			}
			_loop267:;
			} // ( ... )*
			break;
		}
		case K_RTRAN:
		case K_TRAN:
		{
			pass_switchtype();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			pass_switch_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					pass_switch_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop269;
				}
				
			}
			_loop269:;
			} // ( ... )*
			break;
		}
		case K_PULLDOWN:
		{
			RefVerAST tmp122_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp122_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp122_AST));
			}
			match(K_PULLDOWN);
			{
			bool synPredMatched272 = false;
			if (((LA(1) == LPAREN))) {
				int _m272 = mark();
				synPredMatched272 = true;
				inputState->guessing++;
				try {
					{
					match(LPAREN);
					pulldown_strength();
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched272 = false;
				}
				rewind(_m272);
				inputState->guessing--;
			}
			if ( synPredMatched272 ) {
				match(LPAREN);
				pulldown_strength();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(RPAREN);
			}
			else if ((LA(1) == LPAREN || LA(1) == IDENTIFIER || LA(1) == ESCAPED_IDENTIFIER)) {
			}
			else {
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			
			}
			pull_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					pull_gate_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop274;
				}
				
			}
			_loop274:;
			} // ( ... )*
			break;
		}
		case K_PULLUP:
		{
			RefVerAST tmp126_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp126_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp126_AST));
			}
			match(K_PULLUP);
			{
			bool synPredMatched277 = false;
			if (((LA(1) == LPAREN))) {
				int _m277 = mark();
				synPredMatched277 = true;
				inputState->guessing++;
				try {
					{
					match(LPAREN);
					pullup_strength();
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched277 = false;
				}
				rewind(_m277);
				inputState->guessing--;
			}
			if ( synPredMatched277 ) {
				match(LPAREN);
				pullup_strength();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(RPAREN);
			}
			else if ((LA(1) == LPAREN || LA(1) == IDENTIFIER || LA(1) == ESCAPED_IDENTIFIER)) {
			}
			else {
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			
			}
			pull_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					pull_gate_instance();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop279;
				}
				
			}
			_loop279:;
			} // ( ... )*
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(SEMI);
		if ( inputState->guessing==0 ) {
			gate_instantiation_AST = RefVerAST(currentAST.root);
#line 1679 "verilog.parser.g"
			gate_instantiation_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(GATE_INSTANTIATION,"GATE_INSTANTIATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(gate_instantiation_AST))));
#line 3907 "VerilogParser.cpp"
			currentAST.root = gate_instantiation_AST;
			if ( gate_instantiation_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				gate_instantiation_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = gate_instantiation_AST->getFirstChild();
			else
				currentAST.child = gate_instantiation_AST;
			currentAST.advanceChildToEnd();
		}
		gate_instantiation_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1682 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 3928 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = gate_instantiation_AST;
}

void VerilogParser::module_or_udp_instantiation() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_or_udp_instantiation_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		module_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		bool synPredMatched324 = false;
		if (((LA(1) == LPAREN))) {
			int _m324 = mark();
			synPredMatched324 = true;
			inputState->guessing++;
			try {
				{
				match(LPAREN);
				drive_strength();
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched324 = false;
			}
			rewind(_m324);
			inputState->guessing--;
		}
		if ( synPredMatched324 ) {
			{
			match(LPAREN);
			drive_strength();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			}
		}
		else if ((_tokenSet_5.member(LA(1)))) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		{
		switch ( LA(1)) {
		case POUND:
		{
			parameter_value_assignment_or_delay2();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		module_instance();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				module_instance();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop328;
			}
			
		}
		_loop328:;
		} // ( ... )*
		match(SEMI);
		if ( inputState->guessing==0 ) {
			module_or_udp_instantiation_AST = RefVerAST(currentAST.root);
#line 2056 "verilog.parser.g"
			module_or_udp_instantiation_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MODULE_OR_UDP_INSTANTIATION,"MODULE_OR_UDP_INSTANTIATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(module_or_udp_instantiation_AST))));
#line 4028 "VerilogParser.cpp"
			currentAST.root = module_or_udp_instantiation_AST;
			if ( module_or_udp_instantiation_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				module_or_udp_instantiation_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = module_or_udp_instantiation_AST->getFirstChild();
			else
				currentAST.child = module_or_udp_instantiation_AST;
			currentAST.advanceChildToEnd();
		}
		module_or_udp_instantiation_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2059 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4049 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_or_udp_instantiation_AST;
}

void VerilogParser::initial_construct() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST initial_construct_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp135_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp135_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp135_AST));
		}
		match(K_INITIAL);
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		statement();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		initial_construct_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2788 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4089 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = initial_construct_AST;
}

void VerilogParser::always_construct() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST always_construct_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp136_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp136_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp136_AST));
		}
		match(K_ALWAYS);
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		statement();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		always_construct_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2800 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4129 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = always_construct_AST;
}

void VerilogParser::net_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST net_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 744 "verilog.parser.g"
	TBool decl, ds, exprng, rng;
#line 4143 "VerilogParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		{
			{
			net_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 747 "verilog.parser.g"
				decl = ds = exprng = rng = FALSE;
#line 4166 "VerilogParser.cpp"
			}
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				match(LPAREN);
				drive_strength();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(RPAREN);
				if ( inputState->guessing==0 ) {
#line 748 "verilog.parser.g"
					ds = TRUE;
#line 4181 "VerilogParser.cpp"
				}
				break;
			}
			case K_SCALARED:
			case K_SIGNED:
			case K_VECTORED:
			case LBRACK:
			case POUND:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case K_SCALARED:
			case K_VECTORED:
			{
				expandrange();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 749 "verilog.parser.g"
					exprng = TRUE;
#line 4213 "VerilogParser.cpp"
				}
				break;
			}
			case K_SIGNED:
			case LBRACK:
			case POUND:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp139_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp139_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp139_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case POUND:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 751 "verilog.parser.g"
					rng = TRUE;
#line 4267 "VerilogParser.cpp"
				}
				break;
			}
			case POUND:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			if (!( rng || !exprng ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" rng || !exprng ");
			{
			switch ( LA(1)) {
			case POUND:
			{
				delay3();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			list_of_net_identifiers_or_decl_assignments(decl);
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if (!( !ds || decl ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !ds || decl ");
			match(SEMI);
			if ( inputState->guessing==0 ) {
				net_declaration_AST = RefVerAST(currentAST.root);
#line 759 "verilog.parser.g"
				net_declaration_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(NET_DECLARATION,"NET_DECLARATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(net_declaration_AST))));
#line 4317 "VerilogParser.cpp"
				currentAST.root = net_declaration_AST;
				if ( net_declaration_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					net_declaration_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = net_declaration_AST->getFirstChild();
				else
					currentAST.child = net_declaration_AST;
				currentAST.advanceChildToEnd();
			}
			}
			net_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_TRIREG:
		{
			{
			RefVerAST tmp141_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp141_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp141_AST));
			}
			match(K_TRIREG);
			if ( inputState->guessing==0 ) {
#line 762 "verilog.parser.g"
				decl = ds = exprng = rng = FALSE;
#line 4342 "VerilogParser.cpp"
			}
			{
			switch ( LA(1)) {
			case LPAREN:
			{
				match(LPAREN);
				{
				switch ( LA(1)) {
				case K_LARGE:
				case K_MEDIUM:
				case K_SMALL:
				{
					charge_strength();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					break;
				}
				case K_HIGHZ0:
				case K_HIGHZ1:
				case K_PULL0:
				case K_PULL1:
				case K_STRONG0:
				case K_STRONG1:
				case K_SUPPLY0:
				case K_SUPPLY1:
				case K_WEAK0:
				case K_WEAK1:
				{
					{
					drive_strength();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if ( inputState->guessing==0 ) {
#line 765 "verilog.parser.g"
						ds = TRUE;
#line 4380 "VerilogParser.cpp"
					}
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				match(RPAREN);
				break;
			}
			case K_SCALARED:
			case K_SIGNED:
			case K_VECTORED:
			case LBRACK:
			case POUND:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case K_SCALARED:
			case K_VECTORED:
			{
				expandrange();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 769 "verilog.parser.g"
					exprng = TRUE;
#line 4422 "VerilogParser.cpp"
				}
				break;
			}
			case K_SIGNED:
			case LBRACK:
			case POUND:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp144_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp144_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp144_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case POUND:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 771 "verilog.parser.g"
					rng = TRUE;
#line 4476 "VerilogParser.cpp"
				}
				break;
			}
			case POUND:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			if (!( rng || !exprng ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" rng || !exprng ");
			{
			switch ( LA(1)) {
			case POUND:
			{
				delay3();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			list_of_net_identifiers_or_decl_assignments(decl);
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if (!( !ds || decl ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !ds || decl ");
			match(SEMI);
			if ( inputState->guessing==0 ) {
				net_declaration_AST = RefVerAST(currentAST.root);
#line 779 "verilog.parser.g"
				net_declaration_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(NET_DECLARATION,"NET_DECLARATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(net_declaration_AST))));
#line 4526 "VerilogParser.cpp"
				currentAST.root = net_declaration_AST;
				if ( net_declaration_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					net_declaration_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = net_declaration_AST->getFirstChild();
				else
					currentAST.child = net_declaration_AST;
				currentAST.advanceChildToEnd();
			}
			}
			net_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 783 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4555 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = net_declaration_AST;
}

void VerilogParser::reg_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST reg_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp146_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp146_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp146_AST));
		}
		match(K_REG);
		{
		switch ( LA(1)) {
		case K_SIGNED:
		{
			RefVerAST tmp147_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp147_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp147_AST));
			}
			match(K_SIGNED);
			break;
		}
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			range();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		list_of_variable_identifiers();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		reg_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 853 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4637 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = reg_declaration_AST;
}

void VerilogParser::integer_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST integer_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp149_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp149_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp149_AST));
		}
		match(K_INTEGER);
		list_of_variable_identifiers();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		integer_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 736 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4674 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = integer_declaration_AST;
}

void VerilogParser::real_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST real_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp151_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp151_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp151_AST));
		}
		match(K_REAL);
		list_of_variable_identifiers();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		real_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 809 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4711 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = real_declaration_AST;
}

void VerilogParser::time_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST time_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp153_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp153_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp153_AST));
		}
		match(K_TIME);
		list_of_variable_identifiers();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		time_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 837 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4748 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = time_declaration_AST;
}

void VerilogParser::realtime_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST realtime_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp155_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp155_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp155_AST));
		}
		match(K_REALTIME);
		list_of_variable_identifiers();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		realtime_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 823 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4785 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = realtime_declaration_AST;
}

void VerilogParser::event_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST event_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp157_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp157_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp157_AST));
		}
		match(K_EVENT);
		list_of_event_identifiers();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		event_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 867 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4822 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = event_declaration_AST;
}

void VerilogParser::genvar_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST genvar_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp159_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp159_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp159_AST));
		}
		match(K_GENVAR);
		list_of_genvar_identifiers();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		genvar_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 881 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 4859 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = genvar_declaration_AST;
}

void VerilogParser::task_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST task_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1455 "verilog.parser.g"
	bool acceptNext = true;
#line 4873 "VerilogParser.cpp"
	
	try {      // for error handling
		RefVerAST tmp161_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp161_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp161_AST));
		}
		match(K_TASK);
		{
		switch ( LA(1)) {
		case K_AUTOMATIC:
		{
			RefVerAST tmp162_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp162_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp162_AST));
			}
			match(K_AUTOMATIC);
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		task_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case SEMI:
		{
			match(SEMI);
			{ // ( ... )*
			for (;;) {
				if ((_tokenSet_6.member(LA(1)))) {
					attrs_opt();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if (!( acceptNext ))
						throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" acceptNext ");
					{
					switch ( LA(1)) {
					case K_EVENT:
					case K_INOUT:
					case K_INPUT:
					case K_INTEGER:
					case K_LOCALPARAM:
					case K_OUTPUT:
					case K_PARAMETER:
					case K_REAL:
					case K_REALTIME:
					case K_REG:
					case K_TIME:
					{
						task_item_declaration();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case K_ASSIGN:
					case K_BEGIN:
					case K_CASE:
					case K_CASEX:
					case K_CASEZ:
					case K_DEASSIGN:
					case K_DISABLE:
					case K_FOR:
					case K_FORCE:
					case K_FOREVER:
					case K_FORK:
					case K_IF:
					case K_RELEASE:
					case K_REPEAT:
					case K_WAIT:
					case K_WHILE:
					case AT:
					case LCRULY:
					case POUND:
					case SEMI:
					case TRIGGER:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case SYSTEM_TASK_NAME:
					{
						statement_or_null();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						if ( inputState->guessing==0 ) {
#line 1464 "verilog.parser.g"
							acceptNext = false;
#line 4975 "VerilogParser.cpp"
						}
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
				}
				else {
					goto _loop204;
				}
				
			}
			_loop204:;
			} // ( ... )*
			break;
		}
		case LPAREN:
		{
			match(LPAREN);
			{
			switch ( LA(1)) {
			case K_INOUT:
			case K_INPUT:
			case K_OUTPUT:
			case PSTAR:
			{
				task_port_list();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			match(RPAREN);
			match(SEMI);
			{ // ( ... )*
			for (;;) {
				if ((_tokenSet_7.member(LA(1)))) {
					attrs_opt();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if (!(acceptNext))
						throw ANTLR_USE_NAMESPACE(antlr)SemanticException("acceptNext");
					{
					switch ( LA(1)) {
					case K_EVENT:
					case K_INTEGER:
					case K_LOCALPARAM:
					case K_PARAMETER:
					case K_REAL:
					case K_REALTIME:
					case K_REG:
					case K_TIME:
					{
						block_item_declaration();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case K_ASSIGN:
					case K_BEGIN:
					case K_CASE:
					case K_CASEX:
					case K_CASEZ:
					case K_DEASSIGN:
					case K_DISABLE:
					case K_FOR:
					case K_FORCE:
					case K_FOREVER:
					case K_FORK:
					case K_IF:
					case K_RELEASE:
					case K_REPEAT:
					case K_WAIT:
					case K_WHILE:
					case AT:
					case LCRULY:
					case POUND:
					case SEMI:
					case TRIGGER:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case SYSTEM_TASK_NAME:
					{
						statement_or_null();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						if ( inputState->guessing==0 ) {
#line 1472 "verilog.parser.g"
							acceptNext = false;
#line 5081 "VerilogParser.cpp"
						}
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
				}
				else {
					goto _loop208;
				}
				
			}
			_loop208:;
			} // ( ... )*
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if (!(!acceptNext))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException("!acceptNext");
		match(K_ENDTASK);
		task_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1481 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5122 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = task_declaration_AST;
}

void VerilogParser::function_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST function_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1355 "verilog.parser.g"
	bool acceptNext = true;
#line 5136 "VerilogParser.cpp"
	
	try {      // for error handling
		RefVerAST tmp168_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp168_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp168_AST));
		}
		match(K_FUNCTION);
		{
		switch ( LA(1)) {
		case K_AUTOMATIC:
		{
			RefVerAST tmp169_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp169_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp169_AST));
			}
			match(K_AUTOMATIC);
			break;
		}
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_SIGNED:
		case K_TIME:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case K_SIGNED:
		{
			RefVerAST tmp170_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp170_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp170_AST));
			}
			match(K_SIGNED);
			break;
		}
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_TIME:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_TIME:
		case LBRACK:
		{
			range_or_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		function_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case SEMI:
		{
			match(SEMI);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			function_item_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((_tokenSet_8.member(LA(1)))) {
					attrs_opt();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if (!( acceptNext ))
						throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" acceptNext ");
					{
					switch ( LA(1)) {
					case K_EVENT:
					case K_INPUT:
					case K_INTEGER:
					case K_LOCALPARAM:
					case K_PARAMETER:
					case K_REAL:
					case K_REALTIME:
					case K_REG:
					case K_TIME:
					{
						function_item_declaration();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case K_ASSIGN:
					case K_BEGIN:
					case K_CASE:
					case K_CASEX:
					case K_CASEZ:
					case K_DEASSIGN:
					case K_DISABLE:
					case K_FOR:
					case K_FORCE:
					case K_FOREVER:
					case K_FORK:
					case K_IF:
					case K_RELEASE:
					case K_REPEAT:
					case K_WAIT:
					case K_WHILE:
					case AT:
					case LCRULY:
					case POUND:
					case SEMI:
					case TRIGGER:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case SYSTEM_TASK_NAME:
					{
						function_statement();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						if ( inputState->guessing==0 ) {
#line 1368 "verilog.parser.g"
							acceptNext = false;
#line 5303 "VerilogParser.cpp"
						}
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
				}
				else {
					goto _loop187;
				}
				
			}
			_loop187:;
			} // ( ... )*
			break;
		}
		case LPAREN:
		{
			match(LPAREN);
			function_port_list();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			match(SEMI);
			{ // ( ... )*
			for (;;) {
				if ((_tokenSet_7.member(LA(1)))) {
					attrs_opt();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if (!( acceptNext ))
						throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" acceptNext ");
					{
					switch ( LA(1)) {
					case K_EVENT:
					case K_INTEGER:
					case K_LOCALPARAM:
					case K_PARAMETER:
					case K_REAL:
					case K_REALTIME:
					case K_REG:
					case K_TIME:
					{
						block_item_declaration();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case K_ASSIGN:
					case K_BEGIN:
					case K_CASE:
					case K_CASEX:
					case K_CASEZ:
					case K_DEASSIGN:
					case K_DISABLE:
					case K_FOR:
					case K_FORCE:
					case K_FOREVER:
					case K_FORK:
					case K_IF:
					case K_RELEASE:
					case K_REPEAT:
					case K_WAIT:
					case K_WHILE:
					case AT:
					case LCRULY:
					case POUND:
					case SEMI:
					case TRIGGER:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case SYSTEM_TASK_NAME:
					{
						function_statement();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						if ( inputState->guessing==0 ) {
#line 1379 "verilog.parser.g"
							acceptNext = false;
#line 5390 "VerilogParser.cpp"
						}
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
				}
				else {
					goto _loop190;
				}
				
			}
			_loop190:;
			} // ( ... )*
			if (!(!acceptNext))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException("!acceptNext");
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(K_ENDFUNCTION);
		function_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1388 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5431 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = function_declaration_AST;
}

void VerilogParser::list_of_defparam_assignments() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_defparam_assignments_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		defparam_assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				defparam_assignment();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop154;
			}
			
		}
		_loop154:;
		} // ( ... )*
		list_of_defparam_assignments_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1136 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5477 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_defparam_assignments_AST;
}

void VerilogParser::range() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST range_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(LBRACK);
		lsb_constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COLON);
		msb_constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RBRACK);
		if ( inputState->guessing==0 ) {
			range_AST = RefVerAST(currentAST.root);
#line 1343 "verilog.parser.g"
			range_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(RANGE,"RANGE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(range_AST))));
#line 5506 "VerilogParser.cpp"
			currentAST.root = range_AST;
			if ( range_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				range_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = range_AST->getFirstChild();
			else
				currentAST.child = range_AST;
			currentAST.advanceChildToEnd();
		}
		range_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1346 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5527 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = range_AST;
}

void VerilogParser::parameter_type() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST parameter_type_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_INTEGER:
		{
			RefVerAST tmp180_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp180_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp180_AST));
			}
			match(K_INTEGER);
			break;
		}
		case K_REAL:
		{
			RefVerAST tmp181_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp181_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp181_AST));
			}
			match(K_REAL);
			break;
		}
		case K_REALTIME:
		{
			RefVerAST tmp182_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp182_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp182_AST));
			}
			match(K_REALTIME);
			break;
		}
		case K_TIME:
		{
			RefVerAST tmp183_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp183_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp183_AST));
			}
			match(K_TIME);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		parameter_type_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 665 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5601 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = parameter_type_AST;
}

void VerilogParser::list_of_param_assignments() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_param_assignments_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		param_assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				param_assignment();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop157;
			}
			
		}
		_loop157:;
		} // ( ... )*
		list_of_param_assignments_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1149 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5647 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_param_assignments_AST;
}

void VerilogParser::list_of_specparam_assignments() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_specparam_assignments_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		specparam_assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				specparam_assignment();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop160;
			}
			
		}
		_loop160:;
		} // ( ... )*
		list_of_specparam_assignments_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1162 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5693 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_specparam_assignments_AST;
}

void VerilogParser::net_type() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST net_type_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_SUPPLY0:
		{
			RefVerAST tmp186_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp186_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp186_AST));
			}
			match(K_SUPPLY0);
			break;
		}
		case K_SUPPLY1:
		{
			RefVerAST tmp187_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp187_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp187_AST));
			}
			match(K_SUPPLY1);
			break;
		}
		case K_TRI:
		{
			RefVerAST tmp188_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp188_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp188_AST));
			}
			match(K_TRI);
			break;
		}
		case K_TRIAND:
		{
			RefVerAST tmp189_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp189_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp189_AST));
			}
			match(K_TRIAND);
			break;
		}
		case K_TRIOR:
		{
			RefVerAST tmp190_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp190_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp190_AST));
			}
			match(K_TRIOR);
			break;
		}
		case K_TRI0:
		{
			RefVerAST tmp191_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp191_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp191_AST));
			}
			match(K_TRI0);
			break;
		}
		case K_TRI1:
		{
			RefVerAST tmp192_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp192_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp192_AST));
			}
			match(K_TRI1);
			break;
		}
		case K_WIRE:
		{
			RefVerAST tmp193_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp193_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp193_AST));
			}
			match(K_WIRE);
			break;
		}
		case K_WAND:
		{
			RefVerAST tmp194_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp194_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp194_AST));
			}
			match(K_WAND);
			break;
		}
		case K_WOR:
		{
			RefVerAST tmp195_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp195_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp195_AST));
			}
			match(K_WOR);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		net_type_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 905 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5827 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = net_type_AST;
}

void VerilogParser::output_variable_type() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST output_variable_type_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_INTEGER:
		{
			RefVerAST tmp196_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp196_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp196_AST));
			}
			match(K_INTEGER);
			break;
		}
		case K_TIME:
		{
			RefVerAST tmp197_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp197_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp197_AST));
			}
			match(K_TIME);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		output_variable_type_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 920 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5881 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = output_variable_type_AST;
}

void VerilogParser::list_of_variable_identifiers() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_variable_identifiers_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		variable_type();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				variable_type();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop163;
			}
			
		}
		_loop163:;
		} // ( ... )*
		list_of_variable_identifiers_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1175 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 5927 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_variable_identifiers_AST;
}

void VerilogParser::drive_strength() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST drive_strength_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_PULL0:
		case K_STRONG0:
		case K_SUPPLY0:
		case K_WEAK0:
		{
			strength0();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case K_PULL1:
			case K_STRONG1:
			case K_SUPPLY1:
			case K_WEAK1:
			{
				strength1();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case K_HIGHZ1:
			{
				highz1();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case K_PULL1:
		case K_STRONG1:
		case K_SUPPLY1:
		case K_WEAK1:
		{
			strength1();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case K_PULL0:
			case K_STRONG0:
			case K_SUPPLY0:
			case K_WEAK0:
			{
				strength0();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case K_HIGHZ0:
			{
				highz0();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case K_HIGHZ0:
		{
			highz0();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COMMA);
			strength1();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_HIGHZ1:
		{
			highz1();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COMMA);
			strength0();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		drive_strength_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 954 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6065 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = drive_strength_AST;
}

void VerilogParser::expandrange() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST expandrange_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_VECTORED:
		{
			RefVerAST tmp203_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp203_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp203_AST));
			}
			match(K_VECTORED);
			break;
		}
		case K_SCALARED:
		{
			RefVerAST tmp204_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp204_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp204_AST));
			}
			match(K_SCALARED);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		expandrange_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 795 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6119 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = expandrange_AST;
}

void VerilogParser::delay3() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST delay3_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(POUND);
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			delay_value();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			match(LPAREN);
			mintypmax_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				mintypmax_expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				{
				switch ( LA(1)) {
				case COMMA:
				{
					match(COMMA);
					mintypmax_expression();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			match(RPAREN);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			delay3_AST = RefVerAST(currentAST.root);
#line 1031 "verilog.parser.g"
			delay3_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(DELAY,"DELAY")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(delay3_AST))));
#line 6209 "VerilogParser.cpp"
			currentAST.root = delay3_AST;
			if ( delay3_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				delay3_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = delay3_AST->getFirstChild();
			else
				currentAST.child = delay3_AST;
			currentAST.advanceChildToEnd();
		}
		delay3_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1034 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6230 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = delay3_AST;
}

void VerilogParser::list_of_net_identifiers_or_decl_assignments(
	TBool& decl
) {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_net_identifiers_or_decl_assignments_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		net_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		case LBRACK:
		case SEMI:
		{
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == LBRACK)) {
					dimension();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop135;
				}
				
			}
			_loop135:;
			} // ( ... )*
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					net_identifier();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					{ // ( ... )*
					for (;;) {
						if ((LA(1) == LBRACK)) {
							dimension();
							if (inputState->guessing==0) {
								astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
							}
						}
						else {
							goto _loop138;
						}
						
					}
					_loop138:;
					} // ( ... )*
				}
				else {
					goto _loop139;
				}
				
			}
			_loop139:;
			} // ( ... )*
			if ( inputState->guessing==0 ) {
				list_of_net_identifiers_or_decl_assignments_AST = RefVerAST(currentAST.root);
#line 1081 "verilog.parser.g"
				list_of_net_identifiers_or_decl_assignments_AST =
				RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(LIST_OF_NET_IDENTIFIERS,"LIST_OF_NET_IDENTIFIERS")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(list_of_net_identifiers_or_decl_assignments_AST))));
				decl = FALSE;
				
#line 6309 "VerilogParser.cpp"
				currentAST.root = list_of_net_identifiers_or_decl_assignments_AST;
				if ( list_of_net_identifiers_or_decl_assignments_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					list_of_net_identifiers_or_decl_assignments_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = list_of_net_identifiers_or_decl_assignments_AST->getFirstChild();
				else
					currentAST.child = list_of_net_identifiers_or_decl_assignments_AST;
				currentAST.advanceChildToEnd();
			}
			break;
		}
		case ASSIGN:
		{
			match(ASSIGN);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					net_identifier();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					match(ASSIGN);
					expression();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop141;
				}
				
			}
			_loop141:;
			} // ( ... )*
			if ( inputState->guessing==0 ) {
				list_of_net_identifiers_or_decl_assignments_AST = RefVerAST(currentAST.root);
#line 1087 "verilog.parser.g"
				
				list_of_net_identifiers_or_decl_assignments_AST =
				RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(LIST_OF_NET_DECL_ASSIGNMENTS,"LIST_OF_NET_DECL_ASSIGNMENTS")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(list_of_net_identifiers_or_decl_assignments_AST))));
				decl = TRUE;
				
#line 6356 "VerilogParser.cpp"
				currentAST.root = list_of_net_identifiers_or_decl_assignments_AST;
				if ( list_of_net_identifiers_or_decl_assignments_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					list_of_net_identifiers_or_decl_assignments_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = list_of_net_identifiers_or_decl_assignments_AST->getFirstChild();
				else
					currentAST.child = list_of_net_identifiers_or_decl_assignments_AST;
				currentAST.advanceChildToEnd();
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		list_of_net_identifiers_or_decl_assignments_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1096 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6385 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_net_identifiers_or_decl_assignments_AST;
}

void VerilogParser::charge_strength() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST charge_strength_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_SMALL:
		{
			RefVerAST tmp214_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp214_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp214_AST));
			}
			match(K_SMALL);
			break;
		}
		case K_MEDIUM:
		{
			RefVerAST tmp215_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp215_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp215_AST));
			}
			match(K_MEDIUM);
			break;
		}
		case K_LARGE:
		{
			RefVerAST tmp216_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp216_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp216_AST));
			}
			match(K_LARGE);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		charge_strength_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1014 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6449 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = charge_strength_AST;
}

void VerilogParser::list_of_event_identifiers() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_event_identifiers_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		event_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LBRACK)) {
				dimension();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop144;
			}
			
		}
		_loop144:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				event_identifier();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				{ // ( ... )*
				for (;;) {
					if ((LA(1) == LBRACK)) {
						dimension();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
					}
					else {
						goto _loop147;
					}
					
				}
				_loop147:;
				} // ( ... )*
			}
			else {
				goto _loop148;
			}
			
		}
		_loop148:;
		} // ( ... )*
		list_of_event_identifiers_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1110 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6525 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_event_identifiers_AST;
}

void VerilogParser::list_of_genvar_identifiers() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_genvar_identifiers_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		genvar_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				genvar_identifier();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop151;
			}
			
		}
		_loop151:;
		} // ( ... )*
		list_of_genvar_identifiers_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1123 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6571 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_genvar_identifiers_AST;
}

void VerilogParser::variable_type() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST variable_type_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		variable_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		case LBRACK:
		case SEMI:
		{
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == LBRACK)) {
					dimension();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop110;
				}
				
			}
			_loop110:;
			} // ( ... )*
			break;
		}
		case ASSIGN:
		{
			match(ASSIGN);
			constant_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			variable_type_AST = RefVerAST(currentAST.root);
#line 934 "verilog.parser.g"
			variable_type_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(VARIABLE_TYPE,"VARIABLE_TYPE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(variable_type_AST))));
#line 6631 "VerilogParser.cpp"
			currentAST.root = variable_type_AST;
			if ( variable_type_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				variable_type_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = variable_type_AST->getFirstChild();
			else
				currentAST.child = variable_type_AST;
			currentAST.advanceChildToEnd();
		}
		variable_type_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 937 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6652 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = variable_type_AST;
}

void VerilogParser::variable_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST variable_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		variable_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4918 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6682 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = variable_identifier_AST;
}

void VerilogParser::dimension() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST dimension_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(LBRACK);
		dimension_constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COLON);
		dimension_constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RBRACK);
		if ( inputState->guessing==0 ) {
			dimension_AST = RefVerAST(currentAST.root);
#line 1326 "verilog.parser.g"
			dimension_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(DIMENSION,"DIMENSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(dimension_AST))));
#line 6711 "VerilogParser.cpp"
			currentAST.root = dimension_AST;
			if ( dimension_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				dimension_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = dimension_AST->getFirstChild();
			else
				currentAST.child = dimension_AST;
			currentAST.advanceChildToEnd();
		}
		dimension_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1329 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6732 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = dimension_AST;
}

void VerilogParser::constant_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST constant_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		constant_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5088 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6762 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = constant_expression_AST;
}

void VerilogParser::strength0() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST strength0_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_SUPPLY0:
		{
			RefVerAST tmp223_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp223_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp223_AST));
			}
			match(K_SUPPLY0);
			break;
		}
		case K_STRONG0:
		{
			RefVerAST tmp224_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp224_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp224_AST));
			}
			match(K_STRONG0);
			break;
		}
		case K_PULL0:
		{
			RefVerAST tmp225_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp225_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp225_AST));
			}
			match(K_PULL0);
			break;
		}
		case K_WEAK0:
		{
			RefVerAST tmp226_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp226_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp226_AST));
			}
			match(K_WEAK0);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		strength0_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 966 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6836 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = strength0_AST;
}

void VerilogParser::strength1() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST strength1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_SUPPLY1:
		{
			RefVerAST tmp227_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp227_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp227_AST));
			}
			match(K_SUPPLY1);
			break;
		}
		case K_STRONG1:
		{
			RefVerAST tmp228_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp228_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp228_AST));
			}
			match(K_STRONG1);
			break;
		}
		case K_PULL1:
		{
			RefVerAST tmp229_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp229_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp229_AST));
			}
			match(K_PULL1);
			break;
		}
		case K_WEAK1:
		{
			RefVerAST tmp230_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp230_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp230_AST));
			}
			match(K_WEAK1);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		strength1_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 978 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6910 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = strength1_AST;
}

void VerilogParser::highz1() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST highz1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp231_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp231_AST = astFactory->create(LT(1));
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp231_AST));
		}
		match(K_HIGHZ1);
		highz1_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1002 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6942 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = highz1_AST;
}

void VerilogParser::highz0() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST highz0_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp232_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp232_AST = astFactory->create(LT(1));
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp232_AST));
		}
		match(K_HIGHZ0);
		highz0_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 990 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 6974 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = highz0_AST;
}

void VerilogParser::delay_value() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST delay_value_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		{
			unsigned_number();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case REAL_NUMBER:
		{
			real_number();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			delay_value_AST = RefVerAST(currentAST.root);
#line 1066 "verilog.parser.g"
			delay_value_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(DELAY_VALUE,"DELAY_VALUE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(delay_value_AST))));
#line 7025 "VerilogParser.cpp"
			currentAST.root = delay_value_AST;
			if ( delay_value_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				delay_value_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = delay_value_AST->getFirstChild();
			else
				currentAST.child = delay_value_AST;
			currentAST.advanceChildToEnd();
		}
		delay_value_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1069 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7046 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = delay_value_AST;
}

void VerilogParser::mintypmax_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST mintypmax_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COLON:
		{
			match(COLON);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COLON);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case COMMA:
		case RBRACK:
		case RPAREN:
		case SEMI:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			mintypmax_expression_AST = RefVerAST(currentAST.root);
#line 4282 "verilog.parser.g"
			mintypmax_expression_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MINTYPMAX_EXPRESSION,"MINTYPMAX_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(mintypmax_expression_AST))));
#line 7097 "VerilogParser.cpp"
			currentAST.root = mintypmax_expression_AST;
			if ( mintypmax_expression_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				mintypmax_expression_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = mintypmax_expression_AST->getFirstChild();
			else
				currentAST.child = mintypmax_expression_AST;
			currentAST.advanceChildToEnd();
		}
		mintypmax_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4285 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7118 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = mintypmax_expression_AST;
}

void VerilogParser::delay2() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST delay2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(POUND);
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			delay_value();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			match(LPAREN);
			mintypmax_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				mintypmax_expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			match(RPAREN);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			delay2_AST = RefVerAST(currentAST.root);
#line 1050 "verilog.parser.g"
			delay2_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(DELAY,"DELAY")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(delay2_AST))));
#line 7187 "VerilogParser.cpp"
			currentAST.root = delay2_AST;
			if ( delay2_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				delay2_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = delay2_AST->getFirstChild();
			else
				currentAST.child = delay2_AST;
			currentAST.advanceChildToEnd();
		}
		delay2_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1053 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7208 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = delay2_AST;
}

void VerilogParser::unsigned_number() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST unsigned_number_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST tok_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		tok = LT(1);
		if ( inputState->guessing == 0 ) {
			tok_AST = astFactory->create(tok);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok_AST));
		}
		match(UNSIGNED_NUMBER);
		if ( inputState->guessing==0 ) {
			unsigned_number_AST = RefVerAST(currentAST.root);
#line 4610 "verilog.parser.g"
			VerilogToken *vt = static_cast<VerilogToken*>(tok.get()); unsigned_number_AST->setNumber(vt->getNumber());
#line 7234 "VerilogParser.cpp"
		}
		unsigned_number_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4613 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7248 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = unsigned_number_AST;
}

void VerilogParser::real_number() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST real_number_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST tok_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		tok = LT(1);
		if ( inputState->guessing == 0 ) {
			tok_AST = astFactory->create(tok);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok_AST));
		}
		match(REAL_NUMBER);
		if ( inputState->guessing==0 ) {
			real_number_AST = RefVerAST(currentAST.root);
#line 4636 "verilog.parser.g"
			VerilogToken *vt = static_cast<VerilogToken*>(tok.get()); real_number_AST->setNumber(vt->getNumber());
#line 7274 "VerilogParser.cpp"
		}
		real_number_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4639 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7288 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = real_number_AST;
}

void VerilogParser::identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		{
			RefVerAST tmp239_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp239_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp239_AST));
			}
			match(IDENTIFIER);
			break;
		}
		case ESCAPED_IDENTIFIER:
		{
			RefVerAST tmp240_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp240_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp240_AST));
			}
			match(ESCAPED_IDENTIFIER);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4719 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7342 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = identifier_AST;
}

void VerilogParser::net_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST net_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		net_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4906 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7372 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = net_identifier_AST;
}

void VerilogParser::expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		conditional_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			expression_AST = RefVerAST(currentAST.root);
#line 4312 "verilog.parser.g"
			expression_AST =RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EXPRESSION,"EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expression_AST))));
#line 7394 "VerilogParser.cpp"
			currentAST.root = expression_AST;
			if ( expression_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				expression_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = expression_AST->getFirstChild();
			else
				currentAST.child = expression_AST;
			currentAST.advanceChildToEnd();
		}
		expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4315 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7415 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = expression_AST;
}

void VerilogParser::event_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST event_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		event_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4930 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7445 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = event_identifier_AST;
}

void VerilogParser::genvar_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST genvar_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		genvar_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4942 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7475 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = genvar_identifier_AST;
}

void VerilogParser::defparam_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST defparam_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		hierarchical_parameter_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(ASSIGN);
		constant_mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			defparam_assignment_AST = RefVerAST(currentAST.root);
#line 1226 "verilog.parser.g"
			defparam_assignment_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(DEFPARAM_ASSIGNMENT,"DEFPARAM_ASSIGNMENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(defparam_assignment_AST))));
#line 7502 "VerilogParser.cpp"
			currentAST.root = defparam_assignment_AST;
			if ( defparam_assignment_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				defparam_assignment_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = defparam_assignment_AST->getFirstChild();
			else
				currentAST.child = defparam_assignment_AST;
			currentAST.advanceChildToEnd();
		}
		defparam_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1229 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7523 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = defparam_assignment_AST;
}

void VerilogParser::specparam_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST specparam_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			param_assignment();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			specparam_assignment_AST = RefVerAST(currentAST.root);
			break;
		}
		case PATHPULSE:
		{
			pulse_control_specparam();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			specparam_assignment_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1257 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7573 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = specparam_assignment_AST;
}

void VerilogParser::list_of_variable_port_identifiers() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_variable_port_identifiers_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1183 "verilog.parser.g"
	TBool dummy;
#line 7587 "VerilogParser.cpp"
	
	try {      // for error handling
		dummy=variable_port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				dummy=variable_port_identifier();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop166;
			}
			
		}
		_loop166:;
		} // ( ... )*
		if ( inputState->guessing==0 ) {
			list_of_variable_port_identifiers_AST = RefVerAST(currentAST.root);
#line 1187 "verilog.parser.g"
			
			list_of_variable_port_identifiers_AST = 
			RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(LIST_OF_VARIABLE_PORT_IDENTIFIERS,"LIST_OF_VARIABLE_PORT_IDENTIFIERS")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(list_of_variable_port_identifiers_AST)))); 
			
#line 7617 "VerilogParser.cpp"
			currentAST.root = list_of_variable_port_identifiers_AST;
			if ( list_of_variable_port_identifiers_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				list_of_variable_port_identifiers_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = list_of_variable_port_identifiers_AST->getFirstChild();
			else
				currentAST.child = list_of_variable_port_identifiers_AST;
			currentAST.advanceChildToEnd();
		}
		list_of_variable_port_identifiers_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1193 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7638 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_variable_port_identifiers_AST;
}

void VerilogParser::hierarchical_parameter_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST hierarchical_parameter_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		hierarchical_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		hierarchical_parameter_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4846 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7668 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = hierarchical_parameter_identifier_AST;
}

void VerilogParser::constant_mintypmax_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST constant_mintypmax_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		constant_mintypmax_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5112 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7698 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = constant_mintypmax_expression_AST;
}

void VerilogParser::parameter_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST parameter_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		parameter_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4882 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7728 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = parameter_identifier_AST;
}

void VerilogParser::pulse_control_specparam() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pulse_control_specparam_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  pp = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST pp_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST cre1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  stn = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST stn_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST cre2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  assn = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST assn_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST cme1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST cme2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1265 "verilog.parser.g"
	CVerStringTokenizerDollar *x;
#line 7752 "VerilogParser.cpp"
	
	try {      // for error handling
		if ( inputState->guessing==0 ) {
			pulse_control_specparam_AST = RefVerAST(currentAST.root);
#line 1267 "verilog.parser.g"
			pulse_control_specparam_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PULSE_CONTROL_SPECPARAM,"PULSE_CONTROL_SPECPARAM")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(pulse_control_specparam_AST))));
#line 7759 "VerilogParser.cpp"
			currentAST.root = pulse_control_specparam_AST;
			if ( pulse_control_specparam_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				pulse_control_specparam_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = pulse_control_specparam_AST->getFirstChild();
			else
				currentAST.child = pulse_control_specparam_AST;
			currentAST.advanceChildToEnd();
		}
		pp = LT(1);
		if ( inputState->guessing == 0 ) {
			pp_AST = astFactory->create(pp);
		}
		match(PATHPULSE);
		if ( inputState->guessing==0 ) {
#line 1269 "verilog.parser.g"
			x = new CVerStringTokenizerDollar( string( pp_AST->getText() ) );
#line 7776 "VerilogParser.cpp"
		}
		if (!( x->getCount() < 4 && x->getCount() > 0 ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" x->getCount() < 4 && x->getCount() > 0 ");
		{
		if (((LA(1) == ASSIGN || LA(1) == LBRACK || LA(1) == SYSTEM_TASK_NAME))&&( x->getCount() > 1 && (*x)[1].length() > 0 )) {
			if ( inputState->guessing==0 ) {
				pulse_control_specparam_AST = RefVerAST(currentAST.root);
#line 1272 "verilog.parser.g"
				
				pulse_control_specparam_AST->addChild( RefVerAST( astFactory->create(IDENTIFIER,x->getCharStr(1)) ) );
				if( x->getCount() > 2 ){
				pulse_control_specparam_AST->addChild( RefVerAST( astFactory->create(IDENTIFIER,x->getCharStr(2)) ) );
				}
				
#line 7791 "VerilogParser.cpp"
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				match(LBRACK);
				constant_range_expression();
				if (inputState->guessing==0) {
					cre1_AST = returnAST;
				}
				if ( inputState->guessing==0 ) {
					pulse_control_specparam_AST = RefVerAST(currentAST.root);
#line 1280 "verilog.parser.g"
					pulse_control_specparam_AST->addChild( cre1_AST );
#line 7806 "VerilogParser.cpp"
				}
				match(RBRACK);
				break;
			}
			case ASSIGN:
			case SYSTEM_TASK_NAME:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			if (((LA(1) == SYSTEM_TASK_NAME))&&( x->getCount() == 2 )) {
				stn = LT(1);
				if ( inputState->guessing == 0 ) {
					stn_AST = astFactory->create(stn);
				}
				match(SYSTEM_TASK_NAME);
				if ( inputState->guessing==0 ) {
					pulse_control_specparam_AST = RefVerAST(currentAST.root);
#line 1286 "verilog.parser.g"
					
					CVerStringTokenizerDollar temp( string(stn_AST->getText()) );
					pulse_control_specparam_AST->addChild( RefVerAST( astFactory->create(IDENTIFIER,temp.getCharStr(1)) ) );
					
#line 7836 "VerilogParser.cpp"
				}
				{
				switch ( LA(1)) {
				case LBRACK:
				{
					match(LBRACK);
					constant_range_expression();
					if (inputState->guessing==0) {
						cre2_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
						pulse_control_specparam_AST = RefVerAST(currentAST.root);
#line 1292 "verilog.parser.g"
						pulse_control_specparam_AST->addChild( cre2_AST );
#line 7851 "VerilogParser.cpp"
					}
					match(RBRACK);
					break;
				}
				case ASSIGN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else if ((LA(1) == ASSIGN)) {
			}
			else {
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			
			}
		}
		else if ((LA(1) == ASSIGN)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		assn = LT(1);
		if ( inputState->guessing == 0 ) {
			assn_AST = astFactory->create(assn);
		}
		match(ASSIGN);
		if ( inputState->guessing==0 ) {
			pulse_control_specparam_AST = RefVerAST(currentAST.root);
#line 1298 "verilog.parser.g"
			pulse_control_specparam_AST->addChild( assn_AST );
#line 7891 "VerilogParser.cpp"
		}
		match(LPAREN);
		constant_mintypmax_expression();
		if (inputState->guessing==0) {
			cme1_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			pulse_control_specparam_AST = RefVerAST(currentAST.root);
#line 1302 "verilog.parser.g"
			pulse_control_specparam_AST->addChild( cme1_AST );
#line 7902 "VerilogParser.cpp"
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			match(COMMA);
			constant_mintypmax_expression();
			if (inputState->guessing==0) {
				cme2_AST = returnAST;
			}
			if ( inputState->guessing==0 ) {
				pulse_control_specparam_AST = RefVerAST(currentAST.root);
#line 1305 "verilog.parser.g"
				pulse_control_specparam_AST->addChild( cme2_AST );
#line 7917 "VerilogParser.cpp"
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		pulse_control_specparam_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1311 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7944 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pulse_control_specparam_AST;
}

void VerilogParser::dimension_constant_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST dimension_constant_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		dimension_constant_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5052 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 7974 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = dimension_constant_expression_AST;
}

void VerilogParser::lsb_constant_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST lsb_constant_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		lsb_constant_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5076 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8004 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = lsb_constant_expression_AST;
}

void VerilogParser::msb_constant_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST msb_constant_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		msb_constant_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5064 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8034 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = msb_constant_expression_AST;
}

void VerilogParser::range_or_type() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST range_or_type_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case LBRACK:
		{
			range();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			range_or_type_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_INTEGER:
		{
			RefVerAST tmp250_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp250_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp250_AST));
			}
			match(K_INTEGER);
			range_or_type_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_REAL:
		{
			RefVerAST tmp251_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp251_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp251_AST));
			}
			match(K_REAL);
			range_or_type_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_REALTIME:
		{
			RefVerAST tmp252_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp252_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp252_AST));
			}
			match(K_REALTIME);
			range_or_type_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_TIME:
		{
			RefVerAST tmp253_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp253_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp253_AST));
			}
			match(K_TIME);
			range_or_type_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1446 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8118 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = range_or_type_AST;
}

void VerilogParser::function_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST function_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		function_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4978 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8148 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = function_identifier_AST;
}

void VerilogParser::function_item_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST function_item_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST tfid_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pid_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_EVENT:
		case K_INTEGER:
		case K_LOCALPARAM:
		case K_PARAMETER:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_TIME:
		{
			block_item_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			function_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_INPUT:
		{
			tf_input_declaration();
			if (inputState->guessing==0) {
				tfid_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					port_identifier();
					if (inputState->guessing==0) {
						pid_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 1401 "verilog.parser.g"
						RefVerAST(tfid_AST)->addChild(pid_AST);
#line 8199 "VerilogParser.cpp"
					}
				}
				else {
					goto _loop193;
				}
				
			}
			_loop193:;
			} // ( ... )*
			match(SEMI);
			function_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1406 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8229 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = function_item_declaration_AST;
}

void VerilogParser::function_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST function_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		statement();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		function_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2959 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8259 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = function_statement_AST;
}

void VerilogParser::function_port_list() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST function_port_list_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST tfid1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST tfid2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pid_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1414 "verilog.parser.g"
	RefVerAST tfid;
#line 8276 "VerilogParser.cpp"
	
	try {      // for error handling
		if ( inputState->guessing==0 ) {
			function_port_list_AST = RefVerAST(currentAST.root);
#line 1416 "verilog.parser.g"
			function_port_list_AST = astFactory->create(FUNCTION_PORT_LIST,"FUNCTION_PORT_LIST");
#line 8283 "VerilogParser.cpp"
			currentAST.root = function_port_list_AST;
			if ( function_port_list_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				function_port_list_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = function_port_list_AST->getFirstChild();
			else
				currentAST.child = function_port_list_AST;
			currentAST.advanceChildToEnd();
		}
		attrs_opt();
		tf_input_declaration();
		if (inputState->guessing==0) {
			tfid1_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			function_port_list_AST = RefVerAST(currentAST.root);
#line 1419 "verilog.parser.g"
			tfid = tfid1_AST; function_port_list_AST->addChild(tfid);
#line 8301 "VerilogParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				{
				switch ( LA(1)) {
				case K_INPUT:
				case PSTAR:
				{
					attrs_opt();
					tf_input_declaration();
					if (inputState->guessing==0) {
						tfid2_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
						function_port_list_AST = RefVerAST(currentAST.root);
#line 1423 "verilog.parser.g"
						tfid = tfid2_AST; function_port_list_AST->addChild(tfid);
#line 8321 "VerilogParser.cpp"
					}
					break;
				}
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				{
					port_identifier();
					if (inputState->guessing==0) {
						pid_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 1425 "verilog.parser.g"
						if (tfid) RefVerAST(tfid)->addChild(pid_AST);
#line 8335 "VerilogParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else {
				goto _loop197;
			}
			
		}
		_loop197:;
		} // ( ... )*
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1430 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8364 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = function_port_list_AST;
}

void VerilogParser::block_item_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST block_item_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_REG:
		{
			reg_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			block_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_INTEGER:
		{
			integer_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			block_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_TIME:
		{
			time_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			block_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_REAL:
		{
			real_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			block_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_REALTIME:
		{
			realtime_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			block_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_EVENT:
		{
			event_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			block_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_LOCALPARAM:
		{
			local_parameter_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			block_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_PARAMETER:
		{
			parameter_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			block_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1638 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8469 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = block_item_declaration_AST;
}

void VerilogParser::tf_input_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST tf_input_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp259_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp259_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp259_AST));
		}
		match(K_INPUT);
		{
		switch ( LA(1)) {
		case K_REG:
		case K_SIGNED:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			{
			switch ( LA(1)) {
			case K_REG:
			{
				RefVerAST tmp260_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp260_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp260_AST));
				}
				match(K_REG);
				break;
			}
			case K_SIGNED:
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp261_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp261_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp261_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_TIME:
		{
			task_port_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		tf_input_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1567 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8602 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = tf_input_declaration_AST;
}

void VerilogParser::task_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST task_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		task_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4966 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8632 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = task_identifier_AST;
}

void VerilogParser::task_item_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST task_item_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST tfid_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pid1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST tfod_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pid2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST tfiod_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pid3_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_EVENT:
		case K_INTEGER:
		case K_LOCALPARAM:
		case K_PARAMETER:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_TIME:
		{
			block_item_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			task_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_INPUT:
		{
			tf_input_declaration();
			if (inputState->guessing==0) {
				tfid_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					port_identifier();
					if (inputState->guessing==0) {
						pid1_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 1494 "verilog.parser.g"
						RefVerAST(tfid_AST)->addChild(pid1_AST);
#line 8687 "VerilogParser.cpp"
					}
				}
				else {
					goto _loop211;
				}
				
			}
			_loop211:;
			} // ( ... )*
			match(SEMI);
			task_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_OUTPUT:
		{
			tf_output_declaration();
			if (inputState->guessing==0) {
				tfod_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					port_identifier();
					if (inputState->guessing==0) {
						pid2_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 1500 "verilog.parser.g"
						RefVerAST(tfod_AST)->addChild(pid2_AST);
#line 8719 "VerilogParser.cpp"
					}
				}
				else {
					goto _loop213;
				}
				
			}
			_loop213:;
			} // ( ... )*
			match(SEMI);
			task_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_INOUT:
		{
			tf_inout_declaration();
			if (inputState->guessing==0) {
				tfiod_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					port_identifier();
					if (inputState->guessing==0) {
						pid3_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 1506 "verilog.parser.g"
						RefVerAST(tfiod_AST)->addChild(pid3_AST);
#line 8751 "VerilogParser.cpp"
					}
				}
				else {
					goto _loop215;
				}
				
			}
			_loop215:;
			} // ( ... )*
			match(SEMI);
			task_item_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1511 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8781 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = task_item_declaration_AST;
}

void VerilogParser::statement_or_null() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST statement_or_null_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		statement();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		}
		if ( inputState->guessing==0 ) {
			statement_or_null_AST = RefVerAST(currentAST.root);
#line 2944 "verilog.parser.g"
			statement_or_null_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(STATEMENT_OR_NULL,"STATEMENT_OR_NULL")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(statement_or_null_AST))));
#line 8805 "VerilogParser.cpp"
			currentAST.root = statement_or_null_AST;
			if ( statement_or_null_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				statement_or_null_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = statement_or_null_AST->getFirstChild();
			else
				currentAST.child = statement_or_null_AST;
			currentAST.advanceChildToEnd();
		}
		statement_or_null_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2947 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8826 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = statement_or_null_AST;
}

void VerilogParser::task_port_list() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST task_port_list_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST tpi1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST tpi2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pid_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1519 "verilog.parser.g"
	RefVerAST tpi;
#line 8843 "VerilogParser.cpp"
	
	try {      // for error handling
		if ( inputState->guessing==0 ) {
			task_port_list_AST = RefVerAST(currentAST.root);
#line 1521 "verilog.parser.g"
			task_port_list_AST = astFactory->create(TASK_PORT_LIST,"TASK_PORT_LIST");
#line 8850 "VerilogParser.cpp"
			currentAST.root = task_port_list_AST;
			if ( task_port_list_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				task_port_list_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = task_port_list_AST->getFirstChild();
			else
				currentAST.child = task_port_list_AST;
			currentAST.advanceChildToEnd();
		}
		task_port_item();
		if (inputState->guessing==0) {
			tpi1_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			task_port_list_AST = RefVerAST(currentAST.root);
#line 1523 "verilog.parser.g"
			tpi = tpi1_AST; task_port_list_AST->addChild(tpi);
#line 8867 "VerilogParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				{
				switch ( LA(1)) {
				case K_INOUT:
				case K_INPUT:
				case K_OUTPUT:
				case PSTAR:
				{
					task_port_item();
					if (inputState->guessing==0) {
						tpi2_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
						task_port_list_AST = RefVerAST(currentAST.root);
#line 1526 "verilog.parser.g"
						tpi = tpi2_AST; task_port_list_AST->addChild(tpi);
#line 8888 "VerilogParser.cpp"
					}
					break;
				}
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				{
					port_identifier();
					if (inputState->guessing==0) {
						pid_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 1528 "verilog.parser.g"
						if (tpi) RefVerAST(tpi)->addChild(pid_AST);
#line 8902 "VerilogParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else {
				goto _loop219;
			}
			
		}
		_loop219:;
		} // ( ... )*
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1533 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 8931 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = task_port_list_AST;
}

void VerilogParser::tf_output_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST tf_output_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp269_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp269_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp269_AST));
		}
		match(K_OUTPUT);
		{
		switch ( LA(1)) {
		case K_REG:
		case K_SIGNED:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			{
			switch ( LA(1)) {
			case K_REG:
			{
				RefVerAST tmp270_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp270_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp270_AST));
				}
				match(K_REG);
				break;
			}
			case K_SIGNED:
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp271_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp271_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp271_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_TIME:
		{
			task_port_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		tf_output_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1585 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9064 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = tf_output_declaration_AST;
}

void VerilogParser::tf_inout_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST tf_inout_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp272_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp272_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp272_AST));
		}
		match(K_INOUT);
		{
		switch ( LA(1)) {
		case K_REG:
		case K_SIGNED:
		case LBRACK:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			{
			switch ( LA(1)) {
			case K_REG:
			{
				RefVerAST tmp273_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp273_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp273_AST));
				}
				match(K_REG);
				break;
			}
			case K_SIGNED:
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case K_SIGNED:
			{
				RefVerAST tmp274_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp274_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp274_AST));
				}
				match(K_SIGNED);
				break;
			}
			case LBRACK:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case LBRACK:
			{
				range();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_TIME:
		{
			task_port_type();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		tf_inout_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1603 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9197 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = tf_inout_declaration_AST;
}

void VerilogParser::task_port_item() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST task_port_item_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case K_INPUT:
		{
			tf_input_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_OUTPUT:
		{
			tf_output_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_INOUT:
		{
			tf_inout_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		task_port_item_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1549 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9259 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = task_port_item_AST;
}

void VerilogParser::task_port_type() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST task_port_type_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_INTEGER:
		{
			RefVerAST tmp275_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp275_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp275_AST));
			}
			match(K_INTEGER);
			task_port_type_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_REAL:
		{
			RefVerAST tmp276_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp276_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp276_AST));
			}
			match(K_REAL);
			task_port_type_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_REALTIME:
		{
			RefVerAST tmp277_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp277_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp277_AST));
			}
			match(K_REALTIME);
			task_port_type_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_TIME:
		{
			RefVerAST tmp278_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp278_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp278_AST));
			}
			match(K_TIME);
			task_port_type_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1618 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9334 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = task_port_type_AST;
}

void VerilogParser::cmos_switchtype() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST cmos_switchtype_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_CMOS:
		{
			RefVerAST tmp279_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp279_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp279_AST));
			}
			match(K_CMOS);
			cmos_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_RCMOS:
		{
			RefVerAST tmp280_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp280_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp280_AST));
			}
			match(K_RCMOS);
			cmos_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1963 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9387 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = cmos_switchtype_AST;
}

void VerilogParser::cmos_switch_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST cmos_switch_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		output_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		input_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		ncontrol_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		pcontrol_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			cmos_switch_instance_AST = RefVerAST(currentAST.root);
#line 1701 "verilog.parser.g"
			cmos_switch_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CMOS_SWITCH_INSTANCE,"CMOS_SWITCH_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(cmos_switch_instance_AST))));
#line 9447 "VerilogParser.cpp"
			currentAST.root = cmos_switch_instance_AST;
			if ( cmos_switch_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				cmos_switch_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = cmos_switch_instance_AST->getFirstChild();
			else
				currentAST.child = cmos_switch_instance_AST;
			currentAST.advanceChildToEnd();
		}
		cmos_switch_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1704 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9468 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = cmos_switch_instance_AST;
}

void VerilogParser::enable_gatetype() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST enable_gatetype_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_BUFIF0:
		{
			RefVerAST tmp286_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp286_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp286_AST));
			}
			match(K_BUFIF0);
			enable_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_BUFIF1:
		{
			RefVerAST tmp287_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp287_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp287_AST));
			}
			match(K_BUFIF1);
			enable_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NOTIF0:
		{
			RefVerAST tmp288_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp288_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp288_AST));
			}
			match(K_NOTIF0);
			enable_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NOTIF1:
		{
			RefVerAST tmp289_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp289_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp289_AST));
			}
			match(K_NOTIF1);
			enable_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1975 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9543 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = enable_gatetype_AST;
}

void VerilogParser::enable_gate_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST enable_gate_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		output_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		input_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		enable_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			enable_gate_instance_AST = RefVerAST(currentAST.root);
#line 1721 "verilog.parser.g"
			enable_gate_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ENABLE_GATE_INSTANCE,"ENABLE_GATE_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(enable_gate_instance_AST))));
#line 9598 "VerilogParser.cpp"
			currentAST.root = enable_gate_instance_AST;
			if ( enable_gate_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				enable_gate_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = enable_gate_instance_AST->getFirstChild();
			else
				currentAST.child = enable_gate_instance_AST;
			currentAST.advanceChildToEnd();
		}
		enable_gate_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1724 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9619 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = enable_gate_instance_AST;
}

void VerilogParser::mos_switchtype() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST mos_switchtype_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_NMOS:
		{
			RefVerAST tmp294_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp294_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp294_AST));
			}
			match(K_NMOS);
			mos_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_PMOS:
		{
			RefVerAST tmp295_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp295_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp295_AST));
			}
			match(K_PMOS);
			mos_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_RNMOS:
		{
			RefVerAST tmp296_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp296_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp296_AST));
			}
			match(K_RNMOS);
			mos_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_RPMOS:
		{
			RefVerAST tmp297_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp297_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp297_AST));
			}
			match(K_RPMOS);
			mos_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1987 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9694 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = mos_switchtype_AST;
}

void VerilogParser::mos_switch_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST mos_switch_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		output_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		input_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		enable_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			mos_switch_instance_AST = RefVerAST(currentAST.root);
#line 1741 "verilog.parser.g"
			mos_switch_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MOS_SWITCH_INSTANCE,"MOS_SWITCH_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(mos_switch_instance_AST))));
#line 9749 "VerilogParser.cpp"
			currentAST.root = mos_switch_instance_AST;
			if ( mos_switch_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				mos_switch_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = mos_switch_instance_AST->getFirstChild();
			else
				currentAST.child = mos_switch_instance_AST;
			currentAST.advanceChildToEnd();
		}
		mos_switch_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1744 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9770 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = mos_switch_instance_AST;
}

void VerilogParser::n_input_gatetype() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST n_input_gatetype_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_AND:
		{
			RefVerAST tmp302_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp302_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp302_AST));
			}
			match(K_AND);
			n_input_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NAND:
		{
			RefVerAST tmp303_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp303_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp303_AST));
			}
			match(K_NAND);
			n_input_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_OR:
		{
			RefVerAST tmp304_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp304_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp304_AST));
			}
			match(K_OR);
			n_input_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NOR:
		{
			RefVerAST tmp305_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp305_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp305_AST));
			}
			match(K_NOR);
			n_input_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_XOR:
		{
			RefVerAST tmp306_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp306_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp306_AST));
			}
			match(K_XOR);
			n_input_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_XNOR:
		{
			RefVerAST tmp307_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp307_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp307_AST));
			}
			match(K_XNOR);
			n_input_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1999 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9867 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = n_input_gatetype_AST;
}

void VerilogParser::n_input_gate_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST n_input_gate_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		output_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		input_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				input_terminal();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop289;
			}
			
		}
		_loop289:;
		} // ( ... )*
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			n_input_gate_instance_AST = RefVerAST(currentAST.root);
#line 1760 "verilog.parser.g"
			n_input_gate_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(N_INPUT_GATE_INSTANCE,"N_INPUT_GATE_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(n_input_gate_instance_AST))));
#line 9933 "VerilogParser.cpp"
			currentAST.root = n_input_gate_instance_AST;
			if ( n_input_gate_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				n_input_gate_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = n_input_gate_instance_AST->getFirstChild();
			else
				currentAST.child = n_input_gate_instance_AST;
			currentAST.advanceChildToEnd();
		}
		n_input_gate_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1763 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 9954 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = n_input_gate_instance_AST;
}

void VerilogParser::n_output_gatetype() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST n_output_gatetype_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_BUF:
		{
			RefVerAST tmp312_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp312_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp312_AST));
			}
			match(K_BUF);
			n_output_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NOT:
		{
			RefVerAST tmp313_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp313_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp313_AST));
			}
			match(K_NOT);
			n_output_gatetype_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2011 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10007 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = n_output_gatetype_AST;
}

void VerilogParser::n_output_gate_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST n_output_gate_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		output_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )+
		int _cnt293=0;
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				input_terminal();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				if ( _cnt293>=1 ) { goto _loop293; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt293++;
		}
		_loop293:;
		}  // ( ... )+
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			n_output_gate_instance_AST = RefVerAST(currentAST.root);
#line 1778 "verilog.parser.g"
			n_output_gate_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(N_OUTPUT_GATE_INSTANCE,"N_OUTPUT_GATE_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(n_output_gate_instance_AST))));
#line 10070 "VerilogParser.cpp"
			currentAST.root = n_output_gate_instance_AST;
			if ( n_output_gate_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				n_output_gate_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = n_output_gate_instance_AST->getFirstChild();
			else
				currentAST.child = n_output_gate_instance_AST;
			currentAST.advanceChildToEnd();
		}
		n_output_gate_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1781 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10091 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = n_output_gate_instance_AST;
}

void VerilogParser::pass_enable_switchtype() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pass_enable_switchtype_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_TRANIF0:
		{
			RefVerAST tmp317_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp317_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp317_AST));
			}
			match(K_TRANIF0);
			pass_enable_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_TRANIF1:
		{
			RefVerAST tmp318_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp318_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp318_AST));
			}
			match(K_TRANIF1);
			pass_enable_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_RTRANIF1:
		{
			RefVerAST tmp319_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp319_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp319_AST));
			}
			match(K_RTRANIF1);
			pass_enable_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_RTRANIF0:
		{
			RefVerAST tmp320_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp320_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp320_AST));
			}
			match(K_RTRANIF0);
			pass_enable_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2023 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10166 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pass_enable_switchtype_AST;
}

void VerilogParser::pass_enable_switch_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pass_enable_switch_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		inout_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		inout_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		enable_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			pass_enable_switch_instance_AST = RefVerAST(currentAST.root);
#line 1798 "verilog.parser.g"
			pass_enable_switch_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PASS_ENABLE_SWITCH_INSTANCE,"PASS_ENABLE_SWITCH_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(pass_enable_switch_instance_AST))));
#line 10221 "VerilogParser.cpp"
			currentAST.root = pass_enable_switch_instance_AST;
			if ( pass_enable_switch_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				pass_enable_switch_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = pass_enable_switch_instance_AST->getFirstChild();
			else
				currentAST.child = pass_enable_switch_instance_AST;
			currentAST.advanceChildToEnd();
		}
		pass_enable_switch_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1801 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10242 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pass_enable_switch_instance_AST;
}

void VerilogParser::pass_switchtype() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pass_switchtype_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_TRAN:
		{
			RefVerAST tmp325_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp325_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp325_AST));
			}
			match(K_TRAN);
			pass_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_RTRAN:
		{
			RefVerAST tmp326_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp326_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp326_AST));
			}
			match(K_RTRAN);
			pass_switchtype_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2035 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10295 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pass_switchtype_AST;
}

void VerilogParser::pass_switch_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pass_switch_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		inout_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		inout_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			pass_switch_instance_AST = RefVerAST(currentAST.root);
#line 1816 "verilog.parser.g"
			pass_switch_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PASS_SWITCH_INSTANCE,"PASS_SWITCH_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(pass_switch_instance_AST))));
#line 10345 "VerilogParser.cpp"
			currentAST.root = pass_switch_instance_AST;
			if ( pass_switch_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				pass_switch_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = pass_switch_instance_AST->getFirstChild();
			else
				currentAST.child = pass_switch_instance_AST;
			currentAST.advanceChildToEnd();
		}
		pass_switch_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1819 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10366 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pass_switch_instance_AST;
}

void VerilogParser::pulldown_strength() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pulldown_strength_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_PULL0:
		case K_STRONG0:
		case K_SUPPLY0:
		case K_WEAK0:
		{
			strength0();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				strength1();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case K_PULL1:
		case K_STRONG1:
		case K_SUPPLY1:
		case K_WEAK1:
		{
			strength1();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COMMA);
			strength0();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		pulldown_strength_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1863 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10448 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pulldown_strength_AST;
}

void VerilogParser::pull_gate_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pull_gate_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_gate_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		output_terminal();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			pull_gate_instance_AST = RefVerAST(currentAST.root);
#line 1832 "verilog.parser.g"
			pull_gate_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PULL_GATE_INSTANCE,"PULL_GATE_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(pull_gate_instance_AST))));
#line 10493 "VerilogParser.cpp"
			currentAST.root = pull_gate_instance_AST;
			if ( pull_gate_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				pull_gate_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = pull_gate_instance_AST->getFirstChild();
			else
				currentAST.child = pull_gate_instance_AST;
			currentAST.advanceChildToEnd();
		}
		pull_gate_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1835 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10514 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pull_gate_instance_AST;
}

void VerilogParser::pullup_strength() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pullup_strength_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_PULL0:
		case K_STRONG0:
		case K_SUPPLY0:
		case K_WEAK0:
		{
			strength0();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COMMA);
			strength1();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_PULL1:
		case K_STRONG1:
		case K_SUPPLY1:
		case K_WEAK1:
		{
			strength1();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				match(COMMA);
				strength0();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		pullup_strength_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1877 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10596 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pullup_strength_AST;
}

void VerilogParser::name_of_gate_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST name_of_gate_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		gate_instance_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			range();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		name_of_gate_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1848 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10646 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = name_of_gate_instance_AST;
}

void VerilogParser::output_terminal() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST output_terminal_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		net_lvalue();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		output_terminal_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1938 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10676 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = output_terminal_AST;
}

void VerilogParser::input_terminal() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST input_terminal_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		input_terminal_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1914 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10706 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = input_terminal_AST;
}

void VerilogParser::ncontrol_terminal() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST ncontrol_terminal_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		ncontrol_terminal_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1926 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10736 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = ncontrol_terminal_AST;
}

void VerilogParser::pcontrol_terminal() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pcontrol_terminal_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		pcontrol_terminal_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1950 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10766 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pcontrol_terminal_AST;
}

void VerilogParser::enable_terminal() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST enable_terminal_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		enable_terminal_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1890 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10796 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = enable_terminal_AST;
}

void VerilogParser::inout_terminal() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST inout_terminal_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		net_lvalue();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		inout_terminal_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 1902 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10826 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = inout_terminal_AST;
}

void VerilogParser::gate_instance_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST gate_instance_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		gate_instance_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4990 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10856 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = gate_instance_identifier_AST;
}

void VerilogParser::net_lvalue() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST net_lvalue_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		lvalue();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		net_lvalue_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4537 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10886 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = net_lvalue_AST;
}

void VerilogParser::parameter_value_assignment_or_delay2() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST parameter_value_assignment_or_delay2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(POUND);
		{
		match(LPAREN);
		list_of_parameter_assignments_or_delay2();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		}
		parameter_value_assignment_or_delay2_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2077 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10921 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = parameter_value_assignment_or_delay2_AST;
}

void VerilogParser::module_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			name_of_module_instance();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		list_of_port_connections();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			module_instance_AST = RefVerAST(currentAST.root);
#line 2137 "verilog.parser.g"
			module_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MODULE_INSTANCE,"MODULE_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(module_instance_AST))));
#line 10966 "VerilogParser.cpp"
			currentAST.root = module_instance_AST;
			if ( module_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				module_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = module_instance_AST->getFirstChild();
			else
				currentAST.child = module_instance_AST;
			currentAST.advanceChildToEnd();
		}
		module_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2140 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 10987 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_instance_AST;
}

void VerilogParser::list_of_parameter_assignments_or_delay2() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_parameter_assignments_or_delay2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			ordered_parameter_assignment();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					ordered_parameter_assignment();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop334;
				}
				
			}
			_loop334:;
			} // ( ... )*
			break;
		}
		case DOT:
		{
			named_parameter_assignment();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					named_parameter_assignment();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop336;
				}
				
			}
			_loop336:;
			} // ( ... )*
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			list_of_parameter_assignments_or_delay2_AST = RefVerAST(currentAST.root);
#line 2091 "verilog.parser.g"
			
			list_of_parameter_assignments_or_delay2_AST = 
			RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2,"LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(list_of_parameter_assignments_or_delay2_AST))));
			
#line 11082 "VerilogParser.cpp"
			currentAST.root = list_of_parameter_assignments_or_delay2_AST;
			if ( list_of_parameter_assignments_or_delay2_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				list_of_parameter_assignments_or_delay2_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = list_of_parameter_assignments_or_delay2_AST->getFirstChild();
			else
				currentAST.child = list_of_parameter_assignments_or_delay2_AST;
			currentAST.advanceChildToEnd();
		}
		list_of_parameter_assignments_or_delay2_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2097 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11103 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_parameter_assignments_or_delay2_AST;
}

void VerilogParser::ordered_parameter_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST ordered_parameter_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		ordered_parameter_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2111 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11133 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = ordered_parameter_assignment_AST;
}

void VerilogParser::named_parameter_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST named_parameter_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(DOT);
		parameter_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(LPAREN);
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			mintypmax_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			named_parameter_assignment_AST = RefVerAST(currentAST.root);
#line 2122 "verilog.parser.g"
			named_parameter_assignment_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(NAMED_PARAMETER_ASSIGNMENT,"NAMED_PARAMETER_ASSIGNMENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(named_parameter_assignment_AST))));
#line 11196 "VerilogParser.cpp"
			currentAST.root = named_parameter_assignment_AST;
			if ( named_parameter_assignment_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				named_parameter_assignment_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = named_parameter_assignment_AST->getFirstChild();
			else
				currentAST.child = named_parameter_assignment_AST;
			currentAST.advanceChildToEnd();
		}
		named_parameter_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2125 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11217 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = named_parameter_assignment_AST;
}

void VerilogParser::name_of_module_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST name_of_module_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		module_instance_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			range();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		name_of_module_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2153 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11267 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = name_of_module_instance_AST;
}

void VerilogParser::list_of_port_connections() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_port_connections_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case COMMA:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case RPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			ordered_port_connection();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					attrs_opt();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					ordered_port_connection();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop347;
				}
				
			}
			_loop347:;
			} // ( ... )*
			break;
		}
		case DOT:
		{
			named_port_connection();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					attrs_opt();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					named_port_connection();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop349;
				}
				
			}
			_loop349:;
			} // ( ... )*
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		list_of_port_connections_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2170 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11381 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_port_connections_AST;
}

void VerilogParser::module_instance_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_instance_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_instance_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5002 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11411 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_instance_identifier_AST;
}

void VerilogParser::ordered_port_connection() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST ordered_port_connection_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case COMMA:
		case RPAREN:
		{
			break;
		}
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			ordered_port_connection_AST = RefVerAST(currentAST.root);
#line 2182 "verilog.parser.g"
			ordered_port_connection_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ORDERED_PORT_CONNECTION,"ORDERED_PORT_CONNECTION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(ordered_port_connection_AST))));
#line 11468 "VerilogParser.cpp"
			currentAST.root = ordered_port_connection_AST;
			if ( ordered_port_connection_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				ordered_port_connection_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = ordered_port_connection_AST->getFirstChild();
			else
				currentAST.child = ordered_port_connection_AST;
			currentAST.advanceChildToEnd();
		}
		ordered_port_connection_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2185 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11489 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = ordered_port_connection_AST;
}

void VerilogParser::named_port_connection() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST named_port_connection_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(DOT);
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(LPAREN);
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			named_port_connection_AST = RefVerAST(currentAST.root);
#line 2199 "verilog.parser.g"
			named_port_connection_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(NAMED_PORT_CONNECTION,"NAMED_PORT_CONNECTION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(named_port_connection_AST))));
#line 11552 "VerilogParser.cpp"
			currentAST.root = named_port_connection_AST;
			if ( named_port_connection_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				named_port_connection_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = named_port_connection_AST->getFirstChild();
			else
				currentAST.child = named_port_connection_AST;
			currentAST.advanceChildToEnd();
		}
		named_port_connection_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2202 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11573 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = named_port_connection_AST;
}

void VerilogParser::generate_item() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST generate_item_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_IF:
		{
			generate_conditional_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_CASE:
		{
			generate_case_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_FOR:
		{
			generate_loop_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_BEGIN:
		{
			generate_block();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_ALWAYS:
		case K_AND:
		case K_ASSIGN:
		case K_BUF:
		case K_BUFIF0:
		case K_BUFIF1:
		case K_CMOS:
		case K_DEFPARAM:
		case K_EVENT:
		case K_FUNCTION:
		case K_GENVAR:
		case K_INITIAL:
		case K_INTEGER:
		case K_NAND:
		case K_NMOS:
		case K_NOR:
		case K_NOT:
		case K_NOTIF0:
		case K_NOTIF1:
		case K_OR:
		case K_PMOS:
		case K_PULLDOWN:
		case K_PULLUP:
		case K_RCMOS:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_RNMOS:
		case K_RPMOS:
		case K_RTRAN:
		case K_RTRANIF0:
		case K_RTRANIF1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TASK:
		case K_TIME:
		case K_TRAN:
		case K_TRANIF0:
		case K_TRANIF1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_TRIREG:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		case K_XNOR:
		case K_XOR:
		case PSTAR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			module_or_generate_item();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			generate_item_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2248 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11705 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = generate_item_AST;
}

void VerilogParser::generate_item_or_null() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST generate_item_or_null_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_ALWAYS:
		case K_AND:
		case K_ASSIGN:
		case K_BEGIN:
		case K_BUF:
		case K_BUFIF0:
		case K_BUFIF1:
		case K_CASE:
		case K_CMOS:
		case K_DEFPARAM:
		case K_EVENT:
		case K_FOR:
		case K_FUNCTION:
		case K_GENVAR:
		case K_IF:
		case K_INITIAL:
		case K_INTEGER:
		case K_NAND:
		case K_NMOS:
		case K_NOR:
		case K_NOT:
		case K_NOTIF0:
		case K_NOTIF1:
		case K_OR:
		case K_PMOS:
		case K_PULLDOWN:
		case K_PULLUP:
		case K_RCMOS:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_RNMOS:
		case K_RPMOS:
		case K_RTRAN:
		case K_RTRANIF0:
		case K_RTRANIF1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TASK:
		case K_TIME:
		case K_TRAN:
		case K_TRANIF0:
		case K_TRANIF1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_TRIREG:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		case K_XNOR:
		case K_XOR:
		case PSTAR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			generate_item();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case SEMI:
		{
			match(SEMI);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			generate_item_or_null_AST = RefVerAST(currentAST.root);
#line 2229 "verilog.parser.g"
			generate_item_or_null_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(GENERATE_ITEM_OR_NULL,"GENERATE_ITEM_OR_NULL")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(generate_item_or_null_AST))));
#line 11800 "VerilogParser.cpp"
			currentAST.root = generate_item_or_null_AST;
			if ( generate_item_or_null_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				generate_item_or_null_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = generate_item_or_null_AST->getFirstChild();
			else
				currentAST.child = generate_item_or_null_AST;
			currentAST.advanceChildToEnd();
		}
		generate_item_or_null_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2232 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11821 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = generate_item_or_null_AST;
}

void VerilogParser::generate_conditional_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST generate_conditional_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp352_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp352_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp352_AST));
		}
		match(K_IF);
		match(LPAREN);
		constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		generate_item_or_null();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		if ((LA(1) == K_ELSE)) {
			match(K_ELSE);
			generate_item_or_null();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
		}
		else if ((_tokenSet_9.member(LA(1)))) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		generate_conditional_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2267 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11878 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = generate_conditional_statement_AST;
}

void VerilogParser::generate_case_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST generate_case_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp356_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp356_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp356_AST));
		}
		match(K_CASE);
		match(LPAREN);
		constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		{ // ( ... )+
		int _cnt364=0;
		for (;;) {
			if ((_tokenSet_10.member(LA(1)))) {
				genvar_case_item();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				if ( _cnt364>=1 ) { goto _loop364; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt364++;
		}
		_loop364:;
		}  // ( ... )+
		match(K_ENDCASE);
		generate_case_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2284 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 11934 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = generate_case_statement_AST;
}

void VerilogParser::generate_loop_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST generate_loop_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp360_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp360_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp360_AST));
		}
		match(K_FOR);
		match(LPAREN);
		genvar_assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		genvar_assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		match(K_BEGIN);
		match(COLON);
		generate_block_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_4.member(LA(1)))) {
				generate_item();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop372;
			}
			
		}
		_loop372:;
		} // ( ... )*
		match(K_END);
		generate_loop_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2325 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12004 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = generate_loop_statement_AST;
}

void VerilogParser::generate_block() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST generate_block_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(K_BEGIN);
		{
		switch ( LA(1)) {
		case COLON:
		{
			match(COLON);
			generate_block_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_ALWAYS:
		case K_AND:
		case K_ASSIGN:
		case K_BEGIN:
		case K_BUF:
		case K_BUFIF0:
		case K_BUFIF1:
		case K_CASE:
		case K_CMOS:
		case K_DEFPARAM:
		case K_END:
		case K_EVENT:
		case K_FOR:
		case K_FUNCTION:
		case K_GENVAR:
		case K_IF:
		case K_INITIAL:
		case K_INTEGER:
		case K_NAND:
		case K_NMOS:
		case K_NOR:
		case K_NOT:
		case K_NOTIF0:
		case K_NOTIF1:
		case K_OR:
		case K_PMOS:
		case K_PULLDOWN:
		case K_PULLUP:
		case K_RCMOS:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_RNMOS:
		case K_RPMOS:
		case K_RTRAN:
		case K_RTRANIF0:
		case K_RTRANIF1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TASK:
		case K_TIME:
		case K_TRAN:
		case K_TRANIF0:
		case K_TRANIF1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_TRIREG:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		case K_XNOR:
		case K_XOR:
		case PSTAR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_4.member(LA(1)))) {
				generate_item();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop377;
			}
			
		}
		_loop377:;
		} // ( ... )*
		match(K_END);
		if ( inputState->guessing==0 ) {
			generate_block_AST = RefVerAST(currentAST.root);
#line 2353 "verilog.parser.g"
			generate_block_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(GENERATE_BLOCK,"GENERATE_BLOCK")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(generate_block_AST))));
#line 12117 "VerilogParser.cpp"
			currentAST.root = generate_block_AST;
			if ( generate_block_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				generate_block_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = generate_block_AST->getFirstChild();
			else
				currentAST.child = generate_block_AST;
			currentAST.advanceChildToEnd();
		}
		generate_block_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2356 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12138 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = generate_block_AST;
}

void VerilogParser::genvar_case_item() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST genvar_case_item_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			constant_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					constant_expression();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop368;
				}
				
			}
			_loop368:;
			} // ( ... )*
			match(COLON);
			break;
		}
		case K_DEFAULT:
		{
			RefVerAST tmp373_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp373_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp373_AST));
			}
			match(K_DEFAULT);
			{
			switch ( LA(1)) {
			case COLON:
			{
				match(COLON);
				break;
			}
			case K_ALWAYS:
			case K_AND:
			case K_ASSIGN:
			case K_BEGIN:
			case K_BUF:
			case K_BUFIF0:
			case K_BUFIF1:
			case K_CASE:
			case K_CMOS:
			case K_DEFPARAM:
			case K_EVENT:
			case K_FOR:
			case K_FUNCTION:
			case K_GENVAR:
			case K_IF:
			case K_INITIAL:
			case K_INTEGER:
			case K_NAND:
			case K_NMOS:
			case K_NOR:
			case K_NOT:
			case K_NOTIF0:
			case K_NOTIF1:
			case K_OR:
			case K_PMOS:
			case K_PULLDOWN:
			case K_PULLUP:
			case K_RCMOS:
			case K_REAL:
			case K_REALTIME:
			case K_REG:
			case K_RNMOS:
			case K_RPMOS:
			case K_RTRAN:
			case K_RTRANIF0:
			case K_RTRANIF1:
			case K_SUPPLY0:
			case K_SUPPLY1:
			case K_TASK:
			case K_TIME:
			case K_TRAN:
			case K_TRANIF0:
			case K_TRANIF1:
			case K_TRI:
			case K_TRI0:
			case K_TRI1:
			case K_TRIAND:
			case K_TRIOR:
			case K_TRIREG:
			case K_WAND:
			case K_WIRE:
			case K_WOR:
			case K_XNOR:
			case K_XOR:
			case PSTAR:
			case SEMI:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		generate_item_or_null();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			genvar_case_item_AST = RefVerAST(currentAST.root);
#line 2300 "verilog.parser.g"
			genvar_case_item_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(GENVAR_CASE_ITEM,"GENVAR_CASE_ITEM")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(genvar_case_item_AST))));
#line 12295 "VerilogParser.cpp"
			currentAST.root = genvar_case_item_AST;
			if ( genvar_case_item_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				genvar_case_item_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = genvar_case_item_AST->getFirstChild();
			else
				currentAST.child = genvar_case_item_AST;
			currentAST.advanceChildToEnd();
		}
		genvar_case_item_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2303 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12316 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = genvar_case_item_AST;
}

void VerilogParser::genvar_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST genvar_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		genvar_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(ASSIGN);
		constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			genvar_assignment_AST = RefVerAST(currentAST.root);
#line 2337 "verilog.parser.g"
			genvar_assignment_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(GENVAR_ASSIGNMENT,"GENVAR_ASSIGNMENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(genvar_assignment_AST))));
#line 12343 "VerilogParser.cpp"
			currentAST.root = genvar_assignment_AST;
			if ( genvar_assignment_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				genvar_assignment_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = genvar_assignment_AST->getFirstChild();
			else
				currentAST.child = genvar_assignment_AST;
			currentAST.advanceChildToEnd();
		}
		genvar_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2340 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12364 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = genvar_assignment_AST;
}

void VerilogParser::generate_block_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST generate_block_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		generate_block_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5014 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12394 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = generate_block_identifier_AST;
}

void VerilogParser::udp_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		udp_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5038 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12424 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_identifier_AST;
}

void VerilogParser::udp_port_list() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_port_list_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )+
		int _cnt384=0;
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				port_identifier();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				if ( _cnt384>=1 ) { goto _loop384; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt384++;
		}
		_loop384:;
		}  // ( ... )+
		if ( inputState->guessing==0 ) {
			udp_port_list_AST = RefVerAST(currentAST.root);
#line 2396 "verilog.parser.g"
			udp_port_list_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(UDP_PORT_LIST,"UDP_PORT_LIST")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(udp_port_list_AST))));
#line 12464 "VerilogParser.cpp"
			currentAST.root = udp_port_list_AST;
			if ( udp_port_list_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				udp_port_list_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = udp_port_list_AST->getFirstChild();
			else
				currentAST.child = udp_port_list_AST;
			currentAST.advanceChildToEnd();
		}
		udp_port_list_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2399 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12485 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_port_list_AST;
}

void VerilogParser::udp_declaration_port_list() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_declaration_port_list_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST atr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST uod_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST atr1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST idh2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST pid_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2407 "verilog.parser.g"
	RefVerAST idh;
#line 12504 "VerilogParser.cpp"
	
	try {      // for error handling
		if ( inputState->guessing==0 ) {
			udp_declaration_port_list_AST = RefVerAST(currentAST.root);
#line 2409 "verilog.parser.g"
			udp_declaration_port_list_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(1))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(UDP_DECLARATION_PORT_LIST,"UDP_DECLARATION_PORT_LIST")))));
#line 12511 "VerilogParser.cpp"
			currentAST.root = udp_declaration_port_list_AST;
			if ( udp_declaration_port_list_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				udp_declaration_port_list_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = udp_declaration_port_list_AST->getFirstChild();
			else
				currentAST.child = udp_declaration_port_list_AST;
			currentAST.advanceChildToEnd();
		}
		attrs_opt();
		if (inputState->guessing==0) {
			atr_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			udp_declaration_port_list_AST = RefVerAST(currentAST.root);
#line 2411 "verilog.parser.g"
			udp_declaration_port_list_AST->addChild(atr_AST);
#line 12528 "VerilogParser.cpp"
		}
		udp_output_declaration();
		if (inputState->guessing==0) {
			uod_AST = returnAST;
		}
		if ( inputState->guessing==0 ) {
			udp_declaration_port_list_AST = RefVerAST(currentAST.root);
#line 2413 "verilog.parser.g"
			udp_declaration_port_list_AST->addChild(uod_AST);
#line 12538 "VerilogParser.cpp"
		}
		{ // ( ... )+
		int _cnt388=0;
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				{
				switch ( LA(1)) {
				case K_INPUT:
				case PSTAR:
				{
					attrs_opt();
					if (inputState->guessing==0) {
						atr1_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
						udp_declaration_port_list_AST = RefVerAST(currentAST.root);
#line 2426 "verilog.parser.g"
						udp_declaration_port_list_AST->addChild(atr1_AST);
#line 12558 "VerilogParser.cpp"
					}
					udp_input_declaration_header();
					if (inputState->guessing==0) {
						idh2_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
						udp_declaration_port_list_AST = RefVerAST(currentAST.root);
#line 2428 "verilog.parser.g"
						
						idh = idh2_AST;
						udp_declaration_port_list_AST->addChild(idh);
						
#line 12571 "VerilogParser.cpp"
					}
					break;
				}
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				{
					port_identifier();
					if (inputState->guessing==0) {
						pid_AST = returnAST;
					}
					if ( inputState->guessing==0 ) {
#line 2432 "verilog.parser.g"
						idh->addChild(pid_AST);
#line 12585 "VerilogParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else {
				if ( _cnt388>=1 ) { goto _loop388; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt388++;
		}
		_loop388:;
		}  // ( ... )+
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2437 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12615 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_declaration_port_list_AST;
}

void VerilogParser::udp_port_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_port_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case K_OUTPUT:
		{
			udp_output_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			break;
		}
		case K_INPUT:
		{
			udp_input_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			break;
		}
		case K_REG:
		{
			udp_reg_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		udp_port_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2453 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12680 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_port_declaration_AST;
}

void VerilogParser::udp_body() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_body_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2519 "verilog.parser.g"
	TUdpType udpType = UDP_UNKNOWN;
#line 12694 "VerilogParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_INITIAL:
		{
			udp_initial_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 2522 "verilog.parser.g"
				udpType = UDP_SEQ;
#line 12708 "VerilogParser.cpp"
			}
			break;
		}
		case K_TABLE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		RefVerAST tmp381_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp381_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp381_AST));
		}
		match(K_TABLE);
		{ // ( ... )+
		int _cnt402=0;
		for (;;) {
			if ((_tokenSet_11.member(LA(1)))) {
				udp_table_entry(udpType);
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				if ( _cnt402>=1 ) { goto _loop402; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt402++;
		}
		_loop402:;
		}  // ( ... )+
		match(K_ENDTABLE);
		udp_body_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2529 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12758 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_body_AST;
}

void VerilogParser::udp_output_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_output_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp383_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp383_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp383_AST));
		}
		match(K_OUTPUT);
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			port_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_REG:
		{
			RefVerAST tmp384_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp384_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp384_AST));
			}
			match(K_REG);
			port_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case ASSIGN:
			{
				match(ASSIGN);
				constant_expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case COMMA:
			case SEMI:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		udp_output_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2469 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12843 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_output_declaration_AST;
}

void VerilogParser::udp_input_declaration_header() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_input_declaration_header_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp386_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp386_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp386_AST));
		}
		match(K_INPUT);
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		udp_input_declaration_header_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2482 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12879 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_input_declaration_header_AST;
}

void VerilogParser::udp_input_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_input_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp387_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp387_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp387_AST));
		}
		match(K_INPUT);
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				port_identifier();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop397;
			}
			
		}
		_loop397:;
		} // ( ... )*
		udp_input_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2496 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12931 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_input_declaration_AST;
}

void VerilogParser::udp_reg_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_reg_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp389_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp389_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp389_AST));
		}
		match(K_REG);
		variable_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		udp_reg_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2509 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 12967 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_reg_declaration_AST;
}

void VerilogParser::udp_initial_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_initial_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp390_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp390_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp390_AST));
		}
		match(K_INITIAL);
		port_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(ASSIGN);
		init_val();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		udp_initial_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2545 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13009 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_initial_statement_AST;
}

void VerilogParser::udp_table_entry(
	TUdpType& udpType
) {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST udp_table_entry_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2582 "verilog.parser.g"
	TBool hasEdge; TBool hasLevel;
#line 13025 "VerilogParser.cpp"
	
	try {      // for error handling
		bool synPredMatched407 = false;
		if (((_tokenSet_11.member(LA(1))))) {
			int _m407 = mark();
			synPredMatched407 = true;
			inputState->guessing++;
			try {
				{
				input_list(hasEdge, hasLevel);
				match(COLON);
				current_state();
				match(COLON);
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched407 = false;
			}
			rewind(_m407);
			inputState->guessing--;
		}
		if ( synPredMatched407 ) {
			input_list(hasEdge, hasLevel);
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COLON);
			current_state();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COLON);
			next_state();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			if ( inputState->guessing==0 ) {
#line 2590 "verilog.parser.g"
				if (udpType == UDP_UNKNOWN) udpType = UDP_SEQ;
#line 13066 "VerilogParser.cpp"
			}
			if (!( udpType == UDP_SEQ ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" udpType == UDP_SEQ ");
			if ( inputState->guessing==0 ) {
				udp_table_entry_AST = RefVerAST(currentAST.root);
#line 2593 "verilog.parser.g"
				udp_table_entry_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(UDP_TABLE_SEQ_ENTRY,"UDP_TABLE_SEQ_ENTRY")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(udp_table_entry_AST))));
#line 13074 "VerilogParser.cpp"
				currentAST.root = udp_table_entry_AST;
				if ( udp_table_entry_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					udp_table_entry_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = udp_table_entry_AST->getFirstChild();
				else
					currentAST.child = udp_table_entry_AST;
				currentAST.advanceChildToEnd();
			}
			udp_table_entry_AST = RefVerAST(currentAST.root);
		}
		else if ((_tokenSet_11.member(LA(1)))) {
			input_list(hasEdge, hasLevel);
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COLON);
			output_symbol();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			if ( inputState->guessing==0 ) {
#line 2598 "verilog.parser.g"
				if (udpType == UDP_UNKNOWN) udpType = UDP_COMB;
#line 13099 "VerilogParser.cpp"
			}
			if (!( udpType == UDP_COMB ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" udpType == UDP_COMB ");
			if (!( !hasEdge ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !hasEdge ");
			if (!( hasLevel ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" hasLevel ");
			if ( inputState->guessing==0 ) {
				udp_table_entry_AST = RefVerAST(currentAST.root);
#line 2605 "verilog.parser.g"
				udp_table_entry_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(UDP_TABLE_COMB_ENTRY,"UDP_TABLE_COMB_ENTRY")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(udp_table_entry_AST))));
#line 13111 "VerilogParser.cpp"
				currentAST.root = udp_table_entry_AST;
				if ( udp_table_entry_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					udp_table_entry_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = udp_table_entry_AST->getFirstChild();
				else
					currentAST.child = udp_table_entry_AST;
				currentAST.advanceChildToEnd();
			}
			udp_table_entry_AST = RefVerAST(currentAST.root);
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2608 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13137 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = udp_table_entry_AST;
}

void VerilogParser::init_val() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST init_val_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST n_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2553 "verilog.parser.g"
	TBool valid = FALSE;
#line 13152 "VerilogParser.cpp"
	
	try {      // for error handling
		number();
		if (inputState->guessing==0) {
			n_AST = returnAST;
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
#line 2557 "verilog.parser.g"
			
			string s = n_AST->getText();
			if ( equal(s, "1'b0") 
			|| equal(s, "1'b1") 
			|| equal(s, "1'bx") 
			|| equal(s, "1'B0") 
			|| equal(s, "1'B1") 
			|| equal(s, "1'Bx") 
			|| equal(s, "1") 
			|| equal(s, "0")
			)
			valid = TRUE;
			
#line 13175 "VerilogParser.cpp"
		}
		if (!( valid ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" valid ");
		init_val_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2574 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13191 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = init_val_AST;
}

void VerilogParser::number() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST number_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST un_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST bn_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		{
			unsigned_number();
			if (inputState->guessing==0) {
				un_AST = returnAST;
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{
			switch ( LA(1)) {
			case BASED_NUMBER:
			{
				based_number();
				if (inputState->guessing==0) {
					bn_AST = returnAST;
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
					number_AST = RefVerAST(currentAST.root);
#line 4591 "verilog.parser.g"
					
					string numText = un_AST->getText() + bn_AST->getText();
					number_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(SIZED_NUMBER,numText)))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(number_AST))));
					
#line 13231 "VerilogParser.cpp"
					currentAST.root = number_AST;
					if ( number_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
						number_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						  currentAST.child = number_AST->getFirstChild();
					else
						currentAST.child = number_AST;
					currentAST.advanceChildToEnd();
				}
				break;
			}
			case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
			case K_OR:
			case COLON:
			case COMMA:
			case MINUS:
			case RBRACK:
			case LCRULY:
			case RCRULY:
			case RPAREN:
			case QUESTION:
			case SEMI:
			case PLUS:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STARP:
			case PO_POS:
			case PO_NEG:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			number_AST = RefVerAST(currentAST.root);
			break;
		}
		case BASED_NUMBER:
		{
			based_number();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			number_AST = RefVerAST(currentAST.root);
			break;
		}
		case REAL_NUMBER:
		{
			real_number();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			number_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4600 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13327 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = number_AST;
}

void VerilogParser::input_list(
	TBool& hasEdge, TBool& hasLevel
) {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST input_list_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2616 "verilog.parser.g"
	
	hasEdge = FALSE;
	hasLevel = FALSE;
	
#line 13346 "VerilogParser.cpp"
	
	try {      // for error handling
		{ // ( ... )+
		int _cnt410=0;
		for (;;) {
			switch ( LA(1)) {
			case UDP_B:
			case UDP_X:
			case UDP_0:
			case UDP_1:
			case QUESTION:
			{
				level_symbol();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 2622 "verilog.parser.g"
					
					if( !hasLevel )
					hasLevel = TRUE; 
					
#line 13369 "VerilogParser.cpp"
				}
				break;
			}
			case UDP_F:
			case UDP_R:
			case UDP_N:
			case UDP_P:
			case LPAREN:
			case STAR:
			{
				edge_indicator();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if (!( !hasEdge ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !hasEdge ");
				if ( inputState->guessing==0 ) {
#line 2629 "verilog.parser.g"
					hasEdge = TRUE;
#line 13389 "VerilogParser.cpp"
				}
				break;
			}
			default:
			{
				if ( _cnt410>=1 ) { goto _loop410; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt410++;
		}
		_loop410:;
		}  // ( ... )+
		if ( inputState->guessing==0 ) {
			input_list_AST = RefVerAST(currentAST.root);
#line 2631 "verilog.parser.g"
			input_list_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(INPUT_LIST,"INPUT_LIST")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(input_list_AST))));
#line 13406 "VerilogParser.cpp"
			currentAST.root = input_list_AST;
			if ( input_list_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				input_list_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = input_list_AST->getFirstChild();
			else
				currentAST.child = input_list_AST;
			currentAST.advanceChildToEnd();
		}
		input_list_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2634 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13427 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = input_list_AST;
}

void VerilogParser::current_state() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST current_state_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		level_symbol();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		current_state_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2646 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13457 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = current_state_AST;
}

void VerilogParser::next_state() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST next_state_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case UDP_X:
		case UDP_0:
		case UDP_1:
		{
			output_symbol();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			next_state_AST = RefVerAST(currentAST.root);
			break;
		}
		case MINUS:
		{
			RefVerAST tmp398_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp398_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp398_AST));
			}
			match(MINUS);
			next_state_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2704 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13510 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = next_state_AST;
}

void VerilogParser::output_symbol() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST output_symbol_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case UDP_0:
		{
			RefVerAST tmp399_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp399_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp399_AST));
			}
			match(UDP_0);
			output_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_1:
		{
			RefVerAST tmp400_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp400_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp400_AST));
			}
			match(UDP_1);
			output_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_X:
		{
			RefVerAST tmp401_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp401_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp401_AST));
			}
			match(UDP_X);
			output_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2716 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13574 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = output_symbol_AST;
}

void VerilogParser::level_symbol() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST level_symbol_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case UDP_0:
		{
			RefVerAST tmp402_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp402_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp402_AST));
			}
			match(UDP_0);
			level_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_1:
		{
			RefVerAST tmp403_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp403_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp403_AST));
			}
			match(UDP_1);
			level_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_X:
		{
			RefVerAST tmp404_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp404_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp404_AST));
			}
			match(UDP_X);
			level_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case QUESTION:
		{
			RefVerAST tmp405_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp405_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp405_AST));
			}
			match(QUESTION);
			level_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_B:
		{
			RefVerAST tmp406_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp406_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp406_AST));
			}
			match(UDP_B);
			level_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2658 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13660 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = level_symbol_AST;
}

void VerilogParser::edge_indicator() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST edge_indicator_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case LPAREN:
		{
			RefVerAST tmp407_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp407_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp407_AST));
			}
			match(LPAREN);
			level_symbol();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			level_symbol();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			edge_indicator_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_F:
		case UDP_R:
		case UDP_N:
		case UDP_P:
		case STAR:
		{
			edge_symbol();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			edge_indicator_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2674 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13724 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = edge_indicator_AST;
}

void VerilogParser::edge_symbol() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST edge_symbol_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case UDP_F:
		{
			RefVerAST tmp409_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp409_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp409_AST));
			}
			match(UDP_F);
			edge_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_R:
		{
			RefVerAST tmp410_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp410_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp410_AST));
			}
			match(UDP_R);
			edge_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_N:
		{
			RefVerAST tmp411_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp411_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp411_AST));
			}
			match(UDP_N);
			edge_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case UDP_P:
		{
			RefVerAST tmp412_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp412_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp412_AST));
			}
			match(UDP_P);
			edge_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		case STAR:
		{
			RefVerAST tmp413_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp413_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp413_AST));
			}
			match(STAR);
			edge_symbol_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2687 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13810 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = edge_symbol_AST;
}

void VerilogParser::list_of_net_assignments() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_net_assignments_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		net_assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				net_assignment();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop422;
			}
			
		}
		_loop422:;
		} // ( ... )*
		list_of_net_assignments_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2747 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13856 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_net_assignments_AST;
}

void VerilogParser::net_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST net_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		net_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2774 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13886 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = net_assignment_AST;
}

void VerilogParser::assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		lvalue();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(ASSIGN);
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			assignment_AST = RefVerAST(currentAST.root);
#line 2759 "verilog.parser.g"
			assignment_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ASSIGNMENT,"ASSIGNMENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(assignment_AST))));
#line 13913 "VerilogParser.cpp"
			currentAST.root = assignment_AST;
			if ( assignment_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				assignment_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = assignment_AST->getFirstChild();
			else
				currentAST.child = assignment_AST;
			currentAST.advanceChildToEnd();
		}
		assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2762 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 13934 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = assignment_AST;
}

void VerilogParser::lvalue() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST lvalue_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			expr_primary_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LCRULY:
		{
			match(LCRULY);
			lvalue();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					lvalue();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop691;
				}
				
			}
			_loop691:;
			} // ( ... )*
			match(RCRULY);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			lvalue_AST = RefVerAST(currentAST.root);
#line 4576 "verilog.parser.g"
			lvalue_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(LVALUE,"LVALUE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(lvalue_AST))));
#line 13995 "VerilogParser.cpp"
			currentAST.root = lvalue_AST;
			if ( lvalue_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				lvalue_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = lvalue_AST->getFirstChild();
			else
				currentAST.child = lvalue_AST;
			currentAST.advanceChildToEnd();
		}
		lvalue_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4579 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14016 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = lvalue_AST;
}

void VerilogParser::statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_CASE:
		case K_CASEX:
		case K_CASEZ:
		{
			case_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_IF:
		{
			conditional_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_DISABLE:
		{
			disable_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case TRIGGER:
		{
			event_trigger();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_FOR:
		case K_FOREVER:
		case K_REPEAT:
		case K_WHILE:
		{
			loop_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_FORK:
		{
			par_block();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_ASSIGN:
		case K_DEASSIGN:
		case K_FORCE:
		case K_RELEASE:
		{
			procedural_continuous_assignments();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case AT:
		case POUND:
		{
			procedural_timing_control_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_BEGIN:
		{
			seq_block();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case SYSTEM_TASK_NAME:
		{
			system_task_enable();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_WAIT:
		{
			wait_statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		case SEMI:
		{
			match(SEMI);
			statement_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
			bool synPredMatched450 = false;
			if (((LA(1) == LCRULY || LA(1) == IDENTIFIER || LA(1) == ESCAPED_IDENTIFIER))) {
				int _m450 = mark();
				synPredMatched450 = true;
				inputState->guessing++;
				try {
					{
					variable_lvalue();
					{
					switch ( LA(1)) {
					case ASSIGN:
					{
						match(ASSIGN);
						break;
					}
					case LE:
					{
						match(LE);
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched450 = false;
				}
				rewind(_m450);
				inputState->guessing--;
			}
			if ( synPredMatched450 ) {
				blocking_or_nonblocking_assignment();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(SEMI);
				statement_AST = RefVerAST(currentAST.root);
			}
			else if ((LA(1) == IDENTIFIER || LA(1) == ESCAPED_IDENTIFIER)) {
				task_enable();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				statement_AST = RefVerAST(currentAST.root);
			}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2930 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14211 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = statement_AST;
}

void VerilogParser::blocking_or_nonblocking_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST blocking_or_nonblocking_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		variable_lvalue();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case ASSIGN:
		{
			RefVerAST tmp422_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp422_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp422_AST));
			}
			match(ASSIGN);
			break;
		}
		case LE:
		{
			RefVerAST tmp423_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp423_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp423_AST));
			}
			match(LE);
			break;
		}
		case K_BEGIN:
		case K_END:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BACKTICK:
		case AT:
		case COLON:
		case COMMA:
		case MINUS:
		case RBRACK:
		case LCRULY:
		case RCRULY:
		case LPAREN:
		case RPAREN:
		case POUND:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case TAND:
		case LOR:
		case LT_:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case TRIGGER:
		case PPATH:
		case FPATH:
		case STARP:
		case PO_POS:
		case PO_NEG:
		case SUPERSTAR:
		case NZ_UNSIGNED_NUMBER:
		case REAL_NUMBER_EXP:
		case TICK:
		{
			unexpected();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case K_REPEAT:
		case AT:
		case POUND:
		{
			delay_or_event_control();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			blocking_or_nonblocking_assignment_AST = RefVerAST(currentAST.root);
#line 2814 "verilog.parser.g"
			
			blocking_or_nonblocking_assignment_AST = 
			RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(BLOCKING_OR_NONBLOCKING_ASSIGNMENT,"BLOCKING_OR_NONBLOCKING_ASSIGNMENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(blocking_or_nonblocking_assignment_AST)))); 
			
#line 14368 "VerilogParser.cpp"
			currentAST.root = blocking_or_nonblocking_assignment_AST;
			if ( blocking_or_nonblocking_assignment_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				blocking_or_nonblocking_assignment_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = blocking_or_nonblocking_assignment_AST->getFirstChild();
			else
				currentAST.child = blocking_or_nonblocking_assignment_AST;
			currentAST.advanceChildToEnd();
		}
		blocking_or_nonblocking_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2820 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14389 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = blocking_or_nonblocking_assignment_AST;
}

void VerilogParser::variable_lvalue() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST variable_lvalue_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		lvalue();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		variable_lvalue_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4549 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14419 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = variable_lvalue_AST;
}

void VerilogParser::delay_or_event_control() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST delay_or_event_control_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case POUND:
		{
			delay_control();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			delay_or_event_control_AST = RefVerAST(currentAST.root);
			break;
		}
		case AT:
		{
			event_control();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			delay_or_event_control_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_REPEAT:
		{
			RefVerAST tmp424_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp424_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp424_AST));
			}
			match(K_REPEAT);
			match(LPAREN);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			event_control();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			delay_or_event_control_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2994 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14489 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = delay_or_event_control_AST;
}

void VerilogParser::procedural_continuous_assignments() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST procedural_continuous_assignments_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_ASSIGN:
		{
			{
			RefVerAST tmp427_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp427_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp427_AST));
			}
			match(K_ASSIGN);
			variable_assignment();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			}
			procedural_continuous_assignments_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_DEASSIGN:
		{
			{
			RefVerAST tmp428_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp428_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp428_AST));
			}
			match(K_DEASSIGN);
			variable_lvalue();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			}
			procedural_continuous_assignments_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_FORCE:
		{
			{
			RefVerAST tmp429_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp429_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp429_AST));
			}
			match(K_FORCE);
			variable_or_net_assignment();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			}
			procedural_continuous_assignments_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_RELEASE:
		{
			{
			RefVerAST tmp430_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp430_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp430_AST));
			}
			match(K_RELEASE);
			net_or_variable_lvalue();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			}
			procedural_continuous_assignments_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2835 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14588 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = procedural_continuous_assignments_AST;
}

void VerilogParser::variable_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST variable_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		variable_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2847 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14618 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = variable_assignment_AST;
}

void VerilogParser::variable_or_net_assignment() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST variable_or_net_assignment_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		assignment();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		variable_or_net_assignment_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2859 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14648 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = variable_or_net_assignment_AST;
}

void VerilogParser::net_or_variable_lvalue() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST net_or_variable_lvalue_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		lvalue();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		net_or_variable_lvalue_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4561 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14678 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = net_or_variable_lvalue_AST;
}

void VerilogParser::par_block() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST par_block_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2868 "verilog.parser.g"
	bool acceptBlockItemDecl = false;
#line 14692 "VerilogParser.cpp"
	
	try {      // for error handling
		match(K_FORK);
		{
		switch ( LA(1)) {
		case COLON:
		{
			match(COLON);
			block_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 2871 "verilog.parser.g"
				acceptBlockItemDecl = true;
#line 14708 "VerilogParser.cpp"
			}
			break;
		}
		case K_ASSIGN:
		case K_BEGIN:
		case K_CASE:
		case K_CASEX:
		case K_CASEZ:
		case K_DEASSIGN:
		case K_DISABLE:
		case K_EVENT:
		case K_FOR:
		case K_FORCE:
		case K_FOREVER:
		case K_FORK:
		case K_IF:
		case K_INTEGER:
		case K_JOIN:
		case K_LOCALPARAM:
		case K_PARAMETER:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_RELEASE:
		case K_REPEAT:
		case K_TIME:
		case K_WAIT:
		case K_WHILE:
		case PSTAR:
		case AT:
		case LCRULY:
		case POUND:
		case SEMI:
		case TRIGGER:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case SYSTEM_TASK_NAME:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_7.member(LA(1)))) {
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				{
				switch ( LA(1)) {
				case K_EVENT:
				case K_INTEGER:
				case K_LOCALPARAM:
				case K_PARAMETER:
				case K_REAL:
				case K_REALTIME:
				case K_REG:
				case K_TIME:
				{
					block_item_declaration();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if (!( acceptBlockItemDecl ))
						throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" acceptBlockItemDecl ");
					break;
				}
				case K_ASSIGN:
				case K_BEGIN:
				case K_CASE:
				case K_CASEX:
				case K_CASEZ:
				case K_DEASSIGN:
				case K_DISABLE:
				case K_FOR:
				case K_FORCE:
				case K_FOREVER:
				case K_FORK:
				case K_IF:
				case K_RELEASE:
				case K_REPEAT:
				case K_WAIT:
				case K_WHILE:
				case AT:
				case LCRULY:
				case POUND:
				case SEMI:
				case TRIGGER:
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				case SYSTEM_TASK_NAME:
				{
					statement();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if ( inputState->guessing==0 ) {
#line 2875 "verilog.parser.g"
						acceptBlockItemDecl = false;
#line 14813 "VerilogParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else {
				goto _loop441;
			}
			
		}
		_loop441:;
		} // ( ... )*
		match(K_JOIN);
		if ( inputState->guessing==0 ) {
			par_block_AST = RefVerAST(currentAST.root);
#line 2879 "verilog.parser.g"
			par_block_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(PAR_BLOCK,"PAR_BLOCK")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(par_block_AST))));
#line 14836 "VerilogParser.cpp"
			currentAST.root = par_block_AST;
			if ( par_block_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				par_block_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = par_block_AST->getFirstChild();
			else
				currentAST.child = par_block_AST;
			currentAST.advanceChildToEnd();
		}
		par_block_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2882 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14857 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = par_block_AST;
}

void VerilogParser::block_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST block_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		block_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4954 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 14887 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = block_identifier_AST;
}

void VerilogParser::seq_block() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST seq_block_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2890 "verilog.parser.g"
	bool acceptBlockItemDecl = false;
#line 14901 "VerilogParser.cpp"
	
	try {      // for error handling
		match(K_BEGIN);
		{
		switch ( LA(1)) {
		case COLON:
		{
			match(COLON);
			block_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 2893 "verilog.parser.g"
				acceptBlockItemDecl = true;
#line 14917 "VerilogParser.cpp"
			}
			break;
		}
		case K_ASSIGN:
		case K_BEGIN:
		case K_CASE:
		case K_CASEX:
		case K_CASEZ:
		case K_DEASSIGN:
		case K_DISABLE:
		case K_END:
		case K_EVENT:
		case K_FOR:
		case K_FORCE:
		case K_FOREVER:
		case K_FORK:
		case K_IF:
		case K_INTEGER:
		case K_LOCALPARAM:
		case K_PARAMETER:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_RELEASE:
		case K_REPEAT:
		case K_TIME:
		case K_WAIT:
		case K_WHILE:
		case PSTAR:
		case AT:
		case LCRULY:
		case POUND:
		case SEMI:
		case TRIGGER:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case SYSTEM_TASK_NAME:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_7.member(LA(1)))) {
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				{
				switch ( LA(1)) {
				case K_EVENT:
				case K_INTEGER:
				case K_LOCALPARAM:
				case K_PARAMETER:
				case K_REAL:
				case K_REALTIME:
				case K_REG:
				case K_TIME:
				{
					block_item_declaration();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if (!( acceptBlockItemDecl ))
						throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" acceptBlockItemDecl ");
					break;
				}
				case K_ASSIGN:
				case K_BEGIN:
				case K_CASE:
				case K_CASEX:
				case K_CASEZ:
				case K_DEASSIGN:
				case K_DISABLE:
				case K_FOR:
				case K_FORCE:
				case K_FOREVER:
				case K_FORK:
				case K_IF:
				case K_RELEASE:
				case K_REPEAT:
				case K_WAIT:
				case K_WHILE:
				case AT:
				case LCRULY:
				case POUND:
				case SEMI:
				case TRIGGER:
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				case SYSTEM_TASK_NAME:
				{
					statement();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					if ( inputState->guessing==0 ) {
#line 2897 "verilog.parser.g"
						acceptBlockItemDecl = false;
#line 15022 "VerilogParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else {
				goto _loop446;
			}
			
		}
		_loop446:;
		} // ( ... )*
		match(K_END);
		if ( inputState->guessing==0 ) {
			seq_block_AST = RefVerAST(currentAST.root);
#line 2901 "verilog.parser.g"
			seq_block_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(SEQ_BLOCK,"SEQ_BLOCK")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(seq_block_AST))));
#line 15045 "VerilogParser.cpp"
			currentAST.root = seq_block_AST;
			if ( seq_block_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				seq_block_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = seq_block_AST->getFirstChild();
			else
				currentAST.child = seq_block_AST;
			currentAST.advanceChildToEnd();
		}
		seq_block_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2904 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15066 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = seq_block_AST;
}

void VerilogParser::case_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST case_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_CASE:
		{
			RefVerAST tmp437_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp437_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp437_AST));
			}
			match(K_CASE);
			break;
		}
		case K_CASEZ:
		{
			RefVerAST tmp438_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp438_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp438_AST));
			}
			match(K_CASEZ);
			break;
		}
		case K_CASEX:
		{
			RefVerAST tmp439_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp439_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp439_AST));
			}
			match(K_CASEX);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LPAREN);
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		{ // ( ... )+
		int _cnt477=0;
		for (;;) {
			if ((_tokenSet_10.member(LA(1)))) {
				case_item();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				if ( _cnt477>=1 ) { goto _loop477; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt477++;
		}
		_loop477:;
		}  // ( ... )+
		match(K_ENDCASE);
		if ( inputState->guessing==0 ) {
			case_statement_AST = RefVerAST(currentAST.root);
#line 3176 "verilog.parser.g"
			case_statement_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CASE_STATEMENT,"CASE_STATEMENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(case_statement_AST))));
#line 15146 "VerilogParser.cpp"
			currentAST.root = case_statement_AST;
			if ( case_statement_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				case_statement_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = case_statement_AST->getFirstChild();
			else
				currentAST.child = case_statement_AST;
			currentAST.advanceChildToEnd();
		}
		case_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3179 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15167 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = case_statement_AST;
}

void VerilogParser::conditional_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST conditional_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp443_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp443_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp443_AST));
		}
		match(K_IF);
		match(LPAREN);
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		statement_or_null();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		if ((LA(1) == K_ELSE)) {
			match(K_ELSE);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement_or_null();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
		}
		else if ((_tokenSet_12.member(LA(1)))) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		conditional_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3162 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15232 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = conditional_statement_AST;
}

void VerilogParser::disable_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST disable_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp447_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp447_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp447_AST));
		}
		match(K_DISABLE);
		hierarchical_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		disable_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3008 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15269 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = disable_statement_AST;
}

void VerilogParser::event_trigger() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST event_trigger_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(TRIGGER);
		expr_primary_identifier_no_range();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(SEMI);
		if ( inputState->guessing==0 ) {
			event_trigger_AST = RefVerAST(currentAST.root);
#line 3041 "verilog.parser.g"
			event_trigger_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EVENT_TRIGGER,"EVENT_TRIGGER")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(event_trigger_AST))));
#line 15293 "VerilogParser.cpp"
			currentAST.root = event_trigger_AST;
			if ( event_trigger_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				event_trigger_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = event_trigger_AST->getFirstChild();
			else
				currentAST.child = event_trigger_AST;
			currentAST.advanceChildToEnd();
		}
		event_trigger_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3044 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15314 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = event_trigger_AST;
}

void VerilogParser::loop_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST loop_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_FOREVER:
		{
			RefVerAST tmp451_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp451_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp451_AST));
			}
			match(K_FOREVER);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_REPEAT:
		{
			RefVerAST tmp452_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp452_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp452_AST));
			}
			match(K_REPEAT);
			match(LPAREN);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_WHILE:
		{
			RefVerAST tmp455_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp455_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp455_AST));
			}
			match(K_WHILE);
			match(LPAREN);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case K_FOR:
		{
			RefVerAST tmp458_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp458_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp458_AST));
			}
			match(K_FOR);
			match(LPAREN);
			variable_assignment();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			variable_assignment();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			statement();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			loop_statement_AST = RefVerAST(currentAST.root);
#line 3212 "verilog.parser.g"
			loop_statement_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(LOOP_STATEMENT,"LOOP_STATEMENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(loop_statement_AST))));
#line 15440 "VerilogParser.cpp"
			currentAST.root = loop_statement_AST;
			if ( loop_statement_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				loop_statement_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = loop_statement_AST->getFirstChild();
			else
				currentAST.child = loop_statement_AST;
			currentAST.advanceChildToEnd();
		}
		loop_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3215 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15461 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = loop_statement_AST;
}

void VerilogParser::procedural_timing_control_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST procedural_timing_control_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		procedural_timing_control();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		statement_or_null();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		procedural_timing_control_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3124 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15499 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = procedural_timing_control_statement_AST;
}

void VerilogParser::system_task_enable() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST system_task_enable_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		system_function_name();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case LPAREN:
		{
			match(LPAREN);
			{
			switch ( LA(1)) {
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case MINUS:
			case LCRULY:
			case LPAREN:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			case STRING:
			case SYSTEM_TASK_NAME:
			{
				expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case COMMA:
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					RefVerAST tmp464_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp464_AST = astFactory->create(LT(1));
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp464_AST));
					}
					match(COMMA);
					{
					switch ( LA(1)) {
					case UNSIGNED_NUMBER:
					case REAL_NUMBER:
					case BASED_NUMBER:
					case MINUS:
					case LCRULY:
					case LPAREN:
					case PLUS:
					case LNOT:
					case NOT:
					case AND:
					case NAND:
					case OR:
					case NOR:
					case XOR:
					case XNOR:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case STRING:
					case SYSTEM_TASK_NAME:
					{
						expression();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case COMMA:
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
				}
				else {
					goto _loop488;
				}
				
			}
			_loop488:;
			} // ( ... )*
			match(RPAREN);
			break;
		}
		case SEMI:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(SEMI);
		if ( inputState->guessing==0 ) {
			system_task_enable_AST = RefVerAST(currentAST.root);
#line 3229 "verilog.parser.g"
			system_task_enable_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(SYSTEM_TASK_ENABLE,"SYSTEM_TASK_ENABLE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(system_task_enable_AST))));
#line 15635 "VerilogParser.cpp"
			currentAST.root = system_task_enable_AST;
			if ( system_task_enable_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				system_task_enable_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = system_task_enable_AST->getFirstChild();
			else
				currentAST.child = system_task_enable_AST;
			currentAST.advanceChildToEnd();
		}
		system_task_enable_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3232 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15656 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = system_task_enable_AST;
}

void VerilogParser::task_enable() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST task_enable_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		hierarchical_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case LPAREN:
		{
			match(LPAREN);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					expression();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop492;
				}
				
			}
			_loop492:;
			} // ( ... )*
			match(RPAREN);
			break;
		}
		case SEMI:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(SEMI);
		if ( inputState->guessing==0 ) {
			task_enable_AST = RefVerAST(currentAST.root);
#line 3244 "verilog.parser.g"
			task_enable_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(TASK_ENABLE,"TASK_ENABLE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(task_enable_AST))));
#line 15717 "VerilogParser.cpp"
			currentAST.root = task_enable_AST;
			if ( task_enable_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				task_enable_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = task_enable_AST->getFirstChild();
			else
				currentAST.child = task_enable_AST;
			currentAST.advanceChildToEnd();
		}
		task_enable_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3247 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15738 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = task_enable_AST;
}

void VerilogParser::wait_statement() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST wait_statement_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp471_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp471_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp471_AST));
		}
		match(K_WAIT);
		match(LPAREN);
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		statement_or_null();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		wait_statement_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3141 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15784 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = wait_statement_AST;
}

void VerilogParser::delay_control() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST delay_control_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(POUND);
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			delay_value();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			match(LPAREN);
			mintypmax_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			delay_control_AST = RefVerAST(currentAST.root);
#line 2973 "verilog.parser.g"
			delay_control_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(DELAY_CONTROL,"DELAY_CONTROL")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(delay_control_AST))));
#line 15832 "VerilogParser.cpp"
			currentAST.root = delay_control_AST;
			if ( delay_control_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				delay_control_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = delay_control_AST->getFirstChild();
			else
				currentAST.child = delay_control_AST;
			currentAST.advanceChildToEnd();
		}
		delay_control_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 2976 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15853 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = delay_control_AST;
}

void VerilogParser::event_control() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST event_control_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(AT);
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			hierarchical_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case LPAREN:
		{
			match(LPAREN);
			event_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			break;
		}
		case STAR:
		{
			RefVerAST tmp480_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp480_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp480_AST));
			}
			match(STAR);
			break;
		}
		case SUPERSTAR:
		{
			RefVerAST tmp481_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp481_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp481_AST));
			}
			match(SUPERSTAR);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			event_control_AST = RefVerAST(currentAST.root);
#line 3023 "verilog.parser.g"
			event_control_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EVENT_CONTROL,"EVENT_CONTROL")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(event_control_AST))));
#line 15919 "VerilogParser.cpp"
			currentAST.root = event_control_AST;
			if ( event_control_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				event_control_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = event_control_AST->getFirstChild();
			else
				currentAST.child = event_control_AST;
			currentAST.advanceChildToEnd();
		}
		event_control_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3026 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 15940 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = event_control_AST;
}

void VerilogParser::hierarchical_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST hierarchical_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == DOT || LA(1) == LBRACK)) {
				{
				switch ( LA(1)) {
				case LBRACK:
				{
					match(LBRACK);
					constant_expression();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					match(RBRACK);
					break;
				}
				case DOT:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				match(DOT);
				identifier();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop714;
			}
			
		}
		_loop714:;
		} // ( ... )*
		if ( inputState->guessing==0 ) {
			hierarchical_identifier_AST = RefVerAST(currentAST.root);
#line 4731 "verilog.parser.g"
			hierarchical_identifier_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(HIERARCHICAL_IDENTIFIER,"HIERARCHICAL_IDENTIFIER")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(hierarchical_identifier_AST))));
#line 16000 "VerilogParser.cpp"
			currentAST.root = hierarchical_identifier_AST;
			if ( hierarchical_identifier_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				hierarchical_identifier_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = hierarchical_identifier_AST->getFirstChild();
			else
				currentAST.child = hierarchical_identifier_AST;
			currentAST.advanceChildToEnd();
		}
		hierarchical_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4734 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16021 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = hierarchical_identifier_AST;
}

void VerilogParser::event_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST event_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		list_of_event_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		event_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3056 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16051 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = event_expression_AST;
}

void VerilogParser::expr_primary_identifier_no_range() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST expr_primary_identifier_no_range_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LBRACK)) {
				match(LBRACK);
				expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				match(RBRACK);
			}
			else {
				goto _loop724;
			}
			
		}
		_loop724:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == DOT)) {
				match(DOT);
				identifier();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				{ // ( ... )*
				for (;;) {
					if ((LA(1) == LBRACK)) {
						match(LBRACK);
						expression();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						match(RBRACK);
					}
					else {
						goto _loop727;
					}
					
				}
				_loop727:;
				} // ( ... )*
			}
			else {
				goto _loop728;
			}
			
		}
		_loop728:;
		} // ( ... )*
		if ( inputState->guessing==0 ) {
			expr_primary_identifier_no_range_AST = RefVerAST(currentAST.root);
#line 4807 "verilog.parser.g"
			expr_primary_identifier_no_range_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EXPR_PRIMARY_IDENTIFIER,"EXPR_PRIMARY_IDENTIFIER")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expr_primary_identifier_no_range_AST))));
#line 16123 "VerilogParser.cpp"
			currentAST.root = expr_primary_identifier_no_range_AST;
			if ( expr_primary_identifier_no_range_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				expr_primary_identifier_no_range_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = expr_primary_identifier_no_range_AST->getFirstChild();
			else
				currentAST.child = expr_primary_identifier_no_range_AST;
			currentAST.advanceChildToEnd();
		}
		expr_primary_identifier_no_range_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4810 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16144 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = expr_primary_identifier_no_range_AST;
}

void VerilogParser::list_of_event_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_event_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		or_event_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				or_event_expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop464;
			}
			
		}
		_loop464:;
		} // ( ... )*
		list_of_event_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3069 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16190 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_event_expression_AST;
}

void VerilogParser::or_event_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST or_event_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		event_expression_primary();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == K_OR)) {
				match(K_OR);
				event_expression_primary();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop467;
			}
			
		}
		_loop467:;
		} // ( ... )*
		if ( inputState->guessing==0 ) {
			or_event_expression_AST = RefVerAST(currentAST.root);
#line 3080 "verilog.parser.g"
			or_event_expression_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(OR_EVENT_EXPRESSION,"OR_EVENT_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(or_event_expression_AST))));
#line 16228 "VerilogParser.cpp"
			currentAST.root = or_event_expression_AST;
			if ( or_event_expression_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				or_event_expression_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = or_event_expression_AST->getFirstChild();
			else
				currentAST.child = or_event_expression_AST;
			currentAST.advanceChildToEnd();
		}
		or_event_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3083 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16249 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = or_event_expression_AST;
}

void VerilogParser::event_expression_primary() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST event_expression_primary_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			event_expression_primary_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_POSEDGE:
		{
			RefVerAST tmp492_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp492_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp492_AST));
			}
			match(K_POSEDGE);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			event_expression_primary_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NEGEDGE:
		{
			RefVerAST tmp493_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp493_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp493_AST));
			}
			match(K_NEGEDGE);
			expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			event_expression_primary_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3097 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16337 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = event_expression_primary_AST;
}

void VerilogParser::procedural_timing_control() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST procedural_timing_control_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case POUND:
		{
			delay_control();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			procedural_timing_control_AST = RefVerAST(currentAST.root);
			break;
		}
		case AT:
		{
			event_control();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			procedural_timing_control_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3110 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16386 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = procedural_timing_control_AST;
}

void VerilogParser::case_item() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST case_item_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case LCRULY:
		case LPAREN:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			expression_list();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COLON);
			break;
		}
		case K_DEFAULT:
		{
			RefVerAST tmp495_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp495_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp495_AST));
			}
			match(K_DEFAULT);
			{
			switch ( LA(1)) {
			case COLON:
			{
				match(COLON);
				break;
			}
			case K_ASSIGN:
			case K_BEGIN:
			case K_CASE:
			case K_CASEX:
			case K_CASEZ:
			case K_DEASSIGN:
			case K_DISABLE:
			case K_FOR:
			case K_FORCE:
			case K_FOREVER:
			case K_FORK:
			case K_IF:
			case K_RELEASE:
			case K_REPEAT:
			case K_WAIT:
			case K_WHILE:
			case PSTAR:
			case AT:
			case LCRULY:
			case POUND:
			case SEMI:
			case TRIGGER:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			case SYSTEM_TASK_NAME:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		statement_or_null();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			case_item_AST = RefVerAST(currentAST.root);
#line 3193 "verilog.parser.g"
			case_item_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CASE_ITEM,"CASE_ITEM")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(case_item_AST))));
#line 16498 "VerilogParser.cpp"
			currentAST.root = case_item_AST;
			if ( case_item_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				case_item_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = case_item_AST->getFirstChild();
			else
				currentAST.child = case_item_AST;
			currentAST.advanceChildToEnd();
		}
		case_item_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3196 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16519 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = case_item_AST;
}

void VerilogParser::expression_list() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST expression_list_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop630;
			}
			
		}
		_loop630:;
		} // ( ... )*
		if ( inputState->guessing==0 ) {
			expression_list_AST = RefVerAST(currentAST.root);
#line 4250 "verilog.parser.g"
			expression_list_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EXPRESSION_LIST,"EXPRESSION_LIST")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expression_list_AST))));
#line 16557 "VerilogParser.cpp"
			currentAST.root = expression_list_AST;
			if ( expression_list_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				expression_list_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = expression_list_AST->getFirstChild();
			else
				currentAST.child = expression_list_AST;
			currentAST.advanceChildToEnd();
		}
		expression_list_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4253 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16578 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = expression_list_AST;
}

void VerilogParser::system_function_name() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST system_function_name_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp498_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp498_AST = astFactory->create(LT(1));
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp498_AST));
		}
		match(SYSTEM_TASK_NAME);
		system_function_name_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4822 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16610 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = system_function_name_AST;
}

void VerilogParser::specify_item() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST specify_item_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_SPECPARAM:
		{
			specparam_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			specify_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_PULSESTYLE_ONDETECT:
		case K_PULSESTYLE_ONEVENT:
		{
			pulsestyle_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			specify_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NOSHOWCANCELLED:
		case K_SHOWCANCELLED:
		{
			showcancelled_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			specify_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_IF:
		case K_IFNONE:
		case LPAREN:
		{
			path_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			specify_item_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_SETUP:
		case K_S_HOLD:
		case K_S_SETUPHOLD:
		case K_S_RECOVERY:
		case K_S_REMOVAL:
		case K_S_RECREM:
		case K_S_SKEW:
		case K_S_TIMESKEW:
		case K_S_FULLSKEW:
		case K_S_PERIOD:
		case K_S_WIDTH:
		case K_S_NOCHANGE:
		{
			system_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			specify_item_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3279 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16701 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = specify_item_AST;
}

void VerilogParser::pulsestyle_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pulsestyle_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3287 "verilog.parser.g"
	
	TBool canBeSimple;
	
#line 16717 "VerilogParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_PULSESTYLE_ONEVENT:
		{
			RefVerAST tmp499_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp499_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp499_AST));
			}
			match(K_PULSESTYLE_ONEVENT);
			canBeSimple=list_of_path_outputs();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			pulsestyle_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_PULSESTYLE_ONDETECT:
		{
			RefVerAST tmp501_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp501_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp501_AST));
			}
			match(K_PULSESTYLE_ONDETECT);
			canBeSimple=list_of_path_outputs();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			pulsestyle_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3295 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16769 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pulsestyle_declaration_AST;
}

void VerilogParser::showcancelled_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST showcancelled_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3303 "verilog.parser.g"
	
	TBool canBeSimple;
	
#line 16785 "VerilogParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_SHOWCANCELLED:
		{
			RefVerAST tmp503_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp503_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp503_AST));
			}
			match(K_SHOWCANCELLED);
			canBeSimple=list_of_path_outputs();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			showcancelled_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NOSHOWCANCELLED:
		{
			RefVerAST tmp505_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp505_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp505_AST));
			}
			match(K_NOSHOWCANCELLED);
			canBeSimple=list_of_path_outputs();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			showcancelled_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3311 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16837 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = showcancelled_declaration_AST;
}

void VerilogParser::path_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST path_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case LPAREN:
		{
			simple_or_edge_sensitive_path_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			path_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_IF:
		case K_IFNONE:
		{
			state_dependent_path_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(SEMI);
			path_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3325 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 16889 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = path_declaration_AST;
}

void VerilogParser::system_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST system_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_S_SETUP:
		{
			setup_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_HOLD:
		{
			hold_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_SETUPHOLD:
		{
			setuphold_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_RECOVERY:
		{
			recovery_timing_cehck();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_REMOVAL:
		{
			removal_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_RECREM:
		{
			recrem_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_SKEW:
		{
			skew_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_TIMESKEW:
		{
			timeskew_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_FULLSKEW:
		{
			fullskew_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_PERIOD:
		{
			period_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_WIDTH:
		{
			width_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_S_NOCHANGE:
		{
			nochange_timing_check();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			system_timing_check_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3639 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17028 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = system_timing_check_AST;
}

TBool  VerilogParser::list_of_path_outputs() {
#line 3405 "verilog.parser.g"
	TBool canBeSimple;
#line 17039 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_path_outputs_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		canBeSimple=list_of_path_terminals();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		list_of_path_outputs_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3409 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17061 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_path_outputs_AST;
	return canBeSimple;
}

void VerilogParser::simple_or_edge_sensitive_path_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST simple_or_edge_sensitive_path_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3333 "verilog.parser.g"
	
	TBool simple = FALSE; 
	TBool ei = FALSE;
	TBool po = FALSE;
	TBool canBeSimple, test;
	TBool hasColon;
	
#line 17082 "VerilogParser.cpp"
	
	try {      // for error handling
		match(LPAREN);
		{
		switch ( LA(1)) {
		case K_NEGEDGE:
		case K_POSEDGE:
		{
			edge_identifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 3342 "verilog.parser.g"
				ei = TRUE;
#line 17098 "VerilogParser.cpp"
			}
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		canBeSimple=list_of_path_inputs();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case MINUS:
		case PLUS:
		case PO_POS:
		case PO_NEG:
		{
			hasColon=polarity_operator(false);
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
#line 3344 "verilog.parser.g"
				po = TRUE;
#line 17131 "VerilogParser.cpp"
			}
			break;
		}
		case PPATH:
		case FPATH:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case PPATH:
		{
			RefVerAST tmp510_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp510_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp510_AST));
			}
			match(PPATH);
			if (!( canBeSimple ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" canBeSimple ");
			break;
		}
		case FPATH:
		{
			RefVerAST tmp511_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp511_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp511_AST));
			}
			match(FPATH);
			if ( inputState->guessing==0 ) {
#line 3348 "verilog.parser.g"
				canBeSimple = FALSE;
#line 17171 "VerilogParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			test=parallel_or_full_path_description();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if (!( !canBeSimple | test ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !canBeSimple | test ");
			if ( inputState->guessing==0 ) {
#line 3352 "verilog.parser.g"
				simple = TRUE;
#line 17195 "VerilogParser.cpp"
			}
			if (!( !ei  ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !ei  ");
			break;
		}
		case LPAREN:
		{
			parallel_or_full_edge_sensitive_path_description(canBeSimple);
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if (!( !po ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !po ");
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(ASSIGN);
		path_delay_value();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			simple_or_edge_sensitive_path_declaration_AST = RefVerAST(currentAST.root);
#line 3362 "verilog.parser.g"
			
			if (simple)
			simple_or_edge_sensitive_path_declaration_AST = 
			RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(SIMPLE_PATH_DECLARATION,"SIMPLE_PATH_DECLARATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(simple_or_edge_sensitive_path_declaration_AST))));
			else
			simple_or_edge_sensitive_path_declaration_AST = 
			RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EDGE_SENSITIVE_PATH_DECLARATION,"EDGE_SENSITIVE_PATH_DECLARATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(simple_or_edge_sensitive_path_declaration_AST))));
			
#line 17234 "VerilogParser.cpp"
			currentAST.root = simple_or_edge_sensitive_path_declaration_AST;
			if ( simple_or_edge_sensitive_path_declaration_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				simple_or_edge_sensitive_path_declaration_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = simple_or_edge_sensitive_path_declaration_AST->getFirstChild();
			else
				currentAST.child = simple_or_edge_sensitive_path_declaration_AST;
			currentAST.advanceChildToEnd();
		}
		simple_or_edge_sensitive_path_declaration_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3372 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17255 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = simple_or_edge_sensitive_path_declaration_AST;
}

void VerilogParser::state_dependent_path_declaration() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST state_dependent_path_declaration_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_IF:
		{
			RefVerAST tmp514_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp514_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp514_AST));
			}
			match(K_IF);
			match(LPAREN);
			module_path_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			simple_or_edge_sensitive_path_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			state_dependent_path_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_IFNONE:
		{
			RefVerAST tmp517_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp517_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp517_AST));
			}
			match(K_IFNONE);
			simple_or_edge_sensitive_path_declaration();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			state_dependent_path_declaration_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3563 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17322 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = state_dependent_path_declaration_AST;
}

void VerilogParser::edge_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST edge_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_POSEDGE:
		{
			RefVerAST tmp518_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp518_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp518_AST));
			}
			match(K_POSEDGE);
			edge_identifier_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NEGEDGE:
		{
			RefVerAST tmp519_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp519_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp519_AST));
			}
			match(K_NEGEDGE);
			edge_identifier_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3544 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17375 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = edge_identifier_AST;
}

TBool  VerilogParser::list_of_path_inputs() {
#line 3393 "verilog.parser.g"
	TBool canBeSimple;
#line 17386 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_path_inputs_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		canBeSimple=list_of_path_terminals();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		list_of_path_inputs_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3397 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17408 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_path_inputs_AST;
	return canBeSimple;
}

TBool  VerilogParser::polarity_operator(
	TBool canBeColon
) {
#line 3583 "verilog.parser.g"
	TBool hasColon;
#line 17422 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST polarity_operator_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST tok_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3583 "verilog.parser.g"
	
	hasColon = false;
	
#line 17432 "VerilogParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case PLUS:
		{
			RefVerAST tmp520_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp520_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp520_AST));
			}
			match(PLUS);
			break;
		}
		case MINUS:
		{
			RefVerAST tmp521_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp521_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp521_AST));
			}
			match(MINUS);
			break;
		}
		case PO_POS:
		{
			RefVerAST tmp522_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp522_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp522_AST));
			}
			match(PO_POS);
			if ( inputState->guessing==0 ) {
#line 3589 "verilog.parser.g"
				hasColon = true;
#line 17468 "VerilogParser.cpp"
			}
			break;
		}
		case PO_NEG:
		{
			RefVerAST tmp523_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp523_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp523_AST));
			}
			match(PO_NEG);
			if ( inputState->guessing==0 ) {
#line 3590 "verilog.parser.g"
				hasColon = true;
#line 17483 "VerilogParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case COLON:
		{
			tok = LT(1);
			if ( inputState->guessing == 0 ) {
				tok_AST = astFactory->create(tok);
			}
			match(COLON);
			if ( inputState->guessing==0 ) {
#line 3593 "verilog.parser.g"
				if(!hasColon) hasColon = true;
				else throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Unexpected :",
				tok->getFilename(), 
				tok->getLine(), 
				tok->getColumn() );
				
#line 17510 "VerilogParser.cpp"
			}
			break;
		}
		case PPATH:
		case FPATH:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if (!( !(canBeColon ^ hasColon) ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !(canBeColon ^ hasColon) ");
		if ( inputState->guessing==0 ) {
			polarity_operator_AST = RefVerAST(currentAST.root);
#line 3601 "verilog.parser.g"
			polarity_operator_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(POLARITY_OPERATOR,"POLARITY_OPERATOR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(polarity_operator_AST))));
#line 17531 "VerilogParser.cpp"
			currentAST.root = polarity_operator_AST;
			if ( polarity_operator_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				polarity_operator_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = polarity_operator_AST->getFirstChild();
			else
				currentAST.child = polarity_operator_AST;
			currentAST.advanceChildToEnd();
		}
		polarity_operator_AST = RefVerAST(currentAST.root);
	}
	catch (SemanticException &sem) {
		if (inputState->guessing==0) {
#line 3604 "verilog.parser.g"
			
			args.push_back("");
			if(canBeColon)
			args.push_back("Polarity operator must be followed by a colon");
			else
			args.push_back("Polarity operator can't be followed by a colon");
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args,sem.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17555 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3614 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17570 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = polarity_operator_AST;
	return hasColon;
}

TBool  VerilogParser::parallel_or_full_path_description() {
#line 3381 "verilog.parser.g"
	TBool canBeSimple;
#line 17582 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST parallel_or_full_path_description_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		canBeSimple=list_of_path_outputs();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		parallel_or_full_path_description_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3385 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17604 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = parallel_or_full_path_description_AST;
	return canBeSimple;
}

void VerilogParser::parallel_or_full_edge_sensitive_path_description(
	TBool canBeSimple
) {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST parallel_or_full_edge_sensitive_path_description_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3502 "verilog.parser.g"
	TBool test;
	//TBool hasColon = false;
	
#line 17623 "VerilogParser.cpp"
	
	try {      // for error handling
		match(LPAREN);
		test=list_of_path_outputs();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if (!( !canBeSimple || test ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !canBeSimple || test ");
		if ( inputState->guessing==0 ) {
#line 3509 "verilog.parser.g"
			cerr << "---------------" << endl;
#line 17636 "VerilogParser.cpp"
		}
		{
		switch ( LA(1)) {
		case PO_POS:
		{
			RefVerAST tmp525_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp525_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp525_AST));
			}
			match(PO_POS);
			break;
		}
		case PO_NEG:
		{
			RefVerAST tmp526_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp526_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp526_AST));
			}
			match(PO_NEG);
			break;
		}
		case COLON:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(COLON);
		data_source_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		parallel_or_full_edge_sensitive_path_description_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3520 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17688 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = parallel_or_full_edge_sensitive_path_description_AST;
}

void VerilogParser::path_delay_value() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST path_delay_value_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		bool synPredMatched515 = false;
		if (((LA(1) == LPAREN))) {
			int _m515 = mark();
			synPredMatched515 = true;
			inputState->guessing++;
			try {
				{
				match(LPAREN);
				list_of_path_delay_expressions();
				match(RPAREN);
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched515 = false;
			}
			rewind(_m515);
			inputState->guessing--;
		}
		if ( synPredMatched515 ) {
			RefVerAST tmp529_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp529_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp529_AST));
			}
			match(LPAREN);
			list_of_path_delay_expressions();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			path_delay_value_AST = RefVerAST(currentAST.root);
		}
		else if ((_tokenSet_13.member(LA(1)))) {
			list_of_path_delay_expressions();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			path_delay_value_AST = RefVerAST(currentAST.root);
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3458 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17756 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = path_delay_value_AST;
}

TBool  VerilogParser::list_of_path_terminals() {
#line 3417 "verilog.parser.g"
	TBool canBeSimple;
#line 17767 "VerilogParser.cpp"
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_path_terminals_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		specify_terminal_descriptor();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
#line 3419 "verilog.parser.g"
			canBeSimple = true;
#line 17780 "VerilogParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				specify_terminal_descriptor();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 3422 "verilog.parser.g"
					
					if( canBeSimple )
					canBeSimple = false;
					
#line 17796 "VerilogParser.cpp"
				}
			}
			else {
				goto _loop510;
			}
			
		}
		_loop510:;
		} // ( ... )*
		list_of_path_terminals_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3429 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17818 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_path_terminals_AST;
	return canBeSimple;
}

void VerilogParser::specify_terminal_descriptor() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST specify_terminal_descriptor_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			match(LBRACK);
			constant_range_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RBRACK);
			break;
		}
		case COLON:
		case COMMA:
		case MINUS:
		case RPAREN:
		case SEMI:
		case PLUS:
		case TAND:
		case PPATH:
		case FPATH:
		case PO_POS:
		case PO_NEG:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			specify_terminal_descriptor_AST = RefVerAST(currentAST.root);
#line 3441 "verilog.parser.g"
			specify_terminal_descriptor_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(SPECIFY_TERMINAL_DESCRIPTOR,"SPECIFY_TERMINAL_DESCRIPTOR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(specify_terminal_descriptor_AST))));
#line 17873 "VerilogParser.cpp"
			currentAST.root = specify_terminal_descriptor_AST;
			if ( specify_terminal_descriptor_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				specify_terminal_descriptor_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = specify_terminal_descriptor_AST->getFirstChild();
			else
				currentAST.child = specify_terminal_descriptor_AST;
			currentAST.advanceChildToEnd();
		}
		specify_terminal_descriptor_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3444 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17894 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = specify_terminal_descriptor_AST;
}

void VerilogParser::list_of_path_delay_expressions() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST list_of_path_delay_expressions_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3466 "verilog.parser.g"
	int counter=1;
#line 17908 "VerilogParser.cpp"
	
	try {      // for error handling
		path_delay_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				path_delay_expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if ( inputState->guessing==0 ) {
#line 3469 "verilog.parser.g"
					++counter;
#line 17926 "VerilogParser.cpp"
				}
			}
			else {
				goto _loop518;
			}
			
		}
		_loop518:;
		} // ( ... )*
		if (!(    counter == 1 
    || counter == 2
    || counter == 3
    || counter == 6
    || counter == 12
  ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException("    counter == 1 \n    || counter == 2\n    || counter == 3\n    || counter == 6\n    || counter == 12\n  ");
		if ( inputState->guessing==0 ) {
			list_of_path_delay_expressions_AST = RefVerAST(currentAST.root);
#line 3476 "verilog.parser.g"
			
			list_of_path_delay_expressions_AST = 
			RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(LIST_OF_PATH_DELAY_EXPRESSIONS,"LIST_OF_PATH_DELAY_EXPRESSIONS")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(list_of_path_delay_expressions_AST))));
			
#line 17950 "VerilogParser.cpp"
			currentAST.root = list_of_path_delay_expressions_AST;
			if ( list_of_path_delay_expressions_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				list_of_path_delay_expressions_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = list_of_path_delay_expressions_AST->getFirstChild();
			else
				currentAST.child = list_of_path_delay_expressions_AST;
			currentAST.advanceChildToEnd();
		}
		list_of_path_delay_expressions_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3482 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 17971 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = list_of_path_delay_expressions_AST;
}

void VerilogParser::path_delay_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST path_delay_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		constant_mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		path_delay_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3494 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 18001 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = path_delay_expression_AST;
}

void VerilogParser::data_source_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST data_source_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		data_source_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3531 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 18031 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = data_source_expression_AST;
}

void VerilogParser::module_path_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST module_path_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		module_path_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3575 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 18061 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = module_path_expression_AST;
}

void VerilogParser::setup_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST setup_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp535_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp535_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp535_AST));
		}
		match(K_S_SETUP);
		match(LPAREN);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp539_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp539_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp539_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		setup_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3660 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 18153 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = setup_timing_check_AST;
}

void VerilogParser::hold_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST hold_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp542_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp542_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp542_AST));
		}
		match(K_S_HOLD);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp546_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp546_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp546_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		hold_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3679 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 18245 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = hold_timing_check_AST;
}

void VerilogParser::setuphold_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST setuphold_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp549_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp549_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp549_AST));
		}
		match(K_S_SETUPHOLD);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp554_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp554_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp554_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case COMMA:
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				RefVerAST tmp555_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp555_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp555_AST));
				}
				match(COMMA);
				{
				switch ( LA(1)) {
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case MINUS:
				case LCRULY:
				case LPAREN:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				case STRING:
				case SYSTEM_TASK_NAME:
				{
					stamptime_condition();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					break;
				}
				case COMMA:
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				{
				switch ( LA(1)) {
				case COMMA:
				{
					RefVerAST tmp556_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp556_AST = astFactory->create(LT(1));
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp556_AST));
					}
					match(COMMA);
					{
					switch ( LA(1)) {
					case UNSIGNED_NUMBER:
					case REAL_NUMBER:
					case BASED_NUMBER:
					case MINUS:
					case LCRULY:
					case LPAREN:
					case PLUS:
					case LNOT:
					case NOT:
					case AND:
					case NAND:
					case OR:
					case NOR:
					case XOR:
					case XNOR:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case STRING:
					case SYSTEM_TASK_NAME:
					{
						checktime_condition();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case COMMA:
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					{
					switch ( LA(1)) {
					case COMMA:
					{
						RefVerAST tmp557_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
						if ( inputState->guessing == 0 ) {
							tmp557_AST = astFactory->create(LT(1));
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp557_AST));
						}
						match(COMMA);
						{
						switch ( LA(1)) {
						case IDENTIFIER:
						case ESCAPED_IDENTIFIER:
						{
							delayed_reference();
							if (inputState->guessing==0) {
								astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
							}
							break;
						}
						case COMMA:
						case RPAREN:
						{
							break;
						}
						default:
						{
							throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
						}
						}
						}
						{
						switch ( LA(1)) {
						case COMMA:
						{
							RefVerAST tmp558_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
							if ( inputState->guessing == 0 ) {
								tmp558_AST = astFactory->create(LT(1));
								astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp558_AST));
							}
							match(COMMA);
							{
							switch ( LA(1)) {
							case IDENTIFIER:
							case ESCAPED_IDENTIFIER:
							{
								delayed_data();
								if (inputState->guessing==0) {
									astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
								}
								break;
							}
							case RPAREN:
							{
								break;
							}
							default:
							{
								throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
							}
							}
							}
							break;
						}
						case RPAREN:
						{
							break;
						}
						default:
						{
							throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
						}
						}
						}
						break;
					}
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		setuphold_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3708 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 18552 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = setuphold_timing_check_AST;
}

void VerilogParser::recovery_timing_cehck() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST recovery_timing_cehck_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp561_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp561_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp561_AST));
		}
		match(K_S_RECOVERY);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp565_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp565_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp565_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		recovery_timing_cehck_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3727 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 18644 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = recovery_timing_cehck_AST;
}

void VerilogParser::removal_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST removal_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp568_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp568_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp568_AST));
		}
		match(K_S_REMOVAL);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp572_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp572_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp572_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		removal_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3746 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 18736 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = removal_timing_check_AST;
}

void VerilogParser::recrem_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST recrem_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp575_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp575_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp575_AST));
		}
		match(K_S_RECREM);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp580_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp580_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp580_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case COMMA:
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				RefVerAST tmp581_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp581_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp581_AST));
				}
				match(COMMA);
				{
				switch ( LA(1)) {
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case MINUS:
				case LCRULY:
				case LPAREN:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				case STRING:
				case SYSTEM_TASK_NAME:
				{
					stamptime_condition();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					break;
				}
				case COMMA:
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				{
				switch ( LA(1)) {
				case COMMA:
				{
					RefVerAST tmp582_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp582_AST = astFactory->create(LT(1));
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp582_AST));
					}
					match(COMMA);
					{
					switch ( LA(1)) {
					case UNSIGNED_NUMBER:
					case REAL_NUMBER:
					case BASED_NUMBER:
					case MINUS:
					case LCRULY:
					case LPAREN:
					case PLUS:
					case LNOT:
					case NOT:
					case AND:
					case NAND:
					case OR:
					case NOR:
					case XOR:
					case XNOR:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case STRING:
					case SYSTEM_TASK_NAME:
					{
						checktime_condition();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case COMMA:
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					{
					switch ( LA(1)) {
					case COMMA:
					{
						RefVerAST tmp583_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
						if ( inputState->guessing == 0 ) {
							tmp583_AST = astFactory->create(LT(1));
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp583_AST));
						}
						match(COMMA);
						{
						switch ( LA(1)) {
						case IDENTIFIER:
						case ESCAPED_IDENTIFIER:
						{
							delayed_reference();
							if (inputState->guessing==0) {
								astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
							}
							break;
						}
						case COMMA:
						case RPAREN:
						{
							break;
						}
						default:
						{
							throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
						}
						}
						}
						{
						switch ( LA(1)) {
						case COMMA:
						{
							RefVerAST tmp584_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
							if ( inputState->guessing == 0 ) {
								tmp584_AST = astFactory->create(LT(1));
								astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp584_AST));
							}
							match(COMMA);
							{
							switch ( LA(1)) {
							case IDENTIFIER:
							case ESCAPED_IDENTIFIER:
							{
								delayed_data();
								if (inputState->guessing==0) {
									astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
								}
								break;
							}
							case RPAREN:
							{
								break;
							}
							default:
							{
								throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
							}
							}
							}
							break;
						}
						case RPAREN:
						{
							break;
						}
						default:
						{
							throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
						}
						}
						}
						break;
					}
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		recrem_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3775 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19043 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = recrem_timing_check_AST;
}

void VerilogParser::skew_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST skew_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp587_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp587_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp587_AST));
		}
		match(K_S_SKEW);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp591_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp591_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp591_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		skew_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3794 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19135 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = skew_timing_check_AST;
}

void VerilogParser::timeskew_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST timeskew_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp594_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp594_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp594_AST));
		}
		match(K_S_TIMESKEW);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp598_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp598_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp598_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case COMMA:
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				RefVerAST tmp599_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp599_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp599_AST));
				}
				match(COMMA);
				{
				switch ( LA(1)) {
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case MINUS:
				case LCRULY:
				case LPAREN:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				case STRING:
				case SYSTEM_TASK_NAME:
				{
					event_based_flag();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					break;
				}
				case COMMA:
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				{
				switch ( LA(1)) {
				case COMMA:
				{
					RefVerAST tmp600_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp600_AST = astFactory->create(LT(1));
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp600_AST));
					}
					match(COMMA);
					{
					switch ( LA(1)) {
					case UNSIGNED_NUMBER:
					case REAL_NUMBER:
					case BASED_NUMBER:
					case MINUS:
					case LCRULY:
					case LPAREN:
					case PLUS:
					case LNOT:
					case NOT:
					case AND:
					case NAND:
					case OR:
					case NOR:
					case XOR:
					case XNOR:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case STRING:
					case SYSTEM_TASK_NAME:
					{
						remain_active_flag();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		timeskew_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3818 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19349 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = timeskew_timing_check_AST;
}

void VerilogParser::fullskew_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST fullskew_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp603_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp603_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp603_AST));
		}
		match(K_S_FULLSKEW);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp608_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp608_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp608_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case COMMA:
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				RefVerAST tmp609_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp609_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp609_AST));
				}
				match(COMMA);
				{
				switch ( LA(1)) {
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case MINUS:
				case LCRULY:
				case LPAREN:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				case STRING:
				case SYSTEM_TASK_NAME:
				{
					event_based_flag();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					break;
				}
				case COMMA:
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				{
				switch ( LA(1)) {
				case COMMA:
				{
					RefVerAST tmp610_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp610_AST = astFactory->create(LT(1));
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp610_AST));
					}
					match(COMMA);
					{
					switch ( LA(1)) {
					case UNSIGNED_NUMBER:
					case REAL_NUMBER:
					case BASED_NUMBER:
					case MINUS:
					case LCRULY:
					case LPAREN:
					case PLUS:
					case LNOT:
					case NOT:
					case AND:
					case NAND:
					case OR:
					case NOR:
					case XOR:
					case XNOR:
					case IDENTIFIER:
					case ESCAPED_IDENTIFIER:
					case STRING:
					case SYSTEM_TASK_NAME:
					{
						remain_active_flag();
						if (inputState->guessing==0) {
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						break;
					}
					case RPAREN:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
					}
					}
					}
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		fullskew_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3843 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19568 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = fullskew_timing_check_AST;
}

void VerilogParser::period_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST period_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp613_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp613_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp613_AST));
		}
		match(K_S_PERIOD);
		match(LPAREN);
		controlled_reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp616_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp616_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp616_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		period_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3861 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19655 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = period_timing_check_AST;
}

void VerilogParser::width_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST width_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp619_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp619_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp619_AST));
		}
		match(K_S_WIDTH);
		match(LPAREN);
		controlled_reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		timing_check_limit();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp622_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp622_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp622_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case MINUS:
			case LCRULY:
			case LPAREN:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			case STRING:
			case SYSTEM_TASK_NAME:
			{
				threshold();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case COMMA:
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			switch ( LA(1)) {
			case COMMA:
			{
				RefVerAST tmp623_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp623_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp623_AST));
				}
				match(COMMA);
				{
				switch ( LA(1)) {
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				{
					notify_reg();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
					break;
				}
				case RPAREN:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		width_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3881 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19803 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = width_timing_check_AST;
}

void VerilogParser::nochange_timing_check() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST nochange_timing_check_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp626_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp626_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp626_AST));
		}
		match(K_S_NOCHANGE);
		match(LPAREN);
		reference_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		data_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		start_edge_offset();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COMMA);
		end_edge_offset();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		{
			RefVerAST tmp631_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp631_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp631_AST));
			}
			match(COMMA);
			{
			switch ( LA(1)) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				notify_reg();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RPAREN);
		match(SEMI);
		nochange_timing_check_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3901 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19900 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = nochange_timing_check_AST;
}

void VerilogParser::data_event() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST data_event_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		timing_check_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		data_event_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3938 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19930 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = data_event_AST;
}

void VerilogParser::reference_event() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST reference_event_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		timing_check_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		reference_event_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4024 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19960 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = reference_event_AST;
}

void VerilogParser::timing_check_limit() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST timing_check_limit_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		timing_check_limit_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4084 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 19990 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = timing_check_limit_AST;
}

void VerilogParser::notify_reg() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST notify_reg_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		variable_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		notify_reg_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4012 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20020 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = notify_reg_AST;
}

void VerilogParser::stamptime_condition() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST stamptime_condition_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		stamptime_condition_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4048 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20050 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = stamptime_condition_AST;
}

void VerilogParser::checktime_condition() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST checktime_condition_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		checktime_condition_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3914 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20080 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = checktime_condition_AST;
}

void VerilogParser::delayed_reference() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST delayed_reference_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		delayed_data_or_reference();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		delayed_reference_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3962 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20110 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = delayed_reference_AST;
}

void VerilogParser::delayed_data() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST delayed_data_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		delayed_data_or_reference();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		delayed_data_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3950 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20140 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = delayed_data_AST;
}

void VerilogParser::event_based_flag() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST event_based_flag_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		event_based_flag_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4000 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20170 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = event_based_flag_AST;
}

void VerilogParser::remain_active_flag() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST remain_active_flag_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		constant_mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		remain_active_flag_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4036 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20200 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = remain_active_flag_AST;
}

void VerilogParser::controlled_reference_event() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST controlled_reference_event_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		controlled_timing_check_event();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		controlled_reference_event_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3926 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20230 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = controlled_reference_event_AST;
}

void VerilogParser::threshold() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST threshold_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		constant_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		threshold_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4072 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20260 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = threshold_AST;
}

void VerilogParser::start_edge_offset() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST start_edge_offset_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		start_edge_offset_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4060 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20290 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = start_edge_offset_AST;
}

void VerilogParser::end_edge_offset() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST end_edge_offset_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		mintypmax_expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		end_edge_offset_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3988 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20320 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = end_edge_offset_AST;
}

void VerilogParser::controlled_timing_check_event() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST controlled_timing_check_event_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		timing_check_event_control();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		specify_terminal_descriptor();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case TAND:
		{
			match(TAND);
			timing_check_condition();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case COMMA:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			controlled_timing_check_event_AST = RefVerAST(currentAST.root);
#line 4113 "verilog.parser.g"
			
			controlled_timing_check_event_AST = 
			RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CONTROLLED_TIMING_CHECK_EVENT,"CONTROLLED_TIMING_CHECK_EVENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(controlled_timing_check_event_AST))));
			
#line 20370 "VerilogParser.cpp"
			currentAST.root = controlled_timing_check_event_AST;
			if ( controlled_timing_check_event_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				controlled_timing_check_event_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = controlled_timing_check_event_AST->getFirstChild();
			else
				currentAST.child = controlled_timing_check_event_AST;
			currentAST.advanceChildToEnd();
		}
		controlled_timing_check_event_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4119 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20391 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = controlled_timing_check_event_AST;
}

void VerilogParser::timing_check_event() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST timing_check_event_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case K_EDGE:
		case K_NEGEDGE:
		case K_POSEDGE:
		{
			timing_check_event_control();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		specify_terminal_descriptor();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case TAND:
		{
			match(TAND);
			timing_check_condition();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case COMMA:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			timing_check_event_AST = RefVerAST(currentAST.root);
#line 4098 "verilog.parser.g"
			timing_check_event_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(TIMING_CHECK_EVENT,"TIMING_CHECK_EVENT")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(timing_check_event_AST))));
#line 20457 "VerilogParser.cpp"
			currentAST.root = timing_check_event_AST;
			if ( timing_check_event_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				timing_check_event_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = timing_check_event_AST->getFirstChild();
			else
				currentAST.child = timing_check_event_AST;
			currentAST.advanceChildToEnd();
		}
		timing_check_event_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4101 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20478 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = timing_check_event_AST;
}

void VerilogParser::delayed_data_or_reference() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST delayed_data_or_reference_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		terminal_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case LBRACK:
		{
			match(LBRACK);
			constant_mintypmax_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RBRACK);
			break;
		}
		case COMMA:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			delayed_data_or_reference_AST = RefVerAST(currentAST.root);
#line 3973 "verilog.parser.g"
			delayed_data_or_reference_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(DELAYED_DATA_OR_REFERENCE,"DELAYED_DATA_OR_REFERENCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(delayed_data_or_reference_AST))));
#line 20523 "VerilogParser.cpp"
			currentAST.root = delayed_data_or_reference_AST;
			if ( delayed_data_or_reference_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				delayed_data_or_reference_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = delayed_data_or_reference_AST->getFirstChild();
			else
				currentAST.child = delayed_data_or_reference_AST;
			currentAST.advanceChildToEnd();
		}
		delayed_data_or_reference_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 3976 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20544 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = delayed_data_or_reference_AST;
}

void VerilogParser::terminal_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST terminal_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		terminal_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 5026 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20574 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = terminal_identifier_AST;
}

void VerilogParser::timing_check_event_control() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST timing_check_event_control_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case K_POSEDGE:
		{
			RefVerAST tmp638_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp638_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp638_AST));
			}
			match(K_POSEDGE);
			timing_check_event_control_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_NEGEDGE:
		{
			RefVerAST tmp639_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp639_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp639_AST));
			}
			match(K_NEGEDGE);
			timing_check_event_control_AST = RefVerAST(currentAST.root);
			break;
		}
		case K_EDGE:
		{
			edge_control_specifier();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			timing_check_event_control_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4133 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20636 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = timing_check_event_control_AST;
}

void VerilogParser::timing_check_condition() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST timing_check_condition_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		scalar_timing_check_condition();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		timing_check_condition_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4174 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20666 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = timing_check_condition_AST;
}

void VerilogParser::edge_control_specifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST edge_control_specifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		RefVerAST tmp640_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
		if ( inputState->guessing == 0 ) {
			tmp640_AST = astFactory->create(LT(1));
			astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp640_AST));
		}
		match(K_EDGE);
		match(LBRACK);
		edge_descriptor();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				edge_descriptor();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop616;
			}
			
		}
		_loop616:;
		} // ( ... )*
		match(RBRACK);
		edge_control_specifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4148 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20720 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = edge_control_specifier_AST;
}

void VerilogParser::edge_descriptor() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST edge_descriptor_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		{
			RefVerAST tmp644_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp644_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp644_AST));
			}
			match(UNSIGNED_NUMBER);
			edge_descriptor_AST = RefVerAST(currentAST.root);
			break;
		}
		case IDENTIFIER:
		{
			RefVerAST tmp645_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp645_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp645_AST));
			}
			match(IDENTIFIER);
			edge_descriptor_AST = RefVerAST(currentAST.root);
			break;
		}
		case EDGE_DESC:
		{
			RefVerAST tmp646_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp646_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp646_AST));
			}
			match(EDGE_DESC);
			edge_descriptor_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4162 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20784 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = edge_descriptor_AST;
}

void VerilogParser::scalar_timing_check_condition() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST scalar_timing_check_condition_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		scalar_timing_check_condition_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4186 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20814 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = scalar_timing_check_condition_AST;
}

void VerilogParser::concatenation() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST concatenation_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(LCRULY);
		{
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COMMA:
		case RCRULY:
		{
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
					expression();
					if (inputState->guessing==0) {
						astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
					}
				}
				else {
					goto _loop624;
				}
				
			}
			_loop624:;
			} // ( ... )*
			if ( inputState->guessing==0 ) {
				concatenation_AST = RefVerAST(currentAST.root);
#line 4200 "verilog.parser.g"
				concatenation_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(CONCATENATION,"CONCATENATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(concatenation_AST))));
#line 20859 "VerilogParser.cpp"
				currentAST.root = concatenation_AST;
				if ( concatenation_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					concatenation_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = concatenation_AST->getFirstChild();
				else
					currentAST.child = concatenation_AST;
				currentAST.advanceChildToEnd();
			}
			break;
		}
		case LCRULY:
		{
			concatenation();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				concatenation_AST = RefVerAST(currentAST.root);
#line 4202 "verilog.parser.g"
				concatenation_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MULTI_CONCATENATION,"MULTI_CONCATENATION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(concatenation_AST))));
#line 20880 "VerilogParser.cpp"
				currentAST.root = concatenation_AST;
				if ( concatenation_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					concatenation_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = concatenation_AST->getFirstChild();
				else
					currentAST.child = concatenation_AST;
				currentAST.advanceChildToEnd();
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		}
		match(RCRULY);
		concatenation_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4208 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20911 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = concatenation_AST;
}

void VerilogParser::function_call() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST function_call_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		hierarchical_function_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		attrs_opt();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(LPAREN);
		expression_list();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(RPAREN);
		if ( inputState->guessing==0 ) {
			function_call_AST = RefVerAST(currentAST.root);
#line 4221 "verilog.parser.g"
			function_call_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(FUNCTION_CALL,"FUNCTION_CALL")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(function_call_AST))));
#line 20943 "VerilogParser.cpp"
			currentAST.root = function_call_AST;
			if ( function_call_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				function_call_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = function_call_AST->getFirstChild();
			else
				currentAST.child = function_call_AST;
			currentAST.advanceChildToEnd();
		}
		function_call_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4224 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20964 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = function_call_AST;
}

void VerilogParser::hierarchical_function_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST hierarchical_function_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		hierarchical_identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		hierarchical_function_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4834 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 20994 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = hierarchical_function_identifier_AST;
}

void VerilogParser::system_function_call() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST system_function_call_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		system_function_name();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case LPAREN:
		{
			match(LPAREN);
			expression_list();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(RPAREN);
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case K_OR:
		case COLON:
		case COMMA:
		case MINUS:
		case RBRACK:
		case LCRULY:
		case RCRULY:
		case RPAREN:
		case QUESTION:
		case SEMI:
		case PLUS:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STARP:
		case PO_POS:
		case PO_NEG:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			system_function_call_AST = RefVerAST(currentAST.root);
#line 4235 "verilog.parser.g"
			system_function_call_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(SYSTEM_FUNCTION_CALL,"SYSTEM_FUNCTION_CALL")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(system_function_call_AST))));
#line 21076 "VerilogParser.cpp"
			currentAST.root = system_function_call_AST;
			if ( system_function_call_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				system_function_call_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = system_function_call_AST->getFirstChild();
			else
				currentAST.child = system_function_call_AST;
			currentAST.advanceChildToEnd();
		}
		system_function_call_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4238 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21097 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = system_function_call_AST;
}

void VerilogParser::range_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST range_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case COLON:
		case PO_POS:
		case PO_NEG:
		{
			{
			switch ( LA(1)) {
			case COLON:
			{
				RefVerAST tmp654_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp654_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp654_AST));
				}
				match(COLON);
				expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case PO_POS:
			{
				RefVerAST tmp655_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp655_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp655_AST));
				}
				match(PO_POS);
				expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			case PO_NEG:
			{
				RefVerAST tmp656_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp656_AST = astFactory->create(LT(1));
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp656_AST));
				}
				match(PO_NEG);
				expression();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			if ( inputState->guessing==0 ) {
				range_expression_AST = RefVerAST(currentAST.root);
#line 4267 "verilog.parser.g"
				range_expression_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(RANGE_EXPRESSION,"RANGE_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(range_expression_AST))));
#line 21175 "VerilogParser.cpp"
				currentAST.root = range_expression_AST;
				if ( range_expression_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					range_expression_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = range_expression_AST->getFirstChild();
				else
					currentAST.child = range_expression_AST;
				currentAST.advanceChildToEnd();
			}
			break;
		}
		case RBRACK:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		range_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4271 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21208 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = range_expression_AST;
}

void VerilogParser::pure_mintypmax_expression() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pure_mintypmax_expression_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COLON);
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		match(COLON);
		expression();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		if ( inputState->guessing==0 ) {
			pure_mintypmax_expression_AST = RefVerAST(currentAST.root);
#line 4299 "verilog.parser.g"
			pure_mintypmax_expression_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MINTYPMAX_EXPRESSION,"MINTYPMAX_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(pure_mintypmax_expression_AST))));
#line 21240 "VerilogParser.cpp"
			currentAST.root = pure_mintypmax_expression_AST;
			if ( pure_mintypmax_expression_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				pure_mintypmax_expression_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = pure_mintypmax_expression_AST->getFirstChild();
			else
				currentAST.child = pure_mintypmax_expression_AST;
			currentAST.advanceChildToEnd();
		}
		pure_mintypmax_expression_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4302 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21261 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pure_mintypmax_expression_AST;
}

void VerilogParser::conditional_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST conditional_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		logical_or_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case QUESTION:
		{
			RefVerAST tmp659_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp659_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp659_AST));
			}
			match(QUESTION);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			conditional_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			match(COLON);
			conditional_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case K_OR:
		case COLON:
		case COMMA:
		case RBRACK:
		case LCRULY:
		case RCRULY:
		case RPAREN:
		case SEMI:
		case STARP:
		case PO_POS:
		case PO_NEG:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		conditional_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4328 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21337 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = conditional_expr_AST;
}

void VerilogParser::logical_or_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST logical_or_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		logical_and_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LOR)) {
				RefVerAST tmp661_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp661_AST = astFactory->create(LT(1));
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp661_AST));
				}
				match(LOR);
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				logical_and_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop642;
			}
			
		}
		_loop642:;
		} // ( ... )*
		logical_or_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4340 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21392 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = logical_or_expr_AST;
}

void VerilogParser::logical_and_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST logical_and_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		or_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LAND)) {
				RefVerAST tmp662_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
				if ( inputState->guessing == 0 ) {
					tmp662_AST = astFactory->create(LT(1));
					astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp662_AST));
				}
				match(LAND);
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				or_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop645;
			}
			
		}
		_loop645:;
		} // ( ... )*
		logical_and_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4352 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21447 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = logical_and_expr_AST;
}

void VerilogParser::or_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST or_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		xor_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OR || LA(1) == NOR)) {
				{
				switch ( LA(1)) {
				case OR:
				{
					RefVerAST tmp663_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp663_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp663_AST));
					}
					match(OR);
					break;
				}
				case NOR:
				{
					RefVerAST tmp664_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp664_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp664_AST));
					}
					match(NOR);
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				xor_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop649;
			}
			
		}
		_loop649:;
		} // ( ... )*
		or_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4364 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21524 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = or_expr_AST;
}

void VerilogParser::xor_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST xor_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		and_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == XOR || LA(1) == XNOR)) {
				{
				switch ( LA(1)) {
				case XOR:
				{
					RefVerAST tmp665_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp665_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp665_AST));
					}
					match(XOR);
					break;
				}
				case XNOR:
				{
					RefVerAST tmp666_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp666_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp666_AST));
					}
					match(XNOR);
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				and_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop653;
			}
			
		}
		_loop653:;
		} // ( ... )*
		xor_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4376 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21601 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = xor_expr_AST;
}

void VerilogParser::and_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST and_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		equality_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == AND || LA(1) == NAND)) {
				{
				switch ( LA(1)) {
				case AND:
				{
					RefVerAST tmp667_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp667_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp667_AST));
					}
					match(AND);
					break;
				}
				case NAND:
				{
					RefVerAST tmp668_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp668_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp668_AST));
					}
					match(NAND);
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				equality_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop657;
			}
			
		}
		_loop657:;
		} // ( ... )*
		and_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4388 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21678 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = and_expr_AST;
}

void VerilogParser::equality_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST equality_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		relational_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if (((LA(1) >= EQUAL && LA(1) <= EQ_CASE))) {
				{
				switch ( LA(1)) {
				case EQUAL:
				{
					RefVerAST tmp669_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp669_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp669_AST));
					}
					match(EQUAL);
					break;
				}
				case NOT_EQ:
				{
					RefVerAST tmp670_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp670_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp670_AST));
					}
					match(NOT_EQ);
					break;
				}
				case NOT_EQ_CASE:
				{
					RefVerAST tmp671_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp671_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp671_AST));
					}
					match(NOT_EQ_CASE);
					break;
				}
				case EQ_CASE:
				{
					RefVerAST tmp672_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp672_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp672_AST));
					}
					match(EQ_CASE);
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				relational_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop661;
			}
			
		}
		_loop661:;
		} // ( ... )*
		equality_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4401 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21775 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = equality_expr_AST;
}

void VerilogParser::relational_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST relational_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		shift_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if (((LA(1) >= LT_ && LA(1) <= GE))) {
				{
				switch ( LA(1)) {
				case LT_:
				{
					RefVerAST tmp673_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp673_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp673_AST));
					}
					match(LT_);
					break;
				}
				case GT:
				{
					RefVerAST tmp674_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp674_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp674_AST));
					}
					match(GT);
					break;
				}
				case LE:
				{
					RefVerAST tmp675_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp675_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp675_AST));
					}
					match(LE);
					break;
				}
				case GE:
				{
					RefVerAST tmp676_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp676_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp676_AST));
					}
					match(GE);
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				shift_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop665;
			}
			
		}
		_loop665:;
		} // ( ... )*
		relational_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4413 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21872 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = relational_expr_AST;
}

void VerilogParser::shift_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST shift_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		addictive_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if (((LA(1) >= SL && LA(1) <= SSR))) {
				{
				switch ( LA(1)) {
				case SL:
				{
					RefVerAST tmp677_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp677_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp677_AST));
					}
					match(SL);
					break;
				}
				case SSL:
				{
					RefVerAST tmp678_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp678_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp678_AST));
					}
					match(SSL);
					break;
				}
				case SR:
				{
					RefVerAST tmp679_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp679_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp679_AST));
					}
					match(SR);
					break;
				}
				case SSR:
				{
					RefVerAST tmp680_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp680_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp680_AST));
					}
					match(SSR);
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				addictive_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop669;
			}
			
		}
		_loop669:;
		} // ( ... )*
		shift_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4425 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 21969 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = shift_expr_AST;
}

void VerilogParser::addictive_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST addictive_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		multiplicative_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == MINUS || LA(1) == PLUS)) {
				{
				switch ( LA(1)) {
				case PLUS:
				{
					RefVerAST tmp681_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp681_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp681_AST));
					}
					match(PLUS);
					break;
				}
				case MINUS:
				{
					RefVerAST tmp682_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp682_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp682_AST));
					}
					match(MINUS);
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				multiplicative_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop673;
			}
			
		}
		_loop673:;
		} // ( ... )*
		addictive_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4437 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 22046 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = addictive_expr_AST;
}

void VerilogParser::multiplicative_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST multiplicative_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		pow_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == STAR || LA(1) == DIV || LA(1) == MOD)) {
				{
				switch ( LA(1)) {
				case STAR:
				{
					RefVerAST tmp683_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp683_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp683_AST));
					}
					match(STAR);
					break;
				}
				case DIV:
				{
					RefVerAST tmp684_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp684_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp684_AST));
					}
					match(DIV);
					break;
				}
				case MOD:
				{
					RefVerAST tmp685_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
					if ( inputState->guessing == 0 ) {
						tmp685_AST = astFactory->create(LT(1));
						astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp685_AST));
					}
					match(MOD);
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				attrs_opt();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				pow_expr();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop677;
			}
			
		}
		_loop677:;
		} // ( ... )*
		multiplicative_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4449 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 22133 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = multiplicative_expr_AST;
}

void VerilogParser::pow_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST pow_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		unary_expr();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case K_OR:
		case COLON:
		case COMMA:
		case MINUS:
		case RBRACK:
		case LCRULY:
		case RCRULY:
		case RPAREN:
		case QUESTION:
		case SEMI:
		case PLUS:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STARP:
		case PO_POS:
		case PO_NEG:
		{
			break;
		}
		case POW:
		{
			RefVerAST tmp686_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp686_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp686_AST));
			}
			match(POW);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			pow_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		pow_expr_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4466 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 22230 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = pow_expr_AST;
}

void VerilogParser::unary_expr() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST unary_expr_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST ex1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST ex2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST ex3_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4474 "verilog.parser.g"
	bool test  = false;
#line 22247 "VerilogParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case LCRULY:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case STRING:
		case SYSTEM_TASK_NAME:
		{
			expr_primary();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case LPAREN:
		{
			match(LPAREN);
			expression();
			if (inputState->guessing==0) {
				ex1_AST = returnAST;
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4478 "verilog.parser.g"
				unary_expr_AST = ex1_AST;
#line 22278 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			{
			switch ( LA(1)) {
			case COLON:
			{
				match(COLON);
				expression();
				if (inputState->guessing==0) {
					ex2_AST = returnAST;
				}
				match(COLON);
				expression();
				if (inputState->guessing==0) {
					ex3_AST = returnAST;
				}
				if ( inputState->guessing==0 ) {
#line 4483 "verilog.parser.g"
					test = true;
#line 22304 "VerilogParser.cpp"
				}
				if ( inputState->guessing==0 ) {
					unary_expr_AST = RefVerAST(currentAST.root);
#line 4484 "verilog.parser.g"
					unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(4))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MINTYPMAX_EXPRESSION,"MINTYPMAX_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(ex1_AST))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(ex2_AST))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(ex3_AST))));
#line 22310 "VerilogParser.cpp"
					currentAST.root = unary_expr_AST;
					if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
						unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						  currentAST.child = unary_expr_AST->getFirstChild();
					else
						currentAST.child = unary_expr_AST;
					currentAST.advanceChildToEnd();
				}
				break;
			}
			case RPAREN:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4486 "verilog.parser.g"
				if(!test) unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(MINTYPMAX_EXPRESSION,"MINTYPMAX_EXPRESSION")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(ex1_AST))));
#line 22335 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			match(RPAREN);
			break;
		}
		case PLUS:
		{
			match(PLUS);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4488 "verilog.parser.g"
				unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(U_PLUS,"U_PLUS")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(unary_expr_AST))));
#line 22362 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case MINUS:
		{
			match(MINUS);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4489 "verilog.parser.g"
				unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(U_MINUS,"U_MINUS")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(unary_expr_AST))));
#line 22389 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case LNOT:
		{
			RefVerAST tmp693_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp693_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp693_AST));
			}
			match(LNOT);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case NOT:
		{
			RefVerAST tmp694_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp694_AST = astFactory->create(LT(1));
				astFactory->makeASTRoot(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp694_AST));
			}
			match(NOT);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case AND:
		{
			match(AND);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4492 "verilog.parser.g"
				unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(U_AND,"U_AND")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(unary_expr_AST))));
#line 22454 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case NAND:
		{
			match(NAND);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4493 "verilog.parser.g"
				unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(U_NAND,"U_NAND")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(unary_expr_AST))));
#line 22481 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case OR:
		{
			match(OR);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4494 "verilog.parser.g"
				unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(U_OR,"U_OR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(unary_expr_AST))));
#line 22508 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case NOR:
		{
			match(NOR);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4495 "verilog.parser.g"
				unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(U_NOR,"U_NOR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(unary_expr_AST))));
#line 22535 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case XOR:
		{
			match(XOR);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4496 "verilog.parser.g"
				unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(U_XOR,"U_XOR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(unary_expr_AST))));
#line 22562 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		case XNOR:
		{
			match(XNOR);
			attrs_opt();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			unary_expr();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			if ( inputState->guessing==0 ) {
				unary_expr_AST = RefVerAST(currentAST.root);
#line 4497 "verilog.parser.g"
				unary_expr_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(U_XNOR,"U_XNOR")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(unary_expr_AST))));
#line 22589 "VerilogParser.cpp"
				currentAST.root = unary_expr_AST;
				if ( unary_expr_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					unary_expr_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = unary_expr_AST->getFirstChild();
				else
					currentAST.child = unary_expr_AST;
				currentAST.advanceChildToEnd();
			}
			unary_expr_AST = RefVerAST(currentAST.root);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4500 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 22617 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = unary_expr_AST;
}

void VerilogParser::expr_primary() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST expr_primary_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST epi_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST el_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		{
			number();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case STRING:
		{
			RefVerAST tmp701_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
			if ( inputState->guessing == 0 ) {
				tmp701_AST = astFactory->create(LT(1));
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tmp701_AST));
			}
			match(STRING);
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			expr_primary_identifier();
			if (inputState->guessing==0) {
				epi_AST = returnAST;
			}
			if ( inputState->guessing==0 ) {
				expr_primary_AST = RefVerAST(currentAST.root);
#line 4513 "verilog.parser.g"
				expr_primary_AST = epi_AST;
#line 22666 "VerilogParser.cpp"
				currentAST.root = expr_primary_AST;
				if ( expr_primary_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
					expr_primary_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					  currentAST.child = expr_primary_AST->getFirstChild();
				else
					currentAST.child = expr_primary_AST;
				currentAST.advanceChildToEnd();
			}
			{
			switch ( LA(1)) {
			case PSTAR:
			case LPAREN:
			{
				attrs_opt();
				match(LPAREN);
				expression_list();
				if (inputState->guessing==0) {
					el_AST = returnAST;
				}
				match(RPAREN);
				if ( inputState->guessing==0 ) {
					expr_primary_AST = RefVerAST(currentAST.root);
#line 4517 "verilog.parser.g"
					expr_primary_AST =  RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(3))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(FUNCTION_CALL,"FUNCTION_CALL")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(epi_AST))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(el_AST))));
#line 22691 "VerilogParser.cpp"
					currentAST.root = expr_primary_AST;
					if ( expr_primary_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
						expr_primary_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						  currentAST.child = expr_primary_AST->getFirstChild();
					else
						currentAST.child = expr_primary_AST;
					currentAST.advanceChildToEnd();
				}
				break;
			}
			case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
			case K_OR:
			case COLON:
			case COMMA:
			case MINUS:
			case RBRACK:
			case LCRULY:
			case RCRULY:
			case RPAREN:
			case QUESTION:
			case SEMI:
			case PLUS:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STARP:
			case PO_POS:
			case PO_NEG:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case LCRULY:
		{
			concatenation();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case SYSTEM_TASK_NAME:
		{
			system_function_call();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		expr_primary_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4524 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 22786 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = expr_primary_AST;
}

void VerilogParser::expr_primary_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST expr_primary_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST rn1_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST rn2_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4754 "verilog.parser.g"
	
	RefVerAST tempRef=RefVerAST(0);
	//We use the count to check and make sure that only the last range is multiple
	unsigned int count =0;
	
#line 22806 "VerilogParser.cpp"
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LBRACK)) {
				match(LBRACK);
				range_expression();
				if (inputState->guessing==0) {
					rn1_AST = returnAST;
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if (!( tempRef.get() ? tempRef->getType() == EXPRESSION : true ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" tempRef.get() ? tempRef->getType() == EXPRESSION : true ");
				if ( inputState->guessing==0 ) {
#line 4765 "verilog.parser.g"
					count++;
#line 22827 "VerilogParser.cpp"
				}
				if ( inputState->guessing==0 ) {
#line 4767 "verilog.parser.g"
					tempRef = rn1_AST;
#line 22832 "VerilogParser.cpp"
				}
				match(RBRACK);
			}
			else {
				goto _loop717;
			}
			
		}
		_loop717:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == DOT)) {
				match(DOT);
				identifier();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
				if (!( count < 2 ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" count < 2 ");
				if ( inputState->guessing==0 ) {
#line 4773 "verilog.parser.g"
					count=0;
#line 22856 "VerilogParser.cpp"
				}
				if (!( tempRef.get() ? tempRef->getType() == EXPRESSION : true ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" tempRef.get() ? tempRef->getType() == EXPRESSION : true ");
				{ // ( ... )*
				for (;;) {
					if ((LA(1) == LBRACK)) {
						match(LBRACK);
						range_expression();
						if (inputState->guessing==0) {
							rn2_AST = returnAST;
							astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
						}
						if (!( tempRef.get() ? tempRef->getType() == EXPRESSION : true ))
							throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" tempRef.get() ? tempRef->getType() == EXPRESSION : true ");
						if ( inputState->guessing==0 ) {
#line 4781 "verilog.parser.g"
							tempRef = rn2_AST; count++;
#line 22874 "VerilogParser.cpp"
						}
						match(RBRACK);
					}
					else {
						goto _loop720;
					}
					
				}
				_loop720:;
				} // ( ... )*
			}
			else {
				goto _loop721;
			}
			
		}
		_loop721:;
		} // ( ... )*
		if ( inputState->guessing==0 ) {
			expr_primary_identifier_AST = RefVerAST(currentAST.root);
#line 4785 "verilog.parser.g"
			expr_primary_identifier_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(EXPR_PRIMARY_IDENTIFIER,"EXPR_PRIMARY_IDENTIFIER")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(expr_primary_identifier_AST))));
#line 22897 "VerilogParser.cpp"
			currentAST.root = expr_primary_identifier_AST;
			if ( expr_primary_identifier_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				expr_primary_identifier_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = expr_primary_identifier_AST->getFirstChild();
			else
				currentAST.child = expr_primary_identifier_AST;
			currentAST.advanceChildToEnd();
		}
		expr_primary_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4788 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 22918 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = expr_primary_identifier_AST;
}

void VerilogParser::based_number() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST based_number_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)RefToken  tok = ANTLR_USE_NAMESPACE(antlr)nullToken;
	RefVerAST tok_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		tok = LT(1);
		if ( inputState->guessing == 0 ) {
			tok_AST = astFactory->create(tok);
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(tok_AST));
		}
		match(BASED_NUMBER);
		if ( inputState->guessing==0 ) {
			based_number_AST = RefVerAST(currentAST.root);
#line 4623 "verilog.parser.g"
			VerilogToken *vt = static_cast<VerilogToken*>(tok.get()); based_number_AST->setNumber(vt->getNumber());
#line 22944 "VerilogParser.cpp"
		}
		based_number_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4626 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 22958 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = based_number_AST;
}

void VerilogParser::attrs() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST attrs_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		{ // ( ... )+
		int _cnt699=0;
		for (;;) {
			if ((LA(1) == PSTAR)) {
				attribute_instance();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				if ( _cnt699>=1 ) { goto _loop699; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt699++;
		}
		_loop699:;
		}  // ( ... )+
		attrs_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4652 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 23001 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = attrs_AST;
}

void VerilogParser::attribute_instance() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST attribute_instance_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		match(PSTAR);
		attr_spec();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				attr_spec();
				if (inputState->guessing==0) {
					astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
				}
			}
			else {
				goto _loop705;
			}
			
		}
		_loop705:;
		} // ( ... )*
		match(STARP);
		if ( inputState->guessing==0 ) {
			attribute_instance_AST = RefVerAST(currentAST.root);
#line 4674 "verilog.parser.g"
			attribute_instance_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ATTRIBUTE_INSTANCE,"ATTRIBUTE_INSTANCE")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(attribute_instance_AST))));
#line 23041 "VerilogParser.cpp"
			currentAST.root = attribute_instance_AST;
			if ( attribute_instance_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				attribute_instance_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = attribute_instance_AST->getFirstChild();
			else
				currentAST.child = attribute_instance_AST;
			currentAST.advanceChildToEnd();
		}
		attribute_instance_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4677 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 23062 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = attribute_instance_AST;
}

void VerilogParser::attr_spec() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST attr_spec_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		attr_name();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		{
		switch ( LA(1)) {
		case ASSIGN:
		{
			match(ASSIGN);
			constant_expression();
			if (inputState->guessing==0) {
				astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
			}
			break;
		}
		case COMMA:
		case STARP:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		if ( inputState->guessing==0 ) {
			attr_spec_AST = RefVerAST(currentAST.root);
#line 4688 "verilog.parser.g"
			attr_spec_AST = RefVerAST(astFactory->make((new ANTLR_USE_NAMESPACE(antlr)ASTArray(2))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(astFactory->create(ATTR_SPEC,"ATTR_SPEC")))->add(ANTLR_USE_NAMESPACE(antlr)RefAST(attr_spec_AST))));
#line 23106 "VerilogParser.cpp"
			currentAST.root = attr_spec_AST;
			if ( attr_spec_AST!=RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) &&
				attr_spec_AST->getFirstChild() != RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				  currentAST.child = attr_spec_AST->getFirstChild();
			else
				currentAST.child = attr_spec_AST;
			currentAST.advanceChildToEnd();
		}
		attr_spec_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4691 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 23127 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = attr_spec_AST;
}

void VerilogParser::attr_name() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST attr_name_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		attr_name_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4703 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 23157 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = attr_name_AST;
}

void VerilogParser::specparam_identifier() {
	returnAST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	ANTLR_USE_NAMESPACE(antlr)ASTPair currentAST;
	RefVerAST specparam_identifier_AST = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	try {      // for error handling
		identifier();
		if (inputState->guessing==0) {
			astFactory->addASTChild(currentAST, ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST));
		}
		specparam_identifier_AST = RefVerAST(currentAST.root);
	}
	catch (RecognitionException &ex) {
		if (inputState->guessing==0) {
#line 4894 "verilog.parser.g"
			
			args.push_back(intToString(ex.getColumn()));
			args.push_back(ex.getMessage());
			addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
			verilogParserHasErrors = true;
			consume();
			
#line 23187 "VerilogParser.cpp"
		} else {
			throw;
		}
	}
	returnAST = specparam_identifier_AST;
}

void VerilogParser::initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& factory )
{
	factory.setMaxNodeType(333);
}
const char* VerilogParser::tokenNames[] = {
	"<0>",
	"EOF",
	"<2>",
	"NULL_TREE_LOOKAHEAD",
	"\"always\"",
	"\"and\"",
	"\"assign\"",
	"\"automatic\"",
	"\"begin\"",
	"\"buf\"",
	"\"bufif0\"",
	"\"bufif1\"",
	"\"case\"",
	"\"casex\"",
	"\"casez\"",
	"\"cmos\"",
	"\"deassign\"",
	"\"default\"",
	"\"defparam\"",
	"\"disable\"",
	"\"edge\"",
	"\"else\"",
	"\"end\"",
	"\"endcase\"",
	"\"endfunction\"",
	"\"endgenerate\"",
	"\"endmodule\"",
	"\"endprimitive\"",
	"\"endspecify\"",
	"K_ENDTABLE",
	"\"endtask\"",
	"\"event\"",
	"\"for\"",
	"\"force\"",
	"\"forever\"",
	"\"fork\"",
	"\"function\"",
	"\"generate\"",
	"\"genvar\"",
	"\"highz0\"",
	"\"highz1\"",
	"\"if\"",
	"\"ifnone\"",
	"\"initial\"",
	"\"inout\"",
	"\"input\"",
	"\"integer\"",
	"\"join\"",
	"\"large\"",
	"\"localparam\"",
	"\"macromodule\"",
	"\"medium\"",
	"\"module\"",
	"\"nand\"",
	"\"negedge\"",
	"\"nmos\"",
	"\"nor\"",
	"\"noshowcancelled\"",
	"\"not\"",
	"\"notif0\"",
	"\"notif1\"",
	"\"or\"",
	"\"output\"",
	"\"parameter\"",
	"\"pmos\"",
	"\"posedge\"",
	"\"primitive\"",
	"\"pull0\"",
	"\"pull1\"",
	"\"pulldown\"",
	"\"pullup\"",
	"\"pulsestyle_ondetect\"",
	"\"pulsestyle_onevent\"",
	"\"rcmos\"",
	"\"real\"",
	"\"realtime\"",
	"\"reg\"",
	"\"release\"",
	"\"repeat\"",
	"\"rnmos\"",
	"\"rpmos\"",
	"\"rtran\"",
	"\"rtranif0\"",
	"\"rtranif1\"",
	"\"scalared\"",
	"\"showcancelled\"",
	"\"signed\"",
	"\"small\"",
	"\"specify\"",
	"\"specparam\"",
	"\"strong0\"",
	"\"strong1\"",
	"\"supply0\"",
	"\"supply1\"",
	"K_TABLE",
	"\"task\"",
	"\"time\"",
	"\"tran\"",
	"\"tranif0\"",
	"\"tranif1\"",
	"\"tri\"",
	"\"tri0\"",
	"\"tri1\"",
	"\"triand\"",
	"\"trior\"",
	"\"trireg\"",
	"\"vectored\"",
	"\"wait\"",
	"\"wand\"",
	"\"weak0\"",
	"\"weak1\"",
	"\"while\"",
	"\"wire\"",
	"\"wor\"",
	"\"xnor\"",
	"\"xor\"",
	"\"$setup\"",
	"\"$hold\"",
	"\"$setuphold\"",
	"\"$recovery\"",
	"\"$removal\"",
	"\"$recrem\"",
	"\"$skew\"",
	"\"$timeskew\"",
	"\"$fullskew\"",
	"\"$period\"",
	"\"$width\"",
	"\"$nochange\"",
	"\"$attribute\"",
	"PSTAR",
	"UNSIGNED_NUMBER",
	"REAL_NUMBER",
	"BASED_NUMBER",
	"PATHPULSE",
	"UDP_Q0",
	"UDP_Q1",
	"UDP_QX",
	"UDP_QQ",
	"UDP_01",
	"UDP_0X",
	"UDP_0Q",
	"UDP_10",
	"UDP_1X",
	"UDP_1Q",
	"UDP_BX",
	"UDP_X0",
	"UDP_X1",
	"UDP_XQ",
	"UDP_B",
	"UDP_F",
	"UDP_R",
	"UDP_X",
	"UDP_N",
	"UDP_P",
	"UDP_0",
	"UDP_1",
	"BACKTICK",
	"AT",
	"COLON",
	"COMMA",
	"DOT",
	"ASSIGN",
	"MINUS",
	"LBRACK",
	"RBRACK",
	"LCRULY",
	"RCRULY",
	"LPAREN",
	"RPAREN",
	"POUND",
	"QUESTION",
	"SEMI",
	"PLUS",
	"LNOT",
	"NOT",
	"AND",
	"NAND",
	"OR",
	"NOR",
	"XOR",
	"XNOR",
	"STAR",
	"POW",
	"DIV",
	"MOD",
	"EQUAL",
	"NOT_EQ",
	"NOT_EQ_CASE",
	"EQ_CASE",
	"LAND",
	"TAND",
	"LOR",
	"LT_",
	"LE",
	"GT",
	"GE",
	"SL",
	"SSL",
	"SR",
	"SSR",
	"TRIGGER",
	"PPATH",
	"FPATH",
	"STARP",
	"PO_POS",
	"PO_NEG",
	"SUPERSTAR",
	"EDGE_DESC",
	"W",
	"END_OF_LINE",
	"VOCAB",
	"ALPHA",
	"DIGIT",
	"NZ_DIGIT",
	"BIN_DIGIT",
	"OCT_DIGIT",
	"HEX_DIGIT",
	"XZ_DIGIT",
	"IDENTIFIER",
	"ESCAPED_IDENTIFIER",
	"STRING",
	"NZ_UNSIGNED_NUMBER",
	"REAL_NUMBER_EXP",
	"SIGN",
	"EXP",
	"XZ_NUMBER",
	"BIN_NUMBER",
	"OCT_NUMBER",
	"HEX_NUMBER",
	"NUMBER",
	"BASED_NUMBER_HEADER",
	"SYSTEM_TASK_NAME",
	"FILENAME",
	"LINE_NUMBER",
	"HASH_LINE",
	"DIRECTIVE",
	"WS",
	"SL_COMMENT",
	"ML_COMMENT",
	"MODULE_DEF",
	"MODULE_PARAMETER_PORT_LIST",
	"LIST_OF_PORT_DECLARATIONS",
	"OUTPUT_VARIABLE_TYPE",
	"RANGE",
	"LIST_OF_VARIABLE_PORT_IDENTIFIERS",
	"PORT_REFERENCE",
	"PORT_REFERENCE_CONCAT",
	"NAMED_PORT_EXPRESSION",
	"PORT",
	"PORT_EXPRESSION",
	"ATTRIBUTE_INSTANCE",
	"ATTR_SPEC",
	"DIMENSION",
	"VARIABLE_PORT_IDENTIFIER",
	"DEFPARAM_ASSIGNMENT",
	"PARAM_ASSIGNMENT",
	"U_PLUS",
	"U_MINUS",
	"U_AND",
	"U_NAND",
	"U_OR",
	"U_NOR",
	"U_XOR",
	"U_XNOR",
	"EXPRESSION",
	"EXPRESSION_LIST",
	"CONCATENATION",
	"MULTI_CONCATENATION",
	"RANGE_EXPRESSION",
	"EXPR_PRIMARY_IDENTIFIER",
	"FUNCTION_CALL",
	"SYSTEM_FUNCTION_CALL",
	"HIERARCHICAL_IDENTIFIER",
	"MINTYPMAX_EXPRESSION",
	"LIST_OF_NET_IDENTIFIERS",
	"LIST_OF_NET_DECL_ASSIGNMENTS",
	"DELAY",
	"DELAY_VALUE",
	"VARIABLE_TYPE",
	"NET_DECLARATION",
	"LVALUE",
	"ASSIGNMENT",
	"BLOCKING_OR_NONBLOCKING_ASSIGNMENT",
	"PAR_BLOCK",
	"SEQ_BLOCK",
	"DELAY_CONTROL",
	"EVENT_CONTROL",
	"EVENT_EXPRESSION_PRIMARY",
	"OR_EVENT_EXPRESSION",
	"CASE_STATEMENT",
	"CASE_ITEM",
	"LOOP_STATEMENT",
	"EVENT_TRIGGER",
	"SYSTEM_TASK_ENABLE",
	"TASK_ENABLE",
	"TASK_PORT_LIST",
	"FUNCTION_PORT_LIST",
	"GATE_INSTANTIATION",
	"CMOS_SWITCH_INSTANCE",
	"ENABLE_GATE_INSTANCE",
	"MOS_SWITCH_INSTANCE",
	"N_INPUT_GATE_INSTANCE",
	"N_OUTPUT_GATE_INSTANCE",
	"PASS_ENABLE_SWITCH_INSTANCE",
	"PASS_SWITCH_INSTANCE",
	"PULL_GATE_INSTANCE",
	"MODULE_OR_UDP_INSTANTIATION",
	"LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2",
	"NAMED_PARAMETER_ASSIGNMENT",
	"MODULE_INSTANCE",
	"ORDERED_PORT_CONNECTION",
	"NAMED_PORT_CONNECTION",
	"GENERATE_ITEM_OR_NULL",
	"GENVAR_CASE_ITEM",
	"GENVAR_ASSIGNMENT",
	"GENERATE_BLOCK",
	"EDGE_SENSITIVE_PATH_DECLARATION",
	"SIMPLE_PATH_DECLARATION",
	"SPECIFY_TERMINAL_DESCRIPTOR",
	"LIST_OF_PATH_DELAY_EXPRESSIONS",
	"DELAYED_DATA_OR_REFERENCE",
	"TIMING_CHECK_EVENT",
	"CONTROLLED_TIMING_CHECK_EVENT",
	"SIZED_NUMBER",
	"STATEMENT_OR_NULL",
	"POLARITY_OPERATOR",
	"UDP_PORT_LIST",
	"UDP_DECLARATION_PORT_LIST",
	"UDP_TABLE_SEQ_ENTRY",
	"UDP_TABLE_COMB_ENTRY",
	"INPUT_LIST",
	"PULSE_CONTROL_SPECPARAM",
	"MY_TOKEN",
	"TICK",
	0
};

const unsigned long VerilogParser::_tokenSet_0_data_[] = { 71303424UL, 1310720UL, 4UL, 0UL, 4026531854UL, 4294965236UL, 1610645501UL, 0UL, 0UL, 0UL, 8192UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "begin" "end" "endmodule" "macromodule" "module" "primitive" PSTAR UNSIGNED_NUMBER 
// REAL_NUMBER BACKTICK AT COLON COMMA MINUS RBRACK LCRULY RCRULY LPAREN 
// RPAREN POUND QUESTION PLUS LNOT NOT AND NAND OR NOR XOR XNOR STAR POW 
// DIV MOD EQUAL NOT_EQ NOT_EQ_CASE EQ_CASE LAND TAND LOR LT_ GT GE SL 
// SSL SR SSR TRIGGER PPATH FPATH STARP PO_POS PO_NEG SUPERSTAR NZ_UNSIGNED_NUMBER 
// REAL_NUMBER_EXP TICK 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_0(_tokenSet_0_data_,24);
const unsigned long VerilogParser::_tokenSet_1_data_[] = { 2147782256UL, 4255283312UL, 3004145249UL, 988159UL, 2UL, 0UL, 201326592UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "always" "and" "assign" "buf" "bufif0" "bufif1" "cmos" "defparam" "event" 
// "function" "generate" "genvar" "initial" "inout" "input" "integer" "localparam" 
// "nand" "nmos" "nor" "not" "notif0" "notif1" "or" "output" "parameter" 
// "pmos" "pulldown" "pullup" "rcmos" "real" "realtime" "reg" "rnmos" "rpmos" 
// "rtran" "rtranif0" "rtranif1" "specify" "specparam" "supply0" "supply1" 
// "task" "time" "tran" "tranif0" "tranif1" "tri" "tri0" "tri1" "triand" 
// "trior" "trireg" "wand" "wire" "wor" "xnor" "xor" PSTAR IDENTIFIER ESCAPED_IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_1(_tokenSet_1_data_,16);
const unsigned long VerilogParser::_tokenSet_2_data_[] = { 0UL, 1073750016UL, 4096UL, 0UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "input" "output" "reg" PSTAR 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_2(_tokenSet_2_data_,12);
const unsigned long VerilogParser::_tokenSet_3_data_[] = { 0UL, 33555968UL, 35651968UL, 4293918720UL, 0UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "if" "ifnone" "noshowcancelled" "pulsestyle_ondetect" "pulsestyle_onevent" 
// "showcancelled" "specparam" "$setup" "$hold" "$setuphold" "$recovery" 
// "$removal" "$recrem" "$skew" "$timeskew" "$fullskew" "$period" "$width" 
// "$nochange" LPAREN 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_3(_tokenSet_3_data_,12);
const unsigned long VerilogParser::_tokenSet_4_data_[] = { 2147786608UL, 1033914961UL, 2953813601UL, 988159UL, 2UL, 0UL, 201326592UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "always" "and" "assign" "begin" "buf" "bufif0" "bufif1" "case" "cmos" 
// "defparam" "event" "for" "function" "genvar" "if" "initial" "integer" 
// "nand" "nmos" "nor" "not" "notif0" "notif1" "or" "pmos" "pulldown" "pullup" 
// "rcmos" "real" "realtime" "reg" "rnmos" "rpmos" "rtran" "rtranif0" "rtranif1" 
// "supply0" "supply1" "task" "time" "tran" "tranif0" "tranif1" "tri" "tri0" 
// "tri1" "triand" "trior" "trireg" "wand" "wire" "wor" "xnor" "xor" PSTAR 
// IDENTIFIER ESCAPED_IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_4(_tokenSet_4_data_,16);
const unsigned long VerilogParser::_tokenSet_5_data_[] = { 0UL, 0UL, 0UL, 0UL, 0UL, 640UL, 201326592UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// LPAREN POUND IDENTIFIER ESCAPED_IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_5(_tokenSet_5_data_,16);
const unsigned long VerilogParser::_tokenSet_6_data_[] = { 2148102464UL, 3221385743UL, 31744UL, 34817UL, 536870914UL, 2592UL, 201326848UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "assign" "begin" "case" "casex" "casez" "deassign" "disable" "event" 
// "for" "force" "forever" "fork" "if" "inout" "input" "integer" "localparam" 
// "output" "parameter" "real" "realtime" "reg" "release" "repeat" "time" 
// "wait" "while" PSTAR AT LCRULY POUND SEMI TRIGGER IDENTIFIER ESCAPED_IDENTIFIER 
// SYSTEM_TASK_NAME 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_6(_tokenSet_6_data_,16);
const unsigned long VerilogParser::_tokenSet_7_data_[] = { 2148102464UL, 2147631631UL, 31744UL, 34817UL, 536870914UL, 2592UL, 201326848UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "assign" "begin" "case" "casex" "casez" "deassign" "disable" "event" 
// "for" "force" "forever" "fork" "if" "integer" "localparam" "parameter" 
// "real" "realtime" "reg" "release" "repeat" "time" "wait" "while" PSTAR 
// AT LCRULY POUND SEMI TRIGGER IDENTIFIER ESCAPED_IDENTIFIER SYSTEM_TASK_NAME 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_7(_tokenSet_7_data_,16);
const unsigned long VerilogParser::_tokenSet_8_data_[] = { 2148102464UL, 2147639823UL, 31744UL, 34817UL, 536870914UL, 2592UL, 201326848UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "assign" "begin" "case" "casex" "casez" "deassign" "disable" "event" 
// "for" "force" "forever" "fork" "if" "input" "integer" "localparam" "parameter" 
// "real" "realtime" "reg" "release" "repeat" "time" "wait" "while" PSTAR 
// AT LCRULY POUND SEMI TRIGGER IDENTIFIER ESCAPED_IDENTIFIER SYSTEM_TASK_NAME 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_8(_tokenSet_8_data_,16);
const unsigned long VerilogParser::_tokenSet_9_data_[] = { 2196152176UL, 1033914961UL, 2953813601UL, 988159UL, 30UL, 2093220UL, 469762048UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "always" "and" "assign" "begin" "buf" "bufif0" "bufif1" "case" "cmos" 
// "default" "defparam" "else" "end" "endcase" "endgenerate" "event" "for" 
// "function" "genvar" "if" "initial" "integer" "nand" "nmos" "nor" "not" 
// "notif0" "notif1" "or" "pmos" "pulldown" "pullup" "rcmos" "real" "realtime" 
// "reg" "rnmos" "rpmos" "rtran" "rtranif0" "rtranif1" "supply0" "supply1" 
// "task" "time" "tran" "tranif0" "tranif1" "tri" "tri0" "tri1" "triand" 
// "trior" "trireg" "wand" "wire" "wor" "xnor" "xor" PSTAR UNSIGNED_NUMBER 
// REAL_NUMBER BASED_NUMBER MINUS LCRULY LPAREN PLUS LNOT NOT AND NAND 
// OR NOR XOR XNOR IDENTIFIER ESCAPED_IDENTIFIER STRING SYSTEM_TASK_NAME 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_9(_tokenSet_9_data_,16);
const unsigned long VerilogParser::_tokenSet_10_data_[] = { 131072UL, 0UL, 0UL, 0UL, 28UL, 2093220UL, 469762048UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "default" UNSIGNED_NUMBER REAL_NUMBER BASED_NUMBER MINUS LCRULY LPAREN 
// PLUS LNOT NOT AND NAND OR NOR XOR XNOR IDENTIFIER ESCAPED_IDENTIFIER 
// STRING SYSTEM_TASK_NAME 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_10(_tokenSet_10_data_,16);
const unsigned long VerilogParser::_tokenSet_11_data_[] = { 0UL, 0UL, 0UL, 0UL, 267386880UL, 2098304UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// UDP_B UDP_F UDP_R UDP_X UDP_N UDP_P UDP_0 UDP_1 LPAREN QUESTION STAR 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_11(_tokenSet_11_data_,12);
const unsigned long VerilogParser::_tokenSet_12_data_[] = { 3354394480UL, 4255316607UL, 3004169825UL, 1022975UL, 536870942UL, 2095780UL, 469762304UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "always" "and" "assign" "begin" "buf" "bufif0" "bufif1" "case" "casex" 
// "casez" "cmos" "deassign" "default" "defparam" "disable" "else" "end" 
// "endcase" "endfunction" "endgenerate" "endmodule" "endtask" "event" 
// "for" "force" "forever" "fork" "function" "generate" "genvar" "if" "initial" 
// "inout" "input" "integer" "join" "localparam" "nand" "nmos" "nor" "not" 
// "notif0" "notif1" "or" "output" "parameter" "pmos" "pulldown" "pullup" 
// "rcmos" "real" "realtime" "reg" "release" "repeat" "rnmos" "rpmos" "rtran" 
// "rtranif0" "rtranif1" "specify" "specparam" "supply0" "supply1" "task" 
// "time" "tran" "tranif0" "tranif1" "tri" "tri0" "tri1" "triand" "trior" 
// "trireg" "wait" "wand" "while" "wire" "wor" "xnor" "xor" PSTAR UNSIGNED_NUMBER 
// REAL_NUMBER BASED_NUMBER AT MINUS LCRULY LPAREN POUND SEMI PLUS LNOT 
// NOT AND NAND OR NOR XOR XNOR TRIGGER IDENTIFIER ESCAPED_IDENTIFIER STRING 
// SYSTEM_TASK_NAME 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_12(_tokenSet_12_data_,16);
const unsigned long VerilogParser::_tokenSet_13_data_[] = { 0UL, 0UL, 0UL, 0UL, 28UL, 2093220UL, 469762048UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// UNSIGNED_NUMBER REAL_NUMBER BASED_NUMBER MINUS LCRULY LPAREN PLUS LNOT 
// NOT AND NAND OR NOR XOR XNOR IDENTIFIER ESCAPED_IDENTIFIER STRING SYSTEM_TASK_NAME 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogParser::_tokenSet_13(_tokenSet_13_data_,16);


