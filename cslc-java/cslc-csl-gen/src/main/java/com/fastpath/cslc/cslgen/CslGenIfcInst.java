package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLifcInst}:
 * {@code trunk/cslc/trunk/csl_gen/cslInterconnectGen_TB.h} (class ~351-371),
 * {@code trunk/cslc/trunk/csl_gen/cslInterconnectGen_TB.cpp} (impl ~659-695).
 */
public final class CslGenIfcInst extends CslGenCslBase {

    private CslGenIfc instType;

    public CslGenIfcInst(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_IFC_INST, parent, name);
    }

    /** Legacy {@code CSLifcInst::getIfcType()} / {@code m_instType}. */
    public CslGenIfc getIfcType() {
        return instType;
    }

    /** Field view of {@code m_instType} (same as {@link #getIfcType()}, cf. {@link CslGenUnitInst#getInstUnit()}). */
    public CslGenIfc getInstType() {
        return instType;
    }

    /** Same as {@link #getIfcType()} — convenient alias alongside {@link CslGenUnitInst#getUnit()}. */
    public CslGenIfc getIfc() {
        return instType;
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    /** Legacy {@code CSLifcInst::randSelIfc()} ({@code cslInterconnectGen_TB.cpp}). */
    public CslGenScopedSelection randSelIfc(RandomGenerator rng) {
        return randSelObj(CslGenCslType.CSL_IFC, rng);
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenScopedSelection sel = randSelIfc(rng);
        if (sel.selected() != null && !getName().equals(sel.selected().getName())) {
            instType = (CslGenIfc) sel.selected();
            return true;
        }
        return false;
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null || instType == null) {
            return;
        }
        CslGenSupportEmit.decl0param(out, instType.getName(), getName());
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
