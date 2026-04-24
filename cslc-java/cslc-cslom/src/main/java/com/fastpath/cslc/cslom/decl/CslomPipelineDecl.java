package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * Syntax-only declaration node for {@code csl_pipeline_declaration} (batch 3 refinement).
 *
 * <p>Legacy CSLOM treats pipeline-like decls as containers; we keep {@link CslomNodeType#TYPE_CONTAINER} while
 * capturing structured param expression text for incremental parity work.
 */
public final class CslomPipelineDecl extends CslomNamedDecl {

    private List<String> firstPipelineParamExprTexts;

    public CslomPipelineDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_CONTAINER, name, lineNumber, columnNumber, fileName);
    }

    /** Text of the first declarator's optional {@code ( ... )} expression(s), in source order. */
    public Optional<List<String>> firstPipelineParamExprTexts() {
        return Optional.ofNullable(firstPipelineParamExprTexts);
    }

    /** Called once by the trunk-port decl bridge when the first declarator has a {@code ( ... )} list. */
    public void attachFirstPipelineParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.firstPipelineParamExprTexts != null) {
            throw new IllegalStateException("first pipeline param expr texts already set");
        }
        this.firstPipelineParamExprTexts = List.copyOf(exprTexts);
    }
}

