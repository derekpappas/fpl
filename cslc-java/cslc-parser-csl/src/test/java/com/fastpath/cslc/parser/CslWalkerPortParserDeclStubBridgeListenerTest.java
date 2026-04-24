package com.fastpath.cslc.parser;

import com.fastpath.cslc.cslom.CslomBase;
import com.fastpath.cslc.cslom.CslomDesignStub;
import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;
import com.fastpath.cslc.cslom.CslomUnitDecl;
import com.fastpath.cslc.cslom.decl.CslomCommandDecl;
import com.fastpath.cslc.cslom.decl.CslomInterfaceDecl;
import com.fastpath.cslc.cslom.decl.CslomPortDecl;
import com.fastpath.cslc.cslom.decl.CslomSignalDecl;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class CslWalkerPortParserDeclStubBridgeListenerTest {

    @Test
    void minimalCslProducesNamedUnitStub() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/minimal.csl")) {
            assertNotNull(in, "missing /regression/minimal.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        var stub = assertInstanceOf(CslomUnitDecl.class, sink.get(0));
        assertEquals(CslomNodeType.TYPE_DECL_UNIT, stub.getNodeType());
        assertEquals("u", stub.declaredName().orElseThrow());
        assertEquals("csl_unit_declaration", stub.antlrRuleSimpleName().orElseThrow());
        assertTrue(stub.antlrText().orElseThrow().contains(stub.declaredName().orElseThrow()));
        assertTrue(stub.getLineNumber() >= 1);
    }

    @Test
    void miniMultiDeclEmitsInnerDeclsThenUnit() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_multi_decl.csl")) {
            assertNotNull(in, "missing /regression/mini_multi_decl.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(4, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_ALL_PORTS, "p");
        var port = assertInstanceOf(CslomPortDecl.class, sink.get(0));
        assertEquals("0", port.firstPortParamListText().orElseThrow());
        assertEquals(1, port.firstPortParamExprCount().orElseThrow());
        assertStub(sink.get(1), CslomNodeType.TYPE_ALL_INTERFACES, "i");
        assertStub(sink.get(2), CslomNodeType.TYPE_BIT_RANGE, "b");
        assertStub(sink.get(3), CslomNodeType.TYPE_DECL_UNIT, "u");
    }

    @Test
    void miniSignalEmitsSignalThenUnitStub() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal.csl")) {
            assertNotNull(in, "missing /regression/mini_signal.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals(CslomNodeType.TYPE_ALL_SIGNALS, sig.getNodeType());
        assertEquals("s", sig.declaredName().orElseThrow());
        assertTrue(sig.firstSignalParamListText().isEmpty());
        assertEquals("csl_signal_declaration", sig.antlrRuleSimpleName().orElseThrow());
        assertTrue(sig.antlrText().orElseThrow().contains(sig.declaredName().orElseThrow()));
        var unit = assertInstanceOf(CslomUnitDecl.class, sink.get(1));
        assertEquals(CslomNodeType.TYPE_DECL_UNIT, unit.getNodeType());
        assertEquals("u", unit.declaredName().orElseThrow());
        assertEquals("csl_unit_declaration", unit.antlrRuleSimpleName().orElseThrow());
        assertTrue(unit.antlrText().orElseThrow().contains(unit.declaredName().orElseThrow()));
    }

    @Test
    void miniTbFifoEmitsTestbenchFifoThenUnit() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_tb_fifo.csl")) {
            assertNotNull(in, "missing /regression/mini_tb_fifo.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_DECL_TESTBENCH, "tb");
        assertStub(sink.get(1), CslomNodeType.TYPE_CONTAINER, "f");
        assertStub(sink.get(2), CslomNodeType.TYPE_DECL_UNIT, "u");
    }

    @Test
    void designStubAcceptsChildDeclStubs() {
        var design = new CslomDesignStub(1, 0, "virtual.csl");
        var unit = new CslomUnitDecl("u", 2, 0, "virtual.csl");
        design.addChild(unit);
        assertEquals(1, design.getChildren().size());
        assertEquals(CslomNodeType.TYPE_DESIGN, design.getNodeType());
    }

    @Test
    void miniSignalHierarchyLinksSignalUnderUnitOnDesign() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal.csl")) {
            assertNotNull(in);
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        var design = new CslomDesignStub(0, 0, "mini_signal.csl");
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink, design));
        assertEquals(1, design.getChildren().size());
        var unit = assertInstanceOf(CslomUnitDecl.class, design.getChildren().get(0));
        assertEquals("u", unit.declaredName().orElseThrow());
        assertEquals(1, unit.getChildren().size());
        var sig = assertInstanceOf(CslomSignalDecl.class, unit.getChildren().get(0));
        assertEquals(CslomNodeType.TYPE_ALL_SIGNALS, sig.getNodeType());
        assertEquals("s", sig.declaredName().orElseThrow());
        assertEquals(2, sink.size());
    }

    @Test
    void miniUnitInstEmitsInstantiationStubsThenUnit() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_inst.csl")) {
            assertNotNull(in, "missing /regression/mini_unit_inst.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c1");
        assertStub(sink.get(1), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c2");
        assertStub(sink.get(2), CslomNodeType.TYPE_DECL_UNIT, "parent");
    }

    @Test
    void miniUnitInstHierarchyLinksInstancesUnderUnit() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_inst.csl")) {
            assertNotNull(in);
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        var design = new CslomDesignStub(0, 0, "mini_unit_inst.csl");
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink, design));
        assertEquals(1, design.getChildren().size());
        var unit = assertInstanceOf(CslomUnitDecl.class, design.getChildren().get(0));
        assertEquals("parent", unit.declaredName().orElseThrow());
        assertEquals(2, unit.getChildren().size());
        assertStub(unit.getChildren().get(0), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c1");
        assertStub(unit.getChildren().get(1), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c2");
        assertEquals(3, sink.size());
    }

    @Test
    void miniUnitCtorEmitsInstUnitStubForTemplateIdentifier() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_ctor.csl")) {
            assertNotNull(in, "missing /regression/mini_unit_ctor.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_INST_UNIT, "sub_unit");
        assertStub(sink.get(1), CslomNodeType.TYPE_DECL_UNIT, "parent");
    }

    @Test
    void miniFileCommandEmitsCommandStubWithReceiverName() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_file_command.csl")) {
            assertNotNull(in, "missing /regression/mini_file_command.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("no_prefix", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniUnitPreprocCmdEmitsStmtSignalThenUnit() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_preproc_cmd.csl")) {
            assertNotNull(in, "missing /regression/mini_unit_preproc_cmd.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_STMT, "f.csl");
        assertStub(sink.get(1), CslomNodeType.TYPE_ALL_SIGNALS, "s");
        assertStub(sink.get(2), CslomNodeType.TYPE_DECL_UNIT, "parent");
    }

    @Test
    void miniUnitPreprocCmdHierarchyOrdersStmtAndSignalUnderUnit() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_preproc_cmd.csl")) {
            assertNotNull(in);
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        var design = new CslomDesignStub(0, 0, "mini_unit_preproc_cmd.csl");
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink, design));
        assertEquals(1, design.getChildren().size());
        var unit = assertInstanceOf(CslomUnitDecl.class, design.getChildren().get(0));
        assertEquals("parent", unit.declaredName().orElseThrow());
        assertEquals(2, unit.getChildren().size());
        assertStub(unit.getChildren().get(0), CslomNodeType.TYPE_STMT, "f.csl");
        assertStub(unit.getChildren().get(1), CslomNodeType.TYPE_ALL_SIGNALS, "s");
        assertEquals(3, sink.size());
    }

    @Test
    void miniUnitCtorCommandEmitsCommandInstAndUnitStubs() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_ctor_command.csl")) {
            assertNotNull(in, "missing /regression/mini_unit_ctor_command.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "command");
        assertEquals(
                "no_prefix",
                assertInstanceOf(CslomCommandDecl.class, sink.get(0)).inferredVerb().orElseThrow());
        assertStub(sink.get(1), CslomNodeType.TYPE_INST_UNIT, "sub_unit");
        assertStub(sink.get(2), CslomNodeType.TYPE_DECL_UNIT, "parent");
    }

    @Test
    void miniUnitCtorCommandHierarchyLinksCommandAndInstUnderUnit() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_ctor_command.csl")) {
            assertNotNull(in);
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        var design = new CslomDesignStub(0, 0, "mini_unit_ctor_command.csl");
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink, design));
        assertEquals(1, design.getChildren().size());
        var unit = assertInstanceOf(CslomUnitDecl.class, design.getChildren().get(0));
        assertEquals("parent", unit.declaredName().orElseThrow());
        assertEquals(2, unit.getChildren().size());
        assertStub(unit.getChildren().get(0), CslomNodeType.TYPE_COMMAND, "command");
        assertEquals(
                "no_prefix",
                assertInstanceOf(CslomCommandDecl.class, unit.getChildren().get(0))
                        .inferredVerb()
                        .orElseThrow());
        assertStub(unit.getChildren().get(1), CslomNodeType.TYPE_INST_UNIT, "sub_unit");
        assertEquals(3, sink.size());
    }

    @Test
    void miniUnitBodyMixFlatEmitsCommandCtorInstsStmtSignalThenUnit() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_body_mix.csl")) {
            assertNotNull(in, "missing /regression/mini_unit_body_mix.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(7, sink.size());

        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "command");
        assertEquals(
                "no_prefix",
                assertInstanceOf(CslomCommandDecl.class, sink.get(0)).inferredVerb().orElseThrow());
        assertStub(sink.get(1), CslomNodeType.TYPE_INST_UNIT, "sub_unit");
        assertStub(sink.get(2), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c1");
        assertStub(sink.get(3), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c2");
        assertStub(sink.get(4), CslomNodeType.TYPE_STMT, "f.csl");
        assertStub(sink.get(5), CslomNodeType.TYPE_ALL_SIGNALS, "s");
        assertStub(sink.get(6), CslomNodeType.TYPE_DECL_UNIT, "parent");
    }

    @Test
    void miniUnitBodyMixHierarchyLinksAllInnerNodesUnderUnitInExitOrder() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_unit_body_mix.csl")) {
            assertNotNull(in);
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        var design = new CslomDesignStub(0, 0, "mini_unit_body_mix.csl");
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink, design));

        assertEquals(1, design.getChildren().size());
        var unit = assertInstanceOf(CslomUnitDecl.class, design.getChildren().get(0));
        assertEquals("parent", unit.declaredName().orElseThrow());
        assertEquals(6, unit.getChildren().size());
        assertStub(unit.getChildren().get(0), CslomNodeType.TYPE_COMMAND, "command");
        assertStub(unit.getChildren().get(1), CslomNodeType.TYPE_INST_UNIT, "sub_unit");
        assertStub(unit.getChildren().get(2), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c1");
        assertStub(unit.getChildren().get(3), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c2");
        assertStub(unit.getChildren().get(4), CslomNodeType.TYPE_STMT, "f.csl");
        assertStub(unit.getChildren().get(5), CslomNodeType.TYPE_ALL_SIGNALS, "s");

        assertEquals(7, sink.size());
    }

    @Test
    void miniAssignOverrideCommandEmitsCommandStubsWithAssignVerbAndReceiverName() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_assign_override_command.csl")) {
            assertNotNull(in, "missing /regression/mini_assign_override_command.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var assign = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("u", assign.declaredName().orElseThrow());
        assertEquals("assign", assign.inferredVerb().orElseThrow());
        var override = assertInstanceOf(CslomCommandDecl.class, sink.get(1));
        assertEquals("u", override.declaredName().orElseThrow());
        assertEquals("override_parameter", override.inferredVerb().orElseThrow());
    }

    @Test
    void miniNestedUnitFlatEmitsSignalInnerOuterInExitOrder() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_nested_unit.csl")) {
            assertNotNull(in, "missing /regression/mini_nested_unit.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_ALL_SIGNALS, "s");
        var inner = assertInstanceOf(CslomUnitDecl.class, sink.get(1));
        assertEquals("inner", inner.declaredName().orElseThrow());
        var outer = assertInstanceOf(CslomUnitDecl.class, sink.get(2));
        assertEquals("outer", outer.declaredName().orElseThrow());
    }

    @Test
    void miniNestedUnitHierarchyNestsInnerUnitAndSignalUnderOuter() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_nested_unit.csl")) {
            assertNotNull(in);
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        var design = new CslomDesignStub(0, 0, "mini_nested_unit.csl");
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink, design));
        assertEquals(1, design.getChildren().size());
        var outer = assertInstanceOf(CslomUnitDecl.class, design.getChildren().get(0));
        assertEquals("outer", outer.declaredName().orElseThrow());
        assertEquals(1, outer.getChildren().size());
        var inner = assertInstanceOf(CslomUnitDecl.class, outer.getChildren().get(0));
        assertEquals("inner", inner.declaredName().orElseThrow());
        assertEquals(1, inner.getChildren().size());
        var sig = assertInstanceOf(CslomSignalDecl.class, inner.getChildren().get(0));
        assertEquals("s", sig.declaredName().orElseThrow());
        assertEquals(3, sink.size());
    }

    @Test
    void miniPortParamCapturesFirstParamListText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_port_param.csl")) {
            assertNotNull(in, "missing /regression/mini_port_param.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var port = assertInstanceOf(CslomPortDecl.class, sink.get(0));
        assertEquals("42", port.firstPortParamListText().orElseThrow());
        assertEquals(1, port.firstPortParamExprCount().orElseThrow());
        assertEquals(List.of("42"), port.firstPortParamExprTexts().orElseThrow());
    }

    @Test
    void miniSignalParamCapturesFirstParamListText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal_param.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_param.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("7", sig.firstSignalParamListText().orElseThrow());
        assertEquals(1, sig.firstSignalParamExprCount().orElseThrow());
        assertEquals(List.of("7"), sig.firstSignalParamExprTexts().orElseThrow());
    }

    @Test
    void miniSignalBitrangeParamCapturesBitrangePureTextAndExprCount() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal_bitrange_param.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_bitrange_param.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("7,[3:0]", sig.firstSignalParamListText().orElseThrow());
        assertEquals(1, sig.firstSignalParamExprCount().orElseThrow());
        assertEquals(List.of("7"), sig.firstSignalParamExprTexts().orElseThrow());
        assertEquals("[3:0]", sig.firstSignalBitrangePureText().orElseThrow());
    }

    @Test
    void miniPortParamMultiCapturesExprTextsInSourceOrder() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_port_param_multi.csl")) {
            assertNotNull(in, "missing /regression/mini_port_param_multi.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var port = assertInstanceOf(CslomPortDecl.class, sink.get(0));
        assertEquals("1,2,3,4", port.firstPortParamListText().orElseThrow());
        assertEquals(4, port.firstPortParamExprCount().orElseThrow());
        assertEquals(List.of("1", "2", "3", "4"), port.firstPortParamExprTexts().orElseThrow());
    }

    @Test
    void miniSignalParamMultiCapturesExprTextsInSourceOrder() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal_param_multi.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_param_multi.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("1,2,3", sig.firstSignalParamListText().orElseThrow());
        assertEquals(3, sig.firstSignalParamExprCount().orElseThrow());
        assertEquals(List.of("1", "2", "3"), sig.firstSignalParamExprTexts().orElseThrow());
    }

    @Test
    void miniBitrangeParamMultiCapturesFirstTwoExprTexts() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_bitrange_param_multi.csl")) {
            assertNotNull(in, "missing /regression/mini_bitrange_param_multi.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var br = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomBitrangeDecl.class, sink.get(0));
        assertEquals("b", br.declaredName().orElseThrow());
        assertEquals(List.of("7", "0"), br.firstBitrangeParamExprTexts().orElseThrow());
    }

    @Test
    void miniMultiDimBitrangeParamCapturesFirstExprText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_multi_dim_bitrange_param.csl")) {
            assertNotNull(in, "missing /regression/mini_multi_dim_bitrange_param.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var br = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomMultiDimBitrangeDecl.class, sink.get(0));
        assertEquals("mdb", br.declaredName().orElseThrow());
        assertEquals(List.of("2"), br.firstMultiDimBitrangeParamExprTexts().orElseThrow());
    }

    @Test
    void miniPipelineParamCapturesFirstExprText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_pipeline_param.csl")) {
            assertNotNull(in, "missing /regression/mini_pipeline_param.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var p = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomPipelineDecl.class, sink.get(0));
        assertEquals("p", p.declaredName().orElseThrow());
        assertEquals(List.of("3"), p.firstPipelineParamExprTexts().orElseThrow());
    }

    @Test
    void miniPipestageEmitsTypedPipestageDecl() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_pipestage.csl")) {
            assertNotNull(in, "missing /regression/mini_pipestage.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var ps = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomPipestageDecl.class, sink.get(0));
        assertEquals("ps", ps.declaredName().orElseThrow());
        assertEquals("csl_pipestage_declaration", ps.antlrRuleSimpleName().orElseThrow());
    }

    @Test
    void miniParameterParamMultiCapturesFirstTwoExprTexts() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_parameter_param_multi.csl")) {
            assertNotNull(in, "missing /regression/mini_parameter_param_multi.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var p = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomParameterDecl.class, sink.get(0));
        assertEquals("p", p.declaredName().orElseThrow());
        assertEquals(List.of("1", "2"), p.firstParamExprTexts().orElseThrow());
    }

    @Test
    void miniVectorWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_vector_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_vector_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var vec = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomVectorDecl.class, sink.get(1));
        assertEquals("v", vec.declaredName().orElseThrow());
        assertTrue(vec.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniStateDataWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_state_data_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_state_data_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var sd = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomStateDataDecl.class, sink.get(1));
        assertEquals("sd", sd.declaredName().orElseThrow());
        assertTrue(sd.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniMemoryWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_memory_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_memory_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var mem = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomMemoryDecl.class, sink.get(1));
        assertEquals("mem", mem.declaredName().orElseThrow());
        assertTrue(mem.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniReadInterfaceMapsLegacyWalkerRuleToCslInterfaceDeclaration() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_read_interface.csl")) {
            assertNotNull(in, "missing /regression/mini_read_interface.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var ifc = assertInstanceOf(CslomInterfaceDecl.class, sink.get(0));
        assertEquals("ri", ifc.declaredName().orElseThrow());
        assertEquals("csl_read_interface_declaration", ifc.antlrRuleSimpleName().orElseThrow());
        assertEquals("csl_interface_declaration", ifc.legacyWalkerRuleSimpleName().orElseThrow());
    }

    @Test
    void miniWriteInterfaceMapsLegacyWalkerRuleToCslInterfaceDeclaration() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_write_interface.csl")) {
            assertNotNull(in, "missing /regression/mini_write_interface.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var ifc = assertInstanceOf(CslomInterfaceDecl.class, sink.get(0));
        assertEquals("wi", ifc.declaredName().orElseThrow());
        assertEquals("csl_write_interface_declaration", ifc.antlrRuleSimpleName().orElseThrow());
        assertEquals("csl_interface_declaration", ifc.legacyWalkerRuleSimpleName().orElseThrow());
    }

    @Test
    void miniConstIntMapsLegacyWalkerRuleToParameterDeclaration() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_const_int.csl")) {
            assertNotNull(in, "missing /regression/mini_const_int.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var c = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomParameterDecl.class, sink.get(0));
        assertEquals("x", c.declaredName().orElseThrow());
        assertEquals("csl_const_int_declaration", c.antlrRuleSimpleName().orElseThrow());
        assertEquals("csl_parameter_declaration", c.legacyWalkerRuleSimpleName().orElseThrow());
    }

    private static void assertStub(CslomBase node, CslomNodeType type, String name) {
        var stub = assertInstanceOf(CslomNamedDecl.class, node);
        assertEquals(type, stub.getNodeType());
        assertEquals(name, stub.declaredName().orElseThrow());
    }
}
