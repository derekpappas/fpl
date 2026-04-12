package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenIsaAoPrintTest {

    @Test
    void printContainsIsaAoKeywords() {
        String text = "";
        for (long seed = 0; seed < 5000; seed++) {
            Random rng = new Random(seed);
            CslGenDesign d = new CslGenDesign("design");
            d.buildDecl(rng);
            StringBuilder out = new StringBuilder();
            d.appendPrintedCsl(out);
            text = out.toString();
            if (text.contains("csl_isa_instruction_format")
                    && text.contains("csl_isa_instruction")
                    && text.contains("csl_isa ")) {
                break;
            }
        }
        assertTrue(text.contains("csl_isa_instruction_format"));
        assertTrue(text.contains("csl_isa_instruction"));
        assertTrue(text.contains("csl_isa "));
    }

    @Test
    void isaAoUsedSlotsAreBounded() {
        CslGenIsaInstrFormat fmt = new CslGenIsaInstrFormat(new CslGenDesign("d"), "fmt");
        assertThrows(IndexOutOfBoundsException.class, () -> fmt.getIsaInstrFormatUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> fmt.getIsaInstrFormatUsedAt(CslGenIsaAoTables.ISA_INSTR_FORMAT_USED_VECTOR_SIZE));
        fmt.buildDecl(new Random(3L));
        for (int i = 0; i < CslGenIsaAoTables.ISA_INSTR_FORMAT_USED_VECTOR_SIZE; i++) {
            int v = fmt.getIsaInstrFormatUsedAt(i);
            assertTrue(v == 0 || v == 1);
        }
        fmt.getWidthNumExprText();

        CslGenIsaInstr instr = new CslGenIsaInstr(new CslGenDesign("d"), "ins");
        assertThrows(IndexOutOfBoundsException.class, () -> instr.getIsaInstrUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> instr.getIsaInstrUsedAt(CslGenIsaAoTables.ISA_INSTR_USED_VECTOR_SIZE));
        instr.buildDecl(new Random(4L));
        instr.getSetAsmMnemonicStringText();
        assertThrows(UnsupportedOperationException.class, () -> instr.getSetAsmMnemonicFieldNames().add("x"));

        CslGenIsa isa = new CslGenIsa(new CslGenDesign("d"), "isa");
        assertThrows(IndexOutOfBoundsException.class, () -> isa.getIsaUsedAt(-1));
        assertThrows(IndexOutOfBoundsException.class, () -> isa.getIsaUsedAt(CslGenIsaAoTables.ISA_USED_VECTOR_SIZE));
        isa.buildDecl(new Random(5L));
        isa.getSetDecoderNameText();
    }
}
