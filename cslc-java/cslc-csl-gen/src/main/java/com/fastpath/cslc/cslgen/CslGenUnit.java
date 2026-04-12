package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code Unit} ({@code csl_gen_unit.h} / {@code csl_gen_unit.cpp}). Trunk header names {@code Base}; the
 * implementation is the interconnect {@code CSLbase} hierarchy.
 */
public final class CslGenUnit extends CslGenCslBase {

    public CslGenUnit(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_UNIT, parent, name);
    }

    /**
     * Legacy {@code CSLunit::addRegFileInst()} ({@code cslRegister.cpp}): for each {@link CslGenCslType#CSL_REG_FILE}
     * child of the parent design, add a {@link CslGenInstance} under this unit.
     */
    public void addRegFileInst(RandomGenerator rng) {
        CslGenCslBase design = getParent().orElse(null);
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_REG_FILE) {
                String name = CslGenRandString.randString(rng);
                if (newNameIsValid(name)) {
                    CslGenInstance inst = new CslGenInstance(this, ch, name);
                    addChild(inst);
                }
            }
        }
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
