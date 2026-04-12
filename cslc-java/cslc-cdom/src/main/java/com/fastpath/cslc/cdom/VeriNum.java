package com.fastpath.cslc.cdom;

/**
 * Four-valued Verilog bit vector; port of {@code trunk/cslc/trunk/src/cdom/CVeriNum}.
 */
public final class VeriNum {

    public enum TBit {
        _0,
        _1,
        _X,
        _Z
    }

    public enum TBase {
        BIN,
        OCT,
        DEC,
        HEX
    }

    public enum TPadType {
        PAD_SIGN,
        PAD_ZERO
    }

    public static final class VeriNumException extends RuntimeException {
        public VeriNumException(String message) {
            super(message);
        }
    }

    static final class BitArray {
        private int length;
        private int blockCount;
        private int[] blocks;

        BitArray() {
            this(0);
        }

        BitArray(int len) {
            setLen(len);
        }

        static int blockCells() {
            return 16;
        }

        static void bitPos(int bitIndex, int[] outBlkNum, int[] outBlkOffset) {
            int cells = blockCells();
            outBlkNum[0] = bitIndex / cells;
            outBlkOffset[0] = bitIndex % cells;
        }

        void validateIndex(int index) {
            if (index < 0 || index >= length) {
                throw new VeriNumException("CVeriNum::CBitArray - Index out of range");
            }
        }

        void setLen(int l) {
            blocks = null;
            blockCount = 0;
            length = 0;
            if (l > 0) {
                blockCount = ((l - 1) / blockCells()) + 1;
                blocks = new int[blockCount];
                length = l;
            }
        }

        int len() {
            return length;
        }

        void setBit(int index, TBit b) {
            validateIndex(index);
            int[] bn = new int[1];
            int[] bo = new int[1];
            bitPos(index, bn, bo);
            int mask = ~(3 << (bo[0] * 2));
            blocks[bn[0]] = (blocks[bn[0]] & mask) | (b.ordinal() << (bo[0] * 2));
        }

        TBit bit(int index) {
            validateIndex(index);
            int[] bn = new int[1];
            int[] bo = new int[1];
            bitPos(index, bn, bo);
            return TBit.values()[(blocks[bn[0]] >> (bo[0] * 2)) & 3];
        }

