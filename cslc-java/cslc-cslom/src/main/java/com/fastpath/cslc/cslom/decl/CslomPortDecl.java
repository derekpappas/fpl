package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;
import java.util.OptionalInt;
import java.util.OptionalLong;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

public final class CslomPortDecl extends CslomNamedDecl {

    private String firstPortParamListText;
    private Integer firstPortParamExprCount;
    private List<String> firstPortParamExprTexts;
    private Long firstPortFirstParamIntLiteral;
    private String firstPortFirstParamIdentifier;
    private String firstPortFirstParamStringLiteral;
    private List<String> additionalPortDeclaratorNames;
    private List<String> additionalPortParamListTexts;
    private List<List<String>> additionalPortParamExprTextLists;
    private List<Integer> additionalPortParamExprCounts;
    private List<Long> additionalPortFirstParamIntLiterals;
    private List<String> additionalPortFirstParamIdentifiers;
    private List<String> additionalPortFirstParamStringLiterals;

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

    /**
     * Number of top-level {@code expression} nodes in {@code param_list_csl_port} for the first port identifier
     * (batch 3 refinement step).
     */
    public OptionalInt firstPortParamExprCount() {
        return firstPortParamExprCount == null ? OptionalInt.empty() : OptionalInt.of(firstPortParamExprCount);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_port} is present for the first name. */
    public void attachFirstPortParamExprCount(int count) {
        if (count < 0) {
            throw new IllegalArgumentException("count must be >= 0");
        }
        if (this.firstPortParamExprCount != null) {
            throw new IllegalStateException("first port param expr count already set");
        }
        this.firstPortParamExprCount = count;
    }

