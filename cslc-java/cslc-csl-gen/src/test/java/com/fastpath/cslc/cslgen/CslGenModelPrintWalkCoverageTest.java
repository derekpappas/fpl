package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import org.junit.jupiter.api.Test;

/**
 * Walks generated trees under many RNG seeds so {@link CslGenIsaField}, {@link CslGenIsaElement}, and
 * {@link CslGenField} {@code print} / {@code appendPrintedCsl} paths that rarely appear in a single fixture are
 * still exercised (see JaCoCo for these classes).
 */
class CslGenModelPrintWalkCoverageTest {

    /**
     * Emitters that show up from typical {@link CslGenDesign#addIsaField(Random)} trees (hierarchical {@code CONSTR}
     * bodies dominate; enum/value slots are covered in {@link #orphanIsaFieldsEmitEnumValueAndItemPaths()}).
     */
    private static final List<String> ISA_FIELD_EMIT = List.of(
            "set_width",
            "set_range",
            "set_bitrange",
            "set_position",
            "set_next",
            "set_previous",
            "set_offset",
            "add_allowed_range");

    private static final List<String> ISA_ELEMENT_EMIT =
            List.of("set_type", "set_width", "set_position", "set_next", "set_previous");

    /** Same split as {@link #ISA_FIELD_EMIT} vs orphan test for {@link CslGenField}. */
    private static final List<String> FIELD_EMIT = List.of(
            "set_width",
            "set_range",
            "set_bitrange",
            "set_position",
            "set_next",
            "set_previous",
            "set_offset",
            "add_allowed_range");

    private static void collectIsaFields(CslGenCslBase root, List<CslGenIsaField> out) {
        if (root instanceof CslGenIsaField f) {
            out.add(f);
        }
        for (CslGenCslBase ch : root.getChildren()) {
            collectIsaFields(ch, out);
        }
    }

    private static void collectIsaElements(CslGenCslBase root, List<CslGenIsaElement> out) {
        if (root instanceof CslGenIsaElement e) {
            out.add(e);
        }
        for (CslGenCslBase ch : root.getChildren()) {
            collectIsaElements(ch, out);
        }
    }

    private static void collectFields(CslGenCslBase root, List<CslGenField> out) {
        if (root instanceof CslGenField f) {
            out.add(f);
        }
        for (CslGenCslBase ch : root.getChildren()) {
            collectFields(ch, out);
        }
    }

    private static void addLightFixture(CslGenDesign d, Random r) {
        for (int i = 0; i < 6; i++) {
            d.addBitrange(r);
        }
        for (int i = 0; i < 5; i++) {
            d.addEnum(r);
        }
        for (int i = 0; i < 12; i++) {
            d.addIsaField(r);
        }
        for (int i = 0; i < 10; i++) {
            d.addIsaElement(r);
        }
        for (int i = 0; i < 12; i++) {
            d.addField(r);
        }
    }

    /** Not added as a design child — still sees {@code design.getChildren()} for cross-refs / enums. */
    private static void appendOrphanIsaFieldPrint(long seed, CslGenDesign d, StringBuilder blob) {
        String n = "orphIf" + seed;
        if (!d.newNameIsValid(n)) {
            return;
        }
        CslGenIsaField f = new CslGenIsaField(d, n);
        if (f.buildDecl(new Random(seed ^ 0x6A09E667F3BCC909L))) {
            f.appendPrintedCsl(blob);
            blob.append('\n');
        }
    }

    private static void appendOrphanCslFieldPrint(long seed, CslGenDesign d, StringBuilder blob) {
        String n = "orphFld" + seed;
        if (!d.newNameIsValid(n)) {
            return;
        }
        CslGenField f = new CslGenField(d, n);
        f.buildDecl(new Random(seed ^ 0xBB67AE8584CAA73BL));
        f.appendPrintedCsl(blob);
        blob.append('\n');
    }

    @Test
    void seededLightDesignsCoverIsaFieldPrintEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 120_000L;
        for (; s < limit && hit.size() < ISA_FIELD_EMIT.size(); s++) {
            Random r = new Random(s);
            CslGenDesign d = new CslGenDesign("d");
            addLightFixture(d, r);
            List<CslGenIsaField> fields = new ArrayList<>();
            collectIsaFields(d, fields);
            StringBuilder blob = new StringBuilder();
            for (CslGenIsaField f : fields) {
                f.appendPrintedCsl(blob);
                blob.append('\n');
            }
            appendOrphanIsaFieldPrint(s, d, blob);
            String t = blob.toString();
            for (String k : ISA_FIELD_EMIT) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        long seedsUsed = s;
        assertEquals(
                ISA_FIELD_EMIT.size(),
                hit.size(),
                "after "
                        + seedsUsed
                        + " seeds, missing emitters: "
                        + missing(ISA_FIELD_EMIT, hit));
    }

    @Test
    void seededLightDesignsCoverIsaElementPrintEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 120_000L;
        for (; s < limit && hit.size() < ISA_ELEMENT_EMIT.size(); s++) {
            Random r = new Random(s);
            CslGenDesign d = new CslGenDesign("d");
            addLightFixture(d, r);
            List<CslGenIsaElement> els = new ArrayList<>();
            collectIsaElements(d, els);
            StringBuilder blob = new StringBuilder();
            for (CslGenIsaElement el : els) {
                el.appendPrintedCsl(blob);
                blob.append('\n');
            }
            String t = blob.toString();
            for (String k : ISA_ELEMENT_EMIT) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        long seedsUsedEl = s;
        assertEquals(
                ISA_ELEMENT_EMIT.size(),
                hit.size(),
                "after "
                        + seedsUsedEl
                        + " seeds, missing emitters: "
                        + missing(ISA_ELEMENT_EMIT, hit));
    }

    @Test
    void seededLightDesignsCoverCslFieldPrintEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 120_000L;
        for (; s < limit && hit.size() < FIELD_EMIT.size(); s++) {
            Random r = new Random(s);
            CslGenDesign d = new CslGenDesign("d");
            addLightFixture(d, r);
            List<CslGenField> fields = new ArrayList<>();
            collectFields(d, fields);
            StringBuilder blob = new StringBuilder();
            for (CslGenField f : fields) {
                f.appendPrintedCsl(blob);
                blob.append('\n');
            }
            appendOrphanCslFieldPrint(s, d, blob);
            String t = blob.toString();
            for (String k : FIELD_EMIT) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        long seedsUsedFld = s;
        assertEquals(
                FIELD_EMIT.size(),
                hit.size(),
                "after "
                        + seedsUsedFld
                        + " seeds, missing emitters: "
                        + missing(FIELD_EMIT, hit));
    }

    @Test
    void fullDesignBuildDeclSometimeAddsIsaContent() {
        boolean ok = false;
        for (long s = 0; s < 50_000 && !ok; s++) {
            CslGenDesign d = new CslGenDesign("d");
            d.buildDecl(new Random(s));
            CslGenIsaField ifield = null;
            CslGenIsaElement iel = null;
            for (CslGenCslBase ch : d.getChildren()) {
                if (ch instanceof CslGenIsaField f) {
                    ifield = f;
                } else if (ch instanceof CslGenIsaElement e) {
                    iel = e;
                }
            }
            if (ifield == null || iel == null) {
                continue;
            }
            StringBuilder o1 = new StringBuilder();
            ifield.appendPrintedCsl(o1);
            StringBuilder o2 = new StringBuilder();
            iel.appendPrintedCsl(o2);
            ok = o1.length() > 0 && o2.length() > 0;
        }
        assertTrue(ok, "expected a seed where design has isa_field + isa_element with non-empty print");
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
