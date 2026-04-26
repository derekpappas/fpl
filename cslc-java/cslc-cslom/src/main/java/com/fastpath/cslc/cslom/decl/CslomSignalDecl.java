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

public final class CslomSignalDecl extends CslomNamedDecl {

    private String firstSignalParamListText;
    private Integer firstSignalParamExprCount;
    private String firstSignalBitrangePureText;
    private List<String> firstSignalParamExprTexts;
    private Long firstSignalFirstParamIntLiteral;
    private String firstSignalFirstParamIdentifier;
    private String firstSignalFirstParamStringLiteral;
    private List<String> additionalSignalDeclaratorNames;
    private List<String> additionalSignalParamListTexts;
    private List<List<String>> additionalSignalParamExprTextLists;
    private List<Integer> additionalSignalParamExprCounts;
    private List<Long> additionalSignalFirstParamIntLiterals;
    private List<String> additionalSignalFirstParamIdentifiers;
    private List<String> additionalSignalFirstParamStringLiterals;
    private List<String> additionalSignalBitrangePureTexts;

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

    /**
     * Number of top-level {@code expression} nodes in {@code param_list_csl_signal} for the first signal identifier
     * (batch 3 refinement step).
     */
    public OptionalInt firstSignalParamExprCount() {
        return firstSignalParamExprCount == null ? OptionalInt.empty() : OptionalInt.of(firstSignalParamExprCount);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_signal} is present for the first name. */
    public void attachFirstSignalParamExprCount(int count) {
        if (count < 0) {
            throw new IllegalArgumentException("count must be >= 0");
        }
        if (this.firstSignalParamExprCount != null) {
            throw new IllegalStateException("first signal param expr count already set");
        }
        this.firstSignalParamExprCount = count;
    }

