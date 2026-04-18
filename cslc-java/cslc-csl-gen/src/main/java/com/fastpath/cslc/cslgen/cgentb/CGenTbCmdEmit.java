package com.fastpath.cslc.cslgen.cgentb;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.nio.file.Path;
import java.util.List;
import java.util.Objects;

/**
 * Minimal command-call emitter (Slice 3): generate a handful of real “legal” command-call files under the legacy chapter
 * {@code _valid} leaf dir for {@link CGenTbTestGen#TG_COMMAND_CALL} and {@link CGenTbTestGen#TG_INSTANCE_COMMAND_CALL}.
 *
 * <p>This does not attempt to fully match the legacy command legality matrix; it simply emits representative calls that
 * appear in {@code cGenBase_tb.cpp} for BITRANGE and FIFO.
 */
public final class CGenTbCmdEmit {

    private CGenTbCmdEmit() {}

    private static boolean emitsCommandCallFiles(CGenTbTestGen tgType) {
        return tgType == CGenTbTestGen.TG_COMMAND_CALL || tgType == CGenTbTestGen.TG_INSTANCE_COMMAND_CALL;
    }

    public static void emitForRunContext(CGenTbRunContext ctx) {
        Objects.requireNonNull(ctx, "ctx");
        if (!emitsCommandCallFiles(ctx.tgType())) {
            return;
        }
        List<CGenTbClassSpec> specs = CGenTbSpecs.forChapter(ctx.chapterFilter());
        for (CGenTbClassSpec spec : specs) {
            emitSpec(ctx, spec);
        }
    }

