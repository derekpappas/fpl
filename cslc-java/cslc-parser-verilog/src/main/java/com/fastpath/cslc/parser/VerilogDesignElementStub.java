package com.fastpath.cslc.parser;

/**
 * Union of syntax-only Verilog design elements lifted from {@link com.fastpath.cslc.parser.verilog.VerilogParserTrunkPort}
 * (batch 6 stub path).
 */
public sealed interface VerilogDesignElementStub
        permits VerilogAlwaysConstructStub,
                VerilogContinuousAssignStub,
                VerilogDefparamAssignmentStub,
                VerilogFunctionDeclStub,
                VerilogGateInstantiationStub,
                VerilogInitialConstructStub,
                VerilogModuleDeclStub,
                VerilogModuleInstanceStub,
                VerilogParamDeclAssignmentStub,
                VerilogPortDeclStub,
                VerilogSignalDeclStub,
                VerilogSpecparamAssignmentStub,
                VerilogTaskDeclStub,
                VerilogUdpDeclStub {}
