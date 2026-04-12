package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLunitInst} ({@code cslInterconnectGen_TB.h} / {@code cslInterconnectGen_TB.cpp}).
 */
public final class CslGenUnitInst extends CslGenCslBase {

    private CslGenUnit instUnit;

    public CslGenUnitInst(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_UNIT_INST, parent, name);
    }

    public CslGenUnit getInstUnit() {
        return instUnit;
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenScopedSelection sel = randSelObj(CslGenCslType.CSL_UNIT, rng);
        if (sel.selected() != null && !getName().equals(sel.selected().getName())) {
            instUnit = (CslGenUnit) sel.selected();
            return true;
        }
        return false;
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null || instUnit == null) {
            return;
        }
        CslGenSupportEmit.decl0param(out, instUnit.getName(), getName());
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
