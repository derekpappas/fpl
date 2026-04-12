package com.fastpath.cslc.cslom;

import com.fastpath.cslc.errors.CslcMessage;
import java.nio.file.Paths;
import java.util.Objects;
import java.util.Optional;

/** Ports of {@code NSCSLOm::checkIdName} and {@code NSCSLOm::ltos} ({@code trunk/cslc/trunk/src/cslom/CSLOM.cpp}). */
public final class CslomUtil {

    private CslomUtil() {}

    /**
     * Unsigned decimal string for legacy {@code ltos(TULong)} — same digits as {@code Long.toUnsignedString} for
     * non-negative values; delegates to {@link Long#toUnsignedString(long)} for full {@code 0…2⁶⁴-1} range.
     */
    public static String ltos(long number) {
        return Long.toUnsignedString(number);
    }

    /**
     * Simple identifiers must not contain {@link CslomBase#DOT}. Legacy records a CSC error via side effects; this
     * port returns a diagnostic when the name is illegal.
     */
    public static Optional<CslcMessage> checkIdName(String name, int lineNumber, Optional<String> fileName) {
        Objects.requireNonNull(name, "name");
        if (name.isEmpty()) {
            throw new IllegalArgumentException("invalid name: length 0");
        }
        if (name.indexOf(CslomBase.DOT) >= 0) {
            return Optional.of(
                    new CslcMessage(
                            CslcMessage.Severity.ERROR,
                            "CSE_CSC_ID_ILLEGAL",
                            "illegal identifier name: " + name,
                            fileName.map(Paths::get),
                            lineNumber,
                            0));
        }
        return Optional.empty();
    }
}
