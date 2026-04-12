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

    /** Legacy {@code CSLunit::addIfcInst()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addIfcInst(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenIfcInst inst = new CslGenIfcInst(this, n);
            if (inst.buildDecl(rng)) {
                addChild(inst);
            }
        }
    }

    /** Legacy {@code CSLunit::addUnitInst()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addUnitInst(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenUnitInst inst = new CslGenUnitInst(this, n);
            if (inst.buildDecl(rng)) {
                addChild(inst);
            }
        }
    }

    /** Legacy {@code CSLunit::addBitrange()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addBitrange(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenBitrange br = new CslGenBitrange(this, n);
            if (br.buildDecl(rng)) {
                addChild(br);
            }
        }
    }

    /** Legacy {@code CSLunit::addSignal()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addSignal(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenSignal sig = new CslGenSignal(this, n);
            if (sig.buildDecl(rng)) {
                addChild(sig);
            }
        }
    }

    /** Legacy {@code CSLunit::addPort()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addPort(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenPort p = new CslGenPort(this, n);
            if (p.buildDecl(rng)) {
                addChild(p);
            }
        }
    }

    /** Legacy {@code CSLunit::randSelPort()} ({@code cslInterconnectGen_TB.cpp}). */
    public CslGenScopedSelection randSelPort(RandomGenerator rng) {
        return randSelObj(CslGenCslType.CSL_PORT, rng);
    }

    /** Legacy {@code CSLunit::randSelSignal()} ({@code cslInterconnectGen_TB.cpp}). */
    public CslGenScopedSelection randSelSignal(RandomGenerator rng) {
        return randSelObj(CslGenCslType.CSL_SIGNAL, rng);
    }

    /** Legacy {@code CSLunit::randSelBitrange()} ({@code cslInterconnectGen_TB.cpp}). */
    public CslGenScopedSelection randSelBitrange(RandomGenerator rng) {
        return randSelObj(CslGenCslType.CSL_BITRANGE, rng);
    }

    /** Legacy {@code CSLunit::modifPort()} ({@code cslInterconnectGen_TB.cpp}); TB leaves calls commented in {@code print}. */
    public void modifPort(RandomGenerator rng) {
        CslGenScopedSelection p = randSelPort(rng);
        if (p.selected() instanceof CslGenPort port) {
            port.buildSet(p.scope(), rng);
        }
    }

    /** Legacy {@code CSLunit::modifSignal()} ({@code cslInterconnectGen_TB.cpp}). */
    public void modifSignal(RandomGenerator rng) {
        CslGenScopedSelection s = randSelSignal(rng);
        if (s.selected() instanceof CslGenSignal sig) {
            sig.buildSet(s.scope(), rng);
        }
    }

    /** Legacy {@code CSLunit::modifBitrange()} ({@code cslInterconnectGen_TB.cpp}). */
    public void modifBitrange(RandomGenerator rng) {
        CslGenScopedSelection b = randSelBitrange(rng);
        if (b.selected() instanceof CslGenBitrange br) {
            br.buildSet(b.scope(), rng);
        }
    }

    /**
     * Legacy {@code CSLunit::addFifoInst()} ({@code cGenFifo_ao.cpp}): for each {@link CslGenCslType#CSL_FIFO} child
     * of the parent design, add a {@link CslGenInstance} under this unit.
     */
    public void addFifoInst(RandomGenerator rng) {
        CslGenCslBase design = getParent().orElse(null);
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_FIFO) {
                String name = CslGenRandString.randString(rng);
                if (newNameIsValid(name)) {
                    CslGenInstance inst = new CslGenInstance(this, ch, name);
                    addChild(inst);
                }
            }
        }
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

    /**
     * Legacy {@code CSLunit::buildDecl()} ({@code cslInterconnectGen_TB.cpp}) — same counts of {@code add*} calls;
     * passes {@code rng} through to each helper.
     */
    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        for (int i = 0; i < 5; i++) {
            addUnitInst(rng);
        }
        for (int i = 0; i < 6; i++) {
            addBitrange(rng);
        }
        for (int i = 0; i < 4; i++) {
            addSignal(rng);
        }
        for (int i = 0; i < 6; i++) {
            addPort(rng);
        }
        for (int i = 0; i < 5; i++) {
            addIfcInst(rng);
        }
        addFifoInst(rng);
        addRegFileInst(rng);
        return true;
    }

    @Override
    public void print() {
        StringBuilder mOut = printSink();
        if (mOut == null) {
            return;
        }
        CslGenSupportEmit.declSHbegin(mOut, "csl_unit", getName());
        for (CslGenCslBase ch : getChildren()) {
            ch.print();
        }
        CslGenSupportEmit.constrSHbegin(mOut, getName());
        CslGenSupportEmit.constrSHend(mOut);
        CslGenSupportEmit.declSHend(mOut);
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
