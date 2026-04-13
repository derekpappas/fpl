package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import org.junit.jupiter.api.Test;

/**
 * Exercises {@link CslGenRegisterFile#print} branches that depend on random {@code m_used} slots and design context
 * (fields, registers, ports).
 */
class CslGenRegisterFilePrintWalkCoverageTest {

    private static final List<String> RF_EMIT = List.of(
            "read_valid",
            "create_rtl_module",
            "set_const_value(",
            "set_field(",
            "set_external(",
            "bypass",
            "set_prefix(",
            "get_width()",
            "register_group",
            "disconnect_register_fields_from_ios",
            "connect_register_fields_to_ios");

    private static void collectRegisterFiles(CslGenCslBase root, List<CslGenRegisterFile> out) {
        if (root instanceof CslGenRegisterFile rf) {
            out.add(rf);
        }
        for (CslGenCslBase ch : root.getChildren()) {
            collectRegisterFiles(ch, out);
        }
    }

    private static void addRegisterFileHeavyFixture(CslGenDesign d, long seed) {
        Random r = new Random(seed);
        String portName = "rfPort" + seed;
        if (d.newNameIsValid(portName)) {
            d.addChild(new CslGenPort(d, portName));
        }
        for (int i = 0; i < 10; i++) {
            d.addField(r);
        }
        for (int i = 0; i < 12; i++) {
            d.addRegister(r);
        }
        for (int i = 0; i < 22; i++) {
            d.addRegisterFile(r);
        }
    }

    @Test
    void seededDesignsCoverRegisterFilePrintEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 350_000L;
        for (; s < limit && hit.size() < RF_EMIT.size(); s++) {
            CslGenDesign d = new CslGenDesign("d");
            addRegisterFileHeavyFixture(d, s);
            List<CslGenRegisterFile> rfs = new ArrayList<>();
            collectRegisterFiles(d, rfs);
            StringBuilder blob = new StringBuilder();
            for (CslGenRegisterFile rf : rfs) {
                rf.appendPrintedCsl(blob);
                blob.append('\n');
            }
            String t = blob.toString();
            for (String k : RF_EMIT) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        assertEquals(
                RF_EMIT.size(),
                hit.size(),
                "after "
                        + s
                        + " seeds, missing emitters: "
                        + missing(RF_EMIT, hit));
    }

    private static List<String> missing(List<String> expected, Set<String> hit) {
        List<String> m = new ArrayList<>();
        for (String e : expected) {
            if (!hit.contains(e)) {
                m.add(e);
            }
        }
        return m;
    }
}
