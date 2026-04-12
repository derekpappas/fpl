package com.fastpath.cslc.cslgen;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLisaElement} ({@code cslIsa.h} / {@code cslIsa.cpp}).
 */
@SuppressWarnings("PMD.GodClass")
public final class CslGenIsaElement extends CslGenCslBase {

    public static final int SET_TYPE = 0;
    public static final int GET_TYPE = 1;
    public static final int SET_WIDTH = 2;
    public static final int GET_WIDTH = 3;
    public static final int SET_FIELD_POS = 4;
    public static final int SET_NEXT = 5;
    public static final int SET_PREVIOUS = 6;

    private final StringBuilder deriv = new StringBuilder();
    private final StringBuilder setType = new StringBuilder();
    private final StringBuilder width = new StringBuilder();
    private final List<String> posField = new ArrayList<>();
    private final List<String> posNumExpr = new ArrayList<>();
    private final List<String> nextLeft = new ArrayList<>();
    private final List<String> nextRight = new ArrayList<>();
    private final List<String> prevLeft = new ArrayList<>();
    private final List<String> prevRight = new ArrayList<>();

    private final int[] used = new int[CslGenIsaTables.ISA_ELEMENT_USED_VECTOR_SIZE];

    boolean derivF;
    boolean posF;
    boolean nextF;
    boolean prevF;

    public CslGenIsaElement(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_ISA_ELEMENT, parent, name);
        Arrays.fill(used, 0);
    }

    /** {@code m_used[slot]} ({@code CSLisaElement}). */
    public int getIsaElementUsedAt(int slot) {
        Objects.checkIndex(slot, used.length);
        return used[slot];
    }

    public void addIsaElementInstance(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() != CslGenCslType.CSL_ISA_FIELD) {
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

    public void genDeriv(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_ISA_ELEMENT && rng.nextBoolean() && !derivF) {
                deriv.append(ch.getName());
                derivF = true;
            }
        }
    }

    public void genSetType(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_ISA_ELEMENT) {
                    continue;
                }
                CslGenIsaElement el = (CslGenIsaElement) ch;
                if (el.getIsaElementUsedAt(GET_TYPE) != 0 && rng.nextBoolean() && !ok) {
                    setType.append(ch.getName()).append('.').append(CslGenIsaTables.ISA_ELEMENT_FUNCTION[GET_TYPE]).append("()");
                    ok = true;
                }
            }
        }
        if (!ok) {
            setType.append(CslGenIsaTables.ISA_ELEMENT_TYPE[rng.nextInt(CslGenIsaTables.ISA_ELEMENT_TYPE_NO)]);
        }
    }

    public void genSetWidth(CslGenCslBase design, RandomGenerator rng) {
        boolean ok = false;
        if (design != null) {
            for (CslGenCslBase ch : design.getChildren()) {
                if (ch.getType() != CslGenCslType.CSL_ISA_ELEMENT) {
                    continue;
                }
                CslGenIsaElement el = (CslGenIsaElement) ch;
                if (rng.nextBoolean() && !ok && el.getIsaElementUsedAt(SET_WIDTH) != 0) {
                    width.append(ch.getName()).append('.').append(CslGenIsaTables.ISA_ELEMENT_FUNCTION[GET_WIDTH]).append("()");
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

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenCslBase design = getParent().orElse(null);
        genDeriv(design, rng);
        genSetType(design, rng);

        for (int j = 0; j < CslGenIsaTables.ISA_FIELDS_NO; j++) {
            String n = CslGenRandString.randString(rng);
            if (newNameIsValid(n)) {
                CslGenIsaField isaField = new CslGenIsaField(this, n);
                isaField.elementTypeF = true;
                isaField.buildDecl(rng);
                addChild(isaField);
            }
        }

        int outer = rng.nextInt(CslGenIsaTables.ISA_ELEMENT_CMD);
        for (int k = 0; k < outer; k++) {
            int ran = rng.nextInt(CslGenIsaTables.ISA_ELEMENT_USED_VECTOR_SIZE);
            if (used[ran] != 0) {
                continue;
            }
            switch (ran) {
                case SET_WIDTH -> {
                    if ("root_format".contentEquals(setType)) {
                        genSetWidth(design, rng);
                        used[SET_WIDTH] = 1;
                    }
                }
                case SET_FIELD_POS -> genSetPosition(rng);
                case SET_NEXT -> genSetNext(rng);
                case SET_PREVIOUS -> genSetPrevious(rng);
                default -> {
                    /* other ran values: no switch body */
                }
            }
            if (ran == GET_TYPE && getIsaElementUsedAt(SET_TYPE) != 0) {
                used[GET_TYPE] = 1;
            } else if (ran == GET_WIDTH && getIsaElementUsedAt(SET_WIDTH) != 0) {
                used[GET_WIDTH] = 1;
            } else if (ran != SET_WIDTH) {
                used[ran] = 1;
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
        CslGenSupportEmit.cslIsaElement(out);
        out.append(getName());
        if (derivF) {
            out.append(" : ").append(deriv);
        }
        CslGenSupportEmit.lCbrace(out);
        for (CslGenCslBase ch : getChildren()) {
            out.append("  ");
            ch.print();
        }
        out.append("    ").append(getName());
        CslGenSupportEmit.lParenthesis(out);
        CslGenSupportEmit.rParenthesis(out);
        CslGenSupportEmit.lCbrace(out);
        for (int i = 0; i < CslGenIsaTables.ISA_ELEMENT_USED_VECTOR_SIZE; i++) {
            if (used[i] == 0) {
                continue;
            }
            switch (i) {
                case SET_TYPE -> CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_ELEMENT_FUNCTION[i], setType.toString());
                case SET_WIDTH -> CslGenSupportEmit.funct1param(out, CslGenIsaTables.ISA_ELEMENT_FUNCTION[i], width.toString());
                case SET_FIELD_POS -> {
                    if (posF) {
                        for (int it = 0; it < posField.size(); it++) {
                            CslGenSupportEmit.funct2param(
                                    out, CslGenIsaTables.ISA_ELEMENT_FUNCTION[i], posField.get(it), posNumExpr.get(it));
                        }
                    }
                }
                case SET_NEXT -> {
                    if (nextF) {
                        for (int it1 = 0; it1 < nextLeft.size(); it1++) {
                            CslGenSupportEmit.funct2param(
                                    out, CslGenIsaTables.ISA_ELEMENT_FUNCTION[i], nextLeft.get(it1), nextRight.get(it1));
                        }
                    }
                }
                case SET_PREVIOUS -> {
                    if (prevF) {
                        for (int it2 = 0; it2 < prevLeft.size(); it2++) {
                            CslGenSupportEmit.funct2param(
                                    out, CslGenIsaTables.ISA_ELEMENT_FUNCTION[i], prevLeft.get(it2), prevRight.get(it2));
                        }
                    }
                }
                default -> {
                    /* GET_* omitted */
                }
            }
        }
        for (CslGenCslBase ch : getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_ISA_FIELD) {
                ((CslGenIsaField) ch).printF = true;
                out.append("     ");
                ch.print();
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

    /** {@code m_deriv}. */
    public String getDerivText() {
        return deriv.toString();
    }

    /** {@code m_setType}. */
    public String getSetTypeText() {
        return setType.toString();
    }

    /** {@code m_width}. */
    public String getWidthText() {
        return width.toString();
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

    /** {@code m_derivF}. */
    public boolean isDerivF() {
        return derivF;
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
}
