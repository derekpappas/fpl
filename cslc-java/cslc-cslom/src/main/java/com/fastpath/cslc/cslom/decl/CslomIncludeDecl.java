package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;

/**
 * Syntax-only declaration node for {@code csl_include_declaration} (batch 3a refinement).
 */
public final class CslomIncludeDecl extends CslomNamedDecl {

    private String includeArgumentExpressionText;

    public CslomIncludeDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_INCLUDE, name, lineNumber, columnNumber, fileName);
    }

    /** Raw {@code expression} after the comma in {@code ( id , expression )} (batch 3a). */
    public Optional<String> includeArgumentExpressionText() {
        return Optional.ofNullable(includeArgumentExpressionText);
    }

    /** Called once by the trunk-port decl bridge when {@code expression} is present. */
    public void attachIncludeArgumentExpressionText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.includeArgumentExpressionText != null) {
            throw new IllegalStateException("include argument expression text already set");
        }
        this.includeArgumentExpressionText = text;
    }
}
