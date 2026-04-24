package com.fastpath.cslc.core.symtree;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

class CslSymTreeTest {

    @Test
    void declareLookupAndScopedShadowing() {
        CslSymTree st = new CslSymTree();
        st.declare("u", CslObjType.UNIT_DECL, 1, 0, "f.csl");
        assertEquals(CslObjType.UNIT_DECL, st.lookup("u").orElseThrow().type());

        CslSymNode inner = st.declare("inner", CslObjType.UNIT_DECL, 2, 0, "f.csl");
        st.enterScope(inner);
        st.declare("u", CslObjType.SIGNAL_DECL, 3, 0, "f.csl");
        assertEquals(CslObjType.SIGNAL_DECL, st.lookup("u").orElseThrow().type());
        st.exitScope();

        assertEquals(CslObjType.UNIT_DECL, st.lookup("u").orElseThrow().type());
        assertTrue(st.lookup("missing").isEmpty());
    }

    @Test
    void duplicateDeclareInSameScopeThrows() {
        CslSymTree st = new CslSymTree();
        st.declare("x", CslObjType.SIGNAL_DECL, 1, 0, "f.csl");
        assertThrows(
                IllegalStateException.class,
                () -> st.declare("x", CslObjType.PORT_DECL, 2, 0, "f.csl"));
    }
}

