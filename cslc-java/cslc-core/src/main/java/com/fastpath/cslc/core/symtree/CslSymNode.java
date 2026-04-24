package com.fastpath.cslc.core.symtree;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

/**
 * A single scoped symbol-table node (name + type + children) roughly corresponding to trunk {@code CSymNode}.
 *
 * <p>This version is intentionally small: it supports tree structure, basic lookup, and capture of source location.
 */
public final class CslSymNode {
    private final String name;
    private final CslObjType type;
    private final int declLine;
    private final int declColumn;
    private final String sourceName;
    private final CslSymNode parent;
    private final Map<String, CslSymNode> children = new LinkedHashMap<>();

    CslSymNode(
            String name,
            CslObjType type,
            int declLine,
            int declColumn,
            String sourceName,
            CslSymNode parent) {
        this.name = Objects.requireNonNull(name, "name");
        this.type = Objects.requireNonNull(type, "type");
        this.declLine = declLine;
        this.declColumn = declColumn;
        this.sourceName = sourceName;
        this.parent = parent;
    }

    public String name() {
        return name;
    }

    public CslObjType type() {
        return type;
    }

    public int declLine() {
        return declLine;
    }

    public int declColumn() {
        return declColumn;
    }

    public Optional<String> sourceName() {
        return Optional.ofNullable(sourceName);
    }

    public Optional<CslSymNode> parent() {
        return Optional.ofNullable(parent);
    }

    public Map<String, CslSymNode> childrenView() {
        return Map.copyOf(children);
    }

    Optional<CslSymNode> childNamed(String childName) {
        return Optional.ofNullable(children.get(childName));
    }

    void addChild(CslSymNode child) {
        Objects.requireNonNull(child, "child");
        CslSymNode prev = children.putIfAbsent(child.name, child);
        if (prev != null) {
            throw new IllegalStateException("symbol already declared in scope: " + child.name);
        }
    }
}

