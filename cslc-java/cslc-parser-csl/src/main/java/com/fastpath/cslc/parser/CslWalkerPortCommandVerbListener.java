package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.List;
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
    private volatile String lastReceiverIdentifier;

    @Override
    public void exitCsl_command(CslParserTrunkPort.Csl_commandContext ctx) {
        cslCommandExitCount.incrementAndGet();
        String raw = ctx.getText();
        commandTextsInExitOrder.add(raw != null ? raw : "");
        TerminalNode id0 = ctx.IDENTIFIER(0);
        lastReceiverIdentifier = id0 != null ? id0.getText() : null;
        String verb = CslCommandVerbInference.inferVerbLabelOrNull(ctx);
        verbsInExitOrder.add(verb != null ? verb : "unknown");
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

    /** Text of {@code IDENTIFIER(0)} on the last exited {@code csl_command}, or {@code null}. */
    public String getLastReceiverIdentifier() {
        return lastReceiverIdentifier;
    }

}
