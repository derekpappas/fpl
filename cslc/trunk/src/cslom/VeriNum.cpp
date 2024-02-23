//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007, 2008 Fastpathlogic
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
//#define __TRACE
#include "../support/Tracer.h"

namespace NSCSLOm {

#define MAX(a, b) (((a) > (b)) ? (a) : (b))

// ********************************************************************************
// CVeriNum::CBitArray class
// ********************************************************************************
void CVeriNum::CBitArray::bitPos(TUInt bitIndex, TUInt& blkNum, TUInt& blkOffset) {
  TRACE_ME(2, "CVeriNum::CBitArray::bitPos(TInt bitIndex, TUInt& blkNum, TUInt& blkOffset)");
  blkNum = bitIndex / blockSizeDiv2;
  blkOffset = bitIndex % blockSizeDiv2;
}

void CVeriNum::CBitArray::setSize(TUInt size) {
  TRACE_ME(2, "CVeriNum::CBitArray::setSize(TUInt size)");
  delete [] m_blocks;
  if (size) {
    TUInt blockCount = ((size - 1) / blockSizeDiv2) + 1;
    m_blocks = new TUInt[blockCount];
    m_size = size;
    m_blockCount = blockCount;
    for (TUInt i = 0; i< m_blockCount; ++i)
      m_blocks[i] = 0;
  }
  else {
    m_blocks = NULL;
    m_blockCount = 0;
    m_size = 0;
  }
}

void CVeriNum::CBitArray::setBit(TUInt index, TBit bit) {
  TRACE_ME(2, "CVeriNum::CBitArray::setBit(TUInt index, TBit bit)");
  ASSERT(index < m_size, "Index out of range");
  TUInt blkNum;
  TUInt blkOffset;
  bitPos(index, blkNum, blkOffset);
  m_blocks[blkNum] = m_blocks[blkNum] &
    ~(((TUInt)3) << (blkOffset * 2))
    | ((TUInt)bit << (blkOffset * 2)); //*1
}

CVeriNum::TBit CVeriNum::CBitArray::getBit(TUInt index) const {
  TRACE_ME(2, "CVeriNum::CBitArray::getBit(TUInt index)");
  ASSERT(index < m_size, "Index out of bounds");
  TUInt blkNum;
  TUInt blkOffset;
  bitPos(index, blkNum, blkOffset);
  return (TBit)((m_blocks[blkNum] & (((TUInt)3) << (blkOffset * 2))) >> (blkOffset * 2));
}

const CVeriNum::CBitArray& CVeriNum::CBitArray::operator=(const CVeriNum::CBitArray& other){
  TRACE_ME(2,"CVeriNum::CBitArray& CVeriNum::CBitArray::operator=(const CVeriNum::CBitArray& other)");
  setSize(other.m_size);
  ASSERT(m_size == other.m_size, "The size doesn't match");
  for (TUInt i = 0; i < m_blockCount; ++i)
    m_blocks[i] = other.m_blocks[i];
  return *this;
}

std::ostream& CVeriNum::CBitArray::dump(std::ostream& os) const{
  os << "CBitArray [length: " << getSize() << ", blocks: " << m_blockCount
     << "]: ";

  TUInt i;
  for (i = 0; i < getSize(); i++)
    os << bitToChar(getBit(getSize() - i - 1));

  return os;
}

// ********************************************************************************
// CVeriNum class
// ********************************************************************************
CVeriNum::CVeriNum(const std::string& str) : m_isSigned(FALSE) {
  TRACE_ME(2, "CVeriNum::CVeriNum(const std::string& str)");
  TUInt width = str.length() * 8;
  if (!width){
    m_bits.setSize(8);
    setByte(0, '\0');
  }
  else {
    m_bits.setSize(width);
    TUInt strLen = str.length();
    for (TUInt i = 0; i < strLen; ++i)
      setByte(i*8, str[strLen-i-1]);
  }
}

CVeriNum::CVeriNum(TUInt val, TUInt width) : m_isSigned(FALSE) {
  TRACE_ME(2, "CVeriNum::CVeriNum(TUInt val, TUInt width)");
  ASSERT(width, "The width of the number can't be zero");
  m_bits.setSize(width);
  for (TUInt i = 0; i < width; ++i, val >>= 1)
    m_bits.setBit(i, (val & 1) ? _1 : _0);
}

CVeriNum::CVeriNum(TBit bit, TUInt width) : m_isSigned(FALSE) {
  TRACE_ME(2, "CVeriNum::CVeriNum(TBit bit, TUInt width)");
  ASSERT(width, "The width of the number can't be zero");
  m_bits.setSize(width);
  for (TUInt i = 0; i < m_bits.getSize(); ++i)
    m_bits.setBit(i, bit);
}

CVeriNum::CVeriNum(TBase base, const std::string& str, TBool sgnd, TUInt desiredWidth) : m_isSigned(sgnd) {
  TRACE_ME(2, "CVeriNum::CVeriNum(TBase base, const std::string& str, TBool sgnd, TUInt desiredWidth)");
  TUInt strLen = str.length();
  TUInt width;
  switch(base) {
    case BIN: 
      width = strLen;
      break;
    case OCT:
      width = strLen * 3;
      break;
    case DEC:
      width = strLen * 4; // will need trim at the end
      break;
    case HEX:
      width = strLen * 4;
      break;
    default:
      ASSERT(0, "invalid base");
  }    //*1

  m_bits.setSize(width);  //*2
  TUInt i;
  TUInt bi = 0; // bit index
  switch(base) {
    case BIN:
      for (i = strLen; i > 0; --i)  {
        TChar ch = str[i-1];
         switch (ch) {
          case '0':
            setBit(bi++, _0);
            break;
          case '1':
            setBit(bi++, _1);
            break;
          case 'Z':
          case 'z':
          case '?':
            setBit(bi++, _Z);
            break;
          case 'X':
          case 'x':
            setBit(bi++, _X);
            break;
          default:
            ASSERT(0, "Invalid binary character: " << ch);
        }
      }
      break;
    case OCT:
      for (i = strLen; i > 0; --i)  {
        TChar ch = str[i-1];
        TBit b1, b2, b3;
        switch (ch) {
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
          case 'z':
          case '?':
            b1 = _Z; b2 = _Z; b3 = _Z;
            break;
          case 'X':
          case 'x':
            b1 = _X; b2 = _X; b3 = _X;
            break;
          default:
            ASSERT(0, "Invalid octal character" << ch);
        }
        setBit(bi++, b3);
        setBit(bi++, b2);
        setBit(bi++, b1);
      }
      break;
    case DEC:
      //std::cerr << "DEC" << std::endl;
      for (i = strLen; i > 0; --i)  {
        TChar ch = str[i-1];
        CVeriNum ten(10, width); // reserve
        switch(ch) {
          case '0':
          case '1':
          case '2':
          case '3':
          case '4':
          case '5':
          case '6':
          case '7':
          case '8':
          case '9': 
            {
              //std::cerr << "strLen=" << strLen << std::endl;
              //std::cerr << "ch=" << ch << std::endl;
              TUInt d = ch - '0';  
              //std::cerr << "d = " << d << std::endl;
              CVeriNum num(d, 4);
              //std::cerr << "num = " << num << std::endl;
              CVeriNum pos(strLen - i, 32);
              //std::cerr << "pos = " << pos << std::endl;
              CVeriNum tmp = power(ten, pos);
              //std::cerr << "power=" << tmp << std::endl;
              tmp = multiply(tmp, num);
              //std::cerr << "multiply=" << tmp << std::endl;
              if(sgnd) {
                tmp.setSigned(TRUE);
              }
              *this = add(*this, tmp);
              //std::cerr << "*this=" << *this << std::endl;
            }
            break;
          case 'z':
          case 'Z':
          case '?':
            *this = CVeriNum(_Z, 32);
            return;
          case 'x':
          case 'X':
            *this = CVeriNum(_X, 32);
            return;
          default:
            ASSERT(0, "Invalid decimal character " << ch);
        }
      }
      break;
    case HEX:
      for (i = strLen; i > 0; --i)  {
        TChar ch = str[i-1];
        TBit b1, b2, b3, b4;
        switch (ch) {
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
          case 'a':
            b1 = _1; b2 = _0; b3 = _1; b4 = _0;
            break;
          case 'B':
          case 'b':
            b1 = _1; b2 = _0; b3 = _1; b4 = _1;
            break;
          case 'C':
          case 'c':
            b1 = _1; b2 = _1; b3 = _0; b4 = _0;
            break;
          case 'D':
          case 'd':
            b1 = _1; b2 = _1; b3 = _0; b4 = _1;
            break;
          case 'E':
          case 'e':
            b1 = _1; b2 = _1; b3 = _1; b4 = _0;
            break;
          case 'F':
          case 'f':
            b1 = _1; b2 = _1; b3 = _1; b4 = _1;
            break;
          case 'Z':
          case 'z':
          case '?':
            b1 = _Z; b2 = _Z; b3 = _Z; b4 = _Z;
            break;
          case 'X':
          case 'x':
            b1 = _X; b2 = _X; b3 = _X; b4 = _X;
            break;
          default:
            ASSERT(0, "Invalid hex character" << ch);
        }
        setBit(bi++, b4);
        setBit(bi++, b3);
        setBit(bi++, b2);
        setBit(bi++, b1);
      }
      break;
    default:
      ASSERT(0,"invalid base");
  }

  if(desiredWidth) {
    setWidth(desiredWidth);   //*6
  }
}

TChar CVeriNum::bitToChar(TBit bit){
  switch (bit){
    case _0: 
      return '0';
    case _1: 
      return '1';
    case _X:
      return 'X';
    case _Z: 
      return 'Z';
    default:
      ASSERT(0, "Bug detected: invalid character found");
  }

  return 'X';
}

CVeriNum CVeriNum::zero(TUInt width, TBool sgn) {
  TRACE_ME(2,"CVeriNum::zero(TUInt width, TBool sgn)");
  CVeriNum res(CVeriNum::_0, width);
  res.setSigned(sgn);
  return res;
}

CVeriNum CVeriNum::one(TUInt width, TBool sgn) {
  TRACE_ME(2, "CVeriNum::one(TUInt width, TBool sgn)");
  ASSERT(width, "The width must be positive to get one");
  ASSERT(!(sgn && width == 1), "If the number is signed, the width has to be greater than one");
  CVeriNum res(CVeriNum::_0, width);
  res.setSigned(sgn);
  res.setBit(0, CVeriNum::_1);
  return res;
}

CVeriNum CVeriNum::minusOne(TUInt width) {
  TRACE_ME(2, "CVeriNum::minusOne(TUInt width)");
  ASSERT(width > 1, "a negative one has to have a width greater than one");
  CVeriNum res(CVeriNum::_1, width);
  res.setSigned(TRUE);
  return res;
}

CVeriNum CVeriNum::undef(TUInt width, TBool sgn){
  TRACE_ME(2, "CVeriNum::undef(TUInt width, TBool sgn)");
  ASSERT(width, "The width of a number can't be zero");
  CVeriNum res(CVeriNum::_X, width);
  res.setSigned(sgn);
  return res;
}

void CVeriNum::setWidth(TUInt width) {
  TRACE_ME(2, "CVeriNum::setWidth(TUInt width)");
  ASSERT(width, "You can't set the width to zero");
  if(width == getWidth())
    return;

  CVeriNum tmp(CVeriNum::_X, width); 

  tmp.setSigned(isSigned());

  for (TUInt i = 0; i < width; ++i)
    tmp.setBit(i, safeGetBit(i));

  *this = tmp;
}

TBool CVeriNum::isDefined() const {
  TRACE_ME(2, "CVeriNum::isDefined() const");
  for (TUInt i = 0; i < m_bits.getSize(); ++i) {
    TBit b = m_bits[i];
    if (b == _X || b == _Z)
      return FALSE;
  }
  return TRUE;
}

TBool CVeriNum::isZero() const {
  TRACE_ME(2, "CVeriNum::isZero() const");
  TUInt size = m_bits.getBlockCount();
  for (TUInt i = 0; i < size; ++i)
    if (m_bits.getBlock(i))
      return FALSE;
  return TRUE;
}

TBool CVeriNum::isNeg() const {
  TRACE_ME(2,"CVeriNum::isNeg() const");
  return isSigned() && (getMsb() == CVeriNum::_1);
}

TBool CVeriNum::isEven() const {
  TRACE_ME(2, "CVeriNum::isEven() const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");
  return getBit(0) == CVeriNum::_0;
}

TBool CVeriNum::isOne() const {
  TRACE_ME(2, "CVeriNum::isOne() const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");

  if(m_bits.getBlock(0) != 1) {
    return FALSE;
  }
  TUInt size = m_bits.getBlockCount();
  for(TUInt i = 1; i<size; ++i)
    if(m_bits.getBlock(i))
      return FALSE;
  return TRUE;
}

TBool CVeriNum::isTwo() const {
  TRACE_ME(2, "CVeriNum::isTwo() const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");
  if(  (getWidth() == 1)
    || (getWidth() == 2 && m_isSigned)
    || (m_bits.getBlock(1) != 4)
    )
    return FALSE;

  TUInt size = m_bits.getSize();
  for(TUInt i = 1; i<size; ++i)
    if(m_bits.getBlock(i))
      return FALSE;

  return TRUE;
}

TBool CVeriNum::isMinusOne() const {
  TRACE_ME(2, "CVeriNum::isMinusOne() const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");
  TUInt width = getWidth();
  if (!isSigned() || width == 1)
    return FALSE;
  //TODO might want to optimize here using getBlock method in m_bits
  for (TUInt i = 0; i < width; ++i)
    if (getBit(i) != CVeriNum::_1)
      return FALSE;

  return TRUE;
}

void CVeriNum::setByte(TUInt bitIndex, TChar ch) {
  TRACE_ME(2,"CVeriNum::setByte(TUInt bitIndex, TChar ch)");
  for(TUInt i = 0; i < 8; ++i)
    m_bits.setBit(bitIndex + i, (ch&(1<<i)) ? _1 : _0);
}

TChar CVeriNum::getByte(TUInt bitIndex) const {
  TRACE_ME(2, "CVeriNum::getByte(TUInt bitIndex) const");
  TChar ch = 0;
  for (TUInt i = bitIndex; i < bitIndex + 8; ++i)
    ch |= getBit(i) << (i - bitIndex);
  return ch;
}

TInt CVeriNum::asInt() const {
  TRACE_ME(2, "CVeriNum::asInt() const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");
  ASSERT(isDefined(), "The number is not defined. Use isDefined before trying to get the number as an int");

  //return isSigned()&&(getBit(l - 1)==_1)?~((TInt)asUInt())+1:asUInt();
  //check if the number has sign and the sign is negative
  //If that, add 1 to the integer. Else return as unsigned int
  TInt res;
  if( !isSigned() || getMsb() == _0) {
    res = (TInt)asUInt();
    res = res>0?res:(-res);
  }
  else {
    res = -1;
    TUInt width = getWidth();
    ASSERT(width, "The width can't be zero, internal bug detected");
    const TUInt sz = sizeof(TInt) * 8;
    if (width > sz)
      width = sz;
    else
      --width;
    for (TUInt i = 0; i < width; ++i) {
      TBit bt = getBit(i);
      if(!bt) {
        res ^= 1<<i;
      }
    }
  }

  return res;
}

TUInt CVeriNum::asUInt() const {
  TRACE_ME(2, "CVeriNum::asUInt() const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");
  ASSERT(isDefined(), "The number is not defined. Use isDefined before trying to get the number as an uint");

  TUInt res = 0;
  TUInt width = getWidth();
  const TUInt sz = sizeof(TUInt) * 8;
  if (width > sz)
    width = sz;
  for (TUInt i = 0; i < width; ++i)
    res |= (getBit(i)) << i;

  return res;
}

std::string CVeriNum::asString() const {
  TRACE_ME(2, "CVeriNum::asString() const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");
  TUInt length = getWidth();
  ASSERT(!(length%8), "Test if this number can be a string before transforming it");

  const TUInt strLen = length / 8;
  std::string returned;
  returned.resize(strLen);
  for(TUInt i = 0; i < strLen; ++i)
    returned[i] = getByte((strLen - i - 1) * 8);

  return returned;
}

CVeriNum::TBit CVeriNum::getMsb() const {
  TRACE_ME(2, "CVeriNum::getMsb() const");
  TUInt width = getWidth();
  ASSERT(width, "The width can't be zero, internal bug detected");

  return getBit(width - 1);
}

CVeriNum::TBit CVeriNum::getPadBit(TPadType pad) const {
  TRACE_ME(2, "CVeriNum::getPadBit(TPadType pad) const");
  if(pad == PAD_ZERO)
    return CVeriNum::_0;

  return isNeg() ? CVeriNum::_1 : CVeriNum::_0;
}

CVeriNum::TBit CVeriNum::safeGetBit(TUInt index, TPadType pad) const {
  TRACE_ME(2, "CVeriNum::safeGetBit(TUInt index, TPadType pad) const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");
  if (index < getWidth())
    return getBit(index);

  return getPadBit(pad);
}

CVeriNum::TBit CVeriNum::getLogicalValue() const {
  TRACE_ME(2, "CVeriNum::getLogicalValue() const");
  ASSERT(getWidth(), "The width can't be zero, internal bug detected");
  for (TUInt i = 0; i < getWidth(); ++i)
    switch (getBit(i)) {
      case CVeriNum::_0:
        break;
      case CVeriNum::_1:
        return CVeriNum::_1;
      case CVeriNum::_X:
      case CVeriNum::_Z:
        return CVeriNum::_X;
      default:
        ASSERT(0, "Bug detected: invalid bit found");
    }

  return CVeriNum::_0;
}

void CVeriNum::inc() {
  TRACE_ME(2, "CVeriNum::inc()");
  *this = add(*this, CVeriNum::one(2, TRUE));
}

void CVeriNum::dec() {
  TRACE_ME(2, "CVeriNum::dec()");
  *this = add(*this, CVeriNum::minusOne(2));
}

std::ostream& CVeriNum::dump(std::ostream& os) const{
  os << "CVeriNum [hasSign: " << isSigned()
     << "] " << std::endl << m_bits;
  return os;
}

// Operations

TBool isDefined(CVeriNum::TBit a) {
  TRACE_ME(2, "isDefined(CVeriNum::TBit a)");
  switch (a){
    case CVeriNum::_0:
    case CVeriNum::_1: break;
    case CVeriNum::_X:
    case CVeriNum::_Z: return FALSE;
    default: ASSERT(0, "Invalid bit found");
  }
  return TRUE;
}

CVeriNum::TBit operator|(CVeriNum::TBit a, CVeriNum::TBit b) {
  TRACE_ME(2, "operator|(CVeriNum::TBit a, CVeriNum::TBit b)");
  ASSERT( a < 4 && b < 4, "Invalid input bits");
  static CVeriNum::TBit tbl[4][4] =  {
      { CVeriNum::_0, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_1, CVeriNum::_1, CVeriNum::_1, CVeriNum::_1 },
      { CVeriNum::_X, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_X, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X }
  };

  return tbl[a][b];
}

CVeriNum::TBit operator&(CVeriNum::TBit a, CVeriNum::TBit b) {
  TRACE_ME(2, "operator&(CVeriNum::TBit a, CVeriNum::TBit b)");
  ASSERT( a < 4 && b < 4, "Invalid input bits");
  static CVeriNum::TBit tbl[4][4] =  {
      { CVeriNum::_0, CVeriNum::_0, CVeriNum::_0, CVeriNum::_0 },
      { CVeriNum::_0, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_0, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_0, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X }
  };

  return tbl[a][b];
}

CVeriNum::TBit operator^(CVeriNum::TBit a, CVeriNum::TBit b) {
  TRACE_ME(2, "operator^(CVeriNum::TBit a, CVeriNum::TBit b)");
  ASSERT( a < 4 && b < 4, "Invalid input bits");
  static CVeriNum::TBit tbl[4][4] =  {
      { CVeriNum::_0, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_1, CVeriNum::_0, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_X, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_X, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X }
  };

  return tbl[a][b];
}

CVeriNum::TBit neg(CVeriNum::TBit a) {
  TRACE_ME(2, "neg(CVeriNum::TBit a)");
  ASSERT(a < 4, "Invalid input bit");
  static CVeriNum::TBit tbl[4] ={
      CVeriNum::_1,
      CVeriNum::_0,
      CVeriNum::_X,
      CVeriNum::_X
  };

  return tbl[a];
}

// combine operation is used in "a ? b : c" operation, when "a" is undefined
// (X or Z). then values of "b" and "c" are combined.
CVeriNum::TBit combine(CVeriNum::TBit a, CVeriNum::TBit b) {
  TRACE_ME(2, "combine(CVeriNum::TBit a, CVeriNum::TBit b)");
  ASSERT( a < 4 && b < 4, "Invalid input bits");
  static CVeriNum::TBit tbl[4][4] =  {
      { CVeriNum::_0, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_X, CVeriNum::_1, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_X, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X },
      { CVeriNum::_X, CVeriNum::_X, CVeriNum::_X, CVeriNum::_X }
  };

  return tbl[a][b];
}

CVeriNum::TBit add(CVeriNum::TBit a, CVeriNum::TBit b, CVeriNum::TBit& carry) {
  TRACE_ME(2,"add(CVeriNum::TBit a, CVeriNum::TBit b, CVeriNum::TBit& carry)");
  ASSERT( a < 4 && b < 4 && carry < 4, "Invalid input bits");
  if (!isDefined(a) || !isDefined(b) || !isDefined(carry))
    return (carry = CVeriNum::_X);

  CVeriNum::TBit tmp = carry;
  if (a == CVeriNum::_0 && b == CVeriNum::_0){
      carry = CVeriNum::_0;
      return tmp;
  }
  else if ((a == CVeriNum::_0) && (b == CVeriNum::_1) ||
           (a == CVeriNum::_1) && (b == CVeriNum::_0)){
      if (carry == CVeriNum::_0)
      return CVeriNum::_1;
      else
      return CVeriNum::_0;
  }
  else {
      carry = CVeriNum::_1;
      return tmp;
  }
  return CVeriNum::_X;
}

CVeriNum::TBit equal(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "equal(const CVeriNum& a, const CVeriNum& b)");
  TUInt aLen = a.getWidth();
  TUInt bLen = b.getWidth();
  TUInt maxLen = aLen > bLen ? aLen : bLen;

