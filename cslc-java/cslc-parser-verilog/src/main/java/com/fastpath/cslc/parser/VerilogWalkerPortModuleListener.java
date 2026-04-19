package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.verilog.VerilogParserTrunkPort;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * Counts visits to the ANTLR4 rule {@code module}, a natural anchor when porting legacy
 * {@code verilog.walker.g} passes that elaborate module declarations. On exit, records the module
 * identifier text from {@code module_identifier} (legacy naming / hierarchy can build on this).
 */
public final class VerilogWalkerPortModuleListener extends VerilogTrunkPortListenerSkeleton {

    private final AtomicInteger moduleEnters = new AtomicInteger();
    private volatile String lastModuleIdentifier;

    @Override
    public void enterModule(VerilogParserTrunkPort.ModuleContext ctx) {
        moduleEnters.incrementAndGet();
    }

    @Override
    public void exitModule(VerilogParserTrunkPort.ModuleContext ctx) {
        if (ctx.module_identifier() != null) {
            lastModuleIdentifier = ctx.module_identifier().getText();
        }
    }

    public int getModuleEnterCount() {
        return moduleEnters.get();
    }

    /** Module name text from the last exited {@code module} rule, or {@code null}. */
    public String getLastModuleIdentifier() {
        return lastModuleIdentifier;
    }
}
