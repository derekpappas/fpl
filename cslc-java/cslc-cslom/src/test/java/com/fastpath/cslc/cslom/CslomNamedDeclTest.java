package com.fastpath.cslc.cslom;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fastpath.cslc.cslom.decl.CslomSignalDecl;
import org.junit.jupiter.api.Test;

class CslomNamedDeclTest {

    @Test
    void attachAntlrRuleSimpleNameOnce() {
        CslomSignalDecl s = new CslomSignalDecl("x", 1, 0, "f.csl");
        assertTrue(s.antlrRuleSimpleName().isEmpty());
        s.attachAntlrRuleSimpleName("csl_signal_declaration");
        assertEquals("csl_signal_declaration", s.antlrRuleSimpleName().orElseThrow());
    }

    @Test
    void attachAntlrRuleSimpleNameTwiceThrows() {
        CslomSignalDecl s = new CslomSignalDecl("x", 1, 0, "f.csl");
        s.attachAntlrRuleSimpleName("csl_signal_declaration");
        assertThrows(IllegalStateException.class, () -> s.attachAntlrRuleSimpleName("csl_port_declaration"));
    }

    @Test
    void attachAntlrTextOnce() {
        CslomSignalDecl s = new CslomSignalDecl("x", 1, 0, "f.csl");
        assertTrue(s.antlrText().isEmpty());
        s.attachAntlrText("csl_signals;");
        assertEquals("csl_signals;", s.antlrText().orElseThrow());
    }

    @Test
    void attachAntlrTextTwiceThrows() {
        CslomSignalDecl s = new CslomSignalDecl("x", 1, 0, "f.csl");
        s.attachAntlrText("t1");
        assertThrows(IllegalStateException.class, () -> s.attachAntlrText("t2"));
    }
}
