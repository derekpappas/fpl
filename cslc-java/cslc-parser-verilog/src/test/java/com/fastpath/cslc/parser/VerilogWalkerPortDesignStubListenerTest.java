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
        assertEquals("child", i0.moduleType());
        assertEquals("u1", i0.instanceName());
        var i1 = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(1));
        assertEquals("u2", i1.instanceName());
        var i2 = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(2));
        assertEquals("u3", i2.instanceName());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniUdpEmitsUdpStub() throws IOException {
        String text = readResource("/regression/mini_udp.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(1, sink.size());
        var u = assertInstanceOf(VerilogUdpDeclStub.class, sink.get(0));
        assertEquals("p", u.udpName());
    }

    @Test
    void anonymousInstanceHasNullInstanceName() {
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                "module top;\n  child ();\nendmodule\n", new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(2, sink.size());
        var inst = assertInstanceOf(VerilogModuleInstanceStub.class, sink.get(0));
        assertEquals("child", inst.moduleType());
        assertNull(inst.instanceName());
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
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
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
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
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
        var s1 = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(1));
        assertEquals("w2", s1.signalName());
        var s2 = assertInstanceOf(VerilogSignalDeclStub.class, sink.get(2));
        assertEquals("reg", s2.declarationKind());
        assertEquals("r1", s2.signalName());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniGateInitialAlwaysEmitsStubsThenModule() throws IOException {
        String text = readResource("/regression/mini_gate_initial_always.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(4, sink.size());
        var g = assertInstanceOf(VerilogGateInstantiationStub.class, sink.get(0));
        assertEquals("top", g.enclosingModuleName());
        assertTrue(g.gateText().contains("buf"));
        var ini = assertInstanceOf(VerilogInitialConstructStub.class, sink.get(1));
        assertTrue(ini.synopsis().contains("initial"));
        var alw = assertInstanceOf(VerilogAlwaysConstructStub.class, sink.get(2));
        assertTrue(alw.synopsis().contains("always"));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
    }

    @Test
    void miniTaskFunctionEmitsDeclStubsThenModule() throws IOException {
        String text = readResource("/regression/mini_task_function.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(3, sink.size());
        var task = assertInstanceOf(VerilogTaskDeclStub.class, sink.get(0));
        assertEquals("top", task.enclosingModuleName());
        assertEquals("t", task.taskName());
        var fn = assertInstanceOf(VerilogFunctionDeclStub.class, sink.get(1));
        assertEquals("f", fn.functionName());
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(2));
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
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(3));
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
        assertEquals("block", blk.blockKind());
        assertEquals("gb", blk.blockLabel());
        assertTrue(blk.synopsis().contains("begin"));
        assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(3));
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
        assertEquals("for_loop", loop.blockKind());
        assertEquals("gfor", loop.blockLabel());
        assertTrue(loop.synopsis().contains("for"));
        assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(4));
        assertInstanceOf(VerilogModuleDeclStub.class, sink.get(5));
    }

    @Test
    void miniGenerateUnlabeledBlockHasNullBlockLabel() throws IOException {
        String text = readResource("/regression/mini_generate_unlabeled_block.v");
        List<VerilogDesignElementStub> sink = new ArrayList<>();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new VerilogWalkerPortDesignStubListener(sink));
        assertEquals(5, sink.size());
        var blk = assertInstanceOf(VerilogGenerateBlockStub.class, sink.get(2));
        assertEquals("block", blk.blockKind());
        assertNull(blk.blockLabel());
        assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(3));
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
        assertTrue(cond.synopsis().contains("if"));
        assertTrue(cond.synopsis().contains("else"));
        assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(5));
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
        assertTrue(cs.synopsis().contains("case"));
        assertTrue(cs.synopsis().contains("endcase"));
        assertInstanceOf(VerilogGenerateRegionStub.class, sink.get(5));
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
        var c1 = assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(1));
        assertEquals("a=1'b0", c1.assignText());
        var c2 = assertInstanceOf(VerilogContinuousAssignStub.class, sink.get(2));
        assertEquals("b=1'b1", c2.assignText());
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