  for(TUInt i = maxLen - 1; i >= 0; --i) {
    CVeriNum::TBit aBit = a.safeGetBit(i);
    CVeriNum::TBit bBit = b.safeGetBit(i);

    if (isDefined(aBit) && isDefined(bBit)) {
      if (aBit != bBit)
        return CVeriNum::_0;
    }
    else
      return CVeriNum::_X;
  }

  return CVeriNum::_1;
}

CVeriNum::TBit notEqual(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "notEqual(const CVeriNum& a, const CVeriNum& b)");
  CVeriNum::TBit r = equal(a, b);
  switch (r){
    case CVeriNum::_0: 
      return CVeriNum::_1;
    case CVeriNum::_1: 
      return CVeriNum::_0;
    case CVeriNum::_X:
    case CVeriNum::_Z:
      break;
    default:
      ASSERT(0, "bug detected: invalid bit");
  }

  return CVeriNum::_X;
}

CVeriNum::TBit caseEqual(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "caseEqual(const CVeriNum& a, const CVeriNum& b)");
  TInt aLen = a.getWidth();
  TInt bLen = b.getWidth();
  TInt maxLen = aLen > bLen ? aLen : bLen;
  TInt i;
  for (i = maxLen - 1; i >= 0; i--) {
    CVeriNum::TBit aBit = a.safeGetBit(i);
    CVeriNum::TBit bBit = b.safeGetBit(i);
    if (aBit != bBit)
      return CVeriNum::_0;
  }

  return CVeriNum::_1;
}

