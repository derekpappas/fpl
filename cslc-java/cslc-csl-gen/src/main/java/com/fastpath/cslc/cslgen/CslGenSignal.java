package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLsignal} ({@code cslInterconnectGen_TB.h} / {@code cslInterconnectGen_TB.cpp}).
 */
public final class CslGenSignal extends CslGenCslBase {

    public static final int SIG_DECL_EMPTY = 0;
    public static final int SIG_DECL_TYPE = 1;
    public static final int SIG_DECL_WIDTH = 2;
    public static final int SIG_DECL_TYPE_WIDTH = 3;
    public static final int SIG_DECL_LOWER_UPPER = 4;
    public static final int SIG_DECL_TYPE_LOWER_UPPER = 5;
    public static final int SIG_DECL_BITRANGE = 6;
    public static final int SIG_DECL_TYPE_BITRANGE = 7;
    public static final int SIG_DECL_COPY = 8;
    public static final int SIG_DECL_MAX = 9;

    private int declForm;
    private final StringBuilder bitrCopy = new StringBuilder();
    private final StringBuilder sigCopy = new StringBuilder();
    private String sigType = "";
    private final CslGenBitrangeState sigBitr = new CslGenBitrangeState();

    public CslGenSignal(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_SIGNAL, parent, name);
    }

    public String getSigType() {
        return sigType;
    }

    public int getLower() {
        return sigBitr.getLower();
    }

    public int getUpper() {
        return sigBitr.getUpper();
    }

    public int getWidth() {
        return sigBitr.getWidth();
    }

    public int getOffset() {
        return sigBitr.getOffset();
    }

    /**
     * Legacy {@code CSLsignal::getBitrange()} ({@code cslInterconnectGen_TB.cpp}): embedded range state (see {@link
     * CslGenPort#getBitrangeState()}).
     */
    public CslGenBitrangeState getBitrangeState() {
        return sigBitr;
    }

    /**
     * Legacy {@code CSLsignal::m_bitrCopy} ({@code cslInterconnectGen_TB.h}) — scoped bitrange reference for
     * {@code SIG_DECL_BITRANGE} / {@code SIG_DECL_TYPE_BITRANGE}.
     */
    public String getBitrCopyText() {
        return bitrCopy.toString();
    }

    /**
     * Legacy {@code CSLsignal::m_sigCopy} ({@code cslInterconnectGen_TB.h}) — scoped signal reference for
     * {@code SIG_DECL_COPY}.
     */
    public String getSigCopyText() {
        return sigCopy.toString();
    }

    /** {@code m_declForm} ({@code ECSLsigDecl}). */
    public int getDeclForm() {
        return declForm;
    }

    public void setSigType(String type) {
        this.sigType = type;
    }

    public boolean setWidth(int width) {
        return sigBitr.setWidth(width);
    }

    public boolean setOffset(int offset) {
        return sigBitr.setOffset(offset);
    }

    public boolean setRange(int lower, int upper) {
        return sigBitr.setRange(lower, upper);
    }

    public void copyBitrange(CslGenBitrange br) {
        br.copyInto(sigBitr);
    }

    public void copySignal(CslGenSignal sig) {
        setSigType(sig.getSigType());
        sig.copyStateTo(sigBitr);
    }

    void copyStateTo(CslGenBitrangeState target) {
        target.copyFrom(sigBitr);
    }

    /** Legacy {@code CSLsignal::randSelBitrange()} ({@code cslInterconnectGen_TB.cpp}). */
    public CslGenScopedSelection randSelBitrange(RandomGenerator rng) {
        return randSelObj(CslGenCslType.CSL_BITRANGE, rng);
    }

    /** Legacy {@code CSLsignal::randSelSignal()} ({@code cslInterconnectGen_TB.cpp}). */
    public CslGenScopedSelection randSelSignal(RandomGenerator rng) {
        return randSelObj(CslGenCslType.CSL_SIGNAL, rng);
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        declForm = rng.nextInt(SIG_DECL_MAX);
        if (declForm == SIG_DECL_EMPTY) {
            return true;
        }
        if (declForm == SIG_DECL_TYPE) {
            setSigType(CslGenInterconnectConsts.SIG_PORT_TYPES[rng.nextInt(CslGenInterconnectConsts.TYPE_VEC_SIZE)]);
            return true;
        }
        if (declForm == SIG_DECL_WIDTH) {
            setWidth(rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH - 1) + 1);
            return true;
        }
        if (declForm == SIG_DECL_TYPE_WIDTH) {
            setWidth(rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH - 1) + 1);
            setSigType(CslGenInterconnectConsts.SIG_PORT_TYPES[rng.nextInt(CslGenInterconnectConsts.TYPE_VEC_SIZE)]);
            return true;
        }
        if (declForm == SIG_DECL_LOWER_UPPER) {
            int low = rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH / 2);
            int up = low + rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH / 2) + 1;
            setRange(low, up);
            return true;
        }
        if (declForm == SIG_DECL_TYPE_LOWER_UPPER) {
            int low = rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH / 2);
            int up = low + rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH / 2) + 1;
            setRange(low, up);
            setSigType(CslGenInterconnectConsts.SIG_PORT_TYPES[rng.nextInt(CslGenInterconnectConsts.TYPE_VEC_SIZE)]);
            return true;
        }
        if (declForm == SIG_DECL_BITRANGE) {
            CslGenScopedSelection br = randSelBitrange(rng);
            if (br.selected() != null) {
                copyBitrange((CslGenBitrange) br.selected());
                bitrCopy.setLength(0);
                bitrCopy.append(br.scope()).append(br.selected().getName());
                return true;
            }
            return false;
        }
        if (declForm == SIG_DECL_TYPE_BITRANGE) {
            CslGenScopedSelection br = randSelBitrange(rng);
            if (br.selected() != null) {
                setSigType(CslGenInterconnectConsts.SIG_PORT_TYPES[rng.nextInt(CslGenInterconnectConsts.TYPE_VEC_SIZE)]);
                copyBitrange((CslGenBitrange) br.selected());
                bitrCopy.setLength(0);
                bitrCopy.append(br.scope()).append(br.selected().getName());
                return true;
            }
            return false;
        }
        if (declForm == SIG_DECL_COPY) {
            CslGenScopedSelection sig = randSelSignal(rng);
            if (sig.selected() != null) {
                copySignal((CslGenSignal) sig.selected());
                sigCopy.setLength(0);
                sigCopy.append(sig.scope()).append(sig.selected().getName());
                return true;
            }
            return false;
        }
        return false;
    }

    /** Legacy {@code CSLsignal::buildSet} ({@code cslInterconnectGen_TB.cpp}). */
    public void buildSet(String scope, RandomGenerator rng) {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        int form = rng.nextInt(CslGenInterconnectConsts.SIG_MODIF_MAX);
        if (form == CslGenInterconnectConsts.SIG_MODIF_RANGE) {
            int low = rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH / 2);
            int up = low + rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH / 2) + 1;
            if (setRange(low, up)) {
                CslGenSupportEmit.call2param(
                        out,
                        scope,
                        getName(),
                        "set_range",
                        CslGenInt.intToString(getLower()),
                        CslGenInt.intToString(getUpper()));
            }
        } else if (form == CslGenInterconnectConsts.SIG_MODIF_WIDTH) {
            int width = rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH) + 1;
            if (setWidth(width)) {
                CslGenSupportEmit.call1param(out, scope, getName(), "set_width", CslGenInt.intToString(getWidth()));
            }
        } else if (form == CslGenInterconnectConsts.SIG_MODIF_OFFSET) {
            int offset = rng.nextInt(CslGenInterconnectConsts.MAX_OFFSET);
            if (setOffset(offset)) {
                CslGenSupportEmit.call1param(out, scope, getName(), "set_offset", CslGenInt.intToString(getOffset()));
            }
        }
        /* SIG_MODIF_BITR: present in header but trunk {@code buildSet} emits nothing for that case. */
    }

    @Override
    public void print() {
        StringBuilder mOut = printSink();
        if (mOut == null) {
            return;
        }
        if (declForm == SIG_DECL_EMPTY) {
            CslGenSupportEmit.decl0param(mOut, "csl_signal", getName());
        } else if (declForm == SIG_DECL_TYPE) {
            CslGenSupportEmit.decl1param(mOut, "csl_signal", getName(), getSigType());
        } else if (declForm == SIG_DECL_WIDTH) {
            CslGenSupportEmit.decl1param(mOut, "csl_signal", getName(), CslGenInt.intToString(getWidth()));
        } else if (declForm == SIG_DECL_TYPE_WIDTH) {
            CslGenSupportEmit.decl2param(mOut, "csl_signal", getName(), getSigType(), CslGenInt.intToString(getWidth()));
        } else if (declForm == SIG_DECL_LOWER_UPPER) {
            CslGenSupportEmit.decl2param(mOut, "csl_signal", getName(), CslGenInt.intToString(getLower()), CslGenInt.intToString(getUpper()));
        } else if (declForm == SIG_DECL_TYPE_LOWER_UPPER) {
            CslGenSupportEmit.decl3param(
                    mOut, "csl_signal", getName(), getSigType(), CslGenInt.intToString(getLower()), CslGenInt.intToString(getUpper()));
        } else if (declForm == SIG_DECL_BITRANGE) {
            CslGenSupportEmit.decl1param(mOut, "csl_signal", getName(), bitrCopy.toString());
        } else if (declForm == SIG_DECL_TYPE_BITRANGE) {
            CslGenSupportEmit.decl2param(mOut, "csl_signal", getName(), getSigType(), bitrCopy.toString());
        } else if (declForm == SIG_DECL_COPY) {
            CslGenSupportEmit.decl1param(mOut, "csl_signal", getName(), sigCopy.toString());
        }
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
