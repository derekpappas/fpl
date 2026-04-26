package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;

public final class CslomUnitInstantiationDecl extends CslomNamedDecl {

    private String templateUnitName;

    public CslomUnitInstantiationDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_UNIT_INSTANTIATION, name, lineNumber, columnNumber, fileName);
    }

    /** Template unit identifier from the enclosing {@code csl_inst_or_cstor} (batch 4 slice). */
    public Optional<String> templateUnitName() {
        return Optional.ofNullable(templateUnitName);
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachTemplateUnitName(String templateUnitName) {
        Objects.requireNonNull(templateUnitName, "templateUnitName");
        if (this.templateUnitName != null) {
            throw new IllegalStateException("template unit name already set: " + this.templateUnitName);
        }
        this.templateUnitName = templateUnitName;
    }
}
