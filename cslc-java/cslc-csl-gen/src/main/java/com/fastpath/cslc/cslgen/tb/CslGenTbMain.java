package com.fastpath.cslc.cslgen.tb;

import java.util.random.RandomGenerator;

/**
 * Legacy {@code main()} from {@code trunk/cslc/trunk/csl_gen/cslGen_TB.cpp} — writes generated CSL to stdout.
 */
public final class CslGenTbMain {

    private CslGenTbMain() {}

    public static void main(String[] args) {
        StringBuilder out = new StringBuilder();
        CslGenTbGenerator gen = new CslGenTbGenerator(out, RandomGenerator.getDefault());
        gen.build();
        System.out.print(out);
    }
}
