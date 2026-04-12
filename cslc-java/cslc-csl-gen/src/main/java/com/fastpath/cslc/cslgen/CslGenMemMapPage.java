package com.fastpath.cslc.cslgen;

import java.util.Arrays;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLmemMapPage} ({@code cslMemoryMap.h} / {@code cslMemoryMap.cpp}).
 */
public final class CslGenMemMapPage extends CslGenCslBase {

    public static final int ADD_ADDR_RANGE = 0;
    public static final int SET_ADDR_INCR = 1;
    public static final int GET_ADDR_INCR = 2;
    public static final int SET_NEXT_ADDR = 3;
    public static final int GET_NEXT_ADDR = 4;
    public static final int SET_ADDR_RIGHTS = 5;
    public static final int ADD_RES_ADDR_RANGE = 6;
    public static final int ADD_OBJ = 7;
    public static final int ADD_MMP = 8;
    public static final int GET_LOWER_BOUND = 9;
    public static final int GET_UPPER_BOUND = 10;
    public static final int SET_DATA_WORD_WIDTH = 11;
    public static final int GET_DATA_WORD_WIDTH = 12;
    public static final int SET_ALIGNMENT = 13;
    public static final int GET_ALIGNMENT = 14;
    public static final int SET_ENDIANESS = 15;
    public static final int GET_ENDIANESS = 16;
    public static final int SET_SYMB_LENGHT = 17;
    public static final int GET_SYMB_LENGHT = 18;

    private final StringBuilder lowerBound = new StringBuilder();
    private final StringBuilder upperBound = new StringBuilder();
    private final StringBuilder setAddrIncr = new StringBuilder();
    private final StringBuilder setNextAddr = new StringBuilder();
    private final StringBuilder groupAccess = new StringBuilder();
    private String accRight = "";
    private final StringBuilder resLowerBound = new StringBuilder();
    private final StringBuilder resUpperBound = new StringBuilder();
    private final StringBuilder addObj = new StringBuilder();
    private final StringBuilder symbol = new StringBuilder();
    private final StringBuilder baseAddr = new StringBuilder();
    private final StringBuilder memMapPageObj = new StringBuilder();
    private final StringBuilder dataWordWidth = new StringBuilder();
    private final StringBuilder setAlignment = new StringBuilder();
    private final StringBuilder endianess = new StringBuilder();
    private final StringBuilder symbolLength = new StringBuilder();

    private boolean baseAddrF;
    private boolean addAddrObjF;
    private boolean memMapPageObjF;
    private boolean groupAccessF;

    private final int[] used = new int[CslGenMemoryMapTables.MMP_USED_VECTOR_SIZE];

