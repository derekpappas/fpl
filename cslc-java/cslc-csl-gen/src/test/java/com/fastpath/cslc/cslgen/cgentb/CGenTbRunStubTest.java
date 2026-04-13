package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.nio.file.Path;
import java.util.concurrent.atomic.AtomicInteger;
import org.junit.jupiter.api.Test;

class CGenTbRunStubTest {

    @Test
    void runsBuildTestsOnlyWhenArgsOk() {
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                0,
                CGenTbRunStub.runAfterMainArgs(
                        new String[] {"tb"}, () -> n.incrementAndGet()));
        assertEquals(1, n.get());
    }

    @Test
    void skipsBuildTestsWhenArgsInvalid() {
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                1,
                CGenTbRunStub.runAfterMainArgs(
                        new String[] {"tb", "bad_chapter"}, () -> n.incrementAndGet()));
        assertEquals(0, n.get());
    }

    @Test
    void legacyRunChecksRunsBuildWhenRepositorySuppliedOk() {
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                0,
                CGenTbRunStub.runAfterLegacyRunChecks(
                        new String[] {"tb"},
                        () -> n.incrementAndGet(),
                        () -> CGenTbRepositoryPath.Outcome.success(Path.of("."))));
        assertEquals(1, n.get());
    }

    @Test
    void legacyRunChecksSkipsBuildWhenRepositoryFails() {
        AtomicInteger n = new AtomicInteger();
        assertEquals(
                1,
                CGenTbRunStub.runAfterLegacyRunChecks(
                        new String[] {"tb"},
                        () -> n.incrementAndGet(),
                        () -> CGenTbRepositoryPath.Outcome.failure("no")));
        assertEquals(0, n.get());
    }
}
