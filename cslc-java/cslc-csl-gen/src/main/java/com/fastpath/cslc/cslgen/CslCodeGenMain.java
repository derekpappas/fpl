package com.fastpath.cslc.cslgen;

import java.util.concurrent.ThreadLocalRandom;

/**
 * Entry point mirroring {@code trunk/cslc/trunk/csl_gen/csl_code_gen.cpp} ({@code main} + {@code CSLdesign}).
 */
public final class CslCodeGenMain {

    public static void main(String[] args) {
        ThreadLocalRandom.current().nextInt();
        CslGenDesign design = new CslGenDesign("design");
        design.buildDecl();
    }

    private CslCodeGenMain() {}
}
