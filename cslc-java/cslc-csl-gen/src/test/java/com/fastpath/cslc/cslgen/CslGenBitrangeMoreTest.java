package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

/** Extra coverage for {@link CslGenBitrange} accessors, {@code buildSet}, and no-arg {@code buildDecl}. */
class CslGenBitrangeMoreTest {

    @Test
    void noArgBuildDeclDispatchesToDefaultGenerator() {
        CslGenBitrange br = new CslGenBitrange(new CslGenDesign("d"), "b0");
        br.buildDecl();
    }

    @Test
    void offsetWidthAccessorsAndIsWidthSet() {
        CslGenBitrange br = new CslGenBitrange(new CslGenDesign("d"), "b1");
        assertTrue(br.setWidth(8));
        assertTrue(br.isWidthSet());
        assertTrue(br.setOffset(3));
        assertEquals(3, br.getOffset());
        assertEquals(8, br.getWidth());
    }

    @Test
    void printWithoutPrintSinkIsNoOp() {
        CslGenBitrange br = new CslGenBitrange(new CslGenDesign("d"), "b2");
        br.buildDecl(new Random(5L));
        br.print();
    }

    @Test
    void buildSetWithSinkEventuallyEmitsSetOffset() {
        CslGenBitrange br = new CslGenBitrange(new CslGenDesign("d"), "b3");
        br.buildDecl(new Random(7L));
        boolean saw = false;
        for (long s = 0; s < 500 && !saw; s++) {
            final long seed = s;
            StringBuilder sink = new StringBuilder();
            CslGenCslBase.runWithPrintSink(sink, () -> br.buildSet("scopeX", new Random(seed)));
            if (sink.toString().contains("set_offset")) {
                saw = true;
            }
        }
        assertTrue(saw, "expected buildSet to emit set_offset for some RNG seed");
    }

    @Test
    void buildSetWithoutSinkIsNoOp() {
        CslGenBitrange br = new CslGenBitrange(new CslGenDesign("d"), "b4");
        br.buildDecl(new Random(9L));
        br.buildSet("s", new Random(1L));
    }

    /**
     * {@link CslGenBitrange#buildDecl(RandomGenerator)} ends with {@code return false} for decl forms outside {@code
     * 0..BITR_DECL_MAX-1}; a contrived {@link Random} can supply an out-of-range decl index.
     */
    @Test
    void buildDeclWithOutOfRangeFormReturnsFalse() {
        CslGenBitrange br = new CslGenBitrange(new CslGenDesign("d"), "b5");
        Random bogus =
                new Random(0L) {
                    @Override
                    public int nextInt(int bound) {
                        if (bound == CslGenBitrange.BITR_DECL_MAX) {
                            return CslGenBitrange.BITR_DECL_MAX;
                        }
                        return super.nextInt(bound);
                    }
                };
        assertFalse(br.buildDecl(bogus));
    }
}
