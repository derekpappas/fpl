package com.fastpath.cslc.cslgen.cgentb;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

/**
 * Minimal port of the per-class pieces built by legacy {@code buildDeclVectors} in {@code cGenBase_tb.cpp}.
 *
 * <p>This is intentionally tiny: just enough to generate a few real declaration test files without porting the full
 * {@code CSLClass} graph (params/predecl/mandatory ordering/cmd legality matrices).
 */
public final class CGenTbClassSpec {

    public record DeclVariant(String nameSuffix, String declText) {
        public DeclVariant {
            Objects.requireNonNull(nameSuffix, "nameSuffix");
            Objects.requireNonNull(declText, "declText");
        }
    }

    public record CmdVariant(String nameSuffix, String cmdBodyText) {
        public CmdVariant {
            Objects.requireNonNull(nameSuffix, "nameSuffix");
            Objects.requireNonNull(cmdBodyText, "cmdBodyText");
        }
    }

    private final CGenTbEslClass kind;
    private final CGenTbChapter chapter;
    private final List<CGenTbEslClass> preDeclKinds;
    private final List<DeclVariant> legalDecls;
    private final List<CmdVariant> legalCmdCalls;

    public CGenTbClassSpec(
            CGenTbEslClass kind,
            CGenTbChapter chapter,
            List<CGenTbEslClass> preDeclKinds,
            List<DeclVariant> legalDecls,
            List<CmdVariant> legalCmdCalls) {
        this.kind = Objects.requireNonNull(kind, "kind");
        this.chapter = Objects.requireNonNull(chapter, "chapter");
        this.preDeclKinds =
                Collections.unmodifiableList(new ArrayList<>(Objects.requireNonNull(preDeclKinds, "preDeclKinds")));
        this.legalDecls = Collections.unmodifiableList(new ArrayList<>(Objects.requireNonNull(legalDecls, "legalDecls")));
        this.legalCmdCalls = Collections.unmodifiableList(new ArrayList<>(Objects.requireNonNull(legalCmdCalls, "legalCmdCalls")));
    }

    public CGenTbEslClass kind() {
        return kind;
    }

    public CGenTbChapter chapter() {
        return chapter;
    }

    /** Legacy {@code getMandatoryObjs} / predecl vector (subset): kinds that must be declared before this spec’s decl. */
    public List<CGenTbEslClass> preDeclKinds() {
        return preDeclKinds;
    }

    /** “Legal declaration” variants (roughly: legacy {@code cls->getParams()} rows + mandatory cmd emissions). */
    public List<DeclVariant> legalDecls() {
        return legalDecls;
    }

    /** “Legal command call” variants (roughly: legacy cmd table rows). */
    public List<CmdVariant> legalCmdCalls() {
        return legalCmdCalls;
    }
}

