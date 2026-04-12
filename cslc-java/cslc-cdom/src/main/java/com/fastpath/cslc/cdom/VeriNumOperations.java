package com.fastpath.cslc.cdom;

/**
 * Free functions from {@code VeriNum.cpp} ({@code NSCdom} namespace).
 */
public final class VeriNumOperations {

    private VeriNumOperations() {}

    private static int max(int a, int b) {
        return Math.max(a, b);
    }

    public static boolean isDefined(VeriNum.TBit a) {
        return a == VeriNum.TBit._0 || a == VeriNum.TBit._1;
    }

    public static VeriNum.TBit or(VeriNum.TBit a, VeriNum.TBit b) {
        VeriNum.TBit[][] tbl = {
            {VeriNum.TBit._0, VeriNum.TBit._1, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._1, VeriNum.TBit._1, VeriNum.TBit._1, VeriNum.TBit._1},
            {VeriNum.TBit._X, VeriNum.TBit._1, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._X, VeriNum.TBit._1, VeriNum.TBit._X, VeriNum.TBit._X}
        };
        return tbl[a.ordinal()][b.ordinal()];
    }

    public static VeriNum.TBit and(VeriNum.TBit a, VeriNum.TBit b) {
        VeriNum.TBit[][] tbl = {
            {VeriNum.TBit._0, VeriNum.TBit._0, VeriNum.TBit._0, VeriNum.TBit._0},
            {VeriNum.TBit._0, VeriNum.TBit._1, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._0, VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._0, VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X}
        };
        return tbl[a.ordinal()][b.ordinal()];
    }

    public static VeriNum.TBit xor(VeriNum.TBit a, VeriNum.TBit b) {
        VeriNum.TBit[][] tbl = {
            {VeriNum.TBit._0, VeriNum.TBit._1, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._1, VeriNum.TBit._0, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X}
        };
        return tbl[a.ordinal()][b.ordinal()];
    }

    public static VeriNum.TBit neg(VeriNum.TBit a) {
        VeriNum.TBit[] tbl = {VeriNum.TBit._1, VeriNum.TBit._0, VeriNum.TBit._X, VeriNum.TBit._X};
        return tbl[a.ordinal()];
    }

    public static VeriNum.TBit combineBit(VeriNum.TBit a, VeriNum.TBit b) {
        VeriNum.TBit[][] tbl = {
            {VeriNum.TBit._0, VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._X, VeriNum.TBit._1, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X},
            {VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X, VeriNum.TBit._X}
        };
        return tbl[a.ordinal()][b.ordinal()];
    }

    public static VeriNum.TBit addBit(VeriNum.TBit a, VeriNum.TBit b, VeriNum.TBit[] carry) {
        if (!isDefined(a) || !isDefined(b) || !isDefined(carry[0])) {
            carry[0] = VeriNum.TBit._X;
            return VeriNum.TBit._X;
        }
        VeriNum.TBit tmp = carry[0];
        if (a == VeriNum.TBit._0 && b == VeriNum.TBit._0) {
            carry[0] = VeriNum.TBit._0;
            return tmp;
        }
        // Half-sum: sum = carry_in XOR (a XOR b); carry_out = (a & b) | ((a^b) & carry_in)
        if ((a == VeriNum.TBit._0 && b == VeriNum.TBit._1) || (a == VeriNum.TBit._1 && b == VeriNum.TBit._0)) {
            if (carry[0] == VeriNum.TBit._0) {
                return VeriNum.TBit._1;
            }
            // carry_in == 1: sum 0, carry_out 1 — legacy C++ leaves carry unchanged here
            return VeriNum.TBit._0;
        }
        carry[0] = VeriNum.TBit._1;
        return tmp;
    }

    public static void addInPlace(VeriNum a, VeriNum b) {
        VeriNum r = add(a, b);
        a.assignFrom(r);
    }

    public static VeriNum.TBit equal(VeriNum a, VeriNum b) {
        int maxLen = max(a.len(), b.len());
        for (int i = maxLen - 1; i >= 0; i--) {
            VeriNum.TBit aBit = a.safeGet(i);
            VeriNum.TBit bBit = b.safeGet(i);
            if (isDefined(aBit) && isDefined(bBit)) {
                if (aBit != bBit) {
                    return VeriNum.TBit._0;
                }
            } else {
                return VeriNum.TBit._X;
            }
        }
        return VeriNum.TBit._1;
    }

    public static VeriNum.TBit notEqual(VeriNum a, VeriNum b) {
        VeriNum.TBit r = equal(a, b);
        return switch (r) {
            case _0 -> VeriNum.TBit._1;
            case _1 -> VeriNum.TBit._0;
            default -> VeriNum.TBit._X;
        };
    }

