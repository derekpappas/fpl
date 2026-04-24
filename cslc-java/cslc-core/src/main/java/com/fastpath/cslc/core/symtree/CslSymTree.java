package com.fastpath.cslc.core.symtree;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Objects;
import java.util.Optional;

/**
 * Minimal scoped symbol tree (legacy trunk {@code CSymTree} analogue).
 *
 * <p>Designed as a "preamble/symtree" replacement host for incremental ANTLR4 porting:
 * walkers can declare/enter/exit scopes without committing to a full semantic model yet.
 */
public final class CslSymTree {

    private final CslSymNode root;
    private final Deque<CslSymNode> scopeStack = new ArrayDeque<>();

    public CslSymTree() {
        this.root = new CslSymNode("", CslObjType.DESIGN, 0, 0, null, null);
        scopeStack.push(root);
    }

    public CslSymNode root() {
        return root;
    }

    public CslSymNode currentScope() {
        return scopeStack.peek();
    }

    /**
     * Declares a symbol in the current scope (fails if the name already exists).
     */
    public CslSymNode declare(String name, CslObjType type, int line, int column, String sourceName) {
        requireNonBlank(name, "name");
        Objects.requireNonNull(type, "type");
        CslSymNode node = new CslSymNode(name, type, line, column, sourceName, currentScope());
        currentScope().addChild(node);
        return node;
    }

    /**
     * Pushes {@code scopeHolder} as the new current scope.
     */
    public void enterScope(CslSymNode scopeHolder) {
        Objects.requireNonNull(scopeHolder, "scopeHolder");
        scopeStack.push(scopeHolder);
    }

    /**
     * Pops the current scope; root is never popped.
     */
    public void exitScope() {
        if (scopeStack.size() <= 1) {
            return;
        }
        scopeStack.pop();
    }

    /**
     * Lookup by name from the current scope outward to root.
     */
    public Optional<CslSymNode> lookup(String name) {
        requireNonBlank(name, "name");
        for (CslSymNode n : scopeStack) {
            Optional<CslSymNode> hit = n.childNamed(name);
            if (hit.isPresent()) {
                return hit;
            }
        }
        return Optional.empty();
    }

    private static void requireNonBlank(String s, String field) {
        if (s == null || s.isBlank()) {
            throw new IllegalArgumentException(field + " must be non-blank");
        }
    }
}

