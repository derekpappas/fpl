package com.fastpath.cslc.cslgen.cgentb;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.Objects;

/**
 * Legacy {@code createRegressionCtrl} ({@code cGenBase_tb.cpp}): writes {@link CGenConsts#REGRESSION_CTRL_FILE_NAME} under a
 * chapter {@code _valid} / {@code _invalid} leaf directory after {@code mkdir}.
 */
public final class CGenTbRegressionCtrl {

    private CGenTbRegressionCtrl() {}

    /**
     * Writes {@link CGenConsts#REGRESSION_CTRL_FILE_NAME} in {@code leafDirectory}. The directory must already exist (legacy
     * {@code mkdir} then {@code createRegressionCtrl}).
     */
    public static void write(Path leafDirectory, boolean valid) throws IOException {
        Objects.requireNonNull(leafDirectory, "leafDirectory");
        String body = valid ? CGenConsts.REGRESSION_CTRL_VALID : CGenConsts.REGRESSION_CTRL_INVALID;
        Path file = leafDirectory.resolve(CGenConsts.REGRESSION_CTRL_FILE_NAME);
        Files.writeString(file, body, StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }
}
