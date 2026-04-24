package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * Syntax-only declaration node for {@code csl_enum_declaration} (batch 3a refinement).
 */
public final class CslomEnumDecl extends CslomNamedDecl {

    private List<String> enumItemTexts;

    public CslomEnumDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ENUM, name, lineNumber, columnNumber, fileName);
    }

    /** Raw enumerator item subtree text per {@code csl_enum_declaration_item}, in source order. */
    public Optional<List<String>> enumItemTexts() {
        return Optional.ofNullable(enumItemTexts);
    }

    /** Called once by the trunk-port decl bridge. */
    public void attachEnumItemTexts(List<String> itemTexts) {
        Objects.requireNonNull(itemTexts, "itemTexts");
        if (this.enumItemTexts != null) {
            throw new IllegalStateException("enum item texts already set");
        }
        this.enumItemTexts = List.copyOf(itemTexts);
    }
}
