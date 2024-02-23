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

#include <iostream>
#include <memory>
#include "VeriNum.h"

namespace NSCdom {

#define MAX(a, b) (((a) > (b)) ? (a) : (b))

// CVeriNum::CBitArray

void CVeriNum::CBitArray::bitPos(TInt bitIndex, TInt& blkNum, TInt& blkOffset)
    {
    blkNum = bitIndex / (blockSize() / 2);
    blkOffset = bitIndex % (blockSize() / 2);
    }

void CVeriNum::CBitArray::validateIndex(TUInt index) const
    {
    if (index < 0 || index >= len())
	throw VeriNumException("CVeriNum::CBitArray - Index out of range");
    }

void CVeriNum::CBitArray::setLen(TUInt l)
    {
    delete [] m_blocks;
    m_blocks = NULL;
    m_blockCount = 0;
    m_len = 0;
    if (l > 0)
	{
	TInt bc = ((l - 1) / (sizeof(TUInt) * 8 / 2)) + 1;
	m_blocks = new TUInt[bc];
	m_len = l;
	m_blockCount = bc;
	}
    }

void CVeriNum::CBitArray::setBit(TInt index, TBit b)
    {
    validateIndex(index);
    TInt blkNum;
    TInt blkOffset;
    bitPos(index, blkNum, blkOffset);
    m_blocks[blkNum] = m_blocks[blkNum] &
        ~(((TUInt)3) << (blkOffset * 2))
        | ((TUInt)b << (blkOffset * 2));
    }

CVeriNum::TBit CVeriNum::CBitArray::bit(TInt index) const
    {
    validateIndex(index);
    TInt blkNum;
    TInt blkOffset;
    bitPos(index, blkNum, blkOffset);
    return (TBit)((m_blocks[blkNum] & (((TUInt)3) << (blkOffset * 2)))
                  >> (blkOffset * 2));
    }

const CVeriNum::CBitArray& CVeriNum::CBitArray::operator=(const CVeriNum::CBitArray& other)
    {
    setLen(other.len());
    TInt i;
    for (i = 0; i < m_blockCount; i++)
	m_blocks[i] = other.m_blocks[i];
    return *this;
    }

std::ostream& CVeriNum::CBitArray::dump(std::ostream& os) const
    {
    os << "CBitArray [length: " << len() << ", blocks: " << m_blockCount
       << "]: ";

    TUInt i;
    for (i = 0; i < len(); i++)
	os << bitToChar(bit(len() - i - 1));

    return os;
    }

// VeriNum

CVeriNum::CVeriNum()
	: m_hasSign(FALSE)
    {
    }

CVeriNum::CVeriNum(const std::string& str)
    : m_hasSign(FALSE)
    {
    TInt nbits = str.length() * 8;

    if (nbits == 0)
	{
	m_bits.setLen(8);
	setOctet(0, '\0');
	}
    else
	{
	m_bits.setLen(nbits);
	TInt i;
	TInt strLen = str.length();
	for (i = 0; i < strLen; i++)
	    setOctet(i * 8, str[strLen - i - 1]);
	}
    }

CVeriNum::CVeriNum(TUInt val, TInt nbits)
    : m_hasSign(FALSE)
    {
    m_bits.setLen(nbits);
    TUInt i;
    for (i = 0; i < m_bits.len(); i++, val >>= 1)
	m_bits.setBit(i, (val & 1) ? _1 : _0);
    }

CVeriNum::CVeriNum(TBit b, TInt nbits)
    : m_hasSign(FALSE)
    {
    m_bits.setLen(nbits);
    TUInt i;
    for (i = 0; i < m_bits.len(); i++)
	m_bits.setBit(i, b);
    }

CVeriNum::CVeriNum(TBase base, const std::string& str, TBool isSigned, TUInt sz)
    : m_hasSign(isSigned)
    {
    TInt strLen = str.length();
    TInt size;
    switch (base)
	{
	case BIN: size = strLen;
	    break;
	case OCT: size = strLen * 3;
	    break;
	case DEC: size = strLen * 4; // will need trim at the end
	    break;
	case HEX: size = strLen * 4;
	    break;
	}

    m_bits.setLen(size);

    TInt i;
    TInt bi = 0; // bit index
    for (i = strLen - 1; i >= 0; i--)
	{
	TChar ch = str[i];
	switch (base)
	    {
	    case BIN:
		{
		switch (ch)
		    {
		    case '0':
			set(bi++, _0);
			break;
		    case '1':
			set(bi++, _1);
			break;
		    case 'Z':
			set(bi++, _Z);
			break;
		    case 'X':
		    default:
			set(bi++, _X);
			break;
		    }
		break;
		}
	    case OCT:
		{
		TBit b1, b2, b3;
		switch (ch)
		    {
		    case '0':
			b1 = _0; b2 = _0; b3 = _0;
			break;
		    case '1':
			b1 = _0; b2 = _0; b3 = _1;
			break;
		    case '2':
			b1 = _0; b2 = _1; b3 = _0;
			break;
		    case '3':
			b1 = _0; b2 = _1; b3 = _1;
			break;
		    case '4':
			b1 = _1; b2 = _0; b3 = _0;
			break;
		    case '5':
			b1 = _1; b2 = _0; b3 = _1;
			break;
		    case '6':
			b1 = _1; b2 = _1; b3 = _0;
			break;
		    case '7':
			b1 = _1; b2 = _1; b3 = _1;
			break;
		    case 'Z':
			b1 = _Z; b2 = _Z; b3 = _Z;
			break;
		    case 'X':
		    default:
			b1 = _X; b2 = _X; b3 = _X;
			break;
		    }
		set(bi++, b1);
		set(bi++, b2);
		set(bi++, b3);
		break;
		}
	    case DEC:
		{
		if (ch >= '0' && ch <= '9')
		    {
		    TUInt d = ch - '0';
		    CVeriNum num(d, 4);
		    CVeriNum ten(10, size); // reserve
		    CVeriNum pos(strLen - i - 1, 32);
		    CVeriNum tmp = power(ten, pos);
		    tmp = multiply(tmp, num);
        if(hasSign()) {
          tmp.setSign(true);
        }
		    *this = add(*this, tmp);
		    }
		else if (ch == 'z' || ch == 'Z')
		    {
		    *this = CVeriNum(_Z, 32);
		    return;
		    }
		else // including: if (ch = 'x' || ch = 'X')
		    {
		    *this = CVeriNum(_X, 32);
		    return;
		    }
		break;
		}
	    case HEX:
		{
		TBit b1, b2, b3, b4;
		switch (ch)
		    {
		    case '0':
			b1 = _0; b2 = _0; b3 = _0; b4 = _0;
			break;
		    case '1':
			b1 = _0; b2 = _0; b3 = _0; b4 = _1;
			break;
		    case '2':
			b1 = _0; b2 = _0; b3 = _1; b4 = _0;
			break;
		    case '3':
			b1 = _0; b2 = _0; b3 = _1; b4 = _1;
			break;
		    case '4':
			b1 = _0; b2 = _1; b3 = _0; b4 = _0;
			break;
		    case '5':
			b1 = _0; b2 = _1; b3 = _0; b4 = _1;
			break;
		    case '6':
			b1 = _0; b2 = _1; b3 = _1; b4 = _0;
			break;
		    case '7':
			b1 = _0; b2 = _1; b3 = _1; b4 = _1;
			break;
		    case '8':
			b1 = _1; b2 = _0; b3 = _0; b4 = _0;
			break;
		    case '9':
			b1 = _1; b2 = _0; b3 = _0; b4 = _1;
			break;
		    case 'A':
			b1 = _1; b2 = _0; b3 = _1; b4 = _0;
			break;
		    case 'B':
			b1 = _1; b2 = _0; b3 = _1; b4 = _1;
			break;
		    case 'C':
			b1 = _1; b2 = _1; b3 = _0; b4 = _0;
			break;
		    case 'D':
			b1 = _1; b2 = _1; b3 = _0; b4 = _1;
			break;
		    case 'E':
			b1 = _1; b2 = _1; b3 = _1; b4 = _0;
			break;
		    case 'F':
			b1 = _1; b2 = _1; b3 = _1; b4 = _1;
			break;
		    case 'Z':
			b1 = _Z; b2 = _Z; b3 = _Z; b4 = _Z;
			break;
		    case 'X':
		    default:
			b1 = _X; b2 = _X; b3 = _X; b4 = _X;
			break;
		    }
		set(bi++, b1);
		set(bi++, b2);
		set(bi++, b3);
		set(bi++, b4);
		break;
		}
	    }
	}

  if(sz) {
    setWidth(sz);
  }
    }

TChar CVeriNum::bitToChar(TBit b)
    {
    switch (b)
	{
	case _0: return '0';
	case _1: return '1';
	case _X: return 'X';
	case _Z: return 'Z';
	}

    return 'X';
    }

CVeriNum CVeriNum::zero(TUInt len, TBool sgn)
    {
    CVeriNum res(CVeriNum::_0, len);
    res.setSign(sgn);
    return res;
    }

CVeriNum CVeriNum::one(TUInt len, TBool sgn)
    {
    CVeriNum res(CVeriNum::_0, len);
    res.setSign(sgn);
    if (len > 0)
	res.set(0, CVeriNum::_1);
    return res;
    }

CVeriNum CVeriNum::minusOne(TUInt len, TBool sgn)
    {
    CVeriNum res(CVeriNum::_1, len);
    res.setSign(sgn);
    return res;
    }

CVeriNum CVeriNum::undef(TUInt len, TBool sgn)
    {
    CVeriNum res(CVeriNum::_X, len);
    res.setSign(sgn);
    return res;
    }

void CVeriNum::setWidth(TUInt width)
    {
    if (width == len())
    return;

    CVeriNum tmp(CVeriNum::_X, width);

    tmp.setSign(hasSign());

    TUInt i;
    for (i = 0; i < width; i++)
      tmp.set(i, safeGet(i));

    *this = tmp;
    }

TBool CVeriNum::isDefined() const
    {
    TUInt i;
    for (i = 0; i < m_bits.len(); i++)
	{
	TBit b = m_bits[i];
	if (b == _X || b == _Z)
	    return FALSE;
	}
    return TRUE;
    }

TBool CVeriNum::isZero() const
    {
    TUInt i;
    for (i = 0; i < m_bits.len(); i++)
	if (m_bits[i] != _0)
	    return FALSE;
    return TRUE;
    }

TBool CVeriNum::isNeg() const
    {
    return hasSign() && (msb() == CVeriNum::_1);
    }

TBool CVeriNum::isEven() const
    {
    if (len() > 0)
	return get(0) == CVeriNum::_0;
    else
	return TRUE;
    }

TBool CVeriNum::isOne() const
    {
    if (len() == 0)
	return FALSE;

    if (isNeg())
	return FALSE;

    if (get(0) != CVeriNum::_1)
	return FALSE;

    TUInt i;
    for (i = 1; i < len(); i++)
	if (get(i) != CVeriNum::_0)
	    return FALSE;

    return TRUE;
    }

TBool CVeriNum::isTwo() const
    {
    if (len() < 2)
	return FALSE;

    if (isNeg())
	return FALSE;

    if (get(0) != CVeriNum::_0)
	return FALSE;

    if (get(1) != CVeriNum::_1)
	return FALSE;

    TUInt i;
    for (i = 2; i < len(); i++)
	if (get(i) != CVeriNum::_0)
	    return FALSE;

    return TRUE;
    }

TBool CVeriNum::isMinusOne() const
    {
    if (!hasSign())
	return FALSE;

    TUInt i;
    for (i = 0; i < len(); i++)
	if (get(i) != CVeriNum::_1)
	    return FALSE;

    return TRUE;
    }

void CVeriNum::setOctet(TInt bitIndex, TChar ch)
    {
    TInt i;
    for (i = 0; i < 8; i++)
	m_bits.setBit(bitIndex + i, (ch&(1<<i)) ? _1 : _0);
    }

TChar CVeriNum::getOctet(TInt bitIndex) const
    {
    TChar ch = 0;
    TInt i;
    for (i = bitIndex; i < bitIndex + 8; i++)
	ch |= get(i) << (i - bitIndex);

    return ch;
    }

TInt CVeriNum::asInt() const
    {
    TInt l = len();
    if (l == 0 || !isDefined())
	return 0;

    if (hasSign() && get(l - 1) == _1)
	{
	const TInt sz = sizeof(TUInt) * 8;
	if (l > sz)
	    l = sz;
	TInt res = -1;
	TInt mask = ~1L;
	TInt i;
	for (i = 0; i < l; i++, mask = (mask << 1) | 1L)
	    if (get(i) == _0)
		res &= mask;
	return res;
	}
    else
	return (TInt) asUInt();
    }

TUInt CVeriNum::asUInt() const
    {
    if (len() == 0 || !isDefined())
	return 0;

    TUInt res = 0;
    TInt l = len();
    const TInt sz = sizeof(TUInt) * 8;
    if (l > sz)
	l = sz;
    TInt i;
    for (i = 0; i < l; i++)
	res |= (get(i)) << i;

    return res;
    }

std::string CVeriNum::asString() const
    {
    TUInt length = len();
    if (length % 8 != 0)
	throw VeriNumException("Can't convert number to string: length % 8 != 0");

    const TInt strLen = length / 8;
    TChar *s = new TChar[strLen + 1];
    std::auto_ptr<TChar> ap_s(s);
    TInt i;
    for (i = 0; i < strLen; i++)
	s[i] = getOctet((strLen - i - 1) * 8);

    s[strLen] = '\0';
    std::string res(s);
    return res;
    }

CVeriNum::TBit CVeriNum::msb() const
    {
    TUInt l = len();

    if (l > 0)
	return get(l - 1);

    return CVeriNum::_0;
    }

CVeriNum::TBit CVeriNum::padBit(TPadType pad) const
    {
    if (pad == PAD_ZERO)
	return CVeriNum::_0;

    CVeriNum::TBit b = msb();

    if (b == CVeriNum::_1 && !hasSign())
	return CVeriNum::_0;

    return b;
    }

CVeriNum::TBit CVeriNum::safeGet(TUInt index, TPadType pad) const
    {
    if (index < len())
	return get(index);

    return padBit(pad);
    }

CVeriNum::TBit CVeriNum::logicVal() const
    {
    TUInt i;

    for (i = 0; i < len(); i++)
	switch (get(i))
	    {
	    case CVeriNum::_0:
		break;
	    case CVeriNum::_1:
		return CVeriNum::_1;
	    case CVeriNum::_X:
	    case CVeriNum::_Z:
		return CVeriNum::_X;
	    }

    return CVeriNum::_0;
    }

void CVeriNum::inc()
    {
    *this = add(*this, CVeriNum::one(2, TRUE));
    }

void CVeriNum::dec()
    {
    *this = sub(*this, CVeriNum::one(2, TRUE));
    }

std::ostream& CVeriNum::dump(std::ostream& os) const
    {
    os << "CVeriNum [hasSign: " << hasSign()
       << "] " << std::endl << m_bits;
    return os;
    }

// Operations

TBool isDefined(CVeriNum::TBit a)
    {
    switch (a)
	{
	case CVeriNum::_0:
	case CVeriNum::_1: break;
	case CVeriNum::_X:
	case CVeriNum::_Z: return FALSE;
	}

    return TRUE;
    }

CVeriNum::TBit operator|(CVeriNum::TBit a, CVeriNum::TBit b)
    {
    static CVeriNum::TBit tbl[4][4] =
	{
	{ CVeriNum::_0, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_1, CVeriNum::_1, CVeriNum::_1, CVeriNum::_1 },
	{ CVeriNum::_X, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_X, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X }
	};

    return tbl[a][b];
    }

CVeriNum::TBit operator&(CVeriNum::TBit a, CVeriNum::TBit b)
    {
    static CVeriNum::TBit tbl[4][4] =
	{
	{ CVeriNum::_0, CVeriNum::_0, CVeriNum::_0, CVeriNum::_0 },
	{ CVeriNum::_0, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_0, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_0, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X }
	};

    return tbl[a][b];
    }

CVeriNum::TBit operator^(CVeriNum::TBit a, CVeriNum::TBit b)
    {
    static CVeriNum::TBit tbl[4][4] =
	{
	{ CVeriNum::_0, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_1, CVeriNum::_0, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_X, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_X, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X }
	};

    return tbl[a][b];
    }

CVeriNum::TBit neg(CVeriNum::TBit a)
    {
    static CVeriNum::TBit tbl[4] =
	{
	CVeriNum::_1,
	CVeriNum::_0,
	CVeriNum::_X,
	CVeriNum::_X
	};

    return tbl[a];
    }

// combine operation is used in "a ? b : c" operation, when "a" is undefined
// (X or Z). then values of "b" and "c" are combined.
CVeriNum::TBit combine(CVeriNum::TBit a, CVeriNum::TBit b)
    {
    static CVeriNum::TBit tbl[4][4] =
	{
	{ CVeriNum::_0, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_X, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_X, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X },
	{ CVeriNum::_X, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X }
	};

    return tbl[a][b];
    }

CVeriNum::TBit add(CVeriNum::TBit a, CVeriNum::TBit b, CVeriNum::TBit& carry)
    {
    if (!isDefined(a) || !isDefined(b) || !isDefined(carry))
	return (carry = CVeriNum::_X);

    CVeriNum::TBit tmp = carry;
    if (a == CVeriNum::_0 && b == CVeriNum::_0)
	{
	carry = CVeriNum::_0;
	return tmp;
	}
    else if ((a == CVeriNum::_0) && (b == CVeriNum::_1) ||
             (a == CVeriNum::_1) && (b == CVeriNum::_0))
	{
	if (carry == CVeriNum::_0)
	    return CVeriNum::_1;
	else
	    return CVeriNum::_0;
	}
    else
	{
	carry = CVeriNum::_1;
	return tmp;
	}
    }

CVeriNum::TBit equal(const CVeriNum& a, const CVeriNum& b)
    {
    TInt aLen = a.len();
    TInt bLen = b.len();
    TInt maxLen = aLen > bLen ? aLen : bLen;
    TInt i;

    for (i = maxLen - 1; i >= 0; i--)
	{
	CVeriNum::TBit aBit = a.safeGet(i);
	CVeriNum::TBit bBit = b.safeGet(i);

	if (isDefined(aBit) && isDefined(bBit))
	    {
	    if (aBit != bBit)
		return CVeriNum::_0;
	    }
	else
	    return CVeriNum::_X;
	}

    return CVeriNum::_1;
    }

CVeriNum::TBit notEqual(const CVeriNum& a, const CVeriNum& b)
    {
    CVeriNum::TBit r = equal(a, b);
    switch (r)
	{
	case CVeriNum::_0: return CVeriNum::_1;
	case CVeriNum::_1: return CVeriNum::_0;
        case CVeriNum::_X:
	case CVeriNum::_Z: break;
	}

    return CVeriNum::_X;
    }

CVeriNum::TBit caseEqual(const CVeriNum& a, const CVeriNum& b)
    {
    TInt aLen = a.len();
    TInt bLen = b.len();
    TInt maxLen = aLen > bLen ? aLen : bLen;
    TInt i;
    for (i = maxLen - 1; i >= 0; i--)
	{
	CVeriNum::TBit aBit = a.safeGet(i);
	CVeriNum::TBit bBit = b.safeGet(i);

	if (aBit != bBit)
	    return CVeriNum::_0;
	}

    return CVeriNum::_1;
    }

CVeriNum::TBit caseNotEqual(const CVeriNum& a, const CVeriNum& b)
    {
    CVeriNum::TBit r = caseEqual(a, b);
    switch (r)
	{
	case CVeriNum::_0: return CVeriNum::_1;
	case CVeriNum::_1: return CVeriNum::_0;
        case CVeriNum::_X:
	case CVeriNum::_Z: break;
	}

    return CVeriNum::_1; // not used
    }

CVeriNum::TBit lessOrEqual(const CVeriNum& a, const CVeriNum& b)
    {
    return lessThan(a, b) | equal(a, b);
    }

CVeriNum::TBit lessThan(const CVeriNum& a, const CVeriNum& b)
    {
    TInt aLen = a.len();
    TInt bLen = b.len();
    TInt maxLen = aLen > bLen ? aLen : bLen;
    TInt i;

    if (!a.isDefined() || !b.isDefined())
	return CVeriNum::_X;

    if (a.isNeg() && (b.isZero() || !b.isNeg()))
	return CVeriNum::_1;

    if (b.isNeg() && (a.isZero() || !a.isNeg()))
	return CVeriNum::_0;

    for (i = maxLen - 1; i >= 0; i--)
	{
	CVeriNum::TBit aBit = a.safeGet(i);
	CVeriNum::TBit bBit = b.safeGet(i);

	if (aBit == CVeriNum::_0 && bBit == CVeriNum::_1)
	    return CVeriNum::_1;
	if (aBit == CVeriNum::_1 && bBit == CVeriNum::_0)
	    return CVeriNum::_0;
	}

    return CVeriNum::_0;
    }

CVeriNum::TBit greaterOrEqual(const CVeriNum& a, const CVeriNum& b)
    {
    return greaterThan(a, b) | equal(a, b);
    }

CVeriNum::TBit greaterThan(const CVeriNum& a, const CVeriNum& b)
    {
    return lessThan(b, a);
    }

// Shift operations

CVeriNum shiftLeft(const CVeriNum& a, TUInt n)
    {
    TUInt len = a.len();
    CVeriNum res(CVeriNum::_0, len);
    res.setSign(a.hasSign());

    TUInt i;
    for (i = 0; i < len; i++)
	if (i + n < len)
	    res.set(i + n, a[i]);

    return res;
    }

CVeriNum shiftRight(const CVeriNum& a, TUInt n)
    {
    TUInt len = a.len();
    CVeriNum res(CVeriNum::_0, len);
    res.setSign(a.hasSign());

    TUInt i;
    for (i = n; i < a.len(); i++)
	res.set(i - n, a[i]);

    return res;
    }

CVeriNum shiftRightArith(const CVeriNum& a, TUInt n)
    {
    TUInt len = a.len();
    CVeriNum::TBit sgn = a.hasSign() ? a.msb() : CVeriNum::_0;
    CVeriNum res(sgn, len);
    res.setSign(a.hasSign());

    TUInt i;
    for (i = n; i < a.len(); i++)
	res.set(i - n, a[i]);

    return res;
    }

CVeriNum bitwiseAnd(const CVeriNum& a, const CVeriNum& b)
    {
    TUInt maxLen = MAX(a.len(), b.len());
    CVeriNum c(CVeriNum::_X, maxLen);

    TUInt i;
    for (i = 0; i < maxLen; i++)
	c.set(i, a.safeGet(i) & b.safeGet(i));

    return c;
    }

CVeriNum bitwiseNand(const CVeriNum& a, const CVeriNum& b)
    {
    return bitwiseNeg(bitwiseAnd(a, b));
    }

CVeriNum bitwiseOr(const CVeriNum& a, const CVeriNum& b)
    {
    TUInt maxLen = MAX(a.len(), b.len());
    CVeriNum c(CVeriNum::_X, maxLen);

    TUInt i;
    for (i = 0; i < maxLen; i++)
	c.set(i, a.safeGet(i) | b.safeGet(i));

    return c;
    }

CVeriNum bitwiseNor(const CVeriNum& a, const CVeriNum& b)
    {
    return bitwiseNeg(bitwiseOr(a, b));
    }

CVeriNum bitwiseXor(const CVeriNum& a, const CVeriNum& b)
    {
    TUInt maxLen = MAX(a.len(), b.len());
    CVeriNum c(CVeriNum::_X, maxLen);

    TUInt i;
    for (i = 0; i < maxLen; i++)
	c.set(i, a.safeGet(i) ^ b.safeGet(i));

    return c;
    }

CVeriNum bitwiseNxor(const CVeriNum& a, const CVeriNum& b)
    {
    return bitwiseNeg(bitwiseXor(a, b));
    }

CVeriNum bitwiseNeg(const CVeriNum& a)
    {
    CVeriNum b(CVeriNum::_X, a.len());

    TUInt i;
    for (i = 0; i < a.len(); i++)
	b.set(i, neg(a[i]));

    return b;
    }

CVeriNum::TBit reductionAnd(const CVeriNum& a)
    {
    CVeriNum::TBit b = CVeriNum::_1;

    TUInt i;
    for (i = 0; i < a.len(); i++)
	b = b & a[i];

    return b;
    }

CVeriNum::TBit reductionNand(const CVeriNum& a)
    {
    return neg(reductionAnd(a));
    }

CVeriNum::TBit reductionOr(const CVeriNum& a)
    {
    CVeriNum::TBit b = CVeriNum::_0;

    TUInt i;
    for (i = 0; i < a.len(); i++)
	b = b | a[i];

    return b;
    }

CVeriNum::TBit reductionNor(const CVeriNum& a)
    {
    return neg(reductionOr(a));
    }

CVeriNum::TBit reductionXor(const CVeriNum& a)
    {
    TUInt i, c = 0;

    for (i = 0; i < a.len(); i++)
	{
	CVeriNum::TBit b = a[i];

	if (!isDefined(b))
	    return CVeriNum::_X;

	if (b == CVeriNum::_1)
	    c++;
	}

    if (c % 2)
	return CVeriNum::_1;

    return CVeriNum::_0;
    }

CVeriNum::TBit reductionNxor(const CVeriNum& a)
    {
    return neg(reductionXor(a));
    }

CVeriNum::TBit logicalAnd(const CVeriNum& a, const CVeriNum& b)
    {
    return a.logicVal() & b.logicVal();
    }

CVeriNum::TBit logicalOr(const CVeriNum& a, const CVeriNum& b)
    {
    return a.logicVal() | b.logicVal();
    }

CVeriNum::TBit logicalNeg(const CVeriNum& a)
    {
    return neg(a.logicVal());
    }

CVeriNum combine(const CVeriNum& a, const CVeriNum& b)
    {
    CVeriNum c(CVeriNum::_X, MAX(a.len(), b.len()));

    TUInt i;
    for (i = 0; i < c.len(); i++)
	c.set(i, combine(a.safeGet(i, CVeriNum::PAD_ZERO),
	                 b.safeGet(i, CVeriNum::PAD_ZERO)));

    return c;
    }

CVeriNum concat(const CVeriNum& a, const CVeriNum& b)
    {
    CVeriNum c(CVeriNum::_X, a.len() + b.len());

    TUInt i, k = 0;
    for (i = 0; i < b.len(); i++)
	{
	c.set(k, b[i]);
	k++;
	}

    for (i = 0; i < a.len(); i++)
	{
	c.set(k, a[i]);
	k++;
	}

    return c;
    }

CVeriNum abs(const CVeriNum& a)
    {
    if (a.isNeg())
	return twosComplement(a);

    return a;
    }

CVeriNum minus(const CVeriNum& a)
    {
    return twosComplement(a);
    }

CVeriNum add(const CVeriNum& a, const CVeriNum& b)
    {
    TUInt maxLen = MAX(a.len(), b.len());
    CVeriNum c(CVeriNum::_X, maxLen);
    c.setSign(a.hasSign() && b.hasSign());

    TUInt i;
    CVeriNum::TBit carry = CVeriNum::_0;
    for (i = 0; i < maxLen; i++)
	{
	CVeriNum::TBit aBit = a.safeGet(i);
	CVeriNum::TBit bBit = b.safeGet(i);

	c.set(i, add(aBit, bBit, carry));
	}

    return c;
    }

CVeriNum twosComplement(const CVeriNum& a)
    {
    CVeriNum b(CVeriNum::_X, a.len());

    TUInt i;
    for (i = 0; i < a.len(); i++)
	b.set(i, neg(a[i]));

    CVeriNum one(CVeriNum::_1, 1);
    CVeriNum c = add(b, one);

    c.setSign(a.hasSign());
    return c;
    }

CVeriNum sub(const CVeriNum& a, const CVeriNum& b)
    {
    return add(a, twosComplement(b));
    }

CVeriNum multiply(const CVeriNum& a, const CVeriNum& b)
    {
    TUInt maxLen = MAX(a.len(), b.len());
    CVeriNum c(CVeriNum::_0, maxLen);
    c.setSign(a.hasSign() && b.hasSign());

    TUInt i;
    for (i = 0; i < maxLen; i++)
	{
	switch (b.safeGet(i))
	    {
	    case CVeriNum::_0: break;
	    case CVeriNum::_1: c = add(c, shiftLeft(a, i)); break;
	    case CVeriNum::_X:
	    case CVeriNum::_Z: return CVeriNum(CVeriNum::_X, maxLen);
	    }
	}

    return c;
    }

CVeriNum div2(const CVeriNum& a)
    {
    //if (a.isTwo())
    //	return CVeriNum::one(a.len(), a.hasSign());

    return shiftRightArith(a, 1);
    }

CVeriNum power(const CVeriNum& a, const CVeriNum& b)
    {
    TUInt len = a.len();
    TBool sgn = a.hasSign();

    if (!a.isDefined() || !b.isDefined())
	return CVeriNum::undef(len, sgn);

    if (b.isZero())
	return CVeriNum::one(len, sgn);

    if (b.isNeg())
	{
	if (a.isMinusOne())
	    return b.isEven() ? CVeriNum::one(len, sgn) :
	                        CVeriNum::minusOne(len, TRUE);

	if (a.isNeg())
	    return CVeriNum::zero(len, sgn);

	if (a.isZero())
	    return CVeriNum::undef(len, sgn);

	if (a.isOne())
	    return CVeriNum::one(len, sgn);

	// "a" is positive
	return CVeriNum::zero(len, sgn);
	}

    // "b" is positive

    if (a.isMinusOne())
	return b.isEven() ? CVeriNum::one(len, sgn) :
	                    CVeriNum::minusOne(len, TRUE);
    if (a.isZero())
	return CVeriNum::zero(len, sgn);

    if (a.isOne())
	return CVeriNum::one(len, sgn);

    // "a" is less than -1 or greater than 1

    if (b.isOne())
	return a;

    if (b.isEven())
	{
	CVeriNum _a = multiply(a, a);
	CVeriNum _b = div2(b);
	return power(_a, _b);
	}

    CVeriNum _a = multiply(a, a);
    CVeriNum _b = div2(sub(b, CVeriNum::one(2, TRUE)));

    return multiply(a, power(_a, _b));
    }

CVeriNum log2(const CVeriNum& a)
    {
    if (!a.isDefined() || a.isNeg() || a.isZero())
	return CVeriNum::undef(a.len(), a.hasSign());

    CVeriNum res(CVeriNum::_0, a.len());

    CVeriNum tmp = a;
    while (!tmp.isZero() && !tmp.isOne())
	{
	tmp = shiftRight(tmp, 1);
	res.inc();
	}

    return res;
    }

void divide(const CVeriNum& a, const CVeriNum& b,
         CVeriNum& quotient, CVeriNum& remainder)
    {
    TInt len = MAX(a.len(), b.len());
    TBool sgn = a.hasSign() && b.hasSign();

    CVeriNum dividend = a;
    dividend.setWidth(len);
    CVeriNum divisor = b;
    divisor.setWidth(len);
    quotient = CVeriNum::zero(len, sgn);
    remainder = CVeriNum::zero(len, sgn);

    if (divisor.isZero() || !dividend.isDefined() || !divisor.isDefined())
	{
	quotient = CVeriNum::undef(len, sgn);
	remainder = CVeriNum::undef(len, sgn);
	return;
	}

    if (lessThan(dividend, divisor) == CVeriNum::_1)
	{
	remainder = dividend;
	return;
	}

    if (equal(dividend, divisor) == CVeriNum::_1)
	{
	quotient = CVeriNum::one(len, sgn);
	return;
	}

    TInt nbits = len;
    CVeriNum::TBit bit, q;
    CVeriNum d, r;
    while (lessThan(remainder, divisor))
	{
	bit = dividend.msb();
	r = remainder;
	remainder = shiftLeft(remainder, 1);
	remainder.set(0, remainder[0] | bit);
	d = dividend;
	dividend = shiftLeft(dividend, 1);
	nbits--;
	}

    dividend = d;
    remainder = r;
    nbits++;

    TInt i;
    CVeriNum t;
    for (i = 0; i < nbits; i++)
	{
	bit = dividend.msb();
	remainder = shiftLeft(remainder, 1);
	remainder.set(0, remainder[0] | bit);
	t = sub(remainder, divisor);
	q = neg(t.msb());
	dividend = shiftLeft(dividend, 1);
	quotient = shiftLeft(quotient, 1);
	quotient.set(0, quotient[0] | q);
	if (q == CVeriNum::_1)
	    remainder = t;
	}
    }

void signed_divide(const CVeriNum& a, const CVeriNum& b,
         CVeriNum& quotient, CVeriNum& remainder)
    {
    CVeriNum _dividend = abs(a);
    CVeriNum _divisor = abs(b);
    CVeriNum _quotient;
    CVeriNum _remainder;

    divide(_dividend, _divisor, _quotient, _remainder);

    quotient = _quotient;
    if (a.isNeg())
	{
	remainder = minus(_remainder);
	if (!b.isNeg() && !b.isZero())
	    quotient = minus(_quotient);
	}
    else
	{
	remainder = _remainder;
	if (b.isNeg())
	    quotient = minus(_quotient);
	}
    }

// stream operators

std::ostream& operator<<(std::ostream& os, CVeriNum::TBit b)
    {
    os << CVeriNum::bitToChar(b);
    return os;
    }

std::ostream& operator<<(std::ostream& os, const CVeriNum::CBitArray& bits)
    {
    return bits.dump(os);
    }

std::ostream& operator<<(std::ostream& os, const CVeriNum& num)
    {
    return num.dump(os);
    }

// CRealNum

std::ostream& CRealNum::dump(std::ostream& os) const
    {
    return os << m_realVal;
    }


std::ostream& operator<<(std::ostream& os, const CRealNum& num)
    {
    return num.dump(os);
    }

} // end namespace NSCdom
// End of File
