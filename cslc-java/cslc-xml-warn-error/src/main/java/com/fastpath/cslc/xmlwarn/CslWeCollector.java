package com.fastpath.cslc.xmlwarn;

import java.util.List;
import java.util.Objects;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * Minimal stand-in for {@code NSWarnError::CslWE::addError} ({@code we_logic.h}) used by {@code WE_Driver.cpp}.
 */
public final class CslWeCollector {

    public record ErrorEntry(long code, List<String> arguments) {}

    private static final CslWeCollector INSTANCE = new CslWeCollector();

    private final CopyOnWriteArrayList<ErrorEntry> errors = new CopyOnWriteArrayList<>();

    public static CslWeCollector instance() {
        return INSTANCE;
    }

    public void clear() {
        errors.clear();
    }

    public void addError(long code, List<String> messages) {
        Objects.requireNonNull(messages, "messages");
        errors.add(new ErrorEntry(code, List.copyOf(messages)));
    }

    public List<ErrorEntry> snapshot() {
        return List.copyOf(errors);
    }

    private CslWeCollector() {}
}
