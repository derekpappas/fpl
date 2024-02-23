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

#ifndef INC_GUARD_CSLOM_VeriNum_h
#define INC_GUARD_CSLOM_VeriNum_h

#include "../support/CommonSupport.h"

namespace NSCSLOm {

class VeriNumException : public std::exception {
public:
  VeriNumException(const TChar *message) throw()
    : m_message(message) { }
  virtual ~VeriNumException() throw () { }
  const TChar* what() const throw() { return m_message.c_str(); }
private:
  std::string m_message;
};

class CVeriNum {
  public:
    enum TBit { 
      _0 = 0x0,
      _1 = 0x1, 
      _X = 0x2,
      _Z = 0x3
    };
    class CBitArray {
      private:
        TUInt m_size;
        TUInt m_blockCount;
        TUInt *m_blocks;
      public:
        CBitArray() : m_size(0), m_blockCount(0), m_blocks(NULL) { }
        CBitArray(TUInt len) 
          : m_size(0), m_blockCount(0), m_blocks(NULL) { setSize(len); }
        CBitArray(const CBitArray& other) 
          : m_size(0), m_blockCount(0), m_blocks(NULL) { setSize(0); *this = other; }
        ~CBitArray() { delete[] m_blocks; }
        static const TUInt blockSize = sizeof(TUInt)*8;
        static const TUInt blockSizeDiv2=blockSize>>1;
        /** 
         * Computes the number of the block the bitIndex belongs to and its offset inside that block.
         * The size of the block is divided by two because 32 classic bits hold only 16 verilog bits.
         */
        static void bitPos(TUInt bitIndex, TUInt& blkNum, TUInt& blkOffset);
        /** Sets the minimum necessary length of the bit vector that holds the VeriNum.
         * For example, for A9BD the min necessary length is 4*8=32. 
         * The final width of the bit vector can be decided by the user(the sz param in the main constructor or the setWidth() function).
         * Let's suppose sz is set to 64.
         * The supplementary 64-32=32 most signifiant bits will be set to 0 (isSigned = false) or to 1 (isSigned = true)
         * The bit vector that holds a VeriNum is divided into several 32 bit blocks(that hold 16 verilog bits).
         * For our example:l=32, each of these 32 verilog bits requires 2 classic bits, therefore
         * we need 64 classic bits divided into two 34 bit blocks(m_blockCount = 2).
         */
        void setSize(TUInt size);
        TUInt getSize() const { return m_size; }
        /** 
         * This function sets a bit in the bit vector that holds the binary representation of the verilog number.
         * Take into account that a bit in verilog can have 4 values, not just 2: 0 1 X Z,
         * therefore we'll need 2 classic bits to represent a verilog bit. 
         * Look at the TBit enum: 0 is assigned the combination 00
         *                        1                             01
         *                        X                             10
         *                        Y                             11
         * That is why, although the size of a block is 32 bits (see blockSize function), one block can only hold 16 verilog bits.
         * Let's consider the following example: index = 17, b = 1
         * blkNum will be evaluated at 1 and blkOffset at 1 => I'm about to change bits 2 and 3 in block 1 into 01
         * Let's assume that this is how blocks 0 and 1 looked before the change:
         * 00000000 00000000 00000000 00000000 | 00000000 00000000 00000000 00000000             classic bits
         *             block 1            --   |          block 0
         *                           bits 32
         * 0 0 0 0  0 0 0 0  0 0 0 0  0 0 0 0  | 0 0 0 0  0 0 0 0  0 0 0 0  0 0 0 0              verilog bits                                                                              
         *                                |
         *                               bit 17    
         * Now let's trace (*1)(see cpp):
         * m_blocks[blkNum] is m_blocks[1] that is 00000000 00000000 00000000 00000000
         * 3 is 0011 ; shifted to the left with 2 positions: 1100
         * b is 1    ; shifted to the left with 2 positions: 0100
         * Now let's do the maths:
         * m_blocks[1] = 00000000 00000000 00000000 00000000 & ~( 00000000 00000000 00000000 00001100) | 00000000 00000000 00000000 00000100 
         * result        00000000 00000000 00000000 00000100    which is what we expected.
         * The non(3 shifted to the left) is a mask necessary to reset only the bits that are to be altered and preserve 
         * the rest of the bits.
         */
        void setBit(TUInt index, TBit bit);
        TBit getBit(TUInt index) const;
        std::ostream& dump(std::ostream& os) const;
        const CBitArray& operator=(const CBitArray& other);
        TBit operator[](TUInt index) const { 
          ASSERT(index < m_size, "Index out of range");
          return getBit(index); 
        }
        /**
         * Don't use this method unless you are sure what you are doing
         * This method returns a internal block representation
         * This method may only be used for optimized checks directly with
         * the internal representation of the bit array
         */
        TUInt getBlock(TUInt blockNumber) const {
          ASSERT(blockNumber<m_blockCount, "Block index out of range");
          return m_blocks[blockNumber];
        }
        /**
         * This method returns the number of blocks used to represent the bit array
         * This is an internal CBitArray value
         * Don't use this method unless you know what you are doing
         */
        TUInt getBlockCount() const {
          return m_blockCount;
        }
    };
  private:
    CBitArray m_bits;
    TBool m_isSigned;
  public:
    enum TBase { BIN, OCT, DEC, HEX };
    enum TPadType { PAD_SIGN, PAD_ZERO };
    /**
     * This constructor builds a string like verilog number
     * This means that this method saves the string value to a verinum
     * in a char like state. The width of the verinum will be 8*string_length
     * Example: string "AB" is converted to "0100000101000010"
     */
    CVeriNum(const std::string& str);
    /**
     * This constructor builds a verinum from an unsigned int, with a specified width
     */
    CVeriNum(TUInt val, TUInt size);
    /**
     * This contructor builds a verinum with a size equal to size and all the
     * bits set to the value of bit
     */
    CVeriNum(TBit bit, TUInt width = 1);
    /** 
     * This constructor is the start point for anyone who endeavours to understand the inner workings of VeriNum.
     * A verilog number is build from a string(str).
     * The string consists in several digits (without spaces or _ symbols inside).
     * The digits should be corresponding to the base specifier.
     * Example: "00110X" (binary), "023007" (octal), "01FZ" (hex),
     * "1234567890" (decimal)
     * If there is a Z or X digit inside a decimal string, a 32 bit number
     * will be constructed with all bits set to Z (or X).
     * Look over the cpp code and follow the numbered references to better understand this function's mechanism.
     * (*1) The local var size stores the number of bits necessary for the binary representation of the number. 
     *      00110X size = 6   023007 size = 6*3 = 18    01FZ size = 4*4 = 16    1234567890 size = 10*4 = 40
     *      (An octal digit requires 3 bits, a hexa digit requires 4 
     *      and we set 4 bits for a decimal digit, the extra bits will be set to 0.)
     * (*2) All the bits in the binary representation of the number are stored in a vector.
     *      If the value of str is A9DB, for example, the vector of bits will be 1010100111011011.
     *      This vector of bits has to be easily handled, so David put the actual vector(m_blocks), 
     *      toghether with the methods that have to do with its constuction , in a class called CBitArray, inside the CVeriNum class.
     *      This way he separated the methods used to build the bit array
     *      ( setting the vector's length, setting/returning the bit on a certain position, validating an index, etc
     *        meaning all the methods in CBitArray class) 
     *      from the ones that handle it once it has been completely constructed(hasSign, return as (unsigned)integer or string, etc
     *      meaning the rest of the methods in CVeriNum class).
     *      This separation is not always perfect though. This is what I think his intention was.
     *      m_bits is an instance of the CBitArray class and a private member of the CVeriNum class; the length of m_bits is set to size
     * (*3) In the next section the number is broken down into digits. Each digit is converted into a bit(for binary numbers) 
     *      or into three bits for octal numbers. The set function is a "cover-up" for the setBit function, so
     *      go to the comment for the setBit function to see how the bit vector is constructed.
     * (*4) When it comes to decimal numbers, it gets tricky. There is no direct, bit by bit conversion.
     *      Let's consider the decimal number 879. 3*4=12 bits are necessary for storing this number.
     *      First, a VeriNum is constructed using the last figure of the initial number:9 (check out the comment for that constructor) 
     *                                                                                        num = 1001 
     *      Then, another VeriNum is constructed holding the value 10, on 12 bits(size = 12)  ten = 0000 0000 1010
     *      The third VeriNum contains the position of the current figure inside the number, in this case 0.
     *      The fourth VeriNum holds the temporary result(9*pow(10,0))                       temp = 0000 0000 1010
     *      This is repeated for every digit(first 7 then 8), inside the for loop, 
     *      The temporary results are added to the final number, thus obtaining the desired binary representation.
     * (*5) For a hex number, each digit is equivaled to a four bit combination. 
     * (*6) If the verilog number passed to the constructor is , let's say, A98B, then the length of the
     *      bit vector is set to 32 (4*8). If the user wants to hold the number on 64 bits(sz = 32), then the most signifiant
     *      32 bits have to be set to 0 (if the number is unsigned) or to 1 (if the number is signed).
     *      That is the purpose of the setWidth function(see comment). The last two lines of code should look like this:
     *      if(sz)
     *       setWidth(sz);
     *      BogdanZ made the change because there are still bugs in the functions that setWidth calls.
     * WARNING: You must not invoke this constructor to with a desiredWidth equal to zero!!!
     *          ASSERT(desiredWidth) before invoking this constructor, the default zero is for autowidth, if you invoke the
     *          constructor with a desiredWidth equal to 0 the width WILL NOT BE ZERO!!!
     */
    CVeriNum(TBase base, const std::string& str, TBool sgnd, TUInt desiredWidth = 0);
  public:
    /**
     * This method transforms a TBit into a char value
     * This is usefull when printing the number
     */
    static TChar bitToChar(TBit bit);
    /**
     * This method builds a verinum with the value equal to zero
     */
    static CVeriNum zero(TUInt width, TBool sgn = FALSE);
    /**
     * This method builds a verinum with the value equal to one
     */
    static CVeriNum one(TUInt width, TBool sgn = FALSE);
    /**
     * This method builds a verinum with the value equal to minus one
     * The sign here is set to TRUE
     */
    static CVeriNum minusOne(TUInt width);
    /**
     * This method builds a verinum with all bits set to 'X'
     */
    static CVeriNum undef(TUInt width, TBool sgn = FALSE);

