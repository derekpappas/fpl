package com.fastpath.cslc.cslgen;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * Port of {@code NSCSLinterconnect::CSLbase} ({@code csl_gen_base.h} / {@code csl_gen_base.cpp}) — Java manages
 * lifetime; no manual {@code delete}.
 */
public abstract class CslGenCslBase {

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
}
