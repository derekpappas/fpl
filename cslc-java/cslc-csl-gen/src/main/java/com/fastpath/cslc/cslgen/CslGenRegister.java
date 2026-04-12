package com.fastpath.cslc.cslgen;

import java.util.Arrays;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLregister} ({@code cslRegister.h} / {@code cslRegister.cpp}). {@link #buildDecl}
 * and {@link #print} follow the legacy control flow; some generators are simplified when the design tree lacks
 * sibling {@link CslGenCslType#CSL_REG} / {@link CslGenCslType#CSL_MEM_MAP} nodes.
 */
public final class CslGenRegister extends CslGenCslBase {

    public static final int SET_RANGE = 0;
    public static final int SET_TYPE = 1;
    public static final int SET_WIDTH = 2;
    public static final int SET_ADDRESS = 3;
    public static final int INDEX_DATA_PAIR = 4;
    public static final int SET_ATRIBUTE = 5;
    public static final int CONSTANT = 6;
    public static final int SET_ATRIBUTES = 7;
    public static final int GET_ATRIBUTES = 8;
    public static final int NEG_OUTPUT = 9;
    public static final int SERIAL_INPUT = 10;
    public static final int SERIAL_OUTPUT = 11;
    public static final int RD_EN = 12;
    public static final int WR_EN = 13;
    public static final int CONNECT_INPUT = 14;
    public static final int GET_INPUT_FILE = 15;
    public static final int CONNECT_OUTPUT = 16;
    public static final int GET_OUTPUT_FILE = 17;
    public static final int INIT_VALUE = 18;
    public static final int SET_VALUE = 19;
    public static final int RESET_VALUE = 20;
    public static final int CLEAR_VALUE = 21;
    public static final int SET_LOCK_ENABLE_BIT = 22;
    public static final int GET_LOCK_ENABLE_BIT = 23;
    public static final int GRAY_OUTPUT = 24;
    public static final int SET_COUNT_AMOUNT = 25;
    public static final int SET_COUNT_DIRECTION = 26;
    public static final int SET_END_VALUE = 27;
    public static final int SET_START_VALUE = 28;
    public static final int STOP_AT_END_VALUE = 29;
    public static final int CNT_DIR_SGN = 30;
    public static final int GET_CNT_DIR_SIGNAL = 31;
    public static final int INC_SGN = 32;
    public static final int DEC_SGN = 33;

    private final StringBuilder range = new StringBuilder();
    private final StringBuilder regType = new StringBuilder();
    private final StringBuilder width = new StringBuilder();
    private final StringBuilder mpSetAddr = new StringBuilder();
    private final StringBuilder setAddr = new StringBuilder();
    private final StringBuilder mpIndexDataRange = new StringBuilder();
    private final StringBuilder indexDataRange = new StringBuilder();
    private final StringBuilder attr = new StringBuilder();
    private final StringBuilder constant = new StringBuilder();
    private final StringBuilder attrObj = new StringBuilder();
    private final StringBuilder attrList = new StringBuilder();
    private final StringBuilder conInputField = new StringBuilder();
    private final StringBuilder conOutputField = new StringBuilder();
    private final StringBuilder initVal = new StringBuilder();
    private final StringBuilder setVal = new StringBuilder();
    private final StringBuilder resetVal = new StringBuilder();
    private final StringBuilder clearVal = new StringBuilder();
    private final StringBuilder lockEnBit = new StringBuilder();
    private final StringBuilder countAmount = new StringBuilder();
    private final StringBuilder countDir = new StringBuilder();
    private final StringBuilder endVal = new StringBuilder();
    private final StringBuilder startVal = new StringBuilder();
    private final StringBuilder cntDirSgn = new StringBuilder();

    private final int[] used = new int[CslGenRegisterTables.R_USED_VECTOR_SIZE];

    private boolean mpSetAddrF;
    private boolean setAddrF;
    private boolean mpIndexDataRangeF;
    private boolean indexDataRangeF;
    private boolean attrObjF;
    private boolean conInputFieldF;
    private boolean conOutputFieldF;
    private boolean cntDirSgnF;

    public CslGenRegister(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_REG, parent, name);
        Arrays.fill(used, 0);
    }

    int usedFlag(int i) {
        return used[i];
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        int limit = rng.nextInt(CslGenRegisterTables.REG_CMD);
        CslGenCslBase design = getParent().orElse(null);
        for (int i = 0; i < limit; i++) {
            int ran = rng.nextInt(CslGenRegisterTables.R_USED_VECTOR_SIZE);
            if (used[ran] != 0) {
                continue;
            }
            switch (ran) {
                case SET_RANGE -> genSetRange(rng);
                case SET_TYPE -> genSetType(rng);
                case SET_WIDTH -> genSetWidth(rng);
                case SET_ADDRESS -> genSetAddress(design, rng);
                case INDEX_DATA_PAIR -> genIndexDataPair(design, rng);
                case SET_ATRIBUTE -> genSetAtribute(rng);
                case CONSTANT -> genConstant(rng);
                case SET_ATRIBUTES -> genSeAtributes(design, rng);
                case CONNECT_INPUT -> genAddLogicConnectInput(design, rng);
                case CONNECT_OUTPUT -> genAddLogicConnectOutput(design, rng);
                case INIT_VALUE -> genInitValue(rng);
                case SET_VALUE -> genSetValue(rng);
                case RESET_VALUE -> genResetValue(rng);
                case CLEAR_VALUE -> genClearValue(rng);
                case SET_LOCK_ENABLE_BIT -> genSetLockEnableBit(design, rng);
                case SET_COUNT_AMOUNT -> genSetCountAmount(rng);
                case SET_COUNT_DIRECTION -> genSetCountDirection(rng);
                case SET_END_VALUE -> genSetEndValue(rng);
                case SET_START_VALUE -> genSetStartValue(rng);
                case STOP_AT_END_VALUE -> genStopEndValue(rng);
                case GET_CNT_DIR_SIGNAL -> genAddLogicCntDirSgn(design, rng);
                default -> {
                    /* slots without explicit generator (legacy still sets m_used) */
                }
            }
            if (ran != GET_ATRIBUTES
                    && ran != GET_INPUT_FILE
                    && ran != GET_OUTPUT_FILE
                    && ran != GET_LOCK_ENABLE_BIT
                    && ran != GET_CNT_DIR_SIGNAL) {
                used[ran] = 1;
            } else if (used[SET_ATRIBUTES] != 0) {
                used[GET_ATRIBUTES] = 1;
            } else if (used[CONNECT_INPUT] != 0) {
                used[GET_INPUT_FILE] = 1;
            } else if (used[CONNECT_OUTPUT] != 0) {
                used[GET_OUTPUT_FILE] = 1;
            } else if (used[SET_LOCK_ENABLE_BIT] != 0) {
                used[GET_LOCK_ENABLE_BIT] = 1;
            } else if (used[SET_COUNT_DIRECTION] != 0) {
                used[GET_CNT_DIR_SIGNAL] = 1;
            }
        }
        return true;
    }

    @Override
    public void print() {
        StringBuilder mOut = printSink();
        if (mOut == null) {
            return;
        }
        CslGenSupportEmit.cslRegister(mOut);
        mOut.append(getName());
        CslGenSupportEmit.lCbrace(mOut);
        mOut.append("    ").append(getName());
        CslGenSupportEmit.lParenthesis(mOut);
        CslGenSupportEmit.rParenthesis(mOut);
        CslGenSupportEmit.lCbrace(mOut);
        for (int i = 0; i < CslGenRegisterTables.R_USED_VECTOR_SIZE; i++) {
            if (used[i] == 0) {
                continue;
            }
            switch (i) {
                case SET_RANGE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], range.toString());
                case SET_TYPE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], regType.toString());
                case SET_WIDTH -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], width.toString());
                case SET_ADDRESS -> {
                    if (mpSetAddrF) {
                        CslGenSupportEmit.funct2param(mOut, CslGenRegisterTables.R_FUNCTION[i], mpSetAddr.toString(), setAddr.toString());
                    }
                }
                case INDEX_DATA_PAIR -> {
                    if (mpIndexDataRangeF) {
                        if (indexDataRangeF) {
                            CslGenSupportEmit.funct2param(
                                    mOut, CslGenRegisterTables.R_FUNCTION[i], mpIndexDataRange.toString(), indexDataRange.toString());
                        } else {
                            CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], mpIndexDataRange.toString());
                        }
                    }
                }
                case SET_ATRIBUTE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], attr.toString());
                case CONSTANT -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], constant.toString());
                case SET_ATRIBUTES -> {
                    if (attrObjF) {
                        mOut.append(attrObj)
                                .append('.')
                                .append(CslGenRegisterTables.R_FUNCTION[i])
                                .append("( ")
                                .append(attrList)
                                .append(");\n");
                    }
                }
                case NEG_OUTPUT -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[0]);
                case SERIAL_INPUT -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[1]);
                case SERIAL_OUTPUT -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[2]);
                case RD_EN -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[3]);
                case WR_EN -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[4]);
                case CONNECT_INPUT -> {
                    if (conInputFieldF) {
                        CslGenSupportEmit.funct2param(
                                mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[5], conInputField.toString());
                    }
                }
                case CONNECT_OUTPUT -> {
                    if (conOutputFieldF) {
                        CslGenSupportEmit.funct2param(
                                mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[6], conOutputField.toString());
                    }
                }
                case INIT_VALUE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], initVal.toString());
                case SET_VALUE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], setVal.toString());
                case RESET_VALUE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], resetVal.toString());
                case CLEAR_VALUE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], clearVal.toString());
                case SET_LOCK_ENABLE_BIT -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], lockEnBit.toString());
                case GRAY_OUTPUT -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[7]);
                case SET_COUNT_AMOUNT -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], countAmount.toString());
                case SET_COUNT_DIRECTION -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], countDir.toString());
                case SET_END_VALUE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], endVal.toString());
                case SET_START_VALUE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], startVal.toString());
                case STOP_AT_END_VALUE -> CslGenSupportEmit.funct0param(mOut, CslGenRegisterTables.R_FUNCTION[i]);
                case CNT_DIR_SGN -> {
                    if (cntDirSgnF) {
                        CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], cntDirSgn.toString());
                    }
                }
                case INC_SGN -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[9]);
                case DEC_SGN -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.R_FUNCTION[i], CslGenRegisterTables.R_ADD_LOGIC_FCT[10]);
                default -> {
                    /* add_logic-only slots: legacy emits funct1param for several indices — omitted when empty */
                }
            }
        }
        mOut.append("  ");
        CslGenSupportEmit.rCbrace(mOut);
        CslGenSupportEmit.rCbrace(mOut);
        CslGenSupportEmit.semicolon(mOut);
    }

    private void genRange(RandomGenerator rng) {
        range.append(CslGenNumExprSupport.randNumExpr(rng));
        range.append(',');
        range.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSetRange(RandomGenerator rng) {
        if (rng.nextBoolean()) {
            genRange(rng);
        } else {
            range.append('{');
            for (int i = 0; i < rng.nextInt(10) + 1; i++) {
                range.append('(');
                genRange(rng);
                range.append(')');
                range.append(", ");
            }
            range.append('(');
            genRange(rng);
            range.append(')');
            range.append('}');
        }
    }

    private void genSetType(RandomGenerator rng) {
        regType.append(CslGenRegisterTables.R_TYPE[rng.nextInt(CslGenRegisterTables.R_TYPE_SIZE)]);
    }

    private void genSetWidth(RandomGenerator rng) {
        width.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSetAddress(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_MEM_MAP && rng.nextBoolean()) {
                mpSetAddr.append(ch.getName());
                mpSetAddrF = true;
            }
        }
        if (mpSetAddrF && rng.nextBoolean()) {
            setAddr.append(CslGenNumExprSupport.randNumExpr(rng));
            setAddrF = true;
        }
    }

    private void genIndexDataPair(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_MEM_MAP && rng.nextBoolean()) {
                mpIndexDataRange.append(ch.getName());
                mpIndexDataRangeF = true;
            }
        }
        if (mpIndexDataRangeF && rng.nextBoolean()) {
            indexDataRange.append(CslGenNumExprSupport.randNumExpr(rng));
            indexDataRangeF = true;
        }
    }

    private void genSetAtribute(RandomGenerator rng) {
        attr.append(CslGenRegisterTables.R_ATRIBUT[rng.nextInt(CslGenRegisterTables.R_ATRIBUT_SIZE)]);
    }

    private void genConstant(RandomGenerator rng) {
        constant.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSeAtributes(CslGenCslBase design, RandomGenerator rng) {
        attrObj.setLength(0);
        attrList.setLength(0);
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() != CslGenCslType.CSL_REG) {
                continue;
            }
            int flag = rng.nextInt(10);
            if (flag == 0 || attrObjF) {
                continue;
            }
            attrObj.append(ch.getName());
            attrObjF = true;
            attrList.append("csl_list (");
            attrList.append(CslGenRegisterTables.R_ATRIBUT[rng.nextInt(CslGenRegisterTables.R_ATRIBUT_SIZE)]);
            attrList.append(" )");
            break;
        }
    }

    private void genAddLogicConnectInput(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        boolean ok = false;
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch instanceof CslGenRegister reg && rng.nextBoolean() && !ok && reg.usedFlag(GET_INPUT_FILE) != 0) {
                conInputField.append(ch.getName()).append('.').append(CslGenRegisterTables.R_FUNCTION[GET_INPUT_FILE]).append("()");
                ok = true;
                conInputFieldF = true;
            }
        }
        if (!ok) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !conInputFieldF) {
                    conInputField.append(ch.getName());
                    conInputFieldF = true;
                    break;
                }
            }
        }
    }

    private void genAddLogicConnectOutput(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        boolean ok = false;
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch instanceof CslGenRegister reg && rng.nextBoolean() && !ok && reg.usedFlag(GET_OUTPUT_FILE) != 0) {
                conOutputField.append(ch.getName()).append('.').append(CslGenRegisterTables.R_FUNCTION[GET_OUTPUT_FILE]).append("()");
                ok = true;
                conOutputFieldF = true;
            }
        }
        if (!ok) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !conOutputFieldF) {
                    conOutputField.append(ch.getName());
                    conOutputFieldF = true;
                    break;
                }
            }
        }
    }

    private void genInitValue(RandomGenerator rng) {
        initVal.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSetValue(RandomGenerator rng) {
        setVal.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genResetValue(RandomGenerator rng) {
        resetVal.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genClearValue(RandomGenerator rng) {
        clearVal.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSetLockEnableBit(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            lockEnBit.append(CslGenNumExprSupport.randNumExpr(rng));
            return;
        }
        boolean ok = false;
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch instanceof CslGenRegister reg && rng.nextBoolean() && !ok && reg.usedFlag(GET_LOCK_ENABLE_BIT) != 0) {
                lockEnBit.append(ch.getName()).append('.').append(CslGenRegisterTables.R_FUNCTION[GET_LOCK_ENABLE_BIT]).append("()");
                ok = true;
            }
        }
        if (!ok) {
            lockEnBit.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    private void genSetCountAmount(RandomGenerator rng) {
        countAmount.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSetCountDirection(RandomGenerator rng) {
        countDir.append(CslGenRegisterTables.R_COUNT_DIR[rng.nextInt(2)]);
    }

    private void genSetEndValue(RandomGenerator rng) {
        endVal.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSetStartValue(RandomGenerator rng) {
        startVal.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genStopEndValue(RandomGenerator rng) {
        startVal.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genAddLogicCntDirSgn(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            cntDirSgn.append(CslGenRegisterTables.R_ADD_LOGIC_FCT[8]);
            return;
        }
        boolean ok = false;
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch instanceof CslGenRegister reg && rng.nextBoolean() && !ok && reg.usedFlag(CNT_DIR_SGN) != 0) {
                cntDirSgn.append(ch.getName())
                        .append('.')
                        .append(CslGenRegisterTables.R_FUNCTION[CNT_DIR_SGN])
                        .append("();\n");
                cntDirSgnF = true;
                ok = true;
            }
        }
        if (!ok) {
            cntDirSgn.append(CslGenRegisterTables.R_ADD_LOGIC_FCT[8]);
        }
    }
}
