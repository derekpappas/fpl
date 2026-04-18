package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.verilog.VerilogLexer;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.Token;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

/**
 * Lex-only helpers using generated {@link VerilogLexer}. For parse trees see {@link VerilogParserFacade}.
 */
public final class VerilogLexerFacade {

    private VerilogLexerFacade() {}

    public static List<Token> tokenize(String text) {
        VerilogLexer lexer = new VerilogLexer(CharStreams.fromString(text));
        return drain(lexer);
    }

    public static List<Token> tokenizeFile(Path path) {
        try {
            VerilogLexer lexer = new VerilogLexer(CharStreams.fromPath(path, StandardCharsets.UTF_8));
            return drain(lexer);
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    private static List<Token> drain(Lexer lexer) {
        List<Token> out = new ArrayList<>();
        for (Token t = lexer.nextToken(); t.getType() != Token.EOF; t = lexer.nextToken()) {
            if (t.getChannel() == Token.DEFAULT_CHANNEL) {
                out.add(t);
            }
        }
        return out;
    }
}
