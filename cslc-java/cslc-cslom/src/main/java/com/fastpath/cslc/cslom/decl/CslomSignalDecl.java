package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;

public final class CslomSignalDecl extends CslomNamedDecl {

    private String firstSignalParamListText;

    public CslomSignalDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_SIGNALS, name, lineNumber, columnNumber, fileName);
    }

    /**
     * Raw {@code param_list_csl_signal} text for the first signal identifier (inside {@code ( ... )} only), when the
     * parse tree included that list (batch 3 — structured slice before full expression IR).
     */
    public Optional<String> firstSignalParamListText() {
        return Optional.ofNullable(firstSignalParamListText);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_signal} is present for the first name. */
    public void attachFirstSignalParamListText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.firstSignalParamListText != null) {
            throw new IllegalStateException("first signal param list text already set");
        }
        this.firstSignalParamListText = text;
    }
}
