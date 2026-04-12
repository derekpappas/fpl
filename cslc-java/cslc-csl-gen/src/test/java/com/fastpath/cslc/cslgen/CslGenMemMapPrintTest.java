package com.fastpath.cslc.cslgen;

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
}
