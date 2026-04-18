package com.fastpath.cslc.cslgen.cgentb;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.util.List;

/** Small curated set of class specs for decl/cmd emission (by {@link CGenTbChapter}). */
public final class CGenTbSpecs {

    private CGenTbSpecs() {}

    public static List<CGenTbClassSpec> all() {
        return List.of(
                bitrange(),
                field(),
                enum_(),
                event(),
                multiDimBitrange(),
                port(),
                signal(),
                signalGroup(),
                interface_(),
                unit(),
                fifo(),
                memory(),
                register(),
                isaField(),
                memoryMap(),
                memoryMapPage(),
                registerFile(),
                stateData(),
                vector(),
                testbench());
    }

    public static CGenTbClassSpec specForKind(CGenTbEslClass kind) {
        for (CGenTbClassSpec s : all()) {
            if (s.kind() == kind) {
                return s;
            }
        }
        return null;
    }

    public static List<CGenTbClassSpec> forChapter(CGenTbChapter filter) {
        if (filter == CGenTbChapter.CPT_ALL) {
            return all();
        }
        return all().stream().filter(s -> s.chapter() == filter).toList();
    }

    /**
     * From legacy {@code buildBitrange()} decl rows:
     *
     * <ul>
     *   <li>{@code csl_bitrange br(WIDTH_DEFAULT);}
     *   <li>{@code csl_bitrange br(LSB_DEFAULT, MSB_DEFAULT);}
     *   <li>{@code csl_bitrange br(csl_bitrange(WIDTH_DEFAULT));} (object-decl param)
     * </ul>
     *
     * We keep the emission simple text; correctness is “shape”, not CSL parser validation.
     */
    private static CGenTbClassSpec bitrange() {
        String br = "br";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_BITRANGE,
                CGenTbChapter.CPT_LANG,
                List.of(),
                List.of(
                        new CGenTbClassSpec.DeclVariant(
                                "w",
                                "csl_bitrange " + br + "(" + CGenConsts.WIDTH_DEFAULT + ");\n"),
                        new CGenTbClassSpec.DeclVariant(
                                "lsb_msb",
                                "csl_bitrange " + br + "(" + CGenConsts.LSB_DEFAULT + ", " + CGenConsts.MSB_DEFAULT + ");\n"),
                        new CGenTbClassSpec.DeclVariant(
                                "obj",
                                "csl_bitrange " + br + "(csl_bitrange(" + CGenConsts.WIDTH_DEFAULT + "));\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant("get_lower", br + ".get_lower();\n"),
                        new CGenTbClassSpec.CmdVariant(
                                "set_offset",
                                br + ".set_offset(" + CGenConsts.OFFSET_DEFAULT + ");\n"),
                        new CGenTbClassSpec.CmdVariant("get_upper", br + ".get_upper();\n")));
    }

