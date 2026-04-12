package com.fastpath.cslc.cslom;

/**
 * Grouped declarations from {@code CSLOM_Declarations.h} (first portions — extend as the port deepens).
 */
public final class CslomDeclarations {

    private CslomDeclarations() {}

    public enum SignalAccessType {
        UNDEFINED,
        RD,
        WR,
        PING,
        MAX
    }

    public enum MemoryMapType {
        UNDEFINED(-1),
        FLAT(0),
        VIRTUAL_W_BASE_ADDR(1),
        VIRTUAL_W_PAGE_NO(2),
        HIERARCHICAL(3),
        MAX(4);

        private final int legacyCode;

        MemoryMapType(int legacyCode) {
            this.legacyCode = legacyCode;
        }

        public int legacyCode() {
            return legacyCode;
        }
    }

    public enum IncludeFileType {
        VERILOG,
        CPLUSPLUS
    }

    public enum EnumMetaType {
        ACCESS,
        ATTR,
        TYPE,
        BASE,
        VSD_RADIX,
        VSD_EDGE_TYPE
    }

    public enum SignalAttr {
        UNDEFINED,
        EN,
        STALL,
        PE,
        PS,
        MS,
        DEC,
        CLK,
        RST,
        WR_EN,
        MAX
    }

    public enum FuncName {
        GET_ACCESS_RIGHTS_ENUM,
        GET_ADDR_INCREMENT,
        GET_ALIGMENT,
        GET_ASM_MNEMONIC,
        GET_ATTR,
        GET_ATTRIBUTES,
        GET_BITRANGE,
        GET_DATA_WORD_WIDTH,
        GET_DEPTH,
        GET_DIM_BITRANGE,
        GET_DIM_LOWER_INDEX,
        GET_DIM_OFFSET,
        GET_DIM_UPPER_INDEX,
        GET_DIM_WIDTH,
        GET_ENDIANESS,
        GET_ENUM,
        GET_ENUM_ITEM,
        GET_FILENAME,
        GET_ID,
        GET_INTERFACE,
        GET_LOWER_INDEX,
        GET_MAX_ERROR_COUNT,
        GET_MAX_NUM_STATES,
        GET_MAX_NUM_VETORS,
        GET_NAME,
        GET_NEXT_ADDRESS,
        GET_NUMBER_OF_DIMENSIONS,
        GET_OFFSET,
        GET_REVERSED_INTERFACE,
        GET_SIGNAL_PREFIX,
        GET_SIGNAL_PREFIX_LOCAL,
        GET_SIGNAL_VALUE,
        GET_SIMULATION_TIMEOUT_COUNT,
        GET_SYMBOL_LENGTH,
        GET_TYPE,
        GET_UNDEFINED,
        GET_UNIT_PREFIX,
        GET_UPPER_INDEX,
        GET_VALUE,
        GET_WIDTH,
        GET_RADIX
    }

    public enum PortDirection {
        UNDEFINED,
        INOUT,
        INPUT,
        OUTPUT,
        MAX
    }

    public enum VerilogDialect {
        UNDEFINED,
        V1995,
        V2001,
        MAX
    }

    public enum SignalType {
        UNDEFINED,
        TRIREG,
        TRI,
        WIRE,
        WOR,
        WAND,
        TRIOR,
        TRI0,
        TRI1,
        TRIAND,
        SUPPLY_0,
        SUPPLY_1,
        REG,
        VAR_INTEGER,
        VAR_REAL,
        VAR_REALTIME,
        VAR_TIME,
        MAX
    }

    public enum AccessCategory {
        UNDEFINED(-1),
        HARDWARE(0),
        SOFTWARE(2),
        TEST(4),
        APPLICATION(6),
        DRIVER(8);

        private final int legacyCode;

        AccessCategory(int legacyCode) {
            this.legacyCode = legacyCode;
        }

        public int legacyCode() {
            return legacyCode;
        }
    }

    public enum AccessRights {
        NONE(0x0),
        R(0x1),
        W(0x2),
        RW(0x3);

        private final int mask;

        AccessRights(int mask) {
            this.mask = mask;
        }

        public int mask() {
            return mask;
        }
    }
}
