package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;

public final class CslomPortDecl extends CslomNamedDecl {

    private String firstPortParamListText;

    public CslomPortDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_PORTS, name, lineNumber, columnNumber, fileName);
    }

    /**
     * Raw {@code param_list_csl_port} text for the first port identifier (inside {@code ( ... )} only), when the
     * parse tree included that list (batch 3 — structured slice before full expression IR).
     */
    public Optional<String> firstPortParamListText() {
        return Optional.ofNullable(firstPortParamListText);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_port} is present for the first name. */
    public void attachFirstPortParamListText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.firstPortParamListText != null) {
            throw new IllegalStateException("first port param list text already set");
        }
        this.firstPortParamListText = text;
    }
}
