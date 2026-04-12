package com.fastpath.cslc.fastpath;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * Port of {@code RefCounted} ({@code trunk/cslc/trunk/src/FastPath/refcounted.h} / empty {@code refcounted.cpp}).
 * Java has no {@code delete this}; when the count drops to zero {@link #onZeroReferences()} runs so subclasses can
 * release native or external resources.
 */
public abstract class RefCounted {

    private final AtomicInteger counter = new AtomicInteger(0);

    public int reference() {
        return counter.incrementAndGet();
    }

    public int release() {
        for (;;) {
            int c = counter.get();
            if (c <= 0) {
                return 0;
            }
            if (counter.compareAndSet(c, c - 1)) {
                if (c == 1) {
                    onZeroReferences();
                }
                return c - 1;
            }
        }
    }

    /** Invoked once when {@link #release} drives the count to zero or below. */
    protected void onZeroReferences() {}

    public int getCount() {
        return counter.get();
    }
}
