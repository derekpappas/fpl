package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Random;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class CslGenAoBatchTest {

    @Test
    void writeCslFilesCreatesGenTestsAndOutFiles(@TempDir Path tmp) throws Exception {
        CslGenAoBatch.writeCslFiles(tmp, 2, new Random(9L));
        Path gen = tmp.resolve(CslGenAoBatch.GEN_TESTS_DIR_NAME);
        assertTrue(Files.isDirectory(gen));
        Path out0 = gen.resolve("out0" + CGenConsts.TEST_EXTENSION);
        Path out1 = gen.resolve("out1" + CGenConsts.TEST_EXTENSION);
        assertTrue(Files.isRegularFile(out0));
        assertTrue(Files.isRegularFile(out1));
        String text = Files.readString(out0);
        assertTrue(text.contains("//Automatically generated"));
        CslGenAoBatch.writeCslFiles(tmp, 2, new Random(9L));
        assertEquals(text, Files.readString(out0), "same seed → same out0 contents");
    }

    @Test
    void legalAndIllegalPrefixesMatchCGenAoCpp() {
        assertEquals("legal_test_", CGenConsts.LEGAL_TEST_FILE_NAME_PREFIX);
        assertEquals("illegal_test_", CGenConsts.ILLEGAL_TEST_FILE_NAME_PREFIX);
    }
}
