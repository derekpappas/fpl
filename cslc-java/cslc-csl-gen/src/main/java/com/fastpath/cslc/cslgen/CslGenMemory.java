package com.fastpath.cslc.cslgen;

import java.util.Arrays;
import java.util.Objects;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLmemory} ({@code cslMemory.h} / {@code cslMemory.cpp}).
 */
public final class CslGenMemory extends CslGenCslBase {

    public static final int SET_DEPTH = 0;
    public static final int GET_DEPTH = 1;
    public static final int SET_WIDTH = 2;
    public static final int GET_WIDTH = 3;

    private final StringBuilder depth = new StringBuilder();
    private final StringBuilder width = new StringBuilder();
    private final int[] used = new int[CslGenMemoryTables.M_USED_VECTOR_SIZE];

    public CslGenMemory(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_MEMORY, parent, name);
        Arrays.fill(used, 0);
    }

    /** {@code m_used[slot]} ({@code CSLmemory}). */
    public int getMemoryUsedAt(int slot) {
        Objects.checkIndex(slot, used.length);
        return used[slot];
    }

    public void genSetDepth(RandomGenerator rng) {
        depth.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    public void genSetWidth(RandomGenerator rng) {
        width.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        genSetDepth(rng);
        genSetWidth(rng);
        used[SET_DEPTH] = 1;
        used[SET_WIDTH] = 1;
        return true;
    }

    /** Emits via {@link #print()} using the shared {@link CslGenCslBase#printSink()} for this thread. */
    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }

    @Override
    public void print() {
        StringBuilder mOut = printSink();
        if (mOut == null) {
            return;
        }
        CslGenSupportEmit.cslMemory(mOut);
        mOut.append(getName());
        CslGenSupportEmit.lCbrace(mOut);
        mOut.append("    ").append(getName());
        CslGenSupportEmit.lParenthesis(mOut);
        CslGenSupportEmit.rParenthesis(mOut);
        CslGenSupportEmit.lCbrace(mOut);
        for (int i = 0; i < CslGenMemoryTables.M_USED_VECTOR_SIZE; i++) {
            if (used[i] != 0) {
                switch (i) {
                    case SET_DEPTH -> CslGenSupportEmit.funct1param(mOut, CslGenMemoryTables.M_FUNCTION[i], depth.toString());
                    case GET_DEPTH -> CslGenSupportEmit.funct0param(mOut, CslGenMemoryTables.M_FUNCTION[i]);
                    case SET_WIDTH -> CslGenSupportEmit.funct1param(mOut, CslGenMemoryTables.M_FUNCTION[i], width.toString());
                    case GET_WIDTH -> CslGenSupportEmit.funct0param(mOut, CslGenMemoryTables.M_FUNCTION[i]);
                    default -> {
                        /* reserved */
                    }
                }
            }
        }
        mOut.append("  ");
        CslGenSupportEmit.rCbrace(mOut);
        CslGenSupportEmit.rCbrace(mOut);
        CslGenSupportEmit.semicolon(mOut);
    }

    /** {@code m_depth}. */
    public String getDepthText() {
        return depth.toString();
    }

    /** {@code m_width}. */
    public String getWidthText() {
        return width.toString();
    }
}
