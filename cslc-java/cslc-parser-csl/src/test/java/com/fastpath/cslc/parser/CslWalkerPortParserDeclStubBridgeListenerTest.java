package com.fastpath.cslc.parser;

import com.fastpath.cslc.cslom.CslomBase;
import com.fastpath.cslc.cslom.CslomDesignStub;
import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;
import com.fastpath.cslc.cslom.CslomUnitDecl;
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
        assertTrue(stub.antlrText().orElseThrow().contains("csl_unit"));
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
        assertEquals("csl_signal_declaration", sig.antlrRuleSimpleName().orElseThrow());
        assertTrue(sig.antlrText().orElseThrow().contains("csl_signal"));
        var unit = assertInstanceOf(CslomUnitDecl.class, sink.get(1));
        assertEquals(CslomNodeType.TYPE_DECL_UNIT, unit.getNodeType());
        assertEquals("u", unit.declaredName().orElseThrow());
        assertEquals("csl_unit_declaration", unit.antlrRuleSimpleName().orElseThrow());
        assertTrue(unit.antlrText().orElseThrow().contains("csl_unit"));
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
        assertStub(unit.getChildren().get(1), CslomNodeType.TYPE_INST_UNIT, "sub_unit");
        assertEquals(3, sink.size());
    }

    private static void assertStub(CslomBase node, CslomNodeType type, String name) {
        var stub = assertInstanceOf(CslomNamedDecl.class, node);
        assertEquals(type, stub.getNodeType());
        assertEquals(name, stub.declaredName().orElseThrow());
    }
}
