package com.fastpath.cslc.cdom;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.function.Predicate;

/**
 * Mutable state extracted from {@code NSCdomChecker::CDOmChecker} ({@code CDOM_Checker.cpp}) before the full visitor
 * is ported: top-module path prefix accumulation and undefined hierarchical instance names.
 */
public final class CdomCheckerState {

    private final List<String> undefinedModuleNames = new ArrayList<>();
    private final StringBuilder topModulePathPrefix = new StringBuilder();

    public void clear() {
        undefinedModuleNames.clear();
        topModulePathPrefix.setLength(0);
    }

    /** Mirrors {@code beforeTraversal(RefCDOmDesign)} — design handle stored in legacy; no-op here. */
    public void setDesignEntered() {
        // Reserved for future design/scope attachment.
    }

    /**
     * Mirrors {@code beforeTraversal(RefCDOmModuleDecl)} when {@code moduleDecl->isTopModule()}: append
     * {@code moduleName + "_"} to the global prefix string used for output paths.
     */
    public void appendTopModulePrefix(String moduleName) {
        if (moduleName != null && !moduleName.isEmpty()) {
            topModulePathPrefix.append(moduleName).append('_');
        }
    }

    public String getTopModulePathPrefix() {
        return topModulePathPrefix.toString();
    }

    /**
     * Mirrors the undefined-module collection in {@code beforeTraversal(RefCDOmModuleOrUdpInstantiation)} when the
     * linked name is missing from the design scope (legacy pushes unique {@code RefString} names).
     */
    public void recordUndefinedIfMissingFromScope(String linkedName, Predicate<String> scopeContainsId) {
        Objects.requireNonNull(scopeContainsId, "scopeContainsId");
        if (linkedName == null || linkedName.isEmpty()) {
            return;
        }
        if (!scopeContainsId.test(linkedName) && !undefinedModuleNames.contains(linkedName)) {
            undefinedModuleNames.add(linkedName);
        }
    }

    public List<String> getUndefinedModuleNames() {
        return List.copyOf(undefinedModuleNames);
    }
}
