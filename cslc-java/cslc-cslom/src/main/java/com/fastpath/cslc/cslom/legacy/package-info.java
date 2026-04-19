/**
 * Legacy ANTLR2 artifacts that are not represented as Java yet.
 *
 * <p>Trunk walker grammars (tree transforms, not ANTLR4): {@code csl.walker.g} and {@code verilog.walker.g}
 * under {@code trunk/cslc/trunk/src/parser/}. New work should prefer ANTLR4 parse trees from
 * {@code cslc-grammars} plus listeners or visitors instead of porting those {@code .g} files verbatim.
 * Starter no-op listeners: {@code com.fastpath.cslc.parser.CslTrunkPortListenerSkeleton} /
 * {@code com.fastpath.cslc.parser.VerilogTrunkPortListenerSkeleton}; entry-count helpers
 * {@code com.fastpath.cslc.parser.CslWalkerPortMetricsListener} /
 * {@code com.fastpath.cslc.parser.VerilogWalkerPortMetricsListener} (same modules).
 * Rule hooks started: {@code com.fastpath.cslc.parser.CslWalkerPortCslUnitDeclarationListener},
 * {@code com.fastpath.cslc.parser.VerilogWalkerPortModuleListener}.
 * Parse-tree → CSLOM: {@code com.fastpath.cslc.parser.CslWalkerPortParserDeclStubBridgeListener} ({@code CslomUnitDecl}
 * + stubs); batch plan
 * {@code ANTLR_PORT_BATCH_PLAN.txt} (cslc-java root).
 * Rule-name inventories for those files live in the repo script {@code scripts/list_antlr2_rule_headers.py}
 * ({@code scripts/list_antlr2_treeparser_rules.py} is a deprecated alias).
 *
 * @see com.fastpath.cslc.cslom.legacy.LegacyAntlrWalkerSources
 * @see com.fastpath.cslc.cslom.legacy.LegacyAntlrParserSources
 */
package com.fastpath.cslc.cslom.legacy;
