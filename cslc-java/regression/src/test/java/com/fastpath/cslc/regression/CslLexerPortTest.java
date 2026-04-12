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
}
