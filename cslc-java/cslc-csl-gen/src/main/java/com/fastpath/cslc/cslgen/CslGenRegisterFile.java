package com.fastpath.cslc.cslgen;

import java.util.Arrays;
import java.util.Objects;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLregisterFile} ({@code cslRegister.h} / {@code cslRegister.cpp}).
 */
public final class CslGenRegisterFile extends CslGenCslBase {

    public static final int SET_WIDTH = 0;
    public static final int GET_WIDTH = 1;
    public static final int SET_DEPTH = 2;
    public static final int GET_DEPTH = 3;
    public static final int READ_VALID = 4;
    public static final int CREATE_RTL_MODELE = 5;
    public static final int SET_CONST_VALUE = 6;
    public static final int SET_FIELD = 7;
    public static final int SET_EXTERNAL = 8;
    public static final int BYPASS = 9;
    public static final int SET_PREFIX = 10;
    public static final int DIR_REG = 11;
    public static final int DIR_DISC = 12;
    public static final int DIR_CON = 13;

    private final StringBuilder width = new StringBuilder();
    private final StringBuilder depth = new StringBuilder();
    private final StringBuilder constVal = new StringBuilder();
    private final StringBuilder fieldName = new StringBuilder();
    private final StringBuilder fieldNumExpr = new StringBuilder();
    private final StringBuilder extNumExpr = new StringBuilder();
    private final StringBuilder extPort = new StringBuilder();
    private final StringBuilder prefix = new StringBuilder();
    private final StringBuilder ioput = new StringBuilder();
    private final StringBuilder prefixAll = new StringBuilder();
    private final StringBuilder groupName = new StringBuilder();
    private final StringBuilder regAll = new StringBuilder();
    private final StringBuilder discAll = new StringBuilder();
    private final StringBuilder conAll = new StringBuilder();
    private final StringBuilder conIOput = new StringBuilder();

    private final int[] used = new int[CslGenRegisterTables.RF_USED_VECTOR_SIZE];

    private boolean fieldNameF;
    private boolean extPortF;
    private boolean prefixAllF;
    private boolean regAllF;
    private boolean discAllF;
    private boolean conAllF;

