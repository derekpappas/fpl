package com.fastpath.cslc.fastpath;

import java.util.Objects;

/**
 * Port of {@code RefCounting<T>} ({@code refcounted.h}) — thin strong-reference holder with explicit refcounting on
 * {@link RefCounted} instances.
 *
 * @param <T> concrete {@link RefCounted} type
 */
public final class RefCounting<T extends RefCounted> {

    private T t;

    public RefCounting() {
        t = null;
    }

    public RefCounting(T initial) {
        t = null;
        set(initial);
    }

    public RefCounting(RefCounting<T> other) {
        Objects.requireNonNull(other, "other");
        t = null;
        set(other.t);
    }

    public T get() {
        return t;
    }

    public void set(T next) {
        if (t != null) {
            t.release();
        }
        t = next;
        if (t != null) {
            t.reference();
        }
    }

    public void clear() {
        set(null);
    }
}
