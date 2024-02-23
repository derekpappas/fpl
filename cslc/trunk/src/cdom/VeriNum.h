//----------------------------------------------------------------------
// Copyright (c) 2005, 2006 Fastpathlogic
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

#ifndef INC_GUARD_CDOM_VeriNum_h
#define INC_GUARD_CDOM_VeriNum_h

#include "../support/CommonSupport.h"

namespace NSCdom {

class VeriNumException : public std::exception
    {
    public:
        VeriNumException(const TChar *message) throw()
                : m_message(message) { }
        virtual ~VeriNumException() throw () { }
        const TChar* what() const throw() { return m_message.c_str(); }
    private:
        std::string m_message;
    };

class CVeriNum
    {
    public:
	enum TBit { _0 = 0, _1, _X, _Z };
	class CBitArray
	    {
	    public:
		CBitArray() : m_len(0), m_blockCount(0), m_blocks(NULL) { }
		CBitArray(TUInt len) : m_len(0), m_blockCount(0), m_blocks(NULL)
		    { setLen(len); }
		CBitArray(const CBitArray& other) : m_len(0), m_blockCount(0),
		    m_blocks(NULL) { setLen(0); *this = other; }
		~CBitArray() { delete[] m_blocks; }

        //returns the block size
		static TInt blockSize() { return sizeof(TUInt) * 8; }
        
        //localize the bit by block and position in block
		static void bitPos(TInt bitIndex, TInt& blkNum, TInt& blkOffset);
        
        //sets the lenght of the m_blocks array
		void setLen(TUInt l);
        
        //returns the lenght of the m_blocks array
		TUInt len() const { return m_len; }
		
        //throws an exception if the index is out of range
        void validateIndex(TUInt index) const;

        //sets the bit located at index to b
		void setBit(TInt index, TBit b);

        //gets the bit located at index
		TBit bit(TInt index) const;

        //prints through os the content of the m_blocks array
		std::ostream& dump(std::ostream& os) const;

        //overloading the assignment operator
		const CBitArray& operator=(const CBitArray& other);

        //gets the bit located at index
		TBit operator[](TInt index) const { return bit(index); }

