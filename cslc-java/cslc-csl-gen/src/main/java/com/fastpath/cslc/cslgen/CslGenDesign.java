package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLdesign} ({@code csl_gen_design.h} / {@code csl_gen_design.cpp}). Active
 * random ISA-instrument build is still TODO (legacy {@code addIsaInstrFormat} is commented in {@code buildDecl}).
 */
public final class CslGenDesign extends CslGenCslBase {

    public CslGenDesign(String name) {
        super(CslGenCslType.CSL_DESIGN, null, name);
    }

    /** Legacy {@code CSLdesign::addMemory()} ({@code cslMemory.cpp}). */
    public void addMemory(RandomGenerator rng) {
        String name = CslGenRandString.randString();
        if (newNameIsValid(name)) {
            CslGenMemory mem = new CslGenMemory(this, name);
            mem.buildDecl(rng);
            addChild(mem);
        }
    }

    /** Legacy {@code CSLdesign::addRegister()} ({@code cslRegister.cpp}). */
    public void addRegister(RandomGenerator rng) {
        String name = CslGenRandString.randString();
        if (newNameIsValid(name)) {
            CslGenRegister reg = new CslGenRegister(this, name);
            reg.buildDecl(rng);
            addChild(reg);
        }
    }

    /** Legacy {@code CSLdesign::addRegisterFile()} ({@code cslRegister.cpp}). */
    public void addRegisterFile(RandomGenerator rng) {
        String name = CslGenRandString.randString();
        if (newNameIsValid(name)) {
            CslGenRegisterFile rf = new CslGenRegisterFile(this, name);
            rf.buildDecl(rng);
            addChild(rf);
        }
    }

    /** Legacy {@code CSLdesign::addFifo()} ({@code cGenFifo_ao.cpp}). */
    public void addFifo(RandomGenerator rng) {
        String name = CslGenRandString.randString();
        if (newNameIsValid(name)) {
            CslGenFifo fifo = new CslGenFifo(this, name);
            fifo.buildDecl(rng);
            addChild(fifo);
        }
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
