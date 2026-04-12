package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLdesign} ({@code csl_gen_design.h} / {@code csl_gen_design.cpp}).
 *
 * <p>{@link #buildDecl(RandomGenerator)} follows {@code CSLdesign::buildDecl()} in {@code cslInterconnectGen_TB.cpp} for
 * interconnect generators, and adds {@code cGenIsa_ao} ISA instruction format / instruction / {@code csl_isa} blocks
 * after units so {@code gen_decoder} can see {@code CSL_UNIT} children.
 */
public final class CslGenDesign extends CslGenCslBase {

    public CslGenDesign(String name) {
        super(CslGenCslType.CSL_DESIGN, null, name);
    }

    /** Legacy {@code CSLdesign::addBitrange()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addBitrange(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenBitrange br = new CslGenBitrange(this, n);
            if (br.buildDecl(rng)) {
                addChild(br);
            }
        }
    }

    /** Legacy {@code CSLdesign::addSignal()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addSignal(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenSignal sig = new CslGenSignal(this, n);
            if (sig.buildDecl(rng)) {
                addChild(sig);
            }
        }
    }

    /** Legacy {@code CSLdesign::addIfc()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addIfc(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenIfc ifc = new CslGenIfc(this, n);
            if (ifc.buildDecl(rng)) {
                addChild(ifc);
            }
        }
    }

    /** Legacy {@code CSLdesign::addUnit()} ({@code cslInterconnectGen_TB.cpp}). */
    public void addUnit(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenUnit u = new CslGenUnit(this, n);
            if (u.buildDecl(rng)) {
                addChild(u);
            }
        }
    }

    /** Legacy {@code CSLdesign::addEnum()} ({@code cslGenEnumFieldEM.cpp}). */
    public void addEnum(RandomGenerator rng) {
        String n = CslGenRandString.randString(rng);
        if (newNameIsValid(n)) {
            CslGenEnum en = new CslGenEnum(this, n);
            if (en.buildDecl(rng)) {
                addChild(en);
            }
        }
    }

    /** Legacy {@code CSLdesign::addField()} ({@code cslField.cpp}). */
    public void addField(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenField field = new CslGenField(this, name);
            if (rng.nextBoolean()) {
                for (int i = 0; i < CslGenFieldTables.FIELD_INSTANCE_NO; i++) {
                    field.addFieldInstance(this, rng);
                }
            }
            if (field.buildDecl(rng)) {
                addChild(field);
            }
        }
    }

    /** Legacy {@code CSLdesign::addMemory()} ({@code cslMemory.cpp}). */
    public void addMemory(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenMemory mem = new CslGenMemory(this, name);
            mem.buildDecl(rng);
            addChild(mem);
        }
    }

    /** Legacy {@code CSLdesign::addRegister()} ({@code cslRegister.cpp}). */
    public void addRegister(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenRegister reg = new CslGenRegister(this, name);
            reg.buildDecl(rng);
            addChild(reg);
        }
    }

    /** Legacy {@code CSLdesign::addRegisterFile()} ({@code cslRegister.cpp}). */
    public void addRegisterFile(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenRegisterFile rf = new CslGenRegisterFile(this, name);
            rf.buildDecl(rng);
            addChild(rf);
        }
    }

    /** Legacy {@code CSLdesign::addFifo()} ({@code cGenFifo_ao.cpp}). */
    public void addFifo(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenFifo fifo = new CslGenFifo(this, name);
            fifo.buildDecl(rng);
            addChild(fifo);
        }
    }

    /** Legacy {@code CSLdesign::addMemMapPage()} ({@code cslMemoryMap.cpp}). */
    public void addMemMapPage(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenMemMapPage page = new CslGenMemMapPage(this, name);
            if (rng.nextBoolean()) {
                for (int i = 0; i < CslGenMemoryMapTables.MMP_INSTANCE_NO; i++) {
                    page.addMemMapPageInstance(this, rng);
                }
            }
            page.buildDecl(rng);
            addChild(page);
        }
    }

    /** Legacy {@code CSLdesign::addMemMap()} ({@code cslMemoryMap.cpp}). */
    public void addMemMap(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenMemMap mm = new CslGenMemMap(this, name);
            for (int i = 0; i < CslGenMemoryMapTables.MM_INSTANCE_NO; i++) {
                mm.addMemMapPageInstance(this, rng);
            }
            mm.buildDecl(rng);
            addChild(mm);
        }
    }

    /** Legacy {@code CSLdesign::addIsaField()} ({@code cslIsa.cpp}). */
    public void addIsaField(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenIsaField f = new CslGenIsaField(this, name);
            if (rng.nextBoolean()) {
                for (int i = 0; i < CslGenIsaTables.ISA_FIELD_INSTANCE_NO; i++) {
                    f.addFieldInstance(this, rng);
                }
            }
            if (f.buildDecl(rng)) {
                addChild(f);
            }
        }
    }

    /** Legacy {@code CSLdesign::addIsaElement()} ({@code cslIsa.cpp}). */
    public void addIsaElement(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenIsaElement el = new CslGenIsaElement(this, name);
            if (rng.nextBoolean()) {
                for (int i = 0; i < CslGenIsaTables.ISA_ELEMENT_INSTANCE_NO; i++) {
                    el.addIsaElementInstance(this, rng);
                }
                el.buildDecl(rng);
                addChild(el);
            }
        }
    }

    /** Legacy {@code CSLdesign::addIsaInstrFormat()} ({@code cGenIsa_ao.cpp}). */
    public void addIsaInstrFormat(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (newNameIsValid(name)) {
            CslGenIsaInstrFormat fmt = new CslGenIsaInstrFormat(this, name);
            fmt.buildDecl(rng);
            addChild(fmt);
        }
    }

    /** Legacy {@code CSLdesign::addIsaInstr()} ({@code cGenIsa_ao.cpp}). */
    public void addIsaInstr(RandomGenerator rng) {
        for (CslGenCslBase ch : getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_ISA_INSTR_FORMAT) {
                if (rng.nextBoolean()) {
                    String name = CslGenRandString.randString(rng);
                    if (newNameIsValid(name)) {
                        CslGenIsaInstr instr = new CslGenIsaInstr(this, name);
                        instr.buildDecl(rng);
                        instr.setInst(ch.getName());
                        addChild(instr);
                        return;
                    }
                }
            }
        }
    }

    /** Legacy {@code CSLdesign::addIsa()} ({@code cGenIsa_ao.cpp}). */
    public void addIsa(RandomGenerator rng) {
        String name = CslGenRandString.randString(rng);
        if (!newNameIsValid(name)) {
            return;
        }
        CslGenIsa isa = new CslGenIsa(this, name);
        isa.buildDecl(rng);
        if (rng.nextBoolean()) {
            for (int i = 0; i < CslGenIsaAoTables.ISA_INSTANCE_NO; i++) {
                isa.addIsaInstance(this, rng);
            }
        }
        addChild(isa);
    }

    /**
     * Legacy {@code CSLdesign::buildDecl()} ({@code cslInterconnectGen_TB.cpp}) — only ported {@code add*} steps are
     * included; see class Javadoc for gaps.
     */
    public boolean buildDecl(RandomGenerator rng) {
        for (int i = 0; i < 3; i++) {
            addSignal(rng);
        }
        for (int i = 0; i < 4; i++) {
            addBitrange(rng);
        }
        for (int i = 0; i < 5; i++) {
            addIfc(rng);
        }
        for (int i = 0; i < 3; i++) {
            addEnum(rng);
        }
        for (int i = 0; i < 7; i++) {
            addField(rng);
        }
        for (int i = 0; i < 4; i++) {
            addRegister(rng);
        }
        for (int i = 0; i < 2; i++) {
            addRegisterFile(rng);
        }
        for (int i = 0; i < 4; i++) {
            addIsaField(rng);
        }
        for (int i = 0; i < 4; i++) {
            addIsaElement(rng);
        }
        for (int i = 0; i < 3; i++) {
            addFifo(rng);
        }
        for (int i = 0; i < 4; i++) {
            addUnit(rng);
        }
        for (int i = 0; i < 3; i++) {
            addIsaInstrFormat(rng);
        }
        for (int i = 0; i < 8; i++) {
            addIsaInstr(rng);
        }
        addIsa(rng);
        for (int i = 0; i < 3; i++) {
            addMemMapPage(rng);
        }
        for (int i = 0; i < 3; i++) {
            addMemory(rng);
        }
        addMemMap(rng);
        return true;
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    @Override
    public void print() {
        StringBuilder mOut = printSink();
        if (mOut == null) {
            return;
        }
        mOut.append("//Automatically generated by cGen_ao.cpp\n");
        mOut.append("//DO NOT MODIFY!\n");
        mOut.append("//Legal test case \n");
        for (CslGenCslBase ch : getChildren()) {
            ch.print();
            mOut.append('\n');
        }
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
