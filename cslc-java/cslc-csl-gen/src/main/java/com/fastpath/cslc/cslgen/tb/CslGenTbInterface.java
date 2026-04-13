package com.fastpath.cslc.cslgen.tb;

import java.util.ArrayList;
import java.util.List;

/** Legacy {@code NSCslGen::CSLinterface} ({@code cslGen_TB.h}). */
public final class CslGenTbInterface {

    public String m_ifcName;
    public final List<CslGenTbPort> m_ifcPorts = new ArrayList<>();
    public final List<CslGenTbInterface> m_ifcIfcs = new ArrayList<>();
}
