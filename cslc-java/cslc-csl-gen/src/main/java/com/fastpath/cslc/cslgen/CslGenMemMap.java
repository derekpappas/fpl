package com.fastpath.cslc.cslgen;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLmemMap} ({@code cslMemoryMap.h} / {@code cslMemoryMap.cpp}).
 */
public final class CslGenMemMap extends CslGenCslBase {

    public static final int AUTO_GEN = 0;
    public static final int SET_TOP_UNIT = 1;
    public static final int ADD_TO_MM = 2;
    public static final int SET_TYPE = 3;
    public static final int SET_ACC_RIGHT = 4;
    public static final int SET_DATA_WORD_WIDTH = 5;
    public static final int GET_DATA_WORD_WIDTH = 6;
    public static final int SET_PREFIX = 7;
    public static final int GET_PREFIX = 8;
    public static final int SET_SUFFIX = 9;
    public static final int GET_SUFFIX = 10;

    private final StringBuilder topUnit = new StringBuilder();
    private final StringBuilder addToMemObj = new StringBuilder();
    private final StringBuilder addToMemAddr = new StringBuilder();
    private final StringBuilder addToMemAccRight = new StringBuilder();
    private final StringBuilder addToMemGroupAcc = new StringBuilder();
    private final StringBuilder mmType = new StringBuilder();
    private final List<String> mmpName = new ArrayList<>();
    private final List<String> enumName = new ArrayList<>();
    private final List<Boolean> enumNameF = new ArrayList<>();
    private final StringBuilder dataWordWidth = new StringBuilder();
    private final StringBuilder prefix = new StringBuilder();
    private final StringBuilder suffix = new StringBuilder();

    private boolean topUnitF;
    private boolean addToMemObjF;
    private boolean addToMemAddrF;
    private boolean addToMemRightF;

    private final int[] used = new int[CslGenMemoryMapTables.MM_USED_VECTOR_SIZE];