CVeriNum::TBit caseNotEqual(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "caseNotEqual(const CVeriNum& a, const CVeriNum& b)");
  CVeriNum::TBit r = caseEqual(a, b);
  switch (r){
    case CVeriNum::_0:
      return CVeriNum::_1;
    case CVeriNum::_1: 
      return CVeriNum::_0;
    case CVeriNum::_X:
    case CVeriNum::_Z: 
      break;
    default:
      ASSERT(0, "bug detected: invalid bit");
  }
  return CVeriNum::_1; // not used
}

CVeriNum::TBit lessOrEqual(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "lessOrEqual(const CVeriNum& a, const CVeriNum& b)");
  return lessThan(a, b) | equal(a, b);
}

CVeriNum::TBit lessThan(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "lessThan(const CVeriNum& a, const CVeriNum& b)");
  TUInt aLen = a.getWidth();
  TUInt bLen = b.getWidth();
  TUInt maxLen = aLen > bLen ? aLen : bLen;
  TUInt i;

  if (!a.isDefined() || !b.isDefined())
    return CVeriNum::_X;

  if (a.isNeg() && (b.isZero() || !b.isNeg()))
    return CVeriNum::_1;

  if (b.isNeg() && (a.isZero() || !a.isNeg()))
    return CVeriNum::_0;

  for (i = maxLen - 1; i >= 0; i--)  {
    CVeriNum::TBit aBit = a.safeGetBit(i);
    CVeriNum::TBit bBit = b.safeGetBit(i);

    if (aBit == CVeriNum::_0 && bBit == CVeriNum::_1)
      return CVeriNum::_1;
    if (aBit == CVeriNum::_1 && bBit == CVeriNum::_0)
      return CVeriNum::_0;
  }

  return CVeriNum::_0;
}

