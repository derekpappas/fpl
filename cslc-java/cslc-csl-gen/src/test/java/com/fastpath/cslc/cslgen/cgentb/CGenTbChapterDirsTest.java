package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class CGenTbChapterDirsTest {

    @Test
    void fifoNamesMatchBuildDirName() {
        assertEquals(
                "csl_fifo_cg2",
                CGenTbChapterDirs.chapterWorkspaceBaseName(CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_COMMAND_CALL));
        assertEquals("csl_fifo_cg2_valid", CGenTbChapterDirs.validLeafName(CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_COMMAND_CALL));
        assertEquals(
                "csl_fifo_cg2_invalid",
                CGenTbChapterDirs.invalidLeafName(CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_COMMAND_CALL));
    }

    @Test
    void cleanGlobFragmentMatchesExecuteCleanMask() {
        assertEquals("/*_cg1_*", CGenTbChapterDirs.cleanGlobFragment(CGenTbTestGen.TG_INSTANCE_DECLARATION));
    }

    @Test
    void ensureAllCreatesTwentyLeafDirs(@TempDir Path root) throws Exception {
        CGenTbChapterDirs.ensureAllChapterValidInvalidDirs(root, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isDirectory(CGenTbChapterDirs.validDir(root, CGenTbChapter.CPT_ISA, CGenTbTestGen.TG_DECLARATION)));
        assertTrue(Files.isDirectory(
                CGenTbChapterDirs.invalidDir(root, CGenTbChapter.CPT_VERIFC, CGenTbTestGen.TG_DECLARATION)));
    }

    @Test
    void filteredChapterCreatesOnlyThatPair(@TempDir Path root) throws Exception {
        CGenTbChapterDirs.ensureChapterValidInvalidDirs(root, CGenTbTestGen.TG_DECLARATION, CGenTbChapter.CPT_FIFO);
        assertTrue(Files.isDirectory(CGenTbChapterDirs.validDir(root, CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_DECLARATION)));
        assertEquals(2, Files.list(root).count());
    }

    @Test
    void ensureWritesRegressionControlInValidAndInvalidLeaves(@TempDir Path root) throws Exception {
        CGenTbChapterDirs.ensureChapterValidInvalidDirs(root, CGenTbTestGen.TG_DECLARATION, CGenTbChapter.CPT_FIFO);
        Path v = CGenTbChapterDirs.validDir(root, CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_DECLARATION);
        Path inv = CGenTbChapterDirs.invalidDir(root, CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.readString(v.resolve(CGenConsts.REGRESSION_CTRL_FILE_NAME)).contains("is_valid = 1"));
        assertTrue(Files.readString(inv.resolve(CGenConsts.REGRESSION_CTRL_FILE_NAME)).contains("is_valid = 0"));
    }

    @Test
    void purgeDeletesOnlyImmediateChildrenMatchingCgOrdinal(@TempDir Path root) throws Exception {
        Path match = Files.createDirectories(root.resolve("x_cg1_y"));
        Files.writeString(match.resolve("in.txt"), "a");
        Files.createFile(root.resolve("report_cg1"));
        Files.createDirectories(root.resolve("other"));
        CGenTbChapterDirs.purgeLeavesMatchingTestGen(root, CGenTbTestGen.TG_INSTANCE_DECLARATION);
        assertFalse(Files.exists(match));
        assertTrue(Files.isRegularFile(root.resolve("report_cg1")));
        assertTrue(Files.isDirectory(root.resolve("other")));
    }
}
