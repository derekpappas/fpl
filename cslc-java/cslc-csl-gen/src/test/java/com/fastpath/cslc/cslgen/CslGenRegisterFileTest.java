package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenRegisterFileTest {

    @Test
    void registerFileOptionalStringsStartEmpty() {
        CslGenRegisterFile rf = new CslGenRegisterFile(new CslGenDesign("d"), "rf");
        assertTrue(rf.getConstValText().isEmpty());
        assertTrue(rf.getFieldNameText().isEmpty());
        assertTrue(rf.getFieldNumExprText().isEmpty());
        assertTrue(rf.getExtNumExprText().isEmpty());
        assertTrue(rf.getExtPortText().isEmpty());
        assertTrue(rf.getPrefixText().isEmpty());
        assertTrue(rf.getIoputText().isEmpty());
        assertTrue(rf.getPrefixAllText().isEmpty());
        assertTrue(rf.getGroupNameText().isEmpty());
        assertTrue(rf.getRegAllText().isEmpty());
        assertTrue(rf.getDiscAllText().isEmpty());
        assertTrue(rf.getConAllText().isEmpty());
        assertTrue(rf.getConIOputText().isEmpty());
        assertThrows(IndexOutOfBoundsException.class, () -> rf.getRegisterFileUsedAt(CslGenRegisterTables.RF_USED_VECTOR_SIZE));
    }

    @Test
    void addRegisterFileEmitsCsl() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(999L);
        d.addRegisterFile(rng);
        assertInstanceOf(CslGenRegisterFile.class, d.getChildAt(0).orElseThrow());
        CslGenRegisterFile rf = (CslGenRegisterFile) d.getChildAt(0).orElseThrow();
        assertFalse(rf.getWidthText().isEmpty());
        assertFalse(rf.getDepthText().isEmpty());
        assertEquals(1, rf.getRegisterFileUsedAt(CslGenRegisterFile.SET_WIDTH));
        assertEquals(1, rf.getRegisterFileUsedAt(CslGenRegisterFile.SET_DEPTH));
        assertThrows(IndexOutOfBoundsException.class, () -> rf.getRegisterFileUsedAt(-1));
        StringBuilder out = new StringBuilder();
        rf.appendPrintedCsl(out);
        String text = out.toString();
        assertTrue(text.startsWith("csl_register_file "));
        assertTrue(text.contains("set_width"));
        assertTrue(text.contains("set_depth"));
        assertTrue(text.endsWith(";\n"));
    }

    @Test
    void registerFileNoArgBuildDeclUsesDefaultGenerator() {
        CslGenRegisterFile rf = new CslGenRegisterFile(new CslGenDesign("d"), "rf0");
        rf.buildDecl();
        assertEquals(1, rf.getRegisterFileUsedAt(CslGenRegisterFile.SET_WIDTH));
    }
}