CVeriNum::TBit greaterOrEqual(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "greaterOrEqual(const CVeriNum& a, const CVeriNum& b)");
  return greaterThan(a, b) | equal(a, b);
}

CVeriNum::TBit greaterThan(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "greaterThan(const CVeriNum& a, const CVeriNum& b)");
  return lessThan(b, a);
}

// Shift operations

CVeriNum shiftLeft(const CVeriNum& a, TUInt n) {
  TRACE_ME(2, "shiftLeft(const CVeriNum& a, TUInt n)");
  TUInt len = a.getWidth();
  CVeriNum res(CVeriNum::_0, len);
  res.setSigned(a.isSigned());

  TUInt i;
  for (i = 0; i < len; i++)
    if (i + n < len)
      res.setBit(i + n, a[i]);

  return res;
}

CVeriNum shiftLeftArith(const CVeriNum& a, TUInt n) {
  TRACE_ME(2, "shiftLeftArith(const CVeriNum& a, TUInt n)");
  std::cerr << "not implemented" << std::endl;
  //!!!TODO
  return CVeriNum::zero(1);
}

CVeriNum shiftRight(const CVeriNum& a, TUInt n) {
  TRACE_ME(2, "shiftRight(const CVeriNum& a, TUInt n)");
  TUInt len = a.getWidth();
  CVeriNum res(CVeriNum::_0, len);
  res.setSigned(a.isSigned());

  TUInt i;
  for (i = n; i < a.getWidth(); i++)
  res.setBit(i - n, a[i]);

  return res;
}

