package com.fastpath.cslc.parser;

import com.fastpath.cslc.cslom.CslomBase;
import com.fastpath.cslc.cslom.CslomDesignStub;
import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;
import com.fastpath.cslc.cslom.CslomUnitDecl;
import com.fastpath.cslc.cslom.decl.CslomCommandDecl;
import com.fastpath.cslc.cslom.decl.CslomEnumDecl;
import com.fastpath.cslc.cslom.decl.CslomIncludeDecl;
import com.fastpath.cslc.cslom.decl.CslomInterfaceDecl;
import com.fastpath.cslc.cslom.decl.CslomListDecl;
import com.fastpath.cslc.cslom.decl.CslomPortDecl;
import com.fastpath.cslc.cslom.decl.CslomSignalDecl;
import com.fastpath.cslc.cslom.decl.CslomTestbenchDecl;
import com.fastpath.cslc.cslom.decl.CslomFieldDecl;
import com.fastpath.cslc.cslom.decl.CslomIsaElementDecl;
import com.fastpath.cslc.cslom.decl.CslomIsaFieldDecl;
import com.fastpath.cslc.cslom.decl.CslomMemoryMapDecl;
import com.fastpath.cslc.cslom.decl.CslomMemoryMapPageDecl;
import com.fastpath.cslc.cslom.decl.CslomRegisterDecl;
import com.fastpath.cslc.cslom.decl.CslomRegisterFileDecl;
import com.fastpath.cslc.cslom.decl.CslomSignalGroupDecl;
import com.fastpath.cslc.cslom.decl.CslomInstUnitDecl;
import com.fastpath.cslc.cslom.decl.CslomUnitInstantiationDecl;
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
        assertEquals(0L, port.firstPortFirstParamIntLiteral().orElseThrow());
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
    void miniTestbenchWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_testbench_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_testbench_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_ALL_SIGNALS, "s");
        var tb = assertInstanceOf(CslomTestbenchDecl.class, sink.get(1));
        assertEquals("tb", tb.declaredName().orElseThrow());
        assertTrue(tb.unitDefinitionText().orElseThrow().contains("csl_signal"));
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
        var i1 = assertInstanceOf(CslomUnitInstantiationDecl.class, sink.get(0));
        assertEquals("child_unit", i1.templateUnitName().orElseThrow());
        assertStub(sink.get(1), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c2");
        var i2 = assertInstanceOf(CslomUnitInstantiationDecl.class, sink.get(1));
        assertEquals("child_unit", i2.templateUnitName().orElseThrow());
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
        assertEquals(
                "child_unit",
                assertInstanceOf(CslomUnitInstantiationDecl.class, unit.getChildren().get(0))
                        .templateUnitName()
                        .orElseThrow());
        assertStub(unit.getChildren().get(1), CslomNodeType.TYPE_UNIT_INSTANTIATION, "c2");
        assertEquals(
                "child_unit",
                assertInstanceOf(CslomUnitInstantiationDecl.class, unit.getChildren().get(1))
                        .templateUnitName()
                        .orElseThrow());
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
        var ctor = assertInstanceOf(CslomInstUnitDecl.class, sink.get(0));
        assertEquals("sub_unit", ctor.templateUnitName().orElseThrow());
        assertTrue(ctor.ctorDeclaredInstanceNames().orElseThrow().isEmpty());
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
        assertTrue(cmd.commandText().orElseThrow().contains("no_prefix"));
    }

    @Test
    void miniCommandSetWidthEmitsCommandStubWithSetWidthVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_width.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_width.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_width", cmd.inferredVerb().orElseThrow());
        assertEquals("u", cmd.receiverIdentifier().orElseThrow());
        assertEquals(List.of("8"), cmd.paramExprTexts().orElseThrow());
        assertEquals("u.", cmd.receiverChainText().orElseThrow());
        assertEquals("param_list_set_width", cmd.paramListAntlrRuleSimpleName().orElseThrow());
    }

    @Test
    void receiverlessMiniCommandSetWidthUsesVerbAsDefaultNameAndInfersVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_width_no_receiver.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_width_no_receiver.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "set_width");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_width", cmd.inferredVerb().orElseThrow());
        assertEquals("set_width", cmd.verbTokenText().orElseThrow());
        assertTrue(cmd.receiverIdentifier().isEmpty());
        assertEquals(List.of("8"), cmd.paramExprTexts().orElseThrow());
        assertEquals("param_list_set_width", cmd.paramListAntlrRuleSimpleName().orElseThrow());
    }

    @Test
    void miniCommandSetDepthEmitsCommandStubWithSetDepthVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_depth.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_depth.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_depth", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandCreateRtlModuleEmitsCommandStubWithCreateRtlModuleVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_create_rtl_module.csl")) {
            assertNotNull(in, "missing /regression/mini_command_create_rtl_module.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("create_rtl_module", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetNameEmitsCommandStubWithSetNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetTypeEmitsCommandStubWithSetTypeVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_type.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_type.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_type", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandDirectiveEmitsCommandStubWithDirectiveVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_directive.csl")) {
            assertNotNull(in, "missing /regression/mini_command_directive.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("directive", cmd.inferredVerb().orElseThrow());
        assertEquals("u", cmd.receiverIdentifier().orElseThrow());
        assertEquals(List.of("d"), cmd.paramExprTexts().orElseThrow());
        assertEquals("d", cmd.firstCommandFirstParamIdentifier().orElseThrow());
        assertEquals("param_list_directive", cmd.paramListAntlrRuleSimpleName().orElseThrow());
    }

    @Test
    void miniCommandSetDirectionEmitsCommandStubWithSetDirectionVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_direction.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_direction.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_direction", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetRadixEmitsCommandStubWithSetRadixVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_radix.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_radix.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_radix", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandExclusionListEmitsCommandStubWithExclusionListVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_exclusion_list.csl")) {
            assertNotNull(in, "missing /regression/mini_command_exclusion_list.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("exclusion_list", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandIncludeOnlyEmitsCommandStubWithIncludeOnlyVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_include_only.csl")) {
            assertNotNull(in, "missing /regression/mini_command_include_only.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("include_only", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandIncludeOnlyStringsCapturesSecondStringLiteral() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_include_only_strings.csl")) {
            assertNotNull(in, "missing /regression/mini_command_include_only_strings.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("include_only", cmd.inferredVerb().orElseThrow());
        assertEquals(List.of("\"a\"", "\"b\""), cmd.paramExprTexts().orElseThrow());
        assertEquals("a", cmd.firstCommandFirstParamStringLiteral().orElseThrow());
        assertEquals("b", cmd.firstCommandSecondParamStringLiteral().orElseThrow());
    }

    @Test
    void miniCommandReverseEmitsCommandStubWithReverseVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_reverse.csl")) {
            assertNotNull(in, "missing /regression/mini_command_reverse.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("reverse", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetOffsetEmitsCommandStubWithSetOffsetVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_offset.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_offset.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_offset", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetPrefixEmitsCommandStubWithSetPrefixVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_prefix.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_prefix.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_prefix", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetSuffixEmitsCommandStubWithSetSuffixVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_suffix.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_suffix.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_suffix", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetTopUnitEmitsCommandStubWithSetTopUnitVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_top_unit.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_top_unit.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_top_unit", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetNumberOfDimensionsEmitsCommandStubWithSetNumberOfDimensionsVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_number_of_dimensions.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_number_of_dimensions.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_number_of_dimensions", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetAlignmentEmitsCommandStubWithSetAlignmentVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_alignment.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_alignment.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_alignment", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetEndianessEmitsCommandStubWithSetEndianessVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_endianess.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_endianess.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_endianess", cmd.inferredVerb().orElseThrow());
        assertEquals("u", cmd.receiverIdentifier().orElseThrow());
        assertEquals(List.of("\"little\""), cmd.paramExprTexts().orElseThrow());
        assertEquals("little", cmd.firstCommandFirstParamStringLiteral().orElseThrow());
    }

    @Test
    void miniCommandSetRangeEmitsCommandStubWithSetRangeVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_range.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_range.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_range", cmd.inferredVerb().orElseThrow());
        assertEquals("u", cmd.receiverIdentifier().orElseThrow());
        assertEquals(List.of("1", "2"), cmd.paramExprTexts().orElseThrow());
        assertEquals(2, cmd.paramExprCount().orElseThrow());
        assertEquals(1L, cmd.firstCommandFirstParamIntLiteral().orElseThrow());
        assertEquals(2L, cmd.firstCommandSecondParamIntLiteral().orElseThrow());
    }

    @Test
    void miniCommandSetDimRangeEmitsCommandStubWithSetDimRangeVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_dim_range.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_dim_range.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_dim_range", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandAutoGenMemoryMapEmitsCommandStubWithAutoGenMemoryMapVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_auto_gen_memory_map.csl")) {
            assertNotNull(in, "missing /regression/mini_command_auto_gen_memory_map.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("auto_gen_memory_map", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandAddToMemoryMapEmitsCommandStubWithAddToMemoryMapVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_add_to_memory_map.csl")) {
            assertNotNull(in, "missing /regression/mini_command_add_to_memory_map.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("add_to_memory_map", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetMemInstanceNameEmitsCommandStubWithSetMemInstanceNameVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_mem_instance_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_mem_instance_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_mem_instance_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetResetNameEmitsCommandStubWithSetResetNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_reset_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_reset_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_reset_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetUnitPrefixEmitsCommandStubWithSetUnitPrefixVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_unit_prefix.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_unit_prefix.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_unit_prefix", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetSignalPrefixEmitsCommandStubWithSetSignalPrefixVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_signal_prefix.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_signal_prefix.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_signal_prefix", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetSignalPrefixLocalEmitsCommandStubWithSetSignalPrefixLocalVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_signal_prefix_local.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_signal_prefix_local.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_signal_prefix_local", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetDimOffsetEmitsCommandStubWithSetDimOffsetVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_dim_offset.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_dim_offset.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_dim_offset", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetDimWidthEmitsCommandStubWithSetDimWidthVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_dim_width.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_dim_width.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_dim_width", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetDimBitrangeEmitsCommandStubWithSetDimBitrangeVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_dim_bitrange.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_dim_bitrange.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_dim_bitrange", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetBitrangeEmitsCommandStubWithSetBitrangeVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_bitrange.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_bitrange.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_bitrange", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetClockNameEmitsCommandStubWithSetClockNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_clock_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_clock_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_clock_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetRdClockNameEmitsCommandStubWithSetRdClockNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_rd_clock_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_rd_clock_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_rd_clock_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetWrClockNameEmitsCommandStubWithSetWrClockNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_wr_clock_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_wr_clock_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_wr_clock_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetPushNameEmitsCommandStubWithSetPushNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_push_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_push_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_push_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetPopNameEmitsCommandStubWithSetPopNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_pop_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_pop_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_pop_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetFullNameEmitsCommandStubWithSetFullNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_full_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_full_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_full_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetEmptyNameEmitsCommandStubWithSetEmptyNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_empty_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_empty_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_empty_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetWrDataNameEmitsCommandStubWithSetWrDataNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_wr_data_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_wr_data_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_wr_data_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetRdDataNameEmitsCommandStubWithSetRdDataNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_rd_data_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_rd_data_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_rd_data_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetDataWordWidthEmitsCommandStubWithSetDataWordWidthVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_data_word_width.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_data_word_width.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_data_word_width", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetAddressIncrementEmitsCommandStubWithSetAddressIncrementVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_address_increment.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_address_increment.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_address_increment", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetNextAddressEmitsCommandStubWithSetNextAddressVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_next_address.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_next_address.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_next_address", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetNextEmitsCommandStubWithSetNextVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_next.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_next.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_next", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetPreviousEmitsCommandStubWithSetPreviousVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_previous.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_previous.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_previous", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetValidNameEmitsCommandStubWithSetValidNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_valid_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_valid_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_valid_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetSymbolMaxLengthEmitsCommandStubWithSetSymbolMaxLengthVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_symbol_max_length.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_symbol_max_length.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_symbol_max_length", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetEnumEmitsCommandStubWithSetEnumVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_enum.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_enum.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_enum", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetEnumItemEmitsCommandStubWithSetEnumItemVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_enum_item.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_enum_item.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_enum_item", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetMnemonicEmitsCommandStubWithSetMnemonicVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_mnemonic.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_mnemonic.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_mnemonic", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandGenDecoderEmitsCommandStubWithGenDecoderVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_gen_decoder.csl")) {
            assertNotNull(in, "missing /regression/mini_command_gen_decoder.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("gen_decoder", cmd.inferredVerb().orElseThrow());
        assertEquals("generate_decoder", cmd.verbTokenText().orElseThrow());
    }

    @Test
    void miniCommandInitializeRandomValuesEmitsCommandStubWithInitializeRandomValuesVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_initialize_random_values.csl")) {
            assertNotNull(in, "missing /regression/mini_command_initialize_random_values.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("initialize_random_values", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandInitializeRandomEmitsCommandStubWithInitializeRandomVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_initialize_random.csl")) {
            assertNotNull(in, "missing /regression/mini_command_initialize_random.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("initialize_random", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandMergeEmitsCommandStubWithMergeVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_merge.csl")) {
            assertNotNull(in, "missing /regression/mini_command_merge.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("merge", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVersionEmitsCommandStubWithSetVersionVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_version.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_version.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_version", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcNameEmitsCommandStubWithSetVcNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_vc_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcHeaderCommentEmitsCommandStubWithSetVcHeaderCommentVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_vc_header_comment.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_header_comment.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_header_comment", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcCompareTriggerEmitsCommandStubWithSetVcCompareTriggerVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_vc_compare_trigger.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_compare_trigger.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_compare_trigger", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcStartGenerationTriggerEmitsCommandStubWithSetVcStartGenerationTriggerVerb()
            throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_vc_start_generation_trigger.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_start_generation_trigger.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_start_generation_trigger", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcClockEmitsCommandStubWithSetVcClockVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_vc_clock.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_clock.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_clock", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcResetEmitsCommandStubWithSetVcResetVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_vc_reset.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_reset.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_reset", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcStallEmitsCommandStubWithSetVcStallVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_vc_stall.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_stall.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_stall", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcEndGenerationTriggerEmitsCommandStubWithSetVcEndGenerationTriggerVerb()
            throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_vc_end_generation_trigger.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_end_generation_trigger.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_end_generation_trigger", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcCaptureEdgeTypeEmitsCommandStubWithSetVcCaptureEdgeTypeVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_vc_capture_edge_type.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_capture_edge_type.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_capture_edge_type", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcMaxNumberOfMismatchesEmitsCommandStubWithSetVcMaxNumberOfMismatchesVerb()
            throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_vc_max_number_of_mismatches.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_max_number_of_mismatches.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_max_number_of_mismatches", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcMaxNumberOfValidTransactionsEmitsCommandStubWithSetVcMaxNumberOfValidTransactionsVerb()
            throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream(
                        "/regression/mini_command_set_vc_max_number_of_valid_transactions.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_max_number_of_valid_transactions.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_max_number_of_valid_transactions", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcValidOutputTransactionEmitsCommandStubWithSetVcValidOutputTransactionVerb()
            throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_vc_valid_output_transaction.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_valid_output_transaction.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_valid_output_transaction", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcOutputFilenameEmitsCommandStubWithSetVcOutputFilenameVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_vc_output_filename.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_output_filename.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_output_filename", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetVcMaxCyclesEmitsCommandStubWithSetVcMaxCyclesVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_vc_max_cycles.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_vc_max_cycles.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_vc_max_cycles", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetUnitNameEmitsCommandStubWithSetUnitNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_unit_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_unit_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_unit_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandPipestageNamingConventionEmitsCommandStubWithPipestageNamingConventionVerb()
            throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_pipestage_naming_convention.csl")) {
            assertNotNull(in, "missing /regression/mini_command_pipestage_naming_convention.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("pipestage_naming_convention", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandNoPrefixEmitsCommandStubWithNoPrefixVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_no_prefix.csl")) {
            assertNotNull(in, "missing /regression/mini_command_no_prefix.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("no_prefix", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandDoNotGenRtlEmitsCommandStubWithDoNotGenRtlVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_do_not_gen_rtl.csl")) {
            assertNotNull(in, "missing /regression/mini_command_do_not_gen_rtl.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("do_not_gen_rtl", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandDoNotGenCppEmitsCommandStubWithDoNotGenCppVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_do_not_gen_cpp.csl")) {
            assertNotNull(in, "missing /regression/mini_command_do_not_gen_cpp.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("do_not_gen_cpp", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandConnectUnitsEmitsCommandStubWithConnectUnitsVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_connect_units.csl")) {
            assertNotNull(in, "missing /regression/mini_command_connect_units.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("connect_units", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandConnectByPatternEmitsCommandStubWithConnectByPatternVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_connect_by_pattern.csl")) {
            assertNotNull(in, "missing /regression/mini_command_connect_by_pattern.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("connect_by_pattern", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandConnectByNameEmitsCommandStubWithConnectByNameVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_connect_by_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_connect_by_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("connect_by_name", cmd.inferredVerb().orElseThrow());
        assertEquals("u", cmd.receiverIdentifier().orElseThrow());
        assertEquals(List.of("a", "b"), cmd.paramExprTexts().orElseThrow());
        assertEquals("a", cmd.firstCommandFirstParamIdentifier().orElseThrow());
        assertEquals("b", cmd.firstCommandSecondParamIdentifier().orElseThrow());
    }

    @Test
    void miniCommandReceiverChainCapturesPrefixBeforeVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_receiver_chain.csl")) {
            assertNotNull(in, "missing /regression/mini_command_receiver_chain.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_width", cmd.inferredVerb().orElseThrow());
        assertEquals("u", cmd.receiverIdentifier().orElseThrow());
        assertEquals("u.a[3].b.", cmd.receiverChainText().orElseThrow());
        assertEquals(List.of("u", "a[3]", "b"), cmd.receiverChainSegments().orElseThrow());
        assertEquals("3", cmd.receiverFirstRangeExpressionText().orElseThrow());
        assertEquals(3L, cmd.receiverFirstRangeIntLiteral().orElseThrow());
        assertEquals(List.of("8"), cmd.paramExprTexts().orElseThrow());
    }

    @Test
    void miniCommandAddPortListEmitsCommandStubWithAddPortListVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_add_port_list.csl")) {
            assertNotNull(in, "missing /regression/mini_command_add_port_list.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("add_port_list", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetAttrEmitsCommandStubWithSetAttrVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_attr.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_attr.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_attr", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetInstanceAlterationBitEmitsCommandStubWithSetInstanceAlterationBitVerb()
            throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_instance_alteration_bit.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_instance_alteration_bit.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_instance_alteration_bit", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetTestbenchVerilogFilenameEmitsCommandStubWithSetTestbenchVerilogFilenameVerb()
            throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_testbench_verilog_filename.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_testbench_verilog_filename.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_testbench_verilog_filename", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandAddEmitsCommandStubWithAddVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_add.csl")) {
            assertNotNull(in, "missing /regression/mini_command_add.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("add", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandAddAddressRangeEmitsCommandStubWithAddAddressRangeVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_add_address_range.csl")) {
            assertNotNull(in, "missing /regression/mini_command_add_address_range.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("add_address_range", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandAddReservedAddressRangeEmitsCommandStubWithAddReservedAddressRangeVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_add_reserved_address_range.csl")) {
            assertNotNull(in, "missing /regression/mini_command_add_reserved_address_range.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("add_reserved_address_range", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetPhysicalImplementationEmitsCommandStubWithSetPhysicalImplementationVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_physical_implementation.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_physical_implementation.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_physical_implementation", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetValueEmitsCommandStubWithSetValueVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_value.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_value.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_value", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetFieldEmitsCommandStubWithSetFieldVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_field.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_field.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_field", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetFieldPositionEmitsCommandStubWithSetFieldPositionVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_field_position.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_field_position.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_field_position", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetPositionEmitsCommandStubWithSetPositionVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_position.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_position.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_position", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandAddAllowedRangeEmitsCommandStubWithAddAllowedRangeVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_add_allowed_range.csl")) {
            assertNotNull(in, "missing /regression/mini_command_add_allowed_range.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("add_allowed_range", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetAttributesEmitsCommandStubWithSetAttributesVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_attributes.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_attributes.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_attributes", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandAddLogicEmitsCommandStubWithAddLogicVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_add_logic.csl")) {
            assertNotNull(in, "missing /regression/mini_command_add_logic.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("add_logic", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetUnitIdEmitsCommandStubWithSetUnitIdVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_unit_id.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_unit_id.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_unit_id", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetNumRdIfcEmitsCommandStubWithSetNumRdIfcVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_num_rd_ifc.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_num_rd_ifc.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_num_rd_ifc", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetNumWrIfcEmitsCommandStubWithSetNumWrIfcVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_num_wr_ifc.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_num_wr_ifc.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_num_wr_ifc", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandGenUniqueRtlModulesEmitsCommandStubWithGenUniqueRtlModulesVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_gen_unique_rtl_modules.csl")) {
            assertNotNull(in, "missing /regression/mini_command_gen_unique_rtl_modules.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("gen_unique_rtl_modules", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandOverrideParameterEmitsCommandStubWithOverrideParameterVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_override_parameter.csl")) {
            assertNotNull(in, "missing /regression/mini_command_override_parameter.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("override_parameter", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetClockEmitsCommandStubWithSetClockVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_set_clock.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_clock.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_clock", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandRegisterIosEmitsCommandStubWithRegisterIosVerb() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_command_register_ios.csl")) {
            assertNotNull(in, "missing /regression/mini_command_register_ios.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("register_ios", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetWrAddrNameEmitsCommandStubWithSetWrAddrNameVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_wr_addr_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_wr_addr_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_wr_addr_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetRdAddrNameEmitsCommandStubWithSetRdAddrNameVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_rd_addr_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_rd_addr_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_rd_addr_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetWrEnNameEmitsCommandStubWithSetWrEnNameVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_wr_en_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_wr_en_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_wr_en_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetRdEnNameEmitsCommandStubWithSetRdEnNameVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_rd_en_name.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_rd_en_name.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_rd_en_name", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetAccessRightsEmitsCommandStubWithSetAccessRightsVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_access_rights.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_access_rights.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_access_rights", cmd.inferredVerb().orElseThrow());
        assertEquals(List.of("1", "2", "3"), cmd.paramExprTexts().orElseThrow());
        assertEquals(3, cmd.paramExprCount().orElseThrow());
        assertEquals(3L, cmd.firstCommandThirdParamIntLiteral().orElseThrow());
    }

    @Test
    void miniCommandSetAccessRightsEnumEmitsCommandStubWithSetAccessRightsEnumVerb() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_access_rights_enum.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_access_rights_enum.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_access_rights_enum", cmd.inferredVerb().orElseThrow());
    }

    @Test
    void miniCommandSetAccessRightsThirdIdentCapturesThirdIdentifierParam() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_access_rights_third_ident.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_access_rights_third_ident.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_access_rights", cmd.inferredVerb().orElseThrow());
        assertEquals(List.of("1", "2", "e"), cmd.paramExprTexts().orElseThrow());
        assertEquals(3, cmd.paramExprCount().orElseThrow());
        assertEquals("e", cmd.firstCommandThirdParamIdentifier().orElseThrow());
    }

    @Test
    void miniCommandSetAccessRightsThirdStringCapturesThirdStringLiteralParam() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_command_set_access_rights_third_string.csl")) {
            assertNotNull(in, "missing /regression/mini_command_set_access_rights_third_string.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "u");
        var cmd = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("set_access_rights", cmd.inferredVerb().orElseThrow());
        assertEquals(List.of("1", "2", "\"e\""), cmd.paramExprTexts().orElseThrow());
        assertEquals(3, cmd.paramExprCount().orElseThrow());
        assertEquals("e", cmd.firstCommandThirdParamStringLiteral().orElseThrow());
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
        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "no_prefix");
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
        assertStub(unit.getChildren().get(0), CslomNodeType.TYPE_COMMAND, "no_prefix");
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

        assertStub(sink.get(0), CslomNodeType.TYPE_COMMAND, "no_prefix");
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
        assertStub(unit.getChildren().get(0), CslomNodeType.TYPE_COMMAND, "no_prefix");
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
        assertEquals("csl_statement_assign", assign.paramListAntlrRuleSimpleName().orElseThrow());
        assertEquals("=", assign.verbTokenText().orElseThrow());
        assertEquals("1", assign.assignRhsExpressionText().orElseThrow());
        assertEquals(List.of("1"), assign.paramExprTexts().orElseThrow());
        assertEquals(1L, assign.firstCommandFirstParamIntLiteral().orElseThrow());
        assertEquals("u", assign.receiverIdentifier().orElseThrow());
        assertEquals("u.", assign.receiverChainText().orElseThrow());
        assertEquals(List.of("u"), assign.receiverChainSegments().orElseThrow());
        var override = assertInstanceOf(CslomCommandDecl.class, sink.get(1));
        assertEquals("u", override.declaredName().orElseThrow());
        assertEquals("override_parameter", override.inferredVerb().orElseThrow());
    }

    @Test
    void miniAssignReceiverChainCapturesLhsSegmentsAndRange() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_assign_receiver_chain.csl")) {
            assertNotNull(in, "missing /regression/mini_assign_receiver_chain.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(1, sink.size());
        var assign = assertInstanceOf(CslomCommandDecl.class, sink.get(0));
        assertEquals("u", assign.declaredName().orElseThrow());
        assertEquals("assign", assign.inferredVerb().orElseThrow());
        assertEquals("csl_statement_assign", assign.paramListAntlrRuleSimpleName().orElseThrow());
        assertEquals("=", assign.verbTokenText().orElseThrow());
        assertEquals("u", assign.receiverIdentifier().orElseThrow());
        assertEquals("u.a[3].", assign.receiverChainText().orElseThrow());
        assertEquals(List.of("u", "a[3]"), assign.receiverChainSegments().orElseThrow());
        assertEquals("3", assign.receiverFirstRangeExpressionText().orElseThrow());
        assertEquals(3L, assign.receiverFirstRangeIntLiteral().orElseThrow());
        assertEquals("1", assign.assignRhsExpressionText().orElseThrow());
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
        assertEquals(42L, port.firstPortFirstParamIntLiteral().orElseThrow());
    }

    @Test
    void miniPortParamIdentCapturesFirstParamIdentifierText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_port_param_ident.csl")) {
            assertNotNull(in, "missing /regression/mini_port_param_ident.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var port = assertInstanceOf(CslomPortDecl.class, sink.get(0));
        assertEquals("w", port.firstPortFirstParamIdentifier().orElseThrow());
    }

    @Test
    void miniPortParamStringCapturesFirstParamStringLiteral() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_port_param_string.csl")) {
            assertNotNull(in, "missing /regression/mini_port_param_string.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var port = assertInstanceOf(CslomPortDecl.class, sink.get(0));
        assertEquals("w", port.firstPortFirstParamStringLiteral().orElseThrow());
    }

    @Test
    void miniPortMultiDeclaratorCapturesAdditionalDeclaratorNames() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_port_multi_declarator.csl")) {
            assertNotNull(in, "missing /regression/mini_port_multi_declarator.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var port = assertInstanceOf(CslomPortDecl.class, sink.get(0));
        assertEquals("p0", port.declaredName().orElseThrow());
        assertEquals(List.of("p1", "p2"), port.additionalPortDeclaratorNames().orElseThrow());
        assertEquals(List.of("1", "2"), port.additionalPortParamListTexts().orElseThrow());
        assertEquals(List.of(List.of("1"), List.of("2")), port.additionalPortParamExprTextLists().orElseThrow());
        assertEquals(List.of(1, 1), port.additionalPortParamExprCounts().orElseThrow());
        assertEquals(List.of(1L, 2L), port.additionalPortFirstParamIntLiterals().orElseThrow());
    }

    @Test
    void miniPortMultiDeclaratorIdentStringCapturesFirstParamIdentifierAndString() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_port_multi_declarator_ident_string.csl")) {
            assertNotNull(in, "missing /regression/mini_port_multi_declarator_ident_string.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var port = assertInstanceOf(CslomPortDecl.class, sink.get(0));
        assertEquals("p0", port.declaredName().orElseThrow());
        assertEquals(List.of("p1", "p2"), port.additionalPortDeclaratorNames().orElseThrow());
        assertEquals(List.of("w", "\"w\""), port.additionalPortParamListTexts().orElseThrow());
        assertEquals(List.of(List.of("w"), List.of("\"w\"")), port.additionalPortParamExprTextLists().orElseThrow());
        assertEquals(List.of(1, 1), port.additionalPortParamExprCounts().orElseThrow());
        assertEquals(java.util.Arrays.asList(null, null), port.additionalPortFirstParamIntLiterals().orElseThrow());
        assertEquals(java.util.Arrays.asList("w", null), port.additionalPortFirstParamIdentifiers().orElseThrow());
        assertEquals(java.util.Arrays.asList(null, "w"), port.additionalPortFirstParamStringLiterals().orElseThrow());
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
        assertEquals(7L, sig.firstSignalFirstParamIntLiteral().orElseThrow());
    }

    @Test
    void miniSignalParamIdentCapturesFirstParamIdentifierText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal_param_ident.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_param_ident.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("w", sig.firstSignalFirstParamIdentifier().orElseThrow());
    }

    @Test
    void miniSignalParamStringCapturesFirstParamStringLiteral() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal_param_string.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_param_string.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("w", sig.firstSignalFirstParamStringLiteral().orElseThrow());
    }

    @Test
    void miniSignalMultiDeclaratorCapturesAdditionalDeclaratorNames() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal_multi_declarator.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_multi_declarator.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("s0", sig.declaredName().orElseThrow());
        assertEquals(List.of("s1", "s2"), sig.additionalSignalDeclaratorNames().orElseThrow());
        assertEquals(List.of("1", "2"), sig.additionalSignalParamListTexts().orElseThrow());
        assertEquals(List.of(List.of("1"), List.of("2")), sig.additionalSignalParamExprTextLists().orElseThrow());
        assertEquals(List.of(1, 1), sig.additionalSignalParamExprCounts().orElseThrow());
        assertEquals(List.of(1L, 2L), sig.additionalSignalFirstParamIntLiterals().orElseThrow());
        assertEquals(List.of("", ""), sig.additionalSignalBitrangePureTexts().orElseThrow());
    }

    @Test
    void miniSignalMultiDeclaratorIdentStringCapturesFirstParamIdentifierAndString() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_signal_multi_declarator_ident_string.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_multi_declarator_ident_string.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("s0", sig.declaredName().orElseThrow());
        assertEquals(List.of("s1", "s2"), sig.additionalSignalDeclaratorNames().orElseThrow());
        assertEquals(List.of("w", "\"w\""), sig.additionalSignalParamListTexts().orElseThrow());
        assertEquals(List.of(List.of("w"), List.of("\"w\"")), sig.additionalSignalParamExprTextLists().orElseThrow());
        assertEquals(List.of(1, 1), sig.additionalSignalParamExprCounts().orElseThrow());
        assertEquals(java.util.Arrays.asList(null, null), sig.additionalSignalFirstParamIntLiterals().orElseThrow());
        assertEquals(java.util.Arrays.asList("w", null), sig.additionalSignalFirstParamIdentifiers().orElseThrow());
        assertEquals(java.util.Arrays.asList(null, "w"), sig.additionalSignalFirstParamStringLiterals().orElseThrow());
        assertEquals(List.of("", ""), sig.additionalSignalBitrangePureTexts().orElseThrow());
    }

    @Test
    void miniSignalMultiDeclaratorMissingParamListAlignsEmptySlot() throws IOException {
        String text;
        try (InputStream in =
                getClass().getResourceAsStream("/regression/mini_signal_multi_declarator_missing_param.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_multi_declarator_missing_param.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("s0", sig.declaredName().orElseThrow());
        assertEquals(List.of("s1", "s2"), sig.additionalSignalDeclaratorNames().orElseThrow());
        assertEquals(List.of("", "2"), sig.additionalSignalParamListTexts().orElseThrow());
        assertEquals(List.of(List.of(), List.of("2")), sig.additionalSignalParamExprTextLists().orElseThrow());
        assertEquals(List.of(0, 1), sig.additionalSignalParamExprCounts().orElseThrow());
        assertEquals(java.util.Arrays.asList(null, 2L), sig.additionalSignalFirstParamIntLiterals().orElseThrow());
        assertEquals(List.of("", ""), sig.additionalSignalBitrangePureTexts().orElseThrow());
    }

    @Test
    void miniSignalMultiDeclaratorBitrangeCapturesBitrangePurePerAdditionalDeclarator() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal_multi_declarator_bitrange.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_multi_declarator_bitrange.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var sig = assertInstanceOf(CslomSignalDecl.class, sink.get(0));
        assertEquals("s0", sig.declaredName().orElseThrow());
        assertEquals(List.of("s1", "s2"), sig.additionalSignalDeclaratorNames().orElseThrow());
        assertEquals(List.of("1,[1:0]", "2"), sig.additionalSignalParamListTexts().orElseThrow());
        assertEquals(List.of("[1:0]", ""), sig.additionalSignalBitrangePureTexts().orElseThrow());
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
        assertEquals(7L, sig.firstSignalFirstParamIntLiteral().orElseThrow());
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
        assertEquals(1L, port.firstPortFirstParamIntLiteral().orElseThrow());
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
    void miniInterfaceWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_interface_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_interface_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var ifc = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomInterfaceDecl.class, sink.get(1));
        assertEquals("ifc", ifc.declaredName().orElseThrow());
        assertTrue(ifc.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniFifoWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_fifo_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_fifo_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var fifo = assertInstanceOf(com.fastpath.cslc.cslom.decl.CslomFifoDecl.class, sink.get(1));
        assertEquals("f", fifo.declaredName().orElseThrow());
        assertTrue(fifo.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniRegisterFileWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_register_file_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_register_file_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var rf = assertInstanceOf(CslomRegisterFileDecl.class, sink.get(1));
        assertEquals("rf", rf.declaredName().orElseThrow());
        assertTrue(rf.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniRegisterWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_register_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_register_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var r = assertInstanceOf(CslomRegisterDecl.class, sink.get(1));
        assertEquals("r", r.declaredName().orElseThrow());
        assertTrue(r.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniMemoryMapWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_memory_map_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_memory_map_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var mm = assertInstanceOf(CslomMemoryMapDecl.class, sink.get(1));
        assertEquals("mm", mm.declaredName().orElseThrow());
        assertTrue(mm.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniMemoryMapPageWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_memory_map_page_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_memory_map_page_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var mmp = assertInstanceOf(CslomMemoryMapPageDecl.class, sink.get(1));
        assertEquals("mmp", mmp.declaredName().orElseThrow());
        assertTrue(mmp.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniIsaFieldWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_isa_field_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_isa_field_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var isf = assertInstanceOf(CslomIsaFieldDecl.class, sink.get(1));
        assertEquals("isf", isf.declaredName().orElseThrow());
        assertTrue(isf.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniIsaElementWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_isa_element_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_isa_element_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var ise = assertInstanceOf(CslomIsaElementDecl.class, sink.get(1));
        assertEquals("ie", ise.declaredName().orElseThrow());
        assertTrue(ise.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniFieldWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_field_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_field_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var fld = assertInstanceOf(CslomFieldDecl.class, sink.get(1));
        assertEquals("fld", fld.declaredName().orElseThrow());
        assertTrue(fld.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniSignalGroupWithBodyCapturesUnitDefinitionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_signal_group_with_body.csl")) {
            assertNotNull(in, "missing /regression/mini_signal_group_with_body.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(3, sink.size());
        var sg = assertInstanceOf(CslomSignalGroupDecl.class, sink.get(1));
        assertEquals("sg", sg.declaredName().orElseThrow());
        assertTrue(sg.unitDefinitionText().orElseThrow().contains("csl_signal"));
    }

    @Test
    void miniEnumItemsCapturesEnumItemTextsInOrder() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_enum_items.csl")) {
            assertNotNull(in, "missing /regression/mini_enum_items.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var en = assertInstanceOf(CslomEnumDecl.class, sink.get(0));
        assertEquals("e", en.declaredName().orElseThrow());
        assertEquals(List.of("a", "b=3"), en.enumItemTexts().orElseThrow());
    }

    @Test
    void miniEnumEmptyLeavesEnumItemTextsUnset() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_enum_empty.csl")) {
            assertNotNull(in, "missing /regression/mini_enum_empty.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var en = assertInstanceOf(CslomEnumDecl.class, sink.get(0));
        assertEquals("e", en.declaredName().orElseThrow());
        assertTrue(en.enumItemTexts().isEmpty());
    }

    @Test
    void miniIncludeWithExprCapturesArgumentExpressionText() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_include_with_expr.csl")) {
            assertNotNull(in, "missing /regression/mini_include_with_expr.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var inc = assertInstanceOf(CslomIncludeDecl.class, sink.get(0));
        assertEquals("inc_path", inc.declaredName().orElseThrow());
        assertEquals("42", inc.includeArgumentExpressionText().orElseThrow());
    }

    @Test
    void miniListNamedParamsCapturesFirstParamListExprTexts() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_list_named_params.csl")) {
            assertNotNull(in, "missing /regression/mini_list_named_params.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var list = assertInstanceOf(CslomListDecl.class, sink.get(0));
        assertEquals("L", list.declaredName().orElseThrow());
        assertEquals(List.of(List.of("1", "2")), list.eachListParamExprTextLists().orElseThrow());
        assertTrue(list.additionalListDeclaratorNames().isEmpty());
    }

    @Test
    void miniListAnonParamsUsesSyntheticNameAndCapturesExprTexts() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_list_anon_params.csl")) {
            assertNotNull(in, "missing /regression/mini_list_anon_params.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var list = assertInstanceOf(CslomListDecl.class, sink.get(0));
        assertEquals(CslomListDecl.ANONYMOUS_LIST_DECL_NAME, list.declaredName().orElseThrow());
        assertEquals(List.of(List.of("1", "2")), list.eachListParamExprTextLists().orElseThrow());
    }

    @Test
    void miniListTwoSegmentsCapturesParamListsAndTrailingNames() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/mini_list_two_segments.csl")) {
            assertNotNull(in, "missing /regression/mini_list_two_segments.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        List<CslomBase> sink = new ArrayList<>();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, new CslWalkerPortParserDeclStubBridgeListener(sink));
        assertEquals(2, sink.size());
        var list = assertInstanceOf(CslomListDecl.class, sink.get(0));
        assertEquals("L", list.declaredName().orElseThrow());
        assertEquals(List.of(List.of("1"), List.of("2")), list.eachListParamExprTextLists().orElseThrow());
        assertEquals(List.of("M"), list.additionalListDeclaratorNames().orElseThrow());
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
