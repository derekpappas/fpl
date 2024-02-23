/* $ANTLR 2.7.7 (20060906): "verilog.lexer.g" -> "VerilogLexer.cpp"$ */
#include "VerilogLexer.hpp"
#include <antlr/CharBuffer.hpp>
#include <antlr/TokenStreamException.hpp>
#include <antlr/TokenStreamIOException.hpp>
#include <antlr/TokenStreamRecognitionException.hpp>
#include <antlr/CharStreamException.hpp>
#include <antlr/CharStreamIOException.hpp>
#include <antlr/NoViableAltForCharException.hpp>

#line 37 "verilog.lexer.g"

typedef boost::shared_ptr<std::string> RefString;
#define _RS(str) (RefString(new string(str)))

#include <iostream>
#include "../../support/Base.hpp"
#include "VerilogToken.hpp"
ANTLR_USING_NAMESPACE(antlr);
#include "VerilogLexer.inc"
ANTLR_USING_NAMESPACE(std);

#line 24 "VerilogLexer.cpp"
VerilogLexer::VerilogLexer(ANTLR_USE_NAMESPACE(std)istream& in)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(new ANTLR_USE_NAMESPACE(antlr)CharBuffer(in),true)
{
	initLiterals();
}

VerilogLexer::VerilogLexer(ANTLR_USE_NAMESPACE(antlr)InputBuffer& ib)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(ib,true)
{
	initLiterals();
}

VerilogLexer::VerilogLexer(const ANTLR_USE_NAMESPACE(antlr)LexerSharedInputState& state)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(state,true)
{
	initLiterals();
}

void VerilogLexer::initLiterals()
{
	literals["endfunction"] = 24;
	literals["rtranif1"] = 83;
	literals["$skew"] = 122;
	literals["tranif1"] = 99;
	literals["xor"] = 115;
	literals["reg"] = 76;
	literals["rtranif0"] = 82;
	literals["tranif0"] = 98;
	literals["endtask"] = 30;
	literals["$setuphold"] = 118;
	literals["endprimitive"] = 27;
	literals["wait"] = 107;
	literals["nand"] = 53;
	literals["pulsestyle_ondetect"] = 71;
	literals["task"] = 95;
	literals["deassign"] = 16;
	literals["parameter"] = 63;
	literals["nmos"] = 55;
	literals["always"] = 4;
	literals["for"] = 32;
	literals["else"] = 21;
	literals["time"] = 96;
	literals["and"] = 5;
	literals["integer"] = 46;
	literals["$period"] = 125;
	literals["begin"] = 8;
	literals["$recovery"] = 119;
	literals["specparam"] = 89;
	literals["primitive"] = 66;
	literals["weak1"] = 110;
	literals["scalared"] = 84;
	literals["endgenerate"] = 25;
	literals["trireg"] = 105;
	literals["signed"] = 86;
	literals["pullup"] = 70;
	literals["weak0"] = 109;
	literals["localparam"] = 49;
	literals["tran"] = 97;
	literals["highz1"] = 40;
	literals["initial"] = 43;
	literals["rcmos"] = 73;
	literals["noshowcancelled"] = 57;
	literals["function"] = 36;
	literals["$recrem"] = 121;
	literals["highz0"] = 39;
	literals["showcancelled"] = 85;
	literals["not"] = 58;
	literals["triand"] = 103;
	literals["trior"] = 104;
	literals["defparam"] = 18;
	literals["pulldown"] = 69;
	literals["bufif1"] = 11;
	literals["genvar"] = 38;
	literals["rpmos"] = 80;
	literals["$hold"] = 117;
	literals["realtime"] = 75;
	literals["real"] = 74;
	literals["bufif0"] = 10;
	literals["nor"] = 56;
	literals["supply1"] = 93;
	literals["assign"] = 6;
	literals["join"] = 47;
	literals["endmodule"] = 26;
	literals["disable"] = 19;
	literals["wand"] = 108;
	literals["endcase"] = 23;
	literals["supply0"] = 92;
	literals["buf"] = 9;
	literals["strong1"] = 91;
	literals["repeat"] = 78;
	literals["negedge"] = 54;
	literals["rnmos"] = 79;
	literals["strong0"] = 90;
	literals["case"] = 12;
	literals["force"] = 33;
	literals["inout"] = 44;
	literals["output"] = 62;
	literals["fork"] = 35;
	literals["small"] = 87;
	literals["$timeskew"] = 123;
	literals["vectored"] = 106;
	literals["$attribute"] = 128;
	literals["pull1"] = 68;
	literals["endspecify"] = 28;
	literals["medium"] = 51;
	literals["pull0"] = 67;
	literals["rtran"] = 81;
	literals["xnor"] = 114;
	literals["forever"] = 34;
	literals["large"] = 48;
	literals["or"] = 61;
	literals["if"] = 41;
	literals["wire"] = 112;
	literals["posedge"] = 65;
	literals["tri1"] = 102;
	literals["module"] = 52;
	literals["$setup"] = 116;
	literals["input"] = 45;
	literals["$removal"] = 120;
	literals["specify"] = 88;
	literals["release"] = 77;
	literals["tri0"] = 101;
	literals["default"] = 17;
	literals["casez"] = 14;
	literals["event"] = 31;
	literals["generate"] = 37;
	literals["end"] = 22;
	literals["casex"] = 13;
	literals["wor"] = 113;
	literals["ifnone"] = 42;
	literals["cmos"] = 15;
	literals["$width"] = 126;
	literals["notif1"] = 60;
	literals["while"] = 111;
	literals["edge"] = 20;
	literals["$fullskew"] = 124;
	literals["notif0"] = 59;
	literals["macromodule"] = 50;
	literals["pulsestyle_onevent"] = 72;
	literals["tri"] = 100;
	literals["$nochange"] = 127;
	literals["automatic"] = 7;
	literals["pmos"] = 64;
}

