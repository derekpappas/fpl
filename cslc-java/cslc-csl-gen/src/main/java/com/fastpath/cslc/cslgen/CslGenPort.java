package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLport} ({@code cslInterconnectGen_TB.h} / {@code cslInterconnectGen_TB.cpp}).
 */
public final class CslGenPort extends CslGenCslBase {

    public static final int PORT_DECL_EMPTY = 0;
    public static final int PORT_DECL_TYPE = 1;
    public static final int PORT_DECL_WIDTH = 2;
    public static final int PORT_DECL_TYPE_WIDTH = 3;
    public static final int PORT_DECL_BITRANGE = 4;
    public static final int PORT_DECL_TYPE_BITRANGE = 5;
    public static final int PORT_DECL_COPY = 6;
    public static final int PORT_DECL_MAX = 8;

    private int declForm;
    private final StringBuilder bitrCopy = new StringBuilder();
    private String prtType = "";
    private String prtDir = "";
    private final CslGenBitrangeState prtBitr = new CslGenBitrangeState();

    public CslGenPort(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_PORT, parent, name);
    }

    public String getPortType() {
        return prtType;
    }

    public String getDir() {
        return prtDir;
    }

    public int getLower() {
        return prtBitr.getLower();
    }

    public int getUpper() {
        return prtBitr.getUpper();
    }

    public int getWidth() {
        return prtBitr.getWidth();
    }

    public int getOffset() {
        return prtBitr.getOffset();
    }

    /**
     * Legacy {@code CSLport::getBitrange()} ({@code cslInterconnectGen_TB.cpp}): the port’s embedded range (C++ held a
     * child {@code CSLbitrange}; Java keeps equivalent state in {@link CslGenBitrangeState}).
     */
    public CslGenBitrangeState getBitrangeState() {
        return prtBitr;
    }

    /**
     * Legacy {@code CSLport::m_bitrCopy} ({@code cslInterconnectGen_TB.h}) — scoped bitrange reference text for
     * {@code PORT_DECL_BITRANGE} / {@code PORT_DECL_TYPE_BITRANGE} {@link #print()}.
     */
    public String getBitrCopyText() {
        return bitrCopy.toString();
    }

    /** {@code m_declForm} ({@code ECSLportDecl}). */
    public int getDeclForm() {
        return declForm;
    }

    public void setPortType(String type) {
        this.prtType = type;
    }

    public void setDir(String dir) {
        this.prtDir = dir;
    }

    public boolean setWidth(int width) {
        return prtBitr.setWidth(width);
    }

    public boolean setOffset(int offset) {
        return prtBitr.setOffset(offset);
    }

    public boolean setRange(int lower, int upper) {
        return prtBitr.setRange(lower, upper);
    }

    public void copyBitrange(CslGenBitrange br) {
        br.copyInto(prtBitr);
    }

    /** Legacy {@code CSLport::copySignal} ({@code cslInterconnectGen_TB.cpp}). */
    public void copySignal(CslGenSignal sig) {
        setPortType(sig.getSigType());
        sig.copyStateTo(prtBitr);
    }

    /** Legacy {@code CSLport::copyPort} ({@code cslInterconnectGen_TB.cpp}). */
    public void copyPort(CslGenPort prt) {
        setDir(prt.getDir());
        setPortType(prt.getPortType());
        prt.copyBitrangeInto(prtBitr);
    }

    /** Copies embedded port bitrange state (legacy {@code m_prtBitr}) into {@code target}. */
    public void copyBitrangeInto(CslGenBitrangeState target) {
        target.copyFrom(prtBitr);
    }

    private boolean isPortDeclValid() {
        return !(((!"output".equals(prtDir)) && "reg".equals(prtType))
                || "integer".equals(prtType)
                || "real".equals(prtType)
                || "realtime".equals(prtType)
                || "time".equals(prtType));
    }

    /** Legacy {@code CSLport::randSelBitrange()} ({@code cslInterconnectGen_TB.cpp}). */
    public CslGenScopedSelection randSelBitrange(RandomGenerator rng) {
        return randSelObj(CslGenCslType.CSL_BITRANGE, rng);
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        declForm = rng.nextInt(PORT_DECL_MAX);
        if (declForm == PORT_DECL_EMPTY) {
            setDir(CslGenInterconnectConsts.PORT_DIRECTIONS[rng.nextInt(CslGenInterconnectConsts.DIR_VEC_SIZE)]);
            return true;
        }
        if (declForm == PORT_DECL_TYPE) {
            setDir(CslGenInterconnectConsts.PORT_DIRECTIONS[rng.nextInt(CslGenInterconnectConsts.DIR_VEC_SIZE)]);
            setPortType(CslGenInterconnectConsts.SIG_PORT_TYPES[rng.nextInt(CslGenInterconnectConsts.TYPE_VEC_SIZE)]);
            return isPortDeclValid();
        }
        if (declForm == PORT_DECL_WIDTH) {
            setWidth(rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH - 1) + 1);
            setDir(CslGenInterconnectConsts.PORT_DIRECTIONS[rng.nextInt(CslGenInterconnectConsts.DIR_VEC_SIZE)]);
            return true;
        }
        if (declForm == PORT_DECL_TYPE_WIDTH) {
            setWidth(rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH - 1) + 1);
            setDir(CslGenInterconnectConsts.PORT_DIRECTIONS[rng.nextInt(CslGenInterconnectConsts.DIR_VEC_SIZE)]);
            setPortType(CslGenInterconnectConsts.SIG_PORT_TYPES[rng.nextInt(CslGenInterconnectConsts.TYPE_VEC_SIZE)]);
            return isPortDeclValid();
        }
        if (declForm == PORT_DECL_BITRANGE) {
            CslGenScopedSelection br = randSelBitrange(rng);
            if (br.selected() != null) {
                copyBitrange((CslGenBitrange) br.selected());
                setDir(CslGenInterconnectConsts.PORT_DIRECTIONS[rng.nextInt(CslGenInterconnectConsts.DIR_VEC_SIZE)]);
                bitrCopy.setLength(0);
                bitrCopy.append(br.scope()).append(br.selected().getName());
                return true;
            }
            return false;
        }
        if (declForm == PORT_DECL_TYPE_BITRANGE) {
            CslGenScopedSelection br = randSelBitrange(rng);
            if (br.selected() != null) {
                copyBitrange((CslGenBitrange) br.selected());
                setDir(CslGenInterconnectConsts.PORT_DIRECTIONS[rng.nextInt(CslGenInterconnectConsts.DIR_VEC_SIZE)]);
                setPortType(CslGenInterconnectConsts.SIG_PORT_TYPES[rng.nextInt(CslGenInterconnectConsts.TYPE_VEC_SIZE)]);
                if (isPortDeclValid()) {
                    bitrCopy.setLength(0);
                    bitrCopy.append(br.scope()).append(br.selected().getName());
                    return true;
                }
            }
            return false;
        }
        if (declForm == PORT_DECL_COPY) {
            /* Legacy {@code CSL_PORT_DECL_COPY}: {@code buildDecl} always fails ({@code cslInterconnectGen_TB.cpp}). */
            return false;
        }
        return false;
    }

    /** Legacy {@code CSLport::buildSet} ({@code cslInterconnectGen_TB.cpp}). */
    public void buildSet(String scope, RandomGenerator rng) {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        int form = rng.nextInt(CslGenInterconnectConsts.PORT_MODIF_MAX);
        if (form == CslGenInterconnectConsts.PORT_MODIF_RANGE) {
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
        } else if (form == CslGenInterconnectConsts.PORT_MODIF_WIDTH) {
            int width = rng.nextInt(CslGenInterconnectConsts.MAX_WIDTH) + 1;
            if (setWidth(width)) {
                CslGenSupportEmit.call1param(out, scope, getName(), "set_width", CslGenInt.intToString(getWidth()));
            }
        } else if (form == CslGenInterconnectConsts.PORT_MODIF_OFFSET) {
            int offset = rng.nextInt(CslGenInterconnectConsts.MAX_OFFSET);
            if (setOffset(offset)) {
                CslGenSupportEmit.call1param(out, scope, getName(), "set_offset", CslGenInt.intToString(getOffset()));
            }
        }
    }

    @Override
    public void print() {
        StringBuilder mOut = printSink();
        if (mOut == null) {
            return;
        }
        if (declForm == PORT_DECL_EMPTY) {
            CslGenSupportEmit.decl1param(mOut, "csl_port", getName(), getDir());
        } else if (declForm == PORT_DECL_TYPE) {
            CslGenSupportEmit.decl2param(mOut, "csl_port", getName(), getDir(), getPortType());
        } else if (declForm == PORT_DECL_WIDTH) {
            CslGenSupportEmit.decl2param(mOut, "csl_port", getName(), getDir(), CslGenInt.intToString(getWidth()));
        } else if (declForm == PORT_DECL_TYPE_WIDTH) {
            CslGenSupportEmit.decl3param(mOut, "csl_port", getName(), getDir(), getPortType(), CslGenInt.intToString(getWidth()));
        } else if (declForm == PORT_DECL_BITRANGE) {
            CslGenSupportEmit.decl2param(mOut, "csl_port", getName(), getDir(), bitrCopy.toString());
        } else if (declForm == PORT_DECL_TYPE_BITRANGE) {
            CslGenSupportEmit.decl3param(mOut, "csl_port", getName(), getDir(), getPortType(), bitrCopy.toString());
        } else if (declForm == PORT_DECL_COPY) {
            /* Legacy: empty branch ({@code cslInterconnectGen_TB.cpp}). */
        }
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
