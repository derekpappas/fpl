package com.fastpath.cslc.buildutils;

import com.fastpath.cslc.csim.CsimShellPort;
import com.fastpath.cslc.csim.CsimShellStub;

import java.util.Optional;

/**
 * Port of {@code trunk/cslc/trunk/build_utils/main.cpp} (CSIM shell entry).
 */
public final class BuildUtilsCsimMain {

    public static void main(String[] argv) {
        CsimShellPort shell = CsimShellStub.getInstance();
        Optional<String> file = argv.length == 2 ? Optional.of(argv[1]) : Optional.empty();
        shell.start(file);
    }

    private BuildUtilsCsimMain() {}
}
