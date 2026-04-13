package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CGenTbEslClassTest {

    @Test
    void legacyStemsMatchCslGenericName() {
        assertEquals("register_file", CGenTbEslClass.CSL_REGISTER_FILE.legacyGenericStem());
        assertEquals("csl_unit", CGenTbEslClass.CSL_UNIT.legacyCslTypeKeyword());
        assertEquals("csl_multi_dim_bitrange", CGenTbEslClass.CSL_MULTI_DIM_BITRANGE.legacyCslTypeKeyword());
    }
}
