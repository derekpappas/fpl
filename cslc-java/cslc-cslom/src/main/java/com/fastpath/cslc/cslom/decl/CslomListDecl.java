package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * Syntax-only declaration node for {@code csl_list_declaration} (batch 3a refinement).
 */
public final class CslomListDecl extends CslomNamedDecl {

    /** Synthetic {@link #declaredName()} when the grammar omits the leading identifier. */
    public static final String ANONYMOUS_LIST_DECL_NAME = "_csl_list";

    private List<List<String>> eachListParamExprTextLists;
    private List<String> additionalListDeclaratorNames;

    public CslomListDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_LIST, name, lineNumber, columnNumber, fileName);
    }

    /**
     * For each {@code param_list_csl_list} in source order, the {@code expression} texts inside the parentheses
     * (batch 3a).
     */
    public Optional<List<List<String>>> eachListParamExprTextLists() {
        return Optional.ofNullable(eachListParamExprTextLists);
    }

    /** Called once by the trunk-port decl bridge. Outer list matches {@code param_list_csl_list()} count. */
    public void attachEachListParamExprTextLists(List<List<String>> lists) {
        Objects.requireNonNull(lists, "lists");
        if (this.eachListParamExprTextLists != null) {
            throw new IllegalStateException("list param expr lists already set");
        }
        List<List<String>> copy = new ArrayList<>(lists.size());
        for (List<String> inner : lists) {
            copy.add(List.copyOf(inner));
        }
        this.eachListParamExprTextLists = List.copyOf(copy);
    }

    /**
     * Trailing declarator identifiers after the first (comma-separated {@code id2} segment), in source order
     * (batch 3a).
     */
    public Optional<List<String>> additionalListDeclaratorNames() {
        return Optional.ofNullable(additionalListDeclaratorNames);
    }

    /** Called once by the trunk-port decl bridge; pass empty list when only the primary name exists. */
    public void attachAdditionalListDeclaratorNames(List<String> names) {
        Objects.requireNonNull(names, "names");
        if (this.additionalListDeclaratorNames != null) {
            throw new IllegalStateException("additional list declarator names already set");
        }
        this.additionalListDeclaratorNames = List.copyOf(names);
    }
}
