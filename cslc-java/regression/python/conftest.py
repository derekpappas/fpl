"""Pytest configuration for CSLC CLI/regression runs (Perl/shell harness replacement)."""


def pytest_configure(config):
    config.addinivalue_line(
        "markers",
        "cslc_cli: invokes the Java cslc CLI (set path via CSLC_JAVA_JAR or build first)",
    )
