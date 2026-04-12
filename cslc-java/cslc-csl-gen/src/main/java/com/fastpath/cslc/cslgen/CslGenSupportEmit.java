package com.fastpath.cslc.cslgen;

import java.util.Objects;

/**
 * Legacy {@code support.cpp} helpers that wrote to {@code std::ostream*} — append the same text to a
 * {@link StringBuilder} (or any {@link Appendable} where noted).
 */
public final class CslGenSupportEmit {

    private CslGenSupportEmit() {}

    public static StringBuilder lCbrace(StringBuilder out) {
        return out.append("{\n");
    }

    public static StringBuilder rCbrace(StringBuilder out) {
        return out.append("}\n");
    }

    public static StringBuilder init(StringBuilder out) {
        return out.append("  void initialise()");
    }

    public static StringBuilder lParenthesis(StringBuilder out) {
        return out.append('(');
    }

    public static StringBuilder rParenthesis(StringBuilder out) {
        return out.append(')');
    }

    public static StringBuilder comma(StringBuilder out) {
        return out.append(", ");
    }

    public static StringBuilder semicolon(StringBuilder out) {
        return out.append(";\n");
    }

    public static StringBuilder cslFifo(StringBuilder out) {
        return out.append("csl_fifo ");
    }

    public static StringBuilder cslIsaField(StringBuilder out) {
        return out.append("csl_isa_field ");
    }

    public static StringBuilder cslIsaElement(StringBuilder out) {
        return out.append("csl_isa_element ");
    }

    /** Legacy {@code cslIsaInstructionFormat(m_out)} in {@code cGenIsa_ao.cpp} (comment: {@code csl_isa_instruction_format}). */
    public static StringBuilder cslIsaInstructionFormat(StringBuilder out) {
        return out.append("csl_isa_instruction_format ");
    }

    /** Legacy {@code cslIsaInstruction(m_out)} in {@code cGenIsa_ao.cpp}. */
    public static StringBuilder cslIsaInstruction(StringBuilder out) {
        return out.append("csl_isa_instruction ");
    }

    /** Legacy {@code cslIsa(m_out)} in {@code cGenIsa_ao.cpp}. */
    public static StringBuilder cslIsa(StringBuilder out) {
        return out.append("csl_isa ");
    }

    public static StringBuilder cslMemoryMapPage(StringBuilder out) {
        return out.append("csl_memory_map_page ");
    }

    public static StringBuilder cslMemoryMap(StringBuilder out) {
        return out.append("csl_memory_map ");
    }

    public static StringBuilder cslMemory(StringBuilder out) {
        return out.append("csl_memory ");
    }

    public static StringBuilder cslRegister(StringBuilder out) {
        return out.append("csl_register ");
    }

    public static StringBuilder cslRegisterFile(StringBuilder out) {
        return out.append("csl_register_file ");
    }

    public static StringBuilder cslField(StringBuilder out) {
        return out.append("csl_field ");
    }

