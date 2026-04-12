package com.fastpath.cslc.driver;

/**
 * Java stand-in for {@code trunk/cslc/trunk/driver/cdom_drivers/CDOM_VerilogGeneratorDriver.cpp}. Legacy builds a
 * {@code CDOmDesign}, adds port items, runs {@code CVerilogGenerator} — pending CDOM + visitor port.
 */
public final class CdomVerilogGeneratorDriverMain {

    public static void main(String[] args) {
        System.err.println(
                "[cdom-verilog-driver] CDOmDesign / CVerilogGenerator traversal not ported (args=" + args.length + ").");
    }

    private CdomVerilogGeneratorDriverMain() {}
}
