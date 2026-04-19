package com.fastpath.cslc.parser;

import org.antlr.v4.runtime.ParserRuleContext;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Collects {@link ParserRuleContext} entry counts while walking a {@code CslParserTrunkPort} tree.
 * Keys are generated context class simple names (for example {@code Source_textContext} for rule
 * {@code source_text}), which is stable for a given grammar and useful when diffing against legacy
 * {@code csl.walker.g} rule ports.
 */
public final class CslWalkerPortMetricsListener extends CslTrunkPortListenerSkeleton {

    private final Map<String, Integer> enterCountByContextClass = new HashMap<>();

    @Override
    public void enterEveryRule(ParserRuleContext ctx) {
        enterCountByContextClass.merge(ctx.getClass().getSimpleName(), 1, Integer::sum);
    }

    /** Immutable snapshot of {@code enterEveryRule} counts keyed by context class simple name. */
    public Map<String, Integer> enterCountsByContextClass() {
        return Collections.unmodifiableMap(new HashMap<>(enterCountByContextClass));
    }

    public int totalParserRuleEnters() {
        return enterCountByContextClass.values().stream().mapToInt(Integer::intValue).sum();
    }
}
