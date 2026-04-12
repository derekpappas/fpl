package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CslGenWireTablesTest {

    @Test
    void tableSizesMatchHeader() {
        assertEquals(CslGenWireTables.TYPE_VEC_SIZE, CslGenWireTables.SIG_PORT_TYPES.length);
        assertEquals(CslGenWireTables.DIR_VEC_SIZE, CslGenWireTables.PORT_DIRECTIONS.length);
    }
}
