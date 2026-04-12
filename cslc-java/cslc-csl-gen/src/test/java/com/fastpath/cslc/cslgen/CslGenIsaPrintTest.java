package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenIsaPrintTest {

    @Test
    void isaFieldPrintContainsKeyword() {
        String text = "";
        for (long s = 0; s < 400; s++) {
            CslGenDesign d = new CslGenDesign("d");
            CslGenIsaField f = new CslGenIsaField(d, "if0");
            f.buildDecl(new Random(s));
            StringBuilder out = new StringBuilder();
            f.appendPrintedCsl(out);
            text = out.toString();
            if (text.contains("csl_isa_field")) {
                break;
            }
        }
        assertTrue(text.contains("csl_isa_field"));
    }

    @Test
    void isaElementPrintContainsKeyword() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenIsaElement el = new CslGenIsaElement(d, "ie0");
        el.buildDecl(new Random(13L));
        StringBuilder out = new StringBuilder();
        el.appendPrintedCsl(out);
        assertTrue(out.toString().contains("csl_isa_element"));
    }

    @Test
    void isaFieldUsedAtRejectsOutOfRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenIsaField f = new CslGenIsaField(d, "if0");
        assertThrows(IndexOutOfBoundsException.class, () -> f.getIsaFieldUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> f.getIsaFieldUsedAt(CslGenIsaTables.ISA_FIELD_USED_VECTOR_SIZE));
    }

    @Test
    void isaFieldTypeDeclUsedAtRejectsOutOfRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenIsaField f = new CslGenIsaField(d, "if0");
        assertThrows(IndexOutOfBoundsException.class, () -> f.getIsaFieldTypeDeclUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> f.getIsaFieldTypeDeclUsedAt(CslGenIsaTables.ISA_FIELD_TYPE_DECL_SIZE));
    }

    @Test
    void isaFieldAccessorsAfterBuildDecl() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenIsaField f = new CslGenIsaField(d, "if0");
        f.buildDecl(new Random(19L));
        for (int i = 0; i < CslGenIsaTables.ISA_FIELD_USED_VECTOR_SIZE; i++) {
            int v = f.getIsaFieldUsedAt(i);
            assertTrue(v == 0 || v == 1);
        }
        for (int i = 0; i < CslGenIsaTables.ISA_FIELD_TYPE_DECL_SIZE; i++) {
            int td = f.getIsaFieldTypeDeclUsedAt(i);
            assertTrue(td == 0 || td == 1);
        }
        f.getWidthText();
        f.getSetTypeText();
        f.getPosFieldNames();
        assertThrows(UnsupportedOperationException.class, () -> f.getPosFieldNames().add("x"));
    }

    @Test
    void isaElementUsedAtRejectsOutOfRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenIsaElement el = new CslGenIsaElement(d, "ie0");
        assertThrows(IndexOutOfBoundsException.class, () -> el.getIsaElementUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> el.getIsaElementUsedAt(CslGenIsaTables.ISA_ELEMENT_USED_VECTOR_SIZE));
    }

    @Test
    void isaElementAccessorsAfterBuildDecl() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenIsaElement el = new CslGenIsaElement(d, "ie0");
        el.buildDecl(new Random(13L));
        for (int i = 0; i < CslGenIsaTables.ISA_ELEMENT_USED_VECTOR_SIZE; i++) {
            int v = el.getIsaElementUsedAt(i);
            assertTrue(v == 0 || v == 1);
        }
        el.getSetTypeText();
        el.getDerivText();
        el.getPosFieldNames();
        assertThrows(UnsupportedOperationException.class, () -> el.getNextLeftStrings().add("x"));
    }

    @Test
    void isaFieldAddFieldInstanceNullDesignIsNoOp() {
        CslGenIsaField f = new CslGenIsaField(new CslGenDesign("d"), "if0");
        f.addFieldInstance(null, new Random(1L));
    }

    @Test
    void isaElementAddIsaElementInstanceNullDesignIsNoOp() {
        CslGenIsaElement el = new CslGenIsaElement(new CslGenDesign("d"), "ie0");
        el.addIsaElementInstance(null, new Random(1L));
    }
}
