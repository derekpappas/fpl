package com.fastpath.cslc.csim;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

/** Staged singleton matching legacy {@code CsimSimulator::getInstance()} wiring surface. */
public final class CsimSimulatorStub implements CsimSimulatorPort {

    private final List<CsimUnitPort> units = new ArrayList<>();
    private final List<CsimClockPort> clocks = new ArrayList<>();
    private final List<CsimVectorWriterPort> vectorWriters = new ArrayList<>();

    public static CsimSimulatorStub getInstance() {
        return Holder.INSTANCE;
    }

    @Override
    public void sortExecs(String fileName) {
        // Legacy: topological sort of execution blocks — not ported.
    }

    @Override
    public void registerUnit(CsimUnitPort unit) {
        units.add(unit);
    }

    @Override
    public void registerClock(CsimClockPort clock) {
        clocks.add(clock);
    }

    @Override
    public void registerVectorWriter(CsimVectorWriterPort vectorWriter) {
        vectorWriters.add(vectorWriter);
    }

    @Override
    public List<CsimUnitPort> getUnits() {
        return Collections.unmodifiableList(units);
    }

    @Override
    public List<CsimClockPort> getClocks() {
        return Collections.unmodifiableList(clocks);
    }

    @Override
    public List<CsimVectorWriterPort> getVectorWriters() {
        return Collections.unmodifiableList(vectorWriters);
    }

    @Override
    public Optional<CsimUnitPort> getRootUnit() {
        return Optional.empty();
    }

    @Override
    public Optional<CsimUnitPort> getUnitByName(String name) {
        if (name == null) {
            return Optional.empty();
        }
        for (CsimUnitPort u : units) {
            if (Objects.equals(name, u.unitName())) {
                return Optional.of(u);
            }
        }
        return Optional.empty();
    }

    @Override
    public Optional<CsimClockPort> getClockByName(String name) {
        if (name == null) {
            return Optional.empty();
        }
        for (CsimClockPort c : clocks) {
            if (Objects.equals(name, c.name())) {
                return Optional.of(c);
            }
        }
        return Optional.empty();
    }

    @Override
    public void cycle() {
        // Legacy: execute units, vector writers, flip-flop propagate, clock advance — not ported.
    }

    /**
     * Clears registered units, clocks, and vector writers. Package-private so tests in this package can reset the
     * singleton between runs (production code should not call this).
     */
    void resetForTesting() {
        units.clear();
        clocks.clear();
        vectorWriters.clear();
    }

    private static final class Holder {
        static final CsimSimulatorStub INSTANCE = new CsimSimulatorStub();
    }

    private CsimSimulatorStub() {}
}
