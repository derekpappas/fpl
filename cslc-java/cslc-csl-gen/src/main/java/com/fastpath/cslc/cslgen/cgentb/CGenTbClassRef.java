package com.fastpath.cslc.cslgen.cgentb;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

/**
 * Stand-in for legacy {@code CSLClass} / {@code CSLClassPoint} in {@code cGenDecl_tb} — name, kind, scope-holder
 * flag, and optional mandatory nested decls ({@code getMandatoryObjs()}).
 */
public final class CGenTbClassRef {

    private final String name;
    private final CGenTbEslClass kind;
    private final boolean scopeHolder;
    private final List<CGenTbClassRef> mandatory;

    public CGenTbClassRef(String name, CGenTbEslClass kind, boolean scopeHolder) {
        this(name, kind, scopeHolder, List.of());
    }

    public CGenTbClassRef(String name, CGenTbEslClass kind, boolean scopeHolder, List<CGenTbClassRef> mandatory) {
        this.name = Objects.requireNonNull(name, "name");
        this.kind = Objects.requireNonNull(kind, "kind");
        this.scopeHolder = scopeHolder;
        this.mandatory = Collections.unmodifiableList(new ArrayList<>(mandatory));
    }

    public String name() {
        return name;
    }

    public CGenTbEslClass kind() {
        return kind;
    }

    public boolean scopeHolder() {
        return scopeHolder;
    }

    public List<CGenTbClassRef> mandatory() {
        return mandatory;
    }
}
