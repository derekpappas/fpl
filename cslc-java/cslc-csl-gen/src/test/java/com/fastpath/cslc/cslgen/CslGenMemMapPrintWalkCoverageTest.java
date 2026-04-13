package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import org.junit.jupiter.api.Test;

/**
 * Drives {@link CslGenMemMap#print} / {@link CslGenMemMap#appendPrintedCsl} across many RNG seeds so rarely-used
 * {@code MM_FUNCTION} emitters appear (see JaCoCo on {@code CslGenMemMap.java}).
 */
class CslGenMemMapPrintWalkCoverageTest {

    private static final List<String> MM_EMIT = List.of(
            "auto_gen_memory_map",
            "set_top_unit",
            "add_to_memory_map",
            "set_type(",
            "set_access_rights_enum",
            "set_data_word_width",
            "set_prefix(",
            "set_suffix(");

    private static void collectMemMaps(CslGenCslBase root, List<CslGenMemMap> out) {
        if (root instanceof CslGenMemMap mm) {
            out.add(mm);
        }
        for (CslGenCslBase ch : root.getChildren()) {
            collectMemMaps(ch, out);
        }
    }

    private static void addMemMapHeavyFixture(CslGenDesign d, long seed) {
        Random r = new Random(seed);
        for (int i = 0; i < 8; i++) {
            d.addUnit(r);
        }
        for (int i = 0; i < 14; i++) {
            d.addEnum(r);
        }
        for (int i = 0; i < 10; i++) {
            d.addField(r);
        }
        for (int i = 0; i < 8; i++) {
            d.addMemory(r);
        }
        for (int i = 0; i < 8; i++) {
            d.addRegister(r);
        }
        for (int i = 0; i < 8; i++) {
            d.addRegisterFile(r);
        }
        for (int i = 0; i < 6; i++) {
            d.addFifo(r);
        }
        for (int i = 0; i < 14; i++) {
            d.addMemMapPage(r);
        }
        for (int i = 0; i < 22; i++) {
            d.addMemMap(r);
        }
    }

    @Test
    void seededDesignsCoverMemMapPrintEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 450_000L;
        for (; s < limit && hit.size() < MM_EMIT.size(); s++) {
            CslGenDesign d = new CslGenDesign("d");
            addMemMapHeavyFixture(d, s);
            List<CslGenMemMap> mms = new ArrayList<>();
            collectMemMaps(d, mms);
            StringBuilder blob = new StringBuilder();
            for (CslGenMemMap mm : mms) {
                mm.appendPrintedCsl(blob);
                blob.append('\n');
            }
            String t = blob.toString();
            for (String k : MM_EMIT) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        assertEquals(
                MM_EMIT.size(),
                hit.size(),
                "after " + s + " seeds, missing emitters: " + missing(MM_EMIT, hit));
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
