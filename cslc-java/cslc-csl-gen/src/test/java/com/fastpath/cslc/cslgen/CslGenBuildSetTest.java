package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenBuildSetTest {

    @Test
    void portBuildSetEmitsSetterCall() {
        String text = "";
        for (long seed = 0; seed < 300; seed++) {
            Random rng = new Random(seed);
            CslGenDesign d = new CslGenDesign("d");
            CslGenUnit u = new CslGenUnit(d, "ux");
            d.addChild(u);
            CslGenPort p = new CslGenPort(u, "p0");
            p.setDir("input");
            StringBuilder out = new StringBuilder();
            CslGenCslBase.runWithPrintSink(out, () -> p.buildSet("", rng));
            text = out.toString();
            if (text.contains("set_range") || text.contains("set_width") || text.contains("set_offset")) {
                return;
            }
        }
        assertTrue(
                text.contains("set_range") || text.contains("set_width") || text.contains("set_offset"),
                "expected port buildSet to emit a set_* call for some seed");
    }

    @Test
    void unitModifPortFindsChildPort() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenUnit u = new CslGenUnit(d, "uu");
        d.addChild(u);
        CslGenPort p = new CslGenPort(u, "pp");
        p.setDir("output");
        u.addChild(p);
        boolean ok = false;
        for (long s = 0; s < 500; s++) {
            final long seed = s;
            StringBuilder out = new StringBuilder();
            CslGenCslBase.runWithPrintSink(out, () -> u.modifPort(new Random(seed)));
            String t = out.toString();
            if (t.contains("pp.") && t.contains("set_")) {
                ok = true;
                break;
            }
        }
        assertTrue(ok, "modifPort should eventually select child port pp and emit set_*");
    }
}
