package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.concurrent.atomic.AtomicInteger;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class CGenTbRunStubTest {

    @Test
    void runsBuildTestsOnlyWhenArgsOk() {
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                0,
                CGenTbRunStub.runAfterMainArgs(
                        new String[] {"tb"}, () -> n.incrementAndGet()));
        assertEquals(1, n.get());
    }

    @Test
    void skipsBuildTestsWhenArgsInvalid() {
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                1,
                CGenTbRunStub.runAfterMainArgs(
                        new String[] {"tb", "bad_chapter"}, () -> n.incrementAndGet()));
        assertEquals(0, n.get());
    }

    @Test
    void legacyRunChecksRunsBuildWhenRepositorySuppliedOk() {
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecks(
                        new String[] {"tb"},
                        () -> n.incrementAndGet(),
                        () -> CGenTbRepositoryPath.Outcome.success(Path.of("."))));
        assertEquals(1, n.get());
    }

    @Test
    void legacyRunChecksSkipsBuildWhenRepositoryFails() {
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                1,
                CGenTbRunStub.runAfterLegacyRunChecks(
                        new String[] {"tb"},
                        () -> n.incrementAndGet(),
                        () -> CGenTbRepositoryPath.Outcome.failure("no")));
        assertEquals(0, n.get());
    }

    @Test
    void legacyRunWithReportWritesCreateReportFile(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb"},
                        () -> n.incrementAndGet(),
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        assertEquals(1, n.get());
        Path report = CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(report));
        String body = Files.readString(report);
        assertTrue(body.contains("Executed cgen_decl_tb"));
        assertTrue(body.contains("Test count : 0\n"), () -> body);
    }

    @Test
    void legacyRunWithReportUsesTestCounterFromBuildTests(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        CGenTbTestCounter counter = new CGenTbTestCounter();
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"driver"},
                        () -> {
                            counter.increment();
                            counter.increment();
                        },
                        CGenTbTestGen.TG_DECLARATION,
                        counter,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 2\n"));
    }

    @Test
    void legacyRunWithDirsCreatesFilteredChapterLeaves(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithDirs(
                        new String[] {"tb", "fifo"},
                        () -> n.incrementAndGet(),
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        assertEquals(1, n.get());
        assertTrue(Files.isDirectory(CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_DECLARATION)));
        assertEquals(2, Files.list(gen).count());
    }

    @Test
    void legacyRunWithDirsDeclBuildTestsWritesMarker(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithDirs(
                        new String[] {"cgen_decl_tb", "fifo"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path marker = gen.resolve("tb_stub_tg_declaration_emit.csl");
        assertTrue(Files.isRegularFile(marker));
        assertTrue(Files.readString(marker).contains("//Gen : cgen_decl_tb"));
        Path legal =
                CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_DECLARATION)
                        .resolve("legal_test_fifo_0.csl");
        assertTrue(Files.isRegularFile(legal));
        // Immediate children are still just the two leaf dirs + marker file.
        assertEquals(3, Files.list(gen).count());
    }

    @Test
    void legacyRunWithReportDeclBuildTestsWritesMarkerAndTestCountOne(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "fifo"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        assertTrue(Files.isRegularFile(gen.resolve("tb_stub_tg_declaration_emit.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 2\n"));
    }

    @Test
    void legacyRunWithDirsPurgesStaleCgDirsBeforeEnsure(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        Path stale = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_DECLARATION);
        Files.createDirectories(stale);
        Files.writeString(stale.resolve("old.txt"), "x");
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithDirs(
                        new String[] {"tb", "fifo"},
                        () -> {},
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        assertTrue(Files.isDirectory(stale));
        assertFalse(Files.exists(stale.resolve("old.txt")));
    }

    @Test
    void legacyRunWithReportCreatesDirsBeforeReport(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"driver", "fifo"},
                        () -> {},
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        assertTrue(Files.isRegularFile(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION)));
        assertTrue(Files.isDirectory(CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_DECLARATION)));
    }
}
