#ifndef INC_CslLexer_hpp_
#define INC_CslLexer_hpp_

#include <antlr/config.hpp>
/* $ANTLR 2.7.7 (2006-11-01): "csl.lexer.g" -> "CslLexer.hpp"$ */
#include <antlr/CommonToken.hpp>
#include <antlr/InputBuffer.hpp>
#include <antlr/BitSet.hpp>
#include "CslTokenTypes.hpp"
#include <antlr/CharScanner.hpp>
#line 31 "csl.lexer.g"

    #include "Def.hpp"
    #include "CslNumber.hpp"
    #include "CslLexerUtils.hpp"
    #include "../../support/CommonSupport.h"

    ANTLR_USING_NAMESPACE(std);
    ANTLR_USING_NAMESPACE(antlr);
    
#line 22 "CslLexer.hpp"
class CUSTOM_API CslLexer : public ANTLR_USE_NAMESPACE(antlr)CharScanner, public CslTokenTypes
{
#line 543 "csl.lexer.g"

  protected:
    TCslLexerState lexerState() const;
    TChar octStrToChar(const string& str) const;
    TInt convertStrToInt(const string& str);
    TDouble convertStrToReal(const string& str);

  protected: // our own virtual methods
    virtual RefToken makeNumberToken(int t, const RefCslNumber number);

  protected: // from base class
    virtual RefToken makeToken(int t);
#line 26 "CslLexer.hpp"
private:
	void initLiterals();
public:
	bool getCaseSensitiveLiterals() const
	{
		return true;
	}
public:
	CslLexer(ANTLR_USE_NAMESPACE(std)istream& in);
	CslLexer(ANTLR_USE_NAMESPACE(antlr)InputBuffer& ib);
	CslLexer(const ANTLR_USE_NAMESPACE(antlr)LexerSharedInputState& state);
	ANTLR_USE_NAMESPACE(antlr)RefToken nextToken();
	public: void mBACKTICK(bool _createToken);
	public: void mAT(bool _createToken);
	public: void mCOLON(bool _createToken);
	public: void mCOMMA(bool _createToken);
	public: void mDOT(bool _createToken);
	public: void mASSIGN(bool _createToken);
	public: void mMINUS(bool _createToken);
	public: void mLBRACK(bool _createToken);
	public: void mRBRACK(bool _createToken);
	public: void mLCURLY(bool _createToken);
	public: void mRCURLY(bool _createToken);
	public: void mLPAREN(bool _createToken);
	public: void mRPAREN(bool _createToken);
	public: void mPOUND(bool _createToken);
	public: void mQUESTION(bool _createToken);
	public: void mSEMI(bool _createToken);
	public: void mPLUS(bool _createToken);
	public: void mLNOT(bool _createToken);
	public: void mNOT(bool _createToken);
	public: void mAND(bool _createToken);
	public: void mNAND(bool _createToken);
	public: void mOR(bool _createToken);
	public: void mNOR(bool _createToken);
	public: void mXOR(bool _createToken);
	public: void mXNOR(bool _createToken);
	public: void mSTAR(bool _createToken);
	public: void mPOW(bool _createToken);
	public: void mDIV(bool _createToken);
	public: void mMOD(bool _createToken);
	public: void mEQUAL(bool _createToken);
	public: void mNOT_EQ(bool _createToken);
	public: void mNOT_EQ_CASE(bool _createToken);
	public: void mEQ_CASE(bool _createToken);
	public: void mLAND(bool _createToken);
	public: void mTAND(bool _createToken);
	public: void mLOR(bool _createToken);
	public: void mLT_(bool _createToken);
	public: void mLE(bool _createToken);
	public: void mGT(bool _createToken);
	public: void mGE(bool _createToken);
	public: void mSL(bool _createToken);
	public: void mSSL(bool _createToken);
	public: void mSR(bool _createToken);
	public: void mSSR(bool _createToken);
	public: void mTRIGGER(bool _createToken);
	public: void mPPATH(bool _createToken);
	public: void mFPATH(bool _createToken);
	public: void mSTARP(bool _createToken);
	public: void mPO_POS(bool _createToken);
	public: void mPO_NEG(bool _createToken);
	public: void mSUPERSTAR(bool _createToken);
	protected: void mW(bool _createToken);
	protected: void mEND_OF_LINE(bool _createToken);
	protected: void mVOCAB(bool _createToken);
	protected: void mALPHA(bool _createToken);
	protected: void mDIGIT(bool _createToken);
	protected: void mNZ_DIGIT(bool _createToken);
	protected: void mBIN_DIGIT(bool _createToken);
	protected: void mOCT_DIGIT(bool _createToken);
	protected: void mHEX_DIGIT(bool _createToken);
	protected: void mXZ_DIGIT(bool _createToken);
	public: void mIDENTIFIER(bool _createToken);
	public: void mESCAPED_IDENTIFIER(bool _createToken);
	public: void mSTRING(bool _createToken);
	protected: void mUNSIGNED_NUMBER(bool _createToken);
	protected: void mNZ_UNSIGNED_NUMBER(bool _createToken);
	protected: void mREAL_NUMBER(bool _createToken);
	protected: void mREAL_NUMBER_EXP(bool _createToken);
	protected: void mEXP(bool _createToken);
	protected: void mSIGN(bool _createToken);
	protected: void mXZ_NUMBER(bool _createToken);
	protected:  bool  mBIN_NUMBER(bool _createToken);
	protected:  bool  mOCT_NUMBER(bool _createToken);
	protected:  bool  mHEX_NUMBER(bool _createToken);
	public: void mNUMBER(bool _createToken);
	protected: RefCslNumber  mBASED_NUMBER(bool _createToken,
		TInt size
	);
	protected: TBool  mBASED_NUMBER_HEADER(bool _createToken);
	public: void mSYSTEM_TASK_NAME(bool _createToken);
	protected: void mFILENAME(bool _createToken);
	public: void mDIRECTIVE(bool _createToken);
	public: void mWS(bool _createToken);
	public: void mSL_COMMENT(bool _createToken);
	public: void mML_COMMENT(bool _createToken);
private:
	
	static const unsigned long _tokenSet_0_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_0;
	static const unsigned long _tokenSet_1_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_1;
	static const unsigned long _tokenSet_2_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_2;
	static const unsigned long _tokenSet_3_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_3;
	static const unsigned long _tokenSet_4_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_4;
	static const unsigned long _tokenSet_5_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_5;
	static const unsigned long _tokenSet_6_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_6;
	static const unsigned long _tokenSet_7_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_7;
	static const unsigned long _tokenSet_8_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_8;
	static const unsigned long _tokenSet_9_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_9;
	static const unsigned long _tokenSet_10_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_10;
	static const unsigned long _tokenSet_11_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_11;
	static const unsigned long _tokenSet_12_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_12;
	static const unsigned long _tokenSet_13_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_13;
	static const unsigned long _tokenSet_14_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_14;
	static const unsigned long _tokenSet_15_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_15;
	static const unsigned long _tokenSet_16_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_16;
	static const unsigned long _tokenSet_17_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_17;
	static const unsigned long _tokenSet_18_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_18;
};

#endif /*INC_CslLexer_hpp_*/
