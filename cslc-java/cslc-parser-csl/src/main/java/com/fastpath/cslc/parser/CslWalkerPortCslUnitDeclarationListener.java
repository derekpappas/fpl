package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * Counts visits to the ANTLR4 rule {@code csl_unit_declaration}, the parse-tree counterpart of legacy
 * {@code csl.walker.g} rule {@code csl_unit_declaration} (C++ walker builds unit declarations into CSLOm).
 * After each declaration exits, records the first {@code IDENTIFIER} (primary unit name) as a string
 * for upcoming Java CSLOm wiring.
 */
public final class CslWalkerPortCslUnitDeclarationListener extends CslTrunkPortListenerSkeleton {

    private final AtomicInteger cslUnitDeclarationEnters = new AtomicInteger();
    private volatile String lastPrimaryUnitIdentifier;

    @Override
    public void enterCsl_unit_declaration(CslParserTrunkPort.Csl_unit_declarationContext ctx) {
        cslUnitDeclarationEnters.incrementAndGet();
    }

    @Override
    public void exitCsl_unit_declaration(CslParserTrunkPort.Csl_unit_declarationContext ctx) {
        TerminalNode id = ctx.IDENTIFIER(0);
        if (id != null) {
            lastPrimaryUnitIdentifier = id.getText();
        }
    }

    public int getCslUnitDeclarationEnterCount() {
        return cslUnitDeclarationEnters.get();
    }

    /** Text of the first identifier in the last exited {@code csl_unit_declaration}, or {@code null}. */
    public String getLastPrimaryUnitIdentifier() {
        return lastPrimaryUnitIdentifier;
    }
}
