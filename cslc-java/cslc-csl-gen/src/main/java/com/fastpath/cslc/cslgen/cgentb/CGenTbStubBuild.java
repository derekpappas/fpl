package com.fastpath.cslc.cslgen.cgentb;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.nio.file.Path;

/**
 * Shared stub {@code buildTests} helpers: when {@link CGenTbRunStub} has installed a {@link CGenTbRunContext}, emit one closed
 * marker file so {@link CGenTbTestCounter} matches legacy {@code closeFile} behavior for driver smoke tests. Newer stubs
 * also iterate over all {@link CGenTbEslClass} in the selected {@link CGenTbChapter} filter to approximate the chapter-scoped
 * generation loops.
 */
public final class CGenTbStubBuild {

    private CGenTbStubBuild() {}

    /**
     * Writes only the legacy-style marker file {@code tb_stub_<tgType>_emit.csl} under the test-gen root when a
     * {@link CGenTbRunContext} is installed.
     */
    public static void emitMarkerOnlyIfRunContext() {
        CGenTbRunContext.current()
                .ifPresent(ctx -> {
                    Path marker =
                            ctx.absoluteTestGenRoot().resolve("tb_stub_" + ctx.tgType().name().toLowerCase() + "_emit.csl");
                    CGenTbGeneratedFile.writeClosedUnchecked(
                            marker, "// TB stub marker\n", ctx.binaryName(), ctx.testCounter());
                });
    }

    /**
     * If {@link CGenTbRunContext#current()} is present, writes one {@code legal_test_*} file per class in the selected chapter
     * (or all classes when {@link CGenTbChapter#CPT_ALL}), then also writes {@code tb_stub_<tgType>_emit.csl} under the test-gen
     * root. Each output file uses {@link CGenTbGeneratedFile} so {@link CGenTbTestCounter} matches legacy {@code closeFile}.
     */
    public static void emitDefaultMarkerIfRunContext() {
        CGenTbRunContext.current()
                .ifPresent(ctx -> {
                    CGenTbContainers c = CGenTbContainers.get();
                    for (CGenTbEslClass kind : CGenTbEslClass.values()) {
                        CGenTbChapter ch = c.chapterForEslClass(kind);
                        if (ch == null) {
                            continue;
                        }
                        if (ctx.chapterFilter() != CGenTbChapter.CPT_ALL && ch != ctx.chapterFilter()) {
                            continue;
                        }
                        Path dir = CGenTbChapterDirs.validDir(ctx.absoluteTestGenRoot(), ch, ctx.tgType());
                        String name =
                                CGenConsts.LEGAL_TEST_FILE_NAME_PREFIX
                                        + kind.legacyGenericStem()
                                        + "_"
                                        + ctx.tgType().ordinal()
                                        + CGenConsts.TEST_EXTENSION;
                        Path f = dir.resolve(name);
                        String body =
                                "// stub class="
                                        + kind.name()
                                        + " obj="
                                        + c.legacyObjName(kind)
                                        + " param="
                                        + c.legacyParamName(kind)
                                        + "\n";
                        CGenTbGeneratedFile.writeClosedUnchecked(f, body, ctx.binaryName(), ctx.testCounter());
                    }
                    emitMarkerOnlyIfRunContext();
                });
    }
}
