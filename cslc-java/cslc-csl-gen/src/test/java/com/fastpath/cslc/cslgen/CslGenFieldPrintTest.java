package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenFieldPrintTest {

    @Test
    void fieldPrintContainsKeyword() {
        String text = "";
        for (long s = 0; s < 400; s++) {
            CslGenDesign d = new CslGenDesign("d");
            CslGenField f = new CslGenField(d, "f0");
            f.buildDecl(new Random(s));
            StringBuilder out = new StringBuilder();
            f.appendPrintedCsl(out);
            text = out.toString();
            if (text.contains("csl_field")) {
                break;
            }
        }
        assertTrue(text.contains("csl_field"));
    }

    @Test
    void fieldUsedAtRejectsOutOfRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenField f = new CslGenField(d, "f");
        assertThrows(IndexOutOfBoundsException.class, () -> f.getFieldUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> f.getFieldUsedAt(CslGenFieldTables.FIELD_USED_VECTOR_SIZE));
    }

    @Test
    void fieldTypeDeclUsedAtRejectsOutOfRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenField f = new CslGenField(d, "f");
        assertThrows(IndexOutOfBoundsException.class, () -> f.getFieldTypeDeclUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> f.getFieldTypeDeclUsedAt(CslGenFieldTables.FIELD_TYPE_DECL_SIZE));
    }

    @Test
    void fieldAccessorsAfterBuild() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenField f = new CslGenField(d, "f0");
        f.buildDecl(new Random(11L));
        for (int i = 0; i < CslGenFieldTables.FIELD_USED_VECTOR_SIZE; i++) {
            int v = f.getFieldUsedAt(i);
            assertTrue(v == 0 || v == 1);
        }
        for (int i = 0; i < CslGenFieldTables.FIELD_TYPE_DECL_SIZE; i++) {
            int v = f.getFieldTypeDeclUsedAt(i);
            assertTrue(v == 0 || v == 1);
        }
        f.getEnumNameText();
        f.getWidthText();
        f.getPosFieldNames();
        assertThrows(UnsupportedOperationException.class, () -> f.getPosFieldNames().add("x"));
    }
}
