package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

class CslGenSupportEmitTest {

    @Test
    void bracesAndDeclMatchLegacy() {
        StringBuilder sb = new StringBuilder();
        CslGenSupportEmit.declSHbegin(sb, "csl_unit", "u");
        CslGenSupportEmit.declSHend(sb);
        assertEquals("csl_unit u{\n};\n", sb.toString());
    }

    @Test
    void initEmitsLegacyInitialiseKeyword() {
        StringBuilder sb = new StringBuilder();
        CslGenSupportEmit.init(sb);
        assertEquals("  void initialise()", sb.toString());
    }

    @Test
    void funct1paramLine() {
        StringBuilder sb = new StringBuilder();
        CslGenSupportEmit.funct1param(sb, "foo", "x");
        assertEquals("     foo(x);\n", sb.toString());
    }

    @Test
    void call2paramLine() {
        StringBuilder sb = new StringBuilder();
        CslGenSupportEmit.call2param(sb, "this.", "", "bar", "1", "2");
        assertEquals("    this..bar(1, 2);\n", sb.toString());
    }

    @Test
    void cslKeywords() {
        StringBuilder sb = new StringBuilder();
        CslGenSupportEmit.cslMemory(sb);
        CslGenSupportEmit.cslRegister(sb);
        assertEquals("csl_memory csl_register ", sb.toString());
    }

    @Test
    void displayFunctDeclAppendsCommandNameAndSemicolon() {
        StringBuilder sb = new StringBuilder();
        CslGenSupportEmit.displayFunctDecl(sb, "void", "foo");
        assertEquals("  void foo;\n", sb.toString());
    }

    @Test
    void displayFunctDeclRejectsNullCommand() {
        assertThrows(NullPointerException.class, () -> CslGenSupportEmit.displayFunctDecl(new StringBuilder(), null, "x"));
    }

    @Test
    void call0paramMatchesLegacyCallShape() {
        StringBuilder sb = new StringBuilder();
        CslGenSupportEmit.call0param(sb, "self.", "sig", "clear");
        assertEquals("    self.sig.clear();\n", sb.toString());
    }
}
