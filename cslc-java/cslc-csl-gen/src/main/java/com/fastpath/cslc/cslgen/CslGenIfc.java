package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLifc} ({@code cslInterconnectGen_TB.h} / {@code cslInterconnectGen_TB.cpp}).
 */
public final class CslGenIfc extends CslGenCslBase {

    public CslGenIfc(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_IFC, parent, name);
    }

    public void addIfcInst(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenIfcInst inst = new CslGenIfcInst(this, n);
            if (inst.buildDecl(rng)) {
                addChild(inst);
            }
        }
    }

    public void addPort(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenPort p = new CslGenPort(this, n);
            if (p.buildDecl(rng)) {
                addChild(p);
            }
        }
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        for (int i = 0; i < 4; i++) {
            addIfcInst(rng);
        }
        for (int i = 0; i < 4; i++) {
            addPort(rng);
        }
        return true;
    }

    @Override
    public void print() {
        StringBuilder mOut = printSink();
        if (mOut == null) {
            return;
        }
        CslGenSupportEmit.declSHbegin(mOut, "csl_interface", getName());
        for (CslGenCslBase ch : getChildren()) {
            ch.print();
        }
        CslGenSupportEmit.declSHend(mOut);
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