CVeriNum shiftRightArith(const CVeriNum& a, TUInt n) {
  TRACE_ME(2, "shiftRightArith(const CVeriNum& a, TUInt n)");
  TUInt len = a.getWidth();
  CVeriNum::TBit sgn = a.isSigned() ? a.getMsb() : CVeriNum::_0;
  CVeriNum res(sgn, len);
  res.setSigned(a.isSigned());

  TUInt i;
  for (i = n; i < a.getWidth(); i++)
  res.setBit(i - n, a[i]);

  return res;
}

CVeriNum bitwiseAnd(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "bitwiseAnd(const CVeriNum& a, const CVeriNum& b)");
  TUInt maxLen = MAX(a.getWidth(), b.getWidth());
  CVeriNum c(CVeriNum::_X, maxLen);

  TUInt i;
  for (i = 0; i < maxLen; i++)
  c.setBit(i, a.safeGetBit(i) & b.safeGetBit(i));

  return c;
}

CVeriNum bitwiseNand(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "bitwiseNand(const CVeriNum& a, const CVeriNum& b)");
  return bitwiseNeg(bitwiseAnd(a, b));
}

CVeriNum bitwiseOr(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "bitwiseOr(const CVeriNum& a, const CVeriNum& b)");
  TUInt maxLen = MAX(a.getWidth(), b.getWidth());
  CVeriNum c(CVeriNum::_X, maxLen);

  TUInt i;
  for (i = 0; i < maxLen; i++)
  c.setBit(i, a.safeGetBit(i) | b.safeGetBit(i));

  return c;
}

