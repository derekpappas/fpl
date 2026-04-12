package com.fastpath.cslc.support;

import java.io.IOException;
import java.nio.file.FileAlreadyExistsException;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.util.Objects;

/**
 * Java analogue of Boost.Filesystem {@code create_directories}, {@code extension}, {@code basename}, and
 * {@code change_extension} from {@code trunk/cslc/trunk/include/src/convenience.cpp} — use {@link java.nio.file}
 * instead of vendoring Boost.
 */
public final class FilesystemConvenience {

    private FilesystemConvenience() {}

    /**
     * @return {@code false} if the path already exists as a directory (or, for Boost, empty path); {@code true} if a
     *         new directory was created.
     * @throws FileAlreadyExistsException if the path exists and is not a directory
     */
    public static boolean createDirectories(Path ph) throws IOException {
        Objects.requireNonNull(ph, "ph");
        ph = ph.toAbsolutePath().normalize();
        if (isEmptyPath(ph)) {
            return false;
        }
        if (Files.exists(ph, LinkOption.NOFOLLOW_LINKS)) {
            if (!Files.isDirectory(ph)) {
                throw new FileAlreadyExistsException(ph.toString());
            }
            return false;
        }
        Path parent = ph.getParent();
        if (parent != null && !Files.exists(parent)) {
            createDirectories(parent);
        }
        Files.createDirectory(ph);
        return true;
    }

    private static boolean isEmptyPath(Path ph) {
        return ph.getNameCount() == 0 && !ph.isAbsolute();
    }

    /** Filename suffix from the last {@code '.'} in the leaf name (including the dot), or empty. */
    public static String extension(Path ph) {
        String leaf = leafName(ph);
        int n = leaf.lastIndexOf('.');
        return n >= 0 ? leaf.substring(n) : "";
    }

    /** Leaf name without trailing extension segment (legacy Boost {@code basename}). */
    public static String basename(Path ph) {
        String leaf = leafName(ph);
        int n = leaf.lastIndexOf('.');
        return n >= 0 ? leaf.substring(0, n) : leaf;
    }

    /** Parent directory + {@code basename(ph) + newExtension}. */
    public static Path changeExtension(Path ph, String newExtension) {
        Objects.requireNonNull(ph, "ph");
        Objects.requireNonNull(newExtension, "newExtension");
        Path parent = ph.getParent();
        String base = basename(ph);
        Path name = Path.of(base + newExtension);
        return parent == null ? name : parent.resolve(name);
    }

    private static String leafName(Path ph) {
        Path leaf = ph.getFileName();
        return leaf == null ? "" : leaf.toString();
    }
}
