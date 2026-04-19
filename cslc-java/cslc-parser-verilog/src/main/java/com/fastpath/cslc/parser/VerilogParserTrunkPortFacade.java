package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.verilog.VerilogLexer;
import com.fastpath.cslc.parser.verilog.VerilogParserTrunkPort;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeListener;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;

/**
 * Parse entry for the mechanical ANTLR4 {@link VerilogParserTrunkPort} grammar (syntax-only trunk port).
 * For the minimal stub parser see {@link VerilogParserFacade}. For migrating legacy {@code verilog.walker.g},
 * start from {@link VerilogTrunkPortListenerSkeleton}; use {@link #walk(ParseTree, ParseTreeListener)} or
 * {@link #parseSourceTextStrictAndWalk(String, ParseTreeListener)} ({@link ParseTreeWalker#DEFAULT}).
 * For per-rule entry counts while porting {@code verilog.walker.g}, see {@link VerilogWalkerPortMetricsListener}.
 * First rule-specific hook: {@link VerilogWalkerPortModuleListener} ({@code module}). Design stub bridge:
 * {@link VerilogWalkerPortDesignStubListener} → {@link VerilogDesignElementStub} ({@code module} /
 * {@code macromodule},
 * {@code port_declaration}, {@code list_of_port_declarations}, {@code list_of_ports}, comma
 * {@code variable_port_identifier} in body
 * {@code module_item}, {@code net_declaration}, {@code reg_declaration}, {@code integer_declaration},
 * {@code time_declaration}, {@code real_declaration}, {@code realtime_declaration}, {@code event_declaration},
 * {@code genvar_declaration}, {@code udp_declaration}, {@code module_or_udp_instantiation},
 * {@code continuous_assign}, {@code gate_instantiation}, {@code initial_construct}, {@code always_construct},
 * {@code parameter_override} ({@code defparam}), {@code task_declaration}, {@code function_declaration},
 * {@code specparam_declaration}, {@code parameter_declaration}, {@code local_parameter_declaration},
 * {@code module_parameter_port_list},
 * {@code generated_instantiation}, {@code generate_block}, {@code generate_loop_statement},
 * {@code generate_conditional_statement}, {@code generate_case_statement}, {@code specify_block};
 * see {@code ANTLR_PORT_BATCH_PLAN.txt} batch 6).
 */
public final class VerilogParserTrunkPortFacade {

    private VerilogParserTrunkPortFacade() {}

    public static VerilogParserTrunkPort newParser(String text) {
        VerilogLexer lexer = new VerilogLexer(CharStreams.fromString(text));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        return new VerilogParserTrunkPort(tokens);
    }

    public static VerilogParserTrunkPort newParser(Path path) {
        try {
            VerilogLexer lexer = new VerilogLexer(CharStreams.fromPath(path, StandardCharsets.UTF_8));
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            return new VerilogParserTrunkPort(tokens);
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    /** Parses as {@link VerilogParserTrunkPort#source_text()} (legacy entry rule name). */
    public static ParseTree parseSourceTextStrict(String text) {
        VerilogParserTrunkPort parser = newParser(text);
        parser.removeErrorListeners();
        try {
            return parser.source_text();
        } catch (ParseCancellationException e) {
            throw e;
        }
    }

    /** Depth-first walk of {@code tree} (ANTLR4 replacement path for legacy tree-parser passes). */
    public static void walk(ParseTree tree, ParseTreeListener listener) {
        ParseTreeWalker.DEFAULT.walk(listener, tree);
    }

    /**
     * Same as {@link #parseSourceTextStrict(String)} followed by {@link #walk(ParseTree, ParseTreeListener)}.
     * Returns the parse tree for callers that need context after listener side effects.
     */
    public static ParseTree parseSourceTextStrictAndWalk(String text, ParseTreeListener listener) {
        ParseTree t = parseSourceTextStrict(text);
        walk(t, listener);
        return t;
    }
}