CVeriNum bitwiseNor(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "bitwiseNor(const CVeriNum& a, const CVeriNum& b)");
  return bitwiseNeg(bitwiseOr(a, b));
}

CVeriNum bitwiseXor(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "bitwiseXor(const CVeriNum& a, const CVeriNum& b)");
  TUInt maxLen = MAX(a.getWidth(), b.getWidth());
  CVeriNum c(CVeriNum::_X, maxLen);

  TUInt i;
  for (i = 0; i < maxLen; i++)
  c.setBit(i, a.safeGetBit(i) ^ b.safeGetBit(i));

  return c;
}

CVeriNum bitwiseNxor(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "bitwiseNxor(const CVeriNum& a, const CVeriNum& b)");
  return bitwiseNeg(bitwiseXor(a, b));
}

CVeriNum bitwiseNeg(const CVeriNum& a){
  TRACE_ME(2, "bitwiseNeg(const CVeriNum& a)");
  CVeriNum b(CVeriNum::_X, a.getWidth());

  TUInt i;
  for (i = 0; i < a.getWidth(); i++)
  b.setBit(i, neg(a[i]));

  return b;
}

CVeriNum::TBit reductionAnd(const CVeriNum& a) {
  TRACE_ME(2, "reductionAnd(const CVeriNum& a)");
  CVeriNum::TBit b = CVeriNum::_1;

  TUInt i;
  for (i = 0; i < a.getWidth(); i++)
  b = b & a[i];

  return b;
}

CVeriNum::TBit reductionNand(const CVeriNum& a){
  TRACE_ME(2, "reductionNand(const CVeriNum& a)");
  return neg(reductionAnd(a));
}

CVeriNum::TBit reductionOr(const CVeriNum& a){
  TRACE_ME(2, "reductionOr(const CVeriNum& a)");
  CVeriNum::TBit b = CVeriNum::_0;

  TUInt i;
  for (i = 0; i < a.getWidth(); i++)
  b = b | a[i];

  return b;
}

CVeriNum::TBit reductionNor(const CVeriNum& a){
  TRACE_ME(2, "reductionNor(const CVeriNum& a)");
  return neg(reductionOr(a));
}

