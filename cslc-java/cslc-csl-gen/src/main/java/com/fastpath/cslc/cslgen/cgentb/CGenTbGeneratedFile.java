package com.fastpath.cslc.cslgen.cgentb;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Objects;

/**
 * Legacy {@code closeFile} ({@code cGenBase_tb.cpp}): ends the stream with {@code //File:}, {@code //Date:}, and
 * {@link CGenTbFileHeader#line} ({@code testFileHeader} from {@code buildHeader}), then increments {@code testCounter}.
 */
public final class CGenTbGeneratedFile {

    private static final DateTimeFormatter LEGACY_STYLE_DATE =
            DateTimeFormatter.ofPattern("EEE MMM d HH:mm:ss uuuu", Locale.US).withZone(ZoneId.systemDefault());

    private CGenTbGeneratedFile() {}

    /**
     * Writes {@code path} (UTF-8): optional {@code body} (newline-terminated if non-empty), blank line, {@code //File:} file
     * name, {@code //Date:} line, {@link CGenTbFileHeader#line}{@code (binaryName)}, then {@link CGenTbTestCounter#increment()}.
     */
    public static void writeClosed(Path path, String body, String binaryName, CGenTbTestCounter counter) throws IOException {
        Objects.requireNonNull(path, "path");
        Objects.requireNonNull(binaryName, "binaryName");
        Objects.requireNonNull(counter, "counter");
        Path parent = path.getParent();
        if (parent != null) {
            Files.createDirectories(parent);
        }
        StringBuilder sb = new StringBuilder();
        if (body != null && !body.isEmpty()) {
            sb.append(body);
            if (!body.endsWith("\n")) {
                sb.append('\n');
            }
        }
        sb.append('\n');
        sb.append("//File: ").append(path.getFileName().toString()).append('\n');
        sb.append("//Date: ").append(ZonedDateTime.now(ZoneId.systemDefault()).format(LEGACY_STYLE_DATE)).append('\n');
        sb.append(CGenTbFileHeader.line(binaryName));
        Files.writeString(path, sb.toString(), StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
        counter.increment();
    }

    /** Same as {@link #writeClosed(Path, String, String, CGenTbTestCounter)}; wraps {@link IOException} as {@link UncheckedIOException}. */
    public static void writeClosedUnchecked(Path path, String body, String binaryName, CGenTbTestCounter counter) {
        try {
            writeClosed(path, body, binaryName, counter);
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }
}
