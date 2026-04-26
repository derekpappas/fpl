package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.OptionalLong;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Per-{@code csl_command} exit metrics for porting legacy {@code csl.walker.g} command rules (batch 5): counts
 * exits, records the inferred verb from the first (alphabetically) non-null {@code param_list_*} child accessor
 * on {@link CslParserTrunkPort.Csl_commandContext}, and keeps the last receiver {@code IDENTIFIER(0)} when present.
 * Assignment-shaped commands ({@code ASSIGN} present) are labeled {@code assign}.
 *
 * <p>Continuation: {@linkplain #commandTextsInExitOrder() command subtree text} from {@code Csl_commandContext#getText}
 * (same span as the grammar rule, typically excluding the trailing {@code ;}).
 */
public final class CslWalkerPortCommandVerbListener extends CslTrunkPortListenerSkeleton {

    private final AtomicInteger cslCommandExitCount = new AtomicInteger();
    private final List<String> verbsInExitOrder = new ArrayList<>();
    private final List<String> commandTextsInExitOrder = new ArrayList<>();
    private final List<String> verbTokenTextsInExitOrder = new ArrayList<>();
    private final List<String> receiverChainTextsInExitOrder = new ArrayList<>();
    private final List<List<String>> receiverChainSegmentsInExitOrder = new ArrayList<>();
    private final List<String> receiverFirstRangeExpressionTextsInExitOrder = new ArrayList<>();
    private final List<Long> receiverFirstRangeIntLiteralsInExitOrder = new ArrayList<>();
    private volatile String lastReceiverIdentifier;

    @Override
    public void exitCsl_command(CslParserTrunkPort.Csl_commandContext ctx) {
        cslCommandExitCount.incrementAndGet();
        String raw = ctx.getText();
        commandTextsInExitOrder.add(raw != null ? raw : "");
        TerminalNode id0 = ctx.IDENTIFIER(0);
        lastReceiverIdentifier = id0 != null ? id0.getText() : null;
        String verb = CslCommandVerbInference.inferVerbLabelOrNull(ctx);
        String verbLabel = verb != null ? verb : "unknown";
        verbsInExitOrder.add(verbLabel);

        Optional<String> verbTokenText = extractVerbTokenText(raw);
        verbTokenTextsInExitOrder.add(verbTokenText.orElse(""));

        // Receiver chain prefix is the raw text before the verb token for normal commands.
        // Assignment-shaped commands (verbLabel=assign) are derived from the LHS before '='.
        Optional<String> receiverChainText = Optional.empty();
        if (raw != null && !raw.isEmpty()) {
            if ("assign".equals(verbLabel)) {
                int eq = raw.indexOf('=');
                if (eq > 0) {
                    String lhs = raw.substring(0, eq);
                    receiverChainText = Optional.of(lhs.endsWith(".") ? lhs : lhs + ".");
                }
            } else if (verb != null && !verb.isEmpty()) {
                int ix = raw.indexOf(verb);
                if (ix > 0) {
                    receiverChainText = Optional.of(raw.substring(0, ix));
                }
            }
        }
        receiverChainTextsInExitOrder.add(receiverChainText.orElse(""));
        receiverChainSegmentsInExitOrder.add(extractReceiverChainSegments(receiverChainText.orElse("")).orElse(List.of()));

        Optional<String> rangeExpr = extractFirstBracketContents(receiverChainText.orElse(""));
        receiverFirstRangeExpressionTextsInExitOrder.add(rangeExpr.orElse(""));
        OptionalLong rangeInt = rangeExpr.isPresent() ? parseDecimalIntLiteral(rangeExpr.get()) : OptionalLong.empty();
        receiverFirstRangeIntLiteralsInExitOrder.add(rangeInt.isPresent() ? rangeInt.getAsLong() : null);
    }

    /** Number of {@code exitCsl_command} callbacks (walk order). */
    public int getCslCommandExitCount() {
        return cslCommandExitCount.get();
    }

    /** Immutable list of inferred verbs in exit order (same length as exit count). */
    public List<String> verbsInExitOrder() {
        return List.copyOf(verbsInExitOrder);
    }

    /** Immutable list of {@code csl_command} subtree texts in exit order (same length as exit count). */
    public List<String> commandTextsInExitOrder() {
        return List.copyOf(commandTextsInExitOrder);
    }

    /** Immutable list of verb token texts in exit order (empty string when not captured). */
    public List<String> verbTokenTextsInExitOrder() {
        return List.copyOf(verbTokenTextsInExitOrder);
    }

    /** Immutable list of receiver chain prefix texts in exit order (empty string when absent). */
    public List<String> receiverChainTextsInExitOrder() {
        return List.copyOf(receiverChainTextsInExitOrder);
    }

    /**
     * Immutable list of receiver chain segments (split on dot, empty list when absent) in exit order.
     * Example: {@code u.a[3].b.} → {@code ["u","a[3]","b"]}.
     */
    public List<List<String>> receiverChainSegmentsInExitOrder() {
        return List.copyOf(receiverChainSegmentsInExitOrder);
    }

    /** Immutable list of first {@code [...] } range expression texts in receiver chains (empty string when absent). */
    public List<String> receiverFirstRangeExpressionTextsInExitOrder() {
        return List.copyOf(receiverFirstRangeExpressionTextsInExitOrder);
    }

    /**
     * Immutable list of first {@code [...] } range expressions parsed as base-10 longs (null when absent / non-decimal).
     */
    public List<Long> receiverFirstRangeIntLiteralsInExitOrder() {
        return List.copyOf(receiverFirstRangeIntLiteralsInExitOrder);
    }

    /** Text of {@code IDENTIFIER(0)} on the last exited {@code csl_command}, or {@code null}. */
    public String getLastReceiverIdentifier() {
        return lastReceiverIdentifier;
    }

    private static Optional<String> extractVerbTokenText(String rawCommandText) {
        if (rawCommandText == null || rawCommandText.isEmpty()) {
            return Optional.empty();
        }
        if (rawCommandText.indexOf('=') >= 0) {
            return Optional.of("=");
        }
        int lp = rawCommandText.indexOf('(');
        if (lp < 0) {
            return Optional.empty();
        }
        int i = lp - 1;
        while (i >= 0) {
            char c = rawCommandText.charAt(i);
            if ((c >= 'a' && c <= 'z')
                    || (c >= 'A' && c <= 'Z')
                    || (c >= '0' && c <= '9')
                    || c == '_') {
                i--;
                continue;
            }
            break;
        }
        int start = i + 1;
        if (start >= lp) {
            return Optional.empty();
        }
        String token = rawCommandText.substring(start, lp);
        if (token.isEmpty()) {
            return Optional.empty();
        }
        char c0 = token.charAt(0);
        if (!((c0 >= 'a' && c0 <= 'z') || (c0 >= 'A' && c0 <= 'Z') || c0 == '_')) {
            return Optional.empty();
        }
        return Optional.of(token);
    }

    private static Optional<String> extractFirstBracketContents(String receiverChainText) {
        if (receiverChainText == null || receiverChainText.isEmpty()) {
            return Optional.empty();
        }
        int lb = receiverChainText.indexOf('[');
        if (lb < 0) {
            return Optional.empty();
        }
        int rb = receiverChainText.indexOf(']', lb + 1);
        if (rb < 0 || rb <= lb + 1) {
            return Optional.empty();
        }
        return Optional.of(receiverChainText.substring(lb + 1, rb));
    }

    private static OptionalLong parseDecimalIntLiteral(String text) {
        if (text == null || text.isEmpty()) {
            return OptionalLong.empty();
        }
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (c < '0' || c > '9') {
                return OptionalLong.empty();
            }
        }
        try {
            return OptionalLong.of(Long.parseLong(text));
        } catch (NumberFormatException ignored) {
            return OptionalLong.empty();
        }
    }

    private static Optional<List<String>> extractReceiverChainSegments(String receiverChainText) {
        if (receiverChainText == null || receiverChainText.isEmpty()) {
            return Optional.empty();
        }
        String[] parts = receiverChainText.split("\\.");
        List<String> segs = new ArrayList<>();
        for (String p : parts) {
            if (p == null || p.isEmpty()) {
                continue;
            }
            segs.add(p);
        }
        return segs.isEmpty() ? Optional.empty() : Optional.of(segs);
    }

}
