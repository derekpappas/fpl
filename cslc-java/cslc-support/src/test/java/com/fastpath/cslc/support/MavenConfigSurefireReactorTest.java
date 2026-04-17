package com.fastpath.cslc.support;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;

/**
 * Guards {@code .mvn/maven.config}: {@code -Dsurefire.failIfNoSpecifiedTests=false} so {@code mvn -pl … -am -Dtest=…} does not
 * fail upstream modules where no test class matches the filter.
 */
class MavenConfigSurefireReactorTest {

    @Test
    void mavenConfigDeclaresSurefireFailIfNoSpecifiedTestsFalse() throws Exception {
        Path moduleDir = Path.of(System.getProperty("basedir", ".")).toAbsolutePath().normalize();
        Path mavenConfig = moduleDir.getParent().resolve(".mvn").resolve("maven.config");
        assertTrue(Files.isRegularFile(mavenConfig), () -> "expected " + mavenConfig);
        String text = Files.readString(mavenConfig);
        assertTrue(
                text.contains("-Dsurefire.failIfNoSpecifiedTests=false"),
                () -> "expected -Dsurefire.failIfNoSpecifiedTests=false in " + mavenConfig);
    }
}