CVeriNum::TBit reductionXor(const CVeriNum& a){
  TRACE_ME(2, "reductionXor(const CVeriNum& a)");
  TUInt i, c = 0;

  for (i = 0; i < a.getWidth(); i++)  {
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

CVeriNum::TBit reductionNxor(const CVeriNum& a){
  TRACE_ME(2, "reductionNxor(const CVeriNum& a)");
  return neg(reductionXor(a));
}

CVeriNum::TBit logicalAnd(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "logicalAnd(const CVeriNum& a, const CVeriNum& b)");
  return a.getLogicalValue() & b.getLogicalValue();
}

CVeriNum::TBit logicalOr(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "logicalOr(const CVeriNum& a, const CVeriNum& b)");
  return a.getLogicalValue() | b.getLogicalValue();
}

CVeriNum::TBit logicalNeg(const CVeriNum& a){
  TRACE_ME(2, "logicalNeg(const CVeriNum& a)");
  return neg(a.getLogicalValue());
}

CVeriNum combine(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "combine(const CVeriNum& a, const CVeriNum& b)");
  CVeriNum c(CVeriNum::_X, MAX(a.getWidth(), b.getWidth()));

  TUInt i;
  for (i = 0; i < c.getWidth(); i++)
  c.setBit(i, combine(a.safeGetBit(i, CVeriNum::PAD_ZERO),
                   b.safeGetBit(i, CVeriNum::PAD_ZERO)));

  return c;
}

CVeriNum concat(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "concat(const CVeriNum& a, const CVeriNum& b)");
  CVeriNum c(CVeriNum::_X, a.getWidth() + b.getWidth());

  TUInt i, k = 0;
  for (i = 0; i < b.getWidth(); i++)  {
      c.setBit(k, b[i]);
      k++;
  }

  for (i = 0; i < a.getWidth(); i++)  {
      c.setBit(k, a[i]);
      k++;
  }

  return c;
}

CVeriNum abs(const CVeriNum& a){
  TRACE_ME(2, "abs(const CVeriNum& a)");
  if (a.isNeg())
  return twosComplement(a);

  return a;
}

CVeriNum minus(const CVeriNum& a){
  TRACE_ME(2, "minus(const CVeriNum& a)");
  return twosComplement(a);
}

CVeriNum add(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "add(const CVeriNum& a, const CVeriNum& b)");
  TUInt maxLen = MAX(a.getWidth(), b.getWidth());
  CVeriNum c(CVeriNum::_X, maxLen);
  c.setSigned(a.isSigned() && b.isSigned());

  TUInt i;
  CVeriNum::TBit carry = CVeriNum::_0;
  for (i = 0; i < maxLen; i++)  {
      CVeriNum::TBit aBit = a.safeGetBit(i);
      CVeriNum::TBit bBit = b.safeGetBit(i);

      c.setBit(i, add(aBit, bBit, carry));
  }

  return c;
}

CVeriNum twosComplement(const CVeriNum& a){
  TRACE_ME(2, "twosComplement(const CVeriNum& a)");
  CVeriNum b(CVeriNum::_X, a.getWidth());

  TUInt i;
  for (i = 0; i < a.getWidth(); i++)
  b.setBit(i, neg(a[i]));

  CVeriNum one(CVeriNum::_1, 1);
  CVeriNum c = add(b, one);

  c.setSigned(a.isSigned());
  return c;
}

CVeriNum sub(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "sub(const CVeriNum& a, const CVeriNum& b)");
  return add(a, twosComplement(b));
}

CVeriNum multiply(const CVeriNum& a, const CVeriNum& b){
  TRACE_ME(2, "multiply(const CVeriNum& a, const CVeriNum& b)");
  TUInt maxLen = MAX(a.getWidth(), b.getWidth());
  CVeriNum c(CVeriNum::_0, maxLen);
  c.setSigned(a.isSigned() && b.isSigned());

  TUInt i;
  for (i = 0; i < maxLen; i++)  {
      switch (b.safeGetBit(i)) {
      case CVeriNum::_0: break;
      case CVeriNum::_1: c = add(c, shiftLeft(a, i)); break;
      case CVeriNum::_X:
      case CVeriNum::_Z: return CVeriNum(CVeriNum::_X, maxLen);
      }
  }

  return c;
}

CVeriNum div2(const CVeriNum& a){
  TRACE_ME(2, "div2(const CVeriNum& a)");
  //if (a.isTwo())
  //  return CVeriNum::one(a.getWidth(), a.isSigned());

  return shiftRightArith(a, 1);
}