    /**
     * From legacy {@code buildField()}:
     *
     * <ul>
     *   <li>mandatory cmd: {@code set_width(WIDTH_DEFAULT)}
     *   <li>decl rows include {@code (WIDTH_DEFAULT)} and {@code (LSB_DEFAULT,MSB_DEFAULT)} etc
     * </ul>
     *
     * For Slice 4 we only model one decl variant and a single pre-decl kind (BITRANGE) to exercise predecl ordering.
     */
    private static CGenTbClassSpec field() {
        String f = "fld";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_FIELD,
                CGenTbChapter.CPT_LANG,
                List.of(CGenTbEslClass.CSL_BITRANGE),
                List.of(
                        new CGenTbClassSpec.DeclVariant(
                                "w",
                                "csl_field " + f + "(" + CGenConsts.WIDTH_DEFAULT + ");\n"
                                        + f + ".set_width(" + CGenConsts.WIDTH_DEFAULT + ");\n")),
                List.of(new CGenTbClassSpec.CmdVariant("get_width", f + ".get_width();\n")));
    }

    /**
     * From legacy {@code buildEnum()} ({@code CPT_LANG}): declaration uses an {@code CSLEnumItem} parameter row (shape-only
     * here).
     */
    private static CGenTbClassSpec enum_() {
        String en = "en";
        String item = en + "_lit";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_ENUM,
                CGenTbChapter.CPT_LANG,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("one_item", "csl_enum " + en + " {\n  " + item + "\n};\n")),
                List.of());
    }

    /**
     * From legacy {@code buildEvent()} ({@code CPT_LANG}): cmd {@code add_equation(CONST_ONE)} (no decl param rows in legacy
     * snippet).
     */
    private static CGenTbClassSpec event() {
        String ev = "ev";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_EVENT,
                CGenTbChapter.CPT_LANG,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_event " + ev + ";\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant(
                                "add_equation", ev + ".add_equation(" + CGenConsts.CONST_ONE + ");\n")));
    }

    /**
     * From legacy {@code buildMultiDimBitrange()} ({@code CPT_LANG}): dimension decl and several {@code get_dim_*} cmds.
     */
    private static CGenTbClassSpec multiDimBitrange() {
        String mdb = "mdb";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_MULTI_DIM_BITRANGE,
                CGenTbChapter.CPT_LANG,
                List.of(),
                List.of(
                        new CGenTbClassSpec.DeclVariant(
                                "dim", "csl_multi_dim_bitrange " + mdb + "(" + CGenConsts.DIMENSION_DEFAULT + ");\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant("get_dim_width", mdb + ".get_dim_width();\n"),
                        new CGenTbClassSpec.CmdVariant("get_dim_lower", mdb + ".get_dim_lower();\n")));
    }

    /**
     * From legacy {@code buildFifo()} mandatory cmds:
     *
     * <ul>
     *   <li>{@code set_depth(DEPTH_DEFAULT)}
     *   <li>{@code set_width(WIDTH_DEFAULT)}
     * </ul>
     *
     * We emit a single “legal declaration” variant that includes these calls after the declaration.
     */
    private static CGenTbClassSpec fifo() {
        String f = "f";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_FIFO,
                CGenTbChapter.CPT_FIFO,
                List.of(),
                List.of(
                        new CGenTbClassSpec.DeclVariant(
                                "mand",
                                "csl_fifo " + f + ";\n"
                                        + f + ".set_depth(" + CGenConsts.DEPTH_DEFAULT + ");\n"
                                        + f + ".set_width(" + CGenConsts.WIDTH_DEFAULT + ");\n")),
                List.of(new CGenTbClassSpec.CmdVariant("add_logic_async_reset", f + ".add_logic(async_reset);\n")));
    }

    /**
     * From legacy {@code buildMemory()} ({@code CPT_MEM}): mandatory {@code set_depth} / {@code set_width} (same shape as
     * {@link #fifo()}).
     */
    private static CGenTbClassSpec memory() {
        String m = "mem";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_MEMORY,
                CGenTbChapter.CPT_MEM,
                List.of(),
                List.of(
                        new CGenTbClassSpec.DeclVariant(
                                "mand",
                                "csl_memory "
                                        + m
                                        + ";\n"
                                        + m
                                        + ".set_depth("
                                        + CGenConsts.DEPTH_DEFAULT
                                        + ");\n"
                                        + m
                                        + ".set_width("
                                        + CGenConsts.WIDTH_DEFAULT
                                        + ");\n")),
                List.of());
    }

    /**
     * From legacy {@code buildRegister()} ({@code CPT_REG}): minimal global decl plus a simple getter cmd.
     */
    private static CGenTbClassSpec register() {
        String r = "reg";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_REGISTER,
                CGenTbChapter.CPT_REG,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_register " + r + ";\n")),
                List.of(new CGenTbClassSpec.CmdVariant("get_attributes", r + ".get_attributes();\n")));
    }

    /**
     * From legacy {@code buildIsaField()} ({@code CPT_ISA}): mandatory {@code set_width} / {@code set_type(opcode)} after
     * width decl; global BITRANGE predecl like {@link #field()}.
     */
    private static CGenTbClassSpec isaField() {
        String isf = "isf";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_ISA_FIELD,
                CGenTbChapter.CPT_ISA,
                List.of(CGenTbEslClass.CSL_BITRANGE),
                List.of(
                        new CGenTbClassSpec.DeclVariant(
                                "w",
                                "csl_isa_field " + isf + "(" + CGenConsts.WIDTH_DEFAULT + ");\n"
                                        + isf + ".set_width(" + CGenConsts.WIDTH_DEFAULT + ");\n"
                                        + isf + ".set_type(opcode);\n")),
                List.of(new CGenTbClassSpec.CmdVariant("get_width", isf + ".get_width();\n")));
    }

    /**
     * From legacy {@code buildSignal()} decl rows:
     * empty params, width, lsb/msb, bitrange object, signal object.
     *
     * <p>For now we model only the width decl, and a couple simple get* cmds.
     */
    private static CGenTbClassSpec signal() {
        String s = "sig";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_SIGNAL,
                CGenTbChapter.CPT_INTERCON,
                List.of(),
                List.of(
                        new CGenTbClassSpec.DeclVariant(
                                "w",
                                "csl_signal " + s + "(" + CGenConsts.WIDTH_DEFAULT + ");\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant("get_width", s + ".get_width();\n"),
                        new CGenTbClassSpec.CmdVariant("get_offset", s + ".get_offset();\n")));
    }

    /**
     * From legacy {@code buildSigGroup()} (CPT_INTERCON): scope-holder with {@code generate_individual_rtl_signals(off/on)}.
     *
     * <p>Legacy {@code addMandatoryObj(CSL_SIGNAL)}: at least one {@code csl_signal} inside the group body.
     */
    private static CGenTbClassSpec signalGroup() {
        String sg = "sg";
        String mandatorySig = sg + "_sig";
        String body =
                "csl_signal_group "
                        + sg
                        + " {\n  csl_signal "
                        + mandatorySig
                        + "("
                        + CGenConsts.WIDTH_DEFAULT
                        + ");\n};\n";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_SIGNAL_GROUP,
                CGenTbChapter.CPT_INTERCON,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("with_mandatory_signal", body)),
                List.of(
                        new CGenTbClassSpec.CmdVariant(
                                "gen_rtl_off", sg + ".generate_individual_rtl_signals(off);\n"),
                        new CGenTbClassSpec.CmdVariant(
                                "gen_rtl_on", sg + ".generate_individual_rtl_signals(on);\n")));
    }

    /**
     * From legacy {@code buildPort()} decl rows: one keyword {@code inout}.
     *
     * <p>Slice: minimal decl + a couple simple cmd calls.
     */
    private static CGenTbClassSpec port() {
        String p = "p";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_PORT,
                CGenTbChapter.CPT_INTERCON,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("inout", "csl_port " + p + "(inout);\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant("get_width", p + ".get_width();\n"),
                        new CGenTbClassSpec.CmdVariant(
                                "set_offset", p + ".set_offset(" + CGenConsts.OFFSET_DEFAULT + ");\n")));
    }

    /**
     * From legacy {@code buildInterface()} (CPT_INTERCON): has {@code reverse} cmd (instance call).
     *
     * <p>Slice: minimal decl + a single cmd.
     */
    private static CGenTbClassSpec interface_() {
        String i = "ifc";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_INTERFACE,
                CGenTbChapter.CPT_INTERCON,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_interface " + i + ";\n")),
                List.of(new CGenTbClassSpec.CmdVariant("reverse", i + ".reverse();\n")));
    }

    /**
     * From legacy {@code buildUnit()} (CPT_INTERCON): scope-holder; legal inner decls include bitrange/signal/port, etc.
     *
     * <p>We use {@code CSL_BITRANGE} in {@link #preDeclKinds()} (like {@link #field()}) so decl/cmd emission walks the
     * same global predecl cartesian order as other interconnect slices.
     */
    private static CGenTbClassSpec unit() {
        String u = "u";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_UNIT,
                CGenTbChapter.CPT_INTERCON,
                List.of(CGenTbEslClass.CSL_BITRANGE),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_unit " + u + " {\n};\n")),
                List.of(new CGenTbClassSpec.CmdVariant("get_unit_prefix", u + ".get_unit_prefix();\n")));
    }

    /**
     * From legacy {@code buildMemMap()} ({@code CPT_MEM_MAP}): scope-holder with {@code get_data_word_width} / {@code get_prefix}
     * style cmds.
     */
    private static CGenTbClassSpec memoryMap() {
        String mm = "mm";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_MEMORY_MAP,
                CGenTbChapter.CPT_MEM_MAP,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_memory_map " + mm + ";\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant("get_data_word_width", mm + ".get_data_word_width();\n"),
                        new CGenTbClassSpec.CmdVariant("get_prefix", mm + ".get_prefix();\n")));
    }

    /**
     * From legacy {@code buildMemMapPage()} ({@code CPT_MEM_MAP}): {@code csl_memory_map_page} with representative getter
     * cmd.
     */
    private static CGenTbClassSpec memoryMapPage() {
        String mmp = "mmp";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_MEMORY_MAP_PAGE,
                CGenTbChapter.CPT_MEM_MAP,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_memory_map_page " + mmp + ";\n")),
                List.of(new CGenTbClassSpec.CmdVariant("get_address_increment", mmp + ".get_address_increment();\n")));
    }

    /**
     * From legacy {@code buildRegFile()} ({@code CPT_REG_FILE}): mandatory {@code set_depth} / {@code set_width} like
     * {@link #memory()}.
     */
    private static CGenTbClassSpec registerFile() {
        String rf = "rf";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_REGISTER_FILE,
                CGenTbChapter.CPT_REG_FILE,
                List.of(),
                List.of(
                        new CGenTbClassSpec.DeclVariant(
                                "mand",
                                "csl_register_file "
                                        + rf
                                        + ";\n"
                                        + rf
                                        + ".set_depth("
                                        + CGenConsts.DEPTH_DEFAULT
                                        + ");\n"
                                        + rf
                                        + ".set_width("
                                        + CGenConsts.WIDTH_DEFAULT
                                        + ");\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant("get_width", rf + ".get_width();\n"),
                        new CGenTbClassSpec.CmdVariant("get_depth", rf + ".get_depth();\n")));
    }

    /**
     * From legacy {@code buildStateData()} ({@code CPT_VERIFC}): verification-component object with {@code get_radix} /
     * {@code get_output_filename}.
     */
    private static CGenTbClassSpec stateData() {
        String sd = "sd";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_STATE_DATA,
                CGenTbChapter.CPT_VERIFC,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_state_data " + sd + ";\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant("get_radix", sd + ".get_radix();\n"),
                        new CGenTbClassSpec.CmdVariant("get_output_filename", sd + ".get_output_filename();\n")));
    }

    /**
     * From legacy {@code buildVector()} ({@code CPT_VERIFC}): {@code csl_vector} with a simple getter.
     */
    private static CGenTbClassSpec vector() {
        String vc = "vc";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_VECTOR,
                CGenTbChapter.CPT_VERIFC,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_vector " + vc + ";\n")),
                List.of(new CGenTbClassSpec.CmdVariant("get_radix", vc + ".get_radix();\n")));
    }

    /**
     * From legacy {@code buildTestbench()} ({@code CPT_TESTB}): global {@code csl_testbench} with instance commands such as
     * {@code get_simulation_timeout_count} and {@code add_logic}.
     */
    private static CGenTbClassSpec testbench() {
        String tb = "tb";
        return new CGenTbClassSpec(
                CGenTbEslClass.CSL_TESTBENCH,
                CGenTbChapter.CPT_TESTB,
                List.of(),
                List.of(new CGenTbClassSpec.DeclVariant("plain", "csl_testbench " + tb + ";\n")),
                List.of(
                        new CGenTbClassSpec.CmdVariant("get_sim", tb + ".get_simulation_timeout_count();\n"),
                        new CGenTbClassSpec.CmdVariant("add_logic_report", tb + ".add_logic(generate_report);\n")));
    }
}

