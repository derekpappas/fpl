package com.fastpath.cslc.cslgen;

/**
 * Port of {@code Unit} ({@code csl_gen_unit.h} / {@code csl_gen_unit.cpp}). Trunk header names {@code Base}; the
 * implementation is the interconnect {@code CSLbase} hierarchy.
 */
public final class CslGenUnit extends CslGenCslBase {

    public CslGenUnit(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_UNIT, parent, name);
    }

    @Override
    public boolean buildDecl() {
        return true;
    }

    @Override
    public void print() {
        // No legacy body in trunk {@code csl_gen_unit.cpp}.
    }
}
