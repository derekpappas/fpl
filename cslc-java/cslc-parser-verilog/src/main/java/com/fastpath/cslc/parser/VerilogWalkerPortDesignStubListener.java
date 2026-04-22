package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.verilog.VerilogParserTrunkPort;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;

import java.util.ArrayDeque;
import java.util.Collection;
import java.util.Deque;
import java.util.List;
import java.util.Objects;

/**
 * Collects flat {@link VerilogDesignElementStub} entries from completed {@code module} (incl. {@code macromodule}
 * via {@link VerilogModuleDeclStub#macromodule()}; header {@link VerilogModuleDeclStub#moduleParameterPortListText()}
 * and {@link VerilogModuleDeclStub#portsListText()}), {@code port_declaration},
 * {@code list_of_port_declarations} (comma-only {@code variable_port_identifier} in ANSI lists),
 * {@code list_of_ports} (non-ANSI header list as {@link VerilogListOfPortsStub}),
 * {@code net_declaration} (optional per-net {@link VerilogSignalDeclStub#initializerText()} from
 * {@code list_of_net_identifiers_or_decl_assignments}), {@code reg_declaration}, {@code integer_declaration},
 * {@code time_declaration},
 * {@code real_declaration}, {@code realtime_declaration}, {@code event_declaration}, {@code genvar_declaration},
 * {@code udp_declaration} ({@link VerilogUdpDeclStub#synopsis()}), {@code module_or_udp_instantiation} ({@link VerilogModuleInstanceStub}:
 * {@code enclosingModuleName} from stack; {@code parameter_value_assignment_or_delay2} and per-instance
 * {@code list_of_port_connections} text when present), {@code continuous_assign} (one
 * {@link VerilogContinuousAssignStub} per {@code net_assignment}; each carries full {@code continuous_assign}
 * {@link VerilogContinuousAssignStub#statementSynopsis()}, {@code gate_instantiation}
 * ({@link VerilogGateInstantiationStub#gateKind()}),
 * {@code initial_construct} / {@code always_construct} ({@link VerilogInitialConstructStub#attrsOptText()} /
 * {@link VerilogAlwaysConstructStub#attrsOptText()}), {@code parameter_override} ({@code defparam}; one
 * {@link VerilogDefparamAssignmentStub} per {@code defparam_assignment}), {@code task_declaration},
 * {@code function_declaration}, {@code specparam_declaration} (one {@link VerilogSpecparamAssignmentStub} per
 * {@code specparam_assignment}), {@code parameter_declaration} and {@code local_parameter_declaration} (one
 * {@link VerilogParamDeclAssignmentStub} per {@code param_assignment}; {@code module_parameter_port_list} uses
 * {@code declarationKind} {@code "module_parameter_port"}, {@code generated_instantiation}
 * ({@link VerilogGenerateRegionStub} for the whole {@code generate} … {@code endgenerate} region),
 * {@code generate_block} and {@code generate_loop_statement} ({@link VerilogGenerateBlockStub}),
 * {@code generate_conditional_statement} ({@link VerilogGenerateConditionalStub}),
 * {@code generate_case_statement} ({@link VerilogGenerateCaseStub}), {@code specify_block}
 * ({@link VerilogSpecifyBlockStub})
 * rules (syntax-only; no {@code cslc-cslom} dependency).
 *
 * @see VerilogParserTrunkPortFacade
 */
public final class VerilogWalkerPortDesignStubListener extends VerilogTrunkPortListenerSkeleton {

    private final Collection<? super VerilogDesignElementStub> sink;
    private final Deque<String> enclosingModuleNames = new ArrayDeque<>();

    public VerilogWalkerPortDesignStubListener(Collection<? super VerilogDesignElementStub> sink) {
        this.sink = Objects.requireNonNull(sink, "sink");
    }

    @Override
    public void enterModule(VerilogParserTrunkPort.ModuleContext ctx) {
        VerilogParserTrunkPort.Module_identifierContext mid = ctx.module_identifier();
        String n = mid != null ? mid.getText() : null;
        enclosingModuleNames.push(n != null && !n.isEmpty() ? n : "");
    }

