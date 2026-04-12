package com.fastpath.cslc.cslgen;

/**
 * Port of {@code NSCSLinterconnect::CSLdesign} ({@code csl_gen_design.h} / {@code csl_gen_design.cpp}). Active
 * random ISA-instrument build is still TODO (legacy {@code addIsaInstrFormat} is commented in {@code buildDecl}).
 */
public final class CslGenDesign extends CslGenCslBase {

    public CslGenDesign(String name) {
        super(CslGenCslType.CSL_DESIGN, null, name);
    }

    @Override
    public boolean buildDecl() {
        return true;
    }

    @Override
    public void print() {
        // Legacy stub — output wiring not ported.
    }
}
