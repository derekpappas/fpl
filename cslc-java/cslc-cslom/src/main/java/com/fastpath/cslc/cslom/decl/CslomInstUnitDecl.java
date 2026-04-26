package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

public final class CslomInstUnitDecl extends CslomNamedDecl {

    private String templateUnitName;
    private List<String> ctorDeclaredInstanceNames;

    public CslomInstUnitDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_INST_UNIT, name, lineNumber, columnNumber, fileName);
    }

    /** Template unit identifier from the enclosing {@code csl_inst_or_cstor} (batch 4 slice). */
    public Optional<String> templateUnitName() {
        return Optional.ofNullable(templateUnitName);
    }

    /** Declared instance identifiers inside {@code csl_cstor(...)} (batch 4 slice). */
    public Optional<List<String>> ctorDeclaredInstanceNames() {
        return ctorDeclaredInstanceNames == null ? Optional.empty() : Optional.of(List.copyOf(ctorDeclaredInstanceNames));
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachTemplateUnitName(String templateUnitName) {
        Objects.requireNonNull(templateUnitName, "templateUnitName");
        if (this.templateUnitName != null) {
            throw new IllegalStateException("template unit name already set: " + this.templateUnitName);
        }
        this.templateUnitName = templateUnitName;
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachCtorDeclaredInstanceNames(List<String> names) {
        Objects.requireNonNull(names, "names");
        if (this.ctorDeclaredInstanceNames != null) {
            throw new IllegalStateException("ctor declared instance names already set");
        }
        this.ctorDeclaredInstanceNames = new ArrayList<>(names);
    }
}
