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
                VerilogGenerateBlockStub,
                VerilogGenerateCaseStub,
                VerilogGenerateConditionalStub,
                VerilogGenerateRegionStub,
                VerilogInitialConstructStub,
                VerilogListOfPortsStub,
                VerilogModuleDeclStub,
                VerilogModuleInstanceStub,
                VerilogParamDeclAssignmentStub,
                VerilogPortDeclStub,
                VerilogSignalDeclStub,
                VerilogSpecifyBlockStub,
                VerilogSpecparamAssignmentStub,
                VerilogTaskDeclStub,
                VerilogUdpDeclStub {}
