package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.concurrent.TimeUnit;
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
    void parseCliSeedMissingValueReturnsError() {
        CslCodeGenMain.CliParseResult r = CslCodeGenMain.parseCli(new String[] {"--seed"});
        assertTrue(r.hasError());
        assertTrue(r.errorMessage().contains("--seed requires"), r.errorMessage());
    }

    @Test
    void parseCliInvalidSeedReturnsError() {
        CslCodeGenMain.CliParseResult r = CslCodeGenMain.parseCli(new String[] {"--seed", "x"});
        assertTrue(r.hasError());
        assertTrue(r.errorMessage().contains("invalid --seed"), r.errorMessage());
    }

    @Test
    void parseCliAoBatchMissingDirReturnsError() {
        CslCodeGenMain.CliParseResult r = CslCodeGenMain.parseCli(new String[] {"--ao-batch"});
        assertTrue(r.hasError());
        assertTrue(r.errorMessage().contains("--ao-batch requires"), r.errorMessage());
    }

    @Test
    void parseCliAoBatchNegativeCountReturnsError(@TempDir Path tmp) {
        CslCodeGenMain.CliParseResult r =
                CslCodeGenMain.parseCli(new String[] {"--ao-batch", tmp.toString(), "-1"});
        assertTrue(r.hasError());
        assertTrue(r.errorMessage().contains("count must be >= 0"), r.errorMessage());
    }

    @Test
    void parseCliAoBatchInvalidCountReturnsError(@TempDir Path tmp) {
        CslCodeGenMain.CliParseResult r =
                CslCodeGenMain.parseCli(new String[] {"--ao-batch", tmp.toString(), "bogus"});
        assertTrue(r.hasError());
        assertTrue(r.errorMessage().contains("invalid --ao-batch count"), r.errorMessage());
    }

    @Test
    void parseCliAoBatchCountParsedAfterDir(@TempDir Path tmp) {
        CslCodeGenMain.CliParseResult r =
                CslCodeGenMain.parseCli(new String[] {"--ao-batch", tmp.toString(), "2"});
        assertFalse(r.hasError());
        assertFalse(r.help());
        assertEquals(2, r.aoBatchCount());
    }

    @Test
    void parseCliAoBatchDirFollowedByFlagLeavesCountUnset(@TempDir Path tmp) {
        CslCodeGenMain.CliParseResult r =
                CslCodeGenMain.parseCli(new String[] {"--ao-batch", tmp.toString(), "--print"});
        assertFalse(r.hasError());
        assertTrue(r.print());
        assertEquals(null, r.aoBatchCount());
    }

    @Test
    void parseCliHelpStopsFurtherOptions() {
        CslCodeGenMain.CliParseResult r =
                CslCodeGenMain.parseCli(new String[] {"--help", "--seed", "1"});
        assertTrue(r.help());
    }

    @Test
    void runFromParsedBatchWhenBasePathIsFileThrowsIOException(@TempDir Path tmp) throws Exception {
        Path blocker = tmp.resolve("not-a-directory");
        Files.writeString(blocker, "x");
        CslCodeGenMain.CliParseResult r = CslCodeGenMain.CliParseResult.ok(false, 1L, blocker, 1);
        assertThrows(IOException.class, () -> CslCodeGenMain.runFromParsed(r));
    }

    @Test
    void runFromParsedSingleArgOverloadWritesToSystemOut() throws Exception {
        PrintStream prev = System.out;
        ByteArrayOutputStream capture = new ByteArrayOutputStream();
        System.setOut(new PrintStream(capture, true, StandardCharsets.UTF_8));
        try {
            CslCodeGenMain.runFromParsed(CslCodeGenMain.CliParseResult.ok(true, 5L, null, null));
        } finally {
            System.setOut(prev);
        }
        assertTrue(
                capture.toString(StandardCharsets.UTF_8).contains("//Automatically generated"),
                "one-arg runFromParsed should delegate to System.out");
    }

    @Test
    void runMainBodyHelpReturnsZeroAndWritesUsage() {
        ByteArrayOutputStream errBaos = new ByteArrayOutputStream();
        PrintStream errPs = new PrintStream(errBaos, true, StandardCharsets.UTF_8);
        PrintStream nullOut = new PrintStream(OutputStream.nullOutputStream(), true, StandardCharsets.UTF_8);
        assertEquals(0, CslCodeGenMain.runMainBody(new String[] {"-h"}, errPs, nullOut));
        assertTrue(errBaos.toString(StandardCharsets.UTF_8).contains("Usage:"));
    }

    @Test
    void runMainBodyParseErrorReturnsOne() {
        ByteArrayOutputStream errBaos = new ByteArrayOutputStream();
        PrintStream errPs = new PrintStream(errBaos, true, StandardCharsets.UTF_8);
        PrintStream nullOut = new PrintStream(OutputStream.nullOutputStream(), true, StandardCharsets.UTF_8);
        assertEquals(1, CslCodeGenMain.runMainBody(new String[] {"--seed"}, errPs, nullOut));
        assertTrue(errBaos.toString(StandardCharsets.UTF_8).contains("--seed requires"));
    }

    @Test
    void runMainBodyBatchIOExceptionReturnsOne(@TempDir Path tmp) throws Exception {
        Path blocker = tmp.resolve("file-not-dir");
        Files.writeString(blocker, "x");
        ByteArrayOutputStream errBaos = new ByteArrayOutputStream();
        PrintStream errPs = new PrintStream(errBaos, true, StandardCharsets.UTF_8);
        PrintStream nullOut = new PrintStream(OutputStream.nullOutputStream(), true, StandardCharsets.UTF_8);
        assertEquals(
                1,
                CslCodeGenMain.runMainBody(
                        new String[] {"--seed", "1", "--ao-batch", blocker.toString(), "1"}, errPs, nullOut));
        assertTrue(errBaos.toString(StandardCharsets.UTF_8).contains("batch write failed"));
    }

    @Test
    void runMainBodyPrintWritesToGivenStream() {
        ByteArrayOutputStream outBaos = new ByteArrayOutputStream();
        PrintStream outPs = new PrintStream(outBaos, true, StandardCharsets.UTF_8);
        PrintStream nullErr = new PrintStream(OutputStream.nullOutputStream(), true, StandardCharsets.UTF_8);
        assertEquals(0, CslCodeGenMain.runMainBody(new String[] {"--print", "--seed", "3"}, nullErr, outPs));
        assertTrue(outBaos.toString(StandardCharsets.UTF_8).contains("//Automatically generated"));
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

    @Test
    void mainWithPrintWritesCslToStdout() {
        PrintStream prev = System.out;
        ByteArrayOutputStream capture = new ByteArrayOutputStream();
        System.setOut(new PrintStream(capture, true, StandardCharsets.UTF_8));
        try {
            CslCodeGenMain.main(new String[] {"--print", "--seed", "7"});
        } finally {
            System.setOut(prev);
        }
        String out = capture.toString(StandardCharsets.UTF_8);
        assertTrue(out.contains("//Automatically generated"), out);
    }

    @Test
    void mainShortPrintFlagWritesCslToStdout() {
        PrintStream prev = System.out;
        ByteArrayOutputStream capture = new ByteArrayOutputStream();
        System.setOut(new PrintStream(capture, true, StandardCharsets.UTF_8));
        try {
            CslCodeGenMain.main(new String[] {"-p", "--seed", "7"});
        } finally {
            System.setOut(prev);
        }
        String out = capture.toString(StandardCharsets.UTF_8);
        assertTrue(out.contains("//Automatically generated"), out);
    }

    @Test
    void mainWithoutPrintLeavesStdoutEmpty() {
        PrintStream prev = System.out;
        ByteArrayOutputStream capture = new ByteArrayOutputStream();
        System.setOut(new PrintStream(capture, true, StandardCharsets.UTF_8));
        try {
            CslCodeGenMain.main(new String[] {"--seed", "7"});
        } finally {
            System.setOut(prev);
        }
        assertEquals("", capture.toString(StandardCharsets.UTF_8));
    }

    @Test
    void mainHelpWritesUsageToStderr() {
        PrintStream prev = System.err;
        ByteArrayOutputStream capture = new ByteArrayOutputStream();
        System.setErr(new PrintStream(capture, true, StandardCharsets.UTF_8));
        try {
            CslCodeGenMain.main(new String[] {"--help"});
        } finally {
            System.setErr(prev);
        }
        String err = capture.toString(StandardCharsets.UTF_8);
        assertTrue(err.contains("Usage:"), err);
        assertTrue(err.contains("--print"), err);
    }

    @Test
    void mainShortHelpWritesUsageToStderr() {
        PrintStream prev = System.err;
        ByteArrayOutputStream capture = new ByteArrayOutputStream();
        System.setErr(new PrintStream(capture, true, StandardCharsets.UTF_8));
        try {
            CslCodeGenMain.main(new String[] {"-h"});
        } finally {
            System.setErr(prev);
        }
        String err = capture.toString(StandardCharsets.UTF_8);
        assertTrue(err.contains("Usage:"), err);
    }

    @Test
    void subprocessMainSeedWithoutValueExitsOne() throws Exception {
        MainProcResult r = runMainInSubprocess("--seed");
        assertEquals(1, r.exit);
        assertTrue(r.err.contains("--seed requires"), r.err);
    }

    @Test
    void subprocessMainInvalidSeedExitsOne() throws Exception {
        MainProcResult r = runMainInSubprocess("--seed", "not-a-long");
        assertEquals(1, r.exit);
        assertTrue(r.err.contains("invalid --seed"), r.err);
    }

    @Test
    void subprocessMainAoBatchWithoutDirExitsOne() throws Exception {
        MainProcResult r = runMainInSubprocess("--ao-batch");
        assertEquals(1, r.exit);
        assertTrue(r.err.contains("--ao-batch requires"), r.err);
    }

    @Test
    void subprocessMainAoBatchInvalidCountExitsOne(@TempDir Path tmp) throws Exception {
        MainProcResult r = runMainInSubprocess("--seed", "1", "--ao-batch", tmp.toString(), "bogus");
        assertEquals(1, r.exit);
        assertTrue(r.err.contains("invalid --ao-batch count"), r.err);
    }

    @Test
    void subprocessMainAoBatchNegativeCountExitsOne(@TempDir Path tmp) throws Exception {
        MainProcResult r = runMainInSubprocess("--seed", "1", "--ao-batch", tmp.toString(), "-1");
        assertEquals(1, r.exit);
        assertTrue(r.err.contains("count must be >= 0"), r.err);
    }

    @Test
    void subprocessMainAoBatchWhenBasePathIsFileExitsOne(@TempDir Path tmp) throws Exception {
        Path blocker = tmp.resolve("not-a-directory");
        Files.writeString(blocker, "x");
        MainProcResult r = runMainInSubprocess("--seed", "1", "--ao-batch", blocker.toString(), "1");
        assertEquals(1, r.exit);
        assertTrue(r.err.contains("batch write failed"), r.err);
    }

    private static MainProcResult runMainInSubprocess(String... args) throws Exception {
        List<String> cmd = new ArrayList<>();
        cmd.add(Path.of(System.getProperty("java.home"), "bin", "java").toString());
        cmd.add("-cp");
        cmd.add(System.getProperty("java.class.path"));
        cmd.add("com.fastpath.cslc.cslgen.CslCodeGenMain");
        cmd.addAll(Arrays.asList(args));
        ProcessBuilder pb = new ProcessBuilder(cmd);
        pb.redirectError(ProcessBuilder.Redirect.PIPE);
        pb.redirectOutput(ProcessBuilder.Redirect.PIPE);
        Process p = pb.start();
        String out = new String(p.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
        String err = new String(p.getErrorStream().readAllBytes(), StandardCharsets.UTF_8);
        assertTrue(p.waitFor(120, TimeUnit.SECONDS), "CslCodeGenMain subprocess did not finish");
        return new MainProcResult(p.exitValue(), out, err);
    }

    private record MainProcResult(int exit, String out, String err) {}

    private static String buildPrinted(RandomGenerator rng) {
        CslGenDesign design = new CslGenDesign("design");
        design.buildDecl(rng);
        StringBuilder out = new StringBuilder();
        design.appendPrintedCsl(out);
        return out.toString();
    }
}
