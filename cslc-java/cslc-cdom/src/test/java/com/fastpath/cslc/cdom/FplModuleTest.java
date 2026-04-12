package com.fastpath.cslc.cdom;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.Test;

class FplModuleTest {

    static final class Stub extends FplModule {
        final List<String> vec = new ArrayList<>();
        final List<String> vcd = new ArrayList<>();

        Stub() {
            super("m");
        }

        @Override
        public void createInstVec(String inst) {
            vec.add(inst);
        }

        @Override
        public void createInstVcd(String inst) {
            vcd.add(inst);
        }
    }

    @Test
    void moduleNamePreserved() {
        Stub s = new Stub();
        assertEquals("m", s.getModuleName());
        s.createInstVec("u1");
        assertEquals(List.of("u1"), s.vec);
    }
}