    /** 
     * This name is not well chosen. This function does not set the width,
     * it actually constructs the bit array filling in the supplementary positions
     * (sign extension rule).
     * Example: The verilog number is AB, it requires 8 verilog bits (16 clasic bits).
     *          m_block looks like this  10101011
     *           nr of bits              76543210
     *          Now, suppose I want to set the size to 16.
     *          For bits 0 through 7, safeGet() returns the actual value of the bit.
     *          For bits 8 through 15, safeGet() will return 0(assuming the number is unsigned).
     *          Before exiting this function, m_block will look like this:  0000000010101011
     * NOTE: The name of the method is very well chosen
     */
    void setWidth(TUInt width);

    TBool isConst() const { return true; }
    TUInt getWidth() const { return m_bits.getSize(); }
    TBit getBit(TUInt index) const { 
      ASSERT(index < m_bits.getSize(), "Index out of range");
      return m_bits.getBit(index); 
    }

    void setBit(TUInt index, TBit bit) { 
      ASSERT(index < m_bits.getSize(), "Index out of range");
      m_bits.setBit(index, bit); 
    }

    TBit operator[](TUInt index) const { 
      ASSERT(index < m_bits.getSize(), "Index out of range");
      return getBit(index); 
    }

    TBool isSigned() const { return m_isSigned; }
    /**
     * This method sets the signed flag
     */
    void setSigned(TBool signedValue) { m_isSigned = signedValue; }

