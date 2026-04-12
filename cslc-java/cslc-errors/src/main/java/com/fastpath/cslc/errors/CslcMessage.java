package com.fastpath.cslc.errors;

import java.nio.file.Path;
import java.util.Optional;

/**
 * Structured diagnostic (warnings/errors); expands toward {@code csl_xml_warn_error/} and {@code CSLC_Errors.h}.
 */
public record CslcMessage(Severity severity, String code, String text, Optional<Path> file, int line, int column) {

    public enum Severity {
        NOTE, WARNING, ERROR
    }

    public static CslcMessage error(String code, String text) {
        return new CslcMessage(Severity.ERROR, code, text, Optional.empty(), 0, 0);
    }
}