CVeriNum power(const CVeriNum& a, const CVeriNum& b) {
  TRACE_ME(2, "power(const CVeriNum& a, const CVeriNum& b)");
  TUInt len = a.getWidth();
  TBool sgn = a.isSigned();

  if (!a.isDefined() || !b.isDefined())
    return CVeriNum::undef(len, sgn);

  if(b.isZero()) {
    return CVeriNum::one(len, sgn);
  }

  if(b.isNeg()){
    if (a.isMinusOne()) {
      return b.isEven() ? CVeriNum::one(len, sgn) :
        CVeriNum::minusOne(len);
    }

    if (a.isNeg())
      return CVeriNum::zero(len, sgn);

    if (a.isZero())
      return CVeriNum::undef(len, sgn);

    if (a.isOne()) {
      return CVeriNum::one(len, sgn);
    }

    // "a" is positive
    return CVeriNum::zero(len, sgn);
  }

  // "b" is positive

  if (a.isMinusOne()) {
    return b.isEven() ? CVeriNum::one(len, sgn) : CVeriNum::minusOne(len);
  }
  if (a.isZero())
    return CVeriNum::zero(len, sgn);

  if (a.isOne()) {
    return CVeriNum::one(len, sgn);
  }

  // "a" is less than -1 or greater than 1

  if (b.isOne())
    return a;

  if (b.isEven()){
    CVeriNum _a = multiply(a, a);
    CVeriNum _b = div2(b);
    return power(_a, _b);
  }

  CVeriNum _a = multiply(a, a);
  CVeriNum _b = div2(sub(b, CVeriNum::one(2, TRUE)));

  return multiply(a, power(_a, _b));
}

CVeriNum log2(const CVeriNum& a){
  TRACE_ME(2, "log2(const CVeriNum& a)");
  if (!a.isDefined() || a.isNeg() || a.isZero())
  return CVeriNum::undef(a.getWidth(), a.isSigned());

  CVeriNum res(CVeriNum::_0, a.getWidth());

  CVeriNum tmp = a;
  while (!tmp.isZero() && !tmp.isOne())  {
      tmp = shiftRight(tmp, 1);
      res.inc();
  }

  return res;
}

void divide(const CVeriNum& a, const CVeriNum& b, CVeriNum& quotient, CVeriNum& remainder){
  TRACE_ME(2, "divide(const CVeriNum& a, const CVeriNum& b, CVeriNum& quotient, CVeriNum& remainder)");
  TInt len = MAX(a.getWidth(), b.getWidth());
  TBool sgn = a.isSigned() && b.isSigned();

  CVeriNum dividend = a;
  dividend.setWidth(len);
  CVeriNum divisor = b;
  divisor.setWidth(len);
  quotient = CVeriNum::zero(len, sgn);
  remainder = CVeriNum::zero(len, sgn);

  if (divisor.isZero() || !dividend.isDefined() || !divisor.isDefined()){
      quotient = CVeriNum::undef(len, sgn);
      remainder = CVeriNum::undef(len, sgn);
      return;
  }

  if (lessThan(dividend, divisor) == CVeriNum::_1){
      remainder = dividend;
      return;
  }

  if (equal(dividend, divisor) == CVeriNum::_1)  {
      quotient = CVeriNum::one(len, sgn);
      return;
  }

  TInt nbits = len;
  CVeriNum::TBit bit, q;
  CVeriNum d=CVeriNum::zero(1), r = CVeriNum::zero(1);
  while (lessThan(remainder, divisor)){
      bit = dividend.getMsb();
      r = remainder;
      remainder = shiftLeft(remainder, 1);
      remainder.setBit(0, remainder[0] | bit);
      d = dividend;
      dividend = shiftLeft(dividend, 1);
      nbits--;
  }

  dividend = d;
  remainder = r;
  nbits++;

  TInt i;
  CVeriNum t=CVeriNum::zero(1);
  for (i = 0; i < nbits; i++){
      bit = dividend.getMsb();
      remainder = shiftLeft(remainder, 1);
      remainder.setBit(0, remainder[0] | bit);
      t = sub(remainder, divisor);
      q = neg(t.getMsb());
      dividend = shiftLeft(dividend, 1);
      quotient = shiftLeft(quotient, 1);
      quotient.setBit(0, quotient[0] | q);
      if (q == CVeriNum::_1)
      remainder = t;
  }
}

void signed_divide(const CVeriNum& a, const CVeriNum& b, CVeriNum& quotient, CVeriNum& remainder) {
  TRACE_ME(2, "signed_divide(const CVeriNum& a, const CVeriNum& b, CVeriNum& quotient, CVeriNum& remainder)");
  CVeriNum _dividend = abs(a);
  CVeriNum _divisor = abs(b);
  CVeriNum _quotient = CVeriNum::zero(1);
  CVeriNum _remainder = CVeriNum::zero(1);

  divide(_dividend, _divisor, _quotient, _remainder);

  quotient = _quotient;
  if (a.isNeg()) {
      remainder = minus(_remainder);
      if (!b.isNeg() && !b.isZero())
      quotient = minus(_quotient);
  }
  else {
      remainder = _remainder;
      if (b.isNeg())
      quotient = minus(_quotient);
  }
}

// stream operators

std::ostream& operator<<(std::ostream& os, CVeriNum::TBit b) {
  os << CVeriNum::bitToChar(b);
  return os;
}

std::ostream& operator<<(std::ostream& os, const CVeriNum::CBitArray& bits) {
  return bits.dump(os);
}

std::ostream& operator<<(std::ostream& os, const CVeriNum& num) {
  return num.dump(os);
}

// CRealNum

std::ostream& CRealNum::dump(std::ostream& os) const {
  return os << m_realVal;
}


std::ostream& operator<<(std::ostream& os, const CRealNum& num) {
  return num.dump(os);
}

} // end namespace NSCdom
// End of File
