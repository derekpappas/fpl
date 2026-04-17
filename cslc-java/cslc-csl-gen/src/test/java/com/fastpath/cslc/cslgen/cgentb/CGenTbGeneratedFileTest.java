package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class CGenTbGeneratedFileTest {

    @Test
    void writeClosedAppendsFileDateGenAndIncrementsCounter(@TempDir Path tmp) throws Exception {
        CGenTbTestCounter c = new CGenTbTestCounter();
        Path f = tmp.resolve("out.csl");
        CGenTbGeneratedFile.writeClosed(f, "// body\n", "tb_bin", c);
        assertEquals(1, c.get());
        String text = Files.readString(f);
        assertTrue(text.contains("// body\n"));
        assertTrue(text.contains("//File: out.csl\n"));
        assertTrue(text.contains("//Date:"));
        assertTrue(text.contains("//Gen : tb_bin\n"));
    }
}
