package com.fastpath.cslc.parser;

import com.fastpath.cslc.cslom.CslomBase;
import com.fastpath.cslc.cslom.CslomDesignStub;
import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;
import com.fastpath.cslc.cslom.CslomPlaceholder;
import com.fastpath.cslc.cslom.CslomUnitDecl;
import com.fastpath.cslc.cslom.decl.CslomBitrangeDecl;
import com.fastpath.cslc.cslom.decl.CslomCommandDecl;
import com.fastpath.cslc.cslom.decl.CslomContainerDecl;
import com.fastpath.cslc.cslom.decl.CslomEnumDecl;
import com.fastpath.cslc.cslom.decl.CslomFieldDecl;
import com.fastpath.cslc.cslom.decl.CslomIncludeDecl;
import com.fastpath.cslc.cslom.decl.CslomInstUnitDecl;
import com.fastpath.cslc.cslom.decl.CslomInterfaceDecl;
import com.fastpath.cslc.cslom.decl.CslomIsaElementDecl;
import com.fastpath.cslc.cslom.decl.CslomIsaFieldDecl;
import com.fastpath.cslc.cslom.decl.CslomListDecl;
import com.fastpath.cslc.cslom.decl.CslomMemoryMapDecl;
import com.fastpath.cslc.cslom.decl.CslomMemoryMapPageDecl;
import com.fastpath.cslc.cslom.decl.CslomParameterDecl;
import com.fastpath.cslc.cslom.decl.CslomPortDecl;
import com.fastpath.cslc.cslom.decl.CslomPreprocessorStmtDecl;
import com.fastpath.cslc.cslom.decl.CslomSignalDecl;
import com.fastpath.cslc.cslom.decl.CslomSignalGroupDecl;
import com.fastpath.cslc.cslom.decl.CslomTestbenchDecl;
import com.fastpath.cslc.cslom.decl.CslomUnitInstantiationDecl;
import com.fastpath.cslc.cslom.decl.CslomVectorDecl;
import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.Collection;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Bridges completed {@code csl_*_declaration} subtrees from {@code CslParserTrunkPort} into
 * {@link com.fastpath.cslc.cslom.decl} typed {@link CslomNamedDecl} nodes and {@link CslomUnitDecl} (or
 * {@link CslomPlaceholder} for a nameless unit).
 *
 * <p>Flat mode: {@code new CslWalkerPortParserDeclStubBridgeListener(sink)} — every node goes to {@code sink}.
 *
 * <p>Hierarchy mode: {@code new CslWalkerPortParserDeclStubBridgeListener(sink, designRoot)} — inner declaration
 * nodes are {@link CslomBase#addChild added} under their enclosing {@code csl_unit_declaration} scope; that
 * scope is linked under {@code designRoot} on first inner use. Each node is still appended to {@code sink} for
 * regression parity. Nested {@code csl_unit} inside another unit is attached under the enclosing unit's
 * {@link CslomUnitDecl} (or placeholder) scope rather than {@code designRoot} (batch 2 remainder).
 *
 * <p>Unit body (batch 4 stub phase): {@code csl_inst} → one {@link CslomNodeType#TYPE_UNIT_INSTANTIATION} stub
 * per instance identifier; {@code csl_inst_or_cstor} with {@code csl_cstor} → {@link CslomNodeType#TYPE_INST_UNIT}
 * stub named after the template identifier (syntax-only; ctor body not walked into CSLOm yet).
 *
 * <p>Preprocessor / commands (batch 4 continued): {@code preprocessor_directive} → {@link CslomNodeType#TYPE_STMT}
 * stub whose declared name is the unquoted {@code STRING} (line-sync / file hint). {@code csl_command} →
 * {@link CslomNodeType#TYPE_COMMAND} stub named after the first receiver {@code IDENTIFIER} if any, else
 * {@code "command"}; commands appear under {@code source_text} / {@code description} and inside {@code csl_cstor}
 * bodies, not directly under {@code csl_unit_definition} (that rule lists declarations, instances, preprocessor,
 * and bare semicolons only).
 *
 * <p>Batch 3: every {@link CslomNamedDecl} (including {@link CslomUnitDecl}) gets
 * {@link CslomNamedDecl#attachAntlrRuleSimpleName} from the originating context (e.g. {@code csl_unit_declaration}),
 * plus optional {@link CslomNamedDecl#legacyWalkerRuleSimpleName()} when {@link CslTrunkPortAntlrToLegacyWalkerRuleNames}
 * maps an ANTLR4 rule to a different {@code csl.walker.g} label (e.g. read/write interface →
 * {@code csl_interface_declaration}). {@link CslomPortDecl} / {@link CslomSignalDecl} also record the first declarator's
 * {@code param_list_csl_port} / {@code param_list_csl_signal} subtree text (paren contents only) when present.
 */
public final class CslWalkerPortParserDeclStubBridgeListener extends CslTrunkPortListenerSkeleton {

    private final Collection<? super CslomBase> sink;
    private final CslomDesignStub designRoot;
    private final Map<CslParserTrunkPort.Csl_unit_declarationContext, CslomBase> unitScopes = new IdentityHashMap<>();

    public CslWalkerPortParserDeclStubBridgeListener(Collection<? super CslomBase> sink) {
        this(sink, null);
    }

    public CslWalkerPortParserDeclStubBridgeListener(Collection<? super CslomBase> sink, CslomDesignStub designRoot) {
        this.sink = Objects.requireNonNull(sink, "sink");
        this.designRoot = designRoot;
    }

    @Override
    public void exitCsl_unit_declaration(CslParserTrunkPort.Csl_unit_declarationContext ctx) {
        if (designRoot != null) {
            CslomBase unit = unitScopes.remove(ctx);
            if (unit == null) {
                Token start = ctx.getStart();
                int line = start != null ? start.getLine() : 0;
                int col = start != null ? start.getCharPositionInLine() : 0;
                String file = start != null ? start.getTokenSource().getSourceName() : null;
                TerminalNode id = ctx.IDENTIFIER(0);
                String name = id != null ? id.getText() : null;
                if (name != null) {
                    CslomUnitDecl u = new CslomUnitDecl(name, line, col, file);
                    attachAntlrCorrelation(u, ctx);
                    parentForUnitScope(ctx).addChild(u);
                    sink.add(u);
                } else {
                    CslomPlaceholder p = new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, line, col, file);
                    parentForUnitScope(ctx).addChild(p);
                    sink.add(p);
                }
            } else {
                sink.add(unit);
            }
            return;
        }
        Token start = ctx.getStart();
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        TerminalNode id = ctx.IDENTIFIER(0);
        String name = id != null ? id.getText() : null;
        if (name != null) {
            CslomUnitDecl u = new CslomUnitDecl(name, line, col, file);
            attachAntlrCorrelation(u, ctx);
            sink.add(u);
        } else {
            sink.add(new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, line, col, file));
        }
    }

    @Override
    public void exitCsl_signal_declaration(CslParserTrunkPort.Csl_signal_declarationContext ctx) {
        TerminalNode id = ctx.IDENTIFIER(0);
        if (id == null) {
            return;
        }
        Token start = id.getSymbol();
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        String name = id.getText();
        if (name.isEmpty()) {
            return;
        }
        var sig = new CslomSignalDecl(name, line, col, file);
        CslParserTrunkPort.Param_list_csl_signalContext pls = ctx.param_list_csl_signal(0);
        if (pls != null) {
            sig.attachFirstSignalParamListText(antlrText(pls));
        }
        emitStub(sig, ctx);
    }

    @Override
    public void exitCsl_port_declaration(CslParserTrunkPort.Csl_port_declarationContext ctx) {
        TerminalNode id = ctx.IDENTIFIER(0);
        if (id == null) {
            return;
        }
        Token start = id.getSymbol();
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        String name = id.getText();
        if (name.isEmpty()) {
            return;
        }
        var port = new CslomPortDecl(name, line, col, file);
        CslParserTrunkPort.Param_list_csl_portContext plp = ctx.param_list_csl_port(0);
        if (plp != null) {
            port.attachFirstPortParamListText(antlrText(plp));
        }
        emitStub(port, ctx);
    }

    @Override
    public void exitCsl_interface_declaration(CslParserTrunkPort.Csl_interface_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomInterfaceDecl::new);
    }

    @Override
    public void exitCsl_bitrange_declaration(CslParserTrunkPort.Csl_bitrange_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomBitrangeDecl::new);
    }

    @Override
    public void exitCsl_read_interface_declaration(CslParserTrunkPort.Csl_read_interface_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(), CslomInterfaceDecl::new);
    }

    @Override
    public void exitCsl_write_interface_declaration(CslParserTrunkPort.Csl_write_interface_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(), CslomInterfaceDecl::new);
    }

    @Override
    public void exitCsl_register_file_declaration(CslParserTrunkPort.Csl_register_file_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomContainerDecl::new);
    }

    @Override
    public void exitCsl_testbench_declaration(CslParserTrunkPort.Csl_testbench_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomTestbenchDecl::new);
    }

    @Override
    public void exitCsl_fifo_declaration(CslParserTrunkPort.Csl_fifo_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomContainerDecl::new);
    }

    @Override
    public void exitCsl_memory_map_declaration(CslParserTrunkPort.Csl_memory_map_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomMemoryMapDecl::new);
    }

    @Override
    public void exitCsl_memory_map_page_declaration(CslParserTrunkPort.Csl_memory_map_page_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomMemoryMapPageDecl::new);
    }

    @Override
    public void exitCsl_register_declaration(CslParserTrunkPort.Csl_register_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomContainerDecl::new);
    }

    @Override
    public void exitCsl_memory_declaration(CslParserTrunkPort.Csl_memory_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomContainerDecl::new);
    }

    @Override
    public void exitCsl_state_data_declaration(CslParserTrunkPort.Csl_state_data_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomContainerDecl::new);
    }

    @Override
    public void exitCsl_vector_declaration(CslParserTrunkPort.Csl_vector_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomVectorDecl::new);
    }

    @Override
    public void exitCsl_isa_field_declaration(CslParserTrunkPort.Csl_isa_field_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomIsaFieldDecl::new);
    }

    @Override
    public void exitCsl_isa_element_declaration(CslParserTrunkPort.Csl_isa_element_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomIsaElementDecl::new);
    }

    @Override
    public void exitCsl_enum_declaration(CslParserTrunkPort.Csl_enum_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(), CslomEnumDecl::new);
    }

    @Override
    public void exitCsl_field_declaration(CslParserTrunkPort.Csl_field_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomFieldDecl::new);
    }

    @Override
    public void exitCsl_include_declaration(CslParserTrunkPort.Csl_include_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(), CslomIncludeDecl::new);
    }

    @Override
    public void exitCsl_signal_group_declaration(CslParserTrunkPort.Csl_signal_group_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomSignalGroupDecl::new);
    }

    @Override
    public void exitCsl_list_declaration(CslParserTrunkPort.Csl_list_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomListDecl::new);
    }

    @Override
    public void exitCsl_multi_dim_bitrange_declaration(CslParserTrunkPort.Csl_multi_dim_bitrange_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomBitrangeDecl::new);
    }

    @Override
    public void exitCsl_pipeline_declaration(CslParserTrunkPort.Csl_pipeline_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomContainerDecl::new);
    }

    @Override
    public void exitCsl_pipestage_declaration(CslParserTrunkPort.Csl_pipestage_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomContainerDecl::new);
    }

    @Override
    public void exitCsl_const_int_declaration(CslParserTrunkPort.Csl_const_int_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomParameterDecl::new);
    }

    @Override
    public void exitCsl_parameter_declaration(CslParserTrunkPort.Csl_parameter_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomParameterDecl::new);
    }

    @Override
    public void exitCsl_inst(CslParserTrunkPort.Csl_instContext ctx) {
        List<TerminalNode> ids = ctx.IDENTIFIER();
        if (ids == null) {
            return;
        }
        for (TerminalNode id : ids) {
            addNamed(ctx, id, CslomUnitInstantiationDecl::new);
        }
    }

    @Override
    public void exitCsl_inst_or_cstor(CslParserTrunkPort.Csl_inst_or_cstorContext ctx) {
        if (ctx.csl_cstor() == null) {
            return;
        }
        addNamed(ctx, ctx.IDENTIFIER(), CslomInstUnitDecl::new);
    }

    @Override
    public void exitPreprocessor_directive(CslParserTrunkPort.Preprocessor_directiveContext ctx) {
        TerminalNode strNode = ctx.STRING();
        if (strNode == null) {
            return;
        }
        Token sym = strNode.getSymbol();
        int line = sym != null ? sym.getLine() : 0;
        int col = sym != null ? sym.getCharPositionInLine() : 0;
        String file = sym != null ? sym.getTokenSource().getSourceName() : null;
        String name = unquoteCslString(strNode.getText());
        if (name.isEmpty()) {
            name = "#";
        }
        emitStub(new CslomPreprocessorStmtDecl(name, line, col, file), ctx);
    }

    @Override
    public void exitCsl_command(CslParserTrunkPort.Csl_commandContext ctx) {
        TerminalNode id = ctx.IDENTIFIER(0);
        String name;
        Token pos;
        if (id != null) {
            name = id.getText();
            pos = id.getSymbol();
        } else {
            name = "command";
            pos = ctx.getStart();
        }
        if (name.isEmpty()) {
            name = "command";
        }
        int line = pos != null ? pos.getLine() : 0;
        int col = pos != null ? pos.getCharPositionInLine() : 0;
        String file = pos != null ? pos.getTokenSource().getSourceName() : null;
        var cmd = new CslomCommandDecl(name, line, col, file);
        String verb = CslCommandVerbInference.inferVerbLabelOrNull(ctx);
        cmd.attachInferredVerb(verb != null ? verb : "unknown");
        emitStub(cmd, ctx);
    }

    @FunctionalInterface
    private interface NamedDeclConstructor {
        CslomNamedDecl create(String name, int line, int column, String fileName);
    }

    private void addNamed(ParserRuleContext ctx, TerminalNode id, NamedDeclConstructor ctor) {
        if (id == null) {
            return;
        }
        Token start = id.getSymbol();
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        String name = id.getText();
        if (name.isEmpty()) {
            return;
        }
        emitStub(ctor.create(name, line, col, file), ctx);
    }

    private void attachAntlrCorrelation(CslomNamedDecl n, ParserRuleContext ctx) {
        String antlrRule = antlrRuleSimpleName(ctx);
        n.attachAntlrRuleSimpleName(antlrRule);
        n.attachAntlrText(antlrText(ctx));
        CslTrunkPortAntlrToLegacyWalkerRuleNames.legacyWalkerRuleSimpleNameForAntlrParserRule(antlrRule)
                .ifPresent(n::attachLegacyWalkerRuleSimpleName);
    }

    private void emitStub(CslomBase stub, ParserRuleContext ctx) {
        if (stub instanceof CslomNamedDecl n) {
            attachAntlrCorrelation(n, ctx);
        }
        if (designRoot != null) {
            CslParserTrunkPort.Csl_unit_declarationContext unitCtx = ancestorUnitDeclaration(ctx);
            if (unitCtx != null) {
                ensureUnitScope(unitCtx).addChild(stub);
            } else {
                designRoot.addChild(stub);
            }
        }
        sink.add(stub);
    }

    private static String unquoteCslString(String raw) {
        if (raw == null || raw.length() < 2) {
            return raw == null ? "" : raw;
        }
        char a = raw.charAt(0);
        char z = raw.charAt(raw.length() - 1);
        if ((a == '"' && z == '"') || (a == '\'' && z == '\'')) {
            return raw.substring(1, raw.length() - 1);
        }
        return raw;
    }

    private CslomBase ensureUnitScope(CslParserTrunkPort.Csl_unit_declarationContext ctx) {
        return unitScopes.computeIfAbsent(
                ctx,
                c -> {
                    Token st = c.getStart();
                    int line = st != null ? st.getLine() : 0;
                    int col = st != null ? st.getCharPositionInLine() : 0;
                    String file = st != null ? st.getTokenSource().getSourceName() : null;
                    TerminalNode id = c.IDENTIFIER(0);
                    String name = id != null ? id.getText() : null;
                    CslomBase scope;
                    if (name != null) {
                        CslomUnitDecl u = new CslomUnitDecl(name, line, col, file);
                        attachAntlrCorrelation(u, c);
                        scope = u;
                    } else {
                        scope = new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, line, col, file);
                    }
                    parentForUnitScope(c).addChild(scope);
                    return scope;
                });
    }

    /**
     * Parent node for a unit scope: enclosing {@code csl_unit_declaration}'s scope if nested, else the design stub.
     */
    private CslomBase parentForUnitScope(CslParserTrunkPort.Csl_unit_declarationContext unitCtx) {
        Objects.requireNonNull(unitCtx, "unitCtx");
        CslParserTrunkPort.Csl_unit_declarationContext outer = enclosingUnitDeclaration(unitCtx);
        if (outer != null) {
            return ensureUnitScope(outer);
        }
        return designRoot;
    }

    /** Nearest {@code csl_unit_declaration} strictly enclosing {@code unitCtx} in the parse tree, if any. */
    private static CslParserTrunkPort.Csl_unit_declarationContext enclosingUnitDeclaration(
            CslParserTrunkPort.Csl_unit_declarationContext unitCtx) {
        ParserRuleContext p = unitCtx.getParent();
        while (p != null) {
            if (p instanceof CslParserTrunkPort.Csl_unit_declarationContext u) {
                return u;
            }
            p = p.getParent();
        }
        return null;
    }

    private static CslParserTrunkPort.Csl_unit_declarationContext ancestorUnitDeclaration(ParserRuleContext ctx) {
        ParserRuleContext p = ctx.getParent();
        while (p != null) {
            if (p instanceof CslParserTrunkPort.Csl_unit_declarationContext u) {
                return u;
            }
            p = p.getParent();
        }
        return null;
    }

    /**
     * ANTLR4 {@link ParserRuleContext} wrapper class simple name without the {@code Context} suffix, with the
     * leading character lowercased to match grammar rule identifiers (e.g. {@code csl_signal_declaration}).
     */
    static String antlrRuleSimpleName(ParserRuleContext ctx) {
        String s = ctx.getClass().getSimpleName();
        if (s.endsWith("Context")) {
            s = s.substring(0, s.length() - "Context".length());
        }
        if (s.isEmpty()) {
            return s;
        }
        return Character.toLowerCase(s.charAt(0)) + s.substring(1);
    }

    static String antlrText(ParserRuleContext ctx) {
        String t = ctx.getText();
        return t == null ? "" : t;
    }
}
