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
    void legacyRunWithReportDeclBuildTestsLanguageChapterIncludesPredeclCombos(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "language"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path langValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_LANG, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_bitrange_0.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_field_0.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_enum_0.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_event_0.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_multi_dim_bitrange_0.csl")));
        // bitrange: 3, field: 1 x 3 predecl, enum: 1, event: 1, multi_dim_bitrange: 1, + marker = 10
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 10\n"));
    }

    @Test
    void legacyRunWithReportDeclBuildTestsInterconnectChapterIncludesPortAndSignal(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "interconnect"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path interValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_INTERCON, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_interface_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_port_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_signal_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_unit_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_unit_1.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_unit_2.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_signal_group_0.csl")));
        // interface: 1, port: 1, signal: 1, signal_group: 1, unit: 1 x 3 bitrange predecl + marker = 8
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 8\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsWritesMarkerAndCommandFiles(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "fifo"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        assertTrue(Files.isRegularFile(gen.resolve("tb_stub_tg_command_call_emit.csl")));
        Path fifoValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_FIFO, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(fifoValid.resolve("legal_test_fifo_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 2\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsLanguageChapterWritesBitrangeCalls(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "language"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path langValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_LANG, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_bitrange_0.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_bitrange_1.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_bitrange_2.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_field_0.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_field_2.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_event_0.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_multi_dim_bitrange_0.csl")));
        assertTrue(Files.isRegularFile(langValid.resolve("legal_test_multi_dim_bitrange_1.csl")));
        // bitrange: 3, field: 1 x 3, event: 1, multi_dim_bitrange: 2, + marker = 10
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 10\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsInterconnectChapterWritesSignalCalls(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "interconnect"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path interValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_INTERCON, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_interface_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_port_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_port_1.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_signal_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_signal_1.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_unit_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_unit_1.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_unit_2.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_signal_group_0.csl")));
        assertTrue(Files.isRegularFile(interValid.resolve("legal_test_signal_group_1.csl")));
        // interface: 1, port: 2, signal: 2, signal_group: 2, unit: 1 cmd x 3 bitrange predecl + marker = 11
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 11\n"));
    }

    @Test
    void legacyRunWithReportDeclBuildTestsTestbenchChapterWritesTestbenchDecl(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "testbench"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path testbValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_TESTB, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(testbValid.resolve("legal_test_testbench_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 2\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsTestbenchChapterWritesTestbenchCalls(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "testbench"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path testbValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_TESTB, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(testbValid.resolve("legal_test_testbench_0.csl")));
        assertTrue(Files.isRegularFile(testbValid.resolve("legal_test_testbench_1.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 3\n"));
    }

    @Test
    void legacyRunWithReportDeclBuildTestsMemoryChapterWritesMemoryDecl(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "memory"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path memValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_MEM, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(memValid.resolve("legal_test_memory_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 2\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsMemoryChapterMarkerOnly(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "memory"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 1\n"));
    }

    @Test
    void legacyRunWithReportDeclBuildTestsRegisterChapter(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "register"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path regValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_REG, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(regValid.resolve("legal_test_register_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 2\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsRegisterChapter(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "register"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path regValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_REG, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(regValid.resolve("legal_test_register_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 2\n"));
    }

    @Test
    void legacyRunWithReportDeclBuildTestsIsaChapterPredeclCombos(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "isa"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path isaValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_ISA, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(isaValid.resolve("legal_test_isa_field_0.csl")));
        assertTrue(Files.isRegularFile(isaValid.resolve("legal_test_isa_field_2.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 4\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsIsaChapterPredeclCombos(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "isa"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path isaValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_ISA, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(isaValid.resolve("legal_test_isa_field_0.csl")));
        assertTrue(Files.isRegularFile(isaValid.resolve("legal_test_isa_field_2.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 4\n"));
    }

    @Test
    void legacyRunWithReportDeclBuildTestsMemoryMapChapter(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "memory_map"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path mmValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_MEM_MAP, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(mmValid.resolve("legal_test_memory_map_0.csl")));
        assertTrue(Files.isRegularFile(mmValid.resolve("legal_test_memory_map_page_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 3\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsMemoryMapChapter(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "memory_map"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path mmValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_MEM_MAP, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(mmValid.resolve("legal_test_memory_map_0.csl")));
        assertTrue(Files.isRegularFile(mmValid.resolve("legal_test_memory_map_1.csl")));
        assertTrue(Files.isRegularFile(mmValid.resolve("legal_test_memory_map_page_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 4\n"));
    }

    @Test
    void legacyRunWithReportDeclBuildTestsRegisterFileChapter(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "register_file"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path rfValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_REG_FILE, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(rfValid.resolve("legal_test_register_file_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 2\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsRegisterFileChapter(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "register_file"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path rfValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_REG_FILE, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(rfValid.resolve("legal_test_register_file_0.csl")));
        assertTrue(Files.isRegularFile(rfValid.resolve("legal_test_register_file_1.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 3\n"));
    }

    @Test
    void legacyRunWithReportDeclBuildTestsVerificationComponentsChapter(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_decl_tb", "verification_components"},
                        CGenDeclTb::buildTests,
                        CGenTbTestGen.TG_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path vValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_VERIFC, CGenTbTestGen.TG_DECLARATION);
        assertTrue(Files.isRegularFile(vValid.resolve("legal_test_state_data_0.csl")));
        assertTrue(Files.isRegularFile(vValid.resolve("legal_test_vector_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_DECLARATION))
                .contains("Test count : 3\n"));
    }

    @Test
    void legacyRunWithReportCmdBuildTestsVerificationComponentsChapter(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_cmds_tb", "verification_components"},
                        CGenCmdTb::buildTests,
                        CGenTbTestGen.TG_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path vValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_VERIFC, CGenTbTestGen.TG_COMMAND_CALL);
        assertTrue(Files.isRegularFile(vValid.resolve("legal_test_state_data_0.csl")));
        assertTrue(Files.isRegularFile(vValid.resolve("legal_test_state_data_1.csl")));
        assertTrue(Files.isRegularFile(vValid.resolve("legal_test_vector_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_COMMAND_CALL))
                .contains("Test count : 4\n"));
    }

    @Test
    void legacyRunWithReportInstDeclBuildTestsMemoryMapWritesCg1Leaves(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_inst_decl_tb", "memory_map"},
                        CGenInstDeclTb::buildTests,
                        CGenTbTestGen.TG_INSTANCE_DECLARATION,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path mmValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_MEM_MAP, CGenTbTestGen.TG_INSTANCE_DECLARATION);
        assertTrue(Files.isRegularFile(mmValid.resolve("legal_test_memory_map_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_INSTANCE_DECLARATION))
                .contains("Test count : 3\n"));
    }

    @Test
    void legacyRunWithReportInstCmdBuildTestsVerificationComponentsWritesCg3Leaves(@TempDir Path tmp) throws Exception {
        Path gen = Files.createDirectories(tmp.resolve("test").resolve("csl_test_gen"));
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                        new String[] {"cgen_inst_cmds_tb", "verification_components"},
                        CGenInstCmdTb::buildTests,
                        CGenTbTestGen.TG_INSTANCE_COMMAND_CALL,
                        () -> CGenTbRepositoryPath.Outcome.success(gen)));
        Path vValid = CGenTbChapterDirs.validDir(gen, CGenTbChapter.CPT_VERIFC, CGenTbTestGen.TG_INSTANCE_COMMAND_CALL);
        assertTrue(Files.isRegularFile(vValid.resolve("legal_test_vector_0.csl")));
        assertTrue(Files.readString(CGenTbReport.reportFilePath(gen, CGenTbTestGen.TG_INSTANCE_COMMAND_CALL))
                .contains("Test count : 4\n"));
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
