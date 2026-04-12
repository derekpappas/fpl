package com.fastpath.cslc.support;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.FileAlreadyExistsException;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class FilesystemConvenienceTest {

    @Test
    void extensionAndBasenameMatchBoostSemantics() {
        Path p = Path.of("dir", "file.v");
        assertEquals(".v", FilesystemConvenience.extension(p));
        assertEquals("file", FilesystemConvenience.basename(p));
        assertEquals(Path.of("dir", "file.sv"), FilesystemConvenience.changeExtension(p, ".sv"));
    }

    @Test
    void extensionEmptyWhenNoDot() {
        assertEquals("", FilesystemConvenience.extension(Path.of("README")));
        assertEquals("README", FilesystemConvenience.basename(Path.of("README")));
    }

    @Test
    void createDirectoriesCreatesTree(@TempDir Path tmp) throws Exception {
        Path nested = tmp.resolve("a").resolve("b").resolve("c");
        assertTrue(FilesystemConvenience.createDirectories(nested));
        assertTrue(Files.isDirectory(nested));
        assertFalse(FilesystemConvenience.createDirectories(nested));
    }

    @Test
    void createDirectoriesRejectsPlainFile(@TempDir Path tmp) throws Exception {
        Path f = tmp.resolve("notdir");
        Files.writeString(f, "x");
        assertThrows(FileAlreadyExistsException.class, () -> FilesystemConvenience.createDirectories(f));
    }
}