    public static VeriNum.TBit caseEqual(VeriNum a, VeriNum b) {
        int maxLen = max(a.len(), b.len());
        for (int i = maxLen - 1; i >= 0; i--) {
            if (a.safeGet(i) != b.safeGet(i)) {
                return VeriNum.TBit._0;
            }
        }
        return VeriNum.TBit._1;
    }

    public static VeriNum.TBit caseNotEqual(VeriNum a, VeriNum b) {
        VeriNum.TBit r = caseEqual(a, b);
        return switch (r) {
            case _0 -> VeriNum.TBit._1;
            case _1 -> VeriNum.TBit._0;
            default -> VeriNum.TBit._X;
        };
    }

    public static VeriNum.TBit lessOrEqual(VeriNum a, VeriNum b) {
        return or(lessThan(a, b), equal(a, b));
    }

    public static VeriNum.TBit lessThan(VeriNum a, VeriNum b) {
        if (!a.isDefined() || !b.isDefined()) {
            return VeriNum.TBit._X;
        }
        if (a.isNeg() && (b.isZero() || !b.isNeg())) {
            return VeriNum.TBit._1;
        }
        if (b.isNeg() && (a.isZero() || !a.isNeg())) {
            return VeriNum.TBit._0;
        }
        int maxLen = max(a.len(), b.len());
        for (int i = maxLen - 1; i >= 0; i--) {
            VeriNum.TBit aBit = a.safeGet(i);
            VeriNum.TBit bBit = b.safeGet(i);
            if (aBit == VeriNum.TBit._0 && bBit == VeriNum.TBit._1) {
                return VeriNum.TBit._1;
            }
            if (aBit == VeriNum.TBit._1 && bBit == VeriNum.TBit._0) {
                return VeriNum.TBit._0;
            }
        }
        return VeriNum.TBit._0;
    }

    public static VeriNum.TBit greaterOrEqual(VeriNum a, VeriNum b) {
        return or(greaterThan(a, b), equal(a, b));
    }

    public static VeriNum.TBit greaterThan(VeriNum a, VeriNum b) {
        return lessThan(b, a);
    }

    public static VeriNum shiftLeft(VeriNum a, int n) {
        int len = a.len();
        VeriNum res = new VeriNum(VeriNum.TBit._0, len);
        res.setSign(a.hasSign());
        for (int i = 0; i < len; i++) {
            if (i + n < len) {
                res.set(i + n, a.get(i));
            }
        }
        return res;
    }

    public static VeriNum shiftRight(VeriNum a, int n) {
        int len = a.len();
        VeriNum res = new VeriNum(VeriNum.TBit._0, len);
        res.setSign(a.hasSign());
        for (int i = n; i < a.len(); i++) {
            res.set(i - n, a.get(i));
        }
        return res;
    }

    public static VeriNum shiftRightArith(VeriNum a, int n) {
        int len = a.len();
        VeriNum.TBit sgn = a.hasSign() ? a.msb() : VeriNum.TBit._0;
        VeriNum res = new VeriNum(sgn, len);
        res.setSign(a.hasSign());
        for (int i = n; i < a.len(); i++) {
            res.set(i - n, a.get(i));
        }
        return res;
    }

    public static VeriNum bitwiseAnd(VeriNum a, VeriNum b) {
        int maxLen = max(a.len(), b.len());
        VeriNum c = new VeriNum(VeriNum.TBit._X, maxLen);
        for (int i = 0; i < maxLen; i++) {
            c.set(i, and(a.safeGet(i), b.safeGet(i)));
        }
        return c;
    }

    public static VeriNum bitwiseNand(VeriNum a, VeriNum b) {
        return bitwiseNeg(bitwiseAnd(a, b));
    }

    public static VeriNum bitwiseOr(VeriNum a, VeriNum b) {
        int maxLen = max(a.len(), b.len());
        VeriNum c = new VeriNum(VeriNum.TBit._X, maxLen);
        for (int i = 0; i < maxLen; i++) {
            c.set(i, or(a.safeGet(i), b.safeGet(i)));
        }
        return c;
    }

    public static VeriNum bitwiseNor(VeriNum a, VeriNum b) {
        return bitwiseNeg(bitwiseOr(a, b));
    }

    public static VeriNum bitwiseXor(VeriNum a, VeriNum b) {
        int maxLen = max(a.len(), b.len());
        VeriNum c = new VeriNum(VeriNum.TBit._X, maxLen);
        for (int i = 0; i < maxLen; i++) {
            c.set(i, xor(a.safeGet(i), b.safeGet(i)));
        }
        return c;
    }

    public static VeriNum bitwiseNxor(VeriNum a, VeriNum b) {
        return bitwiseNeg(bitwiseXor(a, b));
    }

    public static VeriNum bitwiseNeg(VeriNum a) {
        VeriNum b = new VeriNum(VeriNum.TBit._X, a.len());
        for (int i = 0; i < a.len(); i++) {
            b.set(i, neg(a.get(i)));
        }
        return b;
    }

