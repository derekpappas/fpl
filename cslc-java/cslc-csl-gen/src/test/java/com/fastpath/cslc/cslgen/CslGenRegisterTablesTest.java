package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CslGenRegisterTablesTest {

    @Test
    void arraySizesMatchHeader() {
        assertEquals(CslGenRegisterTables.R_USED_VECTOR_SIZE, CslGenRegisterTables.R_FUNCTION.length);
        assertEquals(CslGenRegisterTables.R_TYPE_SIZE, CslGenRegisterTables.R_TYPE.length);
        assertEquals(CslGenRegisterTables.R_ATRIBUT_SIZE, CslGenRegisterTables.R_ATRIBUT.length);
        assertEquals(11, CslGenRegisterTables.R_ADD_LOGIC_FCT.length);
        assertEquals(CslGenRegisterTables.RF_USED_VECTOR_SIZE, CslGenRegisterTables.RF_FUNCTION.length);
    }
}
