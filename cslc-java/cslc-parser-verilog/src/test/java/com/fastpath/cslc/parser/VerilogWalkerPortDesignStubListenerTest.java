package com.fastpath.cslc.parser;

import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class VerilogWalkerPortDesignStubListenerTest {

    @Test
    void singleEmptyModuleProducesModuleStub() {
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                "module m();\nendmodule\n", new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(1, sink.size());
        var m = assertInstanceOf(VerilogModuleDeclStub.class, sink.get(0));
        assertEquals("m", m.moduleName());
        assertEquals(1, m.line());
        assertFalse(m.macromodule());
        assertNull(m.moduleParameterPortListText());
        assertNull(m.portsListText());
    }

    @Test
    void macromoduleSetsMacromoduleFlagOnModuleStub() throws IOException {
        String text = readResource("/regression/mini_macromodule.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(1, sink.size());
        var m = assertInstanceOf(VerilogModuleDeclStub.class, sink.get(0));
        assertEquals("mm", m.moduleName());
        assertTrue(m.macromodule());
    }

    @Test
    void twoModulesProduceTwoModuleStubsInOrder() {
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                "module a();\nendmodule\nmodule b();\nendmodule\n",
                new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(2, sink.size());
        assertEquals("a", assertInstanceOf(VerilogModuleDeclStub.class, sink.get(0)).moduleName());
        assertEquals("b", assertInstanceOf(VerilogModuleDeclStub.class, sink.get(1)).moduleName());
    }

    @Test
    void miniInstanceEmitsInstanceStubsThenModule() throws IOException {
        String text = readResource("/regression/mini_instance.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var i0 = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(0));
        assertEquals("top", i0.enclosingModuleName());
        assertEquals("child", i0.moduleType());
        assertEquals("u1", i0.instanceName());
        assertNull(i0.parameterValueAssignmentText());
        assertNull(i0.portConnectionsText());
        var i1 = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(1));
        assertEquals("top", i1.enclosingModuleName());
        assertEquals("u2", i1.instanceName());
        assertNull(i1.parameterValueAssignmentText());
        assertNull(i1.portConnectionsText());
        var i2 = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(2));
        assertEquals("top", i2.enclosingModuleName());
        assertEquals("u3", i2.instanceName());
        assertNull(i2.parameterValueAssignmentText());
        assertNull(i2.portConnectionsText());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniInstanceNamedParamsRepeatsParameterTextOnEachInstanceStub() throws IOException {
        String text = readResource("/regression/mini_instance_named_params.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        var i0 = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(0));
        assertEquals("top", i0.enclosingModuleName());
        assertEquals("child", i0.moduleType());
        assertEquals("u1", i0.instanceName());
        assertNotNull(i0.parameterValueAssignmentText());
        assertTrue(i0.parameterValueAssignmentText().contains(".W"));
        var i1 = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(1));
        assertEquals("u2", i1.instanceName());
        assertEquals(i0.parameterValueAssignmentText(), i1.parameterValueAssignmentText());
        assertEquals("top", i1.enclosingModuleName());
        assertNull(i0.portConnectionsText());
        assertNull(i1.portConnectionsText());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
    }

    @Test
    void miniInstanceNamedPortConnsCapturesPortListText() throws IOException {
        String text = readResource("/regression/mini_instance_named_port_conns.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(2, sink.size());
        var i0 = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(0));
        assertEquals("top", i0.enclosingModuleName());
        assertEquals("child", i0.moduleType());
        assertNull(i0.parameterValueAssignmentText());
        assertNotNull(i0.portConnectionsText());
        assertTrue(i0.portConnectionsText().contains(".clk"));
        assertTrue(i0.portConnectionsText().contains(".d"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(1));
    }

    @Test
    void miniUdpEmitsUdpStub() throws IOException {
        String text = readResource("/regression/mini_udp.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(1, sink.size());
        var u = assertInstanceOf(VerilogUdpDeclStub.class, sink.get(0));
        assertEquals("p", u.udpName());
        assertTrue(u.synopsis().contains("primitive"));
        assertTrue(u.synopsis().contains("endtable"));
        assertTrue(u.synopsis().contains("endprimitive"));
    }

    @Test
    void anonymousInstanceHasNullInstanceName() {
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                "module top;\n  child ();\nendmodule\n", new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(2, sink.size());
        var inst = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(0));
        assertEquals("top", inst.enclosingModuleName());
        assertEquals("child", inst.moduleType());
        assertNull(inst.instanceName());
        assertNull(inst.parameterValueAssignmentText());
        assertNull(inst.portConnectionsText());
    }

    @Test
    void miniModuleItemPortsEmitsPortsThenModule() throws IOException {
        String text = readResource("/regression/mini_module_item_ports.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        var px = assertInstanceOf(VerilogPortDeclStub.class, sink.get(0));
        assertEquals("m", px.enclosingModuleName());
        assertEquals("x", px.portName());
        assertEquals("input", px.direction());
        var py = assertInstanceOf(VerilogPortDeclStub.class, sink.get(1));
        assertEquals("y", py.portName());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
    }

    @Test
    void miniAnsiPortsEmitsHeaderPortsThenModule() throws IOException {
        String text = readResource("/regression/mini_ansi_ports.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        var pa = assertInstanceOf(VerilogPortDeclStub.class, sink.get(0));
        assertEquals("a", pa.portName());
        assertEquals("input", pa.direction());
        var pb = assertInstanceOf(VerilogPortDeclStub.class, sink.get(1));
        assertEquals("b", pb.portName());
        assertEquals("output", pb.direction());
        var mod = assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
        assertNull(mod.moduleParameterPortListText());
        assertNotNull(mod.portsListText());
        assertTrue(mod.portsListText().contains("a"));
        assertTrue(mod.portsListText().contains("b"));
    }

    @Test
    void miniNonAnsiPortsEmitsListStubThenBodyPortDeclsThenModule() throws IOException {
        String text = readResource("/regression/mini_non_ansi_ports.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var list = assertInstanceOf(VerilogListOfPortsStub.class, sink.get(0));
        assertEquals("top", list.enclosingModuleName());
        assertTrue(list.synopsis().contains("a"));
        assertTrue(list.synopsis().contains("b"));
        var pa = assertInstanceOf(VerilogPortDeclStub.class, sink.get(1));
        assertEquals("a", pa.portName());
        assertEquals("input", pa.direction());
        var pb = assertInstanceOf(VerilogPortDeclStub.class, sink.get(2));
        assertEquals("b", pb.portName());
        var mod = assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
        assertNull(mod.moduleParameterPortListText());
        assertNotNull(mod.portsListText());
        assertTrue(mod.portsListText().contains("a"));
        assertTrue(mod.portsListText().contains("b"));
    }

    @Test
    void miniMiscDeclsEmitSignalStubsThenModule() throws IOException {
        String text = readResource("/regression/mini_misc_decl.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(9, sink.size());
        assertEquals("top", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0)).enclosingModuleName());
        assertEquals("integer", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0)).declarationKind());
        assertEquals("i", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0)).signalName());
        assertEquals("j", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(1)).signalName());
        assertEquals("time", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(2)).declarationKind());
        assertEquals("real", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(3)).declarationKind());
        assertEquals("realtime", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(4)).declarationKind());
        assertEquals("event", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(5)).declarationKind());
        assertEquals("e1", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(5)).signalName());
        assertEquals("e2", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(6)).signalName());
        assertEquals("genvar", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(7)).declarationKind());
        assertEquals("top", assertInstanceOf(VerilogModuleDeclStub.class, sink.get(8)).moduleName());
    }

    @Test
    void miniNetRegEmitsSignalsThenModule() throws IOException {
        String text = readResource("/regression/mini_net_reg.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var s0 = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0));
        assertEquals("top", s0.enclosingModuleName());
        assertEquals("w1", s0.signalName());
        assertEquals("net", s0.declarationKind());
        assertEquals("wire", s0.flavor());
        assertNull(s0.initializerText());
        var s1 = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(1));
        assertEquals("w2", s1.signalName());
        var s2 = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(2));
        assertEquals("reg", s2.declarationKind());
        assertEquals("r1", s2.signalName());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniNetDeclAssignEmitsSignalStubPerNetIdentifierThenModule() throws IOException {
        String text = readResource("/regression/mini_net_decl_assign.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var s0 = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0));
        assertEquals("wa", s0.signalName());
        assertEquals("wire", s0.flavor());
        assertEquals("1'b0", s0.initializerText());
        var s1 = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(1));
        assertEquals("wb", s1.signalName());
        assertEquals("1'b1", s1.initializerText());
        var s2 = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(2));
        assertEquals("wc", s2.signalName());
        assertEquals("1'b0", s2.initializerText());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniRegInitializerCapturesConstantExpressionText() throws IOException {
        String text = readResource("/regression/mini_reg_initializer.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(2, sink.size());
        var r = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0));
        assertEquals("r", r.signalName());
        assertEquals("reg", r.declarationKind());
        assertEquals("1'b0", r.initializerText());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(1));
    }

    @Test
    void miniGateInitialAlwaysEmitsStubsThenModule() throws IOException {
        String text = readResource("/regression/mini_gate_initial_always.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var g = assertInstanceOf(VerilogGateInstantiationStub.class, sink.get(0));
        assertEquals("top", g.enclosingModuleName());
        assertEquals("buf", g.gateKind());
        assertTrue(g.gateText().contains("buf"));
        var ini = assertInstanceOf(VerilogInitialConstructStub.class, sink.get(1));
        assertNull(ini.attrsOptText());
        assertTrue(ini.synopsis().contains("initial"));
        var alw = assertInstanceOf(VerilogAlwaysConstructStub.class, sink.get(2));
        assertNull(alw.attrsOptText());
        assertTrue(alw.synopsis().contains("always"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniInitialAlwaysAttrsCapturesAttrsOptText() throws IOException {
        String text = readResource("/regression/mini_initial_always_attrs.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        var ini = assertInstanceOf(VerilogInitialConstructStub.class, sink.get(0));
        assertEquals("top", ini.enclosingModuleName());
        assertNotNull(ini.attrsOptText());
        assertTrue(ini.attrsOptText().contains("keep"));
        var alw = assertInstanceOf(VerilogAlwaysConstructStub.class, sink.get(1));
        assertNotNull(alw.attrsOptText());
        assertTrue(alw.attrsOptText().contains("full_case"));
        assertTrue(alw.synopsis().contains("@(*)"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
    }

    @Test
    void miniTaskFunctionEmitsDeclStubsThenModule() throws IOException {
        String text = readResource("/regression/mini_task_function.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var task = assertInstanceOf(VerilogTaskDeclStub.class, sink.get(0));
        assertEquals("top", task.enclosingModuleName());
        assertEquals("t", task.taskName());
        var local = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(1));
        assertEquals("top", local.enclosingModuleName());
        assertEquals("integer", local.declarationKind());
        assertEquals("i", local.signalName());
        var fn = assertInstanceOf(VerilogFunctionDeclStub.class, sink.get(2));
        assertEquals("f", fn.functionName());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniParameterDeclEmitsOneStubPerParamAssignmentThenModule() throws IOException {
        String text = readResource("/regression/mini_parameter_decl.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var p0 = assertInstanceOf(VerilogParamDeclAssignmentStub.class, sink.get(0));
        assertEquals("m", p0.enclosingModuleName());
        assertEquals("parameter", p0.declarationKind());
        assertTrue(p0.assignmentText().contains("p"));
        var p1 = assertInstanceOf(VerilogParamDeclAssignmentStub.class, sink.get(1));
        assertEquals("localparam", p1.declarationKind());
        assertTrue(p1.assignmentText().contains("q"));
        var p2 = assertInstanceOf(VerilogParamDeclAssignmentStub.class, sink.get(2));
        assertEquals("localparam", p2.declarationKind());
        assertTrue(p2.assignmentText().contains("r"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniModuleHeaderParamsEmitModuleParameterPortStubsThenAnsiPortsThenModule() throws IOException {
        String text = readResource("/regression/mini_module_header_params.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var h0 = assertInstanceOf(VerilogParamDeclAssignmentStub.class, sink.get(0));
        assertEquals("m", h0.enclosingModuleName());
        assertEquals("module_parameter_port", h0.declarationKind());
        assertTrue(h0.assignmentText().contains("W"));
        var h1 = assertInstanceOf(VerilogParamDeclAssignmentStub.class, sink.get(1));
        assertEquals("module_parameter_port", h1.declarationKind());
        assertTrue(h1.assignmentText().contains("X"));
        var port = assertInstanceOf(VerilogPortDeclStub.class, sink.get(2));
        assertEquals("clk", port.portName());
        assertEquals("input", port.direction());
        var mod = assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
        assertNotNull(mod.moduleParameterPortListText());
        assertTrue(mod.moduleParameterPortListText().contains("W"));
        assertNotNull(mod.portsListText());
        assertTrue(mod.portsListText().contains("clk"));
    }

    @Test
    void miniSpecparamEmitsOneStubPerAssignmentThenModule() throws IOException {
        String text = readResource("/regression/mini_specparam.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        var s0 = assertInstanceOf(VerilogSpecparamAssignmentStub.class, sink.get(0));
        assertEquals("m", s0.enclosingModuleName());
        assertTrue(s0.assignmentText().contains("dly"));
        var s1 = assertInstanceOf(VerilogSpecparamAssignmentStub.class, sink.get(1));
        assertTrue(s1.assignmentText().contains("x"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
    }

    @Test
    void miniSpecifyBlockEmitsSpecparamStubsThenSpecifyBlockThenModule() throws IOException {
        String text = readResource("/regression/mini_specify_block.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        assertInstanceOf(VerilogSpecparamAssignmentStub.class, sink.get(0));
        var sp = assertInstanceOf(VerilogSpecifyBlockStub.class, sink.get(1));
        assertEquals("m", sp.enclosingModuleName());
        assertTrue(sp.synopsis().contains("specify"));
        assertTrue(sp.synopsis().contains("endspecify"));
        assertTrue(sp.synopsis().contains("t"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
    }

    @Test
    void miniDefparamEmitsOneStubPerAssignmentThenModule() throws IOException {
        String text = readResource("/regression/mini_defparam.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        var d0 = assertInstanceOf(VerilogDefparamAssignmentStub.class, sink.get(0));
        assertEquals("top", d0.enclosingModuleName());
        assertTrue(d0.assignmentText().contains("a"));
        assertTrue(d0.assignmentText().contains("b"));
        var d1 = assertInstanceOf(VerilogDefparamAssignmentStub.class, sink.get(1));
        assertTrue(d1.assignmentText().contains("c"));
        assertTrue(d1.assignmentText().contains("d"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
    }

    @Test
    void miniGenerateLabeledBlockEmitsBlockStubThenRegion() throws IOException {
        String text = readResource("/regression/mini_generate_labeled_block.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(5, sink.size());
        assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0));
        assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(1));
        var blk = assertInstanceOf(VerilogGenerateBlockStub.class, sink.get(2));
        assertEquals("m", blk.enclosingModuleName());
        assertEquals("generate/block:gb", blk.generateScopePath());
        assertEquals("block", blk.blockKind());
        assertEquals("gb", blk.blockLabel());
        assertTrue(blk.synopsis().contains("begin"));
        var gen = assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(3));
        assertEquals("generate", gen.generateScopePath());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(4));
    }

    @Test
    void miniGenerateForLoopEmitsForLoopStubWithLabel() throws IOException {
        String text = readResource("/regression/mini_generate_for_loop.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(6, sink.size());
        assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0));
        assertEquals("genvar", assertInstanceOf(VerilogSignalDeclStub.class, sink.get(1)).declarationKind());
        assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(2));
        var loop = assertInstanceOf(VerilogGenerateBlockStub.class, sink.get(3));
        assertEquals("generate/for_loop:gfor", loop.generateScopePath());
        assertEquals("for_loop", loop.blockKind());
        assertEquals("gfor", loop.blockLabel());
        assertTrue(loop.synopsis().contains("for"));
        assertEquals("generate", assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(4)).generateScopePath());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(5));
    }

    @Test
    void miniGenerateUnlabeledBlockHasNullBlockLabel() throws IOException {
        String text = readResource("/regression/mini_generate_unlabeled_block.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(5, sink.size());
        var blk = assertInstanceOf(VerilogGenerateBlockStub.class, sink.get(2));
        assertEquals("generate/block", blk.generateScopePath());
        assertEquals("block", blk.blockKind());
        assertNull(blk.blockLabel());
        assertEquals("generate", assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(3)).generateScopePath());
    }

    @Test
    void miniGenerateIfElseEmitsAssignsThenConditionalThenRegion() throws IOException {
        String text = readResource("/regression/mini_generate_if_else.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(7, sink.size());
        assertInstanceOf(VerilogParamDeclAssignmentStub.class, sink.get(0));
        assertInstanceOf(VerilogSignalDeclStub.class, sink.get(1));
        assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(2));
        assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(3));
        var cond = assertInstanceOf(VerilogGenerateConditionalStub.class, sink.get(4));
        assertEquals("m", cond.enclosingModuleName());
        assertEquals("generate/if", cond.generateScopePath());
        assertTrue(cond.synopsis().contains("if"));
        assertTrue(cond.synopsis().contains("else"));
        assertEquals("generate", assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(5)).generateScopePath());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(6));
    }

    @Test
    void miniGenerateCaseEmitsAssignsThenCaseThenRegion() throws IOException {
        String text = readResource("/regression/mini_generate_case.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(7, sink.size());
        assertInstanceOf(VerilogParamDeclAssignmentStub.class, sink.get(0));
        assertInstanceOf(VerilogSignalDeclStub.class, sink.get(1));
        assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(2));
        assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(3));
        var cs = assertInstanceOf(VerilogGenerateCaseStub.class, sink.get(4));
        assertEquals("m", cs.enclosingModuleName());
        assertEquals("generate/case", cs.generateScopePath());
        assertTrue(cs.synopsis().contains("case"));
        assertTrue(cs.synopsis().contains("endcase"));
        assertEquals("generate", assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(5)).generateScopePath());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(6));
    }

    @Test
    void miniGenerateRegionEmitsInnerAssignThenRegionThenModule() throws IOException {
        String text = readResource("/regression/mini_generate_region.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var net = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(0));
        assertEquals("m", net.enclosingModuleName());
        assertEquals("x", net.signalName());
        var ca = assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(1));
        assertTrue(ca.assignText().contains("x"));
        var gen = assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(2));
        assertEquals("m", gen.enclosingModuleName());
        assertEquals("generate", gen.generateScopePath());
        assertTrue(gen.synopsis().contains("generate"));
        assertTrue(gen.synopsis().contains("assign"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniContinuousAssignEmitsOneStubPerNetAssignmentThenModule() throws IOException {
        String text = readResource("/regression/mini_continuous_assign.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var c0 = assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(0));
        assertEquals("top", c0.enclosingModuleName());
        assertEquals("x=y", c0.assignText());
        assertTrue(c0.statementSynopsis().contains("x=y"));
        var c1 = assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(1));
        assertEquals("a=1'b0", c1.assignText());
        var c2 = assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(2));
        assertEquals("b=1'b1", c2.assignText());
        assertEquals(c1.statementSynopsis(), c2.statementSynopsis());
        assertTrue(c1.statementSynopsis().contains("a=1'b0"));
        assertTrue(c1.statementSynopsis().contains("b=1'b1"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniAnsiCommaOnlySecondPortEmitsBothPortsThenModule() throws IOException {
        String text = readResource("/regression/mini_ansi_comma_ident.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        var pa = assertInstanceOf(VerilogPortDeclStub.class, sink.get(0));
        assertEquals("a", pa.portName());
        assertEquals("input", pa.direction());
        var pb = assertInstanceOf(VerilogPortDeclStub.class, sink.get(1));
        assertEquals("b", pb.portName());
        assertEquals("input", pb.direction());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
    }

    private static String readResource(String path) throws IOException {
        try (InputStream in = VerilogWalkerPortDesignStubListenerTest.class.getResourceAsStream(path)) {
            assertNotNull(in, "missing resource " + path);
            return new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
    }
}
