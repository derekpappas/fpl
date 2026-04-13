package com.fastpath.cslc.cslgen.tb;

/** Legacy {@code NSCslGen::CSLsignal} ({@code cslGen_TB.h}). */
public final class CslGenTbSignal {

    public String m_sName;
    public String m_sType = "";
    public String m_sAttr = "";
    public short m_sLower;
    public short m_sUpper;
    public CslGenTbSignal m_sCopyOf;
    public CslGenTbBitrange m_sBitrange;

    public CslGenTbSignal(String name) {
        this.m_sName = name;
    }
}
