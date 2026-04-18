package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslLexer;
import com.fastpath.cslc.parser.csl.CslParser;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;

/**
 * Parse entry for the incremental ANTLR4 {@link CslParser} port. Lexer is {@link CslLexer}; grammar rules grow from
 * {@code CslParser.g4} toward legacy {@code csl.parser.g} coverage (no walker / CSLOM here yet).
 */
public final class CslParserFacade {

    private CslParserFacade() {}

    public static CslParser newParser(String text) {
        CslLexer lexer = new CslLexer(CharStreams.fromString(text));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        return new CslParser(tokens);
    }

    public static CslParser newParser(Path path) {
        try {
            CslLexer lexer = new CslLexer(CharStreams.fromPath(path, StandardCharsets.UTF_8));
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            return new CslParser(tokens);
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    /** Parses as {@link CslParser#sourceFile()} and returns the parse tree, or throws on syntax error. */
    public static ParseTree parseSourceFileStrict(String text) {
        CslParser parser = newParser(text);
        parser.removeErrorListeners();
        try {
            return parser.sourceFile();
        } catch (ParseCancellationException e) {
            throw e;
        }
    }
}
