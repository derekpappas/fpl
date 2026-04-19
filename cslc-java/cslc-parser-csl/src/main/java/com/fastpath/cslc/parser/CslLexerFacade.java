package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslLexer;
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
 * Lex-only helpers using generated {@link CslLexer}. For parse trees see {@link CslParserFacade} /
 * {@link CslParserTrunkPortFacade} (stub vs mechanical trunk port).
 */
public final class CslLexerFacade {

    private CslLexerFacade() {}

    public static List<Token> tokenize(String text) {
        CslLexer lexer = new CslLexer(CharStreams.fromString(text));
        return drain(lexer);
    }

    public static List<Token> tokenizeFile(Path path) {
        try {
            CslLexer lexer = new CslLexer(CharStreams.fromPath(path, StandardCharsets.UTF_8));
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
