package com.fastpath.cslc.cslgen;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLfield} ({@code cslField.h} / {@code cslField.cpp}).
 */
@SuppressWarnings("PMD.GodClass")
public final class CslGenField extends CslGenCslBase {

    public static final int WIDTH = 0;
    public static final int UPPER_LOWER = 1;
    public static final int COPY_CONSTR = 2;
    public static final int CONSTR = 3;

    public static final int SET_WIDTH = 0;
    public static final int SET_RANGE = 1;
    public static final int SET_BITRANGE = 2;
    public static final int SET_ENUM = 3;
    public static final int GET_ENUM = 4;
    public static final int SET_ENUM_ITEM = 5;
    public static final int GET_ENUM_ITEM = 6;
    public static final int SET_VALUE = 7;
    public static final int GET_VALUE = 8;
    public static final int SET_FIELD_POS = 9;
    public static final int SET_NEXT = 10;
    public static final int SET_PREVIOUS = 11;
    public static final int GET_WIDTH = 12;
    public static final int GET_UPPER = 13;
    public static final int GET_LOWER = 14;
    public static final int SET_OFFSET = 15;
    public static final int GET_OFFSET = 16;
    public static final int ADD_ALLOWED_RANGE = 17;

    private final StringBuilder enumName = new StringBuilder();
    private final StringBuilder enumItem = new StringBuilder();
    private final StringBuilder value = new StringBuilder();
    private final StringBuilder width = new StringBuilder();
    private final StringBuilder bitrange = new StringBuilder();
    private final StringBuilder range = new StringBuilder();
    private final StringBuilder offset = new StringBuilder();
    private final StringBuilder upper = new StringBuilder();
    private final StringBuilder lower = new StringBuilder();
    private final StringBuilder allowedRange = new StringBuilder();
    private final StringBuilder copy = new StringBuilder();

    private final List<String> posField = new ArrayList<>();
    private final List<String> posNumExpr = new ArrayList<>();
    private final List<String> nextLeft = new ArrayList<>();
    private final List<String> nextRight = new ArrayList<>();
    private final List<String> prevLeft = new ArrayList<>();
    private final List<String> prevRight = new ArrayList<>();

    private final int[] used = new int[CslGenFieldTables.FIELD_USED_VECTOR_SIZE];
    private final int[] usedTypeDecl = new int[CslGenFieldTables.FIELD_TYPE_DECL_SIZE];

    boolean copyF;
    boolean bitrangeF;
    boolean enumF;
    boolean enumItemF;
    boolean fieldTypeF;
    boolean posF;
    boolean nextF;
    boolean prevF;
    boolean hierarchicalF;

