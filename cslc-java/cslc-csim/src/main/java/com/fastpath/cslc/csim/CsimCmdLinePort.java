package com.fastpath.cslc.csim;

import java.util.Optional;

/**
 * Port for {@code NSCsimLib::CsimCmdLine} ({@code trunk/cslc/trunk/src/csim/CsimCmdLine.h}).
 * Readline-backed input is intentionally not modeled here.
 */
public interface CsimCmdLinePort {

    void setCmdPrompt(String prompt);

    /** Next shell command line, or empty when input is exhausted. */
    Optional<String> getNextCmd();

    void print(String out);
}