    public static VeriNum.TBit reductionAnd(VeriNum a) {
        VeriNum.TBit b = VeriNum.TBit._1;
        for (int i = 0; i < a.len(); i++) {
            b = and(b, a.get(i));
        }
        return b;
    }

    public static VeriNum.TBit reductionNand(VeriNum a) {
        return neg(reductionAnd(a));
    }

    public static VeriNum.TBit reductionOr(VeriNum a) {
        VeriNum.TBit b = VeriNum.TBit._0;
        for (int i = 0; i < a.len(); i++) {
            b = or(b, a.get(i));
        }
        return b;
    }

    public static VeriNum.TBit reductionNor(VeriNum a) {
        return neg(reductionOr(a));
    }

    public static VeriNum.TBit reductionXor(VeriNum a) {
        int c = 0;
        for (int i = 0; i < a.len(); i++) {
            VeriNum.TBit bit = a.get(i);
            if (!isDefined(bit)) {
                return VeriNum.TBit._X;
            }
            if (bit == VeriNum.TBit._1) {
                c++;
            }
        }
        return (c % 2) != 0 ? VeriNum.TBit._1 : VeriNum.TBit._0;
    }

    public static VeriNum.TBit reductionNxor(VeriNum a) {
        return neg(reductionXor(a));
    }

    public static VeriNum.TBit logicalAnd(VeriNum a, VeriNum b) {
        return and(a.logicVal(), b.logicVal());
    }

    public static VeriNum.TBit logicalOr(VeriNum a, VeriNum b) {
        return or(a.logicVal(), b.logicVal());
    }

    public static VeriNum.TBit logicalNeg(VeriNum a) {
        return neg(a.logicVal());
    }

    public static VeriNum combine(VeriNum a, VeriNum b) {
        VeriNum c = new VeriNum(VeriNum.TBit._X, max(a.len(), b.len()));
        for (int i = 0; i < c.len(); i++) {
            c.set(
                    i,
                    combineBit(
                            a.safeGet(i, VeriNum.TPadType.PAD_ZERO),
                            b.safeGet(i, VeriNum.TPadType.PAD_ZERO)));
        }
        return c;
    }

    public static VeriNum concat(VeriNum a, VeriNum b) {
        VeriNum c = new VeriNum(VeriNum.TBit._X, a.len() + b.len());
        int k = 0;
        for (int i = 0; i < b.len(); i++) {
            c.set(k++, b.get(i));
        }
        for (int i = 0; i < a.len(); i++) {
            c.set(k++, a.get(i));
        }
        return c;
    }

    public static VeriNum abs(VeriNum a) {
        if (a.isNeg()) {
            return twosComplement(a);
        }
        return a.copy();
    }

    public static VeriNum minus(VeriNum a) {
        return twosComplement(a);
    }

    public static VeriNum add(VeriNum a, VeriNum b) {
        int maxLen = max(a.len(), b.len());
        VeriNum c = new VeriNum(VeriNum.TBit._X, maxLen);
        c.setSign(a.hasSign() && b.hasSign());
        VeriNum.TBit[] carry = new VeriNum.TBit[] {VeriNum.TBit._0};
        for (int i = 0; i < maxLen; i++) {
            c.set(i, addBit(a.safeGet(i), b.safeGet(i), carry));
        }
        return c;
    }

    public static VeriNum twosComplement(VeriNum a) {
        VeriNum b = new VeriNum(VeriNum.TBit._X, a.len());
        for (int i = 0; i < a.len(); i++) {
            b.set(i, neg(a.get(i)));
        }
        VeriNum one = VeriNum.one(1, false);
        VeriNum c = add(b, one);
        c.setSign(a.hasSign());
        return c;
    }

    public static VeriNum sub(VeriNum a, VeriNum b) {
        return add(a, twosComplement(b));
    }

    public static VeriNum multiply(VeriNum a, VeriNum b) {
        int maxLen = max(a.len(), b.len());
        VeriNum c = new VeriNum(VeriNum.TBit._0, maxLen);
        c.setSign(a.hasSign() && b.hasSign());
        for (int i = 0; i < maxLen; i++) {
            switch (b.safeGet(i)) {
                case _0 -> {
                }
                case _1 -> c.assignFrom(add(c, shiftLeft(a, i)));
                case _X, _Z -> {
                    return new VeriNum(VeriNum.TBit._X, maxLen);
                }
            }
        }
        return c;
    }

    public static VeriNum div2(VeriNum a) {
        return shiftRightArith(a, 1);
    }