        void assign(BitArray other) {
            setLen(other.len());
            if (blockCount > 0 && other.blocks != null) {
                System.arraycopy(other.blocks, 0, blocks, 0, blockCount);
            }
        }

        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder("CBitArray [length: ").append(length).append(", blocks: ").append(blockCount).append("]: ");
            for (int i = 0; i < length; i++) {
                sb.append(bitToChar(bit(length - i - 1)));
            }
            return sb.toString();
        }
    }

    private BitArray bits = new BitArray();
    private boolean hasSign;

    public VeriNum() {
        this.hasSign = false;
    }

    public VeriNum(String str) {
        this.hasSign = false;
        int nbits = str.length() * 8;
        if (nbits == 0) {
            bits.setLen(8);
            setOctet(0, '\0');
        } else {
            bits.setLen(nbits);
            int strLen = str.length();
            for (int i = 0; i < strLen; i++) {
                setOctet(i * 8, str.charAt(strLen - i - 1));
            }
        }
    }

    public VeriNum(int val, int nbits) {
        this.hasSign = false;
        bits.setLen(nbits);
        long v = Integer.toUnsignedLong(val);
        for (int i = 0; i < bits.len(); i++, v >>>= 1) {
            bits.setBit(i, (v & 1) != 0 ? TBit._1 : TBit._0);
        }
    }

    public VeriNum(TBit b, int nbits) {
        this.hasSign = false;
        bits.setLen(nbits);
        for (int i = 0; i < bits.len(); i++) {
            bits.setBit(i, b);
        }
    }

    public VeriNum(TBase base, String str, boolean isSigned, int sz) {
        this.hasSign = isSigned;
        int strLen = str.length();
        int allocSize =
                switch (base) {
                    case BIN -> strLen;
                    case OCT -> strLen * 3;
                    case DEC -> strLen * 4;
                    case HEX -> strLen * 4;
                };
        bits.setLen(allocSize);
        int bi = 0;
        for (int i = strLen - 1; i >= 0; i--) {
            switch (base) {
                case BIN -> bi = appendBin(bi, str.charAt(i));
                case OCT -> bi = appendOct(bi, str.charAt(i));
                case DEC -> appendDec(str, strLen, i, allocSize);
                case HEX -> bi = appendHex(bi, str.charAt(i));
            }
        }
        if (sz != 0) {
            setWidth(sz);
        }
    }

    private int appendBin(int bi, char ch) {
        switch (ch) {
            case '0' -> set(bi++, TBit._0);
            case '1' -> set(bi++, TBit._1);
            case 'Z', 'z' -> set(bi++, TBit._Z);
            default -> set(bi++, TBit._X);
        }
        return bi;
    }

    private int appendOct(int bi, char ch) {
        TBit b1;
        TBit b2;
        TBit b3;
        switch (ch) {
            case '0' -> {
                b1 = TBit._0;
                b2 = TBit._0;
                b3 = TBit._0;
            }
            case '1' -> {
                b1 = TBit._0;
                b2 = TBit._0;
                b3 = TBit._1;
            }
            case '2' -> {
                b1 = TBit._0;
                b2 = TBit._1;
                b3 = TBit._0;
            }
            case '3' -> {
                b1 = TBit._0;
                b2 = TBit._1;
                b3 = TBit._1;
            }
            case '4' -> {
                b1 = TBit._1;
                b2 = TBit._0;
                b3 = TBit._0;
            }
            case '5' -> {
                b1 = TBit._1;
                b2 = TBit._0;
                b3 = TBit._1;
            }
            case '6' -> {
                b1 = TBit._1;
                b2 = TBit._1;
                b3 = TBit._0;
            }
            case '7' -> {
                b1 = TBit._1;
                b2 = TBit._1;
                b3 = TBit._1;
            }
            case 'Z', 'z' -> {
                b1 = TBit._Z;
                b2 = TBit._Z;
                b3 = TBit._Z;
            }
            default -> {
                b1 = TBit._X;
                b2 = TBit._X;
                b3 = TBit._X;
            }
        }
        set(bi++, b1);
        set(bi++, b2);
        set(bi++, b3);
        return bi;
    }

    private int appendHex(int bi, char ch) {
        TBit b1;
        TBit b2;
        TBit b3;
        TBit b4;
        switch (ch) {
            case '0' -> {
                b1 = TBit._0;
                b2 = TBit._0;
                b3 = TBit._0;
                b4 = TBit._0;
            }
            case '1' -> {
                b1 = TBit._0;
                b2 = TBit._0;
                b3 = TBit._0;
                b4 = TBit._1;
            }
            case '2' -> {
                b1 = TBit._0;
                b2 = TBit._0;
                b3 = TBit._1;
                b4 = TBit._0;
            }
            case '3' -> {
                b1 = TBit._0;
                b2 = TBit._0;
                b3 = TBit._1;
                b4 = TBit._1;
            }
            case '4' -> {
                b1 = TBit._0;
                b2 = TBit._1;
                b3 = TBit._0;
                b4 = TBit._0;
            }
            case '5' -> {
                b1 = TBit._0;
                b2 = TBit._1;
                b3 = TBit._0;
                b4 = TBit._1;
            }
            case '6' -> {
                b1 = TBit._0;
                b2 = TBit._1;
                b3 = TBit._1;
                b4 = TBit._0;
            }
            case '7' -> {
                b1 = TBit._0;
                b2 = TBit._1;
                b3 = TBit._1;
                b4 = TBit._1;
            }
            case '8' -> {
                b1 = TBit._1;
                b2 = TBit._0;
                b3 = TBit._0;
                b4 = TBit._0;
            }
            case '9' -> {
                b1 = TBit._1;
                b2 = TBit._0;
                b3 = TBit._0;
                b4 = TBit._1;
            }
            case 'A', 'a' -> {
                b1 = TBit._1;
                b2 = TBit._0;
                b3 = TBit._1;
                b4 = TBit._0;
            }
            case 'B', 'b' -> {
                b1 = TBit._1;
                b2 = TBit._0;
                b3 = TBit._1;
                b4 = TBit._1;
            }
            case 'C', 'c' -> {
                b1 = TBit._1;
                b2 = TBit._1;
                b3 = TBit._0;
                b4 = TBit._0;
            }
            case 'D', 'd' -> {
                b1 = TBit._1;
                b2 = TBit._1;
                b3 = TBit._0;
                b4 = TBit._1;
            }
            case 'E', 'e' -> {
                b1 = TBit._1;
                b2 = TBit._1;
                b3 = TBit._1;
                b4 = TBit._0;
            }
            case 'F', 'f' -> {
                b1 = TBit._1;
                b2 = TBit._1;
                b3 = TBit._1;
                b4 = TBit._1;
            }
            case 'Z', 'z' -> {
                b1 = TBit._Z;
                b2 = TBit._Z;
                b3 = TBit._Z;
                b4 = TBit._Z;
            }
            default -> {
                b1 = TBit._X;
                b2 = TBit._X;
                b3 = TBit._X;
                b4 = TBit._X;
            }
        }
        set(bi++, b1);
        set(bi++, b2);
        set(bi++, b3);
        set(bi++, b4);
        return bi;
    }

    private void appendDec(String str, int strLen, int i, int allocSize) {
        char ch = str.charAt(i);
        if (ch >= '0' && ch <= '9') {
            int d = ch - '0';
            VeriNum num = new VeriNum(d, 4);
            VeriNum ten = new VeriNum(10, allocSize);
            VeriNum pos = new VeriNum(strLen - i - 1, 32);
            VeriNum tmp = VeriNumOperations.multiply(VeriNumOperations.power(ten, pos), num);
            if (hasSign()) {
                tmp.setSign(true);
            }
            VeriNumOperations.addInPlace(this, tmp);
        } else if (ch == 'z' || ch == 'Z') {
            replaceWith(new VeriNum(TBit._Z, 32));
        } else {
            replaceWith(new VeriNum(TBit._X, 32));
        }
    }

    private void replaceWith(VeriNum o) {
        this.bits.assign(o.bits);
        this.hasSign = o.hasSign;
    }

    public static char bitToChar(TBit b) {
        return switch (b) {
            case _0 -> '0';
            case _1 -> '1';
            case _X -> 'X';
            case _Z -> 'Z';
        };
    }

    public static VeriNum zero(int len, boolean sgn) {
        VeriNum res = new VeriNum(TBit._0, len);
        res.setSign(sgn);
        return res;
    }

    public static VeriNum one(int len, boolean sgn) {
        VeriNum res = new VeriNum(TBit._0, len);
        res.setSign(sgn);
        if (len > 0) {
            res.set(0, TBit._1);
        }
        return res;
    }

    public static VeriNum minusOne(int len, boolean sgn) {
        VeriNum res = new VeriNum(TBit._1, len);
        res.setSign(sgn);
        return res;
    }

    public static VeriNum undef(int len, boolean sgn) {
        VeriNum res = new VeriNum(TBit._X, len);
        res.setSign(sgn);
        return res;
    }

    public void setWidth(int width) {
        if (width == len()) {
            return;
        }
        VeriNum tmp = new VeriNum(TBit._X, width);
        tmp.setSign(hasSign());
        for (int i = 0; i < width; i++) {
            tmp.set(i, safeGet(i));
        }
        this.bits.assign(tmp.bits);
        this.hasSign = tmp.hasSign;
    }

    public boolean isDefined() {
        for (int i = 0; i < bits.len(); i++) {
            TBit b = bits.bit(i);
            if (b == TBit._X || b == TBit._Z) {
                return false;
            }
        }
        return true;
    }

    public boolean isZero() {
        for (int i = 0; i < bits.len(); i++) {
            if (bits.bit(i) != TBit._0) {
                return false;
            }
        }
        return true;
    }

    public boolean isNeg() {
        return hasSign && msb() == TBit._1;
    }

    public boolean isEven() {
        if (len() > 0) {
            return get(0) == TBit._0;
        }
        return true;
    }

    public boolean isOne() {
        if (len() == 0 || isNeg()) {
            return false;
        }
        if (get(0) != TBit._1) {
            return false;
        }
        for (int i = 1; i < len(); i++) {
            if (get(i) != TBit._0) {
                return false;
            }
        }
        return true;
    }

    public boolean isTwo() {
        if (len() < 2 || isNeg()) {
            return false;
        }
        if (get(0) != TBit._0 || get(1) != TBit._1) {
            return false;
        }
        for (int i = 2; i < len(); i++) {
            if (get(i) != TBit._0) {
                return false;
            }
        }
        return true;
    }

    public boolean isMinusOne() {
        if (!hasSign) {
            return false;
        }
        for (int i = 0; i < len(); i++) {
            if (get(i) != TBit._1) {
                return false;
            }
        }
        return true;
    }

    public void setOctet(int bitIndex, char ch) {
        for (int i = 0; i < 8; i++) {
            bits.setBit(bitIndex + i, (ch & (1 << i)) != 0 ? TBit._1 : TBit._0);
        }
    }

    public char getOctet(int bitIndex) {
        char c = 0;
        for (int i = bitIndex; i < bitIndex + 8; i++) {
            c |= (char) ((get(i) == TBit._1 ? 1 : 0) << (i - bitIndex));
        }
        return c;
    }

    public int asInt() {
        int l = len();
        if (l == 0 || !isDefined()) {
            return 0;
        }
        if (hasSign && get(l - 1) == TBit._1) {
            int sz = 32;
            if (l > sz) {
                l = sz;
            }
            int res = -1;
            int mask = ~1;
            for (int i = 0; i < l; i++, mask = (mask << 1) | 1) {
                if (get(i) == TBit._0) {
                    res &= mask;
                }
            }
            return res;
        }
        return (int) asUInt();
    }

    public long asUInt() {
        if (len() == 0 || !isDefined()) {
            return 0;
        }
        long res = 0;
        int l = len();
        int sz = 32;
        if (l > sz) {
            l = sz;
        }
        for (int i = 0; i < l; i++) {
            res |= ((long) (get(i) == TBit._1 ? 1 : 0)) << i;
        }
        return Integer.toUnsignedLong((int) res);
    }

    public String asString() {
        int length = len();
        if (length % 8 != 0) {
            throw new VeriNumException("Can't convert number to string: length % 8 != 0");
        }
        int strLen = length / 8;
        char[] s = new char[strLen];
        for (int i = 0; i < strLen; i++) {
            s[i] = getOctet((strLen - i - 1) * 8);
        }
        return new String(s);
    }

    public TBit msb() {
        int l = len();
        if (l > 0) {
            return get(l - 1);
        }
        return TBit._0;
    }

    public TBit padBit(TPadType pad) {
        if (pad == TPadType.PAD_ZERO) {
            return TBit._0;
        }
        TBit b = msb();
        if (b == TBit._1 && !hasSign) {
            return TBit._0;
        }
        return b;
    }

    public TBit safeGet(int index) {
        return safeGet(index, TPadType.PAD_SIGN);
    }

    public TBit safeGet(int index, TPadType pad) {
        if (index >= 0 && index < len()) {
            return get(index);
        }
        return padBit(pad);
    }

    public TBit logicVal() {
        for (int i = 0; i < len(); i++) {
            switch (get(i)) {
                case _0 -> {
                }
                case _1 -> {
                    return TBit._1;
                }
                case _X, _Z -> {
                    return TBit._X;
                }
            }
        }
        return TBit._0;
    }

    public void inc() {
        VeriNum r = VeriNumOperations.add(this, one(2, true));
        this.bits.assign(r.bits);
        this.hasSign = r.hasSign;
    }

    public void dec() {
        VeriNum r = VeriNumOperations.sub(this, one(2, true));
        this.bits.assign(r.bits);
        this.hasSign = r.hasSign;
    }

    public boolean hasSign() {
        return hasSign;
    }

    public void setSign(boolean signFlag) {
        this.hasSign = signFlag;
    }

    public int len() {
        return bits.len();
    }

    public TBit get(int index) {
        return bits.bit(index);
    }

    public void set(int index, TBit bit) {
        bits.setBit(index, bit);
    }

    @Override
    public String toString() {
        return "CVeriNum [hasSign: " + hasSign + "] " + bits;
    }

    public VeriNum copy() {
        VeriNum v = new VeriNum();
        v.bits = new BitArray();
        v.bits.assign(bits);
        v.hasSign = hasSign;
        return v;
    }

    public void assignFrom(VeriNum o) {
        this.bits.assign(o.bits);
        this.hasSign = o.hasSign;
    }
}
