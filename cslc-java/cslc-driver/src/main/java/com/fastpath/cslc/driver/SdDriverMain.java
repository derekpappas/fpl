package com.fastpath.cslc.driver;

import com.fastpath.cslc.csim.CsimSimulatorPort;

/**
 * Java stand-in for {@code trunk/cslc/trunk/driver/csim_driver/SD_Driver.cpp} (TopUnit + {@code CSimulator}).
 */
public final class SdDriverMain {

    public static void main(String[] args) {
        System.err.println("[sd-driver] CSimUnit / CSimulator not ported; invoking csim stub cycle.");
        CsimSimulatorPort.instance().cycle();
    }

    private SdDriverMain() {}
}
