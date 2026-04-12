package com.fastpath.cslc.cslgen;

/**
 * Numeric bit-range state matching legacy {@code CSLbitrange} fields ({@code cslInterconnectGen_TB.cpp}), shared by
 * {@link CslGenPort} / {@link CslGenSignal} embedded ranges and {@link CslGenBitrange}.
 */
public final class CslGenBitrangeState {

    private int lower;
    private int upper = 1;
    private int offset;
    private boolean widthIsSet;

    public int getLower() {
        return lower;
    }

    public int getUpper() {
        return upper;
    }

    public int getWidth() {
        return upper - lower;
    }

    public int getOffset() {
        return offset;
    }

    public boolean isWidthSet() {
        return widthIsSet;
    }

    public boolean setWidth(int width) {
        if (!widthIsSet && width > 0) {
            upper = lower + width;
            widthIsSet = true;
            return true;
        }
        return false;
    }

    public boolean setOffset(int off) {
        if (off >= 0) {
            lower += off;
            upper += off;
            offset = off;
            return true;
        }
        return false;
    }

    public boolean setRange(int lo, int up) {
        if (!widthIsSet && lo >= 0 && up > lo) {
            lower = lo;
            upper = up;
            widthIsSet = true;
            return true;
        }
        return false;
    }

    public void copyFrom(CslGenBitrangeState other) {
        this.lower = other.lower;
        this.upper = other.upper;
        this.offset = other.offset;
        this.widthIsSet = other.widthIsSet;
    }

}
