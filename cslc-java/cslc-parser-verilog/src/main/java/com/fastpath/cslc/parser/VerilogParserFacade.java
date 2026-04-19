package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.verilog.VerilogLexer;
import com.fastpath.cslc.parser.verilog.VerilogParser;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;

/**
 * Parse entry for the small ANTLR4 {@link VerilogParser} stub. For the mechanical trunk grammar see
 * {@link VerilogParserTrunkPortFacade}.
 */
public final class VerilogParserFacade {

    private VerilogParserFacade() {}

    public static VerilogParser newParser(String text) {
        VerilogLexer lexer = new VerilogLexer(CharStreams.fromString(text));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        return new VerilogParser(tokens);
    }

    public static VerilogParser newParser(Path path) {
        try {
            VerilogLexer lexer = new VerilogLexer(CharStreams.fromPath(path, StandardCharsets.UTF_8));
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            return new VerilogParser(tokens);
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    /** Parses as {@link VerilogParser#source_text()} (legacy rule name) and returns the parse tree. */
    public static ParseTree parseSourceTextStrict(String text) {
        VerilogParser parser = newParser(text);
        parser.removeErrorListeners();
        try {
            return parser.source_text();
        } catch (ParseCancellationException e) {
            throw e;
        }
    }
}
