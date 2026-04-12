package com.fastpath.cslc.cslgen;

import java.util.Objects;

/**
 * Port of {@code NSCSLinterconnect::CSLfieldInst} ({@code cslGenEnumFieldEM.cpp}) / type {@code CSL_FIELD_INST}
 * ({@code cslInterconnectGen_TB.h}). TB {@code cslField.cpp} uses {@code CSLinstance} for the same emission shape;
 * Java uses this node so {@link CslGenCslType#CSL_FIELD_INST} appears in the tree like the header enum.
 */
public final class CslGenFieldInst extends CslGenCslBase {

    private final CslGenCslBase fieldObj;

    public CslGenFieldInst(CslGenCslBase parent, CslGenCslBase field, String name) {
        super(CslGenCslType.CSL_FIELD_INST, parent, name);
        this.fieldObj = Objects.requireNonNull(field, "field");
        if (field.getType() != CslGenCslType.CSL_FIELD) {
            throw new IllegalArgumentException("field must be CSL_FIELD");
        }
    }

    public CslGenCslBase getFieldObj() {
        return fieldObj;
    }

    /** Same as {@link #getFieldObj()} (cf. {@link CslGenInstance#getInstObj()}). */
    public CslGenCslBase getInstObj() {
        return fieldObj;
    }

    /** Narrow view of the instantiated {@code csl_field}. */
    public CslGenField getInstField() {
        return (CslGenField) fieldObj;
    }

    /**
     * Legacy {@code CSLfieldInst::m_field_inst} string used in {@code print()} ({@code cslGenEnumFieldEM.cpp}) — the
     * referenced {@code csl_field} type name (equivalent to {@link #getFieldObj()} {@link CslGenCslBase#getName()}).
     */
    public String getFieldInstTypeName() {
        return fieldObj.getName();
    }

    /** {@code m_field_inst} as plain text (same as {@link #getFieldInstTypeName()}). */
    public String getFieldInstText() {
        return fieldObj.getName();
    }

    @Override
    public boolean buildDecl() {
        return true;
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        CslGenSupportEmit.decl0param(out, fieldObj.getName(), getName());
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
