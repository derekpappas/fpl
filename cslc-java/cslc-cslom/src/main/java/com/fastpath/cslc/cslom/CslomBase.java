package com.fastpath.cslc.cslom;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * Base of the CSLOM tree ({@code NSCSLOm::CSLOmBase} / {@code CSLOM_Base.h}). Factories and scope caching are not
 * ported yet; this class wires parent/child links for traversal and generators.
 */
public abstract class CslomBase {

    public static final char DOT = '.';

    private final CslomNodeType nodeType;
    private final int lineNumber;
    private final int columnNumber;
    private final String fileName;
    private final List<CslomBase> children = new ArrayList<>();
    private CslomBase parent;
    private boolean defined;
    private int mandatoryCounter;

    protected CslomBase(CslomNodeType nodeType, int lineNumber, int columnNumber, String fileName) {
        this.nodeType = Objects.requireNonNull(nodeType);
        this.lineNumber = lineNumber;
        this.columnNumber = columnNumber;
        this.fileName = fileName;
    }

    public final CslomNodeType getNodeType() {
        return nodeType;
    }

    public final int getLineNumber() {
        return lineNumber;
    }

    public final int getColumnNumber() {
        return columnNumber;
    }

    public final Optional<String> getFileName() {
        return Optional.ofNullable(fileName);
    }

    public final Optional<CslomBase> getParent() {
        return Optional.ofNullable(parent);
    }

    public final List<CslomBase> getChildren() {
        return Collections.unmodifiableList(children);
    }

    public final void defineObject() {
        this.defined = true;
    }

    public final boolean isDefined() {
        return defined;
    }

    public final int getMandatoryCount() {
        return mandatoryCounter;
    }

    protected final void setMandatoryCounter(int mandatoryCounter) {
        this.mandatoryCounter = mandatoryCounter;
    }

    /** Append {@code child} and set its parent to this node. */
    public final void addChild(CslomBase child) {
        Objects.requireNonNull(child, "child");
        if (child.parent != null) {
            throw new IllegalStateException("Child already parented");
        }
        children.add(child);
        child.parent = this;
    }

    public final void addChildAt(CslomBase child, int position) {
        Objects.requireNonNull(child, "child");
        if (child.parent != null) {
            throw new IllegalStateException("Child already parented");
        }
        children.add(position, child);
        child.parent = this;
    }
}
