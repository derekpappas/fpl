package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Path;
import org.junit.jupiter.api.Test;

class CGenTbRunContextTest {

    @Test
    void currentEmptyOutsideRunStub() {
        assertTrue(CGenTbRunContext.current().isEmpty());
    }

    @Test
    void installAndClearRoundTrip() {
        Path p = Path.of("x");
        CGenTbTestCounter c = new CGenTbTestCounter();
        CGenTbRunContext.install(p, "bin", CGenTbTestGen.TG_DECLARATION, CGenTbChapter.CPT_FIFO, c);
        try {
            CGenTbRunContext ctx = CGenTbRunContext.current().orElseThrow();
            assertEquals(p, ctx.absoluteTestGenRoot());
            assertEquals("bin", ctx.binaryName());
            assertEquals(CGenTbTestGen.TG_DECLARATION, ctx.tgType());
            assertEquals(CGenTbChapter.CPT_FIFO, ctx.chapterFilter());
            assertEquals(c, ctx.testCounter());
        } finally {
            CGenTbRunContext.clear();
        }
        assertTrue(CGenTbRunContext.current().isEmpty());
    }
}
