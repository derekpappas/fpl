package com.fastpath.cslc.csim;

/**
 * Port surface for {@code NSCsimLib::CsimClock} ({@code trunk/cslc/trunk/src/csim/CsimClock.h}) — name, period, cycle
 * step. See {@link CsimClockStub}.
 */
public interface CsimClockPort {

    String name();

    long getPeriod();

    int getCycleNo();

    void next();
}
