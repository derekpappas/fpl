package com.fastpath.cslc.driver;

import com.fastpath.cslc.xmlwarn.CslWeCollector;
import com.fastpath.cslc.xmlwarn.CslcLegacyErrorCodes;
import java.util.List;

/**
 * Java port of {@code trunk/cslc/trunk/driver/csl_xml_warn_error_driver/WE_Driver.cpp}.
 */
public final class WeDriverMain {

    public static void main(String[] args) {
        CslWeCollector errors = CslWeCollector.instance();
        errors.clear();
        errors.addError(CslcLegacyErrorCodes.CSE_CSP_FUNC_FCT_NON_BLOCK, List.of("mata.xml", "10"));
    }

    private WeDriverMain() {}
}
