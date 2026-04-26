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
