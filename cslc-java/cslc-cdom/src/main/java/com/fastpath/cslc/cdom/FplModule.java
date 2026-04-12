package com.fastpath.cslc.cdom;

import java.util.Objects;

/**
 * Java stand-in for {@code fpl_module} ({@code trunk/cslc/trunk/src/cdom/fpl_module_class.h} / {@code fpl_module_class.cpp})
 * without linking SystemC — preserves naming and the abstract hooks used by generated models.
 */
public abstract class FplModule {

    private final String moduleName;

    protected FplModule(String moduleName) {
        this.moduleName = Objects.requireNonNull(moduleName, "moduleName");
    }

    public final String getModuleName() {
        return moduleName;
    }

    public abstract void createInstVec(String inst);

    public abstract void createInstVcd(String inst);
}
