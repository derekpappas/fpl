package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenMemMapPrintTest {

    @Test
    void memMapPagePrintsHeader() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(7L);
        d.addMemMapPage(rng);
        CslGenMemMapPage page = d.getChildren().stream()
                .filter(CslGenMemMapPage.class::isInstance)
                .map(CslGenMemMapPage.class::cast)
                .findFirst()
                .orElseThrow();
        StringBuilder out = new StringBuilder();
        page.appendPrintedCsl(out);
        String t = out.toString();
        assertTrue(t.startsWith("csl_memory_map_page "));
        assertTrue(t.endsWith(";\n"));
    }

    @Test
    void memMapPageUsedAtRejectsOutOfRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenMemMapPage page = new CslGenMemMapPage(d, "p");
        assertThrows(IndexOutOfBoundsException.class, () -> page.getMemMapPageUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> page.getMemMapPageUsedAt(CslGenMemoryMapTables.MMP_USED_VECTOR_SIZE));
    }

    @Test
    void memMapPageAccessorsAfterBuild() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(7L);
        d.addMemMapPage(rng);
        CslGenMemMapPage page = d.getChildren().stream()
                .filter(CslGenMemMapPage.class::isInstance)
                .map(CslGenMemMapPage.class::cast)
                .findFirst()
                .orElseThrow();
        for (int i = 0; i < CslGenMemoryMapTables.MMP_USED_VECTOR_SIZE; i++) {
            int v = page.getMemMapPageUsedAt(i);
            assertTrue(v == 0 || v == 1);
        }
        page.getLowerBoundText();
        page.getAccRightText();
        page.isBaseAddrF();
    }

    @Test
    void memMapPrintsHeader() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(8L);
        d.addMemMapPage(rng);
        d.addMemMap(rng);
        CslGenMemMap mm = d.getChildren().stream()
                .filter(CslGenMemMap.class::isInstance)
                .map(CslGenMemMap.class::cast)
                .findFirst()
                .orElseThrow();
        StringBuilder out = new StringBuilder();
        mm.appendPrintedCsl(out);
        String t = out.toString();
        assertTrue(t.startsWith("csl_memory_map "));
        assertTrue(t.endsWith(";\n"));
    }

    @Test
    void memMapUsedAtRejectsOutOfRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenMemMap mm = new CslGenMemMap(d, "m");
        assertThrows(IndexOutOfBoundsException.class, () -> mm.getMemMapUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> mm.getMemMapUsedAt(CslGenMemoryMapTables.MM_USED_VECTOR_SIZE));
    }

    @Test
    void memMapAccessorsAfterBuild() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(8L);
        d.addMemMapPage(rng);
        d.addMemMap(rng);
        CslGenMemMap mm = d.getChildren().stream()
                .filter(CslGenMemMap.class::isInstance)
                .map(CslGenMemMap.class::cast)
                .findFirst()
                .orElseThrow();
        for (int i = 0; i < CslGenMemoryMapTables.MM_USED_VECTOR_SIZE; i++) {
            int v = mm.getMemMapUsedAt(i);
            assertTrue(v == 0 || v == 1);
        }
        mm.getTopUnitText();
        mm.getMmpNames();
        mm.getEnumNames();
        mm.getEnumNameFlags();
        assertThrows(UnsupportedOperationException.class, () -> mm.getMmpNames().add("x"));
    }
}
