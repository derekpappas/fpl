package com.fastpath.cslc.cli;

import com.fastpath.cslc.parser.CslLexerFacade;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Entry point replacing {@code new_cslc.cpp} / {@code CSLcMain::runCompiler} (staged implementation).
 */
public final class CslcMain {

    public static void main(String[] args) {
        if (args.length > 0 && ("--lex-smoke".equals(args[0]) || "-lex-smoke".equals(args[0]))) {
            var tokens = CslLexerFacade.tokenize("csl_unit foo;");
            System.out.println(tokens.getFirst().getText());
            return;
        }
        if (args.length > 0 && "--virtual-thread-demo".equals(args[0])) {
            try (ExecutorService ex = Executors.newVirtualThreadPerTaskExecutor()) {
                ex.submit(() -> System.out.println("virtual thread ok"));
            }
            return;
        }
        System.err.println("CSLC Java — use --lex-smoke or --virtual-thread-demo (full compiler in progress).");
        System.exit(1);
    }

    private CslcMain() {}
}
