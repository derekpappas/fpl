package com.fastpath.cslc.cslom;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

class CslomPlaceholderTest {

    @Test
    void attachAntlrCorrelationOnce() {
        CslomPlaceholder p = new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, 1, 0, "f.csl");
        assertTrue(p.antlrRuleSimpleName().isEmpty());
        p.attachAntlrRuleSimpleName("csl_unit_declaration");
        assertEquals("csl_unit_declaration", p.antlrRuleSimpleName().orElseThrow());
        p.attachAntlrText("csl_unitu{}");
        assertEquals("csl_unitu{}", p.antlrText().orElseThrow());
    }

    @Test
    void attachAntlrRuleTwiceThrows() {
        CslomPlaceholder p = new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, 1, 0, "f.csl");
        p.attachAntlrRuleSimpleName("csl_unit_declaration");
        assertThrows(IllegalStateException.class, () -> p.attachAntlrRuleSimpleName("other"));
    }

    @Test
    void attachAntlrTextTwiceThrows() {
        CslomPlaceholder p = new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, 1, 0, "f.csl");
        p.attachAntlrText("a");
        assertThrows(IllegalStateException.class, () -> p.attachAntlrText("b"));
    }
}
