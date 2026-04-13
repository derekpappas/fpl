package com.fastpath.cslc.csim;

import java.util.Objects;

/**
 * Minimal {@link CsimUnitPort} toward {@code CsimUnit::getUnitName} / {@code getInstanceName} ({@code CsimUnit.h}).
 */
public final class CsimUnitStub implements CsimUnitPort {

    private final String unitName;
    private final String instanceName;

    public CsimUnitStub(String unitName, String instanceName) {
        this.unitName = Objects.requireNonNull(unitName, "unitName");
        this.instanceName = Objects.requireNonNull(instanceName, "instanceName");
    }

    @Override
    public String unitName() {
        return unitName;
    }

    @Override
    public String instanceName() {
        return instanceName;
    }
}
