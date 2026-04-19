package com.fastpath.cslc.parser;

/**
 * Union of syntax-only Verilog design elements lifted from {@link com.fastpath.cslc.parser.verilog.VerilogParserTrunkPort}
 * (batch 6 stub path).
 */
public sealed interface VerilogDesignElementStub
        permits VerilogContinuousAssignStub,
                VerilogModuleDeclStub,
                VerilogModuleInstanceStub,
                VerilogPortDeclStub,
                VerilogSignalDeclStub,
                VerilogUdpDeclStub {}