    @Override
    public void exitModule(VerilogParserTrunkPort.ModuleContext ctx) {
        try {
            VerilogParserTrunkPort.Module_identifierContext mid = ctx.module_identifier();
            if (mid == null) {
                return;
            }
            String name = mid.getText();
            if (name == null || name.isEmpty()) {
                return;
            }
            Token start = positionToken(mid);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            boolean macromodule = false;
            VerilogParserTrunkPort.Module_keywordContext mkw = ctx.module_keyword();
            if (mkw != null && mkw.K_MACROMODULE() != null) {
                macromodule = true;
            }
            String mplText = nonEmptyContextText(ctx.module_parameter_port_list());
            String portsText = nonEmptyContextText(ctx.list_of_port_declarations());
            if (portsText == null) {
                portsText = nonEmptyContextText(ctx.list_of_ports());
            }
            sink.add(new VerilogModuleDeclStub(name, line, col, file, macromodule, mplText, portsText));
        } finally {
            if (!enclosingModuleNames.isEmpty()) {
                enclosingModuleNames.pop();
            }
        }
    }

    @Override
    public void exitModule_parameter_port_list(VerilogParserTrunkPort.Module_parameter_port_listContext ctx) {
        emitParamAssignmentContexts(ctx.param_assignment(), "module_parameter_port");
    }

    @Override
    public void exitPort_declaration(VerilogParserTrunkPort.Port_declarationContext ctx) {
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        if (ctx.inout_declaration() != null) {
            emitPort(module, "inout", ctx.inout_declaration().port_identifier());
            return;
        }
        if (ctx.input_declaration() != null) {
            emitPort(module, "input", ctx.input_declaration().port_identifier());
            return;
        }
        if (ctx.output_declaration() != null) {
            VerilogParserTrunkPort.Output_declarationContext od = ctx.output_declaration();
            if (od.port_identifier() != null) {
                emitPort(module, "output", od.port_identifier());
                return;
            }
            if (od.variable_port_identifier() != null) {
                emitPortFromVariablePortId(module, "output", od.variable_port_identifier());
            }
        }
    }

    @Override
    public void exitModule_item(VerilogParserTrunkPort.Module_itemContext ctx) {
        VerilogParserTrunkPort.Port_declarationContext pdecl = ctx.port_declaration();
        if (pdecl == null) {
            return;
        }
        List<VerilogParserTrunkPort.Variable_port_identifierContext> extra = ctx.variable_port_identifier();
        if (extra == null || extra.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        String dir = directionOf(pdecl);
        for (VerilogParserTrunkPort.Variable_port_identifierContext vid : extra) {
            emitPortFromVariablePortId(module, dir, vid);
        }
    }

    private static String directionOf(VerilogParserTrunkPort.Port_declarationContext pdecl) {
        if (pdecl.inout_declaration() != null) {
            return "inout";
        }
        if (pdecl.input_declaration() != null) {
            return "input";
        }
        if (pdecl.output_declaration() != null) {
            return "output";
        }
        return "unknown";
    }

    /**
     * ANSI {@code list_of_port_declarations}: after a comma the grammar may use {@code variable_port_identifier}
     * only (e.g. {@code input a, b}). Those identifiers are not wrapped in their own {@code port_declaration}, so
     * emit them here using the direction of the last {@code port_declaration} in the same list.
     */
    @Override
    public void exitList_of_port_declarations(VerilogParserTrunkPort.List_of_port_declarationsContext ctx) {
        List<VerilogParserTrunkPort.Variable_port_identifierContext> vpis = ctx.variable_port_identifier();
        if (vpis == null || vpis.isEmpty()) {
            return;
        }
        List<VerilogParserTrunkPort.Port_declarationContext> pdecls = ctx.port_declaration();
        if (pdecls == null || pdecls.isEmpty()) {
            return;
        }
        VerilogParserTrunkPort.Port_declarationContext lastDecl = pdecls.get(pdecls.size() - 1);
        String dir = directionOf(lastDecl);
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        for (VerilogParserTrunkPort.Variable_port_identifierContext vid : vpis) {
            emitPortFromVariablePortId(module, dir, vid);
        }
    }

    @Override
    public void exitList_of_ports(VerilogParserTrunkPort.List_of_portsContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogListOfPortsStub(module, text, line, col, file));
    }

