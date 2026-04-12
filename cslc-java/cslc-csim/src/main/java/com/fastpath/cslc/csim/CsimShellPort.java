package com.fastpath.cslc.csim;

import java.util.Optional;

/**
 * Port surface for {@code NSCsimLib::CsimShell} ({@code trunk/cslc/trunk/src/csim/CsimShell.h}).
 */
public interface CsimShellPort {

    void start(Optional<String> scriptFileName);
}