	    private:
	        TUInt m_len;
		TInt m_blockCount;
		TUInt *m_blocks;
	    };
	enum TBase { BIN, OCT, DEC, HEX };
	enum TPadType { PAD_SIGN, PAD_ZERO };
    public:
	CVeriNum();
	// construct verilog number from string, each character is considered
	// as an 8 bit ASCII value. Number length is 8 * string_length
	// Example: string "AB" is converted to "0100000101000010"
	CVeriNum(const std::string& str);
	// construct verilog number from unsigned int, with specified length
	CVeriNum(TUInt val, TInt nbits);
	CVeriNum(TBit b, TInt nbits = 1);
	// construct verilog number from base specifier and a number string.
	// number string consists of digits (without spaces or _ symbols inside).
	// digits should be corresponding to the base specifier.
	// Example: "00110X" (binary), "023007" (octal), "01FZ" (hex),
	// "1234567890" (decimal)
	// if there is a Z or X digit inside a decimal string, 32 bit number
	// will be constructed with all bits set to Z (or X).
	CVeriNum(TBase base, const std::string& str, TBool isSigned, TUInt sz = 0);
    public:
	static TChar bitToChar(TBit b);
	// factory functions for 0, 1, -1, X verilog numbers
	static CVeriNum zero(TUInt len, TBool sgn = FALSE);
	static CVeriNum one(TUInt len, TBool sgn = FALSE);
	static CVeriNum minusOne(TUInt len, TBool sgn = TRUE);
	static CVeriNum undef(TUInt len, TBool sgn = FALSE);
	TBool isConst() const { return true; }
	TUInt len() const { return m_bits.len(); }
	// width is the same as length (number of bits)
	void setWidth(TUInt width);
	TBit get(TInt index) const { return m_bits.bit(index); }
	void set(TInt index, TBit bit) { m_bits.setBit(index, bit); }
	TBit operator[](TInt index) const { return get(index); }
	TBool hasSign() const { return m_hasSign; }
	void setSign(TBool signFlag) { m_hasSign = signFlag; }
	TBool isDefined() const;
	TBool isZero() const;
	TBool isNeg() const;
	TBool isEven() const;
	TBool isOne() const;
	TBool isMinusOne() const;
	TBool isTwo() const;
	// Set 4 bits starting from bitIndex
	void setOctet(TInt bitIndex, TChar ch);
	TChar getOctet(TInt bitIndex) const;
	TInt asInt() const;
	TUInt asUInt() const;
	std::string asString() const;
	TBit msb() const;
	// get a pad bit, which is a zero or a sign bit
	TBit padBit(TPadType pad = PAD_SIGN) const;
	// index may be out of bounds, in this case padBit is returned
	TBit safeGet(TUInt index, TPadType pad = PAD_SIGN) const;
	TBit logicVal() const;
	void inc();
	void dec();
	std::ostream& dump(std::ostream& os) const;
    private:
	CBitArray m_bits;
	TBool m_hasSign;
    };

TBool isDefined(CVeriNum::TBit a);
CVeriNum::TBit operator|(CVeriNum::TBit a, CVeriNum::TBit b);
CVeriNum::TBit operator&(CVeriNum::TBit a, CVeriNum::TBit b);
CVeriNum::TBit operator^(CVeriNum::TBit a, CVeriNum::TBit b);
CVeriNum::TBit neg(CVeriNum::TBit a);
// combine is needed for "x ? y : z" operator
CVeriNum::TBit combine(CVeriNum::TBit a, CVeriNum::TBit b);
CVeriNum::TBit add(CVeriNum::TBit a, CVeriNum::TBit b, CVeriNum::TBit& carry);

CVeriNum::TBit equal(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit notEqual(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit caseEqual(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit caseNotEqual(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit lessOrEqual(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit lessThan(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit greaterOrEqual(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit greaterThan(const CVeriNum& a, const CVeriNum& b);

CVeriNum shiftLeft(const CVeriNum& a, TUInt n);
CVeriNum shiftRight(const CVeriNum& a, TUInt n);
CVeriNum shiftRightArith(const CVeriNum& a, TUInt n); // arithmetic shift

CVeriNum bitwiseAnd(const CVeriNum& a, const CVeriNum& b);
CVeriNum bitwiseNand(const CVeriNum& a, const CVeriNum& b);
CVeriNum bitwiseOr(const CVeriNum& a, const CVeriNum& b);
CVeriNum bitwiseNor(const CVeriNum& a, const CVeriNum& b);
CVeriNum bitwiseXor(const CVeriNum& a, const CVeriNum& b);
CVeriNum bitwiseNxor(const CVeriNum& a, const CVeriNum& b);
CVeriNum bitwiseNeg(const CVeriNum& a);

CVeriNum::TBit reductionAnd(const CVeriNum& a);
CVeriNum::TBit reductionNand(const CVeriNum& a);
CVeriNum::TBit reductionOr(const CVeriNum& a);
CVeriNum::TBit reductionNor(const CVeriNum& a);
CVeriNum::TBit reductionXor(const CVeriNum& a);
CVeriNum::TBit reductionNxor(const CVeriNum& a);

CVeriNum::TBit logicalAnd(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit logicalOr(const CVeriNum& a, const CVeriNum& b);
CVeriNum::TBit logicalNeg(const CVeriNum& a);

CVeriNum combine(const CVeriNum& a, const CVeriNum& b);
CVeriNum concat(const CVeriNum& a, const CVeriNum& b);

CVeriNum abs(const CVeriNum& a);
CVeriNum minus(const CVeriNum& a);
CVeriNum add(const CVeriNum& a, const CVeriNum& b);
CVeriNum twosComplement(const CVeriNum& a);
CVeriNum sub(const CVeriNum& a, const CVeriNum& b);
CVeriNum multiply(const CVeriNum& a, const CVeriNum& b);
CVeriNum div2(const CVeriNum& a);
CVeriNum power(const CVeriNum& a, const CVeriNum& b);
CVeriNum log2(const CVeriNum& a);
void divide(const CVeriNum& a, const CVeriNum& b,
         CVeriNum& quotient, CVeriNum& remainder);
void signed_divide(const CVeriNum& a, const CVeriNum& b,
         CVeriNum& quotient, CVeriNum& remainder);

// stream operators
std::ostream& operator<<(std::ostream& os, CVeriNum::TBit b);
std::ostream& operator<<(std::ostream& os, const CVeriNum::CBitArray& bits);
std::ostream& operator<<(std::ostream& os, const CVeriNum& num);

class CRealNum
    {
    public:
        enum TRealType { REAL_TYPE_CPP };
    public:
        CRealNum(): m_realType(REAL_TYPE_CPP), m_realVal(0) { }
        CRealNum(TDouble realVal): m_realType(REAL_TYPE_CPP),
            m_realVal(realVal) { }
        CRealNum(const std::string& str, TRealType realType = REAL_TYPE_CPP)
            : m_realType(REAL_TYPE_CPP)
                { m_realVal = strtod(str.c_str(), NULL); }
        TRealType getRealType() const { return m_realType; }
        void setRealType(TRealType realType) { m_realType = realType; }
        TDouble getRealVal() const { return m_realVal; }
        void  setRealVal(TDouble realVal) { m_realVal = realVal; }
        std::ostream& dump(std::ostream& os) const;
    private:
        TRealType m_realType;
        TDouble m_realVal;
    };

std::ostream& operator<<(std::ostream& os, const CRealNum& num);

} // end namespace NSCdom

#endif /*INC_GUARD_VeriNum_h*/
