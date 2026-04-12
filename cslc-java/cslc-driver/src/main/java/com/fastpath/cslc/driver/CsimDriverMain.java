package com.fastpath.cslc.driver;

import com.fastpath.cslc.csim.CsimSimulatorPort;

/**
 * Java stand-in for {@code trunk/cslc/trunk/driver/csim_driver/CSIM_Driver.cpp} ({@code MyInterface} +
 * {@code start_simulation}).
 */
public final class CsimDriverMain {

    public static void main(String[] args) {
        System.err.println("[csim-driver] CSimulator interface / flip-flop sample not ported; csim stub cycle.");
        CsimSimulatorPort.instance().cycle();
    }

    private CsimDriverMain() {}
}
