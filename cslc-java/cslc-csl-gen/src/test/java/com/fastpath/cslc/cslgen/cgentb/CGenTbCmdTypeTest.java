package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class CGenTbCmdTypeTest {

    @Test
    void enumCountMatchesLegacyEcsLCmdType() {
        assertEquals(180, CGenTbCmdType.values().length);
    }

    @Test
    void legacyNamesMatchBuildCmdNames() {
        assertEquals("add", CGenTbCmdType.CMD_ADD.legacyCslCmdName());
        assertEquals("get_vc_stall ", CGenTbCmdType.CMD_GET_VC_STALL.legacyCslCmdName());
        assertEquals(180, CGenTbCmdType.legacyNameTable().size());
        assertTrue(CGenTbCmdType.legacyNameTable().containsKey(CGenTbCmdType.CMD_SET_WR_EN_NAME));
    }
}
