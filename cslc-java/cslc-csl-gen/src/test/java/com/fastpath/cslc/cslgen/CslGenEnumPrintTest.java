package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenEnumPrintTest {

    @Test
    void enumPrintsBlockWithItems() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(42L);
        d.addEnum(rng);
        CslGenEnum en = d.getChildren().stream()
                .filter(CslGenEnum.class::isInstance)
                .map(CslGenEnum.class::cast)
                .findFirst()
                .orElseThrow();
        StringBuilder out = new StringBuilder();
        en.appendPrintedCsl(out);
        String t = out.toString();
        assertTrue(t.startsWith("csl_enum "));
        assertTrue(t.contains(" {\n"));
        assertTrue(t.endsWith("};\n"));
    }

    @Test
    void getEnumItemsMatchesItemChildren() {
        CslGenDesign d = new CslGenDesign("d");
        d.addEnum(new Random(42L));
        CslGenEnum en = d.getChildren().stream()
                .filter(CslGenEnum.class::isInstance)
                .map(CslGenEnum.class::cast)
                .findFirst()
                .orElseThrow();
        int itemChildren = (int)
                en.getChildren().stream().filter(CslGenEnumItem.class::isInstance).count();
        assertTrue(itemChildren > 0);
        assertEquals(itemChildren, en.getEnumItems().size());
        assertThrows(UnsupportedOperationException.class, () -> en.getEnumItems().add(null));
    }
}
