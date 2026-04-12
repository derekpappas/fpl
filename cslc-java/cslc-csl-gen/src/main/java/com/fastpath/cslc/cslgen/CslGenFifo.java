package com.fastpath.cslc.cslgen;

import java.util.Arrays;
import java.util.Objects;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLfifo} ({@code cGenFifo_ao.h} / {@code cGenFifo_ao.cpp}).
 */
public final class CslGenFifo extends CslGenCslBase {

    public static final int SET_DEPTH = 0;
    public static final int SET_WIDTH = 1;
    public static final int DEFAULT_DEPTH = 2;
    public static final int PH_IMPL = 3;
    public static final int PRIORITY_BYPASS = 4;
    public static final int SYNCR = 5;
    public static final int NUM_EXPR_DEPTH_EXT = 6;
    public static final int NUM_EXPR_WIDTH_EXT = 7;
    public static final int NUM_EXPR_WR_HOLD = 8;
    public static final int PREFIX = 9;
    public static final int PARALLEL_OUTPUT = 10;
    public static final int PARALLEL_INPUT = 11;
    public static final int RD_WORDS = 12;
    public static final int WR_WORDS = 13;
    public static final int PUSH_BACK = 14;
    public static final int FLOW_THROUGH = 15;
    public static final int STALL = 16;
    public static final int STALL_RD_SIDE = 17;
    public static final int STALL_WR_SIDE = 18;
    public static final int WR_RELEASE = 19;
    public static final int EMPTY_ADDRESS = 20;
    public static final int FULL_ADDRESS = 21;
    public static final int OUTPUT_WR_ADDR = 22;
    public static final int OUTPUT_RD_ADDR = 23;
    public static final int CREDIT = 24;
    public static final int RD_CREDIT = 25;
    public static final int WR_CREDIT = 26;
    public static final int FLOW = 27;

    private final StringBuilder depth = new StringBuilder();
    private final StringBuilder width = new StringBuilder();
    private final StringBuilder phImpl = new StringBuilder();
    private final StringBuilder prefix = new StringBuilder();
    private final StringBuilder defaultDepth = new StringBuilder();
    private final StringBuilder sync = new StringBuilder();
    private final StringBuilder numExprDepthExt = new StringBuilder();
    private final StringBuilder numExprWidthExt = new StringBuilder();
    private final StringBuilder numExprWrHold = new StringBuilder();
    private final StringBuilder rdWordsAddr = new StringBuilder();
    private final StringBuilder wrWordsAddr = new StringBuilder();
    private final StringBuilder flowNumExpr = new StringBuilder();
    private final StringBuilder emptyAddress = new StringBuilder();
    private final StringBuilder fullAddress = new StringBuilder();

    private final int[] used = new int[CslGenFifoTables.FIFO_USED_VECTOR_SIZE];

