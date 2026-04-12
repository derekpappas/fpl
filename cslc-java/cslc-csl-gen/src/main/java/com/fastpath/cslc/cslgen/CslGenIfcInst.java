package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLifcInst} ({@code cslInterconnectGen_TB.h} / {@code cslInterconnectGen_TB.cpp}).
 */
public final class CslGenIfcInst extends CslGenCslBase {

    private CslGenIfc instType;

    public CslGenIfcInst(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_IFC_INST, parent, name);
    }

    public CslGenIfc getIfcType() {
        return instType;
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenScopedSelection sel = randSelObj(CslGenCslType.CSL_IFC, rng);
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
