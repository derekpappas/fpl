package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;

class CGenTbContainersTest {

    @Test
    void eslLookupsMatchEnums() {
        CGenTbContainers c = CGenTbContainers.get();
        assertEquals(CGenTbEslClass.CSL_FIFO, c.eslClassForLegacyGenericStem("fifo"));
        assertEquals(CGenTbEslClass.CSL_FIFO, c.eslClassForLegacyCslTypeKeyword("csl_fifo"));
        assertNull(c.eslClassForLegacyGenericStem("nope"));
    }

    @Test
    void cmdLookupMatchesAdd() {
        assertEquals(CGenTbCmdType.CMD_ADD, CGenTbContainers.get().cmdTypeForLegacyName("add"));
    }

    @Test
    void chapterAndObjTablesMatchLegacyDerivations() {
        CGenTbContainers c = CGenTbContainers.get();
        assertEquals(CGenTbChapter.CPT_FIFO, c.chapterForEslClass(CGenTbEslClass.CSL_FIFO));
        assertEquals("fifo_obj", c.legacyObjName(CGenTbEslClass.CSL_FIFO));
        assertEquals("fifo_param", c.legacyParamName(CGenTbEslClass.CSL_FIFO));
        assertEquals("fifo_inst", c.legacyInst1Name(CGenTbEslClass.CSL_FIFO));
    }
}
