package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenCslBaseTest {

    @Test
    void tracksChildrenAndNameValidity() {
        CslGenDesign d = new CslGenDesign("top");
        CslGenUnit u = new CslGenUnit(d, "u1");
        d.registerName("reserved");
        assertTrue(d.getRegisteredNames().contains("reserved"));
        assertThrows(UnsupportedOperationException.class, () -> d.getRegisteredNames().clear());
        assertFalse(d.newNameIsValid("reserved"));
        assertTrue(d.newNameIsValid("other"));
        d.addChild(u);
        assertEquals(1, d.getChildrenCount());
        assertSame(u, d.getChildAt(0).orElseThrow());
        assertEquals(1, d.getChildrenOfType(CslGenCslType.CSL_UNIT).size());
        assertSame(u, d.getChildrenOfType(CslGenCslType.CSL_UNIT).get(0));
        assertTrue(d.getChildrenOfType(CslGenCslType.CSL_IFC).isEmpty());
        assertThrows(UnsupportedOperationException.class, () -> d.getChildrenOfType(CslGenCslType.CSL_UNIT).remove(0));
        assertFalse(d.newNameIsValid("u1"), "legacy newNameIsValid rejects names of existing design children");
    }

    @Test
    void getChildAtNegativeOrPastEndReturnsEmpty() {
        CslGenDesign d = new CslGenDesign("d");
        assertTrue(d.getChildAt(-1).isEmpty());
        assertTrue(d.getChildAt(0).isEmpty());
        d.addChild(new CslGenUnit(d, "u"));
        assertTrue(d.getChildAt(1).isEmpty());
    }

    @Test
    void unitInstRandSelObjWhenInstUnitUnsetWalksThroughNullResolvedBranch() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenUnitInst ui = new CslGenUnitInst(d, "ui0");
        d.addChild(ui);
        for (long s = 0; s < 500; s++) {
            ui.randSelObj(CslGenCslType.CSL_SIGNAL, new Random(s));
        }
    }

    @Test
    void runWithPrintSinkNestedRestoresPreviousSinkInInnerFinally() {
        final class SinkProbe extends CslGenCslBase {
            SinkProbe() {
                super(CslGenCslType.CSL_PORT, null, "sinkProbe");
            }

            @Override
            public boolean buildDecl() {
                return true;
            }

            @Override
            public void print() {}

            StringBuilder currentPrintSink() {
                return printSink();
            }
        }
        SinkProbe probe = new SinkProbe();
        StringBuilder outer = new StringBuilder();
        StringBuilder inner = new StringBuilder();
        CslGenCslBase.runWithPrintSink(outer, () -> {
            assertSame(outer, probe.currentPrintSink());
            CslGenCslBase.runWithPrintSink(inner, () -> assertSame(inner, probe.currentPrintSink()));
            assertNotNull(probe.currentPrintSink());
            assertSame(outer, probe.currentPrintSink());
        });
    }

    @Test
    void designBuildDeclSucceeds() {
        assertTrue(new CslGenDesign("design").buildDecl());
    }
}
