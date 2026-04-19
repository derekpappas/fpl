package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;

/**
 * {@code csl_command} bridge node. {@linkplain #inferredVerb() Inferred verb} matches batch-5
 * {@code CslWalkerPortCommandVerbListener} labeling ({@code assign} vs {@code param_list_*} suffix, else
 * {@code unknown}).
 */
public final class CslomCommandDecl extends CslomNamedDecl {

    private String inferredVerb;

    public CslomCommandDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_COMMAND, name, lineNumber, columnNumber, fileName);
    }

    /** Batch-5 verb label attached by the trunk-port decl bridge, if set. */
    public Optional<String> inferredVerb() {
        return Optional.ofNullable(inferredVerb);
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachInferredVerb(String verbLabel) {
        Objects.requireNonNull(verbLabel, "verbLabel");
        if (this.inferredVerb != null) {
            throw new IllegalStateException("inferred verb already set: " + this.inferredVerb);
        }
        this.inferredVerb = verbLabel;
    }
}
