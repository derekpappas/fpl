package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.OptionalLong;

/**
 * {@code csl_command} bridge node. {@linkplain #inferredVerb() Inferred verb} matches batch-5
 * {@code CslWalkerPortCommandVerbListener} labeling ({@code assign} vs {@code param_list_*} suffix, else
 * {@code unknown}).
 */
public final class CslomCommandDecl extends CslomNamedDecl {

    private String inferredVerb;
    private String commandText;
    private String verbTokenText;
    private String receiverChainText;
    private String receiverIdentifier;
    private String receiverFirstRangeExpressionText;
    private Long receiverFirstRangeIntLiteral;
    private List<String> receiverChainSegments;
    private List<String> paramExprTexts;
    private Integer paramExprCount;
    private String paramListAntlrRuleSimpleName;
    private String assignRhsExpressionText;
    private String setDirectionKeyword;
    private Long setRadixValue;
    private Long setWidthValue;
    private Long firstCommandFirstParamIntLiteral;
    private Long firstCommandSecondParamIntLiteral;
    private Long firstCommandThirdParamIntLiteral;
    private String firstCommandFirstParamIdentifier;
    private String firstCommandFirstParamStringLiteral;
    private String firstCommandSecondParamIdentifier;
    private String firstCommandSecondParamStringLiteral;
    private String firstCommandThirdParamIdentifier;
    private String firstCommandThirdParamStringLiteral;

