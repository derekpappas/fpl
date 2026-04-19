package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
import org.antlr.v4.runtime.ParserRuleContext;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Comparator;

/**
 * Shared {@code csl_command} verb-shape inference for {@link CslWalkerPortCommandVerbListener} (batch 5 metrics)
 * and {@link CslWalkerPortParserDeclStubBridgeListener} ({@link com.fastpath.cslc.cslom.decl.CslomCommandDecl}).
 */
public final class CslCommandVerbInference {

    private CslCommandVerbInference() {}

    /**
     * Returns {@code assign} when {@code ASSIGN} is present on the context; otherwise the suffix of the
     * alphabetically first non-null {@code param_list_*} child accessor (same rule as the metrics listener);
     * or {@code null} when no accessor matches (callers typically substitute {@code unknown}).
     */
    public static String inferVerbLabelOrNull(CslParserTrunkPort.Csl_commandContext ctx) {
        if (ctx.ASSIGN() != null) {
            return "assign";
        }
        Method[] methods = CslParserTrunkPort.Csl_commandContext.class.getMethods();
        Arrays.sort(methods, Comparator.comparing(Method::getName));
        for (Method m : methods) {
            String n = m.getName();
            if (!n.startsWith("param_list_") || m.getParameterCount() != 0) {
                continue;
            }
            if (!ParserRuleContext.class.isAssignableFrom(m.getReturnType())) {
                continue;
            }
            try {
                Object v = m.invoke(ctx);
                if (v != null) {
                    return n.substring("param_list_".length());
                }
            } catch (IllegalAccessException | InvocationTargetException ignored) {
                return null;
            }
        }
        return null;
    }
}
