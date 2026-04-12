package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLenumItem} ({@code cslGenEnumFieldEM.cpp}).
 */
public final class CslGenEnumItem extends CslGenCslBase {

    private boolean valueSet;
    private int value;

    public CslGenEnumItem(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_ENUM_ITEM, parent, name);
    }

    /** Legacy {@code CSLenumItem::m_valueF}. */
    public boolean isValueSet() {
        return valueSet;
    }

    /** Legacy {@code CSLenumItem::m_value} (meaningful when {@link #isValueSet()}). */
    public int getValue() {
        return value;
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        value = rng.nextInt(100);
        valueSet = true;
        return true;
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        out.append('\t').append(getName());
        if (valueSet) {
            out.append(" = ").append(value);
        }
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
