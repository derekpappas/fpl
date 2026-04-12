package com.fastpath.cslc.cslgen;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLisaField} ({@code cslIsa.h} / {@code cslIsa.cpp}).
 */
@SuppressWarnings("PMD.GodClass")
public final class CslGenIsaField extends CslGenCslBase {

    public static final int WIDTH = 0;
    public static final int UPPER_LOWER = 1;
    public static final int COPY_CONSTR = 2;
    public static final int CONSTR = 3;

    public static final int SET_TYPE = 0;
    public static final int GET_TYPE = 1;
    public static final int SET_WIDTH = 2;
    public static final int SET_RANGE = 3;
    public static final int SET_BITRANGE = 4;
    public static final int SET_ENUM = 5;
    public static final int GET_ENUM = 6;
    public static final int SET_ENUM_ITEM = 7;
    public static final int GET_ENUM_ITEM = 8;
    public static final int SET_VALUE = 9;
    public static final int GET_VALUE = 10;
    public static final int SET_FIELD_POS = 11;
    public static final int SET_NEXT = 12;
    public static final int SET_PREVIOUS = 13;
    public static final int GET_WIDTH = 14;
    public static final int GET_UPPER = 15;
    public static final int GET_LOWER = 16;
    public static final int SET_OFFSET = 17;
    public static final int GET_OFFSET = 18;
    public static final int ADD_ALLOWED_RANGE = 19;
    public static final int SET_NAME = 20;
    public static final int GET_NAME = 21;
    public static final int SET_MNEMONIC = 22;
    public static final int GET_MNEMONIC = 23;

    private final StringBuilder typeDecl = new StringBuilder();
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
    private final StringBuilder setName = new StringBuilder();
    private final StringBuilder setType = new StringBuilder();
    private final StringBuilder setMnemonic = new StringBuilder();

    private final List<String> posField = new ArrayList<>();
    private final List<String> posNumExpr = new ArrayList<>();
    private final List<String> nextLeft = new ArrayList<>();
    private final List<String> nextRight = new ArrayList<>();
    private final List<String> prevLeft = new ArrayList<>();
    private final List<String> prevRight = new ArrayList<>();

    private final int[] used = new int[CslGenIsaTables.ISA_FIELD_USED_VECTOR_SIZE];
    private final int[] usedTypeDecl = new int[CslGenIsaTables.ISA_FIELD_TYPE_DECL_SIZE];

    boolean copyF;
    boolean bitrangeF;
    boolean enumF;
    boolean enumItemF;
    boolean fieldTypeF;
    boolean elementTypeF;
    boolean printF;
    boolean posF;
    boolean nextF;
    boolean prevF;
    boolean hierarchicalF;