    public CslGenMemMap(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_MEM_MAP, parent, name);
        Arrays.fill(used, 0);
    }

    /** {@code m_used[slot]} ({@code CSLmemMap}). */
    public int getMemMapUsedAt(int slot) {
        Objects.checkIndex(slot, used.length);
        return used[slot];
    }

    public void genSetTopUnit(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_UNIT && rng.nextBoolean() && !topUnitF) {
                topUnit.append(ch.getName());
                topUnitF = true;
            }
        }
    }

    public void genAddToMemMap(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            CslGenCslType t = ch.getType();
            if (t != CslGenCslType.CSL_FIFO
                    && t != CslGenCslType.CSL_REG_FILE
                    && t != CslGenCslType.CSL_REG
                    && t != CslGenCslType.CSL_MEMORY) {
                continue;
            }
            if (rng.nextBoolean() && !addToMemObjF) {
                addToMemObj.append(ch.getName());
                addToMemObjF = true;
            }
        }
        if (addToMemObjF) {
            if (rng.nextBoolean()) {
                addToMemAddr.append(CslGenNumExprSupport.randNumExpr(rng));
                addToMemAddrF = true;
            }
            if (rng.nextBoolean()) {
                for (CslGenCslBase ch : design.getChildren()) {
                    if (ch.getType() == CslGenCslType.CSL_ENUM && rng.nextBoolean() && !addToMemRightF) {
                        addToMemGroupAcc.append(ch.getName());
                        addToMemAccRight.append(
                                CslGenMemoryMapTables.MMP_ACCESS_RIGHTS[rng.nextInt(CslGenMemoryMapTables.MMP_ACCESS_RIGHTS_SIZE)]);
                        addToMemRightF = true;
                    }
                }
            }
        }
    }

    public void genSetType(RandomGenerator rng) {
        mmType.append(CslGenMemoryMapTables.MM_TYPE[rng.nextInt(CslGenMemoryMapTables.MM_TYPE_SIZE)]);
    }

    public void genSetAccessRight(CslGenCslBase design, String name, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        boolean ok = false;
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() != CslGenCslType.CSL_ENUM) {
                continue;
            }
            if (rng.nextInt(10) != 0 && !ok) {
                mmpName.add(name);
                enumName.add(ch.getName());
                enumNameF.add(true);
                ok = true;
            }
        }
    }

    public void genSetDataWordWidth(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP) {
                    continue;
                }
                CslGenMemMap mm = (CslGenMemMap) ch;
                if (rng.nextBoolean()
                        && !ok
                        && mm.getMemMapUsedAt(GET_DATA_WORD_WIDTH) != 0) {
                    dataWordWidth.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MM_FUNCTION[GET_DATA_WORD_WIDTH]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            dataWordWidth.append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    public void genSetPrefix(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP) {
                    continue;
                }
                CslGenMemMap mm = (CslGenMemMap) ch;
                if (rng.nextBoolean() && !ok && mm.getMemMapUsedAt(GET_PREFIX) != 0) {
                    prefix.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MM_FUNCTION[GET_PREFIX]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            prefix.append('"').append(CslGenRandString.randString(rng)).append('"');
        }
    }

    public void genSetSuffix(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_MEM_MAP) {
                    continue;
                }
                CslGenMemMap mm = (CslGenMemMap) ch;
                if (rng.nextBoolean() && !ok && mm.getMemMapUsedAt(GET_SUFFIX) != 0) {
                    suffix.append(ch.getName()).append('.').append(CslGenMemoryMapTables.MM_FUNCTION[GET_SUFFIX]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            suffix.append('"').append(CslGenRandString.randString(rng)).append('"');
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
            String n = CslGenRandString.randString(rng);
            if (newNameIsValid(n)) {
                addChild(new CslGenInstance(this, ch, n));
            }
        }
    }

    private static boolean isValidInst(List<CslGenCslBase> children, int i) {
        if (children.get(i).getType() != CslGenCslType.CSL_INSTANCE) {
            return false;
        }
        CslGenInstance cur = (CslGenInstance) children.get(i);
        String n = cur.getInstantiatedObj().getName();
        for (int j = 0; j < i; j++) {
            if (children.get(j).getType() != CslGenCslType.CSL_INSTANCE) {
                continue;
            }
            CslGenInstance o = (CslGenInstance) children.get(j);
            if (o.getInstantiatedObj().getName().equals(n)) {
                return false;
            }
        }
        return true;
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenCslBase design = getParent().orElse(null);
        int cmds = rng.nextInt(CslGenMemoryMapTables.MM_CMD);
        for (int k = 0; k < cmds; k++) {
            int ran = rng.nextInt(CslGenMemoryMapTables.MM_USED_VECTOR_SIZE);
            if (used[ran] == 0) {
                switch (ran) {
                    case SET_TOP_UNIT -> genSetTopUnit(design, rng);
                    case ADD_TO_MM -> genAddToMemMap(design, rng);
                    case SET_TYPE -> genSetType(rng);
                    case SET_DATA_WORD_WIDTH -> genSetDataWordWidth(design, rng);
                    case SET_PREFIX -> genSetPrefix(design, rng);
                    case SET_SUFFIX -> genSetSuffix(design, rng);
                    default -> {
                        /* SET_ACC_RIGHT commented in legacy loop */
                    }
                }
            }
            if (ran != GET_DATA_WORD_WIDTH && ran != GET_PREFIX && ran != GET_SUFFIX) {
                used[ran] = 1;
            } else if (used[SET_DATA_WORD_WIDTH] != 0) {
                used[GET_DATA_WORD_WIDTH] = 1;
            } else if (used[SET_PREFIX] != 0) {
                used[GET_PREFIX] = 1;
            } else if (used[SET_SUFFIX] != 0) {
                used[GET_SUFFIX] = 1;
            }
        }
        List<CslGenCslBase> ch = new ArrayList<>(getChildren());
        for (int i = 0; i < ch.size(); i++) {
            CslGenCslBase it = ch.get(i);
            if (it.getType() != CslGenCslType.CSL_INSTANCE) {
                continue;
            }
            CslGenInstance inst = (CslGenInstance) it;
            CslGenCslBase obj = inst.getInstantiatedObj();
            if (obj.getType() != CslGenCslType.CSL_MEM_MAP_PAGE) {
                continue;
            }
            CslGenMemMapPage page = (CslGenMemMapPage) obj;
            if (isValidInst(ch, i) && page.getMemMapPageUsedAt(CslGenMemMapPage.SET_ADDR_RIGHTS) != 0) {
                genSetAccessRight(design, obj.getName(), rng);
                used[SET_ACC_RIGHT] = 1;
            }
        }
        return true;
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        CslGenSupportEmit.cslMemoryMap(out);
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
        for (int i = 0; i < CslGenMemoryMapTables.MM_USED_VECTOR_SIZE; i++) {
            if (used[i] == 0) {
                continue;
            }
            switch (i) {
                case AUTO_GEN -> CslGenSupportEmit.funct0param(out, CslGenMemoryMapTables.MM_FUNCTION[i]);
                case SET_TOP_UNIT -> {
                    if (topUnitF) {
                        CslGenSupportEmit.funct1param(out, CslGenMemoryMapTables.MM_FUNCTION[i], topUnit.toString());
                    }
                }
                case ADD_TO_MM -> {
                    if (addToMemObjF) {
                        out.append("    ").append(addToMemObj).append('.').append(CslGenMemoryMapTables.MM_FUNCTION[i]);
                        CslGenSupportEmit.lParenthesis(out);
                        if (addToMemAddrF) {
                            out.append(addToMemAddr);
                            if (addToMemRightF) {
                                CslGenSupportEmit.comma(out);
                                out.append(addToMemGroupAcc);
                                CslGenSupportEmit.comma(out);
                                out.append(addToMemAccRight);
                            }
                        } else if (addToMemRightF) {
                            out.append(addToMemGroupAcc);
                            CslGenSupportEmit.comma(out);
                            out.append(addToMemAccRight);
                        }
                        CslGenSupportEmit.rParenthesis(out);
                        CslGenSupportEmit.semicolon(out);
                    }
                }
                case SET_TYPE -> CslGenSupportEmit.funct1param(out, CslGenMemoryMapTables.MM_FUNCTION[i], mmType.toString());
                case SET_ACC_RIGHT -> {
                    for (int it1 = 0; it1 < enumNameF.size(); it1++) {
                        if (Boolean.TRUE.equals(enumNameF.get(it1))) {
                            out.append(CslGenMemoryMapTables.MM_FUNCTION[i])
                                    .append("( ")
                                    .append(enumName.get(it1))
                                    .append("); \n");
                        }
                    }
                }
                case SET_DATA_WORD_WIDTH -> CslGenSupportEmit.funct1param(
                        out, CslGenMemoryMapTables.MM_FUNCTION[i], dataWordWidth.toString());
                case SET_PREFIX -> CslGenSupportEmit.funct1param(out, CslGenMemoryMapTables.MM_FUNCTION[i], prefix.toString());
                case SET_SUFFIX -> CslGenSupportEmit.funct1param(out, CslGenMemoryMapTables.MM_FUNCTION[i], suffix.toString());
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

    public String getTopUnitText() {
        return topUnit.toString();
    }

    public String getAddToMemObjText() {
        return addToMemObj.toString();
    }

    public String getAddToMemAddrText() {
        return addToMemAddr.toString();
    }

    public String getAddToMemAccRightText() {
        return addToMemAccRight.toString();
    }

    public String getAddToMemGroupAccText() {
        return addToMemGroupAcc.toString();
    }

    public String getMmTypeText() {
        return mmType.toString();
    }

    public List<String> getMmpNames() {
        return Collections.unmodifiableList(mmpName);
    }

    public List<String> getEnumNames() {
        return Collections.unmodifiableList(enumName);
    }

    public List<Boolean> getEnumNameFlags() {
        return Collections.unmodifiableList(enumNameF);
    }

    public String getDataWordWidthText() {
        return dataWordWidth.toString();
    }

    public String getPrefixText() {
        return prefix.toString();
    }

    public String getSuffixText() {
        return suffix.toString();
    }

    public boolean isTopUnitF() {
        return topUnitF;
    }

    public boolean isAddToMemObjF() {
        return addToMemObjF;
    }

    public boolean isAddToMemAddrF() {
        return addToMemAddrF;
    }

    public boolean isAddToMemRightF() {
        return addToMemRightF;
    }
}
