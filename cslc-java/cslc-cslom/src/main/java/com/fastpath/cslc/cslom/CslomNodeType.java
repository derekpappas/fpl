package com.fastpath.cslc.cslom;

/**
 * Legacy {@code NSCSLOm::ECSLOmType} ({@code trunk/cslc/trunk/src/cslom/CSLOM_Declarations.h}).
 * Numeric codes match the C/C++ enumerator values for the current trunk header (including the gap at 28
 * where {@code TYPE_PARAMETER_OVERRIDE} was commented out).
 */
public enum CslomNodeType {
    TYPE_ALL_TYPES(0),
    TYPE_ALL_TOP_LEVELS(1),
    TYPE_ALL_SCOPE_HOLDERS(2),
    TYPE_ALL_SIGNALS(3),
    TYPE_ALL_FIELDS(4),
    TYPE_ALL_ISA(5),
    TYPE_ALL_INTERFACES(6),
    TYPE_ALL_PORTS(7),
    TYPE_ALL_GROUPS(8),
    TYPE_ALL_IDS(9),
    TYPE_ALL_SIMPLE_BR(10),
    TYPE_ALL_VERIF_COMPS(11),
    TYPE_ALL_TBS(12),
    TYPE_DESIGN(13),
    TYPE_INCLUDE(14),
    TYPE_ID_SIMPLE(15),
    TYPE_ID_SCOPE_DIRECT(16),
    TYPE_ID_SCOPE_INDIRECT(17),
    TYPE_DECL_UNIT(18),
    TYPE_DECL_TESTBENCH(19),
    TYPE_CONNECTABLE(20),
    TYPE_INST_UNIT(21),
    TYPE_BIT_RANGE(22),
    TYPE_EXPR(23),
    TYPE_LIST_EXPR(24),
    TYPE_UNIT_INSTANTIATION(25),
    TYPE_LIST(26),
    TYPE_PARAMETER(27),
    TYPE_COMMAND(28),
    TYPE_ADDRESS_RANGE(29),
    TYPE_MEMORY_MAP_LOCATION(30),
    TYPE_MEMORY_MAP_PAGE(31),
    TYPE_MEMORY_MAP_PAGE_INST(32),
    TYPE_MEMORY_MAP(33),
    TYPE_VECTOR(34),
    TYPE_ENUM(35),
    TYPE_ISA_ELEMENT(36),
    TYPE_CONTAINER(37),
    TYPE_MUX(38),
    TYPE_STMT(39),
    TYPE_UNIT_INFO(40);

    private final int legacyCode;

    CslomNodeType(int legacyCode) {
        this.legacyCode = legacyCode;
    }

    /** Same integer as legacy {@code ECSLOmType} for this trunk revision. */
    public int legacyCode() {
        return legacyCode;
    }

    public static CslomNodeType fromLegacyCode(int code) {
        for (CslomNodeType t : values()) {
            if (t.legacyCode == code) {
                return t;
            }
        }
        throw new IllegalArgumentException("Unknown ECSLOmType code: " + code);
    }
}
