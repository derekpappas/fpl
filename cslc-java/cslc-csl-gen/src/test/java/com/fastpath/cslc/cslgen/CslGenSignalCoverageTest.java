package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;
import org.junit.jupiter.api.Test;

/** Drives {@link CslGenSignal} {@code buildDecl} / {@code print} across all {@code SIG_DECL_*} forms. */
class CslGenSignalCoverageTest {

    @Test
    void seededDesignsExerciseAllSignalDeclForms() {
        Set<Integer> seen = new HashSet<>();
        long s = 0;
        long limit = 60_000L;
        for (; s < limit && seen.size() < CslGenSignal.SIG_DECL_MAX; s++) {
            Random r = new Random(s);
            CslGenDesign d = new CslGenDesign("d");
            for (int i = 0; i < 12; i++) {
                d.addBitrange(r);
            }
            for (int i = 0; i < 12; i++) {
                d.addSignal(r);
            }
            for (CslGenCslBase ch : d.getChildren()) {
                if (ch instanceof CslGenSignal sig) {
                    StringBuilder out = new StringBuilder();
                    sig.appendPrintedCsl(out);
                    if (out.length() > 0) {
                        seen.add(sig.getDeclForm());
                    }
                }
            }
        }
        assertEquals(
                CslGenSignal.SIG_DECL_MAX,
                seen.size(),
                "after " + s + " seeds, missing decl forms: " + missingForms(seen));
    }

    @Test
    void noArgBuildDeclDispatchesToDefaultGenerator() {
        CslGenSignal sig = new CslGenSignal(new CslGenDesign("d"), "s0");
        sig.buildDecl();
    }

    @Test
    void offsetAccessorAndSetOffset() {
        CslGenSignal sig = new CslGenSignal(new CslGenDesign("d"), "s1");
        assertTrue(sig.setWidth(4));
        assertTrue(sig.setOffset(2));
        assertEquals(2, sig.getOffset());
    }

    @Test
    void printWithoutPrintSinkIsNoOp() {
        CslGenSignal sig = new CslGenSignal(new CslGenDesign("d"), "s2");
        sig.buildDecl(new Random(4L));
        sig.print();
    }

    @Test
    void buildSetWithoutSinkIsNoOp() {
        CslGenSignal sig = new CslGenSignal(new CslGenDesign("d"), "s3");
        sig.buildDecl(new Random(6L));
        sig.buildSet("sc", new Random(1L));
    }

    @Test
    void buildSetEmitsSetRange() {
        long declSeed = findDeclSeedWhereFormIsEmptyOrTypeOnly(25_000);
        assertTrue(declSeed >= 0, "need EMPTY or TYPE decl so embedded width is unset");
        boolean found = false;
        for (long s = 0; s < 100_000 && !found; s++) {
            final long setSeed = s;
            CslGenSignal sig = new CslGenSignal(new CslGenDesign("dr" + s), "sr" + s);
            if (!sig.buildDecl(new Random(declSeed))) {
                continue;
            }
            StringBuilder sink = new StringBuilder();
            CslGenCslBase.runWithPrintSink(sink, () -> sig.buildSet("sc", new Random(setSeed)));
            if (sink.toString().contains("set_range")) {
                found = true;
            }
        }
        assertTrue(found, "set_range from buildSet");
    }

    @Test
    void buildSetEmitsSetWidth() {
        long declSeed = findDeclSeedWhereFormIsEmptyOrTypeOnly(25_000);
        assertTrue(declSeed >= 0);
        boolean found = false;
        for (long s = 0; s < 100_000 && !found; s++) {
            final long setSeed = s;
            CslGenSignal sig = new CslGenSignal(new CslGenDesign("dw" + s), "sw" + s);
            if (!sig.buildDecl(new Random(declSeed))) {
                continue;
            }
            StringBuilder sink = new StringBuilder();
            CslGenCslBase.runWithPrintSink(sink, () -> sig.buildSet("sc", new Random(setSeed)));
            if (sink.toString().contains("set_width")) {
                found = true;
            }
        }
        assertTrue(found, "set_width from buildSet");
    }

