package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLisa} ({@code cGenIsa_ao.h} / {@code cGenIsa_ao.cpp}) — container for ISA decoder
 * settings and {@link CslGenInstance} children referencing {@link CslGenIsaInstr}.
 */
public final class CslGenIsa extends CslGenCslBase {

    private String setDecoderName = "";
    private String setDecoderPrefix = "";
    private String setDecoderSuffix = "";
    private String generateDecoder = "";
    private String printFileName = "";
    private final int[] used = new int[CslGenIsaAoTables.ISA_USED_VECTOR_SIZE];

    private boolean generateDecoderF;

    private static final int DECODER_NAME = 0;
    private static final int DECODER_PREFIX = 1;
    private static final int DECODER_SUFFIX = 2;
    private static final int GEN_DECODER = 3;
    private static final int PRINT = 4;

    public CslGenIsa(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_ISA, parent, name);
    }

    void addIsaInstance(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_ISA_INSTR && rng.nextBoolean()) {
                String n = CslGenRandString.randString(rng);
                if (design.newNameIsValid(n)) {
                    addChild(new CslGenInstance(this, ch, n));
                }
            }
        }
    }

    private void genSetDecoderName(RandomGenerator rng) {
        setDecoderName += "\"";
        setDecoderName += CslGenRandString.randString(rng);
        setDecoderName += "\"";
    }

    private void genSetDecoderPrefix(RandomGenerator rng) {
        setDecoderPrefix += "\"";
        setDecoderPrefix += CslGenRandString.randString(rng);
        setDecoderPrefix += "\"";
    }

    private void genSetDecoderSuffix(RandomGenerator rng) {
        setDecoderSuffix += "\"";
        setDecoderSuffix += CslGenRandString.randString(rng);
        setDecoderSuffix += "\"";
    }

    private void genGenerateDecoder(CslGenCslBase design, RandomGenerator rng) {
        if (design == null) {
            return;
        }
        for (CslGenCslBase ch : design.getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_UNIT && rng.nextBoolean() && !generateDecoderF) {
                generateDecoder += ch.getName();
                generateDecoderF = true;
            }
        }
    }

    private void printFile() {
        printFileName += "\"isa.txt\"";
    }

    public boolean buildDecl(RandomGenerator rng) {
        CslGenCslBase design = getParent().orElse(null);
        int rounds = rng.nextInt(CslGenIsaAoTables.ISA_CMD);
        for (int i = 0; i < rounds; i++) {
            int ran = rng.nextInt(CslGenIsaAoTables.ISA_USED_VECTOR_SIZE);
            if (used[ran] != 0) {
                continue;
            }
            switch (ran) {
                case DECODER_NAME:
                    genSetDecoderName(rng);
                    break;
                case DECODER_PREFIX:
                    genSetDecoderPrefix(rng);
                    break;
                case DECODER_SUFFIX:
                    genSetDecoderSuffix(rng);
                    break;
                case GEN_DECODER:
                    genGenerateDecoder(design, rng);
                    break;
                case PRINT:
                    printFile();
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
        CslGenSupportEmit.cslIsa(out);
        out.append(getName());
        CslGenSupportEmit.lCbrace(out);

        for (CslGenCslBase ch : getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_INSTANCE) {
                ch.print();
            }
        }

        out.append("    ").append(getName());
        CslGenSupportEmit.lParenthesis(out);
        CslGenSupportEmit.rParenthesis(out);
        CslGenSupportEmit.lCbrace(out);

        for (int i = 0; i < CslGenIsaAoTables.ISA_USED_VECTOR_SIZE; i++) {
            if (used[i] == 0) {
                continue;
            }
            switch (i) {
                case DECODER_NAME:
                    CslGenSupportEmit.funct1param(out, CslGenIsaAoTables.ISA_FUNCTION[i], setDecoderName);
                    break;
                case DECODER_PREFIX:
                    CslGenSupportEmit.funct1param(out, CslGenIsaAoTables.ISA_FUNCTION[i], setDecoderPrefix);
                    break;
                case DECODER_SUFFIX:
                    CslGenSupportEmit.funct1param(out, CslGenIsaAoTables.ISA_FUNCTION[i], setDecoderSuffix);
                    break;
                case GEN_DECODER:
                    if (generateDecoderF) {
                        CslGenSupportEmit.funct1param(out, CslGenIsaAoTables.ISA_FUNCTION[i], generateDecoder);
                    }
                    break;
                case PRINT:
                    CslGenSupportEmit.funct1param(out, CslGenIsaAoTables.ISA_FUNCTION[i], printFileName);
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
