package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;
import org.junit.jupiter.api.Test;

/**
 * Locks in coverage for {@link CslGenIsaField} enum / value / design {@code set_type} print paths. Uses a bounded seed
 * hunt (deterministic across machines) plus fixed seeds that were verified to hit {@code .set_type(} on design-root
 * WIDTH declarations.
 */
class CslGenIsaFieldEnumTypeValuePrintTest {

    /**
     * Verified locally: design-root {@code csl_isa_field} WIDTH/COPY declarations append a trailing {@code name.set_type(...);}
     * after {@link CslGenIsaField#genSetType}.
     */
    private static final long DESIGN_SET_TYPE_SEED_A = 14L;

    private static final long DESIGN_SET_TYPE_SEED_B = 203L;

    private static String collectIsaFieldPrintBlob(CslGenDesign d) {
        StringBuilder blob = new StringBuilder();
        for (CslGenCslBase ch : d.getChildren()) {
            if (ch instanceof CslGenIsaField f) {
                f.appendPrintedCsl(blob);
                blob.append('\n');
            }
        }
        return blob.toString();
    }

    @Test
    void designRootWidthIsaFieldEmitsSetTypeCallForKnownSeeds() {
        for (long seed : new long[] {DESIGN_SET_TYPE_SEED_A, DESIGN_SET_TYPE_SEED_B}) {
            CslGenDesign d = new CslGenDesign("d");
            Random r = new Random(seed);
            for (int i = 0; i < 4; i++) {
                d.addEnum(r);
            }
            d.addIsaField(r);
            String t = collectIsaFieldPrintBlob(d);
            assertTrue(t.contains(".set_type("), "seed " + seed + " output:\n" + t);
        }
    }

    @Test
    void boundedSeedHuntHitsConstrSetEnumSetEnumItemAndSetValueEmitters() {
        final String[] need = {"set_enum(", "set_enum_item(", "set_value("};
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 250_000L;
        for (; s < limit && hit.size() < need.length; s++) {
            CslGenDesign d = new CslGenDesign("d");
            Random r = new Random(s);
            for (int i = 0; i < 14; i++) {
                d.addEnum(r);
            }
            for (int i = 0; i < 30; i++) {
                d.addIsaField(r);
            }
            String t = collectIsaFieldPrintBlob(d);
            for (String n : need) {
                if (t.contains(n)) {
                    hit.add(n);
                }
            }
        }
        assertEquals(
                need.length,
                hit.size(),
                "after "
                        + s
                        + " seeds, missing emitters among "
                        + java.util.Arrays.toString(need)
                        + "; hit="
                        + hit);
    }
}
