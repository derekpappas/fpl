package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import org.junit.jupiter.api.Test;

/**
 * Exercises {@link CslGenRegister#print} branches that depend on {@code m_used} slots filled by {@link
 * CslGenRegister#buildDecl(RandomGenerator)} and design context (memory maps, fields, other registers).
 */
class CslGenRegisterPrintWalkCoverageTest {

    private static final List<String> R_EMIT = List.of(
            "set_address(",
            "index_data_pair(",
            "set_attributes(",
            "connect_input_to_field",
            "connect_output_to_field",
            "stop_at_end_value",
            "gray_output",
            "inc_signal",
            "dec_signal",
            "serial_input",
            "neg_output",
            "set_lock_enable_bit",
            "constant(",
            "reset_value(",
            "clear_value(",
            "set_count_direction(",
            "set_end_value(",
            "set_start_value(");

    private static void collectRegisters(CslGenCslBase root, List<CslGenRegister> out) {
        if (root instanceof CslGenRegister reg) {
            out.add(reg);
        }
        for (CslGenCslBase ch : root.getChildren()) {
            collectRegisters(ch, out);
        }
    }

    private static void addRegisterHeavyFixture(CslGenDesign d, long seed) {
        Random r = new Random(seed);
        for (int i = 0; i < 8; i++) {
            d.addMemMap(r);
        }
        for (int i = 0; i < 20; i++) {
            d.addField(r);
        }
        for (int i = 0; i < 40; i++) {
            d.addRegister(r);
        }
    }

    @Test
    void seededDesignsCoverRegisterPrintEmitters() {
        Set<String> hit = new HashSet<>();
        long s = 0;
        long limit = 400_000L;
        for (; s < limit && hit.size() < R_EMIT.size(); s++) {
            CslGenDesign d = new CslGenDesign("d");
            addRegisterHeavyFixture(d, s);
            List<CslGenRegister> regs = new ArrayList<>();
            collectRegisters(d, regs);
            StringBuilder blob = new StringBuilder();
            for (CslGenRegister reg : regs) {
                reg.appendPrintedCsl(blob);
                blob.append('\n');
            }
            String t = blob.toString();
            for (String k : R_EMIT) {
                if (t.contains(k)) {
                    hit.add(k);
                }
            }
        }
        assertEquals(
                R_EMIT.size(),
                hit.size(),
                "after "
                        + s
                        + " seeds, missing emitters: "
                        + missing(R_EMIT, hit));
    }

    private static List<String> missing(List<String> expected, Set<String> hit) {
        List<String> m = new ArrayList<>();
        for (String e : expected) {
            if (!hit.contains(e)) {
                m.add(e);
            }
        }
        return m;
    }
}
