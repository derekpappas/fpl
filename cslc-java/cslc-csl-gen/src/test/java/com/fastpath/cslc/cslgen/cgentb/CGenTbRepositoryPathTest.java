package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class CGenTbRepositoryPathTest {

    @Test
    void nullOrBlankWorkFailsWithLegacyMessage() {
        CGenTbRepositoryPath.Outcome a = CGenTbRepositoryPath.checkWorkRoot(null);
        assertFalse(a.ok());
        assertTrue(a.errorLog().contains(CGenConsts.ENV_VAR_NAME));

        CGenTbRepositoryPath.Outcome b = CGenTbRepositoryPath.checkWorkRoot("  ");
        assertFalse(b.ok());
    }

    @Test
    void resolvesWorkPlusRelativeSegment(@TempDir Path tmp) throws Exception {
        Path expected = tmp.resolve("test").resolve("csl_test_gen");
        Files.createDirectories(expected);
        CGenTbRepositoryPath.Outcome o = CGenTbRepositoryPath.checkWorkRoot(tmp.toString());
        assertTrue(o.ok());
        assertEquals(expected.toRealPath(), o.absoluteTestGenPath().toRealPath());
    }

    @Test
    void missingDirectoryFails() {
        CGenTbRepositoryPath.Outcome o = CGenTbRepositoryPath.checkWorkRoot("/nonexistent_root_7f3a2b1c");
        assertFalse(o.ok());
        assertTrue(o.errorLog().contains("Repository path check failed"));
    }
}
