package com.fastpath.cslc.cslgen.cgentb;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.nio.file.Path;
import java.util.Objects;

/**
 * Legacy {@code createReport} ({@code cGenBase_tb.cpp}): report file path under {@code absoluteTestPath} and the three
 * summary lines written to the report stream. {@code testCount} is legacy {@code testCounter} (incremented per
 * {@code closeFile} in C++; use {@link CGenTbTestCounter} in Java).
 */
public final class CGenTbReport {

    private CGenTbReport() {}

    /**
     * Same layout as C++ {@code string(absoluteTestPath).append(REPORT_FILE_NAME).append(intToString(tgType))} with
     * {@link CGenConsts#REPORT_FILE_NAME} ({@code "/report_cg"}) and {@code ETestGen} ordinal.
     */
    public static Path reportFilePath(Path absoluteTestGenRoot, CGenTbTestGen tgType) {
        Objects.requireNonNull(absoluteTestGenRoot, "absoluteTestGenRoot");
        Objects.requireNonNull(tgType, "tgType");
        String suffix =
                CGenConsts.REPORT_FILE_NAME.startsWith("/")
                        ? CGenConsts.REPORT_FILE_NAME.substring(1)
                        : CGenConsts.REPORT_FILE_NAME;
        return absoluteTestGenRoot.resolve(suffix + tgType.ordinal());
    }

    /** Legacy {@code createReport} body (no {@code ofstream}). */
    public static void appendReportText(String binaryName, int testCount, long elapsedSeconds, StringBuilder out) {
        Objects.requireNonNull(binaryName, "binaryName");
        Objects.requireNonNull(out, "out");
        out.append("Executed ").append(binaryName).append('\n');
        out.append("Test count : ").append(testCount).append('\n');
        out.append("Time elapsed(s) : ").append(elapsedSeconds).append('\n');
    }
}
