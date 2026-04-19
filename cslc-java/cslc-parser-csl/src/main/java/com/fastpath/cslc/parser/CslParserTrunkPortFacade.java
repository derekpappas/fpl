package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslLexer;
import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
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
 * Parse entry for the mechanical ANTLR4 {@link CslParserTrunkPort} grammar (syntax-only trunk port).
 * For the minimal stub parser see {@link CslParserFacade}. For migrating legacy {@code csl.walker.g},
 * start from {@link CslTrunkPortListenerSkeleton}; use {@link #walk(ParseTree, ParseTreeListener)} or
 * {@link #parseSourceTextStrictAndWalk(String, ParseTreeListener)} ({@link ParseTreeWalker#DEFAULT}).
 * For per-rule entry counts while porting {@code csl.walker.g}, see {@link CslWalkerPortMetricsListener}.
 * First rule-specific hook: {@link CslWalkerPortCslUnitDeclarationListener} ({@code csl_unit_declaration}).
 * CSLOM bridge: {@link CslWalkerPortParserDeclStubBridgeListener} (all {@code csl_*_declaration} exits as
 * {@code com.fastpath.cslc.cslom.decl} {@link com.fastpath.cslc.cslom.CslomNamedDecl} types, {@link com.fastpath.cslc.cslom.CslomUnitDecl}
 * for units; plus {@code csl_inst} / ctor-branch {@code csl_inst_or_cstor}; see {@code ANTLR_PORT_BATCH_PLAN.txt}
 * batches 2–4). Batch 3: {@link com.fastpath.cslc.cslom.CslomNamedDecl#antlrRuleSimpleName} and
 * {@link com.fastpath.cslc.cslom.CslomNamedDecl#antlrText} on bridge-produced nodes.
 * Command verb metrics (walker port batch 5): {@link CslWalkerPortCommandVerbListener} (verbs, receivers,
 * {@link CslWalkerPortCommandVerbListener#commandTextsInExitOrder command text}).
 */
public final class CslParserTrunkPortFacade {

    private CslParserTrunkPortFacade() {}

    public static CslParserTrunkPort newParser(String text) {
        CslLexer lexer = new CslLexer(CharStreams.fromString(text));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        return new CslParserTrunkPort(tokens);
    }

    public static CslParserTrunkPort newParser(Path path) {
        try {
            CslLexer lexer = new CslLexer(CharStreams.fromPath(path, StandardCharsets.UTF_8));
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            return new CslParserTrunkPort(tokens);
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    /** Parses as {@link CslParserTrunkPort#source_text()} (legacy entry rule name). */
    public static ParseTree parseSourceTextStrict(String text) {
        CslParserTrunkPort parser = newParser(text);
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
