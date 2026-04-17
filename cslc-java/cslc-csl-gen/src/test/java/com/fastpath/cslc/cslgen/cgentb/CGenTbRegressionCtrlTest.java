package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class CGenTbRegressionCtrlTest {

    @Test
    void writeValidAndInvalidBodies(@TempDir Path root) throws Exception {
        Path v = Files.createDirectories(root.resolve("v"));
        Path inv = Files.createDirectories(root.resolve("inv"));
        CGenTbRegressionCtrl.write(v, true);
        CGenTbRegressionCtrl.write(inv, false);
        assertTrue(Files.readString(v.resolve(CGenConsts.REGRESSION_CTRL_FILE_NAME)).contains("is_valid = 1"));
        assertTrue(Files.readString(inv.resolve(CGenConsts.REGRESSION_CTRL_FILE_NAME)).contains("is_valid = 0"));
    }
}