    public CslGenMemMapPage(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_MEM_MAP_PAGE, parent, name);
        Arrays.fill(used, 0);
    }

    boolean isMmpUsed(int idx) {
        return idx >= 0 && idx < used.length && used[idx] != 0;
    }

    public void genAddAddrRange(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP_PAGE) {
                    continue;
                }
                CslGenMemMapPage p = (CslGenMemMapPage) ch;
                if (rng.nextBoolean()
                        && !ok
                        && p.isMmpUsed(GET_LOWER_BOUND)
                        && p.isMmpUsed(GET_UPPER_BOUND)) {
                    lowerBound.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MMP_FUNCTION[GET_LOWER_BOUND]).append("()");
                    upperBound.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MMP_FUNCTION[GET_UPPER_BOUND]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            lowerBound.append(CslGenNumExprSupport.randNumExpr(rng));
            upperBound.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    public void genSetAddrIncr(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP_PAGE) {
                    continue;
                }
                CslGenMemMapPage p = (CslGenMemMapPage) ch;
                if (rng.nextBoolean() && !ok && p.isMmpUsed(GET_ADDR_INCR)) {
                    setAddrIncr.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MMP_FUNCTION[GET_ADDR_INCR]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            setAddrIncr.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    public void genSetNextAddr(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP_PAGE) {
                    continue;
                }
                CslGenMemMapPage p = (CslGenMemMapPage) ch;
                if (rng.nextBoolean() && !ok && p.isMmpUsed(GET_NEXT_ADDR)) {
                    setNextAddr.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MMP_FUNCTION[GET_NEXT_ADDR]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            setNextAddr.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    public void genSetAddrRights(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() != CslGenCslType.CSL_ENUM) {
                continue;
            }
            for (CslGenCslBase it : ch.getChildren()) {
                if (it.getType() != CslGenCslType.CSL_ENUM_ITEM) {
                    continue;
                }
                if (rng.nextInt(8) != 0 && !groupAccessF) {
                    groupAccess.append(it.getName());
                    groupAccessF = true;
                }
            }
        }
        if (groupAccessF) {
            accRight = CslGenMemoryMapTables.MMP_ACCESS_RIGHTS[rng.nextInt(CslGenMemoryMapTables.MMP_ACCESS_RIGHTS_SIZE)];
        }
    }

    public void genAddResAddrRange(RandomGenerator rng) {
        resLowerBound.append(CslGenNumExprSupport.randNumExpr(rng));
        resUpperBound.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    public void genAddAddrObj(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            CslGenCslType t = ch.getType();
            if (t != CslGenCslType.CSL_FIFO && t != CslGenCslType.CSL_REG_FILE && t != CslGenCslType.CSL_REG) {
                continue;
            }
            if (rng.nextBoolean() && !addAddrObjF) {
                addObj.append(ch.getName());
                addAddrObjF = true;
            }
        }
        if (addAddrObjF) {
            symbol.append('"').append(CslGenRandString.randString(rng)).append('"');
            if (!rng.nextBoolean()) {
                baseAddr.append(CslGenNumExprSupport.randNumExpr(rng));
                baseAddrF = true;
            }
        }
    }

    public void genAddMMP(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_MEM_MAP_PAGE && rng.nextBoolean() && !memMapPageObjF) {
                memMapPageObj.append(ch.getName());
                memMapPageObjF = true;
            }
        }
    }

    public void genSetDataWordWidth(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP_PAGE) {
                    continue;
                }
                CslGenMemMapPage p = (CslGenMemMapPage) ch;
                if (rng.nextBoolean() && !ok && p.isMmpUsed(GET_DATA_WORD_WIDTH)) {
                    dataWordWidth.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MMP_FUNCTION[GET_DATA_WORD_WIDTH]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            dataWordWidth.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    public void genSetAlignment(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP_PAGE) {
                    continue;
                }
                CslGenMemMapPage p = (CslGenMemMapPage) ch;
                if (rng.nextBoolean() && !ok && p.isMmpUsed(GET_ALIGNMENT)) {
                    setAlignment.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MMP_FUNCTION[GET_ALIGNMENT]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            setAlignment.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    public void genSetEndianess(RandomGenerator rng) {
        int ran = rng.nextInt(2);
        endianess.append(CslGenMemoryMapTables.ENDIANESS_TYPE[ran]);
    }

    public void genSetSymbolLenght(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP_PAGE) {
                    continue;
                }
                CslGenMemMapPage p = (CslGenMemMapPage) ch;
                if (rng.nextBoolean() && !ok && p.isMmpUsed(GET_SYMB_LENGHT)) {
                    symbolLength.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MMP_FUNCTION[GET_SYMB_LENGHT]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            symbolLength.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    public void addMemMapPageInstance(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() != CslGenCslType.CSL_MEM_MAP_PAGE) {
                continue;
            }
            if (rng.nextBoolean()) {
                String n = CslGenRandString.randString(rng);
                if (newNameIsValid(n)) {
                    addChild(new CslGenInstance(this, ch, n));
                }
            }
        }
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenCslBase design = getParent().orElse(null);
        int cmds = rng.nextInt(CslGenMemoryMapTables.MMP_CMD);
        for (int i = 0; i < cmds; i++) {
            int ran = rng.nextInt(CslGenMemoryMapTables.MMP_USED_VECTOR_SIZE);
            if (used[ran] != 0) {
                continue;
            }
            switch (ran) {
                case ADD_ADDR_RANGE -> genAddAddrRange(design, rng);
                case SET_ADDR_INCR -> genSetAddrIncr(design, rng);
                case SET_NEXT_ADDR -> genSetNextAddr(design, rng);
                case SET_ADDR_RIGHTS -> genSetAddrRights(design, rng);
                case ADD_RES_ADDR_RANGE -> genAddResAddrRange(rng);
                case ADD_OBJ -> genAddAddrObj(design, rng);
                case ADD_MMP -> genAddMMP(design, rng);
                case SET_DATA_WORD_WIDTH -> genSetDataWordWidth(design, rng);
                case SET_ALIGNMENT -> genSetAlignment(design, rng);
                case SET_ENDIANESS -> genSetEndianess(rng);
                case SET_SYMB_LENGHT -> genSetSymbolLenght(design, rng);
                default -> {
                    /* GET_* slots not chosen in legacy buildDecl switch */
                }
            }
            used[ran] = 1;
        }
        return true;
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        CslGenSupportEmit.cslMemoryMapPage(out);
        out.append(getName());
        CslGenSupportEmit.lCbrace(out);
        for (CslGenCslBase ch : getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_INSTANCE) {
                ch.print();
            }
        }
        out.append("    ").append(getName());
        CslGenSupportEmit.lParenthesis(out);
        CslGenSupportEmit.rParenthesis(out);
        CslGenSupportEmit.lCbrace(out);
        for (int i = 0; i < CslGenMemoryMapTables.MMP_USED_VECTOR_SIZE; i++) {
            if (used[i] == 0) {
                continue;
            }
            switch (i) {
                case ADD_ADDR_RANGE -> CslGenSupportEmit.funct2param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], lowerBound.toString(), upperBound.toString());
                case SET_ADDR_INCR -> CslGenSupportEmit.funct1param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], setAddrIncr.toString());
                case SET_NEXT_ADDR -> CslGenSupportEmit.funct1param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], setNextAddr.toString());
                case SET_ADDR_RIGHTS -> CslGenSupportEmit.funct2param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], groupAccess.toString(), accRight);
                case ADD_RES_ADDR_RANGE -> CslGenSupportEmit.funct2param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], resUpperBound.toString(), resLowerBound.toString());
                case ADD_OBJ -> {
                    if (addAddrObjF) {
                        if (baseAddrF) {
                            CslGenSupportEmit.funct3param(
                                    out,
                                    CslGenMemoryMapTables.MMP_FUNCTION[i],
                                    addObj.toString(),
                                    symbol.toString(),
                                    baseAddr.toString());
                        } else {
                            CslGenSupportEmit.funct2param(
                                    out, CslGenMemoryMapTables.MMP_FUNCTION[i], addObj.toString(), symbol.toString());
                        }
                    }
                }
                case ADD_MMP -> {
                    if (memMapPageObjF) {
                        CslGenSupportEmit.funct1param(out, CslGenMemoryMapTables.MMP_FUNCTION[i], memMapPageObj.toString());
                    }
                }
                case SET_DATA_WORD_WIDTH -> CslGenSupportEmit.funct1param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], dataWordWidth.toString());
                case SET_ALIGNMENT -> CslGenSupportEmit.funct1param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], setAlignment.toString());
                case SET_ENDIANESS -> CslGenSupportEmit.funct1param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], endianess.toString());
                case SET_SYMB_LENGHT -> CslGenSupportEmit.funct1param(
                        out, CslGenMemoryMapTables.MMP_FUNCTION[i], symbolLength.toString());
                default -> {
                    /* GET_* omitted in legacy print */
                }
            }
        }
        out.append("  ");
        CslGenSupportEmit.rCbrace(out);
        CslGenSupportEmit.rCbrace(out);
        CslGenSupportEmit.semicolon(out);
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
