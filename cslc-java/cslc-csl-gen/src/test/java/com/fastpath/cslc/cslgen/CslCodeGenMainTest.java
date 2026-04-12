package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import java.util.random.RandomGenerator;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class CslCodeGenMainTest {

    @Test
    void createRngWithSeedUsesJavaRandom() {
        RandomGenerator rng = CslCodeGenMain.createRng(42L);
        assertInstanceOf(Random.class, rng);
    }

    @Test
    void createRngWithoutSeedUsesThreadLocalRandom() {
        RandomGenerator rng = CslCodeGenMain.createRng(null);
        assertInstanceOf(ThreadLocalRandom.class, rng);
    }

    @Test
    void seededDesignBuildDeclIsDeterministic() {
        String a = buildPrinted(new Random(12345L));
        String b = buildPrinted(new Random(12345L));
        assertNotEquals("", a);
        assertEquals(a, b);
    }

    @Test
    void mainAoBatchFlagWritesFiles(@TempDir Path tmp) throws Exception {
        CslCodeGenMain.main(new String[] {"--seed", "2", "--ao-batch", tmp.toString(), "1"});
        Path out0 = tmp.resolve(CslGenAoBatch.GEN_TESTS_DIR_NAME).resolve("out0" + CGenConsts.TEST_EXTENSION);
        assertTrue(Files.isRegularFile(out0));
        assertTrue(Files.readString(out0).contains("//Automatically generated"));
    }

    private static String buildPrinted(RandomGenerator rng) {
        CslGenDesign design = new CslGenDesign("design");
        design.buildDecl(rng);
        StringBuilder out = new StringBuilder();
        design.appendPrintedCsl(out);
        return out.toString();
    }
}
