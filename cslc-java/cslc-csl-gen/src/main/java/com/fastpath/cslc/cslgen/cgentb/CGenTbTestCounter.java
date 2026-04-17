package com.fastpath.cslc.cslgen.cgentb;

/**
 * Legacy global {@code testCounter} ({@code cGenBase_tb.cpp}): incremented in {@code closeFile} once per generated output file
 * closed. {@link CGenTbRunStub#runAfterLegacyRunChecksWithReport} reads {@link #get()} for the
 * report {@code "Test count :"} line; TB code can call {@link #increment()} whenever it finishes an output file.
 */
public final class CGenTbTestCounter {

    private int count;

    public void increment() {
        count++;
    }

    public int get() {
        return count;
    }
}
