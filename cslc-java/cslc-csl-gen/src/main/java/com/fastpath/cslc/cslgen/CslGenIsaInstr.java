package com.fastpath.cslc.cslgen;

import java.util.ArrayList;
import java.util.List;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLisaInstr} ({@code cGenIsa_ao.h} / {@code cGenIsa_ao.cpp}).
 */
public final class CslGenIsaInstr extends CslGenCslBase {

    private String inst = "";
    private int setAsmMnemonicOption;
    private String setAsmMnemonicString = "";
    private final List<String> setAsmMnemonicField = new ArrayList<>();
    private String genAsmMnemonicString = "";
    private final int[] used = new int[CslGenIsaAoTables.ISA_INSTR_USED_VECTOR_SIZE];

    private boolean setAsmMnemonicFieldF;
    private boolean setAsmMnemonicStringF;

    private static final int SET_ASM_MNEMONIC = 0;

    public CslGenIsaInstr(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_ISA_INSTR, parent, name);
    }

    void setInst(String formatName) {
        this.inst = formatName != null ? formatName : "";
    }

    /** Legacy {@code CSLisaInstr::m_inst} — instruction format name bound by {@link CslGenDesign#addIsaInstr}. */
    public String getInst() {
        return inst;
    }

    /** Legacy {@code m_used[SET_ASM_MNEMONIC]} for sibling scans in {@code genSetAsmMnemonic}. */
    boolean isSetAsmMnemonicUsed() {
        return used[SET_ASM_MNEMONIC] != 0;
    }

    private void genSetAsmMnemonic(CslGenCslBase design, RandomGenerator rng) {
        setAsmMnemonicOption = rng.nextInt(2);
        if (setAsmMnemonicOption == 0) {
            setAsmMnemonicString += "\"";
            setAsmMnemonicString += CslGenRandString.randString(rng);
            setAsmMnemonicString += "\"";

            boolean ok = false;
            if (design != null) {
                for (CslGenCslBase ch : design.getChildren()) {
                    if (ch.getType() == CslGenCslType.CSL_ISA_INSTR && ch != this) {
                        if (rng.nextBoolean()
                                && !ok
                                && ch instanceof CslGenIsaInstr other
                                && other.isSetAsmMnemonicUsed()) {
                            genAsmMnemonicString += ch.getName();
                            setAsmMnemonicStringF = true;
                            ok = true;
                        }
                    }
                }
            }
        } else {
            boolean ok = false;
            if (design != null) {
                for (CslGenCslBase ch : design.getChildren()) {
                    if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !ok) {
                        setAsmMnemonicField.add(ch.getName());
                        setAsmMnemonicFieldF = true;
                        ok = true;
                    }
                }
            }
        }
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenCslBase design = getParent().orElse(null);
        int rounds = rng.nextInt(CslGenIsaAoTables.ISA_INSTR_CMD);
        for (int i = 0; i < rounds; i++) {
            int ran = rng.nextInt(CslGenIsaAoTables.ISA_INSTR_USED_VECTOR_SIZE);
            if (used[ran] != 0) {
                continue;
            }
            if (ran == SET_ASM_MNEMONIC) {
                genSetAsmMnemonic(design, rng);
            }
            used[ran] = 1;
        }
        return true;
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        CslGenSupportEmit.cslIsaInstruction(out);
        out.append(getName());
        out.append(" : ").append(inst);
        CslGenSupportEmit.lCbrace(out);

        out.append("    ").append(getName());
        CslGenSupportEmit.lParenthesis(out);
        CslGenSupportEmit.rParenthesis(out);
        CslGenSupportEmit.lCbrace(out);

        if (used[SET_ASM_MNEMONIC] != 0) {
            if (setAsmMnemonicStringF) {
                out.append("    ").append(CslGenIsaAoTables.ISA_INSTR_FUNCTION[0]).append("( ");
                out.append(genAsmMnemonicString);
                CslGenSupportEmit.rParenthesis(out);
                CslGenSupportEmit.semicolon(out);
            } else if (setAsmMnemonicFieldF) {
                out.append("    ").append(CslGenIsaAoTables.ISA_INSTR_FUNCTION[0]).append("( ");
                out.append("csl_list ( ");
                for (int i = 0; i < setAsmMnemonicField.size() - 1; i++) {
                    out.append(setAsmMnemonicField.get(i)).append(", ");
                }
                if (!setAsmMnemonicField.isEmpty()) {
                    out.append(setAsmMnemonicField.get(setAsmMnemonicField.size() - 1));
                }
                out.append(") ");
                CslGenSupportEmit.rParenthesis(out);
                CslGenSupportEmit.semicolon(out);
            } else if (setAsmMnemonicOption == 0) {
                out.append("    ").append(CslGenIsaAoTables.ISA_INSTR_FUNCTION[0]).append("( ");
                out.append(setAsmMnemonicString);
                CslGenSupportEmit.rParenthesis(out);
                CslGenSupportEmit.semicolon(out);
            }
        }

        out.append("  ");
        CslGenSupportEmit.rCbrace(out);
        CslGenSupportEmit.rCbrace(out);
        CslGenSupportEmit.semicolon(out);
    }
}
