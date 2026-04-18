package com.fastpath.cslc.cslgen.cgentb;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.nio.file.Path;
import java.util.List;
import java.util.Objects;

/**
 * Minimal declaration emitter (Slice 2): generate a handful of real “legal” declaration files from {@link CGenTbSpecs} under
 * the legacy chapter {@code _valid} leaf dir for {@link CGenTbTestGen#TG_DECLARATION} and
 * {@link CGenTbTestGen#TG_INSTANCE_DECLARATION} (same layout, different {@code ETestGen} ordinal in dir names).
 */
public final class CGenTbDeclEmit {

    private CGenTbDeclEmit() {}

    private static boolean emitsDeclarationFiles(CGenTbTestGen tgType) {
        return tgType == CGenTbTestGen.TG_DECLARATION || tgType == CGenTbTestGen.TG_INSTANCE_DECLARATION;
    }

    public static void emitForRunContext(CGenTbRunContext ctx) {
        Objects.requireNonNull(ctx, "ctx");
        if (!emitsDeclarationFiles(ctx.tgType())) {
            return;
        }
        List<CGenTbClassSpec> specs = CGenTbSpecs.forChapter(ctx.chapterFilter());
        for (CGenTbClassSpec spec : specs) {
            emitSpec(ctx, spec);
        }
    }

    private static void emitSpec(CGenTbRunContext ctx, CGenTbClassSpec spec) {
        CGenTbContainers containers = CGenTbContainers.get();
        CGenTbChapter chapter = spec.chapter();
        Path dir = CGenTbChapterDirs.validDir(ctx.absoluteTestGenRoot(), chapter, ctx.tgType());

        int i = 0;
        List<String> preDeclBlocks = buildPreDeclBlocks(spec);
        for (CGenTbClassSpec.DeclVariant v : spec.legalDecls()) {
            if (preDeclBlocks.isEmpty()) {
                writeOne(ctx, containers, spec, dir, i, "", v.declText());
                i++;
                continue;
            }
            for (String pre : preDeclBlocks) {
                writeOne(ctx, containers, spec, dir, i, pre, v.declText());
                i++;
            }
        }
    }

    private static void writeOne(
            CGenTbRunContext ctx,
            CGenTbContainers containers,
            CGenTbClassSpec spec,
            Path dir,
            int i,
            String preDeclText,
            String declText) {
        String name =
                CGenConsts.LEGAL_TEST_FILE_NAME_PREFIX
                        + spec.kind().legacyGenericStem()
                        + "_"
                        + i
                        + CGenConsts.TEST_EXTENSION;
        Path f = dir.resolve(name);
        StringBuilder body = new StringBuilder();
        body.append(CGenConsts.VALID_TEST_HEADER);
        body.append("// Testing global object declaration as non-scope\n");
        body.append("// kind=")
                .append(spec.kind().name())
                .append(" obj=")
                .append(containers.legacyObj1Name(spec.kind()))
                .append('\n');
        if (!preDeclText.isEmpty()) {
            body.append(preDeclText);
            if (!preDeclText.endsWith("\n")) {
                body.append('\n');
            }
        }
        body.append(declText);
        CGenTbGeneratedFile.writeClosedUnchecked(f, body.toString(), ctx.binaryName(), ctx.testCounter());
    }

    private static List<String> buildPreDeclBlocks(CGenTbClassSpec spec) {
        if (spec.preDeclKinds().isEmpty()) {
            return List.of();
        }
        List<CGenTbClassSpec> preSpecs =
                spec.preDeclKinds().stream().map(CGenTbSpecs::specForKind).filter(Objects::nonNull).toList();
        if (preSpecs.size() != spec.preDeclKinds().size()) {
            // Unknown predecl kind(s) — treat as no predecls for now.
            return List.of();
        }
        List<Integer> sizes = preSpecs.stream().map(s -> s.legalDecls().size()).toList();
        List<int[]> indices = CGenTbPreDeclOrder.cartesianIndices(sizes);
        return indices.stream()
                .map(idx -> {
                    StringBuilder b = new StringBuilder();
                    for (int k = 0; k < idx.length; k++) {
                        CGenTbClassSpec.DeclVariant v = preSpecs.get(k).legalDecls().get(idx[k]);
                        b.append(v.declText());
                    }
                    return b.toString();
                })
                .toList();
    }
}

