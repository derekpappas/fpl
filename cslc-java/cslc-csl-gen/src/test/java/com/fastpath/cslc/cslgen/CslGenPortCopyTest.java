package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenPortCopyTest {

    @Test
    void copyPortCopiesDirTypeAndRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenUnit u = new CslGenUnit(d, "u");
        d.addChild(u);
        CslGenPort a = new CslGenPort(u, "pa");
        a.setDir("input");
        a.setPortType("wire");
        a.setRange(1, 5);
        CslGenPort b = new CslGenPort(u, "pb");
        b.copyPort(a);
        assertEquals("input", b.getDir());
        assertEquals("wire", b.getPortType());
        assertEquals(1, b.getLower());
        assertEquals(5, b.getUpper());
    }

    @Test
    void copySignalCopiesTypeAndBitrange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenUnit u = new CslGenUnit(d, "u");
        d.addChild(u);
        CslGenSignal s = new CslGenSignal(u, "s");
        s.setSigType("reg");
        s.setWidth(3);
        CslGenPort p = new CslGenPort(u, "p");
        p.copySignal(s);
        assertEquals("reg", p.getPortType());
        assertEquals(3, p.getWidth());
    }

    @Test
    void getBitrangeStateIsLiveEmbeddedRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenPort p = new CslGenPort(d, "p");
        p.getBitrangeState().setRange(0, 4);
        assertEquals(0, p.getLower());
        assertEquals(4, p.getUpper());
    }

    @Test
    void signalGetBitrangeStateMatchesAccessors() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenSignal s = new CslGenSignal(d, "s");
        s.setRange(2, 9);
        assertEquals(2, s.getBitrangeState().getLower());
        assertEquals(9, s.getBitrangeState().getUpper());
    }

    @Test
    void scopedCopyStringsDefaultEmpty() {
        CslGenPort p = new CslGenPort(new CslGenDesign("d"), "p");
        assertTrue(p.getBitrCopyText().isEmpty());
        CslGenSignal s = new CslGenSignal(new CslGenDesign("d"), "s");
        assertTrue(s.getBitrCopyText().isEmpty());
        assertTrue(s.getSigCopyText().isEmpty());
    }

    @Test
    void portDeclFormVisibleAfterBuildDecl() {
        CslGenPort p = new CslGenPort(new CslGenDesign("d"), "p");
        assertEquals(CslGenPort.PORT_DECL_EMPTY, p.getDeclForm());
        p.buildDecl(new Random(77L));
        int f = p.getDeclForm();
        assertTrue(f >= 0 && f < CslGenPort.PORT_DECL_MAX);
    }

    @Test
    void signalDeclFormVisibleAfterBuildDecl() {
        CslGenSignal s = new CslGenSignal(new CslGenDesign("d"), "s");
        assertEquals(CslGenSignal.SIG_DECL_EMPTY, s.getDeclForm());
        s.buildDecl(new Random(88L));
        int f = s.getDeclForm();
        assertTrue(f >= 0 && f < CslGenSignal.SIG_DECL_MAX);
    }
}
