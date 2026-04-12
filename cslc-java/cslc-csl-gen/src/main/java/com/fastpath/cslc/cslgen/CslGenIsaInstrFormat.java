package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLisaInstrFormat} ({@code cGenIsa_ao.h} / {@code cGenIsa_ao.cpp}).
 */
public final class CslGenIsaInstrFormat extends CslGenCslBase {

    private String formatName = "";
    private String widthNumExpr = "";
    private String fieldName = "";
    private String fieldPosNumExpr = "";
    private String nLeftFieldName = "";
    private String nRightFieldName = "";
    private String pLeftFieldName = "";
    private String pRightFieldName = "";
    private String decoderUnitName = "";
    private final int[] used = new int[CslGenIsaAoTables.ISA_INSTR_FORMAT_USED_VECTOR_SIZE];

    private boolean fieldNameF;
    private boolean nLeftFieldNameF;
    private boolean nRightFieldNameF;
    private boolean pLeftFieldNameF;
    private boolean pRightFieldNameF;
    private boolean decoderUnitNameF;

    private static final int WIDTH = 0;
    private static final int FIELD_POS = 1;
    private static final int NEXT_FIELD = 2;
    private static final int PREVIOUS_FIELD = 3;
    private static final int GEN_DECODER = 4;

    public CslGenIsaInstrFormat(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_ISA_INSTR_FORMAT, parent, name);
    }

    private CslGenCslBase design() {
        return getParent().orElse(null);
    }

    private void genSetWidth(RandomGenerator rng) {
        widthNumExpr = CslGenNumExprSupport.randNumExpr(rng);
    }

    private void genSetFieldName(CslGenCslBase d, RandomGenerator rng) {
        if (d == null) {
            return;
        }
        for (CslGenCslBase ch : d.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !fieldNameF) {
                fieldName += ch.getName();
                fieldNameF = true;
            }
        }
    }

    private void genSetFieldNumExpr(RandomGenerator rng) {
        fieldPosNumExpr += CslGenNumExprSupport.randNumExpr(rng);
    }

    private void genSetNextFieldLeft(CslGenCslBase d, RandomGenerator rng) {
        if (d == null) {
            return;
        }
        for (CslGenCslBase ch : d.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !nLeftFieldNameF) {
                nLeftFieldName += ch.getName();
                nLeftFieldNameF = true;
            }
        }
    }

    private void genSetNextFieldRight(CslGenCslBase d, RandomGenerator rng) {
        if (d == null) {
            return;
        }
        for (CslGenCslBase ch : d.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !nRightFieldNameF) {
                nRightFieldName += ch.getName();
                nRightFieldNameF = true;
            }
        }
    }

    private void genSetPreviousFieldLeft(CslGenCslBase d, RandomGenerator rng) {
        if (d == null) {
            return;
        }
        for (CslGenCslBase ch : d.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !pLeftFieldNameF) {
                pLeftFieldName += ch.getName();
                pLeftFieldNameF = true;
            }
        }
    }

    private void genSetPreviousFieldRight(CslGenCslBase d, RandomGenerator rng) {
        if (d == null) {
            return;
        }
        for (CslGenCslBase ch : d.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_FIELD && rng.nextBoolean() && !pRightFieldNameF) {
                pRightFieldName += ch.getName();
                pRightFieldNameF = true;
            }
        }
    }

    private void genDecoder(CslGenCslBase d, RandomGenerator rng) {
        if (d == null) {
            return;
        }
        for (CslGenCslBase ch : d.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_UNIT && rng.nextBoolean() && !decoderUnitNameF) {
                decoderUnitName += ch.getName();
                decoderUnitNameF = true;
            }
        }
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenCslBase d = design();
        int rounds = rng.nextInt(CslGenIsaAoTables.ISA_INSTR_FORMAT_CMD);
        for (int i = 0; i < rounds; i++) {
            int ran = rng.nextInt(CslGenIsaAoTables.ISA_INSTR_FORMAT_USED_VECTOR_SIZE);
            if (used[ran] != 0) {
                continue;
            }
            switch (ran) {
                case WIDTH:
                    genSetWidth(rng);
                    break;
                case FIELD_POS:
                    genSetFieldName(d, rng);
                    genSetFieldNumExpr(rng);
                    break;
                case NEXT_FIELD:
                    genSetNextFieldLeft(d, rng);
                    genSetNextFieldRight(d, rng);
                    break;
                case PREVIOUS_FIELD:
                    genSetPreviousFieldLeft(d, rng);
                    genSetPreviousFieldRight(d, rng);
                    break;
                case GEN_DECODER:
                    genDecoder(d, rng);
                    break;
                default:
                    break;
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
        CslGenSupportEmit.cslIsaInstructionFormat(out);
        out.append(getName());
        CslGenSupportEmit.lCbrace(out);

        out.append("    ").append(getName());
        CslGenSupportEmit.lParenthesis(out);
        CslGenSupportEmit.rParenthesis(out);
        CslGenSupportEmit.lCbrace(out);

        for (int i = 0; i < CslGenIsaAoTables.ISA_INSTR_FORMAT_USED_VECTOR_SIZE; i++) {
            if (used[i] == 0) {
                continue;
            }
            switch (i) {
                case WIDTH:
                    CslGenSupportEmit.funct1param(out, CslGenIsaAoTables.ISA_INSTR_FORMAT_FUNCTION[i], widthNumExpr);
                    break;
                case FIELD_POS:
                    if (fieldNameF) {
                        CslGenSupportEmit.funct2param(
                                out,
                                CslGenIsaAoTables.ISA_INSTR_FORMAT_FUNCTION[i],
                                fieldName,
                                fieldPosNumExpr);
                    }
                    break;
                case NEXT_FIELD:
                    if (nLeftFieldNameF && nRightFieldNameF) {
                        CslGenSupportEmit.funct2param(
                                out,
                                CslGenIsaAoTables.ISA_INSTR_FORMAT_FUNCTION[i],
                                nLeftFieldName,
                                nRightFieldName);
                    }
                    break;
                case PREVIOUS_FIELD:
                    if (pLeftFieldNameF && pRightFieldNameF) {
                        CslGenSupportEmit.funct2param(
                                out,
                                CslGenIsaAoTables.ISA_INSTR_FORMAT_FUNCTION[i],
                                pLeftFieldName,
                                pRightFieldName);
                    }
                    break;
                case GEN_DECODER:
                    if (decoderUnitNameF) {
                        CslGenSupportEmit.funct1param(
                                out, CslGenIsaAoTables.ISA_INSTR_FORMAT_FUNCTION[i], decoderUnitName);
                    }
                    break;
                default:
                    break;
            }
        }
        out.append("  ");
        CslGenSupportEmit.rCbrace(out);
        CslGenSupportEmit.rCbrace(out);
        CslGenSupportEmit.semicolon(out);
    }
}
