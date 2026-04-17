package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Path;
import org.junit.jupiter.api.Test;

class CGenTbReportTest {

    @Test
    void reportPathUsesReportCgPrefixAndOrdinal() {
        Path root = Path.of("/tmp", "gen");
        assertEquals(
                root.resolve("report_cg2").toString(),
                CGenTbReport.reportFilePath(root, CGenTbTestGen.TG_COMMAND_CALL).toString());
    }

    @Test
    void reportTextMatchesCreateReportLines() {
        StringBuilder out = new StringBuilder();
        CGenTbReport.appendReportText("cgen_decl_tb", 42, 9, out);
        assertTrue(out.toString().startsWith("Executed cgen_decl_tb\n"));
        assertTrue(out.toString().contains("Test count : 42\n"));
        assertTrue(out.toString().endsWith("Time elapsed(s) : 9\n"));
    }
}
