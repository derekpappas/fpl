package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;

/**
 * Syntax-only declaration node for {@code csl_isa_field_declaration} (batch 3 refinement).
 */
public final class CslomIsaFieldDecl extends CslomNamedDecl {

    private String unitDefinitionText;

    public CslomIsaFieldDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_ISA, name, lineNumber, columnNumber, fileName);
    }

    /** Raw {@code csl_unit_definition} subtree text when present (batch 3 refinement). */
    public Optional<String> unitDefinitionText() {
        return Optional.ofNullable(unitDefinitionText);
    }

    /** Called once by the trunk-port decl bridge when a {@code csl_unit_definition} is present. */
    public void attachUnitDefinitionText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.unitDefinitionText != null) {
            throw new IllegalStateException("unit definition text already set");
        }
        this.unitDefinitionText = text;
    }
}