    /**
     * This method returns FALSE if this number has a at least one X or Z
     */
    TBool isDefined() const;
    TBool isZero() const;
    TBool isNeg() const;
    TBool isEven() const;
    TBool isOne() const;
    TBool isTwo() const;
    TBool isMinusOne() const;
    // Set 4 bits starting from bitIndex
    void setByte(TUInt bitIndex, TChar ch);
    TChar getByte(TUInt bitIndex) const;
    TInt asInt() const;
    TUInt asUInt() const;
    std::string asString() const;
    TBit getMsb() const;
    // get a pad bit, which is a zero or a sign bit
    TBit getPadBit(TPadType pad = PAD_SIGN) const;
    // index may be out of bounds, in this case padBit is returned
    TBit safeGetBit(TUInt index, TPadType pad = PAD_SIGN) const;
    TBit getLogicalValue() const;
    void inc();
    void dec();
    std::ostream& dump(std::ostream& os) const;
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
CVeriNum shiftLeftArith(const CVeriNum& a, TUInt n); // arithmetic shift
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
void divide(const CVeriNum& a, const CVeriNum& b, CVeriNum& quotient, CVeriNum& remainder);
void signed_divide(const CVeriNum& a, const CVeriNum& b, CVeriNum& quotient, CVeriNum& remainder);

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