    public CslomCommandDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_COMMAND, name, lineNumber, columnNumber, fileName);
    }

    /** Batch-5 verb label attached by the trunk-port decl bridge, if set. */
    public Optional<String> inferredVerb() {
        return Optional.ofNullable(inferredVerb);
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachInferredVerb(String verbLabel) {
        Objects.requireNonNull(verbLabel, "verbLabel");
        if (this.inferredVerb != null) {
            throw new IllegalStateException("inferred verb already set: " + this.inferredVerb);
        }
        this.inferredVerb = verbLabel;
    }

    /** Raw {@code csl_command} subtree text (same span as {@code ParserRuleContext#getText()}), if set. */
    public Optional<String> commandText() {
        return Optional.ofNullable(commandText);
    }

    /** Actual verb token text from source (e.g. {@code generate_decoder}), if captured. */
    public Optional<String> verbTokenText() {
        return Optional.ofNullable(verbTokenText);
    }

    /** Text prefix before the inferred verb (e.g. {@code u.a[3].b.}). */
    public Optional<String> receiverChainText() {
        return Optional.ofNullable(receiverChainText);
    }

    /** Receiver chain segments split on dot (e.g. {@code u.a[3].b.} → {@code ["u","a[3]","b"]}). */
    public Optional<List<String>> receiverChainSegments() {
        return receiverChainSegments == null ? Optional.empty() : Optional.of(List.copyOf(receiverChainSegments));
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachCommandText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.commandText != null) {
            throw new IllegalStateException("command text already set");
        }
        this.commandText = text;
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachVerbTokenText(String verbTokenText) {
        Objects.requireNonNull(verbTokenText, "verbTokenText");
        if (this.verbTokenText != null) {
            throw new IllegalStateException("verb token text already set: " + this.verbTokenText);
        }
        this.verbTokenText = verbTokenText;
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachReceiverChainText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.receiverChainText != null) {
            throw new IllegalStateException("receiver chain text already set");
        }
        this.receiverChainText = text;
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachReceiverChainSegments(List<String> segments) {
        Objects.requireNonNull(segments, "segments");
        if (this.receiverChainSegments != null) {
            throw new IllegalStateException("receiver chain segments already set");
        }
        this.receiverChainSegments = new ArrayList<>(segments);
    }

    /** Optional receiver identifier before the dot (e.g. {@code u.set_width(8)} → {@code u}). */
    public Optional<String> receiverIdentifier() {
        return Optional.ofNullable(receiverIdentifier);
    }

    /** First {@code [...] } range expression text found in the receiver chain (e.g. {@code a[3]} → {@code 3}). */
    public Optional<String> receiverFirstRangeExpressionText() {
        return Optional.ofNullable(receiverFirstRangeExpressionText);
    }

    /** First {@code [...] } range expression as an integer literal when it's a simple base-10 digit sequence. */
    public OptionalLong receiverFirstRangeIntLiteral() {
        return receiverFirstRangeIntLiteral == null
                ? OptionalLong.empty()
                : OptionalLong.of(receiverFirstRangeIntLiteral);
    }

    /** Expression texts from the command's parameter list, if captured by the bridge. */
    public Optional<List<String>> paramExprTexts() {
        return paramExprTexts == null ? Optional.empty() : Optional.of(List.copyOf(paramExprTexts));
    }

    /** Number of captured parameter atoms (expr texts or identifier fallbacks), if set. */
    public Optional<Integer> paramExprCount() {
        return Optional.ofNullable(paramExprCount);
    }

    /** ANTLR rule name of the matched {@code param_list_*} subtree (e.g. {@code param_list_set_width}), if set. */
    public Optional<String> paramListAntlrRuleSimpleName() {
        return Optional.ofNullable(paramListAntlrRuleSimpleName);
    }

    /** RHS expression text for {@code csl_command} assign form (e.g. {@code u=1;} → {@code 1}), if set. */
    public Optional<String> assignRhsExpressionText() {
        return Optional.ofNullable(assignRhsExpressionText);
    }

    /**
     * Structured direction keyword for {@code set_direction(...)} when the first param is a simple identifier
     * matching {@code in}, {@code out}, or {@code inout} (batch 3 refinement).
     */
    public Optional<String> setDirectionKeyword() {
        return Optional.ofNullable(setDirectionKeyword);
    }

    /** Structured radix value for {@code set_radix(<int>)} when first param is a decimal int (batch 3 refinement). */
    public OptionalLong setRadixValue() {
        return setRadixValue == null ? OptionalLong.empty() : OptionalLong.of(setRadixValue);
    }

    /** Structured width value for {@code set_width(<int>)} when first param is a decimal int (batch 3 refinement). */
    public OptionalLong setWidthValue() {
        return setWidthValue == null ? OptionalLong.empty() : OptionalLong.of(setWidthValue);
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachReceiverIdentifier(String receiverIdentifier) {
        Objects.requireNonNull(receiverIdentifier, "receiverIdentifier");
        if (this.receiverIdentifier != null) {
            throw new IllegalStateException("receiver identifier already set: " + this.receiverIdentifier);
        }
        this.receiverIdentifier = receiverIdentifier;
    }

    public void attachReceiverFirstRangeExpressionText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.receiverFirstRangeExpressionText != null) {
            throw new IllegalStateException("receiver first range expression already set");
        }
        this.receiverFirstRangeExpressionText = text;
    }

    public void attachReceiverFirstRangeIntLiteral(long value) {
        if (this.receiverFirstRangeIntLiteral != null) {
            throw new IllegalStateException("receiver first range int literal already set: " + this.receiverFirstRangeIntLiteral);
        }
        this.receiverFirstRangeIntLiteral = value;
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.paramExprTexts != null) {
            throw new IllegalStateException("param expr texts already set");
        }
        this.paramExprTexts = new ArrayList<>(exprTexts);
        this.paramExprCount = exprTexts.size();
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachParamListAntlrRuleSimpleName(String ruleSimpleName) {
        Objects.requireNonNull(ruleSimpleName, "ruleSimpleName");
        if (this.paramListAntlrRuleSimpleName != null) {
            throw new IllegalStateException(
                    "param list antlr rule already set: " + this.paramListAntlrRuleSimpleName);
        }
        this.paramListAntlrRuleSimpleName = ruleSimpleName;
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public void attachAssignRhsExpressionText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.assignRhsExpressionText != null) {
            throw new IllegalStateException("assign rhs expression text already set");
        }
        this.assignRhsExpressionText = text;
    }

    /** Called once by the trunk-port decl bridge when {@code set_direction} param is recognized. */
    public void attachSetDirectionKeyword(String keyword) {
        Objects.requireNonNull(keyword, "keyword");
        if (keyword.isEmpty()) {
            throw new IllegalArgumentException("keyword must be non-empty");
        }
        if (this.setDirectionKeyword != null) {
            throw new IllegalStateException("set_direction keyword already set");
        }
        this.setDirectionKeyword = keyword;
    }

    /** Called once by the trunk-port decl bridge when {@code set_radix} param is recognized. */
    public void attachSetRadixValue(long value) {
        if (this.setRadixValue != null) {
            throw new IllegalStateException("set_radix value already set");
        }
        this.setRadixValue = value;
    }

    /** Called once by the trunk-port decl bridge when {@code set_width} param is recognized. */
    public void attachSetWidthValue(long value) {
        if (this.setWidthValue != null) {
            throw new IllegalStateException("set_width value already set");
        }
        this.setWidthValue = value;
    }

    /** Batch 3/4 refinement: first param as an integer literal when it's a simple base-10 digit sequence. */
    public OptionalLong firstCommandFirstParamIntLiteral() {
        return firstCommandFirstParamIntLiteral == null ? OptionalLong.empty() : OptionalLong.of(firstCommandFirstParamIntLiteral);
    }

    /** Batch refinement: second param as an integer literal when it's a simple base-10 digit sequence. */
    public OptionalLong firstCommandSecondParamIntLiteral() {
        return firstCommandSecondParamIntLiteral == null ? OptionalLong.empty() : OptionalLong.of(firstCommandSecondParamIntLiteral);
    }

    /** Batch refinement: third param as an integer literal when it's a simple base-10 digit sequence. */
    public OptionalLong firstCommandThirdParamIntLiteral() {
        return firstCommandThirdParamIntLiteral == null ? OptionalLong.empty() : OptionalLong.of(firstCommandThirdParamIntLiteral);
    }

    /** Batch 3/4 refinement: first param as a simple identifier token, when it matches the narrow contract. */
    public Optional<String> firstCommandFirstParamIdentifier() {
        return Optional.ofNullable(firstCommandFirstParamIdentifier);
    }

    /** Batch 3/4 refinement: first param as an unquoted string literal, when it is a quoted CSL string. */
    public Optional<String> firstCommandFirstParamStringLiteral() {
        return Optional.ofNullable(firstCommandFirstParamStringLiteral);
    }

    public Optional<String> firstCommandSecondParamIdentifier() {
        return Optional.ofNullable(firstCommandSecondParamIdentifier);
    }

    public Optional<String> firstCommandSecondParamStringLiteral() {
        return Optional.ofNullable(firstCommandSecondParamStringLiteral);
    }

    public Optional<String> firstCommandThirdParamIdentifier() {
        return Optional.ofNullable(firstCommandThirdParamIdentifier);
    }

    public Optional<String> firstCommandThirdParamStringLiteral() {
        return Optional.ofNullable(firstCommandThirdParamStringLiteral);
    }

    public void attachFirstCommandFirstParamIntLiteral(long value) {
        if (this.firstCommandFirstParamIntLiteral != null) {
            throw new IllegalStateException("first command first param int literal already set: " + this.firstCommandFirstParamIntLiteral);
        }
        this.firstCommandFirstParamIntLiteral = value;
    }

    public void attachFirstCommandSecondParamIntLiteral(long value) {
        if (this.firstCommandSecondParamIntLiteral != null) {
            throw new IllegalStateException("first command second param int literal already set: " + this.firstCommandSecondParamIntLiteral);
        }
        this.firstCommandSecondParamIntLiteral = value;
    }

    public void attachFirstCommandThirdParamIntLiteral(long value) {
        if (this.firstCommandThirdParamIntLiteral != null) {
            throw new IllegalStateException("first command third param int literal already set: " + this.firstCommandThirdParamIntLiteral);
        }
        this.firstCommandThirdParamIntLiteral = value;
    }

    public void attachFirstCommandFirstParamIdentifier(String identifier) {
        Objects.requireNonNull(identifier, "identifier");
        if (this.firstCommandFirstParamIdentifier != null) {
            throw new IllegalStateException("first command first param identifier already set: " + this.firstCommandFirstParamIdentifier);
        }
        this.firstCommandFirstParamIdentifier = identifier;
    }

    public void attachFirstCommandFirstParamStringLiteral(String stringLiteral) {
        Objects.requireNonNull(stringLiteral, "stringLiteral");
        if (this.firstCommandFirstParamStringLiteral != null) {
            throw new IllegalStateException("first command first param string literal already set: " + this.firstCommandFirstParamStringLiteral);
        }
        this.firstCommandFirstParamStringLiteral = stringLiteral;
    }

    public void attachFirstCommandSecondParamIdentifier(String identifier) {
        Objects.requireNonNull(identifier, "identifier");
        if (this.firstCommandSecondParamIdentifier != null) {
            throw new IllegalStateException("first command second param identifier already set: " + this.firstCommandSecondParamIdentifier);
        }
        this.firstCommandSecondParamIdentifier = identifier;
    }

    public void attachFirstCommandSecondParamStringLiteral(String stringLiteral) {
        Objects.requireNonNull(stringLiteral, "stringLiteral");
        if (this.firstCommandSecondParamStringLiteral != null) {
            throw new IllegalStateException("first command second param string literal already set: " + this.firstCommandSecondParamStringLiteral);
        }
        this.firstCommandSecondParamStringLiteral = stringLiteral;
    }

    public void attachFirstCommandThirdParamIdentifier(String identifier) {
        Objects.requireNonNull(identifier, "identifier");
        if (this.firstCommandThirdParamIdentifier != null) {
            throw new IllegalStateException("first command third param identifier already set: " + this.firstCommandThirdParamIdentifier);
        }
        this.firstCommandThirdParamIdentifier = identifier;
    }

    public void attachFirstCommandThirdParamStringLiteral(String stringLiteral) {
        Objects.requireNonNull(stringLiteral, "stringLiteral");
        if (this.firstCommandThirdParamStringLiteral != null) {
            throw new IllegalStateException("first command third param string literal already set: " + this.firstCommandThirdParamStringLiteral);
        }
        this.firstCommandThirdParamStringLiteral = stringLiteral;
    }
}
