package com.fastpath.cslc.cslgen;

import java.util.Objects;

/**
 * Port of {@code NSCSLinterconnect::CSLinstance} ({@code cslInterconnectGen_TB.h} / {@code cslInterconnectGen_TB.cpp}).
 */
public final class CslGenInstance extends CslGenCslBase {

    private final CslGenCslBase instObj;

    public CslGenInstance(CslGenCslBase parent, CslGenCslBase instantiatedObj, String name) {
        super(CslGenCslType.CSL_INSTANCE, parent, name);
        this.instObj = Objects.requireNonNull(instantiatedObj, "instantiatedObj");
    }

    public CslGenCslBase getInstantiatedObj() {
        return instObj;
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
        CslGenSupportEmit.decl0param(out, instObj.getName(), getName());
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