    @Test
    void buildSetEmitsSetOffset() {
        long declSeed = findDeclSeedWhereFormIsEmptyOrTypeOnly(25_000);
        assertTrue(declSeed >= 0);
        boolean found = false;
        for (long s = 0; s < 100_000 && !found; s++) {
            final long setSeed = s;
            CslGenSignal sig = new CslGenSignal(new CslGenDesign("do" + s), "so" + s);
            if (!sig.buildDecl(new Random(declSeed))) {
                continue;
            }
            StringBuilder sink = new StringBuilder();
            CslGenCslBase.runWithPrintSink(sink, () -> sig.buildSet("sc", new Random(setSeed)));
            if (sink.toString().contains("set_offset")) {
                found = true;
            }
        }
        assertTrue(found, "set_offset from buildSet");
    }

    private static long findDeclSeedWhereFormIsEmptyOrTypeOnly(long max) {
        for (long b = 0; b < max; b++) {
            CslGenSignal p = new CslGenSignal(new CslGenDesign("dp" + b), "probe" + b);
            if (!p.buildDecl(new Random(b))) {
                continue;
            }
            int form = p.getDeclForm();
            if (form == CslGenSignal.SIG_DECL_EMPTY || form == CslGenSignal.SIG_DECL_TYPE) {
                return b;
            }
        }
        return -1;
    }

    @Test
    void randSelMethodsCallableWithPeersOnDesign() {
        CslGenDesign d = new CslGenDesign("d");
        Random r = new Random(11L);
        d.addBitrange(r);
        d.addSignal(r);
        CslGenSignal sig = new CslGenSignal(d, "probe");
        sig.randSelBitrange(new Random(12L));
        sig.randSelSignal(new Random(13L));
    }

    @Test
    void signalPrintContainsCslKeyword() {
        CslGenDesign d = new CslGenDesign("d");
        Random r = new Random(33L);
        for (int i = 0; i < 6; i++) {
            d.addBitrange(r);
        }
        d.addSignal(r);
        CslGenSignal sig =
                d.getChildren().stream()
                        .filter(CslGenSignal.class::isInstance)
                        .map(CslGenSignal.class::cast)
                        .findFirst()
                        .orElseThrow();
        StringBuilder out = new StringBuilder();
        sig.appendPrintedCsl(out);
        assertTrue(out.toString().contains("csl_signal"));
    }

    /**
     * When the signal has a design parent but is not listed among the design's children, {@link CslGenSignal#randSelSignal}
     * finds no peer {@code csl_signal}; {@code SIG_DECL_COPY} then returns {@code false} (legacy failure path).
     */
    @Test
    void buildDeclCopyFormReturnsFalseWhenSignalNotInDesignChildList() {
        boolean hit = false;
        for (long seed = 0; seed < 80_000L && !hit; seed++) {
            Random pre = new Random(seed ^ 0x9E3779B97F4A7C15L);
            CslGenDesign d = new CslGenDesign("d");
            for (int i = 0; i < 12; i++) {
                d.addRegister(pre);
            }
            CslGenSignal s = new CslGenSignal(d, "unlisted" + seed);
            Random rng = new Random(seed);
            boolean ok = s.buildDecl(rng);
            if (!ok && s.getDeclForm() == CslGenSignal.SIG_DECL_COPY) {
                hit = true;
            }
        }
        assertTrue(hit, "expected SIG_DECL_COPY + no peer signal for some seed");
    }

    private static Set<Integer> missingForms(Set<Integer> seen) {
        Set<Integer> m = new HashSet<>();
        for (int f = 0; f < CslGenSignal.SIG_DECL_MAX; f++) {
            if (!seen.contains(f)) {
                m.add(f);
            }
        }
        return m;
    }
}
