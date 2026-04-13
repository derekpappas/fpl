package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class CGenTbMainArgsTest {

    @Test
    void programOnlyMeansAllChapters() {
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(new String[] {"cgen_inst_cmds_tb"});
        assertTrue(r.ok());
        assertEquals(CGenTbChapter.CPT_ALL, r.chapter());
    }

    @Test
    void fifoSelectsChapter() {
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(new String[] {"bin", "fifo"});
        assertTrue(r.ok());
        assertEquals(CGenTbChapter.CPT_FIFO, r.chapter());
    }

    @Test
    void verificationComponents() {
        CGenTbMainArgs.Result r =
                CGenTbMainArgs.validate(new String[] {"x", "verification_components"});
        assertTrue(r.ok());
        assertEquals(CGenTbChapter.CPT_VERIFC, r.chapter());
    }

    @Test
    void helpFailsWithUsage() {
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(new String[] {"prog", CGenTbMainArgs.ARG_HELP});
        assertFalse(r.ok());
        assertTrue(r.errorLog().contains("prog"));
        assertTrue(r.errorLog().contains("fifo"));
    }

    @Test
    void badChapterFails() {
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(new String[] {"prog", "nope"});
        assertFalse(r.ok());
        assertTrue(r.errorLog().contains("Invalid chapter name"));
    }

    @Test
    void tooManyArgsFails() {
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(new String[] {"a", "b", "c"});
        assertFalse(r.ok());
        assertTrue(r.errorLog().contains("Invalid number of arguments"));
    }

    @Test
    void emptyArgvFails() {
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(new String[] {});
        assertFalse(r.ok());
    }
}
