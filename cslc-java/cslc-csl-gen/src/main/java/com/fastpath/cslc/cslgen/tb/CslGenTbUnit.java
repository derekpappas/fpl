package com.fastpath.cslc.cslgen.tb;

/** Legacy {@code NSCslGen::CSLunit} ({@code cslGen_TB.h}). */
public final class CslGenTbUnit {

    public String m_uName;
    public final CslGenTbUnitDecl m_uDecl = new CslGenTbUnitDecl();
    public final CslGenTbUnitInit m_uInit = new CslGenTbUnitInit();

    public CslGenTbUnit(String name) {
        this.m_uName = name;
    }
}
