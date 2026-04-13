package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CGenInstCmdTbTest {

    @Test
    void stubMainSucceedsWhenArgsValid() {
        assertEquals(0, CGenInstCmdTb.runStubMain(new String[] {"cgen_inst_cmds_tb"}));
        assertEquals(0, CGenInstCmdTb.runStubMain(new String[] {"cgen_inst_cmds_tb", "isa"}));
    }

    @Test
    void stubMainFailsOnBadArgs() {
        assertEquals(1, CGenInstCmdTb.runStubMain(new String[] {"p", "bad"}));
        assertEquals(1, CGenInstCmdTb.runStubMain(new String[] {"p", CGenTbMainArgs.ARG_HELP}));
    }
}
