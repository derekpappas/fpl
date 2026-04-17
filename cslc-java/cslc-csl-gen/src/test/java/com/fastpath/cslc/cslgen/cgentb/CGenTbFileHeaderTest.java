package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CGenTbFileHeaderTest {

    @Test
    void lineMatchesBuildHeader() {
        assertEquals("//Gen : cgen_decl_tb\n", CGenTbFileHeader.line("cgen_decl_tb"));
    }
}