    public CslGenIsaField(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_ISA_FIELD, parent, name);
        Arrays.fill(used, 0);
        Arrays.fill(usedTypeDecl, 0);
    }

    boolean isaUsed(int idx) {
        return idx >= 0 && idx < used.length && used[idx] != 0;
    }

    public void addFieldInstance(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() != CslGenCslType.CSL_ISA_FIELD) {
                continue;
            }
            String n = CslGenRandString.randString(rng);
            if (newNameIsValid(n)) {
                addChild(new CslGenInstance(this, ch, n));
                hierarchicalF = true;
            }
        }
    }

    public void genSetWidth(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_ISA_FIELD) {
                    continue;
                }
                CslGenIsaField f = (CslGenIsaField) ch;
                if (rng.nextBoolean()
                        && !ok
                        && (f.isaUsed(SET_WIDTH) || f.isaUsed(SET_RANGE) || f.isaUsed(SET_BITRANGE))) {
                    width.append(ch.getName()).append('.').append(CslGenIsaTables.ISA_FIELD_FUNCTION[GET_WIDTH]).append("()");
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
                if (ch.getType() != CslGenCslType.CSL_ISA_FIELD) {
                    continue;
                }
                CslGenIsaField f = (CslGenIsaField) ch;
                if (rng.nextBoolean()
                        && !ok
                        && (f.isaUsed(SET_WIDTH) || f.isaUsed(SET_RANGE) || f.isaUsed(SET_BITRANGE))) {
                    range.append(ch.getName())
                            .append('.')
                            .append(CslGenIsaTables.ISA_FIELD_FUNCTION[GET_LOWER])
                            .append("(), ");
                    range.append(ch.getName()).append('.').append(CslGenIsaTables.ISA_FIELD_FUNCTION[GET_UPPER]).append("()");
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
                if (ch.getType() != CslGenCslType.CSL_ISA_FIELD) {
                    continue;
                }
                CslGenIsaField f = (CslGenIsaField) ch;
                if (rng.nextBoolean() && !ok && f.isaUsed(GET_OFFSET)) {
                    offset.append(ch.getName()).append('.').append(CslGenIsaTables.ISA_FIELD_FUNCTION[GET_OFFSET]).append("()");
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

    public void genSetPosition(RandomGenerator rng) {
        for (CslGenCslBase ch : getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_INSTANCE) {
                for (CslGenCslBase it : ch.getChildren()) {
                    if (rng.nextBoolean()) {
                        posField.add(it.getName());
                        posNumExpr.add(CslGenNumExprSupport.randNumExpr(rng));
                        ((CslGenIsaField) it).posF = true;
                        posF = true;
                    }
                }
            } else if (ch.getType() == CslGenCslType.CSL_ISA_FIELD) {
                if (rng.nextBoolean()) {
                    posField.add(ch.getName());
                    posNumExpr.add(CslGenNumExprSupport.randNumExpr(rng));
                    ((CslGenIsaField) ch).posF = true;
                    posF = true;
                }
            }
        }
    }

    public void genSetNext(RandomGenerator rng) {
        for (CslGenCslBase ch : getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_INSTANCE) {
                for (CslGenCslBase it1 : ch.getChildren()) {
                    CslGenIsaField f1 = (CslGenIsaField) it1;
                    if (f1.posF) {
                        List<CslGenCslBase> inner = ch.getChildren();
                        int idx = inner.indexOf(it1);
                        for (int j = idx + 1; j < inner.size(); j++) {
                            CslGenIsaField f2 = (CslGenIsaField) inner.get(j);
                            if (rng.nextBoolean() && !f2.posF && !f2.prevF) {
                                nextLeft.add(f1.getName());
                                nextRight.add(f2.getName());
                                f2.nextF = true;
                                nextF = true;
                            }
                        }
                    }
                }
            } else if (ch.getType() == CslGenCslType.CSL_ISA_FIELD) {
                CslGenIsaField f1 = (CslGenIsaField) ch;
                if (f1.posF) {
                    List<CslGenCslBase> all = getChildren();
                    int idx = all.indexOf(ch);
                    for (int j = idx + 1; j < all.size(); j++) {
                        CslGenCslBase o = all.get(j);
                        if (o.getType() != CslGenCslType.CSL_ISA_FIELD) {
                            continue;
                        }
                        CslGenIsaField f2 = (CslGenIsaField) o;
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

    public void genSetPrevious(RandomGenerator rng) {
        for (CslGenCslBase ch : getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_INSTANCE) {
                for (CslGenCslBase it1 : ch.getChildren()) {
                    CslGenIsaField f1 = (CslGenIsaField) it1;
                    if (f1.posF) {
                        List<CslGenCslBase> inner = ch.getChildren();
                        int idx = inner.indexOf(it1);
                        for (int j = idx + 1; j < inner.size(); j++) {
                            CslGenIsaField f2 = (CslGenIsaField) inner.get(j);
                            if (rng.nextBoolean() && !f2.posF && !f2.nextF) {
                                prevLeft.add(f1.getName());
                                prevRight.add(f2.getName());
                                f2.prevF = true;
                                prevF = true;
                            }
                        }
                    }
                }
            } else if (ch.getType() == CslGenCslType.CSL_ISA_FIELD) {
                CslGenIsaField f1 = (CslGenIsaField) ch;
                if (f1.posF) {
                    List<CslGenCslBase> all = getChildren();
                    int idx = all.indexOf(ch);
                    for (int j = idx + 1; j < all.size(); j++) {
                        CslGenCslBase o = all.get(j);
                        if (o.getType() != CslGenCslType.CSL_ISA_FIELD) {
                            continue;
                        }
                        CslGenIsaField f2 = (CslGenIsaField) o;
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
                /* case 2: neither */
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
            if (ch.getType() == CslGenCslType.CSL_ISA_FIELD && rng.nextBoolean() && !copyF) {
                copy.append(ch.getName());
                copyF = true;
            }
        }
    }

    public void genSetType(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_ISA_FIELD) {
                    continue;
                }
                CslGenIsaField f = (CslGenIsaField) ch;
                if (f.isaUsed(GET_TYPE) && rng.nextBoolean() && !ok) {
                    setType.append(ch.getName()).append('.').append(CslGenIsaTables.ISA_FIELD_FUNCTION[GET_TYPE]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            setType.append(CslGenIsaTables.ISA_FIELD_TYPE[rng.nextInt(CslGenIsaTables.ISA_FIELD_TYPE_NO)]);
        }
    }

    public void genSetName(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_ISA_FIELD) {
                    continue;
                }
                CslGenIsaField f = (CslGenIsaField) ch;
                if (f.isaUsed(GET_NAME) && rng.nextBoolean() && !ok) {
                    setName.append(ch.getName()).append('.').append(CslGenIsaTables.ISA_FIELD_FUNCTION[GET_NAME]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            setName.append('"').append(CslGenRandString.randString(rng)).append('"');
        }
    }

    public void genSetMnemonic(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_ISA_FIELD) {
                    continue;
                }
                CslGenIsaField f = (CslGenIsaField) ch;
                if (f.isaUsed(GET_MNEMONIC) && rng.nextBoolean() && !ok) {
                    setMnemonic
                            .append(ch.getName())
                            .append('.')
                            .append(CslGenIsaTables.ISA_FIELD_FUNCTION[GET_MNEMONIC])
                            .append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            setMnemonic.append('"').append(CslGenRandString.randString(rng)).append('"');
        }
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        int ranType;
        if (fieldTypeF || elementTypeF) {
            ranType = rng.nextInt(CslGenIsaTables.ISA_FIELD_TYPE_DECL_SIZE - 1);
        } else {
            ranType = rng.nextInt(CslGenIsaTables.ISA_FIELD_TYPE_DECL_SIZE);
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
                for (int j = 0; j < CslGenIsaTables.ISA_FIELDS_NO; j++) {
                    String n = CslGenRandString.randString(rng);
                    if (newNameIsValid(n)) {
                        CslGenIsaField child = new CslGenIsaField(this, n);
                        child.fieldTypeF = true;
                        child.buildDecl(rng);
                        addChild(child);
                    }
                }
                if (CslGenIsaTables.ISA_FIELDS_NO != 0) {
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
                int cmdNo = rng.nextInt(CslGenIsaTables.ISA_FIELD_CMD);
                for (int c = 0; c < cmdNo; c++) {
                    int ran = rng.nextInt(CslGenIsaTables.ISA_FIELD_USED_VECTOR_SIZE);
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
                                if (isaUsed(SET_ENUM)) {
                                    used[GET_ENUM] = 1;
                                }
                            }
                            case GET_ENUM_ITEM -> {
                                if (isaUsed(SET_ENUM_ITEM)) {
                                    used[GET_ENUM_ITEM] = 1;
                                }
                            }
                            case GET_VALUE -> {
                                if (isaUsed(SET_VALUE)) {
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
                                genSetPosition(rng);
                                used[SET_FIELD_POS] = 1;
                            }
                            case SET_NEXT -> {
                                genSetNext(rng);
                                used[SET_NEXT] = 1;
                            }
                            case SET_PREVIOUS -> {
                                genSetPrevious(rng);
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
                                break;
                            case GET_OFFSET:
                                if (isaUsed(SET_OFFSET)) {
                                    used[GET_OFFSET] = 1;
                                }
                                break;
                            case ADD_ALLOWED_RANGE:
                                genAllowedRange(rng);
                                used[ADD_ALLOWED_RANGE] = 1;
                                break;
                            case SET_NAME:
                                genSetName(design, rng);
                                used[SET_NAME] = 1;
                                // fall through
                            case GET_NAME:
                                if (isaUsed(SET_NAME)) {
                                    used[GET_NAME] = 1;
                                }
                                // fall through
                            case SET_MNEMONIC:
                                genSetMnemonic(design, rng);
                                used[SET_MNEMONIC] = 1;
                                // fall through
                            case GET_MNEMONIC:
                                if (isaUsed(SET_MNEMONIC)) {
                                    used[GET_MNEMONIC] = 1;
                                }
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
        if (!printF) {
            if (!(usedTypeDecl[COPY_CONSTR] != 0 && !copyF)) {
                CslGenSupportEmit.cslIsaField(out);
                out.append(getName());
            }
            int i = 0;
            while (usedTypeDecl[i] == 0 && i < CONSTR - 1) {
                i++;
            }
            if (usedTypeDecl[i] != 0) {
                switch (i) {
                    case WIDTH -> {
                        CslGenSupportEmit.lParenthesis(out);
                        out.append(width);
                        if (isaUsed(SET_ENUM) || isaUsed(SET_ENUM_ITEM)) {
                            CslGenSupportEmit.comma(out);
                        }
                    }
                    case UPPER_LOWER -> {
                        CslGenSupportEmit.lParenthesis(out);
                        out.append(upper);
                        CslGenSupportEmit.comma(out);
                        out.append(lower);
                        if (isaUsed(SET_ENUM) || isaUsed(SET_ENUM_ITEM)) {
                            CslGenSupportEmit.comma(out);
                        }
                    }
                    case COPY_CONSTR -> {
                        if (copyF) {
                            CslGenSupportEmit.lParenthesis(out);
                            out.append(copy);
                        }
                    }
                    default -> {
                        /* CONSTR alone: no paren block here */
                    }
                }
                if (usedTypeDecl[i] != usedTypeDecl[CONSTR]) {
                    if (isaUsed(SET_ENUM)) {
                        out.append(enumName);
                    } else if (isaUsed(SET_ENUM_ITEM)) {
                        out.append(enumItem);
                    }
                    if (!(usedTypeDecl[COPY_CONSTR] != 0 && !copyF)) {
                        CslGenSupportEmit.rParenthesis(out);
                        CslGenSupportEmit.semicolon(out);
                    }
                }
            }
        }
        boolean parentIsDesign = getParent().map(p -> p.getType() == CslGenCslType.CSL_DESIGN).orElse(false);
        if ((printF || parentIsDesign) && usedTypeDecl[CONSTR] == 0) {
            if (!(usedTypeDecl[COPY_CONSTR] != 0 && !copyF)) {
                if (isaUsed(SET_TYPE)) {
                    out.append(getName()).append('.').append(CslGenIsaTables.ISA_FIELD_FUNCTION[SET_TYPE]);
                    CslGenSupportEmit.lParenthesis(out);
                    out.append(setType);
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
            for (int ui = 0; ui < CslGenIsaTables.ISA_FIELD_USED_VECTOR_SIZE; ui++) {
                if (used[ui] == 0) {
                    continue;
                }
                switch (ui) {
                    case SET_WIDTH -> CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], width.toString());
                    case SET_BITRANGE -> {
                        if (bitrangeF) {
                            CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], bitrange.toString());
                        }
                    }
                    case SET_RANGE -> CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], range.toString());
                    case SET_ENUM -> {
                        if (enumF) {
                            CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], enumName.toString());
                        }
                    }
                    case SET_ENUM_ITEM -> {
                        if (enumItemF) {
                            CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], enumItem.toString());
                        }
                    }
                    case SET_VALUE -> CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], value.toString());
                    case SET_FIELD_POS -> {
                        if (posF) {
                            for (int it = 0; it < posField.size(); it++) {
                                CslGenSupportEmit.funct2param(
                                        out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], posField.get(it), posNumExpr.get(it));
                            }
                        }
                    }
                    case SET_NEXT -> {
                        if (nextF) {
                            for (int it1 = 0; it1 < nextLeft.size(); it1++) {
                                CslGenSupportEmit.funct2param(
                                        out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], nextLeft.get(it1), nextRight.get(it1));
                            }
                        }
                    }
                    case SET_PREVIOUS -> {
                        if (prevF) {
                            for (int it2 = 0; it2 < prevLeft.size(); it2++) {
                                CslGenSupportEmit.funct2param(
                                        out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], prevLeft.get(it2), prevRight.get(it2));
                            }
                        }
                    }
                    case SET_OFFSET -> CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], offset.toString());
                    case ADD_ALLOWED_RANGE -> CslGenSupportEmit.funct1param(
                            out, CslGenIsaTables.ISA_FIELD_FUNCTION[ui], allowedRange.toString());
                    case SET_TYPE -> {
                        out.append("     ").append(CslGenIsaTables.ISA_FIELD_FUNCTION[SET_TYPE]);
                        CslGenSupportEmit.lParenthesis(out);
                        out.append(setType);
                        CslGenSupportEmit.rParenthesis(out);
                        CslGenSupportEmit.semicolon(out);
                    }
                    default -> {
                        /* GET_* and others omitted in legacy print */
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
}