    private static void emitSpec(CGenTbRunContext ctx, CGenTbClassSpec spec) {
        if (spec.legalCmdCalls().isEmpty()) {
            return;
        }
        Path dir = CGenTbChapterDirs.validDir(ctx.absoluteTestGenRoot(), spec.chapter(), ctx.tgType());
        String obj = switch (spec.kind()) {
            case CSL_BITRANGE -> "br";
            case CSL_FIFO -> "f";
            case CSL_FIELD -> "fld";
            case CSL_PORT -> "p";
            case CSL_INTERFACE -> "ifc";
            case CSL_UNIT -> "u";
            case CSL_SIGNAL_GROUP -> "sg";
            case CSL_TESTBENCH -> "tb";
            case CSL_MEMORY -> "mem";
            case CSL_REGISTER -> "reg";
            case CSL_ISA_FIELD -> "isf";
            case CSL_MEMORY_MAP -> "mm";
            case CSL_MEMORY_MAP_PAGE -> "mmp";
            case CSL_REGISTER_FILE -> "rf";
            case CSL_STATE_DATA -> "sd";
            case CSL_VECTOR -> "vc";
            case CSL_EVENT -> "ev";
            case CSL_MULTI_DIM_BITRANGE -> "mdb";
            default -> "o";
        };

        String declPrefix = switch (spec.kind()) {
            case CSL_BITRANGE -> "csl_bitrange " + obj + "(" + CGenConsts.WIDTH_DEFAULT + ");\n";
            case CSL_FIFO -> "csl_fifo "
                    + obj
                    + ";\n"
                    + obj
                    + ".set_depth("
                    + CGenConsts.DEPTH_DEFAULT
                    + ");\n"
                    + obj
                    + ".set_width("
                    + CGenConsts.WIDTH_DEFAULT
                    + ");\n";
            case CSL_FIELD -> "csl_field " + obj + "(" + CGenConsts.WIDTH_DEFAULT + ");\n";
            case CSL_PORT -> "csl_port " + obj + "(inout);\n";
            case CSL_INTERFACE -> "csl_interface " + obj + ";\n";
            case CSL_UNIT -> "csl_unit " + obj + " {\n};\n";
            case CSL_SIGNAL_GROUP -> "csl_signal_group "
                    + obj
                    + " {\n  csl_signal "
                    + obj
                    + "_sig("
                    + CGenConsts.WIDTH_DEFAULT
                    + ");\n};\n";
            case CSL_TESTBENCH -> "csl_testbench " + obj + ";\n";
            case CSL_MEMORY -> "csl_memory "
                    + obj
                    + ";\n"
                    + obj
                    + ".set_depth("
                    + CGenConsts.DEPTH_DEFAULT
                    + ");\n"
                    + obj
                    + ".set_width("
                    + CGenConsts.WIDTH_DEFAULT
                    + ");\n";
            case CSL_REGISTER -> "csl_register " + obj + ";\n";
            case CSL_ISA_FIELD -> "csl_isa_field "
                    + obj
                    + "("
                    + CGenConsts.WIDTH_DEFAULT
                    + ");\n"
                    + obj
                    + ".set_width("
                    + CGenConsts.WIDTH_DEFAULT
                    + ");\n"
                    + obj
                    + ".set_type(opcode);\n";
            case CSL_MEMORY_MAP -> "csl_memory_map " + obj + ";\n";
            case CSL_MEMORY_MAP_PAGE -> "csl_memory_map_page " + obj + ";\n";
            case CSL_REGISTER_FILE -> "csl_register_file "
                    + obj
                    + ";\n"
                    + obj
                    + ".set_depth("
                    + CGenConsts.DEPTH_DEFAULT
                    + ");\n"
                    + obj
                    + ".set_width("
                    + CGenConsts.WIDTH_DEFAULT
                    + ");\n";
            case CSL_STATE_DATA -> "csl_state_data " + obj + ";\n";
            case CSL_VECTOR -> "csl_vector " + obj + ";\n";
            case CSL_EVENT -> "csl_event " + obj + ";\n";
            case CSL_MULTI_DIM_BITRANGE -> "csl_multi_dim_bitrange " + obj + "(" + CGenConsts.DIMENSION_DEFAULT + ");\n";
            default -> "";
        };

        List<String> preDeclBlocks = buildPreDeclBlocks(spec);
        int i = 0;
        for (CGenTbClassSpec.CmdVariant v : spec.legalCmdCalls()) {
            if (preDeclBlocks.isEmpty()) {
                Path f =
                        dir.resolve(
                                CGenConsts.LEGAL_TEST_FILE_NAME_PREFIX
                                        + spec.kind().legacyGenericStem()
                                        + "_"
                                        + i
                                        + CGenConsts.TEST_EXTENSION);
                write(
                        ctx,
                        f,
                        "//Testing non-scope-holder object command call on global scope\n" + declPrefix + v.cmdBodyText());
                i++;
                continue;
            }
            for (String pre : preDeclBlocks) {
                Path f =
                        dir.resolve(
                                CGenConsts.LEGAL_TEST_FILE_NAME_PREFIX
                                        + spec.kind().legacyGenericStem()
                                        + "_"
                                        + i
                                        + CGenConsts.TEST_EXTENSION);
                write(
                        ctx,
                        f,
                        "//Testing non-scope-holder object command call on global scope\n"
                                + pre
                                + declPrefix
                                + v.cmdBodyText());
                i++;
            }
        }
    }

    private static List<String> buildPreDeclBlocks(CGenTbClassSpec spec) {
        if (spec.preDeclKinds().isEmpty()) {
            return List.of();
        }
        List<CGenTbClassSpec> preSpecs =
                spec.preDeclKinds().stream().map(CGenTbSpecs::specForKind).filter(Objects::nonNull).toList();
        if (preSpecs.size() != spec.preDeclKinds().size()) {
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

    private static void write(CGenTbRunContext ctx, Path f, String body) {
        StringBuilder out = new StringBuilder();
        out.append(CGenConsts.VALID_TEST_HEADER);
        out.append(body);
        CGenTbGeneratedFile.writeClosedUnchecked(f, out.toString(), ctx.binaryName(), ctx.testCounter());
    }
}

