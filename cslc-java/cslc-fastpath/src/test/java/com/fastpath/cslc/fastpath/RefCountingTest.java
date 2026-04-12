package com.fastpath.cslc.fastpath;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;

import java.util.concurrent.atomic.AtomicInteger;
import org.junit.jupiter.api.Test;

class RefCountingTest {

    static final class N extends RefCounted {
        final AtomicInteger zero = new AtomicInteger();

        @Override
        protected void onZeroReferences() {
            zero.incrementAndGet();
        }
    }

    @Test
    void setReleasesPreviousAndReferencesNew() {
        N a = new N();
        N b = new N();
        RefCounting<N> r = new RefCounting<>();
        r.set(a);
        assertSame(a, r.get());
        assertEquals(1, a.getCount());
        r.set(b);
        assertEquals(1, a.zero.get());
        assertSame(b, r.get());
        assertEquals(1, b.getCount());
        r.clear();
        assertNull(r.get());
        assertEquals(1, b.zero.get());
    }
}
