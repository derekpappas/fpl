package com.fastpath.cslc.parser;

import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class CslWalkerPortCommandVerbListenerTest {

    @Test
    void fileLevelNoPrefixRecordsVerbAndReceiver() throws IOException {
        String text = read("/regression/mini_file_command.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("no_prefix", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertEquals(1, listener.commandTextsInExitOrder().size());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("no_prefix"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("u"));
    }

    @Test
    void ctorBodyNoPrefixRecordsVerbWithoutReceiver() throws IOException {
        String text = read("/regression/mini_unit_ctor_command.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("no_prefix", listener.verbsInExitOrder().get(0));
        assertNull(listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("no_prefix"));
    }

    @Test
    void twoFileLevelCommandsPreserveExitOrder() {
        String text =
                """
                a.no_prefix();
                b.no_prefix();
                """;
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(2, listener.getCslCommandExitCount());
        assertEquals("no_prefix", listener.verbsInExitOrder().get(0));
        assertEquals("no_prefix", listener.verbsInExitOrder().get(1));
        assertEquals("b", listener.getLastReceiverIdentifier());
        assertEquals(2, listener.commandTextsInExitOrder().size());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("a"));
        assertTrue(listener.commandTextsInExitOrder().get(1).contains("b"));
    }

    @Test
    void assignAndOverrideParameterCommandsInferDifferentVerbs() throws IOException {
        String text = read("/regression/mini_assign_override_command.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(2, listener.getCslCommandExitCount());
        assertEquals("assign", listener.verbsInExitOrder().get(0));
        assertEquals("override_parameter", listener.verbsInExitOrder().get(1));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertEquals(2, listener.commandTextsInExitOrder().size());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("="));
        assertTrue(listener.commandTextsInExitOrder().get(1).contains("override_parameter"));
    }

    @Test
    void setWidthCommandInfersParamListSetWidthVerb() throws IOException {
        String text = read("/regression/mini_command_set_width.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_width", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_width"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("8"));
    }

    @Test
    void setDepthCommandInfersParamListSetDepthVerb() throws IOException {
        String text = read("/regression/mini_command_set_depth.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_depth", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_depth"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("9"));
    }

    @Test
    void createRtlModuleCommandInfersParamListCreateRtlModuleVerb() throws IOException {
        String text = read("/regression/mini_command_create_rtl_module.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("create_rtl_module", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("create_rtl_module"));
    }

    @Test
    void setNameCommandInfersParamListSetNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"foo\""));
    }

    @Test
    void setTypeCommandInfersParamListSetTypeVerb() throws IOException {
        String text = read("/regression/mini_command_set_type.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_type", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_type"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"t\""));
    }

    @Test
    void directiveCommandInfersParamListDirectiveVerb() throws IOException {
        String text = read("/regression/mini_command_directive.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("directive", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("directive"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("d"));
    }

    @Test
    void setDirectionCommandInfersParamListSetDirectionVerb() throws IOException {
        String text = read("/regression/mini_command_set_direction.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_direction", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_direction"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("in"));
    }

    @Test
    void setRadixCommandInfersParamListSetRadixVerb() throws IOException {
        String text = read("/regression/mini_command_set_radix.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_radix", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_radix"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("16"));
    }

    @Test
    void exclusionListCommandInfersParamListExclusionListVerb() throws IOException {
        String text = read("/regression/mini_command_exclusion_list.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("exclusion_list", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("exclusion_list"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void includeOnlyCommandInfersParamListIncludeOnlyVerb() throws IOException {
        String text = read("/regression/mini_command_include_only.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("include_only", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("include_only"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void reverseCommandInfersParamListReverseVerb() throws IOException {
        String text = read("/regression/mini_command_reverse.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("reverse", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("reverse"));
    }

    @Test
    void setOffsetCommandInfersParamListSetOffsetVerb() throws IOException {
        String text = read("/regression/mini_command_set_offset.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_offset", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_offset"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("4"));
    }

    @Test
    void setPrefixCommandInfersParamListSetPrefixVerb() throws IOException {
        String text = read("/regression/mini_command_set_prefix.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_prefix", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_prefix"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"p\""));
    }

    @Test
    void setSuffixCommandInfersParamListSetSuffixVerb() throws IOException {
        String text = read("/regression/mini_command_set_suffix.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_suffix", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_suffix"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"s\""));
    }

    @Test
    void setTopUnitCommandInfersParamListSetTopUnitVerb() throws IOException {
        String text = read("/regression/mini_command_set_top_unit.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_top_unit", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_top_unit"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("top"));
    }

    @Test
    void setNumberOfDimensionsCommandInfersParamListSetNumberOfDimensionsVerb() throws IOException {
        String text = read("/regression/mini_command_set_number_of_dimensions.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_number_of_dimensions", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_number_of_dimensions"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setAlignmentCommandInfersParamListSetAlignmentVerb() throws IOException {
        String text = read("/regression/mini_command_set_alignment.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_alignment", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_alignment"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("8"));
    }

    @Test
    void setEndianessCommandInfersParamListSetEndianessVerb() throws IOException {
        String text = read("/regression/mini_command_set_endianess.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_endianess", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_endianess"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"little\""));
    }

    @Test
    void setRangeCommandInfersParamListSetRangeVerb() throws IOException {
        String text = read("/regression/mini_command_set_range.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_range", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_range"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setDimRangeCommandInfersParamListSetDimRangeVerb() throws IOException {
        String text = read("/regression/mini_command_set_dim_range.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_dim_range", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_dim_range"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("3"));
    }

    @Test
    void autoGenMemoryMapCommandInfersParamListAutoGenMemoryMapVerb() throws IOException {
        String text = read("/regression/mini_command_auto_gen_memory_map.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("auto_gen_memory_map", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("auto_gen_memory_map"));
    }

    @Test
    void addToMemoryMapCommandInfersParamListAddToMemoryMapVerb() throws IOException {
        String text = read("/regression/mini_command_add_to_memory_map.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("add_to_memory_map", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("add_to_memory_map"));
    }

    @Test
    void setMemInstanceNameCommandInfersParamListSetMemInstanceNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_mem_instance_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_mem_instance_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_mem_instance_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"m\""));
    }

    @Test
    void setResetNameCommandInfersParamListSetResetNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_reset_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_reset_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_reset_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"rst\""));
    }

    @Test
    void setUnitPrefixCommandInfersParamListSetUnitPrefixVerb() throws IOException {
        String text = read("/regression/mini_command_set_unit_prefix.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_unit_prefix", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_unit_prefix"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"u_\""));
    }

    @Test
    void setSignalPrefixCommandInfersParamListSetSignalPrefixVerb() throws IOException {
        String text = read("/regression/mini_command_set_signal_prefix.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_signal_prefix", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_signal_prefix"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"s_\""));
    }

    @Test
    void setSignalPrefixLocalCommandInfersParamListSetSignalPrefixLocalVerb() throws IOException {
        String text = read("/regression/mini_command_set_signal_prefix_local.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_signal_prefix_local", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_signal_prefix_local"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"sl_\""));
    }

    @Test
    void setDimOffsetCommandInfersParamListSetDimOffsetVerb() throws IOException {
        String text = read("/regression/mini_command_set_dim_offset.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_dim_offset", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_dim_offset"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setDimWidthCommandInfersParamListSetDimWidthVerb() throws IOException {
        String text = read("/regression/mini_command_set_dim_width.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_dim_width", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_dim_width"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setDimBitrangeCommandInfersParamListSetDimBitrangeVerb() throws IOException {
        String text = read("/regression/mini_command_set_dim_bitrange.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_dim_bitrange", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_dim_bitrange"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setBitrangeCommandInfersParamListSetBitrangeVerb() throws IOException {
        String text = read("/regression/mini_command_set_bitrange.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_bitrange", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_bitrange"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("7"));
    }

    @Test
    void setClockNameCommandInfersParamListSetClockNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_clock_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_clock_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_clock_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"clk\""));
    }

    @Test
    void setRdClockNameCommandInfersParamListSetRdClockNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_rd_clock_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_rd_clock_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_rd_clock_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"rd_clk\""));
    }

    @Test
    void setWrClockNameCommandInfersParamListSetWrClockNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_wr_clock_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_wr_clock_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_wr_clock_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"wr_clk\""));
    }

    @Test
    void setPushNameCommandInfersParamListSetPushNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_push_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_push_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_push_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"push\""));
    }

    @Test
    void setPopNameCommandInfersParamListSetPopNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_pop_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_pop_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_pop_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"pop\""));
    }

    @Test
    void setFullNameCommandInfersParamListSetFullNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_full_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_full_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_full_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"full\""));
    }

    @Test
    void setEmptyNameCommandInfersParamListSetEmptyNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_empty_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_empty_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_empty_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"empty\""));
    }

    @Test
    void setWrDataNameCommandInfersParamListSetWrDataNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_wr_data_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_wr_data_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_wr_data_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"wr_data\""));
    }

    @Test
    void setRdDataNameCommandInfersParamListSetRdDataNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_rd_data_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_rd_data_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_rd_data_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"rd_data\""));
    }

    @Test
    void setDataWordWidthCommandInfersParamListSetDataWordWidthVerb() throws IOException {
        String text = read("/regression/mini_command_set_data_word_width.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_data_word_width", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_data_word_width"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("32"));
    }

    @Test
    void setAddressIncrementCommandInfersParamListSetAddressIncrementVerb() throws IOException {
        String text = read("/regression/mini_command_set_address_increment.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_address_increment", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_address_increment"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("4"));
    }

    @Test
    void setNextAddressCommandInfersParamListSetNextAddressVerb() throws IOException {
        String text = read("/regression/mini_command_set_next_address.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_next_address", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_next_address"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("8"));
    }

    @Test
    void setNextCommandInfersParamListSetNextVerb() throws IOException {
        String text = read("/regression/mini_command_set_next.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_next", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_next"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setPreviousCommandInfersParamListSetPreviousVerb() throws IOException {
        String text = read("/regression/mini_command_set_previous.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_previous", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_previous"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setValidNameCommandInfersParamListSetValidNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_valid_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_valid_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_valid_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"valid\""));
    }

    @Test
    void setSymbolMaxLengthCommandInfersParamListSetSymbolMaxLengthVerb() throws IOException {
        String text = read("/regression/mini_command_set_symbol_max_length.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_symbol_max_length", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_symbol_max_length"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("12"));
    }

    @Test
    void setEnumCommandInfersParamListSetEnumVerb() throws IOException {
        String text = read("/regression/mini_command_set_enum.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_enum", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_enum"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"E\""));
    }

    @Test
    void setEnumItemCommandInfersParamListSetEnumItemVerb() throws IOException {
        String text = read("/regression/mini_command_set_enum_item.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_enum_item", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_enum_item"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"I\""));
    }

    @Test
    void setMnemonicCommandInfersParamListSetMnemonicVerb() throws IOException {
        String text = read("/regression/mini_command_set_mnemonic.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_mnemonic", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_mnemonic"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"m\""));
    }

    @Test
    void genDecoderCommandInfersParamListGenDecoderVerb() throws IOException {
        String text = read("/regression/mini_command_gen_decoder.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("gen_decoder", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("generate_decoder"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void initializeRandomValuesCommandInfersParamListInitializeRandomValuesVerb() throws IOException {
        String text = read("/regression/mini_command_initialize_random_values.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("initialize_random_values", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("initialize_random_values"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void initializeRandomCommandInfersParamListInitializeRandomVerb() throws IOException {
        String text = read("/regression/mini_command_initialize_random.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("initialize_random", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("initialize_random"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void mergeCommandInfersParamListMergeVerb() throws IOException {
        String text = read("/regression/mini_command_merge.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("merge", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("merge"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("3"));
    }

    @Test
    void setVersionCommandInfersParamListSetVersionVerb() throws IOException {
        String text = read("/regression/mini_command_set_version.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_version", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_version"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"1\""));
    }

    @Test
    void setVcNameCommandInfersParamListSetVcNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"vc\""));
    }

    @Test
    void setVcHeaderCommentCommandInfersParamListSetVcHeaderCommentVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_header_comment.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_header_comment", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_header_comment"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"header\""));
    }

    @Test
    void setVcCompareTriggerCommandInfersParamListSetVcCompareTriggerVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_compare_trigger.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_compare_trigger", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_compare_trigger"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setVcStartGenerationTriggerCommandInfersParamListSetVcStartGenerationTriggerVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_start_generation_trigger.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_start_generation_trigger", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_start_generation_trigger"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setVcClockCommandInfersParamListSetVcClockVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_clock.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_clock", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_clock"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"clk\""));
    }

    @Test
    void setVcResetCommandInfersParamListSetVcResetVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_reset.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_reset", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_reset"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"rst\""));
    }

    @Test
    void setVcStallCommandInfersParamListSetVcStallVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_stall.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_stall", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_stall"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("0"));
    }

    @Test
    void setVcEndGenerationTriggerCommandInfersParamListSetVcEndGenerationTriggerVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_end_generation_trigger.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_end_generation_trigger", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_end_generation_trigger"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setVcCaptureEdgeTypeCommandInfersParamListSetVcCaptureEdgeTypeVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_capture_edge_type.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_capture_edge_type", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_capture_edge_type"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"pos\""));
    }

    @Test
    void setVcMaxNumberOfMismatchesCommandInfersParamListSetVcMaxNumberOfMismatchesVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_max_number_of_mismatches.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_max_number_of_mismatches", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_max_number_of_mismatches"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("10"));
    }

    @Test
    void setVcMaxNumberOfValidTransactionsCommandInfersParamListSetVcMaxNumberOfValidTransactionsVerb()
            throws IOException {
        String text = read("/regression/mini_command_set_vc_max_number_of_valid_transactions.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_max_number_of_valid_transactions", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_max_number_of_valid_transactions"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("20"));
    }

    @Test
    void setVcValidOutputTransactionCommandInfersParamListSetVcValidOutputTransactionVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_valid_output_transaction.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_valid_output_transaction", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_valid_output_transaction"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setVcOutputFilenameCommandInfersParamListSetVcOutputFilenameVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_output_filename.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_output_filename", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_output_filename"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"out\""));
    }

    @Test
    void setVcMaxCyclesCommandInfersParamListSetVcMaxCyclesVerb() throws IOException {
        String text = read("/regression/mini_command_set_vc_max_cycles.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_vc_max_cycles", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_vc_max_cycles"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("100"));
    }

    @Test
    void setUnitNameCommandInfersParamListSetUnitNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_unit_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_unit_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_unit_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"u1\""));
    }

    @Test
    void pipestageNamingConventionCommandInfersParamListPipestageNamingConventionVerb() throws IOException {
        String text = read("/regression/mini_command_pipestage_naming_convention.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("pipestage_naming_convention", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("pipestage_naming_convention"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"x\""));
    }

    @Test
    void noPrefixCommandInfersParamListNoPrefixVerb() throws IOException {
        String text = read("/regression/mini_command_no_prefix.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("no_prefix", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("no_prefix"));
    }

    @Test
    void doNotGenRtlCommandInfersParamListDoNotGenRtlVerb() throws IOException {
        String text = read("/regression/mini_command_do_not_gen_rtl.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("do_not_gen_rtl", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("do_not_gen_rtl"));
    }

    @Test
    void doNotGenCppCommandInfersParamListDoNotGenCppVerb() throws IOException {
        String text = read("/regression/mini_command_do_not_gen_cpp.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("do_not_gen_cpp", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("do_not_gen_cpp"));
    }

    @Test
    void connectUnitsCommandInfersParamListConnectUnitsVerb() throws IOException {
        String text = read("/regression/mini_command_connect_units.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("connect_units", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("connect_units"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("a"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("b"));
    }

    @Test
    void connectByPatternCommandInfersParamListConnectByPatternVerb() throws IOException {
        String text = read("/regression/mini_command_connect_by_pattern.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("connect_by_pattern", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("connect_by_pattern"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("a"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("b"));
    }

    @Test
    void connectByNameCommandInfersParamListConnectByNameVerb() throws IOException {
        String text = read("/regression/mini_command_connect_by_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("connect_by_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("connect_by_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("a"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("b"));
    }

    @Test
    void addPortListCommandInfersParamListAddPortListVerb() throws IOException {
        String text = read("/regression/mini_command_add_port_list.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("add_port_list", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("add_port_list"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("a"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("b"));
    }

    @Test
    void setAttrCommandInfersParamListSetAttrVerb() throws IOException {
        String text = read("/regression/mini_command_set_attr.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_attr", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_attr"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setInstanceAlterationBitCommandInfersParamListSetInstanceAlterationBitVerb() throws IOException {
        String text = read("/regression/mini_command_set_instance_alteration_bit.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_instance_alteration_bit", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_instance_alteration_bit"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setTestbenchVerilogFilenameCommandInfersParamListSetTestbenchVerilogFilenameVerb() throws IOException {
        String text = read("/regression/mini_command_set_testbench_verilog_filename.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_testbench_verilog_filename", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_testbench_verilog_filename"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"tb.v\""));
    }

    @Test
    void addCommandInfersParamListAddVerb() throws IOException {
        String text = read("/regression/mini_command_add.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("add", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("add"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("3"));
    }

    @Test
    void addAddressRangeCommandInfersParamListAddAddressRangeVerb() throws IOException {
        String text = read("/regression/mini_command_add_address_range.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("add_address_range", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("add_address_range"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void addReservedAddressRangeCommandInfersParamListAddReservedAddressRangeVerb() throws IOException {
        String text = read("/regression/mini_command_add_reserved_address_range.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("add_reserved_address_range", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("add_reserved_address_range"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setPhysicalImplementationCommandInfersParamListSetPhysicalImplementationVerb() throws IOException {
        String text = read("/regression/mini_command_set_physical_implementation.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_physical_implementation", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_physical_implementation"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("pi"));
    }

    @Test
    void setValueCommandInfersParamListSetValueVerb() throws IOException {
        String text = read("/regression/mini_command_set_value.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_value", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_value"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setFieldCommandInfersParamListSetFieldVerb() throws IOException {
        String text = read("/regression/mini_command_set_field.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_field", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_field"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setFieldPositionCommandInfersParamListSetFieldPositionVerb() throws IOException {
        String text = read("/regression/mini_command_set_field_position.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_field_position", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_field_position"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setPositionCommandInfersParamListSetPositionVerb() throws IOException {
        String text = read("/regression/mini_command_set_position.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_position", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_position"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void addAllowedRangeCommandInfersParamListAddAllowedRangeVerb() throws IOException {
        String text = read("/regression/mini_command_add_allowed_range.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("add_allowed_range", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("add_allowed_range"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setAttributesCommandInfersParamListSetAttributesVerb() throws IOException {
        String text = read("/regression/mini_command_set_attributes.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_attributes", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_attributes"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void addLogicCommandInfersParamListAddLogicVerb() throws IOException {
        String text = read("/regression/mini_command_add_logic.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("add_logic", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("add_logic"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setUnitIdCommandInfersParamListSetUnitIdVerb() throws IOException {
        String text = read("/regression/mini_command_set_unit_id.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_unit_id", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_unit_id"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setNumRdIfcCommandInfersParamListSetNumRdIfcVerb() throws IOException {
        String text = read("/regression/mini_command_set_num_rd_ifc.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_num_rd_ifc", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_num_rd_ifc"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void setNumWrIfcCommandInfersParamListSetNumWrIfcVerb() throws IOException {
        String text = read("/regression/mini_command_set_num_wr_ifc.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_num_wr_ifc", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_num_wr_ifc"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
    }

    @Test
    void genUniqueRtlModulesCommandInfersParamListGenUniqueRtlModulesVerb() throws IOException {
        String text = read("/regression/mini_command_gen_unique_rtl_modules.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("gen_unique_rtl_modules", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("gen_unique_rtl_modules"));
    }

    @Test
    void overrideParameterCommandInfersParamListOverrideParameterVerb() throws IOException {
        String text = read("/regression/mini_command_override_parameter.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("override_parameter", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("override_parameter"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
    }

    @Test
    void setClockCommandInfersParamListSetClockVerb() throws IOException {
        String text = read("/regression/mini_command_set_clock.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_clock", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_clock"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"clk\""));
    }

    @Test
    void registerIosCommandInfersParamListRegisterIosVerb() throws IOException {
        String text = read("/regression/mini_command_register_ios.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("register_ios", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("register_ios"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("ios"));
    }

    @Test
    void setWrAddrNameCommandInfersParamListSetWrAddrNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_wr_addr_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_wr_addr_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_wr_addr_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"wr_addr\""));
    }

    @Test
    void setRdAddrNameCommandInfersParamListSetRdAddrNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_rd_addr_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_rd_addr_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_rd_addr_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"rd_addr\""));
    }

    @Test
    void setWrEnNameCommandInfersParamListSetWrEnNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_wr_en_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_wr_en_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_wr_en_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"wr_en\""));
    }

    @Test
    void setRdEnNameCommandInfersParamListSetRdEnNameVerb() throws IOException {
        String text = read("/regression/mini_command_set_rd_en_name.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_rd_en_name", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_rd_en_name"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("\"rd_en\""));
    }

    @Test
    void setAccessRightsCommandInfersParamListSetAccessRightsVerb() throws IOException {
        String text = read("/regression/mini_command_set_access_rights.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_access_rights", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_access_rights"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("1"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("2"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("3"));
    }

    @Test
    void setAccessRightsEnumCommandInfersParamListSetAccessRightsEnumVerb() throws IOException {
        String text = read("/regression/mini_command_set_access_rights_enum.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("set_access_rights_enum", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("set_access_rights_enum"));
        assertTrue(listener.commandTextsInExitOrder().get(0).contains("e"));
    }

    private static String read(String path) throws IOException {
        try (InputStream in = CslWalkerPortCommandVerbListenerTest.class.getResourceAsStream(path)) {
            assertNotNull(in, "missing resource " + path);
            return new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
    }
}