    @Override
    public void exitContinuous_assign(VerilogParserTrunkPort.Continuous_assignContext ctx) {
        VerilogParserTrunkPort.List_of_net_assignmentsContext list = ctx.list_of_net_assignments();
        if (list == null) {
            return;
        }
        List<VerilogParserTrunkPort.Net_assignmentContext> assigns = list.net_assignment();
        if (assigns == null) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        String stmt = ctx.getText();
        if (stmt == null) {
            stmt = "";
        }
        for (VerilogParserTrunkPort.Net_assignmentContext na : assigns) {
            if (na == null) {
                continue;
            }
            String text = na.getText();
            if (text == null || text.isEmpty()) {
                continue;
            }
            Token start = positionToken(na);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogContinuousAssignStub(module, text, stmt, line, col, file));
        }
    }

    @Override
    public void exitGate_instantiation(VerilogParserTrunkPort.Gate_instantiationContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        String kind = gateKind(ctx);
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogGateInstantiationStub(module, kind, text, line, col, file));
    }

    /**
     * First keyword / switch-type slice for the {@code gate_instantiation} alternative (trunk grammar).
     */
    private static String gateKind(VerilogParserTrunkPort.Gate_instantiationContext ctx) {
        if (ctx.cmos_switchtype() != null) {
            return nullToEmpty(ctx.cmos_switchtype().getText());
        }
        if (ctx.enable_gatetype() != null) {
            return nullToEmpty(ctx.enable_gatetype().getText());
        }
        if (ctx.mos_switchtype() != null) {
            return nullToEmpty(ctx.mos_switchtype().getText());
        }
        if (ctx.n_input_gatetype() != null) {
            return nullToEmpty(ctx.n_input_gatetype().getText());
        }
        if (ctx.n_output_gatetype() != null) {
            return nullToEmpty(ctx.n_output_gatetype().getText());
        }
        if (ctx.pass_enable_switchtype() != null) {
            return nullToEmpty(ctx.pass_enable_switchtype().getText());
        }
        if (ctx.pass_switchtype() != null) {
            return nullToEmpty(ctx.pass_switchtype().getText());
        }
        if (ctx.K_PULLDOWN() != null) {
            return nullToEmpty(ctx.K_PULLDOWN().getText());
        }
        if (ctx.K_PULLUP() != null) {
            return nullToEmpty(ctx.K_PULLUP().getText());
        }
        return "";
    }

    private static String nullToEmpty(String s) {
        return s == null ? "" : s;
    }

    @Override
    public void exitInitial_construct(VerilogParserTrunkPort.Initial_constructContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        String attrs = nonEmptyContextText(ctx.attrs_opt());
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogInitialConstructStub(module, attrs, text, line, col, file));
    }

    @Override
    public void exitAlways_construct(VerilogParserTrunkPort.Always_constructContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        String attrs = nonEmptyContextText(ctx.attrs_opt());
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogAlwaysConstructStub(module, attrs, text, line, col, file));
    }

    @Override
    public void exitSpecify_block(VerilogParserTrunkPort.Specify_blockContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogSpecifyBlockStub(module, text, line, col, file));
    }

    @Override
    public void exitGenerated_instantiation(VerilogParserTrunkPort.Generated_instantiationContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogGenerateRegionStub(module, text, line, col, file));
    }

    @Override
    public void exitGenerate_block(VerilogParserTrunkPort.Generate_blockContext ctx) {
        emitGenerateBlockStub("block", ctx.generate_block_identifier(), ctx);
    }

    @Override
    public void exitGenerate_loop_statement(VerilogParserTrunkPort.Generate_loop_statementContext ctx) {
        emitGenerateBlockStub("for_loop", ctx.generate_block_identifier(), ctx);
    }

    @Override
    public void exitGenerate_conditional_statement(VerilogParserTrunkPort.Generate_conditional_statementContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogGenerateConditionalStub(module, text, line, col, file));
    }

    @Override
    public void exitGenerate_case_statement(VerilogParserTrunkPort.Generate_case_statementContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogGenerateCaseStub(module, text, line, col, file));
    }

    @Override
    public void exitParameter_override(VerilogParserTrunkPort.Parameter_overrideContext ctx) {
        VerilogParserTrunkPort.List_of_defparam_assignmentsContext list = ctx.list_of_defparam_assignments();
        if (list == null) {
            return;
        }
        List<VerilogParserTrunkPort.Defparam_assignmentContext> assigns = list.defparam_assignment();
        if (assigns == null) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        for (VerilogParserTrunkPort.Defparam_assignmentContext da : assigns) {
            if (da == null) {
                continue;
            }
            String t = da.getText();
            if (t == null || t.isEmpty()) {
                continue;
            }
            Token start = positionToken(da);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogDefparamAssignmentStub(module, t, line, col, file));
        }
    }

    @Override
    public void exitTask_declaration(VerilogParserTrunkPort.Task_declarationContext ctx) {
        VerilogParserTrunkPort.Task_identifierContext tid = ctx.task_identifier();
        if (tid == null) {
            return;
        }
        String name = tid.getText();
        if (name == null || name.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(tid);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogTaskDeclStub(module, name, line, col, file));
    }

    @Override
    public void exitFunction_declaration(VerilogParserTrunkPort.Function_declarationContext ctx) {
        VerilogParserTrunkPort.Function_identifierContext fid = ctx.function_identifier();
        if (fid == null) {
            return;
        }
        String name = fid.getText();
        if (name == null || name.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(fid);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogFunctionDeclStub(module, name, line, col, file));
    }

    @Override
    public void exitSpecparam_declaration(VerilogParserTrunkPort.Specparam_declarationContext ctx) {
        VerilogParserTrunkPort.List_of_specparam_assignmentsContext list = ctx.list_of_specparam_assignments();
        if (list == null) {
            return;
        }
        List<VerilogParserTrunkPort.Specparam_assignmentContext> assigns = list.specparam_assignment();
        if (assigns == null) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        for (VerilogParserTrunkPort.Specparam_assignmentContext sa : assigns) {
            if (sa == null) {
                continue;
            }
            String t = sa.getText();
            if (t == null || t.isEmpty()) {
                continue;
            }
            Token start = positionToken(sa);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogSpecparamAssignmentStub(module, t, line, col, file));
        }
    }

    @Override
    public void exitParameter_declaration(VerilogParserTrunkPort.Parameter_declarationContext ctx) {
        emitParamAssignments(ctx.list_of_param_assignments(), "parameter");
    }

    @Override
    public void exitLocal_parameter_declaration(VerilogParserTrunkPort.Local_parameter_declarationContext ctx) {
        emitParamAssignments(ctx.list_of_param_assignments(), "localparam");
    }

    private void emitParamAssignments(
            VerilogParserTrunkPort.List_of_param_assignmentsContext list, String declarationKind) {
        if (list == null) {
            return;
        }
        emitParamAssignmentContexts(list.param_assignment(), declarationKind);
    }

    private void emitParamAssignmentContexts(
            List<VerilogParserTrunkPort.Param_assignmentContext> pas, String declarationKind) {
        if (pas == null) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        for (VerilogParserTrunkPort.Param_assignmentContext pa : pas) {
            if (pa == null) {
                continue;
            }
            String t = pa.getText();
            if (t == null || t.isEmpty()) {
                continue;
            }
            Token start = positionToken(pa);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogParamDeclAssignmentStub(module, declarationKind, t, line, col, file));
        }
    }

    @Override
    public void exitNet_declaration(VerilogParserTrunkPort.Net_declarationContext ctx) {
        VerilogParserTrunkPort.List_of_net_identifiers_or_decl_assignmentsContext list =
                ctx.list_of_net_identifiers_or_decl_assignments();
        if (list == null) {
            return;
        }
        String flavor;
        if (ctx.K_TRIREG() != null) {
            flavor = "trireg";
        } else if (ctx.net_type() != null) {
            flavor = ctx.net_type().getText();
        } else {
            flavor = "net";
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        List<VerilogParserTrunkPort.Net_identifierContext> nets = list.net_identifier();
        if (nets == null) {
            return;
        }
        List<VerilogParserTrunkPort.ExpressionContext> inits = list.expression();
        boolean hasInit = inits != null && !inits.isEmpty();
        for (int i = 0; i < nets.size(); i++) {
            VerilogParserTrunkPort.Net_identifierContext nid = nets.get(i);
            if (nid == null) {
                continue;
            }
            String name = nid.getText();
            if (name == null || name.isEmpty()) {
                continue;
            }
            String init = null;
            if (hasInit && i < inits.size()) {
                VerilogParserTrunkPort.ExpressionContext ex = inits.get(i);
                if (ex != null) {
                    String t = ex.getText();
                    if (t != null && !t.isEmpty()) {
                        init = t;
                    }
                }
            }
            Token start = positionToken(nid);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogSignalDeclStub(module, name, "net", flavor, line, col, file, init));
        }
    }

    @Override
    public void exitReg_declaration(VerilogParserTrunkPort.Reg_declarationContext ctx) {
        emitFromListOfVariableIdentifiers(ctx.list_of_variable_identifiers(), "reg", "reg");
    }

    @Override
    public void exitInteger_declaration(VerilogParserTrunkPort.Integer_declarationContext ctx) {
        emitFromListOfVariableIdentifiers(ctx.list_of_variable_identifiers(), "integer", "integer");
    }

    @Override
    public void exitTime_declaration(VerilogParserTrunkPort.Time_declarationContext ctx) {
        emitFromListOfVariableIdentifiers(ctx.list_of_variable_identifiers(), "time", "time");
    }

    @Override
    public void exitReal_declaration(VerilogParserTrunkPort.Real_declarationContext ctx) {
        emitFromListOfVariableIdentifiers(ctx.list_of_variable_identifiers(), "real", "real");
    }

    @Override
    public void exitRealtime_declaration(VerilogParserTrunkPort.Realtime_declarationContext ctx) {
        emitFromListOfVariableIdentifiers(ctx.list_of_variable_identifiers(), "realtime", "realtime");
    }

    @Override
    public void exitEvent_declaration(VerilogParserTrunkPort.Event_declarationContext ctx) {
        VerilogParserTrunkPort.List_of_event_identifiersContext list = ctx.list_of_event_identifiers();
        if (list == null) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        List<VerilogParserTrunkPort.Event_identifierContext> ids = list.event_identifier();
        if (ids == null) {
            return;
        }
        for (VerilogParserTrunkPort.Event_identifierContext eid : ids) {
            if (eid == null) {
                continue;
            }
            String name = eid.getText();
            if (name == null || name.isEmpty()) {
                continue;
            }
            Token start = positionToken(eid);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogSignalDeclStub(module, name, "event", "event", line, col, file, null));
        }
    }

    @Override
    public void exitGenvar_declaration(VerilogParserTrunkPort.Genvar_declarationContext ctx) {
        VerilogParserTrunkPort.List_of_genvar_identifiersContext list = ctx.list_of_genvar_identifiers();
        if (list == null) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        List<VerilogParserTrunkPort.Genvar_identifierContext> ids = list.genvar_identifier();
        if (ids == null) {
            return;
        }
        for (VerilogParserTrunkPort.Genvar_identifierContext gid : ids) {
            if (gid == null) {
                continue;
            }
            String name = gid.getText();
            if (name == null || name.isEmpty()) {
                continue;
            }
            Token start = positionToken(gid);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogSignalDeclStub(module, name, "genvar", "genvar", line, col, file, null));
        }
    }

    @Override
    public void exitUdp_declaration(VerilogParserTrunkPort.Udp_declarationContext ctx) {
        VerilogParserTrunkPort.Udp_identifierContext uid = ctx.udp_identifier();
        if (uid == null) {
            return;
        }
        String name = uid.getText();
        if (name == null || name.isEmpty()) {
            return;
        }
        String synopsis = ctx.getText();
        if (synopsis == null) {
            synopsis = "";
        }
        Token start = positionToken(uid);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogUdpDeclStub(name, synopsis, line, col, file));
    }

    @Override
    public void exitModule_or_udp_instantiation(VerilogParserTrunkPort.Module_or_udp_instantiationContext ctx) {
        VerilogParserTrunkPort.Module_identifierContext typeId = ctx.module_identifier();
        if (typeId == null) {
            return;
        }
        String moduleType = typeId.getText();
        if (moduleType == null || moduleType.isEmpty()) {
            return;
        }
        List<VerilogParserTrunkPort.Module_instanceContext> insts = ctx.module_instance();
        if (insts == null) {
            return;
        }
        String paramText = null;
        VerilogParserTrunkPort.Parameter_value_assignment_or_delay2Context pva = ctx.parameter_value_assignment_or_delay2();
        if (pva != null) {
            String pt = pva.getText();
            if (pt != null && !pt.isEmpty()) {
                paramText = pt;
            }
        }
        String enclosing = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        for (VerilogParserTrunkPort.Module_instanceContext mic : insts) {
            if (mic == null) {
                continue;
            }
            String instanceName = null;
            VerilogParserTrunkPort.Name_of_module_instanceContext nomi = mic.name_of_module_instance();
            if (nomi != null && nomi.module_instance_identifier() != null) {
                instanceName = nomi.module_instance_identifier().getText();
            }
            String portConn = null;
            VerilogParserTrunkPort.List_of_port_connectionsContext lopc = mic.list_of_port_connections();
            if (lopc != null) {
                String pc = lopc.getText();
                if (pc != null && !pc.isEmpty()) {
                    portConn = pc;
                }
            }
            Token start = positionToken(mic);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogModuleInstanceStub(enclosing, moduleType, instanceName, paramText, portConn, line, col, file));
        }
    }

    private void emitPort(String enclosingModule, String direction, VerilogParserTrunkPort.Port_identifierContext portId) {
        if (portId == null) {
            return;
        }
        String portName = portId.getText();
        if (portName == null || portName.isEmpty()) {
            return;
        }
        Token start = positionToken(portId);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogPortDeclStub(enclosingModule, portName, direction, line, col, file));
    }

    private void emitPortFromVariablePortId(
            String enclosingModule, String direction, VerilogParserTrunkPort.Variable_port_identifierContext vid) {
        if (vid == null) {
            return;
        }
        String portName = vid.getText();
        if (portName == null || portName.isEmpty()) {
            return;
        }
        Token start = positionToken(vid);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogPortDeclStub(enclosingModule, portName, direction, line, col, file));
    }

    private void emitFromListOfVariableIdentifiers(
            VerilogParserTrunkPort.List_of_variable_identifiersContext list, String declarationKind, String flavor) {
        if (list == null) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        List<VerilogParserTrunkPort.Variable_typeContext> vars = list.variable_type();
        if (vars == null) {
            return;
        }
        for (VerilogParserTrunkPort.Variable_typeContext vt : vars) {
            if (vt == null || vt.variable_identifier() == null) {
                continue;
            }
            String name = vt.variable_identifier().getText();
            if (name == null || name.isEmpty()) {
                continue;
            }
            String init = null;
            if (vt.ASSIGN() != null && vt.constant_expression() != null) {
                String t = vt.constant_expression().getText();
                if (t != null && !t.isEmpty()) {
                    init = t;
                }
            }
            Token start = positionToken(vt.variable_identifier());
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogSignalDeclStub(module, name, declarationKind, flavor, line, col, file, init));
        }
    }

    private void emitGenerateBlockStub(
            String blockKind, VerilogParserTrunkPort.Generate_block_identifierContext labelCtx, ParserRuleContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String label = null;
        if (labelCtx != null) {
            String t = labelCtx.getText();
            if (t != null && !t.isEmpty()) {
                label = t;
            }
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogGenerateBlockStub(module, blockKind, label, text, line, col, file));
    }

    private static Token positionToken(ParserRuleContext ctx) {
        Token t = ctx.getStart();
        if (t != null) {
            return t;
        }
        if (ctx.getChildCount() > 0 && ctx.getChild(0) instanceof ParserRuleContext child) {
            return child.getStart();
        }
        return null;
    }

    private static String nonEmptyContextText(ParserRuleContext ctx) {
        if (ctx == null) {
            return null;
        }
        String t = ctx.getText();
        if (t == null || t.isEmpty()) {
            return null;
        }
        return t;
    }
}
