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
 * Targets JaCoCo gaps in {@link CslGenIsaField} / {@link CslGenField}: no-arg {@code buildDecl}, null-design branches in
 * enum helpers, and hierarchical {@code set_next} / {@code set_previous} / {@code get_type()} emit paths that need many
 * {@code CONSTR} command iterations plus {@link CslGenIsaField#addFieldInstance} / {@link CslGenField#addFieldInstance}.
 */
class CslGenModelHeavyHierarchicalCoverageTest {

    private static final List<String> ISA_HEAVY = List.of("set_next(", "set_previous(");

    private static final List<String> FIELD_HEAVY = List.of("set_next(", "set_previous(");

    private static final List<String> ISA_ELEMENT_HEAVY = List.of("set_next(", "set_previous(", "set_position(");

    private static void collectIsaFields(CslGenCslBase root, List<CslGenIsaField> out) {
        if (root instanceof CslGenIsaField f) {
            out.add(f);
        }
        for (CslGenCslBase ch : root.getChildren()) {
            collectIsaFields(ch, out);
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

    private static void collectIsaElements(CslGenCslBase root, List<CslGenIsaElement> out) {
        if (root instanceof CslGenIsaElement e) {
            out.add(e);
        }
        for (CslGenCslBase ch : root.getChildren()) {
            collectIsaElements(ch, out);
        }
    }

    /** Same as {@link CslGenDesign#addIsaField} but always runs {@link CslGenIsaField#addFieldInstance}. */
    private static void addIsaFieldWithInstances(CslGenDesign d, Random r) {
        String name = CslGenRandString.randString(r);
        if (!d.newNameIsValid(name)) {
            return;
        }
        CslGenIsaField f = new CslGenIsaField(d, name);
        for (int i = 0; i < CslGenIsaTables.ISA_FIELD_INSTANCE_NO; i++) {
            f.addFieldInstance(d, r);
        }
        if (f.buildDecl(r)) {
            d.addChild(f);
        }
    }

    /** Same as {@link CslGenDesign#addField} but always runs {@link CslGenField#addFieldInstance}. */
    private static void addCslFieldWithInstances(CslGenDesign d, Random r) {
        String name = CslGenRandString.randString(r);
        if (!d.newNameIsValid(name)) {
            return;
        }
        CslGenField f = new CslGenField(d, name);
        for (int i = 0; i < CslGenFieldTables.FIELD_INSTANCE_NO; i++) {
            f.addFieldInstance(d, r);
        }
        if (f.buildDecl(r)) {
            d.addChild(f);
        }
    }

    /** Same as {@link CslGenDesign#addIsaElement} but always runs {@link CslGenIsaElement#addIsaElementInstance}. */
    private static void addIsaElementWithInstances(CslGenDesign d, Random r) {
        String name = CslGenRandString.randString(r);
        if (!d.newNameIsValid(name)) {
            return;
        }
        CslGenIsaElement el = new CslGenIsaElement(d, name);
        for (int i = 0; i < CslGenIsaTables.ISA_ELEMENT_INSTANCE_NO; i++) {
            el.addIsaElementInstance(d, r);
        }
        el.buildDecl(r);
        d.addChild(el);
    }

    private static void addHeavyFixtureForIsaElements(CslGenDesign d, Random r) {
        for (int i = 0; i < 20; i++) {
            d.addBitrange(r);
        }
        for (int i = 0; i < 24; i++) {
            d.addEnum(r);
        }
        for (int i = 0; i < 40; i++) {
            addIsaFieldWithInstances(d, r);
        }
        for (int i = 0; i < 48; i++) {
            addIsaElementWithInstances(d, r);
        }
    }

    private static void addHeavyFixture(CslGenDesign d, Random r) {
        for (int i = 0; i < 24; i++) {
            d.addBitrange(r);
        }
        for (int i = 0; i < 28; i++) {
            d.addEnum(r);
        }
        for (int i = 0; i < 55; i++) {
            addIsaFieldWithInstances(d, r);
        }
        for (int i = 0; i < 14; i++) {
            d.addIsaElement(r);
        }
        for (int i = 0; i < 55; i++) {
            addCslFieldWithInstances(d, r);
        }
    }

    @Test
    void isaFieldNoArgBuildDeclUsesDefaultGenerator() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenIsaField f = new CslGenIsaField(d, "only");
        f.buildDecl();
    }

    @Test
    void cslFieldNoArgBuildDeclUsesDefaultGenerator() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenField f = new CslGenField(d, "only");
        f.buildDecl();
    }

    @Test
    void nullParentIsaFieldBuildDeclScansManySeeds() {
        for (long s = 0; s < 8_000; s++) {
            CslGenIsaField f = new CslGenIsaField(null, "orphIsa" + s);
            f.buildDecl(new Random(s));
        }
    }

    @Test
    void nullParentCslFieldBuildDeclScansManySeeds() {
        for (long s = 0; s < 8_000; s++) {
            CslGenField f = new CslGenField(null, "orphFld" + s);
            f.buildDecl(new Random(s));
        }
    }

    @Test
    void heavySeededDesignsCoverIsaHierarchicalEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 350_000L;
        for (; s < limit && hit.size() < ISA_HEAVY.size(); s++) {
            Random r = new Random(s);
            CslGenDesign d = new CslGenDesign("d");
            addHeavyFixture(d, r);
            List<CslGenIsaField> fields = new ArrayList<>();
            collectIsaFields(d, fields);
            StringBuilder blob = new StringBuilder();
            for (CslGenIsaField f : fields) {
                f.appendPrintedCsl(blob);
                blob.append('\n');
            }
            String t = blob.toString();
            for (String k : ISA_HEAVY) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        assertEquals(
                ISA_HEAVY.size(),
                hit.size(),
                "after " + s + " seeds, missing: " + missing(ISA_HEAVY, hit));
    }

    @Test
    void heavySeededDesignsCoverIsaElementHierarchicalEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 400_000L;
        for (; s < limit && hit.size() < ISA_ELEMENT_HEAVY.size(); s++) {
            Random r = new Random(s);
            CslGenDesign d = new CslGenDesign("d");
            addHeavyFixtureForIsaElements(d, r);
            List<CslGenIsaElement> els = new ArrayList<>();
            collectIsaElements(d, els);
            StringBuilder blob = new StringBuilder();
            for (CslGenIsaElement el : els) {
                el.appendPrintedCsl(blob);
                blob.append('\n');
            }
            String t = blob.toString();
            for (String k : ISA_ELEMENT_HEAVY) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        assertEquals(
                ISA_ELEMENT_HEAVY.size(),
                hit.size(),
                "after " + s + " seeds, missing: " + missing(ISA_ELEMENT_HEAVY, hit));
    }

    @Test
    void heavySeededDesignsCoverCslFieldHierarchicalEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 350_000L;
        for (; s < limit && hit.size() < FIELD_HEAVY.size(); s++) {
            Random r = new Random(s);
            CslGenDesign d = new CslGenDesign("d");
            addHeavyFixture(d, r);
            List<CslGenField> fields = new ArrayList<>();
            collectFields(d, fields);
            StringBuilder blob = new StringBuilder();
            for (CslGenField f : fields) {
                f.appendPrintedCsl(blob);
                blob.append('\n');
            }
            String t = blob.toString();
            for (String k : FIELD_HEAVY) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        assertEquals(
                FIELD_HEAVY.size(),
                hit.size(),
                "after " + s + " seeds, missing: " + missing(FIELD_HEAVY, hit));
    }

    @Test
    void heavyFixturePrintsNonEmptyForSomeSeed() {
        boolean nonEmpty = false;
        for (long s = 0; s < 500 && !nonEmpty; s++) {
            Random r = new Random(s);
            CslGenDesign d = new CslGenDesign("d");
            addHeavyFixture(d, r);
            StringBuilder blob = new StringBuilder();
            d.appendPrintedCsl(blob);
            nonEmpty = blob.length() > 200;
        }
        assertTrue(nonEmpty, "expected heavy fixture to produce substantial CSL output");
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
