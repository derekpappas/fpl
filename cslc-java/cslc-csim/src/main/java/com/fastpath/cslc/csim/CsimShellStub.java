package com.fastpath.cslc.csim;

import java.util.Optional;

/** Staged implementation until {@code CsimShell} is fully ported. */
public final class CsimShellStub implements CsimShellPort {

    public static CsimShellPort getInstance() {
        return Holder.INSTANCE;
    }

    @Override
    public void start(Optional<String> scriptFileName) {
        // Legacy: RefCsimShell shell = CsimShell::getInstance(); shell->start(fileName);
        scriptFileName.ifPresentOrElse(
                f -> System.err.println("[csim-stub] would load script: " + f),
                () -> System.err.println("[csim-stub] interactive shell (not implemented)"));
    }

    private static final class Holder {
        static final CsimShellStub INSTANCE = new CsimShellStub();
    }

    private CsimShellStub() {}
}
