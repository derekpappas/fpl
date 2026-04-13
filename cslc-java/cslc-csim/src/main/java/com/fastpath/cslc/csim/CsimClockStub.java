package com.fastpath.cslc.csim;

import java.util.Objects;

/**
 * Minimal {@link CsimClockPort} toward {@code NSCsimLib::CsimClock} ({@code trunk/cslc/trunk/src/csim/CsimClock.h}):
 * name, period, cycle counter, {@link #next()}.
 */
public final class CsimClockStub implements CsimClockPort {

    private final String name;
    private final long period;
    private int cycleNo;

    public CsimClockStub(String name, long period) {
        this.name = Objects.requireNonNull(name, "name");
        if (period <= 0) {
            throw new IllegalArgumentException("period must be positive");
        }
        this.period = period;
    }

    @Override
    public String name() {
        return name;
    }

    @Override
    public long getPeriod() {
        return period;
    }

    /** Legacy {@code CsimClock::getCycleNo()} / {@code getCycleNo} naming in header. */
    @Override
    public int getCycleNo() {
        return cycleNo;
    }

    /** Legacy {@code CsimClock::next()} — advances simulation cycle counter (stub). */
    @Override
    public void next() {
        cycleNo++;
    }
}