    public CslGenFifo(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_FIFO, parent, name);
        Arrays.fill(used, 0);
    }

    public void genSetDepth(RandomGenerator rng) {
        depth.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    public void genSetWidth(RandomGenerator rng) {
        width.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicProgrDepth(RandomGenerator rng) {
        defaultDepth.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSetPhysicalImplementation(RandomGenerator rng) {
        phImpl.append(CslGenFifoTables.FIFO_IMP_TYPE[rng.nextInt(2)]);
    }

    private void genSetPrefix(RandomGenerator rng) {
        prefix.append('"').append(CslGenRandString.randString(rng)).append('"');
    }

    private void genAddLogicSync(RandomGenerator rng) {
        sync.append(CslGenFifoTables.SYNC[rng.nextInt(2)]);
    }

    private void genAddLogicDepthExtend(RandomGenerator rng) {
        numExprDepthExt.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicWidthExtend(RandomGenerator rng) {
        numExprWidthExt.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicWrHold(RandomGenerator rng) {
        numExprWrHold.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicWrWords(RandomGenerator rng) {
        wrWordsAddr.append(CslGenNumExprSupport.randNumExpr(rng));
        wrWordsAddr.append(", ");
        wrWordsAddr.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicRdWords(RandomGenerator rng) {
        rdWordsAddr.append(CslGenNumExprSupport.randNumExpr(rng));
        rdWordsAddr.append(", ");
        rdWordsAddr.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicFlowThrough(RandomGenerator rng) {
        flowNumExpr.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicEmptyAddress(RandomGenerator rng) {
        emptyAddress.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicFullAddress(RandomGenerator rng) {
        fullAddress.append(CslGenNumExprSupport.randNumExpr(rng));
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
        for (int i = 0; i < rng.nextInt(10); i++) {
            int ran = rng.nextInt(CslGenFifoTables.FIFO_USED_VECTOR_SIZE);
            if (used[ran] != 0) {
                continue;
            }
            switch (ran) {
                case DEFAULT_DEPTH -> genAddLogicProgrDepth(rng);
                case PH_IMPL -> genSetPhysicalImplementation(rng);
                case SYNCR -> genAddLogicSync(rng);
                case NUM_EXPR_DEPTH_EXT -> genAddLogicDepthExtend(rng);
                case NUM_EXPR_WIDTH_EXT -> genAddLogicWidthExtend(rng);
                case NUM_EXPR_WR_HOLD -> genAddLogicWrHold(rng);
                case PREFIX -> genSetPrefix(rng);
                case RD_WORDS -> genAddLogicRdWords(rng);
                case WR_WORDS -> genAddLogicWrWords(rng);
                case FLOW_THROUGH -> genAddLogicFlowThrough(rng);
                case EMPTY_ADDRESS -> genAddLogicEmptyAddress(rng);
                case FULL_ADDRESS -> genAddLogicFullAddress(rng);
                default -> {
                    /* legacy switch has no case; slot may still be marked used */
                }
            }
            used[ran] = 1;
        }
        return true;
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
        CslGenSupportEmit.cslFifo(mOut);
        mOut.append(getName());
        CslGenSupportEmit.lCbrace(mOut);
        mOut.append("   ").append(getName());
        CslGenSupportEmit.lParenthesis(mOut);
        CslGenSupportEmit.rParenthesis(mOut);
        CslGenSupportEmit.lCbrace(mOut);
        for (int i = 0; i < CslGenFifoTables.FIFO_USED_VECTOR_SIZE; i++) {
            if (used[i] == 0) {
                continue;
            }
            String fn = CslGenFifoTables.FIFO_FUNCTION[i];
            switch (i) {
                case SET_DEPTH -> CslGenSupportEmit.funct1param(mOut, fn, depth.toString());
                case SET_WIDTH -> CslGenSupportEmit.funct1param(mOut, fn, width.toString());
                case DEFAULT_DEPTH -> CslGenSupportEmit.funct2param(mOut, fn, "programmable_depth", defaultDepth.toString());
                case PH_IMPL -> CslGenSupportEmit.funct1param(mOut, fn, phImpl.toString());
                case PRIORITY_BYPASS -> CslGenSupportEmit.funct1param(mOut, fn, "priority_bypass");
                case SYNCR -> CslGenSupportEmit.funct1param(mOut, fn, sync.toString());
                case NUM_EXPR_DEPTH_EXT -> CslGenSupportEmit.funct2param(mOut, fn, "depth_extend", numExprDepthExt.toString());
                case NUM_EXPR_WIDTH_EXT -> CslGenSupportEmit.funct2param(mOut, fn, "width_extend", numExprWidthExt.toString());
                case NUM_EXPR_WR_HOLD -> CslGenSupportEmit.funct2param(mOut, fn, "wr_hold", numExprWrHold.toString());
                case PREFIX -> CslGenSupportEmit.funct1param(mOut, fn, prefix.toString());
                case PARALLEL_OUTPUT -> CslGenSupportEmit.funct2param(mOut, fn, "parallel_output", "all");
                case PARALLEL_INPUT -> CslGenSupportEmit.funct2param(mOut, fn, "parallel_input", "all");
                case RD_WORDS -> CslGenSupportEmit.funct2param(mOut, fn, "rd_words", rdWordsAddr.toString());
                case WR_WORDS -> CslGenSupportEmit.funct2param(mOut, fn, "wr_words", wrWordsAddr.toString());
                case PUSH_BACK -> CslGenSupportEmit.funct1param(mOut, fn, "pushback");
                case FLOW_THROUGH -> CslGenSupportEmit.funct2param(mOut, fn, "flow_through", flowNumExpr.toString());
                case STALL -> CslGenSupportEmit.funct1param(mOut, fn, "stall");
                case STALL_RD_SIDE -> CslGenSupportEmit.funct1param(mOut, fn, "stall_rd_side");
                case STALL_WR_SIDE -> CslGenSupportEmit.funct1param(mOut, fn, "stall_wr_side");
                case WR_RELEASE -> CslGenSupportEmit.funct1param(mOut, fn, "wr_release");
                case EMPTY_ADDRESS -> CslGenSupportEmit.funct2param(mOut, fn, "almost_empty", emptyAddress.toString());
                case FULL_ADDRESS -> CslGenSupportEmit.funct2param(mOut, fn, "almost_full", fullAddress.toString());
                case OUTPUT_WR_ADDR -> CslGenSupportEmit.funct1param(mOut, fn, "output_wr_addr");
                case OUTPUT_RD_ADDR -> CslGenSupportEmit.funct1param(mOut, fn, "output_rd_addr");
                case CREDIT -> CslGenSupportEmit.funct1param(mOut, fn, "credit");
                case RD_CREDIT -> CslGenSupportEmit.funct1param(mOut, fn, "rd_credit");
                case WR_CREDIT -> CslGenSupportEmit.funct1param(mOut, fn, "wr_credit");
                case FLOW -> CslGenSupportEmit.funct1param(mOut, fn, "flow");
                default -> {
                    /* reserved */
                }
            }
        }
        mOut.append("  ");
        CslGenSupportEmit.rCbrace(mOut);
        CslGenSupportEmit.rCbrace(mOut);
        CslGenSupportEmit.semicolon(mOut);
    }

    /** Legacy public {@code CSLfifo::m_depth} ({@code cGenFifo_ao.h}). */
    public String getDepthText() {
        return depth.toString();
    }

    /** Legacy public {@code CSLfifo::m_width} ({@code cGenFifo_ao.h}). */
    public String getWidthText() {
        return width.toString();
    }

    /** Legacy public {@code CSLfifo::m_phImpl}. */
    public String getPhImplText() {
        return phImpl.toString();
    }

    /** Legacy public {@code CSLfifo::m_prefix}. */
    public String getPrefixText() {
        return prefix.toString();
    }

    /** Legacy public {@code CSLfifo::m_defaultDepth}. */
    public String getDefaultDepthText() {
        return defaultDepth.toString();
    }

    /** Legacy public {@code CSLfifo::m_sync}. */
    public String getSyncText() {
        return sync.toString();
    }

    /** Legacy public {@code CSLfifo::m_numExprDepthExt}. */
    public String getNumExprDepthExtText() {
        return numExprDepthExt.toString();
    }

    /** Legacy public {@code CSLfifo::m_numExprWidthExt}. */
    public String getNumExprWidthExtText() {
        return numExprWidthExt.toString();
    }

    /** Legacy public {@code CSLfifo::m_numExprWrHold}. */
    public String getNumExprWrHoldText() {
        return numExprWrHold.toString();
    }

    /** Legacy public {@code CSLfifo::m_rdWordsAddr}. */
    public String getRdWordsAddrText() {
        return rdWordsAddr.toString();
    }

    /** Legacy public {@code CSLfifo::m_wrWordsAddr}. */
    public String getWrWordsAddrText() {
        return wrWordsAddr.toString();
    }

    /** Legacy public {@code CSLfifo::m_flowNumExpr}. */
    public String getFlowNumExprText() {
        return flowNumExpr.toString();
    }

    /** Legacy public {@code CSLfifo::m_emptyAddress}. */
    public String getEmptyAddressText() {
        return emptyAddress.toString();
    }

    /** Legacy public {@code CSLfifo::m_fullAddress}. */
    public String getFullAddressText() {
        return fullAddress.toString();
    }

    /**
     * Legacy public {@code CSLfifo::used[slot]} ({@code cGenFifo_ao.h}): {@code 0} or {@code 1} when the generator
     * marked that {@code add_logic} / option slot.
     */
    public int getFifoUsedAt(int slot) {
        Objects.checkIndex(slot, used.length);
        return used[slot];
    }
}
