package com.fastpath.cslc.cslgen.tb;

import java.util.ArrayList;
import java.util.List;

/** Legacy {@code NSCslGen::CSLunitDecl} ({@code cslGen_TB.h}). */
public final class CslGenTbUnitDecl {

    public final List<CslGenTbInstance> m_dInsts = new ArrayList<>();
    public final List<CslGenTbBitrange> m_dBitranges = new ArrayList<>();
    public final List<CslGenTbSignal> m_dSignals = new ArrayList<>();
    public final List<CslGenTbPort> m_dPorts = new ArrayList<>();
}