    public static StringBuilder funct0param(StringBuilder out, String functName) {
        Objects.requireNonNull(functName, "functName");
        out.append("     ").append(functName);
        lParenthesis(out);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder funct1param(StringBuilder out, String functName, String firstParam) {
        Objects.requireNonNull(functName, "functName");
        Objects.requireNonNull(firstParam, "firstParam");
        out.append("     ").append(functName);
        lParenthesis(out);
        out.append(firstParam);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder funct2param(StringBuilder out, String functName, String firstParam, String secondParam) {
        Objects.requireNonNull(functName, "functName");
        Objects.requireNonNull(firstParam, "firstParam");
        Objects.requireNonNull(secondParam, "secondParam");
        out.append("     ").append(functName);
        lParenthesis(out);
        out.append(firstParam);
        comma(out);
        out.append(secondParam);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder funct3param(
            StringBuilder out, String functName, String firstParam, String secondParam, String thirdParam) {
        Objects.requireNonNull(functName, "functName");
        Objects.requireNonNull(firstParam, "firstParam");
        Objects.requireNonNull(secondParam, "secondParam");
        Objects.requireNonNull(thirdParam, "thirdParam");
        out.append("     ").append(functName);
        lParenthesis(out);
        out.append(firstParam);
        comma(out);
        out.append(secondParam);
        comma(out);
        out.append(thirdParam);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder displayFunctDecl(StringBuilder out, String command, String name) {
        Objects.requireNonNull(command, "command");
        Objects.requireNonNull(name, "name");
        out.append("  ").append(command).append(' ').append(name);
        return semicolon(out);
    }

    public static StringBuilder dot(StringBuilder out) {
        return out.append('.');
    }

    public static StringBuilder space(StringBuilder out) {
        return out.append(' ');
    }

    public static StringBuilder decl0param(StringBuilder out, String type, String name) {
        Objects.requireNonNull(type, "type");
        Objects.requireNonNull(name, "name");
        out.append("  ").append(type);
        space(out);
        out.append(name);
        return semicolon(out);
    }

    public static StringBuilder decl1param(StringBuilder out, String type, String name, String firstParam) {
        Objects.requireNonNull(type, "type");
        Objects.requireNonNull(name, "name");
        Objects.requireNonNull(firstParam, "firstParam");
        out.append("  ").append(type);
        space(out);
        out.append(name);
        lParenthesis(out);
        out.append(firstParam);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder decl2param(
            StringBuilder out, String type, String name, String firstParam, String secondParam) {
        Objects.requireNonNull(type, "type");
        Objects.requireNonNull(name, "name");
        Objects.requireNonNull(firstParam, "firstParam");
        Objects.requireNonNull(secondParam, "secondParam");
        out.append("  ").append(type);
        space(out);
        out.append(name);
        lParenthesis(out);
        out.append(firstParam);
        comma(out);
        out.append(secondParam);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder decl3param(
            StringBuilder out, String type, String name, String firstParam, String secondParam, String thirdParam) {
        Objects.requireNonNull(type, "type");
        Objects.requireNonNull(name, "name");
        Objects.requireNonNull(firstParam, "firstParam");
        Objects.requireNonNull(secondParam, "secondParam");
        Objects.requireNonNull(thirdParam, "thirdParam");
        out.append("  ").append(type);
        space(out);
        out.append(name);
        lParenthesis(out);
        out.append(firstParam);
        comma(out);
        out.append(secondParam);
        comma(out);
        out.append(thirdParam);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder declSHbegin(StringBuilder out, String type, String name) {
        Objects.requireNonNull(type, "type");
        Objects.requireNonNull(name, "name");
        out.append(type);
        space(out);
        out.append(name);
        return lCbrace(out);
    }

    public static StringBuilder declSHend(StringBuilder out) {
        return out.append("};\n");
    }

    public static StringBuilder constrSHbegin(StringBuilder out, String name) {
        Objects.requireNonNull(name, "name");
        out.append("  ").append(name);
        lParenthesis(out);
        rParenthesis(out);
        space(out);
        return lCbrace(out);
    }

    public static StringBuilder constrSHend(StringBuilder out) {
        out.append("  ");
        return rCbrace(out);
    }

    public static StringBuilder call0param(StringBuilder out, String scope, String caller, String funct) {
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(caller, "caller");
        Objects.requireNonNull(funct, "funct");
        out.append("    ").append(scope).append(caller);
        dot(out);
        out.append(funct);
        lParenthesis(out);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder call1param(StringBuilder out, String scope, String caller, String funct, String firstParam) {
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(caller, "caller");
        Objects.requireNonNull(funct, "funct");
        Objects.requireNonNull(firstParam, "firstParam");
        out.append("    ").append(scope).append(caller);
        dot(out);
        out.append(funct);
        lParenthesis(out);
        out.append(firstParam);
        rParenthesis(out);
        return semicolon(out);
    }

    public static StringBuilder call2param(
            StringBuilder out, String scope, String caller, String funct, String firstParam, String secondParam) {
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(caller, "caller");
        Objects.requireNonNull(funct, "funct");
        Objects.requireNonNull(firstParam, "firstParam");
        Objects.requireNonNull(secondParam, "secondParam");
        out.append("    ").append(scope).append(caller);
        dot(out);
        out.append(funct);
        lParenthesis(out);
        out.append(firstParam);
        comma(out);
        out.append(secondParam);
        rParenthesis(out);
        return semicolon(out);
    }
}