    public CslGenField(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_FIELD, parent, name);
        Arrays.fill(used, 0);
        Arrays.fill(usedTypeDecl, 0);
    }

    /** {@code m_used[slot]} ({@code CSLfield}). */
    public int getFieldUsedAt(int slot) {
        Objects.checkIndex(slot, used.length);
        return used[slot];
    }

    /** {@code m_usedTypeDecl[slot]} ({@code CSLfield}). */
    public int getFieldTypeDeclUsedAt(int slot) {
        Objects.checkIndex(slot, usedTypeDecl.length);
        return usedTypeDecl[slot];
    }

    /**
     * Legacy {@code CSLfield} child used as a wrapper for nested hierarchical fields ({@code CSL_INSTANCE} in
     * {@code cslField.cpp}, {@code CSL_FIELD_INST} in {@code cslGenEnumFieldEM.cpp}).
     */
    private static boolean isFieldHierarchyWrapper(CslGenCslBase ch) {
        return ch.getType() == CslGenCslType.CSL_INSTANCE || ch.getType() == CslGenCslType.CSL_FIELD_INST;
    }

    public void addFieldInstance(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() != CslGenCslType.CSL_FIELD) {
                continue;
            }
            String n = CslGenRandString.randString(rng);
            if (newNameIsValid(n)) {
                addChild(new CslGenFieldInst(this, ch, n));
                hierarchicalF = true;
            }
        }
    }

    public void genSetWidth(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_FIELD) {
                    continue;
                }
                CslGenField f = (CslGenField) ch;
                if (rng.nextBoolean()
                        && !ok
                        && (f.getFieldUsedAt(SET_WIDTH) != 0
                                || f.getFieldUsedAt(SET_RANGE) != 0
                                || f.getFieldUsedAt(SET_BITRANGE) != 0)) {
                    width.append(ch.getName()).append('.').append(CslGenFieldTables.FIELD_FUNCTION[GET_WIDTH]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            String w;
            do {
                w = CslGenNumExprSupport.randNumExpr(rng);
            } while ("0".equals(w));
            width.append(w);
        }
    }

    public void genSetBitrange(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() == CslGenCslType.CSL_BITRANGE && rng.nextBoolean() && !ok) {
                    bitrange.append(ch.getName());
                    ok = true;
                    bitrangeF = true;
                }
            }
        }
    }

    public void genSetRange(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_FIELD) {
                    continue;
                }
                CslGenField f = (CslGenField) ch;
                if (rng.nextBoolean()
                        && !ok
                        && (f.getFieldUsedAt(SET_WIDTH) != 0
                                || f.getFieldUsedAt(SET_RANGE) != 0
                                || f.getFieldUsedAt(SET_BITRANGE) != 0)) {
                    range.append(ch.getName())
                            .append('.')
                            .append(CslGenFieldTables.FIELD_FUNCTION[GET_LOWER])
                            .append("(), ");
                    range.append(ch.getName()).append('.').append(CslGenFieldTables.FIELD_FUNCTION[GET_UPPER]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            range.append(CslGenNumExprSupport.randNumExpr(rng)).append(", ").append(CslGenNumExprSupport.randNumExpr(rng));
        }
    }

    public void genSetOffset(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_FIELD) {
                    continue;
                }
                CslGenField f = (CslGenField) ch;
                if (rng.nextBoolean() && !ok && f.getFieldUsedAt(GET_OFFSET) != 0) {
                    offset.append(ch.getName()).append('.').append(CslGenFieldTables.FIELD_FUNCTION[GET_OFFSET]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            String o;
            do {
                o = CslGenNumExprSupport.randNumExpr(rng);
            } while ("0".equals(o));
            offset.append(o);
        }
    }

    public void genSetEnum(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_ENUM && rng.nextBoolean() && !enumF) {
                enumName.append(ch.getName());
                enumF = true;
            }
        }
    }

    public void genSetEnumItem(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() != CslGenCslType.CSL_ENUM) {
                continue;
            }
            for (CslGenCslBase it : ch.getChildren()) {
                if (it.getType() == CslGenCslType.CSL_ENUM_ITEM && rng.nextInt(5) != 0 && !enumItemF) {
                    enumItem.append(it.getName());
                    enumItemF = true;
                }
            }
        }
    }

    public void genSetValue(RandomGenerator rng) {
        value.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    public void genSetFieldPos(RandomGenerator rng) {
        for (CslGenCslBase ch : getChildren()) {
            if (isFieldHierarchyWrapper(ch)) {
                for (CslGenCslBase it : ch.getChildren()) {
                    if (rng.nextBoolean()) {
                        posField.add(it.getName());
                        posNumExpr.add(CslGenNumExprSupport.randNumExpr(rng));
                        ((CslGenField) it).posF = true;
                        posF = true;
                    }
                }
            } else if (ch.getType() == CslGenCslType.CSL_FIELD) {
                if (rng.nextBoolean()) {
                    posField.add(ch.getName());
                    posNumExpr.add(CslGenNumExprSupport.randNumExpr(rng));
                    ((CslGenField) ch).posF = true;
                    posF = true;
                }
            }
        }
    }

    public void genNext(RandomGenerator rng) {
        for (CslGenCslBase ch : getChildren()) {
            if (isFieldHierarchyWrapper(ch)) {
                for (CslGenCslBase it1 : ch.getChildren()) {
                    CslGenField f1 = (CslGenField) it1;
                    if (f1.posF) {
                        List<CslGenCslBase> inner = ch.getChildren();
                        int idx = inner.indexOf(it1);
                        for (int j = idx + 1; j < inner.size(); j++) {
                            CslGenField f2 = (CslGenField) inner.get(j);
                            if (rng.nextBoolean() && !f2.posF && !f2.prevF) {
                                nextLeft.add(f1.getName());
                                nextRight.add(f2.getName());
                                f2.nextF = true;
                                nextF = true;
                            }
                        }
                    }
                }
            } else if (ch.getType() == CslGenCslType.CSL_FIELD) {
                CslGenField f1 = (CslGenField) ch;
                if (f1.posF) {
                    List<CslGenCslBase> all = getChildren();
                    int idx = all.indexOf(ch);
                    for (int j = idx + 1; j < all.size(); j++) {
                        CslGenCslBase o = all.get(j);
                        if (o.getType() != CslGenCslType.CSL_FIELD) {
                            continue;
                        }
                        CslGenField f2 = (CslGenField) o;
                        if (rng.nextBoolean() && !f2.posF && !f2.prevF) {
                            nextLeft.add(f1.getName());
                            nextRight.add(f2.getName());
                            f2.nextF = true;
                            nextF = true;
                        }
                    }
                }
            }
        }
    }

    public void genPrevious(RandomGenerator rng) {
        for (CslGenCslBase ch : getChildren()) {
            if (isFieldHierarchyWrapper(ch)) {
                for (CslGenCslBase it1 : ch.getChildren()) {
                    CslGenField f1 = (CslGenField) it1;
                    if (f1.posF) {
                        List<CslGenCslBase> inner = ch.getChildren();
                        int idx = inner.indexOf(it1);
                        for (int j = idx + 1; j < inner.size(); j++) {
                            CslGenField f2 = (CslGenField) inner.get(j);
                            if (rng.nextBoolean() && !f2.posF && !f2.nextF) {
                                prevLeft.add(f1.getName());
                                prevRight.add(f2.getName());
                                f2.prevF = true;
                                prevF = true;
                            }
                        }
                    }
                }
            } else if (ch.getType() == CslGenCslType.CSL_FIELD) {
                CslGenField f1 = (CslGenField) ch;
                if (f1.posF) {
                    List<CslGenCslBase> all = getChildren();
                    int idx = all.indexOf(ch);
                    for (int j = idx + 1; j < all.size(); j++) {
                        CslGenCslBase o = all.get(j);
                        if (o.getType() != CslGenCslType.CSL_FIELD) {
                            continue;
                        }
                        CslGenField f2 = (CslGenField) o;
                        if (rng.nextBoolean() && !f2.posF && !f2.nextF) {
                            prevLeft.add(f1.getName());
                            prevRight.add(f2.getName());
                            f2.prevF = true;
                            prevF = true;
                        }
                    }
                }
            }
        }
    }

    public void genAllowedRange(RandomGenerator rng) {
        allowedRange.append(CslGenNumExprSupport.randNumExpr(rng)).append(',').append(CslGenNumExprSupport.randNumExpr(rng));
    }

    public void genEnum(CslGenCslBase design, RandomGenerator rng) {
        int flag = rng.nextInt(3);
        switch (flag) {
            case 0 -> genSetEnum(design, rng);
            case 1 -> genSetEnumItem(design, rng);
            default -> {
                /* neither */
            }
        }
    }

    public void genUpperLower(RandomGenerator rng) {
        upper.append(CslGenNumExprSupport.randNumExpr(rng));
        lower.append(CslGenNumExprSupport.randNumExpr(rng));
    }

    public void genCopyConstr(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !copyF) {
                copy.append(ch.getName());
                copyF = true;
            }
        }
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        int ranType;
        if (fieldTypeF) {
            ranType = rng.nextInt(CslGenFieldTables.FIELD_TYPE_DECL_SIZE - 1);
        } else {
            ranType = rng.nextInt(CslGenFieldTables.FIELD_TYPE_DECL_SIZE);
        }
        boolean ok = false;
        CslGenCslBase design = getParent().orElse(null);

        switch (ranType) {
            case WIDTH -> {
                genSetWidth(design, rng);
                genEnum(design, rng);
            }
            case UPPER_LOWER -> {
                genUpperLower(rng);
                genEnum(design, rng);
            }
            case COPY_CONSTR -> genCopyConstr(design, rng);
            case CONSTR -> {
                for (int j = 0; j < CslGenFieldTables.FIELDS_NO; j++) {
                    String n = CslGenRandString.randString(rng);
                    if (newNameIsValid(n)) {
                        CslGenField child = new CslGenField(this, n);
                        child.fieldTypeF = true;
                        if (child.buildDecl(rng)) {
                            addChild(child);
                        }
                    }
                }
                if (CslGenFieldTables.FIELDS_NO != 0) {
                    hierarchicalF = true;
                }
                int ranWidth = rng.nextInt(3);
                if (hierarchicalF) {
                    switch (ranWidth) {
                        case 0 -> {
                            genSetWidth(design, rng);
                            used[SET_WIDTH] = 1;
                        }
                        case 1 -> {
                            genSetRange(design, rng);
                            used[SET_RANGE] = 1;
                        }
                        case 2 -> {
                            genSetBitrange(design, rng);
                            used[SET_BITRANGE] = 1;
                        }
                        default -> {
                            /* unused */
                        }
                    }
                }
                int cmdNo = rng.nextInt(CslGenFieldTables.FIELD_CMD);
                for (int c = 0; c < cmdNo; c++) {
                    int ran = rng.nextInt(CslGenFieldTables.FIELD_USED_VECTOR_SIZE);
                    if (used[ran] != 0) {
                        continue;
                    }
                    if ((ran == SET_ENUM || ran == SET_ENUM_ITEM || ran == SET_VALUE) && !ok && !hierarchicalF) {
                        switch (ran) {
                            case SET_ENUM -> {
                                genSetEnum(design, rng);
                                used[SET_ENUM] = 1;
                            }
                            case SET_ENUM_ITEM -> {
                                genSetEnumItem(design, rng);
                                used[SET_ENUM_ITEM] = 1;
                            }
                            case SET_VALUE -> {
                                genSetValue(rng);
                                used[SET_VALUE] = 1;
                            }
                            default -> {
                                /* unreachable */
                            }
                        }
                        ok = true;
                    } else if (ran == GET_ENUM
                            || ran == GET_ENUM_ITEM
                            || (ran == GET_VALUE && !hierarchicalF)) {
                        switch (ran) {
                            case GET_ENUM -> {
                                if (getFieldUsedAt(SET_ENUM) != 0) {
                                    used[GET_ENUM] = 1;
                                }
                            }
                            case GET_ENUM_ITEM -> {
                                if (getFieldUsedAt(SET_ENUM_ITEM) != 0) {
                                    used[GET_ENUM_ITEM] = 1;
                                }
                            }
                            case GET_VALUE -> {
                                if (getFieldUsedAt(SET_VALUE) != 0) {
                                    used[GET_VALUE] = 1;
                                }
                            }
                            default -> {
                                /* unreachable */
                            }
                        }
                    } else if (ran >= SET_FIELD_POS && ran <= SET_PREVIOUS) {
                        switch (ran) {
                            case SET_FIELD_POS -> {
                                genSetFieldPos(rng);
                                used[SET_FIELD_POS] = 1;
                            }
                            case SET_NEXT -> {
                                genNext(rng);
                                used[SET_NEXT] = 1;
                            }
                            case SET_PREVIOUS -> {
                                genPrevious(rng);
                                used[SET_PREVIOUS] = 1;
                            }
                            default -> {
                                /* unused */
                            }
                        }
                    } else {
                        switch (ran) {
                            case GET_WIDTH:
                                used[GET_WIDTH] = 1;
                                break;
                            case GET_UPPER:
                                used[GET_UPPER] = 1;
                                break;
                            case GET_LOWER:
                                used[GET_LOWER] = 1;
                                break;
                            case SET_OFFSET:
                                genSetOffset(design, rng);
                                used[SET_OFFSET] = 1;
                                used[GET_OFFSET] = 1;
                                break;
                            case GET_OFFSET:
                                if (getFieldUsedAt(SET_OFFSET) != 0) {
                                    used[GET_OFFSET] = 1;
                                }
                                break;
                            case ADD_ALLOWED_RANGE:
                                genAllowedRange(rng);
                                used[ADD_ALLOWED_RANGE] = 1;
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
            default -> {
                /* unreachable */
            }
        }
        usedTypeDecl[ranType] = 1;
        return !(usedTypeDecl[COPY_CONSTR] != 0 && !copyF);
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        if (!(usedTypeDecl[COPY_CONSTR] != 0 && !copyF)) {
            CslGenSupportEmit.cslField(out);
            out.append(getName());
        }
        for (int i = 0; i < CslGenFieldTables.FIELD_TYPE_DECL_SIZE - 1; i++) {
            if (usedTypeDecl[i] == 0) {
                continue;
            }
            switch (i) {
                case WIDTH -> {
                    CslGenSupportEmit.lParenthesis(out);
                    out.append(width);
                    if (getFieldUsedAt(SET_ENUM) != 0 || getFieldUsedAt(SET_ENUM_ITEM) != 0) {
                        CslGenSupportEmit.comma(out);
                    }
                }
                case UPPER_LOWER -> {
                    CslGenSupportEmit.lParenthesis(out);
                    out.append(upper);
                    CslGenSupportEmit.comma(out);
                    out.append(lower);
                    if (getFieldUsedAt(SET_ENUM) != 0 || getFieldUsedAt(SET_ENUM_ITEM) != 0) {
                        CslGenSupportEmit.comma(out);
                    }
                }
                case COPY_CONSTR -> {
                    if (copyF) {
                        CslGenSupportEmit.lParenthesis(out);
                        out.append(copy);
                        if (getFieldUsedAt(SET_ENUM) != 0 || getFieldUsedAt(SET_ENUM_ITEM) != 0) {
                            CslGenSupportEmit.comma(out);
                        }
                    } else {
                        out.append("\n this was checked once!!! \n \n");
                    }
                }
                default -> {
                    /* unused index */
                }
            }
            if (usedTypeDecl[i] != usedTypeDecl[CONSTR]) {
                if (getFieldUsedAt(SET_ENUM) != 0) {
                    out.append(enumName);
                } else if (getFieldUsedAt(SET_ENUM_ITEM) != 0) {
                    out.append(enumItem);
                }
                if (!(usedTypeDecl[COPY_CONSTR] != 0 && !copyF)) {
                    CslGenSupportEmit.rParenthesis(out);
                    CslGenSupportEmit.semicolon(out);
                }
            }
        }
        if (usedTypeDecl[CONSTR] != 0) {
            CslGenSupportEmit.lCbrace(out);
            for (CslGenCslBase ch : getChildren()) {
                out.append("  ");
                ch.print();
            }
            out.append("    ").append(getName());
            CslGenSupportEmit.lParenthesis(out);
            CslGenSupportEmit.rParenthesis(out);
            CslGenSupportEmit.lCbrace(out);
            for (int ui = 0; ui < CslGenFieldTables.FIELD_USED_VECTOR_SIZE; ui++) {
                if (used[ui] == 0) {
                    continue;
                }
                switch (ui) {
                    case SET_WIDTH -> CslGenSupportEmit.funct1param(out, CslGenFieldTables.FIELD_FUNCTION[ui], width.toString());
                    case SET_BITRANGE -> {
                        if (bitrangeF) {
                            CslGenSupportEmit.funct1param(out, CslGenFieldTables.FIELD_FUNCTION[ui], bitrange.toString());
                        }
                    }
                    case SET_RANGE -> CslGenSupportEmit.funct1param(out, CslGenFieldTables.FIELD_FUNCTION[ui], range.toString());
                    case SET_ENUM -> {
                        if (enumF) {
                            CslGenSupportEmit.funct1param(out, CslGenFieldTables.FIELD_FUNCTION[ui], enumName.toString());
                        }
                    }
                    case SET_ENUM_ITEM -> {
                        if (enumItemF) {
                            CslGenSupportEmit.funct1param(out, CslGenFieldTables.FIELD_FUNCTION[ui], enumItem.toString());
                        }
                    }
                    case SET_VALUE -> CslGenSupportEmit.funct1param(out, CslGenFieldTables.FIELD_FUNCTION[ui], value.toString());
                    case SET_FIELD_POS -> {
                        if (posF) {
                            for (int it = 0; it < posField.size(); it++) {
                                CslGenSupportEmit.funct2param(
                                        out, CslGenFieldTables.FIELD_FUNCTION[ui], posField.get(it), posNumExpr.get(it));
                            }
                        }
                    }
                    case SET_NEXT -> {
                        if (nextF) {
                            for (int it1 = 0; it1 < nextLeft.size(); it1++) {
                                CslGenSupportEmit.funct2param(
                                        out, CslGenFieldTables.FIELD_FUNCTION[ui], nextLeft.get(it1), nextRight.get(it1));
                            }
                        }
                    }
                    case SET_PREVIOUS -> {
                        if (prevF) {
                            for (int it2 = 0; it2 < prevLeft.size(); it2++) {
                                CslGenSupportEmit.funct2param(
                                        out, CslGenFieldTables.FIELD_FUNCTION[ui], prevLeft.get(it2), prevRight.get(it2));
                            }
                        }
                    }
                    case SET_OFFSET -> CslGenSupportEmit.funct1param(out, CslGenFieldTables.FIELD_FUNCTION[ui], offset.toString());
                    case ADD_ALLOWED_RANGE -> CslGenSupportEmit.funct1param(
                            out, CslGenFieldTables.FIELD_FUNCTION[ui], allowedRange.toString());
                    default -> {
                        /* GET_* omitted */
                    }
                }
            }
            out.append("  ");
            CslGenSupportEmit.rCbrace(out);
            CslGenSupportEmit.rCbrace(out);
            CslGenSupportEmit.semicolon(out);
        }
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }

    public String getEnumNameText() {
        return enumName.toString();
    }

    public String getEnumItemText() {
        return enumItem.toString();
    }

    public String getValueText() {
        return value.toString();
    }

    public String getWidthText() {
        return width.toString();
    }

    public String getBitrangeText() {
        return bitrange.toString();
    }

    public String getRangeText() {
        return range.toString();
    }

    public String getOffsetText() {
        return offset.toString();
    }

    public String getUpperText() {
        return upper.toString();
    }

    public String getLowerText() {
        return lower.toString();
    }

    public String getAllowedRangeText() {
        return allowedRange.toString();
    }

    public String getCopyText() {
        return copy.toString();
    }

    public List<String> getPosFieldNames() {
        return Collections.unmodifiableList(posField);
    }

    public List<String> getPosNumExprs() {
        return Collections.unmodifiableList(posNumExpr);
    }

    public List<String> getNextLeftStrings() {
        return Collections.unmodifiableList(nextLeft);
    }

    public List<String> getNextRightStrings() {
        return Collections.unmodifiableList(nextRight);
    }

    public List<String> getPrevLeftStrings() {
        return Collections.unmodifiableList(prevLeft);
    }

    public List<String> getPrevRightStrings() {
        return Collections.unmodifiableList(prevRight);
    }

    public boolean isCopyF() {
        return copyF;
    }

    public boolean isBitrangeF() {
        return bitrangeF;
    }

    public boolean isEnumF() {
        return enumF;
    }

    public boolean isEnumItemF() {
        return enumItemF;
    }

    /** {@code m_fieldType}. */
    public boolean isFieldTypeF() {
        return fieldTypeF;
    }

    public boolean isPosF() {
        return posF;
    }

    public boolean isNextF() {
        return nextF;
    }

    public boolean isPrevF() {
        return prevF;
    }

    public boolean isHierarchicalF() {
        return hierarchicalF;
    }
}
