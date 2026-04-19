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
 * Collects flat {@link VerilogDesignElementStub} entries from completed {@code module}, {@code port_declaration},
 * {@code list_of_port_declarations} (comma-only {@code variable_port_identifier} in ANSI lists),
 * {@code net_declaration}, {@code reg_declaration}, {@code integer_declaration}, {@code time_declaration},
 * {@code real_declaration}, {@code realtime_declaration}, {@code event_declaration}, {@code genvar_declaration},
 * {@code udp_declaration}, {@code module_or_udp_instantiation}, {@code continuous_assign} (one
 * {@link VerilogContinuousAssignStub} per {@code net_assignment}), {@code gate_instantiation},
 * {@code initial_construct}, {@code always_construct}, {@code parameter_override} ({@code defparam}; one
 * {@link VerilogDefparamAssignmentStub} per {@code defparam_assignment}), {@code task_declaration},
 * {@code function_declaration}, {@code specparam_declaration} (one {@link VerilogSpecparamAssignmentStub} per
 * {@code specparam_assignment}), {@code parameter_declaration} and {@code local_parameter_declaration} (one
 * {@link VerilogParamDeclAssignmentStub} per {@code param_assignment})
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
            sink.add(new VerilogModuleDeclStub(name, line, col, file));
        } finally {
            if (!enclosingModuleNames.isEmpty()) {
                enclosingModuleNames.pop();
            }
        }
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
            sink.add(new VerilogContinuousAssignStub(module, text, line, col, file));
        }
    }

    @Override
    public void exitGate_instantiation(VerilogParserTrunkPort.Gate_instantiationContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogGateInstantiationStub(module, text, line, col, file));
    }

    @Override
    public void exitInitial_construct(VerilogParserTrunkPort.Initial_constructContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogInitialConstructStub(module, text, line, col, file));
    }

    @Override
    public void exitAlways_construct(VerilogParserTrunkPort.Always_constructContext ctx) {
        String text = ctx.getText();
        if (text == null || text.isEmpty()) {
            return;
        }
        String module = enclosingModuleNames.isEmpty() ? "" : enclosingModuleNames.peek();
        Token start = positionToken(ctx);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogAlwaysConstructStub(module, text, line, col, file));
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
        List<VerilogParserTrunkPort.Param_assignmentContext> pas = list.param_assignment();
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
        for (VerilogParserTrunkPort.Net_identifierContext nid : nets) {
            if (nid == null) {
                continue;
            }
            String name = nid.getText();
            if (name == null || name.isEmpty()) {
                continue;
            }
            Token start = positionToken(nid);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogSignalDeclStub(module, name, "net", flavor, line, col, file));
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
            sink.add(new VerilogSignalDeclStub(module, name, "event", "event", line, col, file));
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
            sink.add(new VerilogSignalDeclStub(module, name, "genvar", "genvar", line, col, file));
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
        Token start = positionToken(uid);
        int line = start != null ? start.getLine() : 0;
        int col = start != null ? start.getCharPositionInLine() : 0;
        String file = start != null ? start.getTokenSource().getSourceName() : null;
        sink.add(new VerilogUdpDeclStub(name, line, col, file));
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
        for (VerilogParserTrunkPort.Module_instanceContext mic : insts) {
            if (mic == null) {
                continue;
            }
            String instanceName = null;
            VerilogParserTrunkPort.Name_of_module_instanceContext nomi = mic.name_of_module_instance();
            if (nomi != null && nomi.module_instance_identifier() != null) {
                instanceName = nomi.module_instance_identifier().getText();
            }
            Token start = positionToken(mic);
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogModuleInstanceStub(moduleType, instanceName, line, col, file));
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
            Token start = positionToken(vt.variable_identifier());
            int line = start != null ? start.getLine() : 0;
            int col = start != null ? start.getCharPositionInLine() : 0;
            String file = start != null ? start.getTokenSource().getSourceName() : null;
            sink.add(new VerilogSignalDeclStub(module, name, declarationKind, flavor, line, col, file));
        }
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
}
