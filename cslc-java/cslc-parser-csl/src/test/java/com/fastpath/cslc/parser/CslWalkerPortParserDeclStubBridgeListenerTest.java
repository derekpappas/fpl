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
