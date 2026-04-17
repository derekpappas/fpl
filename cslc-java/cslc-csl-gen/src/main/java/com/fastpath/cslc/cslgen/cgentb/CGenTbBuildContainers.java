package com.fastpath.cslc.cslgen.cgentb;

/**
 * Legacy {@code buildContainers} ({@code cGenBase_tb.cpp}): {@code buildGenericNames}, {@code buildClassNames},
 * {@code buildObjNames}, {@code buildCmdNames}, {@code buildDeclVectors}. Java keeps names on {@link CGenTbEslClass} /
 * {@link CGenTbCmdType}; {@link #run()} loads {@link CGenTbContainers} lookup tables (same ordering as {@code runTestGen}).
 */
public final class CGenTbBuildContainers {

    private CGenTbBuildContainers() {}

    /** Ensures {@link CGenTbContainers} singleton is initialized (idempotent). */
    public static void run() {
        CGenTbContainers.get();
    }
}