    public CslGenRegisterFile(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_REG_FILE, parent, name);
        Arrays.fill(used, 0);
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenCslBase design = getParent().orElse(null);
        genSetWidth(design, rng);
        genSetDepth(design, rng);
        used[SET_WIDTH] = 1;
        used[SET_DEPTH] = 1;
        int limit = rng.nextInt(CslGenRegisterTables.REG_FILE_CMD);
        for (int i = 0; i < limit; i++) {
            int ran = rng.nextInt(CslGenRegisterTables.RF_USED_VECTOR_SIZE);
            if (used[ran] != 0) {
                continue;
            }
            switch (ran) {
                case SET_CONST_VALUE -> genSetConstValue(rng);
                case SET_FIELD -> genSetField(design, rng);
                case SET_EXTERNAL -> genSetExternal(design, rng);
                case SET_PREFIX -> genSetPrefix(design, rng);
                case DIR_REG -> genDirReg(design, rng);
                case DIR_DISC -> genDirDisconnect(design, rng);
                case DIR_CON -> genDirConnect(design, rng);
                default -> {
                    /* GET_WIDTH / GET_DEPTH / READ_VALID handled via m_used rules */
                }
            }
            if (ran != GET_WIDTH && ran != GET_DEPTH) {
                used[ran] = 1;
            } else if (used[SET_WIDTH] != 0) {
                used[GET_WIDTH] = 1;
            } else if (used[SET_DEPTH] != 0) {
                used[GET_DEPTH] = 1;
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
        CslGenSupportEmit.cslRegisterFile(mOut);
        mOut.append(getName());
        CslGenSupportEmit.lCbrace(mOut);
        mOut.append("    ").append(getName());
        CslGenSupportEmit.lParenthesis(mOut);
        CslGenSupportEmit.rParenthesis(mOut);
        CslGenSupportEmit.lCbrace(mOut);
        for (int i = 0; i < CslGenRegisterTables.RF_USED_VECTOR_SIZE; i++) {
            if (used[i] == 0) {
                continue;
            }
            switch (i) {
                case SET_WIDTH -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.RF_FUNCTION[i], width.toString());
                case SET_DEPTH -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.RF_FUNCTION[i], depth.toString());
                case READ_VALID -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.RF_FUNCTION[i], CslGenRegisterTables.RF_ADD_LOGIC_FCT[0]);
                case CREATE_RTL_MODELE -> CslGenSupportEmit.funct0param(mOut, CslGenRegisterTables.RF_FUNCTION[i]);
                case SET_CONST_VALUE -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.RF_FUNCTION[i], constVal.toString());
                case SET_FIELD -> {
                    if (fieldNameF) {
                        CslGenSupportEmit.funct2param(mOut, CslGenRegisterTables.RF_FUNCTION[i], fieldName.toString(), fieldNumExpr.toString());
                    }
                }
                case SET_EXTERNAL -> {
                    if (extPortF) {
                        CslGenSupportEmit.funct2param(mOut, CslGenRegisterTables.RF_FUNCTION[i], extNumExpr.toString(), extPort.toString());
                    }
                }
                case BYPASS -> CslGenSupportEmit.funct1param(mOut, CslGenRegisterTables.RF_FUNCTION[i], CslGenRegisterTables.RF_ADD_LOGIC_FCT[1]);
                case SET_PREFIX -> {
                    if (prefixAllF) {
                        CslGenSupportEmit.funct3param(mOut, CslGenRegisterTables.RF_FUNCTION[i], prefix.toString(), ioput.toString(), prefixAll.toString());
                    }
                }
                case DIR_REG -> {
                    if (regAllF) {
                        CslGenSupportEmit.funct3param(
                                mOut,
                                CslGenRegisterTables.RF_FUNCTION[i],
                                CslGenRegisterTables.RF_DIRECTIVE[0],
                                groupName.toString(),
                                regAll.toString());
                    }
                }
                case DIR_DISC -> {
                    if (discAllF) {
                        CslGenSupportEmit.funct2param(mOut, CslGenRegisterTables.RF_FUNCTION[i], CslGenRegisterTables.RF_DIRECTIVE[1], discAll.toString());
                    }
                }
                case DIR_CON -> {
                    if (conAllF) {
                        CslGenSupportEmit.funct3param(
                                mOut, CslGenRegisterTables.RF_FUNCTION[i], CslGenRegisterTables.RF_DIRECTIVE[2], conIOput.toString(), conAll.toString());
                    }
                }
                default -> {}
            }
        }
        mOut.append("  ");
        CslGenSupportEmit.rCbrace(mOut);
        CslGenSupportEmit.rCbrace(mOut);
        CslGenSupportEmit.semicolon(mOut);
    }

    private void genSetWidth(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            width.append(CslGenNumExprSupport.randNumExpr(rng));
            return;
        }
        boolean ok = false;
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_REG_FILE && ch instanceof CslGenRegisterFile rf) {
                if (rng.nextBoolean() && !ok && rf.used[GET_WIDTH] != 0) {
                    width.append(ch.getName()).append('.').append(CslGenRegisterTables.RF_FUNCTION[GET_WIDTH]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            width.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    private void genSetDepth(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            depth.append(CslGenNumExprSupport.randNumExpr(rng));
            return;
        }
        boolean ok = false;
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_REG_FILE && ch instanceof CslGenRegisterFile rf) {
                if (rng.nextBoolean() && !ok && rf.used[GET_DEPTH] != 0) {
                    depth.append(ch.getName()).append('.').append(CslGenRegisterTables.RF_FUNCTION[GET_DEPTH]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            depth.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    private void genSetConstValue(RandomGenerator rng) {
        constVal.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    private void genSetField(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !fieldNameF) {
                fieldName.append(ch.getName());
                fieldNameF = true;
            }
        }
        if (fieldNameF) {
            fieldNumExpr.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    private void genSetExternal(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_PORT && rng.nextBoolean() && !extPortF) {
                extPort.append(ch.getName());
                extPortF = true;
            }
        }
        if (extPortF) {
            extNumExpr.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    private void genSetPrefix(CslGenCslBase design, RandomGenerator rng) {
        String p = CslGenRandString.randString(rng);
        if (!newNameIsValid(p)) {
            return;
        }
        prefix.append('"').append(CslGenRandString.randString(rng)).append('"');
        ioput.append(CslGenRegisterTables.RF_IOPUT[rng.nextInt(2)]);
        if (rng.nextBoolean()) {
            prefixAll.append("all");
            prefixAllF = true;
        } else if (design != null) {
            for (CslGenCslBase reg : design.getChildren()) {
                if (reg.getType() != CslGenCslType.CSL_REG) {
                    continue;
                }
                for (CslGenCslBase f : reg.getChildren()) {
                    if (f.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !prefixAllF) {
                        prefixAll.append(reg.getName()).append('.').append(f.getName());
                        prefixAllF = true;
                        return;
                    }
                }
            }
        }
    }

    private void genDirReg(CslGenCslBase design, RandomGenerator rng) {
        if (rng.nextBoolean()) {
            regAll.append("all");
            regAllF = true;
        } else if (design != null) {
            outer:
            for (CslGenCslBase reg : design.getChildren()) {
                if (reg.getType() != CslGenCslType.CSL_REG) {
                    continue;
                }
                for (CslGenCslBase f : reg.getChildren()) {
                    if (f.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !regAllF) {
                        regAll.append(reg.getName()).append('.').append(f.getName());
                        regAllF = true;
                        break outer;
                    }
                }
            }
        }
        if (regAllF) {
            groupName.append(CslGenRandString.randString(rng));
        }
    }

    private void genDirDisconnect(CslGenCslBase design, RandomGenerator rng) {
        if (rng.nextBoolean()) {
            discAll.append("all");
            discAllF = true;
        } else if (design != null) {
            for (CslGenCslBase reg : design.getChildren()) {
                if (reg.getType() != CslGenCslType.CSL_REG) {
                    continue;
                }
                for (CslGenCslBase f : reg.getChildren()) {
                    if (f.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !discAllF) {
                        discAll.append(f.getName());
                        discAllF = true;
                    }
                }
            }
        }
    }

    private void genDirConnect(CslGenCslBase design, RandomGenerator rng) {
        conIOput.append(CslGenRegisterTables.RF_DIR_CONNECT[rng.nextInt(3)]);
        if (rng.nextBoolean()) {
            conAll.append("all ");
            conAllF = true;
        } else if (design != null) {
            for (CslGenCslBase reg : design.getChildren()) {
                if (reg.getType() != CslGenCslType.CSL_REG) {
                    continue;
                }
                for (CslGenCslBase f : reg.getChildren()) {
                    if (f.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean()) {
                        int k = rng.nextInt(3);
                        switch (k) {
                            case 0 -> conAll.append(reg.getName());
                            case 1 -> conAll.append('.').append(f.getName());
                            case 2 -> conAll.append(reg.getName()).append('.').append(f.getName());
                            default -> {}
                        }
                        conAllF = true;
                    }
                }
            }
        }
    }

    /** Legacy public {@code CSLregisterFile::m_width}. */
    public String getWidthText() {
        return width.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_depth}. */
    public String getDepthText() {
        return depth.toString();
    }

    /**
     * Legacy public {@code CSLregisterFile::m_used[slot]} ({@code cslRegister.h}): {@code 0} or {@code 1} per emitted
     * option slot.
     */
    public int getRegisterFileUsedAt(int slot) {
        Objects.checkIndex(slot, used.length);
        return used[slot];
    }

    /** Legacy public {@code CSLregisterFile::m_constVal}. */
    public String getConstValText() {
        return constVal.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_fieldName}. */
    public String getFieldNameText() {
        return fieldName.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_fieldNumExpr}. */
    public String getFieldNumExprText() {
        return fieldNumExpr.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_extNumExpr}. */
    public String getExtNumExprText() {
        return extNumExpr.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_extPort}. */
    public String getExtPortText() {
        return extPort.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_prefix}. */
    public String getPrefixText() {
        return prefix.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_ioput}. */
    public String getIoputText() {
        return ioput.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_prefixAll}. */
    public String getPrefixAllText() {
        return prefixAll.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_groupName}. */
    public String getGroupNameText() {
        return groupName.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_regAll}. */
    public String getRegAllText() {
        return regAll.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_discAll}. */
    public String getDiscAllText() {
        return discAll.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_conAll}. */
    public String getConAllText() {
        return conAll.toString();
    }

    /** Legacy public {@code CSLregisterFile::m_conIOput}. */
    public String getConIOputText() {
        return conIOput.toString();
    }

    /** Legacy public {@code m_fieldNameF}. */
    public boolean isFieldNameF() {
        return fieldNameF;
    }

    /** Legacy public {@code m_extPortF}. */
    public boolean isExtPortF() {
        return extPortF;
    }

    /** Legacy public {@code m_prefixAllF}. */
    public boolean isPrefixAllF() {
        return prefixAllF;
    }

    /** Legacy public {@code m_regAllF}. */
    public boolean isRegAllF() {
        return regAllF;
    }

    /** Legacy public {@code m_discAllF}. */
    public boolean isDiscAllF() {
        return discAllF;
    }

    /** Legacy public {@code m_conAllF}. */
    public boolean isConAllF() {
        return conAllF;
    }
}
