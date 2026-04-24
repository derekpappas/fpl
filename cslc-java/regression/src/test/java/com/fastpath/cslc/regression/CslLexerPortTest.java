package com.fastpath.cslc.regression;

import com.fastpath.cslc.parser.CslLexerFacade;
import com.fastpath.cslc.parser.csl.CslLexer;
import org.antlr.v4.runtime.Token;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class CslLexerPortTest {

    @Test
    void lexesCslUnitKeyword() {
        List<Token> tokens = CslLexerFacade.tokenize("csl_unit");
        assertEquals(1, tokens.size());
        assertEquals(CslLexer.K_CSL_UNIT, tokens.getFirst().getType());
        assertEquals("csl_unit", tokens.getFirst().getText());
    }

    @Test
    void ignoresWhitespaceAndComments() {
        List<Token> tokens = CslLexerFacade.tokenize(" \n\tcsl_unit // trailing\n /* block */ ");
        assertEquals(1, tokens.size());
        assertEquals(CslLexer.K_CSL_UNIT, tokens.getFirst().getType());
    }

    @Test
    void lexesUnsignedNumbersWithUnderscores() {
        List<Token> tokens = CslLexerFacade.tokenize("12_34 0 9_9");
        assertEquals(3, tokens.size());
        assertEquals(CslLexer.UNSIGNED_NUMBER, tokens.get(0).getType());
        assertEquals("12_34", tokens.get(0).getText());
        assertEquals(CslLexer.UNSIGNED_NUMBER, tokens.get(1).getType());
        assertEquals("0", tokens.get(1).getText());
        assertEquals(CslLexer.UNSIGNED_NUMBER, tokens.get(2).getType());
        assertEquals("9_9", tokens.get(2).getText());
    }

    @Test
    void lexesRealNumbersAndExponentials() {
        List<Token> tokens = CslLexerFacade.tokenize("1.2 10e+3 10.5e-2");
        assertEquals(3, tokens.size());
        assertEquals(CslLexer.REAL_NUMBER, tokens.get(0).getType());
        assertEquals("1.2", tokens.get(0).getText());
        assertEquals(CslLexer.REAL_NUMBER_EXP, tokens.get(1).getType());
        assertEquals("10e+3", tokens.get(1).getText());
        assertEquals(CslLexer.REAL_NUMBER_EXP, tokens.get(2).getType());
        assertEquals("10.5e-2", tokens.get(2).getText());
    }

    @Test
    void lexesStringsWithEscapes() {
        List<Token> tokens = CslLexerFacade.tokenize("\"a\\\\b\\\"c\"");
        assertEquals(1, tokens.size());
        assertEquals(CslLexer.STRING, tokens.getFirst().getType());
        assertEquals("\"a\\\\b\\\"c\"", tokens.getFirst().getText());
    }

    @Test
    void lexesPreprocessorPoundStringNumberSequence() {
        List<Token> tokens = CslLexerFacade.tokenize("# \"f.csl\" 42");
        assertEquals(3, tokens.size());
        assertEquals(CslLexer.POUND, tokens.get(0).getType());
        assertEquals("#", tokens.get(0).getText());
        assertEquals(CslLexer.STRING, tokens.get(1).getType());
        assertEquals("\"f.csl\"", tokens.get(1).getText());
        assertEquals(CslLexer.UNSIGNED_NUMBER, tokens.get(2).getType());
        assertEquals("42", tokens.get(2).getText());
    }
}
