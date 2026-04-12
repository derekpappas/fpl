package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLbitrange} ({@code cslInterconnectGen_TB.h} / {@code cslInterconnectGen_TB.cpp}).
 */
public final class CslGenBitrange extends CslGenCslBase {

    public static final int BITR_DECL_WIDTH = 0;
    public static final int BITR_DECL_LOWER_UPPER = 1;
    public static final int BITR_DECL_MAX = 2;

    private final CslGenBitrangeState state = new CslGenBitrangeState();
    private int declForm = BITR_DECL_WIDTH;

    public CslGenBitrange(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_BITRANGE, parent, name);
    }

    void copyInto(CslGenBitrangeState target) {
        target.copyFrom(state);
    }

    /** Legacy {@code CSLbitrange::copyBitrange} ({@code cslInterconnectGen_TB.cpp}). */
    public void copyBitrange(CslGenBitrange br) {
        state.copyFrom(br.state);
    }

    public int getLower() {
        return state.getLower();
    }

    public int getUpper() {
        return state.getUpper();
    }

    public int getWidth() {
        return state.getWidth();
    }

    public int getOffset() {
        return state.getOffset();
    }

    public boolean isWidthSet() {
        return state.isWidthSet();
    }

    public boolean setWidth(int width) {
        return state.setWidth(width);
    }

    public boolean setOffset(int offset) {
        return state.setOffset(offset);
    }

    public boolean setRange(int lower, int upper) {
        return state.setRange(lower, upper);
    }

    /** {@code m_declForm} ({@code ECSLbitrDecl}). */
    public int getDeclForm() {
        return declForm;
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        declForm = rng.nextInt(BITR_DECL_MAX);
        if (declForm == BITR_DECL_WIDTH) {
            setWidth(rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH - 1) + 1);
            return true;
        }
        if (declForm == BITR_DECL_LOWER_UPPER) {
            int low = rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH / 2);
            int up = low + rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH / 2) + 1;
            setRange(low, up);
            return true;
        }
        return false;
    }

    /** Legacy {@code CSLbitrange::buildSet} ({@code cslInterconnectGen_TB.cpp}). */
    public void buildSet(String scope, RandomGenerator rng) {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        int form = rng.nextInt(CslGenInterconnectConsts.BITR_MODIF_MAX);
        if (form == CslGenInterconnectConsts.BITR_MODIF_OFFSET) {
            int offset = rng.nextInt(CslGenInterconnectConsts.MAX_OFFSET);
            if (setOffset(offset)) {
                CslGenSupportEmit.call1param(out, scope, getName(), "set_offset", CslGenInt.intToString(getOffset()));
            }
        }
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }

    @Override
    public void print() {
        StringBuilder mOut = printSink();
        if (mOut == null) {
            return;
        }
        if (declForm == BITR_DECL_WIDTH) {
            CslGenSupportEmit.decl1param(mOut, "csl_bitrange", getName(), CslGenInt.intToString(getWidth()));
        } else if (declForm == BITR_DECL_LOWER_UPPER) {
            CslGenSupportEmit.decl2param(
                    mOut, "csl_bitrange", getName(), CslGenInt.intToString(getLower()), CslGenInt.intToString(getUpper()));
        }
    }
}