ANTLR_USE_NAMESPACE(antlr)RefToken VerilogLexer::nextToken()
{
	ANTLR_USE_NAMESPACE(antlr)RefToken theRetToken;
	for (;;) {
		ANTLR_USE_NAMESPACE(antlr)RefToken theRetToken;
		int _ttype = ANTLR_USE_NAMESPACE(antlr)Token::INVALID_TYPE;
		resetText();
		try {   // for lexical and char stream error handling
			switch ( LA(1)) {
			case 0x40 /* '@' */ :
			{
				mAT(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x3a /* ':' */ :
			{
				mCOLON(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2c /* ',' */ :
			{
				mCOMMA(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2e /* '.' */ :
			{
				mDOT(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5b /* '[' */ :
			{
				mLBRACK(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5d /* ']' */ :
			{
				mRBRACK(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x7b /* '{' */ :
			{
				mLCRULY(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x7d /* '}' */ :
			{
				mRCRULY(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x29 /* ')' */ :
			{
				mRPAREN(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x3f /* '?' */ :
			{
				mQUESTION(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x3b /* ';' */ :
			{
				mSEMI(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5e /* '^' */ :
			{
				mXOR(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x25 /* '%' */ :
			{
				mMOD(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x41 /* 'A' */ :
			case 0x42 /* 'B' */ :
			case 0x43 /* 'C' */ :
			case 0x44 /* 'D' */ :
			case 0x45 /* 'E' */ :
			case 0x46 /* 'F' */ :
			case 0x47 /* 'G' */ :
			case 0x48 /* 'H' */ :
			case 0x49 /* 'I' */ :
			case 0x4a /* 'J' */ :
			case 0x4b /* 'K' */ :
			case 0x4c /* 'L' */ :
			case 0x4d /* 'M' */ :
			case 0x4e /* 'N' */ :
			case 0x4f /* 'O' */ :
			case 0x50 /* 'P' */ :
			case 0x51 /* 'Q' */ :
			case 0x52 /* 'R' */ :
			case 0x53 /* 'S' */ :
			case 0x54 /* 'T' */ :
			case 0x55 /* 'U' */ :
			case 0x56 /* 'V' */ :
			case 0x57 /* 'W' */ :
			case 0x58 /* 'X' */ :
			case 0x59 /* 'Y' */ :
			case 0x5a /* 'Z' */ :
			case 0x5f /* '_' */ :
			case 0x61 /* 'a' */ :
			case 0x62 /* 'b' */ :
			case 0x63 /* 'c' */ :
			case 0x64 /* 'd' */ :
			case 0x65 /* 'e' */ :
			case 0x66 /* 'f' */ :
			case 0x67 /* 'g' */ :
			case 0x68 /* 'h' */ :
			case 0x69 /* 'i' */ :
			case 0x6a /* 'j' */ :
			case 0x6b /* 'k' */ :
			case 0x6c /* 'l' */ :
			case 0x6d /* 'm' */ :
			case 0x6e /* 'n' */ :
			case 0x6f /* 'o' */ :
			case 0x70 /* 'p' */ :
			case 0x71 /* 'q' */ :
			case 0x72 /* 'r' */ :
			case 0x73 /* 's' */ :
			case 0x74 /* 't' */ :
			case 0x75 /* 'u' */ :
			case 0x76 /* 'v' */ :
			case 0x77 /* 'w' */ :
			case 0x78 /* 'x' */ :
			case 0x79 /* 'y' */ :
			case 0x7a /* 'z' */ :
			{
				mIDENTIFIER(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5c /* '\\' */ :
			{
				mESCAPED_IDENTIFIER(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x22 /* '\"' */ :
			{
				mSTRING(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x24 /* '$' */ :
			{
				mSYSTEM_TASK_NAME(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x8 /* '\10' */ :
			case 0x9 /* '\t' */ :
			case 0xa /* '\n' */ :
			case 0xc /* '\14' */ :
			case 0xd /* '\r' */ :
			case 0x20 /* ' ' */ :
			{
				mWS(true);
				theRetToken=_returnToken;
				break;
			}
			default:
				if ((LA(1) == 0x21 /* '!' */ ) && (LA(2) == 0x3d /* '=' */ ) && (LA(3) == 0x3d /* '=' */ )) {
					mNOT_EQ_CASE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3d /* '=' */ ) && (LA(3) == 0x3d /* '=' */ )) {
					mEQ_CASE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (LA(2) == 0x26 /* '&' */ ) && (LA(3) == 0x26 /* '&' */ )) {
					mTAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3c /* '<' */ ) && (LA(3) == 0x3c /* '<' */ )) {
					mSSL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3e /* '>' */ ) && (LA(3) == 0x3e /* '>' */ )) {
					mSSR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x28 /* '(' */ ) && (LA(2) == 0x2a /* '*' */ ) && (LA(3) == 0x29 /* ')' */ )) {
					mSUPERSTAR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x26 /* '&' */ )) {
					mNAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x7c /* '|' */ )) {
					mNOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x5e /* '^' */ )) {
					mXNOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2a /* '*' */ ) && (LA(2) == 0x2a /* '*' */ )) {
					mPOW(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3d /* '=' */ ) && (true)) {
					mEQUAL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x21 /* '!' */ ) && (LA(2) == 0x3d /* '=' */ ) && (true)) {
					mNOT_EQ(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (LA(2) == 0x26 /* '&' */ ) && (true)) {
					mLAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7c /* '|' */ ) && (LA(2) == 0x7c /* '|' */ )) {
					mLOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mLE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mGE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3c /* '<' */ ) && (true)) {
					mSL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3e /* '>' */ ) && (true)) {
					mSR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2d /* '-' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mTRIGGER(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mPPATH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2a /* '*' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mFPATH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x28 /* '(' */ ) && (LA(2) == 0x2a /* '*' */ ) && (true)) {
					mPSTAR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2a /* '*' */ ) && (LA(2) == 0x29 /* ')' */ )) {
					mSTARP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2b /* '+' */ ) && (LA(2) == 0x3a /* ':' */ )) {
					mPO_POS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2d /* '-' */ ) && (LA(2) == 0x3a /* ':' */ )) {
					mPO_NEG(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x30 /* '0' */  || LA(1) == 0x31 /* '1' */ ) && (_tokenSet_0.member(LA(2)))) {
					mEDGE_DESC(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x23 /* '#' */ ) && (LA(2) == 0x6c /* 'l' */ )) {
					mHASH_LINE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x60 /* '`' */ ) && (_tokenSet_1.member(LA(2)))) {
					mDIRECTIVE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2f /* '/' */ ) && (LA(2) == 0x2f /* '/' */ )) {
					mSL_COMMENT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2f /* '/' */ ) && (LA(2) == 0x2a /* '*' */ )) {
					mML_COMMENT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x60 /* '`' */ ) && (true)) {
					mBACKTICK(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (true)) {
					mASSIGN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2d /* '-' */ ) && (true)) {
					mMINUS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x28 /* '(' */ ) && (true)) {
					mLPAREN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x23 /* '#' */ ) && (true)) {
					mPOUND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2b /* '+' */ ) && (true)) {
					mPLUS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x21 /* '!' */ ) && (true)) {
					mLNOT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (true)) {
					mNOT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (true)) {
					mAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7c /* '|' */ ) && (true)) {
					mOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2a /* '*' */ ) && (true)) {
					mSTAR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2f /* '/' */ ) && (true)) {
					mDIV(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (true)) {
					mLT_(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (true)) {
					mGT(true);
					theRetToken=_returnToken;
				}
				else if ((_tokenSet_2.member(LA(1))) && (true)) {
					mNUMBER(true);
					theRetToken=_returnToken;
				}
			else {
				if (LA(1)==EOF_CHAR)
				{
					uponEOF();
					_returnToken = makeToken(ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE);
				}
				else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			}
			if ( !_returnToken )
				goto tryAgain; // found SKIP token

			_ttype = _returnToken->getType();
			_returnToken->setType(_ttype);
			return _returnToken;
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& e) {
				throw ANTLR_USE_NAMESPACE(antlr)TokenStreamRecognitionException(e);
		}
		catch (ANTLR_USE_NAMESPACE(antlr)CharStreamIOException& csie) {
			throw ANTLR_USE_NAMESPACE(antlr)TokenStreamIOException(csie.io);
		}
		catch (ANTLR_USE_NAMESPACE(antlr)CharStreamException& cse) {
			throw ANTLR_USE_NAMESPACE(antlr)TokenStreamException(cse.getMessage());
		}
tryAgain:;
	}
}

void VerilogLexer::mBACKTICK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BACKTICK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("`");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mAT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = AT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("@");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mCOLON(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = COLON;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(":");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mCOMMA(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = COMMA;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(",");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mDOT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DOT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(".");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mASSIGN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ASSIGN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("=");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mMINUS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MINUS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("-");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLBRACK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LBRACK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("[");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mRBRACK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RBRACK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("]");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLCRULY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LCRULY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("{");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mRCRULY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RCRULY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("}");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLPAREN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LPAREN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("(");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mRPAREN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RPAREN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(")");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mPOUND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = POUND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("#");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mQUESTION(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = QUESTION;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("?");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSEMI(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SEMI;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(";");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mPLUS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PLUS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("+");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLNOT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LNOT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("!");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mNOT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("~");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = AND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("&");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mNAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NAND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("~&");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("|");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mNOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("~|");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mXOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 283 "verilog.lexer.g"
	bool test = false;
#line 882 "VerilogLexer.cpp"
	
	match("^");
	{
	if ((LA(1) == 0x7e /* '~' */ )) {
		match("~");
		if ( inputState->guessing==0 ) {
#line 283 "verilog.lexer.g"
			test=true;
#line 891 "VerilogLexer.cpp"
		}
	}
	else {
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 283 "verilog.lexer.g"
		if(test) _ttype = XNOR;
#line 901 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mXNOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XNOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("~^");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSTAR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = STAR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("*");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mPOW(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = POW;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("**");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mDIV(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIV;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("/");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mMOD(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MOD;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("%");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mEQUAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EQUAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("==");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mNOT_EQ(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOT_EQ;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("!=");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mNOT_EQ_CASE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOT_EQ_CASE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("!==");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mEQ_CASE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EQ_CASE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("===");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LAND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("&&");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mTAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TAND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("&&&");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("||");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLT_(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LT_;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("<");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("<=");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mGT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = GT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(">");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mGE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = GE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(">=");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("<<");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSSL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SSL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("<<<");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(">>");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSSR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SSR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(">>>");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mTRIGGER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TRIGGER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("->");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mPPATH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PPATH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("=>");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mFPATH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FPATH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("*>");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mPSTAR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PSTAR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("(*");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSTARP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = STARP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("*)");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mPO_POS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PO_POS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("+:");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mPO_NEG(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PO_NEG;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("-:");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSUPERSTAR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SUPERSTAR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("(*)");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mEDGE_DESC(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EDGE_DESC;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	{
		match("0");
		break;
	}
	case 0x31 /* '1' */ :
	{
		match("1");
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	{
	switch ( LA(1)) {
	case 0x78 /* 'x' */ :
	{
		match("x");
		break;
	}
	case 0x58 /* 'X' */ :
	{
		match("X");
		break;
	}
	case 0x7a /* 'z' */ :
	{
		match("z");
		break;
	}
	case 0x5a /* 'Z' */ :
	{
		match("Z");
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mW(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = W;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	switch ( LA(1)) {
	case 0x20 /* ' ' */ :
	{
		match(' ' /* charlit */ );
		break;
	}
	case 0x9 /* '\t' */ :
	{
		match('\t' /* charlit */ );
		break;
	}
	case 0x8 /* '\10' */ :
	{
		match('\10' /* charlit */ );
		break;
	}
	case 0xc /* '\14' */ :
	{
		match('\14' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mEND_OF_LINE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = END_OF_LINE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	bool synPredMatched62 = false;
	if (((LA(1) == 0xd /* '\r' */ ) && (LA(2) == 0xa /* '\n' */ ) && (true))) {
		int _m62 = mark();
		synPredMatched62 = true;
		inputState->guessing++;
		try {
			{
			match("\r\n");
			}
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
			synPredMatched62 = false;
		}
		rewind(_m62);
		inputState->guessing--;
	}
	if ( synPredMatched62 ) {
		match("\r\n");
	}
	else if ((LA(1) == 0xd /* '\r' */ ) && (true) && (true)) {
		match('\r' /* charlit */ );
	}
	else if ((LA(1) == 0xa /* '\n' */ )) {
		match('\n' /* charlit */ );
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 337 "verilog.lexer.g"
		newline();
#line 1442 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mVOCAB(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = VOCAB;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('\3',static_cast<unsigned char>('\377'));
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mALPHA(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ALPHA;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x61 /* 'a' */ :
	case 0x62 /* 'b' */ :
	case 0x63 /* 'c' */ :
	case 0x64 /* 'd' */ :
	case 0x65 /* 'e' */ :
	case 0x66 /* 'f' */ :
	case 0x67 /* 'g' */ :
	case 0x68 /* 'h' */ :
	case 0x69 /* 'i' */ :
	case 0x6a /* 'j' */ :
	case 0x6b /* 'k' */ :
	case 0x6c /* 'l' */ :
	case 0x6d /* 'm' */ :
	case 0x6e /* 'n' */ :
	case 0x6f /* 'o' */ :
	case 0x70 /* 'p' */ :
	case 0x71 /* 'q' */ :
	case 0x72 /* 'r' */ :
	case 0x73 /* 's' */ :
	case 0x74 /* 't' */ :
	case 0x75 /* 'u' */ :
	case 0x76 /* 'v' */ :
	case 0x77 /* 'w' */ :
	case 0x78 /* 'x' */ :
	case 0x79 /* 'y' */ :
	case 0x7a /* 'z' */ :
	{
		matchRange('a','z');
		break;
	}
	case 0x41 /* 'A' */ :
	case 0x42 /* 'B' */ :
	case 0x43 /* 'C' */ :
	case 0x44 /* 'D' */ :
	case 0x45 /* 'E' */ :
	case 0x46 /* 'F' */ :
	case 0x47 /* 'G' */ :
	case 0x48 /* 'H' */ :
	case 0x49 /* 'I' */ :
	case 0x4a /* 'J' */ :
	case 0x4b /* 'K' */ :
	case 0x4c /* 'L' */ :
	case 0x4d /* 'M' */ :
	case 0x4e /* 'N' */ :
	case 0x4f /* 'O' */ :
	case 0x50 /* 'P' */ :
	case 0x51 /* 'Q' */ :
	case 0x52 /* 'R' */ :
	case 0x53 /* 'S' */ :
	case 0x54 /* 'T' */ :
	case 0x55 /* 'U' */ :
	case 0x56 /* 'V' */ :
	case 0x57 /* 'W' */ :
	case 0x58 /* 'X' */ :
	case 0x59 /* 'Y' */ :
	case 0x5a /* 'Z' */ :
	{
		matchRange('A','Z');
		break;
	}
	case 0x5f /* '_' */ :
	{
		match('_' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mDIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('0','9');
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mNZ_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NZ_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('1','9');
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mBIN_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BIN_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('0','1');
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mOCT_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OCT_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('0','7');
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mHEX_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HEX_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	case 0x32 /* '2' */ :
	case 0x33 /* '3' */ :
	case 0x34 /* '4' */ :
	case 0x35 /* '5' */ :
	case 0x36 /* '6' */ :
	case 0x37 /* '7' */ :
	case 0x38 /* '8' */ :
	case 0x39 /* '9' */ :
	{
		{
		matchRange('0','9');
		}
		break;
	}
	case 0x61 /* 'a' */ :
	case 0x62 /* 'b' */ :
	case 0x63 /* 'c' */ :
	case 0x64 /* 'd' */ :
	case 0x65 /* 'e' */ :
	case 0x66 /* 'f' */ :
	{
		{
		matchRange('a','f');
		}
		break;
	}
	case 0x41 /* 'A' */ :
	case 0x42 /* 'B' */ :
	case 0x43 /* 'C' */ :
	case 0x44 /* 'D' */ :
	case 0x45 /* 'E' */ :
	case 0x46 /* 'F' */ :
	{
		{
		matchRange('A','F');
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mXZ_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XZ_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x78 /* 'x' */ :
	{
		match('x' /* charlit */ );
		break;
	}
	case 0x58 /* 'X' */ :
	{
		match('X' /* charlit */ );
		break;
	}
	case 0x7a /* 'z' */ :
	{
		match('z' /* charlit */ );
		break;
	}
	case 0x5a /* 'Z' */ :
	{
		match('Z' /* charlit */ );
		break;
	}
	case 0x3f /* '?' */ :
	{
		match('?' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mIDENTIFIER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = IDENTIFIER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	mALPHA(false);
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x47 /* 'G' */ :
		case 0x48 /* 'H' */ :
		case 0x49 /* 'I' */ :
		case 0x4a /* 'J' */ :
		case 0x4b /* 'K' */ :
		case 0x4c /* 'L' */ :
		case 0x4d /* 'M' */ :
		case 0x4e /* 'N' */ :
		case 0x4f /* 'O' */ :
		case 0x50 /* 'P' */ :
		case 0x51 /* 'Q' */ :
		case 0x52 /* 'R' */ :
		case 0x53 /* 'S' */ :
		case 0x54 /* 'T' */ :
		case 0x55 /* 'U' */ :
		case 0x56 /* 'V' */ :
		case 0x57 /* 'W' */ :
		case 0x58 /* 'X' */ :
		case 0x59 /* 'Y' */ :
		case 0x5a /* 'Z' */ :
		case 0x5f /* '_' */ :
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		case 0x67 /* 'g' */ :
		case 0x68 /* 'h' */ :
		case 0x69 /* 'i' */ :
		case 0x6a /* 'j' */ :
		case 0x6b /* 'k' */ :
		case 0x6c /* 'l' */ :
		case 0x6d /* 'm' */ :
		case 0x6e /* 'n' */ :
		case 0x6f /* 'o' */ :
		case 0x70 /* 'p' */ :
		case 0x71 /* 'q' */ :
		case 0x72 /* 'r' */ :
		case 0x73 /* 's' */ :
		case 0x74 /* 't' */ :
		case 0x75 /* 'u' */ :
		case 0x76 /* 'v' */ :
		case 0x77 /* 'w' */ :
		case 0x78 /* 'x' */ :
		case 0x79 /* 'y' */ :
		case 0x7a /* 'z' */ :
		{
			mALPHA(false);
			break;
		}
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mDIGIT(false);
			break;
		}
		case 0x24 /* '$' */ :
		{
			match('$' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop76;
		}
		}
	}
	_loop76:;
	} // ( ... )*
	if ( inputState->guessing==0 ) {
#line 383 "verilog.lexer.g"
		
			string id = getText();
			if (startsWith(id, "PATHPULSE$", FALSE))
			    {
			    _ttype = PATHPULSE;
			    }
			else if (equal(id, "table"))
			    {
			    setUdpTable(TRUE);
			    _ttype = K_TABLE;
			    }
			else if (equal(id, "endtable"))
			    {
			    setUdpTable(FALSE);
			    _ttype = K_ENDTABLE;
			    }
			else if (equal(id, "b") && udpTable())
			    _ttype = UDP_B;
			else if (equal(id, "f") && udpTable())
			    _ttype = UDP_F;
			else if (equal(id, "r") && udpTable())
			    _ttype = UDP_R;
			else if (equal(id, "x") && udpTable())
			    _ttype = UDP_X;
			else if (equal(id, "n") && udpTable())
			    _ttype = UDP_N;
			else if (equal(id, "p") && udpTable())
			    _ttype = UDP_P;
			else if (equal(id, "B") && udpTable())
			    _ttype = UDP_B;
			else if (equal(id, "F") && udpTable())
			    _ttype = UDP_F;
			else if (equal(id, "R") && udpTable())
			    _ttype = UDP_R;
			else if (equal(id, "X") && udpTable())
			    _ttype = UDP_X;
			else if (equal(id, "N") && udpTable())
			    _ttype = UDP_N;
			else if (equal(id, "P") && udpTable())
			    _ttype = UDP_P;
			else
			    _ttype = testLiteralsTable(_ttype);
			
#line 1847 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mESCAPED_IDENTIFIER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ESCAPED_IDENTIFIER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 428 "verilog.lexer.g"
	char c = 0xFF;
#line 1863 "VerilogLexer.cpp"
	
	_saveIndex = text.length();
	match('\\' /* charlit */ );
	text.erase(_saveIndex);
	if ( inputState->guessing==0 ) {
#line 429 "verilog.lexer.g"
		text += c;
#line 1871 "VerilogLexer.cpp"
	}
	{ // ( ... )+
	int _cnt80=0;
	for (;;) {
		if ((_tokenSet_3.member(LA(1)))) {
			{
			match(_tokenSet_3);
			}
		}
		else if ((LA(1) == 0x2e /* '.' */ )) {
			_saveIndex = text.length();
			match('.' /* charlit */ );
			text.erase(_saveIndex);
			if ( inputState->guessing==0 ) {
#line 431 "verilog.lexer.g"
				text += c;
#line 1888 "VerilogLexer.cpp"
			}
		}
		else {
			if ( _cnt80>=1 ) { goto _loop80; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
		}
		
		_cnt80++;
	}
	_loop80:;
	}  // ( ... )+
	{
	switch ( LA(1)) {
	case 0x20 /* ' ' */ :
	{
		_saveIndex = text.length();
		match(' ' /* charlit */ );
		text.erase(_saveIndex);
		break;
	}
	case 0x9 /* '\t' */ :
	{
		_saveIndex = text.length();
		match('\t' /* charlit */ );
		text.erase(_saveIndex);
		break;
	}
	case 0x8 /* '\10' */ :
	{
		_saveIndex = text.length();
		match('\10' /* charlit */ );
		text.erase(_saveIndex);
		break;
	}
	case 0xc /* '\14' */ :
	{
		_saveIndex = text.length();
		match('\14' /* charlit */ );
		text.erase(_saveIndex);
		break;
	}
	case 0xa /* '\n' */ :
	case 0xd /* '\r' */ :
	{
		_saveIndex = text.length();
		mEND_OF_LINE(false);
		text.erase(_saveIndex);
		break;
	}
	default:
		{
		}
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSTRING(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = STRING;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	_saveIndex = text.length();
	match('\"' /* charlit */ );
	text.erase(_saveIndex);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 0x5c /* '\\' */ )) {
			{
			match('\\' /* charlit */ );
			{
			match(_tokenSet_4);
			}
			}
		}
		else if ((_tokenSet_5.member(LA(1)))) {
			{
			match(_tokenSet_5);
			}
		}
		else {
			goto _loop87;
		}
		
	}
	_loop87:;
	} // ( ... )*
	_saveIndex = text.length();
	match('\"' /* charlit */ );
	text.erase(_saveIndex);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mUNSIGNED_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UNSIGNED_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	mDIGIT(false);
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mDIGIT(false);
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop91;
		}
		}
	}
	_loop91:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mNZ_UNSIGNED_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NZ_UNSIGNED_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	mNZ_DIGIT(false);
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mDIGIT(false);
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop95;
		}
		}
	}
	_loop95:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mREAL_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = REAL_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	mUNSIGNED_NUMBER(false);
	match('.' /* charlit */ );
	mUNSIGNED_NUMBER(false);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mREAL_NUMBER_EXP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = REAL_NUMBER_EXP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	mUNSIGNED_NUMBER(false);
	{
	switch ( LA(1)) {
	case 0x2e /* '.' */ :
	{
		match('.' /* charlit */ );
		mUNSIGNED_NUMBER(false);
		break;
	}
	case 0x45 /* 'E' */ :
	case 0x65 /* 'e' */ :
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	mEXP(false);
	{
	switch ( LA(1)) {
	case 0x2b /* '+' */ :
	case 0x2d /* '-' */ :
	{
		mSIGN(false);
		break;
	}
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	case 0x32 /* '2' */ :
	case 0x33 /* '3' */ :
	case 0x34 /* '4' */ :
	case 0x35 /* '5' */ :
	case 0x36 /* '6' */ :
	case 0x37 /* '7' */ :
	case 0x38 /* '8' */ :
	case 0x39 /* '9' */ :
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	mUNSIGNED_NUMBER(false);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mEXP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EXP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x65 /* 'e' */ :
	{
		match('e' /* charlit */ );
		break;
	}
	case 0x45 /* 'E' */ :
	{
		match('E' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSIGN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SIGN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x2b /* '+' */ :
	{
		match('+' /* charlit */ );
		break;
	}
	case 0x2d /* '-' */ :
	{
		match('-' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mXZ_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XZ_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	mXZ_DIGIT(false);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 0x5f /* '_' */ )) {
			match('_' /* charlit */ );
		}
		else {
			goto _loop104;
		}
		
	}
	_loop104:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

 bool  VerilogLexer::mBIN_NUMBER(bool _createToken) {
#line 496 "verilog.lexer.g"
	 bool hasXZ ;
#line 2248 "VerilogLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BIN_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 496 "verilog.lexer.g"
	hasXZ = false;
#line 2254 "VerilogLexer.cpp"
	
	{
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	{
		mBIN_DIGIT(false);
		break;
	}
	case 0x3f /* '?' */ :
	case 0x58 /* 'X' */ :
	case 0x5a /* 'Z' */ :
	case 0x78 /* 'x' */ :
	case 0x7a /* 'z' */ :
	{
		mXZ_DIGIT(false);
		if ( inputState->guessing==0 ) {
#line 498 "verilog.lexer.g"
			hasXZ = true;
#line 2274 "VerilogLexer.cpp"
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		{
			mBIN_DIGIT(false);
			break;
		}
		case 0x3f /* '?' */ :
		case 0x58 /* 'X' */ :
		case 0x5a /* 'Z' */ :
		case 0x78 /* 'x' */ :
		case 0x7a /* 'z' */ :
		{
			mXZ_DIGIT(false);
			if ( inputState->guessing==0 ) {
#line 498 "verilog.lexer.g"
				hasXZ = true;
#line 2303 "VerilogLexer.cpp"
			}
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop108;
		}
		}
	}
	_loop108:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return hasXZ ;
}

 bool  VerilogLexer::mOCT_NUMBER(bool _createToken) {
#line 501 "verilog.lexer.g"
	 bool hasXZ ;
#line 2332 "VerilogLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OCT_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 501 "verilog.lexer.g"
	hasXZ = false;
#line 2338 "VerilogLexer.cpp"
	
	{
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	case 0x32 /* '2' */ :
	case 0x33 /* '3' */ :
	case 0x34 /* '4' */ :
	case 0x35 /* '5' */ :
	case 0x36 /* '6' */ :
	case 0x37 /* '7' */ :
	{
		mOCT_DIGIT(false);
		break;
	}
	case 0x3f /* '?' */ :
	case 0x58 /* 'X' */ :
	case 0x5a /* 'Z' */ :
	case 0x78 /* 'x' */ :
	case 0x7a /* 'z' */ :
	{
		mXZ_DIGIT(false);
		if ( inputState->guessing==0 ) {
#line 503 "verilog.lexer.g"
			hasXZ = true;
#line 2364 "VerilogLexer.cpp"
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		{
			mOCT_DIGIT(false);
			break;
		}
		case 0x3f /* '?' */ :
		case 0x58 /* 'X' */ :
		case 0x5a /* 'Z' */ :
		case 0x78 /* 'x' */ :
		case 0x7a /* 'z' */ :
		{
			mXZ_DIGIT(false);
			if ( inputState->guessing==0 ) {
#line 503 "verilog.lexer.g"
				hasXZ = true;
#line 2399 "VerilogLexer.cpp"
			}
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop112;
		}
		}
	}
	_loop112:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return hasXZ ;
}

 bool  VerilogLexer::mHEX_NUMBER(bool _createToken) {
#line 506 "verilog.lexer.g"
	 bool hasXZ ;
#line 2428 "VerilogLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HEX_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 506 "verilog.lexer.g"
	hasXZ = false;
#line 2434 "VerilogLexer.cpp"
	
	{
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	case 0x32 /* '2' */ :
	case 0x33 /* '3' */ :
	case 0x34 /* '4' */ :
	case 0x35 /* '5' */ :
	case 0x36 /* '6' */ :
	case 0x37 /* '7' */ :
	case 0x38 /* '8' */ :
	case 0x39 /* '9' */ :
	case 0x41 /* 'A' */ :
	case 0x42 /* 'B' */ :
	case 0x43 /* 'C' */ :
	case 0x44 /* 'D' */ :
	case 0x45 /* 'E' */ :
	case 0x46 /* 'F' */ :
	case 0x61 /* 'a' */ :
	case 0x62 /* 'b' */ :
	case 0x63 /* 'c' */ :
	case 0x64 /* 'd' */ :
	case 0x65 /* 'e' */ :
	case 0x66 /* 'f' */ :
	{
		mHEX_DIGIT(false);
		break;
	}
	case 0x3f /* '?' */ :
	case 0x58 /* 'X' */ :
	case 0x5a /* 'Z' */ :
	case 0x78 /* 'x' */ :
	case 0x7a /* 'z' */ :
	{
		mXZ_DIGIT(false);
		if ( inputState->guessing==0 ) {
#line 508 "verilog.lexer.g"
			hasXZ = true;
#line 2474 "VerilogLexer.cpp"
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		{
			mHEX_DIGIT(false);
			break;
		}
		case 0x3f /* '?' */ :
		case 0x58 /* 'X' */ :
		case 0x5a /* 'Z' */ :
		case 0x78 /* 'x' */ :
		case 0x7a /* 'z' */ :
		{
			mXZ_DIGIT(false);
			if ( inputState->guessing==0 ) {
#line 508 "verilog.lexer.g"
				hasXZ = true;
#line 2523 "VerilogLexer.cpp"
			}
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop116;
		}
		}
	}
	_loop116:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return hasXZ ;
}

void VerilogLexer::mNUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	ANTLR_USE_NAMESPACE(antlr)RefToken r_exp;
	ANTLR_USE_NAMESPACE(antlr)RefToken r;
	ANTLR_USE_NAMESPACE(antlr)RefToken u;
#line 510 "verilog.lexer.g"
	RefVerilogNumber vn;
#line 2558 "VerilogLexer.cpp"
	
	{
	bool synPredMatched121 = false;
	if ((((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ )) && (_tokenSet_6.member(LA(2))) && (_tokenSet_7.member(LA(3))))) {
		int _m121 = mark();
		synPredMatched121 = true;
		inputState->guessing++;
		try {
			{
			mUNSIGNED_NUMBER(false);
			{
			switch ( LA(1)) {
			case 0x2e /* '.' */ :
			{
				match('.' /* charlit */ );
				mUNSIGNED_NUMBER(false);
				break;
			}
			case 0x45 /* 'E' */ :
			case 0x65 /* 'e' */ :
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
			}
			}
			}
			mEXP(false);
			}
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
			synPredMatched121 = false;
		}
		rewind(_m121);
		inputState->guessing--;
	}
	if ( synPredMatched121 ) {
		mREAL_NUMBER_EXP(true);
		r_exp=_returnToken;
		if ( inputState->guessing==0 ) {
#line 516 "verilog.lexer.g"
			
			_token = makeNumberToken(REAL_NUMBER, VerilogNumber::build(_RS(r_exp->getText()), VerilogNumber::NUM_REAL) ) ;
			//cout << "LEXER: ---------> " << r_exp->getText() << endl;
			
#line 2606 "VerilogLexer.cpp"
		}
	}
	else {
		bool synPredMatched123 = false;
		if ((((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ )) && (_tokenSet_8.member(LA(2))) && (_tokenSet_8.member(LA(3))))) {
			int _m123 = mark();
			synPredMatched123 = true;
			inputState->guessing++;
			try {
				{
				mUNSIGNED_NUMBER(false);
				match('.' /* charlit */ );
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched123 = false;
			}
			rewind(_m123);
			inputState->guessing--;
		}
		if ( synPredMatched123 ) {
			mREAL_NUMBER(true);
			r=_returnToken;
			if ( inputState->guessing==0 ) {
#line 521 "verilog.lexer.g"
				
				_token = makeNumberToken(REAL_NUMBER, VerilogNumber::build(_RS(r->getText()), VerilogNumber::NUM_REAL) ) ;
				
#line 2635 "VerilogLexer.cpp"
			}
		}
		else if ((LA(1) == 0x27 /* '\'' */ )) {
			vn=mBASED_NUMBER(false,VerilogNumber::NOT_SIZED);
			if ( inputState->guessing==0 ) {
#line 512 "verilog.lexer.g"
				
				_token = makeNumberToken(BASED_NUMBER, vn);
				
#line 2645 "VerilogLexer.cpp"
			}
		}
		else if (((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ )) && (true) && (true)) {
			mUNSIGNED_NUMBER(true);
			u=_returnToken;
			if ( inputState->guessing==0 ) {
#line 525 "verilog.lexer.g"
				
				if (u->getText() == "0" && udpTable())
				_token = makeToken(UDP_0);
				else if (u->getText() == "1" && udpTable())
				_token = makeToken(UDP_1);
				else {
				_token = makeNumberToken(UNSIGNED_NUMBER, VerilogNumber::build(_RS(u->getText()), VerilogNumber::NUM_BASED) ) ;
				// isSigned = FALSE, base = BASE_DEC, size = NOT_SIZED
				}
				
#line 2663 "VerilogLexer.cpp"
			}
		}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	if ( inputState->guessing==0 ) {
#line 536 "verilog.lexer.g"
		
		_token->setText(text.substr(_begin, text.length()-_begin));
		
#line 2676 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

RefVerilogNumber  VerilogLexer::mBASED_NUMBER(bool _createToken,
	TInt size
) {
#line 549 "verilog.lexer.g"
	RefVerilogNumber vn;
#line 2691 "VerilogLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BASED_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	ANTLR_USE_NAMESPACE(antlr)RefToken xz;
#line 549 "verilog.lexer.g"
	
	TBool isSigned; 
	bool hasXZ = true; 
	
#line 2701 "VerilogLexer.cpp"
	
	bool synPredMatched130 = false;
	if (((LA(1) == 0x27 /* '\'' */ ) && (_tokenSet_9.member(LA(2))) && (_tokenSet_10.member(LA(3))))) {
		int _m130 = mark();
		synPredMatched130 = true;
		inputState->guessing++;
		try {
			{
			mBASED_NUMBER_HEADER(false);
			{
			switch ( LA(1)) {
			case 0x64 /* 'd' */ :
			{
				match('d' /* charlit */ );
				break;
			}
			case 0x44 /* 'D' */ :
			{
				match('D' /* charlit */ );
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
			}
			}
			}
			}
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
			synPredMatched130 = false;
		}
		rewind(_m130);
		inputState->guessing--;
	}
	if ( synPredMatched130 ) {
		isSigned=mBASED_NUMBER_HEADER(false);
		{
		switch ( LA(1)) {
		case 0x64 /* 'd' */ :
		{
			match('d' /* charlit */ );
			break;
		}
		case 0x44 /* 'D' */ :
		{
			match('D' /* charlit */ );
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case 0x20 /* ' ' */ :
			{
				match(' ' /* charlit */ );
				break;
			}
			case 0x9 /* '\t' */ :
			{
				match('\t' /* charlit */ );
				break;
			}
			default:
			{
				goto _loop133;
			}
			}
		}
		_loop133:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mUNSIGNED_NUMBER(false);
			if ( inputState->guessing==0 ) {
#line 556 "verilog.lexer.g"
				
				vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_DEC, size, false);
				
#line 2797 "VerilogLexer.cpp"
			}
			break;
		}
		case 0x3f /* '?' */ :
		case 0x58 /* 'X' */ :
		case 0x5a /* 'Z' */ :
		case 0x78 /* 'x' */ :
		case 0x7a /* 'z' */ :
		{
			mXZ_NUMBER(true);
			xz=_returnToken;
			if ( inputState->guessing==0 ) {
#line 560 "verilog.lexer.g"
				
				vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_DEC, size, true );
				
#line 2814 "VerilogLexer.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
	}
	else {
		bool synPredMatched137 = false;
		if (((LA(1) == 0x27 /* '\'' */ ) && (_tokenSet_11.member(LA(2))) && (_tokenSet_12.member(LA(3))))) {
			int _m137 = mark();
			synPredMatched137 = true;
			inputState->guessing++;
			try {
				{
				mBASED_NUMBER_HEADER(false);
				{
				switch ( LA(1)) {
				case 0x62 /* 'b' */ :
				{
					match('b' /* charlit */ );
					break;
				}
				case 0x42 /* 'B' */ :
				{
					match('B' /* charlit */ );
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
				}
				}
				}
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched137 = false;
			}
			rewind(_m137);
			inputState->guessing--;
		}
		if ( synPredMatched137 ) {
			isSigned=mBASED_NUMBER_HEADER(false);
			{
			switch ( LA(1)) {
			case 0x62 /* 'b' */ :
			{
				match('b' /* charlit */ );
				break;
			}
			case 0x42 /* 'B' */ :
			{
				match('B' /* charlit */ );
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
			}
			}
			}
			{ // ( ... )*
			for (;;) {
				switch ( LA(1)) {
				case 0x20 /* ' ' */ :
				{
					match(' ' /* charlit */ );
					break;
				}
				case 0x9 /* '\t' */ :
				{
					match('\t' /* charlit */ );
					break;
				}
				default:
				{
					goto _loop140;
				}
				}
			}
			_loop140:;
			} // ( ... )*
			hasXZ=mBIN_NUMBER(false);
			if ( inputState->guessing==0 ) {
#line 565 "verilog.lexer.g"
				
				vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_BIN, size, hasXZ );
				
#line 2907 "VerilogLexer.cpp"
			}
		}
		else {
			bool synPredMatched143 = false;
			if (((LA(1) == 0x27 /* '\'' */ ) && (_tokenSet_13.member(LA(2))) && (_tokenSet_14.member(LA(3))))) {
				int _m143 = mark();
				synPredMatched143 = true;
				inputState->guessing++;
				try {
					{
					mBASED_NUMBER_HEADER(false);
					{
					switch ( LA(1)) {
					case 0x6f /* 'o' */ :
					{
						match('o' /* charlit */ );
						break;
					}
					case 0x4f /* 'O' */ :
					{
						match('O' /* charlit */ );
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
					}
					}
					}
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched143 = false;
				}
				rewind(_m143);
				inputState->guessing--;
			}
			if ( synPredMatched143 ) {
				isSigned=mBASED_NUMBER_HEADER(false);
				{
				switch ( LA(1)) {
				case 0x6f /* 'o' */ :
				{
					match('o' /* charlit */ );
					break;
				}
				case 0x4f /* 'O' */ :
				{
					match('O' /* charlit */ );
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
				}
				}
				}
				{ // ( ... )*
				for (;;) {
					switch ( LA(1)) {
					case 0x20 /* ' ' */ :
					{
						match(' ' /* charlit */ );
						break;
					}
					case 0x9 /* '\t' */ :
					{
						match('\t' /* charlit */ );
						break;
					}
					default:
					{
						goto _loop146;
					}
					}
				}
				_loop146:;
				} // ( ... )*
				hasXZ=mOCT_NUMBER(false);
				if ( inputState->guessing==0 ) {
#line 569 "verilog.lexer.g"
					
					vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_OCT, size, hasXZ );
					
#line 2992 "VerilogLexer.cpp"
				}
			}
			else {
				bool synPredMatched149 = false;
				if (((LA(1) == 0x27 /* '\'' */ ) && (_tokenSet_15.member(LA(2))) && (_tokenSet_16.member(LA(3))))) {
					int _m149 = mark();
					synPredMatched149 = true;
					inputState->guessing++;
					try {
						{
						mBASED_NUMBER_HEADER(false);
						{
						switch ( LA(1)) {
						case 0x68 /* 'h' */ :
						{
							match('h' /* charlit */ );
							break;
						}
						case 0x48 /* 'H' */ :
						{
							match('H' /* charlit */ );
							break;
						}
						default:
						{
							throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
						}
						}
						}
						}
					}
					catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
						synPredMatched149 = false;
					}
					rewind(_m149);
					inputState->guessing--;
				}
				if ( synPredMatched149 ) {
					isSigned=mBASED_NUMBER_HEADER(false);
					{
					switch ( LA(1)) {
					case 0x68 /* 'h' */ :
					{
						match('h' /* charlit */ );
						break;
					}
					case 0x48 /* 'H' */ :
					{
						match('H' /* charlit */ );
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
					}
					}
					}
					{ // ( ... )*
					for (;;) {
						switch ( LA(1)) {
						case 0x20 /* ' ' */ :
						{
							match(' ' /* charlit */ );
							break;
						}
						case 0x9 /* '\t' */ :
						{
							match('\t' /* charlit */ );
							break;
						}
						default:
						{
							goto _loop152;
						}
						}
					}
					_loop152:;
					} // ( ... )*
					hasXZ=mHEX_NUMBER(false);
					if ( inputState->guessing==0 ) {
#line 573 "verilog.lexer.g"
						
						vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_HEX, size, hasXZ);
						
#line 3077 "VerilogLexer.cpp"
					}
				}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}}}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return vn;
}

TBool  VerilogLexer::mBASED_NUMBER_HEADER(bool _createToken) {
#line 542 "verilog.lexer.g"
	TBool s;
#line 3096 "VerilogLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BASED_NUMBER_HEADER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	if ( inputState->guessing==0 ) {
#line 543 "verilog.lexer.g"
		s = FALSE;
#line 3104 "VerilogLexer.cpp"
	}
	match('\'' /* charlit */ );
	{
	switch ( LA(1)) {
	case 0x53 /* 'S' */ :
	case 0x73 /* 's' */ :
	{
		{
		switch ( LA(1)) {
		case 0x73 /* 's' */ :
		{
			match('s' /* charlit */ );
			break;
		}
		case 0x53 /* 'S' */ :
		{
			match('S' /* charlit */ );
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
		if ( inputState->guessing==0 ) {
#line 545 "verilog.lexer.g"
			s = TRUE;
#line 3133 "VerilogLexer.cpp"
		}
		break;
	}
	case 0x42 /* 'B' */ :
	case 0x44 /* 'D' */ :
	case 0x48 /* 'H' */ :
	case 0x4f /* 'O' */ :
	case 0x62 /* 'b' */ :
	case 0x64 /* 'd' */ :
	case 0x68 /* 'h' */ :
	case 0x6f /* 'o' */ :
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return s;
}

void VerilogLexer::mSYSTEM_TASK_NAME(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SYSTEM_TASK_NAME;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match('$' /* charlit */ );
	{ // ( ... )+
	int _cnt155=0;
	for (;;) {
		switch ( LA(1)) {
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x47 /* 'G' */ :
		case 0x48 /* 'H' */ :
		case 0x49 /* 'I' */ :
		case 0x4a /* 'J' */ :
		case 0x4b /* 'K' */ :
		case 0x4c /* 'L' */ :
		case 0x4d /* 'M' */ :
		case 0x4e /* 'N' */ :
		case 0x4f /* 'O' */ :
		case 0x50 /* 'P' */ :
		case 0x51 /* 'Q' */ :
		case 0x52 /* 'R' */ :
		case 0x53 /* 'S' */ :
		case 0x54 /* 'T' */ :
		case 0x55 /* 'U' */ :
		case 0x56 /* 'V' */ :
		case 0x57 /* 'W' */ :
		case 0x58 /* 'X' */ :
		case 0x59 /* 'Y' */ :
		case 0x5a /* 'Z' */ :
		case 0x5f /* '_' */ :
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		case 0x67 /* 'g' */ :
		case 0x68 /* 'h' */ :
		case 0x69 /* 'i' */ :
		case 0x6a /* 'j' */ :
		case 0x6b /* 'k' */ :
		case 0x6c /* 'l' */ :
		case 0x6d /* 'm' */ :
		case 0x6e /* 'n' */ :
		case 0x6f /* 'o' */ :
		case 0x70 /* 'p' */ :
		case 0x71 /* 'q' */ :
		case 0x72 /* 'r' */ :
		case 0x73 /* 's' */ :
		case 0x74 /* 't' */ :
		case 0x75 /* 'u' */ :
		case 0x76 /* 'v' */ :
		case 0x77 /* 'w' */ :
		case 0x78 /* 'x' */ :
		case 0x79 /* 'y' */ :
		case 0x7a /* 'z' */ :
		{
			mALPHA(false);
			break;
		}
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mDIGIT(false);
			break;
		}
		case 0x24 /* '$' */ :
		{
			match('$' /* charlit */ );
			break;
		}
		default:
		{
			if ( _cnt155>=1 ) { goto _loop155; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
		}
		}
		_cnt155++;
	}
	_loop155:;
	}  // ( ... )+
	_ttype = testLiteralsTable(_ttype);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mFILENAME(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FILENAME;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_17.member(LA(1)))) {
			matchNot('\"' /* charlit */ );
		}
		else {
			goto _loop158;
		}
		
	}
	_loop158:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mLINE_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LINE_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{ // ( ... )+
	int _cnt161=0;
	for (;;) {
		if (((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ ))) {
			mDIGIT(false);
		}
		else {
			if ( _cnt161>=1 ) { goto _loop161; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
		}
		
		_cnt161++;
	}
	_loop161:;
	}  // ( ... )+
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mHASH_LINE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HASH_LINE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	ANTLR_USE_NAMESPACE(antlr)RefToken fn;
	ANTLR_USE_NAMESPACE(antlr)RefToken l;
	
	match("#line");
	{ // ( ... )+
	int _cnt164=0;
	for (;;) {
		if ((_tokenSet_18.member(LA(1)))) {
			mW(false);
		}
		else {
			if ( _cnt164>=1 ) { goto _loop164; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
		}
		
		_cnt164++;
	}
	_loop164:;
	}  // ( ... )+
	match('\"' /* charlit */ );
	mFILENAME(true);
	fn=_returnToken;
	match('\"' /* charlit */ );
	{ // ( ... )+
	int _cnt166=0;
	for (;;) {
		if ((_tokenSet_18.member(LA(1)))) {
			mW(false);
		}
		else {
			if ( _cnt166>=1 ) { goto _loop166; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
		}
		
		_cnt166++;
	}
	_loop166:;
	}  // ( ... )+
	mLINE_NUMBER(true);
	l=_returnToken;
	{
	if ((_tokenSet_19.member(LA(1)))) {
		{
		{
		match(_tokenSet_19);
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_4.member(LA(1)))) {
				{
				match(_tokenSet_4);
				}
			}
			else {
				goto _loop172;
			}
			
		}
		_loop172:;
		} // ( ... )*
	}
	else {
	}
	
	}
	{
	if ((LA(1) == 0xa /* '\n' */  || LA(1) == 0xd /* '\r' */ )) {
		mEND_OF_LINE(false);
	}
	else {
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 594 "verilog.lexer.g"
		
		handleLineDirective(fn->getText(), l->getText());
		_ttype = Token::SKIP;
		
#line 3401 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mDIRECTIVE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIRECTIVE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	ANTLR_USE_NAMESPACE(antlr)RefToken i;
	
	_saveIndex = text.length();
	match('`' /* charlit */ );
	text.erase(_saveIndex);
	{
	mIDENTIFIER(true);
	i=_returnToken;
	{
	if ((_tokenSet_18.member(LA(1)))) {
		{ // ( ... )+
		int _cnt178=0;
		for (;;) {
			if ((_tokenSet_18.member(LA(1)))) {
				mW(false);
			}
			else {
				if ( _cnt178>=1 ) { goto _loop178; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			
			_cnt178++;
		}
		_loop178:;
		}  // ( ... )+
		{
		{
		match(_tokenSet_20);
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_4.member(LA(1)))) {
				{
				match(_tokenSet_4);
				}
			}
			else {
				goto _loop183;
			}
			
		}
		_loop183:;
		} // ( ... )*
	}
	else {
	}
	
	}
	}
	{
	if ((LA(1) == 0xa /* '\n' */  || LA(1) == 0xd /* '\r' */ )) {
		_saveIndex = text.length();
		mEND_OF_LINE(false);
		text.erase(_saveIndex);
	}
	else {
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 604 "verilog.lexer.g"
		
		cout << "WARNING: Directives are ignored" << endl;
		_ttype = Token::SKIP;
		
#line 3480 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mWS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = WS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	switch ( LA(1)) {
	case 0x8 /* '\10' */ :
	case 0x9 /* '\t' */ :
	case 0xc /* '\14' */ :
	case 0x20 /* ' ' */ :
	{
		mW(false);
		break;
	}
	case 0xa /* '\n' */ :
	case 0xd /* '\r' */ :
	{
		mEND_OF_LINE(false);
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	if ( inputState->guessing==0 ) {
#line 615 "verilog.lexer.g"
		_ttype = Token::SKIP;
#line 3520 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mSL_COMMENT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SL_COMMENT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("//");
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_4.member(LA(1)))) {
			{
			match(_tokenSet_4);
			}
		}
		else {
			goto _loop190;
		}
		
	}
	_loop190:;
	} // ( ... )*
	{
	if ((LA(1) == 0xa /* '\n' */  || LA(1) == 0xd /* '\r' */ )) {
		mEND_OF_LINE(false);
	}
	else {
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 620 "verilog.lexer.g"
		_ttype = Token::SKIP;
#line 3561 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void VerilogLexer::mML_COMMENT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ML_COMMENT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("/*");
	{ // ( ... )*
	for (;;) {
		if (((LA(1) == 0x2a /* '*' */ ) && ((LA(2) >= 0x3 /* '\3' */  && LA(2) <= 0xff)) && ((LA(3) >= 0x3 /* '\3' */  && LA(3) <= 0xff)))&&( LA(2) != '/' )) {
			match('*' /* charlit */ );
		}
		else if ((LA(1) == 0xa /* '\n' */  || LA(1) == 0xd /* '\r' */ )) {
			mEND_OF_LINE(false);
		}
		else if ((_tokenSet_21.member(LA(1)))) {
			{
			match(_tokenSet_21);
			}
		}
		else {
			goto _loop195;
		}
		
	}
	_loop195:;
	} // ( ... )*
	match("*/");
	if ( inputState->guessing==0 ) {
#line 630 "verilog.lexer.g"
		_ttype = Token::SKIP;
#line 3601 "VerilogLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}


const unsigned long VerilogLexer::_tokenSet_0_data_[] = { 0UL, 0UL, 83886080UL, 83886080UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// X Z x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_0(_tokenSet_0_data_,10);
const unsigned long VerilogLexer::_tokenSet_1_data_[] = { 0UL, 0UL, 2281701374UL, 134217726UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// A B C D E F G H I J K L M N O P Q R S T U V W X Y Z _ a b c d e f g 
// h i j k l m n o p q r s t u v w x y z 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_1(_tokenSet_1_data_,10);
const unsigned long VerilogLexer::_tokenSet_2_data_[] = { 0UL, 67043456UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// \' 0 1 2 3 4 5 6 7 8 9 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_2(_tokenSet_2_data_,10);
const unsigned long VerilogLexer::_tokenSet_3_data_[] = { 4294953208UL, 4294950910UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0xb 0xe 0xf 0x10 0x11 0x12 0x13 0x14 0x15 0x16 0x17 
// 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f ! \" # $ % & \' ( ) * + , - 
// / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O P 
// Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h i j k l m n o p q 
// r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 0x85 0x86 0x87 
// 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 0x93 0x94 0x95 
// 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 0xa1 0xa2 0xa3 
// 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 0xaf 0xb0 0xb1 
// 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 0xbd 0xbe 0xbf 
// 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 0xcb 0xcc 0xcd 
// 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 0xd9 0xda 0xdb 
// 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 0xe7 0xe8 0xe9 
// 0xea 0xeb 0xec 0xed 0xee 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_3(_tokenSet_3_data_,16);
const unsigned long VerilogLexer::_tokenSet_4_data_[] = { 4294958072UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xe 0xf 0x10 0x11 0x12 0x13 0x14 
// 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! \" # $ % 
// & \' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G 
// H I J K L M N O P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h 
// i j k l m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 
// 0x84 0x85 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 
// 0x92 0x93 0x94 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 
// 0xa0 0xa1 0xa2 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 
// 0xae 0xaf 0xb0 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 
// 0xbc 0xbd 0xbe 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 
// 0xca 0xcb 0xcc 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 
// 0xd8 0xd9 0xda 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 
// 0xe6 0xe7 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_4(_tokenSet_4_data_,16);
const unsigned long VerilogLexer::_tokenSet_5_data_[] = { 4294958072UL, 4294967291UL, 4026531839UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xe 0xf 0x10 0x11 0x12 0x13 0x14 
// 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! # $ % & \' 
// ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I 
// J K L M N O P Q R S T U V W X Y Z [ ] ^ _ ` a b c d e f g h i j k l 
// m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 0x85 
// 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 0x93 
// 0x94 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 0xa1 
// 0xa2 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 0xaf 
// 0xb0 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 0xbd 
// 0xbe 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 0xcb 
// 0xcc 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 0xd9 
// 0xda 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 0xe7 
// 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_5(_tokenSet_5_data_,16);
const unsigned long VerilogLexer::_tokenSet_6_data_[] = { 0UL, 67059712UL, 2147483680UL, 32UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// . 0 1 2 3 4 5 6 7 8 9 E _ e 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_6(_tokenSet_6_data_,10);
const unsigned long VerilogLexer::_tokenSet_7_data_[] = { 0UL, 67069952UL, 2147483680UL, 32UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// + - . 0 1 2 3 4 5 6 7 8 9 E _ e 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_7(_tokenSet_7_data_,10);
const unsigned long VerilogLexer::_tokenSet_8_data_[] = { 0UL, 67059712UL, 2147483648UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// . 0 1 2 3 4 5 6 7 8 9 _ 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_8(_tokenSet_8_data_,10);
const unsigned long VerilogLexer::_tokenSet_9_data_[] = { 0UL, 0UL, 524304UL, 524304UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// D S d s 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_9(_tokenSet_9_data_,10);
const unsigned long VerilogLexer::_tokenSet_10_data_[] = { 512UL, 2214526977UL, 83886096UL, 83886096UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   0 1 2 3 4 5 6 7 8 9 ? D X Z d x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_10(_tokenSet_10_data_,10);
const unsigned long VerilogLexer::_tokenSet_11_data_[] = { 0UL, 0UL, 524292UL, 524292UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// B S b s 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_11(_tokenSet_11_data_,10);
const unsigned long VerilogLexer::_tokenSet_12_data_[] = { 512UL, 2147680257UL, 83886084UL, 83886084UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   0 1 ? B X Z b x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_12(_tokenSet_12_data_,10);
const unsigned long VerilogLexer::_tokenSet_13_data_[] = { 0UL, 0UL, 557056UL, 557056UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// O S o s 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_13(_tokenSet_13_data_,10);
const unsigned long VerilogLexer::_tokenSet_14_data_[] = { 512UL, 2164195329UL, 83918848UL, 83918848UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   0 1 2 3 4 5 6 7 ? O X Z o x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_14(_tokenSet_14_data_,10);
const unsigned long VerilogLexer::_tokenSet_15_data_[] = { 0UL, 0UL, 524544UL, 524544UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// H S h s 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_15(_tokenSet_15_data_,10);
const unsigned long VerilogLexer::_tokenSet_16_data_[] = { 512UL, 2214526977UL, 83886462UL, 83886462UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   0 1 2 3 4 5 6 7 8 9 ? A B C D E F H X Z a b c d e f h x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_16(_tokenSet_16_data_,10);
const unsigned long VerilogLexer::_tokenSet_17_data_[] = { 4294967288UL, 4294967291UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xa 0xb 0xc 0xd 0xe 0xf 0x10 0x11 0x12 0x13 
// 0x14 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! # $ 
// % & \' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F 
// G H I J K L M N O P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g 
// h i j k l m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 
// 0x84 0x85 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 
// 0x92 0x93 0x94 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 
// 0xa0 0xa1 0xa2 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 
// 0xae 0xaf 0xb0 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 
// 0xbc 0xbd 0xbe 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 
// 0xca 0xcb 0xcc 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 
// 0xd8 0xd9 0xda 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 
// 0xe6 0xe7 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_17(_tokenSet_17_data_,16);
const unsigned long VerilogLexer::_tokenSet_18_data_[] = { 4864UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x8 0x9 0xc   
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_18(_tokenSet_18_data_,10);
const unsigned long VerilogLexer::_tokenSet_19_data_[] = { 4294958072UL, 4227923967UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xe 0xf 0x10 0x11 0x12 0x13 0x14 
// 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! \" # $ % 
// & \' ( ) * + , - . / : ; < = > ? @ A B C D E F G H I J K L M N O P Q 
// R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h i j k l m n o p q r 
// s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 0x85 0x86 0x87 
// 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 0x93 0x94 0x95 
// 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 0xa1 0xa2 0xa3 
// 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 0xaf 0xb0 0xb1 
// 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 0xbd 0xbe 0xbf 
// 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 0xcb 0xcc 0xcd 
// 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 0xd9 0xda 0xdb 
// 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 0xe7 0xe8 0xe9 
// 0xea 0xeb 0xec 0xed 0xee 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_19(_tokenSet_19_data_,16);
const unsigned long VerilogLexer::_tokenSet_20_data_[] = { 4294953208UL, 4294967294UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0xb 0xe 0xf 0x10 0x11 0x12 0x13 0x14 0x15 0x16 0x17 
// 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f ! \" # $ % & \' ( ) * + , - 
// . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O 
// P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h i j k l m n o p 
// q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 0x85 0x86 
// 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 0x93 0x94 
// 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 0xa1 0xa2 
// 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 0xaf 0xb0 
// 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 0xbd 0xbe 
// 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 0xcb 0xcc 
// 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 0xd9 0xda 
// 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 0xe7 0xe8 
// 0xe9 0xea 0xeb 0xec 0xed 0xee 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_20(_tokenSet_20_data_,16);
const unsigned long VerilogLexer::_tokenSet_21_data_[] = { 4294958072UL, 4294966271UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xe 0xf 0x10 0x11 0x12 0x13 0x14 
// 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! \" # $ % 
// & \' ( ) + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H 
// I J K L M N O P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h i 
// j k l m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 
// 0x85 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 
// 0x93 0x94 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 
// 0xa1 0xa2 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 
// 0xaf 0xb0 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 
// 0xbd 0xbe 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 
// 0xcb 0xcc 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 
// 0xd9 0xda 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 
// 0xe7 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogLexer::_tokenSet_21(_tokenSet_21_data_,16);

