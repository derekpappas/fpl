package com.fastpath.cslc.cslgen;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLbase} ({@code csl_gen_base.h} / {@code csl_gen_base.cpp}) — Java manages
 * lifetime; no manual {@code delete}.
 *
 * <p>Legacy static {@code CSLbase::m_out} is modeled with a per-thread {@link StringBuilder} sink (see
 * {@link #printSink()}, {@link #runWithPrintSink}).
 */
public abstract class CslGenCslBase {

    private static final ThreadLocal<StringBuilder> PRINT_SINK = new ThreadLocal<>();

    private final CslGenCslType type;
    private final String name;
    private final CslGenCslBase parent;
    private final List<CslGenCslBase> children = new ArrayList<>();
    private final List<String> names = new ArrayList<>();

    protected CslGenCslBase(CslGenCslType type, CslGenCslBase parent, String name) {
        this.type = Objects.requireNonNull(type);
        this.parent = parent;
        this.name = Objects.requireNonNull(name);
    }

    public final CslGenCslType getType() {
        return type;
    }

    public final String getName() {
        return name;
    }

    public final Optional<CslGenCslBase> getParent() {
        return Optional.ofNullable(parent);
    }

    public final List<CslGenCslBase> getChildren() {
        return Collections.unmodifiableList(children);
    }

    public final int getChildrenCount() {
        return children.size();
    }

    public final Optional<CslGenCslBase> getChildAt(int index) {
        if (index >= 0 && index < children.size()) {
            return Optional.of(children.get(index));
        }
        return Optional.empty();
    }

    public final boolean newNameIsValid(String candidate) {
        return !names.contains(candidate);
    }

    /** Registers a name used by this node (legacy {@code m_names} bookkeeping). */
    public final void registerName(String name) {
        names.add(name);
    }

    public final void addChild(CslGenCslBase child) {
        Objects.requireNonNull(child, "child");
        children.add(child);
    }

    public abstract boolean buildDecl();

    public abstract void print();

    /** Current print target for this thread (legacy {@code m_out}); {@code null} if unset. */
    protected static StringBuilder printSink() {
        return PRINT_SINK.get();
    }

    /**
     * Runs {@code action} with {@link #printSink()} set to {@code out}, restoring the previous sink afterward
     * (supports one level of nesting).
     */
    public static void runWithPrintSink(StringBuilder out, Runnable action) {
        Objects.requireNonNull(out, "out");
        Objects.requireNonNull(action, "action");
        StringBuilder prev = PRINT_SINK.get();
        PRINT_SINK.set(out);
        try {
            action.run();
        } finally {
            if (prev != null) {
                PRINT_SINK.set(prev);
            } else {
                PRINT_SINK.remove();
            }
        }
    }

    /** Legacy {@code CSLbase::addToScope} ({@code cslInterconnectGen_TB.cpp}). */
    protected final String interconnectAddToScope(String scope, String toAdd) {
        return scope + toAdd + ".";
    }

    /** Legacy {@code CSLbase::removeFromScope} ({@code cslInterconnectGen_TB.cpp}). */
    protected final String interconnectRemoveFromScope(String scope) {
        if (scope.isEmpty()) {
            return "";
        }
        int pos = scope.lastIndexOf('.') - 1;
        while (pos > 0 && scope.charAt(pos) != '.') {
            pos--;
        }
        if (pos > 0) {
            return scope.substring(0, pos + 1);
        }
        return "";
    }

    /**
     * Legacy {@code CSLbase::randSelObj} ({@code cslInterconnectGen_TB.cpp}) — random walk from {@code this} to find
     * a child of {@code type} with optional dotted {@code scope} prefix.
     */
    public final CslGenScopedSelection randSelObj(CslGenCslType type, RandomGenerator rng) {
        String scope = "";
        boolean canAdd = true;
        CslGenCslBase walk = this;
        CslGenCslBase randObj = null;

        while (walk != null) {
            if (walk.getType() == CslGenCslType.CSL_UNIT_INST && type != CslGenCslType.CSL_UNIT) {
                scope = interconnectAddToScope(scope, walk.getName());
                CslGenUnit resolved = ((CslGenUnitInst) walk).getInstUnit();
                if (resolved == null) {
                    scope = interconnectRemoveFromScope(scope);
                    walk = walk.getParent().orElse(null);
                } else {
                    walk = resolved;
                    canAdd = false;
                }
                continue;
            }
            if (walk.getChildrenCount() > 0) {
                if (walk.getType() != CslGenCslType.CSL_DESIGN && canAdd) {
                    scope = interconnectAddToScope(scope, walk.getName());
                } else {
                    canAdd = true;
                }
                int maxPos = rng.nextInt(walk.getChildrenCount());
                randObj = null;
                for (CslGenCslBase ch : walk.getChildren()) {
                    if (maxPos <= 0) {
                        break;
                    }
                    if (ch.getType() == type) {
                        randObj = ch;
                    }
                    maxPos--;
                }
                if (randObj != null && rng.nextBoolean()) {
                    return new CslGenScopedSelection(scope, randObj);
                }
                if (rng.nextBoolean()) {
                    int n = walk.getChildrenCount();
                    walk = walk.getChildAt(rng.nextInt(n)).orElse(null);
                } else {
                    scope = interconnectRemoveFromScope(scope);
                    walk = walk.getParent().orElse(null);
                }
            } else {
                scope = interconnectRemoveFromScope(scope);
                walk = walk.getParent().orElse(null);
            }
        }
        return new CslGenScopedSelection(scope, randObj);
    }
}
