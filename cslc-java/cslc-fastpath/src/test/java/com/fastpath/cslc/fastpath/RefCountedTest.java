package com.fastpath.cslc.fastpath;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.concurrent.atomic.AtomicInteger;
import org.junit.jupiter.api.Test;

class RefCountedTest {

    static final class Track extends RefCounted {
        final AtomicInteger zero = new AtomicInteger();

        @Override
        protected void onZeroReferences() {
            zero.incrementAndGet();
        }
    }

    @Test
    void referenceReleaseMatchesLegacyCounts() {
        Track t = new Track();
        assertEquals(1, t.reference());
        assertEquals(2, t.reference());
        assertEquals(1, t.release());
        assertEquals(0, t.release());
        assertEquals(0, t.release());
        assertEquals(1, t.zero.get());
    }
}
