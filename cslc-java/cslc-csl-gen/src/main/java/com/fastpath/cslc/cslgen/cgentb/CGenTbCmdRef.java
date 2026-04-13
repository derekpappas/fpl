package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;

/**
 * Minimal stand-in for legacy {@code CSLCmd} / {@code CSLCmdPoint} in {@code cGenCmds_tb.cpp} (command type + caller
 * class + global-call flag).
 */
public final class CGenTbCmdRef {

    private final CGenTbCmdType type;
    private final CGenTbEslClass callerClass;
    private final boolean canCallFromGlobalScope;

    public CGenTbCmdRef(CGenTbCmdType type, CGenTbEslClass callerClass, boolean canCallFromGlobalScope) {
        this.type = Objects.requireNonNull(type, "type");
        this.callerClass = Objects.requireNonNull(callerClass, "callerClass");
        this.canCallFromGlobalScope = canCallFromGlobalScope;
    }

    public CGenTbCmdType type() {
        return type;
    }

    public CGenTbEslClass callerClass() {
        return callerClass;
    }

    public boolean canCallFromGlobalScope() {
        return canCallFromGlobalScope;
    }

    /** Legacy {@code cmd->isCaller(cls->getClass()) && cmd->getCanCallFromGlobalScope()} (simplified: same {@link CGenTbEslClass}). */
    public boolean isLegalFor(CGenTbClassRef cls) {
        return callerClass == cls.kind() && canCallFromGlobalScope;
    }
}