    /**
     * Text of each top-level {@code expression} inside {@code param_list_csl_port} for the first port identifier,
     * in source order (batch 3 refinement step).
     */
    public Optional<List<String>> firstPortParamExprTexts() {
        return Optional.ofNullable(firstPortParamExprTexts);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_port} is present for the first name. */
    public void attachFirstPortParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.firstPortParamExprTexts != null) {
            throw new IllegalStateException("first port param expr texts already set");
        }
        this.firstPortParamExprTexts = List.copyOf(exprTexts);
    }

    /**
     * Parsed integer literal of the first top-level {@code expression} in {@code param_list_csl_port}, when that
     * expression text is a simple base-10 integer token (batch 3 refinement step).
     */
    public OptionalLong firstPortFirstParamIntLiteral() {
        return firstPortFirstParamIntLiteral == null
                ? OptionalLong.empty()
                : OptionalLong.of(firstPortFirstParamIntLiteral);
    }

    /** Called once by the trunk-port decl bridge when the first param expression is a decimal integer literal. */
    public void attachFirstPortFirstParamIntLiteral(long value) {
        if (this.firstPortFirstParamIntLiteral != null) {
            throw new IllegalStateException("first port first param int literal already set");
        }
        this.firstPortFirstParamIntLiteral = value;
    }

    /**
     * Identifier text of the first top-level {@code expression} in {@code param_list_csl_port}, when that expression
     * is a single {@code IDENTIFIER} token (batch 3 refinement step).
     */
    public Optional<String> firstPortFirstParamIdentifier() {
        return Optional.ofNullable(firstPortFirstParamIdentifier);
    }

    /** Called once by the trunk-port decl bridge when the first param expression is a simple identifier token. */
    public void attachFirstPortFirstParamIdentifier(String identifier) {
        Objects.requireNonNull(identifier, "identifier");
        if (identifier.isEmpty()) {
            throw new IllegalArgumentException("identifier must be non-empty");
        }
        if (this.firstPortFirstParamIdentifier != null) {
            throw new IllegalStateException("first port first param identifier already set");
        }
        this.firstPortFirstParamIdentifier = identifier;
    }

    /**
     * Unquoted CSL string literal of the first top-level {@code expression} in {@code param_list_csl_port}, when that
     * expression is a single quoted string token (batch 3 refinement step).
     */
    public Optional<String> firstPortFirstParamStringLiteral() {
        return Optional.ofNullable(firstPortFirstParamStringLiteral);
    }

    /** Called once by the trunk-port decl bridge when the first param expression is a quoted string token. */
    public void attachFirstPortFirstParamStringLiteral(String unquotedValue) {
        Objects.requireNonNull(unquotedValue, "unquotedValue");
        if (this.firstPortFirstParamStringLiteral != null) {
            throw new IllegalStateException("first port first param string literal already set");
        }
        this.firstPortFirstParamStringLiteral = unquotedValue;
    }

    /**
     * Additional declarator identifiers in the same {@code csl_port_declaration} after the first
     * (comma-separated), in source order (batch 3 refinement).
     */
    public Optional<List<String>> additionalPortDeclaratorNames() {
        return Optional.ofNullable(additionalPortDeclaratorNames);
    }

    /** Called once by the trunk-port decl bridge; pass non-empty list when multiple declarators exist. */
    public void attachAdditionalPortDeclaratorNames(List<String> names) {
        Objects.requireNonNull(names, "names");
        if (this.additionalPortDeclaratorNames != null) {
            throw new IllegalStateException("additional port declarator names already set");
        }
        this.additionalPortDeclaratorNames = List.copyOf(names);
    }

    /**
     * Raw {@code param_list_csl_port} text (inside {@code ( ... )} only) for each additional declarator after the first,
     * in source order (batch 3 refinement).
     *
     * <p>List length matches {@link #additionalPortDeclaratorNames()} when set; entries are never null.
     */
    public Optional<List<String>> additionalPortParamListTexts() {
        return Optional.ofNullable(additionalPortParamListTexts);
    }

    /** Called once by the trunk-port decl bridge. */
    public void attachAdditionalPortParamListTexts(List<String> texts) {
        Objects.requireNonNull(texts, "texts");
        if (this.additionalPortParamListTexts != null) {
            throw new IllegalStateException("additional port param list texts already set");
        }
        this.additionalPortParamListTexts = List.copyOf(texts);
    }

    /**
     * For each additional declarator after the first, the list of top-level {@code expression} texts inside that
     * declarator's {@code param_list_csl_port}, in source order (batch 3 refinement).
     */
    public Optional<List<List<String>>> additionalPortParamExprTextLists() {
        return Optional.ofNullable(additionalPortParamExprTextLists);
    }

    /** Top-level {@code expression} count per additional declarator (batch 3 refinement). */
    public Optional<List<Integer>> additionalPortParamExprCounts() {
        return Optional.ofNullable(additionalPortParamExprCounts);
    }

    /** Called once by the trunk-port decl bridge. */
    public void attachAdditionalPortParamExprTextLists(List<List<String>> lists) {
        Objects.requireNonNull(lists, "lists");
        if (this.additionalPortParamExprTextLists != null) {
            throw new IllegalStateException("additional port param expr text lists already set");
        }
        this.additionalPortParamExprTextLists =
                List.copyOf(lists.stream().map(List::copyOf).toList());
    }

    /** Called once by the trunk-port decl bridge. */
    public void attachAdditionalPortParamExprCounts(List<Integer> counts) {
        Objects.requireNonNull(counts, "counts");
        if (this.additionalPortParamExprCounts != null) {
            throw new IllegalStateException("additional port param expr counts already set");
        }
        this.additionalPortParamExprCounts = List.copyOf(counts);
    }

    /** First additional declarator param parsed as decimal int literal; null when absent/non-decimal (batch 3 refinement). */
    public Optional<List<Long>> additionalPortFirstParamIntLiterals() {
        return Optional.ofNullable(additionalPortFirstParamIntLiterals);
    }

    /** First additional declarator param captured as identifier; null when absent/non-identifier (batch 3 refinement). */
    public Optional<List<String>> additionalPortFirstParamIdentifiers() {
        return Optional.ofNullable(additionalPortFirstParamIdentifiers);
    }

    /** First additional declarator param captured as unquoted string; null when absent/non-string (batch 3 refinement). */
    public Optional<List<String>> additionalPortFirstParamStringLiterals() {
        return Optional.ofNullable(additionalPortFirstParamStringLiterals);
    }

    /** Called once by the trunk-port decl bridge. List length matches {@link #additionalPortDeclaratorNames()} when set. */
    public void attachAdditionalPortFirstParamIntLiterals(List<Long> valuesOrNulls) {
        Objects.requireNonNull(valuesOrNulls, "valuesOrNulls");
        if (this.additionalPortFirstParamIntLiterals != null) {
            throw new IllegalStateException("additional port first param int literals already set");
        }
        // List.copyOf rejects nulls; null is meaningful here (non-decimal / absent).
        this.additionalPortFirstParamIntLiterals = Collections.unmodifiableList(new ArrayList<>(valuesOrNulls));
    }

    /** Called once by the trunk-port decl bridge. List entries may be null. */
    public void attachAdditionalPortFirstParamIdentifiers(List<String> idsOrNulls) {
        Objects.requireNonNull(idsOrNulls, "idsOrNulls");
        if (this.additionalPortFirstParamIdentifiers != null) {
            throw new IllegalStateException("additional port first param identifiers already set");
        }
        // List.copyOf rejects nulls; null is meaningful here (non-identifier / absent).
        this.additionalPortFirstParamIdentifiers = Collections.unmodifiableList(new ArrayList<>(idsOrNulls));
    }

    /** Called once by the trunk-port decl bridge. List entries may be null. */
    public void attachAdditionalPortFirstParamStringLiterals(List<String> strsOrNulls) {
        Objects.requireNonNull(strsOrNulls, "strsOrNulls");
        if (this.additionalPortFirstParamStringLiterals != null) {
            throw new IllegalStateException("additional port first param string literals already set");
        }
        // List.copyOf rejects nulls; null is meaningful here (non-string / absent).
        this.additionalPortFirstParamStringLiterals = Collections.unmodifiableList(new ArrayList<>(strsOrNulls));
    }
}
