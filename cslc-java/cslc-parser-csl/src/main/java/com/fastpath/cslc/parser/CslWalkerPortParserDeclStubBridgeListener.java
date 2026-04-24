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
import com.fastpath.cslc.cslom.decl.CslomFifoDecl;
import com.fastpath.cslc.cslom.decl.CslomFieldDecl;
import com.fastpath.cslc.cslom.decl.CslomIncludeDecl;
import com.fastpath.cslc.cslom.decl.CslomInstUnitDecl;
import com.fastpath.cslc.cslom.decl.CslomInterfaceDecl;
import com.fastpath.cslc.cslom.decl.CslomIsaElementDecl;
import com.fastpath.cslc.cslom.decl.CslomIsaFieldDecl;
import com.fastpath.cslc.cslom.decl.CslomListDecl;
import com.fastpath.cslc.cslom.decl.CslomMemoryDecl;
import com.fastpath.cslc.cslom.decl.CslomMemoryMapDecl;
import com.fastpath.cslc.cslom.decl.CslomMemoryMapPageDecl;
import com.fastpath.cslc.cslom.decl.CslomMultiDimBitrangeDecl;
import com.fastpath.cslc.cslom.decl.CslomParameterDecl;
import com.fastpath.cslc.cslom.decl.CslomPipelineDecl;
import com.fastpath.cslc.cslom.decl.CslomPipestageDecl;
import com.fastpath.cslc.cslom.decl.CslomPortDecl;
import com.fastpath.cslc.cslom.decl.CslomPreprocessorStmtDecl;
import com.fastpath.cslc.cslom.decl.CslomRegisterDecl;
import com.fastpath.cslc.cslom.decl.CslomRegisterFileDecl;
import com.fastpath.cslc.cslom.decl.CslomSignalDecl;
import com.fastpath.cslc.cslom.decl.CslomSignalGroupDecl;
import com.fastpath.cslc.cslom.decl.CslomStateDataDecl;
import com.fastpath.cslc.cslom.decl.CslomTestbenchDecl;
import com.fastpath.cslc.cslom.decl.CslomUnitInstantiationDecl;
import com.fastpath.cslc.cslom.decl.CslomVectorDecl;
import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.Collection;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
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
            sig.attachFirstSignalParamExprCount(pls.expression() != null ? pls.expression().size() : 0);
            if (pls.expression() != null && !pls.expression().isEmpty()) {
                sig.attachFirstSignalParamExprTexts(
                        pls.expression().stream().map(CslWalkerPortParserDeclStubBridgeListener::antlrText).collect(Collectors.toList()));
            }
            CslParserTrunkPort.Bitrange_pureContext bp = pls.bitrange_pure();
            if (bp != null) {
                sig.attachFirstSignalBitrangePureText(antlrText(bp));
            }
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
            port.attachFirstPortParamExprCount(plp.expression() != null ? plp.expression().size() : 0);
            if (plp.expression() != null && !plp.expression().isEmpty()) {
                port.attachFirstPortParamExprTexts(
                        plp.expression().stream().map(CslWalkerPortParserDeclStubBridgeListener::antlrText).collect(Collectors.toList()));
            }
        }
        emitStub(port, ctx);
    }

    @Override
    public void exitCsl_interface_declaration(CslParserTrunkPort.Csl_interface_declarationContext ctx) {
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
        var ifc = new CslomInterfaceDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            ifc.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(ifc, ctx);
    }

    @Override
    public void exitCsl_bitrange_declaration(CslParserTrunkPort.Csl_bitrange_declarationContext ctx) {
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
        var br = new CslomBitrangeDecl(name, line, col, file);
        List<CslParserTrunkPort.ExpressionContext> exprs = ctx.expression();
        if (exprs != null && !exprs.isEmpty()) {
            // Grammar shape: first declarator uses exp/exp2 and later declarators use exp3/exp4.
            // We record the first two expressions only (first declarator's optional ( ... ) list).
            int take = Math.min(2, exprs.size());
            br.attachFirstBitrangeParamExprTexts(
                    exprs.subList(0, take).stream()
                            .map(CslWalkerPortParserDeclStubBridgeListener::antlrText)
                            .collect(Collectors.toList()));
        }
        emitStub(br, ctx);
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
        var rf = new CslomRegisterFileDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            rf.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(rf, ctx);
    }

    @Override
    public void exitCsl_testbench_declaration(CslParserTrunkPort.Csl_testbench_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomTestbenchDecl::new);
    }

    @Override
    public void exitCsl_fifo_declaration(CslParserTrunkPort.Csl_fifo_declarationContext ctx) {
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
        var fifo = new CslomFifoDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            fifo.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(fifo, ctx);
    }

    @Override
    public void exitCsl_memory_map_declaration(CslParserTrunkPort.Csl_memory_map_declarationContext ctx) {
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
        var mm = new CslomMemoryMapDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            mm.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(mm, ctx);
    }

    @Override
    public void exitCsl_memory_map_page_declaration(CslParserTrunkPort.Csl_memory_map_page_declarationContext ctx) {
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
        var mmp = new CslomMemoryMapPageDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            mmp.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(mmp, ctx);
    }

    @Override
    public void exitCsl_register_declaration(CslParserTrunkPort.Csl_register_declarationContext ctx) {
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
        var reg = new CslomRegisterDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            reg.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(reg, ctx);
    }

    @Override
    public void exitCsl_memory_declaration(CslParserTrunkPort.Csl_memory_declarationContext ctx) {
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
        var m = new CslomMemoryDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            m.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(m, ctx);
    }

    @Override
    public void exitCsl_state_data_declaration(CslParserTrunkPort.Csl_state_data_declarationContext ctx) {
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
        var sd = new CslomStateDataDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            sd.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(sd, ctx);
    }

    @Override
    public void exitCsl_vector_declaration(CslParserTrunkPort.Csl_vector_declarationContext ctx) {
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
        var v = new CslomVectorDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            v.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(v, ctx);
    }

    @Override
    public void exitCsl_isa_field_declaration(CslParserTrunkPort.Csl_isa_field_declarationContext ctx) {
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
        var isf = new CslomIsaFieldDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            isf.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(isf, ctx);
    }

    @Override
    public void exitCsl_isa_element_declaration(CslParserTrunkPort.Csl_isa_element_declarationContext ctx) {
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
        var ise = new CslomIsaElementDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            ise.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(ise, ctx);
    }

    @Override
    public void exitCsl_enum_declaration(CslParserTrunkPort.Csl_enum_declarationContext ctx) {
        TerminalNode id = ctx.IDENTIFIER();
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
        var en = new CslomEnumDecl(name, line, col, file);
        List<CslParserTrunkPort.Csl_enum_declaration_itemContext> items = ctx.csl_enum_declaration_item();
        if (items != null && !items.isEmpty()) {
            en.attachEnumItemTexts(
                    items.stream().map(CslWalkerPortParserDeclStubBridgeListener::antlrText).collect(Collectors.toList()));
        }
        emitStub(en, ctx);
    }

    @Override
    public void exitCsl_field_declaration(CslParserTrunkPort.Csl_field_declarationContext ctx) {
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
        var fld = new CslomFieldDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            fld.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(fld, ctx);
    }

    @Override
    public void exitCsl_include_declaration(CslParserTrunkPort.Csl_include_declarationContext ctx) {
        TerminalNode id = ctx.IDENTIFIER();
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
        var inc = new CslomIncludeDecl(name, line, col, file);
        if (ctx.expression() != null) {
            inc.attachIncludeArgumentExpressionText(antlrText(ctx.expression()));
        }
        emitStub(inc, ctx);
    }

    @Override
    public void exitCsl_signal_group_declaration(CslParserTrunkPort.Csl_signal_group_declarationContext ctx) {
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
        var sg = new CslomSignalGroupDecl(name, line, col, file);
        if (ctx.csl_unit_definition() != null) {
            sg.attachUnitDefinitionText(antlrText(ctx.csl_unit_definition()));
        }
        emitStub(sg, ctx);
    }

    @Override
    public void exitCsl_list_declaration(CslParserTrunkPort.Csl_list_declarationContext ctx) {
        List<TerminalNode> idNodes = ctx.IDENTIFIER();
        String name;
        Token start;
        if (idNodes != null && !idNodes.isEmpty()) {
            TerminalNode id0 = idNodes.get(0);
            name = id0.getText();
            start = id0.getSymbol();
        } else {
            name = CslomListDecl.ANONYMOUS_LIST_DECL_NAME;
            List<CslParserTrunkPort.Param_list_csl_listContext> plsForPos = ctx.param_list_csl_list();
            if (plsForPos != null && !plsForPos.isEmpty()) {
                TerminalNode lp = plsForPos.get(0).LPAREN();
                start = lp != null ? lp.getSymbol() : ctx.getStart();
            } else {
                start = ctx.getStart();
            }
        }
        if (name.isEmpty()) {
            return;
        }
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        var list = new CslomListDecl(name, line, col, file);
        List<CslParserTrunkPort.Param_list_csl_listContext> pls = ctx.param_list_csl_list();
        if (pls != null && !pls.isEmpty()) {
            List<List<String>> segments = new ArrayList<>(pls.size());
            for (CslParserTrunkPort.Param_list_csl_listContext pl : pls) {
                List<CslParserTrunkPort.ExpressionContext> exprs = pl.expression();
                if (exprs == null || exprs.isEmpty()) {
                    segments.add(List.of());
                } else {
                    segments.add(
                            exprs.stream()
                                    .map(CslWalkerPortParserDeclStubBridgeListener::antlrText)
                                    .collect(Collectors.toList()));
                }
            }
            list.attachEachListParamExprTextLists(segments);
        }
        if (idNodes != null && idNodes.size() > 1) {
            list.attachAdditionalListDeclaratorNames(
                    idNodes.subList(1, idNodes.size()).stream()
                            .map(TerminalNode::getText)
                            .collect(Collectors.toList()));
        }
        emitStub(list, ctx);
    }

    @Override
    public void exitCsl_multi_dim_bitrange_declaration(CslParserTrunkPort.Csl_multi_dim_bitrange_declarationContext ctx) {
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
        var br = new CslomMultiDimBitrangeDecl(name, line, col, file);
        List<CslParserTrunkPort.ExpressionContext> exprs = ctx.expression();
        if (exprs != null && !exprs.isEmpty()) {
            // Grammar shape: first declarator uses exp and later declarators use exp2.
            br.attachFirstMultiDimBitrangeParamExprTexts(
                    List.of(antlrText(exprs.get(0))));
        }
        emitStub(br, ctx);
    }

    @Override
    public void exitCsl_pipeline_declaration(CslParserTrunkPort.Csl_pipeline_declarationContext ctx) {
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
        var p = new CslomPipelineDecl(name, line, col, file);
        List<CslParserTrunkPort.ExpressionContext> exprs = ctx.expression();
        if (exprs != null && !exprs.isEmpty()) {
            // Grammar shape: first declarator uses exp and later declarators use exp2.
            p.attachFirstPipelineParamExprTexts(List.of(antlrText(exprs.get(0))));
        }
        emitStub(p, ctx);
    }

    @Override
    public void exitCsl_pipestage_declaration(CslParserTrunkPort.Csl_pipestage_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomPipestageDecl::new);
    }

    @Override
    public void exitCsl_const_int_declaration(CslParserTrunkPort.Csl_const_int_declarationContext ctx) {
        addNamed(ctx, ctx.IDENTIFIER(0), CslomParameterDecl::new);
    }

    @Override
    public void exitCsl_parameter_declaration(CslParserTrunkPort.Csl_parameter_declarationContext ctx) {
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
        var p = new CslomParameterDecl(name, line, col, file);
        List<CslParserTrunkPort.ExpressionContext> exprs = ctx.expression();
        if (exprs != null && !exprs.isEmpty()) {
            // Grammar shape: first declarator uses exp1/exp2, then later declarators use exp3/exp4.
            int take = Math.min(2, exprs.size());
            p.attachFirstParamExprTexts(
                    exprs.subList(0, take).stream()
                            .map(CslWalkerPortParserDeclStubBridgeListener::antlrText)
                            .collect(Collectors.toList()));
        }
        emitStub(p, ctx);
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
