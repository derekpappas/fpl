package com.fastpath.cslc.csim;

import java.util.List;
import java.util.Optional;

/**
 * Port for {@code NSCsimLib::CsimSimulator} ({@code trunk/cslc/trunk/src/csim/CsimSimulator.h}).
 * {@link #instance()} corresponds to legacy {@code CsimSimulator::getInstance()}.
 */
public interface CsimSimulatorPort {

    static CsimSimulatorPort instance() {
        return CsimSimulatorStub.getInstance();
    }

    void sortExecs(String fileName);

    void registerUnit(CsimUnitPort unit);

    void registerClock(CsimClockPort clock);

    void registerVectorWriter(CsimVectorWriterPort vectorWriter);

    List<CsimUnitPort> getUnits();

    List<CsimClockPort> getClocks();

    /** Registered vector writers (legacy {@code m_vwVec}). */
    List<CsimVectorWriterPort> getVectorWriters();

    Optional<CsimUnitPort> getRootUnit();

    Optional<CsimUnitPort> getUnitByName(String name);

    Optional<CsimClockPort> getClockByName(String name);

    void cycle();
}
