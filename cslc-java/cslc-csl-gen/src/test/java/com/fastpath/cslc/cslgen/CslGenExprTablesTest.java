package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CslGenExprTablesTest {

    @Test
    void sizesMatchSupportHeader() {
        assertEquals(2, CslGenExprTables.UNARY_POSTFIXED_OP.length);
        assertEquals(5, CslGenExprTables.BINARY_OP.length);
    }
}
