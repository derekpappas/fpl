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
    private Long setDepthValue;
    private String setNameValue;
    private String setTypeValue;
    private Long setOffsetValue;
    private String setPrefixValue;
    private String setSuffixValue;
    private String setEndianessValue;
    private Long setAlignmentValue;
    private Long setNumberOfDimensionsValue;
    private Long setRangeLowValue;
    private Long setRangeHighValue;
    private Long setDimRangeLowValue;
    private Long setDimRangeHighValue;
    private String setTopUnitName;
    private String setVcOutputFilenameValue;
    private Long setVcMaxCyclesValue;
    private Long setVcMaxNumberOfMismatchesValue;
    private Long setVcMaxNumberOfValidTransactionsValue;
    private String setUnitNameValue;
    private String pipestageNamingConventionValue;
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

    /** Structured depth value for {@code set_depth(<int>)} when first param is a decimal int (batch 3 refinement). */
    public OptionalLong setDepthValue() {
        return setDepthValue == null ? OptionalLong.empty() : OptionalLong.of(setDepthValue);
    }

    /** Structured name value for {@code set_name("...")} when first param is a string literal (batch 3 refinement). */
    public Optional<String> setNameValue() {
        return Optional.ofNullable(setNameValue);
    }

    /** Structured type value for {@code set_type("...")} when first param is a string literal (batch 3 refinement). */
    public Optional<String> setTypeValue() {
        return Optional.ofNullable(setTypeValue);
    }

    /** Structured offset value for {@code set_offset(<int>)} when first param is a decimal int (batch 3 refinement). */
    public OptionalLong setOffsetValue() {
        return setOffsetValue == null ? OptionalLong.empty() : OptionalLong.of(setOffsetValue);
    }

    /** Structured prefix value for {@code set_prefix("...")} when first param is a string literal (batch 3 refinement). */
    public Optional<String> setPrefixValue() {
        return Optional.ofNullable(setPrefixValue);
    }

    /** Structured suffix value for {@code set_suffix("...")} when first param is a string literal (batch 3 refinement). */
    public Optional<String> setSuffixValue() {
        return Optional.ofNullable(setSuffixValue);
    }

    /**
     * Structured endianess value for {@code set_endianess("...")} when first param is a string literal
     * (batch 3 refinement).
     */
    public Optional<String> setEndianessValue() {
        return Optional.ofNullable(setEndianessValue);
    }

    /** Structured alignment value for {@code set_alignment(<int>)} when first param is a decimal int (batch 3 refinement). */
    public OptionalLong setAlignmentValue() {
        return setAlignmentValue == null ? OptionalLong.empty() : OptionalLong.of(setAlignmentValue);
    }

    /**
     * Structured value for {@code set_number_of_dimensions(<int>)} when first param is a decimal int
     * (batch 3 refinement).
     */
    public OptionalLong setNumberOfDimensionsValue() {
        return setNumberOfDimensionsValue == null ? OptionalLong.empty() : OptionalLong.of(setNumberOfDimensionsValue);
    }

    /** Structured low range value for {@code set_range(<low>, <high>)} when both params are decimal ints. */
    public OptionalLong setRangeLowValue() {
        return setRangeLowValue == null ? OptionalLong.empty() : OptionalLong.of(setRangeLowValue);
    }

    /** Structured high range value for {@code set_range(<low>, <high>)} when both params are decimal ints. */
    public OptionalLong setRangeHighValue() {
        return setRangeHighValue == null ? OptionalLong.empty() : OptionalLong.of(setRangeHighValue);
    }

    /** Structured low value for {@code set_dim_range(<low>, <high>, <dim>)} when first two params are decimal ints. */
    public OptionalLong setDimRangeLowValue() {
        return setDimRangeLowValue == null ? OptionalLong.empty() : OptionalLong.of(setDimRangeLowValue);
    }

    /** Structured high value for {@code set_dim_range(<low>, <high>, <dim>)} when first two params are decimal ints. */
    public OptionalLong setDimRangeHighValue() {
        return setDimRangeHighValue == null ? OptionalLong.empty() : OptionalLong.of(setDimRangeHighValue);
    }

    /** Structured top-unit name for {@code set_top_unit(<id>)} when first param is a simple identifier (batch 3 refinement). */
    public Optional<String> setTopUnitName() {
        return Optional.ofNullable(setTopUnitName);
    }

    /**
     * Structured output filename for {@code set_vc_output_filename("...")} when first param is a string literal
     * (batch 3 refinement).
     */
    public Optional<String> setVcOutputFilenameValue() {
        return Optional.ofNullable(setVcOutputFilenameValue);
    }

    /** Structured max-cycles value for {@code set_vc_max_cycles(<int>)} when first param is a decimal int (batch 3 refinement). */
    public OptionalLong setVcMaxCyclesValue() {
        return setVcMaxCyclesValue == null ? OptionalLong.empty() : OptionalLong.of(setVcMaxCyclesValue);
    }

    /**
     * Structured value for {@code set_vc_max_number_of_mismatches(<int>)} when first param is a decimal int
     * (batch 3 refinement).
     */
    public OptionalLong setVcMaxNumberOfMismatchesValue() {
        return setVcMaxNumberOfMismatchesValue == null
                ? OptionalLong.empty()
                : OptionalLong.of(setVcMaxNumberOfMismatchesValue);
    }

    /**
     * Structured value for {@code set_vc_max_number_of_valid_transactions(<int>)} when first param is a decimal int
     * (batch 3 refinement).
     */
    public OptionalLong setVcMaxNumberOfValidTransactionsValue() {
        return setVcMaxNumberOfValidTransactionsValue == null
                ? OptionalLong.empty()
                : OptionalLong.of(setVcMaxNumberOfValidTransactionsValue);
    }

    /**
     * Structured unit name for {@code set_unit_name("...")} when first param is a string literal
     * (batch 3 refinement).
     */
    public Optional<String> setUnitNameValue() {
        return Optional.ofNullable(setUnitNameValue);
    }

    /**
     * Structured naming convention value for {@code pipestage_naming_convention("...")} when first param is a string
     * literal (batch 3 refinement).
     */
    public Optional<String> pipestageNamingConventionValue() {
        return Optional.ofNullable(pipestageNamingConventionValue);
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

    /** Called once by the trunk-port decl bridge when {@code set_depth} param is recognized. */
    public void attachSetDepthValue(long value) {
        if (this.setDepthValue != null) {
            throw new IllegalStateException("set_depth value already set");
        }
        this.setDepthValue = value;
    }

    /** Called once by the trunk-port decl bridge when {@code set_name} param is recognized. */
    public void attachSetNameValue(String unquotedName) {
        Objects.requireNonNull(unquotedName, "unquotedName");
        if (this.setNameValue != null) {
            throw new IllegalStateException("set_name value already set");
        }
        this.setNameValue = unquotedName;
    }

    /** Called once by the trunk-port decl bridge when {@code set_type} param is recognized. */
    public void attachSetTypeValue(String unquotedType) {
        Objects.requireNonNull(unquotedType, "unquotedType");
        if (this.setTypeValue != null) {
            throw new IllegalStateException("set_type value already set");
        }
        this.setTypeValue = unquotedType;
    }

    /** Called once by the trunk-port decl bridge when {@code set_offset} param is recognized. */
    public void attachSetOffsetValue(long value) {
        if (this.setOffsetValue != null) {
            throw new IllegalStateException("set_offset value already set");
        }
        this.setOffsetValue = value;
    }

    /** Called once by the trunk-port decl bridge when {@code set_prefix} param is recognized. */
    public void attachSetPrefixValue(String unquotedPrefix) {
        Objects.requireNonNull(unquotedPrefix, "unquotedPrefix");
        if (this.setPrefixValue != null) {
            throw new IllegalStateException("set_prefix value already set");
        }
        this.setPrefixValue = unquotedPrefix;
    }

    /** Called once by the trunk-port decl bridge when {@code set_suffix} param is recognized. */
    public void attachSetSuffixValue(String unquotedSuffix) {
        Objects.requireNonNull(unquotedSuffix, "unquotedSuffix");
        if (this.setSuffixValue != null) {
            throw new IllegalStateException("set_suffix value already set");
        }
        this.setSuffixValue = unquotedSuffix;
    }

    /** Called once by the trunk-port decl bridge when {@code set_endianess} param is recognized. */
    public void attachSetEndianessValue(String unquotedEndianess) {
        Objects.requireNonNull(unquotedEndianess, "unquotedEndianess");
        if (this.setEndianessValue != null) {
            throw new IllegalStateException("set_endianess value already set");
        }
        this.setEndianessValue = unquotedEndianess;
    }

    /** Called once by the trunk-port decl bridge when {@code set_alignment} param is recognized. */
    public void attachSetAlignmentValue(long value) {
        if (this.setAlignmentValue != null) {
            throw new IllegalStateException("set_alignment value already set");
        }
        this.setAlignmentValue = value;
    }

    /** Called once by the trunk-port decl bridge when {@code set_number_of_dimensions} param is recognized. */
    public void attachSetNumberOfDimensionsValue(long value) {
        if (this.setNumberOfDimensionsValue != null) {
            throw new IllegalStateException("set_number_of_dimensions value already set");
        }
        this.setNumberOfDimensionsValue = value;
    }

    /** Called once by the trunk-port decl bridge when {@code set_range} low/high params are recognized. */
    public void attachSetRangeLowHighValues(long low, long high) {
        if (this.setRangeLowValue != null || this.setRangeHighValue != null) {
            throw new IllegalStateException("set_range low/high already set");
        }
        this.setRangeLowValue = low;
        this.setRangeHighValue = high;
    }

    /** Called once by the trunk-port decl bridge when {@code set_dim_range} low/high params are recognized. */
    public void attachSetDimRangeLowHighValues(long low, long high) {
        if (this.setDimRangeLowValue != null || this.setDimRangeHighValue != null) {
            throw new IllegalStateException("set_dim_range low/high already set");
        }
        this.setDimRangeLowValue = low;
        this.setDimRangeHighValue = high;
    }

    /** Called once by the trunk-port decl bridge when {@code set_top_unit} param is recognized. */
    public void attachSetTopUnitName(String unitName) {
        Objects.requireNonNull(unitName, "unitName");
        if (unitName.isEmpty()) {
            throw new IllegalArgumentException("unitName must be non-empty");
        }
        if (this.setTopUnitName != null) {
            throw new IllegalStateException("set_top_unit name already set");
        }
        this.setTopUnitName = unitName;
    }

    /** Called once by the trunk-port decl bridge when {@code set_vc_output_filename} param is recognized. */
    public void attachSetVcOutputFilenameValue(String unquotedValue) {
        Objects.requireNonNull(unquotedValue, "unquotedValue");
        if (this.setVcOutputFilenameValue != null) {
            throw new IllegalStateException("set_vc_output_filename value already set");
        }
        this.setVcOutputFilenameValue = unquotedValue;
    }

    /** Called once by the trunk-port decl bridge when {@code set_vc_max_cycles} param is recognized. */
    public void attachSetVcMaxCyclesValue(long value) {
        if (this.setVcMaxCyclesValue != null) {
            throw new IllegalStateException("set_vc_max_cycles value already set");
        }
        this.setVcMaxCyclesValue = value;
    }

    /** Called once by the trunk-port decl bridge when {@code set_vc_max_number_of_mismatches} param is recognized. */
    public void attachSetVcMaxNumberOfMismatchesValue(long value) {
        if (this.setVcMaxNumberOfMismatchesValue != null) {
            throw new IllegalStateException("set_vc_max_number_of_mismatches value already set");
        }
        this.setVcMaxNumberOfMismatchesValue = value;
    }

    /** Called once by the trunk-port decl bridge when {@code set_vc_max_number_of_valid_transactions} param is recognized. */
    public void attachSetVcMaxNumberOfValidTransactionsValue(long value) {
        if (this.setVcMaxNumberOfValidTransactionsValue != null) {
            throw new IllegalStateException("set_vc_max_number_of_valid_transactions value already set");
        }
        this.setVcMaxNumberOfValidTransactionsValue = value;
    }

    /** Called once by the trunk-port decl bridge when {@code set_unit_name} param is recognized. */
    public void attachSetUnitNameValue(String unquotedValue) {
        Objects.requireNonNull(unquotedValue, "unquotedValue");
        if (this.setUnitNameValue != null) {
            throw new IllegalStateException("set_unit_name value already set");
        }
        this.setUnitNameValue = unquotedValue;
    }

    /** Called once by the trunk-port decl bridge when {@code pipestage_naming_convention} param is recognized. */
    public void attachPipestageNamingConventionValue(String unquotedValue) {
        Objects.requireNonNull(unquotedValue, "unquotedValue");
        if (this.pipestageNamingConventionValue != null) {
            throw new IllegalStateException("pipestage_naming_convention value already set");
        }
        this.pipestageNamingConventionValue = unquotedValue;
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