    /**
     * Text of each top-level {@code expression} inside {@code param_list_csl_signal} for the first signal identifier,
     * in source order (batch 3 refinement step). This excludes the {@code bitrange_pure} alternative (captured
     * separately by {@link #firstSignalBitrangePureText()}).
     */
    public Optional<List<String>> firstSignalParamExprTexts() {
        return Optional.ofNullable(firstSignalParamExprTexts);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_signal} is present for the first name. */
    public void attachFirstSignalParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.firstSignalParamExprTexts != null) {
            throw new IllegalStateException("first signal param expr texts already set");
        }
        this.firstSignalParamExprTexts = List.copyOf(exprTexts);
    }

    /**
     * Parsed integer literal of the first top-level {@code expression} in {@code param_list_csl_signal}, when that
     * expression text is a simple base-10 integer token (batch 3 refinement step).
     */
    public OptionalLong firstSignalFirstParamIntLiteral() {
        return firstSignalFirstParamIntLiteral == null
                ? OptionalLong.empty()
                : OptionalLong.of(firstSignalFirstParamIntLiteral);
    }

    /** Called once by the trunk-port decl bridge when the first param expression is a decimal integer literal. */
    public void attachFirstSignalFirstParamIntLiteral(long value) {
        if (this.firstSignalFirstParamIntLiteral != null) {
            throw new IllegalStateException("first signal first param int literal already set");
        }
        this.firstSignalFirstParamIntLiteral = value;
    }

    /**
     * Identifier text of the first top-level {@code expression} in {@code param_list_csl_signal}, when that expression
     * is a single {@code IDENTIFIER} token (batch 3 refinement step).
     */
    public Optional<String> firstSignalFirstParamIdentifier() {
        return Optional.ofNullable(firstSignalFirstParamIdentifier);
    }

    /** Called once by the trunk-port decl bridge when the first param expression is a simple identifier token. */
    public void attachFirstSignalFirstParamIdentifier(String identifier) {
        Objects.requireNonNull(identifier, "identifier");
        if (identifier.isEmpty()) {
            throw new IllegalArgumentException("identifier must be non-empty");
        }
        if (this.firstSignalFirstParamIdentifier != null) {
            throw new IllegalStateException("first signal first param identifier already set");
        }
        this.firstSignalFirstParamIdentifier = identifier;
    }

    /**
     * Unquoted CSL string literal of the first top-level {@code expression} in {@code param_list_csl_signal}, when that
     * expression is a single quoted string token (batch 3 refinement step).
     */
    public Optional<String> firstSignalFirstParamStringLiteral() {
        return Optional.ofNullable(firstSignalFirstParamStringLiteral);
    }

    /** Called once by the trunk-port decl bridge when the first param expression is a quoted string token. */
    public void attachFirstSignalFirstParamStringLiteral(String unquotedValue) {
        Objects.requireNonNull(unquotedValue, "unquotedValue");
        if (this.firstSignalFirstParamStringLiteral != null) {
            throw new IllegalStateException("first signal first param string literal already set");
        }
        this.firstSignalFirstParamStringLiteral = unquotedValue;
    }

    /**
     * Raw {@code bitrange_pure} text (e.g. {@code [7:0]}) when the second slot of {@code param_list_csl_signal}
     * uses the bitrange alternative (batch 3 refinement step).
     */
    public Optional<String> firstSignalBitrangePureText() {
        return Optional.ofNullable(firstSignalBitrangePureText);
    }

    /** Called once by the trunk-port decl bridge when {@code bitrange_pure} is present in {@code param_list_csl_signal}. */
    public void attachFirstSignalBitrangePureText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.firstSignalBitrangePureText != null) {
            throw new IllegalStateException("first signal bitrange_pure text already set");
        }
        this.firstSignalBitrangePureText = text;
    }

    /**
     * Additional declarator identifiers in the same {@code csl_signal_declaration} after the first
     * (comma-separated), in source order (batch 3 refinement).
     */
    public Optional<List<String>> additionalSignalDeclaratorNames() {
        return Optional.ofNullable(additionalSignalDeclaratorNames);
    }

    /** Called once by the trunk-port decl bridge; pass non-empty list when multiple declarators exist. */
    public void attachAdditionalSignalDeclaratorNames(List<String> names) {
        Objects.requireNonNull(names, "names");
        if (this.additionalSignalDeclaratorNames != null) {
            throw new IllegalStateException("additional signal declarator names already set");
        }
        this.additionalSignalDeclaratorNames = List.copyOf(names);
    }

    /**
     * Raw {@code param_list_csl_signal} text (inside {@code ( ... )} only) for each additional declarator after the first,
     * in source order (batch 3 refinement). For declarators with no param list, the entry is an empty string.
     */
    public Optional<List<String>> additionalSignalParamListTexts() {
        return Optional.ofNullable(additionalSignalParamListTexts);
    }

    /** Called once by the trunk-port decl bridge. */
    public void attachAdditionalSignalParamListTexts(List<String> texts) {
        Objects.requireNonNull(texts, "texts");
        if (this.additionalSignalParamListTexts != null) {
            throw new IllegalStateException("additional signal param list texts already set");
        }
        this.additionalSignalParamListTexts = List.copyOf(texts);
    }

    /**
     * For each additional declarator after the first, the list of top-level {@code expression} texts inside that
     * declarator's {@code param_list_csl_signal}, in source order (batch 3 refinement).
     */
    public Optional<List<List<String>>> additionalSignalParamExprTextLists() {
        return Optional.ofNullable(additionalSignalParamExprTextLists);
    }

    /** Top-level {@code expression} count per additional declarator (batch 3 refinement). */
    public Optional<List<Integer>> additionalSignalParamExprCounts() {
        return Optional.ofNullable(additionalSignalParamExprCounts);
    }

    /** Called once by the trunk-port decl bridge. */
    public void attachAdditionalSignalParamExprTextLists(List<List<String>> lists) {
        Objects.requireNonNull(lists, "lists");
        if (this.additionalSignalParamExprTextLists != null) {
            throw new IllegalStateException("additional signal param expr text lists already set");
        }
        this.additionalSignalParamExprTextLists =
                List.copyOf(lists.stream().map(List::copyOf).toList());
    }

    /** Called once by the trunk-port decl bridge. */
    public void attachAdditionalSignalParamExprCounts(List<Integer> counts) {
        Objects.requireNonNull(counts, "counts");
        if (this.additionalSignalParamExprCounts != null) {
            throw new IllegalStateException("additional signal param expr counts already set");
        }
        this.additionalSignalParamExprCounts = List.copyOf(counts);
    }

    /** First additional declarator param parsed as decimal int literal; null when absent/non-decimal (batch 3 refinement). */
    public Optional<List<Long>> additionalSignalFirstParamIntLiterals() {
        return Optional.ofNullable(additionalSignalFirstParamIntLiterals);
    }

    /** First additional declarator param captured as identifier; null when absent/non-identifier (batch 3 refinement). */
    public Optional<List<String>> additionalSignalFirstParamIdentifiers() {
        return Optional.ofNullable(additionalSignalFirstParamIdentifiers);
    }

    /** First additional declarator param captured as unquoted string; null when absent/non-string (batch 3 refinement). */
    public Optional<List<String>> additionalSignalFirstParamStringLiterals() {
        return Optional.ofNullable(additionalSignalFirstParamStringLiterals);
    }

    /** Called once by the trunk-port decl bridge. List length matches {@link #additionalSignalDeclaratorNames()} when set. */
    public void attachAdditionalSignalFirstParamIntLiterals(List<Long> valuesOrNulls) {
        Objects.requireNonNull(valuesOrNulls, "valuesOrNulls");
        if (this.additionalSignalFirstParamIntLiterals != null) {
            throw new IllegalStateException("additional signal first param int literals already set");
        }
        // List.copyOf rejects nulls; null is meaningful here (non-decimal / absent).
        this.additionalSignalFirstParamIntLiterals = Collections.unmodifiableList(new ArrayList<>(valuesOrNulls));
    }

    /** Called once by the trunk-port decl bridge. List entries may be null. */
    public void attachAdditionalSignalFirstParamIdentifiers(List<String> idsOrNulls) {
        Objects.requireNonNull(idsOrNulls, "idsOrNulls");
        if (this.additionalSignalFirstParamIdentifiers != null) {
            throw new IllegalStateException("additional signal first param identifiers already set");
        }
        // List.copyOf rejects nulls; null is meaningful here (non-identifier / absent).
        this.additionalSignalFirstParamIdentifiers = Collections.unmodifiableList(new ArrayList<>(idsOrNulls));
    }

    /** Called once by the trunk-port decl bridge. List entries may be null. */
    public void attachAdditionalSignalFirstParamStringLiterals(List<String> strsOrNulls) {
        Objects.requireNonNull(strsOrNulls, "strsOrNulls");
        if (this.additionalSignalFirstParamStringLiterals != null) {
            throw new IllegalStateException("additional signal first param string literals already set");
        }
        // List.copyOf rejects nulls; null is meaningful here (non-string / absent).
        this.additionalSignalFirstParamStringLiterals = Collections.unmodifiableList(new ArrayList<>(strsOrNulls));
    }

    /**
     * Raw {@code bitrange_pure} text (e.g. {@code [7:0]}) captured from each additional declarator's
     * {@code param_list_csl_signal} when the second slot uses the bitrange alternative (batch 3 refinement).
     *
     * <p>List length matches {@link #additionalSignalDeclaratorNames()} when set; entries may be empty when absent.
     */
    public Optional<List<String>> additionalSignalBitrangePureTexts() {
        return Optional.ofNullable(additionalSignalBitrangePureTexts);
    }

    /** Called once by the trunk-port decl bridge. */
    public void attachAdditionalSignalBitrangePureTexts(List<String> texts) {
        Objects.requireNonNull(texts, "texts");
        if (this.additionalSignalBitrangePureTexts != null) {
            throw new IllegalStateException("additional signal bitrange_pure texts already set");
        }
        this.additionalSignalBitrangePureTexts = List.copyOf(texts);
    }
}