    public static VeriNum power(VeriNum a, VeriNum b) {
        int len = a.len();
        boolean sgn = a.hasSign();
        if (!a.isDefined() || !b.isDefined()) {
            return VeriNum.undef(len, sgn);
        }
        if (b.isZero()) {
            return VeriNum.one(len, sgn);
        }
        if (b.isNeg()) {
            if (a.isMinusOne()) {
                return b.isEven() ? VeriNum.one(len, sgn) : VeriNum.minusOne(len, true);
            }
            if (a.isNeg()) {
                return VeriNum.zero(len, sgn);
            }
            if (a.isZero()) {
                return VeriNum.undef(len, sgn);
            }
            if (a.isOne()) {
                return VeriNum.one(len, sgn);
            }
            return VeriNum.zero(len, sgn);
        }
        if (a.isMinusOne()) {
            return b.isEven() ? VeriNum.one(len, sgn) : VeriNum.minusOne(len, true);
        }
        if (a.isZero()) {
            return VeriNum.zero(len, sgn);
        }
        if (a.isOne()) {
            return VeriNum.one(len, sgn);
        }
        if (b.isOne()) {
            return a.copy();
        }
        if (b.isEven()) {
            VeriNum _a = multiply(a, a);
            VeriNum _b = div2(b);
            return power(_a, _b);
        }
        VeriNum _a = multiply(a, a);
        VeriNum _b = div2(sub(b, VeriNum.one(2, true)));
        return multiply(a, power(_a, _b));
    }

    public static VeriNum log2(VeriNum a) {
        if (!a.isDefined() || a.isNeg() || a.isZero()) {
            return VeriNum.undef(a.len(), a.hasSign());
        }
        VeriNum res = new VeriNum(VeriNum.TBit._0, a.len());
        VeriNum tmp = a.copy();
        while (!tmp.isZero() && !tmp.isOne()) {
            tmp = shiftRight(tmp, 1);
            res.inc();
        }
        return res;
    }

    public static void divide(VeriNum a, VeriNum b, VeriNum quotient, VeriNum remainder) {
        int len = max(a.len(), b.len());
        boolean sgn = a.hasSign() && b.hasSign();
        VeriNum dividend = a.copy();
        dividend.setWidth(len);
        VeriNum divisor = b.copy();
        divisor.setWidth(len);
        quotient.assignFrom(VeriNum.zero(len, sgn));
        remainder.assignFrom(VeriNum.zero(len, sgn));
        if (divisor.isZero() || !dividend.isDefined() || !divisor.isDefined()) {
            quotient.assignFrom(VeriNum.undef(len, sgn));
            remainder.assignFrom(VeriNum.undef(len, sgn));
            return;
        }
        if (lessThan(dividend, divisor) == VeriNum.TBit._1) {
            remainder.assignFrom(dividend);
            return;
        }
        if (equal(dividend, divisor) == VeriNum.TBit._1) {
            quotient.assignFrom(VeriNum.one(len, sgn));
            return;
        }
        int nbits = len;
        VeriNum.TBit bit;
        VeriNum.TBit q;
        VeriNum d = dividend.copy();
        VeriNum r = remainder.copy();
        while (lessThan(remainder, divisor) == VeriNum.TBit._1) {
            bit = dividend.msb();
            r = remainder.copy();
            remainder.assignFrom(shiftLeft(remainder, 1));
            remainder.set(0, or(remainder.get(0), bit));
            d = dividend.copy();
            dividend.assignFrom(shiftLeft(dividend, 1));
            nbits--;
        }
        dividend.assignFrom(d);
        remainder.assignFrom(r);
        nbits++;
        VeriNum t;
        for (int i = 0; i < nbits; i++) {
            bit = dividend.msb();
            remainder.assignFrom(shiftLeft(remainder, 1));
            remainder.set(0, or(remainder.get(0), bit));
            t = sub(remainder, divisor);
            q = neg(t.msb());
            dividend.assignFrom(shiftLeft(dividend, 1));
            quotient.assignFrom(shiftLeft(quotient, 1));
            quotient.set(0, or(quotient.get(0), q));
            if (q == VeriNum.TBit._1) {
                remainder.assignFrom(t);
            }
        }
    }

    public static void signedDivide(VeriNum a, VeriNum b, VeriNum quotient, VeriNum remainder) {
        VeriNum dividend = abs(a);
        VeriNum divisor = abs(b);
        int len = max(a.len(), b.len());
        boolean sgn = a.hasSign() && b.hasSign();
        VeriNum q = VeriNum.zero(len, sgn);
        VeriNum r = VeriNum.zero(len, sgn);
        divide(dividend, divisor, q, r);
        quotient.assignFrom(q);
        if (a.isNeg()) {
            remainder.assignFrom(minus(r));
            if (!b.isNeg() && !b.isZero()) {
                quotient.assignFrom(minus(q));
            }
        } else {
            remainder.assignFrom(r);
            if (b.isNeg()) {
                quotient.assignFrom(minus(q));
            }
        }
    }
}
